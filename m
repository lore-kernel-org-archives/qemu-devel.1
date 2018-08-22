Received: from eggs.gnu.org ([2001:4830:134:3::10]:39019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRpI-0006oU-Ro
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRpH-00008A-TD
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46198 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsRpH-00007w-NB
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:27 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 14:00:44 +0200
Message-Id: <20180822120050.12694-15-quintela@redhat.com>
In-Reply-To: <20180822120050.12694-1-quintela@redhat.com>
References: <20180822120050.12694-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 14/20] migration: poll the cm event for
 destination qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Lidong Chen <jemmy858585@gmail.com>, Lidong Chen <lidongchen@tencent.com>

From: Lidong Chen <jemmy858585@gmail.com>

The destination qemu only poll the comp_channel->fd in
qemu_rdma_wait_comp_channel. But when source qemu disconnnect
the rdma connection, the destination qemu should be notified.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c |  3 ++-
 migration/rdma.c      | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 6f2b506335..4d76bee0da 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -390,6 +390,7 @@ static void process_incoming_migration_co(void *opaque)
     int ret;
 
     assert(mis->from_src_file);
+    mis->migration_incoming_co = qemu_coroutine_self();
     mis->largest_page_size = qemu_ram_pagesize_largest();
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
     migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
@@ -419,7 +420,6 @@ static void process_incoming_migration_co(void *opaque)
 
     /* we get COLO info, and know if we are in COLO mode */
     if (!ret && migration_incoming_enable_colo()) {
-        mis->migration_incoming_co = qemu_coroutine_self();
         qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
              colo_process_incoming_thread, mis, QEMU_THREAD_JOINABLE);
         mis->have_colo_incoming_thread = true;
@@ -443,6 +443,7 @@ static void process_incoming_migration_co(void *opaque)
     }
     mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
     qemu_bh_schedule(mis->bh);
+    mis->migration_incoming_co = NULL;
 }
 
 static void migration_incoming_setup(QEMUFile *f)
diff --git a/migration/rdma.c b/migration/rdma.c
index 1affc46937..ae07515e83 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3226,6 +3226,35 @@ err:
 
 static void rdma_accept_incoming_migration(void *opaque);
 
+static void rdma_cm_poll_handler(void *opaque)
+{
+    RDMAContext *rdma = opaque;
+    int ret;
+    struct rdma_cm_event *cm_event;
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    ret = rdma_get_cm_event(rdma->channel, &cm_event);
+    if (ret) {
+        error_report("get_cm_event failed %d", errno);
+        return;
+    }
+    rdma_ack_cm_event(cm_event);
+
+    if (cm_event->event == RDMA_CM_EVENT_DISCONNECTED ||
+        cm_event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
+        error_report("receive cm event, cm event is %d", cm_event->event);
+        rdma->error_state = -EPIPE;
+        if (rdma->return_path) {
+            rdma->return_path->error_state = -EPIPE;
+        }
+
+        if (mis->migration_incoming_co) {
+            qemu_coroutine_enter(mis->migration_incoming_co);
+        }
+        return;
+    }
+}
+
 static int qemu_rdma_accept(RDMAContext *rdma)
 {
     RDMACapabilities cap;
@@ -3326,7 +3355,8 @@ static int qemu_rdma_accept(RDMAContext *rdma)
                             NULL,
                             (void *)(intptr_t)rdma->return_path);
     } else {
-        qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
+        qemu_set_fd_handler(rdma->channel->fd, rdma_cm_poll_handler,
+                            NULL, rdma);
     }
 
     ret = rdma_accept(rdma->cm_id, &conn_param);
-- 
2.17.1

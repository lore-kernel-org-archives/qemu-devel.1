Received: from eggs.gnu.org ([2001:4830:134:3::10]:52951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1flWA5-0001Yd-R2
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1flWA4-0001lZ-Ne
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:14:17 -0400
Received: from mail-pl0-x231.google.com ([2607:f8b0:400e:c01::231]:45562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1flWA4-0001jy-Gu
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:14:16 -0400
Received: by mail-pl0-x231.google.com with SMTP id j8-v6so2292912pll.12
	for <qemu-devel@nongnu.org>; Fri, 03 Aug 2018 02:14:16 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Fri,  3 Aug 2018 17:13:48 +0800
Message-Id: <1533287630-4221-11-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1533287630-4221-1-git-send-email-lidongchen@tencent.com>
References: <1533287630-4221-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v6 10/12] migration: poll the cm event for
 destination qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com, quintela@redhat.com, dgilbert@redhat.com
Cc: qemu-devel@nongnu.org, Lidong Chen <lidongchen@tencent.com>

The destination qemu only poll the comp_channel->fd in
qemu_rdma_wait_comp_channel. But when source qemu disconnnect
the rdma connection, the destination qemu should be notified.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 migration/migration.c |  3 ++-
 migration/rdma.c      | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f190964..360ee94 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -389,6 +389,7 @@ static void process_incoming_migration_co(void *opaque)
     int ret;
 
     assert(mis->from_src_file);
+    mis->migration_incoming_co = qemu_coroutine_self();
     mis->largest_page_size = qemu_ram_pagesize_largest();
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
     migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
@@ -418,7 +419,6 @@ static void process_incoming_migration_co(void *opaque)
 
     /* we get COLO info, and know if we are in COLO mode */
     if (!ret && migration_incoming_enable_colo()) {
-        mis->migration_incoming_co = qemu_coroutine_self();
         qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
              colo_process_incoming_thread, mis, QEMU_THREAD_JOINABLE);
         mis->have_colo_incoming_thread = true;
@@ -442,6 +442,7 @@ static void process_incoming_migration_co(void *opaque)
     }
     mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
     qemu_bh_schedule(mis->bh);
+    mis->migration_incoming_co = NULL;
 }
 
 static void migration_incoming_setup(QEMUFile *f)
diff --git a/migration/rdma.c b/migration/rdma.c
index 1affc46..62de2ec 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3226,6 +3226,34 @@ err:
 
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
+        return;
+    }
+
+    if (cm_event->event == RDMA_CM_EVENT_DISCONNECTED ||
+        cm_event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
+        rdma_ack_cm_event(cm_event);
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
@@ -3326,7 +3354,8 @@ static int qemu_rdma_accept(RDMAContext *rdma)
                             NULL,
                             (void *)(intptr_t)rdma->return_path);
     } else {
-        qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
+        qemu_set_fd_handler(rdma->channel->fd, rdma_cm_poll_handler,
+                            NULL, rdma);
     }
 
     ret = rdma_accept(rdma->cm_id, &conn_param);
-- 
1.8.3.1

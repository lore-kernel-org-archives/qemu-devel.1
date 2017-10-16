Received: from eggs.gnu.org ([2001:4830:134:3::10]:42952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e3zHy-0001jM-RJ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 02:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e3zHx-0003C2-Qj
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 02:54:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e3zHx-0003Ap-IM
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 02:54:13 -0400
From: Peter Xu <peterx@redhat.com>
Date: Mon, 16 Oct 2017 14:52:11 +0800
Message-Id: <20171016065216.18162-28-peterx@redhat.com>
In-Reply-To: <20171016065216.18162-1-peterx@redhat.com>
References: <20171016065216.18162-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 27/32] migration: store listen task tag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andrea Arcangeli <aarcange@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Store the task tag for migration types: tcp/unix/fd/exec in current
MigrationIncomingState struct.

For defered migration, no need to store task tag since there is no task
running in the main loop at all. For RDMA, let's mark it as todo.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 22 ++++++++++++++++++----
 migration/migration.h |  2 ++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index edf7365b69..0baa09ada3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -172,6 +172,7 @@ void migration_incoming_state_destroy(void)
         mis->from_src_file = NULL;
     }
 
+    mis->listen_task_tag = 0;
     qemu_event_reset(&mis->main_thread_load_event);
 }
 
@@ -266,25 +267,31 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char *rbname,
 void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
     const char *p;
+    guint task_tag = 0;
+    MigrationIncomingState *mis = migration_incoming_get_current();
 
     qapi_event_send_migration(MIGRATION_STATUS_SETUP, &error_abort);
     if (!strcmp(uri, "defer")) {
         deferred_incoming_migration(errp);
     } else if (strstart(uri, "tcp:", &p)) {
-        tcp_start_incoming_migration(p, errp);
+        task_tag = tcp_start_incoming_migration(p, errp);
 #ifdef CONFIG_RDMA
     } else if (strstart(uri, "rdma:", &p)) {
+        /* TODO: store task tag for RDMA migrations */
         rdma_start_incoming_migration(p, errp);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
-        exec_start_incoming_migration(p, errp);
+        task_tag = exec_start_incoming_migration(p, errp);
     } else if (strstart(uri, "unix:", &p)) {
-        unix_start_incoming_migration(p, errp);
+        task_tag = unix_start_incoming_migration(p, errp);
     } else if (strstart(uri, "fd:", &p)) {
-        fd_start_incoming_migration(p, errp);
+        task_tag = fd_start_incoming_migration(p, errp);
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
+        return;
     }
+
+    mis->listen_task_tag = task_tag;
 }
 
 static void process_incoming_migration_bh(void *opaque)
@@ -450,6 +457,13 @@ void migration_fd_process_incoming(QEMUFile *f)
         migration_incoming_setup(f);
         migration_incoming_process();
     }
+
+    /*
+     * When reach here, we should not need the listening port any
+     * more. We'll detach the listening task soon, let's reset the
+     * listen task tag.
+     */
+    mis->listen_task_tag = 0;
 }
 
 void migration_ioc_process_incoming(QIOChannel *ioc)
diff --git a/migration/migration.h b/migration/migration.h
index c8d5939d43..d89a0387cf 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -27,6 +27,8 @@
 /* State for the incoming migration */
 struct MigrationIncomingState {
     QEMUFile *from_src_file;
+    /* Task tag for incoming listen port. Valid when >0. */
+    guint listen_task_tag;
 
     /*
      * Free at the start of the main state load, set as the main thread finishes
-- 
2.13.5

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJSN-0000aa-P0
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:03:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJSM-0007BM-9X
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:03:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCJSM-0007B9-0t
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:03:22 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed,  8 Nov 2017 14:01:25 +0800
Message-Id: <20171108060130.3772-28-peterx@redhat.com>
In-Reply-To: <20171108060130.3772-1-peterx@redhat.com>
References: <20171108060130.3772-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 27/32] migration: store listen task tag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

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
index 189d5d2d42..a4cdedcde8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -175,6 +175,7 @@ void migration_incoming_state_destroy(void)
         mis->from_src_file = NULL;
     }
 
+    mis->listen_task_tag = 0;
     qemu_event_reset(&mis->main_thread_load_event);
 }
 
@@ -269,25 +270,31 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char *rbname,
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
@@ -453,6 +460,13 @@ void migration_fd_process_incoming(QEMUFile *f)
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
index 82dd7d9820..a0af86ab21 100644
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
2.13.6

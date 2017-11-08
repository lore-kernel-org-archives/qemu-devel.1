Received: from eggs.gnu.org ([2001:4830:134:3::10]:38288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJZk-0006xc-VI
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJZj-00016Y-62
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:11:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCJZi-00014t-UK
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:10:59 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed,  8 Nov 2017 14:01:26 +0800
Message-Id: <20171108060130.3772-29-peterx@redhat.com>
In-Reply-To: <20171108060130.3772-1-peterx@redhat.com>
References: <20171108060130.3772-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 28/32] migration: allow migrate_incoming for
 paused VM
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

migrate_incoming command is previously only used when we were providing
"-incoming defer" in the command line, to defer the incoming migration
channel creation.

However there is similar requirement when we are paused during postcopy
migration. The old incoming channel might have been destroyed already.
We may need another new channel for the recovery to happen.

This patch leveraged the same interface, but allows the user to specify
incoming migration channel even for paused postcopy.

Meanwhile, now migration listening ports are always detached manually
using the tag, rather than using return values of dispatchers.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/exec.c       |  2 +-
 migration/fd.c         |  2 +-
 migration/migration.c  | 58 +++++++++++++++++++++++++++++++++++++++++++-------
 migration/socket.c     |  4 +---
 migration/trace-events |  2 ++
 5 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/migration/exec.c b/migration/exec.c
index a0796c2c70..9d20d10899 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -49,7 +49,7 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
 {
     migration_channel_process_incoming(ioc);
     object_unref(OBJECT(ioc));
-    return G_SOURCE_REMOVE;
+    return G_SOURCE_CONTINUE;
 }
 
 /*
diff --git a/migration/fd.c b/migration/fd.c
index 7ead2f26cc..54b36888e2 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -49,7 +49,7 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
 {
     migration_channel_process_incoming(ioc);
     object_unref(OBJECT(ioc));
-    return G_SOURCE_REMOVE;
+    return G_SOURCE_CONTINUE;
 }
 
 /*
diff --git a/migration/migration.c b/migration/migration.c
index a4cdedcde8..9b7fc56ed8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -179,6 +179,17 @@ void migration_incoming_state_destroy(void)
     qemu_event_reset(&mis->main_thread_load_event);
 }
 
+static bool migrate_incoming_detach_listen(MigrationIncomingState *mis)
+{
+    if (mis->listen_task_tag) {
+        /* Never fail */
+        g_source_remove(mis->listen_task_tag);
+        mis->listen_task_tag = 0;
+        return true;
+    }
+    return false;
+}
+
 static void migrate_generate_event(int new_state)
 {
     if (migrate_use_events()) {
@@ -463,10 +474,9 @@ void migration_fd_process_incoming(QEMUFile *f)
 
     /*
      * When reach here, we should not need the listening port any
-     * more. We'll detach the listening task soon, let's reset the
-     * listen task tag.
+     * more.  Detach the listening port explicitly.
      */
-    mis->listen_task_tag = 0;
+    migrate_incoming_detach_listen(mis);
 }
 
 void migration_ioc_process_incoming(QIOChannel *ioc)
@@ -1422,14 +1432,46 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
 {
     Error *local_err = NULL;
     static bool once = true;
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
 
-    if (!deferred_incoming) {
-        error_setg(errp, "For use with '-incoming defer'");
+    if (mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+        if (mis->listen_task_tag) {
+            error_setg(errp, "We already have a listening port!");
+            return;
+        } else {
+            /*
+            * We are in postcopy-paused state, and we don't have
+            * listening port.  It's very possible that the old
+            * listening port is already gone, so we allow to create a
+            * new one.
+            *
+            * NOTE: RDMA migration currently does not really use
+            * listen_task_tag for now, so even if listen_task_tag is
+            * zero, RDMA can still have its accept port listening.
+            * However, RDMA is not supported by postcopy at all (yet), so
+            * we are safe here.
+            */
+            trace_migrate_incoming_recover();
+        }
+    } else if (deferred_incoming) {
+        /*
+         * We don't need recovery, but we possibly has a deferred
+         * incoming parameter, this allows us to manually specify
+         * incoming port once.
+         */
+        if (!once) {
+            error_setg(errp, "The incoming migration has already been started");
+            return;
+        } else {
+            /* PASS */
+            trace_migrate_incoming_deferred();
+        }
+    } else {
+        error_setg(errp, "Migrate-incoming is only allowed for either "
+                   "deferred incoming, or postcopy paused stage.");
         return;
     }
-    if (!once) {
-        error_setg(errp, "The incoming migration has already been started");
-    }
 
     qemu_start_incoming_migration(uri, &local_err);
 
diff --git a/migration/socket.c b/migration/socket.c
index e8f3325155..54095a80a0 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -155,10 +155,8 @@ out:
     if (migration_has_all_channels()) {
         /* Close listening socket as its no longer needed */
         qio_channel_close(ioc, NULL);
-        return G_SOURCE_REMOVE;
-    } else {
-        return G_SOURCE_CONTINUE;
     }
+    return G_SOURCE_CONTINUE;
 }
 
 
diff --git a/migration/trace-events b/migration/trace-events
index 98c2e4de58..65b1c7e459 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -136,6 +136,8 @@ process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
 process_incoming_migration_co_postcopy_end_main(void) ""
 migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
 migration_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname)  "ioc=%p ioctype=%s hostname=%s"
+migrate_incoming_deferred(void) ""
+migrate_incoming_recover(void) ""
 
 # migration/rdma.c
 qemu_rdma_accept_incoming_migration(void) ""
-- 
2.13.6

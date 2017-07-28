Received: from eggs.gnu.org ([2001:4830:134:3::10]:47155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db0JO-0001Cw-Lq
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db0JN-0001PK-Io
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:07:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1db0JN-0001P1-8i
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:07:53 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 28 Jul 2017 16:06:26 +0800
Message-Id: <1501229198-30588-18-git-send-email-peterx@redhat.com>
In-Reply-To: <1501229198-30588-1-git-send-email-peterx@redhat.com>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 17/29] migration: rebuild channel on source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

This patch detects the "resume" flag of migration command, rebuild the
channels only if the flag is set.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 52 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 36ff8c3..64de0ee 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1244,6 +1244,15 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     MigrationState *s = migrate_get_current();
     const char *p;
 
+    if (has_resume && resume) {
+        if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
+            error_setg(errp, "Cannot resume if there is no "
+                       "paused migration");
+            return;
+        }
+        goto do_resume;
+    }
+
     if (migration_is_setup_or_active(s->state) ||
         s->state == MIGRATION_STATUS_CANCELLING ||
         s->state == MIGRATION_STATUS_COLO) {
@@ -1279,6 +1288,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
 
     s = migrate_init();
 
+do_resume:
     if (strstart(uri, "tcp:", &p)) {
         tcp_start_outgoing_migration(s, p, &local_err);
 #ifdef CONFIG_RDMA
@@ -1700,7 +1710,8 @@ out:
     return NULL;
 }
 
-static int open_return_path_on_source(MigrationState *ms)
+static int open_return_path_on_source(MigrationState *ms,
+                                      bool create_thread)
 {
 
     ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
@@ -1709,6 +1720,12 @@ static int open_return_path_on_source(MigrationState *ms)
     }
 
     trace_open_return_path_on_source();
+
+    if (!create_thread) {
+        /* We're done */
+        return 0;
+    }
+
     qemu_thread_create(&ms->rp_state.rp_thread, "return path",
                        source_return_path_thread, ms, QEMU_THREAD_JOINABLE);
 
@@ -2249,15 +2266,24 @@ static void *migration_thread(void *opaque)
 
 void migrate_fd_connect(MigrationState *s)
 {
-    s->expected_downtime = s->parameters.downtime_limit;
-    s->cleanup_bh = qemu_bh_new(migrate_fd_cleanup, s);
+    int64_t rate_limit;
+    bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
 
-    qemu_file_set_blocking(s->to_dst_file, true);
-    qemu_file_set_rate_limit(s->to_dst_file,
-                             s->parameters.max_bandwidth / XFER_LIMIT_RATIO);
+    if (resume) {
+        /* This is a resumed migration */
+        rate_limit = INT64_MAX;
+    } else {
+        /* This is a fresh new migration */
+        rate_limit = s->parameters.max_bandwidth / XFER_LIMIT_RATIO;
+        s->expected_downtime = s->parameters.downtime_limit;
+        s->cleanup_bh = qemu_bh_new(migrate_fd_cleanup, s);
 
-    /* Notify before starting migration thread */
-    notifier_list_notify(&migration_state_notifiers, s);
+        /* Notify before starting migration thread */
+        notifier_list_notify(&migration_state_notifiers, s);
+    }
+
+    qemu_file_set_rate_limit(s->to_dst_file, rate_limit);
+    qemu_file_set_blocking(s->to_dst_file, true);
 
     /*
      * Open the return path. For postcopy, it is used exclusively. For
@@ -2265,15 +2291,19 @@ void migrate_fd_connect(MigrationState *s)
      * QEMU uses the return path.
      */
     if (migrate_postcopy_ram() || migrate_use_return_path()) {
-        if (open_return_path_on_source(s)) {
+        if (open_return_path_on_source(s, !resume)) {
             error_report("Unable to open return-path for postcopy");
-            migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                              MIGRATION_STATUS_FAILED);
+            migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
             migrate_fd_cleanup(s);
             return;
         }
     }
 
+    if (resume) {
+        /* TODO: do the resume logic */
+        return;
+    }
+
     qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
                        QEMU_THREAD_JOINABLE);
     s->migration_thread_running = true;
-- 
2.7.4

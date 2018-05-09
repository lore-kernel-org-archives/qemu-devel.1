Received: from eggs.gnu.org ([2001:4830:134:3::10]:58646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNDH-0004hH-05
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNDF-0001Lz-4N
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53766 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGNDE-0001L8-Ub
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9BB05819D1D1
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 11:24:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  9 May 2018 13:23:46 +0200
Message-Id: <20180509112406.6183-22-quintela@redhat.com>
In-Reply-To: <20180509112406.6183-1-quintela@redhat.com>
References: <20180509112406.6183-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 21/41] migration: rebuild channel on source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: Peter Xu <peterx@redhat.com>

This patch detects the "resume" flag of migration command, rebuild the
channels only if the flag is set.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180502104740.12123-9-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 91 +++++++++++++++++++++++++++++++++----------
 1 file changed, 70 insertions(+), 21 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 19f07fb64f..038fae93ab 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1411,49 +1411,75 @@ bool migration_is_blocked(Error **errp)
     return false;
 }
 
-void qmp_migrate(const char *uri, bool has_blk, bool blk,
-                 bool has_inc, bool inc, bool has_detach, bool detach,
-                 bool has_resume, bool resume, Error **errp)
+/* Returns true if continue to migrate, or false if error detected */
+static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
+                            bool resume, Error **errp)
 {
     Error *local_err = NULL;
-    MigrationState *s = migrate_get_current();
-    const char *p;
+
+    if (resume) {
+        if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
+            error_setg(errp, "Cannot resume if there is no "
+                       "paused migration");
+            return false;
+        }
+        /* This is a resume, skip init status */
+        return true;
+    }
 
     if (migration_is_setup_or_active(s->state) ||
         s->state == MIGRATION_STATUS_CANCELLING ||
         s->state == MIGRATION_STATUS_COLO) {
         error_setg(errp, QERR_MIGRATION_ACTIVE);
-        return;
+        return false;
     }
+
     if (runstate_check(RUN_STATE_INMIGRATE)) {
         error_setg(errp, "Guest is waiting for an incoming migration");
-        return;
+        return false;
     }
 
     if (migration_is_blocked(errp)) {
-        return;
+        return false;
     }
 
-    if ((has_blk && blk) || (has_inc && inc)) {
+    if (blk || blk_inc) {
         if (migrate_use_block() || migrate_use_block_incremental()) {
             error_setg(errp, "Command options are incompatible with "
                        "current migration capabilities");
-            return;
+            return false;
         }
         migrate_set_block_enabled(true, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
-            return;
+            return false;
         }
         s->must_remove_block_options = true;
     }
 
-    if (has_inc && inc) {
+    if (blk_inc) {
         migrate_set_block_incremental(s, true);
     }
 
     migrate_init(s);
 
+    return true;
+}
+
+void qmp_migrate(const char *uri, bool has_blk, bool blk,
+                 bool has_inc, bool inc, bool has_detach, bool detach,
+                 bool has_resume, bool resume, Error **errp)
+{
+    Error *local_err = NULL;
+    MigrationState *s = migrate_get_current();
+    const char *p;
+
+    if (!migrate_prepare(s, has_blk && blk, has_inc && inc,
+                         has_resume && resume, errp)) {
+        /* Error detected, put into errp */
+        return;
+    }
+
     if (strstart(uri, "tcp:", &p)) {
         tcp_start_outgoing_migration(s, p, &local_err);
 #ifdef CONFIG_RDMA
@@ -1928,7 +1954,8 @@ out:
     return NULL;
 }
 
-static int open_return_path_on_source(MigrationState *ms)
+static int open_return_path_on_source(MigrationState *ms,
+                                      bool create_thread)
 {
 
     ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
@@ -1937,6 +1964,12 @@ static int open_return_path_on_source(MigrationState *ms)
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
 
@@ -2593,6 +2626,9 @@ static void *migration_thread(void *opaque)
 
 void migrate_fd_connect(MigrationState *s, Error *error_in)
 {
+    int64_t rate_limit;
+    bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
+
     s->expected_downtime = s->parameters.downtime_limit;
     s->cleanup_bh = qemu_bh_new(migrate_fd_cleanup, s);
     if (error_in) {
@@ -2601,12 +2637,21 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         return;
     }
 
+    if (resume) {
+        /* This is a resumed migration */
+        rate_limit = INT64_MAX;
+    } else {
+        /* This is a fresh new migration */
+        rate_limit = s->parameters.max_bandwidth / XFER_LIMIT_RATIO;
+        s->expected_downtime = s->parameters.downtime_limit;
+        s->cleanup_bh = qemu_bh_new(migrate_fd_cleanup, s);
+
+        /* Notify before starting migration thread */
+        notifier_list_notify(&migration_state_notifiers, s);
+    }
+
+    qemu_file_set_rate_limit(s->to_dst_file, rate_limit);
     qemu_file_set_blocking(s->to_dst_file, true);
-    qemu_file_set_rate_limit(s->to_dst_file,
-                             s->parameters.max_bandwidth / XFER_LIMIT_RATIO);
-
-    /* Notify before starting migration thread */
-    notifier_list_notify(&migration_state_notifiers, s);
 
     /*
      * Open the return path. For postcopy, it is used exclusively. For
@@ -2614,15 +2659,19 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
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
     if (multifd_save_setup() != 0) {
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
-- 
2.17.0

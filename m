Received: from eggs.gnu.org ([2001:4830:134:3::10]:34846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpJ7-0006Vy-Al
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpJ6-0002sc-1R
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44598 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fDpJ5-0002sI-RY
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:19 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed,  2 May 2018 18:47:24 +0800
Message-Id: <20180502104740.12123-9-peterx@redhat.com>
In-Reply-To: <20180502104740.12123-1-peterx@redhat.com>
References: <20180502104740.12123-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 08/24] migration: rebuild channel on source
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

This patch detects the "resume" flag of migration command, rebuild the
channels only if the flag is set.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 91 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 70 insertions(+), 21 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 9faf22d3ae..78b0046e59 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1406,49 +1406,75 @@ bool migration_is_blocked(Error **errp)
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
@@ -1923,7 +1949,8 @@ out:
     return NULL;
 }
 
-static int open_return_path_on_source(MigrationState *ms)
+static int open_return_path_on_source(MigrationState *ms,
+                                      bool create_thread)
 {
 
     ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
@@ -1932,6 +1959,12 @@ static int open_return_path_on_source(MigrationState *ms)
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
 
@@ -2588,6 +2621,9 @@ static void *migration_thread(void *opaque)
 
 void migrate_fd_connect(MigrationState *s, Error *error_in)
 {
+    int64_t rate_limit;
+    bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
+
     s->expected_downtime = s->parameters.downtime_limit;
     s->cleanup_bh = qemu_bh_new(migrate_fd_cleanup, s);
     if (error_in) {
@@ -2596,12 +2632,21 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         return;
     }
 
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
@@ -2609,15 +2654,19 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
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
2.14.3

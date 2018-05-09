Received: from eggs.gnu.org ([2001:4830:134:3::10]:58566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGND9-0004Zp-VK
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGND8-00019z-GT
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43664 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGND8-00019Q-B9
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F2671722F4
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 11:24:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  9 May 2018 13:23:41 +0200
Message-Id: <20180509112406.6183-17-quintela@redhat.com>
In-Reply-To: <20180509112406.6183-1-quintela@redhat.com>
References: <20180509112406.6183-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 16/41] migration: implement "postcopy-pause" src
 logic
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

Now when network down for postcopy, the source side will not fail the
migration. Instead we convert the status into this new paused state, and
we will try to wait for a rescue in the future.

If a recovery is detected, migration_thread() will reset its local
variables to prepare for that.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180502104740.12123-4-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c  | 99 +++++++++++++++++++++++++++++++++++++++---
 migration/migration.h  |  3 ++
 migration/trace-events |  1 +
 3 files changed, 97 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 02ebd6c9d1..8392cf467d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2245,6 +2245,80 @@ bool migrate_colo_enabled(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_X_COLO];
 }
 
+typedef enum MigThrError {
+    /* No error detected */
+    MIG_THR_ERR_NONE = 0,
+    /* Detected error, but resumed successfully */
+    MIG_THR_ERR_RECOVERED = 1,
+    /* Detected fatal error, need to exit */
+    MIG_THR_ERR_FATAL = 2,
+} MigThrError;
+
+/*
+ * We don't return until we are in a safe state to continue current
+ * postcopy migration.  Returns MIG_THR_ERR_RECOVERED if recovered, or
+ * MIG_THR_ERR_FATAL if unrecovery failure happened.
+ */
+static MigThrError postcopy_pause(MigrationState *s)
+{
+    assert(s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
+    migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+                      MIGRATION_STATUS_POSTCOPY_PAUSED);
+
+    /* Current channel is possibly broken. Release it. */
+    assert(s->to_dst_file);
+    qemu_file_shutdown(s->to_dst_file);
+    qemu_fclose(s->to_dst_file);
+    s->to_dst_file = NULL;
+
+    error_report("Detected IO failure for postcopy. "
+                 "Migration paused.");
+
+    /*
+     * We wait until things fixed up. Then someone will setup the
+     * status back for us.
+     */
+    while (s->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+        qemu_sem_wait(&s->postcopy_pause_sem);
+    }
+
+    trace_postcopy_pause_continued();
+
+    return MIG_THR_ERR_RECOVERED;
+}
+
+static MigThrError migration_detect_error(MigrationState *s)
+{
+    int ret;
+
+    /* Try to detect any file errors */
+    ret = qemu_file_get_error(s->to_dst_file);
+
+    if (!ret) {
+        /* Everything is fine */
+        return MIG_THR_ERR_NONE;
+    }
+
+    if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE && ret == -EIO) {
+        /*
+         * For postcopy, we allow the network to be down for a
+         * while. After that, it can be continued by a
+         * recovery phase.
+         */
+        return postcopy_pause(s);
+    } else {
+        /*
+         * For precopy (or postcopy with error outside IO), we fail
+         * with no time.
+         */
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+        trace_migration_thread_file_err();
+
+        /* Time to stop the migration, now. */
+        return MIG_THR_ERR_FATAL;
+    }
+}
+
 static void migration_calculate_complete(MigrationState *s)
 {
     uint64_t bytes = qemu_ftell(s->to_dst_file);
@@ -2401,6 +2475,7 @@ static void *migration_thread(void *opaque)
 {
     MigrationState *s = opaque;
     int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
+    MigThrError thr_error;
 
     rcu_register_thread();
 
@@ -2450,13 +2525,22 @@ static void *migration_thread(void *opaque)
             }
         }
 
-        if (qemu_file_get_error(s->to_dst_file)) {
-            if (migration_is_setup_or_active(s->state)) {
-                migrate_set_state(&s->state, s->state,
-                                  MIGRATION_STATUS_FAILED);
-            }
-            trace_migration_thread_file_err();
+        /*
+         * Try to detect any kind of failures, and see whether we
+         * should stop the migration now.
+         */
+        thr_error = migration_detect_error(s);
+        if (thr_error == MIG_THR_ERR_FATAL) {
+            /* Stop migration */
             break;
+        } else if (thr_error == MIG_THR_ERR_RECOVERED) {
+            /*
+             * Just recovered from a e.g. network failure, reset all
+             * the local variables. This is important to avoid
+             * breaking transferred_bytes and bandwidth calculation
+             */
+            s->iteration_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+            s->iteration_initial_bytes = 0;
         }
 
         current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
@@ -2614,6 +2698,7 @@ static void migration_instance_finalize(Object *obj)
     g_free(params->tls_hostname);
     g_free(params->tls_creds);
     qemu_sem_destroy(&ms->pause_sem);
+    qemu_sem_destroy(&ms->postcopy_pause_sem);
     error_free(ms->error);
 }
 
@@ -2643,6 +2728,8 @@ static void migration_instance_init(Object *obj)
     params->has_x_multifd_channels = true;
     params->has_x_multifd_page_count = true;
     params->has_xbzrle_cache_size = true;
+
+    qemu_sem_init(&ms->postcopy_pause_sem, 0);
 }
 
 /*
diff --git a/migration/migration.h b/migration/migration.h
index 26e5951d56..60283c39b2 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -194,6 +194,9 @@ struct MigrationState
     bool send_configuration;
     /* Whether we send section footer during migration */
     bool send_section_footer;
+
+    /* Needed by postcopy-pause state */
+    QemuSemaphore postcopy_pause_sem;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
diff --git a/migration/trace-events b/migration/trace-events
index d6be74b7a7..409b4b8be3 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -99,6 +99,7 @@ migration_thread_setup_complete(void) ""
 open_return_path_on_source(void) ""
 open_return_path_on_source_continue(void) ""
 postcopy_start(void) ""
+postcopy_pause_continued(void) ""
 postcopy_start_set_run(void) ""
 source_return_path_thread_bad_end(void) ""
 source_return_path_thread_end(void) ""
-- 
2.17.0

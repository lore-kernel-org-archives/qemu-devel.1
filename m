Received: from eggs.gnu.org ([2001:4830:134:3::10]:38324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJZm-0006yZ-0t
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:11:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJZj-00017I-Fb
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:11:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCJZj-00015E-2y
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:10:59 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed,  8 Nov 2017 14:01:03 +0800
Message-Id: <20171108060130.3772-6-peterx@redhat.com>
In-Reply-To: <20171108060130.3772-1-peterx@redhat.com>
References: <20171108060130.3772-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 05/32] migration: implement "postcopy-pause"
 src logic
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

Now when network down for postcopy, the source side will not fail the
migration. Instead we convert the status into this new paused state, and
we will try to wait for a rescue in the future.

If a recovery is detected, migration_thread() will reset its local
variables to prepare for that.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c  | 98 +++++++++++++++++++++++++++++++++++++++++++++++---
 migration/migration.h  |  3 ++
 migration/trace-events |  1 +
 3 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index dd270f8bc5..46e7ca36a4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1111,6 +1111,8 @@ static void migrate_fd_cleanup(void *opaque)
     }
     notifier_list_notify(&migration_state_notifiers, s);
     block_cleanup_parameters(s);
+
+    qemu_sem_destroy(&s->postcopy_pause_sem);
 }
 
 void migrate_set_error(MigrationState *s, const Error *error)
@@ -1267,6 +1269,7 @@ MigrationState *migrate_init(void)
     s->migration_thread_running = false;
     error_free(s->error);
     s->error = NULL;
+    qemu_sem_init(&s->postcopy_pause_sem, 0);
 
     migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
 
@@ -2159,6 +2162,80 @@ bool migrate_colo_enabled(void)
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
 /*
  * Master migration thread on the source VM.
  * It drives the migration and pumps the data down the outgoing channel.
@@ -2183,6 +2260,7 @@ static void *migration_thread(void *opaque)
     /* The active state we expect to be in; ACTIVE or POSTCOPY_ACTIVE */
     enum MigrationStatus current_active_state = MIGRATION_STATUS_ACTIVE;
     bool enable_colo = migrate_colo_enabled();
+    MigThrError thr_error;
 
     rcu_register_thread();
 
@@ -2255,12 +2333,24 @@ static void *migration_thread(void *opaque)
             }
         }
 
-        if (qemu_file_get_error(s->to_dst_file)) {
-            migrate_set_state(&s->state, current_active_state,
-                              MIGRATION_STATUS_FAILED);
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
+            initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+            initial_bytes = 0;
         }
+
         current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
         if (current_time >= initial_time + BUFFER_DELAY) {
             uint64_t transferred_bytes = qemu_ftell(s->to_dst_file) -
diff --git a/migration/migration.h b/migration/migration.h
index 6d36400975..36aaa13f50 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -156,6 +156,9 @@ struct MigrationState
     bool send_configuration;
     /* Whether we send section footer during migration */
     bool send_section_footer;
+
+    /* Needed by postcopy-pause state */
+    QemuSemaphore postcopy_pause_sem;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
diff --git a/migration/trace-events b/migration/trace-events
index 6f29fcc686..da1c63a933 100644
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
2.13.6

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db0J0-0000tF-UH
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db0Iz-0001BV-OO
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:07:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1db0Iz-0001An-Fr
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:07:29 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 28 Jul 2017 16:06:20 +0800
Message-Id: <1501229198-30588-12-git-send-email-peterx@redhat.com>
In-Reply-To: <1501229198-30588-1-git-send-email-peterx@redhat.com>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 11/29] migration: new postcopy-pause state
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

Introducing a new state "postcopy-paused", which can be used to pause a
postcopy migration. It is targeted to support network failures during
postcopy migration. Now when network down for postcopy, the source side
will not fail the migration. Instead we convert the status into this new
paused state, and we will try to wait for a rescue in the future.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c  | 78 +++++++++++++++++++++++++++++++++++++++++++++++---
 migration/migration.h  |  3 ++
 migration/trace-events |  1 +
 qapi-schema.json       |  5 +++-
 4 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index efee87e..0bc70c8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -470,6 +470,7 @@ static bool migration_is_setup_or_active(int state)
     switch (state) {
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_PAUSED:
     case MIGRATION_STATUS_SETUP:
         return true;
 
@@ -545,6 +546,7 @@ MigrationInfo *qmp_query_migrate(Error **errp)
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_CANCELLING:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_PAUSED:
          /* TODO add some postcopy stats */
         info->has_status = true;
         info->has_total_time = true;
@@ -991,6 +993,8 @@ static void migrate_fd_cleanup(void *opaque)
 
     notifier_list_notify(&migration_state_notifiers, s);
     block_cleanup_parameters(s);
+
+    qemu_sem_destroy(&s->postcopy_pause_sem);
 }
 
 void migrate_fd_error(MigrationState *s, const Error *error)
@@ -1134,6 +1138,7 @@ MigrationState *migrate_init(void)
     s->migration_thread_running = false;
     error_free(s->error);
     s->error = NULL;
+    qemu_sem_init(&s->postcopy_pause_sem, 0);
 
     migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
 
@@ -1942,6 +1947,69 @@ static bool postcopy_should_start(MigrationState *s)
 }
 
 /*
+ * We don't return until we are in a safe state to continue current
+ * postcopy migration.  Returns true to continue the migration, or
+ * false to terminate current migration.
+ */
+static bool postcopy_pause(MigrationState *s)
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
+    return true;
+}
+
+/* Return true if we want to stop the migration, otherwise false. */
+static bool migration_detect_error(MigrationState *s)
+{
+    int ret;
+
+    /* Try to detect any file errors */
+    ret = qemu_file_get_error(s->to_dst_file);
+
+    if (!ret) {
+        /* Everything is fine */
+        return false;
+    }
+
+    if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE && ret == -EIO) {
+        /*
+         * For postcopy, we allow the network to be down for a
+         * while. After that, it can be continued by a
+         * recovery phase.
+         */
+        return !postcopy_pause(s);
+    } else {
+        /*
+         * For precopy (or postcopy with error outside IO), we fail
+         * with no time.
+         */
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+        trace_migration_thread_file_err();
+
+        /* Time to stop the migration, now. */
+        return true;
+    }
+}
+
+/*
  * Master migration thread on the source VM.
  * It drives the migration and pumps the data down the outgoing channel.
  */
@@ -2037,12 +2105,14 @@ static void *migration_thread(void *opaque)
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
+        if (migration_detect_error(s)) {
             break;
         }
+
         current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
         if (current_time >= initial_time + BUFFER_DELAY) {
             uint64_t transferred_bytes = qemu_ftell(s->to_dst_file) -
diff --git a/migration/migration.h b/migration/migration.h
index e902bae..24cdaf6 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -151,6 +151,9 @@ struct MigrationState
     bool send_configuration;
     /* Whether we send section footer during migration */
     bool send_section_footer;
+
+    /* Needed by postcopy-pause state */
+    QemuSemaphore postcopy_pause_sem;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
diff --git a/migration/trace-events b/migration/trace-events
index 08d00fa..2211acc 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -98,6 +98,7 @@ migration_thread_setup_complete(void) ""
 open_return_path_on_source(void) ""
 open_return_path_on_source_continue(void) ""
 postcopy_start(void) ""
+postcopy_pause_continued(void) ""
 postcopy_start_set_run(void) ""
 source_return_path_thread_bad_end(void) ""
 source_return_path_thread_end(void) ""
diff --git a/qapi-schema.json b/qapi-schema.json
index 9c6c3e1..2a36b80 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -667,6 +667,8 @@
 #
 # @postcopy-active: like active, but now in postcopy mode. (since 2.5)
 #
+# @postcopy-paused: during postcopy but paused. (since 2.10)
+#
 # @completed: migration is finished.
 #
 # @failed: some error occurred during migration process.
@@ -679,7 +681,8 @@
 ##
 { 'enum': 'MigrationStatus',
   'data': [ 'none', 'setup', 'cancelling', 'cancelled',
-            'active', 'postcopy-active', 'completed', 'failed', 'colo' ] }
+            'active', 'postcopy-active', 'postcopy-paused',
+            'completed', 'failed', 'colo' ] }
 
 ##
 # @MigrationInfo:
-- 
2.7.4

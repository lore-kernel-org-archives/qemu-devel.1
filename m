Received: from eggs.gnu.org ([2001:4830:134:3::10]:34475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmyRp-0007o4-CO
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmyRo-0003bU-9Y
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:34:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dmyRo-0003ax-0r
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:34:04 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 30 Aug 2017 16:32:14 +0800
Message-Id: <1504081950-2528-18-git-send-email-peterx@redhat.com>
In-Reply-To: <1504081950-2528-1-git-send-email-peterx@redhat.com>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 17/33] migration: new state "postcopy-recover"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Introducing new migration state "postcopy-recover". If a migration
procedure is paused and the connection is rebuilt afterward
successfully, we'll switch the source VM state from "postcopy-paused" to
the new state "postcopy-recover", then we'll do the resume logic in the
migration thread (along with the return path thread).

This patch only do the state switch on source side. Another following up
patch will handle the state switching on destination side using the same
status bit.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 76 ++++++++++++++++++++++++++++++++++++++-------------
 qapi-schema.json      |  4 ++-
 2 files changed, 60 insertions(+), 20 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index deb947b..30dd566 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -495,6 +495,7 @@ static bool migration_is_setup_or_active(int state)
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER:
     case MIGRATION_STATUS_SETUP:
         return true;
 
@@ -571,6 +572,7 @@ MigrationInfo *qmp_query_migrate(Error **errp)
     case MIGRATION_STATUS_CANCELLING:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER:
          /* TODO add some postcopy stats */
         info->has_status = true;
         info->has_total_time = true;
@@ -2035,6 +2037,13 @@ typedef enum MigThrError {
     MIG_THR_ERR_FATAL = 2,
 } MigThrError;
 
+/* Return zero if success, or <0 for error */
+static int postcopy_do_resume(MigrationState *s)
+{
+    /* TODO: do the resume logic */
+    return 0;
+}
+
 /*
  * We don't return until we are in a safe state to continue current
  * postcopy migration.  Returns MIG_THR_ERR_RECOVERED if recovered, or
@@ -2043,29 +2052,55 @@ typedef enum MigThrError {
 static MigThrError postcopy_pause(MigrationState *s)
 {
     assert(s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
-    migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                      MIGRATION_STATUS_POSTCOPY_PAUSED);
 
-    /* Current channel is possibly broken. Release it. */
-    assert(s->to_dst_file);
-    qemu_file_shutdown(s->to_dst_file);
-    qemu_fclose(s->to_dst_file);
-    s->to_dst_file = NULL;
+    while (true) {
+        migrate_set_state(&s->state, s->state,
+                          MIGRATION_STATUS_POSTCOPY_PAUSED);
 
-    error_report("Detected IO failure for postcopy. "
-                 "Migration paused.");
+        /* Current channel is possibly broken. Release it. */
+        assert(s->to_dst_file);
+        qemu_file_shutdown(s->to_dst_file);
+        qemu_fclose(s->to_dst_file);
+        s->to_dst_file = NULL;
 
-    /*
-     * We wait until things fixed up. Then someone will setup the
-     * status back for us.
-     */
-    while (s->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
-        qemu_sem_wait(&s->postcopy_pause_sem);
-    }
+        error_report("Detected IO failure for postcopy. "
+                     "Migration paused.");
+
+        /*
+         * We wait until things fixed up. Then someone will setup the
+         * status back for us.
+         */
+        while (s->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+            qemu_sem_wait(&s->postcopy_pause_sem);
+        }
 
-    trace_postcopy_pause_continued();
+        if (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
+            /* Woken up by a recover procedure. Give it a shot */
+
+            /*
+             * Firstly, let's wake up the return path now, with a new
+             * return path channel.
+             */
+            qemu_sem_post(&s->postcopy_pause_rp_sem);
 
-    return MIG_THR_ERR_RECOVERED;
+            /* Do the resume logic */
+            if (postcopy_do_resume(s) == 0) {
+                /* Let's continue! */
+                trace_postcopy_pause_continued();
+                return MIG_THR_ERR_RECOVERED;
+            } else {
+                /*
+                 * Something wrong happened during the recovery, let's
+                 * pause again. Pause is always better than throwing
+                 * data away.
+                 */
+                continue;
+            }
+        } else {
+            /* This is not right... Time to quit. */
+            return MIG_THR_ERR_FATAL;
+        }
+    }
 }
 
 static MigThrError migration_detect_error(MigrationState *s)
@@ -2330,7 +2365,10 @@ void migrate_fd_connect(MigrationState *s)
     }
 
     if (resume) {
-        /* TODO: do the resume logic */
+        /* Wakeup the main migration thread to do the recovery */
+        migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_PAUSED,
+                          MIGRATION_STATUS_POSTCOPY_RECOVER);
+        qemu_sem_post(&s->postcopy_pause_sem);
         return;
     }
 
diff --git a/qapi-schema.json b/qapi-schema.json
index ba41f2c..989f95a 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -669,6 +669,8 @@
 #
 # @postcopy-paused: during postcopy but paused. (since 2.11)
 #
+# @postcopy-recover: trying to recover from a paused postcopy. (since 2.11)
+#
 # @completed: migration is finished.
 #
 # @failed: some error occurred during migration process.
@@ -682,7 +684,7 @@
 { 'enum': 'MigrationStatus',
   'data': [ 'none', 'setup', 'cancelling', 'cancelled',
             'active', 'postcopy-active', 'postcopy-paused',
-            'completed', 'failed', 'colo' ] }
+            'postcopy-recover', 'completed', 'failed', 'colo' ] }
 
 ##
 # @MigrationInfo:
-- 
2.7.4

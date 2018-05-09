Received: from eggs.gnu.org ([2001:4830:134:3::10]:58663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNDH-0004hy-Oe
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNDG-0001Nf-Db
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43690 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGNDG-0001NO-8W
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DFAD58D6EC
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 11:24:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  9 May 2018 13:23:47 +0200
Message-Id: <20180509112406.6183-23-quintela@redhat.com>
In-Reply-To: <20180509112406.6183-1-quintela@redhat.com>
References: <20180509112406.6183-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 22/41] migration: new state "postcopy-recover"
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

Introducing new migration state "postcopy-recover". If a migration
procedure is paused and the connection is rebuilt afterward
successfully, we'll switch the source VM state from "postcopy-paused" to
the new state "postcopy-recover", then we'll do the resume logic in the
migration thread (along with the return path thread).

This patch only do the state switch on source side. Another following up
patch will handle the state switching on destination side using the same
status bit.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180502104740.12123-10-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 78 ++++++++++++++++++++++++++++++++-----------
 qapi/migration.json   |  4 ++-
 2 files changed, 61 insertions(+), 21 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 038fae93ab..4ab637a1fe 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -577,6 +577,7 @@ static bool migration_is_setup_or_active(int state)
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER:
     case MIGRATION_STATUS_SETUP:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
@@ -658,6 +659,7 @@ static void fill_source_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER:
          /* TODO add some postcopy stats */
         info->has_status = true;
         info->has_total_time = true;
@@ -2318,6 +2320,13 @@ typedef enum MigThrError {
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
@@ -2326,29 +2335,55 @@ typedef enum MigThrError {
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
+
+        if (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
+            /* Woken up by a recover procedure. Give it a shot */
+
+            /*
+             * Firstly, let's wake up the return path now, with a new
+             * return path channel.
+             */
+            qemu_sem_post(&s->postcopy_pause_rp_sem);
+
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
     }
-
-    trace_postcopy_pause_continued();
-
-    return MIG_THR_ERR_RECOVERED;
 }
 
 static MigThrError migration_detect_error(MigrationState *s)
@@ -2668,7 +2703,10 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     }
 
     if (resume) {
-        /* TODO: do the resume logic */
+        /* Wakeup the main migration thread to do the recovery */
+        migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_PAUSED,
+                          MIGRATION_STATUS_POSTCOPY_RECOVER);
+        qemu_sem_post(&s->postcopy_pause_sem);
         return;
     }
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 84ae4b90d5..c9e6d5a91b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -91,6 +91,8 @@
 #
 # @postcopy-paused: during postcopy but paused. (since 2.13)
 #
+# @postcopy-recover: trying to recover from a paused postcopy. (since 2.11)
+#
 # @completed: migration is finished.
 #
 # @failed: some error occurred during migration process.
@@ -109,7 +111,7 @@
 { 'enum': 'MigrationStatus',
   'data': [ 'none', 'setup', 'cancelling', 'cancelled',
             'active', 'postcopy-active', 'postcopy-paused',
-            'completed', 'failed', 'colo',
+            'postcopy-recover', 'completed', 'failed', 'colo',
             'pre-switchover', 'device' ] }
 
 ##
-- 
2.17.0

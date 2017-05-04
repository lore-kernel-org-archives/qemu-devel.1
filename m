Received: from eggs.gnu.org ([2001:4830:134:3::10]:56072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6Jzu-000895-4i
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6Jzt-0003nC-14
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:52:58 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  4 May 2017 18:52:36 +0200
Message-Id: <1493916761-32319-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
References: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 1/6] migration: Unify block node activation
 error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

Migration code activates all block driver nodes on the destination when
the migration completes. It does so by calling
bdrv_invalidate_cache_all() and blk_resume_after_migration(). There is
one code path for precopy and one for postcopy migration, resulting in
four function calls, which used to have three different failure modes.

This patch unifies the behaviour so that failure to activate all block
nodes is non-fatal, but the error message is logged and the VM isn't
automatically started. 'cont' will retry activating the block nodes.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 migration/migration.c | 16 +++++-----------
 migration/savevm.c    | 12 +++++-------
 qmp.c                 | 18 +++++++++---------
 3 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 353f272..7cb0af2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -338,20 +338,14 @@ static void process_incoming_migration_bh(void *opaque)
     Error *local_err = NULL;
     MigrationIncomingState *mis = opaque;
 
-    /* Make sure all file formats flush their mutable metadata */
+    /* Make sure all file formats flush their mutable metadata.
+     * If we get an error here, just don't restart the VM yet. */
     bdrv_invalidate_cache_all(&local_err);
-    if (local_err) {
-        migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
-                          MIGRATION_STATUS_FAILED);
-        error_report_err(local_err);
-        migrate_decompress_threads_join();
-        exit(EXIT_FAILURE);
+    if (!local_err) {
+        blk_resume_after_migration(&local_err);
     }
-
-    /* If we get an error here, just don't restart the VM yet. */
-    blk_resume_after_migration(&local_err);
     if (local_err) {
-        error_free(local_err);
+        error_report_err(local_err);
         local_err = NULL;
         autostart = false;
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index a00c1ab..0004f43 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1616,16 +1616,14 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 
     qemu_announce_self();
 
-    /* Make sure all file formats flush their mutable metadata */
+    /* Make sure all file formats flush their mutable metadata.
+     * If we get an error here, just don't restart the VM yet. */
     bdrv_invalidate_cache_all(&local_err);
-    if (local_err) {
-        error_report_err(local_err);
+    if (!local_err) {
+        blk_resume_after_migration(&local_err);
     }
-
-    /* If we get an error here, just don't restart the VM yet. */
-    blk_resume_after_migration(&local_err);
     if (local_err) {
-        error_free(local_err);
+        error_report_err(local_err);
         local_err = NULL;
         autostart = false;
     }
diff --git a/qmp.c b/qmp.c
index ab74cd7..25b5050 100644
--- a/qmp.c
+++ b/qmp.c
@@ -196,15 +196,15 @@ void qmp_cont(Error **errp)
     }
 
     /* Continuing after completed migration. Images have been inactivated to
-     * allow the destination to take control. Need to get control back now. */
-    if (runstate_check(RUN_STATE_FINISH_MIGRATE) ||
-        runstate_check(RUN_STATE_POSTMIGRATE))
-    {
-        bdrv_invalidate_cache_all(&local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
+     * allow the destination to take control. Need to get control back now.
+     *
+     * If there are no inactive block nodes (e.g. because the VM was just
+     * paused rather than completing a migration), bdrv_inactivate_all() simply
+     * doesn't do anything. */
+    bdrv_invalidate_cache_all(&local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
     }
 
     blk_resume_after_migration(&local_err);
-- 
1.8.3.1

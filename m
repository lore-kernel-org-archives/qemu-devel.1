Received: from eggs.gnu.org ([2001:4830:134:3::10]:56105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6Jzw-0008Aj-3U
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6Jzu-0003o3-UY
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:53:00 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  4 May 2017 18:52:37 +0200
Message-Id: <1493916761-32319-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
References: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 2/6] block: New BdrvChildRole.activate() for
 blk_resume_after_migration()
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

Instead of manually calling blk_resume_after_migration() in migration
code after doing bdrv_invalidate_cache_all(), integrate the BlockBackend
activation with cache invalidation into a single function. This is
achieved with a new callback in BdrvChildRole that is called by
bdrv_invalidate_cache_all().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                   | 12 +++++++++-
 block/block-backend.c     | 56 +++++++++++++++++++++++------------------------
 include/block/block.h     |  2 --
 include/block/block_int.h |  5 +++++
 migration/migration.c     |  3 ---
 migration/savevm.c        |  3 ---
 qmp.c                     |  6 -----
 7 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/block.c b/block.c
index 70ca7b4..3e7f124 100644
--- a/block.c
+++ b/block.c
@@ -3958,7 +3958,7 @@ void bdrv_init_with_whitelist(void)
 
 void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
 {
-    BdrvChild *child;
+    BdrvChild *child, *parent;
     Error *local_err = NULL;
     int ret;
 
@@ -3994,6 +3994,16 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
         error_setg_errno(errp, -ret, "Could not refresh total sector count");
         return;
     }
+
+    QLIST_FOREACH(parent, &bs->parents, next_parent) {
+        if (parent->role->activate) {
+            parent->role->activate(parent, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return;
+            }
+        }
+    }
 }
 
 void bdrv_invalidate_cache_all(Error **errp)
diff --git a/block/block-backend.c b/block/block-backend.c
index f5bf13e..a7ce72b 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -130,6 +130,32 @@ static const char *blk_root_get_name(BdrvChild *child)
     return blk_name(child->opaque);
 }
 
+/*
+ * Notifies the user of the BlockBackend that migration has completed. qdev
+ * devices can tighten their permissions in response (specifically revoke
+ * shared write permissions that we needed for storage migration).
+ *
+ * If an error is returned, the VM cannot be allowed to be resumed.
+ */
+static void blk_root_activate(BdrvChild *child, Error **errp)
+{
+    BlockBackend *blk = child->opaque;
+    Error *local_err = NULL;
+
+    if (!blk->disable_perm) {
+        return;
+    }
+
+    blk->disable_perm = false;
+
+    blk_set_perm(blk, blk->perm, blk->shared_perm, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        blk->disable_perm = true;
+        return;
+    }
+}
+
 static const BdrvChildRole child_root = {
     .inherit_options    = blk_root_inherit_options,
 
@@ -140,6 +166,8 @@ static const BdrvChildRole child_root = {
 
     .drained_begin      = blk_root_drained_begin,
     .drained_end        = blk_root_drained_end,
+
+    .activate           = blk_root_activate,
 };
 
 /*
@@ -601,34 +629,6 @@ void blk_get_perm(BlockBackend *blk, uint64_t *perm, uint64_t *shared_perm)
     *shared_perm = blk->shared_perm;
 }
 
-/*
- * Notifies the user of all BlockBackends that migration has completed. qdev
- * devices can tighten their permissions in response (specifically revoke
- * shared write permissions that we needed for storage migration).
- *
- * If an error is returned, the VM cannot be allowed to be resumed.
- */
-void blk_resume_after_migration(Error **errp)
-{
-    BlockBackend *blk;
-    Error *local_err = NULL;
-
-    for (blk = blk_all_next(NULL); blk; blk = blk_all_next(blk)) {
-        if (!blk->disable_perm) {
-            continue;
-        }
-
-        blk->disable_perm = false;
-
-        blk_set_perm(blk, blk->perm, blk->shared_perm, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            blk->disable_perm = true;
-            return;
-        }
-    }
-}
-
 static int blk_do_attach_dev(BlockBackend *blk, void *dev)
 {
     if (blk->dev) {
diff --git a/include/block/block.h b/include/block/block.h
index 877fbb0..80d51d8 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -369,8 +369,6 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp);
 void bdrv_invalidate_cache_all(Error **errp);
 int bdrv_inactivate_all(void);
 
-void blk_resume_after_migration(Error **errp);
-
 /* Ensure contents are flushed to disk.  */
 int bdrv_flush(BlockDriverState *bs);
 int coroutine_fn bdrv_co_flush(BlockDriverState *bs);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 1b4d08e..5637925 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -473,6 +473,11 @@ struct BdrvChildRole {
     void (*drained_begin)(BdrvChild *child);
     void (*drained_end)(BdrvChild *child);
 
+    /* Notifies the parent that the child has been activated (e.g. when
+     * migration is completing) and it can start requesting permissions and
+     * doing I/O on it. */
+    void (*activate)(BdrvChild *child, Error **errp);
+
     void (*attach)(BdrvChild *child);
     void (*detach)(BdrvChild *child);
 };
diff --git a/migration/migration.c b/migration/migration.c
index 7cb0af2..0d230f4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -341,9 +341,6 @@ static void process_incoming_migration_bh(void *opaque)
     /* Make sure all file formats flush their mutable metadata.
      * If we get an error here, just don't restart the VM yet. */
     bdrv_invalidate_cache_all(&local_err);
-    if (!local_err) {
-        blk_resume_after_migration(&local_err);
-    }
     if (local_err) {
         error_report_err(local_err);
         local_err = NULL;
diff --git a/migration/savevm.c b/migration/savevm.c
index 0004f43..5689615 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1619,9 +1619,6 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
     /* Make sure all file formats flush their mutable metadata.
      * If we get an error here, just don't restart the VM yet. */
     bdrv_invalidate_cache_all(&local_err);
-    if (!local_err) {
-        blk_resume_after_migration(&local_err);
-    }
     if (local_err) {
         error_report_err(local_err);
         local_err = NULL;
diff --git a/qmp.c b/qmp.c
index 25b5050..f656940 100644
--- a/qmp.c
+++ b/qmp.c
@@ -207,12 +207,6 @@ void qmp_cont(Error **errp)
         return;
     }
 
-    blk_resume_after_migration(&local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
     if (runstate_check(RUN_STATE_INMIGRATE)) {
         autostart = 1;
     } else {
-- 
1.8.3.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKMH-0003f5-Ta
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKMG-0006IO-6V
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:13 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:50 +0100
Message-Id: <1487006583-24350-29-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 28/41] commit: Use real permissions in
 commit block job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is probably one of the most interesting conversions to the new
op blocker system because a commit block job intentionally leaves some
intermediate block nodes in the backing chain that aren't valid on their
own any more; only the whole chain together results in a valid view.

In order to provide the 'consistent read' permission to the parents of
the 'top' node of the commit job, a new filter block driver is inserted
above 'top' which doesn't require 'consistent read' on its backing
chain. Subsequently, the commit job can block 'consistent read' on all
intermediate nodes without causing a conflict.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/commit.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 89 insertions(+), 16 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 68fa2a4..49ffddb 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -36,6 +36,7 @@ typedef struct CommitBlockJob {
     BlockJob common;
     RateLimit limit;
     BlockDriverState *active;
+    BlockDriverState *commit_top_bs;
     BlockBackend *top;
     BlockBackend *base;
     BlockdevOnError on_error;
@@ -83,12 +84,19 @@ static void commit_complete(BlockJob *job, void *opaque)
     BlockDriverState *active = s->active;
     BlockDriverState *top = blk_bs(s->top);
     BlockDriverState *base = blk_bs(s->base);
-    BlockDriverState *overlay_bs = bdrv_find_overlay(active, top);
+    BlockDriverState *overlay_bs = bdrv_find_overlay(active, s->commit_top_bs);
     int ret = data->ret;
+    bool remove_commit_top_bs = false;
 
     if (!block_job_is_cancelled(&s->common) && ret == 0) {
         /* success */
-        ret = bdrv_drop_intermediate(active, top, base, s->backing_file_str);
+        ret = bdrv_drop_intermediate(active, s->commit_top_bs, base,
+                                     s->backing_file_str);
+    } else if (overlay_bs) {
+        /* XXX Can (or should) we somehow keep 'consistent read' blocked even
+         * after the failed/cancelled commit job is gone? If we already wrote
+         * something to base, the intermediate images aren't valid any more. */
+        remove_commit_top_bs = true;
     }
 
     /* restore base open flags here if appropriate (e.g., change the base back
@@ -105,6 +113,13 @@ static void commit_complete(BlockJob *job, void *opaque)
     blk_unref(s->base);
     block_job_completed(&s->common, ret);
     g_free(data);
+
+    /* If bdrv_drop_intermediate() didn't already do that, remove the commit
+     * filter driver from the backing chain. Do this as the final step so that
+     * the 'consistent read' permission can be granted.  */
+    if (remove_commit_top_bs) {
+        bdrv_set_backing_hd(overlay_bs, top);
+    }
 }
 
 static void coroutine_fn commit_run(void *opaque)
@@ -208,6 +223,34 @@ static const BlockJobDriver commit_job_driver = {
     .start         = commit_run,
 };
 
+static int coroutine_fn bdrv_commit_top_preadv(BlockDriverState *bs,
+    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+{
+    return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
+}
+
+static void bdrv_commit_top_close(BlockDriverState *bs)
+{
+}
+
+static void bdrv_commit_top_child_perm(BlockDriverState *bs, BdrvChild *c,
+                                       const BdrvChildRole *role,
+                                       uint64_t perm, uint64_t shared,
+                                       uint64_t *nperm, uint64_t *nshared)
+{
+    *nperm = 0;
+    *nshared = BLK_PERM_ALL;
+}
+
+/* Dummy node that provides consistent read to its users without requiring it
+ * from its backing file and that allows writes on the backing file chain. */
+static BlockDriver bdrv_commit_top = {
+    .format_name        = "commit_top",
+    .bdrv_co_preadv     = bdrv_commit_top_preadv,
+    .bdrv_close         = bdrv_commit_top_close,
+    .bdrv_child_perm    = bdrv_commit_top_child_perm,
+};
+
 void commit_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *base, BlockDriverState *top, int64_t speed,
                   BlockdevOnError on_error, const char *backing_file_str,
@@ -219,6 +262,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     int orig_base_flags;
     BlockDriverState *iter;
     BlockDriverState *overlay_bs;
+    BlockDriverState *commit_top_bs;
     Error *local_err = NULL;
     int ret;
 
@@ -235,7 +279,6 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         return;
     }
 
-    /* FIXME Use real permissions */
     s = block_job_create(job_id, &commit_job_driver, bs, 0, BLK_PERM_ALL,
                          speed, BLOCK_JOB_DEFAULT, NULL, NULL, errp);
     if (!s) {
@@ -262,33 +305,60 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         }
     }
 
+    /* Insert commit_top block node above top, so we can block consistent read
+     * on the backing chain below it */
+    ret = bdrv_new_open_driver(&bdrv_commit_top, &commit_top_bs, NULL,
+                               BDRV_O_RDWR, errp);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    bdrv_set_backing_hd(commit_top_bs, top);
+    bdrv_set_backing_hd(overlay_bs, commit_top_bs);
+
+    s->commit_top_bs = commit_top_bs;
+    bdrv_unref(commit_top_bs);
 
     /* Block all nodes between top and base, because they will
      * disappear from the chain after this operation. */
     assert(bdrv_chain_contains(top, base));
-    for (iter = top; iter != backing_bs(base); iter = backing_bs(iter)) {
-        /* FIXME Use real permissions */
-        block_job_add_bdrv(&s->common, iter, 0, BLK_PERM_ALL, &error_abort);
+    for (iter = top; iter != base; iter = backing_bs(iter)) {
+        /* XXX BLK_PERM_WRITE needs to be allowed so we don't block ourselves
+         * at s->base. The other options would be a second filter driver above
+         * s->base. */
+        ret = block_job_add_bdrv(&s->common, iter, 0,
+                                 BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE,
+                                 errp);
+        if (ret < 0) {
+            goto fail;
+        }
+    }
+
+    ret = block_job_add_bdrv(&s->common, base, 0, BLK_PERM_ALL, errp);
+    if (ret < 0) {
+        goto fail;
     }
+
     /* overlay_bs must be blocked because it needs to be modified to
-     * update the backing image string, but if it's the root node then
-     * don't block it again */
-    if (bs != overlay_bs) {
-        /* FIXME Use real permissions */
-        block_job_add_bdrv(&s->common, overlay_bs, 0, BLK_PERM_ALL,
-                           &error_abort);
+     * update the backing image string. */
+    ret = block_job_add_bdrv(&s->common, overlay_bs, BLK_PERM_GRAPH_MOD,
+                             BLK_PERM_ALL, errp);
+    if (ret < 0) {
+        goto fail;
     }
 
-    /* FIXME Use real permissions */
-    s->base = blk_new(0, BLK_PERM_ALL);
+    s->base = blk_new(BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
+                      BLK_PERM_CONSISTENT_READ
+                      | BLK_PERM_GRAPH_MOD
+                      | BLK_PERM_WRITE_UNCHANGED);
     ret = blk_insert_bs(s->base, base, errp);
     if (ret < 0) {
         goto fail;
     }
 
-    /* FIXME Use real permissions */
+    /* Required permissions are already taken with block_job_add_bdrv() */
     s->top = blk_new(0, BLK_PERM_ALL);
-    ret = blk_insert_bs(s->top, top, errp);
+    blk_insert_bs(s->top, top, errp);
     if (ret < 0) {
         goto fail;
     }
@@ -313,6 +383,9 @@ fail:
     if (s->top) {
         blk_unref(s->top);
     }
+    if (commit_top_bs) {
+        bdrv_set_backing_hd(overlay_bs, top);
+    }
     block_job_unref(&s->common);
 }
 
-- 
1.8.3.1

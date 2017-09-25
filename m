Received: from eggs.gnu.org ([2001:4830:134:3::10]:47317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwSUw-0003kM-Uv
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwSUt-00068b-9Z
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:28:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Sep 2017 14:28:08 +0200
Message-Id: <20170925122808.14561-6-kwolf@redhat.com>
In-Reply-To: <20170925122808.14561-1-kwolf@redhat.com>
References: <20170925122808.14561-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] commit: Remove overlay_bs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

We don't need to make any assumptions about the graph layout above the
top node of the commit operation any more. Remove the use of
bdrv_find_overlay() and related variables from the commit job code.

bdrv_drop_intermediate() doesn't use the 'active' parameter any more, so
we can just drop it.

The overlay node was previously added to the block job to get a
BLK_PERM_GRAPH_MOD. We really need to respect those permissions in
bdrv_drop_intermediate() now, but as long as we haven't figured out yet
how BLK_PERM_GRAPH_MOD is actually supposed to work, just leave a TODO
comment there.

With this change, it is now possible to perform another block job on an
overlay node without conflicts. qemu-iotests 030 is changed accordingly.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h  |  3 +--
 block.c                |  6 +++--
 block/commit.c         | 62 ++++++++++++--------------------------------------
 tests/qemu-iotests/030 |  4 ----
 4 files changed, 20 insertions(+), 55 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 3c3af462e4..d5c2731a03 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -315,8 +315,7 @@ int bdrv_commit(BlockDriverState *bs);
 int bdrv_change_backing_file(BlockDriverState *bs,
     const char *backing_file, const char *backing_fmt);
 void bdrv_register(BlockDriver *bdrv);
-int bdrv_drop_intermediate(BlockDriverState *active, BlockDriverState *top,
-                           BlockDriverState *base,
+int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
                            const char *backing_file_str);
 BlockDriverState *bdrv_find_overlay(BlockDriverState *active,
                                     BlockDriverState *bs);
diff --git a/block.c b/block.c
index e57fab501d..5f2d7222a5 100644
--- a/block.c
+++ b/block.c
@@ -3491,8 +3491,8 @@ BlockDriverState *bdrv_find_base(BlockDriverState *bs)
  *  if active == top, that is considered an error
  *
  */
-int bdrv_drop_intermediate(BlockDriverState *active, BlockDriverState *top,
-                           BlockDriverState *base, const char *backing_file_str)
+int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
+                           const char *backing_file_str)
 {
     BdrvChild *c, *next;
     Error *local_err = NULL;
@@ -3510,6 +3510,8 @@ int bdrv_drop_intermediate(BlockDriverState *active, BlockDriverState *top,
     }
 
     /* success - we can delete the intermediate states, and link top->base */
+    /* TODO Check graph modification op blockers (BLK_PERM_GRAPH_MOD) once
+     * we've figured out how they should work. */
     backing_file_str = backing_file_str ? backing_file_str : base->filename;
 
     QLIST_FOREACH_SAFE(c, &top->parents, next_parent, next) {
diff --git a/block/commit.c b/block/commit.c
index 610e1cd8f5..5036eec434 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -36,13 +36,11 @@ enum {
 typedef struct CommitBlockJob {
     BlockJob common;
     RateLimit limit;
-    BlockDriverState *active;
     BlockDriverState *commit_top_bs;
     BlockBackend *top;
     BlockBackend *base;
     BlockdevOnError on_error;
     int base_flags;
-    int orig_overlay_flags;
     char *backing_file_str;
 } CommitBlockJob;
 
@@ -81,18 +79,15 @@ static void commit_complete(BlockJob *job, void *opaque)
 {
     CommitBlockJob *s = container_of(job, CommitBlockJob, common);
     CommitCompleteData *data = opaque;
-    BlockDriverState *active = s->active;
     BlockDriverState *top = blk_bs(s->top);
     BlockDriverState *base = blk_bs(s->base);
-    BlockDriverState *overlay_bs = bdrv_find_overlay(active, s->commit_top_bs);
+    BlockDriverState *commit_top_bs = s->commit_top_bs;
     int ret = data->ret;
     bool remove_commit_top_bs = false;
 
-    /* Make sure overlay_bs and top stay around until bdrv_set_backing_hd() */
+    /* Make sure commit_top_bs and top stay around until bdrv_replace_node() */
     bdrv_ref(top);
-    if (overlay_bs) {
-        bdrv_ref(overlay_bs);
-    }
+    bdrv_ref(commit_top_bs);
 
     /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE before
      * the normal backing chain can be restored. */
@@ -100,9 +95,9 @@ static void commit_complete(BlockJob *job, void *opaque)
 
     if (!block_job_is_cancelled(&s->common) && ret == 0) {
         /* success */
-        ret = bdrv_drop_intermediate(active, s->commit_top_bs, base,
+        ret = bdrv_drop_intermediate(s->commit_top_bs, base,
                                      s->backing_file_str);
-    } else if (overlay_bs) {
+    } else {
         /* XXX Can (or should) we somehow keep 'consistent read' blocked even
          * after the failed/cancelled commit job is gone? If we already wrote
          * something to base, the intermediate images aren't valid any more. */
@@ -115,9 +110,6 @@ static void commit_complete(BlockJob *job, void *opaque)
     if (s->base_flags != bdrv_get_flags(base)) {
         bdrv_reopen(base, s->base_flags, NULL);
     }
-    if (overlay_bs && s->orig_overlay_flags != bdrv_get_flags(overlay_bs)) {
-        bdrv_reopen(overlay_bs, s->orig_overlay_flags, NULL);
-    }
     g_free(s->backing_file_str);
     blk_unref(s->top);
 
@@ -134,10 +126,13 @@ static void commit_complete(BlockJob *job, void *opaque)
      * filter driver from the backing chain. Do this as the final step so that
      * the 'consistent read' permission can be granted.  */
     if (remove_commit_top_bs) {
-        bdrv_set_backing_hd(overlay_bs, top, &error_abort);
+        bdrv_child_try_set_perm(commit_top_bs->backing, 0, BLK_PERM_ALL,
+                                &error_abort);
+        bdrv_replace_node(commit_top_bs, backing_bs(commit_top_bs),
+                          &error_abort);
     }
 
-    bdrv_unref(overlay_bs);
+    bdrv_unref(commit_top_bs);
     bdrv_unref(top);
 }
 
@@ -283,10 +278,8 @@ void commit_start(const char *job_id, BlockDriverState *bs,
 {
     CommitBlockJob *s;
     BlockReopenQueue *reopen_queue = NULL;
-    int orig_overlay_flags;
     int orig_base_flags;
     BlockDriverState *iter;
-    BlockDriverState *overlay_bs;
     BlockDriverState *commit_top_bs = NULL;
     Error *local_err = NULL;
     int ret;
@@ -297,31 +290,19 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         return;
     }
 
-    overlay_bs = bdrv_find_overlay(bs, top);
-
-    if (overlay_bs == NULL) {
-        error_setg(errp, "Could not find overlay image for %s:", top->filename);
-        return;
-    }
-
     s = block_job_create(job_id, &commit_job_driver, bs, 0, BLK_PERM_ALL,
                          speed, BLOCK_JOB_DEFAULT, NULL, NULL, errp);
     if (!s) {
         return;
     }
 
-    orig_base_flags    = bdrv_get_flags(base);
-    orig_overlay_flags = bdrv_get_flags(overlay_bs);
-
-    /* convert base & overlay_bs to r/w, if necessary */
+    /* convert base to r/w, if necessary */
+    orig_base_flags = bdrv_get_flags(base);
     if (!(orig_base_flags & BDRV_O_RDWR)) {
         reopen_queue = bdrv_reopen_queue(reopen_queue, base, NULL,
                                          orig_base_flags | BDRV_O_RDWR);
     }
-    if (!(orig_overlay_flags & BDRV_O_RDWR)) {
-        reopen_queue = bdrv_reopen_queue(reopen_queue, overlay_bs, NULL,
-                                         orig_overlay_flags | BDRV_O_RDWR);
-    }
+
     if (reopen_queue) {
         bdrv_reopen_multiple(bdrv_get_aio_context(bs), reopen_queue, &local_err);
         if (local_err != NULL) {
@@ -382,14 +363,6 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         goto fail;
     }
 
-    /* overlay_bs must be blocked because it needs to be modified to
-     * update the backing image string. */
-    ret = block_job_add_bdrv(&s->common, "overlay of top", overlay_bs,
-                             BLK_PERM_GRAPH_MOD, BLK_PERM_ALL, errp);
-    if (ret < 0) {
-        goto fail;
-    }
-
     s->base = blk_new(BLK_PERM_CONSISTENT_READ
                       | BLK_PERM_WRITE
                       | BLK_PERM_RESIZE,
@@ -408,13 +381,8 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         goto fail;
     }
 
-    s->active = bs;
-
-    s->base_flags          = orig_base_flags;
-    s->orig_overlay_flags  = orig_overlay_flags;
-
+    s->base_flags = orig_base_flags;
     s->backing_file_str = g_strdup(backing_file_str);
-
     s->on_error = on_error;
 
     trace_commit_start(bs, base, top, s);
@@ -429,7 +397,7 @@ fail:
         blk_unref(s->top);
     }
     if (commit_top_bs) {
-        bdrv_set_backing_hd(overlay_bs, top, &error_abort);
+        bdrv_replace_node(commit_top_bs, top, &error_abort);
     }
     block_job_early_fail(&s->common);
 }
diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index d745cb4cde..18838948fa 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -287,10 +287,6 @@ class TestParallelOps(iotests.QMPTestCase):
         result = self.vm.qmp('block-stream', device='node6', base=self.imgs[4], job_id='stream-node6-v2')
         self.assert_qmp(result, 'error/class', 'GenericError')
 
-        # This fails because block-commit needs to block node6, the overlay of the 'top' image
-        result = self.vm.qmp('block-stream', device='node7', base=self.imgs[5], job_id='stream-node6-v3')
-        self.assert_qmp(result, 'error/class', 'GenericError')
-
         # This fails because block-commit currently blocks the active layer even if it's not used
         result = self.vm.qmp('block-stream', device='drive0', base=self.imgs[5], job_id='stream-drive0')
         self.assert_qmp(result, 'error/class', 'GenericError')
-- 
2.13.5

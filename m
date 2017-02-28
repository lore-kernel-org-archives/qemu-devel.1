Received: from eggs.gnu.org ([2001:4830:134:3::10]:45879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioXR-0006u9-9T
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:38:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioXP-0008FN-UU
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:38:25 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 28 Feb 2017 21:36:45 +0100
Message-Id: <1488314205-16264-47-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
References: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 46/46] block: Add Error parameter to
 bdrv_append()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

Aborting on error in bdrv_append() isn't correct. This patch fixes it
and lets the callers handle failures.

Test case 085 needs a reference output update. This is caused by the
reversed order of bdrv_set_backing_hd() and change_parent_backing_link()
in bdrv_append(): When the backing file of the new node is set, the
parent nodes are still pointing to the old top, so the backing blocker
is now initialised with the node name rather than the BlockBackend name.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block.c                    | 23 +++++++++++++++++------
 block/mirror.c             |  9 ++++++++-
 blockdev.c                 | 18 +++++++++++++++---
 include/block/block.h      |  3 ++-
 tests/qemu-iotests/085.out |  2 +-
 5 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/block.c b/block.c
index 6440b61..f293ccb 100644
--- a/block.c
+++ b/block.c
@@ -2087,6 +2087,7 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
     int64_t total_size;
     QemuOpts *opts = NULL;
     BlockDriverState *bs_snapshot;
+    Error *local_err = NULL;
     int ret;
 
     /* if snapshot, we create a temporary backing file and open it
@@ -2136,7 +2137,12 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
      * call bdrv_unref() on it), so in order to be able to return one, we have
      * to increase bs_snapshot's refcount here */
     bdrv_ref(bs_snapshot);
-    bdrv_append(bs_snapshot, bs);
+    bdrv_append(bs_snapshot, bs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto out;
+    }
 
     g_free(tmp_filename);
     return bs_snapshot;
@@ -2927,20 +2933,25 @@ static void change_parent_backing_link(BlockDriverState *from,
  * parents of bs_top after bdrv_append() returns. If the caller needs to keep a
  * reference of its own, it must call bdrv_ref().
  */
-void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top)
+void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
+                 Error **errp)
 {
+    Error *local_err = NULL;
+
     assert(!atomic_read(&bs_top->in_flight));
     assert(!atomic_read(&bs_new->in_flight));
 
-    bdrv_ref(bs_top);
+    bdrv_set_backing_hd(bs_new, bs_top, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto out;
+    }
 
     change_parent_backing_link(bs_top, bs_new);
-    /* FIXME Error handling */
-    bdrv_set_backing_hd(bs_new, bs_top, &error_abort);
-    bdrv_unref(bs_top);
 
     /* bs_new is now referenced by its new parents, we don't need the
      * additional reference any more. */
+out:
     bdrv_unref(bs_new);
 }
 
diff --git a/block/mirror.c b/block/mirror.c
index 8497e0d..57f26c3 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1099,6 +1099,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     BlockDriverState *mirror_top_bs;
     bool target_graph_mod;
     bool target_is_backing;
+    Error *local_err = NULL;
     int ret;
 
     if (granularity == 0) {
@@ -1130,9 +1131,15 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
      * it alive until block_job_create() even if bs has no parent. */
     bdrv_ref(mirror_top_bs);
     bdrv_drained_begin(bs);
-    bdrv_append(mirror_top_bs, bs);
+    bdrv_append(mirror_top_bs, bs, &local_err);
     bdrv_drained_end(bs);
 
+    if (local_err) {
+        bdrv_unref(mirror_top_bs);
+        error_propagate(errp, local_err);
+        return;
+    }
+
     /* Make sure that the source is not resized while the job is running */
     s = block_job_create(job_id, driver, mirror_top_bs,
                          BLK_PERM_CONSISTENT_READ,
diff --git a/blockdev.c b/blockdev.c
index ff781d9..8eb4e84 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1768,6 +1768,17 @@ static void external_snapshot_prepare(BlkActionState *common,
 
     if (!state->new_bs->drv->supports_backing) {
         error_setg(errp, "The snapshot does not support backing images");
+        return;
+    }
+
+    /* This removes our old bs and adds the new bs. This is an operation that
+     * can fail, so we need to do it in .prepare; undoing it for abort is
+     * always possible. */
+    bdrv_ref(state->new_bs);
+    bdrv_append(state->new_bs, state->old_bs, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
     }
 }
 
@@ -1778,8 +1789,6 @@ static void external_snapshot_commit(BlkActionState *common)
 
     bdrv_set_aio_context(state->new_bs, state->aio_context);
 
-    /* This removes our old bs and adds the new bs */
-    bdrv_append(state->new_bs, state->old_bs);
     /* We don't need (or want) to use the transactional
      * bdrv_reopen_multiple() across all the entries at once, because we
      * don't want to abort all of them if one of them fails the reopen */
@@ -1794,7 +1803,9 @@ static void external_snapshot_abort(BlkActionState *common)
     ExternalSnapshotState *state =
                              DO_UPCAST(ExternalSnapshotState, common, common);
     if (state->new_bs) {
-        bdrv_unref(state->new_bs);
+        if (state->new_bs->backing) {
+            bdrv_replace_in_backing_chain(state->new_bs, state->old_bs);
+        }
     }
 }
 
@@ -1805,6 +1816,7 @@ static void external_snapshot_clean(BlkActionState *common)
     if (state->aio_context) {
         bdrv_drained_end(state->old_bs);
         aio_context_release(state->aio_context);
+        bdrv_unref(state->new_bs);
     }
 }
 
diff --git a/include/block/block.h b/include/block/block.h
index eac2861..c7c4a3a 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -236,7 +236,8 @@ int bdrv_create(BlockDriver *drv, const char* filename,
                 QemuOpts *opts, Error **errp);
 int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp);
 BlockDriverState *bdrv_new(void);
-void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top);
+void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
+                 Error **errp);
 void bdrv_replace_in_backing_chain(BlockDriverState *old,
                                    BlockDriverState *new);
 
diff --git a/tests/qemu-iotests/085.out b/tests/qemu-iotests/085.out
index 08e4bb7..182acb4 100644
--- a/tests/qemu-iotests/085.out
+++ b/tests/qemu-iotests/085.out
@@ -74,7 +74,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/
 
 === Invalid command - snapshot node used as backing hd ===
 
-{"error": {"class": "GenericError", "desc": "Node 'snap_11' is busy: node is used as backing hd of 'virtio0'"}}
+{"error": {"class": "GenericError", "desc": "Node 'snap_11' is busy: node is used as backing hd of 'snap_12'"}}
 
 === Invalid command - snapshot node has a backing image ===
 
-- 
1.8.3.1

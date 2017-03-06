Received: from eggs.gnu.org ([2001:4830:134:3::10]:54755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ckvPK-0002kU-GH
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:22:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ckvPJ-0001Gk-2m
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:22:46 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  6 Mar 2017 17:22:02 +0100
Message-Id: <1488817322-11397-11-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 10/10] block: Fix error handling in
 bdrv_replace_in_backing_chain()
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

When adding an Error parameter, bdrv_replace_in_backing_chain() would
become nothing more than a wrapper around change_parent_backing_link().
So make the latter public, renamed as bdrv_replace_node(), and remove
bdrv_replace_in_backing_chain().

Most of the callers just remove a node from the graph that they just
inserted, so they can use &error_abort, but completion of a mirror job
with 'replaces' set can actually fail.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                   | 25 ++++++-------------------
 block/mirror.c            | 15 +++++++++------
 blockdev.c                |  2 +-
 include/block/block.h     |  4 ++--
 include/block/block_int.h |  4 ++--
 5 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/block.c b/block.c
index a310132..dd9ded8 100644
--- a/block.c
+++ b/block.c
@@ -2932,8 +2932,8 @@ static bool should_update_child(BdrvChild *c, BlockDriverState *to)
     return true;
 }
 
-static void change_parent_backing_link(BlockDriverState *from,
-                                       BlockDriverState *to, Error **errp)
+void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
+                       Error **errp)
 {
     BdrvChild *c, *next;
     GSList *list = NULL, *p;
@@ -2941,6 +2941,9 @@ static void change_parent_backing_link(BlockDriverState *from,
     uint64_t perm = 0, shared = BLK_PERM_ALL;
     int ret;
 
+    assert(!atomic_read(&from->in_flight));
+    assert(!atomic_read(&to->in_flight));
+
     /* Make sure that @from doesn't go away until we have successfully attached
      * all of its parents to @to. */
     bdrv_ref(from);
@@ -3003,16 +3006,13 @@ void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
 {
     Error *local_err = NULL;
 
-    assert(!atomic_read(&bs_top->in_flight));
-    assert(!atomic_read(&bs_new->in_flight));
-
     bdrv_set_backing_hd(bs_new, bs_top, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto out;
     }
 
-    change_parent_backing_link(bs_top, bs_new, &local_err);
+    bdrv_replace_node(bs_top, bs_new, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         bdrv_set_backing_hd(bs_new, NULL, &error_abort);
@@ -3025,19 +3025,6 @@ out:
     bdrv_unref(bs_new);
 }
 
-void bdrv_replace_in_backing_chain(BlockDriverState *old, BlockDriverState *new)
-{
-    assert(!bdrv_requests_pending(old));
-    assert(!bdrv_requests_pending(new));
-
-    bdrv_ref(old);
-
-    /* FIXME Proper error handling */
-    change_parent_backing_link(old, new, &error_abort);
-
-    bdrv_unref(old);
-}
-
 static void bdrv_delete(BlockDriverState *bs)
 {
     assert(!bs->job);
diff --git a/block/mirror.c b/block/mirror.c
index f24dc51..a5d30ee 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -550,8 +550,12 @@ static void mirror_exit(BlockJob *job, void *opaque)
         /* The mirror job has no requests in flight any more, but we need to
          * drain potential other users of the BDS before changing the graph. */
         bdrv_drained_begin(target_bs);
-        bdrv_replace_in_backing_chain(to_replace, target_bs);
+        bdrv_replace_node(to_replace, target_bs, &local_err);
         bdrv_drained_end(target_bs);
+        if (local_err) {
+            error_report_err(local_err);
+            data->ret = -EPERM;
+        }
     }
     if (s->to_replace) {
         bdrv_op_unblock_all(s->to_replace, s->replace_blocker);
@@ -570,12 +574,11 @@ static void mirror_exit(BlockJob *job, void *opaque)
      * block the removal. */
     block_job_remove_all_bdrv(job);
     bdrv_child_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL);
-    bdrv_replace_in_backing_chain(mirror_top_bs, backing_bs(mirror_top_bs));
+    bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_abort);
 
     /* We just changed the BDS the job BB refers to (with either or both of the
-     * bdrv_replace_in_backing_chain() calls), so switch the BB back so the
-     * cleanup does the right thing. We don't need any permissions any more
-     * now. */
+     * bdrv_replace_node() calls), so switch the BB back so the cleanup does
+     * the right thing. We don't need any permissions any more now. */
     blk_remove_bs(job->blk);
     blk_set_perm(job->blk, 0, BLK_PERM_ALL, &error_abort);
     blk_insert_bs(job->blk, mirror_top_bs, &error_abort);
@@ -1234,7 +1237,7 @@ fail:
     }
 
     bdrv_child_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL);
-    bdrv_replace_in_backing_chain(mirror_top_bs, backing_bs(mirror_top_bs));
+    bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_abort);
 }
 
 void mirror_start(const char *job_id, BlockDriverState *bs,
diff --git a/blockdev.c b/blockdev.c
index af67ce4..f1f49bd 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1806,7 +1806,7 @@ static void external_snapshot_abort(BlkActionState *common)
                              DO_UPCAST(ExternalSnapshotState, common, common);
     if (state->new_bs) {
         if (state->overlay_appended) {
-            bdrv_replace_in_backing_chain(state->new_bs, state->old_bs);
+            bdrv_replace_node(state->new_bs, state->old_bs, &error_abort);
         }
     }
 }
diff --git a/include/block/block.h b/include/block/block.h
index c7c4a3a..5149260 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -238,8 +238,8 @@ int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp);
 BlockDriverState *bdrv_new(void);
 void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
                  Error **errp);
-void bdrv_replace_in_backing_chain(BlockDriverState *old,
-                                   BlockDriverState *new);
+void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
+                       Error **errp);
 
 int bdrv_parse_cache_mode(const char *mode, int *flags, bool *writethrough);
 int bdrv_parse_discard_flags(const char *mode, int *flags);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index fc83f7f..6c699ac 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -441,8 +441,8 @@ typedef struct BdrvAioNotifier {
 } BdrvAioNotifier;
 
 struct BdrvChildRole {
-    /* If true, bdrv_replace_in_backing_chain() doesn't change the node this
-     * BdrvChild points to. */
+    /* If true, bdrv_replace_node() doesn't change the node this BdrvChild
+     * points to. */
     bool stay_at_node;
 
     void (*inherit_options)(int *child_flags, QDict *child_options,
-- 
1.8.3.1

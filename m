Received: from eggs.gnu.org ([2001:4830:134:3::10]:53955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gHter-0006j8-8Q
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gHten-0004di-6n
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:47:53 -0400
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Wed, 31 Oct 2018 19:47:20 +0300
Message-Id: <1541004440-182262-3-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1541004440-182262-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1541004440-182262-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/2] Discard blocks while copy-on-read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, dgilbert@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

Discards the block duplicated in an intermediate backing file
after the block have been copied into the active layer during
QMP block-stream operation.
It saves the disk space while merging snapshots.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/stream.c | 400 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 389 insertions(+), 11 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index db81df4..0adceb4 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "trace.h"
 #include "block/block_int.h"
 #include "block/blockjob_int.h"
@@ -35,9 +36,62 @@ typedef struct StreamBlockJob {
     BlockdevOnError on_error;
     char *backing_file_str;
     int bs_flags;
+    bool discard;
+    BlockDriverState *stream_top_bs;
+    GSList *im_nodes;
 } StreamBlockJob;
 
-static int coroutine_fn stream_populate(BlockBackend *blk,
+typedef struct IntermediateNode {
+    BlockBackend *blk;
+    int flags;
+} IntermediateNode;
+
+static inline void restore_all_im_nodes(StreamBlockJob *s)
+{
+    GSList *l;
+    BlockDriverState *bs_active;
+    BlockDriverState *bs_im;
+    IntermediateNode *im_node;
+    BlockReopenQueue *queue = NULL;
+    Error *local_err = NULL;
+
+    assert(s->stream_top_bs && s->stream_top_bs->backing &&
+           s->stream_top_bs->backing->bs);
+    bs_active = backing_bs(s->stream_top_bs);
+    assert(backing_bs(bs_active));
+
+    bdrv_subtree_drained_begin(backing_bs(bs_active));
+
+    for (l = s->im_nodes; l; l = l->next) {
+        im_node = l->data;
+        if (im_node->blk) {
+            bs_im = blk_bs(im_node->blk);
+
+            if (im_node->flags != bdrv_get_flags(bs_im) && bs_im) {
+                queue = bdrv_reopen_queue(queue, bs_im, NULL, im_node->flags);
+            }
+            /* Give up write permissions before making it read-only */
+            blk_set_perm(im_node->blk, 0, BLK_PERM_ALL, &error_abort);
+            blk_unref(im_node->blk);
+            bdrv_unref(bs_im);
+        }
+        g_free(im_node);
+    }
+    g_slist_free(s->im_nodes);
+    s->im_nodes = NULL;
+
+    if (queue) {
+        bdrv_reopen_multiple(bdrv_get_aio_context(bs_active), queue,
+                             &local_err);
+        if (local_err != NULL) {
+            error_report_err(local_err);
+        }
+    }
+
+    bdrv_subtree_drained_end(backing_bs(bs_active));
+}
+
+static int coroutine_fn stream_populate(const StreamBlockJob *s,
                                         int64_t offset, uint64_t bytes,
                                         void *buf)
 {
@@ -46,12 +100,83 @@ static int coroutine_fn stream_populate(BlockBackend *blk,
         .iov_len  = bytes,
     };
     QEMUIOVector qiov;
+    GSList *l;
+    IntermediateNode *im_node;
+    int ret;
 
+    assert(s);
     assert(bytes < SIZE_MAX);
     qemu_iovec_init_external(&qiov, &iov, 1);
 
     /* Copy-on-read the unallocated clusters */
-    return blk_co_preadv(blk, offset, qiov.size, &qiov, BDRV_REQ_COPY_ON_READ);
+    ret = blk_co_preadv(s->common.blk, offset, qiov.size, &qiov,
+                        BDRV_REQ_COPY_ON_READ);
+
+    if (ret < 0 || !s->discard) {
+        return ret;
+    }
+
+    for (l = s->im_nodes; l; l = l->next) {
+        im_node = l->data;
+        blk_co_pdiscard(im_node->blk, offset, bytes);
+    }
+
+    return ret;
+}
+
+static int stream_exit_discard(StreamBlockJob *s)
+{
+    BlockJob *bjob = &s->common;
+    BlockDriverState *bs = backing_bs(s->stream_top_bs);
+    BlockDriverState *base = s->base;
+    Error *local_err = NULL;
+    int ret = 0;
+
+    /* Make sure that the BDS doesn't go away during bdrv_replace_node,
+     * before we can call bdrv_drained_end */
+    bdrv_ref(s->stream_top_bs);
+    /* Reopen intermediate images back in read-only mode */
+    restore_all_im_nodes(s);
+    /* Hold a guest back from writing until we remove the filter */
+    bdrv_drained_begin(bs);
+    /* Dropping WRITE is required before changing the backing file. */
+    bdrv_child_try_set_perm(s->stream_top_bs->backing, 0, BLK_PERM_ALL,
+                            &error_abort);
+    if (bs->backing) {
+        const char *base_id = NULL, *base_fmt = NULL;
+        if (base) {
+            base_id = s->backing_file_str;
+            if (base->drv) {
+                base_fmt = base->drv->format_name;
+            }
+        }
+        ret = bdrv_change_backing_file(bs, base_id, base_fmt);
+        bdrv_set_backing_hd(bs, base, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            ret = -EPERM;
+        }
+    }
+    /* Remove the filter driver from the graph. Before this, get rid of
+     * the blockers on the intermediate nodes so that the resulting state is
+     * valid. Also give up permissions on stream_top_bs->backing, which might
+     * block the removal. */
+    block_job_remove_all_bdrv(bjob);
+    bdrv_child_try_set_perm(s->stream_top_bs->backing, 0, BLK_PERM_ALL,
+                            &error_abort);
+    bdrv_replace_node(s->stream_top_bs, backing_bs(s->stream_top_bs),
+                      &error_abort);
+    /* We just changed the BDS the job BB refers to (with either or both of the
+     * bdrv_replace_node() calls), so switch the BB back so the cleanup does
+     * the right thing. We don't need any permissions any more now. */
+    blk_remove_bs(bjob->blk);
+    blk_set_perm(bjob->blk, 0, BLK_PERM_ALL, &error_abort);
+    blk_insert_bs(bjob->blk, s->stream_top_bs, &error_abort);
+
+    bdrv_drained_end(bs);
+    bdrv_unref(s->stream_top_bs);
+
+    return ret;
 }
 
 static int stream_prepare(Job *job)
@@ -63,6 +188,10 @@ static int stream_prepare(Job *job)
     Error *local_err = NULL;
     int ret = 0;
 
+    if (s->discard) {
+        return stream_exit_discard(s);
+    }
+
     if (bs->backing) {
         const char *base_id = NULL, *base_fmt = NULL;
         if (base) {
@@ -102,7 +231,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockBackend *blk = s->common.blk;
-    BlockDriverState *bs = blk_bs(blk);
+    BlockDriverState *bs;
     BlockDriverState *base = s->base;
     int64_t len;
     int64_t offset = 0;
@@ -112,6 +241,12 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     int64_t n = 0; /* bytes */
     void *buf;
 
+    if (s->discard) {
+        bs = backing_bs(s->stream_top_bs);
+    } else {
+        bs = blk_bs(blk);
+    }
+
     if (!bs->backing) {
         goto out;
     }
@@ -165,7 +300,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         }
         trace_stream_one_iteration(s, offset, n, ret);
         if (copy) {
-            ret = stream_populate(blk, offset, n, buf);
+            ret = stream_populate(s, offset, n, buf);
         }
         if (ret < 0) {
             BlockErrorAction action =
@@ -206,6 +341,209 @@ out:
     return ret;
 }
 
+static int coroutine_fn bdrv_stream_top_preadv(BlockDriverState *bs,
+    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+{
+    return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
+}
+
+static int coroutine_fn bdrv_stream_top_pwritev(BlockDriverState *bs,
+    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+{
+    return bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
+}
+
+static int coroutine_fn bdrv_stream_top_flush(BlockDriverState *bs)
+{
+    if (bs->backing == NULL) {
+        /* we can be here after failed bdrv_append in stream_start */
+        return 0;
+    }
+    return bdrv_co_flush(bs->backing->bs);
+}
+
+static int coroutine_fn bdrv_stream_top_pwrite_zeroes(BlockDriverState *bs,
+    int64_t offset, int bytes, BdrvRequestFlags flags)
+{
+    return bdrv_co_pwrite_zeroes(bs->backing, offset, bytes, flags);
+}
+
+static int coroutine_fn bdrv_stream_top_pdiscard(BlockDriverState *bs,
+    int64_t offset, int bytes)
+{
+    return bdrv_co_pdiscard(bs->backing, offset, bytes);
+}
+
+static int bdrv_stream_top_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
+{
+    return bdrv_get_info(bs->backing->bs, bdi);
+}
+
+static void bdrv_stream_top_refresh_filename(BlockDriverState *bs, QDict *opts)
+{
+    if (bs->backing == NULL) {
+        /* we can be here after failed bdrv_attach_child in
+         * bdrv_set_backing_hd */
+        return;
+    }
+    bdrv_refresh_filename(bs->backing->bs);
+    pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
+            bs->backing->bs->filename);
+}
+
+static void bdrv_stream_top_child_perm(BlockDriverState *bs, BdrvChild *c,
+                                       const BdrvChildRole *role,
+                                       BlockReopenQueue *reopen_queue,
+                                       uint64_t perm, uint64_t shared,
+                                       uint64_t *nperm, uint64_t *nshared)
+{
+    /* Must be able to forward guest writes to the real image */
+    *nperm = 0;
+    if (perm & BLK_PERM_WRITE) {
+        *nperm |= BLK_PERM_WRITE;
+    }
+
+    *nshared = BLK_PERM_ALL;
+}
+
+/* Dummy node that provides consistent read to its users without requiring it
+ * from its backing file and that allows writes on the backing file chain. */
+static BlockDriver bdrv_stream_top = {
+    .format_name                = "stream_top",
+    .bdrv_co_preadv             = bdrv_stream_top_preadv,
+    .bdrv_co_pwritev            = bdrv_stream_top_pwritev,
+    .bdrv_co_pwrite_zeroes      = bdrv_stream_top_pwrite_zeroes,
+    .bdrv_co_pdiscard           = bdrv_stream_top_pdiscard,
+    .bdrv_get_info              = bdrv_stream_top_get_info,
+    .bdrv_co_flush              = bdrv_stream_top_flush,
+    .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
+    .bdrv_refresh_filename      = bdrv_stream_top_refresh_filename,
+    .bdrv_child_perm            = bdrv_stream_top_child_perm,
+};
+
+/* In the case of block discard, add a dummy driver
+ * to make the backing chain writable. */
+static BlockDriverState *insert_filter(BlockDriverState *bs, Error **errp)
+{
+    const char *filter_node_name = NULL;
+    BlockDriverState *stream_top_bs;
+    Error *local_err = NULL;
+
+    stream_top_bs = bdrv_new_open_driver(&bdrv_stream_top, filter_node_name,
+                                         BDRV_O_RDWR, errp);
+    if (stream_top_bs == NULL) {
+        return NULL;
+    }
+    if (!filter_node_name) {
+        stream_top_bs->implicit = true;
+    }
+
+    stream_top_bs->total_sectors = bs->total_sectors;
+    stream_top_bs->supported_write_flags = BDRV_REQ_WRITE_UNCHANGED;
+    stream_top_bs->supported_zero_flags = BDRV_REQ_WRITE_UNCHANGED;
+    bdrv_set_aio_context(stream_top_bs, bdrv_get_aio_context(bs));
+
+    /* bdrv_append takes ownership of the stream_top_bs reference, need to keep
+     * it alive until block_job_create() succeeds even if bs has no parent. */
+    bdrv_ref(stream_top_bs);
+    bdrv_drained_begin(bs);
+    bdrv_append(stream_top_bs, bs, &local_err);
+    bdrv_drained_end(bs);
+
+    if (local_err) {
+        bdrv_unref(stream_top_bs);
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    return stream_top_bs;
+}
+
+/* Makes intermediate block chain writable */
+static int init_intermediate_nodes(StreamBlockJob *s,
+                                   BlockDriverState *bs,
+                                   BlockDriverState *base, Error **errp)
+{
+    BlockDriverState *iter;
+    int backing_bs_flags;
+    IntermediateNode *im_node;
+    BlockBackend *blk;
+    BlockReopenQueue *queue = NULL;
+    Error *local_err = NULL;
+    int ret;
+
+    /* Sanity check */
+    if (!backing_bs(bs)) {
+        error_setg(errp, "Top BDS does not have a backing file.");
+        return -EINVAL;
+    }
+    if (base && !bdrv_chain_contains(bs, base)) {
+        error_setg(errp, "The backing chain does not contain the base file.");
+        return -EINVAL;
+    }
+
+    /* Reopen intermediate images in read-write mode */
+    bdrv_subtree_drained_begin(backing_bs(bs));
+
+    for (iter = backing_bs(bs); iter && iter != base; iter = backing_bs(iter)) {
+        /* Keep the intermediate backing chain with BDRV original flags */
+        backing_bs_flags = bdrv_get_flags(iter);
+        im_node = g_new0(IntermediateNode, 1);
+        im_node->blk = NULL;
+        im_node->flags = backing_bs_flags;
+        bdrv_ref(iter);
+        s->im_nodes = g_slist_prepend(s->im_nodes, im_node);
+
+        if ((backing_bs_flags & BDRV_O_RDWR) == 0) {
+            queue = bdrv_reopen_queue(queue, iter, NULL,
+                                      backing_bs_flags | BDRV_O_RDWR);
+        }
+    }
+
+    if (queue) {
+        ret = bdrv_reopen_multiple(bdrv_get_aio_context(bs), queue, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            bdrv_subtree_drained_end(backing_bs(bs));
+            restore_all_im_nodes(s);
+            return -1;
+        }
+    }
+
+    bdrv_subtree_drained_end(backing_bs(bs));
+
+    s->im_nodes = g_slist_reverse(s->im_nodes);
+    GSList *l = s->im_nodes;
+
+    for (iter = backing_bs(bs); iter && iter != base; iter = backing_bs(iter)) {
+        blk = blk_new(BLK_PERM_WRITE, BLK_PERM_CONSISTENT_READ |
+                      BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED |
+                      BLK_PERM_GRAPH_MOD);
+        if (!blk) {
+            error_setg(errp,
+                       "Block Stream: failed to create new Block Backend.");
+            goto fail;
+        }
+
+        ret = blk_insert_bs(blk, iter, errp);
+        if (ret < 0) {
+            goto fail;
+        }
+
+        assert(l);
+        im_node = l->data;
+        im_node->blk = blk;
+        l = l->next;
+    }
+
+    return 0;
+
+fail:
+    restore_all_im_nodes(s);
+
+    return -1;
+}
+
 static const BlockJobDriver stream_job_driver = {
     .job_driver = {
         .instance_size = sizeof(StreamBlockJob),
@@ -224,9 +562,12 @@ void stream_start(const char *job_id, BlockDriverState *bs,
                   int creation_flags, int64_t speed, bool discard,
                   BlockdevOnError on_error, Error **errp)
 {
-    StreamBlockJob *s;
+    StreamBlockJob *s = NULL;
     BlockDriverState *iter;
     int orig_bs_flags;
+    BlockDriverState *stream_top_bs;
+    int node_shared_flags = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
+    int ret;
 
     /* Make sure that the image is opened in read-write mode */
     orig_bs_flags = bdrv_get_flags(bs);
@@ -236,10 +577,19 @@ void stream_start(const char *job_id, BlockDriverState *bs,
         }
     }
 
+    if (discard) {
+        node_shared_flags |= BLK_PERM_WRITE;
+        stream_top_bs = insert_filter(bs, errp);
+        if (stream_top_bs == NULL) {
+            goto fail;
+        }
+    } else {
+        stream_top_bs = bs;
+    }
     /* Prevent concurrent jobs trying to modify the graph structure here, we
      * already have our own plans. Also don't allow resize as the image size is
      * queried only at the job start and then cached. */
-    s = block_job_create(job_id, &stream_job_driver, NULL, bs,
+    s = block_job_create(job_id, &stream_job_driver, NULL, stream_top_bs,
                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
                          BLK_PERM_GRAPH_MOD,
                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
@@ -251,18 +601,28 @@ void stream_start(const char *job_id, BlockDriverState *bs,
 
     /* Block all intermediate nodes between bs and base, because they will
      * disappear from the chain after this operation. The streaming job reads
-     * every block only once, assuming that it doesn't change, so block writes
-     * and resizes. */
+     * every block only once, assuming that it doesn't change, so forbid writes
+     * and resizes. Allow writing in case of discard. */
     for (iter = backing_bs(bs); iter && iter != base; iter = backing_bs(iter)) {
         block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
-                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED,
-                           &error_abort);
+                           node_shared_flags, &error_abort);
+    }
+
+    if (discard) {
+        s->stream_top_bs = stream_top_bs;
+        /* The block job now has a reference to this node */
+        bdrv_unref(stream_top_bs);
+
+        ret = init_intermediate_nodes(s, bs, base, errp);
+        if (ret < 0) {
+            goto fail;
+        }
     }
 
     s->base = base;
     s->backing_file_str = g_strdup(backing_file_str);
     s->bs_flags = orig_bs_flags;
-
+    s->discard = discard;
     s->on_error = on_error;
     trace_stream_start(bs, base, s);
     job_start(&s->common.job);
@@ -272,4 +632,22 @@ fail:
     if (orig_bs_flags != bdrv_get_flags(bs)) {
         bdrv_reopen(bs, orig_bs_flags, NULL);
     }
+    if (!discard) {
+        return;
+    }
+    if (s) {
+        /* Make sure this BDS does not go away until we have completed the graph
+         * changes below */
+        bdrv_ref(stream_top_bs);
+        job_early_fail(&s->common.job);
+    }
+    if (stream_top_bs) {
+        bdrv_drained_begin(bs);
+        bdrv_child_try_set_perm(stream_top_bs->backing, 0, BLK_PERM_ALL,
+                                &error_abort);
+        bdrv_replace_node(stream_top_bs, backing_bs(stream_top_bs),
+                          &error_abort);
+        bdrv_drained_end(bs);
+        bdrv_unref(stream_top_bs);
+    }
 }
-- 
1.8.3.1

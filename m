Received: from eggs.gnu.org ([208.118.235.92]:43331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gdhOq-0001fz-KN
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 15:09:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gdhOn-0008Ez-Jg
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 15:09:28 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Sun, 30 Dec 2018 23:09:13 +0300
Message-Id: <1546200557-774583-3-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1546200557-774583-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1546200557-774583-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 2/6] Discard blocks while copy-on-read
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
It saves the disk space while merging external snapshots.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/stream.c | 207 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 195 insertions(+), 12 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 20e768e..af2eebf 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "trace.h"
 #include "block/block_int.h"
 #include "block/blockjob_int.h"
@@ -37,14 +38,68 @@ typedef struct StreamBlockJob {
     char *backing_file_str;
     bool bs_read_only;
     BlockDriverState *cor_filter_bs;
+    bool discard;
+    GSList *im_nodes;
 } StreamBlockJob;
 
+typedef struct IntermediateNode {
+    BlockBackend *blk;
+    bool bs_read_only;
+} IntermediateNode;
+
 static BlockDriverState *child_file_bs(BlockDriverState *bs)
 {
     return bs->file ? bs->file->bs : NULL;
 }
 
-static int coroutine_fn stream_populate(BlockBackend *blk,
+static void restore_all_im_nodes(StreamBlockJob *s)
+{
+    GSList *l;
+    BlockDriverState *bs_active;
+    BlockDriverState *bs_im;
+    IntermediateNode *im_node;
+    QDict *opts;
+    BlockReopenQueue *queue = NULL;
+    Error *local_err = NULL;
+
+    assert(s->cor_filter_bs);
+    bs_active = child_file_bs(s->cor_filter_bs);
+    assert(bs_active && backing_bs(bs_active));
+
+    bdrv_subtree_drained_begin(backing_bs(bs_active));
+
+    for (l = s->im_nodes; l; l = l->next) {
+        im_node = l->data;
+        if (im_node->blk) {
+            bs_im = blk_bs(im_node->blk);
+
+            if (im_node->bs_read_only && bs_im && !bdrv_is_read_only(bs_im)) {
+                opts = qdict_new();
+                qdict_put_bool(opts, BDRV_OPT_READ_ONLY, true);
+                queue = bdrv_reopen_queue(queue, bs_im, opts);
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
@@ -53,12 +108,28 @@ static int coroutine_fn stream_populate(BlockBackend *blk,
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
 }
 
 static int stream_change_backing_file(Job *job)
@@ -109,6 +180,8 @@ static void stream_exit(Job *job)
     if (s->cor_filter_bs == NULL) {
         return;
     }
+    /* Reopen intermediate images back in read-only mode */
+    restore_all_im_nodes(s);
     /* Remove the filter driver from the graph */
     remove_filter(s->cor_filter_bs);
     s->cor_filter_bs = NULL;
@@ -145,7 +218,6 @@ static void stream_clean(Job *job)
 static int coroutine_fn stream_run(Job *job, Error **errp)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
-    BlockBackend *blk = s->common.blk;
     BlockDriverState *bs = child_file_bs(s->cor_filter_bs);
     BlockDriverState *base = s->base;
     int64_t len;
@@ -209,7 +281,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         }
         trace_stream_one_iteration(s, offset, n, ret);
         if (copy) {
-            ret = stream_populate(blk, offset, n, buf);
+            ret = stream_populate(s, offset, n, buf);
         }
         if (ret < 0) {
             BlockErrorAction action =
@@ -250,22 +322,27 @@ out:
     return ret;
 }
 
-static BlockDriverState *create_filter_node(BlockDriverState *bs, Error **errp)
+static BlockDriverState *create_filter_node(BlockDriverState *bs, bool discard,
+                                            Error **errp)
 {
     QDict *opts = qdict_new();
 
     qdict_put_str(opts, "driver", "copy-on-read");
     qdict_put_str(opts, "file", bdrv_get_node_name(bs));
+    if (discard) {
+        qdict_put_bool(opts, "driver.discard", true);
+    }
 
     return bdrv_open(NULL, NULL, opts, BDRV_O_RDWR, errp);
 }
 
-static BlockDriverState *insert_filter(BlockDriverState *bs, Error **errp)
+static BlockDriverState *insert_filter(BlockDriverState *bs, bool discard,
+                                       Error **errp)
 {
     BlockDriverState *cor_filter_bs;
     Error *local_err = NULL;
 
-    cor_filter_bs = create_filter_node(bs, errp);
+    cor_filter_bs = create_filter_node(bs, discard, errp);
     if (cor_filter_bs == NULL) {
         error_prepend(errp, "Could not create filter node: ");
         return NULL;
@@ -286,6 +363,92 @@ static BlockDriverState *insert_filter(BlockDriverState *bs, Error **errp)
     return cor_filter_bs;
 }
 
+/* Makes intermediate block chain writable */
+static int init_intermediate_nodes(StreamBlockJob *s,
+                                   BlockDriverState *bs,
+                                   BlockDriverState *base, Error **errp)
+{
+    BlockDriverState *iter;
+    bool bs_read_only;
+    IntermediateNode *im_node;
+    BlockBackend *blk;
+    QDict *opts;
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
+        bs_read_only = bdrv_is_read_only(iter);
+        im_node = g_new0(IntermediateNode, 1);
+        im_node->blk = NULL;
+        im_node->bs_read_only = bs_read_only;
+        bdrv_ref(iter);
+        s->im_nodes = g_slist_prepend(s->im_nodes, im_node);
+
+        if (bs_read_only) {
+            opts = qdict_new();
+            qdict_put_bool(opts, BDRV_OPT_READ_ONLY, false);
+            queue = bdrv_reopen_queue(queue, iter, opts);
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
@@ -308,6 +471,9 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     StreamBlockJob *s;
     BlockDriverState *iter;
     bool bs_read_only;
+    const bool discard = false;
+    int node_shared_flags = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
+    int ret;
 
     /* Make sure that the image is opened in read-write mode */
     bs_read_only = bdrv_is_read_only(bs);
@@ -330,21 +496,34 @@ void stream_start(const char *job_id, BlockDriverState *bs,
         goto fail;
     }
 
-    /* Block all intermediate nodes between bs and base, because they will
+    /*
+     * Block all intermediate nodes between bs and base, because they will
      * disappear from the chain after this operation. The streaming job reads
-     * every block only once, assuming that it doesn't change, so block writes
-     * and resizes. */
+     * every block only once, assuming that it doesn't change, so forbid writes
+     * and resizes. Allow writing in case of discard.
+     */
+    if (discard) {
+        node_shared_flags |= BLK_PERM_WRITE;
+    }
     for (iter = backing_bs(bs); iter && iter != base; iter = backing_bs(iter)) {
         block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
-                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED,
+                           node_shared_flags,
                            &error_abort);
     }
 
-    s->cor_filter_bs = insert_filter(bs, errp);
+    s->cor_filter_bs = insert_filter(bs, discard, errp);
     if (s->cor_filter_bs == NULL) {
         goto fail;
     }
 
+    if (discard) {
+        ret = init_intermediate_nodes(s, bs, base, errp);
+        if (ret < 0) {
+            goto fail;
+        }
+    }
+
+    s->discard = discard;
     s->base = base;
     s->backing_file_str = g_strdup(backing_file_str);
     s->bs_read_only = bs_read_only;
@@ -355,6 +534,10 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     return;
 
 fail:
+    if (s && s->cor_filter_bs) {
+        remove_filter(s->cor_filter_bs);
+        job_early_fail(&s->common.job);
+    }
     if (bs_read_only) {
         bdrv_reopen_set_read_only(bs, true, NULL);
     }
-- 
1.8.3.1

Received: from eggs.gnu.org ([209.51.188.92]:45467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gmHue-00071k-AU
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:45:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gmHi7-0003Mt-Oe
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:32:53 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Wed, 23 Jan 2019 14:54:24 +0300
Message-Id: <1548244464-633186-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH RFC 1/1] Stream block job involves copy-on-read
 filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

The copy-on-read filter driver is applied to block-stream operations.
The 'test_stream_parallel' in the file tests/qemu-iotests/030 runs
jobs that use nodes for streaming in parallel through the backing chain.
We've got filters being inserted to and removed from the backing chain
while jobs are running. As a result, a filter node may be passed as the
'base' parameter to the stream_start() function when the base node name
is not specified (the base node is identified by its file name which is
the same to the related filter node).
Another issue is that a function keeps the pointer to the filter BDS
object that can be replaced and deleted after the co-routine switch.
For example, the function backing_bs() returns the pointer to the
backing BDS and the BDS reference counter is not incremented.
A solution (or workaround) made with the given patch for block-stream
job helps to pass all the iotests in the file tests/qemu-iotests/030.
Any piece of advice how to amend the solution will be appreciated.
I am looking forward to hearing from you.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/stream.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 143 insertions(+), 11 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 7a49ac0..18e51b3 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -16,6 +16,7 @@
 #include "block/block_int.h"
 #include "block/blockjob_int.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/ratelimit.h"
 #include "sysemu/block-backend.h"
@@ -35,8 +36,26 @@ typedef struct StreamBlockJob {
     BlockdevOnError on_error;
     char *backing_file_str;
     bool bs_read_only;
+    BlockDriverState *cor_filter_bs;
+    BlockDriverState *target_bs;
 } StreamBlockJob;
 
+static BlockDriverState *child_file_bs(BlockDriverState *bs)
+{
+    return bs->file ? bs->file->bs : NULL;
+}
+
+static BlockDriverState *skip_filter(BlockDriverState *bs)
+{
+    BlockDriverState *ret_bs = bs;
+
+    while (ret_bs && ret_bs->drv && ret_bs->drv->is_filter) {
+        ret_bs = child_file_bs(ret_bs);
+    }
+
+    return ret_bs;
+}
+
 static int coroutine_fn stream_populate(BlockBackend *blk,
                                         int64_t offset, uint64_t bytes,
                                         void *buf)
@@ -51,14 +70,12 @@ static int coroutine_fn stream_populate(BlockBackend *blk,
     qemu_iovec_init_external(&qiov, &iov, 1);
 
     /* Copy-on-read the unallocated clusters */
-    return blk_co_preadv(blk, offset, qiov.size, &qiov, BDRV_REQ_COPY_ON_READ);
+    return blk_co_preadv(blk, offset, qiov.size, &qiov, 0);
 }
 
-static int stream_prepare(Job *job)
+static int stream_change_backing_file(StreamBlockJob *s)
 {
-    StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
-    BlockJob *bjob = &s->common;
-    BlockDriverState *bs = blk_bs(bjob->blk);
+    BlockDriverState *bs = s->target_bs;
     BlockDriverState *base = s->base;
     Error *local_err = NULL;
     int ret = 0;
@@ -82,11 +99,53 @@ static int stream_prepare(Job *job)
     return ret;
 }
 
+static int stream_exit(Job *job, bool abort)
+{
+    StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
+    BlockJob *bjob = &s->common;
+    BlockDriverState *target_bs = s->target_bs;
+    int ret = 0;
+
+    /* Retain the BDS until we complete the graph change. */
+    bdrv_ref(target_bs);
+    /* Hold a guest back from writing while permissions are being reset. */
+    bdrv_drained_begin(target_bs);
+    /* Drop permissions before the graph change. */
+    bdrv_child_try_set_perm(s->cor_filter_bs->file, 0, BLK_PERM_ALL,
+                            &error_abort);
+    if (!abort) {
+        ret = stream_change_backing_file(s);
+    }
+
+    bdrv_replace_node(s->cor_filter_bs, target_bs, &error_abort);
+    /* Switch the BB back to the filter so that job terminated properly. */
+    blk_remove_bs(bjob->blk);
+    blk_set_perm(bjob->blk, 0, BLK_PERM_ALL, &error_abort);
+    blk_insert_bs(bjob->blk, s->cor_filter_bs, &error_abort);
+
+    bdrv_drained_end(target_bs);
+    bdrv_unref(target_bs);
+    /* Submit control over filter to the job instance. */
+    bdrv_unref(s->cor_filter_bs);
+
+    return ret;
+}
+
+static int stream_prepare(Job *job)
+{
+    return stream_exit(job, false);
+}
+
+static void stream_abort(Job *job)
+{
+    stream_exit(job, job->ret < 0);
+}
+
 static void stream_clean(Job *job)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockJob *bjob = &s->common;
-    BlockDriverState *bs = blk_bs(bjob->blk);
+    BlockDriverState *bs = s->target_bs;
 
     /* Reopen the image back in read-only mode if necessary */
     if (s->bs_read_only) {
@@ -102,7 +161,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockBackend *blk = s->common.blk;
-    BlockDriverState *bs = blk_bs(blk);
+    BlockDriverState *bs = s->target_bs;
     BlockDriverState *base = s->base;
     int64_t len;
     int64_t offset = 0;
@@ -213,12 +272,64 @@ static const BlockJobDriver stream_job_driver = {
         .free          = block_job_free,
         .run           = stream_run,
         .prepare       = stream_prepare,
+        .abort         = stream_abort,
         .clean         = stream_clean,
         .user_resume   = block_job_user_resume,
         .drain         = block_job_drain,
     },
 };
 
+static BlockDriverState *create_filter_node(BlockDriverState *bs,
+                                            Error **errp)
+{
+    QDict *opts = qdict_new();
+
+    qdict_put_str(opts, "driver", "copy-on-read");
+    qdict_put_str(opts, "file", bdrv_get_node_name(bs));
+
+    return bdrv_open(NULL, NULL, opts, BDRV_O_RDWR, errp);
+}
+
+static void remove_filter(BlockDriverState *cor_filter_bs)
+{
+    BlockDriverState *bs = child_file_bs(cor_filter_bs);
+
+    /* Hold a guest back from writing until we remove the filter */
+    bdrv_drained_begin(bs);
+    bdrv_child_try_set_perm(cor_filter_bs->file, 0, BLK_PERM_ALL,
+                            &error_abort);
+    bdrv_replace_node(cor_filter_bs, bs, &error_abort);
+    bdrv_drained_end(bs);
+
+    bdrv_unref(cor_filter_bs);
+}
+
+static BlockDriverState *insert_filter(BlockDriverState *bs, Error **errp)
+{
+    BlockDriverState *cor_filter_bs;
+    Error *local_err = NULL;
+
+    cor_filter_bs = create_filter_node(bs, errp);
+    if (cor_filter_bs == NULL) {
+        error_prepend(errp, "Could not create filter node: ");
+        return NULL;
+    }
+
+    bdrv_set_aio_context(cor_filter_bs, bdrv_get_aio_context(bs));
+
+    bdrv_drained_begin(bs);
+    bdrv_replace_node(bs, cor_filter_bs, &local_err);
+    bdrv_drained_end(bs);
+
+    if (local_err) {
+        bdrv_unref(cor_filter_bs);
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    return cor_filter_bs;
+}
+
 void stream_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *base, const char *backing_file_str,
                   int creation_flags, int64_t speed,
@@ -227,6 +338,14 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     StreamBlockJob *s;
     BlockDriverState *iter;
     bool bs_read_only;
+    BlockDriverState *cor_filter_bs;
+
+    /*
+     * The base node might be identified by its file name rather than
+     * by its node name. In that case, we can encounter a filter node
+     * instead which has other BS pointer and the same file name.
+     */
+    base = skip_filter(base);
 
     /* Make sure that the image is opened in read-write mode */
     bs_read_only = bdrv_is_read_only(bs);
@@ -236,10 +355,15 @@ void stream_start(const char *job_id, BlockDriverState *bs,
         }
     }
 
+    cor_filter_bs = insert_filter(bs, errp);
+    if (cor_filter_bs == NULL) {
+        goto fail;
+    }
+
     /* Prevent concurrent jobs trying to modify the graph structure here, we
      * already have our own plans. Also don't allow resize as the image size is
      * queried only at the job start and then cached. */
-    s = block_job_create(job_id, &stream_job_driver, NULL, bs,
+    s = block_job_create(job_id, &stream_job_driver, NULL, cor_filter_bs,
                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
                          BLK_PERM_GRAPH_MOD,
                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
@@ -249,16 +373,21 @@ void stream_start(const char *job_id, BlockDriverState *bs,
         goto fail;
     }
 
-    /* Block all intermediate nodes between bs and base, because they will
+    /*
+     * Block all intermediate nodes between bs and base, because they will
      * disappear from the chain after this operation. The streaming job reads
      * every block only once, assuming that it doesn't change, so block writes
-     * and resizes. */
-    for (iter = backing_bs(bs); iter && iter != base; iter = backing_bs(iter)) {
+     * and resizes. We account a filter node may be a part of the graph.
+     */
+    for (iter = skip_filter(backing_bs(bs)); iter && iter != base;
+         iter = skip_filter(backing_bs(iter))) {
         block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
                            BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED,
                            &error_abort);
     }
 
+    s->cor_filter_bs = cor_filter_bs;
+    s->target_bs = bs;
     s->base = base;
     s->backing_file_str = g_strdup(backing_file_str);
     s->bs_read_only = bs_read_only;
@@ -269,6 +398,9 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     return;
 
 fail:
+    if (cor_filter_bs) {
+        remove_filter(cor_filter_bs);
+    }
     if (bs_read_only) {
         bdrv_reopen_set_read_only(bs, true, NULL);
     }
-- 
1.8.3.1

Received: from eggs.gnu.org ([209.51.188.92]:48108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hAvhd-0007Ot-QL
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:06:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hAvhc-0006iu-2d
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:06:13 -0400
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Mon,  1 Apr 2019 15:06:05 +0300
Message-Id: <1554120365-39119-4-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1554120365-39119-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1554120365-39119-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 3/3] block/stream: introduce a bottom node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com, berto@igalia.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

The bottom node is the intermediate block device that has the base as its
backing image. It is used instead of the base node while a block stream
job is running to avoid dependency on the base that may change due to the
parallel jobs. The change may take place due to a filter node as well that
is inserted between the base and the intermediate bottom node. It occurs
when the base node is the top one for another commit or stream job.
After the introduction of the bottom node, don't freeze its backing child,
that's the base, anymore.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/stream.c            | 54 +++++++++++++++++++++++------------------------
 block/trace-events        |  2 +-
 blockdev.c                |  7 +++++-
 include/block/block_int.h |  6 +++---
 tests/qemu-iotests/245    |  4 ++--
 5 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index c065e99..913f04e 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -31,7 +31,7 @@ enum {
 
 typedef struct StreamBlockJob {
     BlockJob common;
-    BlockDriverState *base;
+    BlockDriverState *bottom;
     BlockdevOnError on_error;
     char *backing_file_str;
     bool bs_read_only;
@@ -56,7 +56,7 @@ static void stream_abort(Job *job)
 
     if (s->chain_frozen) {
         BlockJob *bjob = &s->common;
-        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->base);
+        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->bottom);
     }
 }
 
@@ -65,11 +65,11 @@ static int stream_prepare(Job *job)
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockJob *bjob = &s->common;
     BlockDriverState *bs = blk_bs(bjob->blk);
-    BlockDriverState *base = s->base;
+    BlockDriverState *base = backing_bs(s->bottom);
     Error *local_err = NULL;
     int ret = 0;
 
-    bdrv_unfreeze_backing_chain(bs, base);
+    bdrv_unfreeze_backing_chain(bs, s->bottom);
     s->chain_frozen = false;
 
     if (bs->backing) {
@@ -112,7 +112,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockBackend *blk = s->common.blk;
     BlockDriverState *bs = blk_bs(blk);
-    BlockDriverState *base = s->base;
+    bool enable_cor = !backing_bs(s->bottom);
     int64_t len;
     int64_t offset = 0;
     uint64_t delay_ns = 0;
@@ -121,7 +121,8 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     int64_t n = 0; /* bytes */
     void *buf;
 
-    if (!bs->backing) {
+    if (bs == s->bottom) {
+        /* Nothing to stream */
         return 0;
     }
 
@@ -138,7 +139,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
      * backing chain since the copy-on-read operation does not take base into
      * account.
      */
-    if (!base) {
+    if (enable_cor) {
         bdrv_enable_copy_on_read(bs);
     }
 
@@ -161,9 +162,8 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         } else if (ret >= 0) {
             /* Copy if allocated in the intermediate images.  Limit to the
              * known-unallocated area [offset, offset+n*BDRV_SECTOR_SIZE).  */
-            ret = bdrv_is_allocated_above(backing_bs(bs), base,
-                                          offset, n, &n);
-
+            ret = bdrv_is_allocated_above_inclusive(backing_bs(bs), s->bottom,
+                                                    offset, n, &n);
             /* Finish early if end of backing file has been reached */
             if (ret == 0 && n == 0) {
                 n = len - offset;
@@ -200,7 +200,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         }
     }
 
-    if (!base) {
+    if (enable_cor) {
         bdrv_disable_copy_on_read(bs);
     }
 
@@ -225,13 +225,14 @@ static const BlockJobDriver stream_job_driver = {
 };
 
 void stream_start(const char *job_id, BlockDriverState *bs,
-                  BlockDriverState *base, const char *backing_file_str,
+                  BlockDriverState *bottom, const char *backing_file_str,
                   int creation_flags, int64_t speed,
                   BlockdevOnError on_error, Error **errp)
 {
     StreamBlockJob *s;
     BlockDriverState *iter;
     bool bs_read_only;
+    int basic_flags = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
 
     /* Make sure that the image is opened in read-write mode */
     bs_read_only = bdrv_is_read_only(bs);
@@ -245,37 +246,36 @@ void stream_start(const char *job_id, BlockDriverState *bs,
      * already have our own plans. Also don't allow resize as the image size is
      * queried only at the job start and then cached. */
     s = block_job_create(job_id, &stream_job_driver, NULL, bs,
-                         BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
-                         BLK_PERM_GRAPH_MOD,
-                         BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
-                         BLK_PERM_WRITE,
+                         basic_flags | BLK_PERM_GRAPH_MOD,
+                         basic_flags | BLK_PERM_WRITE,
                          speed, creation_flags, NULL, NULL, errp);
     if (!s) {
         goto fail;
     }
 
-    /* Block all intermediate nodes between bs and base, because they will
-     * disappear from the chain after this operation. The streaming job reads
-     * every block only once, assuming that it doesn't change, so block writes
-     * and resizes. */
-    for (iter = backing_bs(bs); iter && iter != base; iter = backing_bs(iter)) {
-        block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
-                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED,
-                           &error_abort);
+    /*
+     * Block all intermediate nodes between bs and bottom (inclusive), because
+     * they will disappear from the chain after this operation. The streaming
+     * job reads every block only once, assuming that it doesn't change, so
+     * forbid writes and resizes.
+     */
+    for (iter = bs; iter != bottom; iter = backing_bs(iter)) {
+        block_job_add_bdrv(&s->common, "intermediate node", backing_bs(iter),
+                           0, basic_flags, &error_abort);
     }
 
-    if (bdrv_freeze_backing_chain(bs, base, errp) < 0) {
+    if (bdrv_freeze_backing_chain(bs, bottom, errp) < 0) {
         job_early_fail(&s->common.job);
         goto fail;
     }
 
-    s->base = base;
+    s->bottom = bottom;
     s->backing_file_str = g_strdup(backing_file_str);
     s->bs_read_only = bs_read_only;
     s->chain_frozen = true;
 
     s->on_error = on_error;
-    trace_stream_start(bs, base, s);
+    trace_stream_start(bs, bottom, s);
     job_start(&s->common.job);
     return;
 
diff --git a/block/trace-events b/block/trace-events
index e6bb5a8..36e7b79 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -20,7 +20,7 @@ bdrv_co_copy_range_to(void *src, uint64_t src_offset, void *dst, uint64_t dst_of
 
 # stream.c
 stream_one_iteration(void *s, int64_t offset, uint64_t bytes, int is_allocated) "s %p offset %" PRId64 " bytes %" PRIu64 " is_allocated %d"
-stream_start(void *bs, void *base, void *s) "bs %p base %p s %p"
+stream_start(void *bs, void *bottom, void *s) "bs %p bottom %p s %p"
 
 # commit.c
 commit_one_iteration(void *s, int64_t offset, uint64_t bytes, int is_allocated) "s %p offset %" PRId64 " bytes %" PRIu64 " is_allocated %d"
diff --git a/blockdev.c b/blockdev.c
index 4775a07..ce0cad4 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3164,6 +3164,7 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
 {
     BlockDriverState *bs, *iter;
     BlockDriverState *base_bs = NULL;
+    BlockDriverState *bottom_node = NULL;
     AioContext *aio_context;
     Error *local_err = NULL;
     const char *base_name = NULL;
@@ -3237,7 +3238,11 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
         job_flags |= JOB_MANUAL_DISMISS;
     }
 
-    stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
+    /* Find the bottom node that has the base as its backing image */
+    bottom_node = bdrv_find_overlay(bs, base_bs);
+    assert(bottom_node);
+
+    stream_start(has_job_id ? job_id : NULL, bs, bottom_node, base_name,
                  job_flags, has_speed ? speed : 0, on_error, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 01e855a..8ab1144 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1019,8 +1019,8 @@ int is_windows_drive(const char *filename);
  * @job_id: The id of the newly-created job, or %NULL to use the
  * device name of @bs.
  * @bs: Block device to operate on.
- * @base: Block device that will become the new base, or %NULL to
- * flatten the whole backing file chain onto @bs.
+ * @bottom_node: The intermediate block device right above the new base.
+ * If base is %NULL, the whole backing file chain is flattened onto @bs.
  * @backing_file_str: The file name that will be written to @bs as the
  * the new backing file if the job completes. Ignored if @base is %NULL.
  * @creation_flags: Flags that control the behavior of the Job lifetime.
@@ -1037,7 +1037,7 @@ int is_windows_drive(const char *filename);
  * BlockDriverState.
  */
 void stream_start(const char *job_id, BlockDriverState *bs,
-                  BlockDriverState *base, const char *backing_file_str,
+                  BlockDriverState *bottom_node, const char *backing_file_str,
                   int creation_flags, int64_t speed,
                   BlockdevOnError on_error, Error **errp);
 
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 7891a21..d11e73c 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -859,9 +859,9 @@ class TestBlockdevReopen(iotests.QMPTestCase):
                              device = 'hd0', base_node = 'hd2', speed = 512 * 1024)
         self.assert_qmp(result, 'return', {})
 
-        # We can't remove hd2 while the stream job is ongoing
+        # We can remove hd2 while the stream job is ongoing
         opts['backing']['backing'] = None
-        self.reopen(opts, {}, "Cannot change 'backing' link from 'hd1' to 'hd2'")
+        self.reopen(opts, {})
 
         # We can't remove hd1 while the stream job is ongoing
         opts['backing'] = None
-- 
1.8.3.1

Received: from eggs.gnu.org ([209.51.188.92]:58013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIW2Y-0002xq-TB
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 06:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIW2X-0006Yc-4F
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 06:19:10 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 22 Apr 2019 13:19:00 +0300
Message-Id: <20190422101900.13897-4-vsementsov@virtuozzo.com>
In-Reply-To: <20190422101900.13897-1-vsementsov@virtuozzo.com>
References: <20190422101900.13897-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 3/3] block/stream: introduce a bottom node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: xiechanglong.d@gmail.com, wencongyang2@huawei.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, berto@igalia.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

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
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/stream.c         | 49 +++++++++++++++++++++---------------------
 tests/qemu-iotests/245 |  4 ++--
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index e73a3201c8..c39212eb3c 100644
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
-            ret = bdrv_is_allocated_above(backing_bs(bs), base, false,
+            ret = bdrv_is_allocated_above(backing_bs(bs), s->bottom, true,
                                           offset, n, &n);
-
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
 
@@ -232,8 +232,10 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     StreamBlockJob *s;
     BlockDriverState *iter;
     bool bs_read_only;
+    int basic_flags = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
+    BlockDriverState *bottom = bdrv_find_overlay(bs, base);
 
-    if (bdrv_freeze_backing_chain(bs, base, errp) < 0) {
+    if (bdrv_freeze_backing_chain(bs, bottom, errp) < 0) {
         return;
     }
 
@@ -250,26 +252,25 @@ void stream_start(const char *job_id, BlockDriverState *bs,
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
 
-    s->base = base;
+    s->bottom = bottom;
     s->backing_file_str = g_strdup(backing_file_str);
     s->bs_read_only = bs_read_only;
     s->chain_frozen = true;
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index a04c6235c1..006f9f72f0 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -865,9 +865,9 @@ class TestBlockdevReopen(iotests.QMPTestCase):
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
2.18.0

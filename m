Received: from eggs.gnu.org ([2001:4830:134:3::10]:42144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fRAWg-0000Zd-L4
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fRAWf-00009o-1w
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:05:30 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Jun 2018 14:04:17 +0800
Message-Id: <20180608060417.10170-7-famz@redhat.com>
In-Reply-To: <20180608060417.10170-1-famz@redhat.com>
References: <20180608060417.10170-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 6/6] mirror: Use copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This makes the mirror job to try offloaded copy. If it fails, error
action will not be taken yet, instead the failed cluster and all the
subsequent ones will fall back to bounce buffer.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/mirror.c     | 71 +++++++++++++++++++++++++++++++++++++++++++++-
 block/trace-events |  1 +
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/block/mirror.c b/block/mirror.c
index 435268bbbf..a90b64550c 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -71,6 +71,8 @@ typedef struct MirrorBlockJob {
     int target_cluster_size;
     int max_iov;
     bool initial_zeroing_ongoing;
+
+    bool use_copy_range;
 } MirrorBlockJob;
 
 typedef struct MirrorOp {
@@ -293,6 +295,69 @@ static uint64_t mirror_do_read(MirrorBlockJob *s, int64_t offset,
     return ret;
 }
 
+static void mirror_copy_range_complete(void *opaque, int ret)
+{
+    MirrorOp *op = opaque;
+    MirrorBlockJob *s = op->s;
+
+    aio_context_acquire(blk_get_aio_context(s->common.blk));
+    trace_mirror_copy_range_complete(s, ret, op->offset, op->bytes);
+    if (!ret) {
+        mirror_iteration_done(op, ret);
+    } else {
+        uint64_t bytes;
+
+        s->use_copy_range = false;
+        s->in_flight--;
+        s->bytes_in_flight -= op->bytes;
+        bytes = mirror_do_read(s, op->offset, op->bytes);
+        /* No alignment adjusting in mirror_do_read since we've already done
+         * that in mirror_do_copy(). */
+        assert(bytes == op->bytes);
+        g_free(op);
+    }
+    aio_context_release(blk_get_aio_context(s->common.blk));
+}
+
+static uint64_t mirror_do_copy(MirrorBlockJob *s, int64_t offset,
+                               uint64_t bytes)
+{
+    uint64_t ret;
+    MirrorOp *op;
+
+    if (!s->use_copy_range || offset < BLOCK_PROBE_BUF_SIZE) {
+        return mirror_do_read(s, offset, bytes);
+    }
+
+    assert(bytes);
+    assert(bytes < BDRV_REQUEST_MAX_BYTES);
+    ret = bytes;
+
+    if (s->cow_bitmap) {
+        ret += mirror_cow_align(s, &offset, &bytes);
+    }
+    /* The offset is granularity-aligned because:
+     * 1) Caller passes in aligned values;
+     * 2) mirror_cow_align is used only when target cluster is larger. */
+    assert(QEMU_IS_ALIGNED(offset, s->granularity));
+    /* The range is sector-aligned, since bdrv_getlength() rounds up. */
+    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
+
+    op = g_new0(MirrorOp, 1);
+    op->s = s;
+    op->offset = offset;
+    op->bytes = bytes;
+
+    /* Copy the dirty cluster.  */
+    s->in_flight++;
+    s->bytes_in_flight += bytes;
+    trace_mirror_one_iteration(s, offset, bytes);
+
+    blk_aio_copy_range(s->common.blk, offset, s->target, offset,
+                       bytes, 0, mirror_copy_range_complete, op);
+    return ret;
+}
+
 static void mirror_do_zero_or_discard(MirrorBlockJob *s,
                                       int64_t offset,
                                       uint64_t bytes,
@@ -429,7 +494,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         io_bytes = mirror_clip_bytes(s, offset, io_bytes);
         switch (mirror_method) {
         case MIRROR_METHOD_COPY:
-            io_bytes = io_bytes_acct = mirror_do_read(s, offset, io_bytes);
+            io_bytes = io_bytes_acct = mirror_do_copy(s, offset, io_bytes);
             break;
         case MIRROR_METHOD_ZERO:
         case MIRROR_METHOD_DISCARD:
@@ -1090,6 +1155,8 @@ static BlockDriver bdrv_mirror_top = {
     .bdrv_co_pdiscard           = bdrv_mirror_top_pdiscard,
     .bdrv_co_flush              = bdrv_mirror_top_flush,
     .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
+    .bdrv_co_copy_range_from    = bdrv_co_copy_range_from_backing,
+    .bdrv_co_copy_range_to      = bdrv_co_copy_range_to_backing,
     .bdrv_refresh_filename      = bdrv_mirror_top_refresh_filename,
     .bdrv_close                 = bdrv_mirror_top_close,
     .bdrv_child_perm            = bdrv_mirror_top_child_perm,
@@ -1177,6 +1244,8 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     s->source = bs;
     s->mirror_top_bs = mirror_top_bs;
 
+    s->use_copy_range = true;
+
     /* No resize for the target either; while the mirror is still running, a
      * consistent read isn't necessarily possible. We could possibly allow
      * writes and graph modifications, though it would likely defeat the
diff --git a/block/trace-events b/block/trace-events
index 2d59b53fd3..2958003e33 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -34,6 +34,7 @@ mirror_one_iteration(void *s, int64_t offset, uint64_t bytes) "s %p offset %" PR
 mirror_iteration_done(void *s, int64_t offset, uint64_t bytes, int ret) "s %p offset %" PRId64 " bytes %" PRIu64 " ret %d"
 mirror_yield(void *s, int64_t cnt, int buf_free_count, int in_flight) "s %p dirty count %"PRId64" free buffers %d in_flight %d"
 mirror_yield_in_flight(void *s, int64_t offset, int in_flight) "s %p offset %" PRId64 " in_flight %d"
+mirror_copy_range_complete(void *s, int ret, int64_t offset, uint64_t bytes) "s %p ret %d offset %" PRId64 " bytes %" PRIu64
 
 # block/backup.c
 backup_do_cow_enter(void *job, int64_t start, int64_t offset, uint64_t bytes) "job %p start %" PRId64 " offset %" PRId64 " bytes %" PRIu64
-- 
2.17.0

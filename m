Received: from eggs.gnu.org ([2001:4830:134:3::10]:40468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cy4Iz-0006YS-Ks
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 18:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cy4Ix-0004oK-HM
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 18:30:33 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 11 Apr 2017 17:29:45 -0500
Message-Id: <20170411222945.11741-18-eblake@redhat.com>
In-Reply-To: <20170411222945.11741-1-eblake@redhat.com>
References: <20170411222945.11741-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 17/17] block: Make bdrv_is_allocated_above()
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Wen Congyang <wency@cn.fujitsu.com>, Changlong Xie <xiecl.fnst@cn.fujitsu.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  In the common case, allocation is unlikely to ever use
values that are not naturally sector-aligned, but it is possible
that byte-based values will let us be more precise about allocation
at the end of an unaligned file that can do byte-based access.

Changing the signature of the function to use int64_t *pnum ensures
that the compiler enforces that all callers are updated.  For now,
the io.c layer still assert()s that all callers are sector-aligned,
but that can be relaxed when a later patch implements byte-based
block status.  Therefore, for the most part this patch is just the
addition of scaling at the callers followed by inverse scaling at
bdrv_is_allocated().  But some code, particularly stream_run(),
gets a lot simpler because it no longer has to mess with sectors.

For ease of review, bdrv_is_allocated() was tackled separately.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/block.h |  2 +-
 block/commit.c        | 20 ++++++++------------
 block/io.c            | 36 +++++++++++++++---------------------
 block/mirror.c        |  5 ++++-
 block/replication.c   | 17 ++++++++++++-----
 block/stream.c        | 21 +++++++++------------
 qemu-img.c            | 10 +++++++---
 7 files changed, 56 insertions(+), 55 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 8641149..740cb86 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -425,7 +425,7 @@ int64_t bdrv_get_block_status_above(BlockDriverState *bs,
 int bdrv_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
                       int64_t *pnum);
 int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
-                            int64_t sector_num, int nb_sectors, int *pnum);
+                            int64_t offset, int64_t bytes, int64_t *pnum);

 bool bdrv_is_read_only(BlockDriverState *bs);
 bool bdrv_is_sg(BlockDriverState *bs);
diff --git a/block/commit.c b/block/commit.c
index 4d6bb2a..989de7d 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -132,7 +132,7 @@ static void coroutine_fn commit_run(void *opaque)
     int64_t offset;
     uint64_t delay_ns = 0;
     int ret = 0;
-    int n = 0; /* sectors */
+    int64_t n = 0; /* bytes */
     void *buf = NULL;
     int bytes_written = 0;
     int64_t base_len;
@@ -157,7 +157,7 @@ static void coroutine_fn commit_run(void *opaque)

     buf = blk_blockalign(s->top, COMMIT_BUFFER_SIZE);

-    for (offset = 0; offset < s->common.len; offset += n * BDRV_SECTOR_SIZE) {
+    for (offset = 0; offset < s->common.len; offset += n) {
         bool copy;

         /* Note that even when no rate limit is applied we need to yield
@@ -169,15 +169,12 @@ static void coroutine_fn commit_run(void *opaque)
         }
         /* Copy if allocated above the base */
         ret = bdrv_is_allocated_above(blk_bs(s->top), blk_bs(s->base),
-                                      offset / BDRV_SECTOR_SIZE,
-                                      COMMIT_BUFFER_SIZE / BDRV_SECTOR_SIZE,
-                                      &n);
+                                      offset, COMMIT_BUFFER_SIZE, &n);
         copy = (ret == 1);
-        trace_commit_one_iteration(s, offset, n * BDRV_SECTOR_SIZE, ret);
+        trace_commit_one_iteration(s, offset, n, ret);
         if (copy) {
-            ret = commit_populate(s->top, s->base, offset,
-                                  n * BDRV_SECTOR_SIZE, buf);
-            bytes_written += n * BDRV_SECTOR_SIZE;
+            ret = commit_populate(s->top, s->base, offset, n, buf);
+            bytes_written += n;
         }
         if (ret < 0) {
             BlockErrorAction action =
@@ -190,11 +187,10 @@ static void coroutine_fn commit_run(void *opaque)
             }
         }
         /* Publish progress */
-        s->common.offset += n * BDRV_SECTOR_SIZE;
+        s->common.offset += n;

         if (copy && s->common.speed) {
-            delay_ns = ratelimit_calculate_delay(&s->limit,
-                                                 n * BDRV_SECTOR_SIZE);
+            delay_ns = ratelimit_calculate_delay(&s->limit, n);
         }
     }

diff --git a/block/io.c b/block/io.c
index 438a493..9218329 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1930,52 +1930,46 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
 /*
  * Given an image chain: ... -> [BASE] -> [INTER1] -> [INTER2] -> [TOP]
  *
- * Return true if the given sector is allocated in any image between
+ * Return true if the given offset is allocated in any image between
  * BASE and TOP (inclusive).  BASE can be NULL to check if the given
- * sector is allocated in any image of the chain.  Return false otherwise,
+ * offset is allocated in any image of the chain.  Return false otherwise,
  * or negative errno on failure.
  *
- * 'pnum' is set to the number of sectors (including and immediately following
- *  the specified sector) that are known to be in the same
+ * 'pnum' is set to the number of bytes (including and immediately following
+ *  the specified offset) that are known to be in the same
  *  allocated/unallocated state.
  *
  */
 int bdrv_is_allocated_above(BlockDriverState *top,
                             BlockDriverState *base,
-                            int64_t sector_num,
-                            int nb_sectors, int *pnum)
+                            int64_t offset, int64_t bytes, int64_t *pnum)
 {
     BlockDriverState *intermediate;
-    int ret, n = nb_sectors;
+    int ret;
+    int64_t n = bytes;

     intermediate = top;
     while (intermediate && intermediate != base) {
         int64_t pnum_inter;
-        int psectors_inter;

-        ret = bdrv_is_allocated(intermediate, sector_num * BDRV_SECTOR_SIZE,
-                                nb_sectors * BDRV_SECTOR_SIZE,
-                                &pnum_inter);
+        ret = bdrv_is_allocated(intermediate, offset, bytes, &pnum_inter);
         if (ret < 0) {
             return ret;
         }
-        assert(pnum_inter < INT_MAX * BDRV_SECTOR_SIZE);
-        psectors_inter = pnum_inter >> BDRV_SECTOR_BITS;
         if (ret) {
-            *pnum = psectors_inter;
+            *pnum = pnum_inter;
             return 1;
         }

         /*
-         * [sector_num, nb_sectors] is unallocated on top but intermediate
-         * might have
-         *
-         * [sector_num+x, nr_sectors] allocated.
+         * [offset, bytes] is unallocated on top but intermediate
+         * might have [offset+x, bytes-x] allocated.
          */
-        if (n > psectors_inter &&
+        if (n > pnum_inter &&
             (intermediate == top ||
-             sector_num + psectors_inter < intermediate->total_sectors)) {
-            n = psectors_inter;
+             offset + pnum_inter < (intermediate->total_sectors *
+                                    BDRV_SECTOR_SIZE))) {
+            n = pnum_inter;
         }

         intermediate = backing_bs(intermediate);
diff --git a/block/mirror.c b/block/mirror.c
index 8de0492..c92335a 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -609,6 +609,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
     BlockDriverState *bs = s->source;
     BlockDriverState *target_bs = blk_bs(s->target);
     int ret, n;
+    int64_t count;

     end = s->bdev_length / BDRV_SECTOR_SIZE;

@@ -658,11 +659,13 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
             return 0;
         }

-        ret = bdrv_is_allocated_above(bs, base, sector_num, nb_sectors, &n);
+        ret = bdrv_is_allocated_above(bs, base, sector_num * BDRV_SECTOR_SIZE,
+                                      nb_sectors * BDRV_SECTOR_SIZE, &count);
         if (ret < 0) {
             return ret;
         }

+        n = DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
         assert(n > 0);
         if (ret == 1) {
             bdrv_set_dirty_bitmap(s->dirty_bitmap, sector_num, n);
diff --git a/block/replication.c b/block/replication.c
index 414ecc4..605d90f 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -264,7 +264,8 @@ static coroutine_fn int replication_co_writev(BlockDriverState *bs,
     BdrvChild *top = bs->file;
     BdrvChild *base = s->secondary_disk;
     BdrvChild *target;
-    int ret, n;
+    int ret;
+    int64_t n;

     ret = replication_get_io_status(s);
     if (ret < 0) {
@@ -283,14 +284,20 @@ static coroutine_fn int replication_co_writev(BlockDriverState *bs,
      */
     qemu_iovec_init(&hd_qiov, qiov->niov);
     while (remaining_sectors > 0) {
-        ret = bdrv_is_allocated_above(top->bs, base->bs, sector_num,
-                                      remaining_sectors, &n);
+        int64_t count;
+
+        ret = bdrv_is_allocated_above(top->bs, base->bs,
+                                      sector_num * BDRV_SECTOR_SIZE,
+                                      remaining_sectors * BDRV_SECTOR_SIZE,
+                                      &count);
         if (ret < 0) {
             goto out1;
         }

+        assert(QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE));
+        n = count >> BDRV_SECTOR_BITS;
         qemu_iovec_reset(&hd_qiov);
-        qemu_iovec_concat(&hd_qiov, qiov, bytes_done, n * BDRV_SECTOR_SIZE);
+        qemu_iovec_concat(&hd_qiov, qiov, bytes_done, count);

         target = ret ? top : base;
         ret = bdrv_co_writev(target, sector_num, n, &hd_qiov);
@@ -300,7 +307,7 @@ static coroutine_fn int replication_co_writev(BlockDriverState *bs,

         remaining_sectors -= n;
         sector_num += n;
-        bytes_done += n * BDRV_SECTOR_SIZE;
+        bytes_done += count;
     }

 out1:
diff --git a/block/stream.c b/block/stream.c
index 85502eb..9033655 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -112,7 +112,7 @@ static void coroutine_fn stream_run(void *opaque)
     uint64_t delay_ns = 0;
     int error = 0;
     int ret = 0;
-    int n = 0; /* sectors */
+    int64_t n = 0; /* bytes */
     void *buf;

     if (!bs->backing) {
@@ -136,9 +136,8 @@ static void coroutine_fn stream_run(void *opaque)
         bdrv_enable_copy_on_read(bs);
     }

-    for ( ; offset < s->common.len; offset += n * BDRV_SECTOR_SIZE) {
+    for ( ; offset < s->common.len; offset += n) {
         bool copy;
-        int64_t count = 0;

         /* Note that even when no rate limit is applied we need to yield
          * with no pending I/O here so that bdrv_drain_all() returns.
@@ -150,26 +149,25 @@ static void coroutine_fn stream_run(void *opaque)

         copy = false;

-        ret = bdrv_is_allocated(bs, offset, STREAM_BUFFER_SIZE, &count);
-        n = DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
+        ret = bdrv_is_allocated(bs, offset, STREAM_BUFFER_SIZE, &n);
         if (ret == 1) {
             /* Allocated in the top, no need to copy.  */
         } else if (ret >= 0) {
             /* Copy if allocated in the intermediate images.  Limit to the
              * known-unallocated area [offset, offset+n*BDRV_SECTOR_SIZE).  */
             ret = bdrv_is_allocated_above(backing_bs(bs), base,
-                                          offset / BDRV_SECTOR_SIZE, n, &n);
+                                          offset, n, &n);

             /* Finish early if end of backing file has been reached */
             if (ret == 0 && n == 0) {
-                n = (s->common.len - offset) / BDRV_SECTOR_SIZE;
+                n = s->common.len - offset;
             }

             copy = (ret == 1);
         }
-        trace_stream_one_iteration(s, offset, n * BDRV_SECTOR_SIZE, ret);
+        trace_stream_one_iteration(s, offset, n, ret);
         if (copy) {
-            ret = stream_populate(blk, offset, n * BDRV_SECTOR_SIZE, buf);
+            ret = stream_populate(blk, offset, n, buf);
         }
         if (ret < 0) {
             BlockErrorAction action =
@@ -188,10 +186,9 @@ static void coroutine_fn stream_run(void *opaque)
         ret = 0;

         /* Publish progress */
-        s->common.offset += n * BDRV_SECTOR_SIZE;
+        s->common.offset += n;
         if (copy && s->common.speed) {
-            delay_ns = ratelimit_calculate_delay(&s->limit,
-                                                 n * BDRV_SECTOR_SIZE);
+            delay_ns = ratelimit_calculate_delay(&s->limit, n);
         }
     }

diff --git a/qemu-img.c b/qemu-img.c
index 2f21d69..d96b4d6 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1448,12 +1448,16 @@ static int img_compare(int argc, char **argv)
         }

         for (;;) {
+            int64_t count;
+
             nb_sectors = sectors_to_process(total_sectors_over, sector_num);
             if (nb_sectors <= 0) {
                 break;
             }
-            ret = bdrv_is_allocated_above(blk_bs(blk_over), NULL, sector_num,
-                                          nb_sectors, &pnum);
+            ret = bdrv_is_allocated_above(blk_bs(blk_over), NULL,
+                                          sector_num * BDRV_SECTOR_SIZE,
+                                          nb_sectors * BDRV_SECTOR_SIZE,
+                                          &count);
             if (ret < 0) {
                 ret = 3;
                 error_report("Sector allocation test failed for %s",
@@ -1461,7 +1465,7 @@ static int img_compare(int argc, char **argv)
                 goto out;

             }
-            nb_sectors = pnum;
+            nb_sectors = DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
             if (ret) {
                 ret = check_empty_sectors(blk_over, sector_num, nb_sectors,
                                           filename_over, buf1, quiet);
-- 
2.9.3

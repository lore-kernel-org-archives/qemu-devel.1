Received: from eggs.gnu.org ([2001:4830:134:3::10]:54028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVgLO-00054B-BV
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVgLM-0005vz-Nw
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:47:58 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 13 Jul 2017 10:47:00 -0500
Message-Id: <20170713154711.32374-13-eblake@redhat.com>
In-Reply-To: <20170713154711.32374-1-eblake@redhat.com>
References: <20170713154711.32374-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 12/23] block: Convert
 bdrv_get_block_status_above() to bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  In the common case, allocation is unlikely to ever use
values that are not naturally sector-aligned, but it is possible
that byte-based values will let us be more precise about allocation
at the end of an unaligned file that can do byte-based access.

Changing the name of the function from bdrv_get_block_status_above()
to bdrv_block_status_above() ensures that the compiler enforces that
all callers are updated.  For now, the io.c layer still assert()s
that all callers are sector-aligned, but that can be relaxed when a
later patch implements byte-based block status in the drivers.

For the most part this patch is just the addition of scaling at the
callers followed by inverse scaling at bdrv_block_status().  But some
code, particularly bdrv_block_status(), gets a lot simpler because
it no longer has to mess with sectors.  Likewise, mirror code no
longer computes s->granularity >> BDRV_SECTOR_BITS, and can therefore
drop an assertion (fix a neighboring assertion to use is_power_of_2
while there).

For ease of review, bdrv_get_block_status() was tackled separately.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v3: rebase to allocation/mapping sense change and qcow2-measure, tweak
mirror assertions, drop R-b
v2: rebase to earlier changes
---
 include/block/block.h | 10 +++++-----
 block/io.c            | 39 ++++++++-------------------------------
 block/mirror.c        | 16 +++++-----------
 block/qcow2.c         | 25 +++++++++----------------
 qemu-img.c            | 39 +++++++++++++++++++++++----------------
 5 files changed, 50 insertions(+), 79 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 581011b..7fe0125 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -427,11 +427,11 @@ bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
 int64_t bdrv_block_status(BlockDriverState *bs, int64_t offset,
                           int64_t bytes, int64_t *pnum,
                           BlockDriverState **file);
-int64_t bdrv_get_block_status_above(BlockDriverState *bs,
-                                    BlockDriverState *base,
-                                    int64_t sector_num,
-                                    int nb_sectors, int *pnum,
-                                    BlockDriverState **file);
+int64_t bdrv_block_status_above(BlockDriverState *bs,
+                                BlockDriverState *base,
+                                int64_t offset,
+                                int64_t bytes, int64_t *pnum,
+                                BlockDriverState **file);
 int bdrv_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
                       int64_t *pnum);
 int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
diff --git a/block/io.c b/block/io.c
index 8f8d7f7..1f59d42 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1907,7 +1907,7 @@ static int64_t coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
     return ret;
 }

-/* Coroutine wrapper for bdrv_get_block_status_above() */
+/* Coroutine wrapper for bdrv_block_status_above() */
 static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
 {
     BdrvCoBlockStatusData *data = opaque;
@@ -1954,43 +1954,20 @@ static int64_t bdrv_common_block_status_above(BlockDriverState *bs,
     return data.ret;
 }

-int64_t bdrv_get_block_status_above(BlockDriverState *bs,
-                                    BlockDriverState *base,
-                                    int64_t sector_num,
-                                    int nb_sectors, int *pnum,
-                                    BlockDriverState **file)
+int64_t bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
+                                int64_t offset, int64_t bytes, int64_t *pnum,
+                                BlockDriverState **file)
 {
-    int64_t ret;
-    int64_t n;
-
-    ret = bdrv_common_block_status_above(bs, base, true,
-                                         sector_num * BDRV_SECTOR_SIZE,
-                                         nb_sectors * BDRV_SECTOR_SIZE,
-                                         &n, file);
-    if (ret < 0) {
-        return ret;
-    }
-    assert(QEMU_IS_ALIGNED(n, BDRV_SECTOR_SIZE));
-    *pnum = n >> BDRV_SECTOR_BITS;
-    return ret;
+    return bdrv_common_block_status_above(bs, base, true, offset, bytes,
+                                          pnum, file);
 }

 int64_t bdrv_block_status(BlockDriverState *bs,
                           int64_t offset, int64_t bytes, int64_t *pnum,
                           BlockDriverState **file)
 {
-    int64_t ret;
-    int n;
-
-    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
-    bytes = MIN(bytes, BDRV_REQUEST_MAX_BYTES);
-    ret = bdrv_get_block_status_above(bs, backing_bs(bs),
-                                      offset >> BDRV_SECTOR_BITS,
-                                      bytes >> BDRV_SECTOR_BITS, &n, file);
-    if (pnum) {
-        *pnum = n * BDRV_SECTOR_SIZE;
-    }
-    return ret;
+    return bdrv_block_status_above(bs, backing_bs(bs),
+                                   offset, bytes, pnum, file);
 }

 int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
diff --git a/block/mirror.c b/block/mirror.c
index 195d475..15b809e 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -328,7 +328,6 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
     uint64_t delay_ns = 0;
     /* At least the first dirty chunk is mirrored in one iteration. */
     int nb_chunks = 1;
-    int sectors_per_chunk = s->granularity >> BDRV_SECTOR_BITS;
     bool write_zeroes_ok = bdrv_can_write_zeroes_with_unmap(blk_bs(s->target));
     int max_io_bytes = MAX(s->buf_size / MAX_IN_FLIGHT, MAX_IO_BYTES);

@@ -377,7 +376,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
     }

     /* Clear dirty bits before querying the block status, because
-     * calling bdrv_get_block_status_above could yield - if some blocks are
+     * calling bdrv_block_status_above could yield - if some blocks are
      * marked dirty in this window, we need to know.
      */
     bdrv_reset_dirty_bitmap_locked(s->dirty_bitmap, offset,
@@ -387,7 +386,6 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
     bitmap_set(s->in_flight_bitmap, offset / s->granularity, nb_chunks);
     while (nb_chunks > 0 && offset < s->bdev_length) {
         int64_t ret;
-        int io_sectors;
         int64_t io_bytes;
         int64_t io_bytes_acct;
         enum MirrorMethod {
@@ -397,11 +395,9 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         } mirror_method = MIRROR_METHOD_COPY;

         assert(!(offset % s->granularity));
-        ret = bdrv_get_block_status_above(source, NULL,
-                                          offset >> BDRV_SECTOR_BITS,
-                                          nb_chunks * sectors_per_chunk,
-                                          &io_sectors, NULL);
-        io_bytes = io_sectors * BDRV_SECTOR_SIZE;
+        ret = bdrv_block_status_above(source, NULL, offset,
+                                      nb_chunks * s->granularity,
+                                      &io_bytes, NULL);
         if (ret < 0) {
             io_bytes = MIN(nb_chunks * s->granularity, max_io_bytes);
         } else if (ret & BDRV_BLOCK_DATA) {
@@ -1121,9 +1117,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         granularity = bdrv_get_default_bitmap_granularity(target);
     }

-    assert ((granularity & (granularity - 1)) == 0);
-    /* Granularity must be large enough for sector-based dirty bitmap */
-    assert(granularity >= BDRV_SECTOR_SIZE);
+    assert(is_power_of_2(granularity));

     if (buf_size < 0) {
         error_setg(errp, "Invalid parameter 'buf-size'");
diff --git a/block/qcow2.c b/block/qcow2.c
index 36e686e..c30becf 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2990,7 +2990,7 @@ finish:

 static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
-    int nr;
+    int64_t nr;
     int64_t res;
     int64_t start;

@@ -3006,10 +3006,8 @@ static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
     if (!bytes) {
         return true;
     }
-    res = bdrv_get_block_status_above(bs, NULL, start >> BDRV_SECTOR_BITS,
-                                      bytes >> BDRV_SECTOR_BITS, &nr, NULL);
-    return res >= 0 && (res & BDRV_BLOCK_ZERO) &&
-        nr * BDRV_SECTOR_SIZE == bytes;
+    res = bdrv_block_status_above(bs, NULL, start, bytes, &nr, NULL);
+    return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == bytes;
 }

 static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
@@ -3665,17 +3663,13 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
             required = virtual_size;
         } else {
             int64_t offset;
-            int pnum = 0;
+            int64_t pnum = 0;

-            for (offset = 0; offset < ssize;
-                 offset += pnum * BDRV_SECTOR_SIZE) {
-                int nb_sectors = MIN(ssize - offset,
-                                     INT_MAX) / BDRV_SECTOR_SIZE;
+            for (offset = 0; offset < ssize; offset += pnum) {
                 int64_t ret;

-                ret = bdrv_get_block_status_above(in_bs, NULL,
-                                                  offset >> BDRV_SECTOR_BITS,
-                                                  nb_sectors, &pnum, NULL);
+                ret = bdrv_block_status_above(in_bs, NULL, offset,
+                                              ssize - offset, &pnum, NULL);
                 if (ret < 0) {
                     error_setg_errno(&local_err, -ret,
                                      "Unable to get block status");
@@ -3687,11 +3681,10 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
                 } else if ((ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) ==
                            (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) {
                     /* Extend pnum to end of cluster for next iteration */
-                    pnum = (ROUND_UP(offset + pnum * BDRV_SECTOR_SIZE,
-                                 cluster_size) - offset) >> BDRV_SECTOR_BITS;
+                    pnum = ROUND_UP(offset + pnum, cluster_size) - offset;

                     /* Count clusters we've seen */
-                    required += offset % cluster_size + pnum * BDRV_SECTOR_SIZE;
+                    required += offset % cluster_size + pnum;
                 }
             }
         }
diff --git a/qemu-img.c b/qemu-img.c
index 149dab2..06a0106 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1219,7 +1219,7 @@ static int img_compare(int argc, char **argv)
     BlockDriverState *bs1, *bs2;
     int64_t total_sectors1, total_sectors2;
     uint8_t *buf1 = NULL, *buf2 = NULL;
-    int pnum1, pnum2;
+    int64_t pnum1, pnum2;
     int allocated1, allocated2;
     int ret = 0; /* return value - 0 Ident, 1 Different, >1 Error */
     bool progress = false, quiet = false, strict = false;
@@ -1373,9 +1373,11 @@ static int img_compare(int argc, char **argv)
         if (nb_sectors <= 0) {
             break;
         }
-        status1 = bdrv_get_block_status_above(bs1, NULL, sector_num,
-                                              total_sectors1 - sector_num,
-                                              &pnum1, NULL);
+        status1 = bdrv_block_status_above(bs1, NULL,
+                                          sector_num * BDRV_SECTOR_SIZE,
+                                          (total_sectors1 - sector_num) *
+                                          BDRV_SECTOR_SIZE,
+                                          &pnum1, NULL);
         if (status1 < 0) {
             ret = 3;
             error_report("Sector allocation test failed for %s", filename1);
@@ -1383,9 +1385,11 @@ static int img_compare(int argc, char **argv)
         }
         allocated1 = status1 & BDRV_BLOCK_ALLOCATED;

-        status2 = bdrv_get_block_status_above(bs2, NULL, sector_num,
-                                              total_sectors2 - sector_num,
-                                              &pnum2, NULL);
+        status2 = bdrv_block_status_above(bs2, NULL,
+                                          sector_num * BDRV_SECTOR_SIZE,
+                                          (total_sectors2 - sector_num) *
+                                          BDRV_SECTOR_SIZE,
+                                          &pnum2, NULL);
         if (status2 < 0) {
             ret = 3;
             error_report("Sector allocation test failed for %s", filename2);
@@ -1393,10 +1397,12 @@ static int img_compare(int argc, char **argv)
         }
         allocated2 = status2 & BDRV_BLOCK_ALLOCATED;
         if (pnum1) {
-            nb_sectors = MIN(nb_sectors, pnum1);
+            nb_sectors = MIN(nb_sectors,
+                             DIV_ROUND_UP(pnum1, BDRV_SECTOR_SIZE));
         }
         if (pnum2) {
-            nb_sectors = MIN(nb_sectors, pnum2);
+            nb_sectors = MIN(nb_sectors,
+                             DIV_ROUND_UP(pnum2, BDRV_SECTOR_SIZE));
         }

         if (strict) {
@@ -1410,7 +1416,7 @@ static int img_compare(int argc, char **argv)
             }
         }
         if ((status1 & BDRV_BLOCK_ZERO) && (status2 & BDRV_BLOCK_ZERO)) {
-            nb_sectors = MIN(pnum1, pnum2);
+            nb_sectors = DIV_ROUND_UP(MIN(pnum1, pnum2), BDRV_SECTOR_SIZE);
         } else if (allocated1 == allocated2) {
             if (allocated1) {
                 ret = blk_pread(blk1, sector_num << BDRV_SECTOR_BITS, buf1,
@@ -1591,23 +1597,24 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
     n = MIN(s->total_sectors - sector_num, BDRV_REQUEST_MAX_SECTORS);

     if (s->sector_next_status <= sector_num) {
+        int64_t count = n * BDRV_SECTOR_SIZE;
+
         if (s->target_has_backing) {
-            int64_t count = n * BDRV_SECTOR_SIZE;

             ret = bdrv_block_status(blk_bs(s->src[src_cur]),
                                     (sector_num - src_cur_offset) *
                                     BDRV_SECTOR_SIZE,
                                     count, &count, NULL);
-            assert(ret < 0 || QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE));
-            n = count >> BDRV_SECTOR_BITS;
         } else {
-            ret = bdrv_get_block_status_above(blk_bs(s->src[src_cur]), NULL,
-                                              sector_num - src_cur_offset,
-                                              n, &n, NULL);
+            ret = bdrv_block_status_above(blk_bs(s->src[src_cur]), NULL,
+                                          (sector_num - src_cur_offset) *
+                                          BDRV_SECTOR_SIZE,
+                                          count, &count, NULL);
         }
         if (ret < 0) {
             return ret;
         }
+        n = DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);

         if (ret & BDRV_BLOCK_ZERO) {
             s->status = BLK_ZERO;
-- 
2.9.4

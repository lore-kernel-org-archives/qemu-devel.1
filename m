Received: from eggs.gnu.org ([2001:4830:134:3::10]:58846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3P-0000eC-Ct
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3N-00027q-CD
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:35 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:20 +0200
Message-Id: <20171026131741.5059-15-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 14/35] block: Convert
 bdrv_get_block_status_above() to bytes
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

From: Eric Blake <eblake@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  In the common case, allocation is unlikely to ever use
values that are not naturally sector-aligned, but it is possible
that byte-based values will let us be more precise about allocation
at the end of an unaligned file that can do byte-based access.

Changing the name of the function from bdrv_get_block_status_above()
to bdrv_block_status_above() ensures that the compiler enforces that
all callers are updated.  Likewise, since it a byte interface allows
an offset mapping that might not be sector aligned, split the mapping
out of the return value and into a pass-by-reference parameter.  For
now, the io.c layer still assert()s that all uses are sector-aligned,
but that can be relaxed when a later patch implements byte-based
block status in the drivers.

For the most part this patch is just the addition of scaling at the
callers followed by inverse scaling at bdrv_block_status(), plus
updates for the new split return interface.  But some code,
particularly bdrv_block_status(), gets a lot simpler because it no
longer has to mess with sectors.  Likewise, mirror code no longer
computes s->granularity >> BDRV_SECTOR_BITS, and can therefore drop
an assertion about alignment because the loop no longer depends on
alignment (never mind that we don't really have a driver that
reports sub-sector alignments, so it's not really possible to test
the effect of sub-sector mirroring).  Fix a neighboring assertion to
use is_power_of_2 while there.

For ease of review, bdrv_get_block_status() was tackled separately.

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h |  8 +++-----
 block/io.c            | 55 ++++++++-------------------------------------------
 block/mirror.c        | 18 ++++++-----------
 block/qcow2.c         | 30 +++++++++++-----------------
 qemu-img.c            | 49 +++++++++++++++++++++++++--------------------
 5 files changed, 57 insertions(+), 103 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 7ac851f82f..fbc21daf62 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -425,11 +425,9 @@ bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
 int bdrv_block_status(BlockDriverState *bs, int64_t offset,
                       int64_t bytes, int64_t *pnum, int64_t *map,
                       BlockDriverState **file);
-int64_t bdrv_get_block_status_above(BlockDriverState *bs,
-                                    BlockDriverState *base,
-                                    int64_t sector_num,
-                                    int nb_sectors, int *pnum,
-                                    BlockDriverState **file);
+int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
+                            int64_t offset, int64_t bytes, int64_t *pnum,
+                            int64_t *map, BlockDriverState **file);
 int bdrv_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
                       int64_t *pnum);
 int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
diff --git a/block/io.c b/block/io.c
index 61b3477cd1..e64b1cb294 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2016,7 +2016,7 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
     return ret;
 }
 
-/* Coroutine wrapper for bdrv_get_block_status_above() */
+/* Coroutine wrapper for bdrv_block_status_above() */
 static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
 {
     BdrvCoBlockStatusData *data = opaque;
@@ -2064,58 +2064,19 @@ static int bdrv_common_block_status_above(BlockDriverState *bs,
     return data.ret;
 }
 
-int64_t bdrv_get_block_status_above(BlockDriverState *bs,
-                                    BlockDriverState *base,
-                                    int64_t sector_num,
-                                    int nb_sectors, int *pnum,
-                                    BlockDriverState **file)
+int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
+                            int64_t offset, int64_t bytes, int64_t *pnum,
+                            int64_t *map, BlockDriverState **file)
 {
-    int64_t ret;
-    int64_t n;
-    int64_t map;
-
-    ret = bdrv_common_block_status_above(bs, base, true,
-                                         sector_num * BDRV_SECTOR_SIZE,
-                                         nb_sectors * BDRV_SECTOR_SIZE,
-                                         &n, &map, file);
-    if (ret < 0) {
-        *pnum = 0;
-        return ret;
-    }
-    assert(QEMU_IS_ALIGNED(n | map, BDRV_SECTOR_SIZE));
-    *pnum = n >> BDRV_SECTOR_BITS;
-    return ret | map;
+    return bdrv_common_block_status_above(bs, base, true, offset, bytes,
+                                          pnum, map, file);
 }
 
 int bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t bytes,
                       int64_t *pnum, int64_t *map, BlockDriverState **file)
 {
-    int64_t ret;
-    int n;
-
-    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
-    assert(pnum);
-    /*
-     * The contract allows us to return pnum smaller than bytes, even
-     * if the next query would see the same status; we truncate the
-     * request to avoid overflowing the driver's 32-bit interface.
-     */
-    bytes = MIN(bytes, BDRV_REQUEST_MAX_BYTES);
-    ret = bdrv_get_block_status_above(bs, backing_bs(bs),
-                                      offset >> BDRV_SECTOR_BITS,
-                                      bytes >> BDRV_SECTOR_BITS, &n, file);
-    if (ret < 0) {
-        assert(INT_MIN <= ret);
-        *pnum = 0;
-        return ret;
-    }
-    *pnum = n * BDRV_SECTOR_SIZE;
-    if (map) {
-        *map = ret & BDRV_BLOCK_OFFSET_MASK;
-    } else {
-        ret &= ~BDRV_BLOCK_OFFSET_VALID;
-    }
-    return ret & ~BDRV_BLOCK_OFFSET_MASK;
+    return bdrv_block_status_above(bs, backing_bs(bs),
+                                   offset, bytes, pnum, map, file);
 }
 
 int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
diff --git a/block/mirror.c b/block/mirror.c
index d11706c566..307b6391a8 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -328,7 +328,6 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
     uint64_t delay_ns = 0;
     /* At least the first dirty chunk is mirrored in one iteration. */
     int nb_chunks = 1;
-    int sectors_per_chunk = s->granularity >> BDRV_SECTOR_BITS;
     bool write_zeroes_ok = bdrv_can_write_zeroes_with_unmap(blk_bs(s->target));
     int max_io_bytes = MAX(s->buf_size / MAX_IN_FLIGHT, MAX_IO_BYTES);
 
@@ -376,7 +375,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
     }
 
     /* Clear dirty bits before querying the block status, because
-     * calling bdrv_get_block_status_above could yield - if some blocks are
+     * calling bdrv_block_status_above could yield - if some blocks are
      * marked dirty in this window, we need to know.
      */
     bdrv_reset_dirty_bitmap_locked(s->dirty_bitmap, offset,
@@ -385,8 +384,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
 
     bitmap_set(s->in_flight_bitmap, offset / s->granularity, nb_chunks);
     while (nb_chunks > 0 && offset < s->bdev_length) {
-        int64_t ret;
-        int io_sectors;
+        int ret;
         int64_t io_bytes;
         int64_t io_bytes_acct;
         enum MirrorMethod {
@@ -396,11 +394,9 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         } mirror_method = MIRROR_METHOD_COPY;
 
         assert(!(offset % s->granularity));
-        ret = bdrv_get_block_status_above(source, NULL,
-                                          offset >> BDRV_SECTOR_BITS,
-                                          nb_chunks * sectors_per_chunk,
-                                          &io_sectors, NULL);
-        io_bytes = io_sectors * BDRV_SECTOR_SIZE;
+        ret = bdrv_block_status_above(source, NULL, offset,
+                                      nb_chunks * s->granularity,
+                                      &io_bytes, NULL, NULL);
         if (ret < 0) {
             io_bytes = MIN(nb_chunks * s->granularity, max_io_bytes);
         } else if (ret & BDRV_BLOCK_DATA) {
@@ -1131,9 +1127,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         granularity = bdrv_get_default_bitmap_granularity(target);
     }
 
-    assert ((granularity & (granularity - 1)) == 0);
-    /* Granularity must be large enough for sector-based dirty bitmap */
-    assert(granularity >= BDRV_SECTOR_SIZE);
+    assert(is_power_of_2(granularity));
 
     if (buf_size < 0) {
         error_setg(errp, "Invalid parameter 'buf-size'");
diff --git a/block/qcow2.c b/block/qcow2.c
index 795be673e7..29d0a50955 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2974,8 +2974,8 @@ finish:
 
 static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
-    int nr;
-    int64_t res;
+    int64_t nr;
+    int res;
     int64_t start;
 
     /* TODO: Widening to sector boundaries should only be needed as
@@ -2991,10 +2991,8 @@ static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
     if (!bytes) {
         return true;
     }
-    res = bdrv_get_block_status_above(bs, NULL, start >> BDRV_SECTOR_BITS,
-                                      bytes >> BDRV_SECTOR_BITS, &nr, NULL);
-    return res >= 0 && (res & BDRV_BLOCK_ZERO) &&
-        nr * BDRV_SECTOR_SIZE == bytes;
+    res = bdrv_block_status_above(bs, NULL, start, bytes, &nr, NULL, NULL);
+    return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == bytes;
 }
 
 static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
@@ -3700,17 +3698,14 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
             required = virtual_size;
         } else {
             int64_t offset;
-            int pnum = 0;
+            int64_t pnum = 0;
 
-            for (offset = 0; offset < ssize;
-                 offset += pnum * BDRV_SECTOR_SIZE) {
-                int nb_sectors = MIN(ssize - offset,
-                                     BDRV_REQUEST_MAX_BYTES) / BDRV_SECTOR_SIZE;
-                int64_t ret;
+            for (offset = 0; offset < ssize; offset += pnum) {
+                int ret;
 
-                ret = bdrv_get_block_status_above(in_bs, NULL,
-                                                  offset >> BDRV_SECTOR_BITS,
-                                                  nb_sectors, &pnum, NULL);
+                ret = bdrv_block_status_above(in_bs, NULL, offset,
+                                              ssize - offset, &pnum, NULL,
+                                              NULL);
                 if (ret < 0) {
                     error_setg_errno(&local_err, -ret,
                                      "Unable to get block status");
@@ -3722,11 +3717,10 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
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
index c81d6ce733..78c820e487 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1226,7 +1226,7 @@ static int img_compare(int argc, char **argv)
     BlockDriverState *bs1, *bs2;
     int64_t total_sectors1, total_sectors2;
     uint8_t *buf1 = NULL, *buf2 = NULL;
-    int pnum1, pnum2;
+    int64_t pnum1, pnum2;
     int allocated1, allocated2;
     int ret = 0; /* return value - 0 Ident, 1 Different, >1 Error */
     bool progress = false, quiet = false, strict = false;
@@ -1374,15 +1374,17 @@ static int img_compare(int argc, char **argv)
     }
 
     for (;;) {
-        int64_t status1, status2;
+        int status1, status2;
 
         nb_sectors = sectors_to_process(total_sectors, sector_num);
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
+                                          &pnum1, NULL, NULL);
         if (status1 < 0) {
             ret = 3;
             error_report("Sector allocation test failed for %s", filename1);
@@ -1390,25 +1392,29 @@ static int img_compare(int argc, char **argv)
         }
         allocated1 = status1 & BDRV_BLOCK_ALLOCATED;
 
-        status2 = bdrv_get_block_status_above(bs2, NULL, sector_num,
-                                              total_sectors2 - sector_num,
-                                              &pnum2, NULL);
+        status2 = bdrv_block_status_above(bs2, NULL,
+                                          sector_num * BDRV_SECTOR_SIZE,
+                                          (total_sectors2 - sector_num) *
+                                          BDRV_SECTOR_SIZE,
+                                          &pnum2, NULL, NULL);
         if (status2 < 0) {
             ret = 3;
             error_report("Sector allocation test failed for %s", filename2);
             goto out;
         }
         allocated2 = status2 & BDRV_BLOCK_ALLOCATED;
+        /* TODO: Relax this once comparison is byte-based, and we no longer
+         * have to worry about sector alignment */
+        assert(QEMU_IS_ALIGNED(pnum1 | pnum2, BDRV_SECTOR_SIZE));
         if (pnum1) {
-            nb_sectors = MIN(nb_sectors, pnum1);
+            nb_sectors = MIN(nb_sectors, pnum1 >> BDRV_SECTOR_BITS);
         }
         if (pnum2) {
-            nb_sectors = MIN(nb_sectors, pnum2);
+            nb_sectors = MIN(nb_sectors, pnum2 >> BDRV_SECTOR_BITS);
         }
 
         if (strict) {
-            if ((status1 & ~BDRV_BLOCK_OFFSET_MASK) !=
-                (status2 & ~BDRV_BLOCK_OFFSET_MASK)) {
+            if (status1 != status2) {
                 ret = 1;
                 qprintf(quiet, "Strict mode: Offset %" PRId64
                         " block status mismatch!\n",
@@ -1417,7 +1423,7 @@ static int img_compare(int argc, char **argv)
             }
         }
         if ((status1 & BDRV_BLOCK_ZERO) && (status2 & BDRV_BLOCK_ZERO)) {
-            nb_sectors = MIN(pnum1, pnum2);
+            nb_sectors = DIV_ROUND_UP(MIN(pnum1, pnum2), BDRV_SECTOR_SIZE);
         } else if (allocated1 == allocated2) {
             if (allocated1) {
                 ret = blk_pread(blk1, sector_num << BDRV_SECTOR_BITS, buf1,
@@ -1589,8 +1595,8 @@ static void convert_select_part(ImgConvertState *s, int64_t sector_num,
 
 static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
 {
-    int64_t ret, src_cur_offset;
-    int n, src_cur;
+    int64_t src_cur_offset;
+    int ret, n, src_cur;
 
     convert_select_part(s, sector_num, &src_cur, &src_cur_offset);
 
@@ -1598,23 +1604,24 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
     n = MIN(s->total_sectors - sector_num, BDRV_REQUEST_MAX_SECTORS);
 
     if (s->sector_next_status <= sector_num) {
+        int64_t count = n * BDRV_SECTOR_SIZE;
+
         if (s->target_has_backing) {
-            int64_t count = n * BDRV_SECTOR_SIZE;
 
             ret = bdrv_block_status(blk_bs(s->src[src_cur]),
                                     (sector_num - src_cur_offset) *
                                     BDRV_SECTOR_SIZE,
                                     count, &count, NULL, NULL);
-            assert(ret < 0 || QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE));
-            n = count >> BDRV_SECTOR_BITS;
         } else {
-            ret = bdrv_get_block_status_above(blk_bs(s->src[src_cur]), NULL,
-                                              sector_num - src_cur_offset,
-                                              n, &n, NULL);
+            ret = bdrv_block_status_above(blk_bs(s->src[src_cur]), NULL,
+                                          (sector_num - src_cur_offset) *
+                                          BDRV_SECTOR_SIZE,
+                                          count, &count, NULL, NULL);
         }
         if (ret < 0) {
             return ret;
         }
+        n = DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
 
         if (ret & BDRV_BLOCK_ZERO) {
             s->status = BLK_ZERO;
-- 
2.13.6

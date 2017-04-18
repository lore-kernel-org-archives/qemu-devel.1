Received: from eggs.gnu.org ([2001:4830:134:3::10]:34064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I2I-0005Lq-HA
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I2G-0003jZ-PP
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:34:30 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Apr 2017 20:33:35 -0500
Message-Id: <20170418013356.3578-11-eblake@redhat.com>
In-Reply-To: <20170418013356.3578-1-eblake@redhat.com>
References: <20170418013356.3578-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 10/31] block: Convert
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
Cc: qemu-block@nongnu.org, kwolf@nongnu.org, jsnow@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

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
it no longer has to mess with sectors; also, it is now possible to pass
NULL if the caller does not care how much of the image is allocated
beyond the initial offset, or which BDS in the chain owns the sector.

For ease of review, bdrv_get_block_status() was tackled separately.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/block.h | 10 +++++-----
 block/io.c            | 36 +++++++++++-------------------------
 block/mirror.c        | 14 +++++---------
 block/qcow2.c         | 10 +++-------
 qemu-img.c            | 37 +++++++++++++++++++++----------------
 5 files changed, 45 insertions(+), 62 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index b9e7281..8f2b8a2 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -420,11 +420,11 @@ bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
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
index 10bc011..1b101cf 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1842,7 +1842,7 @@ static int64_t coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
     return ret;
 }

-/* Coroutine wrapper for bdrv_get_block_status_above() */
+/* Coroutine wrapper for bdrv_block_status_above() */
 static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
 {
     BdrvCoBlockStatusData *data = opaque;
@@ -1858,21 +1858,19 @@ static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
  *
  * See bdrv_co_block_status_above() for details.
  */
-int64_t bdrv_get_block_status_above(BlockDriverState *bs,
-                                    BlockDriverState *base,
-                                    int64_t sector_num,
-                                    int nb_sectors, int *pnum,
-                                    BlockDriverState **file)
+int64_t bdrv_block_status_above(BlockDriverState *bs,
+                                BlockDriverState *base,
+                                int64_t offset, int64_t bytes, int64_t *pnum,
+                                BlockDriverState **file)
 {
     Coroutine *co;
-    int64_t n;
     BdrvCoBlockStatusData data = {
         .bs = bs,
         .base = base,
         .file = file,
-        .offset = sector_num * BDRV_SECTOR_SIZE,
-        .bytes = nb_sectors * BDRV_SECTOR_SIZE,
-        .pnum = &n,
+        .offset = offset,
+        .bytes = bytes,
+        .pnum = pnum,
         .done = false,
     };

@@ -1884,7 +1882,6 @@ int64_t bdrv_get_block_status_above(BlockDriverState *bs,
         bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, !data.done);
     }
-    *pnum = n >> BDRV_SECTOR_BITS;
     return data.ret;
 }

@@ -1892,27 +1889,16 @@ int64_t bdrv_block_status(BlockDriverState *bs,
                           int64_t offset, int64_t bytes, int64_t *pnum,
                           BlockDriverState **file)
 {
-    int64_t ret;
-    int n;
-
-    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
-    assert(bytes <= BDRV_REQUEST_MAX_BYTES);
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
                                    int64_t bytes, int64_t *pnum)
 {
-    BlockDriverState *file;
     int64_t ret;

-    ret = bdrv_block_status(bs, offset, bytes, pnum, &file);
+    ret = bdrv_block_status(bs, offset, bytes, pnum, NULL);
     if (ret < 0) {
         return ret;
     }
diff --git a/block/mirror.c b/block/mirror.c
index 2510793..750be1f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -328,7 +328,6 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
     uint64_t delay_ns = 0;
     /* At least the first dirty chunk is mirrored in one iteration. */
     int nb_chunks = 1;
-    int sectors_per_chunk = s->granularity >> BDRV_SECTOR_BITS;
     bool write_zeroes_ok = bdrv_can_write_zeroes_with_unmap(blk_bs(s->target));
     int max_io_bytes = MAX(s->buf_size / MAX_IN_FLIGHT, MAX_IO_BYTES);

@@ -374,7 +373,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
     }

     /* Clear dirty bits before querying the block status, because
-     * calling bdrv_get_block_status_above could yield - if some blocks are
+     * calling bdrv_block_status_above could yield - if some blocks are
      * marked dirty in this window, we need to know.
      */
     bdrv_reset_dirty_bitmap(s->dirty_bitmap, offset,
@@ -382,10 +381,8 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
     bitmap_set(s->in_flight_bitmap, offset / s->granularity, nb_chunks);
     while (nb_chunks > 0 && offset < s->bdev_length) {
         int64_t ret;
-        int io_sectors;
         int64_t io_bytes;
         int64_t io_bytes_acct;
-        BlockDriverState *file;
         enum MirrorMethod {
             MIRROR_METHOD_COPY,
             MIRROR_METHOD_ZERO,
@@ -393,11 +390,10 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         } mirror_method = MIRROR_METHOD_COPY;

         assert(!(offset % s->granularity));
-        ret = bdrv_get_block_status_above(source, NULL,
-                                          offset >> BDRV_SECTOR_BITS,
-                                          nb_chunks * sectors_per_chunk,
-                                          &io_sectors, &file);
-        io_bytes = io_sectors * BDRV_SECTOR_SIZE;
+        ret = bdrv_block_status_above(source, NULL,
+                                      offset,
+                                      nb_chunks * s->granularity,
+                                      &io_bytes, NULL);
         if (ret < 0) {
             io_bytes = MIN(nb_chunks * s->granularity, max_io_bytes);
         } else if (ret & BDRV_BLOCK_DATA) {
diff --git a/block/qcow2.c b/block/qcow2.c
index fe4ccf6..4272cca 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2444,8 +2444,7 @@ finish:

 static bool is_zero_above(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
-    int nr;
-    BlockDriverState *file;
+    int64_t nr;
     int64_t res;
     int64_t start;

@@ -2461,11 +2460,8 @@ static bool is_zero_above(BlockDriverState *bs, int64_t offset, int64_t bytes)
     if (!bytes) {
         return true;
     }
-    res = bdrv_get_block_status_above(bs, NULL, start >> BDRV_SECTOR_BITS,
-                                      bytes >> BDRV_SECTOR_BITS,
-                                      &nr, &file);
-    return res >= 0 && (res & BDRV_BLOCK_ZERO) &&
-        nr * BDRV_SECTOR_SIZE == bytes;
+    res = bdrv_block_status_above(bs, NULL, start, bytes, &nr, NULL);
+    return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == bytes;
 }

 static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
diff --git a/qemu-img.c b/qemu-img.c
index 7ed77d5..2fbd956 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1194,7 +1194,7 @@ static int img_compare(int argc, char **argv)
     BlockDriverState *bs1, *bs2;
     int64_t total_sectors1, total_sectors2;
     uint8_t *buf1 = NULL, *buf2 = NULL;
-    int pnum1, pnum2;
+    int64_t pnum1, pnum2;
     int allocated1, allocated2;
     int ret = 0; /* return value - 0 Ident, 1 Different, >1 Error */
     bool progress = false, quiet = false, strict = false;
@@ -1336,15 +1336,16 @@ static int img_compare(int argc, char **argv)

     for (;;) {
         int64_t status1, status2;
-        BlockDriverState *file;

         nb_sectors = sectors_to_process(total_sectors, sector_num);
         if (nb_sectors <= 0) {
             break;
         }
-        status1 = bdrv_get_block_status_above(bs1, NULL, sector_num,
-                                              total_sectors1 - sector_num,
-                                              &pnum1, &file);
+        status1 = bdrv_block_status_above(bs1, NULL,
+                                          sector_num * BDRV_SECTOR_SIZE,
+                                          (total_sectors1 - sector_num) *
+                                          BDRV_SECTOR_SIZE,
+                                          &pnum1, NULL);
         if (status1 < 0) {
             ret = 3;
             error_report("Sector allocation test failed for %s", filename1);
@@ -1352,9 +1353,11 @@ static int img_compare(int argc, char **argv)
         }
         allocated1 = status1 & BDRV_BLOCK_ALLOCATED;

-        status2 = bdrv_get_block_status_above(bs2, NULL, sector_num,
-                                              total_sectors2 - sector_num,
-                                              &pnum2, &file);
+        status2 = bdrv_block_status_above(bs2, NULL,
+                                          sector_num * BDRV_SECTOR_SIZE,
+                                          (total_sectors2 - sector_num) *
+                                          BDRV_SECTOR_SIZE,
+                                          &pnum2, NULL);
         if (status2 < 0) {
             ret = 3;
             error_report("Sector allocation test failed for %s", filename2);
@@ -1362,10 +1365,10 @@ static int img_compare(int argc, char **argv)
         }
         allocated2 = status2 & BDRV_BLOCK_ALLOCATED;
         if (pnum1) {
-            nb_sectors = MIN(nb_sectors, pnum1);
+            nb_sectors = MIN(nb_sectors, pnum1 >> BDRV_SECTOR_BITS);
         }
         if (pnum2) {
-            nb_sectors = MIN(nb_sectors, pnum2);
+            nb_sectors = MIN(nb_sectors, pnum2 >> BDRV_SECTOR_BITS);
         }

         if (strict) {
@@ -1379,7 +1382,7 @@ static int img_compare(int argc, char **argv)
             }
         }
         if ((status1 & BDRV_BLOCK_ZERO) && (status2 & BDRV_BLOCK_ZERO)) {
-            nb_sectors = MIN(pnum1, pnum2);
+            nb_sectors = MIN(pnum1, pnum2) >> BDRV_SECTOR_BITS;
         } else if (allocated1 == allocated2) {
             if (allocated1) {
                 ret = blk_pread(blk1, sector_num << BDRV_SECTOR_BITS, buf1,
@@ -1557,12 +1560,11 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
     n = MIN(s->total_sectors - sector_num, BDRV_REQUEST_MAX_SECTORS);

     if (s->sector_next_status <= sector_num) {
-        BlockDriverState *file;
         int64_t count = n * BDRV_SECTOR_SIZE;

         ret = bdrv_block_status(blk_bs(s->src[src_cur]),
                                 (sector_num - src_cur_offset) * BDRV_SECTOR_SIZE,
-                                count, &count, &file);
+                                count, &count, NULL);
         if (ret < 0) {
             return ret;
         }
@@ -1579,9 +1581,12 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
             /* Check block status of the backing file chain to avoid
              * needlessly reading zeroes and limiting the iteration to the
              * buffer size */
-            ret = bdrv_get_block_status_above(blk_bs(s->src[src_cur]), NULL,
-                                              sector_num - src_cur_offset,
-                                              n, &n, &file);
+            ret = bdrv_block_status_above(blk_bs(s->src[src_cur]), NULL,
+                                          (sector_num - src_cur_offset) *
+                                          BDRV_SECTOR_SIZE,
+                                          n * BDRV_SECTOR_SIZE, &count, NULL);
+            assert(QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE));
+            n = count >> BDRV_SECTOR_BITS;
             if (ret < 0) {
                 return ret;
             }
-- 
2.9.3

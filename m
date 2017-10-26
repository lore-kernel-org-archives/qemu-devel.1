Received: from eggs.gnu.org ([2001:4830:134:3::10]:58639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i34-0000LK-M6
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i33-0001qD-0D
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:14 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:15 +0200
Message-Id: <20171026131741.5059-10-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/35] block: Convert bdrv_get_block_status() to
 bytes
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

Changing the name of the function from bdrv_get_block_status() to
bdrv_block_status() ensures that the compiler enforces that all
callers are updated.  For now, the io.c layer still assert()s that
all callers are sector-aligned, but that can be relaxed when a later
patch implements byte-based block status in the drivers.

There was an inherent limitation in returning the offset via the
return value: we only have room for BDRV_BLOCK_OFFSET_MASK bits, which
means an offset can only be mapped for sector-aligned queries (or,
if we declare that non-aligned input is at the same relative position
modulo 512 of the answer), so the new interface also changes things to
return the offset via output through a parameter by reference rather
than mashed into the return value.  We'll have some glue code that
munges between the two styles until we finish converting all uses.

For the most part this patch is just the addition of scaling at the
callers followed by inverse scaling at bdrv_block_status(), coupled
with the tweak in calling convention.  But some code, particularly
bdrv_is_allocated(), gets a lot simpler because it no longer has to
mess with sectors.

For ease of review, bdrv_get_block_status_above() will be tackled
separately.

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h | 17 +++++++++--------
 block/io.c            | 47 ++++++++++++++++++++++++++++++++++-------------
 block/qcow2-cluster.c |  2 +-
 qemu-img.c            | 25 ++++++++++++++-----------
 4 files changed, 58 insertions(+), 33 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 440f3e9e39..7ac851f82f 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -121,7 +121,7 @@ typedef struct HDGeometry {
 #define BDRV_REQUEST_MAX_BYTES (BDRV_REQUEST_MAX_SECTORS << BDRV_SECTOR_BITS)
 
 /*
- * Allocation status flags for bdrv_get_block_status() and friends.
+ * Allocation status flags for bdrv_block_status() and friends.
  *
  * Public flags:
  * BDRV_BLOCK_DATA: allocation for data at offset is tied to this layer
@@ -136,10 +136,11 @@ typedef struct HDGeometry {
  *                 that the block layer recompute the answer from the returned
  *                 BDS; must be accompanied by just BDRV_BLOCK_OFFSET_VALID.
  *
- * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 (BDRV_BLOCK_OFFSET_MASK)
- * represent the offset in the returned BDS that is allocated for the
- * corresponding raw data; however, whether that offset actually contains
- * data also depends on BDRV_BLOCK_DATA and BDRV_BLOCK_ZERO, as follows:
+ * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 (BDRV_BLOCK_OFFSET_MASK) of
+ * the return value (old interface) or the entire map parameter (new
+ * interface) represent the offset in the returned BDS that is allocated for
+ * the corresponding raw data.  However, whether that offset actually
+ * contains data also depends on BDRV_BLOCK_DATA, as follows:
  *
  * DATA ZERO OFFSET_VALID
  *  t    t        t       sectors read as zero, returned file is zero at offset
@@ -421,9 +422,9 @@ int bdrv_has_zero_init_1(BlockDriverState *bs);
 int bdrv_has_zero_init(BlockDriverState *bs);
 bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
-int64_t bdrv_get_block_status(BlockDriverState *bs, int64_t sector_num,
-                              int nb_sectors, int *pnum,
-                              BlockDriverState **file);
+int bdrv_block_status(BlockDriverState *bs, int64_t offset,
+                      int64_t bytes, int64_t *pnum, int64_t *map,
+                      BlockDriverState **file);
 int64_t bdrv_get_block_status_above(BlockDriverState *bs,
                                     BlockDriverState *base,
                                     int64_t sector_num,
diff --git a/block/io.c b/block/io.c
index ad84d84888..890d3c073b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -716,9 +716,9 @@ int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
  */
 int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
 {
-    int64_t target_size, ret, bytes, offset = 0;
+    int ret;
+    int64_t target_size, bytes, offset = 0;
     BlockDriverState *bs = child->bs;
-    int n; /* sectors */
 
     target_size = bdrv_getlength(bs);
     if (target_size < 0) {
@@ -730,24 +730,23 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
         if (bytes <= 0) {
             return 0;
         }
-        ret = bdrv_get_block_status(bs, offset >> BDRV_SECTOR_BITS,
-                                    bytes >> BDRV_SECTOR_BITS, &n, NULL);
+        ret = bdrv_block_status(bs, offset, bytes, &bytes, NULL, NULL);
         if (ret < 0) {
             error_report("error getting block status at offset %" PRId64 ": %s",
                          offset, strerror(-ret));
             return ret;
         }
         if (ret & BDRV_BLOCK_ZERO) {
-            offset += n * BDRV_SECTOR_BITS;
+            offset += bytes;
             continue;
         }
-        ret = bdrv_pwrite_zeroes(child, offset, n * BDRV_SECTOR_SIZE, flags);
+        ret = bdrv_pwrite_zeroes(child, offset, bytes, flags);
         if (ret < 0) {
             error_report("error writing zeroes at offset %" PRId64 ": %s",
                          offset, strerror(-ret));
             return ret;
         }
-        offset += n * BDRV_SECTOR_SIZE;
+        offset += bytes;
     }
 }
 
@@ -2045,13 +2044,35 @@ int64_t bdrv_get_block_status_above(BlockDriverState *bs,
                                           nb_sectors, pnum, file);
 }
 
-int64_t bdrv_get_block_status(BlockDriverState *bs,
-                              int64_t sector_num,
-                              int nb_sectors, int *pnum,
-                              BlockDriverState **file)
+int bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                      int64_t *pnum, int64_t *map, BlockDriverState **file)
 {
-    return bdrv_get_block_status_above(bs, backing_bs(bs),
-                                       sector_num, nb_sectors, pnum, file);
+    int64_t ret;
+    int n;
+
+    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
+    assert(pnum);
+    /*
+     * The contract allows us to return pnum smaller than bytes, even
+     * if the next query would see the same status; we truncate the
+     * request to avoid overflowing the driver's 32-bit interface.
+     */
+    bytes = MIN(bytes, BDRV_REQUEST_MAX_BYTES);
+    ret = bdrv_get_block_status_above(bs, backing_bs(bs),
+                                      offset >> BDRV_SECTOR_BITS,
+                                      bytes >> BDRV_SECTOR_BITS, &n, file);
+    if (ret < 0) {
+        assert(INT_MIN <= ret);
+        *pnum = 0;
+        return ret;
+    }
+    *pnum = n * BDRV_SECTOR_SIZE;
+    if (map) {
+        *map = ret & BDRV_BLOCK_OFFSET_MASK;
+    } else {
+        ret &= ~BDRV_BLOCK_OFFSET_VALID;
+    }
+    return ret & ~BDRV_BLOCK_OFFSET_MASK;
 }
 
 int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 0e5aec81cb..fb10e26068 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1632,7 +1632,7 @@ static int discard_single_l2(BlockDriverState *bs, uint64_t offset,
          * cluster is already marked as zero, or if it's unallocated and we
          * don't have a backing file.
          *
-         * TODO We might want to use bdrv_get_block_status(bs) here, but we're
+         * TODO We might want to use bdrv_block_status(bs) here, but we're
          * holding s->lock, so that doesn't work today.
          *
          * If full_discard is true, the sector should not read back as zeroes,
diff --git a/qemu-img.c b/qemu-img.c
index af3effdec5..c81d6ce733 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1599,9 +1599,14 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
 
     if (s->sector_next_status <= sector_num) {
         if (s->target_has_backing) {
-            ret = bdrv_get_block_status(blk_bs(s->src[src_cur]),
-                                        sector_num - src_cur_offset,
-                                        n, &n, NULL);
+            int64_t count = n * BDRV_SECTOR_SIZE;
+
+            ret = bdrv_block_status(blk_bs(s->src[src_cur]),
+                                    (sector_num - src_cur_offset) *
+                                    BDRV_SECTOR_SIZE,
+                                    count, &count, NULL, NULL);
+            assert(ret < 0 || QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE));
+            n = count >> BDRV_SECTOR_BITS;
         } else {
             ret = bdrv_get_block_status_above(blk_bs(s->src[src_cur]), NULL,
                                               sector_num - src_cur_offset,
@@ -2674,13 +2679,12 @@ static void dump_map_entry(OutputFormat output_format, MapEntry *e,
 static int get_block_status(BlockDriverState *bs, int64_t offset,
                             int64_t bytes, MapEntry *e)
 {
-    int64_t ret;
+    int ret;
     int depth;
     BlockDriverState *file;
     bool has_offset;
-    int nb_sectors = bytes >> BDRV_SECTOR_BITS;
+    int64_t map;
 
-    assert(bytes < INT_MAX);
     /* As an optimization, we could cache the current range of unallocated
      * clusters in each file of the chain, and avoid querying the same
      * range repeatedly.
@@ -2688,12 +2692,11 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,
 
     depth = 0;
     for (;;) {
-        ret = bdrv_get_block_status(bs, offset >> BDRV_SECTOR_BITS, nb_sectors,
-                                    &nb_sectors, &file);
+        ret = bdrv_block_status(bs, offset, bytes, &bytes, &map, &file);
         if (ret < 0) {
             return ret;
         }
-        assert(nb_sectors);
+        assert(bytes);
         if (ret & (BDRV_BLOCK_ZERO|BDRV_BLOCK_DATA)) {
             break;
         }
@@ -2710,10 +2713,10 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,
 
     *e = (MapEntry) {
         .start = offset,
-        .length = nb_sectors * BDRV_SECTOR_SIZE,
+        .length = bytes,
         .data = !!(ret & BDRV_BLOCK_DATA),
         .zero = !!(ret & BDRV_BLOCK_ZERO),
-        .offset = ret & BDRV_BLOCK_OFFSET_MASK,
+        .offset = map,
         .has_offset = has_offset,
         .depth = depth,
         .has_filename = file && has_offset,
-- 
2.13.6

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I27-00059U-0k
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I25-0003er-EK
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:34:19 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Apr 2017 20:33:31 -0500
Message-Id: <20170418013356.3578-7-eblake@redhat.com>
In-Reply-To: <20170418013356.3578-1-eblake@redhat.com>
References: <20170418013356.3578-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 06/31] block: Convert bdrv_get_block_status()
 to bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@nongnu.org, jsnow@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

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

Note that we have an inherent limitation in the BDRV_BLOCK_* return
values: BDRV_BLOCK_OFFSET_VALID can only return the start of a
sector, even if we later relax the interface to query for the status
starting at an intermediate byte; document the obvious interpretation
that valid offsets are always sector-relative.

Therefore, for the most part this patch is just the addition of scaling
at the callers followed by inverse scaling at bdrv_block_status().  But
some code, particularly bdrv_is_allocated(), gets a lot simpler because
it no longer has to mess with sectors; also, it is now possible to pass
NULL if the caller does not care how much of the image is allocated
beyond the initial offset.

For ease of review, bdrv_get_block_status_above() will be tackled
separately.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/block.h | 15 +++++++++------
 block/io.c            | 51 ++++++++++++++++++++++++++-------------------------
 block/qcow2-cluster.c |  2 +-
 qemu-img.c            | 19 ++++++++++---------
 4 files changed, 46 insertions(+), 41 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index eed1330..b9e7281 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -121,10 +121,10 @@ typedef struct HDGeometry {

 /*
  * Allocation status flags
- * BDRV_BLOCK_DATA: data is read from a file returned by bdrv_get_block_status.
+ * BDRV_BLOCK_DATA: data is read from a file returned by bdrv_block_status.
  * BDRV_BLOCK_ZERO: sectors read as zero
  * BDRV_BLOCK_OFFSET_VALID: sector stored as raw data in a file returned by
- *                          bdrv_get_block_status.
+ *                          bdrv_block_status.
  * BDRV_BLOCK_ALLOCATED: the content of the block is determined by this
  *                       layer (as opposed to the backing file)
  * BDRV_BLOCK_RAW: used internally to indicate that the request
@@ -132,7 +132,10 @@ typedef struct HDGeometry {
  *                 should look in bs->file directly.
  *
  * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 represent the offset in
- * bs->file where sector data can be read from as raw data.
+ * bs->file that begins the sector containing the address in question,
+ * where the sector can be read from as raw data with individual bytes
+ * at the same sector-relative locations (and thus, this bit cannot be
+ * set for mappings which are not equivalent modulo 512).
  *
  * DATA == 0 && ZERO == 0 means that data is read from backing_hd if present.
  *
@@ -414,9 +417,9 @@ int bdrv_has_zero_init_1(BlockDriverState *bs);
 int bdrv_has_zero_init(BlockDriverState *bs);
 bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
-int64_t bdrv_get_block_status(BlockDriverState *bs, int64_t sector_num,
-                              int nb_sectors, int *pnum,
-                              BlockDriverState **file);
+int64_t bdrv_block_status(BlockDriverState *bs, int64_t offset,
+                          int64_t bytes, int64_t *pnum,
+                          BlockDriverState **file);
 int64_t bdrv_get_block_status_above(BlockDriverState *bs,
                                     BlockDriverState *base,
                                     int64_t sector_num,
diff --git a/block/io.c b/block/io.c
index 1f8ae81..5cdb1f0 100644
--- a/block/io.c
+++ b/block/io.c
@@ -669,7 +669,6 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
     int64_t target_size, ret, bytes, offset = 0;
     BlockDriverState *bs = child->bs;
     BlockDriverState *file;
-    int n; /* sectors */

     target_size = bdrv_getlength(bs);
     if (target_size < 0) {
@@ -681,24 +680,23 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
         if (bytes <= 0) {
             return 0;
         }
-        ret = bdrv_get_block_status(bs, offset >> BDRV_SECTOR_BITS,
-                                    bytes >> BDRV_SECTOR_BITS, &n, &file);
+        ret = bdrv_block_status(bs, offset, bytes, &bytes, &file);
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

@@ -1754,9 +1752,13 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
     }

     if (ret & BDRV_BLOCK_RAW) {
+        int64_t bytes = *pnum * BDRV_SECTOR_SIZE;
+
         assert(ret & BDRV_BLOCK_OFFSET_VALID);
-        ret = bdrv_get_block_status(*file, ret >> BDRV_SECTOR_BITS,
-                                    *pnum, pnum, file);
+        ret = bdrv_block_status(*file, ret & BDRV_BLOCK_OFFSET_MASK,
+                                bytes, &bytes, file);
+        assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
+        *pnum = bytes >> BDRV_SECTOR_BITS;
         goto out;
     }

@@ -1874,35 +1876,34 @@ int64_t bdrv_get_block_status_above(BlockDriverState *bs,
     return data.ret;
 }

-int64_t bdrv_get_block_status(BlockDriverState *bs,
-                              int64_t sector_num,
-                              int nb_sectors, int *pnum,
-                              BlockDriverState **file)
+int64_t bdrv_block_status(BlockDriverState *bs,
+                          int64_t offset, int64_t bytes, int64_t *pnum,
+                          BlockDriverState **file)
 {
-    return bdrv_get_block_status_above(bs, backing_bs(bs),
-                                       sector_num, nb_sectors, pnum, file);
+    int64_t ret;
+    int n;
+
+    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
+    assert(bytes <= BDRV_REQUEST_MAX_BYTES);
+    ret = bdrv_get_block_status_above(bs, backing_bs(bs),
+                                      offset >> BDRV_SECTOR_BITS,
+                                      bytes >> BDRV_SECTOR_BITS, &n, file);
+    if (pnum) {
+        *pnum = n * BDRV_SECTOR_SIZE;
+    }
+    return ret;
 }

 int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
                                    int64_t bytes, int64_t *pnum)
 {
     BlockDriverState *file;
-    int64_t sector_num = offset >> BDRV_SECTOR_BITS;
-    int nb_sectors = bytes >> BDRV_SECTOR_BITS;
     int64_t ret;
-    int psectors;

-    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
-    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE) &&
-           bytes < INT_MAX * BDRV_SECTOR_SIZE);
-    ret = bdrv_get_block_status(bs, sector_num, nb_sectors, &psectors,
-                                &file);
+    ret = bdrv_block_status(bs, offset, bytes, pnum, &file);
     if (ret < 0) {
         return ret;
     }
-    if (pnum) {
-        *pnum = psectors * BDRV_SECTOR_SIZE;
-    }
     return !!(ret & BDRV_BLOCK_ALLOCATED);
 }

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index bc59cb8..e5feb89 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1465,7 +1465,7 @@ static int discard_single_l2(BlockDriverState *bs, uint64_t offset,
          * cluster is already marked as zero, or if it's unallocated and we
          * don't have a backing file.
          *
-         * TODO We might want to use bdrv_get_block_status(bs) here, but we're
+         * TODO We might want to use bdrv_block_status(bs) here, but we're
          * holding s->lock, so that doesn't work today.
          *
          * If full_discard is true, the sector should not read back as zeroes,
diff --git a/qemu-img.c b/qemu-img.c
index 8cb5165..7ed77d5 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1558,12 +1558,16 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)

     if (s->sector_next_status <= sector_num) {
         BlockDriverState *file;
-        ret = bdrv_get_block_status(blk_bs(s->src[src_cur]),
-                                    sector_num - src_cur_offset,
-                                    n, &n, &file);
+        int64_t count = n * BDRV_SECTOR_SIZE;
+
+        ret = bdrv_block_status(blk_bs(s->src[src_cur]),
+                                (sector_num - src_cur_offset) * BDRV_SECTOR_SIZE,
+                                count, &count, &file);
         if (ret < 0) {
             return ret;
         }
+        assert(QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE));
+        n = count >> BDRV_SECTOR_BITS;

         if (ret & BDRV_BLOCK_ZERO) {
             s->status = BLK_ZERO;
@@ -2669,9 +2673,7 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,
     int depth;
     BlockDriverState *file;
     bool has_offset;
-    int nb_sectors = bytes >> BDRV_SECTOR_BITS;

-    assert(bytes < INT_MAX);
     /* As an optimization, we could cache the current range of unallocated
      * clusters in each file of the chain, and avoid querying the same
      * range repeatedly.
@@ -2679,12 +2681,11 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,

     depth = 0;
     for (;;) {
-        ret = bdrv_get_block_status(bs, offset >> BDRV_SECTOR_BITS, nb_sectors,
-                                    &nb_sectors, &file);
+        ret = bdrv_block_status(bs, offset, bytes, &bytes, &file);
         if (ret < 0) {
             return ret;
         }
-        assert(nb_sectors);
+        assert(bytes);
         if (ret & (BDRV_BLOCK_ZERO|BDRV_BLOCK_DATA)) {
             break;
         }
@@ -2701,7 +2702,7 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,

     *e = (MapEntry) {
         .start = offset,
-        .length = nb_sectors * BDRV_SECTOR_SIZE,
+        .length = bytes,
         .data = !!(ret & BDRV_BLOCK_DATA),
         .zero = !!(ret & BDRV_BLOCK_ZERO),
         .offset = ret & BDRV_BLOCK_OFFSET_MASK,
-- 
2.9.3

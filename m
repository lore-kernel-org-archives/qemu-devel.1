Received: from eggs.gnu.org ([2001:4830:134:3::10]:55942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9cx-0007fQ-K9
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9cw-0004d1-8G
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:31 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Jul 2017 17:14:49 -0500
Message-Id: <20170703221456.30817-9-eblake@redhat.com>
In-Reply-To: <20170703221456.30817-1-eblake@redhat.com>
References: <20170703221456.30817-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/15] block: Convert
 bdrv_get_block_status() to bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

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
it no longer has to mess with sectors.

For ease of review, bdrv_get_block_status_above() will be tackled
separately.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: rebase to earlier changes
---
 include/block/block.h | 12 +++++++-----
 block/io.c            | 31 +++++++++++++++++++------------
 block/qcow2-cluster.c |  2 +-
 qemu-img.c            | 20 +++++++++++---------
 4 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index cc82a0d..e3e6582 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -138,8 +138,10 @@ typedef struct HDGeometry {
  *
  * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 (BDRV_BLOCK_OFFSET_MASK)
  * represent the offset in the returned BDS that is allocated for the
- * corresponding raw data; however, whether that offset actually contains
- * data also depends on BDRV_BLOCK_DATA and BDRV_BLOCK_ZERO, as follows:
+ * corresponding raw data.  Individual bytes are at the same sector-relative
+ * locations (and thus, this bit cannot be set for mappings which are
+ * not equivalent modulo 512).  However, whether that offset actually
+ * contains data also depends on BDRV_BLOCK_DATA, as follows:
  *
  * DATA ZERO OFFSET_VALID
  *  t    t        t       sectors read as zero, returned file is zero at offset
@@ -419,9 +421,9 @@ int bdrv_has_zero_init_1(BlockDriverState *bs);
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
index b3ba9af..2662f37 100644
--- a/block/io.c
+++ b/block/io.c
@@ -671,7 +671,6 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
 {
     int64_t target_size, ret, bytes, offset = 0;
     BlockDriverState *bs = child->bs;
-    int n; /* sectors */

     target_size = bdrv_getlength(bs);
     if (target_size < 0) {
@@ -683,24 +682,23 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
         if (bytes <= 0) {
             return 0;
         }
-        ret = bdrv_get_block_status(bs, offset >> BDRV_SECTOR_BITS,
-                                    bytes >> BDRV_SECTOR_BITS, &n, NULL);
+        ret = bdrv_block_status(bs, offset, bytes, &bytes, NULL);
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

@@ -1956,13 +1954,22 @@ int64_t bdrv_get_block_status_above(BlockDriverState *bs,
                                           nb_sectors, pnum, file);
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
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f06c08f..0185986 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1567,7 +1567,7 @@ static int discard_single_l2(BlockDriverState *bs, uint64_t offset,
          * cluster is already marked as zero, or if it's unallocated and we
          * don't have a backing file.
          *
-         * TODO We might want to use bdrv_get_block_status(bs) here, but we're
+         * TODO We might want to use bdrv_block_status(bs) here, but we're
          * holding s->lock, so that doesn't work today.
          *
          * If full_discard is true, the sector should not read back as zeroes,
diff --git a/qemu-img.c b/qemu-img.c
index 7b7f992..2b1422a 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1594,9 +1594,14 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)

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
+                                    count, &count, NULL);
+            assert(ret < 0 || QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE));
+            n = count >> BDRV_SECTOR_BITS;
         } else {
             ret = bdrv_get_block_status_above(blk_bs(s->src[src_cur]), NULL,
                                               sector_num - src_cur_offset,
@@ -2681,9 +2686,7 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,
     int depth;
     BlockDriverState *file;
     bool has_offset;
-    int nb_sectors = bytes >> BDRV_SECTOR_BITS;

-    assert(bytes < INT_MAX);
     /* As an optimization, we could cache the current range of unallocated
      * clusters in each file of the chain, and avoid querying the same
      * range repeatedly.
@@ -2691,12 +2694,11 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,

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
@@ -2713,7 +2715,7 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,

     *e = (MapEntry) {
         .start = offset,
-        .length = nb_sectors * BDRV_SECTOR_SIZE,
+        .length = bytes,
         .data = !!(ret & BDRV_BLOCK_DATA),
         .zero = !!(ret & BDRV_BLOCK_ZERO),
         .offset = ret & BDRV_BLOCK_OFFSET_MASK,
-- 
2.9.4

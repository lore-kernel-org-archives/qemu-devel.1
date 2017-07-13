Received: from eggs.gnu.org ([2001:4830:134:3::10]:54689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVgMT-00079J-K1
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:49:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVgMS-0006Y6-6I
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:49:05 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 13 Jul 2017 10:47:09 -0500
Message-Id: <20170713154711.32374-22-eblake@redhat.com>
In-Reply-To: <20170713154711.32374-1-eblake@redhat.com>
References: <20170713154711.32374-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 21/23] block: Align block status requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Any device that has request_alignment greater than 512 should be
unable to report status at a finer granularity; it may also be
simpler for such devices to be guaranteed that the block layer
has rounded things out to the granularity boundary (the way the
block layer already rounds all other I/O out).  Besides, getting
the code correct for super-sector alignment also benefits us
for the fact that our public interface now has byte granularity,
even though none of our drivers have byte-level callbacks.

Add an assertion in blkdebug that proves that the block layer
never requests status of unaligned sections, similar to what it
does on other requests (while still keeping the generic helper
in place for when future patches add a throttle driver).  Note
that iotest 177 already covers this (it would fail if you use
just the blkdebug.c hunk without the io.c changes).  Meanwhile,
we can drop assertions in callers that no longer have to pass
in sector-aligned addresses.

There is a mid-function scope added for 'int count', for a
couple of reasons: first, an upcoming patch will add an 'if'
statement that checks whether a driver has an old- or new-style
callback, and can conveniently use the same scope for less
indentation churn at that time.  Second, since we are trying
to get rid of sector-based computations, wrapping things in
a scope makes it easier to group and see what will be deleted
in a final cleanup patch once all drivers have been converted
to the new-style callback.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v3: tweak commit message [Fam], rebase to context conflicts, ensure
we don't exceed 32-bit limit, drop R-b
v2: new patch
---
 include/block/block_int.h |  3 ++-
 block/io.c                | 55 +++++++++++++++++++++++++++++++----------------
 block/blkdebug.c          | 13 ++++++++++-
 3 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 3b4977d..f2c1da7 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -177,7 +177,8 @@ struct BlockDriver {
      * according to the current layer, and should not set
      * BDRV_BLOCK_ALLOCATED, but may set BDRV_BLOCK_RAW.  See block.h
      * for the meaning of _DATA, _ZERO, and _OFFSET_VALID.  The block
-     * layer guarantees non-NULL pnum and file.
+     * layer guarantees input aligned to request_alignment, as well as
+     * non-NULL pnum and file.
      */
     int64_t coroutine_fn (*bdrv_co_get_block_status)(BlockDriverState *bs,
         int64_t sector_num, int nb_sectors, int *pnum,
diff --git a/block/io.c b/block/io.c
index 1f59d42..df692d2 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1749,7 +1749,8 @@ static int64_t coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
     int64_t n; /* bytes */
     int64_t ret, ret2;
     BlockDriverState *local_file = NULL;
-    int count; /* sectors */
+    int64_t aligned_offset, aligned_bytes;
+    uint32_t align;

     assert(pnum);
     total_size = bdrv_getlength(bs);
@@ -1791,28 +1792,45 @@ static int64_t coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
     }

     bdrv_inc_in_flight(bs);
-    /*
-     * TODO: Rather than require aligned offsets, we could instead
-     * round to the driver's request_alignment here, then touch up
-     * count afterwards back to the caller's expectations.
-     */
-    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
-    bytes = MIN(bytes, BDRV_REQUEST_MAX_BYTES);
-    ret = bs->drv->bdrv_co_get_block_status(bs, offset >> BDRV_SECTOR_BITS,
-                                            bytes >> BDRV_SECTOR_BITS, &count,
-                                            &local_file);
-    if (ret < 0) {
-        *pnum = 0;
-        goto out;
+
+    /* Round out to request_alignment boundaries */
+    align = MAX(bs->bl.request_alignment, BDRV_SECTOR_SIZE);
+    aligned_offset = QEMU_ALIGN_DOWN(offset, align);
+    aligned_bytes = ROUND_UP(offset + bytes, align) - aligned_offset;
+
+    {
+        int count; /* sectors */
+
+        assert(QEMU_IS_ALIGNED(aligned_offset | aligned_bytes,
+                               BDRV_SECTOR_SIZE));
+        ret = bs->drv->bdrv_co_get_block_status(
+            bs, aligned_offset >> BDRV_SECTOR_BITS,
+            MIN(INT_MAX, aligned_bytes) >> BDRV_SECTOR_BITS, &count,
+            &local_file);
+        if (ret < 0) {
+            *pnum = 0;
+            goto out;
+        }
+        *pnum = count * BDRV_SECTOR_SIZE;
+    }
+
+    /* Clamp pnum and ret to original request */
+    assert(QEMU_IS_ALIGNED(*pnum, align));
+    *pnum -= offset - aligned_offset;
+    if (aligned_offset >> BDRV_SECTOR_BITS != offset >> BDRV_SECTOR_BITS &&
+        ret & BDRV_BLOCK_OFFSET_VALID) {
+        ret += QEMU_ALIGN_DOWN(offset - aligned_offset, BDRV_SECTOR_SIZE);
+    }
+    if (*pnum > bytes) {
+        *pnum = bytes;
     }
-    *pnum = count * BDRV_SECTOR_SIZE;

     if (ret & BDRV_BLOCK_RAW) {
         assert(ret & BDRV_BLOCK_OFFSET_VALID && local_file);
         ret = bdrv_co_block_status(local_file, mapping,
-                                   ret & BDRV_BLOCK_OFFSET_MASK,
+                                   (ret & BDRV_BLOCK_OFFSET_MASK) |
+                                   (offset & ~BDRV_BLOCK_OFFSET_MASK),
                                    *pnum, pnum, &local_file);
-        assert(QEMU_IS_ALIGNED(*pnum, BDRV_SECTOR_SIZE));
         goto out;
     }

@@ -1836,7 +1854,8 @@ static int64_t coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
         int64_t file_pnum;

         ret2 = bdrv_co_block_status(local_file, mapping,
-                                    ret & BDRV_BLOCK_OFFSET_MASK,
+                                    (ret & BDRV_BLOCK_OFFSET_MASK) |
+                                    (offset & ~BDRV_BLOCK_OFFSET_MASK),
                                     *pnum, &file_pnum, NULL);
         if (ret2 >= 0) {
             /* Ignore errors.  This is just providing extra information, it
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 775c464..6b40a85 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -641,6 +641,17 @@ static int coroutine_fn blkdebug_co_pdiscard(BlockDriverState *bs,
     return bdrv_co_pdiscard(bs->file->bs, offset, bytes);
 }

+static int64_t coroutine_fn blkdebug_co_get_block_status(
+    BlockDriverState *bs, int64_t sector_num, int nb_sectors, int *pnum,
+    BlockDriverState **file)
+{
+    assert(QEMU_IS_ALIGNED(sector_num | nb_sectors,
+                           DIV_ROUND_UP(bs->bl.request_alignment,
+                                        BDRV_SECTOR_SIZE)));
+    return bdrv_co_get_block_status_from_file(bs, sector_num, nb_sectors,
+                                              pnum, file);
+}
+
 static void blkdebug_close(BlockDriverState *bs)
 {
     BDRVBlkdebugState *s = bs->opaque;
@@ -910,7 +921,7 @@ static BlockDriver bdrv_blkdebug = {
     .bdrv_co_flush_to_disk  = blkdebug_co_flush,
     .bdrv_co_pwrite_zeroes  = blkdebug_co_pwrite_zeroes,
     .bdrv_co_pdiscard       = blkdebug_co_pdiscard,
-    .bdrv_co_get_block_status = bdrv_co_get_block_status_from_file,
+    .bdrv_co_get_block_status = blkdebug_co_get_block_status,

     .bdrv_debug_event           = blkdebug_debug_event,
     .bdrv_debug_breakpoint      = blkdebug_debug_breakpoint,
-- 
2.9.4

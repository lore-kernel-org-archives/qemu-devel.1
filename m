Received: from eggs.gnu.org ([2001:4830:134:3::10]:59079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3f-0000r8-JM
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3d-0002M1-OH
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:51 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:29 +0200
Message-Id: <20171026131741.5059-24-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 23/35] block: Align block status requests
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

There is a mid-function scope added for 'count' and 'longret',
for a couple of reasons: first, an upcoming patch will add an
'if' statement that checks whether a driver has an old- or
new-style callback, and can conveniently use the same scope for
less indentation churn at that time.  Second, since we are
trying to get rid of sector-based computations, wrapping things
in a scope makes it easier to group and see what will be
deleted in a final cleanup patch once all drivers have been
converted to the new-style callback.

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h |  3 +-
 block/blkdebug.c          | 13 ++++++++-
 block/io.c                | 71 ++++++++++++++++++++++++++++++-----------------
 3 files changed, 59 insertions(+), 28 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 246eee2e82..a5482775ec 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -207,7 +207,8 @@ struct BlockDriver {
      * according to the current layer, and should not set
      * BDRV_BLOCK_ALLOCATED, but may set BDRV_BLOCK_RAW.  See block.h
      * for the meaning of _DATA, _ZERO, and _OFFSET_VALID.  The block
-     * layer guarantees non-NULL pnum and file.
+     * layer guarantees input aligned to request_alignment, as well as
+     * non-NULL pnum and file.
      */
     int64_t coroutine_fn (*bdrv_co_get_block_status)(BlockDriverState *bs,
         int64_t sector_num, int nb_sectors, int *pnum,
diff --git a/block/blkdebug.c b/block/blkdebug.c
index dfdf9b91aa..e21669979d 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -627,6 +627,17 @@ static int coroutine_fn blkdebug_co_pdiscard(BlockDriverState *bs,
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
@@ -896,7 +907,7 @@ static BlockDriver bdrv_blkdebug = {
     .bdrv_co_flush_to_disk  = blkdebug_co_flush,
     .bdrv_co_pwrite_zeroes  = blkdebug_co_pwrite_zeroes,
     .bdrv_co_pdiscard       = blkdebug_co_pdiscard,
-    .bdrv_co_get_block_status = bdrv_co_get_block_status_from_file,
+    .bdrv_co_get_block_status = blkdebug_co_get_block_status,
 
     .bdrv_debug_event           = blkdebug_debug_event,
     .bdrv_debug_breakpoint      = blkdebug_debug_breakpoint,
diff --git a/block/io.c b/block/io.c
index e64b1cb294..d2cb20d872 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1839,10 +1839,11 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
 {
     int64_t total_size;
     int64_t n; /* bytes */
-    int64_t ret;
+    int ret;
     int64_t local_map = 0;
     BlockDriverState *local_file = NULL;
-    int count; /* sectors */
+    int64_t aligned_offset, aligned_bytes;
+    uint32_t align;
 
     assert(pnum);
     *pnum = 0;
@@ -1881,35 +1882,58 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
     }
 
     bdrv_inc_in_flight(bs);
+
+    /* Round out to request_alignment boundaries */
+    /* TODO: until we have a byte-based driver callback, we also have to
+     * round out to sectors, even if that is bigger than request_alignment */
+    align = MAX(bs->bl.request_alignment, BDRV_SECTOR_SIZE);
+    aligned_offset = QEMU_ALIGN_DOWN(offset, align);
+    aligned_bytes = ROUND_UP(offset + bytes, align) - aligned_offset;
+
+    {
+        int count; /* sectors */
+        int64_t longret;
+
+        assert(QEMU_IS_ALIGNED(aligned_offset | aligned_bytes,
+                               BDRV_SECTOR_SIZE));
+        /*
+         * The contract allows us to return pnum smaller than bytes, even
+         * if the next query would see the same status; we truncate the
+         * request to avoid overflowing the driver's 32-bit interface.
+         */
+        longret = bs->drv->bdrv_co_get_block_status(
+            bs, aligned_offset >> BDRV_SECTOR_BITS,
+            MIN(INT_MAX, aligned_bytes) >> BDRV_SECTOR_BITS, &count,
+            &local_file);
+        if (longret < 0) {
+            assert(INT_MIN <= longret);
+            ret = longret;
+            goto out;
+        }
+        if (longret & BDRV_BLOCK_OFFSET_VALID) {
+            local_map = longret & BDRV_BLOCK_OFFSET_MASK;
+        }
+        ret = longret & ~BDRV_BLOCK_OFFSET_MASK;
+        *pnum = count * BDRV_SECTOR_SIZE;
+    }
+
     /*
-     * TODO: Rather than require aligned offsets, we could instead
-     * round to the driver's request_alignment here, then touch up
-     * count afterwards back to the caller's expectations.
-     */
-    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
-    /*
-     * The contract allows us to return pnum smaller than bytes, even
-     * if the next query would see the same status; we truncate the
-     * request to avoid overflowing the driver's 32-bit interface.
+     * The driver's result must be a multiple of request_alignment.
+     * Clamp pnum and adjust map to original request.
      */
-    bytes = MIN(bytes, BDRV_REQUEST_MAX_BYTES);
-    ret = bs->drv->bdrv_co_get_block_status(bs, offset >> BDRV_SECTOR_BITS,
-                                            bytes >> BDRV_SECTOR_BITS, &count,
-                                            &local_file);
-    if (ret < 0) {
-        goto out;
+    assert(QEMU_IS_ALIGNED(*pnum, align) && align > offset - aligned_offset);
+    *pnum -= offset - aligned_offset;
+    if (*pnum > bytes) {
+        *pnum = bytes;
     }
     if (ret & BDRV_BLOCK_OFFSET_VALID) {
-        local_map = ret & BDRV_BLOCK_OFFSET_MASK;
+        local_map += offset - aligned_offset;
     }
-    *pnum = count * BDRV_SECTOR_SIZE;
 
     if (ret & BDRV_BLOCK_RAW) {
         assert(ret & BDRV_BLOCK_OFFSET_VALID && local_file);
         ret = bdrv_co_block_status(local_file, want_zero, local_map,
                                    *pnum, pnum, &local_map, &local_file);
-        assert(ret < 0 ||
-               QEMU_IS_ALIGNED(*pnum | local_map, BDRV_SECTOR_SIZE));
         goto out;
     }
 
@@ -1968,11 +1992,6 @@ early_out:
     if (map) {
         *map = local_map;
     }
-    if (ret >= 0) {
-        ret &= ~BDRV_BLOCK_OFFSET_MASK;
-    } else {
-        assert(INT_MIN <= ret);
-    }
     return ret;
 }
 
-- 
2.13.6

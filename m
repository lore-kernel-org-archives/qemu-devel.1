Received: from eggs.gnu.org ([2001:4830:134:3::10]:34718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzZ0o-0001gl-Vm
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 22:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzZ0n-0006al-MZ
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 22:02:15 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  3 Oct 2017 21:00:46 -0500
Message-Id: <20171004020048.26379-22-eblake@redhat.com>
In-Reply-To: <20171004020048.26379-1-eblake@redhat.com>
References: <20171004020048.26379-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 21/23] block: Align block status requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

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
v5: rebase to earlier changes, add more comments
v4: no change
v3: tweak commit message [Fam], rebase to context conflicts, ensure
we don't exceed 32-bit limit, drop R-b
v2: new patch
---
 include/block/block_int.h |  3 ++-
 block/io.c                | 68 +++++++++++++++++++++++++++++++++--------------
 block/blkdebug.c          | 13 ++++++++-
 3 files changed, 62 insertions(+), 22 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 3b4158f576..41a229d933 100644
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
diff --git a/block/io.c b/block/io.c
index 8f0434ce4f..8619f82eae 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1818,7 +1818,8 @@ static int64_t coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
     int64_t ret, ret2;
     BlockDriverState *local_file = NULL;
     int64_t local_pnum = 0;
-    int count; /* sectors */
+    int64_t aligned_offset, aligned_bytes;
+    uint32_t align;

     assert(pnum);
     total_size = bdrv_getlength(bs);
@@ -1851,32 +1852,58 @@ static int64_t coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
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
+
+        assert(QEMU_IS_ALIGNED(aligned_offset | aligned_bytes,
+                               BDRV_SECTOR_SIZE));
+        /*
+         * The contract allows us to return pnum smaller than bytes, even
+         * if the next query would see the same status; we truncate the
+         * request to avoid overflowing the driver's 32-bit interface.
+         */
+        ret = bs->drv->bdrv_co_get_block_status(
+            bs, aligned_offset >> BDRV_SECTOR_BITS,
+            MIN(INT_MAX, aligned_bytes) >> BDRV_SECTOR_BITS, &count,
+            &local_file);
+        if (ret < 0) {
+            goto out;
+        }
+        local_pnum = count * BDRV_SECTOR_SIZE;
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
+     * Clamp pnum and ret to original request; requires care if align
+     * is larger than a sector.
      */
-    bytes = MIN(bytes, BDRV_REQUEST_MAX_BYTES);
-    ret = bs->drv->bdrv_co_get_block_status(bs, offset >> BDRV_SECTOR_BITS,
-                                            bytes >> BDRV_SECTOR_BITS, &count,
-                                            &local_file);
-    if (ret < 0) {
-        goto out;
+    assert(QEMU_IS_ALIGNED(local_pnum, align) &&
+           align > offset - aligned_offset);
+    local_pnum -= offset - aligned_offset;
+    if (ret & BDRV_BLOCK_OFFSET_VALID &&
+        (aligned_offset & BDRV_BLOCK_OFFSET_MASK) !=
+        (offset & BDRV_BLOCK_OFFSET_MASK)) {
+        assert(align > BDRV_SECTOR_SIZE);
+        ret += QEMU_ALIGN_DOWN(offset - aligned_offset, BDRV_SECTOR_SIZE);
+    }
+    if (local_pnum > bytes) {
+        local_pnum = bytes;
     }
-    local_pnum = count * BDRV_SECTOR_SIZE;

     if (ret & BDRV_BLOCK_RAW) {
         assert(ret & BDRV_BLOCK_OFFSET_VALID && local_file);
         ret = bdrv_co_block_status(local_file, mapping,
-                                   ret & BDRV_BLOCK_OFFSET_MASK,
+                                   (ret & BDRV_BLOCK_OFFSET_MASK) |
+                                   (offset & ~BDRV_BLOCK_OFFSET_MASK),
                                    local_pnum, &local_pnum, &local_file);
-        assert(ret < 0 || QEMU_IS_ALIGNED(local_pnum, BDRV_SECTOR_SIZE));
         goto out;
     }

@@ -1900,7 +1927,8 @@ static int64_t coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
         int64_t file_pnum;

         ret2 = bdrv_co_block_status(local_file, mapping,
-                                    ret & BDRV_BLOCK_OFFSET_MASK,
+                                    (ret & BDRV_BLOCK_OFFSET_MASK) |
+                                    (offset & ~BDRV_BLOCK_OFFSET_MASK),
                                     local_pnum, &file_pnum, NULL);
         if (ret2 >= 0) {
             /* Ignore errors.  This is just providing extra information, it
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 46e53f2f09..f54fe33cae 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -628,6 +628,17 @@ static int coroutine_fn blkdebug_co_pdiscard(BlockDriverState *bs,
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
@@ -897,7 +908,7 @@ static BlockDriver bdrv_blkdebug = {
     .bdrv_co_flush_to_disk  = blkdebug_co_flush,
     .bdrv_co_pwrite_zeroes  = blkdebug_co_pwrite_zeroes,
     .bdrv_co_pdiscard       = blkdebug_co_pdiscard,
-    .bdrv_co_get_block_status = bdrv_co_get_block_status_from_file,
+    .bdrv_co_get_block_status = blkdebug_co_get_block_status,

     .bdrv_debug_event           = blkdebug_debug_event,
     .bdrv_debug_breakpoint      = blkdebug_debug_breakpoint,
-- 
2.13.6

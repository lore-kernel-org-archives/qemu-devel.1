Received: from eggs.gnu.org ([2001:4830:134:3::10]:34162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dUJQM-0003mY-FT
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dUJQJ-0006RX-BG
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:07:26 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun,  9 Jul 2017 22:07:17 +0100
Message-Id: <20170709210717.984-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] block/vpc.c: Handle write failures in
 get_image_offset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Coverity (CID 1355236) points out that get_image_offset() doesn't check that
it actually succeeded in writing the updated block bitmap to the file.
Check the error return from bdrv_pwrite_sync() and propagate an error
response back up to the function which calls get_image_offset() for
a write so that it can return the error to its caller.

get_sector_offset() is only used for reads, but we move it to the
same API for consistency.
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The new get_image_offset() API is pretty clunky, but I couldn't
think of anything better -- we need to report one of 3 things:
 * offset number (0..INT64_MAX)
 * sector not allocated
 * arbitrary errno
and they won't all fit into one return value.
I opted for "minimal change compared to current code".
---
 block/vpc.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index 4240ba9d1c..b93211df36 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -460,17 +460,23 @@ static int vpc_reopen_prepare(BDRVReopenState *state,
 /*
  * Returns the absolute byte offset of the given sector in the image file.
  * If the sector is not allocated, -1 is returned instead.
+ * If an error occurred trying to write an updated block bitmap back to
+ * the file, -2 is returned, and the error value is written to *err.
+ * This can only happen for a write operation.
  *
  * The parameter write must be 1 if the offset will be used for a write
  * operation (the block bitmaps is updated then), 0 otherwise.
+ * If write is true then err must not be NULL.
  */
 static inline int64_t get_image_offset(BlockDriverState *bs, uint64_t offset,
-                                       bool write)
+                                       bool write, int *err)
 {
     BDRVVPCState *s = bs->opaque;
     uint64_t bitmap_offset, block_offset;
     uint32_t pagetable_index, offset_in_block;
 
+    assert(!(write && err == NULL));
+
     pagetable_index = offset / s->block_size;
     offset_in_block = offset % s->block_size;
 
@@ -487,19 +493,25 @@ static inline int64_t get_image_offset(BlockDriverState *bs, uint64_t offset,
        correctness. */
     if (write && (s->last_bitmap_offset != bitmap_offset)) {
         uint8_t bitmap[s->bitmap_size];
+        int r;
 
         s->last_bitmap_offset = bitmap_offset;
         memset(bitmap, 0xff, s->bitmap_size);
-        bdrv_pwrite_sync(bs->file, bitmap_offset, bitmap, s->bitmap_size);
+        r = bdrv_pwrite_sync(bs->file, bitmap_offset, bitmap, s->bitmap_size);
+        if (r < 0) {
+            *err = r;
+            return -2;
+        }
     }
 
     return block_offset;
 }
 
 static inline int64_t get_sector_offset(BlockDriverState *bs,
-                                        int64_t sector_num, bool write)
+                                        int64_t sector_num, bool write,
+                                        int *err)
 {
-    return get_image_offset(bs, sector_num * BDRV_SECTOR_SIZE, write);
+    return get_image_offset(bs, sector_num * BDRV_SECTOR_SIZE, write, err);
 }
 
 /*
@@ -567,7 +579,7 @@ static int64_t alloc_block(BlockDriverState* bs, int64_t offset)
     if (ret < 0)
         goto fail;
 
-    return get_image_offset(bs, offset, false);
+    return get_image_offset(bs, offset, false, NULL);
 
 fail:
     s->free_data_block_offset -= (s->block_size + s->bitmap_size);
@@ -607,7 +619,7 @@ vpc_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     qemu_iovec_init(&local_qiov, qiov->niov);
 
     while (bytes > 0) {
-        image_offset = get_image_offset(bs, offset, false);
+        image_offset = get_image_offset(bs, offset, false, NULL);
         n_bytes = MIN(bytes, s->block_size - (offset % s->block_size));
 
         if (image_offset == -1) {
@@ -656,7 +668,11 @@ vpc_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     qemu_iovec_init(&local_qiov, qiov->niov);
 
     while (bytes > 0) {
-        image_offset = get_image_offset(bs, offset, true);
+        image_offset = get_image_offset(bs, offset, true, &ret);
+        if (image_offset == -2) {
+            /* Failed to write block bitmap: can't proceed with write */
+            goto fail;
+        }
         n_bytes = MIN(bytes, s->block_size - (offset % s->block_size));
 
         if (image_offset == -1) {
@@ -705,7 +721,7 @@ static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
                (sector_num << BDRV_SECTOR_BITS);
     }
 
-    offset = get_sector_offset(bs, sector_num, 0);
+    offset = get_sector_offset(bs, sector_num, false, NULL);
     start = offset;
     allocated = (offset != -1);
     *pnum = 0;
@@ -728,7 +744,7 @@ static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
         if (nb_sectors == 0) {
             break;
         }
-        offset = get_sector_offset(bs, sector_num, 0);
+        offset = get_sector_offset(bs, sector_num, false, NULL);
     } while (offset == -1);
 
     return 0;
-- 
2.11.0

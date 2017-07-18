Received: from eggs.gnu.org ([2001:4830:134:3::10]:53057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKV-0000Rn-RG
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKS-0007br-P4
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:27 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 18 Jul 2017 16:17:50 +0200
Message-Id: <1500387486-5469-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
References: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 05/21] block/vpc.c: Handle write failures in
 get_image_offset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

Coverity (CID 1355236) points out that get_image_offset() doesn't check that
it actually succeeded in writing the updated block bitmap to the file.
Check the error return from bdrv_pwrite_sync() and propagate an error
response back up to the function which calls get_image_offset() for
a write so that it can return the error to its caller.

get_sector_offset() is only used for reads, but we move it to the
same API for consistency.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vpc.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index 8057d42..10e6519 100644
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
 
@@ -487,10 +493,15 @@ static inline int64_t get_image_offset(BlockDriverState *bs, uint64_t offset,
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
@@ -561,7 +572,7 @@ static int64_t alloc_block(BlockDriverState* bs, int64_t offset)
     if (ret < 0)
         goto fail;
 
-    return get_image_offset(bs, offset, false);
+    return get_image_offset(bs, offset, false, NULL);
 
 fail:
     s->free_data_block_offset -= (s->block_size + s->bitmap_size);
@@ -601,7 +612,7 @@ vpc_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     qemu_iovec_init(&local_qiov, qiov->niov);
 
     while (bytes > 0) {
-        image_offset = get_image_offset(bs, offset, false);
+        image_offset = get_image_offset(bs, offset, false, NULL);
         n_bytes = MIN(bytes, s->block_size - (offset % s->block_size));
 
         if (image_offset == -1) {
@@ -650,7 +661,11 @@ vpc_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
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
@@ -702,7 +717,7 @@ static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
 
     qemu_co_mutex_lock(&s->lock);
 
-    offset = get_image_offset(bs, sector_num << BDRV_SECTOR_BITS, false);
+    offset = get_image_offset(bs, sector_num << BDRV_SECTOR_BITS, false, NULL);
     start = offset;
     allocated = (offset != -1);
     *pnum = 0;
@@ -727,7 +742,8 @@ static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
         if (nb_sectors == 0) {
             break;
         }
-        offset = get_image_offset(bs, sector_num << BDRV_SECTOR_BITS, false);
+        offset = get_image_offset(bs, sector_num << BDRV_SECTOR_BITS, false,
+                                  NULL);
     } while (offset == -1);
 
     qemu_co_mutex_unlock(&s->lock);
-- 
1.8.3.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1S-0000Zz-BX
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1R-0004YP-EI
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dWx1R-0004Xv-7c
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:37 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 17 Jul 2017 11:48:14 +0800
Message-Id: <20170717034825.1524-5-famz@redhat.com>
In-Reply-To: <20170717034825.1524-1-famz@redhat.com>
References: <20170717034825.1524-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 04/15] vpc: make it thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20170629132749.997-5-pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/vpc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index 9a6f817..8057d42 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -496,12 +496,6 @@ static inline int64_t get_image_offset(BlockDriverState *bs, uint64_t offset,
     return block_offset;
 }
 
-static inline int64_t get_sector_offset(BlockDriverState *bs,
-                                        int64_t sector_num, bool write)
-{
-    return get_image_offset(bs, sector_num * BDRV_SECTOR_SIZE, write);
-}
-
 /*
  * Writes the footer to the end of the image file. This is needed when the
  * file grows as it overwrites the old footer
@@ -696,6 +690,7 @@ static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
     VHDFooter *footer = (VHDFooter*) s->footer_buf;
     int64_t start, offset;
     bool allocated;
+    int64_t ret;
     int n;
 
     if (be32_to_cpu(footer->type) == VHD_FIXED) {
@@ -705,10 +700,13 @@ static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
                (sector_num << BDRV_SECTOR_BITS);
     }
 
-    offset = get_sector_offset(bs, sector_num, 0);
+    qemu_co_mutex_lock(&s->lock);
+
+    offset = get_image_offset(bs, sector_num << BDRV_SECTOR_BITS, false);
     start = offset;
     allocated = (offset != -1);
     *pnum = 0;
+    ret = 0;
 
     do {
         /* All sectors in a block are contiguous (without using the bitmap) */
@@ -723,15 +721,17 @@ static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
          * sectors since there is always a bitmap in between. */
         if (allocated) {
             *file = bs->file->bs;
-            return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID | start;
+            ret = BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID | start;
+            break;
         }
         if (nb_sectors == 0) {
             break;
         }
-        offset = get_sector_offset(bs, sector_num, 0);
+        offset = get_image_offset(bs, sector_num << BDRV_SECTOR_BITS, false);
     } while (offset == -1);
 
-    return 0;
+    qemu_co_mutex_unlock(&s->lock);
+    return ret;
 }
 
 /*
-- 
2.9.4

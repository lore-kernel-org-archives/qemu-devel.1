Received: from eggs.gnu.org ([2001:4830:134:3::10]:34618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I2z-00063u-Pl
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I2y-00046V-Qe
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:35:13 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Apr 2017 20:33:54 -0500
Message-Id: <20170418013356.3578-30-eblake@redhat.com>
In-Reply-To: <20170418013356.3578-1-eblake@redhat.com>
References: <20170418013356.3578-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 29/31] vpc: Switch to .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@nongnu.org, jsnow@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the vpc driver accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/vpc.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index ecfee77..3cd56e7 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -689,46 +689,45 @@ fail:
     return ret;
 }

-static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, int *pnum, BlockDriverState **file)
+static int64_t coroutine_fn vpc_co_block_status(BlockDriverState *bs,
+        int64_t offset, int64_t bytes, int64_t *pnum, BlockDriverState **file)
 {
     BDRVVPCState *s = bs->opaque;
     VHDFooter *footer = (VHDFooter*) s->footer_buf;
-    int64_t start, offset;
+    int64_t start, image_offset;
     bool allocated;
     int n;

     if (be32_to_cpu(footer->type) == VHD_FIXED) {
-        *pnum = nb_sectors;
+        *pnum = bytes;
         *file = bs->file->bs;
         return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_DATA |
-               (sector_num << BDRV_SECTOR_BITS);
+               (offset & BDRV_BLOCK_OFFSET_MASK);
     }

-    offset = get_sector_offset(bs, sector_num, 0);
-    start = offset;
-    allocated = (offset != -1);
+    image_offset = get_image_offset(bs, offset, 0);
+    start = image_offset & BDRV_BLOCK_OFFSET_MASK;
+    allocated = (image_offset != -1);
     *pnum = 0;

     do {
         /* All sectors in a block are contiguous (without using the bitmap) */
-        n = ROUND_UP(sector_num + 1, s->block_size / BDRV_SECTOR_SIZE)
-          - sector_num;
-        n = MIN(n, nb_sectors);
+        n = ROUND_UP(offset + 1, s->block_size) - offset;
+        n = MIN(n, bytes);

         *pnum += n;
-        sector_num += n;
-        nb_sectors -= n;
+        offset += n;
+        bytes -= n;
         /* *pnum can't be greater than one block for allocated
          * sectors since there is always a bitmap in between. */
         if (allocated) {
             *file = bs->file->bs;
             return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID | start;
         }
-        if (nb_sectors == 0) {
+        if (bytes == 0) {
             break;
         }
-        offset = get_sector_offset(bs, sector_num, 0);
+        image_offset = get_sector_offset(bs, offset, 0);
     } while (offset == -1);

     return 0;
@@ -1074,7 +1073,7 @@ static BlockDriver bdrv_vpc = {

     .bdrv_co_preadv             = vpc_co_preadv,
     .bdrv_co_pwritev            = vpc_co_pwritev,
-    .bdrv_co_get_block_status   = vpc_co_get_block_status,
+    .bdrv_co_block_status       = vpc_co_block_status,

     .bdrv_get_info          = vpc_get_info,

-- 
2.9.3

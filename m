Received: from eggs.gnu.org ([2001:4830:134:3::10]:47036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsVKp-0006QL-Fu
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsVKo-000355-Gl
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:41:43 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 14 Sep 2017 09:40:30 -0500
Message-Id: <20170914144032.14945-19-eblake@redhat.com>
In-Reply-To: <20170914144032.14945-1-eblake@redhat.com>
References: <20170914144032.14945-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 18/20] vpc: Switch to .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the vpc driver accordingly.  Drop the now-unused
get_sector_offset().

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v3: rebase to master
v2: drop get_sector_offset() [Kevin], rebase to mapping flag
---
 block/vpc.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index 1576d7b595..2daa1db538 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -705,40 +705,42 @@ fail:
     return ret;
 }

-static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, int *pnum, BlockDriverState **file)
+static int64_t coroutine_fn vpc_co_block_status(BlockDriverState *bs,
+                                                bool mapping,
+                                                int64_t offset, int64_t bytes,
+                                                int64_t *pnum,
+                                                BlockDriverState **file)
 {
     BDRVVPCState *s = bs->opaque;
     VHDFooter *footer = (VHDFooter*) s->footer_buf;
-    int64_t start, offset;
+    int64_t start, image_offset;
     bool allocated;
     int64_t ret;
     int n;

     if (be32_to_cpu(footer->type) == VHD_FIXED) {
-        *pnum = nb_sectors;
+        *pnum = bytes;
         *file = bs->file->bs;
         return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
-               (sector_num << BDRV_SECTOR_BITS);
+               (offset & BDRV_BLOCK_OFFSET_MASK);
     }

     qemu_co_mutex_lock(&s->lock);

-    offset = get_image_offset(bs, sector_num << BDRV_SECTOR_BITS, false, NULL);
-    start = offset;
-    allocated = (offset != -1);
+    image_offset = get_image_offset(bs, offset, false, NULL);
+    start = image_offset & BDRV_BLOCK_OFFSET_MASK;
+    allocated = (image_offset != -1);
     *pnum = 0;
     ret = 0;

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
@@ -746,11 +748,10 @@ static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
             ret = BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID | start;
             break;
         }
-        if (nb_sectors == 0) {
+        if (bytes == 0) {
             break;
         }
-        offset = get_image_offset(bs, sector_num << BDRV_SECTOR_BITS, false,
-                                  NULL);
+        image_offset = get_image_offset(bs, offset, false, NULL);
     } while (offset == -1);

     qemu_co_mutex_unlock(&s->lock);
@@ -1097,7 +1098,7 @@ static BlockDriver bdrv_vpc = {

     .bdrv_co_preadv             = vpc_co_preadv,
     .bdrv_co_pwritev            = vpc_co_pwritev,
-    .bdrv_co_get_block_status   = vpc_co_get_block_status,
+    .bdrv_co_block_status       = vpc_co_block_status,

     .bdrv_get_info          = vpc_get_info,

-- 
2.13.5

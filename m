Received: from eggs.gnu.org ([2001:4830:134:3::10]:34615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I2z-00063o-Lf
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I2y-00046a-Rc
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:35:13 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Apr 2017 20:33:55 -0500
Message-Id: <20170418013356.3578-31-eblake@redhat.com>
In-Reply-To: <20170418013356.3578-1-eblake@redhat.com>
References: <20170418013356.3578-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 30/31] vvfat: Switch to .bdrv_co_block_status()
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
byte-based.  Update the vvfat driver accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/vvfat.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index bef2056..825fe72 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -2961,13 +2961,13 @@ vvfat_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     return ret;
 }

-static int64_t coroutine_fn vvfat_co_get_block_status(BlockDriverState *bs,
-	int64_t sector_num, int nb_sectors, int *n, BlockDriverState **file)
+static int64_t coroutine_fn vvfat_co_block_status(BlockDriverState *bs,
+    int64_t offset, int64_t bytes, int64_t *n, BlockDriverState **file)
 {
     BDRVVVFATState* s = bs->opaque;
-    *n = s->sector_count - sector_num;
-    if (*n > nb_sectors) {
-        *n = nb_sectors;
+    *n = s->sector_count * BDRV_SECTOR_SIZE - offset;
+    if (*n > bytes) {
+        *n = bytes;
     } else if (*n < 0) {
         return 0;
     }
@@ -3124,7 +3124,7 @@ static BlockDriver bdrv_vvfat = {

     .bdrv_co_preadv         = vvfat_co_preadv,
     .bdrv_co_pwritev        = vvfat_co_pwritev,
-    .bdrv_co_get_block_status = vvfat_co_get_block_status,
+    .bdrv_co_block_status   = vvfat_co_block_status,
 };

 static void bdrv_vvfat_init(void)
-- 
2.9.3

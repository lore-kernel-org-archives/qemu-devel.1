Received: from eggs.gnu.org ([2001:4830:134:3::10]:34435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I2n-0005m2-9F
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I2m-0003wX-AW
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:35:01 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Apr 2017 20:33:49 -0500
Message-Id: <20170418013356.3578-25-eblake@redhat.com>
In-Reply-To: <20170418013356.3578-1-eblake@redhat.com>
References: <20170418013356.3578-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 24/31] raw: Switch to .bdrv_co_block_status()
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
byte-based.  Update the raw driver accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/raw-format.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/raw-format.c b/block/raw-format.c
index 36e6503..746beed 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -250,17 +250,17 @@ fail:
     return ret;
 }

-static int64_t coroutine_fn raw_co_get_block_status(BlockDriverState *bs,
-                                            int64_t sector_num,
-                                            int nb_sectors, int *pnum,
-                                            BlockDriverState **file)
+static int64_t coroutine_fn raw_co_block_status(BlockDriverState *bs,
+                                                int64_t offset,
+                                                int64_t bytes, int64_t *pnum,
+                                                BlockDriverState **file)
 {
     BDRVRawState *s = bs->opaque;
-    *pnum = nb_sectors;
+    *pnum = bytes;
     *file = bs->file->bs;
-    sector_num += s->offset / BDRV_SECTOR_SIZE;
+    offset += s->offset;
     return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_DATA |
-           (sector_num << BDRV_SECTOR_BITS);
+        (offset & BDRV_BLOCK_OFFSET_MASK);
 }

 static int coroutine_fn raw_co_pwrite_zeroes(BlockDriverState *bs,
@@ -475,7 +475,7 @@ BlockDriver bdrv_raw = {
     .bdrv_co_pwritev      = &raw_co_pwritev,
     .bdrv_co_pwrite_zeroes = &raw_co_pwrite_zeroes,
     .bdrv_co_pdiscard     = &raw_co_pdiscard,
-    .bdrv_co_get_block_status = &raw_co_get_block_status,
+    .bdrv_co_block_status = &raw_co_block_status,
     .bdrv_truncate        = &raw_truncate,
     .bdrv_getlength       = &raw_getlength,
     .has_variable_length  = true,
-- 
2.9.3

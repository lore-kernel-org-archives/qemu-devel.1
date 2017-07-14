Received: from eggs.gnu.org ([2001:4830:134:3::10]:46832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzVg-00043t-KR
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzVc-00046a-Kq
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:15:52 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 14 Jul 2017 07:14:50 -0500
Message-Id: <20170714121457.10322-14-eblake@redhat.com>
In-Reply-To: <20170714121457.10322-1-eblake@redhat.com>
References: <20170714121457.10322-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/20] raw: Switch to .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the raw driver accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: rebase to mapping
---
 block/raw-format.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/raw-format.c b/block/raw-format.c
index ab552c0..22c7e98 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -250,17 +250,18 @@ fail:
     return ret;
 }

-static int64_t coroutine_fn raw_co_get_block_status(BlockDriverState *bs,
-                                            int64_t sector_num,
-                                            int nb_sectors, int *pnum,
-                                            BlockDriverState **file)
+static int64_t coroutine_fn raw_co_block_status(BlockDriverState *bs,
+                                                bool mapping,
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
     return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
-           (sector_num << BDRV_SECTOR_BITS);
+        (offset & BDRV_BLOCK_OFFSET_MASK);
 }

 static int coroutine_fn raw_co_pwrite_zeroes(BlockDriverState *bs,
@@ -496,7 +497,7 @@ BlockDriver bdrv_raw = {
     .bdrv_co_pwritev      = &raw_co_pwritev,
     .bdrv_co_pwrite_zeroes = &raw_co_pwrite_zeroes,
     .bdrv_co_pdiscard     = &raw_co_pdiscard,
-    .bdrv_co_get_block_status = &raw_co_get_block_status,
+    .bdrv_co_block_status = &raw_co_block_status,
     .bdrv_truncate        = &raw_truncate,
     .bdrv_getlength       = &raw_getlength,
     .has_variable_length  = true,
-- 
2.9.4

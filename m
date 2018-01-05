Received: from eggs.gnu.org ([2001:4830:134:3::10]:47714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawg-0003Er-Kj
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawf-0000Lj-Op
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:38 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  5 Jan 2018 16:57:46 -0600
Message-Id: <20180105225753.30509-14-eblake@redhat.com>
In-Reply-To: <20180105225753.30509-1-eblake@redhat.com>
References: <20180105225753.30509-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 13/20] raw: Switch to .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the raw driver accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Fam Zheng <famz@redhat.com>

---
v5-v7: no change
v4: rebase to interface tweak
v3: no change
v2: rebase to mapping
---
 block/raw-format.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/raw-format.c b/block/raw-format.c
index ab552c0954..830243a8e4 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -250,17 +250,17 @@ fail:
     return ret;
 }

-static int64_t coroutine_fn raw_co_get_block_status(BlockDriverState *bs,
-                                            int64_t sector_num,
-                                            int nb_sectors, int *pnum,
+static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
+                                            bool want_zero, int64_t offset,
+                                            int64_t bytes, int64_t *pnum,
+                                            int64_t *map,
                                             BlockDriverState **file)
 {
     BDRVRawState *s = bs->opaque;
-    *pnum = nb_sectors;
+    *pnum = bytes;
     *file = bs->file->bs;
-    sector_num += s->offset / BDRV_SECTOR_SIZE;
-    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
-           (sector_num << BDRV_SECTOR_BITS);
+    *map = offset + s->offset;
+    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
 }

 static int coroutine_fn raw_co_pwrite_zeroes(BlockDriverState *bs,
@@ -496,7 +496,7 @@ BlockDriver bdrv_raw = {
     .bdrv_co_pwritev      = &raw_co_pwritev,
     .bdrv_co_pwrite_zeroes = &raw_co_pwrite_zeroes,
     .bdrv_co_pdiscard     = &raw_co_pdiscard,
-    .bdrv_co_get_block_status = &raw_co_get_block_status,
+    .bdrv_co_block_status = &raw_co_block_status,
     .bdrv_truncate        = &raw_truncate,
     .bdrv_getlength       = &raw_getlength,
     .has_variable_length  = true,
-- 
2.14.3

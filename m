Received: from eggs.gnu.org ([2001:4830:134:3::10]:47937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawq-0003P9-RN
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawp-0000Vl-JQ
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:48 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  5 Jan 2018 16:57:49 -0600
Message-Id: <20180105225753.30509-17-eblake@redhat.com>
In-Reply-To: <20180105225753.30509-1-eblake@redhat.com>
References: <20180105225753.30509-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 16/20] vdi: Switch to .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the vdi driver accordingly.  Note that the
TODO is already covered (the block layer guarantees bounds of its
requests), and that we can remove the now-unused s->block_sectors.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Fam Zheng <famz@redhat.com>

---
v6-v7: no change
v5: fix pnum when offset rounded down to block_size [Vladimir]
v4: rebase to interface tweak
v3: no change
v2: rebase to mapping flag
---
 block/vdi.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 6f83221ddc..f309562d36 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -171,8 +171,6 @@ typedef struct {
     uint32_t *bmap;
     /* Size of block (bytes). */
     uint32_t block_size;
-    /* Size of block (sectors). */
-    uint32_t block_sectors;
     /* First sector of block map. */
     uint32_t bmap_sector;
     /* VDI header (converted to host endianness). */
@@ -462,7 +460,6 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
     bs->total_sectors = header.disk_size / SECTOR_SIZE;

     s->block_size = header.block_size;
-    s->block_sectors = header.block_size / SECTOR_SIZE;
     s->bmap_sector = header.offset_bmap / SECTOR_SIZE;
     s->header = header;

@@ -508,33 +505,29 @@ static int vdi_reopen_prepare(BDRVReopenState *state,
     return 0;
 }

-static int64_t coroutine_fn vdi_co_get_block_status(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, int *pnum, BlockDriverState **file)
+static int coroutine_fn vdi_co_block_status(BlockDriverState *bs,
+                                            bool want_zero,
+                                            int64_t offset, int64_t bytes,
+                                            int64_t *pnum, int64_t *map,
+                                            BlockDriverState **file)
 {
-    /* TODO: Check for too large sector_num (in bdrv_is_allocated or here). */
     BDRVVdiState *s = (BDRVVdiState *)bs->opaque;
-    size_t bmap_index = sector_num / s->block_sectors;
-    size_t sector_in_block = sector_num % s->block_sectors;
-    int n_sectors = s->block_sectors - sector_in_block;
+    size_t bmap_index = offset / s->block_size;
+    size_t index_in_block = offset % s->block_size;
     uint32_t bmap_entry = le32_to_cpu(s->bmap[bmap_index]);
-    uint64_t offset;
     int result;

-    logout("%p, %" PRId64 ", %d, %p\n", bs, sector_num, nb_sectors, pnum);
-    if (n_sectors > nb_sectors) {
-        n_sectors = nb_sectors;
-    }
-    *pnum = n_sectors;
+    logout("%p, %" PRId64 ", %" PRId64 ", %p\n", bs, offset, bytes, pnum);
+    *pnum = MIN(s->block_size - index_in_block, bytes);
     result = VDI_IS_ALLOCATED(bmap_entry);
     if (!result) {
         return 0;
     }

-    offset = s->header.offset_data +
-                              (uint64_t)bmap_entry * s->block_size +
-                              sector_in_block * SECTOR_SIZE;
+    *map = s->header.offset_data + (uint64_t)bmap_entry * s->block_size +
+        index_in_block;
     *file = bs->file->bs;
-    return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID | offset;
+    return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
 }

 static int coroutine_fn
@@ -902,7 +895,7 @@ static BlockDriver bdrv_vdi = {
     .bdrv_child_perm          = bdrv_format_default_perms,
     .bdrv_create = vdi_create,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
-    .bdrv_co_get_block_status = vdi_co_get_block_status,
+    .bdrv_co_block_status = vdi_co_block_status,
     .bdrv_make_empty = vdi_make_empty,

     .bdrv_co_preadv     = vdi_co_preadv,
-- 
2.14.3

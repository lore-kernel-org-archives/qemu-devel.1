Received: from eggs.gnu.org ([2001:4830:134:3::10]:47786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawj-0003Hd-TJ
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawi-0000OI-In
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:41 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  5 Jan 2018 16:57:47 -0600
Message-Id: <20180105225753.30509-15-eblake@redhat.com>
In-Reply-To: <20180105225753.30509-1-eblake@redhat.com>
References: <20180105225753.30509-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 14/20] sheepdog: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, Max Reitz <mreitz@redhat.com>, "open list:Sheepdog" <sheepdog@lists.wpkg.org>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the sheepdog driver accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>

---
v7: rebase to minor spacing changes in master
v5-v6: no change
v4: update to interface tweak
v3: no change
v2: rebase to mapping flag
---
 block/sheepdog.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index f684477328..8a7b688ece 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2987,19 +2987,19 @@ static coroutine_fn int sd_co_pdiscard(BlockDriverState *bs, int64_t offset,
     return acb.ret;
 }

-static coroutine_fn int64_t
-sd_co_get_block_status(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
-                       int *pnum, BlockDriverState **file)
+static coroutine_fn int
+sd_co_block_status(BlockDriverState *bs, bool want_zero, int64_t offset,
+                   int64_t bytes, int64_t *pnum, int64_t *map,
+                   BlockDriverState **file)
 {
     BDRVSheepdogState *s = bs->opaque;
     SheepdogInode *inode = &s->inode;
     uint32_t object_size = (UINT32_C(1) << inode->block_size_shift);
-    uint64_t offset = sector_num * BDRV_SECTOR_SIZE;
     unsigned long start = offset / object_size,
-                  end = DIV_ROUND_UP((sector_num + nb_sectors) *
-                                     BDRV_SECTOR_SIZE, object_size);
+                  end = DIV_ROUND_UP(offset + bytes, object_size);
     unsigned long idx;
-    int64_t ret = BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID | offset;
+    *map = offset;
+    int ret = BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;

     for (idx = start; idx < end; idx++) {
         if (inode->data_vdi_id[idx] == 0) {
@@ -3016,9 +3016,9 @@ sd_co_get_block_status(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
         }
     }

-    *pnum = (idx - start) * object_size / BDRV_SECTOR_SIZE;
-    if (*pnum > nb_sectors) {
-        *pnum = nb_sectors;
+    *pnum = (idx - start) * object_size;
+    if (*pnum > bytes) {
+        *pnum = bytes;
     }
     if (ret > 0 && ret & BDRV_BLOCK_OFFSET_VALID) {
         *file = bs;
@@ -3096,7 +3096,7 @@ static BlockDriver bdrv_sheepdog = {
     .bdrv_co_writev               = sd_co_writev,
     .bdrv_co_flush_to_disk        = sd_co_flush_to_disk,
     .bdrv_co_pdiscard             = sd_co_pdiscard,
-    .bdrv_co_get_block_status     = sd_co_get_block_status,
+    .bdrv_co_block_status         = sd_co_block_status,

     .bdrv_snapshot_create         = sd_snapshot_create,
     .bdrv_snapshot_goto           = sd_snapshot_goto,
@@ -3132,7 +3132,7 @@ static BlockDriver bdrv_sheepdog_tcp = {
     .bdrv_co_writev               = sd_co_writev,
     .bdrv_co_flush_to_disk        = sd_co_flush_to_disk,
     .bdrv_co_pdiscard             = sd_co_pdiscard,
-    .bdrv_co_get_block_status     = sd_co_get_block_status,
+    .bdrv_co_block_status         = sd_co_block_status,

     .bdrv_snapshot_create         = sd_snapshot_create,
     .bdrv_snapshot_goto           = sd_snapshot_goto,
@@ -3168,7 +3168,7 @@ static BlockDriver bdrv_sheepdog_unix = {
     .bdrv_co_writev               = sd_co_writev,
     .bdrv_co_flush_to_disk        = sd_co_flush_to_disk,
     .bdrv_co_pdiscard             = sd_co_pdiscard,
-    .bdrv_co_get_block_status     = sd_co_get_block_status,
+    .bdrv_co_block_status         = sd_co_block_status,

     .bdrv_snapshot_create         = sd_snapshot_create,
     .bdrv_snapshot_goto           = sd_snapshot_goto,
-- 
2.14.3

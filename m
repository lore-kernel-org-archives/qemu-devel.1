Received: from eggs.gnu.org ([2001:4830:134:3::10]:46867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzVi-000485-SY
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzVh-0004Ce-QR
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:15:54 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 14 Jul 2017 07:14:51 -0500
Message-Id: <20170714121457.10322-15-eblake@redhat.com>
In-Reply-To: <20170714121457.10322-1-eblake@redhat.com>
References: <20170714121457.10322-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/20] sheepdog: Switch to
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
Cc: qemu-block@nongnu.org, famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Sheepdog" <sheepdog@lists.wpkg.org>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the sheepdog driver accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: rebase to mapping flag
---
 block/sheepdog.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index b7b7e6b..8a83210 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2972,18 +2972,17 @@ static coroutine_fn int sd_co_pdiscard(BlockDriverState *bs, int64_t offset,
 }

 static coroutine_fn int64_t
-sd_co_get_block_status(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
-                       int *pnum, BlockDriverState **file)
+sd_co_block_status(BlockDriverState *bs, bool mapping, int64_t offset,
+                   int64_t bytes, int64_t *pnum, BlockDriverState **file)
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
+    int64_t ret = BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID |
+        (offset & BDRV_BLOCK_OFFSET_MASK);

     for (idx = start; idx < end; idx++) {
         if (inode->data_vdi_id[idx] == 0) {
@@ -3000,9 +2999,9 @@ sd_co_get_block_status(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
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
@@ -3080,7 +3079,7 @@ static BlockDriver bdrv_sheepdog = {
     .bdrv_co_writev = sd_co_writev,
     .bdrv_co_flush_to_disk  = sd_co_flush_to_disk,
     .bdrv_co_pdiscard = sd_co_pdiscard,
-    .bdrv_co_get_block_status = sd_co_get_block_status,
+    .bdrv_co_block_status   = sd_co_block_status,

     .bdrv_snapshot_create   = sd_snapshot_create,
     .bdrv_snapshot_goto     = sd_snapshot_goto,
@@ -3116,7 +3115,7 @@ static BlockDriver bdrv_sheepdog_tcp = {
     .bdrv_co_writev = sd_co_writev,
     .bdrv_co_flush_to_disk  = sd_co_flush_to_disk,
     .bdrv_co_pdiscard = sd_co_pdiscard,
-    .bdrv_co_get_block_status = sd_co_get_block_status,
+    .bdrv_co_block_status   = sd_co_block_status,

     .bdrv_snapshot_create   = sd_snapshot_create,
     .bdrv_snapshot_goto     = sd_snapshot_goto,
@@ -3152,7 +3151,7 @@ static BlockDriver bdrv_sheepdog_unix = {
     .bdrv_co_writev = sd_co_writev,
     .bdrv_co_flush_to_disk  = sd_co_flush_to_disk,
     .bdrv_co_pdiscard = sd_co_pdiscard,
-    .bdrv_co_get_block_status = sd_co_get_block_status,
+    .bdrv_co_block_status   = sd_co_block_status,

     .bdrv_snapshot_create   = sd_snapshot_create,
     .bdrv_snapshot_goto     = sd_snapshot_goto,
-- 
2.9.4

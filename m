Received: from eggs.gnu.org ([2001:4830:134:3::10]:52526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpq6-0001C2-ST
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpq5-0002q2-Rw
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:55:30 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  2 Mar 2018 19:54:21 +0100
Message-Id: <20180302185448.6314-11-kwolf@redhat.com>
In-Reply-To: <20180302185448.6314-1-kwolf@redhat.com>
References: <20180302185448.6314-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/37] parallels: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the parallels driver accordingly.  Note that
the internal function block_status() is still sector-based, because
it is still in use by other sector-based functions; but that's okay
because request_alignment is 512 as a result of those functions.
For now, no optimizations are added based on the mapping hint.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/parallels.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index e1e3d80c88..3e952a9c14 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -261,23 +261,31 @@ static coroutine_fn int parallels_co_flush_to_os(BlockDriverState *bs)
 }
 
 
-static int64_t coroutine_fn parallels_co_get_block_status(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, int *pnum, BlockDriverState **file)
+static int coroutine_fn parallels_co_block_status(BlockDriverState *bs,
+                                                  bool want_zero,
+                                                  int64_t offset,
+                                                  int64_t bytes,
+                                                  int64_t *pnum,
+                                                  int64_t *map,
+                                                  BlockDriverState **file)
 {
     BDRVParallelsState *s = bs->opaque;
-    int64_t offset;
+    int count;
 
+    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
     qemu_co_mutex_lock(&s->lock);
-    offset = block_status(s, sector_num, nb_sectors, pnum);
+    offset = block_status(s, offset >> BDRV_SECTOR_BITS,
+                          bytes >> BDRV_SECTOR_BITS, &count);
     qemu_co_mutex_unlock(&s->lock);
 
+    *pnum = count * BDRV_SECTOR_SIZE;
     if (offset < 0) {
         return 0;
     }
 
+    *map = offset * BDRV_SECTOR_SIZE;
     *file = bs->file->bs;
-    return (offset << BDRV_SECTOR_BITS) |
-        BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
+    return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
 }
 
 static coroutine_fn int parallels_co_writev(BlockDriverState *bs,
@@ -782,7 +790,7 @@ static BlockDriver bdrv_parallels = {
     .bdrv_open		= parallels_open,
     .bdrv_close		= parallels_close,
     .bdrv_child_perm          = bdrv_format_default_perms,
-    .bdrv_co_get_block_status = parallels_co_get_block_status,
+    .bdrv_co_block_status     = parallels_co_block_status,
     .bdrv_has_zero_init       = bdrv_has_zero_init_1,
     .bdrv_co_flush_to_os      = parallels_co_flush_to_os,
     .bdrv_co_readv  = parallels_co_readv,
-- 
2.13.6

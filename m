Received: from eggs.gnu.org ([2001:4830:134:3::10]:52789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqN-0001U4-Gv
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:55:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqM-00033I-NL
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:55:47 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  2 Mar 2018 19:54:31 +0100
Message-Id: <20180302185448.6314-21-kwolf@redhat.com>
In-Reply-To: <20180302185448.6314-1-kwolf@redhat.com>
References: <20180302185448.6314-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 20/37] vvfat: Switch to .bdrv_co_block_status()
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
byte-based.  Update the vvfat driver accordingly.  Note that we
can rely on the block driver having already clamped limits to our
block size, and simplify accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 7e06ebacf6..4a17a49e12 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3088,15 +3088,13 @@ vvfat_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     return ret;
 }
 
-static int64_t coroutine_fn vvfat_co_get_block_status(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, int *n, BlockDriverState **file)
+static int coroutine_fn vvfat_co_block_status(BlockDriverState *bs,
+                                              bool want_zero, int64_t offset,
+                                              int64_t bytes, int64_t *n,
+                                              int64_t *map,
+                                              BlockDriverState **file)
 {
-    *n = bs->total_sectors - sector_num;
-    if (*n > nb_sectors) {
-        *n = nb_sectors;
-    } else if (*n < 0) {
-        return 0;
-    }
+    *n = bytes;
     return BDRV_BLOCK_DATA;
 }
 
@@ -3257,7 +3255,7 @@ static BlockDriver bdrv_vvfat = {
 
     .bdrv_co_preadv         = vvfat_co_preadv,
     .bdrv_co_pwritev        = vvfat_co_pwritev,
-    .bdrv_co_get_block_status = vvfat_co_get_block_status,
+    .bdrv_co_block_status   = vvfat_co_block_status,
 };
 
 static void bdrv_vvfat_init(void)
-- 
2.13.6

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawz-0003WU-3A
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawy-0000br-8M
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:57 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  5 Jan 2018 16:57:52 -0600
Message-Id: <20180105225753.30509-20-eblake@redhat.com>
In-Reply-To: <20180105225753.30509-1-eblake@redhat.com>
References: <20180105225753.30509-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 19/20] vvfat: Switch to
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
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the vvfat driver accordingly.  Note that we
can rely on the block driver having already clamped limits to our
block size, and simplify accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Fam Zheng <famz@redhat.com>

---
v5-v7: no change
v4: rebase to interface tweak
v3: no change
v2: rebase to earlier changes, simplify
---
 block/vvfat.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index a690595f2c..37d85a389f 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3086,15 +3086,13 @@ vvfat_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
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

@@ -3255,7 +3253,7 @@ static BlockDriver bdrv_vvfat = {

     .bdrv_co_preadv         = vvfat_co_preadv,
     .bdrv_co_pwritev        = vvfat_co_pwritev,
-    .bdrv_co_get_block_status = vvfat_co_get_block_status,
+    .bdrv_co_block_status   = vvfat_co_block_status,
 };

 static void bdrv_vvfat_init(void)
-- 
2.14.3

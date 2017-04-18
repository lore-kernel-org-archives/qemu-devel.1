Received: from eggs.gnu.org ([2001:4830:134:3::10]:34080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I2K-0005M7-8g
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I2H-0003k6-U3
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:34:32 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Apr 2017 20:33:37 -0500
Message-Id: <20170418013356.3578-13-eblake@redhat.com>
In-Reply-To: <20170418013356.3578-1-eblake@redhat.com>
References: <20170418013356.3578-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 12/31] commit: Switch to .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@nongnu.org, jsnow@redhat.com, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the commit driver accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/commit.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 989de7d..1cc7a00 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -228,14 +228,14 @@ static int coroutine_fn bdrv_commit_top_preadv(BlockDriverState *bs,
     return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
 }

-static int64_t coroutine_fn bdrv_commit_top_get_block_status(
-    BlockDriverState *bs, int64_t sector_num, int nb_sectors, int *pnum,
+static int64_t coroutine_fn bdrv_commit_top_block_status(
+    BlockDriverState *bs, int64_t offset, int64_t bytes, int64_t *pnum,
     BlockDriverState **file)
 {
-    *pnum = nb_sectors;
+    *pnum = bytes;
     *file = bs->backing->bs;
     return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_DATA |
-           (sector_num << BDRV_SECTOR_BITS);
+           (offset & BDRV_BLOCK_OFFSET_MASK);
 }

 static void bdrv_commit_top_refresh_filename(BlockDriverState *bs, QDict *opts)
@@ -263,7 +263,7 @@ static void bdrv_commit_top_child_perm(BlockDriverState *bs, BdrvChild *c,
 static BlockDriver bdrv_commit_top = {
     .format_name                = "commit_top",
     .bdrv_co_preadv             = bdrv_commit_top_preadv,
-    .bdrv_co_get_block_status   = bdrv_commit_top_get_block_status,
+    .bdrv_co_block_status       = bdrv_commit_top_block_status,
     .bdrv_refresh_filename      = bdrv_commit_top_refresh_filename,
     .bdrv_close                 = bdrv_commit_top_close,
     .bdrv_child_perm            = bdrv_commit_top_child_perm,
-- 
2.9.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxk2-0008GE-Gf
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:10:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxjx-0006AB-KK
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:10:26 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:16 +0200
Message-Id: <20170711160814.20941-28-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 27/85] block: fix bdrv_dirty_bitmap_granularity
 signature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Make getter signature const-correct. This allows other functions with
const dirty bitmap parameter use bdrv_dirty_bitmap_granularity().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-id: 20170628120530.31251-6-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/dirty-bitmap.h | 2 +-
 block/dirty-bitmap.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index ad6558a..ab89f08 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -29,7 +29,7 @@ void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs);
 uint32_t bdrv_get_default_bitmap_granularity(BlockDriverState *bs);
-uint32_t bdrv_dirty_bitmap_granularity(BdrvDirtyBitmap *bitmap);
+uint32_t bdrv_dirty_bitmap_granularity(const BdrvDirtyBitmap *bitmap);
 uint32_t bdrv_dirty_bitmap_meta_granularity(BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_frozen(BdrvDirtyBitmap *bitmap);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index a04c6e4..df0110c 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -455,7 +455,7 @@ uint32_t bdrv_get_default_bitmap_granularity(BlockDriverState *bs)
     return granularity;
 }
 
-uint32_t bdrv_dirty_bitmap_granularity(BdrvDirtyBitmap *bitmap)
+uint32_t bdrv_dirty_bitmap_granularity(const BdrvDirtyBitmap *bitmap)
 {
     return BDRV_SECTOR_SIZE << hbitmap_granularity(bitmap->bitmap);
 }
-- 
2.9.4

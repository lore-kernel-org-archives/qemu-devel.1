Received: from eggs.gnu.org ([2001:4830:134:3::10]:36267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdSR-0002H6-Jp
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdSN-0005BR-L8
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:47 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:43306 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cVdSN-00057J-9l
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:43 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 23 Jan 2017 15:10:17 +0300
Message-Id: <20170123121036.4823-6-vsementsov@virtuozzo.com>
In-Reply-To: <20170123121036.4823-1-vsementsov@virtuozzo.com>
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 05/24] block: fix bdrv_dirty_bitmap_granularity
 signature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com

Make getter signature const-correct. This allows other functions with
const dirty bitmap parameter use bdrv_dirty_bitmap_granularity().

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/dirty-bitmap.c         | 2 +-
 include/block/dirty-bitmap.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 519737c8d3..186941cfc3 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -388,7 +388,7 @@ uint32_t bdrv_get_default_bitmap_granularity(BlockDriverState *bs)
     return granularity;
 }
 
-uint32_t bdrv_dirty_bitmap_granularity(BdrvDirtyBitmap *bitmap)
+uint32_t bdrv_dirty_bitmap_granularity(const BdrvDirtyBitmap *bitmap)
 {
     return BDRV_SECTOR_SIZE << hbitmap_granularity(bitmap->bitmap);
 }
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 9dea14ba03..7cbe623ba7 100644
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
-- 
2.11.0

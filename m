Received: from eggs.gnu.org ([2001:4830:134:3::10]:55951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0QhG-0002sa-On
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 07:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0QhC-0000Gw-62
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 07:53:54 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 26 Mar 2018 14:53:46 +0300
Message-Id: <20180326115346.11939-1-vsementsov@virtuozzo.com>
In-Reply-To: <20180326112056.8420-1-vsementsov@virtuozzo.com>
References: <20180326112056.8420-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 5.5/7] dirty-bitmap: drop unused
 bdrv_undo_clear_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h | 1 -
 block/dirty-bitmap.c      | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index e5af7820ff..bd857d5099 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1079,7 +1079,6 @@ bool blk_dev_is_medium_locked(BlockBackend *blk);
 void bdrv_set_dirty(BlockDriverState *bs, int64_t offset, int64_t bytes);
 
 void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out);
-void bdrv_undo_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *in);
 
 void bdrv_inc_in_flight(BlockDriverState *bs);
 void bdrv_dec_in_flight(BlockDriverState *bs);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 1812e17549..3c69a8eed9 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -607,15 +607,6 @@ void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
     bdrv_dirty_bitmap_unlock(bitmap);
 }
 
-void bdrv_undo_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *in)
-{
-    HBitmap *tmp = bitmap->bitmap;
-    assert(bdrv_dirty_bitmap_enabled(bitmap));
-    assert(!bdrv_dirty_bitmap_readonly(bitmap));
-    bitmap->bitmap = in;
-    hbitmap_free(tmp);
-}
-
 uint64_t bdrv_dirty_bitmap_serialization_size(const BdrvDirtyBitmap *bitmap,
                                               uint64_t offset, uint64_t bytes)
 {
-- 
2.11.1

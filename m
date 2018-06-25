Received: from eggs.gnu.org ([2001:4830:134:3::10]:38654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fXUoK-0008M1-PL
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fXUoI-0006rk-7z
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:57:52 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 25 Jun 2018 19:57:44 +0300
Message-Id: <20180625165745.25259-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180625165745.25259-1-vsementsov@virtuozzo.com>
References: <20180625165745.25259-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/2] block/dirty-bitmap: add
 bdrv_enable_dirty_bitmap_locked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Add _locked version of bdrv_enable_dirty_bitmap, to fix dirty bitmap
migration in the following patch.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/dirty-bitmap.h | 1 +
 block/dirty-bitmap.c         | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 288dc6adb6..259bd27c40 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -32,6 +32,7 @@ void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
                                          Error **errp);
 void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
+void bdrv_enable_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap);
 BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs);
 uint32_t bdrv_get_default_bitmap_granularity(BlockDriverState *bs);
 uint32_t bdrv_dirty_bitmap_granularity(const BdrvDirtyBitmap *bitmap);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index db1782ec1f..93744b3565 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -241,6 +241,12 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
     return 0;
 }
 
+void bdrv_enable_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap)
+{
+    assert(!bdrv_dirty_bitmap_frozen(bitmap));
+    bitmap->disabled = false;
+}
+
 /* Called with BQL taken. */
 void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap)
 {
@@ -424,8 +430,7 @@ void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 {
     bdrv_dirty_bitmap_lock(bitmap);
-    assert(!bdrv_dirty_bitmap_frozen(bitmap));
-    bitmap->disabled = false;
+    bdrv_enable_dirty_bitmap_locked(bitmap);
     bdrv_dirty_bitmap_unlock(bitmap);
 }
 
-- 
2.11.1

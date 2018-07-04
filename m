Received: from eggs.gnu.org ([2001:4830:134:3::10]:53033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fabMY-0002Bh-4F
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 02:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fabMT-0004Bm-9L
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 02:34:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59068 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fabMT-0004Au-5T
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 02:33:57 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed,  4 Jul 2018 02:33:54 -0400
Message-Id: <20180704063355.25818-2-jsnow@redhat.com>
In-Reply-To: <20180704063355.25818-1-jsnow@redhat.com>
References: <20180704063355.25818-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] block/dirty-bitmap: add
 bdrv_enable_dirty_bitmap_locked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add _locked version of bdrv_enable_dirty_bitmap, to fix dirty bitmap
migration in the following patch.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20180625165745.25259-2-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c         | 9 +++++++--
 include/block/dirty-bitmap.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

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
-- 
2.14.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1d5tLu-0000au-29
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1d5tLq-00005r-6o
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:25:53 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:11477 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1d5tLp-0008St-OX
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:25:50 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  3 May 2017 15:25:23 +0300
Message-Id: <20170503122539.282182-10-vsementsov@virtuozzo.com>
In-Reply-To: <20170503122539.282182-1-vsementsov@virtuozzo.com>
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 09/25] block/dirty-bitmap: add readonly field
 to BdrvDirtyBitmap
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

It will be needed in following commits for persistent bitmaps.
If bitmap is loaded from read-only storage (and we can't mark it
"in use" in this storage) corresponding BdrvDirtyBitmap should be
read-only.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/dirty-bitmap.c         | 16 ++++++++++++++++
 include/block/dirty-bitmap.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 90af37287f..ab6a95cf41 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -44,6 +44,8 @@ struct BdrvDirtyBitmap {
     int64_t size;               /* Size of the bitmap (Number of sectors) */
     bool disabled;              /* Bitmap is read-only */
     int active_iterators;       /* How many iterators are active */
+    bool readonly;              /* Bitmap is read-only and may be changed only
+                                   by deserialize* functions */
     QLIST_ENTRY(BdrvDirtyBitmap) list;
 };
 
@@ -436,6 +438,7 @@ void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                            int64_t cur_sector, int64_t nr_sectors)
 {
     assert(bdrv_dirty_bitmap_enabled(bitmap));
+    assert(!bdrv_dirty_bitmap_readonly(bitmap));
     hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
 }
 
@@ -443,12 +446,14 @@ void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                              int64_t cur_sector, int64_t nr_sectors)
 {
     assert(bdrv_dirty_bitmap_enabled(bitmap));
+    assert(!bdrv_dirty_bitmap_readonly(bitmap));
     hbitmap_reset(bitmap->bitmap, cur_sector, nr_sectors);
 }
 
 void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
 {
     assert(bdrv_dirty_bitmap_enabled(bitmap));
+    assert(!bdrv_dirty_bitmap_readonly(bitmap));
     if (!out) {
         hbitmap_reset_all(bitmap->bitmap);
     } else {
@@ -519,6 +524,7 @@ void bdrv_set_dirty(BlockDriverState *bs, int64_t cur_sector,
         if (!bdrv_dirty_bitmap_enabled(bitmap)) {
             continue;
         }
+        assert(!bdrv_dirty_bitmap_readonly(bitmap));
         hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
     }
 }
@@ -540,3 +546,13 @@ int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap)
 {
     return hbitmap_count(bitmap->meta);
 }
+
+bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap)
+{
+    return bitmap->readonly;
+}
+
+void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap)
+{
+    bitmap->readonly = true;
+}
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 1e17729ac2..0aab5841f5 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -75,4 +75,7 @@ void bdrv_dirty_bitmap_deserialize_ones(BdrvDirtyBitmap *bitmap,
                                         bool finish);
 void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
 
+bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
+void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap);
+
 #endif
-- 
2.11.1

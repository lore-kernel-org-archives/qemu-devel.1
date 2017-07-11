Received: from eggs.gnu.org ([2001:4830:134:3::10]:45862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxkj-0000VO-CQ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxke-0006WG-OJ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:11:09 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:28 +0200
Message-Id: <20170711160814.20941-40-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 39/85] block: introduce persistent dirty bitmaps
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

New field BdrvDirtyBitmap.persistent means, that bitmap should be saved
by format driver in .bdrv_close and .bdrv_inactivate. No format driver
supports it for now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20170628120530.31251-18-vsementsov@virtuozzo.com
[mreitz: Fixed indentation]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/dirty-bitmap.h |  4 ++++
 block/dirty-bitmap.c         | 29 +++++++++++++++++++++++++++++
 block/qcow2-bitmap.c         |  1 +
 3 files changed, 34 insertions(+)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index e2fea12..bdf43df 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -73,6 +73,8 @@ void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
 
 void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value);
 void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool autoload);
+void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
+                                       bool persistent);
 
 /* Functions that require manual locking.  */
 void bdrv_dirty_bitmap_lock(BdrvDirtyBitmap *bitmap);
@@ -91,5 +93,7 @@ void bdrv_dirty_bitmap_truncate(BlockDriverState *bs);
 bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
 bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
 bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
+bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap);
+bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
 
 #endif
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 06dc7a3..3c17c45 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -54,6 +54,7 @@ struct BdrvDirtyBitmap {
                                    this flag is set. */
     bool autoload;              /* For persistent bitmaps: bitmap must be
                                    autoloaded on image opening */
+    bool persistent;            /* bitmap must be saved to owner disk image */
     QLIST_ENTRY(BdrvDirtyBitmap) list;
 };
 
@@ -102,6 +103,7 @@ void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap)
     assert(!bdrv_dirty_bitmap_frozen(bitmap));
     g_free(bitmap->name);
     bitmap->name = NULL;
+    bitmap->persistent = false;
     bitmap->autoload = false;
 }
 
@@ -299,6 +301,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
     bitmap->name = NULL;
     successor->name = name;
     bitmap->successor = NULL;
+    successor->persistent = bitmap->persistent;
+    bitmap->persistent = false;
     successor->autoload = bitmap->autoload;
     bitmap->autoload = false;
     bdrv_release_dirty_bitmap(bs, bitmap);
@@ -689,3 +693,28 @@ bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap)
 {
     return bitmap->autoload;
 }
+
+/* Called with BQL taken. */
+void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap, bool persistent)
+{
+    qemu_mutex_lock(bitmap->mutex);
+    bitmap->persistent = persistent;
+    qemu_mutex_unlock(bitmap->mutex);
+}
+
+bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap)
+{
+    return bitmap->persistent;
+}
+
+bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs)
+{
+    BdrvDirtyBitmap *bm;
+    QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
+        if (bm->persistent && !bm->readonly) {
+            return true;
+        }
+    }
+
+    return false;
+}
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index ee6d8f7..52e4616 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -794,6 +794,7 @@ bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp)
                 goto fail;
             }
 
+            bdrv_dirty_bitmap_set_persistance(bitmap, true);
             bdrv_dirty_bitmap_set_autoload(bitmap, true);
             bm->flags |= BME_FLAG_IN_USE;
             created_dirty_bitmaps =
-- 
2.9.4

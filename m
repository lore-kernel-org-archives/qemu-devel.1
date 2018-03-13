Received: from eggs.gnu.org ([2001:4830:134:3::10]:34636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evrFx-0000lL-9d
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evrFu-0005kc-9T
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48284 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1evrFu-0005kI-4Q
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:46 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 13 Mar 2018 17:14:30 -0400
Message-Id: <20180313211441.5179-3-jsnow@redhat.com>
In-Reply-To: <20180313211441.5179-1-jsnow@redhat.com>
References: <20180313211441.5179-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 02/13] block/dirty-bitmap: fix locking in
 bdrv_reclaim_dirty_bitmap
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

Like other setters here these functions should take a lock.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20180207155837.92351-3-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c | 85 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 32 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 0d0e807216..75435f6c2f 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -242,6 +242,51 @@ void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap)
     qemu_mutex_unlock(bitmap->mutex);
 }
 
+/* Called within bdrv_dirty_bitmap_lock..unlock */
+static void bdrv_do_release_matching_dirty_bitmap_locked(
+    BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
+    bool (*cond)(BdrvDirtyBitmap *bitmap))
+{
+    BdrvDirtyBitmap *bm, *next;
+
+    QLIST_FOREACH_SAFE(bm, &bs->dirty_bitmaps, list, next) {
+        if ((!bitmap || bm == bitmap) && (!cond || cond(bm))) {
+            assert(!bm->active_iterators);
+            assert(!bdrv_dirty_bitmap_frozen(bm));
+            assert(!bm->meta);
+            QLIST_REMOVE(bm, list);
+            hbitmap_free(bm->bitmap);
+            g_free(bm->name);
+            g_free(bm);
+
+            if (bitmap) {
+                return;
+            }
+        }
+    }
+
+    if (bitmap) {
+        abort();
+    }
+}
+
+/* Called with BQL taken.  */
+static void bdrv_do_release_matching_dirty_bitmap(
+    BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
+    bool (*cond)(BdrvDirtyBitmap *bitmap))
+{
+    bdrv_dirty_bitmaps_lock(bs);
+    bdrv_do_release_matching_dirty_bitmap_locked(bs, bitmap, cond);
+    bdrv_dirty_bitmaps_unlock(bs);
+}
+
+/* Called within bdrv_dirty_bitmap_lock..unlock */
+static void bdrv_release_dirty_bitmap_locked(BlockDriverState *bs,
+                                             BdrvDirtyBitmap *bitmap)
+{
+    bdrv_do_release_matching_dirty_bitmap_locked(bs, bitmap, NULL);
+}
+
 /**
  * For a bitmap with a successor, yield our name to the successor,
  * delete the old bitmap, and return a handle to the new bitmap.
@@ -281,7 +326,11 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
                                            BdrvDirtyBitmap *parent,
                                            Error **errp)
 {
-    BdrvDirtyBitmap *successor = parent->successor;
+    BdrvDirtyBitmap *successor;
+
+    qemu_mutex_lock(parent->mutex);
+
+    successor = parent->successor;
 
     if (!successor) {
         error_setg(errp, "Cannot reclaim a successor when none is present");
@@ -292,9 +341,11 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
         error_setg(errp, "Merging of parent and successor bitmap failed");
         return NULL;
     }
-    bdrv_release_dirty_bitmap(bs, successor);
+    bdrv_release_dirty_bitmap_locked(bs, successor);
     parent->successor = NULL;
 
+    qemu_mutex_unlock(parent->mutex);
+
     return parent;
 }
 
@@ -321,36 +372,6 @@ static bool bdrv_dirty_bitmap_has_name(BdrvDirtyBitmap *bitmap)
     return !!bdrv_dirty_bitmap_name(bitmap);
 }
 
-/* Called with BQL taken.  */
-static void bdrv_do_release_matching_dirty_bitmap(
-    BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
-    bool (*cond)(BdrvDirtyBitmap *bitmap))
-{
-    BdrvDirtyBitmap *bm, *next;
-    bdrv_dirty_bitmaps_lock(bs);
-    QLIST_FOREACH_SAFE(bm, &bs->dirty_bitmaps, list, next) {
-        if ((!bitmap || bm == bitmap) && (!cond || cond(bm))) {
-            assert(!bm->active_iterators);
-            assert(!bdrv_dirty_bitmap_frozen(bm));
-            assert(!bm->meta);
-            QLIST_REMOVE(bm, list);
-            hbitmap_free(bm->bitmap);
-            g_free(bm->name);
-            g_free(bm);
-
-            if (bitmap) {
-                goto out;
-            }
-        }
-    }
-    if (bitmap) {
-        abort();
-    }
-
-out:
-    bdrv_dirty_bitmaps_unlock(bs);
-}
-
 /* Called with BQL taken.  */
 void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap)
 {
-- 
2.14.3

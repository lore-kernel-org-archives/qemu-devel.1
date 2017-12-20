Received: from eggs.gnu.org ([208.118.235.92]:35035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRgd5-0003uh-Ou
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:50:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRgd1-0005da-9y
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:49:58 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 20 Dec 2017 18:49:34 +0300
Message-Id: <20171220154945.88410-3-vsementsov@virtuozzo.com>
In-Reply-To: <20171220154945.88410-1-vsementsov@virtuozzo.com>
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v9 02/13] block/dirty-bitmap: fix locking in
 bdrv_reclaim_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, vsementsov@virtuozzo.com, lirans@il.ibm.com

Like other setters here these functions should take a lock.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/dirty-bitmap.c | 85 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 32 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 81adbeb6d4..d83da077d5 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -245,6 +245,51 @@ void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap)
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
@@ -286,7 +331,11 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
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
@@ -297,9 +346,11 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
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
 
@@ -327,36 +378,6 @@ static bool bdrv_dirty_bitmap_has_name(BdrvDirtyBitmap *bitmap)
 }
 
 /* Called with BQL taken.  */
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
-/* Called with BQL taken.  */
 void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap)
 {
     bdrv_do_release_matching_dirty_bitmap(bs, bitmap, NULL);
-- 
2.11.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSSaO-0001uU-Ie
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSSaL-0003VZ-8N
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:34:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36618 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fSSaL-0003V2-2s
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:34:37 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 11 Jun 2018 15:34:29 -0400
Message-Id: <20180611193434.19004-3-jsnow@redhat.com>
In-Reply-To: <20180611193434.19004-1-jsnow@redhat.com>
References: <20180611193434.19004-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] block: simplify code around releasing
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

QLIST_REMOVE does not require walking the list, and once the "bitmap"
argument is removed from bdrv_do_release_matching_dirty_bitmap_locked
the code simplifies a lot and it is worth inlining everything in the
callers of bdrv_do_release_matching_dirty_bitmap.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20180326104037.6894-1-pbonzini@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c | 84 ++++++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 52 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index ea82c06f07..a7eaa1051d 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -249,49 +249,16 @@ void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap)
     qemu_mutex_unlock(bitmap->mutex);
 }
 
-/* Called within bdrv_dirty_bitmap_lock..unlock */
-static void bdrv_do_release_matching_dirty_bitmap_locked(
-    BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
-    bool (*cond)(BdrvDirtyBitmap *bitmap))
+/* Called within bdrv_dirty_bitmap_lock..unlock and with BQL taken.  */
+static void bdrv_release_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap)
 {
-    BdrvDirtyBitmap *bm, *next;
-
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
-                return;
-            }
-        }
-    }
-
-    if (bitmap) {
-        abort();
-    }
-}
-
-/* Called with BQL taken.  */
-static void bdrv_do_release_matching_dirty_bitmap(
-    BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
-    bool (*cond)(BdrvDirtyBitmap *bitmap))
-{
-    bdrv_dirty_bitmaps_lock(bs);
-    bdrv_do_release_matching_dirty_bitmap_locked(bs, bitmap, cond);
-    bdrv_dirty_bitmaps_unlock(bs);
-}
-
-/* Called within bdrv_dirty_bitmap_lock..unlock */
-static void bdrv_release_dirty_bitmap_locked(BlockDriverState *bs,
-                                             BdrvDirtyBitmap *bitmap)
-{
-    bdrv_do_release_matching_dirty_bitmap_locked(bs, bitmap, NULL);
+    assert(!bitmap->active_iterators);
+    assert(!bdrv_dirty_bitmap_frozen(bitmap));
+    assert(!bitmap->meta);
+    QLIST_REMOVE(bitmap, list);
+    hbitmap_free(bitmap->bitmap);
+    g_free(bitmap->name);
+    g_free(bitmap);
 }
 
 /**
@@ -344,7 +311,7 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
         error_setg(errp, "Merging of parent and successor bitmap failed");
         return NULL;
     }
-    bdrv_release_dirty_bitmap_locked(bs, successor);
+    bdrv_release_dirty_bitmap_locked(successor);
     parent->successor = NULL;
 
     return parent;
@@ -382,15 +349,12 @@ void bdrv_dirty_bitmap_truncate(BlockDriverState *bs, int64_t bytes)
     bdrv_dirty_bitmaps_unlock(bs);
 }
 
-static bool bdrv_dirty_bitmap_has_name(BdrvDirtyBitmap *bitmap)
-{
-    return !!bdrv_dirty_bitmap_name(bitmap);
-}
-
 /* Called with BQL taken.  */
 void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap)
 {
-    bdrv_do_release_matching_dirty_bitmap(bs, bitmap, NULL);
+    bdrv_dirty_bitmaps_lock(bs);
+    bdrv_release_dirty_bitmap_locked(bitmap);
+    bdrv_dirty_bitmaps_unlock(bs);
 }
 
 /**
@@ -401,7 +365,15 @@ void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap)
  */
 void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs)
 {
-    bdrv_do_release_matching_dirty_bitmap(bs, NULL, bdrv_dirty_bitmap_has_name);
+    BdrvDirtyBitmap *bm, *next;
+
+    bdrv_dirty_bitmaps_lock(bs);
+    QLIST_FOREACH_SAFE(bm, &bs->dirty_bitmaps, list, next) {
+        if (bdrv_dirty_bitmap_name(bm)) {
+            bdrv_release_dirty_bitmap_locked(bm);
+        }
+    }
+    bdrv_dirty_bitmaps_unlock(bs);
 }
 
 /**
@@ -409,11 +381,19 @@ void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs)
  * bdrv_inactivate_recurse()).
  * There must not be any frozen bitmaps attached.
  * This function does not remove persistent bitmaps from the storage.
+ * Called with BQL taken.
  */
 void bdrv_release_persistent_dirty_bitmaps(BlockDriverState *bs)
 {
-    bdrv_do_release_matching_dirty_bitmap(bs, NULL,
-                                          bdrv_dirty_bitmap_get_persistance);
+    BdrvDirtyBitmap *bm, *next;
+
+    bdrv_dirty_bitmaps_lock(bs);
+    QLIST_FOREACH_SAFE(bm, &bs->dirty_bitmaps, list, next) {
+        if (bdrv_dirty_bitmap_get_persistance(bm)) {
+            bdrv_release_dirty_bitmap_locked(bm);
+        }
+    }
+    bdrv_dirty_bitmaps_unlock(bs);
 }
 
 /**
-- 
2.14.3

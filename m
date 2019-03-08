Received: from eggs.gnu.org ([209.51.188.92]:44775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7E-0000nP-W3
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7B-0006ov-E5
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38295)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1h2M78-0006j9-A4
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:07 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Mar 2019 15:28:43 -0500
Message-Id: <20190308202858.26636-3-jsnow@redhat.com>
In-Reply-To: <20190308202858.26636-1-jsnow@redhat.com>
References: <20190308202858.26636-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 02/17] block/dirty-bitmaps: rename frozen
 predicate helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org

"Frozen" was a good description a long time ago, but it isn't adequate now.
Rename the frozen predicate to has_successor to make the semantics of the
predicate more clear to outside callers.

In the process, remove some calls to frozen() that no longer semantically
make sense. For bdrv_enable_dirty_bitmap_locked and
bdrv_disable_dirty_bitmap_locked, it doesn't make sense to prohibit QEMU
internals from performing this action when we only wished to prohibit QMP
users from issuing these commands. All of the QMP API commands for bitmap
manipulation already check against user_locked() to prohibit these actions.

Several other assertions really want to check that the bitmap isn't in-use
by another operation -- use the bitmap_user_locked function for this instead,
which presently also checks for has_successor. This leaves some redundant
checks of has_successor through different helpers that are addressed in
forthcoming patches.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190223000614.13894-3-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/block/dirty-bitmap.h   |  2 +-
 block/dirty-bitmap.c           | 34 +++++++++++++++++++---------------
 migration/block-dirty-bitmap.c |  2 +-
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 04a117fc81..cdbb4dfefd 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -36,7 +36,7 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs);
 uint32_t bdrv_get_default_bitmap_granularity(BlockDriverState *bs);
 uint32_t bdrv_dirty_bitmap_granularity(const BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap);
-bool bdrv_dirty_bitmap_frozen(BdrvDirtyBitmap *bitmap);
+bool bdrv_dirty_bitmap_has_successor(BdrvDirtyBitmap *bitmap);
 const char *bdrv_dirty_bitmap_name(const BdrvDirtyBitmap *bitmap);
 int64_t bdrv_dirty_bitmap_size(const BdrvDirtyBitmap *bitmap);
 DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 101383b3af..c8fa21b526 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -50,7 +50,7 @@ struct BdrvDirtyBitmap {
     HBitmap *meta;              /* Meta dirty bitmap */
     bool qmp_locked;            /* Bitmap is locked, it can't be modified
                                    through QMP */
-    BdrvDirtyBitmap *successor; /* Anonymous child; implies frozen status */
+    BdrvDirtyBitmap *successor; /* Anonymous child; implies user_locked state */
     char *name;                 /* Optional non-empty unique ID */
     int64_t size;               /* Size of the bitmap, in bytes */
     bool disabled;              /* Bitmap is disabled. It ignores all writes to
@@ -183,14 +183,14 @@ const char *bdrv_dirty_bitmap_name(const BdrvDirtyBitmap *bitmap)
 }
 
 /* Called with BQL taken.  */
-bool bdrv_dirty_bitmap_frozen(BdrvDirtyBitmap *bitmap)
+bool bdrv_dirty_bitmap_has_successor(BdrvDirtyBitmap *bitmap)
 {
     return bitmap->successor;
 }
 
 /* Both conditions disallow user-modification via QMP. */
 bool bdrv_dirty_bitmap_user_locked(BdrvDirtyBitmap *bitmap) {
-    return bdrv_dirty_bitmap_frozen(bitmap) ||
+    return bdrv_dirty_bitmap_has_successor(bitmap) ||
            bdrv_dirty_bitmap_qmp_locked(bitmap);
 }
 
@@ -215,7 +215,7 @@ bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap)
 /* Called with BQL taken.  */
 DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap)
 {
-    if (bdrv_dirty_bitmap_frozen(bitmap)) {
+    if (bdrv_dirty_bitmap_has_successor(bitmap)) {
         return DIRTY_BITMAP_STATUS_FROZEN;
     } else if (bdrv_dirty_bitmap_qmp_locked(bitmap)) {
         return DIRTY_BITMAP_STATUS_LOCKED;
@@ -235,7 +235,7 @@ static bool bdrv_dirty_bitmap_recording(BdrvDirtyBitmap *bitmap)
 
 /**
  * Create a successor bitmap destined to replace this bitmap after an operation.
- * Requires that the bitmap is not frozen and has no successor.
+ * Requires that the bitmap is not user_locked and has no successor.
  * Called with BQL taken.
  */
 int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
@@ -244,12 +244,16 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
     uint64_t granularity;
     BdrvDirtyBitmap *child;
 
-    if (bdrv_dirty_bitmap_frozen(bitmap)) {
-        error_setg(errp, "Cannot create a successor for a bitmap that is "
-                   "currently frozen");
+    if (bdrv_dirty_bitmap_user_locked(bitmap)) {
+        error_setg(errp, "Cannot create a successor for a bitmap that is in-use "
+                   "by an operation");
+        return -1;
+    }
+    if (bdrv_dirty_bitmap_has_successor(bitmap)) {
+        error_setg(errp, "Cannot create a successor for a bitmap that already "
+                   "has one");
         return -1;
     }
-    assert(!bitmap->successor);
 
     /* Create an anonymous successor */
     granularity = bdrv_dirty_bitmap_granularity(bitmap);
@@ -268,7 +272,6 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
 
 void bdrv_enable_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap)
 {
-    assert(!bdrv_dirty_bitmap_frozen(bitmap));
     bitmap->disabled = false;
 }
 
@@ -285,7 +288,8 @@ void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap)
 static void bdrv_release_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap)
 {
     assert(!bitmap->active_iterators);
-    assert(!bdrv_dirty_bitmap_frozen(bitmap));
+    assert(!bdrv_dirty_bitmap_user_locked(bitmap));
+    assert(!bdrv_dirty_bitmap_has_successor(bitmap));
     assert(!bitmap->meta);
     QLIST_REMOVE(bitmap, list);
     hbitmap_free(bitmap->bitmap);
@@ -325,7 +329,7 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
 /**
  * In cases of failure where we can no longer safely delete the parent,
  * we may wish to re-join the parent and child/successor.
- * The merged parent will be un-frozen, but not explicitly re-enabled.
+ * The merged parent will not be user_locked, nor explicitly re-enabled.
  * Called within bdrv_dirty_bitmap_lock..unlock and with BQL taken.
  */
 BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
@@ -373,7 +377,8 @@ void bdrv_dirty_bitmap_truncate(BlockDriverState *bs, int64_t bytes)
 
     bdrv_dirty_bitmaps_lock(bs);
     QLIST_FOREACH(bitmap, &bs->dirty_bitmaps, list) {
-        assert(!bdrv_dirty_bitmap_frozen(bitmap));
+        assert(!bdrv_dirty_bitmap_user_locked(bitmap));
+        assert(!bdrv_dirty_bitmap_has_successor(bitmap));
         assert(!bitmap->active_iterators);
         hbitmap_truncate(bitmap->bitmap, bytes);
         bitmap->size = bytes;
@@ -391,7 +396,7 @@ void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap)
 
 /**
  * Release all named dirty bitmaps attached to a BDS (for use in bdrv_close()).
- * There must not be any frozen bitmaps attached.
+ * There must not be any user_locked bitmaps attached.
  * This function does not remove persistent bitmaps from the storage.
  * Called with BQL taken.
  */
@@ -428,7 +433,6 @@ void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
 void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 {
     bdrv_dirty_bitmap_lock(bitmap);
-    assert(!bdrv_dirty_bitmap_frozen(bitmap));
     bitmap->disabled = true;
     bdrv_dirty_bitmap_unlock(bitmap);
 }
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 6426151e4f..ac6954142f 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -542,7 +542,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DirtyBitmapLoadState *s)
         }
     }
 
-    if (bdrv_dirty_bitmap_frozen(s->bitmap)) {
+    if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
         bdrv_dirty_bitmap_lock(s->bitmap);
         if (enabled_bitmaps == NULL) {
             /* in postcopy */
-- 
2.17.2

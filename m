Received: from eggs.gnu.org ([2001:4830:134:3::10]:45189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF27-000411-7s
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF25-0002GR-Cu
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gHF25-0002GA-4F
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:09 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 29 Oct 2018 17:24:46 -0400
Message-Id: <20181029212501.5897-5-jsnow@redhat.com>
In-Reply-To: <20181029212501.5897-1-jsnow@redhat.com>
References: <20181029212501.5897-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 04/19] dirty-bitmap: make it possible to restore
 bitmap after merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add backup parameter to bdrv_merge_dirty_bitmap() to be used then with
bdrv_restore_dirty_bitmap() if it needed to restore the bitmap after
merge operation.

This is needed to implement bitmap merge transaction action in further
commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c         | 17 ++++++++++++++---
 blockdev.c                   |  2 +-
 include/block/dirty-bitmap.h |  2 +-
 include/qemu/hbitmap.h       | 25 ++++++++++++++++---------
 util/hbitmap.c               | 11 ++++++++---
 5 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 017ee9db46..8ac933cf1c 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -314,7 +314,7 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
         return NULL;
     }
 
-    if (!hbitmap_merge(parent->bitmap, successor->bitmap)) {
+    if (!hbitmap_merge(parent->bitmap, successor->bitmap, parent->bitmap)) {
         error_setg(errp, "Merging of parent and successor bitmap failed");
         return NULL;
     }
@@ -791,8 +791,10 @@ int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t offset)
 }
 
 void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
-                             Error **errp)
+                             HBitmap **backup, Error **errp)
 {
+    bool ret;
+
     /* only bitmaps from one bds are supported */
     assert(dest->mutex == src->mutex);
 
@@ -810,11 +812,20 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
         goto out;
     }
 
-    if (!hbitmap_merge(dest->bitmap, src->bitmap)) {
+    if (!hbitmap_can_merge(dest->bitmap, src->bitmap)) {
         error_setg(errp, "Bitmaps are incompatible and can't be merged");
         goto out;
     }
 
+    if (backup) {
+        *backup = dest->bitmap;
+        dest->bitmap = hbitmap_alloc(dest->size, hbitmap_granularity(*backup));
+        ret = hbitmap_merge(*backup, src->bitmap, dest->bitmap);
+    } else {
+        ret = hbitmap_merge(dest->bitmap, src->bitmap, dest->bitmap);
+    }
+    assert(ret);
+
 out:
     qemu_mutex_unlock(dest->mutex);
 }
diff --git a/blockdev.c b/blockdev.c
index 598ff87519..b8a854fba5 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2968,7 +2968,7 @@ void qmp_x_block_dirty_bitmap_merge(const char *node, const char *dst_name,
         return;
     }
 
-    bdrv_merge_dirty_bitmap(dst, src, errp);
+    bdrv_merge_dirty_bitmap(dst, src, NULL, errp);
 }
 
 BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 259bd27c40..201ff7f20b 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -71,7 +71,7 @@ void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
                                        bool persistent);
 void bdrv_dirty_bitmap_set_qmp_locked(BdrvDirtyBitmap *bitmap, bool qmp_locked);
 void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
-                             Error **errp);
+                             HBitmap **backup, Error **errp);
 
 /* Functions that require manual locking.  */
 void bdrv_dirty_bitmap_lock(BdrvDirtyBitmap *bitmap);
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index ddca52c48e..a7cb780592 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -73,16 +73,23 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size);
 
 /**
  * hbitmap_merge:
- * @a: The bitmap to store the result in.
- * @b: The bitmap to merge into @a.
- * @return true if the merge was successful,
- *         false if it was not attempted.
- *
- * Merge two bitmaps together.
- * A := A (BITOR) B.
- * B is left unmodified.
+ *
+ * Store result of merging @a and @b into @result.
+ * @result is allowed to be equal to @a or @b.
+ *
+ * Return true if the merge was successful,
+ *        false if it was not attempted.
+ */
+bool hbitmap_merge(const HBitmap *a, const HBitmap *b, HBitmap *result);
+
+/**
+ * hbitmap_can_merge:
+ *
+ * hbitmap_can_merge(a, b) && hbitmap_can_merge(a, result) is sufficient and
+ * necessary for hbitmap_merge will not fail.
+ *
  */
-bool hbitmap_merge(HBitmap *a, const HBitmap *b);
+bool hbitmap_can_merge(const HBitmap *a, const HBitmap *b);
 
 /**
  * hbitmap_empty:
diff --git a/util/hbitmap.c b/util/hbitmap.c
index bcd304041a..d5aca5159f 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -723,6 +723,10 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size)
     }
 }
 
+bool hbitmap_can_merge(const HBitmap *a, const HBitmap *b)
+{
+    return (a->size == b->size) && (a->granularity == b->granularity);
+}
 
 /**
  * Given HBitmaps A and B, let A := A (BITOR) B.
@@ -731,14 +735,15 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size)
  * @return true if the merge was successful,
  *         false if it was not attempted.
  */
-bool hbitmap_merge(HBitmap *a, const HBitmap *b)
+bool hbitmap_merge(const HBitmap *a, const HBitmap *b, HBitmap *result)
 {
     int i;
     uint64_t j;
 
-    if ((a->size != b->size) || (a->granularity != b->granularity)) {
+    if (!hbitmap_can_merge(a, b) || !hbitmap_can_merge(a, result)) {
         return false;
     }
+    assert(hbitmap_can_merge(b, result));
 
     if (hbitmap_count(b) == 0) {
         return true;
@@ -750,7 +755,7 @@ bool hbitmap_merge(HBitmap *a, const HBitmap *b)
      */
     for (i = HBITMAP_LEVELS - 1; i >= 0; i--) {
         for (j = 0; j < a->sizes[i]; j++) {
-            a->levels[i][j] |= b->levels[i][j];
+            result->levels[i][j] = a->levels[i][j] | b->levels[i][j];
         }
     }
 
-- 
2.14.5

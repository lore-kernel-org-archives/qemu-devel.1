Received: from eggs.gnu.org ([209.51.188.92]:44926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7L-0000uS-Ud
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7J-0006yg-Rj
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1h2M7J-0006v0-Hk
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:17 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Mar 2019 15:28:58 -0500
Message-Id: <20190308202858.26636-18-jsnow@redhat.com>
In-Reply-To: <20190308202858.26636-1-jsnow@redhat.com>
References: <20190308202858.26636-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 17/17] block/dirty-bitmaps: implement
 inconsistent bit
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

Set the inconsistent bit on load instead of rejecting such bitmaps.
There is no way to un-set it; the only option is to delete the bitmap.

Obvervations:
- bitmap loading does not need to update the header for in_use bitmaps.
- inconsistent bitmaps don't need to have their data loaded; they're
  glorified corruption sentinels.
- bitmap saving does not need to save inconsistent bitmaps back to disk.
- bitmap reopening DOES need to drop the readonly flag from inconsistent
  bitmaps to allow reopening of qcow2 files with non-qemu-owned bitmaps
  being eventually flushed back to disk.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20190301191545.8728-8-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2-bitmap.c | 103 ++++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 50 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 3ee524da4b..80926966de 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -343,9 +343,15 @@ static BdrvDirtyBitmap *load_bitmap(BlockDriverState *bs,
     uint32_t granularity;
     BdrvDirtyBitmap *bitmap = NULL;
 
+    granularity = 1U << bm->granularity_bits;
+    bitmap = bdrv_create_dirty_bitmap(bs, granularity, bm->name, errp);
+    if (bitmap == NULL) {
+        goto fail;
+    }
+
     if (bm->flags & BME_FLAG_IN_USE) {
-        error_setg(errp, "Bitmap '%s' is in use", bm->name);
-        goto fail;
+        /* Data is unusable, skip loading it */
+        return bitmap;
     }
 
     ret = bitmap_table_load(bs, &bm->table, &bitmap_table);
@@ -356,12 +362,6 @@ static BdrvDirtyBitmap *load_bitmap(BlockDriverState *bs,
         goto fail;
     }
 
-    granularity = 1U << bm->granularity_bits;
-    bitmap = bdrv_create_dirty_bitmap(bs, granularity, bm->name, errp);
-    if (bitmap == NULL) {
-        goto fail;
-    }
-
     ret = load_bitmap_data(bs, bitmap_table, bm->table.size, bitmap);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not read bitmap '%s' from image",
@@ -949,6 +949,7 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
     Qcow2Bitmap *bm;
     GSList *created_dirty_bitmaps = NULL;
     bool header_updated = false;
+    bool needs_update = false;
 
     if (s->nb_bitmaps == 0) {
         /* No bitmaps - nothing to do */
@@ -962,35 +963,39 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
     }
 
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
-        if (!(bm->flags & BME_FLAG_IN_USE)) {
-            BdrvDirtyBitmap *bitmap = load_bitmap(bs, bm, errp);
-            if (bitmap == NULL) {
-                goto fail;
-            }
-
-            if (!(bm->flags & BME_FLAG_AUTO)) {
-                bdrv_disable_dirty_bitmap(bitmap);
-            }
-            bdrv_dirty_bitmap_set_persistance(bitmap, true);
-            bm->flags |= BME_FLAG_IN_USE;
-            created_dirty_bitmaps =
-                    g_slist_append(created_dirty_bitmaps, bitmap);
+        BdrvDirtyBitmap *bitmap = load_bitmap(bs, bm, errp);
+        if (bitmap == NULL) {
+            goto fail;
         }
-    }
 
-    if (created_dirty_bitmaps != NULL) {
-        if (can_write(bs)) {
-            /* in_use flags must be updated */
-            int ret = update_ext_header_and_dir_in_place(bs, bm_list);
-            if (ret < 0) {
-                error_setg_errno(errp, -ret, "Can't update bitmap directory");
-                goto fail;
-            }
-            header_updated = true;
+        bdrv_dirty_bitmap_set_persistance(bitmap, true);
+        if (bm->flags & BME_FLAG_IN_USE) {
+            bdrv_dirty_bitmap_set_inconsistent(bitmap);
         } else {
-            g_slist_foreach(created_dirty_bitmaps, set_readonly_helper,
-                            (gpointer)true);
+            /* NB: updated flags only get written if can_write(bs) is true. */
+            bm->flags |= BME_FLAG_IN_USE;
+            needs_update = true;
         }
+        if (!(bm->flags & BME_FLAG_AUTO)) {
+            bdrv_disable_dirty_bitmap(bitmap);
+        }
+        created_dirty_bitmaps =
+            g_slist_append(created_dirty_bitmaps, bitmap);
+    }
+
+    if (needs_update && can_write(bs)) {
+        /* in_use flags must be updated */
+        int ret = update_ext_header_and_dir_in_place(bs, bm_list);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Can't update bitmap directory");
+            goto fail;
+        }
+        header_updated = true;
+    }
+
+    if (!can_write(bs)) {
+        g_slist_foreach(created_dirty_bitmaps, set_readonly_helper,
+                        (gpointer)true);
     }
 
     g_slist_free(created_dirty_bitmaps);
@@ -1112,23 +1117,21 @@ int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
     }
 
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
-        if (!(bm->flags & BME_FLAG_IN_USE)) {
-            BdrvDirtyBitmap *bitmap = bdrv_find_dirty_bitmap(bs, bm->name);
-            if (bitmap == NULL) {
-                continue;
-            }
-
-            if (!bdrv_dirty_bitmap_readonly(bitmap)) {
-                error_setg(errp, "Bitmap %s is not readonly but not marked"
-                                 "'IN_USE' in the image. Something went wrong,"
-                                 "all the bitmaps may be corrupted", bm->name);
-                ret = -EINVAL;
-                goto out;
-            }
+        BdrvDirtyBitmap *bitmap = bdrv_find_dirty_bitmap(bs, bm->name);
+        if (bitmap == NULL) {
+            continue;
+        }
 
-            bm->flags |= BME_FLAG_IN_USE;
-            ro_dirty_bitmaps = g_slist_append(ro_dirty_bitmaps, bitmap);
+        if (!bdrv_dirty_bitmap_readonly(bitmap)) {
+            error_setg(errp, "Bitmap %s was loaded prior to rw-reopen, but was "
+                       "not marked as readonly. This is a bug, something went "
+                       "wrong. All of the bitmaps may be corrupted", bm->name);
+            ret = -EINVAL;
+            goto out;
         }
+
+        bm->flags |= BME_FLAG_IN_USE;
+        ro_dirty_bitmaps = g_slist_append(ro_dirty_bitmaps, bitmap);
     }
 
     if (ro_dirty_bitmaps != NULL) {
@@ -1424,8 +1427,8 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
         Qcow2Bitmap *bm;
 
         if (!bdrv_dirty_bitmap_get_persistance(bitmap) ||
-            bdrv_dirty_bitmap_readonly(bitmap))
-        {
+            bdrv_dirty_bitmap_readonly(bitmap) ||
+            bdrv_dirty_bitmap_inconsistent(bitmap)) {
             continue;
         }
 
-- 
2.17.2

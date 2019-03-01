Received: from eggs.gnu.org ([209.51.188.92]:34824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gzndp-0002JL-C4
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:16:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gzndm-0008Jh-N6
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:16:17 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri,  1 Mar 2019 14:15:45 -0500
Message-Id: <20190301191545.8728-8-jsnow@redhat.com>
In-Reply-To: <20190301191545.8728-1-jsnow@redhat.com>
References: <20190301191545.8728-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 7/7] block/dirty-bitmaps: implement
 inconsistent bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>

Set the inconsistent bit on load instead of rejecting such bitmaps.
There is no way to un-set it; the only option is to delete it.

Obvervations:
- bitmap loading does not need to update the header for in_use bitmaps.
- inconsistent bitmaps don't need to have their data loaded; they're
  glorified corruption sentinels.
- bitmap saving does not need to save inconsistent bitmaps back to disk.
- bitmap reopening DOES need to drop the readonly flag from inconsistent
  bitmaps to allow reopening of qcow2 files with non-qemu-owned bitmaps
  being eventually flushed back to disk.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2-bitmap.c | 103 ++++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 50 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 3ee524da4b..c3b210ede1 100644
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
+        bdrv_dirty_bitmap_set_persistance(bitmap, true);
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

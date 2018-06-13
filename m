Received: from eggs.gnu.org ([2001:4830:134:3::10]:45993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSvAz-0001O4-Bd
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSvAy-0001eu-1q
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:06:21 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 12 Jun 2018 22:06:05 -0400
Message-Id: <20180613020613.1343-3-jsnow@redhat.com>
In-Reply-To: <20180613020613.1343-1-jsnow@redhat.com>
References: <20180613020613.1343-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/10] qcow2/bitmap: avoid adjusting
 bm->flags for RO bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>

Instead of always setting IN_USE, do this conditionally based on
whether or not the bitmap is read-only. Eliminate the two-pass
processing and move the second loop to the failure case.

This will allow us to show the flags exactly as they appear
on-disk for bitmaps in `qemu-img info`.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2-bitmap.c | 51 +++++++++++++++++++++------------------------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 0670e5eb41..85c1b5afe3 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -919,13 +919,6 @@ fail:
     return ret;
 }
 
-/* for g_slist_foreach for GSList of BdrvDirtyBitmap* elements */
-static void release_dirty_bitmap_helper(gpointer bitmap,
-                                        gpointer bs)
-{
-    bdrv_release_dirty_bitmap(bs, bitmap);
-}
-
 /* for g_slist_foreach for GSList of BdrvDirtyBitmap* elements */
 static void set_readonly_helper(gpointer bitmap, gpointer value)
 {
@@ -944,8 +937,7 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
     BDRVQcow2State *s = bs->opaque;
     Qcow2BitmapList *bm_list;
     Qcow2Bitmap *bm;
-    GSList *created_dirty_bitmaps = NULL;
-    bool header_updated = false;
+    bool needs_update = false;
 
     if (s->nb_bitmaps == 0) {
         /* No bitmaps - nothing to do */
@@ -968,35 +960,34 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
                 bdrv_disable_dirty_bitmap(bitmap);
             }
             bdrv_dirty_bitmap_set_persistance(bitmap, true);
-            bm->flags |= BME_FLAG_IN_USE;
-            created_dirty_bitmaps =
-                    g_slist_append(created_dirty_bitmaps, bitmap);
-        }
-    }
-
-    if (created_dirty_bitmaps != NULL) {
-        if (can_write(bs)) {
-            /* in_use flags must be updated */
-            int ret = update_ext_header_and_dir_in_place(bs, bm_list);
-            if (ret < 0) {
-                error_setg_errno(errp, -ret, "Can't update bitmap directory");
-                goto fail;
+            if (can_write(bs)) {
+                bm->flags |= BME_FLAG_IN_USE;
+                needs_update = true;
+            } else {
+                bdrv_dirty_bitmap_set_readonly(bitmap, true);
             }
-            header_updated = true;
-        } else {
-            g_slist_foreach(created_dirty_bitmaps, set_readonly_helper,
-                            (gpointer)true);
         }
     }
 
-    g_slist_free(created_dirty_bitmaps);
+    /* in_use flags must be updated */
+    if (needs_update) {
+        int ret = update_ext_header_and_dir_in_place(bs, bm_list);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Can't update bitmap directory");
+            goto fail;
+        }
+    }
+
     bitmap_list_free(bm_list);
 
-    return header_updated;
+    return needs_update;
 
 fail:
-    g_slist_foreach(created_dirty_bitmaps, release_dirty_bitmap_helper, bs);
-    g_slist_free(created_dirty_bitmaps);
+    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+        if (bm->dirty_bitmap) {
+            bdrv_release_dirty_bitmap(bs, bm->dirty_bitmap);
+        }
+    }
     bitmap_list_free(bm_list);
 
     return false;
-- 
2.14.3

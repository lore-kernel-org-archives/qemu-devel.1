Received: from eggs.gnu.org ([209.51.188.92]:40356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1Jiw-0007Ht-S5
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1Jiu-0005mr-Ux
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:43:50 -0500
From: John Snow <jsnow@redhat.com>
Date: Tue,  5 Mar 2019 18:43:34 -0500
Message-Id: <20190305234337.18353-3-jsnow@redhat.com>
In-Reply-To: <20190305234337.18353-1-jsnow@redhat.com>
References: <20190305234337.18353-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] block/qcow2-bitmap: Allow bitmap flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

Usually, we only write out bitmaps when we're about to close out the file,
so we always remove the bitmaps after to make it easier to determine the
source of truth for migration purposes.

However, there may be times we want to flush bitmap data more aggressively,
like after a truncate event where we need to make the metadata consistent
again.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2.h        |  1 +
 block/qcow2-bitmap.c | 45 ++++++++++++++++++++++++++++++--------------
 2 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 9dd02df831..4c1fdfcbec 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -690,6 +690,7 @@ int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
                                  Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+void qcow2_flush_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
 bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
                                       const char *name,
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index d02730004a..4e11b6b05a 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1392,7 +1392,7 @@ fail:
     bitmap_list_free(bm_list);
 }
 
-void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
+static void do_store_bitmaps(BlockDriverState *bs, bool remove, Error **errp)
 {
     BdrvDirtyBitmap *bitmap;
     BDRVQcow2State *s = bs->opaque;
@@ -1474,6 +1474,9 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
             QSIMPLEQ_INSERT_TAIL(&drop_tables, tb, entry);
         }
         bm->flags = bdrv_dirty_bitmap_enabled(bitmap) ? BME_FLAG_AUTO : 0;
+        if (!remove) {
+            bm->flags |= BME_FLAG_IN_USE;
+        }
         bm->granularity_bits = ctz32(bdrv_dirty_bitmap_granularity(bitmap));
         bm->dirty_bitmap = bitmap;
     }
@@ -1503,20 +1506,14 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
         g_free(tb);
     }
 
-    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
-        /* For safety, we remove bitmap after storing.
-         * We may be here in two cases:
-         * 1. bdrv_close. It's ok to drop bitmap.
-         * 2. inactivation. It means migration without 'dirty-bitmaps'
-         *    capability, so bitmaps are not marked with
-         *    BdrvDirtyBitmap.migration flags. It's not bad to drop them too,
-         *    and reload on invalidation.
-         */
-        if (bm->dirty_bitmap == NULL) {
-            continue;
-        }
+    if (remove) {
+        QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+            if (bm->dirty_bitmap == NULL) {
+                continue;
+            }
 
-        bdrv_release_dirty_bitmap(bs, bm->dirty_bitmap);
+            bdrv_release_dirty_bitmap(bs, bm->dirty_bitmap);
+        }
     }
 
     bitmap_list_free(bm_list);
@@ -1538,6 +1535,26 @@ fail:
     bitmap_list_free(bm_list);
 }
 
+void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
+{
+    /* For safety, we remove bitmap after storing.
+     * We may be here in two cases:
+     * 1. bdrv_close. It's ok to drop bitmap.
+     * 2. inactivation. It means migration without 'dirty-bitmaps'
+     *    capability, so bitmaps are not marked with
+     *    BdrvDirtyBitmap.migration flags. It's not bad to drop them too,
+     *    and reload on invalidation.
+     */
+    do_store_bitmaps(bs, true, errp);
+}
+
+void qcow2_flush_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
+{
+    /* We're here because of some event like resize or reopen_ro, and we want
+     * to flush bitmaps to disk without removing them from memory. */
+    do_store_bitmaps(bs, false, errp);
+}
+
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
 {
     BdrvDirtyBitmap *bitmap;
-- 
2.17.2

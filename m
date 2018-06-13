Received: from eggs.gnu.org ([2001:4830:134:3::10]:46025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSvB0-0001P3-57
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSvAy-0001f4-3h
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:06:22 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 12 Jun 2018 22:06:06 -0400
Message-Id: <20180613020613.1343-4-jsnow@redhat.com>
In-Reply-To: <20180613020613.1343-1-jsnow@redhat.com>
References: <20180613020613.1343-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/10] qcow2/bitmap: cache bm_list
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

We don't need to re-read this list every time, exactly. We can keep it cached
and delete our copy when we flush to disk.

Because we don't try to flush bitmaps on close if there's nothing to flush,
add a new conditional to delete the state anyway for a clean exit.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2-bitmap.c | 74 ++++++++++++++++++++++++++++++++++------------------
 block/qcow2.c        |  2 ++
 block/qcow2.h        |  2 ++
 3 files changed, 52 insertions(+), 26 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 85c1b5afe3..5ae9b17928 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -636,6 +636,34 @@ fail:
     return NULL;
 }
 
+static Qcow2BitmapList *get_bitmap_list(BlockDriverState *bs, Error **errp)
+{
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2BitmapList *bm_list;
+
+    if (s->bitmap_list) {
+        return (Qcow2BitmapList *)s->bitmap_list;
+    }
+
+    if (s->nb_bitmaps) {
+        bm_list = bitmap_list_load(bs, errp);
+    } else {
+        bm_list = bitmap_list_new();
+    }
+    s->bitmap_list = bm_list;
+    return bm_list;
+}
+
+static void del_bitmap_list(BlockDriverState *bs)
+{
+    BDRVQcow2State *s = bs->opaque;
+
+    if (s->bitmap_list) {
+        bitmap_list_free(s->bitmap_list);
+        s->bitmap_list = NULL;
+    }
+}
+
 int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                   void **refcount_table,
                                   int64_t *refcount_table_size)
@@ -656,7 +684,7 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
         return ret;
     }
 
-    bm_list = bitmap_list_load(bs, NULL);
+    bm_list = get_bitmap_list(bs, NULL);
     if (bm_list == NULL) {
         res->corruptions++;
         return -EINVAL;
@@ -706,8 +734,6 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
     }
 
 out:
-    bitmap_list_free(bm_list);
-
     return ret;
 }
 
@@ -944,7 +970,7 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
         return false;
     }
 
-    bm_list = bitmap_list_load(bs, errp);
+    bm_list = get_bitmap_list(bs, errp);
     if (bm_list == NULL) {
         return false;
     }
@@ -978,8 +1004,6 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
         }
     }
 
-    bitmap_list_free(bm_list);
-
     return needs_update;
 
 fail:
@@ -988,8 +1012,7 @@ fail:
             bdrv_release_dirty_bitmap(bs, bm->dirty_bitmap);
         }
     }
-    bitmap_list_free(bm_list);
-
+    del_bitmap_list(bs);
     return false;
 }
 
@@ -1016,7 +1039,7 @@ int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
         return -EINVAL;
     }
 
-    bm_list = bitmap_list_load(bs, errp);
+    bm_list = get_bitmap_list(bs, errp);
     if (bm_list == NULL) {
         return -EINVAL;
     }
@@ -1056,7 +1079,6 @@ int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
 
 out:
     g_slist_free(ro_dirty_bitmaps);
-    bitmap_list_free(bm_list);
 
     return ret;
 }
@@ -1265,7 +1287,7 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
         return;
     }
 
-    bm_list = bitmap_list_load(bs, errp);
+    bm_list = get_bitmap_list(bs, errp);
     if (bm_list == NULL) {
         return;
     }
@@ -1287,7 +1309,11 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
 
 fail:
     bitmap_free(bm);
-    bitmap_list_free(bm_list);
+}
+
+void qcow2_persistent_dirty_bitmaps_cache_destroy(BlockDriverState *bs)
+{
+    del_bitmap_list(bs);
 }
 
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
@@ -1304,23 +1330,19 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
 
     if (!bdrv_has_changed_persistent_bitmaps(bs)) {
         /* nothing to do */
-        return;
+        goto out;
     }
 
     if (!can_write(bs)) {
         error_setg(errp, "No write access");
-        return;
+        goto out;
     }
 
     QSIMPLEQ_INIT(&drop_tables);
 
-    if (s->nb_bitmaps == 0) {
-        bm_list = bitmap_list_new();
-    } else {
-        bm_list = bitmap_list_load(bs, errp);
-        if (bm_list == NULL) {
-            return;
-        }
+    bm_list = get_bitmap_list(bs, errp);
+    if (bm_list == NULL) {
+        goto out;
     }
 
     /* check constraints and names */
@@ -1400,8 +1422,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
         g_free(tb);
     }
 
-    bitmap_list_free(bm_list);
-    return;
+    goto out;
 
 fail:
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
@@ -1416,7 +1437,9 @@ fail:
         g_free(tb);
     }
 
-    bitmap_list_free(bm_list);
+ out:
+    del_bitmap_list(bs);
+    return;
 }
 
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
@@ -1481,13 +1504,12 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
         goto fail;
     }
 
-    bm_list = bitmap_list_load(bs, errp);
+    bm_list = get_bitmap_list(bs, errp);
     if (bm_list == NULL) {
         goto fail;
     }
 
     found = find_bitmap_by_name(bm_list, name);
-    bitmap_list_free(bm_list);
     if (found) {
         error_setg(errp, "Bitmap with the same name is already stored");
         goto fail;
diff --git a/block/qcow2.c b/block/qcow2.c
index 6fa5e1d71a..dbd334b150 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2148,6 +2148,8 @@ static void qcow2_close(BlockDriverState *bs)
 
     if (!(s->flags & BDRV_O_INACTIVE)) {
         qcow2_inactivate(bs);
+    } else {
+        qcow2_persistent_dirty_bitmaps_cache_destroy(bs);
     }
 
     cache_clean_timer_del(bs);
diff --git a/block/qcow2.h b/block/qcow2.h
index 01b5250415..29b637a0ee 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -295,6 +295,7 @@ typedef struct BDRVQcow2State {
     uint64_t bitmap_directory_size;
     uint64_t bitmap_directory_offset;
     bool dirty_bitmaps_loaded;
+    void *bitmap_list;
 
     int flags;
     int qcow_version;
@@ -671,6 +672,7 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
                                  Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
+void qcow2_persistent_dirty_bitmaps_cache_destroy(BlockDriverState *bs);
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
 bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
-- 
2.14.3

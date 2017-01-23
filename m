Received: from eggs.gnu.org ([2001:4830:134:3::10]:36442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdSW-0002Iz-2h
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdSO-0005Do-QZ
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:52 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:21118 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cVdSO-0005AJ-AO
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:44 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 23 Jan 2017 15:10:36 +0300
Message-Id: <20170123121036.4823-25-vsementsov@virtuozzo.com>
In-Reply-To: <20170123121036.4823-1-vsementsov@virtuozzo.com>
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 24/24] qcow2-bitmap: cache bitmap list in
 BDRVQcow2State
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com

Do not reload bitmap list every time it is needed.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-bitmap.c | 125 ++++++++++++++++++++++++++++++++++-----------------
 block/qcow2.c        |   2 +
 block/qcow2.h        |   4 ++
 3 files changed, 89 insertions(+), 42 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index be026fc80e..dd987a111c 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -79,7 +79,7 @@ typedef struct Qcow2BitmapTable {
 } Qcow2BitmapTable;
 typedef QSIMPLEQ_HEAD(Qcow2BitmapTableList, Qcow2BitmapTable) Qcow2BitmapTableList;
 
-typedef struct Qcow2Bitmap {
+struct Qcow2Bitmap {
     Qcow2BitmapTable table;
     uint32_t flags;
     uint8_t granularity_bits;
@@ -88,8 +88,7 @@ typedef struct Qcow2Bitmap {
     BdrvDirtyBitmap *dirty_bitmap;
 
     QSIMPLEQ_ENTRY(Qcow2Bitmap) entry;
-} Qcow2Bitmap;
-typedef QSIMPLEQ_HEAD(Qcow2BitmapList, Qcow2Bitmap) Qcow2BitmapList;
+};
 
 typedef enum BitmapType {
     BT_DIRTY_TRACKING_BITMAP = 1
@@ -492,6 +491,14 @@ static void bitmap_free(Qcow2Bitmap *bm)
     g_free(bm);
 }
 
+static Qcow2Bitmap *bitmap_dup(Qcow2Bitmap *bm)
+{
+    Qcow2Bitmap *copy = g_memdup(bm, sizeof(*bm));
+    copy->name = g_strdup(bm->name);
+
+    return copy;
+}
+
 static void bitmap_list_free(Qcow2BitmapList *bm_list)
 {
     Qcow2Bitmap *bm;
@@ -729,6 +736,44 @@ fail:
  * Bitmap List end
  */
 
+static const Qcow2BitmapList *qcow2_get_bitmap_list_const(BlockDriverState *bs,
+                                                          Error **errp)
+{
+    BDRVQcow2State *s = bs->opaque;
+
+    if (s->bitmaps != NULL) {
+        return s->bitmaps;
+    }
+
+    if (s->nb_bitmaps == 0) {
+        return NULL;
+    }
+
+    return s->bitmaps = bitmap_list_load(bs, s->bitmap_directory_offset,
+                                         s->bitmap_directory_size, errp);
+}
+
+static Qcow2BitmapList *qcow2_get_bitmap_list(BlockDriverState *bs,
+                                              Error **errp)
+{
+    Qcow2Bitmap *bm;
+    Qcow2BitmapList *bm_list_copy;
+    const Qcow2BitmapList *bm_list = qcow2_get_bitmap_list_const(bs, errp);
+
+    if (bm_list == NULL) {
+        return NULL;
+    }
+
+    bm_list_copy = bitmap_list_new();
+
+    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+        QSIMPLEQ_INSERT_TAIL(bm_list_copy, bitmap_dup(bm), entry);
+    }
+
+    return bm_list_copy;
+}
+
+/* This function consumes bm_list on success. */
 static int update_ext_header_and_dir_in_place(BlockDriverState *bs,
                                               Qcow2BitmapList *bm_list)
 {
@@ -759,9 +804,20 @@ static int update_ext_header_and_dir_in_place(BlockDriverState *bs,
     }
 
     s->autoclear_features |= QCOW2_AUTOCLEAR_BITMAPS;
-    return update_header_sync(bs);
+    ret = update_header_sync(bs);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /* success, consume bm_list */
+    assert(s->bitmaps != bm_list);
+    bitmap_list_free(s->bitmaps);
+    s->bitmaps = bm_list;
+
+    return 0;
 }
 
+/* This function consumes bm_list on success. */
 static int update_ext_header_and_dir(BlockDriverState *bs,
                                      Qcow2BitmapList *bm_list)
 {
@@ -810,6 +866,11 @@ static int update_ext_header_and_dir(BlockDriverState *bs,
         qcow2_free_clusters(bs, old_offset, old_size, QCOW2_DISCARD_OTHER);
     }
 
+    /* success, consume bm_list */
+    assert(s->bitmaps != bm_list);
+    bitmap_list_free(s->bitmaps);
+    s->bitmaps = bm_list;
+
     return 0;
 
 fail:
@@ -834,18 +895,11 @@ static void release_dirty_bitmap_helper(gpointer bitmap,
 
 void qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp)
 {
-    BDRVQcow2State *s = bs->opaque;
     Qcow2BitmapList *bm_list;
     Qcow2Bitmap *bm;
     GSList *created_dirty_bitmaps = NULL;
 
-    if (s->nb_bitmaps == 0) {
-        /* No bitmaps - nothing to do */
-        return;
-    }
-
-    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
-                               s->bitmap_directory_size, errp);
+    bm_list = qcow2_get_bitmap_list(bs, errp);
     if (bm_list == NULL) {
         return;
     }
@@ -875,9 +929,8 @@ void qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp)
     }
 
     g_slist_free(created_dirty_bitmaps);
-    bitmap_list_free(bm_list);
 
-    return;
+    return; /* bm_list is consumed */
 
 fail:
     g_slist_foreach(created_dirty_bitmaps, release_dirty_bitmap_helper, bs);
@@ -1069,17 +1122,10 @@ void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
                                           Error **errp)
 {
     int ret;
-    BDRVQcow2State *s = bs->opaque;
     Qcow2Bitmap *bm;
     Qcow2BitmapList *bm_list;
 
-    if (s->nb_bitmaps == 0) {
-        /* No bitmaps - nothing to do */
-        return;
-    }
-
-    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
-                               s->bitmap_directory_size, errp);
+    bm_list = qcow2_get_bitmap_list(bs, errp);
     if (bm_list == NULL) {
         return;
     }
@@ -1131,10 +1177,8 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
     if (s->nb_bitmaps == 0) {
         bm_list = bitmap_list_new();
     } else {
-        bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
-                                   s->bitmap_directory_size, errp);
+        bm_list = qcow2_get_bitmap_list(bs, errp);
         if (bm_list == NULL) {
-            /* errp is already set */
             return;
         }
     }
@@ -1214,8 +1258,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
         g_free(tb);
     }
 
-    bitmap_list_free(bm_list);
-    return;
+    return; /* bm_list is consumed */
 
 fail:
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
@@ -1252,8 +1295,7 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
         return true;
     }
 
-    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
-                               s->bitmap_directory_size, errp);
+    bm_list = qcow2_get_bitmap_list(bs, errp);
     if (bm_list == NULL) {
         return false;
     }
@@ -1279,7 +1321,7 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
 {
     int ret;
     BDRVQcow2State *s = bs->opaque;
-    Qcow2BitmapList *bm_list;
+    const Qcow2BitmapList *bm_list;
     Qcow2Bitmap *bm;
 
     if (s->nb_bitmaps == 0) {
@@ -1293,8 +1335,7 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
         return ret;
     }
 
-    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
-                               s->bitmap_directory_size, NULL);
+    bm_list = qcow2_get_bitmap_list_const(bs, NULL);
     if (bm_list == NULL) {
         res->corruptions++;
         return -EINVAL;
@@ -1309,13 +1350,13 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                        bm->table.offset,
                                        bm->table.size * sizeof(uint64_t));
         if (ret < 0) {
-            goto out;
+            return ret;
         }
 
         ret = bitmap_table_load(bs, &bm->table, &bitmap_table);
         if (ret < 0) {
             res->corruptions++;
-            goto out;
+            return ret;
         }
 
         for (i = 0; i < bm->table.size; ++i) {
@@ -1336,19 +1377,19 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                            offset, s->cluster_size);
             if (ret < 0) {
                 g_free(bitmap_table);
-                goto out;
+                return ret;
             }
         }
 
         g_free(bitmap_table);
     }
 
-    if (res->corruptions > 0) {
-        ret = -EINVAL;
-    }
-
-out:
-    bitmap_list_free(bm_list);
+    return res->corruptions > 0 ? -EINVAL : 0;
+}
 
-    return ret;
+void qcow2_free_bitmaps(BlockDriverState *bs)
+{
+    BDRVQcow2State *s = bs->opaque;
+    bitmap_list_free(s->bitmaps);
+    s->bitmaps = NULL;
 }
diff --git a/block/qcow2.c b/block/qcow2.c
index f6bac38e51..f6544d52ad 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1850,6 +1850,8 @@ static void qcow2_close(BlockDriverState *bs)
     qemu_vfree(s->cluster_data);
     qcow2_refcount_close(bs);
     qcow2_free_snapshots(bs);
+
+    qcow2_free_bitmaps(bs);
 }
 
 static void qcow2_invalidate_cache(BlockDriverState *bs, Error **errp)
diff --git a/block/qcow2.h b/block/qcow2.h
index a009827f60..ed8f5a73b0 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -242,6 +242,8 @@ typedef struct Qcow2BitmapHeaderExt {
     uint64_t bitmap_directory_offset;
 } QEMU_PACKED Qcow2BitmapHeaderExt;
 
+typedef struct Qcow2Bitmap Qcow2Bitmap;
+typedef QSIMPLEQ_HEAD(Qcow2BitmapList, Qcow2Bitmap) Qcow2BitmapList;
 typedef struct BDRVQcow2State {
     int cluster_bits;
     int cluster_size;
@@ -286,6 +288,7 @@ typedef struct BDRVQcow2State {
     uint32_t nb_bitmaps;
     uint64_t bitmap_directory_size;
     uint64_t bitmap_directory_offset;
+    Qcow2BitmapList *bitmaps; /* cached version of bitmaps list in file */
 
     int flags;
     int qcow_version;
@@ -630,5 +633,6 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
 void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
                                           const char *name,
                                           Error **errp);
+void qcow2_free_bitmaps(BlockDriverState *bs);
 
 #endif
-- 
2.11.0

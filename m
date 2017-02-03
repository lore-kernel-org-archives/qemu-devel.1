Received: from eggs.gnu.org ([2001:4830:134:3::10]:46585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZaM2-00044C-Bm
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:40:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZaLy-0004QT-1Z
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:40:30 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:3656 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cZaLx-0004Nh-Ir
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:40:25 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  3 Feb 2017 12:40:17 +0300
Message-Id: <20170203094018.15493-24-vsementsov@virtuozzo.com>
In-Reply-To: <20170203094018.15493-1-vsementsov@virtuozzo.com>
References: <20170203094018.15493-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 23/24] qcow2: add
 .bdrv_remove_persistent_dirty_bitmap
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

Realize .bdrv_remove_persistent_dirty_bitmap interface.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-bitmap.c | 41 +++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c        |  1 +
 block/qcow2.h        |  3 +++
 3 files changed, 45 insertions(+)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 590a0fcc8e..cfa1943071 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1065,6 +1065,47 @@ static Qcow2Bitmap *find_bitmap_by_name(Qcow2BitmapList *bm_list,
     return NULL;
 }
 
+void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
+                                          const char *name,
+                                          Error **errp)
+{
+    int ret;
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2Bitmap *bm;
+    Qcow2BitmapList *bm_list;
+
+    if (s->nb_bitmaps == 0) {
+        /* Absence of the bitmap is not an error: see explanation above
+         * bdrv_remove_persistent_dirty_bitmap() definition. */
+        return;
+    }
+
+    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
+                               s->bitmap_directory_size, errp);
+    if (bm_list == NULL) {
+        return;
+    }
+
+    bm = find_bitmap_by_name(bm_list, name);
+    if (bm == NULL) {
+        goto fail;
+    }
+
+    QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);
+
+    ret = update_ext_header_and_dir(bs, bm_list);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to update bitmap extension");
+        goto fail;
+    }
+
+    free_bitmap_clusters(bs, &bm->table);
+
+fail:
+    bitmap_free(bm);
+    bitmap_list_free(bm_list);
+}
+
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
 {
     BdrvDirtyBitmap *bitmap;
diff --git a/block/qcow2.c b/block/qcow2.c
index 166a43bd05..9d3a2f4879 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3544,6 +3544,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_load_autoloading_dirty_bitmaps = qcow2_load_autoloading_dirty_bitmaps,
     .bdrv_store_persistent_dirty_bitmaps = qcow2_store_persistent_dirty_bitmaps,
     .bdrv_can_store_new_dirty_bitmap = qcow2_can_store_new_dirty_bitmap,
+    .bdrv_remove_persistent_dirty_bitmap = qcow2_remove_persistent_dirty_bitmap,
 };
 
 static void bdrv_qcow2_init(void)
diff --git a/block/qcow2.h b/block/qcow2.h
index eaad34a527..a009827f60 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -627,5 +627,8 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
 int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                   void **refcount_table,
                                   int64_t *refcount_table_size);
+void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
+                                          const char *name,
+                                          Error **errp);
 
 #endif
-- 
2.11.0

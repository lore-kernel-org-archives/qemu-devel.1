Received: from eggs.gnu.org ([2001:4830:134:3::10]:36332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdST-0002HJ-FB
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cVdSO-0005DS-KE
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:49 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:3740 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cVdSO-0005AC-9L
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:10:44 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 23 Jan 2017 15:10:35 +0300
Message-Id: <20170123121036.4823-24-vsementsov@virtuozzo.com>
In-Reply-To: <20170123121036.4823-1-vsementsov@virtuozzo.com>
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
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
 block/qcow2-bitmap.c | 40 ++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c        |  1 +
 block/qcow2.h        |  3 +++
 3 files changed, 44 insertions(+)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 2687a3acd5..be026fc80e 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1064,6 +1064,46 @@ static Qcow2Bitmap *find_bitmap_by_name(Qcow2BitmapList *bm_list,
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
+        /* No bitmaps - nothing to do */
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
index 76a6a2ba28..f6bac38e51 100644
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

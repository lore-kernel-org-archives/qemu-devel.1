Received: from eggs.gnu.org ([2001:4830:134:3::10]:44143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1chfpL-0006ZU-D7
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 12:08:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1chfpH-0001VE-1Y
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 12:08:11 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:25186 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1chfpG-0001Ti-LV
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 12:08:06 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat, 25 Feb 2017 20:07:51 +0300
Message-Id: <20170225170758.427066-16-vsementsov@virtuozzo.com>
In-Reply-To: <20170225170758.427066-1-vsementsov@virtuozzo.com>
References: <20170225170758.427066-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v16 15/22] qcow2: add
 .bdrv_can_store_new_dirty_bitmap
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

Realize .bdrv_can_store_new_dirty_bitmap interface.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block/qcow2-bitmap.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c        |  2 ++
 block/qcow2.h        |  4 ++++
 3 files changed, 57 insertions(+)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index e377215d5c..8c0c24c208 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1280,3 +1280,54 @@ fail:
 
     bitmap_list_free(bm_list);
 }
+
+bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
+                                      const char *name,
+                                      uint32_t granularity,
+                                      Error **errp)
+{
+    BDRVQcow2State *s = bs->opaque;
+    bool found;
+    Qcow2BitmapList *bm_list;
+
+    if (check_constraints_on_bitmap(bs, name, granularity, errp) != 0) {
+        goto fail;
+    }
+
+    if (s->nb_bitmaps == 0) {
+        return true;
+    }
+
+    if (s->nb_bitmaps >= QCOW2_MAX_BITMAPS) {
+        error_setg(errp,
+                   "Maximum number of persistent bitmaps is already reached");
+        goto fail;
+    }
+
+    if (s->bitmap_directory_size + calc_dir_entry_size(strlen(name), 0) >
+        QCOW2_MAX_BITMAP_DIRECTORY_SIZE)
+    {
+        error_setg(errp, "No enough space in the bitmap directory");
+        goto fail;
+    }
+
+    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
+                               s->bitmap_directory_size, errp);
+    if (bm_list == NULL) {
+        goto fail;
+    }
+
+    found = find_bitmap_by_name(bm_list, name);
+    bitmap_list_free(bm_list);
+    if (found) {
+        error_setg(errp, "Bitmap with the same name is already stored");
+        goto fail;
+    }
+
+    return true;
+
+fail:
+    error_prepend(errp, "Can't make bitmap '%s' persistent in '%s': ",
+                  name, bdrv_get_device_or_node_name(bs));
+    return false;
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index 201e7186f0..8f7937dc50 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3555,6 +3555,8 @@ BlockDriver bdrv_qcow2 = {
 
     .bdrv_detach_aio_context  = qcow2_detach_aio_context,
     .bdrv_attach_aio_context  = qcow2_attach_aio_context,
+
+    .bdrv_can_store_new_dirty_bitmap = qcow2_can_store_new_dirty_bitmap,
 };
 
 static void bdrv_qcow2_init(void)
diff --git a/block/qcow2.h b/block/qcow2.h
index e2ef5698cd..c291858425 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -622,5 +622,9 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                   int64_t *refcount_table_size);
 void qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
+                                      const char *name,
+                                      uint32_t granularity,
+                                      Error **errp);
 
 #endif
-- 
2.11.1

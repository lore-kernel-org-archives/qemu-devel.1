Received: from eggs.gnu.org ([2001:4830:134:3::10]:59729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dKmQV-0001hR-8S
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dKmQS-0005Kr-5j
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:04:11 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:39839 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dKmQR-0005Hr-R1
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:04:08 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 13 Jun 2017 17:03:50 +0300
Message-Id: <20170613140358.81651-23-vsementsov@virtuozzo.com>
In-Reply-To: <20170613140358.81651-1-vsementsov@virtuozzo.com>
References: <20170613140358.81651-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v21 22/30] qcow2: add
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
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-bitmap.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c        |  1 +
 block/qcow2.h        |  4 ++++
 3 files changed, 56 insertions(+)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 7912a82c8c..f45324e584 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1387,3 +1387,54 @@ int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
 
     return 0;
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
+        error_setg(errp, "Not enough space in the bitmap directory");
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
index 76603903ff..77260df512 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3612,6 +3612,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_attach_aio_context  = qcow2_attach_aio_context,
 
     .bdrv_reopen_bitmaps_rw = qcow2_reopen_bitmaps_rw,
+    .bdrv_can_store_new_dirty_bitmap = qcow2_can_store_new_dirty_bitmap,
 };
 
 static void bdrv_qcow2_init(void)
diff --git a/block/qcow2.h b/block/qcow2.h
index 7d0a20c053..8b2f66f8b6 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -633,5 +633,9 @@ bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
+bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
+                                      const char *name,
+                                      uint32_t granularity,
+                                      Error **errp);
 
 #endif
-- 
2.11.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxkw-0000ib-FS
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxkv-0006bN-Ev
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:11:22 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:33 +0200
Message-Id: <20170711160814.20941-45-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 44/85] qcow2: add
 .bdrv_can_store_new_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Realize .bdrv_can_store_new_dirty_bitmap interface.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170628120530.31251-23-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h        |  4 ++++
 block/qcow2-bitmap.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c        |  1 +
 3 files changed, 56 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index 1f80b5d..084a298 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -649,5 +649,9 @@ bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
+bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
+                                      const char *name,
+                                      uint32_t granularity,
+                                      Error **errp);
 
 #endif
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index f82478c..a8c7e1d 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1388,3 +1388,54 @@ int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
 
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
index 1a31f1d..d7046a3 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3989,6 +3989,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_attach_aio_context  = qcow2_attach_aio_context,
 
     .bdrv_reopen_bitmaps_rw = qcow2_reopen_bitmaps_rw,
+    .bdrv_can_store_new_dirty_bitmap = qcow2_can_store_new_dirty_bitmap,
 };
 
 static void bdrv_qcow2_init(void)
-- 
2.9.4

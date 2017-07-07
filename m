Received: from eggs.gnu.org ([2001:4830:134:3::10]:43269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmN-0006Rh-61
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmM-0000ly-10
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:55 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:31 +0200
Message-Id: <1499447335-6125-77-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 076/100] qcow2: support .bdrv_reopen_bitmaps_rw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Realize bdrv_reopen_bitmaps_rw interface.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170628120530.31251-15-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-bitmap.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c        |  2 ++
 block/qcow2.h        |  1 +
 3 files changed, 64 insertions(+)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 2c7b057..a21fab8 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -826,3 +826,64 @@ fail:
 
     return false;
 }
+
+int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
+{
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2BitmapList *bm_list;
+    Qcow2Bitmap *bm;
+    GSList *ro_dirty_bitmaps = NULL;
+    int ret = 0;
+
+    if (s->nb_bitmaps == 0) {
+        /* No bitmaps - nothing to do */
+        return 0;
+    }
+
+    if (!can_write(bs)) {
+        error_setg(errp, "Can't write to the image on reopening bitmaps rw");
+        return -EINVAL;
+    }
+
+    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
+                               s->bitmap_directory_size, errp);
+    if (bm_list == NULL) {
+        return -EINVAL;
+    }
+
+    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+        if (!(bm->flags & BME_FLAG_IN_USE)) {
+            BdrvDirtyBitmap *bitmap = bdrv_find_dirty_bitmap(bs, bm->name);
+            if (bitmap == NULL) {
+                continue;
+            }
+
+            if (!bdrv_dirty_bitmap_readonly(bitmap)) {
+                error_setg(errp, "Bitmap %s is not readonly but not marked"
+                                 "'IN_USE' in the image. Something went wrong,"
+                                 "all the bitmaps may be corrupted", bm->name);
+                ret = -EINVAL;
+                goto out;
+            }
+
+            bm->flags |= BME_FLAG_IN_USE;
+            ro_dirty_bitmaps = g_slist_append(ro_dirty_bitmaps, bitmap);
+        }
+    }
+
+    if (ro_dirty_bitmaps != NULL) {
+        /* in_use flags must be updated */
+        ret = update_ext_header_and_dir_in_place(bs, bm_list);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Can't update bitmap directory");
+            goto out;
+        }
+        g_slist_foreach(ro_dirty_bitmaps, set_readonly_helper, false);
+    }
+
+out:
+    g_slist_free(ro_dirty_bitmaps);
+    bitmap_list_free(bm_list);
+
+    return ret;
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index 8645b08..19cc49a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3973,6 +3973,8 @@ BlockDriver bdrv_qcow2 = {
 
     .bdrv_detach_aio_context  = qcow2_detach_aio_context,
     .bdrv_attach_aio_context  = qcow2_attach_aio_context,
+
+    .bdrv_reopen_bitmaps_rw = qcow2_reopen_bitmaps_rw,
 };
 
 static void bdrv_qcow2_init(void)
diff --git a/block/qcow2.h b/block/qcow2.h
index 886480b..633bd43 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -646,5 +646,6 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                   void **refcount_table,
                                   int64_t *refcount_table_size);
 bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
 
 #endif
-- 
1.8.3.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBj6-0006QP-Q6
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQBj3-000332-5p
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:44 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:14838 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dQBj2-0002v7-Pt
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:05:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 28 Jun 2017 15:05:14 +0300
Message-Id: <20170628120530.31251-15-vsementsov@virtuozzo.com>
In-Reply-To: <20170628120530.31251-1-vsementsov@virtuozzo.com>
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v22 14/30] qcow2: support
 .bdrv_reopen_bitmaps_rw
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

Realize bdrv_reopen_bitmaps_rw interface.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-bitmap.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c        |  2 ++
 block/qcow2.h        |  1 +
 3 files changed, 64 insertions(+)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 2c7b057e21..a21fab8ce8 100644
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
index 92e8ff064d..8f070b12a2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3595,6 +3595,8 @@ BlockDriver bdrv_qcow2 = {
 
     .bdrv_detach_aio_context  = qcow2_detach_aio_context,
     .bdrv_attach_aio_context  = qcow2_attach_aio_context,
+
+    .bdrv_reopen_bitmaps_rw = qcow2_reopen_bitmaps_rw,
 };
 
 static void bdrv_qcow2_init(void)
diff --git a/block/qcow2.h b/block/qcow2.h
index 67c61de008..3e23bb7361 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -630,5 +630,6 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                   void **refcount_table,
                                   int64_t *refcount_table_size);
 bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
 
 #endif
-- 
2.11.1

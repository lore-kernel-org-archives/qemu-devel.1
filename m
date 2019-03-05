Received: from eggs.gnu.org ([209.51.188.92]:40430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1Jj1-0007NF-Jd
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:43:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1Jiy-0005pc-UO
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:43:54 -0500
From: John Snow <jsnow@redhat.com>
Date: Tue,  5 Mar 2019 18:43:36 -0500
Message-Id: <20190305234337.18353-5-jsnow@redhat.com>
In-Reply-To: <20190305234337.18353-1-jsnow@redhat.com>
References: <20190305234337.18353-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] block/qcow2-bitmap: Allow resizes with
 persistent bitmaps
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

Since we now load all bitmaps into memory anyway, we can just truncate them
in-memory and then flush them back to disk. Just in case, we will still check
and enforce that this shortcut is valid -- i.e. that any bitmap described
on-disk is indeed in-memory and can be modified.

If there are any inconsistent bitmaps, we refuse to allow the truncate as
we do not actually load these bitmaps into memory, and it isn't safe or
reasonable to attempt to truncate corrupted data.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2.h        |  1 +
 block/qcow2-bitmap.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c        | 27 ++++++++++++++++++++-------
 3 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 4c1fdfcbec..b9227a72cc 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -689,6 +689,7 @@ Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
 int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
                                  Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
+int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 void qcow2_flush_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 9373055d3b..24f280bccc 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1167,6 +1167,48 @@ int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
     return qcow2_reopen_bitmaps_rw_hint(bs, NULL, errp);
 }
 
+/* Checks to see if it's safe to resize bitmaps */
+int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp)
+{
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2BitmapList *bm_list;
+    Qcow2Bitmap *bm;
+    int ret = 0;
+
+    if (s->nb_bitmaps == 0) {
+        return 0;
+    }
+
+    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
+                               s->bitmap_directory_size, false, errp);
+    if (bm_list == NULL) {
+        return -EINVAL;
+    }
+
+    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+        BdrvDirtyBitmap *bitmap = bdrv_find_dirty_bitmap(bs, bm->name);
+        if (bitmap == NULL) {
+            /* We rely on all bitmaps being in-memory to be able to resize them,
+             * Otherwise, we'd need to resize them on disk explicitly */
+            error_setg(errp, "Cannot resize qcow2 with persistent bitmaps that "
+                       "were not loaded into memory");
+            ret = -ENOTSUP;
+            goto out;
+        }
+
+        /* The checks against readonly and busy are redundant, but certainly
+         * do no harm. checks against inconsistent are crucial: */
+        if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, errp)) {
+            ret = -ENOTSUP;
+            goto out;
+        }
+    }
+
+out:
+    bitmap_list_free(bm_list);
+    return ret;
+}
+
 /* store_bitmap_data()
  * Store bitmap to image, filling bitmap table accordingly.
  */
diff --git a/block/qcow2.c b/block/qcow2.c
index 7fb2730f09..6fd9252494 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3472,7 +3472,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t old_length;
-    int64_t new_l1_size;
+    int64_t new_l1_size, offset_be;
     int ret;
     QDict *options;
 
@@ -3498,10 +3498,8 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
         goto fail;
     }
 
-    /* cannot proceed if image has bitmaps */
-    if (s->nb_bitmaps) {
-        /* TODO: resize bitmaps in the image */
-        error_setg(errp, "Can't resize an image which has bitmaps");
+    /* Only certain persistent bitmaps can be resized: */
+    if (qcow2_truncate_bitmaps_check(bs, errp)) {
         ret = -ENOTSUP;
         goto fail;
     }
@@ -3702,9 +3700,9 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
     bs->total_sectors = offset / BDRV_SECTOR_SIZE;
 
     /* write updated header.size */
-    offset = cpu_to_be64(offset);
+    offset_be = cpu_to_be64(offset);
     ret = bdrv_pwrite_sync(bs->file, offsetof(QCowHeader, size),
-                           &offset, sizeof(uint64_t));
+                           &offset_be, sizeof(uint64_t));
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to update the image size");
         goto fail;
@@ -3719,6 +3717,21 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
     if (ret < 0) {
         goto fail;
     }
+
+    /* Flush bitmaps */
+    if (s->nb_bitmaps) {
+        Error *local_err = NULL;
+
+        /* Usually, bitmaps get resized after this call.
+         * Force it earlier so we can make the metadata consistent. */
+        bdrv_dirty_bitmap_truncate(bs, offset);
+        qcow2_flush_persistent_dirty_bitmaps(bs, &local_err);
+        if (local_err) {
+            ret = -EINVAL;
+            goto fail;
+        }
+    }
+
     ret = 0;
 fail:
     qemu_co_mutex_unlock(&s->lock);
-- 
2.17.2

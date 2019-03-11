Received: from eggs.gnu.org ([209.51.188.92]:56233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h3Q1h-0004rb-CC
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h3Q1g-0005NE-4X
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:51:53 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 11 Mar 2019 21:51:46 +0300
Message-Id: <20190311185147.52309-4-vsementsov@virtuozzo.com>
In-Reply-To: <20190311185147.52309-1-vsementsov@virtuozzo.com>
References: <20190311185147.52309-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 3/4] block/qcow2-bitmap: Allow resizes with
 persistent bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com, eblake@redhat.com, den@virtuozzo.com

From: John Snow <jsnow@redhat.com>

Since we now load all bitmaps into memory anyway, we can just truncate
them in-memory and then flush them back to disk. Just in case, we will
still check and enforce that this shortcut is valid -- i.e. that any
bitmap described on-disk is indeed in-memory and can be modified.

If there are any inconsistent bitmaps, we refuse to allow the truncate
as we do not actually load these bitmaps into memory, and it isn't safe
or reasonable to attempt to truncate corrupted data.

Signed-off-by: John Snow <jsnow@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
  [vsementsov: drop bitmap flushing, fix block comments style]
---
 block/qcow2.h        |  1 +
 block/qcow2-bitmap.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c        |  4 +---
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 9dd02df831..bbac694a84 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -689,6 +689,7 @@ Qcow2BitmapInfoList *qcow2_get_bitmap_info_list(BlockDriverState *bs,
 int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_updated,
                                  Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
+int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
 bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 141bc1e52c..6ffeae36c2 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1174,6 +1174,52 @@ int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp)
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
+                               s->bitmap_directory_size, errp);
+    if (bm_list == NULL) {
+        return -EINVAL;
+    }
+
+    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+        BdrvDirtyBitmap *bitmap = bdrv_find_dirty_bitmap(bs, bm->name);
+        if (bitmap == NULL) {
+            /*
+             * We rely on all bitmaps being in-memory to be able to resize them,
+             * Otherwise, we'd need to resize them on disk explicitly
+             */
+            error_setg(errp, "Cannot resize qcow2 with persistent bitmaps that "
+                       "were not loaded into memory");
+            ret = -ENOTSUP;
+            goto out;
+        }
+
+        /*
+         * The checks against readonly and busy are redundant, but certainly
+         * do no harm. checks against inconsistent are crucial:
+         */
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
index 7fb2730f09..da2697f912 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3499,9 +3499,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
     }
 
     /* cannot proceed if image has bitmaps */
-    if (s->nb_bitmaps) {
-        /* TODO: resize bitmaps in the image */
-        error_setg(errp, "Can't resize an image which has bitmaps");
+    if (qcow2_truncate_bitmaps_check(bs, errp)) {
         ret = -ENOTSUP;
         goto fail;
     }
-- 
2.18.0

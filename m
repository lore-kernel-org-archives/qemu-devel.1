Received: from eggs.gnu.org ([2001:4830:134:3::10]:45971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxku-0000g9-7K
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxkp-0006ZR-AD
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:11:20 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:31 +0200
Message-Id: <20170711160814.20941-43-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 42/85] qcow2: store bitmaps on reopening image
 as read-only
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

Store bitmaps and mark them read-only on reopening image as read-only.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170628120530.31251-21-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h        |  1 +
 block/qcow2-bitmap.c | 22 ++++++++++++++++++++++
 block/qcow2.c        |  5 +++++
 3 files changed, 28 insertions(+)

diff --git a/block/qcow2.h b/block/qcow2.h
index 308cefd..1f80b5d 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -648,5 +648,6 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
 bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
 
 #endif
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 81c49ae..f82478c 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1366,3 +1366,25 @@ fail:
 
     bitmap_list_free(bm_list);
 }
+
+int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
+{
+    BdrvDirtyBitmap *bitmap;
+    Error *local_err = NULL;
+
+    qcow2_store_persistent_dirty_bitmaps(bs, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return -EINVAL;
+    }
+
+    for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap != NULL;
+         bitmap = bdrv_dirty_bitmap_next(bs, bitmap))
+    {
+        if (bdrv_dirty_bitmap_get_persistance(bitmap)) {
+            bdrv_dirty_bitmap_set_readonly(bitmap, true);
+        }
+    }
+
+    return 0;
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index 790b5b1..1a31f1d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1555,6 +1555,11 @@ static int qcow2_reopen_prepare(BDRVReopenState *state,
 
     /* We need to write out any unwritten data if we reopen read-only. */
     if ((state->flags & BDRV_O_RDWR) == 0) {
+        ret = qcow2_reopen_bitmaps_ro(state->bs, errp);
+        if (ret < 0) {
+            goto fail;
+        }
+
         ret = bdrv_flush(state->bs);
         if (ret < 0) {
             goto fail;
-- 
2.9.4

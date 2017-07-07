Received: from eggs.gnu.org ([2001:4830:134:3::10]:43417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmU-0006bm-VS
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmQ-0000v1-CP
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:11:02 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:37 +0200
Message-Id: <1499447335-6125-83-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 082/100] qcow2: store bitmaps on reopening image
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Store bitmaps and mark them read-only on reopening image as read-only.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170628120530.31251-21-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-bitmap.c | 22 ++++++++++++++++++++++
 block/qcow2.c        |  5 +++++
 block/qcow2.h        |  1 +
 3 files changed, 28 insertions(+)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 5f53486..7912a82 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1365,3 +1365,25 @@ fail:
 
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
-- 
1.8.3.1

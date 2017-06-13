Received: from eggs.gnu.org ([2001:4830:134:3::10]:59716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dKmQU-0001hP-U7
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dKmQS-0005Kk-4t
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:04:10 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:37297 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dKmQR-0005Hc-Ow
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:04:08 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 13 Jun 2017 17:03:48 +0300
Message-Id: <20170613140358.81651-21-vsementsov@virtuozzo.com>
In-Reply-To: <20170613140358.81651-1-vsementsov@virtuozzo.com>
References: <20170613140358.81651-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v21 20/30] qcow2: store bitmaps on reopening
 image as read-only
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

Store bitmaps and mark them read-only on reopening image as read-only.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-bitmap.c | 22 ++++++++++++++++++++++
 block/qcow2.c        |  5 +++++
 block/qcow2.h        |  1 +
 3 files changed, 28 insertions(+)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 5f53486b22..7912a82c8c 100644
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
index ebe23ba4a5..76603903ff 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1382,6 +1382,11 @@ static int qcow2_reopen_prepare(BDRVReopenState *state,
 
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
index 0594551237..7d0a20c053 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -632,5 +632,6 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
 bool qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
 void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
 
 #endif
-- 
2.11.1

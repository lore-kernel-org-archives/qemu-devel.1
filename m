Received: from eggs.gnu.org ([209.51.188.92]:43106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gteLb-0000WW-9x
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gteLZ-00079q-EG
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:08:03 -0500
From: John Snow <jsnow@redhat.com>
Date: Tue, 12 Feb 2019 15:07:50 -0500
Message-Id: <20190212200750.27521-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2] blockdev: acquire aio_context for bitmap
 add/remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, eblake@redhat.com, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>

When bitmaps are persistent, they may incur a disk read or write when bitmaps
are added or removed. For configurations like virtio-dataplane, failing to
acquire this lock will abort QEMU when disk IO occurs.

We used to acquire aio_context as part of the bitmap lookup, so re-introduce
the lock for just the cases that have an IO penalty.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1672010
Reported-By: Aihua Liang <aliang@redhat.com>
---
 blockdev.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index fb18e9c975..790b0e0ac8 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2820,6 +2820,7 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
 {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
+    AioContext *aio_context = NULL;
 
     if (!name || name[0] == '\0') {
         error_setg(errp, "Bitmap name cannot be empty");
@@ -2854,15 +2855,17 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
         disabled = false;
     }
 
-    if (persistent &&
-        !bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp))
-    {
-        return;
+    if (persistent) {
+        aio_context = bdrv_get_aio_context(bs);
+        aio_context_acquire(aio_context);
+        if (!bdrv_can_store_new_dirty_bitmap(bs, name, granularity, errp)) {
+            goto out;
+        }
     }
 
     bitmap = bdrv_create_dirty_bitmap(bs, granularity, name, errp);
     if (bitmap == NULL) {
-        return;
+        goto out
     }
 
     if (disabled) {
@@ -2870,6 +2873,10 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
     }
 
     bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
+ out:
+    if (aio_context) {
+        aio_context_release(aio_context);
+    }
 }
 
 void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
@@ -2878,6 +2885,7 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
     Error *local_err = NULL;
+    AioContext *aio_context = NULL;
 
     bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
     if (!bitmap || !bs) {
@@ -2892,14 +2900,20 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
     }
 
     if (bdrv_dirty_bitmap_get_persistance(bitmap)) {
+        aio_context = bdrv_get_aio_context(bs);
+        aio_context_acquire(aio_context);
         bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
-            return;
+            goto out;
         }
     }
 
     bdrv_release_dirty_bitmap(bs, bitmap);
+ out:
+    if (aio_context) {
+        aio_context_release(aio_context);
+    }
 }
 
 /**
-- 
2.17.2

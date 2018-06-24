Received: from eggs.gnu.org ([2001:4830:134:3::10]:49511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <root@bogon.localdomain>) id 1fXfWL-0008FB-D9
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 00:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <root@bogon.localdomain>) id 1fXfWK-0002Ma-Bg
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 00:24:01 -0400
From: yaoxu@didichuxing.com
Date: Mon, 25 Jun 2018 00:01:57 +0800
Message-Id: <20180624160157.33509-1-yaoxu@didichuxing.com>
Subject: [Qemu-devel] block/dirty-bitmap: Useless bitmaps in image can be
 removed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, yaoxu <yaoxu@didichuxing.com>

If qemu-kvm quit without saving bitmaps to image(coredump, host kernel panic,
or host pooweroff), bitmaps in image can not be safely used anymore, and also
can not be removed. Useless bitmaps should be removed.

Signed-off-by: yaoxu <yaoxu@didichuxing.com>
---
diff --git a/blockdev.c b/blockdev.c
index 58d7570932..c85056a74b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2837,31 +2837,35 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
     Error *local_err = NULL;
 
     bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
-    if (!bitmap || !bs) {
+    if (!bs) {
         return;
     }
 
-    if (bdrv_dirty_bitmap_frozen(bitmap)) {
-        error_setg(errp,
-                   "Bitmap '%s' is currently frozen and cannot be removed",
-                   name);
-        return;
-    } else if (bdrv_dirty_bitmap_qmp_locked(bitmap)) {
-        error_setg(errp,
-                   "Bitmap '%s' is currently locked and cannot be removed",
-                   name);
+    if (bitmap) {
+        if (bdrv_dirty_bitmap_frozen(bitmap)) {
+            error_setg(errp,
+                       "Bitmap '%s' is currently frozen and cannot be removed",
+                       name);
+            return;
+        } else if (bdrv_dirty_bitmap_qmp_locked(bitmap)) {
+            error_setg(errp,
+                       "Bitmap '%s' is currently locked and cannot be removed",
+                       name);
+            return;
+        }
+    }
+
+    bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
         return;
     }
 
-    if (bdrv_dirty_bitmap_get_persistance(bitmap)) {
-        bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
-        if (local_err != NULL) {
-            error_propagate(errp, local_err);
-            return;
-        }
+    if (bitmap) {
+        bdrv_release_dirty_bitmap(bs, bitmap);
     }
 
-    bdrv_release_dirty_bitmap(bs, bitmap);
+    if (*errp) {
+        error_free(*errp);
+        *errp = NULL;
+    }
 }
 
 /**

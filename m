Received: from eggs.gnu.org ([2001:4830:134:3::10]:58892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <root@didideMacBook-Pro-334.local>)
	id 1fWu50-0000o9-9V
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 21:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <root@didideMacBook-Pro-334.local>)
	id 1fWu4z-0000XP-D3
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 21:44:38 -0400
From: yaoxu@didichuxing.com
Date: Sun, 24 Jun 2018 09:44:22 +0800
Message-Id: <20180624014422.3237-1-yaoxu@didichuxing.com>
Subject: [Qemu-devel] block/dirty-bitmap: Useless bitmap in image should be
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

If qemu-kvm quit without saving bitmaps in image(coredump or panic on host),
bitmaps in image can not be used safely anymore, and can not be removed
also. Useless bitmaps should be removed.

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
+    *errp = NULL;
 }
 
 /**

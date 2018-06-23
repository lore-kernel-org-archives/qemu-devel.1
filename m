Received: from eggs.gnu.org ([2001:4830:134:3::10]:37441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <root@didideMacBook-Pro-334.local>)
	id 1fWmIK-0005Z1-TU
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 13:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <root@didideMacBook-Pro-334.local>)
	id 1fWmIJ-0003zf-NX
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 13:25:52 -0400
From: 13466399134@163.com
Date: Sun, 24 Jun 2018 00:41:16 +0800
Message-Id: <20180623164116.29482-1-13466399134@163.com>
Subject: [Qemu-devel] block/dirty-bitmap: Useless bitmap in image can be
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
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, Yaoxu19870920 <13466399134@163.com>

If qemu-kvm quit without save bitmaps in image(coredump or panic on host),
bitmaps in image can not be used safely anymore, and can not be removed 
also. Useless bitmaps should be removed.

Signed-off-by: Yaoxu19870920 <13466399134@163.com>
---
diff --git a/blockdev.c b/blockdev.c
index c85056a74b..58d7570932 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2837,35 +2837,31 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
     Error *local_err = NULL;
 
     bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
-    if (!bs) {
+    if (!bitmap || !bs) {
         return;
     }
 
-    if (bitmap){
-        if (bdrv_dirty_bitmap_frozen(bitmap)) {
-            error_setg(errp,
-                       "Bitmap '%s' is currently frozen and cannot be removed",
-                       name);
-            return;
-        } else if (bdrv_dirty_bitmap_qmp_locked(bitmap)) {
-            error_setg(errp,
-                       "Bitmap '%s' is currently locked and cannot be removed",
-                       name);
-            return;
-        }
-    }
-
-    bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    if (bdrv_dirty_bitmap_frozen(bitmap)) {
+        error_setg(errp,
+                   "Bitmap '%s' is currently frozen and cannot be removed",
+                   name);
+        return;
+    } else if (bdrv_dirty_bitmap_qmp_locked(bitmap)) {
+        error_setg(errp,
+                   "Bitmap '%s' is currently locked and cannot be removed",
+                   name);
         return;
     }
 
-    if (bitmap){
-        bdrv_release_dirty_bitmap(bs, bitmap);
+    if (bdrv_dirty_bitmap_get_persistance(bitmap)) {
+        bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
     }
 
-    *errp = NULL;
+    bdrv_release_dirty_bitmap(bs, bitmap);
 }
 
 /**

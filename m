Received: from eggs.gnu.org ([2001:4830:134:3::10]:52147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1d-0002oL-UT
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1c-0005G2-QQ
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:05:49 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:04:44 +0100
Message-Id: <20180213170529.10858-11-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/55] gluster: Pull truncation from
 qemu_gluster_create
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

From: Max Reitz <mreitz@redhat.com>

Pull out the truncation code from the qemu_cluster_create() function so
we can later reuse it in qemu_gluster_truncate().

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/gluster.c | 74 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 7fab2dfa12..8178541416 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -965,6 +965,45 @@ static coroutine_fn int qemu_gluster_co_pwrite_zeroes(BlockDriverState *bs,
 }
 #endif
 
+static int qemu_gluster_do_truncate(struct glfs_fd *fd, int64_t offset,
+                                    PreallocMode prealloc, Error **errp)
+{
+    switch (prealloc) {
+#ifdef CONFIG_GLUSTERFS_FALLOCATE
+    case PREALLOC_MODE_FALLOC:
+        if (glfs_fallocate(fd, 0, 0, offset)) {
+            error_setg_errno(errp, errno, "Could not preallocate data");
+            return -errno;
+        }
+        break;
+#endif /* CONFIG_GLUSTERFS_FALLOCATE */
+#ifdef CONFIG_GLUSTERFS_ZEROFILL
+    case PREALLOC_MODE_FULL:
+        if (glfs_ftruncate(fd, offset)) {
+            error_setg_errno(errp, errno, "Could not resize file");
+            return -errno;
+        }
+        if (glfs_zerofill(fd, 0, offset)) {
+            error_setg_errno(errp, errno, "Could not zerofill the new area");
+            return -errno;
+        }
+        break;
+#endif /* CONFIG_GLUSTERFS_ZEROFILL */
+    case PREALLOC_MODE_OFF:
+        if (glfs_ftruncate(fd, offset)) {
+            error_setg_errno(errp, errno, "Could not resize file");
+            return -errno;
+        }
+        break;
+    default:
+        error_setg(errp, "Unsupported preallocation mode: %s",
+                   PreallocMode_str(prealloc));
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 static int qemu_gluster_create(const char *filename,
                                QemuOpts *opts, Error **errp)
 {
@@ -1019,40 +1058,7 @@ static int qemu_gluster_create(const char *filename,
         goto out;
     }
 
-    switch (prealloc) {
-#ifdef CONFIG_GLUSTERFS_FALLOCATE
-    case PREALLOC_MODE_FALLOC:
-        if (glfs_fallocate(fd, 0, 0, total_size)) {
-            error_setg(errp, "Could not preallocate data for the new file");
-            ret = -errno;
-        }
-        break;
-#endif /* CONFIG_GLUSTERFS_FALLOCATE */
-#ifdef CONFIG_GLUSTERFS_ZEROFILL
-    case PREALLOC_MODE_FULL:
-        if (!glfs_ftruncate(fd, total_size)) {
-            if (glfs_zerofill(fd, 0, total_size)) {
-                error_setg(errp, "Could not zerofill the new file");
-                ret = -errno;
-            }
-        } else {
-            error_setg(errp, "Could not resize file");
-            ret = -errno;
-        }
-        break;
-#endif /* CONFIG_GLUSTERFS_ZEROFILL */
-    case PREALLOC_MODE_OFF:
-        if (glfs_ftruncate(fd, total_size) != 0) {
-            ret = -errno;
-            error_setg(errp, "Could not resize file");
-        }
-        break;
-    default:
-        ret = -EINVAL;
-        error_setg(errp, "Unsupported preallocation mode: %s",
-                   PreallocMode_str(prealloc));
-        break;
-    }
+    ret = qemu_gluster_do_truncate(fd, total_size, prealloc, errp);
 
 out:
     if (fd) {
-- 
2.13.6

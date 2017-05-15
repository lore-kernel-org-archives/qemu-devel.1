Received: from eggs.gnu.org ([2001:4830:134:3::10]:39277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1dALQH-0003nG-Po
	for qemu-devel@nongnu.org; Mon, 15 May 2017 15:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1dALQG-000192-QH
	for qemu-devel@nongnu.org; Mon, 15 May 2017 15:12:49 -0400
From: Niels de Vos <ndevos@redhat.com>
Date: Mon, 15 May 2017 21:11:36 +0200
Message-Id: <20170515191136.24314-1-ndevos@redhat.com>
Subject: [Qemu-devel] [PATCH] gluster: add support for PREALLOC_MODE_FALLOC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Niels de Vos <ndevos@redhat.com>

Add missing support for "preallocation=falloc" to the Gluster block
driver. This change bases its logic on that of block/file-posix.c and
removed the gluster_supports_zerofill() function in favour of an #ifdef
check in an easy to read switch-statement.

Reported-by: Satheesaran Sundaramoorthi <sasundar@redhat.com>
URL: https://bugzilla.redhat.com/1450759
Signed-off-by: Niels de Vos <ndevos@redhat.com>
---
 block/gluster.c | 61 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 7c76cd0..566166f 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -965,11 +965,6 @@ static coroutine_fn int qemu_gluster_co_pwrite_zeroes(BlockDriverState *bs,
     return acb.ret;
 }
 
-static inline bool gluster_supports_zerofill(void)
-{
-    return 1;
-}
-
 static inline int qemu_gluster_zerofill(struct glfs_fd *fd, int64_t offset,
                                         int64_t size)
 {
@@ -977,11 +972,6 @@ static inline int qemu_gluster_zerofill(struct glfs_fd *fd, int64_t offset,
 }
 
 #else
-static inline bool gluster_supports_zerofill(void)
-{
-    return 0;
-}
-
 static inline int qemu_gluster_zerofill(struct glfs_fd *fd, int64_t offset,
                                         int64_t size)
 {
@@ -996,9 +986,10 @@ static int qemu_gluster_create(const char *filename,
     struct glfs *glfs;
     struct glfs_fd *fd;
     int ret = 0;
-    int prealloc = 0;
+    PreallocMode prealloc;
     int64_t total_size = 0;
     char *tmp = NULL;
+    Error *local_err = NULL;
 
     gconf = g_new0(BlockdevOptionsGluster, 1);
     gconf->debug = qemu_opt_get_number_del(opts, GLUSTER_OPT_DEBUG,
@@ -1026,13 +1017,12 @@ static int qemu_gluster_create(const char *filename,
                           BDRV_SECTOR_SIZE);
 
     tmp = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
-    if (!tmp || !strcmp(tmp, "off")) {
-        prealloc = 0;
-    } else if (!strcmp(tmp, "full") && gluster_supports_zerofill()) {
-        prealloc = 1;
-    } else {
-        error_setg(errp, "Invalid preallocation mode: '%s'"
-                         " or GlusterFS doesn't support zerofill API", tmp);
+    prealloc = qapi_enum_parse(PreallocMode_lookup, tmp,
+                               PREALLOC_MODE__MAX, PREALLOC_MODE_OFF,
+                               &local_err);
+    g_free(tmp);
+    if (local_err) {
+        error_propagate(errp, local_err);
         ret = -EINVAL;
         goto out;
     }
@@ -1041,21 +1031,46 @@ static int qemu_gluster_create(const char *filename,
                     O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, S_IRUSR | S_IWUSR);
     if (!fd) {
         ret = -errno;
-    } else {
+        goto out;
+    }
+
+    switch (prealloc) {
+    case PREALLOC_MODE_FALLOC:
+        if (!glfs_fallocate(fd, 0, 0, total_size)) {
+            error_setg(errp, "Could not preallocate data for the new file");
+            ret = -errno;
+        }
+        break;
+#ifdef CONFIG_GLUSTERFS_ZEROFILL
+    case PREALLOC_MODE_FULL:
         if (!glfs_ftruncate(fd, total_size)) {
-            if (prealloc && qemu_gluster_zerofill(fd, 0, total_size)) {
+            if (qemu_gluster_zerofill(fd, 0, total_size)) {
+                error_setg(errp, "Could not zerofill the new file");
                 ret = -errno;
             }
         } else {
+            error_setg(errp, "Could not resize file");
             ret = -errno;
         }
-
-        if (glfs_close(fd) != 0) {
+        break;
+#endif /* CONFIG_GLUSTERFS_ZEROFILL */
+    case PREALLOC_MODE_OFF:
+        if (glfs_ftruncate(fd, total_size) != 0) {
             ret = -errno;
+            error_setg(errp, "Could not resize file");
         }
+        break;
+    default:
+        ret = -EINVAL;
+        error_setg(errp, "Unsupported preallocation mode: %s",
+                   PreallocMode_lookup[prealloc]);
+        break;
+    }
+
+    if (glfs_close(fd) != 0) {
+        ret = -errno;
     }
 out:
-    g_free(tmp);
     qapi_free_BlockdevOptionsGluster(gconf);
     glfs_clear_preopened(glfs);
     return ret;
-- 
2.9.3

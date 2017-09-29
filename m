Received: from eggs.gnu.org ([2001:4830:134:3::10]:53522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtFB-00061o-L1
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtFA-0007ok-GH
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:09 -0400
Received: from mifritscher.de ([188.40.170.105]:33028
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1dxtFA-0007o2-6a
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:08 -0400
From: Michael Fritscher <michael@fritscher.net>
Date: Fri, 29 Sep 2017 13:13:22 +0200
Message-Id: <20170929111323.6308-18-michael@fritscher.net>
In-Reply-To: <20170929111323.6308-1-michael@fritscher.net>
References: <20170929111323.6308-1-michael@fritscher.net>
Subject: [Qemu-devel] [PATCH 17/18] Compile fixes for Windows.
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org
Cc: Michael Fritscher <michael@fritscher.net>
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Michael Fritscher <michael@fritscher.net>
---
 hw/9pfs/9p-local.c | 50 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index bf6fb70b81..afe07dd142 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -17,22 +17,26 @@
 #include "9p-xattr.h"
 #include "9p-util.h"
 #include "fsdev/qemu-fsdev.h"   /* local_ops */
+#ifndef _WIN32
 #include <arpa/inet.h>
 #include <pwd.h>
 #include <grp.h>
 #include <sys/socket.h>
 #include <sys/un.h>
+#endif
 #ifndef _WIN32
-# include "qemu/xattr.h"
+#include "qemu/xattr.h"
 #endif
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include <libgen.h>
+#ifndef _WIN32
 #include <linux/fs.h>
+#endif
 #ifdef CONFIG_LINUX_MAGIC_H
 #include <linux/magic.h>
-#endif
 #include <sys/ioctl.h>
+#endif
 
 #ifndef XFS_SUPER_MAGIC
 #define XFS_SUPER_MAGIC  0x58465342
@@ -300,8 +304,10 @@ update_map_file:
 
     map_fd = fileno(fp);
     assert(map_fd != -1);
+#ifndef _WIN32
     ret = fchmod(map_fd, 0600);
     assert(ret == 0);
+#endif
 
     if (credp->fc_uid != -1) {
         uid = credp->fc_uid;
@@ -309,7 +315,8 @@ update_map_file:
     if (credp->fc_gid != -1) {
         gid = credp->fc_gid;
     }
-    if (credp->fc_mode != -1) {
+    /* On Windows it is unsigned... */
+    if ((int16_t)(credp->fc_mode) != -1) {
         mode = credp->fc_mode;
     }
     if (credp->fc_rdev != -1) {
@@ -368,8 +375,12 @@ static int fchmodat_nofollow(int dirfd, const char *name, mode_t mode)
     if (fd == -1) {
         return -1;
     }
+#ifndef _WIN32
     ret = fchmod(fd, mode);
 #else
+    ret = 0;
+#endif
+#else
     /* Access modes are ignored when O_PATH is supported. If name is a symbolic
      * link, O_PATH | O_NOFOLLOW causes openat(2) to return a file descriptor
      * referring to the symbolic link.
@@ -418,7 +429,8 @@ static int local_set_xattrat(int dirfd, const char *path, FsCred *credp)
             return err;
         }
     }
-    if (credp->fc_mode != -1) {
+    /* On Windows it is unsigned... */
+    if ((int16_t)(credp->fc_mode) != -1) {
         uint32_t tmp_mode = cpu_to_le32(credp->fc_mode);
         err = fsetxattrat_nofollow(dirfd, path, "user.virtfs.mode", &tmp_mode,
                                    sizeof(mode_t), 0);
@@ -518,8 +530,23 @@ static int local_open(FsContext *ctx, V9fsPath *fs_path,
 static int local_opendir(FsContext *ctx,
                          V9fsPath *fs_path, V9fsFidOpenState *fs)
 {
+   DIR *stream;
+/* there is no fdopendir available on Windows... */
+#ifdef _WIN32
+    char *buffer;
+    char *path = fs_path->data;
+
+    buffer = rpath(ctx, path);
+    error_printf("Directory (opendir) which should be opened: %s\n", buffer);
+    stream = opendir(buffer);
+    g_free(buffer);
+    if (!stream) {
+        return -1;
+    }
+    fs->dir.stream = stream;
+    return 0;
+#else
     int dirfd;
-    DIR *stream;
 
     dirfd = local_opendir_nofollow(ctx, fs_path->data);
     if (dirfd == -1) {
@@ -533,6 +560,7 @@ static int local_opendir(FsContext *ctx,
     }
     fs->dir.stream = stream;
     return 0;
+#endif
 }
 
 static void local_rewinddir(FsContext *ctx, V9fsFidOpenState *fs)
@@ -562,13 +590,17 @@ again:
     }
 
     if (ctx->export_flags & V9FS_SM_MAPPED) {
+#ifndef _WIN32
         entry->d_type = DT_UNKNOWN;
+#endif
     } else if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
         if (local_is_mapped_file_metadata(ctx, entry->d_name)) {
             /* skip the meta data */
             goto again;
         }
+#ifndef _WIN32
         entry->d_type = DT_UNKNOWN;
+#endif
     }
 
     return entry;
@@ -763,7 +795,11 @@ static int local_fstat(FsContext *fs_ctx, int fid_type,
     int err, fd;
 
     if (fid_type == P9_FID_DIR) {
+#ifndef _WIN32
         fd = dirfd(fs->dir.stream);
+#else
+        fd = fs->fd;
+#endif
     } else {
         fd = fs->fd;
     }
@@ -1161,7 +1197,11 @@ static int local_fsync(FsContext *ctx, int fid_type,
     int fd;
 
     if (fid_type == P9_FID_DIR) {
+#ifndef _WIN32
         fd = dirfd(fs->dir.stream);
+#else
+        fd = fs->fd;
+#endif
     } else {
         fd = fs->fd;
     }
-- 
2.13.2.windows.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fPE6y-0007wc-Pm
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 17:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fPE6x-0005nZ-LK
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 17:30:56 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:44208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fPE6x-0005nE-HD
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 17:30:55 -0400
Received: by mail-qt0-x243.google.com with SMTP id d3-v6so36437707qtp.11
	for <qemu-devel@nongnu.org>; Sat, 02 Jun 2018 14:30:55 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Sat,  2 Jun 2018 17:29:37 -0400
Message-Id: <15479c7ebdc70dd260f696cd4c3d2d0f2336f375.1527973524.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527973524.git.keno@juliacomputing.com>
References: <cover.1527973524.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527973524.git.keno@juliacomputing.com>
References: <cover.1527973524.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v3 3/5] 9p: local: Avoid warning if
 FS_IOC_GETVERSION is not defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@juliacomputing.com>, groug@kaod.org

Both `stbuf` and `local_ioc_getversion` where unused when
FS_IOC_GETVERSION was not defined, causing a compiler warning.

Reorganize the code to avoid this warning.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 hw/9pfs/9p-local.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 304ef72..828e8d6 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1373,10 +1373,10 @@ static int local_unlinkat(FsContext *ctx, V9fsPath *dir,
     return ret;
 }
 
+#ifdef FS_IOC_GETVERSION
 static int local_ioc_getversion(FsContext *ctx, V9fsPath *path,
                                 mode_t st_mode, uint64_t *st_gen)
 {
-#ifdef FS_IOC_GETVERSION
     int err;
     V9fsFidOpenState fid_open;
 
@@ -1395,32 +1395,21 @@ static int local_ioc_getversion(FsContext *ctx, V9fsPath *path,
     err = ioctl(fid_open.fd, FS_IOC_GETVERSION, st_gen);
     local_close(ctx, &fid_open);
     return err;
-#else
-    errno = ENOTTY;
-    return -1;
-#endif
 }
+#endif
 
-static int local_init(FsContext *ctx, Error **errp)
+static int local_ioc_getversion_init(FsContext *ctx, LocalData *data, Error **errp)
 {
+#ifdef FS_IOC_GETVERSION
     struct statfs stbuf;
-    LocalData *data = g_malloc(sizeof(*data));
 
-    data->mountfd = open(ctx->fs_root, O_DIRECTORY | O_RDONLY);
-    if (data->mountfd == -1) {
-        error_setg_errno(errp, errno, "failed to open '%s'", ctx->fs_root);
-        goto err;
-    }
-
-#ifdef FS_IOC_GETVERSION
     /*
      * use ioc_getversion only if the ioctl is definied
      */
     if (fstatfs(data->mountfd, &stbuf) < 0) {
-        close_preserve_errno(data->mountfd);
         error_setg_errno(errp, errno,
-            "failed to stat file system at '%s'", ctx->fs_root);
-        goto err;
+                         "failed to stat file system at '%s'", ctx->fs_root);
+        return -1;
     }
     switch (stbuf.f_type) {
     case EXT2_SUPER_MAGIC:
@@ -1431,6 +1420,23 @@ static int local_init(FsContext *ctx, Error **errp)
         break;
     }
 #endif
+    return 0;
+}
+
+static int local_init(FsContext *ctx, Error **errp)
+{
+    LocalData *data = g_malloc(sizeof(*data));
+
+    data->mountfd = open(ctx->fs_root, O_DIRECTORY | O_RDONLY);
+    if (data->mountfd == -1) {
+        error_setg_errno(errp, errno, "failed to open '%s'", ctx->fs_root);
+        goto err;
+    }
+
+    if (local_ioc_getversion_init(ctx, data, errp) < 0) {
+        close(data->mountfd);
+        goto err;
+    }
 
     if (ctx->export_flags & V9FS_SM_PASSTHROUGH) {
         ctx->xops = passthrough_xattr_ops;
-- 
2.8.1

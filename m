Received: from eggs.gnu.org ([2001:4830:134:3::10]:33324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYqv-0002xc-H6
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYqu-0002x7-J9
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:37 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:39684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fOYqu-0002wq-FF
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:36 -0400
Received: by mail-qt0-x243.google.com with SMTP id p23-v6so5420032qtn.6
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 18:27:36 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Thu, 31 May 2018 21:26:01 -0400
Message-Id: <0758699faca2ee5526d2b64e0a5fdda7e7845cbc.1527814874.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v2 06/20] 9p: Avoid warning if
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

Reorgnaize the code to avoid this warning.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---

Changes since v1:
 * As request in review, logic is factored into a
   local_ioc_getversion_init function.

 hw/9pfs/9p-local.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 576c8e3..6222891 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1375,10 +1375,10 @@ static int local_unlinkat(FsContext *ctx, V9fsPath *dir,
     return ret;
 }
 
+#ifdef FS_IOC_GETVERSION
 static int local_ioc_getversion(FsContext *ctx, V9fsPath *path,
                                 mode_t st_mode, uint64_t *st_gen)
 {
-#ifdef FS_IOC_GETVERSION
     int err;
     V9fsFidOpenState fid_open;
 
@@ -1397,32 +1397,19 @@ static int local_ioc_getversion(FsContext *ctx, V9fsPath *path,
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
+static int local_ioc_getversion_init(FsContext *ctx, LocalData *data)
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
-        error_setg_errno(errp, errno,
-            "failed to stat file system at '%s'", ctx->fs_root);
-        goto err;
+        return -1;
     }
     switch (stbuf.f_type) {
     case EXT2_SUPER_MAGIC:
@@ -1433,6 +1420,26 @@ static int local_init(FsContext *ctx, Error **errp)
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
+    if (local_ioc_getversion_init(ctx, data) < 0) {
+        close_preserve_errno(data->mountfd);
+        error_setg_errno(errp, errno,
+            "failed initialize ioc_getversion for file system at '%s'",
+            ctx->fs_root);
+        goto err;
+    }
 
     if (ctx->export_flags & V9FS_SM_PASSTHROUGH) {
         ctx->xops = passthrough_xattr_ops;
-- 
2.8.1

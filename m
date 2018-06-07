Received: from eggs.gnu.org ([2001:4830:134:3::10]:56976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQwjz-0001z4-OM
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQwjv-0000OP-P6
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fQwjv-0000Nn-HA
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:22:15 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w57FJSl6058052
	for <qemu-devel@nongnu.org>; Thu, 7 Jun 2018 11:22:14 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jf5q159uu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 11:22:14 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 7 Jun 2018 16:22:11 +0100
From: Greg Kurz <groug@kaod.org>
Date: Thu,  7 Jun 2018 17:21:17 +0200
In-Reply-To: <20180607152119.3447-1-groug@kaod.org>
References: <20180607152119.3447-1-groug@kaod.org>
Message-Id: <20180607152119.3447-6-groug@kaod.org>
Subject: [Qemu-devel] [PULL 5/7] 9p: local: Avoid warning if
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, Keno Fischer <keno@juliacomputing.com>

From: Keno Fischer <keno@juliacomputing.com>

Both `stbuf` and `local_ioc_getversion` where unused when
FS_IOC_GETVERSION was not defined, causing a compiler warning.

Reorganize the code to avoid this warning.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 7758c3850900..5721eff1e189 100644
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
2.14.4

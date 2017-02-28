Received: from eggs.gnu.org ([2001:4830:134:3::10]:37507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cif3b-00018V-De
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:31:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cif3X-0007uW-Uh
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:30:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56096
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cif3X-0007u6-PP
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:30:55 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1SASobO088837
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 05:30:55 -0500
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28vyqf3e99-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 05:30:54 -0500
Received: from localhost
	by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 28 Feb 2017 10:30:52 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 28 Feb 2017 11:30:14 +0100
In-Reply-To: <1488277840-18608-1-git-send-email-groug@kaod.org>
References: <1488277840-18608-1-git-send-email-groug@kaod.org>
Message-Id: <1488277840-18608-3-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 02/28] 9pfs: remove side-effects in local_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

If this function fails, it should not modify *ctx.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/9pfs/9p-local.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 7de07e1ba67f..4a8e628117ae 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1168,9 +1168,25 @@ static int local_ioc_getversion(FsContext *ctx, V9fsPath *path,
 
 static int local_init(FsContext *ctx)
 {
-    int err = 0;
     struct statfs stbuf;
 
+#ifdef FS_IOC_GETVERSION
+    /*
+     * use ioc_getversion only if the ioctl is definied
+     */
+    if (statfs(ctx->fs_root, &stbuf) < 0) {
+        return -1;
+    }
+    switch (stbuf.f_type) {
+    case EXT2_SUPER_MAGIC:
+    case BTRFS_SUPER_MAGIC:
+    case REISERFS_SUPER_MAGIC:
+    case XFS_SUPER_MAGIC:
+        ctx->exops.get_st_gen = local_ioc_getversion;
+        break;
+    }
+#endif
+
     if (ctx->export_flags & V9FS_SM_PASSTHROUGH) {
         ctx->xops = passthrough_xattr_ops;
     } else if (ctx->export_flags & V9FS_SM_MAPPED) {
@@ -1185,23 +1201,8 @@ static int local_init(FsContext *ctx)
         ctx->xops = passthrough_xattr_ops;
     }
     ctx->export_flags |= V9FS_PATHNAME_FSCONTEXT;
-#ifdef FS_IOC_GETVERSION
-    /*
-     * use ioc_getversion only if the iocl is definied
-     */
-    err = statfs(ctx->fs_root, &stbuf);
-    if (!err) {
-        switch (stbuf.f_type) {
-        case EXT2_SUPER_MAGIC:
-        case BTRFS_SUPER_MAGIC:
-        case REISERFS_SUPER_MAGIC:
-        case XFS_SUPER_MAGIC:
-            ctx->exops.get_st_gen = local_ioc_getversion;
-            break;
-        }
-    }
-#endif
-    return err;
+
+    return 0;
 }
 
 static int local_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
-- 
2.7.4

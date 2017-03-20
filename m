Received: from eggs.gnu.org ([2001:4830:134:3::10]:40798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qh-0001dt-5W
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qb-0004s8-7f
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39881
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qb-0004rf-0l
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:29 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8Wi1028710
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:28 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29amb5t77d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:28 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:27 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:07:26 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-3-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 02/81] 9pfs: remove side-effects in local_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, Greg Kurz <gkurz@linux.vnet.ibm.com>

From: Greg Kurz <groug@kaod.org>

If this function fails, it should not modify *ctx.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 00c90bd1c2ff6aabb9ca948a254ba044a403e399)
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-local.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 845675e..c88158f 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1169,9 +1169,25 @@ static int local_ioc_getversion(FsContext *ctx, V9fsPath *path,
 
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
@@ -1186,23 +1202,8 @@ static int local_init(FsContext *ctx)
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

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ci7Vv-0004N6-Nh
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:42:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ci7Vs-0002eJ-KP
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:41:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55672
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ci7Vs-0002eD-Dc
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:41:56 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1QMd1nm114950
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 17:41:55 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28u7bakg3b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 17:41:55 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Sun, 26 Feb 2017 17:41:54 -0500
From: Greg Kurz <groug@kaod.org>
Date: Sun, 26 Feb 2017 23:41:48 +0100
In-Reply-To: <148814889214.28146.16915712763478774662.stgit@bahia>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148814890792.28146.3580053733335411481.stgit@bahia>
Subject: [Qemu-devel] [PATCH v2 02/28] 9pfs: remove side-effects in
 local_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

If this function fails, it should not modify *ctx.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v2: - s/iocl/ioctl in comment
---
 hw/9pfs/9p-local.c |   37 +++++++++++++++++++------------------
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

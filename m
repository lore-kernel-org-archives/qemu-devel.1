Received: from eggs.gnu.org ([2001:4830:134:3::10]:53777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp7y-0005gZ-1L
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:39:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp7u-0003RF-RN
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:39:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cfp7u-0003R2-Hv
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:39:42 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEd9HC048639
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:39:41 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28pphvhmdk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:39:41 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 20 Feb 2017 07:39:40 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 20 Feb 2017 15:39:34 +0100
In-Reply-To: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148760157489.31154.11695946385006642137.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 02/29] 9pfs: remove side-effects in local_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

If this function fails, it should not modify *ctx.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 7de07e1ba67f..55903e5d7745 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1168,9 +1168,25 @@ static int local_ioc_getversion(FsContext *ctx, V9fsPath *path,
 
 static int local_init(FsContext *ctx)
 {
-    int err = 0;
     struct statfs stbuf;
 
+#ifdef FS_IOC_GETVERSION
+    /*
+     * use ioc_getversion only if the iocl is definied
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

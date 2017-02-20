Received: from eggs.gnu.org ([2001:4830:134:3::10]:53907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp8M-00060l-1z
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:40:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp8I-0003XB-Ra
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:40:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36763
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cfp8I-0003X1-LD
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:40:06 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEcr5s126895
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:40:06 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28r012pt1q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:40:05 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 20 Feb 2017 07:40:05 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 20 Feb 2017 15:39:59 +0100
In-Reply-To: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148760159920.31154.1371018412446175087.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 05/29] 9pfs: local: keep a file descriptor on
 the shared folder
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

This patch opens the shared folder and caches the file descriptor, so that
it can be used to do symlink-safe path walk.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index c2239bfafce4..8aee7f2516ed 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "9p.h"
 #include "9p-xattr.h"
+#include "9p-util.h"
 #include "fsdev/qemu-fsdev.h"   /* local_ops */
 #include <arpa/inet.h>
 #include <pwd.h>
@@ -43,6 +44,10 @@
 #define BTRFS_SUPER_MAGIC 0x9123683E
 #endif
 
+struct local_data {
+    int mountfd;
+};
+
 #define VIRTFS_META_DIR ".virtfs_metadata"
 
 static char *local_mapped_attr_path(FsContext *ctx, const char *path)
@@ -1176,13 +1181,20 @@ static int local_ioc_getversion(FsContext *ctx, V9fsPath *path,
 static int local_init(FsContext *ctx)
 {
     struct statfs stbuf;
+    struct local_data *data = g_malloc(sizeof(*data));
+
+    data->mountfd = open(ctx->fs_root, O_DIRECTORY | O_RDONLY);
+    if (data->mountfd == -1) {
+        goto err;
+    }
 
 #ifdef FS_IOC_GETVERSION
     /*
      * use ioc_getversion only if the iocl is definied
      */
-    if (statfs(ctx->fs_root, &stbuf) < 0) {
-        return -1;
+    if (fstatfs(data->mountfd, &stbuf) < 0) {
+        close_preserve_errno(data->mountfd);
+        goto err;
     }
     switch (stbuf.f_type) {
     case EXT2_SUPER_MAGIC:
@@ -1209,7 +1221,20 @@ static int local_init(FsContext *ctx)
     }
     ctx->export_flags |= V9FS_PATHNAME_FSCONTEXT;
 
+    ctx->private = data;
     return 0;
+
+err:
+    g_free(data);
+    return -1;
+}
+
+static void local_cleanup(FsContext *ctx)
+{
+    struct local_data *data = ctx->private;
+
+    close(data->mountfd);
+    g_free(data);
 }
 
 static int local_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
@@ -1252,6 +1277,7 @@ static int local_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
 FileOperations local_ops = {
     .parse_opts = local_parse_opts,
     .init  = local_init,
+    .cleanup = local_cleanup,
     .lstat = local_lstat,
     .readlink = local_readlink,
     .close = local_close,

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cif3d-0001Au-Nn
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cif3a-0007vF-D6
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:31:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46664
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cif3a-0007ur-6M
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:30:58 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1SASdZ3118020
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 05:30:57 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28vqj1gupm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 05:30:57 -0500
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 28 Feb 2017 10:30:55 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 28 Feb 2017 11:30:17 +0100
In-Reply-To: <1488277840-18608-1-git-send-email-groug@kaod.org>
References: <1488277840-18608-1-git-send-email-groug@kaod.org>
Message-Id: <1488277840-18608-6-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 05/28] 9pfs: local: keep a file descriptor on
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

This patch opens the shared folder and caches the file descriptor, so that
it can be used to do symlink-safe path walk.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/9pfs/9p-local.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 607cd2aeceea..be6be615149b 100644
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
 
+typedef struct {
+    int mountfd;
+} LocalData;
+
 #define VIRTFS_META_DIR ".virtfs_metadata"
 
 static char *local_mapped_attr_path(FsContext *ctx, const char *path)
@@ -1176,13 +1181,20 @@ static int local_ioc_getversion(FsContext *ctx, V9fsPath *path,
 static int local_init(FsContext *ctx)
 {
     struct statfs stbuf;
+    LocalData *data = g_malloc(sizeof(*data));
+
+    data->mountfd = open(ctx->fs_root, O_DIRECTORY | O_RDONLY);
+    if (data->mountfd == -1) {
+        goto err;
+    }
 
 #ifdef FS_IOC_GETVERSION
     /*
      * use ioc_getversion only if the ioctl is definied
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
+    LocalData *data = ctx->private;
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
-- 
2.7.4

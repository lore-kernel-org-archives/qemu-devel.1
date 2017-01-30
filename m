Received: from eggs.gnu.org ([2001:4830:134:3::10]:45934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAoR-0006a7-C3
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAoO-0000J8-6o
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAoN-0000J3-T5
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:56 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC8r1J054393
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:11:54 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28a37q5gjy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:11:54 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 07:11:53 -0500
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:11:46 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577830646.10533.15016303134930167352.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 17/36] 9pfs: local: keep a file descriptor
 on the shared folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ppandit@redhat.com, jannh@google.com, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This patch opens the shared folder and caches the file descriptor, so that
it can be used to do symlink-safe path walk. Since nothing prevents several
QEMU instances to pass overlapping export paths to -fsdev, we also make
sure that the export path doesn't traverse a symlink either.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index d3c6ccf30b53..8a1d52cd6c2a 100644
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
@@ -1573,13 +1578,28 @@ static int local_ioc_getversion(FsContext *ctx, V9fsPath *path,
 static int local_init(FsContext *ctx)
 {
     struct statfs stbuf;
+    struct local_data *data = g_malloc(sizeof(*data));
+    int rootfd;
+
+    rootfd = open("/", O_DIRECTORY | O_RDONLY);
+    if (rootfd == -1) {
+        goto err;
+    }
+
+    data->mountfd = openat_nofollow(rootfd, ctx->fs_root,
+                                    O_DIRECTORY | O_RDONLY, 0);
+    close_preserve_errno(rootfd);
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
@@ -1606,7 +1626,20 @@ static int local_init(FsContext *ctx)
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
@@ -1649,6 +1682,7 @@ static int local_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
 FileOperations local_ops = {
     .parse_opts = local_parse_opts,
     .init  = local_init,
+    .cleanup = local_cleanup,
     .lstat = local_lstat,
     .readlink = local_readlink,
     .close = local_close,

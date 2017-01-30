Received: from eggs.gnu.org ([2001:4830:134:3::10]:45303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAmY-0004M9-QZ
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:10:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAmV-0008Nb-MK
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:10:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAmV-0008NN-BA
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:09:59 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC9DgA038934
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:09:58 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2890j99eq5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:09:58 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 07:09:56 -0500
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:09:52 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577819235.10533.4363430692173079799.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 02/36] 9pfs: local: split chmod operation
 per security model
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

Having all security models implemented in one monolithic function is
cumbersome. Especially when the need arises to fix something in the
shared code, as it forces to change all the paths at the same time.

This doesn't fix any bug, it is just preparatory cleanup.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   46 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 7de07e1ba67f..73a20657f1fc 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -461,25 +461,53 @@ static ssize_t local_pwritev(FsContext *ctx, V9fsFidOpenState *fs,
     return ret;
 }
 
-static int local_chmod(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
+static int local_chmod_mapped(FsContext *fs_ctx, V9fsPath *fs_path,
+                              FsCred *credp)
+{
+    char *buffer;
+    int ret = -1;
+    char *path = fs_path->data;
+
+    buffer = rpath(fs_ctx, path);
+    ret = local_set_xattr(buffer, credp);
+    g_free(buffer);
+
+    return ret;
+}
+
+static int local_chmod_passthrough(FsContext *fs_ctx, V9fsPath *fs_path,
+                                   FsCred *credp)
 {
     char *buffer;
     int ret = -1;
     char *path = fs_path->data;
 
+    buffer = rpath(fs_ctx, path);
+    ret = chmod(buffer, credp->fc_mode);
+    g_free(buffer);
+
+    return ret;
+}
+
+static int local_chmod_mapped_file(FsContext *fs_ctx, V9fsPath *fs_path,
+                                   FsCred *credp)
+{
+    char *path = fs_path->data;
+
+    return local_set_mapped_file_attr(fs_ctx, path, credp);
+}
+
+static int local_chmod(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
+{
     if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
-        buffer = rpath(fs_ctx, path);
-        ret = local_set_xattr(buffer, credp);
-        g_free(buffer);
+        return local_chmod_mapped(fs_ctx, fs_path, credp);
     } else if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        return local_set_mapped_file_attr(fs_ctx, path, credp);
+        return local_chmod_mapped_file(fs_ctx, fs_path, credp);
     } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
                (fs_ctx->export_flags & V9FS_SM_NONE)) {
-        buffer = rpath(fs_ctx, path);
-        ret = chmod(buffer, credp->fc_mode);
-        g_free(buffer);
+        return local_chmod_passthrough(fs_ctx, fs_path, credp);
     }
-    return ret;
+    g_assert_not_reached();
 }
 
 static int local_mknod(FsContext *fs_ctx, V9fsPath *dir_path,

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAnX-0005C6-IO
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAnU-00009b-Dr
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60821
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAnU-00009T-7X
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:11:00 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC8eqH008876
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:10:59 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28a3d3d54p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:10:59 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 07:10:49 -0500
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:10:28 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577822883.10533.14469737034261055085.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 07/36] 9pfs: local: split mkdir operation
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
 hw/9pfs/9p-local.c |   44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index f9abd4229b17..d424d8994779 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1187,26 +1187,52 @@ static int local_rename(FsContext *ctx, const char *oldpath,
     return err;
 }
 
-static int local_chown(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
+static int local_chown_passthrough(FsContext *fs_ctx, V9fsPath *fs_path,
+                                   FsCred *credp)
 {
     char *buffer;
     int ret = -1;
     char *path = fs_path->data;
 
+    buffer = rpath(fs_ctx, path);
+    ret = lchown(buffer, credp->fc_uid, credp->fc_gid);
+    g_free(buffer);
+    return ret;
+}
+
+static int local_chown_mapped(FsContext *fs_ctx, V9fsPath *fs_path,
+                              FsCred *credp)
+{
+    char *buffer;
+    int ret = -1;
+    char *path = fs_path->data;
+
+    buffer = rpath(fs_ctx, path);
+    ret = local_set_xattr(buffer, credp);
+    g_free(buffer);
+    return ret;
+}
+
+static int local_chown_mapped_file(FsContext *fs_ctx, V9fsPath *fs_path,
+                                   FsCred *credp)
+{
+    char *path = fs_path->data;
+
+    return local_set_mapped_file_attr(fs_ctx, path, credp);
+}
+
+static int local_chown(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
+{
     if ((credp->fc_uid == -1 && credp->fc_gid == -1) ||
         (fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
         (fs_ctx->export_flags & V9FS_SM_NONE)) {
-        buffer = rpath(fs_ctx, path);
-        ret = lchown(buffer, credp->fc_uid, credp->fc_gid);
-        g_free(buffer);
+        return local_chown_passthrough(fs_ctx, fs_path, credp);
     } else if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
-        buffer = rpath(fs_ctx, path);
-        ret = local_set_xattr(buffer, credp);
-        g_free(buffer);
+        return local_chown_mapped(fs_ctx, fs_path, credp);
     } else if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        return local_set_mapped_file_attr(fs_ctx, path, credp);
+        return local_chown_mapped_file(fs_ctx, fs_path, credp);
     }
-    return ret;
+    g_assert_not_reached();
 }
 
 static int local_utimensat(FsContext *s, V9fsPath *fs_path,

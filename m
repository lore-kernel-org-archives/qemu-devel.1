Received: from eggs.gnu.org ([2001:4830:134:3::10]:46273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYApi-0007j3-3w
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:13:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYApe-0000qb-Vk
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:13:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33761)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYApe-0000qP-N5
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:13:14 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UCCuUK066952
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:13:13 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28a37q5j9b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:13:13 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:13:11 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:13:03 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577838383.10533.13809232167735564817.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 27/36] 9pfs: local: link: don't follow
 symlinks
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

This fixes CVE-2016-9602 for the "passthrough" and "mapped" security models.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 5e320917c484..de860db3d70b 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1181,21 +1181,23 @@ out:
 static int local_link(FsContext *ctx, V9fsPath *oldpath,
                       V9fsPath *dirpath, const char *name)
 {
-    int ret;
-    V9fsString newpath;
-    char *buffer, *buffer1;
-    int serrno;
-
-    v9fs_string_init(&newpath);
-    v9fs_string_sprintf(&newpath, "%s/%s", dirpath->data, name);
+    char *odirpath = local_dirname(oldpath->data);
+    char *oname = local_basename(oldpath->data);
+    int ret = -1;
+    int odirfd, ndirfd;
 
-    buffer = rpath(ctx, oldpath->data);
-    buffer1 = rpath(ctx, newpath.data);
-    ret = link(buffer, buffer1);
-    g_free(buffer);
-    if (ret < 0) {
+    odirfd = local_opendir_nofollow(ctx, odirpath);
+    if (odirfd == -1) {
         goto out;
     }
+    ndirfd = local_opendir_nofollow(ctx, dirpath->data);
+    if (ndirfd == -1) {
+        goto out_close_odirfd;
+    }
+    ret = linkat(odirfd, oname, ndirfd, name, AT_SYMLINK_FOLLOW);
+    if (ret < 0) {
+        goto out_close_ndirfd;
+    }
 
     /* now link the virtfs_metadata files */
     if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
@@ -1204,15 +1206,17 @@ static int local_link(FsContext *ctx, V9fsPath *oldpath,
             goto err_out;
         }
     }
-    goto out;
+    goto out_close_ndirfd;
 
 err_out:
-    serrno = errno;
-    remove(buffer1);
-    errno = serrno;
+    unlinkat_preserve_errno(ndirfd, name, 0);
+out_close_ndirfd:
+    close_preserve_errno(ndirfd);
+out_close_odirfd:
+    close_preserve_errno(odirfd);
 out:
-    g_free(buffer1);
-    v9fs_string_free(&newpath);
+    g_free(oname);
+    g_free(odirpath);
     return ret;
 }
 

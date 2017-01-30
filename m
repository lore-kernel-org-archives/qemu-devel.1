Received: from eggs.gnu.org ([2001:4830:134:3::10]:46289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYApl-0007m6-HX
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:13:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYApi-0000rM-C5
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:13:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48239
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYApi-0000rC-65
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:13:18 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC8gfO039261
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:13:17 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 289ywycfqm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:13:17 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:13:16 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:13:11 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577839159.10533.17785563097901862930.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 28/36] 9pfs: local: rename: don't follow
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
 hw/9pfs/9p-local.c |   44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index de860db3d70b..364da435350b 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -84,6 +84,14 @@ static void unlinkat_preserve_errno(int dirfd, const char *path, int flags)
     errno = serrno;
 }
 
+static void renameat_preserve_errno(int odirfd, const char *opath, int ndirfd,
+                                    const char *npath)
+{
+    int serrno = errno;
+    renameat(odirfd, opath, ndirfd, npath);
+    errno = serrno;
+}
+
 #define VIRTFS_META_DIR ".virtfs_metadata"
 
 static char *local_mapped_attr_path(FsContext *ctx, const char *path)
@@ -1259,16 +1267,22 @@ static int local_post_rename_mapped_file(FsContext *ctx, const char *oldpath,
 static int local_rename(FsContext *ctx, const char *oldpath,
                         const char *newpath)
 {
-    int err;
-    char *buffer, *buffer1;
-    int serrno;
+    char *odirpath = local_dirname(oldpath);
+    char *oname = local_basename(oldpath);
+    char *ndirpath = local_dirname(newpath);
+    char *nname = local_basename(newpath);
+    int err = -1;
+    int odirfd, ndirfd;
 
-    buffer = rpath(ctx, oldpath);
-    buffer1 = rpath(ctx, newpath);
-    err = rename(buffer, buffer1);
-    if (err < 0) {
+    odirfd = local_opendir_nofollow(ctx, odirpath);
+    if (odirfd == -1) {
         goto out;
     }
+    ndirfd = local_opendir_nofollow(ctx, ndirpath);
+    if (ndirfd < 0) {
+        goto out_close_odirfd;
+    }
+    err = renameat(odirfd, oname, ndirfd, nname);
 
     if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
         err = local_post_rename_mapped_file(ctx, oldpath, newpath);
@@ -1276,15 +1290,19 @@ static int local_rename(FsContext *ctx, const char *oldpath,
             goto err_out;
         }
     }
-    goto out;
+    goto out_close_ndirfd;
 
 err_out:
-    serrno = errno;
-    rename(buffer1, buffer);
-    errno = serrno;
+    renameat_preserve_errno(ndirfd, nname, odirfd, oname);
+out_close_ndirfd:
+    close_preserve_errno(ndirfd);
+out_close_odirfd:
+    close_preserve_errno(odirfd);
 out:
-    g_free(buffer);
-    g_free(buffer1);
+    g_free(nname);
+    g_free(ndirpath);
+    g_free(oname);
+    g_free(odirpath);
     return err;
 }
 

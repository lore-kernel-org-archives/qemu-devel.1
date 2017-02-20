Received: from eggs.gnu.org ([2001:4830:134:3::10]:54598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfpAW-0008Am-8y
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:42:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfpAT-0003zs-3b
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:42:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53444
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cfpAS-0003zj-St
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:42:21 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEd0m2034984
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:42:20 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28r00g6w1e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:42:19 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 20 Feb 2017 07:42:18 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 20 Feb 2017 15:42:11 +0100
In-Reply-To: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148760173178.31154.10880735541217141085.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 22/29] 9pfs: local: link: don't follow symlinks
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

The local_link() callback is vulnerable to symlink attacks because it calls:

(1) link() which follows symbolic links for all path elements but the
    rightmost one
(2) local_create_mapped_attr_dir()->mkdir() which follows symbolic links
    for all path elements but the rightmost one

This patch converts local_link() to rely on opendir_nofollow() and linkat()
to fix (1), mkdirat() to fix (2).

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   86 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 29 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 9b9c39ee42ee..fb536fdb3082 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -69,6 +69,13 @@ static void renameat_preserve_errno(int odirfd, const char *opath, int ndirfd,
     errno = serrno;
 }
 
+static void unlinkat_preserve_errno(int dirfd, const char *path, int flags)
+{
+    int serrno = errno;
+    unlinkat(dirfd, path, flags);
+    errno = serrno;
+}
+
 #define VIRTFS_META_DIR ".virtfs_metadata"
 
 static char *local_mapped_attr_path(FsContext *ctx, const char *path)
@@ -912,49 +919,70 @@ out:
 static int local_link(FsContext *ctx, V9fsPath *oldpath,
                       V9fsPath *dirpath, const char *name)
 {
-    int ret;
-    V9fsString newpath;
-    char *buffer, *buffer1;
-    int serrno;
+    char *odirpath = g_path_get_dirname(oldpath->data);
+    char *oname = g_path_get_basename(oldpath->data);
+    int ret = -1;
+    int odirfd, ndirfd;
 
-    v9fs_string_init(&newpath);
-    v9fs_string_sprintf(&newpath, "%s/%s", dirpath->data, name);
+    odirfd = local_opendir_nofollow(ctx, odirpath);
+    if (odirfd == -1) {
+        goto out;
+    }
 
-    buffer = rpath(ctx, oldpath->data);
-    buffer1 = rpath(ctx, newpath.data);
-    ret = link(buffer, buffer1);
-    g_free(buffer);
-    if (ret < 0) {
+    ndirfd = local_opendir_nofollow(ctx, dirpath->data);
+    if (ndirfd == -1) {
+        close_preserve_errno(odirfd);
         goto out;
     }
 
+    ret = linkat(odirfd, oname, ndirfd, name, 0);
+    if (ret < 0) {
+        goto out_close;
+    }
+
     /* now link the virtfs_metadata files */
     if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        char *vbuffer, *vbuffer1;
+        int omap_dirfd, nmap_dirfd;
 
-        /* Link the .virtfs_metadata files. Create the metada directory */
-        ret = local_create_mapped_attr_dir(ctx, newpath.data);
-        if (ret < 0) {
-            goto err_out;
+        ret = mkdirat(ndirfd, VIRTFS_META_DIR, 0700);
+        if (ret < 0 && errno != EEXIST) {
+            goto err_undo_link;
         }
-        vbuffer = local_mapped_attr_path(ctx, oldpath->data);
-        vbuffer1 = local_mapped_attr_path(ctx, newpath.data);
-        ret = link(vbuffer, vbuffer1);
-        g_free(vbuffer);
-        g_free(vbuffer1);
+
+        omap_dirfd = openat(odirfd, VIRTFS_META_DIR,
+                            O_RDONLY | O_DIRECTORY | O_NOFOLLOW);
+        if (omap_dirfd == -1) {
+            goto err;
+        }
+
+        nmap_dirfd = openat(ndirfd, VIRTFS_META_DIR,
+                            O_RDONLY | O_DIRECTORY | O_NOFOLLOW);
+        if (nmap_dirfd == -1) {
+            close_preserve_errno(omap_dirfd);
+            goto err;
+        }
+
+        ret = linkat(omap_dirfd, oname, nmap_dirfd, name, 0);
+        close_preserve_errno(nmap_dirfd);
+        close_preserve_errno(omap_dirfd);
         if (ret < 0 && errno != ENOENT) {
-            goto err_out;
+            goto err_undo_link;
         }
+
+        ret = 0;
     }
-    goto out;
+    goto out_close;
 
-err_out:
-    serrno = errno;
-    remove(buffer1);
-    errno = serrno;
+err:
+    ret = -1;
+err_undo_link:
+    unlinkat_preserve_errno(ndirfd, name, 0);
+out_close:
+    close_preserve_errno(ndirfd);
+    close_preserve_errno(odirfd);
 out:
-    g_free(buffer1);
-    v9fs_string_free(&newpath);
+    g_free(oname);
+    g_free(odirpath);
     return ret;
 }
 

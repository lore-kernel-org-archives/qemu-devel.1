Received: from eggs.gnu.org ([2001:4830:134:3::10]:51052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ci7Z3-0007YD-VE
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:45:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ci7Z0-0003DM-Rp
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:45:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60056
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ci7Z0-0003DF-LP
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:45:10 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1QMi31v131897
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 17:45:10 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28uqvkssjv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 17:45:09 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Sun, 26 Feb 2017 15:45:09 -0700
From: Greg Kurz <groug@kaod.org>
Date: Sun, 26 Feb 2017 23:45:02 +0100
In-Reply-To: <148814889214.28146.16915712763478774662.stgit@bahia>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148814910201.28146.7217483545833853712.stgit@bahia>
Subject: [Qemu-devel] [PATCH v2 26/28] 9pfs: local: mkdir: don't follow
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
Cc: Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

The local_mkdir() callback is vulnerable to symlink attacks because it
calls:

(1) mkdir() which follows symbolic links for all path elements but the
    rightmost one
(2) local_set_xattr()->setxattr() which follows symbolic links for all
    path elements
(3) local_set_mapped_file_attr() which calls in turn local_fopen() and
    mkdir(), both functions following symbolic links for all path
    elements but the rightmost one
(4) local_post_create_passthrough() which calls in turn lchown() and
    chmod(), both functions also following symbolic links

This patch converts local_mkdir() to rely on opendir_nofollow() and
mkdirat() to fix (1), as well as local_set_xattrat(),
local_set_mapped_file_attrat() and local_set_cred_passthrough() to
fix (2), (3) and (4) respectively.

The mapped and mapped-file security modes are supposed to be identical,
except for the place where credentials and file modes are stored. While
here, we also make that explicit by sharing the call to mkdirat().

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/9pfs/9p-local.c |   55 +++++++++++++++++++---------------------------------
 1 file changed, 20 insertions(+), 35 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 4766175dda72..9b28bb530ae9 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -799,62 +799,47 @@ out:
 static int local_mkdir(FsContext *fs_ctx, V9fsPath *dir_path,
                        const char *name, FsCred *credp)
 {
-    char *path;
     int err = -1;
-    int serrno = 0;
-    V9fsString fullname;
-    char *buffer = NULL;
+    int dirfd;
 
-    v9fs_string_init(&fullname);
-    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
-    path = fullname.data;
+    dirfd = local_opendir_nofollow(fs_ctx, dir_path->data);
+    if (dirfd == -1) {
+        return -1;
+    }
 
-    /* Determine the security model */
-    if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
-        buffer = rpath(fs_ctx, path);
-        err = mkdir(buffer, SM_LOCAL_DIR_MODE_BITS);
+    if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
+        fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
+        err = mkdirat(dirfd, name, SM_LOCAL_DIR_MODE_BITS);
         if (err == -1) {
             goto out;
         }
-        credp->fc_mode = credp->fc_mode|S_IFDIR;
-        err = local_set_xattr(buffer, credp);
-        if (err == -1) {
-            serrno = errno;
-            goto err_end;
-        }
-    } else if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        buffer = rpath(fs_ctx, path);
-        err = mkdir(buffer, SM_LOCAL_DIR_MODE_BITS);
-        if (err == -1) {
-            goto out;
+        credp->fc_mode = credp->fc_mode | S_IFDIR;
+
+        if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
+            err = local_set_xattrat(dirfd, name, credp);
+        } else {
+            err = local_set_mapped_file_attrat(dirfd, name, credp);
         }
-        credp->fc_mode = credp->fc_mode|S_IFDIR;
-        err = local_set_mapped_file_attr(fs_ctx, path, credp);
         if (err == -1) {
-            serrno = errno;
             goto err_end;
         }
-    } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
-               (fs_ctx->export_flags & V9FS_SM_NONE)) {
-        buffer = rpath(fs_ctx, path);
-        err = mkdir(buffer, credp->fc_mode);
+    } else if (fs_ctx->export_flags & V9FS_SM_PASSTHROUGH ||
+               fs_ctx->export_flags & V9FS_SM_NONE) {
+        err = mkdirat(dirfd, name, credp->fc_mode);
         if (err == -1) {
             goto out;
         }
-        err = local_post_create_passthrough(fs_ctx, path, credp);
+        err = local_set_cred_passthrough(fs_ctx, dirfd, name, credp);
         if (err == -1) {
-            serrno = errno;
             goto err_end;
         }
     }
     goto out;
 
 err_end:
-    remove(buffer);
-    errno = serrno;
+    unlinkat_preserve_errno(dirfd, name, AT_REMOVEDIR);
 out:
-    g_free(buffer);
-    v9fs_string_free(&fullname);
+    close_preserve_errno(dirfd);
     return err;
 }
 

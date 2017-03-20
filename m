Received: from eggs.gnu.org ([2001:4830:134:3::10]:40668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qc-0001aJ-Pu
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6QY-0004qE-8q
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6QX-0004oi-Po
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:26 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8YuW109702
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:24 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ak40pby4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:24 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:23 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:07:49 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-26-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 25/81] 9pfs: local: mknod: don't follow symlinks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, Greg Kurz <gkurz@linux.vnet.ibm.com>

From: Greg Kurz <groug@kaod.org>

The local_mknod() callback is vulnerable to symlink attacks because it
calls:

(1) mknod() which follows symbolic links for all path elements but the
    rightmost one
(2) local_set_xattr()->setxattr() which follows symbolic links for all
    path elements
(3) local_set_mapped_file_attr() which calls in turn local_fopen() and
    mkdir(), both functions following symbolic links for all path
    elements but the rightmost one
(4) local_post_create_passthrough() which calls in turn lchown() and
    chmod(), both functions also following symbolic links

This patch converts local_mknod() to rely on opendir_nofollow() and
mknodat() to fix (1), as well as local_set_xattrat() and
local_set_mapped_file_attrat() to fix (2) and (3) respectively.

A new local_set_cred_passthrough() helper based on fchownat() and
fchmodat_nofollow() is introduced as a replacement to
local_post_create_passthrough() to fix (4).

The mapped and mapped-file security modes are supposed to be identical,
except for the place where credentials and file modes are stored. While
here, we also make that explicit by sharing the call to mknodat().

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit d815e7219036d6911fce12efe3e59906264c8536)
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-local.c | 68 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 2bb77e2..f71cc11 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -543,6 +543,23 @@ err:
     return -1;
 }
 
+static int local_set_cred_passthrough(FsContext *fs_ctx, int dirfd,
+                                      const char *name, FsCred *credp)
+{
+    if (fchownat(dirfd, name, credp->fc_uid, credp->fc_gid,
+                 AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH) < 0) {
+        /*
+         * If we fail to change ownership and if we are
+         * using security model none. Ignore the error
+         */
+        if ((fs_ctx->export_flags & V9FS_SEC_MASK) != V9FS_SM_NONE) {
+            return -1;
+        }
+    }
+
+    return fchmodat_nofollow(dirfd, name, credp->fc_mode & 07777);
+}
+
 static ssize_t local_readlink(FsContext *fs_ctx, V9fsPath *fs_path,
                               char *buf, size_t bufsz)
 {
@@ -737,61 +754,46 @@ out:
 static int local_mknod(FsContext *fs_ctx, V9fsPath *dir_path,
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
-        err = mknod(buffer, SM_LOCAL_MODE_BITS|S_IFREG, 0);
+    if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
+        fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
+        err = mknodat(dirfd, name, SM_LOCAL_MODE_BITS | S_IFREG, 0);
         if (err == -1) {
             goto out;
         }
-        err = local_set_xattr(buffer, credp);
-        if (err == -1) {
-            serrno = errno;
-            goto err_end;
-        }
-    } else if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
 
-        buffer = rpath(fs_ctx, path);
-        err = mknod(buffer, SM_LOCAL_MODE_BITS|S_IFREG, 0);
-        if (err == -1) {
-            goto out;
+        if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
+            err = local_set_xattrat(dirfd, name, credp);
+        } else {
+            err = local_set_mapped_file_attrat(dirfd, name, credp);
         }
-        err = local_set_mapped_file_attr(fs_ctx, path, credp);
         if (err == -1) {
-            serrno = errno;
             goto err_end;
         }
-    } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
-               (fs_ctx->export_flags & V9FS_SM_NONE)) {
-        buffer = rpath(fs_ctx, path);
-        err = mknod(buffer, credp->fc_mode, credp->fc_rdev);
+    } else if (fs_ctx->export_flags & V9FS_SM_PASSTHROUGH ||
+               fs_ctx->export_flags & V9FS_SM_NONE) {
+        err = mknodat(dirfd, name, credp->fc_mode, credp->fc_rdev);
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
+    unlinkat_preserve_errno(dirfd, name, 0);
 out:
-    g_free(buffer);
-    v9fs_string_free(&fullname);
+    close_preserve_errno(dirfd);
     return err;
 }
 
-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:40365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6QW-0001Qy-DH
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6QS-0004i4-Dt
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46812
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6QS-0004ga-6x
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:20 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8W5e084386
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:19 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29amb2aayg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:19 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:18 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:07:36 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-13-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 12/81] 9pfs: local: remove: don't follow
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
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, Greg Kurz <gkurz@linux.vnet.ibm.com>

From: Greg Kurz <groug@kaod.org>

The local_remove() callback is vulnerable to symlink attacks because it
calls:

(1) lstat() which follows symbolic links in all path elements but the
    rightmost one
(2) remove() which follows symbolic links in all path elements but the
    rightmost one

This patch converts local_remove() to rely on opendir_nofollow(),
fstatat(AT_SYMLINK_NOFOLLOW) to fix (1) and unlinkat() to fix (2).

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit a0e640a87210b1e986bcd4e7f7de03beb3db0a4a)
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-local.c | 64 ++++++++++++++++++------------------------------------
 1 file changed, 21 insertions(+), 43 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index a72adb8..9caee0e 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1022,54 +1022,32 @@ err_out:
 
 static int local_remove(FsContext *ctx, const char *path)
 {
-    int err;
     struct stat stbuf;
-    char *buffer;
+    char *dirpath = g_path_get_dirname(path);
+    char *name = g_path_get_basename(path);
+    int flags = 0;
+    int dirfd;
+    int err = -1;
 
-    if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        buffer = rpath(ctx, path);
-        err =  lstat(buffer, &stbuf);
-        g_free(buffer);
-        if (err) {
-            goto err_out;
-        }
-        /*
-         * If directory remove .virtfs_metadata contained in the
-         * directory
-         */
-        if (S_ISDIR(stbuf.st_mode)) {
-            buffer = g_strdup_printf("%s/%s/%s", ctx->fs_root,
-                                     path, VIRTFS_META_DIR);
-            err = remove(buffer);
-            g_free(buffer);
-            if (err < 0 && errno != ENOENT) {
-                /*
-                 * We didn't had the .virtfs_metadata file. May be file created
-                 * in non-mapped mode ?. Ignore ENOENT.
-                 */
-                goto err_out;
-            }
-        }
-        /*
-         * Now remove the name from parent directory
-         * .virtfs_metadata directory
-         */
-        buffer = local_mapped_attr_path(ctx, path);
-        err = remove(buffer);
-        g_free(buffer);
-        if (err < 0 && errno != ENOENT) {
-            /*
-             * We didn't had the .virtfs_metadata file. May be file created
-             * in non-mapped mode ?. Ignore ENOENT.
-             */
-            goto err_out;
-        }
+    dirfd = local_opendir_nofollow(ctx, dirpath);
+    if (dirfd) {
+        goto out;
     }
 
-    buffer = rpath(ctx, path);
-    err = remove(buffer);
-    g_free(buffer);
+    if (fstatat(dirfd, path, &stbuf, AT_SYMLINK_NOFOLLOW) < 0) {
+        goto err_out;
+    }
+
+    if (S_ISDIR(stbuf.st_mode)) {
+        flags |= AT_REMOVEDIR;
+    }
+
+    err = local_unlinkat_common(ctx, dirfd, name, flags);
 err_out:
+    close_preserve_errno(dirfd);
+out:
+    g_free(name);
+    g_free(dirpath);
     return err;
 }
 
-- 
2.7.4

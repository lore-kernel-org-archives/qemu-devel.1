Received: from eggs.gnu.org ([2001:4830:134:3::10]:37652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cif3k-0001Gz-LJ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:31:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cif3h-0007ys-AG
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:31:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cif3h-0007yI-0C
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:31:05 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1SASlfS055073
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 05:31:04 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28vnaj7syk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 05:31:03 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 28 Feb 2017 10:31:01 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 28 Feb 2017 11:30:24 +0100
In-Reply-To: <1488277840-18608-1-git-send-email-groug@kaod.org>
References: <1488277840-18608-1-git-send-email-groug@kaod.org>
Message-Id: <1488277840-18608-13-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 12/28] 9pfs: local: remove: don't follow symlinks
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
---
 hw/9pfs/9p-local.c | 64 ++++++++++++++++++------------------------------------
 1 file changed, 21 insertions(+), 43 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 04de511765d8..8fb79e44b5f3 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1021,54 +1021,32 @@ err_out:
 
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

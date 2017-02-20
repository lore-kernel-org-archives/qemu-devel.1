Received: from eggs.gnu.org ([2001:4830:134:3::10]:54259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp9Q-0006tQ-AW
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:41:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp9J-0003nE-On
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:41:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cfp9J-0003n5-Ec
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:41:09 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEd8BC048601
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:41:08 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28pphvhpb6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:41:08 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 20 Feb 2017 07:41:07 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 20 Feb 2017 15:41:00 +0100
In-Reply-To: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148760166051.31154.9036980312875397552.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 13/29] 9pfs: local: remove: don't follow
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

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
---
 hw/9pfs/9p-local.c |   64 +++++++++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 43 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 21522ca7de43..c6f4c8d95442 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1016,54 +1016,32 @@ err_out:
 
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
 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:40410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6QW-0001Rb-PU
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6QT-0004in-41
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44925
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6QS-0004iO-U0
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:21 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8ptT008189
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:20 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29afu7a7vy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:20 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:19 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:07:42 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-19-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 18/81] 9pfs: local: renameat: don't follow
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

The local_renameat() callback is currently a wrapper around local_rename()
which is vulnerable to symlink attacks.

This patch rewrites local_renameat() to have its own implementation, based
on local_opendir_nofollow() and renameat().

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 99f2cf4b2dad7b37c69759deb0d0b19d3ec1a24a)
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-local.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 10 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 547baa4..f2adf25 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -67,6 +67,14 @@ int local_opendir_nofollow(FsContext *fs_ctx, const char *path)
     return local_open_nofollow(fs_ctx, path, O_DIRECTORY | O_RDONLY, 0);
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
@@ -146,8 +154,7 @@ static void local_mapped_file_attr(int dirfd, const char *name,
     char buf[ATTR_MAX];
     int map_dirfd;
 
-    map_dirfd = openat(dirfd, VIRTFS_META_DIR,
-                       O_RDONLY | O_DIRECTORY | O_NOFOLLOW);
+    map_dirfd = openat_dir(dirfd, VIRTFS_META_DIR);
     if (map_dirfd == -1) {
         return;
     }
@@ -1187,17 +1194,64 @@ static int local_renameat(FsContext *ctx, V9fsPath *olddir,
                           const char *new_name)
 {
     int ret;
-    V9fsString old_full_name, new_full_name;
+    int odirfd, ndirfd;
+
+    odirfd = local_opendir_nofollow(ctx, olddir->data);
+    if (odirfd == -1) {
+        return -1;
+    }
+
+    ndirfd = local_opendir_nofollow(ctx, newdir->data);
+    if (ndirfd == -1) {
+        close_preserve_errno(odirfd);
+        return -1;
+    }
+
+    ret = renameat(odirfd, old_name, ndirfd, new_name);
+    if (ret < 0) {
+        goto out;
+    }
 
-    v9fs_string_init(&old_full_name);
-    v9fs_string_init(&new_full_name);
+    if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
+        int omap_dirfd, nmap_dirfd;
 
-    v9fs_string_sprintf(&old_full_name, "%s/%s", olddir->data, old_name);
-    v9fs_string_sprintf(&new_full_name, "%s/%s", newdir->data, new_name);
+        ret = mkdirat(ndirfd, VIRTFS_META_DIR, 0700);
+        if (ret < 0 && errno != EEXIST) {
+            goto err_undo_rename;
+        }
 
-    ret = local_rename(ctx, old_full_name.data, new_full_name.data);
-    v9fs_string_free(&old_full_name);
-    v9fs_string_free(&new_full_name);
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
+        /* rename the .virtfs_metadata files */
+        ret = renameat(omap_dirfd, old_name, nmap_dirfd, new_name);
+        close_preserve_errno(nmap_dirfd);
+        close_preserve_errno(omap_dirfd);
+        if (ret < 0 && errno != ENOENT) {
+            goto err_undo_rename;
+        }
+
+        ret = 0;
+    }
+    goto out;
+
+err:
+    ret = -1;
+err_undo_rename:
+    renameat_preserve_errno(ndirfd, new_name, odirfd, old_name);
+out:
+    close_preserve_errno(ndirfd);
+    close_preserve_errno(odirfd);
     return ret;
 }
 
-- 
2.7.4

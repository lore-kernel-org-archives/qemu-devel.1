Received: from eggs.gnu.org ([2001:4830:134:3::10]:40469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6QX-0001SH-Ta
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6QW-0004nX-6n
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6QV-0004la-TE
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:24 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8Y8S020563
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:23 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 299yqc6ygr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:22 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:21 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:07:44 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-21-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 20/81] 9pfs: local: improve error handling in
 link op
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

When using the mapped-file security model, we also have to create a link
for the metadata file if it exists. In case of failure, we should rollback.

That's what this patch does.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 6dd4b1f1d026e478d9177b28169b377e212400f3)
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-local.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 8b233b0..b2eaf88 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -921,6 +921,7 @@ static int local_link(FsContext *ctx, V9fsPath *oldpath,
     int ret;
     V9fsString newpath;
     char *buffer, *buffer1;
+    int serrno;
 
     v9fs_string_init(&newpath);
     v9fs_string_sprintf(&newpath, "%s/%s", dirpath->data, name);
@@ -929,25 +930,36 @@ static int local_link(FsContext *ctx, V9fsPath *oldpath,
     buffer1 = rpath(ctx, newpath.data);
     ret = link(buffer, buffer1);
     g_free(buffer);
-    g_free(buffer1);
+    if (ret < 0) {
+        goto out;
+    }
 
     /* now link the virtfs_metadata files */
-    if (!ret && (ctx->export_flags & V9FS_SM_MAPPED_FILE)) {
+    if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
+        char *vbuffer, *vbuffer1;
+
         /* Link the .virtfs_metadata files. Create the metada directory */
         ret = local_create_mapped_attr_dir(ctx, newpath.data);
         if (ret < 0) {
             goto err_out;
         }
-        buffer = local_mapped_attr_path(ctx, oldpath->data);
-        buffer1 = local_mapped_attr_path(ctx, newpath.data);
-        ret = link(buffer, buffer1);
-        g_free(buffer);
-        g_free(buffer1);
+        vbuffer = local_mapped_attr_path(ctx, oldpath->data);
+        vbuffer1 = local_mapped_attr_path(ctx, newpath.data);
+        ret = link(vbuffer, vbuffer1);
+        g_free(vbuffer);
+        g_free(vbuffer1);
         if (ret < 0 && errno != ENOENT) {
             goto err_out;
         }
     }
+    goto out;
+
 err_out:
+    serrno = errno;
+    remove(buffer1);
+    errno = serrno;
+out:
+    g_free(buffer1);
     v9fs_string_free(&newpath);
     return ret;
 }
@@ -1190,14 +1202,12 @@ static int local_renameat(FsContext *ctx, V9fsPath *olddir,
             goto err_undo_rename;
         }
 
-        omap_dirfd = openat(odirfd, VIRTFS_META_DIR,
-                            O_RDONLY | O_DIRECTORY | O_NOFOLLOW);
+        omap_dirfd = openat_dir(odirfd, VIRTFS_META_DIR);
         if (omap_dirfd == -1) {
             goto err;
         }
 
-        nmap_dirfd = openat(ndirfd, VIRTFS_META_DIR,
-                            O_RDONLY | O_DIRECTORY | O_NOFOLLOW);
+        nmap_dirfd = openat_dir(ndirfd, VIRTFS_META_DIR);
         if (nmap_dirfd == -1) {
             close_preserve_errno(omap_dirfd);
             goto err;
-- 
2.7.4

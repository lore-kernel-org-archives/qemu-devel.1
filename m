Received: from eggs.gnu.org ([2001:4830:134:3::10]:50890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ci7YH-0006lY-3G
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:44:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ci7YD-00034h-Uc
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:44:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ci7YD-00034b-LK
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:44:21 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1QMi2WU027245
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 17:44:20 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28u6y5kxbb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 17:44:20 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Sun, 26 Feb 2017 15:44:19 -0700
From: Greg Kurz <groug@kaod.org>
Date: Sun, 26 Feb 2017 23:44:11 +0100
In-Reply-To: <148814889214.28146.16915712763478774662.stgit@bahia>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148814905168.28146.6937613688176042132.stgit@bahia>
Subject: [Qemu-devel] [PATCH v2 20/28] 9pfs: local: improve error handling
 in link op
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

When using the mapped-file security model, we also have to create a link
for the metadata file if it exists. In case of failure, we should rollback.

That's what this patch does.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v2: - use openat_dir()
---
 hw/9pfs/9p-local.c |   32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 442d0475c7cd..03f4f5e913c6 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -920,6 +920,7 @@ static int local_link(FsContext *ctx, V9fsPath *oldpath,
     int ret;
     V9fsString newpath;
     char *buffer, *buffer1;
+    int serrno;
 
     v9fs_string_init(&newpath);
     v9fs_string_sprintf(&newpath, "%s/%s", dirpath->data, name);
@@ -928,25 +929,36 @@ static int local_link(FsContext *ctx, V9fsPath *oldpath,
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
@@ -1189,14 +1201,12 @@ static int local_renameat(FsContext *ctx, V9fsPath *olddir,
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

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfpAj-0008PE-Tx
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfpAg-00041f-O2
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:42:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cfpAg-00041X-EN
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:42:34 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEgXT1092927
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:42:33 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28pnxqka17-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:42:33 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 20 Feb 2017 07:42:32 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 20 Feb 2017 15:42:26 +0100
In-Reply-To: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148760174673.31154.11366007991909627456.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 24/29] 9pfs: local: chown: don't follow symlinks
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

The local_chown() callback is vulnerable to symlink attacks because it
calls:

(1) lchown() which follows symbolic links for all path elements but the
    rightmost one
(2) local_set_xattr()->setxattr() which follows symbolic links for all
    path elements
(3) local_set_mapped_file_attr() which calls in turn local_fopen() and
    mkdir(), both functions following symbolic links for all path
    elements but the rightmost one

This patch converts local_chown() to rely on open_nofollow() and
fchownat() to fix (1), as well as local_set_xattrat() and
local_set_mapped_file_attrat() to fix (2) and (3) respectively.

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 56d7731f7ce1..7f1e105d72aa 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1138,23 +1138,31 @@ static int local_truncate(FsContext *ctx, V9fsPath *fs_path, off_t size)
 
 static int local_chown(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
 {
-    char *buffer;
+    char *dirpath = g_path_get_dirname(fs_path->data);
+    char *name = g_path_get_basename(fs_path->data);
     int ret = -1;
-    char *path = fs_path->data;
+    int dirfd;
+
+    dirfd = local_opendir_nofollow(fs_ctx, dirpath);
+    if (dirfd == -1) {
+        goto out;
+    }
 
     if ((credp->fc_uid == -1 && credp->fc_gid == -1) ||
         (fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
         (fs_ctx->export_flags & V9FS_SM_NONE)) {
-        buffer = rpath(fs_ctx, path);
-        ret = lchown(buffer, credp->fc_uid, credp->fc_gid);
-        g_free(buffer);
+        ret = fchownat(dirfd, name, credp->fc_uid, credp->fc_gid,
+                       AT_SYMLINK_NOFOLLOW);
     } else if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
-        buffer = rpath(fs_ctx, path);
-        ret = local_set_xattr(buffer, credp);
-        g_free(buffer);
+        ret = local_set_xattrat(dirfd, name, credp);
     } else if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        return local_set_mapped_file_attr(fs_ctx, path, credp);
+        ret = local_set_mapped_file_attrat(dirfd, name, credp);
     }
+
+    close_preserve_errno(dirfd);
+out:
+    g_free(name);
+    g_free(dirpath);
     return ret;
 }
 

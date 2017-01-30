Received: from eggs.gnu.org ([2001:4830:134:3::10]:46215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYApP-0007Rh-Ck
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:13:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYApM-0000dn-86
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYApL-0000c0-Vf
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:56 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC9D00038969
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:12:55 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2890j99jc5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:12:54 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:12:54 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:12:48 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577836845.10533.6062596840936192051.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 25/36] 9pfs: local: symlink: don't follow
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
Cc: ppandit@redhat.com, jannh@google.com, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This fixes CVE-2016-9602 for the "passthrough" security model.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 9dfa3e306245..bbc08184564f 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1100,29 +1100,25 @@ static int local_symlink_passthrough(FsContext *fs_ctx, const char *oldpath,
                                      V9fsPath *dir_path, const char *name,
                                      FsCred *credp)
 {
-    int err = -1;
-    int serrno = 0;
-    char *newpath;
-    V9fsString fullname;
-    char *buffer = NULL;
+    int dirfd, err;
 
-    v9fs_string_init(&fullname);
-    v9fs_string_sprintf(&fullname, "%s/%s", dir_path->data, name);
-    newpath = fullname.data;
+    dirfd = local_opendir_nofollow(fs_ctx, dir_path->data);
+    if (dirfd == -1) {
+        return -1;
+    }
 
-    buffer = rpath(fs_ctx, newpath);
-    err = symlink(oldpath, buffer);
+    err = symlinkat(oldpath, dirfd, name);
     if (err) {
         goto out;
     }
-    err = lchown(buffer, credp->fc_uid, credp->fc_gid);
+    err = fchownat(dirfd, name, credp->fc_uid, credp->fc_gid,
+                   AT_SYMLINK_NOFOLLOW);
     if (err == -1) {
         /*
          * If we fail to change ownership and if we are
          * using security model none. Ignore the error
          */
         if ((fs_ctx->export_flags & V9FS_SEC_MASK) != V9FS_SM_NONE) {
-            serrno = errno;
             goto err_end;
         } else {
             err = 0;
@@ -1131,11 +1127,9 @@ static int local_symlink_passthrough(FsContext *fs_ctx, const char *oldpath,
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
 

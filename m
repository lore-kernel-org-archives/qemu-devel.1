Received: from eggs.gnu.org ([2001:4830:134:3::10]:54067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp8s-0006VT-In
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:40:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp8p-0003fP-CQ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:40:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37679
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cfp8p-0003fC-1l
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:40:39 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEcswr126948
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:40:38 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28r012ptv0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:40:38 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 20 Feb 2017 09:40:37 -0500
From: Greg Kurz <groug@kaod.org>
Date: Mon, 20 Feb 2017 15:40:30 +0100
In-Reply-To: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148760163084.31154.3895291117452367500.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 09/29] 9pfs: local: llistxattr: don't follow
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

The local_llistxattr() callback is vulnerable to symlink attacks because
it calls llistxattr() which follows symbolic links in all path elements but
the rightmost one.

This patch converts local_llistxattr() to rely on opendir_nofollow() and
flistxattrat_nofollow() instead.

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-xattr.c |   30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/9p-xattr.c b/hw/9pfs/9p-xattr.c
index 4c3c0046bd47..803d4bbbc50b 100644
--- a/hw/9pfs/9p-xattr.c
+++ b/hw/9pfs/9p-xattr.c
@@ -216,6 +216,11 @@ ssize_t pt_listxattr(FsContext *ctx, const char *path,
     return name_size;
 }
 
+static ssize_t flistxattrat(int dirfd, const char *path, char *list,
+                            size_t size)
+{
+    return do_xattrat_op(XATTRAT_OP_LIST, dirfd, path, NULL, list, size, 0);
+}
 
 /*
  * Get the list and pass to each layer to find out whether
@@ -225,24 +230,37 @@ ssize_t v9fs_list_xattr(FsContext *ctx, const char *path,
                         void *value, size_t vsize)
 {
     ssize_t size = 0;
-    char *buffer;
     void *ovalue = value;
     XattrOperations *xops;
     char *orig_value, *orig_value_start;
     ssize_t xattr_len, parsed_len = 0, attr_len;
+    char *dirpath, *name;
+    int dirfd;
 
     /* Get the actual len */
-    buffer = rpath(ctx, path);
-    xattr_len = llistxattr(buffer, value, 0);
+    dirpath = g_path_get_dirname(path);
+    dirfd = local_opendir_nofollow(ctx, dirpath);
+    g_free(dirpath);
+    if (dirfd == -1) {
+        return -1;
+    }
+
+    name = g_path_get_basename(path);
+    xattr_len = flistxattrat(dirfd, name, value, 0);
     if (xattr_len <= 0) {
-        g_free(buffer);
+        g_free(name);
+        close_preserve_errno(dirfd);
         return xattr_len;
     }
 
     /* Now fetch the xattr and find the actual size */
     orig_value = g_malloc(xattr_len);
-    xattr_len = llistxattr(buffer, orig_value, xattr_len);
-    g_free(buffer);
+    xattr_len = flistxattrat(dirfd, name, orig_value, xattr_len);
+    g_free(name);
+    close_preserve_errno(dirfd);
+    if (xattr_len < 0) {
+        return -1;
+    }
 
     /* store the orig pointer */
     orig_value_start = orig_value;

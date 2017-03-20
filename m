Received: from eggs.gnu.org ([2001:4830:134:3::10]:42095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6RC-0002Dw-CH
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6R0-0005Mb-0L
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40305
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qz-0005LZ-Nd
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:53 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8YoP028796
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:53 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29amb5t7kb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:53 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:52 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:07:32 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-9-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 08/81] 9pfs: local: llistxattr: don't follow
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

The local_llistxattr() callback is vulnerable to symlink attacks because
it calls llistxattr() which follows symbolic links in all path elements but
the rightmost one.

This patch introduces a helper to emulate the non-existing flistxattrat()
function: it is implemented with /proc/self/fd which provides a trusted
path that can be safely passed to llistxattr().

local_llistxattr() is converted to use this helper and opendir_nofollow().

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 5507904e362df252f6065cb27d1ff98372db6abc)
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-xattr.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/9p-xattr.c b/hw/9pfs/9p-xattr.c
index aa4391e..54193c6 100644
--- a/hw/9pfs/9p-xattr.c
+++ b/hw/9pfs/9p-xattr.c
@@ -60,6 +60,16 @@ ssize_t pt_listxattr(FsContext *ctx, const char *path,
     return name_size;
 }
 
+static ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
+                                     char *list, size_t size)
+{
+    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
+    int ret;
+
+    ret = llistxattr(proc_path, list, size);
+    g_free(proc_path);
+    return ret;
+}
 
 /*
  * Get the list and pass to each layer to find out whether
@@ -69,24 +79,37 @@ ssize_t v9fs_list_xattr(FsContext *ctx, const char *path,
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
+    xattr_len = flistxattrat_nofollow(dirfd, name, value, 0);
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
+    xattr_len = flistxattrat_nofollow(dirfd, name, orig_value, xattr_len);
+    g_free(name);
+    close_preserve_errno(dirfd);
+    if (xattr_len < 0) {
+        return -1;
+    }
 
     /* store the orig pointer */
     orig_value_start = orig_value;
-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cif3h-0001E6-2v
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:31:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cif3d-0007xX-Mo
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:31:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53559
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cif3d-0007xE-Du
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:31:01 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1SASkNb043957
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 05:31:00 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28vn6ar6fq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 05:31:00 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 28 Feb 2017 10:30:58 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 28 Feb 2017 11:30:20 +0100
In-Reply-To: <1488277840-18608-1-git-send-email-groug@kaod.org>
References: <1488277840-18608-1-git-send-email-groug@kaod.org>
Message-Id: <1488277840-18608-9-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 08/28] 9pfs: local: llistxattr: don't follow
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

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
---
 hw/9pfs/9p-xattr.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/9p-xattr.c b/hw/9pfs/9p-xattr.c
index aa4391e6b317..54193c630c9d 100644
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

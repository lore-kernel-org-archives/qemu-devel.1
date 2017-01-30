Received: from eggs.gnu.org ([2001:4830:134:3::10]:46640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAr6-0000Wc-Tj
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:14:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAr3-00016X-Pz
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:14:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37381
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAr3-00016L-Je
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:14:41 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UCEYB3171830
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:14:41 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 289954wvjr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:14:36 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:14:02 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:13:56 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577843680.10533.18024708307122210366.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 34/36] 9pfs: local: llistxattr: don't
 follow symlinks
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

This fixes CVE-2016-9602 for all security models.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-xattr.c |   30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/9p-xattr.c b/hw/9pfs/9p-xattr.c
index 29f4f940a23f..08df02e0bab2 100644
--- a/hw/9pfs/9p-xattr.c
+++ b/hw/9pfs/9p-xattr.c
@@ -214,6 +214,11 @@ ssize_t pt_listxattr(FsContext *ctx, const char *path,
     return name_size;
 }
 
+static ssize_t flistxattrat(int dirfd, const char *path, char *list,
+                            size_t size)
+{
+    return do_xattrat_op(XATTRAT_OP_LIST, dirfd, path, NULL, list, size, 0);
+}
 
 /*
  * Get the list and pass to each layer to find out whether
@@ -223,24 +228,37 @@ ssize_t v9fs_list_xattr(FsContext *ctx, const char *path,
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
+    dirpath = local_dirname(path);
+    dirfd = local_opendir_nofollow(ctx, dirpath);
+    g_free(dirpath);
+    if (dirfd == -1) {
+        return -1;
+    }
+
+    name = local_basename(path);
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

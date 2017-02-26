Received: from eggs.gnu.org ([2001:4830:134:3::10]:50530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ci7Wg-00051H-0N
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:42:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ci7Wc-0002ph-SB
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:42:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ci7Wc-0002pS-I0
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:42:42 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1QMcesr070066
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 17:42:41 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28u6xmv0gq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 17:42:41 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Sun, 26 Feb 2017 15:42:40 -0700
From: Greg Kurz <groug@kaod.org>
Date: Sun, 26 Feb 2017 23:42:34 +0100
In-Reply-To: <148814889214.28146.16915712763478774662.stgit@bahia>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148814895464.28146.14337427309543597613.stgit@bahia>
Subject: [Qemu-devel] [PATCH v2 08/28] 9pfs: local: llistxattr: don't follow
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
Cc: Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

The local_llistxattr() callback is vulnerable to symlink attacks because
it calls llistxattr() which follows symbolic links in all path elements but
the rightmost one.

This patch introduces a helper to emulate the non-existing flistxattrat()
function: it is implemented with /proc/self/fd which provides a trusted
path that can be safely passed to llistxattr().

local_llistxattr() is converted to use this helper and opendir_nofollow().

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: - introduce /proc based flistxattrat_nofollow()
---
 hw/9pfs/9p-xattr.c |   35 +++++++++++++++++++++++++++++------
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

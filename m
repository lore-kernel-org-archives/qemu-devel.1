Received: from eggs.gnu.org ([2001:4830:134:3::10]:40330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6QW-0001Qr-DF
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6QR-0004gK-Nl
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6QR-0004f8-EE
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:19 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8Xdt130192
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:18 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ahw0awc4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:18 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:17 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:07:37 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-14-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 13/81] 9pfs: local: utimensat: don't follow
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

The local_utimensat() callback is vulnerable to symlink attacks because it
calls qemu_utimens()->utimensat(AT_SYMLINK_NOFOLLOW) which follows symbolic
links in all path elements but the rightmost one or qemu_utimens()->utimes()
which follows symbolic links for all path elements.

This patch converts local_utimensat() to rely on opendir_nofollow() and
utimensat(AT_SYMLINK_NOFOLLOW) directly instead of using qemu_utimens().
It is hence assumed that the OS supports utimensat(), i.e. has glibc 2.6
or higher and linux 2.6.22 or higher, which seems reasonable nowadays.

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit a33eda0dd99e00faa3bacae43d19490bb9500e07)
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-local.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 9caee0e..fa1477f 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -960,13 +960,20 @@ static int local_chown(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
 static int local_utimensat(FsContext *s, V9fsPath *fs_path,
                            const struct timespec *buf)
 {
-    char *buffer;
-    int ret;
-    char *path = fs_path->data;
+    char *dirpath = g_path_get_dirname(fs_path->data);
+    char *name = g_path_get_basename(fs_path->data);
+    int dirfd, ret = -1;
 
-    buffer = rpath(s, path);
-    ret = qemu_utimens(buffer, buf);
-    g_free(buffer);
+    dirfd = local_opendir_nofollow(s, dirpath);
+    if (dirfd == -1) {
+        goto out;
+    }
+
+    ret = utimensat(dirfd, name, buf, AT_SYMLINK_NOFOLLOW);
+    close_preserve_errno(dirfd);
+out:
+    g_free(dirpath);
+    g_free(name);
     return ret;
 }
 
-- 
2.7.4

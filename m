Received: from eggs.gnu.org ([2001:4830:134:3::10]:40344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6QW-0001Qu-DL
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6QS-0004h4-3A
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39730
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6QR-0004fl-SP
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:20 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8WHT028678
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:19 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29amb5t731-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:19 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:18 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:07:40 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-17-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 16/81] 9pfs: local: readlink: don't follow
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

The local_readlink() callback is vulnerable to symlink attacks because it
calls:

(1) open(O_NOFOLLOW) which follows symbolic links for all path elements but
    the rightmost one
(2) readlink() which follows symbolic links for all path elements but the
    rightmost one

This patch converts local_readlink() to rely on open_nofollow() to fix (1)
and opendir_nofollow(), readlinkat() to fix (2).

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit bec1e9546e03b9e7f5152cf3e8c95cf8acff5e12)
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-local.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 5e206e1..c290b6c 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -340,27 +340,35 @@ static ssize_t local_readlink(FsContext *fs_ctx, V9fsPath *fs_path,
                               char *buf, size_t bufsz)
 {
     ssize_t tsize = -1;
-    char *buffer;
-    char *path = fs_path->data;
 
     if ((fs_ctx->export_flags & V9FS_SM_MAPPED) ||
         (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE)) {
         int fd;
-        buffer = rpath(fs_ctx, path);
-        fd = open(buffer, O_RDONLY | O_NOFOLLOW);
-        g_free(buffer);
+
+        fd = local_open_nofollow(fs_ctx, fs_path->data, O_RDONLY, 0);
         if (fd == -1) {
             return -1;
         }
         do {
             tsize = read(fd, (void *)buf, bufsz);
         } while (tsize == -1 && errno == EINTR);
-        close(fd);
+        close_preserve_errno(fd);
     } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
                (fs_ctx->export_flags & V9FS_SM_NONE)) {
-        buffer = rpath(fs_ctx, path);
-        tsize = readlink(buffer, buf, bufsz);
-        g_free(buffer);
+        char *dirpath = g_path_get_dirname(fs_path->data);
+        char *name = g_path_get_basename(fs_path->data);
+        int dirfd;
+
+        dirfd = local_opendir_nofollow(fs_ctx, dirpath);
+        if (dirfd == -1) {
+            goto out;
+        }
+
+        tsize = readlinkat(dirfd, name, buf, bufsz);
+        close_preserve_errno(dirfd);
+    out:
+        g_free(name);
+        g_free(dirpath);
     }
     return tsize;
 }
-- 
2.7.4

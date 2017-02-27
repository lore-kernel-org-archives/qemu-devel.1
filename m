Received: from eggs.gnu.org ([2001:4830:134:3::10]:46952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHo-0000bb-7W
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHl-00040G-1j
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45015
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ciUHk-0003zZ-SE
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:52 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RMrZA3089015
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:52 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28vsx7g4k6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:51 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 27 Feb 2017 23:00:50 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 28 Feb 2017 00:00:09 +0100
In-Reply-To: <1488236421-30983-1-git-send-email-groug@kaod.org>
References: <1488236421-30983-1-git-send-email-groug@kaod.org>
Message-Id: <1488236421-30983-20-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 19/31] 9pfs: local: readlink: don't follow
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
---
 hw/9pfs/9p-local.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index c6c114839287..add1b2e83dbe 100644
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

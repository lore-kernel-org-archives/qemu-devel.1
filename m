Received: from eggs.gnu.org ([2001:4830:134:3::10]:45975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAol-0006sD-Hi
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAoi-0000LM-Du
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35069
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAoi-0000LH-7c
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:16 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC8eIK008952
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:12:15 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28a3d3d6x0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:12:15 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:12:14 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:12:08 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577832823.10533.9238654008311268368.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 20/36] 9pfs: local: readlink: don't follow
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

This fixes CVE-2016-9602 for all security models.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index a1fff04c3219..1f9239de07e5 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -346,31 +346,48 @@ err:
     return -1;
 }
 
+static int readlink_nofollow(FsContext *fs_ctx, const char *path, char *buf,
+                             size_t bufsz)
+{
+    char *dirpath = local_dirname(path);
+    char *name = local_basename(path);
+    int dirfd, ret = -1;
+
+    dirfd = local_opendir_nofollow(fs_ctx, dirpath);
+    if (dirfd == -1) {
+        goto out;
+    }
+
+    ret = readlinkat(dirfd, name, buf, bufsz);
+    close_preserve_errno(dirfd);
+out:
+    g_free(name);
+    g_free(dirpath);
+    return ret;
+}
+
 static ssize_t local_readlink(FsContext *fs_ctx, V9fsPath *fs_path,
                               char *buf, size_t bufsz)
 {
-    ssize_t tsize = -1;
-    char *buffer;
-    char *path = fs_path->data;
+    ssize_t tsize;
 
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
+        tsize = readlink_nofollow(fs_ctx, fs_path->data, buf, bufsz);
+    } else {
+        g_assert_not_reached();
     }
     return tsize;
 }

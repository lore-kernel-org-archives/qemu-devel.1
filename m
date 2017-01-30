Received: from eggs.gnu.org ([2001:4830:134:3::10]:45963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAod-0006kS-EG
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAoZ-0000K8-FK
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55492
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAoZ-0000Jz-9f
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:12:07 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC9HpQ062187
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:12:06 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28a32f60es-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:12:06 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 07:12:06 -0500
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:12:01 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577832099.10533.4868622896741220970.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 19/36] 9pfs: local: utimensat: don't follow
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
 hw/9pfs/9p-local.c |   37 ++++++++++++++++++++++++++++++-------
 hw/9pfs/9p-local.h |    2 ++
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 783b4006ffd4..a1fff04c3219 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -61,6 +61,22 @@ int local_opendir_nofollow(FsContext *fs_ctx, const char *path)
     return local_open_nofollow(fs_ctx, path, O_DIRECTORY | O_RDONLY, 0);
 }
 
+char *local_dirname(const char *path)
+{
+    char *tmp_path = g_strdup(path);
+    char *result = g_strdup(dirname(tmp_path));
+    g_free(tmp_path);
+    return result;
+}
+
+char *local_basename(const char *path)
+{
+    char *tmp_path = g_strdup(path);
+    char *result = g_strdup(basename(tmp_path));
+    g_free(tmp_path);
+    return result;
+}
+
 #define VIRTFS_META_DIR ".virtfs_metadata"
 
 static char *local_mapped_attr_path(FsContext *ctx, const char *path)
@@ -1313,16 +1329,23 @@ static int local_chown(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
     g_assert_not_reached();
 }
 
-static int local_utimensat(FsContext *s, V9fsPath *fs_path,
+static int local_utimensat(FsContext *fs_ctx, V9fsPath *fs_path,
                            const struct timespec *buf)
 {
-    char *buffer;
-    int ret;
-    char *path = fs_path->data;
+    char *dirpath = local_dirname(fs_path->data);
+    char *name = local_basename(fs_path->data);
+    int dirfd, ret = -1;
 
-    buffer = rpath(s, path);
-    ret = qemu_utimens(buffer, buf);
-    g_free(buffer);
+    dirfd = local_opendir_nofollow(fs_ctx, dirpath);
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
 
diff --git a/hw/9pfs/9p-local.h b/hw/9pfs/9p-local.h
index 32c72749d9df..2732da2b5d55 100644
--- a/hw/9pfs/9p-local.h
+++ b/hw/9pfs/9p-local.h
@@ -16,5 +16,7 @@
 int local_open_nofollow(FsContext *fs_ctx, const char *path, int flags,
                         mode_t mode);
 int local_opendir_nofollow(FsContext *fs_ctx, const char *path);
+char *local_dirname(const char *path);
+char *local_basename(const char *path);
 
 #endif

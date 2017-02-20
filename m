Received: from eggs.gnu.org ([2001:4830:134:3::10]:54468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfpA1-0007bx-DX
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:41:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfp9y-0003tc-7F
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:41:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59224
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cfp9y-0003tV-0d
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:41:50 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEf1WV143595
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:41:49 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28r16cbe6r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:41:49 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 20 Feb 2017 07:41:48 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 20 Feb 2017 15:41:41 +0100
In-Reply-To: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148760170128.31154.5884656729259031522.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 18/29] 9pfs: local: lstat: don't follow symlinks
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

The local_lstat() callback is vulnerable to symlink attacks because it
calls:

(1) lstat() which follows symbolic links in all path elements but the
    rightmost one
(2) getxattr() which follows symbolic links in all path elements
(3) local_mapped_file_attr()->local_fopen()->openat(O_NOFOLLOW) which
    follows symbolic links in all path elements but the rightmost
    one

This patch converts local_lstat() to rely on opendir_nofollow() and
fstatat(AT_SYMLINK_NOFOLLOW) to fix (1), fgetxattrat_nofollow() to
fix (2).

A new local_fopenat() helper is introduced as a replacement to
local_fopen() to fix (3). No effort is made to factor out code
because local_fopen() will be dropped when all users have been
converted to call local_fopenat().

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   78 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 61 insertions(+), 17 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index dbd5549283aa..b7bf1a11feb3 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -105,17 +105,49 @@ static FILE *local_fopen(const char *path, const char *mode)
     return fp;
 }
 
+static FILE *local_fopenat(int dirfd, const char *name, const char *mode)
+{
+    int fd, o_mode = 0;
+    FILE *fp;
+    int flags = O_NOFOLLOW;
+    /*
+     * only supports two modes
+     */
+    if (mode[0] == 'r') {
+        flags |= O_RDONLY;
+    } else if (mode[0] == 'w') {
+        flags |= O_WRONLY | O_TRUNC | O_CREAT;
+        o_mode = S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
+    } else {
+        return NULL;
+    }
+    fd = openat(dirfd, name, flags, o_mode);
+    if (fd == -1) {
+        return NULL;
+    }
+    fp = fdopen(fd, mode);
+    if (!fp) {
+        close(fd);
+    }
+    return fp;
+}
+
 #define ATTR_MAX 100
-static void local_mapped_file_attr(FsContext *ctx, const char *path,
+static void local_mapped_file_attr(int dirfd, const char *name,
                                    struct stat *stbuf)
 {
     FILE *fp;
     char buf[ATTR_MAX];
-    char *attr_path;
+    int map_dirfd;
 
-    attr_path = local_mapped_attr_path(ctx, path);
-    fp = local_fopen(attr_path, "r");
-    g_free(attr_path);
+    map_dirfd = openat(dirfd, VIRTFS_META_DIR,
+                       O_RDONLY | O_DIRECTORY | O_NOFOLLOW);
+    if (map_dirfd == -1) {
+        return;
+    }
+
+    fp = local_fopenat(map_dirfd, name, "r");
+    close_preserve_errno(map_dirfd);
     if (!fp) {
         return;
     }
@@ -137,12 +169,17 @@ static void local_mapped_file_attr(FsContext *ctx, const char *path,
 
 static int local_lstat(FsContext *fs_ctx, V9fsPath *fs_path, struct stat *stbuf)
 {
-    int err;
-    char *buffer;
-    char *path = fs_path->data;
+    int err = -1;
+    char *dirpath = g_path_get_dirname(fs_path->data);
+    char *name = g_path_get_basename(fs_path->data);
+    int dirfd;
 
-    buffer = rpath(fs_ctx, path);
-    err =  lstat(buffer, stbuf);
+    dirfd = local_opendir_nofollow(fs_ctx, dirpath);
+    if (dirfd == -1) {
+        goto out;
+    }
+
+    err = fstatat(dirfd, name, stbuf, AT_SYMLINK_NOFOLLOW);
     if (err) {
         goto err_out;
     }
@@ -152,25 +189,32 @@ static int local_lstat(FsContext *fs_ctx, V9fsPath *fs_path, struct stat *stbuf)
         gid_t tmp_gid;
         mode_t tmp_mode;
         dev_t tmp_dev;
-        if (getxattr(buffer, "user.virtfs.uid", &tmp_uid, sizeof(uid_t)) > 0) {
+
+        if (fgetxattrat_nofollow(dirfd, name, "user.virtfs.uid", &tmp_uid,
+                                 sizeof(uid_t)) > 0) {
             stbuf->st_uid = le32_to_cpu(tmp_uid);
         }
-        if (getxattr(buffer, "user.virtfs.gid", &tmp_gid, sizeof(gid_t)) > 0) {
+        if (fgetxattrat_nofollow(dirfd, name, "user.virtfs.gid", &tmp_gid,
+                                 sizeof(gid_t)) > 0) {
             stbuf->st_gid = le32_to_cpu(tmp_gid);
         }
-        if (getxattr(buffer, "user.virtfs.mode",
-                    &tmp_mode, sizeof(mode_t)) > 0) {
+        if (fgetxattrat_nofollow(dirfd, name, "user.virtfs.mode", &tmp_mode,
+                                 sizeof(mode_t)) > 0) {
             stbuf->st_mode = le32_to_cpu(tmp_mode);
         }
-        if (getxattr(buffer, "user.virtfs.rdev", &tmp_dev, sizeof(dev_t)) > 0) {
+        if (fgetxattrat_nofollow(dirfd, name, "user.virtfs.rdev", &tmp_dev,
+                                 sizeof(dev_t)) > 0) {
             stbuf->st_rdev = le64_to_cpu(tmp_dev);
         }
     } else if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        local_mapped_file_attr(fs_ctx, path, stbuf);
+        local_mapped_file_attr(dirfd, name, stbuf);
     }
 
 err_out:
-    g_free(buffer);
+    close_preserve_errno(dirfd);
+out:
+    g_free(name);
+    g_free(dirpath);
     return err;
 }
 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:34420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAVyY-0006cU-Ti
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAVyV-00006U-JH
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:28:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40654
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dAVyV-00006Q-Dp
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:28:51 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4G6NfBK121202
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 02:28:50 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2afe8h3mw7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 02:28:50 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 16 May 2017 07:28:48 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue, 16 May 2017 08:28:23 +0200
In-Reply-To: <1494916103-32207-1-git-send-email-groug@kaod.org>
References: <1494916103-32207-1-git-send-email-groug@kaod.org>
Message-Id: <1494916103-32207-2-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL] 9pfs: local: forbid client access to metadata
 (CVE-2017-7493)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

When using the mapped-file security mode, we shouldn't let the client mess
with the metadata. The current code already tries to hide the metadata dir
from the client by skipping it in local_readdir(). But the client can still
access or modify it through several other operations. This can be used to
escalate privileges in the guest.

Affected backend operations are:
- local_mknod()
- local_mkdir()
- local_open2()
- local_symlink()
- local_link()
- local_unlinkat()
- local_renameat()
- local_rename()
- local_name_to_path()

Other operations are safe because they are only passed a fid path, which
is computed internally in local_name_to_path().

This patch converts all the functions listed above to fail and return
EINVAL when being passed the name of the metadata dir. This may look
like a poor choice for errno, but there's no such thing as an illegal
path name on Linux and I could not think of anything better.

This fixes CVE-2017-7493.

Reported-by: Leo Gaspard <leo@gaspard.io>
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hw/9pfs/9p-local.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index f3ebca4f7a56..a2486566afb7 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -452,6 +452,11 @@ static off_t local_telldir(FsContext *ctx, V9fsFidOpenState *fs)
     return telldir(fs->dir.stream);
 }
 
+static bool local_is_mapped_file_metadata(FsContext *fs_ctx, const char *name)
+{
+    return !strcmp(name, VIRTFS_META_DIR);
+}
+
 static struct dirent *local_readdir(FsContext *ctx, V9fsFidOpenState *fs)
 {
     struct dirent *entry;
@@ -465,8 +470,8 @@ again:
     if (ctx->export_flags & V9FS_SM_MAPPED) {
         entry->d_type = DT_UNKNOWN;
     } else if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        if (!strcmp(entry->d_name, VIRTFS_META_DIR)) {
-            /* skp the meta data directory */
+        if (local_is_mapped_file_metadata(ctx, entry->d_name)) {
+            /* skip the meta data directory */
             goto again;
         }
         entry->d_type = DT_UNKNOWN;
@@ -559,6 +564,12 @@ static int local_mknod(FsContext *fs_ctx, V9fsPath *dir_path,
     int err = -1;
     int dirfd;
 
+    if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE &&
+        local_is_mapped_file_metadata(fs_ctx, name)) {
+        errno = EINVAL;
+        return -1;
+    }
+
     dirfd = local_opendir_nofollow(fs_ctx, dir_path->data);
     if (dirfd == -1) {
         return -1;
@@ -605,6 +616,12 @@ static int local_mkdir(FsContext *fs_ctx, V9fsPath *dir_path,
     int err = -1;
     int dirfd;
 
+    if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE &&
+        local_is_mapped_file_metadata(fs_ctx, name)) {
+        errno = EINVAL;
+        return -1;
+    }
+
     dirfd = local_opendir_nofollow(fs_ctx, dir_path->data);
     if (dirfd == -1) {
         return -1;
@@ -694,6 +711,12 @@ static int local_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
     int err = -1;
     int dirfd;
 
+    if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE &&
+        local_is_mapped_file_metadata(fs_ctx, name)) {
+        errno = EINVAL;
+        return -1;
+    }
+
     /*
      * Mark all the open to not follow symlinks
      */
@@ -752,6 +775,12 @@ static int local_symlink(FsContext *fs_ctx, const char *oldpath,
     int err = -1;
     int dirfd;
 
+    if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE &&
+        local_is_mapped_file_metadata(fs_ctx, name)) {
+        errno = EINVAL;
+        return -1;
+    }
+
     dirfd = local_opendir_nofollow(fs_ctx, dir_path->data);
     if (dirfd == -1) {
         return -1;
@@ -826,6 +855,12 @@ static int local_link(FsContext *ctx, V9fsPath *oldpath,
     int ret = -1;
     int odirfd, ndirfd;
 
+    if (ctx->export_flags & V9FS_SM_MAPPED_FILE &&
+        local_is_mapped_file_metadata(ctx, name)) {
+        errno = EINVAL;
+        return -1;
+    }
+
     odirfd = local_opendir_nofollow(ctx, odirpath);
     if (odirfd == -1) {
         goto out;
@@ -1096,6 +1131,12 @@ static int local_lremovexattr(FsContext *ctx, V9fsPath *fs_path,
 static int local_name_to_path(FsContext *ctx, V9fsPath *dir_path,
                               const char *name, V9fsPath *target)
 {
+    if (ctx->export_flags & V9FS_SM_MAPPED_FILE &&
+        local_is_mapped_file_metadata(ctx, name)) {
+        errno = EINVAL;
+        return -1;
+    }
+
     if (dir_path) {
         v9fs_path_sprintf(target, "%s/%s", dir_path->data, name);
     } else if (strcmp(name, "/")) {
@@ -1116,6 +1157,13 @@ static int local_renameat(FsContext *ctx, V9fsPath *olddir,
     int ret;
     int odirfd, ndirfd;
 
+    if (ctx->export_flags & V9FS_SM_MAPPED_FILE &&
+        (local_is_mapped_file_metadata(ctx, old_name) ||
+         local_is_mapped_file_metadata(ctx, new_name))) {
+        errno = EINVAL;
+        return -1;
+    }
+
     odirfd = local_opendir_nofollow(ctx, olddir->data);
     if (odirfd == -1) {
         return -1;
@@ -1206,6 +1254,12 @@ static int local_unlinkat(FsContext *ctx, V9fsPath *dir,
     int ret;
     int dirfd;
 
+    if (ctx->export_flags & V9FS_SM_MAPPED_FILE &&
+        local_is_mapped_file_metadata(ctx, name)) {
+        errno = EINVAL;
+        return -1;
+    }
+
     dirfd = local_opendir_nofollow(ctx, dir->data);
     if (dirfd == -1) {
         return -1;
-- 
2.7.4

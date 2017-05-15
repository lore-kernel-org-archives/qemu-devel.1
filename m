Received: from eggs.gnu.org ([2001:4830:134:3::10]:54339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAIWq-0003Ye-9i
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAIWn-0000j2-2A
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:07:24 -0400
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:37335)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dAIWm-0000ip-Mr
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:07:20 -0400
Received: from player699.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 48AD01FC2D
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 18:07:18 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 15 May 2017 18:07:12 +0200
Message-ID: <149486383099.19357.10170962018755572073.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] 9pfs: local: forbid client access to metadata
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
Cc: Leo Gaspard <leo@gaspard.io>, Prasad J Pandit <prasad@redhat.com>, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>

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
---
 hw/9pfs/9p-local.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

I had already sent a similar fix as part of a bigger patchset 10 days ago,
but it turned out that a CVE got created since then for this specific issue.
I hence repost a standalone patch with some minor changes and an updated
changelog.

Eric,

I'd appreciate if you could review this, so that I can send a pull request
ASAP.

Thanks.

--
Greg

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

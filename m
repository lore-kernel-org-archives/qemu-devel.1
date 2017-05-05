Received: from eggs.gnu.org ([2001:4830:134:3::10]:33917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d6f2a-0001mz-Ul
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d6f2X-0001dZ-Mm
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:21:08 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:37126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d6f2X-0001d2-G9
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:21:05 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id CA6CFDE7DB
	for <qemu-devel@nongnu.org>; Fri,  5 May 2017 17:21:03 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 05 May 2017 16:37:38 +0200
Message-ID: <149399505841.29022.17760460736155165332.stgit@bahia.lan>
In-Reply-To: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 5/5] 9pfs: local: forbid client access to
 metadata
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?L=C3=A9o?= Gaspard <leo@gaspard.io>, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>

When using the mapped-file security mode, we shouldn't let the client
mess with the metadata. The current code already hides it but the
client can still access the metadata through several operations.

This patch fixes the issue by:
- preventing the creation of fids pointing to the metadata (name_to_path)
- failing various operations taking a dirpath and a name arguments if
  name is a metadata reserved name

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index b427d2928800..93cadac302c9 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -588,6 +588,11 @@ static int local_mknod(FsContext *fs_ctx, V9fsPath *dir_path,
     int err = -1;
     int dirfd;
 
+    if (local_must_skip_metadata(fs_ctx, name)) {
+        errno = EINVAL;
+        return -1;
+    }
+
     dirfd = local_opendir_nofollow(fs_ctx, dir_path->data);
     if (dirfd == -1) {
         return -1;
@@ -634,6 +639,11 @@ static int local_mkdir(FsContext *fs_ctx, V9fsPath *dir_path,
     int err = -1;
     int dirfd;
 
+    if (local_must_skip_metadata(fs_ctx, name)) {
+        errno = EINVAL;
+        return -1;
+    }
+
     dirfd = local_opendir_nofollow(fs_ctx, dir_path->data);
     if (dirfd == -1) {
         return -1;
@@ -723,6 +733,11 @@ static int local_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
     int err = -1;
     int dirfd;
 
+    if (local_must_skip_metadata(fs_ctx, name)) {
+        errno = EINVAL;
+        return -1;
+    }
+
     /*
      * Mark all the open to not follow symlinks
      */
@@ -781,6 +796,11 @@ static int local_symlink(FsContext *fs_ctx, const char *oldpath,
     int err = -1;
     int dirfd;
 
+    if (local_must_skip_metadata(fs_ctx, name)) {
+        errno = EINVAL;
+        return -1;
+    }
+
     dirfd = local_opendir_nofollow(fs_ctx, dir_path->data);
     if (dirfd == -1) {
         return -1;
@@ -855,6 +875,11 @@ static int local_link(FsContext *ctx, V9fsPath *oldpath,
     int ret = -1;
     int odirfd, ndirfd;
 
+    if (local_must_skip_metadata(ctx, name)) {
+        errno = EINVAL;
+        return -1;
+    }
+
     odirfd = local_opendir_nofollow(ctx, odirpath);
     if (odirfd == -1) {
         goto out;
@@ -983,6 +1008,11 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
 {
     int ret = -1;
 
+    if (local_must_skip_metadata(ctx, name)) {
+        errno = EINVAL;
+        return -1;
+    }
+
     if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
         int map_dirfd;
 
@@ -1125,6 +1155,11 @@ static int local_lremovexattr(FsContext *ctx, V9fsPath *fs_path,
 static int local_name_to_path(FsContext *ctx, V9fsPath *dir_path,
                               const char *name, V9fsPath *target)
 {
+    if (local_must_skip_metadata(ctx, name)) {
+        errno = EINVAL;
+        return -1;
+    }
+
     if (dir_path) {
         if (!strcmp(name, ".")) {
             /* "." relative to "foo/bar" is "foo/bar" */
@@ -1161,6 +1196,12 @@ static int local_renameat(FsContext *ctx, V9fsPath *olddir,
     int ret;
     int odirfd, ndirfd;
 
+    if (local_must_skip_metadata(ctx, old_name) ||
+        local_must_skip_metadata(ctx, new_name)) {
+        errno = EINVAL;
+        return -1;
+    }
+
     odirfd = local_opendir_nofollow(ctx, olddir->data);
     if (odirfd == -1) {
         return -1;

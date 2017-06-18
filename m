Received: from eggs.gnu.org ([2001:4830:134:3::10]:47830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tobleminer@gmail.com>) id 1dMVaq-0005dj-Tr
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 04:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tobleminer@gmail.com>) id 1dMVap-000591-QZ
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 04:30:00 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tobleminer@gmail.com>)
	id 1dMVap-000581-Gd
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 04:29:59 -0400
Received: by mail-wm0-x242.google.com with SMTP id d64so11817573wmf.2
	for <qemu-devel@nongnu.org>; Sun, 18 Jun 2017 01:29:59 -0700 (PDT)
From: Tobias Schramm <tobleminer@gmail.com>
Date: Sun, 18 Jun 2017 10:28:13 +0200
Message-Id: <20170618082813.8091-2-tobleminer@gmail.com>
In-Reply-To: <20170618082813.8091-1-tobleminer@gmail.com>
References: <20170618082813.8091-1-tobleminer@gmail.com>
Subject: [Qemu-devel] [PATCH 1/1] Add support for custom fmasks/dmasks in
 9ps mapped mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tobias Schramm <tobleminer@gmail.com>

Signed-off-by: Tobias Schramm <tobleminer@gmail.com>
---
 fsdev/file-op-9p.h      |  4 ++++
 fsdev/qemu-fsdev-opts.c | 12 ++++++++++++
 hw/9pfs/9p-local.c      | 33 +++++++++++++++++++++++++++++----
 hw/9pfs/9p.c            |  3 +++
 4 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index 0844a403dc..0ecb1d392b 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -76,6 +76,8 @@ typedef struct FsDriverEntry {
     int export_flags;
     FileOperations *ops;
     FsThrottle fst;
+    mode_t fmask;
+    mode_t dmask;
 } FsDriverEntry;
 
 typedef struct FsContext
@@ -88,6 +90,8 @@ typedef struct FsContext
     FsThrottle *fst;
     /* fs driver specific data */
     void *private;
+    mode_t fmask;
+    mode_t dmask;
 } FsContext;
 
 typedef struct V9fsPath {
diff --git a/fsdev/qemu-fsdev-opts.c b/fsdev/qemu-fsdev-opts.c
index bf5713008a..dd6391edb0 100644
--- a/fsdev/qemu-fsdev-opts.c
+++ b/fsdev/qemu-fsdev-opts.c
@@ -38,6 +38,12 @@ static QemuOptsList qemu_fsdev_opts = {
         }, {
             .name = "sock_fd",
             .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "fmask",
+            .type = QEMU_OPT_STRING,
+        }, {
+            .name = "dmask",
+            .type = QEMU_OPT_STRING,
         },
 
         THROTTLE_OPTS,
@@ -75,6 +81,12 @@ static QemuOptsList qemu_virtfs_opts = {
         }, {
             .name = "sock_fd",
             .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "fmask",
+            .type = QEMU_OPT_STRING,
+        }, {
+            .name = "dmask",
+            .type = QEMU_OPT_STRING,
         },
 
         { /*End of list */ }
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 1e78b7c9e9..5c312298e8 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -633,7 +633,7 @@ static int local_mknod(FsContext *fs_ctx, V9fsPath *dir_path,
 
     if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
         fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        err = mknodat(dirfd, name, SM_LOCAL_MODE_BITS | S_IFREG, 0);
+        err = mknodat(dirfd, name, fs_ctx->fmask | S_IFREG, 0);
         if (err == -1) {
             goto out;
         }
@@ -685,7 +685,7 @@ static int local_mkdir(FsContext *fs_ctx, V9fsPath *dir_path,
 
     if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
         fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        err = mkdirat(dirfd, name, SM_LOCAL_DIR_MODE_BITS);
+        err = mkdirat(dirfd, name, fs_ctx->dmask);
         if (err == -1) {
             goto out;
         }
@@ -786,7 +786,7 @@ static int local_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
     /* Determine the security model */
     if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
         fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        fd = openat_file(dirfd, name, flags, SM_LOCAL_MODE_BITS);
+        fd = openat_file(dirfd, name, flags, fs_ctx->fmask);
         if (fd == -1) {
             goto out;
         }
@@ -849,7 +849,7 @@ static int local_symlink(FsContext *fs_ctx, const char *oldpath,
         ssize_t oldpath_size, write_size;
 
         fd = openat_file(dirfd, name, O_CREAT | O_EXCL | O_RDWR,
-                         SM_LOCAL_MODE_BITS);
+                         fs_ctx->fmask);
         if (fd == -1) {
             goto out;
         }
@@ -1431,6 +1431,9 @@ static int local_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
 {
     const char *sec_model = qemu_opt_get(opts, "security_model");
     const char *path = qemu_opt_get(opts, "path");
+    const char *fmask = qemu_opt_get(opts, "fmask");
+    const char *dmask = qemu_opt_get(opts, "dmask");
+    long mask;
     Error *err = NULL;
 
     if (!sec_model) {
@@ -1469,6 +1472,28 @@ static int local_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
 
     fse->path = g_strdup(path);
 
+    fse->fmask = SM_LOCAL_MODE_BITS;
+    if (fmask) {
+        mask = strtol(fmask, NULL, 0);
+        if((!mask || mask == LONG_MIN || mask == LONG_MAX) && errno)
+        {
+            error_report("Invalid fmask %s specified", fmask);
+            return -1;
+	}
+        fse->fmask = ((mode_t)mask) & 0777;
+    }
+
+    fse->dmask = SM_LOCAL_DIR_MODE_BITS;
+    if (dmask) {
+        mask = strtol(dmask, NULL, 0);
+        if((!mask || mask == LONG_MIN || mask == LONG_MAX) && errno)
+        {
+            error_report("Invalid dmask %s specified", dmask);
+            return -1;
+	}
+        fse->dmask = ((mode_t)mask) & 0777;
+    }
+
     return 0;
 }
 
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 96d2683348..40290dbade 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3533,6 +3533,9 @@ int v9fs_device_realize_common(V9fsState *s, Error **errp)
 
     s->ops = fse->ops;
 
+    s->ctx.fmask = fse->fmask;
+    s->ctx.dmask = fse->dmask;
+
     s->fid_list = NULL;
     qemu_co_rwlock_init(&s->rename_lock);
 
-- 
2.13.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fUM0b-0005nZ-Kt
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fUM0W-0003Hk-VT
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:33 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:32952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fUM0W-0003Hf-Qd
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:28 -0400
Received: by mail-qk0-x241.google.com with SMTP id c131-v6so7676449qkb.0
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 17:57:28 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Sat, 16 Jun 2018 20:56:55 -0400
Message-Id: <6843f92c494c66ccc0db503f9aa56b28eddb61fc.1529196703.git.keno@juliacomputing.com>
In-Reply-To: <cover.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
In-Reply-To: <cover.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v3 11/13] 9p: darwin: Implement compatibility
 for mknodat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@juliacomputing.com>, groug@kaod.org

Darwin does not support mknodat. However, to avoid race conditions
with later setting the permissions, we must avoid using mknod on
the full path instead. We could try to fchdir, but that would cause
problems if multiple threads try to call mknodat at the same time.
However, luckily there is a solution: Darwin as an (unexposed in the
C library) system call that sets the cwd for the current thread only.
This should suffice to use mknod safely.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---

Changes since v2:
 - Silence clang warning for deprecated uses of `syscall`. It is
  unforunate that we have to use this depreacted interface, but
  there does not seem to be a better option.

 hw/9pfs/9p-local.c       |  5 +++--
 hw/9pfs/9p-util-darwin.c | 31 +++++++++++++++++++++++++++++++
 hw/9pfs/9p-util-linux.c  |  5 +++++
 hw/9pfs/9p-util.h        |  2 ++
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 56bcabf..450f31c 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -668,7 +668,7 @@ static int local_mknod(FsContext *fs_ctx, V9fsPath *dir_path,
 
     if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
         fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        err = mknodat(dirfd, name, fs_ctx->fmode | S_IFREG, 0);
+        err = qemu_mknodat(dirfd, name, fs_ctx->fmode | S_IFREG, 0);
         if (err == -1) {
             goto out;
         }
@@ -683,7 +683,7 @@ static int local_mknod(FsContext *fs_ctx, V9fsPath *dir_path,
         }
     } else if (fs_ctx->export_flags & V9FS_SM_PASSTHROUGH ||
                fs_ctx->export_flags & V9FS_SM_NONE) {
-        err = mknodat(dirfd, name, credp->fc_mode, credp->fc_rdev);
+        err = qemu_mknodat(dirfd, name, credp->fc_mode, credp->fc_rdev);
         if (err == -1) {
             goto out;
         }
@@ -696,6 +696,7 @@ static int local_mknod(FsContext *fs_ctx, V9fsPath *dir_path,
 
 err_end:
     unlinkat_preserve_errno(dirfd, name, 0);
+
 out:
     close_preserve_errno(dirfd);
     return err;
diff --git a/hw/9pfs/9p-util-darwin.c b/hw/9pfs/9p-util-darwin.c
index ac414bc..194f068 100644
--- a/hw/9pfs/9p-util-darwin.c
+++ b/hw/9pfs/9p-util-darwin.c
@@ -158,3 +158,34 @@ done:
     close_preserve_errno(fd);
     return ret;
 }
+
+#ifndef SYS___pthread_fchdir
+# define SYS___pthread_fchdir 349
+#endif
+
+// This is an undocumented OS X syscall. It would be best to avoid it,
+// but there doesn't seem to be another safe way to implement mknodat.
+// Dear Apple, please implement mknodat before you remove this syscall.
+static int fchdir_thread_local(int fd)
+{
+#pragma clang diagnostic push
+#pragma clang diagnostic ignored "-Wdeprecated-declarations"
+    return syscall(SYS___pthread_fchdir, fd);
+#pragma clang diagnostic pop
+}
+
+int qemu_mknodat(int dirfd, const char *filename, mode_t mode, dev_t dev)
+{
+    int preserved_errno, err;
+    if (fchdir_thread_local(dirfd) < 0) {
+        return -1;
+    }
+    err = mknod(filename, mode, dev);
+    preserved_errno = errno;
+    /* Stop using the thread-local cwd */
+    fchdir_thread_local(-1);
+    if (err < 0) {
+        errno = preserved_errno;
+    }
+    return err;
+}
diff --git a/hw/9pfs/9p-util-linux.c b/hw/9pfs/9p-util-linux.c
index 3902378..06399c5 100644
--- a/hw/9pfs/9p-util-linux.c
+++ b/hw/9pfs/9p-util-linux.c
@@ -63,3 +63,8 @@ int utimensat_nofollow(int dirfd, const char *filename,
 {
     return utimensat(dirfd, filename, times, AT_SYMLINK_NOFOLLOW);
 }
+
+int qemu_mknodat(int dirfd, const char *filename, mode_t mode, dev_t dev)
+{
+    return mknodat(dirfd, filename, mode, dev);
+}
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index b1dc08a..127564d 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -90,4 +90,6 @@ ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
 int utimensat_nofollow(int dirfd, const char *filename,
                        const struct timespec times[2]);
 
+int qemu_mknodat(int dirfd, const char *filename, mode_t mode, dev_t dev);
+
 #endif
-- 
2.8.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgS-0006Db-Sg
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgR-0004UG-EL
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:04 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:40301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fMRgR-0004U2-9E
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:03 -0400
Received: by mail-qt0-x242.google.com with SMTP id h2-v6so9175894qtp.7
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:24:03 -0700 (PDT)
From: keno@juliacomputing.com
Date: Sat, 26 May 2018 01:23:05 -0400
Message-Id: <033ba6f2e3f0daccb31e1930a1c65cf7a18ae66c.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
Subject: [Qemu-devel] [PATCH 03/13] 9p: Move a couple xattr functions to
 9p-util
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@alumni.harvard.edu>, groug@kaod.org, Keno Fischer <keno@juliacomputing.com>

From: Keno Fischer <keno@alumni.harvard.edu>

These functions will need custom implementations on Darwin. Since the
implementation is very similar among all of them, and 9p-util already
has the _nofollow version of fgetxattrat, let's move them all there.

Additionally, introduce a _follow version of fgetxattr and use it.
On darwin, fgetxattr has a more general interface, so we'll need to factor
it out anyway.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 hw/9pfs/9p-local.c | 11 +++++++----
 hw/9pfs/9p-util.c  | 39 +++++++++++++++++++++++++++++++++++++++
 hw/9pfs/9p-util.h  |  6 ++++++
 hw/9pfs/9p-xattr.c | 33 ---------------------------------
 4 files changed, 52 insertions(+), 37 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 7592f8d..fd65d04 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -776,16 +776,19 @@ static int local_fstat(FsContext *fs_ctx, int fid_type,
         mode_t tmp_mode;
         dev_t tmp_dev;
 
-        if (fgetxattr(fd, "user.virtfs.uid", &tmp_uid, sizeof(uid_t)) > 0) {
+        if (fgetxattr_follow(fd, "user.virtfs.uid", &tmp_uid, sizeof(uid_t)) > 0) {
             stbuf->st_uid = le32_to_cpu(tmp_uid);
         }
-        if (fgetxattr(fd, "user.virtfs.gid", &tmp_gid, sizeof(gid_t)) > 0) {
+        if (fgetxattr_follow(fd, "user.virtfs.gid", &tmp_gid, sizeof(gid_t)) > 0)
+        {
             stbuf->st_gid = le32_to_cpu(tmp_gid);
         }
-        if (fgetxattr(fd, "user.virtfs.mode", &tmp_mode, sizeof(mode_t)) > 0) {
+        if (fgetxattr_follow(fd, "user.virtfs.mode", &tmp_mode, sizeof(mode_t)) > 0)
+        {
             stbuf->st_mode = le32_to_cpu(tmp_mode);
         }
-        if (fgetxattr(fd, "user.virtfs.rdev", &tmp_dev, sizeof(dev_t)) > 0) {
+        if (fgetxattr_follow(fd, "user.virtfs.rdev", &tmp_dev, sizeof(dev_t)) > 0)
+        {
             stbuf->st_rdev = le64_to_cpu(tmp_dev);
         }
     } else if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
diff --git a/hw/9pfs/9p-util.c b/hw/9pfs/9p-util.c
index f709c27..8cf5554 100644
--- a/hw/9pfs/9p-util.c
+++ b/hw/9pfs/9p-util.c
@@ -24,3 +24,42 @@ ssize_t fgetxattrat_nofollow(int dirfd, const char *filename, const char *name,
     g_free(proc_path);
     return ret;
 }
+
+ssize_t fgetxattr_follow(int fd, const char *name,
+                         void *value, size_t size)
+{
+    return fgetxattr(fd, name, value, size);
+}
+
+ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
+                              char *list, size_t size)
+{
+    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
+    int ret;
+
+    ret = llistxattr(proc_path, list, size);
+    g_free(proc_path);
+    return ret;
+}
+
+ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
+                                const char *name)
+{
+    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
+    int ret;
+
+    ret = lremovexattr(proc_path, name);
+    g_free(proc_path);
+    return ret;
+}
+
+int fsetxattrat_nofollow(int dirfd, const char *filename, const char *name,
+                         void *value, size_t size, int flags)
+{
+    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
+    int ret;
+
+    ret = lsetxattr(proc_path, name, value, size, flags);
+    g_free(proc_path);
+    return ret;
+}
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index dc0d2e2..cb26343 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -58,7 +58,13 @@ static inline int openat_file(int dirfd, const char *name, int flags,
 
 ssize_t fgetxattrat_nofollow(int dirfd, const char *path, const char *name,
                              void *value, size_t size);
+ssize_t fgetxattr_follow(int fd, const char *name,
+                         void *value, size_t size);
 int fsetxattrat_nofollow(int dirfd, const char *path, const char *name,
                          void *value, size_t size, int flags);
+ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
+                              char *list, size_t size);
+ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
+                                const char *name);
 
 #endif
diff --git a/hw/9pfs/9p-xattr.c b/hw/9pfs/9p-xattr.c
index d05c1a1..c696d8f 100644
--- a/hw/9pfs/9p-xattr.c
+++ b/hw/9pfs/9p-xattr.c
@@ -60,17 +60,6 @@ ssize_t pt_listxattr(FsContext *ctx, const char *path,
     return name_size;
 }
 
-static ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
-                                     char *list, size_t size)
-{
-    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
-    int ret;
-
-    ret = llistxattr(proc_path, list, size);
-    g_free(proc_path);
-    return ret;
-}
-
 /*
  * Get the list and pass to each layer to find out whether
  * to send the data or not
@@ -196,17 +185,6 @@ ssize_t pt_getxattr(FsContext *ctx, const char *path, const char *name,
     return local_getxattr_nofollow(ctx, path, name, value, size);
 }
 
-int fsetxattrat_nofollow(int dirfd, const char *filename, const char *name,
-                         void *value, size_t size, int flags)
-{
-    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
-    int ret;
-
-    ret = lsetxattr(proc_path, name, value, size, flags);
-    g_free(proc_path);
-    return ret;
-}
-
 ssize_t local_setxattr_nofollow(FsContext *ctx, const char *path,
                                 const char *name, void *value, size_t size,
                                 int flags)
@@ -235,17 +213,6 @@ int pt_setxattr(FsContext *ctx, const char *path, const char *name, void *value,
     return local_setxattr_nofollow(ctx, path, name, value, size, flags);
 }
 
-static ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
-                                       const char *name)
-{
-    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
-    int ret;
-
-    ret = lremovexattr(proc_path, name);
-    g_free(proc_path);
-    return ret;
-}
-
 ssize_t local_removexattr_nofollow(FsContext *ctx, const char *path,
                                    const char *name)
 {
-- 
2.8.1

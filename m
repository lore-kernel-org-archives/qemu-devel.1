Received: from eggs.gnu.org ([2001:4830:134:3::10]:35799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgc-0006MG-DC
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgb-0004ar-Ec
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:14 -0400
Received: from mail-qk0-x232.google.com ([2607:f8b0:400d:c09::232]:45074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fMRgb-0004aD-AZ
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:13 -0400
Received: by mail-qk0-x232.google.com with SMTP id c198-v6so5676569qkg.12
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:24:13 -0700 (PDT)
From: keno@juliacomputing.com
Date: Sat, 26 May 2018 01:23:12 -0400
Message-Id: <981de427dbb657d58d08f216b40255b132cb1596.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
Subject: [Qemu-devel] [PATCH 10/13] 9p: darwin: *xattr_nofollow
 implementations
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

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 hw/9pfs/9p-util.c | 49 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/hw/9pfs/9p-util.c b/hw/9pfs/9p-util.c
index 8cf5554..98004ac 100644
--- a/hw/9pfs/9p-util.c
+++ b/hw/9pfs/9p-util.c
@@ -17,49 +17,90 @@
 ssize_t fgetxattrat_nofollow(int dirfd, const char *filename, const char *name,
                              void *value, size_t size)
 {
-    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
     int ret;
+#ifdef CONFIG_DARWIN
+    int fd = openat_file(dirfd, filename, O_RDONLY | O_PATH_9P_UTIL | O_NOFOLLOW, 0);
+    if (fd == -1)
+        return -1;
+
+    ret = fgetxattr(fd, name, value, size, 0, XATTR_NOFOLLOW);
+    close_preserve_errno(fd);
+#else
+    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
 
     ret = lgetxattr(proc_path, name, value, size);
     g_free(proc_path);
+#endif
     return ret;
 }
 
 ssize_t fgetxattr_follow(int fd, const char *name,
                          void *value, size_t size)
 {
+#ifdef CONFIG_DARWIN
+    return fgetxattr(fd, name, value, size, 0, 0);
+#else
     return fgetxattr(fd, name, value, size);
+#endif
 }
 
 ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
                               char *list, size_t size)
 {
-    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
     int ret;
+#ifdef CONFIG_DARWIN
+    int fd = openat_file(dirfd, filename, O_RDONLY | O_PATH_9P_UTIL | O_NOFOLLOW, 0);
+    if (fd == -1)
+        return -1;
+
+    ret = flistxattr(fd, list, size, XATTR_NOFOLLOW);
+    close_preserve_errno(fd);
+#else
+    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
 
     ret = llistxattr(proc_path, list, size);
     g_free(proc_path);
+#endif
     return ret;
 }
 
 ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
                                 const char *name)
 {
-    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
     int ret;
+#ifdef CONFIG_DARWIN
+    int fd = openat_file(dirfd, filename, O_PATH_9P_UTIL | O_NOFOLLOW, 0);
+    if (fd == -1)
+        return -1;
+
+    ret = fremovexattr(fd, name, XATTR_NOFOLLOW);
+    close_preserve_errno(fd);
+    return ret;
+#else
+    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
 
     ret = lremovexattr(proc_path, name);
     g_free(proc_path);
     return ret;
+#endif
 }
 
 int fsetxattrat_nofollow(int dirfd, const char *filename, const char *name,
                          void *value, size_t size, int flags)
 {
-    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
     int ret;
+#ifdef CONFIG_DARWIN
+    int fd = openat_file(dirfd, filename, O_PATH_9P_UTIL | O_NOFOLLOW, 0);
+    if (fd == -1)
+        return -1;
+
+    ret = fsetxattr(fd, name, value, size, 0, XATTR_NOFOLLOW);
+    close_preserve_errno(fd);
+#else
+    char *proc_path = g_strdup_printf("/proc/self/fd/%d/%s", dirfd, filename);
 
     ret = lsetxattr(proc_path, name, value, size, flags);
     g_free(proc_path);
+#endif
     return ret;
 }
-- 
2.8.1

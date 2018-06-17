Received: from eggs.gnu.org ([2001:4830:134:3::10]:56875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fUM0X-0005jC-Ah
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fUM0V-0003HM-WE
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:29 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:42650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fUM0V-0003HI-QX
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:27 -0400
Received: by mail-qk0-x243.google.com with SMTP id j80-v6so7659765qke.9
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 17:57:27 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Sat, 16 Jun 2018 20:56:54 -0400
Message-Id: <a0bd7cdd338f0c44ea6786dab6889592431c71b1.1529196703.git.keno@juliacomputing.com>
In-Reply-To: <cover.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
In-Reply-To: <cover.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v3 10/13] 9p: darwin: Provide a fallback
 implementation for utimensat
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

This function is new in Mac OS 10.13. Provide a fallback implementation
when building against older SDKs. The complication in the definition comes
having to separately handle the used SDK version and the target OS version.

- If the SDK version is too low (__MAC_10_13 not defined), utimensat is not
  defined in the header, so we must not try to use it (doing so would error).
- Otherwise, if the targetted OS version is at least 10.13, we know this
  function is available, so we can unconditionally call it.
- Lastly, we check for the availability of the __builtin_available macro to
  potentially insert a dynamic check for this OS version. However, __builtin_available
  is only available with sufficiently recent versions of clang and while all
  Apple clang versions that ship with Xcode versions that support the 10.13
  SDK support with builtin, we want to allow building with compilers other
  than Apple clang that may not support this builtin.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 fsdev/virtfs-proxy-helper.c |  3 +-
 hw/9pfs/9p-local.c          |  2 +-
 hw/9pfs/9p-util-darwin.c    | 96 +++++++++++++++++++++++++++++++++++++++++++++
 hw/9pfs/9p-util-linux.c     |  6 +++
 hw/9pfs/9p-util.h           |  8 ++++
 hw/9pfs/9p.c                |  1 +
 6 files changed, 113 insertions(+), 3 deletions(-)

diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
index a26f8b8..d8dd3f5 100644
--- a/fsdev/virtfs-proxy-helper.c
+++ b/fsdev/virtfs-proxy-helper.c
@@ -957,8 +957,7 @@ static int process_requests(int sock)
                                      &spec[0].tv_sec, &spec[0].tv_nsec,
                                      &spec[1].tv_sec, &spec[1].tv_nsec);
             if (retval > 0) {
-                retval = utimensat(AT_FDCWD, path.data, spec,
-                                   AT_SYMLINK_NOFOLLOW);
+                retval = utimensat_nofollow(AT_FDCWD, path.data, spec);
                 if (retval < 0) {
                     retval = -errno;
                 }
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 768ef6f..56bcabf 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1071,7 +1071,7 @@ static int local_utimensat(FsContext *s, V9fsPath *fs_path,
         goto out;
     }
 
-    ret = utimensat(dirfd, name, buf, AT_SYMLINK_NOFOLLOW);
+    ret = utimensat_nofollow(dirfd, name, buf);
     close_preserve_errno(dirfd);
 out:
     g_free(dirpath);
diff --git a/hw/9pfs/9p-util-darwin.c b/hw/9pfs/9p-util-darwin.c
index cdb4c9e..ac414bc 100644
--- a/hw/9pfs/9p-util-darwin.c
+++ b/hw/9pfs/9p-util-darwin.c
@@ -62,3 +62,99 @@ int fsetxattrat_nofollow(int dirfd, const char *filename, const char *name,
     close_preserve_errno(fd);
     return ret;
 }
+
+#ifndef __has_builtin
+#define __has_builtin(x) 0
+#endif
+
+static int update_times_from_stat(int fd, struct timespec times[2],
+                                  int update0, int update1)
+{
+    struct stat buf;
+    int ret = fstat(fd, &buf);
+    if (ret == -1) {
+        return ret;
+    }
+    if (update0) {
+        times[0] = buf.st_atimespec;
+    }
+    if (update1) {
+        times[1] = buf.st_mtimespec;
+    }
+    return 0;
+}
+
+int utimensat_nofollow(int dirfd, const char *filename,
+                       const struct timespec times_in[2])
+{
+    int ret, fd;
+    int special0, special1;
+    struct timeval futimes_buf[2];
+    struct timespec times[2];
+    memcpy(times, times_in, 2 * sizeof(struct timespec));
+
+/* Check whether we have an SDK version that defines utimensat */
+#if defined(__MAC_10_13)
+# if __MAC_OS_X_VERSION_MIN_REQUIRED >= __MAC_10_13
+#  define UTIMENSAT_AVAILABLE 1
+# elif __has_builtin(__builtin_available)
+#  define UTIMENSAT_AVAILABLE __builtin_available(macos 10.13, *)
+# else
+#  define UTIMENSAT_AVAILABLE 0
+# endif
+    if (UTIMENSAT_AVAILABLE) {
+        return utimensat(dirfd, filename, times, AT_SYMLINK_NOFOLLOW);
+    }
+#endif
+
+    /* utimensat not available. Use futimes. */
+    fd = openat_file(dirfd, filename, O_PATH_9P_UTIL | O_NOFOLLOW, 0);
+    if (fd == -1) {
+        return -1;
+    }
+
+    special0 = times[0].tv_nsec == UTIME_OMIT;
+    special1 = times[1].tv_nsec == UTIME_OMIT;
+    if (special0 || special1) {
+        /* If both are set, nothing to do */
+        if (special0 && special1) {
+            ret = 0;
+            goto done;
+        }
+
+        ret = update_times_from_stat(fd, times, special0, special1);
+        if (ret < 0) {
+            goto done;
+        }
+    }
+
+    special0 = times[0].tv_nsec == UTIME_NOW;
+    special1 = times[1].tv_nsec == UTIME_NOW;
+    if (special0 || special1) {
+        ret = futimes(fd, NULL);
+        if (ret < 0) {
+            goto done;
+        }
+
+        /* If both are set, we are done */
+        if (special0 && special1) {
+            ret = 0;
+            goto done;
+        }
+
+        ret = update_times_from_stat(fd, times, special0, special1);
+        if (ret < 0) {
+            goto done;
+        }
+    }
+
+    futimes_buf[0].tv_sec = times[0].tv_sec;
+    futimes_buf[0].tv_usec = times[0].tv_nsec / 1000;
+    futimes_buf[1].tv_sec = times[1].tv_sec;
+    futimes_buf[1].tv_usec = times[1].tv_nsec / 1000;
+    ret = futimes(fd, futimes_buf);
+
+done:
+    close_preserve_errno(fd);
+    return ret;
+}
diff --git a/hw/9pfs/9p-util-linux.c b/hw/9pfs/9p-util-linux.c
index defa3a4..3902378 100644
--- a/hw/9pfs/9p-util-linux.c
+++ b/hw/9pfs/9p-util-linux.c
@@ -57,3 +57,9 @@ int fsetxattrat_nofollow(int dirfd, const char *filename, const char *name,
     g_free(proc_path);
     return ret;
 }
+
+int utimensat_nofollow(int dirfd, const char *filename,
+                       const struct timespec times[2])
+{
+    return utimensat(dirfd, filename, times, AT_SYMLINK_NOFOLLOW);
+}
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index 50a03c7..b1dc08a 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -36,6 +36,12 @@ static inline int qemu_lsetxattr(const char *path, const char *name,
 #define qemu_lsetxattr lsetxattr
 #endif
 
+/* Compatibility with old SDK Versions for Darwin */
+#if defined(CONFIG_DARWIN) && !defined(UTIME_NOW)
+#define UTIME_NOW -1
+#define UTIME_OMIT -2
+#endif
+
 static inline void close_preserve_errno(int fd)
 {
     int serrno = errno;
@@ -81,5 +87,7 @@ ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
                               char *list, size_t size);
 ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
                                 const char *name);
+int utimensat_nofollow(int dirfd, const char *filename,
+                       const struct timespec times[2]);
 
 #endif
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index abfb8dc..dc53691 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -21,6 +21,7 @@
 #include "virtio-9p.h"
 #include "fsdev/qemu-fsdev.h"
 #include "9p-xattr.h"
+#include "9p-util.h"
 #include "coth.h"
 #include "trace.h"
 #include "migration/blocker.h"
-- 
2.8.1

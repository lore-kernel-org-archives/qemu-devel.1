Received: from eggs.gnu.org ([2001:4830:134:3::10]:43267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efvEM-0004NU-J4
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 17:15:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efvEJ-0003bO-Bb
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 17:15:18 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1efvEI-0003aZ-SQ
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 17:15:15 -0500
Received: by mail-pf0-x241.google.com with SMTP id t12so3179941pfg.2
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 14:15:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 28 Jan 2018 14:15:10 -0800
Message-Id: <20180128221510.13722-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] linux-user: Use *at functions to implement
 interp_prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Richard Henderson <rth@twiddle.net>

If the interp_prefix is a complete chroot, it may have a *lot* of files.
Setting up the cache for this is quite expensive.

For the most part, we can use the *at versions of various syscalls to
attempt the operation in the prefix.  For the few cases that remain,
use faccessat and create the full path on demand.

Cc: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---

Changes since v3 (Dec 29 2017):
  * Use DO/WHILE as the control construct; wrap it in a macro.
  * Introduce linux_user_path to handle the cases *at syscalls
    do not cover.

Changes since v2 (Dec 4 2017):
  * Use IF as the control construct instead of SWITCH.

Changes since v1 (Nov 2016):
  * Require interp_dirfd set before trying the *at path.


r~

---
 linux-user/qemu.h    |  15 ++++++
 linux-user/elfload.c |   5 +-
 linux-user/main.c    |  36 +++++++++++++-
 linux-user/syscall.c | 130 +++++++++++++++++++++++++++++++++++----------------
 4 files changed, 141 insertions(+), 45 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 4edd7d0c08..5b621f26e0 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -437,8 +437,23 @@ void mmap_fork_start(void);
 void mmap_fork_end(int child);
 
 /* main.c */
+extern int interp_dirfd;
 extern unsigned long guest_stack_size;
 
+#define CHOOSE_INTERP(RET, PATH, OPENAT_EXPR, NORMAL_EXPR)  \
+    do {                                                    \
+        if (interp_dirfd >= 0 && PATH[0] == '/') {          \
+            RET = OPENAT_EXPR;                              \
+            if (!(RET < 0 && errno == ENOENT)) {            \
+                break;                                      \
+            }                                               \
+        }                                                   \
+        RET = NORMAL_EXPR;                                  \
+    } while (0)
+
+const char *linux_user_path(const char *);
+#define path(x)  linux_user_path(x)
+
 /* user access */
 
 #define VERIFY_READ 0
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 32a47674e6..1fb097e30d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -6,7 +6,6 @@
 
 #include "qemu.h"
 #include "disas/disas.h"
-#include "qemu/path.h"
 
 #ifdef _ARCH_PPC64
 #undef ARCH_DLINFO
@@ -2204,7 +2203,9 @@ static void load_elf_interp(const char *filename, struct image_info *info,
 {
     int fd, retval;
 
-    fd = open(path(filename), O_RDONLY);
+    CHOOSE_INTERP(fd, filename,
+                  openat(interp_dirfd, filename + 1, O_RDONLY),
+                  open(filename, O_RDONLY));
     if (fd < 0) {
         goto exit_perror;
     }
diff --git a/linux-user/main.c b/linux-user/main.c
index 2140465709..8f4087d508 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -23,7 +23,6 @@
 
 #include "qapi/error.h"
 #include "qemu.h"
-#include "qemu/path.h"
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
@@ -98,8 +97,41 @@ unsigned long reserved_va;
 static void usage(int exitcode);
 
 static const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
+int interp_dirfd;
 const char *qemu_uname_release;
 
+const char *linux_user_path(const char *pathname)
+{
+    static THREAD size_t save_len;
+    static THREAD char *save_buf;
+    size_t len, prefix_len, path_len;
+    int e;
+
+    /* Only consider absolute paths.  */
+    if (pathname[0] != '/' || interp_dirfd < 0) {
+        return pathname;
+    }
+
+    /* Test if the path within interp_dir exists.  */
+    e = faccessat(interp_dirfd, pathname + 1, F_OK, AT_SYMLINK_NOFOLLOW);
+    if (e < 0 && errno != ENOENT) {
+        return pathname;
+    }
+
+    /* It does -- form the new absolute path.  */
+    prefix_len = strlen(interp_prefix);
+    path_len = strlen(pathname) + 1;
+    len = prefix_len + path_len;
+    if (len <= save_len) {
+        save_len = len;
+        save_buf = realloc(save_buf, len);
+    }
+    memcpy(save_buf, interp_prefix, prefix_len);
+    memcpy(save_buf + prefix_len, pathname, path_len);
+
+    return save_buf;
+}
+
 /* XXX: on x86 MAP_GROWSDOWN only works if ESP <= address + 32, so
    we allocate a bigger stack. Need a better solution, for example
    by remapping the process stack directly at the right place */
@@ -4319,7 +4351,7 @@ int main(int argc, char **argv, char **envp)
     memset(&bprm, 0, sizeof (bprm));
 
     /* Scan interp_prefix dir for replacement files. */
-    init_paths(interp_prefix);
+    interp_dirfd = open(interp_prefix, O_CLOEXEC | O_DIRECTORY | O_PATH);
 
     init_qemu_uname_release();
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 74378947f0..ebd41fcab4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -19,7 +19,6 @@
 #define _ATFILE_SOURCE
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
-#include "qemu/path.h"
 #include <elf.h>
 #include <endian.h>
 #include <grp.h>
@@ -7263,7 +7262,10 @@ static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
     fh = g_malloc0(total_size);
     fh->handle_bytes = size;
 
-    ret = get_errno(name_to_handle_at(dirfd, path(name), fh, &mid, flags));
+    CHOOSE_INTERP(ret, name,
+                  name_to_handle_at(interp_dirfd, name + 1, fh, &mid, flags),
+                  name_to_handle_at(dirfd, name, fh, &mid, flags));
+    ret = get_errno(ret);
     unlock_user(name, pathname, 0);
 
     /* man name_to_handle_at(2):
@@ -7639,6 +7641,7 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags,
 #endif
         { NULL, NULL, NULL }
     };
+    int ret;
 
     if (is_proc_myself(pathname, "exe")) {
         int execfd = qemu_getauxval(AT_EXECFD);
@@ -7678,7 +7681,10 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags,
         return fd;
     }
 
-    return safe_openat(dirfd, path(pathname), flags, mode);
+    CHOOSE_INTERP(ret, pathname,
+                  safe_openat(interp_dirfd, pathname + 1, flags, mode),
+                  safe_openat(dirfd, pathname, flags, mode));
+    return ret;
 }
 
 #define TIMER_MAGIC 0x0caf0000
@@ -7831,6 +7837,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     struct stat st;
     struct statfs stfs;
     void *p;
+    char *fn;
 
 #if defined(DEBUG_ERESTARTSYS)
     /* Debug-only code for exercising the syscall-restart code paths
@@ -8362,10 +8369,14 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             } else {
                 tvp = NULL;
             }
-            if (!(p = lock_user_string(arg2)))
+            if (!(fn = lock_user_string(arg2))) {
                 goto efault;
-            ret = get_errno(futimesat(arg1, path(p), tvp));
-            unlock_user(p, arg2, 0);
+            }
+            CHOOSE_INTERP(ret, fn,
+                          futimesat(interp_dirfd, fn + 1, tvp),
+                          futimesat(arg1, fn, tvp));
+            ret = get_errno(ret);
+            unlock_user(fn, arg2, 0);
         }
         break;
 #endif
@@ -8379,18 +8390,26 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_access
     case TARGET_NR_access:
-        if (!(p = lock_user_string(arg1)))
+        if (!(fn = lock_user_string(arg1))) {
             goto efault;
-        ret = get_errno(access(path(p), arg2));
-        unlock_user(p, arg1, 0);
+        }
+        CHOOSE_INTERP(ret, fn,
+                      faccessat(interp_dirfd, fn + 1, arg2, 0),
+                      access(fn, arg2));
+        ret = get_errno(ret);
+        unlock_user(fn, arg1, 0);
         break;
 #endif
 #if defined(TARGET_NR_faccessat) && defined(__NR_faccessat)
     case TARGET_NR_faccessat:
-        if (!(p = lock_user_string(arg2)))
+        if (!(fn = lock_user_string(arg2))) {
             goto efault;
-        ret = get_errno(faccessat(arg1, p, arg3, 0));
-        unlock_user(p, arg2, 0);
+        }
+        CHOOSE_INTERP(ret, fn,
+                      faccessat(interp_dirfd, fn + 1, arg3, 0),
+                      faccessat(arg1, fn, arg3, 0));
+        ret = get_errno(ret);
+        unlock_user(fn, arg2, 0);
         break;
 #endif
 #ifdef TARGET_NR_nice /* not on alpha */
@@ -9307,14 +9326,14 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_readlink:
         {
             void *p2;
-            p = lock_user_string(arg1);
+            fn = lock_user_string(arg1);
             p2 = lock_user(VERIFY_WRITE, arg2, arg3, 0);
-            if (!p || !p2) {
+            if (!fn || !p2) {
                 ret = -TARGET_EFAULT;
             } else if (!arg3) {
                 /* Short circuit this for the magic exe check. */
                 ret = -TARGET_EINVAL;
-            } else if (is_proc_myself((const char *)p, "exe")) {
+            } else if (is_proc_myself(fn, "exe")) {
                 char real[PATH_MAX], *temp;
                 temp = realpath(exec_path, real);
                 /* Return value is # of bytes that we wrote to the buffer. */
@@ -9328,10 +9347,13 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                     memcpy(p2, real, ret);
                 }
             } else {
-                ret = get_errno(readlink(path(p), p2, arg3));
+                CHOOSE_INTERP(ret, fn,
+                              readlinkat(interp_dirfd, fn + 1, p2, arg3),
+                              readlink(fn, p2, arg3));
+                ret = get_errno(ret);
             }
             unlock_user(p2, arg2, ret);
-            unlock_user(p, arg1, 0);
+            unlock_user(fn, arg1, 0);
         }
         break;
 #endif
@@ -9339,20 +9361,23 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_readlinkat:
         {
             void *p2;
-            p  = lock_user_string(arg2);
+            fn = lock_user_string(arg2);
             p2 = lock_user(VERIFY_WRITE, arg3, arg4, 0);
-            if (!p || !p2) {
+            if (!fn || !p2) {
                 ret = -TARGET_EFAULT;
-            } else if (is_proc_myself((const char *)p, "exe")) {
+            } else if (is_proc_myself(fn, "exe")) {
                 char real[PATH_MAX], *temp;
                 temp = realpath(exec_path, real);
                 ret = temp == NULL ? get_errno(-1) : strlen(real) ;
                 snprintf((char *)p2, arg4, "%s", real);
             } else {
-                ret = get_errno(readlinkat(arg1, path(p), p2, arg4));
+                CHOOSE_INTERP(ret, fn,
+                              readlinkat(interp_dirfd, fn + 1, p2, arg4),
+                              readlinkat(arg1, fn, p2, arg4));
+                ret = get_errno(ret);
             }
             unlock_user(p2, arg3, ret);
-            unlock_user(p, arg2, 0);
+            unlock_user(fn, arg2, 0);
         }
         break;
 #endif
@@ -9780,18 +9805,26 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #ifdef TARGET_NR_stat
     case TARGET_NR_stat:
-        if (!(p = lock_user_string(arg1)))
+        if (!(fn = lock_user_string(arg1))) {
             goto efault;
-        ret = get_errno(stat(path(p), &st));
-        unlock_user(p, arg1, 0);
+        }
+        CHOOSE_INTERP(ret, fn,
+                      fstatat(interp_dirfd, fn + 1, &st, 0),
+                      stat(fn, &st));
+        ret = get_errno(ret);
+        unlock_user(fn, arg1, 0);
         goto do_stat;
 #endif
 #ifdef TARGET_NR_lstat
     case TARGET_NR_lstat:
-        if (!(p = lock_user_string(arg1)))
+        if (!(fn = lock_user_string(arg1))) {
             goto efault;
-        ret = get_errno(lstat(path(p), &st));
-        unlock_user(p, arg1, 0);
+        }
+        CHOOSE_INTERP(ret, fn,
+                      fstatat(interp_dirfd, fn + 1, &st, AT_SYMLINK_NOFOLLOW),
+                      lstat(fn, &st));
+        ret = get_errno(ret);
+        unlock_user(fn, arg1, 0);
         goto do_stat;
 #endif
     case TARGET_NR_fstat:
@@ -10886,20 +10919,28 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_stat64
     case TARGET_NR_stat64:
-        if (!(p = lock_user_string(arg1)))
+        if (!(fn = lock_user_string(arg1))) {
             goto efault;
-        ret = get_errno(stat(path(p), &st));
-        unlock_user(p, arg1, 0);
+        }
+        CHOOSE_INTERP(ret, fn,
+                      fstatat(interp_dirfd, fn + 1, &st, 0),
+                      stat(fn, &st));
+        ret = get_errno(ret);
+        unlock_user(fn, arg1, 0);
         if (!is_error(ret))
             ret = host_to_target_stat64(cpu_env, arg2, &st);
         break;
 #endif
 #ifdef TARGET_NR_lstat64
     case TARGET_NR_lstat64:
-        if (!(p = lock_user_string(arg1)))
+        if (!(fn = lock_user_string(arg1))) {
             goto efault;
-        ret = get_errno(lstat(path(p), &st));
-        unlock_user(p, arg1, 0);
+        }
+        CHOOSE_INTERP(ret, fn,
+                      fstatat(interp_dirfd, fn + 1, &st, AT_SYMLINK_NOFOLLOW),
+                      lstat(fn, &st));
+        ret = get_errno(ret);
+        unlock_user(fn, arg1, 0);
         if (!is_error(ret))
             ret = host_to_target_stat64(cpu_env, arg2, &st);
         break;
@@ -10918,9 +10959,14 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_newfstatat
     case TARGET_NR_newfstatat:
 #endif
-        if (!(p = lock_user_string(arg2)))
+        if (!(fn = lock_user_string(arg2))) {
             goto efault;
-        ret = get_errno(fstatat(arg1, path(p), &st, arg4));
+        }
+        CHOOSE_INTERP(ret, fn,
+                      fstatat(interp_dirfd, fn + 1, &st, arg4),
+                      fstatat(arg1, fn, &st, arg4));
+        ret = get_errno(ret);
+        unlock_user(fn, arg2, 0);
         if (!is_error(ret))
             ret = host_to_target_stat64(cpu_env, arg3, &st);
         break;
@@ -11917,12 +11963,14 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             if (!arg2)
                 ret = get_errno(sys_utimensat(arg1, NULL, tsp, arg4));
             else {
-                if (!(p = lock_user_string(arg2))) {
-                    ret = -TARGET_EFAULT;
-                    goto fail;
+                if (!(fn = lock_user_string(arg2))) {
+                    goto efault;
                 }
-                ret = get_errno(sys_utimensat(arg1, path(p), tsp, arg4));
-                unlock_user(p, arg2, 0);
+                CHOOSE_INTERP(ret, fn,
+                              sys_utimensat(interp_dirfd, fn + 1, tsp, arg4),
+                              sys_utimensat(arg1, fn, tsp, arg4));
+                ret = get_errno(ret);
+                unlock_user(fn, arg2, 0);
             }
         }
 	break;
-- 
2.14.3

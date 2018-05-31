Received: from eggs.gnu.org ([2001:4830:134:3::10]:38559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOWNr-0005Gw-Uj
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOWNo-0000rO-LU
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:49:27 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:44340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOWNo-0000qf-B4
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:49:24 -0400
Received: by mail-pg0-x244.google.com with SMTP id p21-v6so10350839pgd.11
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 15:49:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 31 May 2018 15:49:11 -0700
Message-Id: <20180531224911.23725-7-richard.henderson@linaro.org>
In-Reply-To: <20180531224911.23725-1-richard.henderson@linaro.org>
References: <20180531224911.23725-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 6/6] linux-user: Use *at functions to implement
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
Cc: peter.maydell@linaro.org, laurent@vivier.eu, evgreen@chromium.org

If the interp_prefix is a complete chroot, it may have a *lot* of files.
Setting up the cache for this is quite expensive.

For the most part, we can use the *at versions of various syscalls to
attempt the operation in the prefix.  For the few cases that remain,
attempt the operation in the prefix via concatenation and then retry
if that fails.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h    |  37 ++++++++++
 linux-user/elfload.c |   5 +-
 linux-user/main.c    |  26 ++++++-
 linux-user/syscall.c | 163 +++++++++++++++++++++++++++++--------------
 4 files changed, 174 insertions(+), 57 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 33dafbe0e4..05a82a3628 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -471,7 +471,44 @@ void mmap_fork_start(void);
 void mmap_fork_end(int child);
 
 /* main.c */
+extern int interp_dirfd;
 extern unsigned long guest_stack_size;
+char *interp_prefix_path(const char *path);
+
+/* If PATH is absolute, attempt an operation first within interp_dirfd,
+ * using OPENAT_EXPR.  If that fails with ENOENT, or if PATH is not
+ * absolute, only use NORMAL_EXPR.
+ */
+#define TRY_INTERP_FD(RET, PATH, OPENAT_EXPR, NORMAL_EXPR)  \
+    do {                                                    \
+        if (interp_dirfd >= 0 && (PATH)[0] == '/') {        \
+            RET = OPENAT_EXPR;                              \
+            if (RET != -1 || errno != ENOENT) {             \
+                break;                                      \
+            }                                               \
+        }                                                   \
+        RET = NORMAL_EXPR;                                  \
+    } while (0)
+
+/* If PATH is absolute, attempt an operation first with interp_prefix
+ * prefixed.  If that fails with ENOENT, or if PATH is not absolute,
+ * only attempt with PATH.
+ */
+#define TRY_INTERP_PATH(RET, PATH, EXPR)                    \
+    do {                                                    \
+        char *new_##PATH = interp_prefix_path(PATH);        \
+        if (new_##PATH) {                                   \
+            __typeof(PATH) save_##PATH = PATH;              \
+            PATH = new_##PATH;                              \
+            RET = EXPR;                                     \
+            free(new_##PATH);                               \
+            PATH = save_##PATH;                             \
+            if (RET != -1 || errno != ENOENT) {             \
+                break;                                      \
+            }                                               \
+        }                                                   \
+        RET = EXPR;                                         \
+    } while (0)
 
 /* user access */
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 13bc78d0c8..abdf5bbf01 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -6,7 +6,6 @@
 
 #include "qemu.h"
 #include "disas/disas.h"
-#include "qemu/path.h"
 
 #ifdef _ARCH_PPC64
 #undef ARCH_DLINFO
@@ -2375,7 +2374,9 @@ static void load_elf_interp(const char *filename, struct image_info *info,
 {
     int fd, retval;
 
-    fd = open(path(filename), O_RDONLY);
+    TRY_INTERP_FD(fd, filename,
+                  openat(interp_dirfd, filename + 1, O_RDONLY),
+                  open(filename, O_RDONLY));
     if (fd < 0) {
         goto exit_perror;
     }
diff --git a/linux-user/main.c b/linux-user/main.c
index ee3f323c08..4e956fc00c 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -23,7 +23,6 @@
 
 #include "qapi/error.h"
 #include "qemu.h"
-#include "qemu/path.h"
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
@@ -89,9 +88,27 @@ unsigned long reserved_va;
 
 static void usage(int exitcode);
 
+int interp_dirfd;
 static const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
 const char *qemu_uname_release;
 
+char *interp_prefix_path(const char *path)
+{
+    size_t i_len, p_len;
+    char *ret;
+
+    if (interp_prefix == NULL || path[0] != '/') {
+        return NULL;
+    }
+    i_len = strlen(interp_prefix);
+    p_len = strlen(path) + 1;
+    ret = g_malloc(i_len + p_len);
+
+    memcpy(ret, interp_prefix, i_len);
+    memcpy(ret + i_len, path, p_len);
+    return ret;
+}
+
 /* XXX: on x86 MAP_GROWSDOWN only works if ESP <= address + 32, so
    we allocate a bigger stack. Need a better solution, for example
    by remapping the process stack directly at the right place */
@@ -671,7 +688,12 @@ int main(int argc, char **argv, char **envp)
     memset(&bprm, 0, sizeof (bprm));
 
     /* Scan interp_prefix dir for replacement files. */
-    init_paths(interp_prefix);
+    interp_dirfd = open(interp_prefix, O_CLOEXEC | O_DIRECTORY | O_PATH);
+    if (interp_dirfd >= 0) {
+        add_hostfd(interp_dirfd);
+    } else {
+        interp_prefix = NULL;
+    }
 
     init_qemu_uname_release();
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d7513d5dac..b75dd9a5bc 100644
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
@@ -7401,7 +7400,10 @@ static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
     fh = g_malloc0(total_size);
     fh->handle_bytes = size;
 
-    ret = get_errno(name_to_handle_at(dirfd, path(name), fh, &mid, flags));
+    TRY_INTERP_FD(ret, name,
+                  name_to_handle_at(interp_dirfd, name + 1, fh, &mid, flags),
+                  name_to_handle_at(dirfd, name, fh, &mid, flags));
+    ret = get_errno(ret);
     unlock_user(name, pathname, 0);
 
     /* man name_to_handle_at(2):
@@ -7777,6 +7779,7 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags,
 #endif
         { NULL, NULL, NULL }
     };
+    int ret;
 
     if (is_proc_myself(pathname, "exe")) {
         int execfd = qemu_getauxval(AT_EXECFD);
@@ -7816,7 +7819,10 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags,
         return fd;
     }
 
-    return safe_openat(dirfd, path(pathname), flags, mode);
+    TRY_INTERP_FD(ret, pathname,
+                  safe_openat(interp_dirfd, pathname + 1, flags, mode),
+                  safe_openat(dirfd, pathname, flags, mode));
+    return ret;
 }
 
 #define TIMER_MAGIC 0x0caf0000
@@ -7969,6 +7975,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     struct stat st;
     struct statfs stfs;
     void *p;
+    char *fn;
 
 #if defined(DEBUG_ERESTARTSYS)
     /* Debug-only code for exercising the syscall-restart code paths
@@ -8531,10 +8538,14 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             } else {
                 tvp = NULL;
             }
-            if (!(p = lock_user_string(arg2)))
+            if (!(fn = lock_user_string(arg2))) {
                 goto efault;
-            ret = get_errno(futimesat(arg1, path(p), tvp));
-            unlock_user(p, arg2, 0);
+            }
+            TRY_INTERP_FD(ret, fn,
+                          futimesat(interp_dirfd, fn + 1, tvp),
+                          futimesat(arg1, fn, tvp));
+            ret = get_errno(ret);
+            unlock_user(fn, arg2, 0);
         }
         break;
 #endif
@@ -8548,10 +8559,14 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_access
     case TARGET_NR_access:
-        if (!(p = lock_user_string(arg1)))
+        if (!(fn = lock_user_string(arg1))) {
             goto efault;
-        ret = get_errno(access(path(p), arg2));
-        unlock_user(p, arg1, 0);
+        }
+        TRY_INTERP_FD(ret, fn,
+                      faccessat(interp_dirfd, fn + 1, arg2, 0),
+                      access(fn, arg2));
+        ret = get_errno(ret);
+        unlock_user(fn, arg1, 0);
         break;
 #endif
 #if defined(TARGET_NR_faccessat) && defined(__NR_faccessat)
@@ -8559,10 +8574,14 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         if (is_hostfd(arg1)) {
             goto ebadf;
         }
-        if (!(p = lock_user_string(arg2)))
+        if (!(fn = lock_user_string(arg2))) {
             goto efault;
-        ret = get_errno(faccessat(arg1, p, arg3, 0));
-        unlock_user(p, arg2, 0);
+        }
+        TRY_INTERP_FD(ret, fn,
+                      faccessat(interp_dirfd, fn + 1, arg3, 0),
+                      faccessat(arg1, fn, arg3, 0));
+        ret = get_errno(ret);
+        unlock_user(fn, arg2, 0);
         break;
 #endif
 #ifdef TARGET_NR_nice /* not on alpha */
@@ -8713,10 +8732,12 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         if (arg1 == 0) {
             ret = get_errno(acct(NULL));
         } else {
-            if (!(p = lock_user_string(arg1)))
+            if (!(fn = lock_user_string(arg1))) {
                 goto efault;
-            ret = get_errno(acct(path(p)));
-            unlock_user(p, arg1, 0);
+            }
+            TRY_INTERP_PATH(ret, fn, acct(fn));
+            ret = get_errno(ret);
+            unlock_user(fn, arg1, 0);
         }
         break;
 #ifdef TARGET_NR_umount2
@@ -9507,14 +9528,14 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
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
@@ -9528,10 +9549,13 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                     memcpy(p2, real, ret);
                 }
             } else {
-                ret = get_errno(readlink(path(p), p2, arg3));
+                TRY_INTERP_FD(ret, fn,
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
@@ -9541,20 +9565,23 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             goto ebadf;
         } else {
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
+                TRY_INTERP_FD(ret, fn,
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
@@ -9739,10 +9766,12 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         goto unimplemented;
 #endif
     case TARGET_NR_statfs:
-        if (!(p = lock_user_string(arg1)))
+        if (!(fn = lock_user_string(arg1))) {
             goto efault;
-        ret = get_errno(statfs(path(p), &stfs));
-        unlock_user(p, arg1, 0);
+        }
+        TRY_INTERP_PATH(ret, fn, statfs(fn, &stfs));
+        ret = get_errno(ret);
+        unlock_user(fn, arg1, 0);
     convert_statfs:
         if (!is_error(ret)) {
             struct target_statfs *target_stfs;
@@ -9777,10 +9806,12 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         goto convert_statfs;
 #ifdef TARGET_NR_statfs64
     case TARGET_NR_statfs64:
-        if (!(p = lock_user_string(arg1)))
+        if (!(fn = lock_user_string(arg1))) {
             goto efault;
-        ret = get_errno(statfs(path(p), &stfs));
-        unlock_user(p, arg1, 0);
+        }
+        TRY_INTERP_PATH(ret, fn, statfs(fn, &stfs));
+        ret = get_errno(ret);
+        unlock_user(fn, arg1, 0);
     convert_statfs64:
         if (!is_error(ret)) {
             struct target_statfs64 *target_stfs;
@@ -10065,18 +10096,26 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #ifdef TARGET_NR_stat
     case TARGET_NR_stat:
-        if (!(p = lock_user_string(arg1)))
+        if (!(fn = lock_user_string(arg1))) {
             goto efault;
-        ret = get_errno(stat(path(p), &st));
-        unlock_user(p, arg1, 0);
+        }
+        TRY_INTERP_FD(ret, fn,
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
+        TRY_INTERP_FD(ret, fn,
+                      fstatat(interp_dirfd, fn + 1, &st, AT_SYMLINK_NOFOLLOW),
+                      lstat(fn, &st));
+        ret = get_errno(ret);
+        unlock_user(fn, arg1, 0);
         goto do_stat;
 #endif
     case TARGET_NR_fstat:
@@ -11261,20 +11300,28 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_stat64
     case TARGET_NR_stat64:
-        if (!(p = lock_user_string(arg1)))
+        if (!(fn = lock_user_string(arg1))) {
             goto efault;
-        ret = get_errno(stat(path(p), &st));
-        unlock_user(p, arg1, 0);
+        }
+        TRY_INTERP_FD(ret, fn,
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
+        TRY_INTERP_FD(ret, fn,
+                      fstatat(interp_dirfd, fn + 1, &st, AT_SYMLINK_NOFOLLOW),
+                      lstat(fn, &st));
+        ret = get_errno(ret);
+        unlock_user(fn, arg1, 0);
         if (!is_error(ret))
             ret = host_to_target_stat64(cpu_env, arg2, &st);
         break;
@@ -11299,9 +11346,14 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         if (is_hostfd(arg1)) {
             goto ebadf;
         }
-        if (!(p = lock_user_string(arg2)))
+        if (!(fn = lock_user_string(arg2))) {
             goto efault;
-        ret = get_errno(fstatat(arg1, path(p), &st, arg4));
+        }
+        TRY_INTERP_FD(ret, fn,
+                      fstatat(interp_dirfd, fn + 1, &st, arg4),
+                      fstatat(arg1, fn, &st, arg4));
+        ret = get_errno(ret);
+        unlock_user(fn, arg2, 0);
         if (!is_error(ret))
             ret = host_to_target_stat64(cpu_env, arg3, &st);
         break;
@@ -12339,12 +12391,14 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
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
+                TRY_INTERP_FD(ret, fn,
+                              sys_utimensat(interp_dirfd, fn + 1, tsp, arg4),
+                              sys_utimensat(arg1, fn, tsp, arg4));
+                ret = get_errno(ret);
+                unlock_user(fn, arg2, 0);
             }
         }
 	break;
@@ -12376,9 +12430,12 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         if (is_hostfd(arg1)) {
             goto ebadf;
         }
-        p = lock_user_string(arg2);
-        ret = get_errno(sys_inotify_add_watch(arg1, path(p), arg3));
-        unlock_user(p, arg2, 0);
+        if (!(fn = lock_user_string(arg2))) {
+            goto efault;
+        }
+        TRY_INTERP_PATH(ret, fn, sys_inotify_add_watch(arg1, fn, arg3));
+        ret = get_errno(ret);
+        unlock_user(fn, arg2, 0);
         break;
 #endif
 #if defined(TARGET_NR_inotify_rm_watch) && defined(__NR_inotify_rm_watch)
-- 
2.17.0

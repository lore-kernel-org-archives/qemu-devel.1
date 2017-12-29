Received: from eggs.gnu.org ([2001:4830:134:3::10]:58495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUzR0-0000gU-6C
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 13:31:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUzQw-0001vJ-5d
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 13:31:10 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:34910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUzQv-0001ts-TD
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 13:31:06 -0500
Received: by mail-pl0-x241.google.com with SMTP id b96so23358096pli.2
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 10:31:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 29 Dec 2017 10:31:01 -0800
Message-Id: <20171229183101.9372-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3] linux-user: Use *at functions instead of
 caching interp_prefix contents
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
Setting up the cache for this is quite expensive.  Instead, use the *at
versions of various syscalls to attempt the operation in the prefix.

Cc: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---

Changes since v2 (Dec 4 2017):
  * Use IF as the control construct instead of SWITCH.

Changes since v1 (Nov 2016):
  * Require interp_dirfd set before trying the *at path.


r~

---
 linux-user/qemu.h    |   1 +
 linux-user/elfload.c |   7 +-
 linux-user/main.c    |   3 +-
 linux-user/syscall.c | 176 ++++++++++++++++++++++++++++++++++++++-------------
 4 files changed, 141 insertions(+), 46 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 4edd7d0c08..d04924fd2e 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -437,6 +437,7 @@ void mmap_fork_start(void);
 void mmap_fork_end(int child);
 
 /* main.c */
+extern int interp_dirfd;
 extern unsigned long guest_stack_size;
 
 /* user access */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 20f3d8c2c3..e70eebc7b8 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2203,7 +2203,12 @@ static void load_elf_interp(const char *filename, struct image_info *info,
 {
     int fd, retval;
 
-    fd = open(path(filename), O_RDONLY);
+    if (interp_dirfd < 0
+        || filename[0] != '/'
+        || (fd = openat(interp_dirfd, filename + 1, O_RDONLY),
+            fd < 0 && errno == ENOENT)) {
+        fd = open(filename, O_RDONLY);
+    }
     if (fd < 0) {
         goto exit_perror;
     }
diff --git a/linux-user/main.c b/linux-user/main.c
index 71696ed33d..391cc5ef82 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -98,6 +98,7 @@ unsigned long reserved_va;
 static void usage(int exitcode);
 
 static const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
+int interp_dirfd;
 const char *qemu_uname_release;
 
 /* XXX: on x86 MAP_GROWSDOWN only works if ESP <= address + 32, so
@@ -4307,7 +4308,7 @@ int main(int argc, char **argv, char **envp)
     memset(&bprm, 0, sizeof (bprm));
 
     /* Scan interp_prefix dir for replacement files. */
-    init_paths(interp_prefix);
+    interp_dirfd = open(interp_prefix, O_CLOEXEC | O_DIRECTORY | O_PATH);
 
     init_qemu_uname_release();
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 11c9116c4a..007db808df 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7228,7 +7228,13 @@ static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
     fh = g_malloc0(total_size);
     fh->handle_bytes = size;
 
-    ret = get_errno(name_to_handle_at(dirfd, path(name), fh, &mid, flags));
+    if (interp_dirfd < 0
+        || name[0] != '/'
+        || (ret = name_to_handle_at(interp_dirfd, name + 1, fh, &mid, flags),
+            ret < 0 && errno == ENOENT)) {
+        ret = name_to_handle_at(dirfd, name, fh, &mid, flags);
+    }
+    ret = get_errno(ret);
     unlock_user(name, pathname, 0);
 
     /* man name_to_handle_at(2):
@@ -7604,6 +7610,7 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags,
 #endif
         { NULL, NULL, NULL }
     };
+    int ret;
 
     if (is_proc_myself(pathname, "exe")) {
         int execfd = qemu_getauxval(AT_EXECFD);
@@ -7643,7 +7650,13 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags,
         return fd;
     }
 
-    return safe_openat(dirfd, path(pathname), flags, mode);
+    if (interp_dirfd < 0
+        || pathname[0] != '/'
+        || (ret = safe_openat(interp_dirfd, pathname + 1, flags, mode),
+            ret < 0 && errno == ENOENT)) {
+        ret = safe_openat(dirfd, pathname, flags, mode);
+    }
+    return ret;
 }
 
 #define TIMER_MAGIC 0x0caf0000
@@ -7729,6 +7742,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     struct stat st;
     struct statfs stfs;
     void *p;
+    char *fn;
 
 #if defined(DEBUG_ERESTARTSYS)
     /* Debug-only code for exercising the syscall-restart code paths
@@ -8260,10 +8274,17 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             } else {
                 tvp = NULL;
             }
-            if (!(p = lock_user_string(arg2)))
+            if (!(fn = lock_user_string(arg2))) {
                 goto efault;
-            ret = get_errno(futimesat(arg1, path(p), tvp));
-            unlock_user(p, arg2, 0);
+            }
+            if (interp_dirfd < 0
+                || fn[0] != '/'
+                || (ret = futimesat(interp_dirfd, fn + 1, tvp),
+                    ret < 0 && errno == ENOENT)) {
+                ret = futimesat(arg1, fn, tvp);
+            }
+            ret = get_errno(ret);
+            unlock_user(fn, arg2, 0);
         }
         break;
 #endif
@@ -8277,18 +8298,32 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_access
     case TARGET_NR_access:
-        if (!(p = lock_user_string(arg1)))
+        if (!(fn = lock_user_string(arg1))) {
             goto efault;
-        ret = get_errno(access(path(p), arg2));
-        unlock_user(p, arg1, 0);
+        }
+        if (interp_dirfd < 0
+            || fn[0] != '/'
+            || (ret = faccessat(interp_dirfd, fn + 1, arg2, 0),
+                ret < 0 && errno == ENOENT)) {
+            ret = access(fn, arg2);
+        }
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
+        if (interp_dirfd < 0
+            || fn[0] != '/'
+            || (ret = faccessat(interp_dirfd, fn + 1, arg3, 0),
+                ret < 0 && errno == ENOENT)) {
+            ret = faccessat(arg1, fn, arg3, 0);
+        }
+        ret = get_errno(ret);
+        unlock_user(fn, arg2, 0);
         break;
 #endif
 #ifdef TARGET_NR_nice /* not on alpha */
@@ -8415,7 +8450,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         } else {
             if (!(p = lock_user_string(arg1)))
                 goto efault;
-            ret = get_errno(acct(path(p)));
+            ret = get_errno(acct(p));
             unlock_user(p, arg1, 0);
         }
         break;
@@ -9181,14 +9216,14 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
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
@@ -9202,10 +9237,16 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                     memcpy(p2, real, ret);
                 }
             } else {
-                ret = get_errno(readlink(path(p), p2, arg3));
+                if (interp_dirfd < 0
+                    || fn[0] != '/'
+                    || (ret = readlinkat(interp_dirfd, fn + 1, p2, arg3),
+                        ret < 0 && errno == ENOENT)) {
+                    ret = readlink(fn, p2, arg3);
+                }
+                ret = get_errno(ret);
             }
             unlock_user(p2, arg2, ret);
-            unlock_user(p, arg1, 0);
+            unlock_user(fn, arg1, 0);
         }
         break;
 #endif
@@ -9213,20 +9254,26 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
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
+                if (interp_dirfd < 0
+                    || fn[0] != '/'
+                    || (ret = readlinkat(interp_dirfd, fn + 1, p2, arg4),
+                        ret < 0 && errno == ENOENT)) {
+                    ret = readlinkat(arg1, fn, p2, arg4);
+                }
+                ret = get_errno(ret);
             }
             unlock_user(p2, arg3, ret);
-            unlock_user(p, arg2, 0);
+            unlock_user(fn, arg2, 0);
         }
         break;
 #endif
@@ -9395,7 +9442,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_statfs:
         if (!(p = lock_user_string(arg1)))
             goto efault;
-        ret = get_errno(statfs(path(p), &stfs));
+        ret = get_errno(statfs(p, &stfs));
         unlock_user(p, arg1, 0);
     convert_statfs:
         if (!is_error(ret)) {
@@ -9425,7 +9472,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_statfs64:
         if (!(p = lock_user_string(arg1)))
             goto efault;
-        ret = get_errno(statfs(path(p), &stfs));
+        ret = get_errno(statfs(p, &stfs));
         unlock_user(p, arg1, 0);
     convert_statfs64:
         if (!is_error(ret)) {
@@ -9654,18 +9701,32 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #ifdef TARGET_NR_stat
     case TARGET_NR_stat:
-        if (!(p = lock_user_string(arg1)))
+        if (!(fn = lock_user_string(arg1))) {
             goto efault;
-        ret = get_errno(stat(path(p), &st));
-        unlock_user(p, arg1, 0);
+        }
+        if (interp_dirfd < 0
+            || fn[0] != '/'
+            || (ret = fstatat(interp_dirfd, fn + 1, &st, 0),
+                ret < 0 && errno == ENOENT)) {
+            ret = stat(fn, &st);
+        }
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
+        if (interp_dirfd < 0
+            || fn[0] != '/'
+            || (ret = fstatat(interp_dirfd, fn + 1, &st, AT_SYMLINK_NOFOLLOW),
+                ret < 0 && errno == ENOENT)) {
+            ret = lstat(fn, &st);
+        }
+        ret = get_errno(ret);
+        unlock_user(fn, arg1, 0);
         goto do_stat;
 #endif
     case TARGET_NR_fstat:
@@ -10745,20 +10806,34 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_stat64
     case TARGET_NR_stat64:
-        if (!(p = lock_user_string(arg1)))
+        if (!(fn = lock_user_string(arg1))) {
             goto efault;
-        ret = get_errno(stat(path(p), &st));
-        unlock_user(p, arg1, 0);
+        }
+        if (interp_dirfd < 0
+            || fn[0] != '/'
+            || (ret = fstatat(interp_dirfd, fn + 1, &st, 0),
+                ret < 0 && errno == ENOENT)) {
+            ret = stat(fn, &st);
+        }
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
+        if (interp_dirfd < 0
+            || fn[0] != '/'
+            || (ret = fstatat(interp_dirfd, fn + 1, &st, AT_SYMLINK_NOFOLLOW),
+                ret < 0 && errno == ENOENT)) {
+            ret = lstat(fn, &st);
+        }
+        ret = get_errno(ret);
+        unlock_user(fn, arg1, 0);
         if (!is_error(ret))
             ret = host_to_target_stat64(cpu_env, arg2, &st);
         break;
@@ -10777,9 +10852,17 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_newfstatat
     case TARGET_NR_newfstatat:
 #endif
-        if (!(p = lock_user_string(arg2)))
+        if (!(fn = lock_user_string(arg2))) {
             goto efault;
-        ret = get_errno(fstatat(arg1, path(p), &st, arg4));
+        }
+        if (interp_dirfd < 0
+            || fn[0] != '/'
+            || (ret = fstatat(interp_dirfd, fn + 1, &st, arg4),
+                ret < 0 && errno == ENOENT)) {
+            ret = fstatat(arg1, fn, &st, arg4);
+        }
+        ret = get_errno(ret);
+        unlock_user(fn, arg2, 0);
         if (!is_error(ret))
             ret = host_to_target_stat64(cpu_env, arg3, &st);
         break;
@@ -11776,12 +11859,17 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
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
+                if (interp_dirfd < 0
+                    || fn[0] != '/'
+                    || (ret = sys_utimensat(interp_dirfd, fn + 1, tsp, arg4),
+                        ret < 0 && errno == ENOENT)) {
+                    ret = sys_utimensat(arg1, fn, tsp, arg4);
+                }
+                ret = get_errno(ret);
+                unlock_user(fn, arg2, 0);
             }
         }
 	break;
@@ -11811,7 +11899,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_inotify_add_watch) && defined(__NR_inotify_add_watch)
     case TARGET_NR_inotify_add_watch:
         p = lock_user_string(arg2);
-        ret = get_errno(sys_inotify_add_watch(arg1, path(p), arg3));
+        ret = get_errno(sys_inotify_add_watch(arg1, p, arg3));
         unlock_user(p, arg2, 0);
         break;
 #endif
-- 
2.14.3

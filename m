Received: from eggs.gnu.org ([2001:4830:134:3::10]:37668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRWdz-00064i-S1
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 23:05:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRWdx-0006KN-B0
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 23:05:43 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRWdw-0006Jw-Uk
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 23:05:41 -0500
Received: by mail-qt0-x242.google.com with SMTP id l7so969367qtd.3
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 20:05:40 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 20:05:34 -0800
Message-Id: <20170112040534.15179-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH] linux-user: Use *at functions instead of
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
Cc: riku.voipio@iki.fi

If the interp_prefix is a complete chroot, it may have a *lot* of files.
Setting up the cache for this is quite expensive.  Instead, use the *at
versions of various syscalls to attempt the operation in the prefix.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/elfload.c |  12 ++-
 linux-user/main.c    |   3 +-
 linux-user/qemu.h    |   1 +
 linux-user/syscall.c | 236 ++++++++++++++++++++++++++++++++++++++++++---------
 util/Makefile.objs   |   2 +-
 util/path.c          | 178 --------------------------------------
 6 files changed, 209 insertions(+), 223 deletions(-)
 delete mode 100644 util/path.c

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 547053c..8b947fd 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2026,7 +2026,17 @@ static void load_elf_interp(const char *filename, struct image_info *info,
 {
     int fd, retval;
 
-    fd = open(path(filename), O_RDONLY);
+    switch (filename[0]) {
+    case '/':
+        fd = openat(interp_dirfd, filename + 1, O_RDONLY);
+        if (fd >= 0 || errno != ENOENT) {
+            break;
+        }
+        /* fallthru */
+    default:
+        fd = open(filename, O_RDONLY);
+        break;
+    }
     if (fd < 0) {
         goto exit_perror;
     }
diff --git a/linux-user/main.c b/linux-user/main.c
index c1d5eb4..dba988b 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -81,6 +81,7 @@ unsigned long reserved_va;
 static void usage(int exitcode);
 
 static const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
+int interp_dirfd;
 const char *qemu_uname_release;
 
 /* XXX: on x86 MAP_GROWSDOWN only works if ESP <= address + 32, so
@@ -4013,7 +4014,7 @@ int main(int argc, char **argv, char **envp)
     memset(&bprm, 0, sizeof (bprm));
 
     /* Scan interp_prefix dir for replacement files. */
-    init_paths(interp_prefix);
+    interp_dirfd = open(interp_prefix, O_CLOEXEC | O_DIRECTORY | O_PATH);
 
     init_qemu_uname_release();
 
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index da73a01..f91e2d5 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -434,6 +434,7 @@ void mmap_fork_start(void);
 void mmap_fork_end(int child);
 
 /* main.c */
+extern int interp_dirfd;
 extern unsigned long guest_stack_size;
 
 /* user access */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7b77503..18d40bb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7055,7 +7055,18 @@ static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
     fh = g_malloc0(total_size);
     fh->handle_bytes = size;
 
-    ret = get_errno(name_to_handle_at(dirfd, path(name), fh, &mid, flags));
+    switch (name[0]) {
+    case '/':
+        ret = name_to_handle_at(interp_dirfd, name + 1, fh, &mid, flags);
+        if (ret == 0 || errno != ENOENT) {
+            break;
+        }
+        /* fallthru */
+    default:
+        ret = name_to_handle_at(dirfd, name, fh, &mid, flags);
+        break;
+    }
+    ret = get_errno(ret);
     unlock_user(name, pathname, 0);
 
     /* man name_to_handle_at(2):
@@ -7464,6 +7475,7 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags,
 #endif
         { NULL, NULL, NULL }
     };
+    int ret;
 
     if (is_proc_myself(pathname, "exe")) {
         int execfd = qemu_getauxval(AT_EXECFD);
@@ -7503,7 +7515,18 @@ static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags,
         return fd;
     }
 
-    return safe_openat(dirfd, path(pathname), flags, mode);
+    switch (pathname[0]) {
+    case '/':
+        ret = safe_openat(interp_dirfd, pathname + 1, flags, mode);
+        if (ret >= 0 || errno != ENOENT) {
+            break;
+        }
+        /* fallthru */
+    default:
+        ret = safe_openat(dirfd, pathname, flags, mode);
+        break;
+    }
+    return ret;
 }
 
 #define TIMER_MAGIC 0x0caf0000
@@ -7540,6 +7563,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     struct stat st;
     struct statfs stfs;
     void *p;
+    char *fn;
 
 #if defined(DEBUG_ERESTARTSYS)
     /* Debug-only code for exercising the syscall-restart code paths
@@ -8058,10 +8082,21 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             } else {
                 tvp = NULL;
             }
-            if (!(p = lock_user_string(arg2)))
+            if (!(fn = lock_user_string(arg2)))
                 goto efault;
-            ret = get_errno(futimesat(arg1, path(p), tvp));
-            unlock_user(p, arg2, 0);
+            switch (fn[0]) {
+            case '/':
+                ret = futimesat(interp_dirfd, fn + 1, tvp);
+                if (ret == 0 || errno != ENOENT) {
+                    break;
+                }
+                /* fallthru */
+            default:
+                ret = futimesat(arg1, fn, tvp);
+                break;
+            }
+            ret = get_errno(ret);
+            unlock_user(fn, arg2, 0);
         }
         break;
 #endif
@@ -8075,18 +8110,42 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_access
     case TARGET_NR_access:
-        if (!(p = lock_user_string(arg1)))
+        if (!(fn = lock_user_string(arg1))) {
             goto efault;
-        ret = get_errno(access(path(p), arg2));
-        unlock_user(p, arg1, 0);
+        }
+        switch (fn[0]) {
+        case '/':
+            ret = faccessat(interp_dirfd, fn + 1, arg2, 0);
+            if (ret == 0 || errno != ENOENT) {
+                break;
+            }
+            /* fallthru */
+        default:
+            ret = access(fn, arg2);
+            break;
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
+        switch (fn[0]) {
+        case '/':
+            ret = faccessat(interp_dirfd, fn + 1, arg3, 0);
+            if (ret == 0 || errno != ENOENT) {
+                break;
+            }
+            /* fallthru */
+        default:
+            ret = faccessat(arg1, fn, arg3, 0);
+            break;
+        }
+        ret = get_errno(ret);
+        unlock_user(fn, arg2, 0);
         break;
 #endif
 #ifdef TARGET_NR_nice /* not on alpha */
@@ -8213,7 +8272,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         } else {
             if (!(p = lock_user_string(arg1)))
                 goto efault;
-            ret = get_errno(acct(path(p)));
+            ret = get_errno(acct(p));
             unlock_user(p, arg1, 0);
         }
         break;
@@ -8955,14 +9014,14 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
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
@@ -8976,10 +9035,21 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                     memcpy(p2, real, ret);
                 }
             } else {
-                ret = get_errno(readlink(path(p), p2, arg3));
+                switch (fn[0]) {
+                case '/':
+                    ret = readlinkat(interp_dirfd, fn + 1, p2, arg3);
+                    if (ret == 0 || errno != ENOENT) {
+                        break;
+                    }
+                    /* fallthru */
+                default:
+                    ret = readlink(fn, p2, arg3);
+                    break;
+                }
+                ret = get_errno(ret);
             }
             unlock_user(p2, arg2, ret);
-            unlock_user(p, arg1, 0);
+            unlock_user(fn, arg1, 0);
         }
         break;
 #endif
@@ -8987,20 +9057,31 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
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
+                switch (fn[0]) {
+                case '/':
+                    ret = readlinkat(interp_dirfd, fn + 1, p2, arg4);
+                    if (ret == 0 || errno != ENOENT) {
+                        break;
+                    }
+                    /* fallthru */
+                default:
+                    ret = readlinkat(arg1, fn, p2, arg4);
+                    break;
+                }
+                ret = get_errno(ret);
             }
             unlock_user(p2, arg3, ret);
-            unlock_user(p, arg2, 0);
+            unlock_user(fn, arg2, 0);
         }
         break;
 #endif
@@ -9169,7 +9250,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_statfs:
         if (!(p = lock_user_string(arg1)))
             goto efault;
-        ret = get_errno(statfs(path(p), &stfs));
+        ret = get_errno(statfs(p, &stfs));
         unlock_user(p, arg1, 0);
     convert_statfs:
         if (!is_error(ret)) {
@@ -9199,7 +9280,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_statfs64:
         if (!(p = lock_user_string(arg1)))
             goto efault;
-        ret = get_errno(statfs(path(p), &stfs));
+        ret = get_errno(statfs(p, &stfs));
         unlock_user(p, arg1, 0);
     convert_statfs64:
         if (!is_error(ret)) {
@@ -9429,18 +9510,42 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #ifdef TARGET_NR_stat
     case TARGET_NR_stat:
-        if (!(p = lock_user_string(arg1)))
+        if (!(fn = lock_user_string(arg1))) {
             goto efault;
-        ret = get_errno(stat(path(p), &st));
-        unlock_user(p, arg1, 0);
+        }
+        switch (fn[0]) {
+        case '/':
+            ret = fstatat(interp_dirfd, fn + 1, &st, 0);
+            if (ret == 0 || errno != ENOENT) {
+                break;
+            }
+            /* fallthru */
+        default:
+            ret = stat(fn, &st);
+            break;
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
+        switch (fn[0]) {
+        case '/':
+            ret = fstatat(interp_dirfd, fn + 1, &st, AT_SYMLINK_NOFOLLOW);
+            if (ret == 0 || errno != ENOENT) {
+                break;
+            }
+            /* fallthru */
+        default:
+            ret = lstat(fn, &st);
+            break;
+        }
+        ret = get_errno(ret);
+        unlock_user(fn, arg1, 0);
         goto do_stat;
 #endif
     case TARGET_NR_fstat:
@@ -10513,20 +10618,44 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_stat64
     case TARGET_NR_stat64:
-        if (!(p = lock_user_string(arg1)))
+        if (!(fn = lock_user_string(arg1))) {
             goto efault;
-        ret = get_errno(stat(path(p), &st));
-        unlock_user(p, arg1, 0);
+        }
+        switch (fn[0]) {
+        case '/':
+            ret = fstatat(interp_dirfd, fn + 1, &st, 0);
+            if (ret == 0 || errno != ENOENT) {
+                break;
+            }
+            /* fallthru */
+        default:
+            ret = stat(fn, &st);
+            break;
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
+        switch (fn[0]) {
+        case '/':
+            ret = fstatat(interp_dirfd, fn + 1, &st, AT_SYMLINK_NOFOLLOW);
+            if (ret == 0 || errno != ENOENT) {
+                break;
+            }
+            /* fallthru */
+        default:
+            ret = lstat(fn, &st);
+            break;
+        }
+        ret = get_errno(ret);
+        unlock_user(fn, arg1, 0);
         if (!is_error(ret))
             ret = host_to_target_stat64(cpu_env, arg2, &st);
         break;
@@ -10545,9 +10674,21 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_newfstatat
     case TARGET_NR_newfstatat:
 #endif
-        if (!(p = lock_user_string(arg2)))
+        if (!(fn = lock_user_string(arg2)))
             goto efault;
-        ret = get_errno(fstatat(arg1, path(p), &st, arg4));
+        switch (fn[0]) {
+        case '/':
+            ret = fstatat(interp_dirfd, fn + 1, &st, arg4);
+            if (ret == 0 || errno != ENOENT) {
+                break;
+            }
+            /* fallthru */
+        default:
+            ret = fstatat(arg1, fn, &st, arg4);
+            break;
+        }
+        ret = get_errno(ret);
+        unlock_user(fn, arg2, 0);
         if (!is_error(ret))
             ret = host_to_target_stat64(cpu_env, arg3, &st);
         break;
@@ -11529,12 +11670,23 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             if (!arg2)
                 ret = get_errno(sys_utimensat(arg1, NULL, tsp, arg4));
             else {
-                if (!(p = lock_user_string(arg2))) {
+                if (!(fn = lock_user_string(arg2))) {
                     ret = -TARGET_EFAULT;
                     goto fail;
                 }
-                ret = get_errno(sys_utimensat(arg1, path(p), tsp, arg4));
-                unlock_user(p, arg2, 0);
+                switch (fn[0]) {
+                case '/':
+                    ret = sys_utimensat(interp_dirfd, fn + 1, tsp, arg4);
+                    if (ret == 0 || errno != ENOENT) {
+                        break;
+                    }
+                    /* fallthru */
+                default:
+                    ret = sys_utimensat(arg1, fn, tsp, arg4);
+                    break;
+                }
+                ret = get_errno(ret);
+                unlock_user(fn, arg2, 0);
             }
         }
 	break;
@@ -11557,7 +11709,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_inotify_add_watch) && defined(__NR_inotify_add_watch)
     case TARGET_NR_inotify_add_watch:
         p = lock_user_string(arg2);
-        ret = get_errno(sys_inotify_add_watch(arg1, path(p), arg3));
+        ret = get_errno(sys_inotify_add_watch(arg1, p, arg3));
         unlock_user(p, arg2, 0);
         break;
 #endif
diff --git a/util/Makefile.objs b/util/Makefile.objs
index ad0f9c7..429d1b0 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -10,7 +10,7 @@ util-obj-$(CONFIG_WIN32) += event_notifier-win32.o
 util-obj-$(CONFIG_POSIX) += memfd.o
 util-obj-$(CONFIG_WIN32) += oslib-win32.o
 util-obj-$(CONFIG_WIN32) += qemu-thread-win32.o
-util-obj-y += envlist.o path.o module.o
+util-obj-y += envlist.o module.o
 util-obj-$(call lnot,$(CONFIG_INT128)) += host-utils.o
 util-obj-y += bitmap.o bitops.o hbitmap.o
 util-obj-y += fifo8.o
diff --git a/util/path.c b/util/path.c
deleted file mode 100644
index 5479f76..0000000
--- a/util/path.c
+++ /dev/null
@@ -1,178 +0,0 @@
-/* Code to mangle pathnames into those matching a given prefix.
-   eg. open("/lib/foo.so") => open("/usr/gnemul/i386-linux/lib/foo.so");
-
-   The assumption is that this area does not change.
-*/
-#include "qemu/osdep.h"
-#include <sys/param.h>
-#include <dirent.h>
-#include "qemu-common.h"
-#include "qemu/cutils.h"
-#include "qemu/path.h"
-
-struct pathelem
-{
-    /* Name of this, eg. lib */
-    char *name;
-    /* Full path name, eg. /usr/gnemul/x86-linux/lib. */
-    char *pathname;
-    struct pathelem *parent;
-    /* Children */
-    unsigned int num_entries;
-    struct pathelem *entries[0];
-};
-
-static struct pathelem *base;
-
-/* First N chars of S1 match S2, and S2 is N chars long. */
-static int strneq(const char *s1, unsigned int n, const char *s2)
-{
-    unsigned int i;
-
-    for (i = 0; i < n; i++)
-        if (s1[i] != s2[i])
-            return 0;
-    return s2[i] == 0;
-}
-
-static struct pathelem *add_entry(struct pathelem *root, const char *name,
-                                  unsigned type);
-
-static struct pathelem *new_entry(const char *root,
-                                  struct pathelem *parent,
-                                  const char *name)
-{
-    struct pathelem *new = g_malloc(sizeof(*new));
-    new->name = g_strdup(name);
-    new->pathname = g_strdup_printf("%s/%s", root, name);
-    new->num_entries = 0;
-    return new;
-}
-
-#define streq(a,b) (strcmp((a), (b)) == 0)
-
-/* Not all systems provide this feature */
-#if defined(DT_DIR) && defined(DT_UNKNOWN) && defined(DT_LNK)
-# define dirent_type(dirent) ((dirent)->d_type)
-# define is_dir_maybe(type) \
-    ((type) == DT_DIR || (type) == DT_UNKNOWN || (type) == DT_LNK)
-#else
-# define dirent_type(dirent) (1)
-# define is_dir_maybe(type)  (type)
-#endif
-
-static struct pathelem *add_dir_maybe(struct pathelem *path)
-{
-    DIR *dir;
-
-    if ((dir = opendir(path->pathname)) != NULL) {
-        struct dirent *dirent;
-
-        while ((dirent = readdir(dir)) != NULL) {
-            if (!streq(dirent->d_name,".") && !streq(dirent->d_name,"..")){
-                path = add_entry(path, dirent->d_name, dirent_type(dirent));
-            }
-        }
-        closedir(dir);
-    }
-    return path;
-}
-
-static struct pathelem *add_entry(struct pathelem *root, const char *name,
-                                  unsigned type)
-{
-    struct pathelem **e;
-
-    root->num_entries++;
-
-    root = g_realloc(root, sizeof(*root)
-                   + sizeof(root->entries[0])*root->num_entries);
-    e = &root->entries[root->num_entries-1];
-
-    *e = new_entry(root->pathname, root, name);
-    if (is_dir_maybe(type)) {
-        *e = add_dir_maybe(*e);
-    }
-
-    return root;
-}
-
-/* This needs to be done after tree is stabilized (ie. no more reallocs!). */
-static void set_parents(struct pathelem *child, struct pathelem *parent)
-{
-    unsigned int i;
-
-    child->parent = parent;
-    for (i = 0; i < child->num_entries; i++)
-        set_parents(child->entries[i], child);
-}
-
-/* FIXME: Doesn't handle DIR/.. where DIR is not in emulated dir. */
-static const char *
-follow_path(const struct pathelem *cursor, const char *name)
-{
-    unsigned int i, namelen;
-
-    name += strspn(name, "/");
-    namelen = strcspn(name, "/");
-
-    if (namelen == 0)
-        return cursor->pathname;
-
-    if (strneq(name, namelen, ".."))
-        return follow_path(cursor->parent, name + namelen);
-
-    if (strneq(name, namelen, "."))
-        return follow_path(cursor, name + namelen);
-
-    for (i = 0; i < cursor->num_entries; i++)
-        if (strneq(name, namelen, cursor->entries[i]->name))
-            return follow_path(cursor->entries[i], name + namelen);
-
-    /* Not found */
-    return NULL;
-}
-
-void init_paths(const char *prefix)
-{
-    char pref_buf[PATH_MAX];
-
-    if (prefix[0] == '\0' ||
-        !strcmp(prefix, "/"))
-        return;
-
-    if (prefix[0] != '/') {
-        char *cwd = getcwd(NULL, 0);
-        size_t pref_buf_len = sizeof(pref_buf);
-
-        if (!cwd)
-            abort();
-        pstrcpy(pref_buf, sizeof(pref_buf), cwd);
-        pstrcat(pref_buf, pref_buf_len, "/");
-        pstrcat(pref_buf, pref_buf_len, prefix);
-        free(cwd);
-    } else
-        pstrcpy(pref_buf, sizeof(pref_buf), prefix + 1);
-
-    base = new_entry("", NULL, pref_buf);
-    base = add_dir_maybe(base);
-    if (base->num_entries == 0) {
-        g_free(base->pathname);
-        g_free(base->name);
-        g_free(base);
-        base = NULL;
-    } else {
-        set_parents(base, base);
-    }
-}
-
-/* Look for path in emulation dir, otherwise return name. */
-const char *path(const char *name)
-{
-    /* Only do absolute paths: quick and dirty, but should mostly be OK.
-       Could do relative by tracking cwd. */
-    if (!base || !name || name[0] != '/')
-        return name;
-
-    return follow_path(base, name) ?: name;
-}
-- 
2.9.3

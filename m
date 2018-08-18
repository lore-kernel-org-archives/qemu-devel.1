Received: from eggs.gnu.org ([2001:4830:134:3::10]:55322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6To-0005N5-Gp
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6Tm-0007Gx-Ul
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:44 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fr6Tm-0007GW-NC
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:42 -0400
Received: by mail-pg1-x543.google.com with SMTP id r64-v6so3780013pgr.0
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 12:01:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 18 Aug 2018 12:01:15 -0700
Message-Id: <20180818190118.12911-14-richard.henderson@linaro.org>
In-Reply-To: <20180818190118.12911-1-richard.henderson@linaro.org>
References: <20180818190118.12911-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 13/16] linux-user: Split out
 name_to_handle_at, open_by_handle_at
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.h          |   1 +
 linux-user/strace.c           |   5 +-
 linux-user/syscall-file.inc.c |  84 +++++++++++++++++++++++++++
 linux-user/syscall.c          | 104 ++--------------------------------
 linux-user/strace.list        |   3 -
 5 files changed, 95 insertions(+), 102 deletions(-)

diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index 1d4b7ea915..f9a60f754c 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -54,6 +54,7 @@ typedef enum {
 
     /* These print as sets of flags.  */
     ARG_ATDIRFD,
+    ARG_ATFLAG,
     ARG_MODEFLAG,
     ARG_OPENFLAG,
 
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 11e0c86554..6d63374c1b 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -780,7 +780,7 @@ UNUSED static struct flags access_flags[] = {
     FLAG_END,
 };
 
-UNUSED static struct flags at_file_flags[] = {
+static struct flags const at_file_flags[] = {
 #ifdef AT_EACCESS
     FLAG_GENERIC(AT_EACCESS),
 #endif
@@ -2676,6 +2676,9 @@ static void print_syscall_def1(const SyscallDef *def, int64_t args[6])
         case ARG_ATDIRFD:
             len = add_atdirfd(b, rest, arg);
             break;
+        case ARG_ATFLAG:
+            len = add_flags(b, rest, at_file_flags, arg, false);
+            break;
         case ARG_MODEFLAG:
             len = add_flags(b, rest, mode_flags, arg, true);
             break;
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index c75c5dea9e..2c984af4cb 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -323,6 +323,90 @@ SYSCALL_IMPL(openat)
 }
 SYSCALL_DEF(openat, ARG_ATDIRFD, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 
+SYSCALL_IMPL(name_to_handle_at)
+{
+    struct file_handle *target_fh;
+    struct file_handle *fh;
+    int mid = 0;
+    abi_long ret;
+    char *name;
+    uint32_t size, total_size;
+
+    if (get_user_s32(size, arg3)) {
+        return -TARGET_EFAULT;
+    }
+    total_size = sizeof(struct file_handle) + size;
+    target_fh = lock_user(VERIFY_WRITE, arg3, total_size, 0);
+    if (!target_fh) {
+        return -TARGET_EFAULT;
+    }
+
+    name = lock_user_string(arg2);
+    if (!name) {
+        unlock_user(target_fh, arg3, 0);
+        return -TARGET_EFAULT;
+    }
+
+
+    fh = g_malloc0(total_size);
+    fh->handle_bytes = size;
+
+    ret = get_errno(safe_name_to_handle_at(arg1, path(name), fh, &mid, arg5));
+    unlock_user(name, arg2, 0);
+
+    /* man name_to_handle_at(2):
+     * Other than the use of the handle_bytes field, the caller should treat
+     * the file_handle structure as an opaque data type
+     */
+    if (!is_error(ret)) {
+        memcpy(target_fh, fh, total_size);
+        target_fh->handle_bytes = tswap32(fh->handle_bytes);
+        target_fh->handle_type = tswap32(fh->handle_type);
+        g_free(fh);
+        unlock_user(target_fh, arg3, total_size);
+
+        if (put_user_s32(mid, arg4)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+SYSCALL_DEF(name_to_handle_at,
+            ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_PTR, ARG_ATFLAG);
+
+SYSCALL_IMPL(open_by_handle_at)
+{
+    abi_long mount_fd = arg1;
+    abi_long handle = arg2;
+    int host_flags = target_to_host_bitmask(arg3, fcntl_flags_tbl);
+    struct file_handle *target_fh;
+    struct file_handle *fh;
+    unsigned int size, total_size;
+    abi_long ret;
+
+    if (get_user_s32(size, handle)) {
+        return -TARGET_EFAULT;
+    }
+    total_size = sizeof(struct file_handle) + size;
+    target_fh = lock_user(VERIFY_READ, handle, total_size, 1);
+    if (!target_fh) {
+        return -TARGET_EFAULT;
+    }
+
+    fh = g_memdup(target_fh, total_size);
+    fh->handle_bytes = size;
+    fh->handle_type = tswap32(target_fh->handle_type);
+
+    ret = get_errno(safe_open_by_handle_at(mount_fd, fh, host_flags));
+
+    g_free(fh);
+    unlock_user(target_fh, handle, total_size);
+
+    fd_trans_unregister(ret);
+    return ret;
+}
+SYSCALL_DEF(open_by_handle_at, ARG_DEC, ARG_PTR, ARG_OPENFLAG);
+
 /*
  * Both pread64 and pwrite64 merge args into a 64-bit offset,
  * but the input registers and ordering are target specific.
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index eb6c8465b7..c9c9669ae2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1027,6 +1027,10 @@ safe_syscall5(int, mq_timedsend, int, mqdes, const char *, msg_ptr,
 safe_syscall5(int, mq_timedreceive, int, mqdes, char *, msg_ptr,
               size_t, len, unsigned *, prio, const struct timespec *, timeout)
 #endif
+safe_syscall5(int, name_to_handle_at, int, dirfd, const char *, pathname,
+              struct file_handle *, handle, int *, mount_id, int, flags)
+safe_syscall3(int, open_by_handle_at, int, mount_fd,
+              struct file_handle *, handle, int, flags)
 /* We do ioctl like this rather than via safe_syscall3 to preserve the
  * "third argument might be integer or pointer or not present" behaviour of
  * the libc function.
@@ -7336,93 +7340,6 @@ static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
         return -TARGET_ENOSYS;
     }
 }
-#if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
-static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
-                                     abi_long handle, abi_long mount_id,
-                                     abi_long flags)
-{
-    struct file_handle *target_fh;
-    struct file_handle *fh;
-    int mid = 0;
-    abi_long ret;
-    char *name;
-    unsigned int size, total_size;
-
-    if (get_user_s32(size, handle)) {
-        return -TARGET_EFAULT;
-    }
-
-    name = lock_user_string(pathname);
-    if (!name) {
-        return -TARGET_EFAULT;
-    }
-
-    total_size = sizeof(struct file_handle) + size;
-    target_fh = lock_user(VERIFY_WRITE, handle, total_size, 0);
-    if (!target_fh) {
-        unlock_user(name, pathname, 0);
-        return -TARGET_EFAULT;
-    }
-
-    fh = g_malloc0(total_size);
-    fh->handle_bytes = size;
-
-    ret = get_errno(name_to_handle_at(dirfd, path(name), fh, &mid, flags));
-    unlock_user(name, pathname, 0);
-
-    /* man name_to_handle_at(2):
-     * Other than the use of the handle_bytes field, the caller should treat
-     * the file_handle structure as an opaque data type
-     */
-
-    memcpy(target_fh, fh, total_size);
-    target_fh->handle_bytes = tswap32(fh->handle_bytes);
-    target_fh->handle_type = tswap32(fh->handle_type);
-    g_free(fh);
-    unlock_user(target_fh, handle, total_size);
-
-    if (put_user_s32(mid, mount_id)) {
-        return -TARGET_EFAULT;
-    }
-
-    return ret;
-
-}
-#endif
-
-#if defined(TARGET_NR_open_by_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
-static abi_long do_open_by_handle_at(abi_long mount_fd, abi_long handle,
-                                     abi_long flags)
-{
-    struct file_handle *target_fh;
-    struct file_handle *fh;
-    unsigned int size, total_size;
-    abi_long ret;
-
-    if (get_user_s32(size, handle)) {
-        return -TARGET_EFAULT;
-    }
-
-    total_size = sizeof(struct file_handle) + size;
-    target_fh = lock_user(VERIFY_READ, handle, total_size, 1);
-    if (!target_fh) {
-        return -TARGET_EFAULT;
-    }
-
-    fh = g_memdup(target_fh, total_size);
-    fh->handle_bytes = size;
-    fh->handle_type = tswap32(target_fh->handle_type);
-
-    ret = get_errno(open_by_handle_at(mount_fd, fh,
-                    target_to_host_bitmask(flags, fcntl_flags_tbl)));
-
-    g_free(fh);
-
-    unlock_user(target_fh, handle, total_size);
-
-    return ret;
-}
-#endif
 
 #if defined(TARGET_NR_signalfd) || defined(TARGET_NR_signalfd4)
 
@@ -7722,17 +7639,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         preexit_cleanup(cpu_env, arg1);
         _exit(arg1);
         return 0; /* avoid warning */
-#if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
-    case TARGET_NR_name_to_handle_at:
-        ret = do_name_to_handle_at(arg1, arg2, arg3, arg4, arg5);
-        return ret;
-#endif
-#if defined(TARGET_NR_open_by_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
-    case TARGET_NR_open_by_handle_at:
-        ret = do_open_by_handle_at(arg1, arg2, arg3);
-        fd_trans_unregister(ret);
-        return ret;
-#endif
     case TARGET_NR_brk:
         return do_brk(arg1);
 #ifdef TARGET_NR_fork
@@ -11983,7 +11889,9 @@ static const SyscallDef *syscall_table(int num)
      * Unconditional syscalls.
      */
     S(close);
+    S(name_to_handle_at);
     S(openat);
+    S(open_by_handle_at);
     S(preadv);
     S(pwritev);
     S(read);
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 586eb55482..26ad95dc7e 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -635,9 +635,6 @@
 #ifdef TARGET_NR_munmap
 { TARGET_NR_munmap, "munmap" , NULL, print_munmap, NULL },
 #endif
-#ifdef TARGET_NR_name_to_handle_at
-{ TARGET_NR_name_to_handle_at, "name_to_handle_at" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_nanosleep
 { TARGET_NR_nanosleep, "nanosleep" , NULL, NULL, NULL },
 #endif
-- 
2.17.1

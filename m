Received: from eggs.gnu.org ([2001:4830:134:3::10]:41416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfm-0004R1-Hz
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfl-0004gv-22
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:42 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:47037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfk-0004gp-QF
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:40 -0400
Received: by mail-pg0-x243.google.com with SMTP id d2-v6so8130646pga.13
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:02:06 -1000
Message-Id: <20180610030220.3777-95-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 094/108] linux-user: Split out inotify
 syscalls
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

This includes inotify_add_watch, inotify_init, inotify_init1,
and inotify_rm_watch.  At the same time, merge in the useless
wrappers around the libc functions.  If host inotify_init1 is
not available, use inotify_init if flags == 0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 139 ++++++++++++++++++++-----------------------
 1 file changed, 65 insertions(+), 74 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 95b30adea2..a540c1455b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -74,6 +74,9 @@
 #ifdef CONFIG_SENDFILE
 #include <sys/sendfile.h>
 #endif
+#ifdef CONFIG_INOTIFY
+#include <sys/inotify.h>
+#endif
 
 #define termios host_termios
 #define winsize host_winsize
@@ -235,9 +238,6 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #define __NR_sys_rt_sigqueueinfo __NR_rt_sigqueueinfo
 #define __NR_sys_rt_tgsigqueueinfo __NR_rt_tgsigqueueinfo
 #define __NR_sys_syslog __NR_syslog
-#define __NR_sys_inotify_init __NR_inotify_init
-#define __NR_sys_inotify_add_watch __NR_inotify_add_watch
-#define __NR_sys_inotify_rm_watch __NR_inotify_rm_watch
 
 /* These definitions produce an ENOSYS from the host kernel.
  * Performing a bogus syscall is lazier than boilerplating
@@ -626,43 +626,6 @@ static int sys_renameat2(int oldfd, const char *old,
 }
 #endif
 
-#ifdef CONFIG_INOTIFY
-#include <sys/inotify.h>
-
-#if defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)
-static int sys_inotify_init(void)
-{
-  return (inotify_init());
-}
-#endif
-#if defined(TARGET_NR_inotify_add_watch) && defined(__NR_inotify_add_watch)
-static int sys_inotify_add_watch(int fd,const char *pathname, int32_t mask)
-{
-  return (inotify_add_watch(fd, pathname, mask));
-}
-#endif
-#if defined(TARGET_NR_inotify_rm_watch) && defined(__NR_inotify_rm_watch)
-static int sys_inotify_rm_watch(int fd, int32_t wd)
-{
-  return (inotify_rm_watch(fd, wd));
-}
-#endif
-#ifdef CONFIG_INOTIFY1
-#if defined(TARGET_NR_inotify_init1) && defined(__NR_inotify_init1)
-static int sys_inotify_init1(int flags)
-{
-  return (inotify_init1(flags));
-}
-#endif
-#endif
-#else
-/* Userspace can usually survive runtime without inotify */
-#undef TARGET_NR_inotify_init
-#undef TARGET_NR_inotify_init1
-#undef TARGET_NR_inotify_add_watch
-#undef TARGET_NR_inotify_rm_watch
-#endif /* CONFIG_INOTIFY  */
-
 #if defined(TARGET_NR_prlimit64)
 #ifndef __NR_prlimit64
 # define __NR_prlimit64 -1
@@ -7421,9 +7384,7 @@ static TargetFdTrans target_eventfd_trans = {
     .target_to_host_data = swap_data_eventfd,
 };
 
-#if (defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)) || \
-    (defined(CONFIG_INOTIFY1) && defined(TARGET_NR_inotify_init1) && \
-     defined(__NR_inotify_init1))
+#ifdef CONFIG_INOTIFY
 static abi_long host_to_target_data_inotify(void *buf, size_t len)
 {
     struct inotify_event *ev;
@@ -9177,6 +9138,59 @@ IMPL(getxuid)
 }
 #endif
 
+#ifdef CONFIG_INOTIFY
+IMPL(inotify_add_watch)
+{
+    char *p;
+    abi_long ret;
+
+    p = lock_user_string(arg2);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(inotify_add_watch(arg1, path(p), arg3));
+    unlock_user(p, arg2, 0);
+    return ret;
+}
+
+# ifdef TARGET_NR_inotify_init
+IMPL(inotify_init)
+{
+    abi_long ret = get_errno(inotify_init());
+    if (!is_error(ret)) {
+        fd_trans_register(ret, &target_inotify_trans);
+    }
+    return ret;
+}
+# endif
+
+IMPL(inotify_init1)
+{
+    int flags = target_to_host_bitmask(arg1, fcntl_flags_tbl);
+    abi_long ret;
+
+# ifdef CONFIG_INOTIFY1
+    ret = inotify_init1(flags);
+# else
+    if (arg1 == 0) {
+        ret = inotify_init();
+    } else {
+        return -TARGET_ENOSYS;
+    }
+# endif
+    ret = get_errno(ret);
+    if (!is_error(ret)) {
+        fd_trans_register(ret, &target_inotify_trans);
+    }
+    return ret;
+}
+
+IMPL(inotify_rm_watch)
+{
+    return get_errno(inotify_rm_watch(arg1, arg2));
+}
+#endif /* CONFIG_INOTIFY */
+
 /* ??? Implement proper locking for ioctls.  */
 IMPL(ioctl)
 {
@@ -12598,37 +12612,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#if defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)
-    case TARGET_NR_inotify_init:
-        ret = get_errno(sys_inotify_init());
-        if (ret >= 0) {
-            fd_trans_register(ret, &target_inotify_trans);
-        }
-        return ret;
-#endif
-#ifdef CONFIG_INOTIFY1
-#if defined(TARGET_NR_inotify_init1) && defined(__NR_inotify_init1)
-    case TARGET_NR_inotify_init1:
-        ret = get_errno(sys_inotify_init1(target_to_host_bitmask(arg1,
-                                          fcntl_flags_tbl)));
-        if (ret >= 0) {
-            fd_trans_register(ret, &target_inotify_trans);
-        }
-        return ret;
-#endif
-#endif
-#if defined(TARGET_NR_inotify_add_watch) && defined(__NR_inotify_add_watch)
-    case TARGET_NR_inotify_add_watch:
-        p = lock_user_string(arg2);
-        ret = get_errno(sys_inotify_add_watch(arg1, path(p), arg3));
-        unlock_user(p, arg2, 0);
-        return ret;
-#endif
-#if defined(TARGET_NR_inotify_rm_watch) && defined(__NR_inotify_rm_watch)
-    case TARGET_NR_inotify_rm_watch:
-        return get_errno(sys_inotify_rm_watch(arg1, arg2));
-#endif
-
 #if defined(TARGET_NR_mq_open) && defined(__NR_mq_open)
     case TARGET_NR_mq_open:
         {
@@ -13481,6 +13464,14 @@ static impl_fn *syscall_table(unsigned num)
 #endif
 #if defined(TARGET_NR_getxuid) && defined(TARGET_ALPHA)
         SYSCALL(getxuid);
+#endif
+#ifdef CONFIG_INOTIFY
+        SYSCALL(inotify_add_watch);
+# ifdef TARGET_NR_inotify_init
+        SYSCALL(inotify_init);
+# endif
+        SYSCALL(inotify_init1);
+        SYSCALL(inotify_rm_watch);
 #endif
         SYSCALL(ioctl);
 #ifdef TARGET_NR_ipc
-- 
2.17.1

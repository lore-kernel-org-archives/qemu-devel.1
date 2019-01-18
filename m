Received: from eggs.gnu.org ([209.51.188.92]:56109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkh-0005Oo-M3
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkg-0004xv-N7
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:35 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbkg-0004xP-HH
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:34 -0500
Received: by mail-pg1-x544.google.com with SMTP id c25so6649801pgb.4
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:01 +1100
Message-Id: <20190118213122.22865-28-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 28/49] linux-user: Split out mknod, mknodat
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

Note that mknodat is universally provided.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  4 ++++
 linux-user/strace.c           | 39 -----------------------------------
 linux-user/syscall-file.inc.c | 26 +++++++++++++++++++++++
 linux-user/syscall.c          | 16 --------------
 linux-user/strace.list        |  6 ------
 5 files changed, 30 insertions(+), 61 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 9950b73e76..b5951e6911 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -38,6 +38,10 @@ SYSCALL_DEF_ARGS(ipc, ARG_HEX, ARG_DEC, ARG_DEC, ARG_HEX, ARG_PTR, ARG_HEX);
 SYSCALL_DEF(link, ARG_STR, ARG_STR);
 #endif
 SYSCALL_DEF(linkat, ARG_ATDIRFD, ARG_STR, ARG_ATDIRFD, ARG_STR, ARG_ATFLAG);
+#ifdef TARGET_NR_mknod
+SYSCALL_DEF(mknod, ARG_STR, ARG_MODEFLAG, ARG_HEX);
+#endif
+SYSCALL_DEF(mknodat, ARG_ATDIRFD, ARG_STR, ARG_MODEFLAG, ARG_HEX);
 SYSCALL_DEF(mlock, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(mlockall, ARG_HEX);
 #ifdef TARGET_NR_mmap
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 5133998c4f..668e6a4759 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1911,45 +1911,6 @@ print_syslog(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_mknod
-static void
-print_mknod(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    int hasdev = (arg1 & (S_IFCHR|S_IFBLK));
-
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_file_mode(arg1, (hasdev == 0));
-    if (hasdev) {
-        print_raw_param("makedev(%d", major(arg2), 0);
-        print_raw_param("%d)", minor(arg2), 1);
-    }
-    print_syscall_epilogue(name);
-}
-#endif
-
-#ifdef TARGET_NR_mknodat
-static void
-print_mknodat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    int hasdev = (arg2 & (S_IFCHR|S_IFBLK));
-
-    print_syscall_prologue(name);
-    print_at_dirfd(arg0, 0);
-    print_string(arg1, 0);
-    print_file_mode(arg2, (hasdev == 0));
-    if (hasdev) {
-        print_raw_param("makedev(%d", major(arg3), 0);
-        print_raw_param("%d)", minor(arg3), 1);
-    }
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_mq_open
 static void
 print_mq_open(const struct syscallname *name,
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 7a4751d460..3b5a79fe74 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -82,6 +82,32 @@ SYSCALL_IMPL(linkat)
     return do_linkat(arg1, arg2, arg3, arg4, arg5);
 }
 
+static abi_long do_mknodat(int dirfd, abi_ulong target_path,
+                           mode_t mode, dev_t dev)
+{
+    char *p = lock_user_string(target_path);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(mknodat(dirfd, p, mode, dev));
+    unlock_user(p, target_path, 0);
+    return ret;
+}
+
+#ifdef TARGET_NR_mknod
+SYSCALL_IMPL(mknod)
+{
+    return do_mknodat(AT_FDCWD, arg1, arg2, arg3);
+}
+#endif
+
+SYSCALL_IMPL(mknodat)
+{
+    return do_mknodat(arg1, arg2, arg3, arg4);
+}
+
 /*
  * Helpers for do_openat, manipulating /proc/self/foo.
  */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index cc5360ae43..d46b4df677 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5331,22 +5331,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_mknod
-    case TARGET_NR_mknod:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(mknod(p, arg2, arg3));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-#if defined(TARGET_NR_mknodat)
-    case TARGET_NR_mknodat:
-        if (!(p = lock_user_string(arg2)))
-            return -TARGET_EFAULT;
-        ret = get_errno(mknodat(arg1, p, arg3, arg4));
-        unlock_user(p, arg2, 0);
-        return ret;
-#endif
 #ifdef TARGET_NR_chmod
     case TARGET_NR_chmod:
         if (!(p = lock_user_string(arg1)))
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 3505014501..adf8955278 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -518,12 +518,6 @@
 #ifdef TARGET_NR_mkdirat
 { TARGET_NR_mkdirat, "mkdirat" , NULL, print_mkdirat, NULL },
 #endif
-#ifdef TARGET_NR_mknod
-{ TARGET_NR_mknod, "mknod" , NULL, print_mknod, NULL },
-#endif
-#ifdef TARGET_NR_mknodat
-{ TARGET_NR_mknodat, "mknodat" , NULL, print_mknodat, NULL },
-#endif
 #ifdef TARGET_NR_modify_ldt
 { TARGET_NR_modify_ldt, "modify_ldt" , NULL, NULL, NULL },
 #endif
-- 
2.17.2

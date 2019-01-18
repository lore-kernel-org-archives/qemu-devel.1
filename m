Received: from eggs.gnu.org ([209.51.188.92]:56417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkblD-0005mr-QT
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkblC-0005Xn-Qj
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:07 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkblC-0005Wg-KW
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:06 -0500
Received: by mail-pl1-x642.google.com with SMTP id y1so6881261plp.9
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:33:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:15 +1100
Message-Id: <20190118213122.22865-42-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 42/49] linux-user: Split out mkdir, mkdirat
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

Note that mkdirat is universally available.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  4 ++++
 linux-user/strace.c           | 27 ---------------------------
 linux-user/syscall-file.inc.c | 25 +++++++++++++++++++++++++
 linux-user/syscall.c          | 16 ----------------
 linux-user/strace.list        |  6 ------
 5 files changed, 29 insertions(+), 49 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 0ed01aa100..8b6d8f75ff 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -69,6 +69,10 @@ SYSCALL_DEF(lseek, ARG_DEC, ARG_DEC, ARG_LSEEKWHENCE);
 #ifdef TARGET_NR_llseek
 SYSCALL_DEF_ARGS(llseek, ARG_DEC, ARG_DEC, ARG_PTR, ARG_LSEEKWHENCE);
 #endif
+#ifdef TARGET_NR_mkdir
+SYSCALL_DEF(mkdir, ARG_STR, ARG_MODEFLAG);
+#endif
+SYSCALL_DEF(mkdirat, ARG_ATDIRFD, ARG_STR, ARG_MODEFLAG);
 #ifdef TARGET_NR_mknod
 SYSCALL_DEF(mknod, ARG_STR, ARG_MODEFLAG, ARG_HEX);
 #endif
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 6dce7e52c0..ca8e110675 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1664,33 +1664,6 @@ print_fstat(const struct syscallname *name,
 #define print_fstat64     print_fstat
 #endif
 
-#ifdef TARGET_NR_mkdir
-static void
-print_mkdir(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_file_mode(arg1, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
-#ifdef TARGET_NR_mkdirat
-static void
-print_mkdirat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_at_dirfd(arg0, 0);
-    print_string(arg1, 0);
-    print_file_mode(arg2, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_rt_sigaction
 static void
 print_rt_sigaction(const struct syscallname *name,
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 9099107631..83174c5781 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -205,6 +205,31 @@ SYSCALL_IMPL(llseek)
 }
 #endif
 
+static abi_long do_mkdirat(int dirfd, abi_ulong target_path, mode_t mode)
+{
+    char *p = lock_user_string(target_path);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(mkdirat(dirfd, p, mode));
+    unlock_user(p, target_path, 0);
+    return ret;
+}
+
+#ifdef TARGET_NR_mkdir
+SYSCALL_IMPL(mkdir)
+{
+    return do_mkdirat(AT_FDCWD, arg1, arg2);
+}
+#endif
+
+SYSCALL_IMPL(mkdirat)
+{
+    return do_mkdirat(arg1, arg2, arg3);
+}
+
 static abi_long do_mknodat(int dirfd, abi_ulong target_path,
                            mode_t mode, dev_t dev)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fe38ec59d4..7874a48840 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5320,22 +5320,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_mkdir
-    case TARGET_NR_mkdir:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(mkdir(p, arg2));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-#if defined(TARGET_NR_mkdirat)
-    case TARGET_NR_mkdirat:
-        if (!(p = lock_user_string(arg2)))
-            return -TARGET_EFAULT;
-        ret = get_errno(mkdirat(arg1, p, arg3));
-        unlock_user(p, arg2, 0);
-        return ret;
-#endif
     case TARGET_NR_dup:
         ret = get_errno(dup(arg1));
         if (ret >= 0) {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 56aab25d9f..678feeeb7b 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -473,12 +473,6 @@
 #ifdef TARGET_NR_mincore
 { TARGET_NR_mincore, "mincore" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_mkdir
-{ TARGET_NR_mkdir, "mkdir" , NULL, print_mkdir, NULL },
-#endif
-#ifdef TARGET_NR_mkdirat
-{ TARGET_NR_mkdirat, "mkdirat" , NULL, print_mkdirat, NULL },
-#endif
 #ifdef TARGET_NR_modify_ldt
 { TARGET_NR_modify_ldt, "modify_ldt" , NULL, NULL, NULL },
 #endif
-- 
2.17.2

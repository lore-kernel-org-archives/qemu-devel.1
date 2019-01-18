Received: from eggs.gnu.org ([209.51.188.92]:56147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkn-0005Sk-Jn
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkl-000528-Pi
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:41 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbkj-0004zL-SC
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:39 -0500
Received: by mail-pl1-x642.google.com with SMTP id u18so6885895plq.7
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:02 +1100
Message-Id: <20190118213122.22865-29-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 29/49] linux-user: Split out chmod, fchmod,
 fchmodat
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

Note that fchmodat is universally provided.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  5 +++++
 linux-user/strace.c           | 28 ----------------------------
 linux-user/syscall-file.inc.c | 30 ++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 18 ------------------
 linux-user/strace.list        |  9 ---------
 5 files changed, 35 insertions(+), 55 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index b5951e6911..3ddf8aa0e3 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -20,6 +20,9 @@ SYSCALL_DEF_FULL(brk, .impl = impl_brk,
                  .print_ret = print_syscall_ptr_ret,
                  .arg_type = { ARG_PTR });
 SYSCALL_DEF(chdir, ARG_STR);
+#ifdef TARGET_NR_chmod
+SYSCALL_DEF(chmod, ARG_STR, ARG_MODEFLAG);
+#endif
 SYSCALL_DEF_ARGS(clone, ARG_CLONEFLAG, ARG_PTR, ARG_PTR, ARG_PTR, ARG_PTR);
 SYSCALL_DEF(close, ARG_DEC);
 #ifdef TARGET_NR_creat
@@ -28,6 +31,8 @@ SYSCALL_DEF(creat, ARG_STR, ARG_MODEFLAG);
 SYSCALL_DEF(exit, ARG_DEC);
 SYSCALL_DEF(execve, ARG_STR, ARG_PTR, ARG_PTR);
 SYSCALL_DEF(execveat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_PTR, ARG_ATFLAG);
+SYSCALL_DEF(fchmod, ARG_DEC, ARG_MODEFLAG);
+SYSCALL_DEF(fchmodat, ARG_ATDIRFD, ARG_STR, ARG_MODEFLAG);
 #ifdef TARGET_NR_fork
 SYSCALL_DEF(fork);
 #endif
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 668e6a4759..66d981b9e6 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1113,19 +1113,6 @@ print_access(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_chmod
-static void
-print_chmod(const struct syscallname *name,
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
 #ifdef TARGET_NR_clock_adjtime
 static void
 print_clock_adjtime(const struct syscallname *name,
@@ -1167,21 +1154,6 @@ print_faccessat(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_fchmodat
-static void
-print_fchmodat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_at_dirfd(arg0, 0);
-    print_string(arg1, 0);
-    print_file_mode(arg2, 0);
-    print_flags(at_file_flags, arg3, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_fchownat
 static void
 print_fchownat(const struct syscallname *name,
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 3b5a79fe74..9844382166 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -30,6 +30,26 @@ SYSCALL_IMPL(chdir)
     return ret;
 }
 
+static abi_long do_fchmodat(int dirfd, abi_ulong target_path, mode_t mode)
+{
+    char *p = lock_user_string(target_path);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(fchmodat(dirfd, p, mode, 0));
+    unlock_user(p, target_path, 0);
+    return ret;
+}
+
+#ifdef TARGET_NR_chmod
+SYSCALL_IMPL(chmod)
+{
+    return do_fchmodat(AT_FDCWD, arg1, arg2);
+}
+#endif
+
 SYSCALL_IMPL(close)
 {
     int fd = arg1;
@@ -54,6 +74,16 @@ SYSCALL_IMPL(creat)
 }
 #endif
 
+SYSCALL_IMPL(fchmod)
+{
+    return get_errno(fchmod(arg1, arg2));
+}
+
+SYSCALL_IMPL(fchmodat)
+{
+    return do_fchmodat(arg1, arg2, arg3);
+}
+
 static abi_long do_linkat(int olddirfd, abi_ulong target_oldpath,
                           int newdirfd, abi_ulong target_newpath,
                           int flags)
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d46b4df677..f9101d0b08 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5331,14 +5331,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_chmod
-    case TARGET_NR_chmod:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(chmod(p, arg2));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
 #ifdef TARGET_NR_lseek
     case TARGET_NR_lseek:
         return get_errno(lseek(arg1, arg2, arg3));
@@ -6410,16 +6402,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_ftruncate
     case TARGET_NR_ftruncate:
         return get_errno(ftruncate(arg1, arg2));
-#endif
-    case TARGET_NR_fchmod:
-        return get_errno(fchmod(arg1, arg2));
-#if defined(TARGET_NR_fchmodat)
-    case TARGET_NR_fchmodat:
-        if (!(p = lock_user_string(arg2)))
-            return -TARGET_EFAULT;
-        ret = get_errno(fchmodat(arg1, p, arg3, 0));
-        unlock_user(p, arg2, 0);
-        return ret;
 #endif
     case TARGET_NR_getpriority:
         /* Note that negative values are valid for getpriority, so we must
diff --git a/linux-user/strace.list b/linux-user/strace.list
index adf8955278..92a86c682c 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -61,9 +61,6 @@
 #ifdef TARGET_NR_capset
 { TARGET_NR_capset, "capset" , "%s(%p,%p)", NULL, NULL },
 #endif
-#ifdef TARGET_NR_chmod
-{ TARGET_NR_chmod, "chmod" , NULL, print_chmod, NULL },
-#endif
 #ifdef TARGET_NR_chown
 { TARGET_NR_chown, "chown" , NULL, NULL, NULL },
 #endif
@@ -169,12 +166,6 @@
 #ifdef TARGET_NR_fchdir
 { TARGET_NR_fchdir, "fchdir" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_fchmod
-{ TARGET_NR_fchmod, "fchmod" , "%s(%d,%#o)", NULL, NULL },
-#endif
-#ifdef TARGET_NR_fchmodat
-{ TARGET_NR_fchmodat, "fchmodat" , NULL, print_fchmodat, NULL },
-#endif
 #ifdef TARGET_NR_fchown
 { TARGET_NR_fchown, "fchown" , "%s(%d,%d,%d)", NULL, NULL },
 #endif
-- 
2.17.2

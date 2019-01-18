Received: from eggs.gnu.org ([209.51.188.92]:56033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbke-0005Lw-Ag
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkd-0004sc-C7
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:32 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbkb-0004jS-Iw
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:31 -0500
Received: by mail-pg1-x544.google.com with SMTP id t13so6634927pgr.11
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:30:55 +1100
Message-Id: <20190118213122.22865-22-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 22/49] linux-user: Split out link, linkat
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

Note that linkat is universally provided.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  4 ++++
 linux-user/strace.c           | 29 -----------------------------
 linux-user/syscall-file.inc.c | 28 ++++++++++++++++++++++++++++
 linux-user/syscall.c          | 32 --------------------------------
 linux-user/strace.list        |  6 ------
 5 files changed, 32 insertions(+), 67 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index de7a99f0c6..41dd887dbc 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -31,6 +31,10 @@ SYSCALL_DEF(fork);
 #ifdef TARGET_NR_ipc
 SYSCALL_DEF_ARGS(ipc, ARG_HEX, ARG_DEC, ARG_DEC, ARG_HEX, ARG_PTR, ARG_HEX);
 #endif
+#ifdef TARGET_NR_link
+SYSCALL_DEF(link, ARG_STR, ARG_STR);
+#endif
+SYSCALL_DEF(linkat, ARG_ATDIRFD, ARG_STR, ARG_ATDIRFD, ARG_STR, ARG_ATFLAG);
 SYSCALL_DEF(mlock, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(mlockall, ARG_HEX);
 #ifdef TARGET_NR_mmap
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 5cb77223fd..5b78eb137b 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1357,35 +1357,6 @@ print_futimesat(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_link
-static void
-print_link(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_string(arg1, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
-#ifdef TARGET_NR_linkat
-static void
-print_linkat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_at_dirfd(arg0, 0);
-    print_string(arg1, 0);
-    print_at_dirfd(arg2, 0);
-    print_string(arg3, 0);
-    print_flags(at_file_flags, arg4, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR__llseek
 static void
 print__llseek(const struct syscallname *name,
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 62e1790e3b..c6ca80955b 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -40,6 +40,34 @@ SYSCALL_IMPL(creat)
 }
 #endif
 
+static abi_long do_linkat(int olddirfd, abi_ulong target_oldpath,
+                          int newdirfd, abi_ulong target_newpath,
+                          int flags)
+{
+    char *oldpath = lock_user_string(target_oldpath);
+    char *newpath = lock_user_string(target_newpath);
+    abi_long ret = -TARGET_EFAULT;
+
+    if (oldpath && newpath) {
+        ret = get_errno(linkat(olddirfd, oldpath, newdirfd, newpath, flags));
+    }
+    unlock_user(oldpath, target_oldpath, 0);
+    unlock_user(newpath, target_newpath, 0);
+    return ret;
+}
+
+#ifdef TARGET_NR_link
+SYSCALL_IMPL(link)
+{
+    return do_linkat(AT_FDCWD, arg1, AT_FDCWD, arg2, 0);
+}
+#endif
+
+SYSCALL_IMPL(linkat)
+{
+    return do_linkat(arg1, arg2, arg3, arg4, arg5);
+}
+
 /*
  * Helpers for do_openat, manipulating /proc/self/foo.
  */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1e9478611c..f1e8d06996 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5330,38 +5330,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_link
-    case TARGET_NR_link:
-        {
-            void * p2;
-            p = lock_user_string(arg1);
-            p2 = lock_user_string(arg2);
-            if (!p || !p2)
-                ret = -TARGET_EFAULT;
-            else
-                ret = get_errno(link(p, p2));
-            unlock_user(p2, arg2, 0);
-            unlock_user(p, arg1, 0);
-        }
-        return ret;
-#endif
-#if defined(TARGET_NR_linkat)
-    case TARGET_NR_linkat:
-        {
-            void * p2 = NULL;
-            if (!arg2 || !arg4)
-                return -TARGET_EFAULT;
-            p  = lock_user_string(arg2);
-            p2 = lock_user_string(arg4);
-            if (!p || !p2)
-                ret = -TARGET_EFAULT;
-            else
-                ret = get_errno(linkat(arg1, p, arg3, p2, arg5));
-            unlock_user(p, arg2, 0);
-            unlock_user(p2, arg4, 0);
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_unlink
     case TARGET_NR_unlink:
         if (!(p = lock_user_string(arg1)))
diff --git a/linux-user/strace.list b/linux-user/strace.list
index be0392810c..c369915759 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -461,12 +461,6 @@
 #ifdef TARGET_NR_lgetxattr
 { TARGET_NR_lgetxattr, "lgetxattr" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_link
-{ TARGET_NR_link, "link" , NULL, print_link, NULL },
-#endif
-#ifdef TARGET_NR_linkat
-{ TARGET_NR_linkat, "linkat" , NULL, print_linkat, NULL },
-#endif
 #ifdef TARGET_NR_Linux
 { TARGET_NR_Linux, "Linux" , NULL, NULL, NULL },
 #endif
-- 
2.17.2

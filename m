Received: from eggs.gnu.org ([209.51.188.92]:56001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkd-0005Kt-Ad
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbkb-0004ql-CF
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:31 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbkZ-0004iA-Nq
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:32:28 -0500
Received: by mail-pg1-x544.google.com with SMTP id n2so6649960pgm.3
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:32:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:30:54 +1100
Message-Id: <20190118213122.22865-21-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 21/49] linux-user: Split out creat
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
 linux-user/syscall-defs.h     |  3 +++
 linux-user/strace.c           | 13 -------------
 linux-user/syscall-file.inc.c | 16 ++++++++++++++++
 linux-user/syscall.c          |  9 ---------
 linux-user/strace.list        |  3 ---
 5 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index f099d98fa3..de7a99f0c6 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -21,6 +21,9 @@ SYSCALL_DEF_FULL(brk, .impl = impl_brk,
                  .arg_type = { ARG_PTR });
 SYSCALL_DEF_ARGS(clone, ARG_CLONEFLAG, ARG_PTR, ARG_PTR, ARG_PTR, ARG_PTR);
 SYSCALL_DEF(close, ARG_DEC);
+#ifdef TARGET_NR_creat
+SYSCALL_DEF(creat, ARG_STR, ARG_MODEFLAG);
+#endif
 SYSCALL_DEF(exit, ARG_DEC);
 #ifdef TARGET_NR_fork
 SYSCALL_DEF(fork);
diff --git a/linux-user/strace.c b/linux-user/strace.c
index d7847e7cd6..5cb77223fd 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1183,19 +1183,6 @@ print_clock_adjtime(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_creat
-static void
-print_creat(const struct syscallname *name,
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
 #ifdef TARGET_NR_execv
 static void
 print_execv(const struct syscallname *name,
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 81423cfd64..62e1790e3b 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -24,6 +24,22 @@ SYSCALL_IMPL(close)
     return get_errno(close(fd));
 }
 
+#ifdef TARGET_NR_creat
+SYSCALL_IMPL(creat)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(creat(p, arg2));
+    fd_trans_unregister(ret);
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+#endif
+
 /*
  * Helpers for do_openat, manipulating /proc/self/foo.
  */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8da92dd188..1e9478611c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5330,15 +5330,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_creat /* not on alpha */
-    case TARGET_NR_creat:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(creat(p, arg2));
-        fd_trans_unregister(ret);
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
 #ifdef TARGET_NR_link
     case TARGET_NR_link:
         {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index afa1521e2d..be0392810c 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -94,9 +94,6 @@
 #ifdef TARGET_NR_connect
 { TARGET_NR_connect, "connect" , "%s(%d,%#x,%d)", NULL, NULL },
 #endif
-#ifdef TARGET_NR_creat
-{ TARGET_NR_creat, "creat" , NULL, print_creat, NULL },
-#endif
 #ifdef TARGET_NR_create_module
 { TARGET_NR_create_module, "create_module" , NULL, NULL, NULL },
 #endif
-- 
2.17.2

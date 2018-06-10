Received: from eggs.gnu.org ([2001:4830:134:3::10]:41059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqex-0003cy-PF
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqew-00044M-OR
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:51 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqew-00043V-Hz
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:50 -0400
Received: by mail-pf0-x241.google.com with SMTP id a12-v6so8499528pfi.3
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:39 -1000
Message-Id: <20180610030220.3777-68-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 067/108] linux-user: Split out getcwd,
 pread64, pwrite64, sigaltstack
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

All targets define pread64 and pwrite64; remove the ifdefs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 88 ++++++++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 32 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e3765069ab..1e1ac8defd 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8161,6 +8161,19 @@ IMPL(getcpu)
     return ret;
 }
 
+IMPL(getcwd)
+{
+    char *p = lock_user(VERIFY_WRITE, arg1, arg2, 0);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(sys_getcwd1(p, arg2));
+    unlock_user(p, arg1, ret);
+    return ret;
+}
+
 #ifdef TARGET_NR_getdents
 IMPL(getdents)
 {
@@ -9359,6 +9372,23 @@ IMPL(prctl)
     }
 }
 
+IMPL(pread64)
+{
+    void *p = lock_user(VERIFY_WRITE, arg2, arg3, 0);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    if (regpairs_aligned(cpu_env, TARGET_NR_pread64)) {
+        arg4 = arg5;
+        arg5 = arg6;
+    }
+    ret = get_errno(pread64(arg1, p, arg3, target_offset64(arg4, arg5)));
+    unlock_user(p, arg2, ret);
+    return ret;
+}
+
 IMPL(preadv)
 {
     struct iovec *vec;
@@ -9478,6 +9508,23 @@ IMPL(pselect6)
     return ret;
 }
 
+IMPL(pwrite64)
+{
+    void *p = lock_user(VERIFY_READ, arg2, arg3, 1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    if (regpairs_aligned(cpu_env, TARGET_NR_pwrite64)) {
+        arg4 = arg5;
+        arg5 = arg6;
+    }
+    ret = get_errno(pwrite64(arg1, p, arg3, target_offset64(arg4, arg5)));
+    unlock_user(p, arg2, 0);
+    return ret;
+}
+
 IMPL(pwritev)
 {
     struct iovec *vec;
@@ -10359,6 +10406,11 @@ IMPL(sigaction)
 }
 #endif
 
+IMPL(sigaltstack)
+{
+    return do_sigaltstack(arg1, arg2, get_sp_from_cpustate(cpu_env));
+}
+
 #ifdef TARGET_NR_sigpending
 IMPL(sigpending)
 {
@@ -11129,34 +11181,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_pread64
-    case TARGET_NR_pread64:
-        if (regpairs_aligned(cpu_env, num)) {
-            arg4 = arg5;
-            arg5 = arg6;
-        }
-        if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
-            return -TARGET_EFAULT;
-        ret = get_errno(pread64(arg1, p, arg3, target_offset64(arg4, arg5)));
-        unlock_user(p, arg2, ret);
-        return ret;
-    case TARGET_NR_pwrite64:
-        if (regpairs_aligned(cpu_env, num)) {
-            arg4 = arg5;
-            arg5 = arg6;
-        }
-        if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(pwrite64(arg1, p, arg3, target_offset64(arg4, arg5)));
-        unlock_user(p, arg2, 0);
-        return ret;
-#endif
-    case TARGET_NR_getcwd:
-        if (!(p = lock_user(VERIFY_WRITE, arg1, arg2, 0)))
-            return -TARGET_EFAULT;
-        ret = get_errno(sys_getcwd1(p, arg2));
-        unlock_user(p, arg1, ret);
-        return ret;
     case TARGET_NR_capget:
     case TARGET_NR_capset:
     {
@@ -11227,10 +11251,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
         }
         return ret;
     }
-    case TARGET_NR_sigaltstack:
-        return do_sigaltstack(arg1, arg2,
-                              get_sp_from_cpustate((CPUArchState *)cpu_env));
-
 #ifdef CONFIG_SENDFILE
     case TARGET_NR_sendfile:
     {
@@ -13022,6 +13042,7 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(futimesat);
 #endif
         SYSCALL(getcpu);
+        SYSCALL(getcwd);
 #ifdef TARGET_NR_getdents
         SYSCALL(getdents);
 #endif
@@ -13144,8 +13165,10 @@ static impl_fn *syscall_table(unsigned num)
 #endif
         SYSCALL(ppoll);
         SYSCALL(prctl);
+        SYSCALL(pread64);
         SYSCALL(preadv);
         SYSCALL(pselect6);
+        SYSCALL(pwrite64);
         SYSCALL(pwritev);
         SYSCALL(read);
 #ifdef TARGET_NR_readlink
@@ -13254,6 +13277,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_sigaction
         SYSCALL(sigaction);
 #endif
+        SYSCALL(sigaltstack);
 #ifdef TARGET_NR_sigpending
         SYSCALL(sigpending);
 #endif
-- 
2.17.1

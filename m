Received: from eggs.gnu.org ([2001:4830:134:3::10]:40500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdm-0002Tl-Fx
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdl-0003Wy-Al
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:38 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:40843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqdl-0003Wg-2d
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:37 -0400
Received: by mail-pg0-x243.google.com with SMTP id l2-v6so8127521pgc.7
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:04 -1000
Message-Id: <20180610030220.3777-33-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 032/108] linux-user: Split out
 rt_sigqueueinfo, rt_sigtimedwait, rt_tgsigqueueinfo
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
 linux-user/syscall.c | 129 ++++++++++++++++++++++---------------------
 1 file changed, 67 insertions(+), 62 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6869a0db47..94dc773b4c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8768,6 +8768,20 @@ IMPL(rt_sigprocmask)
     return ret;
 }
 
+IMPL(rt_sigqueueinfo)
+{
+    siginfo_t uinfo;
+    target_siginfo_t *p;
+
+    p = lock_user(VERIFY_READ, arg3, sizeof(target_siginfo_t), 1);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_siginfo(&uinfo, p);
+    unlock_user(p, arg3, 0);
+    return get_errno(sys_rt_sigqueueinfo(arg1, arg2, &uinfo));
+}
+
 IMPL(rt_sigsuspend)
 {
     CPUState *cpu = ENV_GET_CPU(cpu_env);
@@ -8791,6 +8805,56 @@ IMPL(rt_sigsuspend)
     return ret;
 }
 
+IMPL(rt_sigtimedwait)
+{
+    sigset_t set;
+    struct timespec uts, *puts = NULL;
+    void *p;
+    siginfo_t uinfo;
+    abi_long ret;
+
+    if (arg4 != sizeof(target_sigset_t)) {
+        return -TARGET_EINVAL;
+    }
+    p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_sigset(&set, p);
+    unlock_user(p, arg1, 0);
+    if (arg3) {
+        puts = &uts;
+        target_to_host_timespec(puts, arg3);
+    }
+    ret = get_errno(safe_rt_sigtimedwait(&set, &uinfo, puts, SIGSET_T_SIZE));
+    if (!is_error(ret)) {
+        if (arg2) {
+            p = lock_user(VERIFY_WRITE, arg2, sizeof(target_siginfo_t), 0);
+            if (!p) {
+                return -TARGET_EFAULT;
+            }
+            host_to_target_siginfo(p, &uinfo);
+            unlock_user(p, arg2, sizeof(target_siginfo_t));
+        }
+        ret = host_to_target_signal(ret);
+    }
+    return ret;
+}
+
+IMPL(rt_tgsigqueueinfo)
+{
+    siginfo_t uinfo;
+    target_siginfo_t *p;
+
+    p = lock_user(VERIFY_READ, arg4, sizeof(target_siginfo_t), 1);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_siginfo(&uinfo, p);
+    unlock_user(p, arg4, 0);
+    return get_errno(sys_rt_tgsigqueueinfo(arg1, arg2, arg3, &uinfo));
+}
+
 #ifdef TARGET_NR_sgetmask
 IMPL(sgetmask)
 {
@@ -9275,68 +9339,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_rt_sigtimedwait:
-        {
-            sigset_t set;
-            struct timespec uts, *puts;
-            siginfo_t uinfo;
-
-            if (arg4 != sizeof(target_sigset_t)) {
-                return -TARGET_EINVAL;
-            }
-
-            if (!(p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1)))
-                return -TARGET_EFAULT;
-            target_to_host_sigset(&set, p);
-            unlock_user(p, arg1, 0);
-            if (arg3) {
-                puts = &uts;
-                target_to_host_timespec(puts, arg3);
-            } else {
-                puts = NULL;
-            }
-            ret = get_errno(safe_rt_sigtimedwait(&set, &uinfo, puts,
-                                                 SIGSET_T_SIZE));
-            if (!is_error(ret)) {
-                if (arg2) {
-                    p = lock_user(VERIFY_WRITE, arg2, sizeof(target_siginfo_t),
-                                  0);
-                    if (!p) {
-                        return -TARGET_EFAULT;
-                    }
-                    host_to_target_siginfo(p, &uinfo);
-                    unlock_user(p, arg2, sizeof(target_siginfo_t));
-                }
-                ret = host_to_target_signal(ret);
-            }
-        }
-        return ret;
-    case TARGET_NR_rt_sigqueueinfo:
-        {
-            siginfo_t uinfo;
-
-            p = lock_user(VERIFY_READ, arg3, sizeof(target_siginfo_t), 1);
-            if (!p) {
-                return -TARGET_EFAULT;
-            }
-            target_to_host_siginfo(&uinfo, p);
-            unlock_user(p, arg3, 0);
-            ret = get_errno(sys_rt_sigqueueinfo(arg1, arg2, &uinfo));
-        }
-        return ret;
-    case TARGET_NR_rt_tgsigqueueinfo:
-        {
-            siginfo_t uinfo;
-
-            p = lock_user(VERIFY_READ, arg4, sizeof(target_siginfo_t), 1);
-            if (!p) {
-                return -TARGET_EFAULT;
-            }
-            target_to_host_siginfo(&uinfo, p);
-            unlock_user(p, arg4, 0);
-            ret = get_errno(sys_rt_tgsigqueueinfo(arg1, arg2, arg3, &uinfo));
-        }
-        return ret;
 #ifdef TARGET_NR_sigreturn
     case TARGET_NR_sigreturn:
         if (block_signals()) {
@@ -12775,7 +12777,10 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(rt_sigaction);
         SYSCALL(rt_sigpending);
         SYSCALL(rt_sigprocmask);
+        SYSCALL(rt_sigqueueinfo);
         SYSCALL(rt_sigsuspend);
+        SYSCALL(rt_sigtimedwait);
+        SYSCALL(rt_tgsigqueueinfo);
 #ifdef TARGET_NR_sgetmask
         SYSCALL(sgetmask);
 #endif
-- 
2.17.1

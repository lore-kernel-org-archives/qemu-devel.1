Received: from eggs.gnu.org ([2001:4830:134:3::10]:57759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeXH-0005ye-MP
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeXF-0000vD-RL
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:42 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:37620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeXF-0000uX-Id
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:41 -0400
Received: by mail-pf0-x241.google.com with SMTP id e9-v6so12083458pfi.4
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:50 -0700
Message-Id: <20180601073050.8054-34-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 33/33] linux-user: Split out rt_sigqueueinfo,
 rt_sigtimedwait, rt_tgsigqueueinfo
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
index c3bd625965..b9e07c2d3f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8876,6 +8876,20 @@ IMPL(rt_sigprocmask)
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
@@ -8899,6 +8913,56 @@ IMPL(rt_sigsuspend)
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
@@ -9393,68 +9457,6 @@ IMPL(everything_else)
     char *fn;
 
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
@@ -13132,7 +13134,10 @@ static impl_fn * const syscall_table[] = {
     [TARGET_NR_rt_sigaction] = impl_rt_sigaction,
     [TARGET_NR_rt_sigpending] = impl_rt_sigpending,
     [TARGET_NR_rt_sigprocmask] = impl_rt_sigprocmask,
+    [TARGET_NR_rt_sigqueueinfo] = impl_rt_sigqueueinfo,
     [TARGET_NR_rt_sigsuspend] = impl_rt_sigsuspend,
+    [TARGET_NR_rt_sigtimedwait] = impl_rt_sigtimedwait,
+    [TARGET_NR_rt_tgsigqueueinfo] = impl_rt_tgsigqueueinfo,
 #ifdef TARGET_NR_sgetmask
     [TARGET_NR_sgetmask] = impl_sgetmask,
 #endif
-- 
2.17.0

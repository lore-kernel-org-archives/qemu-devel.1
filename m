Received: from eggs.gnu.org ([2001:4830:134:3::10]:40484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdk-0002S6-Si
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdi-0003W6-Vg
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:36 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:37246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqdi-0003Vk-Kn
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:34 -0400
Received: by mail-pf0-x243.google.com with SMTP id y5-v6so7583407pfn.4
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:03 -1000
Message-Id: <20180610030220.3777-32-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 031/108] linux-user: Split out rt_sigpending,
 rt_sigsuspend, sigpending, sigsuspend
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
 linux-user/syscall.c | 176 +++++++++++++++++++++++++------------------
 1 file changed, 101 insertions(+), 75 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index cc818ea65e..6869a0db47 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8697,6 +8697,32 @@ IMPL(rt_sigaction)
     return ret;
 }
 
+IMPL(rt_sigpending)
+{
+    sigset_t set;
+    abi_long ret;
+
+    /* Yes, this check is >, not != like most. We follow the kernel's
+     * logic and it does it like this because it implements
+     * NR_sigpending through the same code path, and in that case
+     * the old_sigset_t is smaller in size.
+     */
+    if (arg2 > sizeof(target_sigset_t)) {
+        return -TARGET_EINVAL;
+    }
+    ret = get_errno(sigpending(&set));
+    if (!is_error(ret)) {
+        target_sigset_t *p;
+        p = lock_user(VERIFY_WRITE, arg1, sizeof(target_sigset_t), 0);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        host_to_target_sigset(p, &set);
+        unlock_user(p, arg1, sizeof(target_sigset_t));
+    }
+    return ret;
+}
+
 IMPL(rt_sigprocmask)
 {
     int how = 0;
@@ -8742,6 +8768,29 @@ IMPL(rt_sigprocmask)
     return ret;
 }
 
+IMPL(rt_sigsuspend)
+{
+    CPUState *cpu = ENV_GET_CPU(cpu_env);
+    TaskState *ts = cpu->opaque;
+    target_sigset_t *p;
+    abi_long ret;
+
+    if (arg2 != sizeof(target_sigset_t)) {
+        return -TARGET_EINVAL;
+    }
+    p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_sigset(&ts->sigsuspend_mask, p);
+    unlock_user(p, arg1, 0);
+    ret = get_errno(safe_rt_sigsuspend(&ts->sigsuspend_mask, SIGSET_T_SIZE));
+    if (ret != -TARGET_ERESTARTSYS) {
+        ts->in_sigsuspend = 1;
+    }
+    return ret;
+}
+
 #ifdef TARGET_NR_sgetmask
 IMPL(sgetmask)
 {
@@ -8852,6 +8901,24 @@ IMPL(sigaction)
 }
 #endif
 
+#ifdef TARGET_NR_sigpending
+IMPL(sigpending)
+{
+    sigset_t set;
+    abi_long ret = get_errno(sigpending(&set));
+    if (!is_error(ret)) {
+        abi_ulong *p;
+        p = lock_user(VERIFY_WRITE, arg1, sizeof(target_sigset_t), 0);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        host_to_target_old_sigset(p, &set);
+        unlock_user(p, arg1, sizeof(target_sigset_t));
+    }
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_sigprocmask
 IMPL(sigprocmask)
 {
@@ -8924,6 +8991,32 @@ IMPL(sigprocmask)
 }
 #endif
 
+#ifdef TARGET_NR_sigsuspend
+IMPL(sigsuspend)
+{
+    CPUState *cpu = ENV_GET_CPU(cpu_env);
+    TaskState *ts = cpu->opaque;
+    abi_long ret;
+
+# ifdef TARGET_ALPHA
+    abi_ulong mask = arg1;
+    target_to_host_old_sigset(&ts->sigsuspend_mask, &mask);
+# else
+    abi_ulong *p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_old_sigset(&ts->sigsuspend_mask, p);
+    unlock_user(p, arg1, 0);
+# endif
+    ret = get_errno(safe_rt_sigsuspend(&ts->sigsuspend_mask, SIGSET_T_SIZE));
+    if (ret != -TARGET_ERESTARTSYS) {
+        ts->in_sigsuspend = 1;
+    }
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_ssetmask
 IMPL(ssetmask)
 {
@@ -9182,81 +9275,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_sigpending
-    case TARGET_NR_sigpending:
-        {
-            sigset_t set;
-            ret = get_errno(sigpending(&set));
-            if (!is_error(ret)) {
-                if (!(p = lock_user(VERIFY_WRITE, arg1, sizeof(target_sigset_t), 0)))
-                    return -TARGET_EFAULT;
-                host_to_target_old_sigset(p, &set);
-                unlock_user(p, arg1, sizeof(target_sigset_t));
-            }
-        }
-        return ret;
-#endif
-    case TARGET_NR_rt_sigpending:
-        {
-            sigset_t set;
-
-            /* Yes, this check is >, not != like most. We follow the kernel's
-             * logic and it does it like this because it implements
-             * NR_sigpending through the same code path, and in that case
-             * the old_sigset_t is smaller in size.
-             */
-            if (arg2 > sizeof(target_sigset_t)) {
-                return -TARGET_EINVAL;
-            }
-
-            ret = get_errno(sigpending(&set));
-            if (!is_error(ret)) {
-                if (!(p = lock_user(VERIFY_WRITE, arg1, sizeof(target_sigset_t), 0)))
-                    return -TARGET_EFAULT;
-                host_to_target_sigset(p, &set);
-                unlock_user(p, arg1, sizeof(target_sigset_t));
-            }
-        }
-        return ret;
-#ifdef TARGET_NR_sigsuspend
-    case TARGET_NR_sigsuspend:
-        {
-            TaskState *ts = cpu->opaque;
-#if defined(TARGET_ALPHA)
-            abi_ulong mask = arg1;
-            target_to_host_old_sigset(&ts->sigsuspend_mask, &mask);
-#else
-            if (!(p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1)))
-                return -TARGET_EFAULT;
-            target_to_host_old_sigset(&ts->sigsuspend_mask, p);
-            unlock_user(p, arg1, 0);
-#endif
-            ret = get_errno(safe_rt_sigsuspend(&ts->sigsuspend_mask,
-                                               SIGSET_T_SIZE));
-            if (ret != -TARGET_ERESTARTSYS) {
-                ts->in_sigsuspend = 1;
-            }
-        }
-        return ret;
-#endif
-    case TARGET_NR_rt_sigsuspend:
-        {
-            TaskState *ts = cpu->opaque;
-
-            if (arg2 != sizeof(target_sigset_t)) {
-                return -TARGET_EINVAL;
-            }
-            if (!(p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1)))
-                return -TARGET_EFAULT;
-            target_to_host_sigset(&ts->sigsuspend_mask, p);
-            unlock_user(p, arg1, 0);
-            ret = get_errno(safe_rt_sigsuspend(&ts->sigsuspend_mask,
-                                               SIGSET_T_SIZE));
-            if (ret != -TARGET_ERESTARTSYS) {
-                ts->in_sigsuspend = 1;
-            }
-        }
-        return ret;
     case TARGET_NR_rt_sigtimedwait:
         {
             sigset_t set;
@@ -12755,7 +12773,9 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(rmdir);
 #endif
         SYSCALL(rt_sigaction);
+        SYSCALL(rt_sigpending);
         SYSCALL(rt_sigprocmask);
+        SYSCALL(rt_sigsuspend);
 #ifdef TARGET_NR_sgetmask
         SYSCALL(sgetmask);
 #endif
@@ -12764,9 +12784,15 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_sigaction
         SYSCALL(sigaction);
 #endif
+#ifdef TARGET_NR_sigpending
+        SYSCALL(sigpending);
+#endif
 #ifdef TARGET_NR_sigprocmask
         SYSCALL(sigprocmask);
 #endif
+#ifdef TARGET_NR_sigsuspend
+        SYSCALL(sigsuspend);
+#endif
 #ifdef TARGET_NR_ssetmask
         SYSCALL(ssetmask);
 #endif
-- 
2.17.1

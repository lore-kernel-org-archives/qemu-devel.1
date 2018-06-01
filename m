Received: from eggs.gnu.org ([2001:4830:134:3::10]:57746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeXF-0005y5-L1
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeXE-0000td-CP
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:41 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeXE-0000t2-4l
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:40 -0400
Received: by mail-pg0-x241.google.com with SMTP id k2-v6so10883082pgc.1
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:49 -0700
Message-Id: <20180601073050.8054-33-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 32/33] linux-user: Split out rt_sigpending,
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
index e37a3ab643..c3bd625965 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8805,6 +8805,32 @@ IMPL(rt_sigaction)
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
@@ -8850,6 +8876,29 @@ IMPL(rt_sigprocmask)
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
@@ -8960,6 +9009,24 @@ IMPL(sigaction)
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
@@ -9032,6 +9099,32 @@ IMPL(sigprocmask)
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
@@ -9300,81 +9393,6 @@ IMPL(everything_else)
     char *fn;
 
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
@@ -13112,7 +13130,9 @@ static impl_fn * const syscall_table[] = {
     [TARGET_NR_rmdir] = impl_rmdir,
 #endif
     [TARGET_NR_rt_sigaction] = impl_rt_sigaction,
+    [TARGET_NR_rt_sigpending] = impl_rt_sigpending,
     [TARGET_NR_rt_sigprocmask] = impl_rt_sigprocmask,
+    [TARGET_NR_rt_sigsuspend] = impl_rt_sigsuspend,
 #ifdef TARGET_NR_sgetmask
     [TARGET_NR_sgetmask] = impl_sgetmask,
 #endif
@@ -13121,9 +13141,15 @@ static impl_fn * const syscall_table[] = {
 #ifdef TARGET_NR_sigaction
     [TARGET_NR_sigaction] = impl_sigaction,
 #endif
+#ifdef TARGET_NR_sigpending
+    [TARGET_NR_sigpending] = impl_sigpending,
+#endif
 #ifdef TARGET_NR_sigprocmask
     [TARGET_NR_sigprocmask] = impl_sigprocmask,
 #endif
+#ifdef TARGET_NR_sigsuspend
+    [TARGET_NR_sigsuspend] = impl_sigsuspend,
+#endif
 #ifdef TARGET_NR_ssetmask
     [TARGET_NR_ssetmask] = impl_ssetmask,
 #endif
-- 
2.17.0

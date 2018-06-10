Received: from eggs.gnu.org ([2001:4830:134:3::10]:41023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeu-0003Zo-Kb
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqet-0003zW-6B
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:48 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:42385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqes-0003z9-Sw
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:47 -0400
Received: by mail-pf0-x242.google.com with SMTP id w7-v6so8479000pfn.9
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:37 -1000
Message-Id: <20180610030220.3777-66-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 065/108] linux-user: Split out getcpu,
 nanosleep, prctl
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
 linux-user/syscall.c | 214 +++++++++++++++++++++++--------------------
 1 file changed, 114 insertions(+), 100 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 84f21634c8..ee3a31f06d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8132,6 +8132,24 @@ IMPL(futimesat)
 }
 #endif
 
+IMPL(getcpu)
+{
+    unsigned cpu, node;
+    abi_long ret;
+
+    ret = get_errno(sys_getcpu(arg1 ? &cpu : NULL, arg2 ? &node : NULL, NULL));
+    if (is_error(ret)) {
+        return ret;
+    }
+    if (arg1 && put_user_u32(cpu, arg1)) {
+        return -TARGET_EFAULT;
+    }
+    if (arg2 && put_user_u32(node, arg2)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+
 #ifdef TARGET_NR_getdents
 IMPL(getdents)
 {
@@ -9004,6 +9022,25 @@ IMPL(name_to_handle_at)
 }
 #endif
 
+IMPL(nanosleep)
+{
+    struct timespec req, rem;
+    abi_long ret;
+
+    ret = target_to_host_timespec(&req, arg1);
+    if (ret < 0) {
+        return ret;
+    }
+    ret = safe_nanosleep(&req, &rem);
+    if (ret < 0) {
+        return -host_to_target_errno(errno);
+    }
+    if (arg2) {
+        return host_to_target_timespec(arg2, &rem);
+    }
+    return 0;
+}
+
 #ifdef TARGET_NR__newselect
 IMPL(_newselect)
 {
@@ -9237,6 +9274,80 @@ IMPL(ppoll)
     return ret;
 }
 
+IMPL(prctl)
+{
+    int deathsig;
+    void *name;
+    abi_long ret;
+
+    switch (arg1) {
+    case PR_GET_PDEATHSIG:
+        ret = get_errno(prctl(arg1, &deathsig, arg3, arg4, arg5));
+        if (!is_error(ret) && arg2 && put_user_ual(deathsig, arg2)) {
+            return -TARGET_EFAULT;
+        }
+        return ret;
+
+#ifdef PR_GET_NAME
+    case PR_GET_NAME:
+        name = lock_user(VERIFY_WRITE, arg2, 16, 1);
+        if (!name) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(prctl(arg1, (uintptr_t)name, arg3, arg4, arg5));
+        unlock_user(name, arg2, 16);
+        return ret;
+#endif
+#ifdef PR_SET_NAME
+    case PR_SET_NAME:
+        name = lock_user(VERIFY_READ, arg2, 16, 1);
+        if (!name) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(prctl(arg1, (uintptr_t)name, arg3, arg4, arg5));
+        unlock_user(name, arg2, 0);
+        return ret;
+#endif
+#ifdef TARGET_AARCH64
+    case TARGET_PR_SVE_SET_VL:
+        /* We cannot support either PR_SVE_SET_VL_ONEXEC
+           or PR_SVE_VL_INHERIT.  Therefore, anything above
+           ARM_MAX_VQ results in EINVAL.  */
+        ret = -TARGET_EINVAL;
+        if (arm_feature(cpu_env, ARM_FEATURE_SVE)
+            && arg2 >= 0 && arg2 <= ARM_MAX_VQ * 16 && !(arg2 & 15)) {
+            CPUARMState *env = cpu_env;
+            int old_vq = (env->vfp.zcr_el[1] & 0xf) + 1;
+            int vq = MAX(arg2 / 16, 1);
+
+            if (vq < old_vq) {
+                aarch64_sve_narrow_vq(env, vq);
+            }
+            env->vfp.zcr_el[1] = vq - 1;
+            ret = vq * 16;
+        }
+        return ret;
+
+    case TARGET_PR_SVE_GET_VL:
+        ret = -TARGET_EINVAL;
+        if (arm_feature(cpu_env, ARM_FEATURE_SVE)) {
+            CPUARMState *env = cpu_env;
+            ret = ((env->vfp.zcr_el[1] & 0xf) + 1) * 16;
+        }
+        return ret;
+#endif /* AARCH64 */
+
+    case PR_GET_SECCOMP:
+    case PR_SET_SECCOMP:
+        /* Disable seccomp to prevent the target disabling syscalls we need. */
+        return -TARGET_EINVAL;
+
+    default:
+        /* Most prctl options have no pointer arguments */
+        return get_errno(prctl(arg1, arg2, arg3, arg4, arg5));
+    }
+}
+
 IMPL(preadv)
 {
     struct iovec *vec;
@@ -11007,106 +11118,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_getcpu:
-        {
-            unsigned cpu, node;
-            ret = get_errno(sys_getcpu(arg1 ? &cpu : NULL,
-                                       arg2 ? &node : NULL,
-                                       NULL));
-            if (is_error(ret)) {
-                return ret;
-            }
-            if (arg1 && put_user_u32(cpu, arg1)) {
-                return -TARGET_EFAULT;
-            }
-            if (arg2 && put_user_u32(node, arg2)) {
-                return -TARGET_EFAULT;
-            }
-        }
-        return ret;
-    case TARGET_NR_nanosleep:
-        {
-            struct timespec req, rem;
-            target_to_host_timespec(&req, arg1);
-            ret = get_errno(safe_nanosleep(&req, &rem));
-            if (is_error(ret) && arg2) {
-                host_to_target_timespec(arg2, &rem);
-            }
-        }
-        return ret;
-    case TARGET_NR_prctl:
-        switch (arg1) {
-        case PR_GET_PDEATHSIG:
-        {
-            int deathsig;
-            ret = get_errno(prctl(arg1, &deathsig, arg3, arg4, arg5));
-            if (!is_error(ret) && arg2
-                && put_user_ual(deathsig, arg2)) {
-                return -TARGET_EFAULT;
-            }
-            return ret;
-        }
-#ifdef PR_GET_NAME
-        case PR_GET_NAME:
-        {
-            void *name = lock_user(VERIFY_WRITE, arg2, 16, 1);
-            if (!name) {
-                return -TARGET_EFAULT;
-            }
-            ret = get_errno(prctl(arg1, (unsigned long)name,
-                                  arg3, arg4, arg5));
-            unlock_user(name, arg2, 16);
-            return ret;
-        }
-        case PR_SET_NAME:
-        {
-            void *name = lock_user(VERIFY_READ, arg2, 16, 1);
-            if (!name) {
-                return -TARGET_EFAULT;
-            }
-            ret = get_errno(prctl(arg1, (unsigned long)name,
-                                  arg3, arg4, arg5));
-            unlock_user(name, arg2, 0);
-            return ret;
-        }
-#endif
-#ifdef TARGET_AARCH64
-        case TARGET_PR_SVE_SET_VL:
-            /* We cannot support either PR_SVE_SET_VL_ONEXEC
-               or PR_SVE_VL_INHERIT.  Therefore, anything above
-               ARM_MAX_VQ results in EINVAL.  */
-            ret = -TARGET_EINVAL;
-            if (arm_feature(cpu_env, ARM_FEATURE_SVE)
-                && arg2 >= 0 && arg2 <= ARM_MAX_VQ * 16 && !(arg2 & 15)) {
-                CPUARMState *env = cpu_env;
-                int old_vq = (env->vfp.zcr_el[1] & 0xf) + 1;
-                int vq = MAX(arg2 / 16, 1);
-
-                if (vq < old_vq) {
-                    aarch64_sve_narrow_vq(env, vq);
-                }
-                env->vfp.zcr_el[1] = vq - 1;
-                ret = vq * 16;
-            }
-            return ret;
-        case TARGET_PR_SVE_GET_VL:
-            ret = -TARGET_EINVAL;
-            if (arm_feature(cpu_env, ARM_FEATURE_SVE)) {
-                CPUARMState *env = cpu_env;
-                ret = ((env->vfp.zcr_el[1] & 0xf) + 1) * 16;
-            }
-            return ret;
-#endif /* AARCH64 */
-        case PR_GET_SECCOMP:
-        case PR_SET_SECCOMP:
-            /* Disable seccomp to prevent the target disabling syscalls we
-             * need. */
-            return -TARGET_EINVAL;
-        default:
-            /* Most prctl options have no pointer arguments */
-            return get_errno(prctl(arg1, arg2, arg3, arg4, arg5));
-        }
-        break;
 #ifdef TARGET_NR_arch_prctl
     case TARGET_NR_arch_prctl:
 #if defined(TARGET_I386) && !defined(TARGET_ABI32)
@@ -13004,6 +13015,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_futimesat
         SYSCALL(futimesat);
 #endif
+        SYSCALL(getcpu);
 #ifdef TARGET_NR_getdents
         SYSCALL(getdents);
 #endif
@@ -13099,6 +13111,7 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef CONFIG_OPEN_BY_HANDLE
         SYSCALL(name_to_handle_at);
 #endif
+        SYSCALL(nanosleep);
 #ifdef TARGET_NR__newselect
         SYSCALL(_newselect);
 #endif
@@ -13124,6 +13137,7 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(poll);
 #endif
         SYSCALL(ppoll);
+        SYSCALL(prctl);
         SYSCALL(preadv);
         SYSCALL(pselect6);
         SYSCALL(pwritev);
-- 
2.17.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeu-0003Zc-Do
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqer-0003xv-7l
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:48 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:42525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqeq-0003wg-Vz
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:45 -0400
Received: by mail-pg0-x244.google.com with SMTP id c10-v6so2509166pgu.9
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:36 -1000
Message-Id: <20180610030220.3777-65-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 064/108] linux-user: Split out sched syscalls
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

This includes sched_getaffinity, sched_getparam, sched_get_priority_max,
sched_get_priority_min, sched_getscheduler, sched_rr_get_interval,
sched_setaffinity, sched_setparam, sched_setscheduler, sched_yield.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 281 ++++++++++++++++++++++++-------------------
 1 file changed, 158 insertions(+), 123 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1907b32499..84f21634c8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9795,6 +9795,154 @@ IMPL(rt_tgsigqueueinfo)
     return get_errno(sys_rt_tgsigqueueinfo(arg1, arg2, arg3, &uinfo));
 }
 
+IMPL(sched_getaffinity)
+{
+    unsigned int mask_size;
+    unsigned long *mask;
+    abi_long ret;
+
+    /*
+     * sched_getaffinity needs multiples of ulong, so need to take
+     * care of mismatches between target ulong and host ulong sizes.
+     */
+    if (arg2 & (sizeof(abi_ulong) - 1)) {
+        return -TARGET_EINVAL;
+    }
+    mask_size = QEMU_ALIGN_UP(arg2, sizeof(unsigned long));
+    mask = alloca(mask_size);
+    memset(mask, 0, mask_size);
+
+    ret = get_errno(sys_sched_getaffinity(arg1, mask_size, mask));
+    if (!is_error(ret)) {
+        if (ret > arg2) {
+            /* More data returned than the caller's buffer will fit.
+             * This only happens if sizeof(abi_long) < sizeof(long)
+             * and the caller passed us a buffer holding an odd number
+             * of abi_longs. If the host kernel is actually using the
+             * extra 4 bytes then fail EINVAL; otherwise we can just
+             * ignore them and only copy the interesting part.
+             */
+            int numcpus = sysconf(_SC_NPROCESSORS_CONF);
+            if (numcpus > arg2 * 8) {
+                return -TARGET_EINVAL;
+            }
+            ret = arg2;
+        }
+        if (host_to_target_cpu_mask(mask, mask_size, arg3, ret)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
+IMPL(sched_getparam)
+{
+    struct sched_param *target_schp;
+    struct sched_param schp;
+    abi_long ret;
+
+    if (arg2 == 0) {
+        return -TARGET_EINVAL;
+    }
+    ret = get_errno(sched_getparam(arg1, &schp));
+    if (!is_error(ret)) {
+        if (!lock_user_struct(VERIFY_WRITE, target_schp, arg2, 0)) {
+            return -TARGET_EFAULT;
+        }
+        target_schp->sched_priority = tswap32(schp.sched_priority);
+        unlock_user_struct(target_schp, arg2, 1);
+    }
+    return ret;
+}
+
+IMPL(sched_get_priority_max)
+{
+    return get_errno(sched_get_priority_max(arg1));
+}
+
+IMPL(sched_get_priority_min)
+{
+    return get_errno(sched_get_priority_min(arg1));
+}
+
+IMPL(sched_getscheduler)
+{
+    return get_errno(sched_getscheduler(arg1));
+}
+
+IMPL(sched_rr_get_interval)
+{
+    struct timespec ts;
+    abi_long ret;
+
+    ret = get_errno(sched_rr_get_interval(arg1, &ts));
+    if (!is_error(ret)) {
+        ret = host_to_target_timespec(arg2, &ts);
+    }
+    return ret;
+}
+
+IMPL(sched_setaffinity)
+{
+    unsigned int mask_size;
+    unsigned long *mask;
+    abi_long ret;
+
+    /*
+     * sched_setaffinity needs multiples of ulong, so need to take
+     * care of mismatches between target ulong and host ulong sizes.
+     */
+    if (arg2 & (sizeof(abi_ulong) - 1)) {
+        return -TARGET_EINVAL;
+    }
+    mask_size = QEMU_ALIGN_UP(arg2, sizeof(unsigned long));
+    mask = alloca(mask_size);
+
+    ret = target_to_host_cpu_mask(mask, mask_size, arg3, arg2);
+    if (ret) {
+        return ret;
+    }
+
+    return get_errno(sys_sched_setaffinity(arg1, mask_size, mask));
+}
+
+IMPL(sched_setparam)
+{
+    struct sched_param *target_schp;
+    struct sched_param schp;
+
+    if (arg2 == 0) {
+        return -TARGET_EINVAL;
+    }
+    if (!lock_user_struct(VERIFY_READ, target_schp, arg2, 1)) {
+        return -TARGET_EFAULT;
+    }
+    schp.sched_priority = tswap32(target_schp->sched_priority);
+    unlock_user_struct(target_schp, arg2, 0);
+    return get_errno(sched_setparam(arg1, &schp));
+}
+
+IMPL(sched_setscheduler)
+{
+    struct sched_param *target_schp;
+    struct sched_param schp;
+
+    if (arg3 == 0) {
+        return -TARGET_EINVAL;
+    }
+    if (!lock_user_struct(VERIFY_READ, target_schp, arg3, 1)) {
+        return -TARGET_EFAULT;
+    }
+    schp.sched_priority = tswap32(target_schp->sched_priority);
+    unlock_user_struct(target_schp, arg3, 0);
+    return get_errno(sched_setscheduler(arg1, arg2, &schp));
+}
+
+IMPL(sched_yield)
+{
+    return get_errno(sched_yield());
+}
+
 #ifdef TARGET_NR_sgetmask
 IMPL(sgetmask)
 {
@@ -10859,68 +11007,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_sched_getaffinity:
-        {
-            unsigned int mask_size;
-            unsigned long *mask;
-
-            /*
-             * sched_getaffinity needs multiples of ulong, so need to take
-             * care of mismatches between target ulong and host ulong sizes.
-             */
-            if (arg2 & (sizeof(abi_ulong) - 1)) {
-                return -TARGET_EINVAL;
-            }
-            mask_size = (arg2 + (sizeof(*mask) - 1)) & ~(sizeof(*mask) - 1);
-
-            mask = alloca(mask_size);
-            memset(mask, 0, mask_size);
-            ret = get_errno(sys_sched_getaffinity(arg1, mask_size, mask));
-
-            if (!is_error(ret)) {
-                if (ret > arg2) {
-                    /* More data returned than the caller's buffer will fit.
-                     * This only happens if sizeof(abi_long) < sizeof(long)
-                     * and the caller passed us a buffer holding an odd number
-                     * of abi_longs. If the host kernel is actually using the
-                     * extra 4 bytes then fail EINVAL; otherwise we can just
-                     * ignore them and only copy the interesting part.
-                     */
-                    int numcpus = sysconf(_SC_NPROCESSORS_CONF);
-                    if (numcpus > arg2 * 8) {
-                        return -TARGET_EINVAL;
-                    }
-                    ret = arg2;
-                }
-
-                if (host_to_target_cpu_mask(mask, mask_size, arg3, ret)) {
-                    return -TARGET_EFAULT;
-                }
-            }
-        }
-        return ret;
-    case TARGET_NR_sched_setaffinity:
-        {
-            unsigned int mask_size;
-            unsigned long *mask;
-
-            /*
-             * sched_setaffinity needs multiples of ulong, so need to take
-             * care of mismatches between target ulong and host ulong sizes.
-             */
-            if (arg2 & (sizeof(abi_ulong) - 1)) {
-                return -TARGET_EINVAL;
-            }
-            mask_size = (arg2 + (sizeof(*mask) - 1)) & ~(sizeof(*mask) - 1);
-            mask = alloca(mask_size);
-
-            ret = target_to_host_cpu_mask(mask, mask_size, arg3, arg2);
-            if (ret) {
-                return ret;
-            }
-
-            return get_errno(sys_sched_setaffinity(arg1, mask_size, mask));
-        }
     case TARGET_NR_getcpu:
         {
             unsigned cpu, node;
@@ -10938,67 +11024,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
             }
         }
         return ret;
-    case TARGET_NR_sched_setparam:
-        {
-            struct sched_param *target_schp;
-            struct sched_param schp;
-
-            if (arg2 == 0) {
-                return -TARGET_EINVAL;
-            }
-            if (!lock_user_struct(VERIFY_READ, target_schp, arg2, 1))
-                return -TARGET_EFAULT;
-            schp.sched_priority = tswap32(target_schp->sched_priority);
-            unlock_user_struct(target_schp, arg2, 0);
-            return get_errno(sched_setparam(arg1, &schp));
-        }
-    case TARGET_NR_sched_getparam:
-        {
-            struct sched_param *target_schp;
-            struct sched_param schp;
-
-            if (arg2 == 0) {
-                return -TARGET_EINVAL;
-            }
-            ret = get_errno(sched_getparam(arg1, &schp));
-            if (!is_error(ret)) {
-                if (!lock_user_struct(VERIFY_WRITE, target_schp, arg2, 0))
-                    return -TARGET_EFAULT;
-                target_schp->sched_priority = tswap32(schp.sched_priority);
-                unlock_user_struct(target_schp, arg2, 1);
-            }
-        }
-        return ret;
-    case TARGET_NR_sched_setscheduler:
-        {
-            struct sched_param *target_schp;
-            struct sched_param schp;
-            if (arg3 == 0) {
-                return -TARGET_EINVAL;
-            }
-            if (!lock_user_struct(VERIFY_READ, target_schp, arg3, 1))
-                return -TARGET_EFAULT;
-            schp.sched_priority = tswap32(target_schp->sched_priority);
-            unlock_user_struct(target_schp, arg3, 0);
-            return get_errno(sched_setscheduler(arg1, arg2, &schp));
-        }
-    case TARGET_NR_sched_getscheduler:
-        return get_errno(sched_getscheduler(arg1));
-    case TARGET_NR_sched_yield:
-        return get_errno(sched_yield());
-    case TARGET_NR_sched_get_priority_max:
-        return get_errno(sched_get_priority_max(arg1));
-    case TARGET_NR_sched_get_priority_min:
-        return get_errno(sched_get_priority_min(arg1));
-    case TARGET_NR_sched_rr_get_interval:
-        {
-            struct timespec ts;
-            ret = get_errno(sched_rr_get_interval(arg1, &ts));
-            if (!is_error(ret)) {
-                ret = host_to_target_timespec(arg2, &ts);
-            }
-        }
-        return ret;
     case TARGET_NR_nanosleep:
         {
             struct timespec req, rem;
@@ -13139,6 +13164,16 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(rt_sigsuspend);
         SYSCALL(rt_sigtimedwait);
         SYSCALL(rt_tgsigqueueinfo);
+        SYSCALL(sched_getaffinity);
+        SYSCALL(sched_getparam);
+        SYSCALL(sched_get_priority_max);
+        SYSCALL(sched_get_priority_min);
+        SYSCALL(sched_getscheduler);
+        SYSCALL(sched_rr_get_interval);
+        SYSCALL(sched_setaffinity);
+        SYSCALL(sched_setparam);
+        SYSCALL(sched_setscheduler);
+        SYSCALL(sched_yield);
 #ifdef TARGET_NR_sgetmask
         SYSCALL(sgetmask);
 #endif
-- 
2.17.1

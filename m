Received: from eggs.gnu.org ([2001:4830:134:3::10]:41224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfL-0003xn-3f
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqfH-0004Lm-St
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:15 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:37284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqfH-0004La-JN
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:11 -0400
Received: by mail-pl0-x243.google.com with SMTP id 31-v6so10386558plc.4
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:50 -1000
Message-Id: <20180610030220.3777-79-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 078/108] linux-user: Split out
 osf_getsysinfo, osf_setsysinfo, osf_sigprocmask
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
 linux-user/syscall.c | 323 ++++++++++++++++++++++---------------------
 1 file changed, 162 insertions(+), 161 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 17560ebd41..ae591a6523 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9444,6 +9444,159 @@ IMPL(open_by_handle_at)
 }
 #endif
 
+#if defined(TARGET_NR_osf_getsysinfo) && defined(TARGET_ALPHA)
+IMPL(osf_getsysinfo)
+{
+    uint64_t swcr, fpcr;
+
+    switch (arg1) {
+    case TARGET_GSI_IEEE_FP_CONTROL:
+        fpcr = cpu_alpha_load_fpcr(cpu_env);
+
+        /* Copied from linux ieee_fpcr_to_swcr.  */
+        swcr = (fpcr >> 35) & SWCR_STATUS_MASK;
+        swcr |= (fpcr >> 36) & SWCR_MAP_DMZ;
+        swcr |= (~fpcr >> 48) & (SWCR_TRAP_ENABLE_INV
+                                | SWCR_TRAP_ENABLE_DZE
+                                | SWCR_TRAP_ENABLE_OVF);
+        swcr |= (~fpcr >> 57) & (SWCR_TRAP_ENABLE_UNF
+                                | SWCR_TRAP_ENABLE_INE);
+        swcr |= (fpcr >> 47) & SWCR_MAP_UMZ;
+        swcr |= (~fpcr >> 41) & SWCR_TRAP_ENABLE_DNO;
+
+        if (put_user_u64(swcr, arg2)) {
+            return -TARGET_EFAULT;
+        }
+        return 0;
+
+    default:
+        /* case GSI_IEEE_STATE_AT_SIGNAL:
+         * -- Not implemented in linux kernel.
+         * case GSI_UACPROC:
+         * -- Retrieves current unaligned access state; not much used.
+         * case GSI_PROC_TYPE:
+         * -- Retrieves implver information; surely not used.
+         * case GSI_GET_HWRPB:
+         * -- Grabs a copy of the HWRPB; surely not used.
+         */
+        return -TARGET_EOPNOTSUPP;
+    }
+}
+#endif
+
+#if defined(TARGET_NR_osf_setsysinfo) && defined(TARGET_ALPHA)
+IMPL(osf_setsysinfo)
+{
+    uint64_t swcr, fpcr, exc, orig_fpcr;
+    int si_code;
+
+    switch (arg1) {
+    case TARGET_SSI_IEEE_FP_CONTROL:
+        if (get_user_u64(swcr, arg2)) {
+            return -TARGET_EFAULT;
+        }
+        orig_fpcr = cpu_alpha_load_fpcr(cpu_env);
+        fpcr = orig_fpcr & FPCR_DYN_MASK;
+
+        /* Copied from linux ieee_swcr_to_fpcr.  */
+        fpcr |= (swcr & SWCR_STATUS_MASK) << 35;
+        fpcr |= (swcr & SWCR_MAP_DMZ) << 36;
+        fpcr |= (~swcr & (SWCR_TRAP_ENABLE_INV
+                          | SWCR_TRAP_ENABLE_DZE
+                          | SWCR_TRAP_ENABLE_OVF)) << 48;
+        fpcr |= (~swcr & (SWCR_TRAP_ENABLE_UNF
+                          | SWCR_TRAP_ENABLE_INE)) << 57;
+        fpcr |= (swcr & SWCR_MAP_UMZ ? FPCR_UNDZ | FPCR_UNFD : 0);
+        fpcr |= (~swcr & SWCR_TRAP_ENABLE_DNO) << 41;
+
+        cpu_alpha_store_fpcr(cpu_env, fpcr);
+        return 0;
+
+    case TARGET_SSI_IEEE_RAISE_EXCEPTION:
+        if (get_user_u64(exc, arg2)) {
+            return -TARGET_EFAULT;
+        }
+        orig_fpcr = cpu_alpha_load_fpcr(cpu_env);
+
+        /* We only add to the exception status here.  */
+        fpcr = orig_fpcr | ((exc & SWCR_STATUS_MASK) << 35);
+        cpu_alpha_store_fpcr(cpu_env, fpcr);
+
+        /* Old exceptions are not signaled.  */
+        fpcr &= ~(orig_fpcr & FPCR_STATUS_MASK);
+
+        /* If any exceptions set by this call,
+           and are unmasked, send a signal.  */
+        si_code = 0;
+        if ((fpcr & (FPCR_INE | FPCR_INED)) == FPCR_INE) {
+            si_code = TARGET_FPE_FLTRES;
+        }
+        if ((fpcr & (FPCR_UNF | FPCR_UNFD)) == FPCR_UNF) {
+            si_code = TARGET_FPE_FLTUND;
+        }
+        if ((fpcr & (FPCR_OVF | FPCR_OVFD)) == FPCR_OVF) {
+            si_code = TARGET_FPE_FLTOVF;
+        }
+        if ((fpcr & (FPCR_DZE | FPCR_DZED)) == FPCR_DZE) {
+            si_code = TARGET_FPE_FLTDIV;
+        }
+        if ((fpcr & (FPCR_INV | FPCR_INVD)) == FPCR_INV) {
+            si_code = TARGET_FPE_FLTINV;
+        }
+        if (si_code != 0) {
+            CPUAlphaState *env = cpu_env;
+            target_siginfo_t info;
+
+            info.si_signo = SIGFPE;
+            info.si_errno = 0;
+            info.si_code = si_code;
+            info._sifields._sigfault._addr = env->pc;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+        }
+        return 0;
+
+    default:
+        /* case SSI_NVPAIRS:
+         * -- Used with SSIN_UACPROC to enable unaligned accesses.
+         * case SSI_IEEE_STATE_AT_SIGNAL:
+         * case SSI_IEEE_IGNORE_STATE_AT_SIGNAL:
+         * -- Not implemented in linux kernel
+         */
+        return -TARGET_EOPNOTSUPP;
+    }
+}
+#endif
+
+#if defined(TARGET_NR_osf_sigprocmask) && defined(TARGET_ALPHA)
+IMPL(osf_sigprocmask)
+{
+    abi_ulong mask = arg2;
+    int how;
+    sigset_t set, oldset;
+
+    switch (arg1) {
+    case TARGET_SIG_BLOCK:
+        how = SIG_BLOCK;
+        break;
+    case TARGET_SIG_UNBLOCK:
+        how = SIG_UNBLOCK;
+        break;
+    case TARGET_SIG_SETMASK:
+        how = SIG_SETMASK;
+        break;
+    default:
+        return -TARGET_EINVAL;
+    }
+    target_to_host_old_sigset(&set, &mask);
+    ret = do_sigprocmask(how, &set, &oldset);
+    if (!ret) {
+        host_to_target_old_sigset(&mask, &oldset);
+        ret = mask;
+    }
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_pause
 IMPL(pause)
 {
@@ -11652,167 +11805,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#if defined(TARGET_NR_osf_getsysinfo) && defined(TARGET_ALPHA)
-    /* Alpha specific */
-    case TARGET_NR_osf_getsysinfo:
-        ret = -TARGET_EOPNOTSUPP;
-        switch (arg1) {
-          case TARGET_GSI_IEEE_FP_CONTROL:
-            {
-                uint64_t swcr, fpcr = cpu_alpha_load_fpcr (cpu_env);
-
-                /* Copied from linux ieee_fpcr_to_swcr.  */
-                swcr = (fpcr >> 35) & SWCR_STATUS_MASK;
-                swcr |= (fpcr >> 36) & SWCR_MAP_DMZ;
-                swcr |= (~fpcr >> 48) & (SWCR_TRAP_ENABLE_INV
-                                        | SWCR_TRAP_ENABLE_DZE
-                                        | SWCR_TRAP_ENABLE_OVF);
-                swcr |= (~fpcr >> 57) & (SWCR_TRAP_ENABLE_UNF
-                                        | SWCR_TRAP_ENABLE_INE);
-                swcr |= (fpcr >> 47) & SWCR_MAP_UMZ;
-                swcr |= (~fpcr >> 41) & SWCR_TRAP_ENABLE_DNO;
-
-                if (put_user_u64 (swcr, arg2))
-                        return -TARGET_EFAULT;
-                ret = 0;
-            }
-            break;
-
-          /* case GSI_IEEE_STATE_AT_SIGNAL:
-             -- Not implemented in linux kernel.
-             case GSI_UACPROC:
-             -- Retrieves current unaligned access state; not much used.
-             case GSI_PROC_TYPE:
-             -- Retrieves implver information; surely not used.
-             case GSI_GET_HWRPB:
-             -- Grabs a copy of the HWRPB; surely not used.
-          */
-        }
-        return ret;
-#endif
-#if defined(TARGET_NR_osf_setsysinfo) && defined(TARGET_ALPHA)
-    /* Alpha specific */
-    case TARGET_NR_osf_setsysinfo:
-        ret = -TARGET_EOPNOTSUPP;
-        switch (arg1) {
-          case TARGET_SSI_IEEE_FP_CONTROL:
-            {
-                uint64_t swcr, fpcr, orig_fpcr;
-
-                if (get_user_u64 (swcr, arg2)) {
-                    return -TARGET_EFAULT;
-                }
-                orig_fpcr = cpu_alpha_load_fpcr(cpu_env);
-                fpcr = orig_fpcr & FPCR_DYN_MASK;
-
-                /* Copied from linux ieee_swcr_to_fpcr.  */
-                fpcr |= (swcr & SWCR_STATUS_MASK) << 35;
-                fpcr |= (swcr & SWCR_MAP_DMZ) << 36;
-                fpcr |= (~swcr & (SWCR_TRAP_ENABLE_INV
-                                  | SWCR_TRAP_ENABLE_DZE
-                                  | SWCR_TRAP_ENABLE_OVF)) << 48;
-                fpcr |= (~swcr & (SWCR_TRAP_ENABLE_UNF
-                                  | SWCR_TRAP_ENABLE_INE)) << 57;
-                fpcr |= (swcr & SWCR_MAP_UMZ ? FPCR_UNDZ | FPCR_UNFD : 0);
-                fpcr |= (~swcr & SWCR_TRAP_ENABLE_DNO) << 41;
-
-                cpu_alpha_store_fpcr(cpu_env, fpcr);
-                ret = 0;
-            }
-            break;
-
-          case TARGET_SSI_IEEE_RAISE_EXCEPTION:
-            {
-                uint64_t exc, fpcr, orig_fpcr;
-                int si_code;
-
-                if (get_user_u64(exc, arg2)) {
-                    return -TARGET_EFAULT;
-                }
-
-                orig_fpcr = cpu_alpha_load_fpcr(cpu_env);
-
-                /* We only add to the exception status here.  */
-                fpcr = orig_fpcr | ((exc & SWCR_STATUS_MASK) << 35);
-
-                cpu_alpha_store_fpcr(cpu_env, fpcr);
-                ret = 0;
-
-                /* Old exceptions are not signaled.  */
-                fpcr &= ~(orig_fpcr & FPCR_STATUS_MASK);
-
-                /* If any exceptions set by this call,
-                   and are unmasked, send a signal.  */
-                si_code = 0;
-                if ((fpcr & (FPCR_INE | FPCR_INED)) == FPCR_INE) {
-                    si_code = TARGET_FPE_FLTRES;
-                }
-                if ((fpcr & (FPCR_UNF | FPCR_UNFD)) == FPCR_UNF) {
-                    si_code = TARGET_FPE_FLTUND;
-                }
-                if ((fpcr & (FPCR_OVF | FPCR_OVFD)) == FPCR_OVF) {
-                    si_code = TARGET_FPE_FLTOVF;
-                }
-                if ((fpcr & (FPCR_DZE | FPCR_DZED)) == FPCR_DZE) {
-                    si_code = TARGET_FPE_FLTDIV;
-                }
-                if ((fpcr & (FPCR_INV | FPCR_INVD)) == FPCR_INV) {
-                    si_code = TARGET_FPE_FLTINV;
-                }
-                if (si_code != 0) {
-                    target_siginfo_t info;
-                    info.si_signo = SIGFPE;
-                    info.si_errno = 0;
-                    info.si_code = si_code;
-                    info._sifields._sigfault._addr
-                        = ((CPUArchState *)cpu_env)->pc;
-                    queue_signal((CPUArchState *)cpu_env, info.si_signo,
-                                 QEMU_SI_FAULT, &info);
-                }
-            }
-            break;
-
-          /* case SSI_NVPAIRS:
-             -- Used with SSIN_UACPROC to enable unaligned accesses.
-             case SSI_IEEE_STATE_AT_SIGNAL:
-             case SSI_IEEE_IGNORE_STATE_AT_SIGNAL:
-             -- Not implemented in linux kernel
-          */
-        }
-        return ret;
-#endif
-#ifdef TARGET_NR_osf_sigprocmask
-    /* Alpha specific.  */
-    case TARGET_NR_osf_sigprocmask:
-        {
-            abi_ulong mask;
-            int how;
-            sigset_t set, oldset;
-
-            switch(arg1) {
-            case TARGET_SIG_BLOCK:
-                how = SIG_BLOCK;
-                break;
-            case TARGET_SIG_UNBLOCK:
-                how = SIG_UNBLOCK;
-                break;
-            case TARGET_SIG_SETMASK:
-                how = SIG_SETMASK;
-                break;
-            default:
-                return -TARGET_EINVAL;
-            }
-            mask = arg2;
-            target_to_host_old_sigset(&set, &mask);
-            ret = do_sigprocmask(how, &set, &oldset);
-            if (!ret) {
-                host_to_target_old_sigset(&mask, &oldset);
-                ret = mask;
-            }
-        }
-        return ret;
-#endif
-
 #ifdef TARGET_NR_getgid32
     case TARGET_NR_getgid32:
         return get_errno(getgid());
@@ -13316,6 +13308,15 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef CONFIG_OPEN_BY_HANDLE
         SYSCALL(open_by_handle_at);
 #endif
+#if defined(TARGET_NR_osf_getsysinfo) && defined(TARGET_ALPHA)
+        SYSCALL(osf_getsysinfo);
+#endif
+#if defined(TARGET_NR_osf_setsysinfo) && defined(TARGET_ALPHA)
+        SYSCALL(osf_setsysinfo);
+#endif
+#if defined(TARGET_NR_osf_sigprocmask) && defined(TARGET_ALPHA)
+        SYSCALL(osf_sigprocmask);
+#endif
 #ifdef TARGET_NR_pause
         SYSCALL(pause);
 #endif
-- 
2.17.1

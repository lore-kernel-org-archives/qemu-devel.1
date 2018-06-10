Received: from eggs.gnu.org ([2001:4830:134:3::10]:40446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdg-0002Mu-2S
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqde-0003T5-Fj
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:32 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:45642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqde-0003Sj-7G
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:30 -0400
Received: by mail-pf0-x243.google.com with SMTP id a22-v6so8479543pfo.12
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:01 -1000
Message-Id: <20180610030220.3777-30-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 029/108] linux-user: Split out rt_sigaction,
 sigaction
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
 linux-user/syscall.c | 325 ++++++++++++++++++++++---------------------
 1 file changed, 165 insertions(+), 160 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d78288258a..cdb4dd5bb4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8622,6 +8622,81 @@ IMPL(rmdir)
 }
 #endif
 
+IMPL(rt_sigaction)
+{
+    abi_long ret;
+#ifdef TARGET_ALPHA
+    /* For Alpha and SPARC this is a 5 argument syscall, with
+     * a 'restorer' parameter which must be copied into the
+     * sa_restorer field of the sigaction struct.
+     * For Alpha that 'restorer' is arg5; for SPARC it is arg4,
+     * and arg5 is the sigsetsize.
+     * Alpha also has a separate rt_sigaction struct that it uses
+     * here; SPARC uses the usual sigaction struct.
+     */
+    struct target_rt_sigaction *rt_act;
+    struct target_sigaction act, oact, *pact = 0;
+
+    if (arg4 != sizeof(target_sigset_t)) {
+        return -TARGET_EINVAL;
+    }
+    if (arg2) {
+        if (!lock_user_struct(VERIFY_READ, rt_act, arg2, 1)) {
+            return -TARGET_EFAULT;
+        }
+        act._sa_handler = rt_act->_sa_handler;
+        act.sa_mask = rt_act->sa_mask;
+        act.sa_flags = rt_act->sa_flags;
+        act.sa_restorer = arg5;
+        unlock_user_struct(rt_act, arg2, 0);
+        pact = &act;
+    }
+    ret = get_errno(do_sigaction(arg1, pact, &oact));
+    if (!is_error(ret) && arg3) {
+        if (!lock_user_struct(VERIFY_WRITE, rt_act, arg3, 0)) {
+            return -TARGET_EFAULT;
+        }
+        rt_act->_sa_handler = oact._sa_handler;
+        rt_act->sa_mask = oact.sa_mask;
+        rt_act->sa_flags = oact.sa_flags;
+        unlock_user_struct(rt_act, arg3, 1);
+    }
+#else
+# ifdef TARGET_SPARC
+    target_ulong restorer = arg4;
+    target_ulong sigsetsize = arg5;
+# else
+    target_ulong sigsetsize = arg4;
+# endif
+    struct target_sigaction *act = NULL;
+    struct target_sigaction *oact = NULL;
+
+    if (sigsetsize != sizeof(target_sigset_t)) {
+        return -TARGET_EINVAL;
+    }
+    if (arg2) {
+        if (!lock_user_struct(VERIFY_READ, act, arg2, 1)) {
+            return -TARGET_EFAULT;
+        }
+# ifdef TARGET_ARCH_HAS_KA_RESTORER
+        act->ka_restorer = restorer;
+# endif
+    }
+    if (arg3 && !lock_user_struct(VERIFY_WRITE, oact, arg3, 0)) {
+        ret = -TARGET_EFAULT;
+    } else {
+        ret = get_errno(do_sigaction(arg1, act, oact));
+    }
+    if (act) {
+        unlock_user_struct(act, arg2, 0);
+    }
+    if (oact) {
+        unlock_user_struct(oact, arg3, 1);
+    }
+#endif
+    return ret;
+}
+
 IMPL(setpgid)
 {
     return get_errno(setpgid(arg1, arg2));
@@ -8632,6 +8707,92 @@ IMPL(setsid)
     return get_errno(setsid());
 }
 
+#ifdef TARGET_NR_sigaction
+IMPL(sigaction)
+{
+    abi_long ret;
+# if defined(TARGET_ALPHA)
+    struct target_sigaction act, oact, *pact = NULL;
+    struct target_old_sigaction *old_act;
+    if (arg2) {
+        if (!lock_user_struct(VERIFY_READ, old_act, arg2, 1)) {
+            return -TARGET_EFAULT;
+        }
+        act._sa_handler = old_act->_sa_handler;
+        target_siginitset(&act.sa_mask, old_act->sa_mask);
+        act.sa_flags = old_act->sa_flags;
+        act.sa_restorer = 0;
+        unlock_user_struct(old_act, arg2, 0);
+        pact = &act;
+    }
+    ret = get_errno(do_sigaction(arg1, pact, &oact));
+    if (!is_error(ret) && arg3) {
+        if (!lock_user_struct(VERIFY_WRITE, old_act, arg3, 0)) {
+            return -TARGET_EFAULT;
+        }
+        old_act->_sa_handler = oact._sa_handler;
+        old_act->sa_mask = oact.sa_mask.sig[0];
+        old_act->sa_flags = oact.sa_flags;
+        unlock_user_struct(old_act, arg3, 1);
+    }
+# elif defined(TARGET_MIPS)
+    struct target_sigaction act, oact, *pact = NULL, *old_act;
+    if (arg2) {
+        if (!lock_user_struct(VERIFY_READ, old_act, arg2, 1)) {
+            return -TARGET_EFAULT;
+        }
+        act._sa_handler = old_act->_sa_handler;
+        target_siginitset(&act.sa_mask, old_act->sa_mask.sig[0]);
+        act.sa_flags = old_act->sa_flags;
+        unlock_user_struct(old_act, arg2, 0);
+        pact = &act;
+    }
+    ret = get_errno(do_sigaction(arg1, pact, &oact));
+    if (!is_error(ret) && arg3) {
+        if (!lock_user_struct(VERIFY_WRITE, old_act, arg3, 0)) {
+            return -TARGET_EFAULT;
+        }
+        old_act->_sa_handler = oact._sa_handler;
+        old_act->sa_flags = oact.sa_flags;
+        old_act->sa_mask.sig[0] = oact.sa_mask.sig[0];
+        old_act->sa_mask.sig[1] = 0;
+        old_act->sa_mask.sig[2] = 0;
+        old_act->sa_mask.sig[3] = 0;
+        unlock_user_struct(old_act, arg3, 1);
+    }
+# else
+    struct target_sigaction act, oact, *pact = NULL;
+    struct target_old_sigaction *old_act;
+    if (arg2) {
+        if (!lock_user_struct(VERIFY_READ, old_act, arg2, 1)) {
+            return -TARGET_EFAULT;
+        }
+        act._sa_handler = old_act->_sa_handler;
+        target_siginitset(&act.sa_mask, old_act->sa_mask);
+        act.sa_flags = old_act->sa_flags;
+        act.sa_restorer = old_act->sa_restorer;
+#  ifdef TARGET_ARCH_HAS_KA_RESTORER
+        act.ka_restorer = 0;
+#  endif
+        unlock_user_struct(old_act, arg2, 0);
+        pact = &act;
+    }
+    ret = get_errno(do_sigaction(arg1, pact, &oact));
+    if (!is_error(ret) && arg3) {
+        if (!lock_user_struct(VERIFY_WRITE, old_act, arg3, 0)) {
+            return -TARGET_EFAULT;
+        }
+        old_act->_sa_handler = oact._sa_handler;
+        old_act->sa_mask = oact.sa_mask.sig[0];
+        old_act->sa_flags = oact.sa_flags;
+        old_act->sa_restorer = oact.sa_restorer;
+        unlock_user_struct(old_act, arg3, 1);
+    }
+# endif
+    return ret;
+}
+#endif
+
 #ifdef TARGET_NR_stime
 IMPL(stime)
 {
@@ -8873,166 +9034,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_sigaction
-    case TARGET_NR_sigaction:
-        {
-#if defined(TARGET_ALPHA)
-            struct target_sigaction act, oact, *pact = 0;
-            struct target_old_sigaction *old_act;
-            if (arg2) {
-                if (!lock_user_struct(VERIFY_READ, old_act, arg2, 1))
-                    return -TARGET_EFAULT;
-                act._sa_handler = old_act->_sa_handler;
-                target_siginitset(&act.sa_mask, old_act->sa_mask);
-                act.sa_flags = old_act->sa_flags;
-                act.sa_restorer = 0;
-                unlock_user_struct(old_act, arg2, 0);
-                pact = &act;
-            }
-            ret = get_errno(do_sigaction(arg1, pact, &oact));
-            if (!is_error(ret) && arg3) {
-                if (!lock_user_struct(VERIFY_WRITE, old_act, arg3, 0))
-                    return -TARGET_EFAULT;
-                old_act->_sa_handler = oact._sa_handler;
-                old_act->sa_mask = oact.sa_mask.sig[0];
-                old_act->sa_flags = oact.sa_flags;
-                unlock_user_struct(old_act, arg3, 1);
-            }
-#elif defined(TARGET_MIPS)
-	    struct target_sigaction act, oact, *pact, *old_act;
-
-	    if (arg2) {
-                if (!lock_user_struct(VERIFY_READ, old_act, arg2, 1))
-                    return -TARGET_EFAULT;
-		act._sa_handler = old_act->_sa_handler;
-		target_siginitset(&act.sa_mask, old_act->sa_mask.sig[0]);
-		act.sa_flags = old_act->sa_flags;
-		unlock_user_struct(old_act, arg2, 0);
-		pact = &act;
-	    } else {
-		pact = NULL;
-	    }
-
-	    ret = get_errno(do_sigaction(arg1, pact, &oact));
-
-	    if (!is_error(ret) && arg3) {
-                if (!lock_user_struct(VERIFY_WRITE, old_act, arg3, 0))
-                    return -TARGET_EFAULT;
-		old_act->_sa_handler = oact._sa_handler;
-		old_act->sa_flags = oact.sa_flags;
-		old_act->sa_mask.sig[0] = oact.sa_mask.sig[0];
-		old_act->sa_mask.sig[1] = 0;
-		old_act->sa_mask.sig[2] = 0;
-		old_act->sa_mask.sig[3] = 0;
-		unlock_user_struct(old_act, arg3, 1);
-	    }
-#else
-            struct target_old_sigaction *old_act;
-            struct target_sigaction act, oact, *pact;
-            if (arg2) {
-                if (!lock_user_struct(VERIFY_READ, old_act, arg2, 1))
-                    return -TARGET_EFAULT;
-                act._sa_handler = old_act->_sa_handler;
-                target_siginitset(&act.sa_mask, old_act->sa_mask);
-                act.sa_flags = old_act->sa_flags;
-                act.sa_restorer = old_act->sa_restorer;
-#ifdef TARGET_ARCH_HAS_KA_RESTORER
-                act.ka_restorer = 0;
-#endif
-                unlock_user_struct(old_act, arg2, 0);
-                pact = &act;
-            } else {
-                pact = NULL;
-            }
-            ret = get_errno(do_sigaction(arg1, pact, &oact));
-            if (!is_error(ret) && arg3) {
-                if (!lock_user_struct(VERIFY_WRITE, old_act, arg3, 0))
-                    return -TARGET_EFAULT;
-                old_act->_sa_handler = oact._sa_handler;
-                old_act->sa_mask = oact.sa_mask.sig[0];
-                old_act->sa_flags = oact.sa_flags;
-                old_act->sa_restorer = oact.sa_restorer;
-                unlock_user_struct(old_act, arg3, 1);
-            }
-#endif
-        }
-        return ret;
-#endif
-    case TARGET_NR_rt_sigaction:
-        {
-#if defined(TARGET_ALPHA)
-            /* For Alpha and SPARC this is a 5 argument syscall, with
-             * a 'restorer' parameter which must be copied into the
-             * sa_restorer field of the sigaction struct.
-             * For Alpha that 'restorer' is arg5; for SPARC it is arg4,
-             * and arg5 is the sigsetsize.
-             * Alpha also has a separate rt_sigaction struct that it uses
-             * here; SPARC uses the usual sigaction struct.
-             */
-            struct target_rt_sigaction *rt_act;
-            struct target_sigaction act, oact, *pact = 0;
-
-            if (arg4 != sizeof(target_sigset_t)) {
-                return -TARGET_EINVAL;
-            }
-            if (arg2) {
-                if (!lock_user_struct(VERIFY_READ, rt_act, arg2, 1))
-                    return -TARGET_EFAULT;
-                act._sa_handler = rt_act->_sa_handler;
-                act.sa_mask = rt_act->sa_mask;
-                act.sa_flags = rt_act->sa_flags;
-                act.sa_restorer = arg5;
-                unlock_user_struct(rt_act, arg2, 0);
-                pact = &act;
-            }
-            ret = get_errno(do_sigaction(arg1, pact, &oact));
-            if (!is_error(ret) && arg3) {
-                if (!lock_user_struct(VERIFY_WRITE, rt_act, arg3, 0))
-                    return -TARGET_EFAULT;
-                rt_act->_sa_handler = oact._sa_handler;
-                rt_act->sa_mask = oact.sa_mask;
-                rt_act->sa_flags = oact.sa_flags;
-                unlock_user_struct(rt_act, arg3, 1);
-            }
-#else
-#ifdef TARGET_SPARC
-            target_ulong restorer = arg4;
-            target_ulong sigsetsize = arg5;
-#else
-            target_ulong sigsetsize = arg4;
-#endif
-            struct target_sigaction *act;
-            struct target_sigaction *oact;
-
-            if (sigsetsize != sizeof(target_sigset_t)) {
-                return -TARGET_EINVAL;
-            }
-            if (arg2) {
-                if (!lock_user_struct(VERIFY_READ, act, arg2, 1)) {
-                    return -TARGET_EFAULT;
-                }
-#ifdef TARGET_ARCH_HAS_KA_RESTORER
-                act->ka_restorer = restorer;
-#endif
-            } else {
-                act = NULL;
-            }
-            if (arg3) {
-                if (!lock_user_struct(VERIFY_WRITE, oact, arg3, 0)) {
-                    ret = -TARGET_EFAULT;
-                    goto rt_sigaction_fail;
-                }
-            } else
-                oact = NULL;
-            ret = get_errno(do_sigaction(arg1, act, oact));
-	rt_sigaction_fail:
-            if (act)
-                unlock_user_struct(act, arg2, 0);
-            if (oact)
-                unlock_user_struct(oact, arg3, 1);
-#endif
-        }
-        return ret;
 #ifdef TARGET_NR_sgetmask /* not on alpha */
     case TARGET_NR_sgetmask:
         {
@@ -12741,8 +12742,12 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_rmdir
         SYSCALL(rmdir);
 #endif
+        SYSCALL(rt_sigaction);
         SYSCALL(setpgid);
         SYSCALL(setsid);
+#ifdef TARGET_NR_sigaction
+        SYSCALL(sigaction);
+#endif
 #ifdef TARGET_NR_stime
         SYSCALL(stime);
 #endif
-- 
2.17.1

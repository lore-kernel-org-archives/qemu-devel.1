Received: from eggs.gnu.org ([2001:4830:134:3::10]:58525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f0Xbq-0003MH-Pu
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f0Xbp-0001dE-Cd
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:16:46 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 26 Mar 2018 21:15:53 +0200
Message-Id: <20180326191603.10217-10-laurent@vivier.eu>
In-Reply-To: <20180326191603.10217-1-laurent@vivier.eu>
References: <20180326191603.10217-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 09/19] linux-user: move openrisc cpu
 loop to openrisc directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>

No code change, only move code from main.c to
openrisc/cpu_loop.c.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/main.c              | 96 ------------------------------------------
 linux-user/openrisc/cpu_loop.c | 89 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 96 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 6ee474e5c2..8530dbfdf1 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -149,92 +149,6 @@ void fork_end(int child)
     }
 }
 
-#ifdef TARGET_OPENRISC
-
-void cpu_loop(CPUOpenRISCState *env)
-{
-    CPUState *cs = CPU(openrisc_env_get_cpu(env));
-    int trapnr;
-    abi_long ret;
-    target_siginfo_t info;
-
-    for (;;) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
-
-        switch (trapnr) {
-        case EXCP_SYSCALL:
-            env->pc += 4;   /* 0xc00; */
-            ret = do_syscall(env,
-                             cpu_get_gpr(env, 11), /* return value       */
-                             cpu_get_gpr(env, 3),  /* r3 - r7 are params */
-                             cpu_get_gpr(env, 4),
-                             cpu_get_gpr(env, 5),
-                             cpu_get_gpr(env, 6),
-                             cpu_get_gpr(env, 7),
-                             cpu_get_gpr(env, 8), 0, 0);
-            if (ret == -TARGET_ERESTARTSYS) {
-                env->pc -= 4;
-            } else if (ret != -TARGET_QEMU_ESIGRETURN) {
-                cpu_set_gpr(env, 11, ret);
-            }
-            break;
-        case EXCP_DPF:
-        case EXCP_IPF:
-        case EXCP_RANGE:
-            info.si_signo = TARGET_SIGSEGV;
-            info.si_errno = 0;
-            info.si_code = TARGET_SEGV_MAPERR;
-            info._sifields._sigfault._addr = env->pc;
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            break;
-        case EXCP_ALIGN:
-            info.si_signo = TARGET_SIGBUS;
-            info.si_errno = 0;
-            info.si_code = TARGET_BUS_ADRALN;
-            info._sifields._sigfault._addr = env->pc;
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            break;
-        case EXCP_ILLEGAL:
-            info.si_signo = TARGET_SIGILL;
-            info.si_errno = 0;
-            info.si_code = TARGET_ILL_ILLOPC;
-            info._sifields._sigfault._addr = env->pc;
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            break;
-        case EXCP_FPE:
-            info.si_signo = TARGET_SIGFPE;
-            info.si_errno = 0;
-            info.si_code = 0;
-            info._sifields._sigfault._addr = env->pc;
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            break;
-        case EXCP_INTERRUPT:
-            /* We processed the pending cpu work above.  */
-            break;
-        case EXCP_DEBUG:
-            trapnr = gdb_handlesig(cs, TARGET_SIGTRAP);
-            if (trapnr) {
-                info.si_signo = trapnr;
-                info.si_errno = 0;
-                info.si_code = TARGET_TRAP_BRKPT;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            }
-            break;
-        case EXCP_ATOMIC:
-            cpu_exec_step_atomic(cs);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        process_pending_signals(env);
-    }
-}
-
-#endif /* TARGET_OPENRISC */
-
 #ifdef TARGET_SH4
 void cpu_loop(CPUSH4State *env)
 {
@@ -2439,16 +2353,6 @@ int main(int argc, char **argv, char **envp)
         env->regs[31] = regs->r31;	    
         env->sregs[SR_PC] = regs->pc;
     }
-#elif defined(TARGET_OPENRISC)
-    {
-        int i;
-
-        for (i = 0; i < 32; i++) {
-            cpu_set_gpr(env, i, regs->gpr[i]);
-        }
-        env->pc = regs->pc;
-        cpu_set_sr(env, regs->sr);
-    }
 #elif defined(TARGET_RISCV)
     {
         env->pc = regs->sepc;
diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/openrisc/cpu_loop.c
index b7700a5561..6c6ea871e1 100644
--- a/linux-user/openrisc/cpu_loop.c
+++ b/linux-user/openrisc/cpu_loop.c
@@ -21,6 +21,95 @@
 #include "qemu.h"
 #include "cpu_loop-common.h"
 
+void cpu_loop(CPUOpenRISCState *env)
+{
+    CPUState *cs = CPU(openrisc_env_get_cpu(env));
+    int trapnr;
+    abi_long ret;
+    target_siginfo_t info;
+
+    for (;;) {
+        cpu_exec_start(cs);
+        trapnr = cpu_exec(cs);
+        cpu_exec_end(cs);
+        process_queued_cpu_work(cs);
+
+        switch (trapnr) {
+        case EXCP_SYSCALL:
+            env->pc += 4;   /* 0xc00; */
+            ret = do_syscall(env,
+                             cpu_get_gpr(env, 11), /* return value       */
+                             cpu_get_gpr(env, 3),  /* r3 - r7 are params */
+                             cpu_get_gpr(env, 4),
+                             cpu_get_gpr(env, 5),
+                             cpu_get_gpr(env, 6),
+                             cpu_get_gpr(env, 7),
+                             cpu_get_gpr(env, 8), 0, 0);
+            if (ret == -TARGET_ERESTARTSYS) {
+                env->pc -= 4;
+            } else if (ret != -TARGET_QEMU_ESIGRETURN) {
+                cpu_set_gpr(env, 11, ret);
+            }
+            break;
+        case EXCP_DPF:
+        case EXCP_IPF:
+        case EXCP_RANGE:
+            info.si_signo = TARGET_SIGSEGV;
+            info.si_errno = 0;
+            info.si_code = TARGET_SEGV_MAPERR;
+            info._sifields._sigfault._addr = env->pc;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
+        case EXCP_ALIGN:
+            info.si_signo = TARGET_SIGBUS;
+            info.si_errno = 0;
+            info.si_code = TARGET_BUS_ADRALN;
+            info._sifields._sigfault._addr = env->pc;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
+        case EXCP_ILLEGAL:
+            info.si_signo = TARGET_SIGILL;
+            info.si_errno = 0;
+            info.si_code = TARGET_ILL_ILLOPC;
+            info._sifields._sigfault._addr = env->pc;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
+        case EXCP_FPE:
+            info.si_signo = TARGET_SIGFPE;
+            info.si_errno = 0;
+            info.si_code = 0;
+            info._sifields._sigfault._addr = env->pc;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
+        case EXCP_INTERRUPT:
+            /* We processed the pending cpu work above.  */
+            break;
+        case EXCP_DEBUG:
+            trapnr = gdb_handlesig(cs, TARGET_SIGTRAP);
+            if (trapnr) {
+                info.si_signo = trapnr;
+                info.si_errno = 0;
+                info.si_code = TARGET_TRAP_BRKPT;
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            }
+            break;
+        case EXCP_ATOMIC:
+            cpu_exec_step_atomic(cs);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        process_pending_signals(env);
+    }
+}
+
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
+    int i;
+
+    for (i = 0; i < 32; i++) {
+        cpu_set_gpr(env, i, regs->gpr[i]);
+    }
+    env->pc = regs->pc;
+    cpu_set_sr(env, regs->sr);
 }
-- 
2.14.3

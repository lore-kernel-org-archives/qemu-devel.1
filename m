Received: from eggs.gnu.org ([2001:4830:134:3::10]:33431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD4qa-0006rK-Uq
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD4qU-0006gJ-S0
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:11:48 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Apr 2018 11:10:26 +0200
Message-Id: <20180430091037.13878-32-laurent@vivier.eu>
In-Reply-To: <20180430091037.13878-1-laurent@vivier.eu>
References: <20180430091037.13878-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 31/42] linux-user: move openrisc cpu loop to
 openrisc directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Cornelia Huck <cohuck@redhat.com>

No code change, only move code from main.c to
openrisc/cpu_loop.c.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180411185651.21351-10-laurent@vivier.eu>
---
 linux-user/main.c              | 96 ------------------------------------------
 linux-user/openrisc/cpu_loop.c | 89 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 96 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 88f807549f..af26a17c46 100644
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
@@ -2442,16 +2356,6 @@ int main(int argc, char **argv, char **envp)
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

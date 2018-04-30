Received: from eggs.gnu.org ([2001:4830:134:3::10]:33291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD4qT-0006ip-99
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD4qM-0006Wr-6J
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:11:41 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Apr 2018 11:10:30 +0200
Message-Id: <20180430091037.13878-36-laurent@vivier.eu>
In-Reply-To: <20180430091037.13878-1-laurent@vivier.eu>
References: <20180430091037.13878-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 35/42] linux-user: move m68k cpu loop to m68k
 directory
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
m68k/cpu_loop.c.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180411185651.21351-14-laurent@vivier.eu>
---
 linux-user/m68k/cpu_loop.c | 144 +++++++++++++++++++++++++++++++++++++++++++
 linux-user/main.c          | 150 +--------------------------------------------
 2 files changed, 145 insertions(+), 149 deletions(-)

diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index b7700a5561..b4d3d8af3d 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -21,6 +21,150 @@
 #include "qemu.h"
 #include "cpu_loop-common.h"
 
+void cpu_loop(CPUM68KState *env)
+{
+    CPUState *cs = CPU(m68k_env_get_cpu(env));
+    int trapnr;
+    unsigned int n;
+    target_siginfo_t info;
+    TaskState *ts = cs->opaque;
+
+    for(;;) {
+        cpu_exec_start(cs);
+        trapnr = cpu_exec(cs);
+        cpu_exec_end(cs);
+        process_queued_cpu_work(cs);
+
+        switch(trapnr) {
+        case EXCP_ILLEGAL:
+            {
+                if (ts->sim_syscalls) {
+                    uint16_t nr;
+                    get_user_u16(nr, env->pc + 2);
+                    env->pc += 4;
+                    do_m68k_simcall(env, nr);
+                } else {
+                    goto do_sigill;
+                }
+            }
+            break;
+        case EXCP_HALT_INSN:
+            /* Semihosing syscall.  */
+            env->pc += 4;
+            do_m68k_semihosting(env, env->dregs[0]);
+            break;
+        case EXCP_LINEA:
+        case EXCP_LINEF:
+        case EXCP_UNSUPPORTED:
+        do_sigill:
+            info.si_signo = TARGET_SIGILL;
+            info.si_errno = 0;
+            info.si_code = TARGET_ILL_ILLOPN;
+            info._sifields._sigfault._addr = env->pc;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
+        case EXCP_CHK:
+            info.si_signo = TARGET_SIGFPE;
+            info.si_errno = 0;
+            info.si_code = TARGET_FPE_INTOVF;
+            info._sifields._sigfault._addr = env->pc;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
+        case EXCP_DIV0:
+            info.si_signo = TARGET_SIGFPE;
+            info.si_errno = 0;
+            info.si_code = TARGET_FPE_INTDIV;
+            info._sifields._sigfault._addr = env->pc;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
+        case EXCP_TRAP0:
+            {
+                abi_long ret;
+                ts->sim_syscalls = 0;
+                n = env->dregs[0];
+                env->pc += 2;
+                ret = do_syscall(env,
+                                 n,
+                                 env->dregs[1],
+                                 env->dregs[2],
+                                 env->dregs[3],
+                                 env->dregs[4],
+                                 env->dregs[5],
+                                 env->aregs[0],
+                                 0, 0);
+                if (ret == -TARGET_ERESTARTSYS) {
+                    env->pc -= 2;
+                } else if (ret != -TARGET_QEMU_ESIGRETURN) {
+                    env->dregs[0] = ret;
+                }
+            }
+            break;
+        case EXCP_INTERRUPT:
+            /* just indicate that signals should be handled asap */
+            break;
+        case EXCP_ACCESS:
+            {
+                info.si_signo = TARGET_SIGSEGV;
+                info.si_errno = 0;
+                /* XXX: check env->error_code */
+                info.si_code = TARGET_SEGV_MAPERR;
+                info._sifields._sigfault._addr = env->mmu.ar;
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            }
+            break;
+        case EXCP_DEBUG:
+            {
+                int sig;
+
+                sig = gdb_handlesig(cs, TARGET_SIGTRAP);
+                if (sig)
+                  {
+                    info.si_signo = sig;
+                    info.si_errno = 0;
+                    info.si_code = TARGET_TRAP_BRKPT;
+                    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                  }
+            }
+            break;
+        case EXCP_ATOMIC:
+            cpu_exec_step_atomic(cs);
+            break;
+        default:
+            EXCP_DUMP(env, "qemu: unhandled CPU exception 0x%x - aborting\n", trapnr);
+            abort();
+        }
+        process_pending_signals(env);
+    }
+}
+
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
+    CPUState *cpu = ENV_GET_CPU(env);
+    TaskState *ts = cpu->opaque;
+    struct image_info *info = ts->info;
+
+    env->pc = regs->pc;
+    env->dregs[0] = regs->d0;
+    env->dregs[1] = regs->d1;
+    env->dregs[2] = regs->d2;
+    env->dregs[3] = regs->d3;
+    env->dregs[4] = regs->d4;
+    env->dregs[5] = regs->d5;
+    env->dregs[6] = regs->d6;
+    env->dregs[7] = regs->d7;
+    env->aregs[0] = regs->a0;
+    env->aregs[1] = regs->a1;
+    env->aregs[2] = regs->a2;
+    env->aregs[3] = regs->a3;
+    env->aregs[4] = regs->a4;
+    env->aregs[5] = regs->a5;
+    env->aregs[6] = regs->a6;
+    env->aregs[7] = regs->usp;
+    env->sr = regs->sr;
+
+    ts->sim_syscalls = 1;
+    ts->stack_base = info->start_stack;
+    ts->heap_base = info->brk;
+    /* This will be filled in on the first SYS_HEAPINFO call.  */
+    ts->heap_limit = 0;
 }
diff --git a/linux-user/main.c b/linux-user/main.c
index 9e49c8a30c..7c223a5629 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -149,125 +149,6 @@ void fork_end(int child)
     }
 }
 
-#ifdef TARGET_M68K
-
-void cpu_loop(CPUM68KState *env)
-{
-    CPUState *cs = CPU(m68k_env_get_cpu(env));
-    int trapnr;
-    unsigned int n;
-    target_siginfo_t info;
-    TaskState *ts = cs->opaque;
-
-    for(;;) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
-
-        switch(trapnr) {
-        case EXCP_ILLEGAL:
-            {
-                if (ts->sim_syscalls) {
-                    uint16_t nr;
-                    get_user_u16(nr, env->pc + 2);
-                    env->pc += 4;
-                    do_m68k_simcall(env, nr);
-                } else {
-                    goto do_sigill;
-                }
-            }
-            break;
-        case EXCP_HALT_INSN:
-            /* Semihosing syscall.  */
-            env->pc += 4;
-            do_m68k_semihosting(env, env->dregs[0]);
-            break;
-        case EXCP_LINEA:
-        case EXCP_LINEF:
-        case EXCP_UNSUPPORTED:
-        do_sigill:
-            info.si_signo = TARGET_SIGILL;
-            info.si_errno = 0;
-            info.si_code = TARGET_ILL_ILLOPN;
-            info._sifields._sigfault._addr = env->pc;
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            break;
-        case EXCP_CHK:
-            info.si_signo = TARGET_SIGFPE;
-            info.si_errno = 0;
-            info.si_code = TARGET_FPE_INTOVF;
-            info._sifields._sigfault._addr = env->pc;
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            break;
-        case EXCP_DIV0:
-            info.si_signo = TARGET_SIGFPE;
-            info.si_errno = 0;
-            info.si_code = TARGET_FPE_INTDIV;
-            info._sifields._sigfault._addr = env->pc;
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            break;
-        case EXCP_TRAP0:
-            {
-                abi_long ret;
-                ts->sim_syscalls = 0;
-                n = env->dregs[0];
-                env->pc += 2;
-                ret = do_syscall(env,
-                                 n,
-                                 env->dregs[1],
-                                 env->dregs[2],
-                                 env->dregs[3],
-                                 env->dregs[4],
-                                 env->dregs[5],
-                                 env->aregs[0],
-                                 0, 0);
-                if (ret == -TARGET_ERESTARTSYS) {
-                    env->pc -= 2;
-                } else if (ret != -TARGET_QEMU_ESIGRETURN) {
-                    env->dregs[0] = ret;
-                }
-            }
-            break;
-        case EXCP_INTERRUPT:
-            /* just indicate that signals should be handled asap */
-            break;
-        case EXCP_ACCESS:
-            {
-                info.si_signo = TARGET_SIGSEGV;
-                info.si_errno = 0;
-                /* XXX: check env->error_code */
-                info.si_code = TARGET_SEGV_MAPERR;
-                info._sifields._sigfault._addr = env->mmu.ar;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            }
-            break;
-        case EXCP_DEBUG:
-            {
-                int sig;
-
-                sig = gdb_handlesig(cs, TARGET_SIGTRAP);
-                if (sig)
-                  {
-                    info.si_signo = sig;
-                    info.si_errno = 0;
-                    info.si_code = TARGET_TRAP_BRKPT;
-                    queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-                  }
-            }
-            break;
-        case EXCP_ATOMIC:
-            cpu_exec_step_atomic(cs);
-            break;
-        default:
-            EXCP_DUMP(env, "qemu: unhandled CPU exception 0x%x - aborting\n", trapnr);
-            abort();
-        }
-        process_pending_signals(env);
-    }
-}
-#endif /* TARGET_M68K */
-
 #ifdef TARGET_ALPHA
 void cpu_loop(CPUAlphaState *env)
 {
@@ -2028,29 +1909,7 @@ int main(int argc, char **argv, char **envp)
 
     target_cpu_copy_regs(env, regs);
 
-#if defined(TARGET_M68K)
-    {
-        env->pc = regs->pc;
-        env->dregs[0] = regs->d0;
-        env->dregs[1] = regs->d1;
-        env->dregs[2] = regs->d2;
-        env->dregs[3] = regs->d3;
-        env->dregs[4] = regs->d4;
-        env->dregs[5] = regs->d5;
-        env->dregs[6] = regs->d6;
-        env->dregs[7] = regs->d7;
-        env->aregs[0] = regs->a0;
-        env->aregs[1] = regs->a1;
-        env->aregs[2] = regs->a2;
-        env->aregs[3] = regs->a3;
-        env->aregs[4] = regs->a4;
-        env->aregs[5] = regs->a5;
-        env->aregs[6] = regs->a6;
-        env->aregs[7] = regs->usp;
-        env->sr = regs->sr;
-        ts->sim_syscalls = 1;
-    }
-#elif defined(TARGET_RISCV)
+#if defined(TARGET_RISCV)
     {
         env->pc = regs->sepc;
         env->gpr[xSP] = regs->sp;
@@ -2105,13 +1964,6 @@ int main(int argc, char **argv, char **envp)
     }
 #endif
 
-#if defined(TARGET_M68K)
-    ts->stack_base = info->start_stack;
-    ts->heap_base = info->brk;
-    /* This will be filled in on the first SYS_HEAPINFO call.  */
-    ts->heap_limit = 0;
-#endif
-
     if (gdbstub_port) {
         if (gdbserver_start(gdbstub_port) < 0) {
             fprintf(stderr, "qemu: could not open gdbserver on port %d\n",
-- 
2.14.3

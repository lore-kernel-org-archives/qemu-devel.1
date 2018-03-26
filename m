Received: from eggs.gnu.org ([2001:4830:134:3::10]:58860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f0Xc8-0003fu-E5
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f0Xc4-0001lF-9g
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:17:04 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 26 Mar 2018 21:15:58 +0200
Message-Id: <20180326191603.10217-15-laurent@vivier.eu>
In-Reply-To: <20180326191603.10217-1-laurent@vivier.eu>
References: <20180326191603.10217-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 14/19] linux-user: move alpha cpu loop
 to alpha directory
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
alpha/cpu_loop.c.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/alpha/cpu_loop.c | 199 ++++++++++++++++++++++++++++++++++++++++++
 linux-user/main.c           | 204 --------------------------------------------
 2 files changed, 199 insertions(+), 204 deletions(-)

diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index b7700a5561..b87fcaea87 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -21,6 +21,205 @@
 #include "qemu.h"
 #include "cpu_loop-common.h"
 
+void cpu_loop(CPUAlphaState *env)
+{
+    CPUState *cs = CPU(alpha_env_get_cpu(env));
+    int trapnr;
+    target_siginfo_t info;
+    abi_long sysret;
+
+    while (1) {
+        bool arch_interrupt = true;
+
+        cpu_exec_start(cs);
+        trapnr = cpu_exec(cs);
+        cpu_exec_end(cs);
+        process_queued_cpu_work(cs);
+
+        switch (trapnr) {
+        case EXCP_RESET:
+            fprintf(stderr, "Reset requested. Exit\n");
+            exit(EXIT_FAILURE);
+            break;
+        case EXCP_MCHK:
+            fprintf(stderr, "Machine check exception. Exit\n");
+            exit(EXIT_FAILURE);
+            break;
+        case EXCP_SMP_INTERRUPT:
+        case EXCP_CLK_INTERRUPT:
+        case EXCP_DEV_INTERRUPT:
+            fprintf(stderr, "External interrupt. Exit\n");
+            exit(EXIT_FAILURE);
+            break;
+        case EXCP_MMFAULT:
+            info.si_signo = TARGET_SIGSEGV;
+            info.si_errno = 0;
+            info.si_code = (page_get_flags(env->trap_arg0) & PAGE_VALID
+                            ? TARGET_SEGV_ACCERR : TARGET_SEGV_MAPERR);
+            info._sifields._sigfault._addr = env->trap_arg0;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
+        case EXCP_UNALIGN:
+            info.si_signo = TARGET_SIGBUS;
+            info.si_errno = 0;
+            info.si_code = TARGET_BUS_ADRALN;
+            info._sifields._sigfault._addr = env->trap_arg0;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
+        case EXCP_OPCDEC:
+        do_sigill:
+            info.si_signo = TARGET_SIGILL;
+            info.si_errno = 0;
+            info.si_code = TARGET_ILL_ILLOPC;
+            info._sifields._sigfault._addr = env->pc;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
+        case EXCP_ARITH:
+            info.si_signo = TARGET_SIGFPE;
+            info.si_errno = 0;
+            info.si_code = TARGET_FPE_FLTINV;
+            info._sifields._sigfault._addr = env->pc;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
+        case EXCP_FEN:
+            /* No-op.  Linux simply re-enables the FPU.  */
+            break;
+        case EXCP_CALL_PAL:
+            switch (env->error_code) {
+            case 0x80:
+                /* BPT */
+                info.si_signo = TARGET_SIGTRAP;
+                info.si_errno = 0;
+                info.si_code = TARGET_TRAP_BRKPT;
+                info._sifields._sigfault._addr = env->pc;
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                break;
+            case 0x81:
+                /* BUGCHK */
+                info.si_signo = TARGET_SIGTRAP;
+                info.si_errno = 0;
+                info.si_code = 0;
+                info._sifields._sigfault._addr = env->pc;
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                break;
+            case 0x83:
+                /* CALLSYS */
+                trapnr = env->ir[IR_V0];
+                sysret = do_syscall(env, trapnr,
+                                    env->ir[IR_A0], env->ir[IR_A1],
+                                    env->ir[IR_A2], env->ir[IR_A3],
+                                    env->ir[IR_A4], env->ir[IR_A5],
+                                    0, 0);
+                if (sysret == -TARGET_ERESTARTSYS) {
+                    env->pc -= 4;
+                    break;
+                }
+                if (sysret == -TARGET_QEMU_ESIGRETURN) {
+                    break;
+                }
+                /* Syscall writes 0 to V0 to bypass error check, similar
+                   to how this is handled internal to Linux kernel.
+                   (Ab)use trapnr temporarily as boolean indicating error.  */
+                trapnr = (env->ir[IR_V0] != 0 && sysret < 0);
+                env->ir[IR_V0] = (trapnr ? -sysret : sysret);
+                env->ir[IR_A3] = trapnr;
+                break;
+            case 0x86:
+                /* IMB */
+                /* ??? We can probably elide the code using page_unprotect
+                   that is checking for self-modifying code.  Instead we
+                   could simply call tb_flush here.  Until we work out the
+                   changes required to turn off the extra write protection,
+                   this can be a no-op.  */
+                break;
+            case 0x9E:
+                /* RDUNIQUE */
+                /* Handled in the translator for usermode.  */
+                abort();
+            case 0x9F:
+                /* WRUNIQUE */
+                /* Handled in the translator for usermode.  */
+                abort();
+            case 0xAA:
+                /* GENTRAP */
+                info.si_signo = TARGET_SIGFPE;
+                switch (env->ir[IR_A0]) {
+                case TARGET_GEN_INTOVF:
+                    info.si_code = TARGET_FPE_INTOVF;
+                    break;
+                case TARGET_GEN_INTDIV:
+                    info.si_code = TARGET_FPE_INTDIV;
+                    break;
+                case TARGET_GEN_FLTOVF:
+                    info.si_code = TARGET_FPE_FLTOVF;
+                    break;
+                case TARGET_GEN_FLTUND:
+                    info.si_code = TARGET_FPE_FLTUND;
+                    break;
+                case TARGET_GEN_FLTINV:
+                    info.si_code = TARGET_FPE_FLTINV;
+                    break;
+                case TARGET_GEN_FLTINE:
+                    info.si_code = TARGET_FPE_FLTRES;
+                    break;
+                case TARGET_GEN_ROPRAND:
+                    info.si_code = 0;
+                    break;
+                default:
+                    info.si_signo = TARGET_SIGTRAP;
+                    info.si_code = 0;
+                    break;
+                }
+                info.si_errno = 0;
+                info._sifields._sigfault._addr = env->pc;
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                break;
+            default:
+                goto do_sigill;
+            }
+            break;
+        case EXCP_DEBUG:
+            info.si_signo = gdb_handlesig(cs, TARGET_SIGTRAP);
+            if (info.si_signo) {
+                info.si_errno = 0;
+                info.si_code = TARGET_TRAP_BRKPT;
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            } else {
+                arch_interrupt = false;
+            }
+            break;
+        case EXCP_INTERRUPT:
+            /* Just indicate that signals should be handled asap.  */
+            break;
+        case EXCP_ATOMIC:
+            cpu_exec_step_atomic(cs);
+            arch_interrupt = false;
+            break;
+        default:
+            printf ("Unhandled trap: 0x%x\n", trapnr);
+            cpu_dump_state(cs, stderr, fprintf, 0);
+            exit(EXIT_FAILURE);
+        }
+        process_pending_signals (env);
+
+        /* Most of the traps imply a transition through PALcode, which
+           implies an REI instruction has been executed.  Which means
+           that RX and LOCK_ADDR should be cleared.  But there are a
+           few exceptions for traps internal to QEMU.  */
+        if (arch_interrupt) {
+            env->flags &= ~ENV_FLAG_RX_FLAG;
+            env->lock_addr = -1;
+        }
+    }
+}
+
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
+    int i;
+
+    for(i = 0; i < 28; i++) {
+        env->ir[i] = ((abi_ulong *)regs)[i];
+    }
+    env->ir[IR_SP] = regs->usp;
+    env->pc = regs->pc;
 }
diff --git a/linux-user/main.c b/linux-user/main.c
index 2a9afb6659..a3c68dad36 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -149,200 +149,6 @@ void fork_end(int child)
     }
 }
 
-#ifdef TARGET_ALPHA
-void cpu_loop(CPUAlphaState *env)
-{
-    CPUState *cs = CPU(alpha_env_get_cpu(env));
-    int trapnr;
-    target_siginfo_t info;
-    abi_long sysret;
-
-    while (1) {
-        bool arch_interrupt = true;
-
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
-
-        switch (trapnr) {
-        case EXCP_RESET:
-            fprintf(stderr, "Reset requested. Exit\n");
-            exit(EXIT_FAILURE);
-            break;
-        case EXCP_MCHK:
-            fprintf(stderr, "Machine check exception. Exit\n");
-            exit(EXIT_FAILURE);
-            break;
-        case EXCP_SMP_INTERRUPT:
-        case EXCP_CLK_INTERRUPT:
-        case EXCP_DEV_INTERRUPT:
-            fprintf(stderr, "External interrupt. Exit\n");
-            exit(EXIT_FAILURE);
-            break;
-        case EXCP_MMFAULT:
-            info.si_signo = TARGET_SIGSEGV;
-            info.si_errno = 0;
-            info.si_code = (page_get_flags(env->trap_arg0) & PAGE_VALID
-                            ? TARGET_SEGV_ACCERR : TARGET_SEGV_MAPERR);
-            info._sifields._sigfault._addr = env->trap_arg0;
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            break;
-        case EXCP_UNALIGN:
-            info.si_signo = TARGET_SIGBUS;
-            info.si_errno = 0;
-            info.si_code = TARGET_BUS_ADRALN;
-            info._sifields._sigfault._addr = env->trap_arg0;
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            break;
-        case EXCP_OPCDEC:
-        do_sigill:
-            info.si_signo = TARGET_SIGILL;
-            info.si_errno = 0;
-            info.si_code = TARGET_ILL_ILLOPC;
-            info._sifields._sigfault._addr = env->pc;
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            break;
-        case EXCP_ARITH:
-            info.si_signo = TARGET_SIGFPE;
-            info.si_errno = 0;
-            info.si_code = TARGET_FPE_FLTINV;
-            info._sifields._sigfault._addr = env->pc;
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            break;
-        case EXCP_FEN:
-            /* No-op.  Linux simply re-enables the FPU.  */
-            break;
-        case EXCP_CALL_PAL:
-            switch (env->error_code) {
-            case 0x80:
-                /* BPT */
-                info.si_signo = TARGET_SIGTRAP;
-                info.si_errno = 0;
-                info.si_code = TARGET_TRAP_BRKPT;
-                info._sifields._sigfault._addr = env->pc;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-                break;
-            case 0x81:
-                /* BUGCHK */
-                info.si_signo = TARGET_SIGTRAP;
-                info.si_errno = 0;
-                info.si_code = 0;
-                info._sifields._sigfault._addr = env->pc;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-                break;
-            case 0x83:
-                /* CALLSYS */
-                trapnr = env->ir[IR_V0];
-                sysret = do_syscall(env, trapnr,
-                                    env->ir[IR_A0], env->ir[IR_A1],
-                                    env->ir[IR_A2], env->ir[IR_A3],
-                                    env->ir[IR_A4], env->ir[IR_A5],
-                                    0, 0);
-                if (sysret == -TARGET_ERESTARTSYS) {
-                    env->pc -= 4;
-                    break;
-                }
-                if (sysret == -TARGET_QEMU_ESIGRETURN) {
-                    break;
-                }
-                /* Syscall writes 0 to V0 to bypass error check, similar
-                   to how this is handled internal to Linux kernel.
-                   (Ab)use trapnr temporarily as boolean indicating error.  */
-                trapnr = (env->ir[IR_V0] != 0 && sysret < 0);
-                env->ir[IR_V0] = (trapnr ? -sysret : sysret);
-                env->ir[IR_A3] = trapnr;
-                break;
-            case 0x86:
-                /* IMB */
-                /* ??? We can probably elide the code using page_unprotect
-                   that is checking for self-modifying code.  Instead we
-                   could simply call tb_flush here.  Until we work out the
-                   changes required to turn off the extra write protection,
-                   this can be a no-op.  */
-                break;
-            case 0x9E:
-                /* RDUNIQUE */
-                /* Handled in the translator for usermode.  */
-                abort();
-            case 0x9F:
-                /* WRUNIQUE */
-                /* Handled in the translator for usermode.  */
-                abort();
-            case 0xAA:
-                /* GENTRAP */
-                info.si_signo = TARGET_SIGFPE;
-                switch (env->ir[IR_A0]) {
-                case TARGET_GEN_INTOVF:
-                    info.si_code = TARGET_FPE_INTOVF;
-                    break;
-                case TARGET_GEN_INTDIV:
-                    info.si_code = TARGET_FPE_INTDIV;
-                    break;
-                case TARGET_GEN_FLTOVF:
-                    info.si_code = TARGET_FPE_FLTOVF;
-                    break;
-                case TARGET_GEN_FLTUND:
-                    info.si_code = TARGET_FPE_FLTUND;
-                    break;
-                case TARGET_GEN_FLTINV:
-                    info.si_code = TARGET_FPE_FLTINV;
-                    break;
-                case TARGET_GEN_FLTINE:
-                    info.si_code = TARGET_FPE_FLTRES;
-                    break;
-                case TARGET_GEN_ROPRAND:
-                    info.si_code = 0;
-                    break;
-                default:
-                    info.si_signo = TARGET_SIGTRAP;
-                    info.si_code = 0;
-                    break;
-                }
-                info.si_errno = 0;
-                info._sifields._sigfault._addr = env->pc;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-                break;
-            default:
-                goto do_sigill;
-            }
-            break;
-        case EXCP_DEBUG:
-            info.si_signo = gdb_handlesig(cs, TARGET_SIGTRAP);
-            if (info.si_signo) {
-                info.si_errno = 0;
-                info.si_code = TARGET_TRAP_BRKPT;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            } else {
-                arch_interrupt = false;
-            }
-            break;
-        case EXCP_INTERRUPT:
-            /* Just indicate that signals should be handled asap.  */
-            break;
-        case EXCP_ATOMIC:
-            cpu_exec_step_atomic(cs);
-            arch_interrupt = false;
-            break;
-        default:
-            printf ("Unhandled trap: 0x%x\n", trapnr);
-            cpu_dump_state(cs, stderr, fprintf, 0);
-            exit(EXIT_FAILURE);
-        }
-        process_pending_signals (env);
-
-        /* Most of the traps imply a transition through PALcode, which
-           implies an REI instruction has been executed.  Which means
-           that RX and LOCK_ADDR should be cleared.  But there are a
-           few exceptions for traps internal to QEMU.  */
-        if (arch_interrupt) {
-            env->flags &= ~ENV_FLAG_RX_FLAG;
-            env->lock_addr = -1;
-        }
-    }
-}
-#endif /* TARGET_ALPHA */
-
 #ifdef TARGET_S390X
 
 /* s390x masks the fault address it reports in si_addr for SIGSEGV and SIGBUS */
@@ -1911,16 +1717,6 @@ int main(int argc, char **argv, char **envp)
         env->pc = regs->sepc;
         env->gpr[xSP] = regs->sp;
     }
-#elif defined(TARGET_ALPHA)
-    {
-        int i;
-
-        for(i = 0; i < 28; i++) {
-            env->ir[i] = ((abi_ulong *)regs)[i];
-        }
-        env->ir[IR_SP] = regs->usp;
-        env->pc = regs->pc;
-    }
 #elif defined(TARGET_S390X)
     {
             int i;
-- 
2.14.3

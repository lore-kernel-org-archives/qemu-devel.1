Received: from eggs.gnu.org ([2001:4830:134:3::10]:58577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f0Xbt-0003OV-96
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f0Xbr-0001eP-LE
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:16:49 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 26 Mar 2018 21:15:52 +0200
Message-Id: <20180326191603.10217-9-laurent@vivier.eu>
In-Reply-To: <20180326191603.10217-1-laurent@vivier.eu>
References: <20180326191603.10217-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 08/19] linux-user: move nios2 cpu loop
 to nios2 directory
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
nios2/cpu_loop.c.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/main.c           | 133 --------------------------------------------
 linux-user/nios2/cpu_loop.c | 126 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+), 133 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 490733a3fb..6ee474e5c2 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -149,109 +149,6 @@ void fork_end(int child)
     }
 }
 
-#ifdef TARGET_NIOS2
-
-void cpu_loop(CPUNios2State *env)
-{
-    CPUState *cs = ENV_GET_CPU(env);
-    Nios2CPU *cpu = NIOS2_CPU(cs);
-    target_siginfo_t info;
-    int trapnr, gdbsig, ret;
-
-    for (;;) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        gdbsig = 0;
-
-        switch (trapnr) {
-        case EXCP_INTERRUPT:
-            /* just indicate that signals should be handled asap */
-            break;
-        case EXCP_TRAP:
-            if (env->regs[R_AT] == 0) {
-                abi_long ret;
-                qemu_log_mask(CPU_LOG_INT, "\nSyscall\n");
-
-                ret = do_syscall(env, env->regs[2],
-                                 env->regs[4], env->regs[5], env->regs[6],
-                                 env->regs[7], env->regs[8], env->regs[9],
-                                 0, 0);
-
-                if (env->regs[2] == 0) {    /* FIXME: syscall 0 workaround */
-                    ret = 0;
-                }
-
-                env->regs[2] = abs(ret);
-                /* Return value is 0..4096 */
-                env->regs[7] = (ret > 0xfffffffffffff000ULL);
-                env->regs[CR_ESTATUS] = env->regs[CR_STATUS];
-                env->regs[CR_STATUS] &= ~0x3;
-                env->regs[R_EA] = env->regs[R_PC] + 4;
-                env->regs[R_PC] += 4;
-                break;
-            } else {
-                qemu_log_mask(CPU_LOG_INT, "\nTrap\n");
-
-                env->regs[CR_ESTATUS] = env->regs[CR_STATUS];
-                env->regs[CR_STATUS] &= ~0x3;
-                env->regs[R_EA] = env->regs[R_PC] + 4;
-                env->regs[R_PC] = cpu->exception_addr;
-
-                gdbsig = TARGET_SIGTRAP;
-                break;
-            }
-        case 0xaa:
-            switch (env->regs[R_PC]) {
-            /*case 0x1000:*/  /* TODO:__kuser_helper_version */
-            case 0x1004:      /* __kuser_cmpxchg */
-                start_exclusive();
-                if (env->regs[4] & 0x3) {
-                    goto kuser_fail;
-                }
-                ret = get_user_u32(env->regs[2], env->regs[4]);
-                if (ret) {
-                    end_exclusive();
-                    goto kuser_fail;
-                }
-                env->regs[2] -= env->regs[5];
-                if (env->regs[2] == 0) {
-                    put_user_u32(env->regs[6], env->regs[4]);
-                }
-                end_exclusive();
-                env->regs[R_PC] = env->regs[R_RA];
-                break;
-            /*case 0x1040:*/  /* TODO:__kuser_sigtramp */
-            default:
-                ;
-kuser_fail:
-                info.si_signo = TARGET_SIGSEGV;
-                info.si_errno = 0;
-                /* TODO: check env->error_code */
-                info.si_code = TARGET_SEGV_MAPERR;
-                info._sifields._sigfault._addr = env->regs[R_PC];
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            }
-            break;
-        default:
-            EXCP_DUMP(env, "\nqemu: unhandled CPU exception %#x - aborting\n",
-                     trapnr);
-            gdbsig = TARGET_SIGILL;
-            break;
-        }
-        if (gdbsig) {
-            gdb_handlesig(cs, gdbsig);
-            if (gdbsig != TARGET_SIGTRAP) {
-                exit(EXIT_FAILURE);
-            }
-        }
-
-        process_pending_signals(env);
-    }
-}
-
-#endif /* TARGET_NIOS2 */
-
 #ifdef TARGET_OPENRISC
 
 void cpu_loop(CPUOpenRISCState *env)
@@ -2542,36 +2439,6 @@ int main(int argc, char **argv, char **envp)
         env->regs[31] = regs->r31;	    
         env->sregs[SR_PC] = regs->pc;
     }
-#elif defined(TARGET_NIOS2)
-    {
-        env->regs[0] = 0;
-        env->regs[1] = regs->r1;
-        env->regs[2] = regs->r2;
-        env->regs[3] = regs->r3;
-        env->regs[4] = regs->r4;
-        env->regs[5] = regs->r5;
-        env->regs[6] = regs->r6;
-        env->regs[7] = regs->r7;
-        env->regs[8] = regs->r8;
-        env->regs[9] = regs->r9;
-        env->regs[10] = regs->r10;
-        env->regs[11] = regs->r11;
-        env->regs[12] = regs->r12;
-        env->regs[13] = regs->r13;
-        env->regs[14] = regs->r14;
-        env->regs[15] = regs->r15;
-        /* TODO: unsigned long  orig_r2; */
-        env->regs[R_RA] = regs->ra;
-        env->regs[R_FP] = regs->fp;
-        env->regs[R_SP] = regs->sp;
-        env->regs[R_GP] = regs->gp;
-        env->regs[CR_ESTATUS] = regs->estatus;
-        env->regs[R_EA] = regs->ea;
-        /* TODO: unsigned long  orig_r7; */
-
-        /* Emulate eret when starting thread. */
-        env->regs[R_PC] = regs->ea;
-    }
 #elif defined(TARGET_OPENRISC)
     {
         int i;
diff --git a/linux-user/nios2/cpu_loop.c b/linux-user/nios2/cpu_loop.c
index b7700a5561..dac7a06181 100644
--- a/linux-user/nios2/cpu_loop.c
+++ b/linux-user/nios2/cpu_loop.c
@@ -21,6 +21,132 @@
 #include "qemu.h"
 #include "cpu_loop-common.h"
 
+void cpu_loop(CPUNios2State *env)
+{
+    CPUState *cs = ENV_GET_CPU(env);
+    Nios2CPU *cpu = NIOS2_CPU(cs);
+    target_siginfo_t info;
+    int trapnr, gdbsig, ret;
+
+    for (;;) {
+        cpu_exec_start(cs);
+        trapnr = cpu_exec(cs);
+        cpu_exec_end(cs);
+        gdbsig = 0;
+
+        switch (trapnr) {
+        case EXCP_INTERRUPT:
+            /* just indicate that signals should be handled asap */
+            break;
+        case EXCP_TRAP:
+            if (env->regs[R_AT] == 0) {
+                abi_long ret;
+                qemu_log_mask(CPU_LOG_INT, "\nSyscall\n");
+
+                ret = do_syscall(env, env->regs[2],
+                                 env->regs[4], env->regs[5], env->regs[6],
+                                 env->regs[7], env->regs[8], env->regs[9],
+                                 0, 0);
+
+                if (env->regs[2] == 0) {    /* FIXME: syscall 0 workaround */
+                    ret = 0;
+                }
+
+                env->regs[2] = abs(ret);
+                /* Return value is 0..4096 */
+                env->regs[7] = (ret > 0xfffffffffffff000ULL);
+                env->regs[CR_ESTATUS] = env->regs[CR_STATUS];
+                env->regs[CR_STATUS] &= ~0x3;
+                env->regs[R_EA] = env->regs[R_PC] + 4;
+                env->regs[R_PC] += 4;
+                break;
+            } else {
+                qemu_log_mask(CPU_LOG_INT, "\nTrap\n");
+
+                env->regs[CR_ESTATUS] = env->regs[CR_STATUS];
+                env->regs[CR_STATUS] &= ~0x3;
+                env->regs[R_EA] = env->regs[R_PC] + 4;
+                env->regs[R_PC] = cpu->exception_addr;
+
+                gdbsig = TARGET_SIGTRAP;
+                break;
+            }
+        case 0xaa:
+            switch (env->regs[R_PC]) {
+            /*case 0x1000:*/  /* TODO:__kuser_helper_version */
+            case 0x1004:      /* __kuser_cmpxchg */
+                start_exclusive();
+                if (env->regs[4] & 0x3) {
+                    goto kuser_fail;
+                }
+                ret = get_user_u32(env->regs[2], env->regs[4]);
+                if (ret) {
+                    end_exclusive();
+                    goto kuser_fail;
+                }
+                env->regs[2] -= env->regs[5];
+                if (env->regs[2] == 0) {
+                    put_user_u32(env->regs[6], env->regs[4]);
+                }
+                end_exclusive();
+                env->regs[R_PC] = env->regs[R_RA];
+                break;
+            /*case 0x1040:*/  /* TODO:__kuser_sigtramp */
+            default:
+                ;
+kuser_fail:
+                info.si_signo = TARGET_SIGSEGV;
+                info.si_errno = 0;
+                /* TODO: check env->error_code */
+                info.si_code = TARGET_SEGV_MAPERR;
+                info._sifields._sigfault._addr = env->regs[R_PC];
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            }
+            break;
+        default:
+            EXCP_DUMP(env, "\nqemu: unhandled CPU exception %#x - aborting\n",
+                     trapnr);
+            gdbsig = TARGET_SIGILL;
+            break;
+        }
+        if (gdbsig) {
+            gdb_handlesig(cs, gdbsig);
+            if (gdbsig != TARGET_SIGTRAP) {
+                exit(EXIT_FAILURE);
+            }
+        }
+
+        process_pending_signals(env);
+    }
+}
+
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
+    env->regs[0] = 0;
+    env->regs[1] = regs->r1;
+    env->regs[2] = regs->r2;
+    env->regs[3] = regs->r3;
+    env->regs[4] = regs->r4;
+    env->regs[5] = regs->r5;
+    env->regs[6] = regs->r6;
+    env->regs[7] = regs->r7;
+    env->regs[8] = regs->r8;
+    env->regs[9] = regs->r9;
+    env->regs[10] = regs->r10;
+    env->regs[11] = regs->r11;
+    env->regs[12] = regs->r12;
+    env->regs[13] = regs->r13;
+    env->regs[14] = regs->r14;
+    env->regs[15] = regs->r15;
+    /* TODO: unsigned long  orig_r2; */
+    env->regs[R_RA] = regs->ra;
+    env->regs[R_FP] = regs->fp;
+    env->regs[R_SP] = regs->sp;
+    env->regs[R_GP] = regs->gp;
+    env->regs[CR_ESTATUS] = regs->estatus;
+    env->regs[R_EA] = regs->ea;
+    /* TODO: unsigned long  orig_r7; */
+
+    /* Emulate eret when starting thread. */
+    env->regs[R_PC] = regs->ea;
 }
-- 
2.14.3

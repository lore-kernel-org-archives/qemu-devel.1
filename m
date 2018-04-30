Received: from eggs.gnu.org ([2001:4830:134:3::10]:33620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD4qm-00074h-1u
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fD4qg-0006t0-VS
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 05:11:59 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Apr 2018 11:10:36 +0200
Message-Id: <20180430091037.13878-42-laurent@vivier.eu>
In-Reply-To: <20180430091037.13878-1-laurent@vivier.eu>
References: <20180430091037.13878-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 41/42] linux-user: move xtensa cpu loop to
 xtensa directory
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
xtensa/cpu_loop.c.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180411185651.21351-20-laurent@vivier.eu>
---
 linux-user/main.c            | 250 -------------------------------------------
 linux-user/xtensa/cpu_loop.c | 241 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 241 insertions(+), 250 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index aa48b048a7..32347545c9 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -149,245 +149,6 @@ void fork_end(int child)
     }
 }
 
-#ifdef TARGET_XTENSA
-
-static void xtensa_rfw(CPUXtensaState *env)
-{
-    xtensa_restore_owb(env);
-    env->pc = env->sregs[EPC1];
-}
-
-static void xtensa_rfwu(CPUXtensaState *env)
-{
-    env->sregs[WINDOW_START] |= (1 << env->sregs[WINDOW_BASE]);
-    xtensa_rfw(env);
-}
-
-static void xtensa_rfwo(CPUXtensaState *env)
-{
-    env->sregs[WINDOW_START] &= ~(1 << env->sregs[WINDOW_BASE]);
-    xtensa_rfw(env);
-}
-
-static void xtensa_overflow4(CPUXtensaState *env)
-{
-    put_user_ual(env->regs[0], env->regs[5] - 16);
-    put_user_ual(env->regs[1], env->regs[5] - 12);
-    put_user_ual(env->regs[2], env->regs[5] -  8);
-    put_user_ual(env->regs[3], env->regs[5] -  4);
-    xtensa_rfwo(env);
-}
-
-static void xtensa_underflow4(CPUXtensaState *env)
-{
-    get_user_ual(env->regs[0], env->regs[5] - 16);
-    get_user_ual(env->regs[1], env->regs[5] - 12);
-    get_user_ual(env->regs[2], env->regs[5] -  8);
-    get_user_ual(env->regs[3], env->regs[5] -  4);
-    xtensa_rfwu(env);
-}
-
-static void xtensa_overflow8(CPUXtensaState *env)
-{
-    put_user_ual(env->regs[0], env->regs[9] - 16);
-    get_user_ual(env->regs[0], env->regs[1] - 12);
-    put_user_ual(env->regs[1], env->regs[9] - 12);
-    put_user_ual(env->regs[2], env->regs[9] -  8);
-    put_user_ual(env->regs[3], env->regs[9] -  4);
-    put_user_ual(env->regs[4], env->regs[0] - 32);
-    put_user_ual(env->regs[5], env->regs[0] - 28);
-    put_user_ual(env->regs[6], env->regs[0] - 24);
-    put_user_ual(env->regs[7], env->regs[0] - 20);
-    xtensa_rfwo(env);
-}
-
-static void xtensa_underflow8(CPUXtensaState *env)
-{
-    get_user_ual(env->regs[0], env->regs[9] - 16);
-    get_user_ual(env->regs[1], env->regs[9] - 12);
-    get_user_ual(env->regs[2], env->regs[9] -  8);
-    get_user_ual(env->regs[7], env->regs[1] - 12);
-    get_user_ual(env->regs[3], env->regs[9] -  4);
-    get_user_ual(env->regs[4], env->regs[7] - 32);
-    get_user_ual(env->regs[5], env->regs[7] - 28);
-    get_user_ual(env->regs[6], env->regs[7] - 24);
-    get_user_ual(env->regs[7], env->regs[7] - 20);
-    xtensa_rfwu(env);
-}
-
-static void xtensa_overflow12(CPUXtensaState *env)
-{
-    put_user_ual(env->regs[0],  env->regs[13] - 16);
-    get_user_ual(env->regs[0],  env->regs[1]  - 12);
-    put_user_ual(env->regs[1],  env->regs[13] - 12);
-    put_user_ual(env->regs[2],  env->regs[13] -  8);
-    put_user_ual(env->regs[3],  env->regs[13] -  4);
-    put_user_ual(env->regs[4],  env->regs[0]  - 48);
-    put_user_ual(env->regs[5],  env->regs[0]  - 44);
-    put_user_ual(env->regs[6],  env->regs[0]  - 40);
-    put_user_ual(env->regs[7],  env->regs[0]  - 36);
-    put_user_ual(env->regs[8],  env->regs[0]  - 32);
-    put_user_ual(env->regs[9],  env->regs[0]  - 28);
-    put_user_ual(env->regs[10], env->regs[0]  - 24);
-    put_user_ual(env->regs[11], env->regs[0]  - 20);
-    xtensa_rfwo(env);
-}
-
-static void xtensa_underflow12(CPUXtensaState *env)
-{
-    get_user_ual(env->regs[0],  env->regs[13] - 16);
-    get_user_ual(env->regs[1],  env->regs[13] - 12);
-    get_user_ual(env->regs[2],  env->regs[13] -  8);
-    get_user_ual(env->regs[11], env->regs[1]  - 12);
-    get_user_ual(env->regs[3],  env->regs[13] -  4);
-    get_user_ual(env->regs[4],  env->regs[11] - 48);
-    get_user_ual(env->regs[5],  env->regs[11] - 44);
-    get_user_ual(env->regs[6],  env->regs[11] - 40);
-    get_user_ual(env->regs[7],  env->regs[11] - 36);
-    get_user_ual(env->regs[8],  env->regs[11] - 32);
-    get_user_ual(env->regs[9],  env->regs[11] - 28);
-    get_user_ual(env->regs[10], env->regs[11] - 24);
-    get_user_ual(env->regs[11], env->regs[11] - 20);
-    xtensa_rfwu(env);
-}
-
-void cpu_loop(CPUXtensaState *env)
-{
-    CPUState *cs = CPU(xtensa_env_get_cpu(env));
-    target_siginfo_t info;
-    abi_ulong ret;
-    int trapnr;
-
-    while (1) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
-
-        env->sregs[PS] &= ~PS_EXCM;
-        switch (trapnr) {
-        case EXCP_INTERRUPT:
-            break;
-
-        case EXC_WINDOW_OVERFLOW4:
-            xtensa_overflow4(env);
-            break;
-        case EXC_WINDOW_UNDERFLOW4:
-            xtensa_underflow4(env);
-            break;
-        case EXC_WINDOW_OVERFLOW8:
-            xtensa_overflow8(env);
-            break;
-        case EXC_WINDOW_UNDERFLOW8:
-            xtensa_underflow8(env);
-            break;
-        case EXC_WINDOW_OVERFLOW12:
-            xtensa_overflow12(env);
-            break;
-        case EXC_WINDOW_UNDERFLOW12:
-            xtensa_underflow12(env);
-            break;
-
-        case EXC_USER:
-            switch (env->sregs[EXCCAUSE]) {
-            case ILLEGAL_INSTRUCTION_CAUSE:
-            case PRIVILEGED_CAUSE:
-                info.si_signo = TARGET_SIGILL;
-                info.si_errno = 0;
-                info.si_code =
-                    env->sregs[EXCCAUSE] == ILLEGAL_INSTRUCTION_CAUSE ?
-                    TARGET_ILL_ILLOPC : TARGET_ILL_PRVOPC;
-                info._sifields._sigfault._addr = env->sregs[EPC1];
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-                break;
-
-            case SYSCALL_CAUSE:
-                env->pc += 3;
-                ret = do_syscall(env, env->regs[2],
-                                 env->regs[6], env->regs[3],
-                                 env->regs[4], env->regs[5],
-                                 env->regs[8], env->regs[9], 0, 0);
-                switch (ret) {
-                default:
-                    env->regs[2] = ret;
-                    break;
-
-                case -TARGET_ERESTARTSYS:
-                    env->pc -= 3;
-                    break;
-
-                case -TARGET_QEMU_ESIGRETURN:
-                    break;
-                }
-                break;
-
-            case ALLOCA_CAUSE:
-                env->sregs[PS] = deposit32(env->sregs[PS],
-                                           PS_OWB_SHIFT,
-                                           PS_OWB_LEN,
-                                           env->sregs[WINDOW_BASE]);
-
-                switch (env->regs[0] & 0xc0000000) {
-                case 0x00000000:
-                case 0x40000000:
-                    xtensa_rotate_window(env, -1);
-                    xtensa_underflow4(env);
-                    break;
-
-                case 0x80000000:
-                    xtensa_rotate_window(env, -2);
-                    xtensa_underflow8(env);
-                    break;
-
-                case 0xc0000000:
-                    xtensa_rotate_window(env, -3);
-                    xtensa_underflow12(env);
-                    break;
-                }
-                break;
-
-            case INTEGER_DIVIDE_BY_ZERO_CAUSE:
-                info.si_signo = TARGET_SIGFPE;
-                info.si_errno = 0;
-                info.si_code = TARGET_FPE_INTDIV;
-                info._sifields._sigfault._addr = env->sregs[EPC1];
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-                break;
-
-            case LOAD_PROHIBITED_CAUSE:
-            case STORE_PROHIBITED_CAUSE:
-                info.si_signo = TARGET_SIGSEGV;
-                info.si_errno = 0;
-                info.si_code = TARGET_SEGV_ACCERR;
-                info._sifields._sigfault._addr = env->sregs[EXCVADDR];
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-                break;
-
-            default:
-                fprintf(stderr, "exccause = %d\n", env->sregs[EXCCAUSE]);
-                g_assert_not_reached();
-            }
-            break;
-        case EXCP_DEBUG:
-            trapnr = gdb_handlesig(cs, TARGET_SIGTRAP);
-            if (trapnr) {
-                info.si_signo = trapnr;
-                info.si_errno = 0;
-                info.si_code = TARGET_TRAP_BRKPT;
-                queue_signal(env, trapnr, QEMU_SI_FAULT, &info);
-            }
-            break;
-        case EXC_DEBUG:
-        default:
-            fprintf(stderr, "trapnr = %d\n", trapnr);
-            g_assert_not_reached();
-        }
-        process_pending_signals(env);
-    }
-}
-
-#endif /* TARGET_XTENSA */
-
 __thread CPUState *thread_cpu;
 
 bool qemu_cpu_is_self(CPUState *cpu)
@@ -1045,17 +806,6 @@ int main(int argc, char **argv, char **envp)
 
     target_cpu_copy_regs(env, regs);
 
-#if defined(TARGET_XTENSA)
-    {
-        int i;
-        for (i = 0; i < 16; ++i) {
-            env->regs[i] = regs->areg[i];
-        }
-        env->sregs[WINDOW_START] = regs->windowstart;
-        env->pc = regs->pc;
-    }
-#endif
-
     if (gdbstub_port) {
         if (gdbserver_start(gdbstub_port) < 0) {
             fprintf(stderr, "qemu: could not open gdbserver on port %d\n",
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
index b7700a5561..d142988ebe 100644
--- a/linux-user/xtensa/cpu_loop.c
+++ b/linux-user/xtensa/cpu_loop.c
@@ -21,6 +21,247 @@
 #include "qemu.h"
 #include "cpu_loop-common.h"
 
+static void xtensa_rfw(CPUXtensaState *env)
+{
+    xtensa_restore_owb(env);
+    env->pc = env->sregs[EPC1];
+}
+
+static void xtensa_rfwu(CPUXtensaState *env)
+{
+    env->sregs[WINDOW_START] |= (1 << env->sregs[WINDOW_BASE]);
+    xtensa_rfw(env);
+}
+
+static void xtensa_rfwo(CPUXtensaState *env)
+{
+    env->sregs[WINDOW_START] &= ~(1 << env->sregs[WINDOW_BASE]);
+    xtensa_rfw(env);
+}
+
+static void xtensa_overflow4(CPUXtensaState *env)
+{
+    put_user_ual(env->regs[0], env->regs[5] - 16);
+    put_user_ual(env->regs[1], env->regs[5] - 12);
+    put_user_ual(env->regs[2], env->regs[5] -  8);
+    put_user_ual(env->regs[3], env->regs[5] -  4);
+    xtensa_rfwo(env);
+}
+
+static void xtensa_underflow4(CPUXtensaState *env)
+{
+    get_user_ual(env->regs[0], env->regs[5] - 16);
+    get_user_ual(env->regs[1], env->regs[5] - 12);
+    get_user_ual(env->regs[2], env->regs[5] -  8);
+    get_user_ual(env->regs[3], env->regs[5] -  4);
+    xtensa_rfwu(env);
+}
+
+static void xtensa_overflow8(CPUXtensaState *env)
+{
+    put_user_ual(env->regs[0], env->regs[9] - 16);
+    get_user_ual(env->regs[0], env->regs[1] - 12);
+    put_user_ual(env->regs[1], env->regs[9] - 12);
+    put_user_ual(env->regs[2], env->regs[9] -  8);
+    put_user_ual(env->regs[3], env->regs[9] -  4);
+    put_user_ual(env->regs[4], env->regs[0] - 32);
+    put_user_ual(env->regs[5], env->regs[0] - 28);
+    put_user_ual(env->regs[6], env->regs[0] - 24);
+    put_user_ual(env->regs[7], env->regs[0] - 20);
+    xtensa_rfwo(env);
+}
+
+static void xtensa_underflow8(CPUXtensaState *env)
+{
+    get_user_ual(env->regs[0], env->regs[9] - 16);
+    get_user_ual(env->regs[1], env->regs[9] - 12);
+    get_user_ual(env->regs[2], env->regs[9] -  8);
+    get_user_ual(env->regs[7], env->regs[1] - 12);
+    get_user_ual(env->regs[3], env->regs[9] -  4);
+    get_user_ual(env->regs[4], env->regs[7] - 32);
+    get_user_ual(env->regs[5], env->regs[7] - 28);
+    get_user_ual(env->regs[6], env->regs[7] - 24);
+    get_user_ual(env->regs[7], env->regs[7] - 20);
+    xtensa_rfwu(env);
+}
+
+static void xtensa_overflow12(CPUXtensaState *env)
+{
+    put_user_ual(env->regs[0],  env->regs[13] - 16);
+    get_user_ual(env->regs[0],  env->regs[1]  - 12);
+    put_user_ual(env->regs[1],  env->regs[13] - 12);
+    put_user_ual(env->regs[2],  env->regs[13] -  8);
+    put_user_ual(env->regs[3],  env->regs[13] -  4);
+    put_user_ual(env->regs[4],  env->regs[0]  - 48);
+    put_user_ual(env->regs[5],  env->regs[0]  - 44);
+    put_user_ual(env->regs[6],  env->regs[0]  - 40);
+    put_user_ual(env->regs[7],  env->regs[0]  - 36);
+    put_user_ual(env->regs[8],  env->regs[0]  - 32);
+    put_user_ual(env->regs[9],  env->regs[0]  - 28);
+    put_user_ual(env->regs[10], env->regs[0]  - 24);
+    put_user_ual(env->regs[11], env->regs[0]  - 20);
+    xtensa_rfwo(env);
+}
+
+static void xtensa_underflow12(CPUXtensaState *env)
+{
+    get_user_ual(env->regs[0],  env->regs[13] - 16);
+    get_user_ual(env->regs[1],  env->regs[13] - 12);
+    get_user_ual(env->regs[2],  env->regs[13] -  8);
+    get_user_ual(env->regs[11], env->regs[1]  - 12);
+    get_user_ual(env->regs[3],  env->regs[13] -  4);
+    get_user_ual(env->regs[4],  env->regs[11] - 48);
+    get_user_ual(env->regs[5],  env->regs[11] - 44);
+    get_user_ual(env->regs[6],  env->regs[11] - 40);
+    get_user_ual(env->regs[7],  env->regs[11] - 36);
+    get_user_ual(env->regs[8],  env->regs[11] - 32);
+    get_user_ual(env->regs[9],  env->regs[11] - 28);
+    get_user_ual(env->regs[10], env->regs[11] - 24);
+    get_user_ual(env->regs[11], env->regs[11] - 20);
+    xtensa_rfwu(env);
+}
+
+void cpu_loop(CPUXtensaState *env)
+{
+    CPUState *cs = CPU(xtensa_env_get_cpu(env));
+    target_siginfo_t info;
+    abi_ulong ret;
+    int trapnr;
+
+    while (1) {
+        cpu_exec_start(cs);
+        trapnr = cpu_exec(cs);
+        cpu_exec_end(cs);
+        process_queued_cpu_work(cs);
+
+        env->sregs[PS] &= ~PS_EXCM;
+        switch (trapnr) {
+        case EXCP_INTERRUPT:
+            break;
+
+        case EXC_WINDOW_OVERFLOW4:
+            xtensa_overflow4(env);
+            break;
+        case EXC_WINDOW_UNDERFLOW4:
+            xtensa_underflow4(env);
+            break;
+        case EXC_WINDOW_OVERFLOW8:
+            xtensa_overflow8(env);
+            break;
+        case EXC_WINDOW_UNDERFLOW8:
+            xtensa_underflow8(env);
+            break;
+        case EXC_WINDOW_OVERFLOW12:
+            xtensa_overflow12(env);
+            break;
+        case EXC_WINDOW_UNDERFLOW12:
+            xtensa_underflow12(env);
+            break;
+
+        case EXC_USER:
+            switch (env->sregs[EXCCAUSE]) {
+            case ILLEGAL_INSTRUCTION_CAUSE:
+            case PRIVILEGED_CAUSE:
+                info.si_signo = TARGET_SIGILL;
+                info.si_errno = 0;
+                info.si_code =
+                    env->sregs[EXCCAUSE] == ILLEGAL_INSTRUCTION_CAUSE ?
+                    TARGET_ILL_ILLOPC : TARGET_ILL_PRVOPC;
+                info._sifields._sigfault._addr = env->sregs[EPC1];
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                break;
+
+            case SYSCALL_CAUSE:
+                env->pc += 3;
+                ret = do_syscall(env, env->regs[2],
+                                 env->regs[6], env->regs[3],
+                                 env->regs[4], env->regs[5],
+                                 env->regs[8], env->regs[9], 0, 0);
+                switch (ret) {
+                default:
+                    env->regs[2] = ret;
+                    break;
+
+                case -TARGET_ERESTARTSYS:
+                    env->pc -= 3;
+                    break;
+
+                case -TARGET_QEMU_ESIGRETURN:
+                    break;
+                }
+                break;
+
+            case ALLOCA_CAUSE:
+                env->sregs[PS] = deposit32(env->sregs[PS],
+                                           PS_OWB_SHIFT,
+                                           PS_OWB_LEN,
+                                           env->sregs[WINDOW_BASE]);
+
+                switch (env->regs[0] & 0xc0000000) {
+                case 0x00000000:
+                case 0x40000000:
+                    xtensa_rotate_window(env, -1);
+                    xtensa_underflow4(env);
+                    break;
+
+                case 0x80000000:
+                    xtensa_rotate_window(env, -2);
+                    xtensa_underflow8(env);
+                    break;
+
+                case 0xc0000000:
+                    xtensa_rotate_window(env, -3);
+                    xtensa_underflow12(env);
+                    break;
+                }
+                break;
+
+            case INTEGER_DIVIDE_BY_ZERO_CAUSE:
+                info.si_signo = TARGET_SIGFPE;
+                info.si_errno = 0;
+                info.si_code = TARGET_FPE_INTDIV;
+                info._sifields._sigfault._addr = env->sregs[EPC1];
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                break;
+
+            case LOAD_PROHIBITED_CAUSE:
+            case STORE_PROHIBITED_CAUSE:
+                info.si_signo = TARGET_SIGSEGV;
+                info.si_errno = 0;
+                info.si_code = TARGET_SEGV_ACCERR;
+                info._sifields._sigfault._addr = env->sregs[EXCVADDR];
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+                break;
+
+            default:
+                fprintf(stderr, "exccause = %d\n", env->sregs[EXCCAUSE]);
+                g_assert_not_reached();
+            }
+            break;
+        case EXCP_DEBUG:
+            trapnr = gdb_handlesig(cs, TARGET_SIGTRAP);
+            if (trapnr) {
+                info.si_signo = trapnr;
+                info.si_errno = 0;
+                info.si_code = TARGET_TRAP_BRKPT;
+                queue_signal(env, trapnr, QEMU_SI_FAULT, &info);
+            }
+            break;
+        case EXC_DEBUG:
+        default:
+            fprintf(stderr, "trapnr = %d\n", trapnr);
+            g_assert_not_reached();
+        }
+        process_pending_signals(env);
+    }
+}
+
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
+    int i;
+    for (i = 0; i < 16; ++i) {
+        env->regs[i] = regs->areg[i];
+    }
+    env->sregs[WINDOW_START] = regs->windowstart;
+    env->pc = regs->pc;
 }
-- 
2.14.3

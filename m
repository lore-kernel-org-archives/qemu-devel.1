Received: from eggs.gnu.org ([2001:4830:134:3::10]:58376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f0Xbe-0003Cm-CT
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f0Xbc-0001OL-Vl
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:16:34 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 26 Mar 2018 21:15:47 +0200
Message-Id: <20180326191603.10217-4-laurent@vivier.eu>
In-Reply-To: <20180326191603.10217-1-laurent@vivier.eu>
References: <20180326191603.10217-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH for 2.13 03/19] linux-user: move aarch64 cpu
 loop to aarch64 directory
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
aarch64/cpu_loop.c and duplicate some macro
defined for both arm and aarch64.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/aarch64/cpu_loop.c | 156 ++++++++++++++++++++++++++++++++++++++++++
 linux-user/main.c             | 109 +----------------------------
 2 files changed, 158 insertions(+), 107 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index b7700a5561..c97a646546 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -21,6 +21,162 @@
 #include "qemu.h"
 #include "cpu_loop-common.h"
 
+#define get_user_code_u32(x, gaddr, env)                \
+    ({ abi_long __r = get_user_u32((x), (gaddr));       \
+        if (!__r && bswap_code(arm_sctlr_b(env))) {     \
+            (x) = bswap32(x);                           \
+        }                                               \
+        __r;                                            \
+    })
+
+#define get_user_code_u16(x, gaddr, env)                \
+    ({ abi_long __r = get_user_u16((x), (gaddr));       \
+        if (!__r && bswap_code(arm_sctlr_b(env))) {     \
+            (x) = bswap16(x);                           \
+        }                                               \
+        __r;                                            \
+    })
+
+#define get_user_data_u32(x, gaddr, env)                \
+    ({ abi_long __r = get_user_u32((x), (gaddr));       \
+        if (!__r && arm_cpu_bswap_data(env)) {          \
+            (x) = bswap32(x);                           \
+        }                                               \
+        __r;                                            \
+    })
+
+#define get_user_data_u16(x, gaddr, env)                \
+    ({ abi_long __r = get_user_u16((x), (gaddr));       \
+        if (!__r && arm_cpu_bswap_data(env)) {          \
+            (x) = bswap16(x);                           \
+        }                                               \
+        __r;                                            \
+    })
+
+#define put_user_data_u32(x, gaddr, env)                \
+    ({ typeof(x) __x = (x);                             \
+        if (arm_cpu_bswap_data(env)) {                  \
+            __x = bswap32(__x);                         \
+        }                                               \
+        put_user_u32(__x, (gaddr));                     \
+    })
+
+#define put_user_data_u16(x, gaddr, env)                \
+    ({ typeof(x) __x = (x);                             \
+        if (arm_cpu_bswap_data(env)) {                  \
+            __x = bswap16(__x);                         \
+        }                                               \
+        put_user_u16(__x, (gaddr));                     \
+    })
+
+/* AArch64 main loop */
+void cpu_loop(CPUARMState *env)
+{
+    CPUState *cs = CPU(arm_env_get_cpu(env));
+    int trapnr, sig;
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
+        case EXCP_SWI:
+            ret = do_syscall(env,
+                             env->xregs[8],
+                             env->xregs[0],
+                             env->xregs[1],
+                             env->xregs[2],
+                             env->xregs[3],
+                             env->xregs[4],
+                             env->xregs[5],
+                             0, 0);
+            if (ret == -TARGET_ERESTARTSYS) {
+                env->pc -= 4;
+            } else if (ret != -TARGET_QEMU_ESIGRETURN) {
+                env->xregs[0] = ret;
+            }
+            break;
+        case EXCP_INTERRUPT:
+            /* just indicate that signals should be handled asap */
+            break;
+        case EXCP_UDEF:
+            info.si_signo = TARGET_SIGILL;
+            info.si_errno = 0;
+            info.si_code = TARGET_ILL_ILLOPN;
+            info._sifields._sigfault._addr = env->pc;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
+        case EXCP_PREFETCH_ABORT:
+        case EXCP_DATA_ABORT:
+            info.si_signo = TARGET_SIGSEGV;
+            info.si_errno = 0;
+            /* XXX: check env->error_code */
+            info.si_code = TARGET_SEGV_MAPERR;
+            info._sifields._sigfault._addr = env->exception.vaddress;
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
+        case EXCP_DEBUG:
+        case EXCP_BKPT:
+            sig = gdb_handlesig(cs, TARGET_SIGTRAP);
+            if (sig) {
+                info.si_signo = sig;
+                info.si_errno = 0;
+                info.si_code = TARGET_TRAP_BRKPT;
+                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            }
+            break;
+        case EXCP_SEMIHOST:
+            env->xregs[0] = do_arm_semihosting(env);
+            break;
+        case EXCP_YIELD:
+            /* nothing to do here for user-mode, just resume guest code */
+            break;
+        case EXCP_ATOMIC:
+            cpu_exec_step_atomic(cs);
+            break;
+        default:
+            EXCP_DUMP(env, "qemu: unhandled CPU exception 0x%x - aborting\n", trapnr);
+            abort();
+        }
+        process_pending_signals(env);
+        /* Exception return on AArch64 always clears the exclusive monitor,
+         * so any return to running guest code implies this.
+         */
+        env->exclusive_addr = -1;
+    }
+}
+
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
+    CPUState *cpu = ENV_GET_CPU(env);
+    TaskState *ts = cpu->opaque;
+    struct image_info *info = ts->info;
+    int i;
+
+    if (!(arm_feature(env, ARM_FEATURE_AARCH64))) {
+        fprintf(stderr,
+                "The selected ARM CPU does not support 64 bit mode\n");
+        exit(EXIT_FAILURE);
+    }
+
+    for (i = 0; i < 31; i++) {
+        env->xregs[i] = regs->regs[i];
+    }
+    env->pc = regs->pc;
+    env->xregs[31] = regs->sp;
+#ifdef TARGET_WORDS_BIGENDIAN
+    env->cp15.sctlr_el[1] |= SCTLR_E0E;
+    for (i = 1; i < 4; ++i) {
+        env->cp15.sctlr_el[i] |= SCTLR_EE;
+    }
+#endif
+
+    ts->stack_base = info->start_stack;
+    ts->heap_base = info->brk;
+    /* This will be filled in on the first SYS_HEAPINFO call.  */
+    ts->heap_limit = 0;
 }
diff --git a/linux-user/main.c b/linux-user/main.c
index 0b792024ce..40be5cf201 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -555,89 +555,6 @@ void cpu_loop(CPUARMState *env)
         process_pending_signals(env);
     }
 }
-
-#else
-
-/* AArch64 main loop */
-void cpu_loop(CPUARMState *env)
-{
-    CPUState *cs = CPU(arm_env_get_cpu(env));
-    int trapnr, sig;
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
-        case EXCP_SWI:
-            ret = do_syscall(env,
-                             env->xregs[8],
-                             env->xregs[0],
-                             env->xregs[1],
-                             env->xregs[2],
-                             env->xregs[3],
-                             env->xregs[4],
-                             env->xregs[5],
-                             0, 0);
-            if (ret == -TARGET_ERESTARTSYS) {
-                env->pc -= 4;
-            } else if (ret != -TARGET_QEMU_ESIGRETURN) {
-                env->xregs[0] = ret;
-            }
-            break;
-        case EXCP_INTERRUPT:
-            /* just indicate that signals should be handled asap */
-            break;
-        case EXCP_UDEF:
-            info.si_signo = TARGET_SIGILL;
-            info.si_errno = 0;
-            info.si_code = TARGET_ILL_ILLOPN;
-            info._sifields._sigfault._addr = env->pc;
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            break;
-        case EXCP_PREFETCH_ABORT:
-        case EXCP_DATA_ABORT:
-            info.si_signo = TARGET_SIGSEGV;
-            info.si_errno = 0;
-            /* XXX: check env->error_code */
-            info.si_code = TARGET_SEGV_MAPERR;
-            info._sifields._sigfault._addr = env->exception.vaddress;
-            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            break;
-        case EXCP_DEBUG:
-        case EXCP_BKPT:
-            sig = gdb_handlesig(cs, TARGET_SIGTRAP);
-            if (sig) {
-                info.si_signo = sig;
-                info.si_errno = 0;
-                info.si_code = TARGET_TRAP_BRKPT;
-                queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
-            }
-            break;
-        case EXCP_SEMIHOST:
-            env->xregs[0] = do_arm_semihosting(env);
-            break;
-        case EXCP_YIELD:
-            /* nothing to do here for user-mode, just resume guest code */
-            break;
-        case EXCP_ATOMIC:
-            cpu_exec_step_atomic(cs);
-            break;
-        default:
-            EXCP_DUMP(env, "qemu: unhandled CPU exception 0x%x - aborting\n", trapnr);
-            abort();
-        }
-        process_pending_signals(env);
-        /* Exception return on AArch64 always clears the exclusive monitor,
-         * so any return to running guest code implies this.
-         */
-        env->exclusive_addr = -1;
-    }
-}
 #endif /* ndef TARGET_ABI32 */
 
 #endif
@@ -4492,29 +4409,7 @@ int main(int argc, char **argv, char **envp)
 
     target_cpu_copy_regs(env, regs);
 
-#if defined(TARGET_AARCH64)
-    {
-        int i;
-
-        if (!(arm_feature(env, ARM_FEATURE_AARCH64))) {
-            fprintf(stderr,
-                    "The selected ARM CPU does not support 64 bit mode\n");
-            exit(EXIT_FAILURE);
-        }
-
-        for (i = 0; i < 31; i++) {
-            env->xregs[i] = regs->regs[i];
-        }
-        env->pc = regs->pc;
-        env->xregs[31] = regs->sp;
-#ifdef TARGET_WORDS_BIGENDIAN
-        env->cp15.sctlr_el[1] |= SCTLR_E0E;
-        for (i = 1; i < 4; ++i) {
-            env->cp15.sctlr_el[i] |= SCTLR_EE;
-        }
-#endif
-    }
-#elif defined(TARGET_ARM)
+#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
     {
         int i;
         cpsr_write(env, regs->uregs[16], CPSR_USER | CPSR_EXEC,
@@ -4769,7 +4664,7 @@ int main(int argc, char **argv, char **envp)
     }
 #endif
 
-#if defined(TARGET_ARM) || defined(TARGET_M68K)
+#if (defined(TARGET_ARM) && !defined(TARGET_AARCH64)) || defined(TARGET_M68K)
     ts->stack_base = info->start_stack;
     ts->heap_base = info->brk;
     /* This will be filled in on the first SYS_HEAPINFO call.  */
-- 
2.14.3

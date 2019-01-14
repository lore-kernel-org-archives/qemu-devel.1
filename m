Received: from eggs.gnu.org ([209.51.188.92]:44769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gix0A-0006Vw-R9
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gix08-00022T-Cn
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:49:42 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:34660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gix08-0001ud-07
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:49:40 -0500
Received: by mail-lf1-x143.google.com with SMTP id p6so14897736lfc.1
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 23:49:31 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 13 Jan 2019 23:48:53 -0800
Message-Id: <20190114074855.16891-6-jcmvbkbc@gmail.com>
In-Reply-To: <20190114074855.16891-1-jcmvbkbc@gmail.com>
References: <20190114074855.16891-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 5/7] target/xtensa: extract interrupt and
 exception helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Move helper functions related to interrupt and exception handling from
op_helper.c and helper.c to exc_helper.c. No functional changes.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/Makefile.objs |   1 +
 target/xtensa/exc_helper.c  | 258 ++++++++++++++++++++++++++++++++++++++++++++
 target/xtensa/helper.c      | 127 ----------------------
 target/xtensa/op_helper.c   |  93 ----------------
 4 files changed, 259 insertions(+), 220 deletions(-)
 create mode 100644 target/xtensa/exc_helper.c

diff --git a/target/xtensa/Makefile.objs b/target/xtensa/Makefile.objs
index cfd33ba1d951..808f7e3fceb8 100644
--- a/target/xtensa/Makefile.objs
+++ b/target/xtensa/Makefile.objs
@@ -8,6 +8,7 @@ obj-$(CONFIG_SOFTMMU) += monitor.o xtensa-semi.o
 obj-y += xtensa-isa.o
 obj-y += translate.o op_helper.o helper.o cpu.o
 obj-$(CONFIG_SOFTMMU) += dbg_helper.o
+obj-y += exc_helper.o
 obj-y += fpu_helper.o
 obj-y += gdbstub.o
 obj-$(CONFIG_SOFTMMU) += mmu_helper.o
diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
new file mode 100644
index 000000000000..371a32ba5ad9
--- /dev/null
+++ b/target/xtensa/exc_helper.c
@@ -0,0 +1,258 @@
+/*
+ * Copyright (c) 2011 - 2019, Max Filippov, Open Source and Linux Lab.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of the Open Source and Linux Lab nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+#include "cpu.h"
+#include "exec/helper-proto.h"
+#include "qemu/host-utils.h"
+#include "exec/exec-all.h"
+
+void HELPER(exception)(CPUXtensaState *env, uint32_t excp)
+{
+    CPUState *cs = CPU(xtensa_env_get_cpu(env));
+
+    cs->exception_index = excp;
+    if (excp == EXCP_YIELD) {
+        env->yield_needed = 0;
+    }
+    if (excp == EXCP_DEBUG) {
+        env->exception_taken = 0;
+    }
+    cpu_loop_exit(cs);
+}
+
+void HELPER(exception_cause)(CPUXtensaState *env, uint32_t pc, uint32_t cause)
+{
+    uint32_t vector;
+
+    env->pc = pc;
+    if (env->sregs[PS] & PS_EXCM) {
+        if (env->config->ndepc) {
+            env->sregs[DEPC] = pc;
+        } else {
+            env->sregs[EPC1] = pc;
+        }
+        vector = EXC_DOUBLE;
+    } else {
+        env->sregs[EPC1] = pc;
+        vector = (env->sregs[PS] & PS_UM) ? EXC_USER : EXC_KERNEL;
+    }
+
+    env->sregs[EXCCAUSE] = cause;
+    env->sregs[PS] |= PS_EXCM;
+
+    HELPER(exception)(env, vector);
+}
+
+void HELPER(exception_cause_vaddr)(CPUXtensaState *env,
+                                   uint32_t pc, uint32_t cause, uint32_t vaddr)
+{
+    env->sregs[EXCVADDR] = vaddr;
+    HELPER(exception_cause)(env, pc, cause);
+}
+
+void debug_exception_env(CPUXtensaState *env, uint32_t cause)
+{
+    if (xtensa_get_cintlevel(env) < env->config->debug_level) {
+        HELPER(debug_exception)(env, env->pc, cause);
+    }
+}
+
+void HELPER(debug_exception)(CPUXtensaState *env, uint32_t pc, uint32_t cause)
+{
+    unsigned level = env->config->debug_level;
+
+    env->pc = pc;
+    env->sregs[DEBUGCAUSE] = cause;
+    env->sregs[EPC1 + level - 1] = pc;
+    env->sregs[EPS2 + level - 2] = env->sregs[PS];
+    env->sregs[PS] = (env->sregs[PS] & ~PS_INTLEVEL) | PS_EXCM |
+        (level << PS_INTLEVEL_SHIFT);
+    HELPER(exception)(env, EXC_DEBUG);
+}
+
+#ifndef CONFIG_USER_ONLY
+
+void HELPER(waiti)(CPUXtensaState *env, uint32_t pc, uint32_t intlevel)
+{
+    CPUState *cpu;
+
+    env->pc = pc;
+    env->sregs[PS] = (env->sregs[PS] & ~PS_INTLEVEL) |
+        (intlevel << PS_INTLEVEL_SHIFT);
+
+    qemu_mutex_lock_iothread();
+    check_interrupts(env);
+    qemu_mutex_unlock_iothread();
+
+    if (env->pending_irq_level) {
+        cpu_loop_exit(CPU(xtensa_env_get_cpu(env)));
+        return;
+    }
+
+    cpu = CPU(xtensa_env_get_cpu(env));
+    cpu->halted = 1;
+    HELPER(exception)(env, EXCP_HLT);
+}
+
+void HELPER(check_interrupts)(CPUXtensaState *env)
+{
+    qemu_mutex_lock_iothread();
+    check_interrupts(env);
+    qemu_mutex_unlock_iothread();
+}
+
+static uint32_t relocated_vector(CPUXtensaState *env, uint32_t vector)
+{
+    if (xtensa_option_enabled(env->config,
+                              XTENSA_OPTION_RELOCATABLE_VECTOR)) {
+        return vector - env->config->vecbase + env->sregs[VECBASE];
+    } else {
+        return vector;
+    }
+}
+
+/*!
+ * Handle penging IRQ.
+ * For the high priority interrupt jump to the corresponding interrupt vector.
+ * For the level-1 interrupt convert it to either user, kernel or double
+ * exception with the 'level-1 interrupt' exception cause.
+ */
+static void handle_interrupt(CPUXtensaState *env)
+{
+    int level = env->pending_irq_level;
+
+    if (level > xtensa_get_cintlevel(env) &&
+        level <= env->config->nlevel &&
+        (env->config->level_mask[level] &
+         env->sregs[INTSET] &
+         env->sregs[INTENABLE])) {
+        CPUState *cs = CPU(xtensa_env_get_cpu(env));
+
+        if (level > 1) {
+            env->sregs[EPC1 + level - 1] = env->pc;
+            env->sregs[EPS2 + level - 2] = env->sregs[PS];
+            env->sregs[PS] =
+                (env->sregs[PS] & ~PS_INTLEVEL) | level | PS_EXCM;
+            env->pc = relocated_vector(env,
+                                       env->config->interrupt_vector[level]);
+        } else {
+            env->sregs[EXCCAUSE] = LEVEL1_INTERRUPT_CAUSE;
+
+            if (env->sregs[PS] & PS_EXCM) {
+                if (env->config->ndepc) {
+                    env->sregs[DEPC] = env->pc;
+                } else {
+                    env->sregs[EPC1] = env->pc;
+                }
+                cs->exception_index = EXC_DOUBLE;
+            } else {
+                env->sregs[EPC1] = env->pc;
+                cs->exception_index =
+                    (env->sregs[PS] & PS_UM) ? EXC_USER : EXC_KERNEL;
+            }
+            env->sregs[PS] |= PS_EXCM;
+        }
+        env->exception_taken = 1;
+    }
+}
+
+/* Called from cpu_handle_interrupt with BQL held */
+void xtensa_cpu_do_interrupt(CPUState *cs)
+{
+    XtensaCPU *cpu = XTENSA_CPU(cs);
+    CPUXtensaState *env = &cpu->env;
+
+    if (cs->exception_index == EXC_IRQ) {
+        qemu_log_mask(CPU_LOG_INT,
+                      "%s(EXC_IRQ) level = %d, cintlevel = %d, "
+                      "pc = %08x, a0 = %08x, ps = %08x, "
+                      "intset = %08x, intenable = %08x, "
+                      "ccount = %08x\n",
+                      __func__, env->pending_irq_level,
+                      xtensa_get_cintlevel(env),
+                      env->pc, env->regs[0], env->sregs[PS],
+                      env->sregs[INTSET], env->sregs[INTENABLE],
+                      env->sregs[CCOUNT]);
+        handle_interrupt(env);
+    }
+
+    switch (cs->exception_index) {
+    case EXC_WINDOW_OVERFLOW4:
+    case EXC_WINDOW_UNDERFLOW4:
+    case EXC_WINDOW_OVERFLOW8:
+    case EXC_WINDOW_UNDERFLOW8:
+    case EXC_WINDOW_OVERFLOW12:
+    case EXC_WINDOW_UNDERFLOW12:
+    case EXC_KERNEL:
+    case EXC_USER:
+    case EXC_DOUBLE:
+    case EXC_DEBUG:
+        qemu_log_mask(CPU_LOG_INT, "%s(%d) "
+                      "pc = %08x, a0 = %08x, ps = %08x, ccount = %08x\n",
+                      __func__, cs->exception_index,
+                      env->pc, env->regs[0], env->sregs[PS],
+                      env->sregs[CCOUNT]);
+        if (env->config->exception_vector[cs->exception_index]) {
+            uint32_t vector;
+
+            vector = env->config->exception_vector[cs->exception_index];
+            env->pc = relocated_vector(env, vector);
+            env->exception_taken = 1;
+        } else {
+            qemu_log_mask(CPU_LOG_INT,
+                          "%s(pc = %08x) bad exception_index: %d\n",
+                          __func__, env->pc, cs->exception_index);
+        }
+        break;
+
+    case EXC_IRQ:
+        break;
+
+    default:
+        qemu_log("%s(pc = %08x) unknown exception_index: %d\n",
+                 __func__, env->pc, cs->exception_index);
+        break;
+    }
+    check_interrupts(env);
+}
+#else
+void xtensa_cpu_do_interrupt(CPUState *cs)
+{
+}
+#endif
+
+bool xtensa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+{
+    if (interrupt_request & CPU_INTERRUPT_HARD) {
+        cs->exception_index = EXC_IRQ;
+        xtensa_cpu_do_interrupt(cs);
+        return true;
+    }
+    return false;
+}
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index c344241bd06e..2f1dec5c63e9 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -169,133 +169,6 @@ void xtensa_cpu_list(FILE *f, fprintf_function cpu_fprintf)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
-
-static uint32_t relocated_vector(CPUXtensaState *env, uint32_t vector)
-{
-    if (xtensa_option_enabled(env->config,
-                XTENSA_OPTION_RELOCATABLE_VECTOR)) {
-        return vector - env->config->vecbase + env->sregs[VECBASE];
-    } else {
-        return vector;
-    }
-}
-
-/*!
- * Handle penging IRQ.
- * For the high priority interrupt jump to the corresponding interrupt vector.
- * For the level-1 interrupt convert it to either user, kernel or double
- * exception with the 'level-1 interrupt' exception cause.
- */
-static void handle_interrupt(CPUXtensaState *env)
-{
-    int level = env->pending_irq_level;
-
-    if (level > xtensa_get_cintlevel(env) &&
-            level <= env->config->nlevel &&
-            (env->config->level_mask[level] &
-             env->sregs[INTSET] &
-             env->sregs[INTENABLE])) {
-        CPUState *cs = CPU(xtensa_env_get_cpu(env));
-
-        if (level > 1) {
-            env->sregs[EPC1 + level - 1] = env->pc;
-            env->sregs[EPS2 + level - 2] = env->sregs[PS];
-            env->sregs[PS] =
-                (env->sregs[PS] & ~PS_INTLEVEL) | level | PS_EXCM;
-            env->pc = relocated_vector(env,
-                    env->config->interrupt_vector[level]);
-        } else {
-            env->sregs[EXCCAUSE] = LEVEL1_INTERRUPT_CAUSE;
-
-            if (env->sregs[PS] & PS_EXCM) {
-                if (env->config->ndepc) {
-                    env->sregs[DEPC] = env->pc;
-                } else {
-                    env->sregs[EPC1] = env->pc;
-                }
-                cs->exception_index = EXC_DOUBLE;
-            } else {
-                env->sregs[EPC1] = env->pc;
-                cs->exception_index =
-                    (env->sregs[PS] & PS_UM) ? EXC_USER : EXC_KERNEL;
-            }
-            env->sregs[PS] |= PS_EXCM;
-        }
-        env->exception_taken = 1;
-    }
-}
-
-/* Called from cpu_handle_interrupt with BQL held */
-void xtensa_cpu_do_interrupt(CPUState *cs)
-{
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
-
-    if (cs->exception_index == EXC_IRQ) {
-        qemu_log_mask(CPU_LOG_INT,
-                "%s(EXC_IRQ) level = %d, cintlevel = %d, "
-                "pc = %08x, a0 = %08x, ps = %08x, "
-                "intset = %08x, intenable = %08x, "
-                "ccount = %08x\n",
-                __func__, env->pending_irq_level, xtensa_get_cintlevel(env),
-                env->pc, env->regs[0], env->sregs[PS],
-                env->sregs[INTSET], env->sregs[INTENABLE],
-                env->sregs[CCOUNT]);
-        handle_interrupt(env);
-    }
-
-    switch (cs->exception_index) {
-    case EXC_WINDOW_OVERFLOW4:
-    case EXC_WINDOW_UNDERFLOW4:
-    case EXC_WINDOW_OVERFLOW8:
-    case EXC_WINDOW_UNDERFLOW8:
-    case EXC_WINDOW_OVERFLOW12:
-    case EXC_WINDOW_UNDERFLOW12:
-    case EXC_KERNEL:
-    case EXC_USER:
-    case EXC_DOUBLE:
-    case EXC_DEBUG:
-        qemu_log_mask(CPU_LOG_INT, "%s(%d) "
-                "pc = %08x, a0 = %08x, ps = %08x, ccount = %08x\n",
-                __func__, cs->exception_index,
-                env->pc, env->regs[0], env->sregs[PS], env->sregs[CCOUNT]);
-        if (env->config->exception_vector[cs->exception_index]) {
-            env->pc = relocated_vector(env,
-                    env->config->exception_vector[cs->exception_index]);
-            env->exception_taken = 1;
-        } else {
-            qemu_log_mask(CPU_LOG_INT, "%s(pc = %08x) bad exception_index: %d\n",
-                          __func__, env->pc, cs->exception_index);
-        }
-        break;
-
-    case EXC_IRQ:
-        break;
-
-    default:
-        qemu_log("%s(pc = %08x) unknown exception_index: %d\n",
-                __func__, env->pc, cs->exception_index);
-        break;
-    }
-    check_interrupts(env);
-}
-#else
-void xtensa_cpu_do_interrupt(CPUState *cs)
-{
-}
-#endif
-
-bool xtensa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
-{
-    if (interrupt_request & CPU_INTERRUPT_HARD) {
-        cs->exception_index = EXC_IRQ;
-        xtensa_cpu_do_interrupt(cs);
-        return true;
-    }
-    return false;
-}
-
 #ifdef CONFIG_USER_ONLY
 
 int xtensa_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index e13e686479db..d3e61e22fe82 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -95,70 +95,6 @@ void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 
 #endif
 
-void HELPER(exception)(CPUXtensaState *env, uint32_t excp)
-{
-    CPUState *cs = CPU(xtensa_env_get_cpu(env));
-
-    cs->exception_index = excp;
-    if (excp == EXCP_YIELD) {
-        env->yield_needed = 0;
-    }
-    if (excp == EXCP_DEBUG) {
-        env->exception_taken = 0;
-    }
-    cpu_loop_exit(cs);
-}
-
-void HELPER(exception_cause)(CPUXtensaState *env, uint32_t pc, uint32_t cause)
-{
-    uint32_t vector;
-
-    env->pc = pc;
-    if (env->sregs[PS] & PS_EXCM) {
-        if (env->config->ndepc) {
-            env->sregs[DEPC] = pc;
-        } else {
-            env->sregs[EPC1] = pc;
-        }
-        vector = EXC_DOUBLE;
-    } else {
-        env->sregs[EPC1] = pc;
-        vector = (env->sregs[PS] & PS_UM) ? EXC_USER : EXC_KERNEL;
-    }
-
-    env->sregs[EXCCAUSE] = cause;
-    env->sregs[PS] |= PS_EXCM;
-
-    HELPER(exception)(env, vector);
-}
-
-void HELPER(exception_cause_vaddr)(CPUXtensaState *env,
-        uint32_t pc, uint32_t cause, uint32_t vaddr)
-{
-    env->sregs[EXCVADDR] = vaddr;
-    HELPER(exception_cause)(env, pc, cause);
-}
-
-void debug_exception_env(CPUXtensaState *env, uint32_t cause)
-{
-    if (xtensa_get_cintlevel(env) < env->config->debug_level) {
-        HELPER(debug_exception)(env, env->pc, cause);
-    }
-}
-
-void HELPER(debug_exception)(CPUXtensaState *env, uint32_t pc, uint32_t cause)
-{
-    unsigned level = env->config->debug_level;
-
-    env->pc = pc;
-    env->sregs[DEBUGCAUSE] = cause;
-    env->sregs[EPC1 + level - 1] = pc;
-    env->sregs[EPS2 + level - 2] = env->sregs[PS];
-    env->sregs[PS] = (env->sregs[PS] & ~PS_INTLEVEL) | PS_EXCM |
-        (level << PS_INTLEVEL_SHIFT);
-    HELPER(exception)(env, EXC_DEBUG);
-}
-
 void HELPER(dump_state)(CPUXtensaState *env)
 {
     XtensaCPU *cpu = xtensa_env_get_cpu(env);
@@ -168,28 +104,6 @@ void HELPER(dump_state)(CPUXtensaState *env)
 
 #ifndef CONFIG_USER_ONLY
 
-void HELPER(waiti)(CPUXtensaState *env, uint32_t pc, uint32_t intlevel)
-{
-    CPUState *cpu;
-
-    env->pc = pc;
-    env->sregs[PS] = (env->sregs[PS] & ~PS_INTLEVEL) |
-        (intlevel << PS_INTLEVEL_SHIFT);
-
-    qemu_mutex_lock_iothread();
-    check_interrupts(env);
-    qemu_mutex_unlock_iothread();
-
-    if (env->pending_irq_level) {
-        cpu_loop_exit(CPU(xtensa_env_get_cpu(env)));
-        return;
-    }
-
-    cpu = CPU(xtensa_env_get_cpu(env));
-    cpu->halted = 1;
-    HELPER(exception)(env, EXCP_HLT);
-}
-
 void HELPER(update_ccount)(CPUXtensaState *env)
 {
     uint64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
@@ -222,13 +136,6 @@ void HELPER(update_ccompare)(CPUXtensaState *env, uint32_t i)
     env->yield_needed = 1;
 }
 
-void HELPER(check_interrupts)(CPUXtensaState *env)
-{
-    qemu_mutex_lock_iothread();
-    check_interrupts(env);
-    qemu_mutex_unlock_iothread();
-}
-
 /*!
  * Check vaddr accessibility/cache attributes and raise an exception if
  * specified by the ATOMCTL SR.
-- 
2.11.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoD9-0002yG-LT
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoD7-0004cs-PV
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:07 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:42241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoD7-0004bd-HX
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:32:05 -0500
Received: by mail-pf0-x244.google.com with SMTP id d23so21818774pfe.9
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:32:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:19 -0800
Message-Id: <20171229063145.29167-13-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 12/38] target/hppa: Fill in
 hppa_cpu_do_interrupt/hppa_cpu_exec_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.c         |   2 +
 target/hppa/helper.c      |  63 -----------------
 target/hppa/int_helper.c  | 176 ++++++++++++++++++++++++++++++++++++++++++++++
 target/hppa/translate.c   |  16 ++++-
 target/hppa/Makefile.objs |   1 +
 5 files changed, 192 insertions(+), 66 deletions(-)
 create mode 100644 target/hppa/int_helper.c

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 9962ab71ee..ca619578dd 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -106,8 +106,10 @@ static void hppa_cpu_initfn(Object *obj)
     CPUHPPAState *env = &cpu->env;
 
     cs->env_ptr = env;
+    cs->exception_index = -1;
     cpu_hppa_loaded_fr0(env);
     set_snan_bit_is_one(true, &env->fp_status);
+    cpu_hppa_put_psw(env, PSW_W);
 }
 
 static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 608b30fe65..cab50c6ddd 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -67,69 +67,6 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ureg psw)
     env->psw_cb = cb;
 }
 
-void hppa_cpu_do_interrupt(CPUState *cs)
-{
-    HPPACPU *cpu = HPPA_CPU(cs);
-    CPUHPPAState *env = &cpu->env;
-    int i = cs->exception_index;
-
-    if (qemu_loglevel_mask(CPU_LOG_INT)) {
-        static const char * const names[] = {
-            [EXCP_HPMC]          = "high priority machine check",
-            [EXCP_POWER_FAIL]    = "power fail interrupt",
-            [EXCP_RC]            = "recovery counter trap",
-            [EXCP_EXT_INTERRUPT] = "external interrupt",
-            [EXCP_LPMC]          = "low priority machine check",
-            [EXCP_ITLB_MISS]     = "instruction tlb miss fault",
-            [EXCP_IMP]           = "instruction memory protection trap",
-            [EXCP_ILL]           = "illegal instruction trap",
-            [EXCP_BREAK]         = "break instruction trap",
-            [EXCP_PRIV_OPR]      = "privileged operation trap",
-            [EXCP_PRIV_REG]      = "privileged register trap",
-            [EXCP_OVERFLOW]      = "overflow trap",
-            [EXCP_COND]          = "conditional trap",
-            [EXCP_ASSIST]        = "assist exception trap",
-            [EXCP_DTLB_MISS]     = "data tlb miss fault",
-            [EXCP_NA_ITLB_MISS]  = "non-access instruction tlb miss",
-            [EXCP_NA_DTLB_MISS]  = "non-access data tlb miss",
-            [EXCP_DMP]           = "data memory protection trap",
-            [EXCP_DMB]           = "data memory break trap",
-            [EXCP_TLB_DIRTY]     = "tlb dirty bit trap",
-            [EXCP_PAGE_REF]      = "page reference trap",
-            [EXCP_ASSIST_EMU]    = "assist emulation trap",
-            [EXCP_HPT]           = "high-privilege transfer trap",
-            [EXCP_LPT]           = "low-privilege transfer trap",
-            [EXCP_TB]            = "taken branch trap",
-            [EXCP_DMAR]          = "data memory access rights trap",
-            [EXCP_DMPI]          = "data memory protection id trap",
-            [EXCP_UNALIGN]       = "unaligned data reference trap",
-            [EXCP_PER_INTERRUPT] = "performance monitor interrupt",
-            [EXCP_SYSCALL]       = "syscall",
-            [EXCP_SYSCALL_LWS]   = "syscall-lws",
-        };
-        static int count;
-        const char *name = NULL;
-
-        if (i >= 0 && i < ARRAY_SIZE(names)) {
-            name = names[i];
-        }
-        if (name) {
-            qemu_log("INT %6d: %s ia_f=" TARGET_FMT_lx "\n",
-                     ++count, name, env->iaoq_f);
-        } else {
-            qemu_log("INT %6d: unknown %d ia_f=" TARGET_FMT_lx "\n",
-                     ++count, i, env->iaoq_f);
-        }
-    }
-    cs->exception_index = -1;
-}
-
-bool hppa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
-{
-    abort();
-    return false;
-}
-
 void hppa_cpu_dump_state(CPUState *cs, FILE *f,
                          fprintf_function cpu_fprintf, int flags)
 {
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
new file mode 100644
index 0000000000..34413c30e1
--- /dev/null
+++ b/target/hppa/int_helper.c
@@ -0,0 +1,176 @@
+/*
+ *  HPPA interrupt helper routines
+ *
+ *  Copyright (c) 2017 Richard Henderson
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
+#include "qom/cpu.h"
+
+
+void hppa_cpu_do_interrupt(CPUState *cs)
+{
+    HPPACPU *cpu = HPPA_CPU(cs);
+    CPUHPPAState *env = &cpu->env;
+    int i = cs->exception_index;
+    target_ureg iaoq_f = env->iaoq_f;
+    target_ureg iaoq_b = env->iaoq_b;
+
+#ifndef CONFIG_USER_ONLY
+    target_ureg old_psw;
+
+    /* As documented in pa2.0 -- interruption handling.  */
+    /* step 1 */
+    env->cr[CR_IPSW] = old_psw = cpu_hppa_get_psw(env);
+
+    /* step 2 -- note PSW_W == 0 for !HPPA64.  */
+    cpu_hppa_put_psw(env, PSW_W | (i == EXCP_HPMC ? PSW_M : 0));
+
+    /* step 3 */
+    env->cr[CR_IIAOQ] = iaoq_f;
+    env->cr_back[1] = iaoq_b;
+
+    /* step 5 */
+    /* ISR and IOR will be set elsewhere.  */
+    switch (i) {
+    case EXCP_ILL:
+    case EXCP_BREAK:
+    case EXCP_PRIV_REG:
+    case EXCP_PRIV_OPR:
+        /* IIR set via translate.c.  */
+        break;
+
+    case EXCP_OVERFLOW:
+    case EXCP_COND:
+    case EXCP_ASSIST:
+    case EXCP_DTLB_MISS:
+    case EXCP_NA_ITLB_MISS:
+    case EXCP_NA_DTLB_MISS:
+    case EXCP_DMAR:
+    case EXCP_DMPI:
+    case EXCP_UNALIGN:
+    case EXCP_DMP:
+    case EXCP_DMB:
+    case EXCP_TLB_DIRTY:
+    case EXCP_PAGE_REF:
+    case EXCP_ASSIST_EMU:
+        {
+            /* Avoid reading directly from the virtual address, lest we
+               raise another exception from some sort of TLB issue.  */
+            vaddr vaddr;
+            hwaddr paddr;
+
+            paddr = vaddr = iaoq_f & -4;
+            env->cr[CR_IIR] = ldl_phys(cs->as, paddr);
+        }
+        break;
+
+    default:
+        /* Other exceptions do not set IIR.  */
+        break;
+    }
+
+    /* step 6 */
+    if (old_psw & PSW_Q) {
+        env->shadow[0] = env->gr[1];
+        env->shadow[1] = env->gr[8];
+        env->shadow[2] = env->gr[9];
+        env->shadow[3] = env->gr[16];
+        env->shadow[4] = env->gr[17];
+        env->shadow[5] = env->gr[24];
+        env->shadow[6] = env->gr[25];
+    }
+
+    /* step 7 */
+    env->iaoq_f = env->cr[CR_IVA] + 32 * i;
+    env->iaoq_b = env->iaoq_f + 4;
+#endif
+
+    if (qemu_loglevel_mask(CPU_LOG_INT)) {
+        static const char * const names[] = {
+            [EXCP_HPMC]          = "high priority machine check",
+            [EXCP_POWER_FAIL]    = "power fail interrupt",
+            [EXCP_RC]            = "recovery counter trap",
+            [EXCP_EXT_INTERRUPT] = "external interrupt",
+            [EXCP_LPMC]          = "low priority machine check",
+            [EXCP_ITLB_MISS]     = "instruction tlb miss fault",
+            [EXCP_IMP]           = "instruction memory protection trap",
+            [EXCP_ILL]           = "illegal instruction trap",
+            [EXCP_BREAK]         = "break instruction trap",
+            [EXCP_PRIV_OPR]      = "privileged operation trap",
+            [EXCP_PRIV_REG]      = "privileged register trap",
+            [EXCP_OVERFLOW]      = "overflow trap",
+            [EXCP_COND]          = "conditional trap",
+            [EXCP_ASSIST]        = "assist exception trap",
+            [EXCP_DTLB_MISS]     = "data tlb miss fault",
+            [EXCP_NA_ITLB_MISS]  = "non-access instruction tlb miss",
+            [EXCP_NA_DTLB_MISS]  = "non-access data tlb miss",
+            [EXCP_DMP]           = "data memory protection trap",
+            [EXCP_DMB]           = "data memory break trap",
+            [EXCP_TLB_DIRTY]     = "tlb dirty bit trap",
+            [EXCP_PAGE_REF]      = "page reference trap",
+            [EXCP_ASSIST_EMU]    = "assist emulation trap",
+            [EXCP_HPT]           = "high-privilege transfer trap",
+            [EXCP_LPT]           = "low-privilege transfer trap",
+            [EXCP_TB]            = "taken branch trap",
+            [EXCP_DMAR]          = "data memory access rights trap",
+            [EXCP_DMPI]          = "data memory protection id trap",
+            [EXCP_UNALIGN]       = "unaligned data reference trap",
+            [EXCP_PER_INTERRUPT] = "performance monitor interrupt",
+            [EXCP_SYSCALL]       = "syscall",
+            [EXCP_SYSCALL_LWS]   = "syscall-lws",
+        };
+        static int count;
+        const char *name = NULL;
+        char unknown[16];
+
+        if (i >= 0 && i < ARRAY_SIZE(names)) {
+            name = names[i];
+        }
+        if (!name) {
+            snprintf(unknown, sizeof(unknown), "unknown %d", i);
+            name = unknown;
+        }
+        qemu_log("INT %6d: %s @ " TARGET_FMT_lx "," TARGET_FMT_lx
+                 " -> " TREG_FMT_lx " " TARGET_FMT_lx "\n",
+                 ++count, name,
+                 (target_ulong)iaoq_f,
+                 (target_ulong)iaoq_b,
+                 env->iaoq_f,
+                 (target_ulong)env->cr[CR_IOR]);
+    }
+    cs->exception_index = -1;
+}
+
+bool hppa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+{
+#ifndef CONFIG_USER_ONLY
+    HPPACPU *cpu = HPPA_CPU(cs);
+    CPUHPPAState *env = &cpu->env;
+
+    /* If interrupts are requested and enabled, raise them.  */
+    if ((env->psw & PSW_I) && (interrupt_request & CPU_INTERRUPT_HARD)) {
+        cs->exception_index = EXCP_EXT_INTERRUPT;
+        hppa_cpu_do_interrupt(cs);
+        return true;
+    }
+#endif
+    return false;
+}
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 8078d3cd46..e6a9adc3c7 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -278,6 +278,7 @@ typedef struct DisasContext {
     DisasCond null_cond;
     TCGLabel *null_lab;
 
+    uint32_t insn;
     int mmu_idx;
     int privilege;
     bool psw_n_nonzero;
@@ -714,17 +715,25 @@ static DisasJumpType gen_excp(DisasContext *ctx, int exception)
     return DISAS_NORETURN;
 }
 
+static DisasJumpType gen_excp_iir(DisasContext *ctx, int exc)
+{
+    TCGv_reg tmp = tcg_const_reg(ctx->insn);
+    tcg_gen_st_reg(tmp, cpu_env, offsetof(CPUHPPAState, cr[CR_IIR]));
+    tcg_temp_free(tmp);
+    return gen_excp(ctx, exc);
+}
+
 static DisasJumpType gen_illegal(DisasContext *ctx)
 {
     nullify_over(ctx);
-    return nullify_end(ctx, gen_excp(ctx, EXCP_ILL));
+    return nullify_end(ctx, gen_excp_iir(ctx, EXCP_ILL));
 }
 
 #define CHECK_MOST_PRIVILEGED(EXCP)                               \
     do {                                                          \
         if (ctx->privilege != 0) {                                \
             nullify_over(ctx);                                    \
-            return nullify_end(ctx, gen_excp(ctx, EXCP));         \
+            return nullify_end(ctx, gen_excp_iir(ctx, EXCP));     \
         }                                                         \
     } while (0)
 
@@ -1884,7 +1893,7 @@ static DisasJumpType trans_break(DisasContext *ctx, uint32_t insn,
                                  const DisasInsn *di)
 {
     nullify_over(ctx);
-    return nullify_end(ctx, gen_excp(ctx, EXCP_BREAK));
+    return nullify_end(ctx, gen_excp_iir(ctx, EXCP_BREAK));
 }
 
 static DisasJumpType trans_sync(DisasContext *ctx, uint32_t insn,
@@ -4266,6 +4275,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
             ctx->null_cond.c = TCG_COND_NEVER;
             ret = DISAS_NEXT;
         } else {
+            ctx->insn = insn;
             ret = translate_one(ctx, insn);
             assert(ctx->null_lab == NULL);
         }
diff --git a/target/hppa/Makefile.objs b/target/hppa/Makefile.objs
index d89285307b..dcd60a6839 100644
--- a/target/hppa/Makefile.objs
+++ b/target/hppa/Makefile.objs
@@ -1 +1,2 @@
 obj-y += translate.o helper.o cpu.o op_helper.o gdbstub.o mem_helper.o
+obj-y += int_helper.o
-- 
2.14.3

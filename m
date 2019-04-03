Received: from eggs.gnu.org ([209.51.188.92]:48536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWox-0002hH-1Q
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWov-00084N-Mn
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:14 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWov-000827-CK
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:13 -0400
Received: by mail-pf1-x441.google.com with SMTP id y13so7421030pfm.11
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:37 +0700
Message-Id: <20190403034358.21999-6-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 05/26] target/cris: Convert to
 CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>

Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/cris/cpu.h       |  5 +--
 target/cris/cpu.c       |  5 ++-
 target/cris/helper.c    | 67 +++++++++++++++++++++++------------------
 target/cris/op_helper.c | 28 -----------------
 4 files changed, 42 insertions(+), 63 deletions(-)

diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 8bb1dbc989..f3c3b428ca 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -282,8 +282,9 @@ static inline int cpu_mmu_index (CPUCRISState *env, bool ifetch)
 	return !!(env->pregs[PR_CCS] & U_FLAG);
 }
 
-int cris_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                              int mmu_idx);
+bool cris_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr);
 
 /* Support function regs.  */
 #define SFR_RW_GC_CFG      0][0
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index a23aba2688..145c33a85a 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -273,9 +273,8 @@ static void cris_cpu_class_init(ObjectClass *oc, void *data)
     cc->set_pc = cris_cpu_set_pc;
     cc->gdb_read_register = cris_cpu_gdb_read_register;
     cc->gdb_write_register = cris_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = cris_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = cris_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug = cris_cpu_get_phys_page_debug;
     dc->vmsd = &vmstate_cris_cpu;
 #endif
diff --git a/target/cris/helper.c b/target/cris/helper.c
index b2dbb2075c..69464837c8 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -24,6 +24,7 @@
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
+#include "exec/helper-proto.h"
 
 
 //#define CRIS_HELPER_DEBUG
@@ -53,15 +54,15 @@ void crisv10_cpu_do_interrupt(CPUState *cs)
     cris_cpu_do_interrupt(cs);
 }
 
-int cris_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                              int mmu_idx)
+bool cris_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
 {
     CRISCPU *cpu = CRIS_CPU(cs);
 
     cs->exception_index = 0xaa;
     cpu->env.pregs[PR_EDA] = address;
-    cpu_dump_state(cs, stderr, fprintf, 0);
-    return 1;
+    cpu_loop_exit_restore(cs, retaddr);
 }
 
 #else /* !CONFIG_USER_ONLY */
@@ -76,33 +77,19 @@ static void cris_shift_ccs(CPUCRISState *env)
     env->pregs[PR_CCS] = ccs;
 }
 
-int cris_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                              int mmu_idx)
+bool cris_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
 {
     CRISCPU *cpu = CRIS_CPU(cs);
     CPUCRISState *env = &cpu->env;
     struct cris_mmu_result res;
     int prot, miss;
-    int r = -1;
     target_ulong phy;
 
-    qemu_log_mask(CPU_LOG_MMU, "%s addr=%" VADDR_PRIx " pc=%x rw=%x\n",
-            __func__, address, env->pc, rw);
     miss = cris_mmu_translate(&res, env, address & TARGET_PAGE_MASK,
-                              rw, mmu_idx, 0);
-    if (miss) {
-        if (cs->exception_index == EXCP_BUSFAULT) {
-            cpu_abort(cs,
-                      "CRIS: Illegal recursive bus fault."
-                      "addr=%" VADDR_PRIx " rw=%d\n",
-                      address, rw);
-        }
-
-        env->pregs[PR_EDA] = address;
-        cs->exception_index = EXCP_BUSFAULT;
-        env->fault_vector = res.bf_vec;
-        r = 1;
-    } else {
+                              access_type, mmu_idx, 0);
+    if (likely(!miss)) {
         /*
          * Mask off the cache selection bit. The ETRAX busses do not
          * see the top bit.
@@ -111,15 +98,35 @@ int cris_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
         prot = res.prot;
         tlb_set_page(cs, address & TARGET_PAGE_MASK, phy,
                      prot, mmu_idx, TARGET_PAGE_SIZE);
-        r = 0;
+        return true;
     }
-    if (r > 0) {
-        qemu_log_mask(CPU_LOG_MMU,
-                "%s returns %d irqreq=%x addr=%" VADDR_PRIx " phy=%x vec=%x"
-                " pc=%x\n", __func__, r, cs->interrupt_request, address,
-                res.phy, res.bf_vec, env->pc);
+
+    if (probe) {
+        return false;
     }
-    return r;
+
+    if (cs->exception_index == EXCP_BUSFAULT) {
+        cpu_abort(cs, "CRIS: Illegal recursive bus fault."
+                      "addr=%" VADDR_PRIx " access_type=%d\n",
+                      address, access_type);
+    }
+
+    env->pregs[PR_EDA] = address;
+    cs->exception_index = EXCP_BUSFAULT;
+    env->fault_vector = res.bf_vec;
+    if (retaddr) {
+        if (cpu_restore_state(cs, retaddr, true)) {
+            /* Evaluate flags after retranslation. */
+            helper_top_evaluate_flags(env);
+        }
+    }
+    cpu_loop_exit(cs);
+}
+
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    cris_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
 }
 
 void crisv10_cpu_do_interrupt(CPUState *cs)
diff --git a/target/cris/op_helper.c b/target/cris/op_helper.c
index 0ee3a3117b..26a395b413 100644
--- a/target/cris/op_helper.c
+++ b/target/cris/op_helper.c
@@ -37,34 +37,6 @@
 #define D_LOG(...) do { } while (0)
 #endif
 
-#if !defined(CONFIG_USER_ONLY)
-/* Try to fill the TLB and return an exception if error. If retaddr is
-   NULL, it means that the function was called in C code (i.e. not
-   from generated code or from helper.c) */
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    CRISCPU *cpu = CRIS_CPU(cs);
-    CPUCRISState *env = &cpu->env;
-    int ret;
-
-    D_LOG("%s pc=%x tpc=%x ra=%p\n", __func__,
-          env->pc, env->pregs[PR_EDA], (void *)retaddr);
-    ret = cris_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (unlikely(ret)) {
-        if (retaddr) {
-            /* now we have a real cpu fault */
-            if (cpu_restore_state(cs, retaddr, true)) {
-                /* Evaluate flags after retranslation. */
-                helper_top_evaluate_flags(env);
-            }
-        }
-        cpu_loop_exit(cs);
-    }
-}
-
-#endif
-
 void helper_raise_exception(CPUCRISState *env, uint32_t index)
 {
     CPUState *cs = CPU(cris_env_get_cpu(env));
-- 
2.17.1

Received: from eggs.gnu.org ([209.51.188.92]:48826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpW-0003DV-5a
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpU-0000My-Ut
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:50 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:42281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWpU-0000Lf-LG
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:48 -0400
Received: by mail-pg1-x52c.google.com with SMTP id p6so7576673pgh.9
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:54 +0700
Message-Id: <20190403034358.21999-23-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 22/26] target/unicore32: Convert to
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
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/unicore32/cpu.h       |  5 +++--
 target/unicore32/cpu.c       |  5 +----
 target/unicore32/helper.c    | 23 -----------------------
 target/unicore32/op_helper.c | 14 --------------
 target/unicore32/softmmu.c   | 19 +++++++++++++++----
 5 files changed, 19 insertions(+), 47 deletions(-)

diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 735d3ae9dc..dfec908cad 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -179,8 +179,9 @@ static inline void cpu_get_tb_cpu_state(CPUUniCore32State *env, target_ulong *pc
     }
 }
 
-int uc32_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                              int mmu_idx);
+bool uc32_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr);
 void uc32_translate_init(void);
 void switch_mode(CPUUniCore32State *, int);
 
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index 2b49d1ca40..3f57c508a0 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -138,11 +138,8 @@ static void uc32_cpu_class_init(ObjectClass *oc, void *data)
     cc->cpu_exec_interrupt = uc32_cpu_exec_interrupt;
     cc->dump_state = uc32_cpu_dump_state;
     cc->set_pc = uc32_cpu_set_pc;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = uc32_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = uc32_cpu_tlb_fill;
     cc->get_phys_page_debug = uc32_cpu_get_phys_page_debug;
-#endif
     cc->tcg_initialize = uc32_translate_init;
     dc->vmsd = &vmstate_uc32_cpu;
 }
diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
index a5ff2ddb74..0d4914b48d 100644
--- a/target/unicore32/helper.c
+++ b/target/unicore32/helper.c
@@ -215,29 +215,6 @@ void helper_cp1_putc(target_ulong x)
 }
 #endif
 
-#ifdef CONFIG_USER_ONLY
-void switch_mode(CPUUniCore32State *env, int mode)
-{
-    UniCore32CPU *cpu = uc32_env_get_cpu(env);
-
-    if (mode != ASR_MODE_USER) {
-        cpu_abort(CPU(cpu), "Tried to switch out of user mode\n");
-    }
-}
-
-void uc32_cpu_do_interrupt(CPUState *cs)
-{
-    cpu_abort(cs, "NO interrupt in user mode\n");
-}
-
-int uc32_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                              int access_type, int mmu_idx)
-{
-    cpu_abort(cs, "NO mmu fault in user mode\n");
-    return 1;
-}
-#endif
-
 bool uc32_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
diff --git a/target/unicore32/op_helper.c b/target/unicore32/op_helper.c
index e0a15882d3..797ba60dc9 100644
--- a/target/unicore32/op_helper.c
+++ b/target/unicore32/op_helper.c
@@ -242,17 +242,3 @@ uint32_t HELPER(ror_cc)(CPUUniCore32State *env, uint32_t x, uint32_t i)
         return ((uint32_t)x >> shift) | (x << (32 - shift));
     }
 }
-
-#ifndef CONFIG_USER_ONLY
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    int ret;
-
-    ret = uc32_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (unlikely(ret)) {
-        /* now we have a real cpu fault */
-        cpu_loop_exit_restore(cs, retaddr);
-    }
-}
-#endif
diff --git a/target/unicore32/softmmu.c b/target/unicore32/softmmu.c
index 00c7e0d028..13678df4d7 100644
--- a/target/unicore32/softmmu.c
+++ b/target/unicore32/softmmu.c
@@ -215,8 +215,9 @@ do_fault:
     return code;
 }
 
-int uc32_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                              int access_type, int mmu_idx)
+bool uc32_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
 {
     UniCore32CPU *cpu = UNICORE32_CPU(cs);
     CPUUniCore32State *env = &cpu->env;
@@ -257,7 +258,11 @@ int uc32_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
         phys_addr &= TARGET_PAGE_MASK;
         address &= TARGET_PAGE_MASK;
         tlb_set_page(cs, address, phys_addr, prot, mmu_idx, page_size);
-        return 0;
+        return true;
+    }
+
+    if (probe) {
+        return false;
     }
 
     env->cp0.c3_faultstatus = ret;
@@ -267,7 +272,13 @@ int uc32_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
     } else {
         cs->exception_index = UC32_EXCP_DTRAP;
     }
-    return ret;
+    cpu_loop_exit_restore(cs, retaddr);
+}
+
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    uc32_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
 }
 
 hwaddr uc32_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
-- 
2.17.1

Received: from eggs.gnu.org ([209.51.188.92]:48610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWp4-0002oz-NJ
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWp3-0008Hq-8o
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:22 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWp2-0008Gx-T1
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:21 -0400
Received: by mail-pf1-x441.google.com with SMTP id r15so7415176pfn.9
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:41 +0700
Message-Id: <20190403034358.21999-10-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 09/26] target/m68k: Convert to
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
Cc: Laurent Vivier <laurent@vivier.eu>

Cc: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.h       |  5 ++-
 target/m68k/cpu.c       |  2 +-
 target/m68k/helper.c    | 87 ++++++++++++++++++++++-------------------
 target/m68k/op_helper.c | 15 -------
 4 files changed, 50 insertions(+), 59 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index f154565117..663c4c0307 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -543,8 +543,9 @@ static inline int cpu_mmu_index (CPUM68KState *env, bool ifetch)
     return (env->sr & SR_S) == 0 ? 1 : 0;
 }
 
-int m68k_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                              int mmu_idx);
+bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr);
 void m68k_cpu_unassigned_access(CPUState *cs, hwaddr addr,
                                 bool is_write, bool is_exec, int is_asi,
                                 unsigned size);
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 582e3a73b3..6f441bc973 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -269,7 +269,7 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
     cc->set_pc = m68k_cpu_set_pc;
     cc->gdb_read_register = m68k_cpu_gdb_read_register;
     cc->gdb_write_register = m68k_cpu_gdb_write_register;
-    cc->handle_mmu_fault = m68k_cpu_handle_mmu_fault;
+    cc->tlb_fill = m68k_cpu_tlb_fill;
 #if defined(CONFIG_SOFTMMU)
     cc->do_unassigned_access = m68k_cpu_unassigned_access;
     cc->get_phys_page_debug = m68k_cpu_get_phys_page_debug;
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 3e26d337bf..9768b4517f 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -359,20 +359,7 @@ void m68k_switch_sp(CPUM68KState *env)
     env->current_sp = new_sp;
 }
 
-#if defined(CONFIG_USER_ONLY)
-
-int m68k_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                              int mmu_idx)
-{
-    M68kCPU *cpu = M68K_CPU(cs);
-
-    cs->exception_index = EXCP_ACCESS;
-    cpu->env.mmu.ar = address;
-    return 1;
-}
-
-#else
-
+#if !defined(CONFIG_USER_ONLY)
 /* MMU: 68040 only */
 
 static void print_address_zone(FILE *f, fprintf_function cpu_fprintf,
@@ -804,11 +791,36 @@ hwaddr m68k_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return phys_addr;
 }
 
-int m68k_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                              int mmu_idx)
+/*
+ * Notify CPU of a pending interrupt.  Prioritization and vectoring should
+ * be handled by the interrupt controller.  Real hardware only requests
+ * the vector when the interrupt is acknowledged by the CPU.  For
+ * simplicitly we calculate it when the interrupt is signalled.
+ */
+void m68k_set_irq_level(M68kCPU *cpu, int level, uint8_t vector)
+{
+    CPUState *cs = CPU(cpu);
+    CPUM68KState *env = &cpu->env;
+
+    env->pending_level = level;
+    env->pending_vector = vector;
+    if (level) {
+        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+    } else {
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+    }
+}
+
+#endif
+
+bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType qemu_access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
 {
     M68kCPU *cpu = M68K_CPU(cs);
     CPUM68KState *env = &cpu->env;
+
+#ifndef CONFIG_USER_ONLY
     hwaddr physical;
     int prot;
     int access_type;
@@ -821,32 +833,35 @@ int m68k_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
                      address & TARGET_PAGE_MASK,
                      PAGE_READ | PAGE_WRITE | PAGE_EXEC,
                      mmu_idx, TARGET_PAGE_SIZE);
-        return 0;
+        return true;
     }
 
-    if (rw == 2) {
+    if (qemu_access_type == MMU_INST_FETCH) {
         access_type = ACCESS_CODE;
-        rw = 0;
     } else {
         access_type = ACCESS_DATA;
-        if (rw) {
+        if (qemu_access_type == MMU_DATA_STORE) {
             access_type |= ACCESS_STORE;
         }
     }
-
     if (mmu_idx != MMU_USER_IDX) {
         access_type |= ACCESS_SUPER;
     }
 
     ret = get_physical_address(&cpu->env, &physical, &prot,
                                address, access_type, &page_size);
-    if (ret == 0) {
+    if (likely(ret == 0)) {
         address &= TARGET_PAGE_MASK;
         physical += address & (page_size - 1);
         tlb_set_page(cs, address, physical,
                      prot, mmu_idx, TARGET_PAGE_SIZE);
-        return 0;
+        return true;
     }
+
+    if (probe) {
+        return false;
+    }
+
     /* page fault */
     env->mmu.ssw = M68K_ATC_040;
     switch (size) {
@@ -871,29 +886,19 @@ int m68k_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
     if (!(access_type & ACCESS_STORE)) {
         env->mmu.ssw |= M68K_RW_040;
     }
-    env->mmu.ar = address;
+#endif
+
     cs->exception_index = EXCP_ACCESS;
-    return 1;
+    env->mmu.ar = address;
+    cpu_loop_exit_restore(cs, retaddr);
 }
 
-/* Notify CPU of a pending interrupt.  Prioritization and vectoring should
-   be handled by the interrupt controller.  Real hardware only requests
-   the vector when the interrupt is acknowledged by the CPU.  For
-   simplicitly we calculate it when the interrupt is signalled.  */
-void m68k_set_irq_level(M68kCPU *cpu, int level, uint8_t vector)
+#ifndef CONFIG_USER_ONLY
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
-    CPUState *cs = CPU(cpu);
-    CPUM68KState *env = &cpu->env;
-
-    env->pending_level = level;
-    env->pending_vector = vector;
-    if (level) {
-        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
-    } else {
-        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
-    }
+    m68k_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
 }
-
 #endif
 
 uint32_t HELPER(bitrev)(uint32_t x)
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 76f439985a..d421614727 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -36,21 +36,6 @@ static inline void do_interrupt_m68k_hardirq(CPUM68KState *env)
 
 #else
 
-/* Try to fill the TLB and return an exception if error. If retaddr is
-   NULL, it means that the function was called in C code (i.e. not
-   from generated code or from helper.c) */
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    int ret;
-
-    ret = m68k_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (unlikely(ret)) {
-        /* now we have a real cpu fault */
-        cpu_loop_exit_restore(cs, retaddr);
-    }
-}
-
 static void cf_rte(CPUM68KState *env)
 {
     uint32_t sp;
-- 
2.17.1

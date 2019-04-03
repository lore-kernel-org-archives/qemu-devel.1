Received: from eggs.gnu.org ([209.51.188.92]:48506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWov-0002ff-2z
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWot-000812-IX
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:13 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWot-0007zL-9O
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:11 -0400
Received: by mail-pg1-x544.google.com with SMTP id 85so7592852pgc.3
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:36 +0700
Message-Id: <20190403034358.21999-5-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 04/26] target/arm: Convert to CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Cc: qemu-arm@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 10 +++--
 target/arm/cpu.c       | 22 +---------
 target/arm/helper.c    | 97 ++++++++++++++++++++++++++----------------
 target/arm/op_helper.c | 29 ++-----------
 4 files changed, 72 insertions(+), 86 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 587a1ddf58..5a02f458f3 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -761,10 +761,12 @@ static inline bool arm_extabort_type(MemTxResult result)
     return result != MEMTX_DECODE_ERROR;
 }
 
-/* Do a page table walk and add page to TLB if possible */
-bool arm_tlb_fill(CPUState *cpu, vaddr address,
-                  MMUAccessType access_type, int mmu_idx,
-                  ARMMMUFaultInfo *fi);
+bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                      MMUAccessType access_type, int mmu_idx,
+                      bool probe, uintptr_t retaddr);
+
+void arm_deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_type,
+                       int mmu_idx, ARMMMUFaultInfo *fi) QEMU_NORETURN;
 
 /* Return true if the stage 1 translation regime is using LPAE format page
  * tables */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4155782197..3b87d897a2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2114,23 +2114,6 @@ static Property arm_cpu_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
-#ifdef CONFIG_USER_ONLY
-static int arm_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                                    int rw, int mmu_idx)
-{
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-
-    env->exception.vaddress = address;
-    if (rw == 2) {
-        cs->exception_index = EXCP_PREFETCH_ABORT;
-    } else {
-        cs->exception_index = EXCP_DATA_ABORT;
-    }
-    return 1;
-}
-#endif
-
 static gchar *arm_gdb_arch_name(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -2163,9 +2146,8 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->synchronize_from_tb = arm_cpu_synchronize_from_tb;
     cc->gdb_read_register = arm_cpu_gdb_read_register;
     cc->gdb_write_register = arm_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = arm_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = arm_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->do_interrupt = arm_cpu_do_interrupt;
     cc->do_unaligned_access = arm_cpu_do_unaligned_access;
     cc->do_transaction_failed = arm_cpu_do_transaction_failed;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a36f4b3d69..0fc4abc651 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11918,43 +11918,6 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
     }
 }
 
-/* Walk the page table and (if the mapping exists) add the page
- * to the TLB. Return false on success, or true on failure. Populate
- * fsr with ARM DFSR/IFSR fault register format value on failure.
- */
-bool arm_tlb_fill(CPUState *cs, vaddr address,
-                  MMUAccessType access_type, int mmu_idx,
-                  ARMMMUFaultInfo *fi)
-{
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-    hwaddr phys_addr;
-    target_ulong page_size;
-    int prot;
-    int ret;
-    MemTxAttrs attrs = {};
-
-    ret = get_phys_addr(env, address, access_type,
-                        core_to_arm_mmu_idx(env, mmu_idx), &phys_addr,
-                        &attrs, &prot, &page_size, fi, NULL);
-    if (!ret) {
-        /*
-         * Map a single [sub]page. Regions smaller than our declared
-         * target page size are handled specially, so for those we
-         * pass in the exact addresses.
-         */
-        if (page_size >= TARGET_PAGE_SIZE) {
-            phys_addr &= TARGET_PAGE_MASK;
-            address &= TARGET_PAGE_MASK;
-        }
-        tlb_set_page_with_attrs(cs, address, phys_addr, attrs,
-                                prot, mmu_idx, page_size);
-        return 0;
-    }
-
-    return ret;
-}
-
 hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
                                          MemTxAttrs *attrs)
 {
@@ -12389,6 +12352,66 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
 
 #endif
 
+bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                      MMUAccessType access_type, int mmu_idx,
+                      bool probe, uintptr_t retaddr)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+
+#ifdef CONFIG_USER_ONLY
+    cpu->env.exception.vaddress = address;
+    if (access_type == MMU_INST_FETCH) {
+        cs->exception_index = EXCP_PREFETCH_ABORT;
+    } else {
+        cs->exception_index = EXCP_DATA_ABORT;
+    }
+    cpu_loop_exit_restore(cs, retaddr);
+#else
+    hwaddr phys_addr;
+    target_ulong page_size;
+    int prot, ret;
+    MemTxAttrs attrs = {};
+    ARMMMUFaultInfo fi = {};
+
+    /*
+     * Walk the page table and (if the mapping exists) add the page
+     * to the TLB. Return false on success, or true on failure. Populate
+     * fsr with ARM DFSR/IFSR fault register format value on failure.
+     */
+    ret = get_phys_addr(&cpu->env, address, access_type,
+                        core_to_arm_mmu_idx(&cpu->env, mmu_idx),
+                        &phys_addr, &attrs, &prot, &page_size, &fi, NULL);
+    if (likely(!ret)) {
+        /*
+         * Map a single [sub]page. Regions smaller than our declared
+         * target page size are handled specially, so for those we
+         * pass in the exact addresses.
+         */
+        if (page_size >= TARGET_PAGE_SIZE) {
+            phys_addr &= TARGET_PAGE_MASK;
+            address &= TARGET_PAGE_MASK;
+        }
+        tlb_set_page_with_attrs(cs, address, phys_addr, attrs,
+                                prot, mmu_idx, page_size);
+        return true;
+    } else if (probe) {
+        return false;
+    } else {
+        /* now we have a real cpu fault */
+        cpu_restore_state(cs, retaddr, true);
+        arm_deliver_fault(cpu, address, access_type, mmu_idx, &fi);
+    }
+#endif
+}
+
+#ifndef CONFIG_USER_ONLY
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    arm_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
+}
+#endif
+
 void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
 {
     /* Implement DC ZVA, which zeroes a fixed-length block of memory.
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 8698b4dc83..8ee15a4bd4 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -126,8 +126,8 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
     return syn;
 }
 
-static void deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_type,
-                          int mmu_idx, ARMMMUFaultInfo *fi)
+void arm_deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_type,
+                       int mmu_idx, ARMMMUFaultInfo *fi)
 {
     CPUARMState *env = &cpu->env;
     int target_el;
@@ -179,27 +179,6 @@ static void deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_type,
     raise_exception(env, exc, syn, target_el);
 }
 
-/* try to fill the TLB and return an exception if error. If retaddr is
- * NULL, it means that the function was called in C code (i.e. not
- * from generated code or from helper.c)
- */
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    bool ret;
-    ARMMMUFaultInfo fi = {};
-
-    ret = arm_tlb_fill(cs, addr, access_type, mmu_idx, &fi);
-    if (unlikely(ret)) {
-        ARMCPU *cpu = ARM_CPU(cs);
-
-        /* now we have a real cpu fault */
-        cpu_restore_state(cs, retaddr, true);
-
-        deliver_fault(cpu, addr, access_type, mmu_idx, &fi);
-    }
-}
-
 /* Raise a data fault alignment exception for the specified virtual address */
 void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
                                  MMUAccessType access_type,
@@ -212,7 +191,7 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     cpu_restore_state(cs, retaddr, true);
 
     fi.type = ARMFault_Alignment;
-    deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
+    arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
 }
 
 /* arm_cpu_do_transaction_failed: handle a memory system error response
@@ -233,7 +212,7 @@ void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
 
     fi.ea = arm_extabort_type(response);
     fi.type = ARMFault_SyncExternal;
-    deliver_fault(cpu, addr, access_type, mmu_idx, &fi);
+    arm_deliver_fault(cpu, addr, access_type, mmu_idx, &fi);
 }
 
 #endif /* !defined(CONFIG_USER_ONLY) */
-- 
2.17.1

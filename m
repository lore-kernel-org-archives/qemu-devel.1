Received: from eggs.gnu.org ([209.51.188.92]:48846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpY-0003Fp-EA
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpX-0000Qa-5j
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:52 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWpW-0000Pc-Ru
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:51 -0400
Received: by mail-pl1-x643.google.com with SMTP id g37so7314978plb.5
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:55 +0700
Message-Id: <20190403034358.21999-24-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 23/26] target/xtensa: Convert to
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
Cc: Max Filippov <jcmvbkbc@gmail.com>

Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/cpu.h    |  5 +--
 target/xtensa/cpu.c    |  5 ++-
 target/xtensa/helper.c | 74 +++++++++++++++++++++---------------------
 3 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 4d8152682f..8ac6f8eeca 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -552,8 +552,9 @@ static inline XtensaCPU *xtensa_env_get_cpu(const CPUXtensaState *env)
 #define ENV_OFFSET offsetof(XtensaCPU, env)
 
 
-int xtensa_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw, int size,
-                                int mmu_idx);
+bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                         MMUAccessType access_type, int mmu_idx,
+                         bool probe, uintptr_t retaddr);
 void xtensa_cpu_do_interrupt(CPUState *cpu);
 bool xtensa_cpu_exec_interrupt(CPUState *cpu, int interrupt_request);
 void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index a54dbe4260..da1236377e 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -181,9 +181,8 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_read_register = xtensa_cpu_gdb_read_register;
     cc->gdb_write_register = xtensa_cpu_gdb_write_register;
     cc->gdb_stop_before_watchpoint = true;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = xtensa_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = xtensa_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->do_unaligned_access = xtensa_cpu_do_unaligned_access;
     cc->get_phys_page_debug = xtensa_cpu_get_phys_page_debug;
     cc->do_transaction_failed = xtensa_cpu_do_transaction_failed;
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index f4867a9b56..3dcab54fbf 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -237,24 +237,49 @@ void xtensa_cpu_list(FILE *f, fprintf_function cpu_fprintf)
     }
 }
 
-#ifdef CONFIG_USER_ONLY
-
-int xtensa_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                                int mmu_idx)
+bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                         MMUAccessType access_type, int mmu_idx,
+                         bool probe, uintptr_t retaddr)
 {
     XtensaCPU *cpu = XTENSA_CPU(cs);
     CPUXtensaState *env = &cpu->env;
+    target_ulong vaddr = address;
+    int ret;
 
-    qemu_log_mask(CPU_LOG_INT,
-                  "%s: rw = %d, address = 0x%08" VADDR_PRIx ", size = %d\n",
-                  __func__, rw, address, size);
-    env->sregs[EXCVADDR] = address;
-    env->sregs[EXCCAUSE] = rw ? STORE_PROHIBITED_CAUSE : LOAD_PROHIBITED_CAUSE;
-    cs->exception_index = EXC_USER;
-    return 1;
+#ifdef CONFIG_USER_ONLY
+    ret = (access_type == MMU_DATA_STORE ?
+           STORE_PROHIBITED_CAUSE : LOAD_PROHIBITED_CAUSE);
+#else
+    uint32_t paddr;
+    uint32_t page_size;
+    unsigned access;
+
+    ret = xtensa_get_physical_addr(env, true, vaddr, access_type, mmu_idx,
+                                   &paddr, &page_size, &access);
+
+    qemu_log_mask(CPU_LOG_MMU, "%s(%08x, %d, %d) -> %08x, ret = %d\n",
+                  __func__, vaddr, access_type, mmu_idx, paddr, ret);
+
+    if (ret == 0) {
+        tlb_set_page(cs, vaddr & TARGET_PAGE_MASK, paddr & TARGET_PAGE_MASK,
+                     access, mmu_idx, page_size);
+        return true;
+    }
+    if (probe) {
+        return false;
+    }
+#endif
+
+    cpu_restore_state(cs, retaddr, true);
+    HELPER(exception_cause_vaddr)(env, env->pc, ret, vaddr);
 }
 
-#else
+#ifndef CONFIG_USER_ONLY
+void tlb_fill(CPUState *cs, target_ulong vaddr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    xtensa_cpu_tlb_fill(cs, vaddr, size, access_type, mmu_idx, false, retaddr);
+}
 
 void xtensa_cpu_do_unaligned_access(CPUState *cs,
                                     vaddr addr, MMUAccessType access_type,
@@ -272,31 +297,6 @@ void xtensa_cpu_do_unaligned_access(CPUState *cs,
     }
 }
 
-void tlb_fill(CPUState *cs, target_ulong vaddr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
-    uint32_t paddr;
-    uint32_t page_size;
-    unsigned access;
-    int ret = xtensa_get_physical_addr(env, true, vaddr, access_type, mmu_idx,
-                                       &paddr, &page_size, &access);
-
-    qemu_log_mask(CPU_LOG_MMU, "%s(%08x, %d, %d) -> %08x, ret = %d\n",
-                  __func__, vaddr, access_type, mmu_idx, paddr, ret);
-
-    if (ret == 0) {
-        tlb_set_page(cs,
-                     vaddr & TARGET_PAGE_MASK,
-                     paddr & TARGET_PAGE_MASK,
-                     access, mmu_idx, page_size);
-    } else {
-        cpu_restore_state(cs, retaddr, true);
-        HELPER(exception_cause_vaddr)(env, env->pc, ret, vaddr);
-    }
-}
-
 void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                       unsigned size, MMUAccessType access_type,
                                       int mmu_idx, MemTxAttrs attrs,
-- 
2.17.1

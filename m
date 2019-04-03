Received: from eggs.gnu.org ([209.51.188.92]:48673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpF-0002xF-6j
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpD-0008S8-VL
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:33 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWpD-0008RC-MO
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:31 -0400
Received: by mail-pf1-x444.google.com with SMTP id i19so7434164pfd.0
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:46 +0700
Message-Id: <20190403034358.21999-15-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 14/26] target/openrisc: Convert to
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
Cc: Stafford Horne <shorne@gmail.com>

Cc: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/cpu.h |  5 ++--
 target/openrisc/cpu.c |  5 ++--
 target/openrisc/mmu.c | 65 ++++++++++++++++++++++---------------------
 3 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index f1b31bc24a..cbd7c97230 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -345,8 +345,9 @@ hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int openrisc_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int openrisc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void openrisc_translate_init(void);
-int openrisc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
-                                  int rw, int mmu_idx);
+bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                           MMUAccessType access_type, int mmu_idx,
+                           bool probe, uintptr_t retaddr);
 int cpu_openrisc_signal_handler(int host_signum, void *pinfo, void *puc);
 int print_insn_or1k(bfd_vma addr, disassemble_info *info);
 
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 541b2a66c7..d38cd24275 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -148,9 +148,8 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
     cc->set_pc = openrisc_cpu_set_pc;
     cc->gdb_read_register = openrisc_cpu_gdb_read_register;
     cc->gdb_write_register = openrisc_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = openrisc_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = openrisc_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug = openrisc_cpu_get_phys_page_debug;
     dc->vmsd = &vmstate_openrisc_cpu;
 #endif
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index e7d5219e11..991f3fafe8 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -107,16 +107,42 @@ static void raise_mmu_exception(OpenRISCCPU *cpu, target_ulong address,
     cpu->env.lock_addr = -1;
 }
 
-int openrisc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                                  int rw, int mmu_idx)
+bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
+                           MMUAccessType access_type, int mmu_idx,
+                           bool probe, uintptr_t retaddr)
 {
-#ifdef CONFIG_USER_ONLY
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-    raise_mmu_exception(cpu, address, EXCP_DPF);
-    return 1;
-#else
-    g_assert_not_reached();
+    int excp = EXCP_DPF;
+
+#ifndef CONFIG_USER_ONLY
+    int prot;
+    hwaddr phys_addr;
+
+    if (mmu_idx == MMU_NOMMU_IDX) {
+        /* The mmu is disabled; lookups never fail.  */
+        get_phys_nommu(&phys_addr, &prot, addr);
+        excp = 0;
+    } else {
+        bool super = mmu_idx == MMU_SUPERVISOR_IDX;
+        int need = (access_type == MMU_INST_FETCH ? PAGE_EXEC
+                    : access_type == MMU_DATA_STORE ? PAGE_WRITE
+                    : PAGE_READ);
+        excp = get_phys_mmu(cpu, &phys_addr, &prot, addr, need, super);
+    }
+
+    if (likely(excp == 0)) {
+        tlb_set_page(cs, addr & TARGET_PAGE_MASK,
+                     phys_addr & TARGET_PAGE_MASK, prot,
+                     mmu_idx, TARGET_PAGE_SIZE);
+        return true;
+    }
+    if (probe) {
+        return false;
+    }
 #endif
+
+    raise_mmu_exception(cpu, addr, excp);
+    cpu_loop_exit_restore(cs, retaddr);
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -156,29 +182,6 @@ hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 void tlb_fill(CPUState *cs, target_ulong addr, int size,
               MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
-    OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-    int prot, excp;
-    hwaddr phys_addr;
-
-    if (mmu_idx == MMU_NOMMU_IDX) {
-        /* The mmu is disabled; lookups never fail.  */
-        get_phys_nommu(&phys_addr, &prot, addr);
-        excp = 0;
-    } else {
-        bool super = mmu_idx == MMU_SUPERVISOR_IDX;
-        int need = (access_type == MMU_INST_FETCH ? PAGE_EXEC
-                    : access_type == MMU_DATA_STORE ? PAGE_WRITE
-                    : PAGE_READ);
-        excp = get_phys_mmu(cpu, &phys_addr, &prot, addr, need, super);
-    }
-
-    if (unlikely(excp)) {
-        raise_mmu_exception(cpu, addr, excp);
-        cpu_loop_exit_restore(cs, retaddr);
-    }
-
-    tlb_set_page(cs, addr & TARGET_PAGE_MASK,
-                 phys_addr & TARGET_PAGE_MASK, prot,
-                 mmu_idx, TARGET_PAGE_SIZE);
+    openrisc_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, 0, retaddr);
 }
 #endif
-- 
2.17.1

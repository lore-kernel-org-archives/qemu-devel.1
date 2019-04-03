Received: from eggs.gnu.org ([209.51.188.92]:48725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpJ-00031q-NX
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpI-00005X-Cn
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:37 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWpI-0008WA-59
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:36 -0400
Received: by mail-pl1-x641.google.com with SMTP id b65so7312868plb.6
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:48 +0700
Message-Id: <20190403034358.21999-17-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 16/26] target/riscv: Convert to
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
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>

Note that env->pc is removed from the qemu_log as that value is garbage.
The PC isn't recovered until cpu_restore_state, called from
cpu_loop_exit_restore, called from riscv_raise_exception.

Cc: qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h        |  5 +++--
 target/riscv/cpu.c        |  5 ++---
 target/riscv/cpu_helper.c | 46 ++++++++++++++++++---------------------
 3 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 20bce8742e..40c1254408 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -261,8 +261,9 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                     MMUAccessType access_type, int mmu_idx,
                                     uintptr_t retaddr);
-int riscv_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
-                              int rw, int mmu_idx);
+bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr);
 char *riscv_isa_string(RISCVCPU *cpu);
 void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d61bce6d55..e9f569c665 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -355,9 +355,8 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
 #endif
     cc->gdb_stop_before_watchpoint = true;
     cc->disas_set_info = riscv_cpu_disas_set_info;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = riscv_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = riscv_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->do_unaligned_access = riscv_cpu_do_unaligned_access;
     cc->get_phys_page_debug = riscv_cpu_get_phys_page_debug;
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index b17f169681..2535435260 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -379,53 +379,49 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     riscv_raise_exception(env, cs->exception_index, retaddr);
 }
 
-/* called by qemu's softmmu to fill the qemu tlb */
 void tlb_fill(CPUState *cs, target_ulong addr, int size,
         MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
-    int ret;
-    ret = riscv_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (ret == TRANSLATE_FAIL) {
-        RISCVCPU *cpu = RISCV_CPU(cs);
-        CPURISCVState *env = &cpu->env;
-        riscv_raise_exception(env, cs->exception_index, retaddr);
-    }
+    riscv_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
 }
-
 #endif
 
-int riscv_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-        int rw, int mmu_idx)
+bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr)
 {
+#ifndef CONFIG_USER_ONLY
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
-#if !defined(CONFIG_USER_ONLY)
     hwaddr pa = 0;
     int prot;
-#endif
     int ret = TRANSLATE_FAIL;
 
-    qemu_log_mask(CPU_LOG_MMU,
-            "%s pc " TARGET_FMT_lx " ad %" VADDR_PRIx " rw %d mmu_idx \
-             %d\n", __func__, env->pc, address, rw, mmu_idx);
+    qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
+                  __func__, address, access_type, mmu_idx);
+
+    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx);
 
-#if !defined(CONFIG_USER_ONLY)
-    ret = get_physical_address(env, &pa, &prot, address, rw, mmu_idx);
     qemu_log_mask(CPU_LOG_MMU,
-            "%s address=%" VADDR_PRIx " ret %d physical " TARGET_FMT_plx
-             " prot %d\n", __func__, address, ret, pa, prot);
+                  "%s address=%" VADDR_PRIx " ret %d physical " TARGET_FMT_plx
+                  " prot %d\n", __func__, address, ret, pa, prot);
+
     if (riscv_feature(env, RISCV_FEATURE_PMP) &&
-        !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << rw)) {
+        !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type)) {
         ret = TRANSLATE_FAIL;
     }
     if (ret == TRANSLATE_SUCCESS) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK, pa & TARGET_PAGE_MASK,
                      prot, mmu_idx, TARGET_PAGE_SIZE);
-    } else if (ret == TRANSLATE_FAIL) {
-        raise_mmu_exception(env, address, rw);
+        return true;
+    } else if (probe) {
+        return false;
+    } else {
+        raise_mmu_exception(env, address, access_type);
+        riscv_raise_exception(env, cs->exception_index, retaddr);
     }
 #else
-    switch (rw) {
+    switch (access_type) {
     case MMU_INST_FETCH:
         cs->exception_index = RISCV_EXCP_INST_PAGE_FAULT;
         break;
@@ -436,8 +432,8 @@ int riscv_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
         cs->exception_index = RISCV_EXCP_STORE_PAGE_FAULT;
         break;
     }
+    cpu_loop_exit_restore(cs, retaddr);
 #endif
-    return ret;
 }
 
 /*
-- 
2.17.1

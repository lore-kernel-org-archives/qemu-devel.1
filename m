Received: from eggs.gnu.org ([209.51.188.92]:48786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpQ-000382-Qu
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpP-0000CR-6j
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:44 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWpO-0000Bt-Rm
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:43 -0400
Received: by mail-pf1-x442.google.com with SMTP id i19so7434372pfd.0
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:51 +0700
Message-Id: <20190403034358.21999-20-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 19/26] target/sparc: Convert to
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
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h         |   5 +-
 target/sparc/cpu.c         |   5 +-
 target/sparc/ldst_helper.c |  15 ----
 target/sparc/mmu_helper.c  | 175 +++++++++++++++++++------------------
 4 files changed, 93 insertions(+), 107 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 4972ebcfd4..44336e5899 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -580,8 +580,9 @@ void cpu_raise_exception_ra(CPUSPARCState *, int, uintptr_t) QEMU_NORETURN;
 void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu);
 void sparc_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 /* mmu_helper.c */
-int sparc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                               int mmu_idx);
+bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr);
 target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev);
 void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUSPARCState *env);
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 4a4445bdf5..016a70717e 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -880,9 +880,8 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
     cc->synchronize_from_tb = sparc_cpu_synchronize_from_tb;
     cc->gdb_read_register = sparc_cpu_gdb_read_register;
     cc->gdb_write_register = sparc_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = sparc_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = sparc_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->do_unassigned_access = sparc_cpu_unassigned_access;
     cc->do_unaligned_access = sparc_cpu_do_unaligned_access;
     cc->get_phys_page_debug = sparc_cpu_get_phys_page_debug;
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 5bc090213c..88196a3ad9 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1924,19 +1924,4 @@ void QEMU_NORETURN sparc_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 #endif
     cpu_raise_exception_ra(env, TT_UNALIGNED, retaddr);
 }
-
-/* try to fill the TLB and return an exception if error. If retaddr is
-   NULL, it means that the function was called in C code (i.e. not
-   from generated code or from helper.c) */
-/* XXX: fix it to restore all registers */
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    int ret;
-
-    ret = sparc_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (ret) {
-        cpu_loop_exit_restore(cs, retaddr);
-    }
-}
 #endif
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 135a9c9d9b..b0fdabbea3 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -24,28 +24,7 @@
 
 /* Sparc MMU emulation */
 
-#if defined(CONFIG_USER_ONLY)
-
-int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                               int mmu_idx)
-{
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
-
-    if (rw & 2) {
-        cs->exception_index = TT_TFAULT;
-    } else {
-        cs->exception_index = TT_DFAULT;
-#ifdef TARGET_SPARC64
-        env->dmmu.mmuregs[4] = address;
-#else
-        env->mmuregs[4] = address;
-#endif
-    }
-    return 1;
-}
-
-#else
+#ifndef CONFIG_USER_ONLY
 
 #ifndef TARGET_SPARC64
 /*
@@ -85,10 +64,10 @@ static const int perm_table[2][8] = {
     }
 };
 
-static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
-                                int *prot, int *access_index,
-                                target_ulong address, int rw, int mmu_idx,
-                                target_ulong *page_size)
+static int get_physical_address1(CPUSPARCState *env, hwaddr *physical,
+                                 int *prot, int *access_index,
+                                 target_ulong address, int rw, int mmu_idx,
+                                 target_ulong *page_size)
 {
     int access_perms = 0;
     hwaddr pde_ptr;
@@ -206,51 +185,41 @@ static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
     return error_code;
 }
 
-/* Perform address translation */
-int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                               int mmu_idx)
+static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
+                                int *prot, int *access_index,
+                                target_ulong address, int rw, int mmu_idx,
+                                target_ulong *page_size)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
-    hwaddr paddr;
-    target_ulong vaddr;
-    target_ulong page_size;
-    int error_code = 0, prot, access_index;
+    int error_code;
+    CPUState *cs = CPU(sparc_env_get_cpu(env));
 
-    address &= TARGET_PAGE_MASK;
-    error_code = get_physical_address(env, &paddr, &prot, &access_index,
-                                      address, rw, mmu_idx, &page_size);
-    vaddr = address;
-    if (error_code == 0) {
-        qemu_log_mask(CPU_LOG_MMU,
-                "Translate at %" VADDR_PRIx " -> " TARGET_FMT_plx ", vaddr "
-                TARGET_FMT_lx "\n", address, paddr, vaddr);
-        tlb_set_page(cs, vaddr, paddr, prot, mmu_idx, page_size);
+    error_code = get_physical_address1(env, physical, prot, access_index,
+                                       address, rw, mmu_idx, page_size);
+
+    if (error_code && ((env->mmuregs[0] & MMU_NF) || env->psret == 0))  {
+        /*
+         * No fault mode: if a mapping is available, just override
+         * permissions. If no mapping is available, redirect accesses to
+         * neverland. Fake/overridden mappings will be flushed when
+         * switching to normal mode.
+         */
+        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         return 0;
     }
 
     if (env->mmuregs[3]) { /* Fault status register */
         env->mmuregs[3] = 1; /* overflow (not read before another fault) */
     }
-    env->mmuregs[3] |= (access_index << 5) | error_code | 2;
+    env->mmuregs[3] |= (*access_index << 5) | error_code | 2;
     env->mmuregs[4] = address; /* Fault address register */
 
-    if ((env->mmuregs[0] & MMU_NF) || env->psret == 0)  {
-        /* No fault mode: if a mapping is available, just override
-           permissions. If no mapping is available, redirect accesses to
-           neverland. Fake/overridden mappings will be flushed when
-           switching to normal mode. */
-        prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-        tlb_set_page(cs, vaddr, paddr, prot, mmu_idx, TARGET_PAGE_SIZE);
-        return 0;
+    if (rw & 2) {
+        cs->exception_index = TT_TFAULT;
     } else {
-        if (rw & 2) {
-            cs->exception_index = TT_TFAULT;
-        } else {
-            cs->exception_index = TT_DFAULT;
-        }
-        return 1;
+        cs->exception_index = TT_DFAULT;
     }
+
+    return error_code;
 }
 
 target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev)
@@ -711,34 +680,6 @@ static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
     }
 }
 
-/* Perform address translation */
-int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                               int mmu_idx)
-{
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
-    target_ulong vaddr;
-    hwaddr paddr;
-    target_ulong page_size;
-    int error_code = 0, prot, access_index;
-
-    address &= TARGET_PAGE_MASK;
-    error_code = get_physical_address(env, &paddr, &prot, &access_index,
-                                      address, rw, mmu_idx, &page_size);
-    if (error_code == 0) {
-        vaddr = address;
-
-        trace_mmu_helper_mmu_fault(address, paddr, mmu_idx, env->tl,
-                                   env->dmmu.mmu_primary_context,
-                                   env->dmmu.mmu_secondary_context);
-
-        tlb_set_page(cs, vaddr, paddr, prot, mmu_idx, page_size);
-        return 0;
-    }
-    /* XXX */
-    return 1;
-}
-
 void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUSPARCState *env)
 {
     unsigned int i;
@@ -865,3 +806,63 @@ hwaddr sparc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return phys_addr;
 }
 #endif
+
+/* Perform address translation */
+bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr)
+{
+    SPARCCPU *cpu = SPARC_CPU(cs);
+    CPUSPARCState *env = &cpu->env;
+
+#ifdef CONFIG_USER_ONLY
+    if (access_type == MMU_INST_FETCH) {
+        cs->exception_index = TT_TFAULT;
+    } else {
+        cs->exception_index = TT_DFAULT;
+    }
+# ifdef TARGET_SPARC64
+    env->dmmu.mmuregs[4] = address;
+# else
+    env->mmuregs[4] = address;
+# endif
+#else
+    hwaddr paddr;
+    target_ulong vaddr;
+    target_ulong page_size;
+    int error_code = 0, prot, access_index;
+
+    address &= TARGET_PAGE_MASK;
+    error_code = get_physical_address(env, &paddr, &prot, &access_index,
+                                      address, access_type, mmu_idx,
+                                      &page_size);
+    vaddr = address;
+    if (error_code == 0) {
+# ifdef TARGET_SPARC64
+        trace_mmu_helper_mmu_fault(address, paddr, mmu_idx, env->tl,
+                                   env->dmmu.mmu_primary_context,
+                                   env->dmmu.mmu_secondary_context);
+# else
+        qemu_log_mask(CPU_LOG_MMU,
+                "Translate at %" VADDR_PRIx " -> " TARGET_FMT_plx ", vaddr "
+                TARGET_FMT_lx "\n", address, paddr, vaddr);
+# endif
+        tlb_set_page(cs, vaddr, paddr, prot, mmu_idx, page_size);
+        return true;
+    }
+
+    if (probe) {
+        return false;
+    }
+#endif
+
+    cpu_loop_exit_restore(cs, retaddr);
+}
+
+#ifndef CONFIG_USER_ONLY
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    sparc_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
+}
+#endif
-- 
2.17.1

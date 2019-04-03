Received: from eggs.gnu.org ([209.51.188.92]:48492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWou-0002f5-8h
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWos-0007zp-VG
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:12 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWos-0007yC-LP
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:10 -0400
Received: by mail-pl1-x643.google.com with SMTP id ck15so6123252plb.3
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:10 -0700 (PDT)
Received: from cloudburst.imgcgcw.net ([147.50.13.10])
	by smtp.gmail.com with ESMTPSA id
	z6sm26753214pgo.31.2019.04.02.20.44.06 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 02 Apr 2019 20:44:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:35 +0700
Message-Id: <20190403034358.21999-4-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 03/26] target/alpha: Convert to
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.h        |  5 ++--
 target/alpha/cpu.c        |  5 ++--
 target/alpha/helper.c     | 50 +++++++++++++++++++++++----------------
 target/alpha/mem_helper.c | 16 -------------
 4 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 7b50be785d..aecf8d75c1 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -476,8 +476,9 @@ void alpha_cpu_list(FILE *f, fprintf_function cpu_fprintf);
    is returned if the signal was handled by the virtual CPU.  */
 int cpu_alpha_signal_handler(int host_signum, void *pinfo,
                              void *puc);
-int alpha_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                               int mmu_idx);
+bool alpha_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr);
 void QEMU_NORETURN dynamic_excp(CPUAlphaState *, uintptr_t, int, int);
 void QEMU_NORETURN arith_excp(CPUAlphaState *, uintptr_t, int, uint64_t);
 
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 1fd95d6c0f..5aa4581b9f 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -230,9 +230,8 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
     cc->set_pc = alpha_cpu_set_pc;
     cc->gdb_read_register = alpha_cpu_gdb_read_register;
     cc->gdb_write_register = alpha_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = alpha_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = alpha_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->do_transaction_failed = alpha_cpu_do_transaction_failed;
     cc->do_unaligned_access = alpha_cpu_do_unaligned_access;
     cc->get_phys_page_debug = alpha_cpu_get_phys_page_debug;
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 57e2c212b3..e54197d5fb 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -102,17 +102,7 @@ void cpu_alpha_store_gr(CPUAlphaState *env, unsigned reg, uint64_t val)
     *cpu_alpha_addr_gr(env, reg) = val;
 }
 
-#if defined(CONFIG_USER_ONLY)
-int alpha_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                               int rw, int mmu_idx)
-{
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-
-    cs->exception_index = EXCP_MMFAULT;
-    cpu->env.trap_arg0 = address;
-    return 1;
-}
-#else
+#ifndef CONFIG_USER_ONLY
 /* Returns the OSF/1 entMM failure indication, or -1 on success.  */
 static int get_physical_address(CPUAlphaState *env, target_ulong addr,
                                 int prot_need, int mmu_idx,
@@ -246,29 +236,49 @@ hwaddr alpha_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     fail = get_physical_address(&cpu->env, addr, 0, 0, &phys, &prot);
     return (fail >= 0 ? -1 : phys);
 }
+#endif /* !USER_ONLY */
 
-int alpha_cpu_handle_mmu_fault(CPUState *cs, vaddr addr, int size, int rw,
-                               int mmu_idx)
+bool alpha_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr)
 {
     AlphaCPU *cpu = ALPHA_CPU(cs);
+
+#ifdef CONFIG_USER_ONLY
+    cs->exception_index = EXCP_MMFAULT;
+    cpu->env.trap_arg0 = address;
+    cpu_loop_exit_restore(cs, retaddr);
+#else
     CPUAlphaState *env = &cpu->env;
     target_ulong phys;
     int prot, fail;
 
-    fail = get_physical_address(env, addr, 1 << rw, mmu_idx, &phys, &prot);
+    fail = get_physical_address(env, address, 1 << access_type,
+                                mmu_idx, &phys, &prot);
     if (unlikely(fail >= 0)) {
+        if (probe) {
+            return false;
+        }
         cs->exception_index = EXCP_MMFAULT;
-        env->trap_arg0 = addr;
+        env->trap_arg0 = address;
         env->trap_arg1 = fail;
-        env->trap_arg2 = (rw == 2 ? -1 : rw);
-        return 1;
+        env->trap_arg2 = (access_type == MMU_INST_FETCH ? -1 : access_type);
+        cpu_loop_exit_restore(cs, retaddr);
     }
 
-    tlb_set_page(cs, addr & TARGET_PAGE_MASK, phys & TARGET_PAGE_MASK,
+    tlb_set_page(cs, address & TARGET_PAGE_MASK, phys & TARGET_PAGE_MASK,
                  prot, mmu_idx, TARGET_PAGE_SIZE);
-    return 0;
+    return true;
+#endif
 }
-#endif /* USER_ONLY */
+
+#ifndef CONFIG_USER_ONLY
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    alpha_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
+}
+#endif
 
 void alpha_cpu_do_interrupt(CPUState *cs)
 {
diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index 011bc73dca..934faa1d6f 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -62,20 +62,4 @@ void alpha_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
     env->error_code = 0;
     cpu_loop_exit_restore(cs, retaddr);
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
-    ret = alpha_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (unlikely(ret != 0)) {
-        /* Exception index and error code are already set */
-        cpu_loop_exit_restore(cs, retaddr);
-    }
-}
 #endif /* CONFIG_USER_ONLY */
-- 
2.17.1

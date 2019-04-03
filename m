Received: from eggs.gnu.org ([209.51.188.92]:48698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpH-0002zQ-EB
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpG-0008Tp-39
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:35 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWpF-0008TG-SU
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:34 -0400
Received: by mail-pl1-x644.google.com with SMTP id y6so7330692plt.1
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:47 +0700
Message-Id: <20190403034358.21999-16-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 15/26] target/ppc: Convert to CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Cc: qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu.h                |  7 +++----
 target/ppc/mmu_helper.c         | 19 +++++++++++++------
 target/ppc/translate_init.inc.c |  5 ++---
 target/ppc/user_only_helper.c   | 14 ++++++++------
 4 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0707177584..da73d3ee5b 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1297,10 +1297,9 @@ void ppc_translate_init(void);
    is returned if the signal was handled by the virtual CPU.  */
 int cpu_ppc_signal_handler (int host_signum, void *pinfo,
                             void *puc);
-#if defined(CONFIG_USER_ONLY)
-int ppc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                             int mmu_idx);
-#endif
+bool ppc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                      MMUAccessType access_type, int mmu_idx,
+                      bool probe, uintptr_t retaddr);
 
 #if !defined(CONFIG_USER_ONLY)
 void ppc_store_sdr1 (CPUPPCState *env, target_ulong value);
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 4a6be4d63b..6865c0ca37 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -3026,12 +3026,9 @@ void helper_check_tlb_flush_global(CPUPPCState *env)
 
 /*****************************************************************************/
 
-/* try to fill the TLB and return an exception if error. If retaddr is
-   NULL, it means that the function was called in C code (i.e. not
-   from generated code or from helper.c) */
-/* XXX: fix it to restore all registers */
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+bool ppc_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
+                      MMUAccessType access_type, int mmu_idx,
+                      bool probe, uintptr_t retaddr)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
@@ -3044,7 +3041,17 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
         ret = cpu_ppc_handle_mmu_fault(env, addr, access_type, mmu_idx);
     }
     if (unlikely(ret != 0)) {
+        if (probe) {
+            return false;
+        }
         raise_exception_err_ra(env, cs->exception_index, env->error_code,
                                retaddr);
     }
+    return true;
+}
+
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    ppc_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
 }
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 0bd555eb19..39f37bba5b 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10545,9 +10545,8 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_read_register = ppc_cpu_gdb_read_register;
     cc->gdb_write_register = ppc_cpu_gdb_write_register;
     cc->do_unaligned_access = ppc_cpu_do_unaligned_access;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = ppc_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = ppc_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug = ppc_cpu_get_phys_page_debug;
     cc->vmsd = &vmstate_ppc_cpu;
 #endif
diff --git a/target/ppc/user_only_helper.c b/target/ppc/user_only_helper.c
index 2f1477f102..683c03390d 100644
--- a/target/ppc/user_only_helper.c
+++ b/target/ppc/user_only_helper.c
@@ -20,21 +20,24 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "exec/exec-all.h"
 
-int ppc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                             int mmu_idx)
+
+bool ppc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                      MMUAccessType access_type, int mmu_idx,
+                      bool probe, uintptr_t retaddr)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
     int exception, error_code;
 
-    if (rw == 2) {
+    if (access_type == MMU_INST_FETCH) {
         exception = POWERPC_EXCP_ISI;
         error_code = 0x40000000;
     } else {
         exception = POWERPC_EXCP_DSI;
         error_code = 0x40000000;
-        if (rw) {
+        if (access_type == MMU_DATA_STORE) {
             error_code |= 0x02000000;
         }
         env->spr[SPR_DAR] = address;
@@ -42,6 +45,5 @@ int ppc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
     }
     cs->exception_index = exception;
     env->error_code = error_code;
-
-    return 1;
+    cpu_loop_exit_restore(cs, retaddr);
 }
-- 
2.17.1

Received: from eggs.gnu.org ([209.51.188.92]:48554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWoy-0002j3-K8
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWox-000886-AP
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:16 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWow-00085l-W5
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:15 -0400
Received: by mail-pf1-x444.google.com with SMTP id c8so7423651pfd.10
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:14 -0700 (PDT)
Received: from cloudburst.imgcgcw.net ([147.50.13.10])
	by smtp.gmail.com with ESMTPSA id
	z6sm26753214pgo.31.2019.04.02.20.44.12 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 02 Apr 2019 20:44:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:38 +0700
Message-Id: <20190403034358.21999-7-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 06/26] target/hppa: Convert to
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
 target/hppa/cpu.h        |  8 ++++----
 target/hppa/cpu.c        |  5 ++---
 target/hppa/mem_helper.c | 22 +++++++++++++++++-----
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index c062c7969c..e0e5d879e1 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -360,10 +360,10 @@ int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void hppa_cpu_do_interrupt(CPUState *cpu);
 bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void hppa_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function, int);
-#ifdef CONFIG_USER_ONLY
-int hppa_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
-                              int rw, int midx);
-#else
+bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr);
+#ifndef CONFIG_USER_ONLY
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
                               int type, hwaddr *pphys, int *pprot);
 extern const MemoryRegionOps hppa_io_eir_ops;
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 00bf444620..46750980f7 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -167,9 +167,8 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
     cc->synchronize_from_tb = hppa_cpu_synchronize_from_tb;
     cc->gdb_read_register = hppa_cpu_gdb_read_register;
     cc->gdb_write_register = hppa_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = hppa_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = hppa_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug = hppa_cpu_get_phys_page_debug;
     dc->vmsd = &vmstate_hppa_cpu;
 #endif
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index c9b57d07c3..f61b0fdb9f 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -25,8 +25,9 @@
 #include "trace.h"
 
 #ifdef CONFIG_USER_ONLY
-int hppa_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
-                              int size, int rw, int mmu_idx)
+bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
 
@@ -34,7 +35,7 @@ int hppa_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
        which would affect si_code.  */
     cs->exception_index = EXCP_DMP;
     cpu->env.cr[CR_IOR] = address;
-    return 1;
+    cpu_loop_exit_restore(cs, retaddr);
 }
 #else
 static hppa_tlb_entry *hppa_find_tlb(CPUHPPAState *env, vaddr addr)
@@ -214,8 +215,9 @@ hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return excp == EXCP_DTLB_MISS ? -1 : phys;
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType type, int mmu_idx, uintptr_t retaddr)
+bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
+                       MMUAccessType type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
@@ -237,6 +239,9 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
     excp = hppa_get_physical_address(env, addr, mmu_idx,
                                      a_prot, &phys, &prot);
     if (unlikely(excp >= 0)) {
+        if (probe) {
+            return false;
+        }
         trace_hppa_tlb_fill_excp(env, addr, size, type, mmu_idx);
         /* Failure.  Raise the indicated exception.  */
         cs->exception_index = excp;
@@ -253,6 +258,13 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
     /* Success!  Store the translation into the QEMU TLB.  */
     tlb_set_page(cs, addr & TARGET_PAGE_MASK, phys & TARGET_PAGE_MASK,
                  prot, mmu_idx, TARGET_PAGE_SIZE);
+    return true;
+}
+
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType type, int mmu_idx, uintptr_t retaddr)
+{
+    hppa_cpu_tlb_fill(cs, addr, size, type, mmu_idx, false, retaddr);
 }
 
 /* Insert (Insn/Data) TLB Address.  Note this is PA 1.1 only.  */
-- 
2.17.1

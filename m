Received: from eggs.gnu.org ([209.51.188.92]:48646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpA-0002t9-Sf
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWp9-0008OA-FR
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:28 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWp9-0008NQ-5m
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:27 -0400
Received: by mail-pf1-x444.google.com with SMTP id y13so7421325pfm.11
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:44 +0700
Message-Id: <20190403034358.21999-13-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 12/26] target/moxie: Convert to
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
Cc: Anthony Green <green@moxielogic.com>

Cc: Anthony Green <green@moxielogic.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/moxie/cpu.h    |  5 ++--
 target/moxie/cpu.c    |  5 ++--
 target/moxie/helper.c | 61 ++++++++++---------------------------------
 3 files changed, 19 insertions(+), 52 deletions(-)

diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index 080df4ee6f..a82c2caf30 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -140,7 +140,8 @@ static inline void cpu_get_tb_cpu_state(CPUMoxieState *env, target_ulong *pc,
     *flags = 0;
 }
 
-int moxie_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
-                               int rw, int mmu_idx);
+bool moxie_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr);
 
 #endif /* MOXIE_CPU_H */
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 46434e65ba..02b2b47574 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -112,9 +112,8 @@ static void moxie_cpu_class_init(ObjectClass *oc, void *data)
     cc->do_interrupt = moxie_cpu_do_interrupt;
     cc->dump_state = moxie_cpu_dump_state;
     cc->set_pc = moxie_cpu_set_pc;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = moxie_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = moxie_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug = moxie_cpu_get_phys_page_debug;
     cc->vmsd = &vmstate_moxie_cpu;
 #endif
diff --git a/target/moxie/helper.c b/target/moxie/helper.c
index f3d8ee7d6b..216cef057e 100644
--- a/target/moxie/helper.c
+++ b/target/moxie/helper.c
@@ -26,18 +26,10 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 
-/* Try to fill the TLB and return an exception if error. If retaddr is
-   NULL, it means that the function was called in C code (i.e. not
-   from generated code or from helper.c) */
 void tlb_fill(CPUState *cs, target_ulong addr, int size,
               MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
-    int ret;
-
-    ret = moxie_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (unlikely(ret)) {
-        cpu_loop_exit_restore(cs, retaddr);
-    }
+    moxie_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
 }
 
 void helper_raise_exception(CPUMoxieState *env, int ex)
@@ -85,53 +77,29 @@ void helper_debug(CPUMoxieState *env)
     cpu_loop_exit(cs);
 }
 
-#if defined(CONFIG_USER_ONLY)
-
-void moxie_cpu_do_interrupt(CPUState *cs)
-{
-    CPUState *cs = CPU(moxie_env_get_cpu(env));
-
-    cs->exception_index = -1;
-}
-
-int moxie_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                               int rw, int mmu_idx)
-{
-    MoxieCPU *cpu = MOXIE_CPU(cs);
-
-    cs->exception_index = 0xaa;
-    cpu->env.debug1 = address;
-    cpu_dump_state(cs, stderr, fprintf, 0);
-    return 1;
-}
-
-#else /* !CONFIG_USER_ONLY */
-
-int moxie_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                               int rw, int mmu_idx)
+bool moxie_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr)
 {
     MoxieCPU *cpu = MOXIE_CPU(cs);
     CPUMoxieState *env = &cpu->env;
     MoxieMMUResult res;
     int prot, miss;
-    target_ulong phy;
-    int r = 1;
 
     address &= TARGET_PAGE_MASK;
     prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-    miss = moxie_mmu_translate(&res, env, address, rw, mmu_idx);
-    if (miss) {
-        /* handle the miss.  */
-        phy = 0;
-        cs->exception_index = MOXIE_EX_MMU_MISS;
-    } else {
-        phy = res.phy;
-        r = 0;
+    miss = moxie_mmu_translate(&res, env, address, access_type, mmu_idx);
+    if (likely(!miss)) {
+        tlb_set_page(cs, address, res.phy, prot, mmu_idx, TARGET_PAGE_SIZE);
+        return true;
+    }
+    if (probe) {
+        return false;
     }
-    tlb_set_page(cs, address, phy, prot, mmu_idx, TARGET_PAGE_SIZE);
-    return r;
-}
 
+    cs->exception_index = MOXIE_EX_MMU_MISS;
+    cpu_loop_exit_restore(cs, retaddr);
+}
 
 void moxie_cpu_do_interrupt(CPUState *cs)
 {
@@ -156,4 +124,3 @@ hwaddr moxie_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     }
     return phy;
 }
-#endif
-- 
2.17.1

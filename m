Received: from eggs.gnu.org ([209.51.188.92]:48588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWp2-0002mr-AN
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWp1-0008FF-7i
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:20 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWp0-0008DM-Uq
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:19 -0400
Received: by mail-pl1-x642.google.com with SMTP id b3so4337150plr.7
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:40 +0700
Message-Id: <20190403034358.21999-9-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 08/26] target/lm32: Convert to
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
Cc: Michael Walle <michael@walle.cc>

Cc: Michael Walle <michael@walle.cc>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/lm32/cpu.h       |  5 +++--
 target/lm32/cpu.c       |  5 ++---
 target/lm32/helper.c    | 12 +++++++++---
 target/lm32/op_helper.c | 16 ----------------
 4 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 66157eefe9..7cc279bcd0 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -262,8 +262,9 @@ bool lm32_cpu_do_semihosting(CPUState *cs);
 #define cpu_list lm32_cpu_list
 #define cpu_signal_handler cpu_lm32_signal_handler
 
-int lm32_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                              int mmu_idx);
+bool lm32_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr);
 
 #include "exec/cpu-all.h"
 
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index b7499cb627..6d2a176c87 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -235,9 +235,8 @@ static void lm32_cpu_class_init(ObjectClass *oc, void *data)
     cc->set_pc = lm32_cpu_set_pc;
     cc->gdb_read_register = lm32_cpu_gdb_read_register;
     cc->gdb_write_register = lm32_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = lm32_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = lm32_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug = lm32_cpu_get_phys_page_debug;
     cc->vmsd = &vmstate_lm32_cpu;
 #endif
diff --git a/target/lm32/helper.c b/target/lm32/helper.c
index a039a993ff..1db9a5562e 100644
--- a/target/lm32/helper.c
+++ b/target/lm32/helper.c
@@ -25,8 +25,9 @@
 #include "exec/semihost.h"
 #include "exec/log.h"
 
-int lm32_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                              int mmu_idx)
+bool lm32_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
 {
     LM32CPU *cpu = LM32_CPU(cs);
     CPULM32State *env = &cpu->env;
@@ -40,8 +41,13 @@ int lm32_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
     } else {
         tlb_set_page(cs, address, address, prot, mmu_idx, TARGET_PAGE_SIZE);
     }
+    return true;
+}
 
-    return 0;
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    lm32_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
 }
 
 hwaddr lm32_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
index 234d55e056..be12b11b02 100644
--- a/target/lm32/op_helper.c
+++ b/target/lm32/op_helper.c
@@ -143,21 +143,5 @@ uint32_t HELPER(rcsr_jrx)(CPULM32State *env)
 {
     return lm32_juart_get_jrx(env->juart_state);
 }
-
-/* Try to fill the TLB and return an exception if error. If retaddr is
- * NULL, it means that the function was called in C code (i.e. not
- * from generated code or from helper.c)
- */
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    int ret;
-
-    ret = lm32_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (unlikely(ret)) {
-        /* now we have a real cpu fault */
-        cpu_loop_exit_restore(cs, retaddr);
-    }
-}
 #endif
 
-- 
2.17.1

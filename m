Received: from eggs.gnu.org ([209.51.188.92]:44727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gix09-0006VO-3e
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gix07-00021n-W8
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:49:41 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:35599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gix06-0001xB-56
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:49:39 -0500
Received: by mail-lj1-x242.google.com with SMTP id x85-v6so18121499ljb.2
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 23:49:34 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 13 Jan 2019 23:48:55 -0800
Message-Id: <20190114074855.16891-8-jcmvbkbc@gmail.com>
In-Reply-To: <20190114074855.16891-1-jcmvbkbc@gmail.com>
References: <20190114074855.16891-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 7/7] target/xtensa: move non-HELPER functions
 to helper.c
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

Move remaining non-HELPER functions from op_helper.c to helper.c.
No functional changes.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/helper.c    | 61 ++++++++++++++++++++++++++++++++++++++++++++---
 target/xtensa/op_helper.c | 56 -------------------------------------------
 2 files changed, 58 insertions(+), 59 deletions(-)

diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 2f1dec5c63e9..323c47a7fb54 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -29,10 +29,8 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
+#include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
-#if !defined(CONFIG_USER_ONLY)
-#include "hw/loader.h"
-#endif
 
 static struct XtensaConfigList *xtensa_cores;
 
@@ -188,6 +186,63 @@ int xtensa_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
 
 #else
 
+void xtensa_cpu_do_unaligned_access(CPUState *cs,
+                                    vaddr addr, MMUAccessType access_type,
+                                    int mmu_idx, uintptr_t retaddr)
+{
+    XtensaCPU *cpu = XTENSA_CPU(cs);
+    CPUXtensaState *env = &cpu->env;
+
+    if (xtensa_option_enabled(env->config, XTENSA_OPTION_UNALIGNED_EXCEPTION) &&
+        !xtensa_option_enabled(env->config, XTENSA_OPTION_HW_ALIGNMENT)) {
+        cpu_restore_state(CPU(cpu), retaddr, true);
+        HELPER(exception_cause_vaddr)(env,
+                                      env->pc, LOAD_STORE_ALIGNMENT_CAUSE,
+                                      addr);
+    }
+}
+
+void tlb_fill(CPUState *cs, target_ulong vaddr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    XtensaCPU *cpu = XTENSA_CPU(cs);
+    CPUXtensaState *env = &cpu->env;
+    uint32_t paddr;
+    uint32_t page_size;
+    unsigned access;
+    int ret = xtensa_get_physical_addr(env, true, vaddr, access_type, mmu_idx,
+                                       &paddr, &page_size, &access);
+
+    qemu_log_mask(CPU_LOG_MMU, "%s(%08x, %d, %d) -> %08x, ret = %d\n",
+                  __func__, vaddr, access_type, mmu_idx, paddr, ret);
+
+    if (ret == 0) {
+        tlb_set_page(cs,
+                     vaddr & TARGET_PAGE_MASK,
+                     paddr & TARGET_PAGE_MASK,
+                     access, mmu_idx, page_size);
+    } else {
+        cpu_restore_state(cs, retaddr, true);
+        HELPER(exception_cause_vaddr)(env, env->pc, ret, vaddr);
+    }
+}
+
+void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
+                                      unsigned size, MMUAccessType access_type,
+                                      int mmu_idx, MemTxAttrs attrs,
+                                      MemTxResult response, uintptr_t retaddr)
+{
+    XtensaCPU *cpu = XTENSA_CPU(cs);
+    CPUXtensaState *env = &cpu->env;
+
+    cpu_restore_state(cs, retaddr, true);
+    HELPER(exception_cause_vaddr)(env, env->pc,
+                                  access_type == MMU_INST_FETCH ?
+                                  INSTR_PIF_ADDR_ERROR_CAUSE :
+                                  LOAD_STORE_PIF_ADDR_ERROR_CAUSE,
+                                  addr);
+}
+
 void xtensa_runstall(CPUXtensaState *env, bool runstall)
 {
     CPUState *cpu = CPU(xtensa_env_get_cpu(env));
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index b0ef828f9ae5..1865f46c4b5f 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -37,62 +37,6 @@
 
 #ifndef CONFIG_USER_ONLY
 
-void xtensa_cpu_do_unaligned_access(CPUState *cs,
-        vaddr addr, MMUAccessType access_type,
-        int mmu_idx, uintptr_t retaddr)
-{
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
-
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_UNALIGNED_EXCEPTION) &&
-            !xtensa_option_enabled(env->config, XTENSA_OPTION_HW_ALIGNMENT)) {
-        cpu_restore_state(CPU(cpu), retaddr, true);
-        HELPER(exception_cause_vaddr)(env,
-                env->pc, LOAD_STORE_ALIGNMENT_CAUSE, addr);
-    }
-}
-
-void tlb_fill(CPUState *cs, target_ulong vaddr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
-    uint32_t paddr;
-    uint32_t page_size;
-    unsigned access;
-    int ret = xtensa_get_physical_addr(env, true, vaddr, access_type, mmu_idx,
-            &paddr, &page_size, &access);
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
-void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
-                                      unsigned size, MMUAccessType access_type,
-                                      int mmu_idx, MemTxAttrs attrs,
-                                      MemTxResult response, uintptr_t retaddr)
-{
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
-
-    cpu_restore_state(cs, retaddr, true);
-    HELPER(exception_cause_vaddr)(env, env->pc,
-                                  access_type == MMU_INST_FETCH ?
-                                  INSTR_PIF_ADDR_ERROR_CAUSE :
-                                  LOAD_STORE_PIF_ADDR_ERROR_CAUSE,
-                                  addr);
-}
-
 void HELPER(update_ccount)(CPUXtensaState *env)
 {
     uint64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-- 
2.11.0

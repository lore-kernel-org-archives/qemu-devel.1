Received: from eggs.gnu.org ([2001:4830:134:3::10]:51905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fup6d-0000N3-1n
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 21:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fup6b-0003s0-WB
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 21:17:10 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131]:38541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fup6b-0003ro-O8
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 21:17:09 -0400
Received: by mail-lf1-x131.google.com with SMTP id i7-v6so2906453lfh.5
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 18:17:09 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 28 Aug 2018 18:16:51 -0700
Message-Id: <20180829011652.4466-2-jcmvbkbc@gmail.com>
In-Reply-To: <20180829011652.4466-1-jcmvbkbc@gmail.com>
References: <20180829011652.4466-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2 1/2] target/xtensa: convert to
 do_transaction_failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- change ldl_phys to address_space_ldl in get_pte and check transaction
  for success;

 target/xtensa/cpu.c       |  2 +-
 target/xtensa/cpu.h       |  7 ++++---
 target/xtensa/helper.c    | 22 +++++++++++++++++++---
 target/xtensa/op_helper.c | 12 +++++++-----
 4 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 590813d4f7b9..a54dbe42602d 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -186,7 +186,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
 #else
     cc->do_unaligned_access = xtensa_cpu_do_unaligned_access;
     cc->get_phys_page_debug = xtensa_cpu_get_phys_page_debug;
-    cc->do_unassigned_access = xtensa_cpu_do_unassigned_access;
+    cc->do_transaction_failed = xtensa_cpu_do_transaction_failed;
 #endif
     cc->debug_excp_handler = xtensa_breakpoint_handler;
     cc->disas_set_info = xtensa_cpu_disas_set_info;
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 7472cf3ca32a..1362772617ea 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -497,9 +497,10 @@ int xtensa_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw, int size,
                                 int mmu_idx);
 void xtensa_cpu_do_interrupt(CPUState *cpu);
 bool xtensa_cpu_exec_interrupt(CPUState *cpu, int interrupt_request);
-void xtensa_cpu_do_unassigned_access(CPUState *cpu, hwaddr addr,
-                                     bool is_write, bool is_exec, int opaque,
-                                     unsigned size);
+void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
+                                      unsigned size, MMUAccessType access_type,
+                                      int mmu_idx, MemTxAttrs attrs,
+                                      MemTxResult response, uintptr_t retaddr);
 void xtensa_cpu_dump_state(CPUState *cpu, FILE *f,
                            fprintf_function cpu_fprintf, int flags);
 hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index f74636f67854..0484f5fab808 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -642,11 +642,27 @@ static int get_pte(CPUXtensaState *env, uint32_t vaddr, uint32_t *pte)
     int ret = get_physical_addr_mmu(env, false, pt_vaddr, 0, 0,
             &paddr, &page_size, &access, false);
 
-    qemu_log_mask(CPU_LOG_MMU, "%s: trying autorefill(%08x) -> %08x\n",
-                  __func__, vaddr, ret ? ~0 : paddr);
+    if (ret == 0) {
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s: autorefill(%08x): PTE va = %08x, pa = %08x\n",
+                      __func__, vaddr, pt_vaddr, paddr);
+    } else {
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s: autorefill(%08x): PTE va = %08x, failed (%d)\n",
+                      __func__, vaddr, pt_vaddr, ret);
+    }
 
     if (ret == 0) {
-        *pte = ldl_phys(cs->as, paddr);
+        MemTxResult result;
+
+        *pte = address_space_ldl(cs->as, paddr, MEMTXATTRS_UNSPECIFIED,
+                                 &result);
+        if (result != MEMTX_OK) {
+            qemu_log_mask(CPU_LOG_MMU,
+                          "%s: couldn't load PTE: transaction failed (%u)\n",
+                          __func__, (unsigned)result);
+            ret = 1;
+        }
     }
     return ret;
 }
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index d4c942d87980..06fe346f02ff 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -78,18 +78,20 @@ void tlb_fill(CPUState *cs, target_ulong vaddr, int size,
     }
 }
 
-void xtensa_cpu_do_unassigned_access(CPUState *cs, hwaddr addr,
-                                     bool is_write, bool is_exec, int opaque,
-                                     unsigned size)
+void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
+                                      unsigned size, MMUAccessType access_type,
+                                      int mmu_idx, MemTxAttrs attrs,
+                                      MemTxResult response, uintptr_t retaddr)
 {
     XtensaCPU *cpu = XTENSA_CPU(cs);
     CPUXtensaState *env = &cpu->env;
 
+    cpu_restore_state(cs, retaddr, true);
     HELPER(exception_cause_vaddr)(env, env->pc,
-                                  is_exec ?
+                                  access_type == MMU_INST_FETCH ?
                                   INSTR_PIF_ADDR_ERROR_CAUSE :
                                   LOAD_STORE_PIF_ADDR_ERROR_CAUSE,
-                                  is_exec ? addr : cs->mem_io_vaddr);
+                                  addr);
 }
 
 static void tb_invalidate_virtual_addr(CPUXtensaState *env, uint32_t vaddr)
-- 
2.11.0

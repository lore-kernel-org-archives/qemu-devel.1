Received: from eggs.gnu.org ([2001:4830:134:3::10]:46249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1frZyZ-000327-9F
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 22:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1frZyY-0002vn-IS
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 22:31:27 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:42241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1frZyY-0002vR-Aw
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 22:31:26 -0400
Received: by mail-lj1-x241.google.com with SMTP id f1-v6so10341737ljc.9
	for <qemu-devel@nongnu.org>; Sun, 19 Aug 2018 19:31:26 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 19 Aug 2018 19:31:10 -0700
Message-Id: <20180820023110.6583-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: convert to do_transaction_failed
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

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.c       |  2 +-
 target/xtensa/cpu.h       |  7 ++++---
 target/xtensa/op_helper.c | 12 +++++++-----
 3 files changed, 12 insertions(+), 9 deletions(-)

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

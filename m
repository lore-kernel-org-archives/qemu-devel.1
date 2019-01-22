Received: from eggs.gnu.org ([209.51.188.92]:48845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gm1r4-0002el-Tm
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:37:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gm1r2-0004B9-97
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:37:02 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:35196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1gm1qx-00043p-6Y
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:36:57 -0500
Received: by mail-pl1-x630.google.com with SMTP id p8so11974376plo.2
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:36:52 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 22 Jan 2019 04:20:46 -0800
Message-Id: <20190122122048.10845-2-edgar.iglesias@gmail.com>
In-Reply-To: <20190122122048.10845-1-edgar.iglesias@gmail.com>
References: <20190122122048.10845-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v1 1/3] target/microblaze: Switch to
 transaction_failed hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com

From: Peter Maydell <peter.maydell@linaro.org>

Switch the microblaze target from the old unassigned_access hook
to the transaction_failed hook.

The notable difference is that rather than it being called
for all physical memory accesses which fail (including
those made by DMA devices or by the gdbstub), it is only
called for those made by the CPU via its MMU. For
microblaze this makes no difference because none of the
target CPU code needs to make loads or stores by physical
address.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
[EI: Add space in qemu_log()]
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c       |  2 +-
 target/microblaze/cpu.h       |  7 ++++---
 target/microblaze/op_helper.c | 22 ++++++++++++----------
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 9b546a2c18..49876b19b3 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -297,7 +297,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
 #ifdef CONFIG_USER_ONLY
     cc->handle_mmu_fault = mb_cpu_handle_mmu_fault;
 #else
-    cc->do_unassigned_access = mb_cpu_unassigned_access;
+    cc->do_transaction_failed = mb_cpu_transaction_failed;
     cc->get_phys_page_debug = mb_cpu_get_phys_page_debug;
 #endif
     dc->vmsd = &vmstate_mb_cpu;
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 3c4e0ba80a..03ca91007d 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -388,9 +388,10 @@ static inline void cpu_get_tb_cpu_state(CPUMBState *env, target_ulong *pc,
 }
 
 #if !defined(CONFIG_USER_ONLY)
-void mb_cpu_unassigned_access(CPUState *cpu, hwaddr addr,
-                              bool is_write, bool is_exec, int is_asi,
-                              unsigned size);
+void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
+                               unsigned size, MMUAccessType access_type,
+                               int mmu_idx, MemTxAttrs attrs,
+                               MemTxResult response, uintptr_t retaddr);
 #endif
 
 #endif
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 7cdbbcccae..e23dcfdc20 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -486,26 +486,28 @@ void helper_mmu_write(CPUMBState *env, uint32_t ext, uint32_t rn, uint32_t v)
     mmu_write(env, ext, rn, v);
 }
 
-void mb_cpu_unassigned_access(CPUState *cs, hwaddr addr,
-                              bool is_write, bool is_exec, int is_asi,
-                              unsigned size)
+void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
+                               unsigned size, MMUAccessType access_type,
+                               int mmu_idx, MemTxAttrs attrs,
+                               MemTxResult response, uintptr_t retaddr)
 {
     MicroBlazeCPU *cpu;
     CPUMBState *env;
-
-    qemu_log_mask(CPU_LOG_INT, "Unassigned " TARGET_FMT_plx " wr=%d exe=%d\n",
-             addr, is_write ? 1 : 0, is_exec ? 1 : 0);
-    if (cs == NULL) {
-        return;
-    }
+    qemu_log_mask(CPU_LOG_INT, "Transaction failed: vaddr 0x%" VADDR_PRIx
+                  " physaddr 0x" TARGET_FMT_plx " size %d access type %s\n",
+                  addr, physaddr, size,
+                  access_type == MMU_INST_FETCH ? "INST_FETCH" :
+                  (access_type == MMU_DATA_LOAD ? "DATA_LOAD" : "DATA_STORE"));
     cpu = MICROBLAZE_CPU(cs);
     env = &cpu->env;
+
+    cpu_restore_state(cs, retaddr, true);
     if (!(env->sregs[SR_MSR] & MSR_EE)) {
         return;
     }
 
     env->sregs[SR_EAR] = addr;
-    if (is_exec) {
+    if (access_type == MMU_INST_FETCH) {
         if ((env->pvr.regs[2] & PVR2_IOPB_BUS_EXC_MASK)) {
             env->sregs[SR_ESR] = ESR_EC_INSN_BUS;
             helper_raise_exception(env, EXCP_HW_EXCP);
-- 
2.19.1

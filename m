Received: from eggs.gnu.org ([2001:4830:134:3::10]:37108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gWOrK-0001O8-Dw
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:56:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gWOrJ-00082w-CD
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:56:42 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gWOrJ-00080R-0x
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:56:41 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Dec 2018 16:56:36 +0000
Message-Id: <20181210165636.28366-4-peter.maydell@linaro.org>
In-Reply-To: <20181210165636.28366-1-peter.maydell@linaro.org>
References: <20181210165636.28366-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC 3/3] target/m68k: Switch to transaction_failed
 hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Laurent Vivier <laurent@vivier.eu>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Switch the m68k target from the old unassigned_access hook
to the transaction_failed hook.

The notable difference is that rather than it being called
for all physical memory accesses which fail (including
those made by DMA devices or by the gdbstub), it is only
called for those made by the CPU via its MMU. (In previous
commits we put in explicit checks for the direct physical
loads made by the target/m68k code which will no longer
be handled by calling the unassigned_access hook.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/m68k/cpu.h       |  7 ++++---
 target/m68k/cpu.c       |  2 +-
 target/m68k/op_helper.c | 20 ++++++++------------
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index b288a3864e0..08828b0581b 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -545,9 +545,10 @@ static inline int cpu_mmu_index (CPUM68KState *env, bool ifetch)
 
 int m68k_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
                               int mmu_idx);
-void m68k_cpu_unassigned_access(CPUState *cs, hwaddr addr,
-                                bool is_write, bool is_exec, int is_asi,
-                                unsigned size);
+void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
+                                 unsigned size, MMUAccessType access_type,
+                                 int mmu_idx, MemTxAttrs attrs,
+                                 MemTxResult response, uintptr_t retaddr);
 
 #include "exec/cpu-all.h"
 
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 582e3a73b37..6d09c630b0e 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -271,7 +271,7 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
     cc->gdb_write_register = m68k_cpu_gdb_write_register;
     cc->handle_mmu_fault = m68k_cpu_handle_mmu_fault;
 #if defined(CONFIG_SOFTMMU)
-    cc->do_unassigned_access = m68k_cpu_unassigned_access;
+    cc->do_transaction_failed = m68k_cpu_transaction_failed;
     cc->get_phys_page_debug = m68k_cpu_get_phys_page_debug;
 #endif
     cc->disas_set_info = m68k_cpu_disas_set_info;
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 8d09ed91c49..6739ab8e436 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -454,19 +454,15 @@ static inline void do_interrupt_m68k_hardirq(CPUM68KState *env)
     do_interrupt_all(env, 1);
 }
 
-void m68k_cpu_unassigned_access(CPUState *cs, hwaddr addr, bool is_write,
-                                bool is_exec, int is_asi, unsigned size)
+void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
+                                 unsigned size, MMUAccessType access_type,
+                                 int mmu_idx, MemTxAttrs attrs,
+                                 MemTxResult response, uintptr_t retaddr)
 {
     M68kCPU *cpu = M68K_CPU(cs);
     CPUM68KState *env = &cpu->env;
-#ifdef DEBUG_UNASSIGNED
-    qemu_log_mask(CPU_LOG_INT, "Unassigned " TARGET_FMT_plx " wr=%d exe=%d\n",
-             addr, is_write, is_exec);
-#endif
-    if (env == NULL) {
-        /* when called from gdb, env is NULL */
-        return;
-    }
+
+    cpu_restore_state(cs, retaddr, true);
 
     if (m68k_feature(env, M68K_FEATURE_M68040)) {
         env->mmu.mmusr = 0;
@@ -476,7 +472,7 @@ void m68k_cpu_unassigned_access(CPUState *cs, hwaddr addr, bool is_write,
         if (env->sr & SR_S) { /* SUPERVISOR */
             env->mmu.ssw |= M68K_TM_040_SUPER;
         }
-        if (is_exec) { /* instruction or data */
+        if (access_type == MMU_INST_FETCH) { /* instruction or data */
             env->mmu.ssw |= M68K_TM_040_CODE;
         } else {
             env->mmu.ssw |= M68K_TM_040_DATA;
@@ -494,7 +490,7 @@ void m68k_cpu_unassigned_access(CPUState *cs, hwaddr addr, bool is_write,
             break;
         }
 
-        if (!is_write) {
+        if (access_type != MMU_DATA_STORE) {
             env->mmu.ssw |= M68K_RW_040;
         }
 
-- 
2.19.2

Received: from eggs.gnu.org ([2001:4830:134:3::10]:39596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKQ-0002mO-Fr
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKP-0006uJ-E2
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:18 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:57:40 +1000
Message-Id: <20180703055804.13449-12-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 11/35] target/ppc: Add do_unaligned_access hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Richard Henderson <richard.henderson@linaro.org>

This allows faults from MO_ALIGN to have the same effect
as from gen_check_align.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/excp_helper.c        | 18 +++++++++++++++++-
 target/ppc/internal.h           |  5 +++++
 target/ppc/translate_init.inc.c |  1 +
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index c092fbead0..d6e97a90e0 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -22,7 +22,7 @@
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
-
+#include "internal.h"
 #include "helper_regs.h"
 
 //#define DEBUG_OP
@@ -1198,3 +1198,19 @@ void helper_book3s_msgsnd(target_ulong rb)
     qemu_mutex_unlock_iothread();
 }
 #endif
+
+void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
+                                 MMUAccessType access_type,
+                                 int mmu_idx, uintptr_t retaddr)
+{
+    CPUPPCState *env = cs->env_ptr;
+    uint32_t insn;
+
+    /* Restore state and reload the insn we executed, for filling in DSISR.  */
+    cpu_restore_state(cs, retaddr, true);
+    insn = cpu_ldl_code(env, env->nip);
+
+    cs->exception_index = POWERPC_EXCP_ALIGN;
+    env->error_code = insn & 0x03FF0000;
+    cpu_loop_exit(cs);
+}
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 1f441c6483..a9bcadff42 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -252,4 +252,9 @@ static inline void putVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
 void helper_compute_fprf_float16(CPUPPCState *env, float16 arg);
 void helper_compute_fprf_float32(CPUPPCState *env, float32 arg);
 void helper_compute_fprf_float128(CPUPPCState *env, float128 arg);
+
+/* Raise a data fault alignment exception for the specified virtual address */
+void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
+                                 MMUAccessType access_type,
+                                 int mmu_idx, uintptr_t retaddr);
 #endif /* PPC_INTERNAL_H */
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 76d6f3fd5e..7813b1b004 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10457,6 +10457,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     cc->set_pc = ppc_cpu_set_pc;
     cc->gdb_read_register = ppc_cpu_gdb_read_register;
     cc->gdb_write_register = ppc_cpu_gdb_write_register;
+    cc->do_unaligned_access = ppc_cpu_do_unaligned_access;
 #ifdef CONFIG_USER_ONLY
     cc->handle_mmu_fault = ppc_cpu_handle_mmu_fault;
 #else
-- 
2.17.1

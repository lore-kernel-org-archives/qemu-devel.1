Received: from eggs.gnu.org ([2001:4830:134:3::10]:53163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvMD-0006BW-3O
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvMC-0001z6-3E
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:01 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 13 Jan 2017 17:28:14 +1100
Message-Id: <1484288903-18807-9-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 08/17] target/ppc/POWER9: Add external
 partition table pointer to cpu state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Similarly to how we have an external hpt pointer in the cpu state, add
an external partition table pointer and update it to point to the
partition table entry in the machine state struct on cpu reset.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr_cpu_core.c | 12 ++++++++++--
 target/ppc/cpu.h        |  3 +++
 target/ppc/mmu.h        |  6 ++++++
 target/ppc/mmu_helper.c | 12 ++++++++++++
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 8cc7058..72a7f90 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -17,6 +17,7 @@
 #include "hw/ppc/ppc.h"
 #include "target/ppc/mmu-hash64.h"
 #include "sysemu/numa.h"
+#include "mmu.h"
 
 static void spapr_cpu_reset(void *opaque)
 {
@@ -34,8 +35,15 @@ static void spapr_cpu_reset(void *opaque)
 
     env->spr[SPR_HIOR] = 0;
 
-    ppc_hash64_set_external_hpt(cpu, spapr->htab, spapr->htab_shift,
-                                &error_fatal);
+    switch (env->mmu_model) {
+    case POWERPC_MMU_3_00:
+        ppc64_set_external_patb(cpu, spapr->patb, &error_fatal);
+    default:
+        /* We assume legacy until told otherwise, thus set HPT irrespective */
+        ppc_hash64_set_external_hpt(cpu, spapr->htab, spapr->htab_shift,
+                                    &error_fatal);
+        break;
+    }
 }
 
 static void spapr_cpu_destroy(PowerPCCPU *cpu)
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0ab49b3..e8b7c06 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -77,6 +77,7 @@
 #include "exec/cpu-defs.h"
 #include "cpu-qom.h"
 #include "fpu/softfloat.h"
+#include "mmu.h"
 
 #if defined (TARGET_PPC64)
 #define PPC_ELF_MACHINE     EM_PPC64
@@ -1009,6 +1010,8 @@ struct CPUPPCState {
     target_ulong sr[32];
     /* externally stored hash table */
     uint8_t *external_htab;
+    /* externally stored partition table entry */
+    struct patb_entry *external_patbe;
     /* BATs */
     uint32_t nb_BATs;
     target_ulong DBAT[2][8];
diff --git a/target/ppc/mmu.h b/target/ppc/mmu.h
index 67b9707..c7967c3 100644
--- a/target/ppc/mmu.h
+++ b/target/ppc/mmu.h
@@ -8,6 +8,12 @@ struct patb_entry {
     uint64_t patbe0, patbe1;
 };
 
+#ifdef TARGET_PPC64
+
+void ppc64_set_external_patb(PowerPCCPU *cpu, void *patb, Error **errp);
+
+#endif /* TARGET_PPC64 */
+
 #endif /* CONFIG_USER_ONLY */
 
 #endif /* MMU_H */
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 2ab4562..bc6c117 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -28,6 +28,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "helper_regs.h"
+#include "mmu.h"
 
 //#define DEBUG_MMU
 //#define DEBUG_BATS
@@ -2907,3 +2908,14 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
                                retaddr);
     }
 }
+
+/******************************************************************************/
+
+/* ISA v3.00 (POWER9) Generic MMU Helpers */
+
+void ppc64_set_external_patb(PowerPCCPU *cpu, void *patb, Error **errp)
+{
+    CPUPPCState *env = &cpu->env;
+
+    env->external_patbe = (struct patb_entry *) patb;
+}
-- 
2.5.5

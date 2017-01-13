Received: from eggs.gnu.org ([2001:4830:134:3::10]:53168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvMD-0006Bo-EF
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvMC-0001zB-CD
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:01 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 13 Jan 2017 17:28:13 +1100
Message-Id: <1484288903-18807-8-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 07/17] target/ppc/POWER9: Add partition
 table pointer to sPAPRMachineState
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

POWER9 uses a partition table to store information relating to how
address translation is performed on a per partition basis.

Add a data area for this to the sPAPRMachineState struct and (re)allocate
it on machine reset.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr.c         | 38 ++++++++++++++++++++++++++++++++------
 include/hw/ppc/spapr.h |  1 +
 target/ppc/mmu.h       | 13 +++++++++++++
 3 files changed, 46 insertions(+), 6 deletions(-)
 create mode 100644 target/ppc/mmu.h

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 208ef7b..45bd2de 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -41,6 +41,7 @@
 #include "migration/migration.h"
 #include "mmu-hash64.h"
 #include "qom/cpu.h"
+#include "mmu.h"
 
 #include "hw/boards.h"
 #include "hw/ppc/ppc.h"
@@ -1115,6 +1116,26 @@ static void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
     }
 }
 
+static void spapr_reallocate_patb(sPAPRMachineState *spapr, Error **errp)
+{
+    g_free(spapr->patb);
+    spapr->patb = NULL;
+
+    if (!kvm_enabled()) {
+        /* We need to allocate a partition table entry */
+        size_t size = sizeof(struct patb_entry);
+
+        spapr->patb = qemu_memalign(size, size);
+        if (!spapr->patb) {
+            error_setg_errno(errp, errno, "Could not allocate memory for "
+                                          "partition table entry");
+            return;
+        }
+
+        memset(spapr->patb, 0, size);
+    }
+}
+
 static void find_unknown_sysbus_device(SysBusDevice *sbdev, void *opaque)
 {
     bool matched = false;
@@ -1134,7 +1155,7 @@ static void ppc_spapr_reset(void)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
     sPAPRMachineState *spapr = SPAPR_MACHINE(machine);
-    PowerPCCPU *first_ppc_cpu;
+    PowerPCCPU *first_ppc_cpu = POWERPC_CPU(first_cpu);
     uint32_t rtas_limit;
     hwaddr rtas_addr, fdt_addr;
     void *fdt;
@@ -1143,10 +1164,16 @@ static void ppc_spapr_reset(void)
     /* Check for unknown sysbus devices */
     foreach_dynamic_sysbus_device(find_unknown_sysbus_device, NULL);
 
-    /* Allocate and/or reset the hash page table */
-    spapr_reallocate_hpt(spapr,
-                         spapr_hpt_shift_for_ramsize(machine->maxram_size),
-                         &error_fatal);
+    switch (first_ppc_cpu->env.mmu_model) {
+    case POWERPC_MMU_3_00:
+        /* Allocate the partition table */
+        spapr_reallocate_patb(spapr, &error_fatal);
+    default:
+        /* Allocate and/or reset the hash page table */
+        spapr_reallocate_hpt(spapr,
+                             spapr_hpt_shift_for_ramsize(machine->maxram_size),
+                             &error_fatal);
+    }
 
     /* Update the RMA size if necessary */
     if (spapr->vrma_adjust) {
@@ -1193,7 +1220,6 @@ static void ppc_spapr_reset(void)
     g_free(fdt);
 
     /* Set up the entry state */
-    first_ppc_cpu = POWERPC_CPU(first_cpu);
     first_ppc_cpu->env.gpr[3] = fdt_addr;
     first_ppc_cpu->env.gpr[5] = 0;
     first_cpu->halted = 0;
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index bd5bcf7..b654773 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -63,6 +63,7 @@ struct sPAPRMachineState {
 
     void *htab;
     uint32_t htab_shift;
+    void *patb;
     hwaddr rma_size;
     int vrma_adjust;
     ssize_t rtas_size;
diff --git a/target/ppc/mmu.h b/target/ppc/mmu.h
new file mode 100644
index 0000000..67b9707
--- /dev/null
+++ b/target/ppc/mmu.h
@@ -0,0 +1,13 @@
+#ifndef MMU_H
+#define MMU_H
+
+#ifndef CONFIG_USER_ONLY
+
+/* Partition Table Entry */
+struct patb_entry {
+    uint64_t patbe0, patbe1;
+};
+
+#endif /* CONFIG_USER_ONLY */
+
+#endif /* MMU_H */
-- 
2.5.5

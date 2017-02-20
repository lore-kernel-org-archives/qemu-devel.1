Received: from eggs.gnu.org ([2001:4830:134:3::10]:39857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cffDq-0000Gm-EX
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 23:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cffDo-0002fP-Kt
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 23:05:10 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Mon, 20 Feb 2017 15:04:33 +1100
Message-Id: <1487563478-22265-6-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1487563478-22265-1-git-send-email-sjitindarsingh@gmail.com>
References: <1487563478-22265-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V3 05/10] target/ppc: Add patb_entry
 to sPAPRMachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com, sjitindarsingh@gmail.com

ISA v3.00 adds the idea of a partition table which is used to store the
address translation details for all partitions on the system. The partition
table consists of double word entries indexed by partition id where the second
double word contains the location of the process table in guest memory. The
process table is registered by the guest via a h-call.

We need somewhere to store the address of the process table so we add an entry
to the sPAPRMachineState struct called patb_entry to represent the second
doubleword of a single partition table entry corresponding to the current
guest. We need to store this value so we know if the guest is using radix or
hash translation and the location of the corresponding process table in guest
memory. Since we only have a single guest per qemu instance, we only need one
entry.

Since the partition table is technically a hypervisor resource we require that
access to it is abstracted by the virtual hypervisor through the calls
[set/get]_patbe(). Currently the value of the entry is never set (and thus
defaults to 0 indicating hash), but it will be required to both implement
POWER9 kvm support and tcg radix support.

We also add this field to be migrated as part of the sPAPRMachineState as we
will need it on the receiving side as the guest will never tell us this
information again and we need it to perform translation.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

---

V2->V3:
- Only add patbe to migration stream if non-zero
---
 hw/ppc/spapr.c         | 29 +++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  1 +
 target/ppc/cpu.h       |  1 +
 3 files changed, 31 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e465d7a..2fbf193 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1018,6 +1018,13 @@ static void emulate_spapr_hypercall(PPCVirtualHypervisor *vhyp,
     }
 }
 
+static uint64_t spapr_get_patbe(PPCVirtualHypervisor *vhyp)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(vhyp);
+
+    return spapr->patb_entry;
+}
+
 #define HPTE(_table, _i)   (void *)(((uint64_t *)(_table)) + ((_i) * 2))
 #define HPTE_VALID(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_VALID)
 #define HPTE_DIRTY(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_HPTE_DIRTY)
@@ -1141,6 +1148,8 @@ static void ppc_spapr_reset(void)
     /* Check for unknown sysbus devices */
     foreach_dynamic_sysbus_device(find_unknown_sysbus_device, NULL);
 
+    spapr->patb_entry = 0;
+
     /* Allocate and/or reset the hash page table */
     spapr_reallocate_hpt(spapr,
                          spapr_hpt_shift_for_ramsize(machine->maxram_size),
@@ -1327,6 +1336,24 @@ static const VMStateDescription vmstate_spapr_ov5_cas = {
     },
 };
 
+static bool spapr_patb_entry_needed(void *opaque)
+{
+    sPAPRMachineState *spapr = opaque;
+
+    return !!spapr->patb_entry;
+}
+
+static const VMStateDescription vmstate_spapr_patb_entry = {
+    .name = "spapr_patb_entry",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = spapr_patb_entry_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(patb_entry, sPAPRMachineState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_spapr = {
     .name = "spapr",
     .version_id = 3,
@@ -1344,6 +1371,7 @@ static const VMStateDescription vmstate_spapr = {
     },
     .subsections = (const VMStateDescription*[]) {
         &vmstate_spapr_ov5_cas,
+        &vmstate_spapr_patb_entry,
         NULL
     }
 };
@@ -2733,6 +2761,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     nc->nmi_monitor_handler = spapr_nmi;
     smc->phb_placement = spapr_phb_placement;
     vhc->hypercall = emulate_spapr_hypercall;
+    vhc->get_patbe = spapr_get_patbe;
 }
 
 static const TypeInfo spapr_machine_info = {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a2d8964..c6a929a 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -63,6 +63,7 @@ struct sPAPRMachineState {
 
     void *htab;
     uint32_t htab_shift;
+    uint64_t patb_entry; /* Process tbl registed in H_REGISTER_PROCESS_TABLE */
     hwaddr rma_size;
     int vrma_adjust;
     ssize_t rtas_size;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 425e79d..684d632 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1218,6 +1218,7 @@ struct PPCVirtualHypervisor {
 struct PPCVirtualHypervisorClass {
     InterfaceClass parent;
     void (*hypercall)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
+    uint64_t (*get_patbe)(PPCVirtualHypervisor *vhyp);
 };
 
 #define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"
-- 
2.5.5

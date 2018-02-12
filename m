Received: from eggs.gnu.org ([2001:4830:134:3::10]:47083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1elJJd-0008Fr-IW
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:59:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1elJJc-0002Kn-Lh
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:59:01 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Mon, 12 Feb 2018 18:58:04 +0000
Message-Id: <1518461904-5305-3-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1518461904-5305-1-git-send-email-eric.auger@redhat.com>
References: <1518461904-5305-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v6 02/22] hw/arm/virt: Implement
 get_primary_pci_bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, kevin.tian@intel.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com, linuc.decode@gmail.com

get_primary_pci_bus() returns the root bus. We also
add the PCIBus handle to VirtMachineState.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c         | 11 ++++++++++-
 include/hw/arm/virt.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index dbb3c80..08ac411 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -941,7 +941,7 @@ static void create_pcie_irq_map(const VirtMachineState *vms,
                            0x7           /* PCI irq */);
 }
 
-static void create_pcie(const VirtMachineState *vms, qemu_irq *pic)
+static void create_pcie(VirtMachineState *vms, qemu_irq *pic)
 {
     hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
     hwaddr size_mmio = vms->memmap[VIRT_PCIE_MMIO].size;
@@ -1004,6 +1004,7 @@ static void create_pcie(const VirtMachineState *vms, qemu_irq *pic)
 
     pci = PCI_HOST_BRIDGE(dev);
     if (pci->bus) {
+        vms->pci_bus = pci->bus;
         for (i = 0; i < nb_nics; i++) {
             NICInfo *nd = &nd_table[i];
 
@@ -1523,6 +1524,13 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
     return ms->possible_cpus;
 }
 
+static PCIBus *virt_get_primary_pci_bus(const MachineState *ms)
+{
+    VirtMachineState *vms = VIRT_MACHINE(ms);
+
+    return vms->pci_bus;
+}
+
 static void virt_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1544,6 +1552,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
+    mc->get_primary_pci_bus = virt_get_primary_pci_bus;
 }
 
 static const TypeInfo virt_machine_info = {
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 33b0ff3..7e31e99 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -106,6 +106,7 @@ typedef struct {
     uint32_t gic_phandle;
     uint32_t msi_phandle;
     int psci_conduit;
+    PCIBus *pci_bus;
 } VirtMachineState;
 
 #define TYPE_VIRT_MACHINE   MACHINE_TYPE_NAME("virt")
-- 
1.9.1

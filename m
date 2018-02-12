Received: from eggs.gnu.org ([2001:4830:134:3::10]:47271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1elJJm-0008S6-T6
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:59:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1elJJm-0002iV-2Q
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:59:10 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Mon, 12 Feb 2018 18:58:05 +0000
Message-Id: <1518461904-5305-4-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1518461904-5305-1-git-send-email-eric.auger@redhat.com>
References: <1518461904-5305-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v6 03/22] pc: Implement get_primary_pci_bus
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

Implement this get_primary_pci_bus() which returns the root
bus.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/i386/pc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 55e69d6..ac33ade 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2342,6 +2342,13 @@ static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
+static PCIBus *pc_machine_get_primary_pci_bus(const MachineState *ms)
+{
+    PCMachineState *pcms = PC_MACHINE(ms);
+
+    return pcms->bus;
+}
+
 static void pc_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -2381,6 +2388,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     hc->unplug = pc_machine_device_unplug_cb;
     nc->nmi_monitor_handler = x86_nmi;
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
+    mc->get_primary_pci_bus = pc_machine_get_primary_pci_bus;
 
     object_class_property_add(oc, PC_MACHINE_MEMHP_REGION_SIZE, "int",
         pc_machine_get_hotplug_memory_region_size, NULL,
-- 
1.9.1

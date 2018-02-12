Received: from eggs.gnu.org ([2001:4830:134:3::10]:47091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1elJJd-0008G0-Ny
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:59:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1elJJc-0002LE-Ug
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:59:01 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Mon, 12 Feb 2018 18:58:03 +0000
Message-Id: <1518461904-5305-2-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1518461904-5305-1-git-send-email-eric.auger@redhat.com>
References: <1518461904-5305-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v6 01/22] machine: Add a get_primary_pci_bus
 callback
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

After e492dc5a267e "pci: Eliminate pci_find_primary_bus()" we don't
have an easy mean to retrieve the primary bus of a machine. This will be
needed by virtio-iommu-device which is bound to be dynamically instantiated
in at least ARM virt and Q35 machines.

Adding a get_primary_pci_bus() callback allows to retrieve the PCIBus the
iommu is connected to.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

This is a temporary solution until we decide whether the
virtio-iommu-device should be instantiable through a -device command
line or through a machine command line, as already suggested by Peter
(for vsmmuv3 though).
---
 include/hw/boards.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index efb0a9e..0ed376a 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -156,6 +156,8 @@ typedef struct {
  *    should instead use "unimplemented-device" for all memory ranges where
  *    the guest will attempt to probe for a device that QEMU doesn't
  *    implement and a stub device is required.
+ * @get_primary_pci_bus: return the primary PCI bus or NULL if there are
+ *    several root buses
  */
 struct MachineClass {
     /*< private >*/
@@ -212,6 +214,7 @@ struct MachineClass {
                                                          unsigned cpu_index);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
     int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
+    PCIBus *(*get_primary_pci_bus)(const MachineState *ms);
 };
 
 /**
-- 
1.9.1

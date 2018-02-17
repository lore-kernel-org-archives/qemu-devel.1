Received: from eggs.gnu.org ([2001:4830:134:3::10]:45193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1en7WR-0003g0-1H
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:47:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1en7WP-0002jZ-U5
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:47:43 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Sat, 17 Feb 2018 19:46:53 +0100
Message-Id: <1518893216-9983-12-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v9 11/14] target/arm/kvm: Translate the MSI
 doorbell in kvm_arch_fixup_msi_route
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com, alex.williamson@redhat.com
Cc: tn@semihalf.com, mst@redhat.com, christoffer.dall@linaro.org, bharat.bhushan@nxp.com, jean-philippe.brucker@arm.com, edgar.iglesias@gmail.com, linuc.decode@gmail.com, peterx@redhat.com

In case the MSI is translated by an IOMMU we need to fixup the
MSI route with the translated address.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v5 -> v6:
- use IOMMUMemoryRegionClass API

It is still unclear to me if we need to register an IOMMUNotifier
to handle any change in the MSI doorbell which would occur behind
the scene and would not lead to any call to kvm_arch_fixup_msi_route().
---
 target/arm/kvm.c        | 27 +++++++++++++++++++++++++++
 target/arm/trace-events |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 1219d00..9f5976a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -20,8 +20,13 @@
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
 #include "cpu.h"
+#include "trace.h"
 #include "internals.h"
 #include "hw/arm/arm.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/msi.h"
+#include "hw/arm/smmu-common.h"
+#include "hw/arm/smmuv3.h"
 #include "exec/memattrs.h"
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
@@ -666,6 +671,28 @@ int kvm_arm_vgic_probe(void)
 int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
                              uint64_t address, uint32_t data, PCIDevice *dev)
 {
+    AddressSpace *as = pci_device_iommu_address_space(dev);
+    IOMMUMemoryRegionClass *imrc;
+    IOMMUTLBEntry entry;
+    SMMUDevice *sdev;
+
+    if (as == &address_space_memory) {
+        return 0;
+    }
+
+    /* MSI doorbell address is translated by an IOMMU */
+    sdev = container_of(as, SMMUDevice, as);
+    imrc = IOMMU_MEMORY_REGION_GET_CLASS(&sdev->iommu);
+
+    entry = imrc->translate(&sdev->iommu, address, IOMMU_WO);
+
+    route->u.msi.address_lo = entry.translated_addr;
+    route->u.msi.address_hi = entry.translated_addr >> 32;
+
+    trace_kvm_arm_fixup_msi_route(address, sdev->devfn,
+                                  sdev->iommu.parent_obj.name,
+                                  entry.translated_addr);
+
     return 0;
 }
 
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 9e37131..8b3c220 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -8,3 +8,6 @@ arm_gt_tval_write(int timer, uint64_t value) "gt_tval_write: timer %d value 0x%"
 arm_gt_ctl_write(int timer, uint64_t value) "gt_ctl_write: timer %d value 0x%" PRIx64
 arm_gt_imask_toggle(int timer, int irqstate) "gt_ctl_write: timer %d IMASK toggle, new irqstate %d"
 arm_gt_cntvoff_write(uint64_t value) "gt_cntvoff_write: value 0x%" PRIx64
+
+# target/arm/kvm.c
+kvm_arm_fixup_msi_route(uint64_t iova, uint32_t devid, const char *name, uint64_t gpa) "MSI addr = 0x%"PRIx64" is translated for devfn=%d through %s into 0x%"PRIx64
-- 
2.5.5

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Bharat.Bhushan@nxp.com>) id 1dVXoQ-0001LT-V7
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 02:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Bharat.Bhushan@nxp.com>) id 1dVXoM-0004r2-NJ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 02:41:22 -0400
From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Date: Thu, 13 Jul 2017 12:08:41 +0530
Message-ID: <1499927922-32303-2-git-send-email-Bharat.Bhushan@nxp.com>
In-Reply-To: <1499927922-32303-1-git-send-email-Bharat.Bhushan@nxp.com>
References: <1499927922-32303-1-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 1/2] target/arm/kvm: Translate the MSI
 doorbell in kvm_arch_fixup_msi_route
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: wei@redhat.com, kevin.tian@intel.com, marc.zyngier@arm.com, tn@semihalf.com, will.deacon@arm.com, drjones@redhat.com, robin.murphy@arm.com, christoffer.dall@linaro.org, Bharat Bhushan <Bharat.Bhushan@nxp.com>

Fix-up MSI address if it translate via virtual iommu.
This code is based on http://patchwork.ozlabs.org/patch/785951/

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
 target/arm/kvm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 4555468..eff7e8f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -22,6 +22,9 @@
 #include "cpu.h"
 #include "internals.h"
 #include "hw/arm/arm.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/msi.h"
+#include "hw/virtio/virtio-iommu.h"
 #include "exec/memattrs.h"
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
@@ -611,6 +614,24 @@ int kvm_arm_vgic_probe(void)
 int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
                              uint64_t address, uint32_t data, PCIDevice *dev)
 {
+    AddressSpace *as = pci_device_iommu_address_space(dev);
+    IOMMUTLBEntry entry;
+    IOMMUDevice *sdev;
+    VirtIOIOMMU *s;
+
+    if (as == &address_space_memory) {
+        return 0;
+    }
+
+    /* MSI doorbell address is translated by an IOMMU */
+    sdev = container_of(as, IOMMUDevice, as);
+    s = sdev->viommu;
+
+    entry = s->iommu_ops.translate(&sdev->iommu_mr, address, IOMMU_WO);
+
+    route->u.msi.address_lo = entry.translated_addr;
+    route->u.msi.address_hi = entry.translated_addr >> 32;
+
     return 0;
 }
 
-- 
1.9.3

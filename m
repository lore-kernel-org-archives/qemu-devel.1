Received: from eggs.gnu.org ([2001:4830:134:3::10]:42940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyGXW-00088Z-Gh
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyGXV-0003n6-I2
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:38:54 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 20 Mar 2018 13:37:33 +0100
Message-Id: <1521549456-14072-12-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1521549456-14072-1-git-send-email-eric.auger@redhat.com>
References: <1521549456-14072-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v10 11/14] target/arm/kvm: Translate the MSI
 doorbell in kvm_arch_fixup_msi_route
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, prem.mallappa@gmail.com
Cc: alex.williamson@redhat.com, tn@semihalf.com, mst@redhat.com, cdall@kernel.org, bharat.bhushan@nxp.com, jean-philippe.brucker@arm.com, linuc.decode@gmail.com, peterx@redhat.com, jintack@cs.columbia.edu

In case the MSI is translated by an IOMMU we need to fixup the
MSI route with the translated address.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v9 -> v10:
- use address_space_translate

v5 -> v6:
- use IOMMUMemoryRegionClass API
---
 target/arm/kvm.c        | 27 +++++++++++++++++++++++++++
 target/arm/trace-events |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ecc39ac..c6f6aa8 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -20,8 +20,10 @@
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
 #include "cpu.h"
+#include "trace.h"
 #include "internals.h"
 #include "hw/arm/arm.h"
+#include "hw/pci/pci.h"
 #include "exec/memattrs.h"
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
@@ -649,6 +651,31 @@ int kvm_arm_vgic_probe(void)
 int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
                              uint64_t address, uint32_t data, PCIDevice *dev)
 {
+    AddressSpace *as = pci_device_iommu_address_space(dev);
+    hwaddr xlat, len, doorbell_gpa;
+    MemoryRegionSection mrs;
+    MemoryRegion *mr;
+
+    if (as == &address_space_memory) {
+        return 0;
+    }
+
+    /* MSI doorbell address is translated by an IOMMU */
+
+    rcu_read_lock();
+    mr = address_space_translate(as, address, &xlat, &len, true);
+    if (!mr) {
+        return 1;
+    }
+    mrs = memory_region_find(mr, xlat, 0);
+    doorbell_gpa = mrs.offset_within_address_space;
+    rcu_read_unlock();
+
+    route->u.msi.address_lo = doorbell_gpa;
+    route->u.msi.address_hi = doorbell_gpa >> 32;
+
+    trace_kvm_arm_fixup_msi_route(address, doorbell_gpa);
+
     return 0;
 }
 
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 9e37131..6b759f9 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -8,3 +8,6 @@ arm_gt_tval_write(int timer, uint64_t value) "gt_tval_write: timer %d value 0x%"
 arm_gt_ctl_write(int timer, uint64_t value) "gt_ctl_write: timer %d value 0x%" PRIx64
 arm_gt_imask_toggle(int timer, int irqstate) "gt_ctl_write: timer %d IMASK toggle, new irqstate %d"
 arm_gt_cntvoff_write(uint64_t value) "gt_cntvoff_write: value 0x%" PRIx64
+
+# target/arm/kvm.c
+kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
-- 
2.5.5

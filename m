Received: from eggs.gnu.org ([2001:4830:134:3::10]:51951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJL-0005px-0H
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJJ-0000nr-TI
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:58 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fEeJJ-0000ld-KO
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:57 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJI-00038r-Ij
	for qemu-devel@nongnu.org; Fri, 04 May 2018 18:15:56 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  4 May 2018 18:15:37 +0100
Message-Id: <20180504171540.25813-22-peter.maydell@linaro.org>
In-Reply-To: <20180504171540.25813-1-peter.maydell@linaro.org>
References: <20180504171540.25813-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 21/24] target/arm/kvm: Translate the MSI
 doorbell in kvm_arch_fixup_msi_route
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

In case the MSI is translated by an IOMMU we need to fixup the
MSI route with the translated address.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Message-id: 1524665762-31355-12-git-send-email-eric.auger@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c        | 38 +++++++++++++++++++++++++++++++++++++-
 target/arm/trace-events |  3 +++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ecc39ac295..5141d0adc5 100644
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
@@ -649,7 +651,41 @@ int kvm_arm_vgic_probe(void)
 int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
                              uint64_t address, uint32_t data, PCIDevice *dev)
 {
-    return 0;
+    AddressSpace *as = pci_device_iommu_address_space(dev);
+    hwaddr xlat, len, doorbell_gpa;
+    MemoryRegionSection mrs;
+    MemoryRegion *mr;
+    int ret = 1;
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
+        goto unlock;
+    }
+    mrs = memory_region_find(mr, xlat, 1);
+    if (!mrs.mr) {
+        goto unlock;
+    }
+
+    doorbell_gpa = mrs.offset_within_address_space;
+    memory_region_unref(mrs.mr);
+
+    route->u.msi.address_lo = doorbell_gpa;
+    route->u.msi.address_hi = doorbell_gpa >> 32;
+
+    trace_kvm_arm_fixup_msi_route(address, doorbell_gpa);
+
+    ret = 0;
+
+unlock:
+    rcu_read_unlock();
+    return ret;
 }
 
 int kvm_arch_add_msi_route_post(struct kvm_irq_routing_entry *route,
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 9e37131115..6b759f9d4f 100644
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
2.17.0

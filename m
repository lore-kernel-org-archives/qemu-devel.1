Received: from eggs.gnu.org ([2001:4830:134:3::10]:50960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxW2g-0000zN-Ty
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 07:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxW2d-0004a8-OO
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 07:32:14 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed,  5 Sep 2018 19:31:58 +0800
Message-Id: <20180905113158.23734-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH] intel_iommu: do address space switching when
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, QEMU Stable <qemu-stable@nongnu.org>

We will drop all the mappings when system reset, however we'll still
keep the existing memory layouts.  That'll be problematic since if IOMMU
is enabled in the guest and then reboot the guest, SeaBIOS will try to
drive a device that with no page mapped there.  What we need to do is to
rebuild the GPA->HPA mapping when system resets, hence ease SeaBIOS.

Without this patch, a guest that boots on an assigned NVMe device might
fail to find the boot device after a system reboot/reset and we'll be
able to observe SeaBIOS errors if turned on:

  WARNING - Timeout at nvme_wait:144!

With the patch applied, the guest will be able to find the NVMe drive
and bootstrap there even after multiple reboots or system resets.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1625173
CC: QEMU Stable <qemu-stable@nongnu.org>
Tested-by: Cong Li <coli@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3dfada19a6..d3eb068d43 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3231,6 +3231,14 @@ static void vtd_reset(DeviceState *dev)
      * When device reset, throw away all mappings and external caches
      */
     vtd_address_space_unmap_all(s);
+
+    /*
+     * Switch address spaces if needed (e.g., when reboot from a
+     * kernel that has IOMMU enabled, we should switch address spaces
+     * to rebuild the GPA->HPA mappings otherwise SeaBIOS might
+     * encounter DMA errors when running with e.g. a NVMe card).
+     */
+    vtd_switch_address_space_all(s);
 }
 
 static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
-- 
2.17.1

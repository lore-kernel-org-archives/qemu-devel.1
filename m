Received: from eggs.gnu.org ([2001:4830:134:3::10]:54651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cED75-00078C-0Z
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:36:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cED74-0001vb-9g
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:36:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cED74-0001vM-4d
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:36:42 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  6 Dec 2016 18:36:17 +0800
Message-Id: <1481020588-4245-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1481020588-4245-1-git-send-email-peterx@redhat.com>
References: <1481020588-4245-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 02/13] intel_iommu: simplify irq region
 translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, peterx@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com

Before we have int-remap, we need to bypass interrupt write requests.
That's not necessary now - we have supported int-remap, and all the irq
region requests should be redirected there. Cleaning up the block with
an assertion instead.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 92e4064..f19a8b3 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -842,29 +842,12 @@ static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     bool writes = true;
     VTDIOTLBEntry *iotlb_entry;
 
-    /* Check if the request is in interrupt address range */
-    if (vtd_is_interrupt_addr(addr)) {
-        if (flags & IOMMU_WO) {
-            /* FIXME: since we don't know the length of the access here, we
-             * treat Non-DWORD length write requests without PASID as
-             * interrupt requests, too. Withoud interrupt remapping support,
-             * we just use 1:1 mapping.
-             */
-            VTD_DPRINTF(MMU, "write request to interrupt address "
-                        "gpa 0x%"PRIx64, addr);
-            entry->iova = addr & VTD_PAGE_MASK_4K;
-            entry->translated_addr = addr & VTD_PAGE_MASK_4K;
-            entry->addr_mask = ~VTD_PAGE_MASK_4K;
-            entry->perm = IOMMU_WO;
-            return;
-        } else {
-            VTD_DPRINTF(GENERAL, "error: read request from interrupt address "
-                        "gpa 0x%"PRIx64, addr);
-            vtd_report_dmar_fault(s, source_id, addr, VTD_FR_READ,
-                    flags & IOMMU_WO);
-            return;
-        }
-    }
+    /*
+     * We have standalone memory region for interrupt addresses, we
+     * should never receive translation requests in this region.
+     */
+    assert(!vtd_is_interrupt_addr(addr));
+
     /* Try to fetch slpte form IOTLB */
     iotlb_entry = vtd_lookup_iotlb(s, source_id, addr);
     if (iotlb_entry) {
-- 
2.7.4

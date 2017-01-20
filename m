Received: from eggs.gnu.org ([2001:4830:134:3::10]:48652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUYwR-0001Qn-Ua
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:09:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUYwR-0002PB-0D
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:09:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cUYwQ-0002Ox-Qv
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:09:18 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 20 Jan 2017 21:08:41 +0800
Message-Id: <1484917736-32056-6-git-send-email-peterx@redhat.com>
In-Reply-To: <1484917736-32056-1-git-send-email-peterx@redhat.com>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v4 05/20] intel_iommu: simplify irq region
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

Now we have a standalone memory region for MSI, all the irq region
requests should be redirected there. Cleaning up the block with an
assertion instead.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e58f1de..55b8ff4 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -818,28 +818,12 @@ static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     bool writes = true;
     VTDIOTLBEntry *iotlb_entry;
 
-    /* Check if the request is in interrupt address range */
-    if (vtd_is_interrupt_addr(addr)) {
-        if (is_write) {
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
-            vtd_report_dmar_fault(s, source_id, addr, VTD_FR_READ, is_write);
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

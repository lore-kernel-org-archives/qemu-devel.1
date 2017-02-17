Received: from eggs.gnu.org ([2001:4830:134:3::10]:44607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceocS-0004dI-0c
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:55:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceocN-000607-5y
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:55:04 -0500
Received: from mail.kernel.org ([198.145.29.136]:34678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceocM-0005zF-SA
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:58 -0500
Date: Fri, 17 Feb 2017 21:54:54 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1487361200-29966-20-git-send-email-mst@redhat.com>
References: <1487361200-29966-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487361200-29966-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 19/23] intel_iommu: simplify irq region
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

Now we have a standalone memory region for MSI, all the irq region
requests should be redirected there. Cleaning up the block with an
assertion instead.

Reviewed-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 50251c3..86d19bb 100644
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
MST

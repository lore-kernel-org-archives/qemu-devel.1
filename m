Received: from eggs.gnu.org ([2001:4830:134:3::10]:48957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUYxE-00026P-CF
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:10:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUYx9-0002jq-9x
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:10:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cUYx9-0002jQ-48
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:10:03 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 20 Jan 2017 21:08:56 +0800
Message-Id: <1484917736-32056-21-git-send-email-peterx@redhat.com>
In-Reply-To: <1484917736-32056-1-git-send-email-peterx@redhat.com>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v4 20/20] intel_iommu: replay even with
 DSI/GLOBAL inv desc
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

We were capturing context entry invalidations to trap IOMMU mapping
changes. This patch listens to domain/global invalidation requests too.

We need this for the sake that guest operating system might send one
domain/global invalidation instead of several PSIs in some cases. To
better survive with that, we'd better replay corresponding regions as
well for these invalidations, even if this will turn the performance
down a bit.

An example in Linux (4.10.0) Intel IOMMU driver:

    /*
     * Fallback to domain selective flush if no PSI support or the size is
     * too big.
     * PSI requires page size to be 2 ^ x, and the base address is naturally
     * aligned to the size
     */
    if (!cap_pgsel_inv(iommu->cap) || mask > cap_max_amask_val(iommu->cap))
        iommu->flush.flush_iotlb(iommu, did, 0, 0,
                        DMA_TLB_DSI_FLUSH);
    else
        iommu->flush.flush_iotlb(iommu, did, addr | ih, mask,
                        DMA_TLB_PSI_FLUSH);

If we don't have this, when above DSI FLUSH happens, we might have
unaligned mapping.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a038651..e958f53 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1196,14 +1196,33 @@ static uint64_t vtd_context_cache_invalidate(IntelIOMMUState *s, uint64_t val)
 
 static void vtd_iotlb_global_invalidate(IntelIOMMUState *s)
 {
+    IntelIOMMUNotifierNode *node;
+
     trace_vtd_iotlb_reset("global invalidation recved");
     vtd_reset_iotlb(s);
+
+    QLIST_FOREACH(node, &s->notifiers_list, next) {
+        memory_region_iommu_replay_all(&node->vtd_as->iommu);
+    }
 }
 
 static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
 {
+    IntelIOMMUNotifierNode *node;
+    VTDContextEntry ce;
+    VTDAddressSpace *vtd_as;
+
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_domain,
                                 &domain_id);
+
+    QLIST_FOREACH(node, &s->notifiers_list, next) {
+        vtd_as = node->vtd_as;
+        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
+                                      vtd_as->devfn, &ce) &&
+            domain_id == VTD_CONTEXT_ENTRY_DID(ce.hi)) {
+            memory_region_iommu_replay_all(&vtd_as->iommu);
+        }
+    }
 }
 
 static int vtd_page_invalidate_notify_hook(IOMMUTLBEntry *entry,
-- 
2.7.4

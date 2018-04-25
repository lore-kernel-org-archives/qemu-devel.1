Received: from eggs.gnu.org ([2001:4830:134:3::10]:59115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBCPq-0004NU-Rn
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBCPp-0007S7-No
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:52:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59414 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fBCPp-0007Rq-Is
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:52:25 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 25 Apr 2018 12:51:28 +0800
Message-Id: <20180425045129.17449-10-peterx@redhat.com>
In-Reply-To: <20180425045129.17449-1-peterx@redhat.com>
References: <20180425045129.17449-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 09/10] intel-iommu: don't unmap all for shadow
 page table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

IOMMU replay was carried out before in many use cases, e.g., context
cache invalidations, domain flushes.  We used this mechanism to sync the
shadow page table by firstly (1) unmap the whole address space, then
(2) walk the page table to remap what's in the table.

This is very dangerous.

The problem is that we'll have a very small window (in my measurement,
it can be about 3ms) during above step (1) and (2) that the device will
see no (or incomplete) device page table.  Howerver the device never
knows that.  This can cause DMA error of devices, who assumes the page
table is always there.

So the point is that, for MAP typed notifiers (vfio-pci, for example)
they'll need the mapped page entries always be there.  We can never
unmap any existing page entries like what we did in (1) above.

The only solution is to remove step (1).  We can't do that before since
we didn't know what device page was mapped and what was not, so we unmap
them all.  Now with the new IOVA tree QEMU knows what has mapped and
what has not.  We don't need this step (1) any more.  Remove it.

Note that after removing that global unmap flushing, we'll need to
notify unmap now during page walkings.

This should fix the DMA error problem that Jintack Lim reported with
nested device assignment.  This problem won't not happen always, e.g., I
cannot reproduce the error.  However after collecting logs it shows that
this is the possible cause to Jintack's problem.

Reported-by: Jintack Lim <jintack@cs.columbia.edu>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 8f396a5d13..dedaebc46b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2952,10 +2952,8 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
 
     /*
      * The replay can be triggered by either a invalidation or a newly
-     * created entry. No matter what, we release existing mappings
-     * (it means flushing caches for UNMAP-only registers).
+     * created entry.
      */
-    vtd_address_space_unmap(vtd_as, n);
 
     if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
         trace_vtd_replay_ce_valid(bus_n, PCI_SLOT(vtd_as->devfn),
@@ -2964,8 +2962,10 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
                                   ce.hi, ce.lo);
         if (vtd_as_notify_mappings(vtd_as)) {
             /* This is required only for MAP typed notifiers */
-            vtd_page_walk(&ce, 0, ~0ULL, vtd_replay_hook, (void *)n, false,
+            vtd_page_walk(&ce, 0, ~0ULL, vtd_replay_hook, (void *)n, true,
                           vtd_as);
+        } else {
+            vtd_address_space_unmap(vtd_as, n);
         }
     } else {
         trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
-- 
2.14.3

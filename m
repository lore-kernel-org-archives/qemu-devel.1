Received: from eggs.gnu.org ([209.51.188.92]:49777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gjbnK-00030d-RH
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 22:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gjbZC-0002lS-Q1
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 22:08:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gjbZC-0002j2-HR
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 22:08:34 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed, 16 Jan 2019 11:08:12 +0800
Message-Id: <20190116030815.27273-2-peterx@redhat.com>
In-Reply-To: <20190116030815.27273-1-peterx@redhat.com>
References: <20190116030815.27273-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/4] intel_iommu: fix operator in
 vtd_switch_address_space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

When calculating use_iommu, we wanted to first detect whether DMAR is
enabled, then check whether PT is enabled if DMAR is enabled.  However
in the current code we used "&" rather than "&&" so the ordering
requirement is lost (instead it'll be an "AND" operation).  This could
introduce errors dumped in QEMU console when rebooting a guest with
both assigned device and vIOMMU, like:

  qemu-system-x86_64: vtd_dev_to_context_entry: invalid root entry:
  rsvd=0xf000ff53f000e2c3, val=0xf000ff53f000ff53 (reserved nonzero)

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 8b72735650..6d5cc1d039 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1153,7 +1153,7 @@ static bool vtd_switch_address_space(VTDAddressSpace *as)
 
     assert(as);
 
-    use_iommu = as->iommu_state->dmar_enabled & !vtd_dev_pt_enabled(as);
+    use_iommu = as->iommu_state->dmar_enabled && !vtd_dev_pt_enabled(as);
 
     trace_vtd_switch_address_space(pci_bus_num(as->bus),
                                    VTD_PCI_SLOT(as->devfn),
-- 
2.17.1

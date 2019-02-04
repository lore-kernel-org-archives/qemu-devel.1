Received: from eggs.gnu.org ([209.51.188.92]:46089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfaf-0006Fc-Ng
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:51:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfTO-0005T4-94
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:47 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:40565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqfTO-0005RP-2X
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:46 -0500
Received: by mail-qk1-f169.google.com with SMTP id y16so41807qki.7
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:43:43 -0800 (PST)
Date: Mon, 4 Feb 2019 09:43:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204142638.27021-12-mst@redhat.com>
References: <20190204142638.27021-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204142638.27021-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 11/25] intel_iommu: fix operator in
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST

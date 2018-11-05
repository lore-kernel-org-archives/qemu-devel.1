Received: from eggs.gnu.org ([2001:4830:134:3::10]:60355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQa-0007ob-65
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQS-0002vS-KY
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gJjQG-0002dO-0E
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:27 -0500
Date: Mon, 5 Nov 2018 13:16:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105181353.39804-10-mst@redhat.com>
References: <20181105181353.39804-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105181353.39804-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 09/33] intel_iommu: handle invalid ce for shadow
 sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Pei Zhang <pezhang@redhat.com>, Eric Auger <eric.auger@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

We should handle VTD_FR_CONTEXT_ENTRY_P properly when synchronizing
shadow page tables.  Having invalid context entry there is perfectly
valid when we move a device out of an existing domain.  When that
happens, instead of posting an error we invalidate the whole region.

Without this patch, QEMU will crash if we do these steps:

(1) start QEMU with VT-d IOMMU and two 10G NICs (ixgbe)
(2) bind the NICs with vfio-pci in the guest
(3) start testpmd with the NICs applied
(4) stop testpmd
(5) rebind the NIC back to ixgbe kernel driver

The patch should fix it.

Reported-by: Pei Zhang <pezhang@redhat.com>
Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1627272
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 25e54671f4..f24ebfca1c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -38,6 +38,7 @@
 #include "trace.h"
 
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
+static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
 
 static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
                             uint64_t wmask, uint64_t w1cmask)
@@ -1066,11 +1067,27 @@ static int vtd_sync_shadow_page_table(VTDAddressSpace *vtd_as)
 {
     int ret;
     VTDContextEntry ce;
+    IOMMUNotifier *n;
 
     ret = vtd_dev_to_context_entry(vtd_as->iommu_state,
                                    pci_bus_num(vtd_as->bus),
                                    vtd_as->devfn, &ce);
     if (ret) {
+        if (ret == -VTD_FR_CONTEXT_ENTRY_P) {
+            /*
+             * It's a valid scenario to have a context entry that is
+             * not present.  For example, when a device is removed
+             * from an existing domain then the context entry will be
+             * zeroed by the guest before it was put into another
+             * domain.  When this happens, instead of synchronizing
+             * the shadow pages we should invalidate all existing
+             * mappings and notify the backends.
+             */
+            IOMMU_NOTIFIER_FOREACH(n, &vtd_as->iommu) {
+                vtd_address_space_unmap(vtd_as, n);
+            }
+            ret = 0;
+        }
         return ret;
     }
 
-- 
MST

Received: from eggs.gnu.org ([2001:4830:134:3::10]:55481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1csmGr-0001iJ-9P
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1csmGm-0001E7-EW
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:14:29 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 28 Mar 2017 19:13:49 +1100
Message-Id: <20170328081349.18734-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] spapr_pci: Warn when RAM page size is not
 enabled in IOMMU page mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

If a page size used by QEMU is not enabled in the PHB IOMMU page mask,
in-kernel acceleration of TCE handling won't be enabled and performance
might be slower than expected.

This prints a warning if system page size is not enabled. This should
print a warning if huge pages are enabled but sphb.pgsz still uses
the default value of 4K|64K.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This follow-up for "exec, spapr_pci: Advertise huge IOMMU pages".
Instead of silently changing PHB properties+behaviour for better
performance if huge pages are detected, this simply warns the user
if IOMMU page mask needs to be adjusted. Since the user chooses
huge pages in the first place, the user can also supply additional
page masks as well.


---
 hw/ppc/spapr_pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 98c52e411f..097ebdd51d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1771,6 +1771,12 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     }
 
     /* DMA setup */
+    if ((sphb->page_size_mask & qemu_getrampagesize()) == 0) {
+        error_report("System page size 0x%lx is not enabled in page_size_mask "
+                     "(0x%"PRIx64"). Performance may be slow",
+                     qemu_getrampagesize(), sphb->page_size_mask);
+    }
+
     for (i = 0; i < windows_supported; ++i) {
         tcet = spapr_tce_new_table(DEVICE(sphb), sphb->dma_liobn[i]);
         if (!tcet) {
-- 
2.11.0

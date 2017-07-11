Received: from eggs.gnu.org ([2001:4830:134:3::10]:40677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxP-0002Ml-TM
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxP-0007Vd-00
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:31 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 11 Jul 2017 14:39:14 +1000
Message-Id: <20170711043917.1757-15-david@gibson.dropbear.id.au>
In-Reply-To: <20170711043917.1757-1-david@gibson.dropbear.id.au>
References: <20170711043917.1757-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 14/17] spapr: Only report host/guest IOMMU page
 size mismatches on KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, groug@kaod.org, bharata@linux.vnet.ibm.com, lvivier@redhat.com, aik@ozlabs.ru, surajjs@au1.ibm.com, sbobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

We print a warning if the spapr IOMMU isn't configured to support a page
size matching the host page size backing RAM.  When that's the case we need
more complex logic to translate VFIO mappings, which is slower.

But, it's not so slow that it would be at all noticeable against the
general slowness of TCG.  So, only warn when using KVM.  This removes some
noisy and unhelpful warnings from make check on hosts with page sizes
which typically differ from those on POWER (e.g. Sparc).

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/spapr_pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index cc1588d..a52dcf8 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1745,7 +1745,8 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     }
 
     /* DMA setup */
-    if ((sphb->page_size_mask & qemu_getrampagesize()) == 0) {
+    if (((sphb->page_size_mask & qemu_getrampagesize()) == 0)
+        && kvm_enabled()) {
         error_report("System page size 0x%lx is not enabled in page_size_mask "
                      "(0x%"PRIx64"). Performance may be slow",
                      qemu_getrampagesize(), sphb->page_size_mask);
-- 
2.9.4

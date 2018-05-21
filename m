Received: from eggs.gnu.org ([2001:4830:134:3::10]:42899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fKlQO-0002wD-9U
	for qemu-devel@nongnu.org; Mon, 21 May 2018 10:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fKlQH-00012S-Q7
	for qemu-devel@nongnu.org; Mon, 21 May 2018 10:04:32 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 May 2018 15:03:47 +0100
Message-Id: <20180521140402.23318-13-peter.maydell@linaro.org>
In-Reply-To: <20180521140402.23318-1-peter.maydell@linaro.org>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 12/27] Make flatview_do_translate() take a
 MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As part of plumbing MemTxAttrs down to the IOMMU translate method,
add MemTxAttrs as an argument to flatview_do_translate().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 exec.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/exec.c b/exec.c
index 84f2c21ecb..af2b82d154 100644
--- a/exec.c
+++ b/exec.c
@@ -541,6 +541,7 @@ unassigned:
  * @is_write: whether the translation operation is for write
  * @is_mmio: whether this can be MMIO, set true if it can
  * @target_as: the address space targeted by the IOMMU
+ * @attrs: memory transaction attributes
  *
  * This function is called from RCU critical section
  */
@@ -551,7 +552,8 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,
                                                  hwaddr *page_mask_out,
                                                  bool is_write,
                                                  bool is_mmio,
-                                                 AddressSpace **target_as)
+                                                 AddressSpace **target_as,
+                                                 MemTxAttrs attrs)
 {
     MemoryRegionSection *section;
     IOMMUMemoryRegion *iommu_mr;
@@ -592,7 +594,8 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
      * but page mask.
      */
     section = flatview_do_translate(address_space_to_flatview(as), addr, &xlat,
-                                    NULL, &page_mask, is_write, false, &as);
+                                    NULL, &page_mask, is_write, false, &as,
+                                    attrs);
 
     /* Illegal translation */
     if (section.mr == &io_mem_unassigned) {
@@ -627,7 +630,7 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
 
     /* This can be MMIO, so setup MMIO bit. */
     section = flatview_do_translate(fv, addr, xlat, plen, NULL,
-                                    is_write, true, &as);
+                                    is_write, true, &as, attrs);
     mr = section.mr;
 
     if (xen_enabled() && memory_access_is_direct(mr, is_write)) {
-- 
2.17.0

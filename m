Received: from eggs.gnu.org ([2001:4830:134:3::10]:42462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fKlQA-0002dX-I4
	for qemu-devel@nongnu.org; Mon, 21 May 2018 10:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fKlQ9-0000rJ-LW
	for qemu-devel@nongnu.org; Mon, 21 May 2018 10:04:18 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 May 2018 15:03:48 +0100
Message-Id: <20180521140402.23318-14-peter.maydell@linaro.org>
In-Reply-To: <20180521140402.23318-1-peter.maydell@linaro.org>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 13/27] Make address_space_translate_iommu take
 a MemTxAttrs argument
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
add MemTxAttrs as an argument to address_space_translate_iommu().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 exec.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/exec.c b/exec.c
index af2b82d154..c3baadc349 100644
--- a/exec.c
+++ b/exec.c
@@ -478,6 +478,7 @@ address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *x
  * @is_write: whether the translation operation is for write
  * @is_mmio: whether this can be MMIO, set true if it can
  * @target_as: the address space targeted by the IOMMU
+ * @attrs: transaction attributes
  *
  * This function is called from RCU critical section.  It is the common
  * part of flatview_do_translate and address_space_translate_cached.
@@ -488,7 +489,8 @@ static MemoryRegionSection address_space_translate_iommu(IOMMUMemoryRegion *iomm
                                                          hwaddr *page_mask_out,
                                                          bool is_write,
                                                          bool is_mmio,
-                                                         AddressSpace **target_as)
+                                                         AddressSpace **target_as,
+                                                         MemTxAttrs attrs)
 {
     MemoryRegionSection *section;
     hwaddr page_mask = (hwaddr)-1;
@@ -572,7 +574,7 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,
         return address_space_translate_iommu(iommu_mr, xlat,
                                              plen_out, page_mask_out,
                                              is_write, is_mmio,
-                                             target_as);
+                                             target_as, attrs);
     }
     if (page_mask_out) {
         /* Not behind an IOMMU, use default page size. */
@@ -3735,7 +3737,7 @@ static inline MemoryRegion *address_space_translate_cached(
 
     section = address_space_translate_iommu(iommu_mr, xlat, plen,
                                             NULL, is_write, true,
-                                            &target_as);
+                                            &target_as, attrs);
     return section.mr;
 }
 
-- 
2.17.0

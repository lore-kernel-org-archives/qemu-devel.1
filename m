Received: from eggs.gnu.org ([2001:4830:134:3::10]:41734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUy-0000wT-8B
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUx-0006aj-EB
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:16 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fOOUx-0006a3-6X
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:15 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUw-0002xw-9Z
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:24:14 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 15:23:54 +0100
Message-Id: <20180531142357.904-23-peter.maydell@linaro.org>
In-Reply-To: <20180531142357.904-1-peter.maydell@linaro.org>
References: <20180531142357.904-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/25] Make address_space_translate_iommu take a
 MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

As part of plumbing MemTxAttrs down to the IOMMU translate method,
add MemTxAttrs as an argument to address_space_translate_iommu().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180521140402.23318-14-peter.maydell@linaro.org
---
 exec.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/exec.c b/exec.c
index e84e0d8c58..c30f905598 100644
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
@@ -3734,7 +3736,7 @@ static inline MemoryRegion *address_space_translate_cached(
 
     section = address_space_translate_iommu(iommu_mr, xlat, plen,
                                             NULL, is_write, true,
-                                            &target_as);
+                                            &target_as, attrs);
     return section.mr;
 }
 
-- 
2.17.1

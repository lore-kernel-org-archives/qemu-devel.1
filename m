Received: from eggs.gnu.org ([2001:4830:134:3::10]:36628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8RHE-0000IO-8y
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8RHC-0003G9-Gm
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:08:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35548 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f8RHC-0003Fn-AZ
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:08:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 027EB406C510
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 14:08:06 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-72.ams2.redhat.com
	[10.36.116.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 887B0200BCB0
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 14:08:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Apr 2018 16:08:00 +0200
Message-Id: <20180417140802.16711-3-pbonzini@redhat.com>
In-Reply-To: <20180417140802.16711-1-pbonzini@redhat.com>
References: <20180417140802.16711-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] exec: small changes to
 flatview_do_translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Prepare for extracting the IOMMU part to a separate function.  Mostly
cosmetic; the only semantic change is that, if there is more than one
cascaded IOMMU and the second one fails to translate, *plen_out is now
adjusted according to the page mask of the first IOMMU.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/exec.c b/exec.c
index 02b1efebb7..1dea3e9c95 100644
--- a/exec.c
+++ b/exec.c
@@ -476,6 +476,7 @@ address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *x
  *            would tell. It can be @NULL if we don't care about it.
  * @is_write: whether the translation operation is for write
  * @is_mmio: whether this can be MMIO, set true if it can
+ * @target_as: the address space targeted by the IOMMU
  *
  * This function is called from RCU critical section
  */
@@ -495,14 +496,14 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,
     hwaddr page_mask = (hwaddr)(-1);
     hwaddr plen = (hwaddr)(-1);
 
-    if (plen_out) {
-        plen = *plen_out;
+    if (!plen_out) {
+        plen_out = &plen;
     }
 
     for (;;) {
         section = address_space_translate_internal(
-                flatview_to_dispatch(fv), addr, &addr,
-                &plen, is_mmio);
+                flatview_to_dispatch(fv), addr, xlat,
+                plen_out, is_mmio);
 
         iommu_mr = memory_region_get_iommu(section->mr);
         if (!iommu_mr) {
@@ -510,35 +511,29 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,
         }
         imrc = memory_region_get_iommu_class_nocheck(iommu_mr);
 
+        addr = *xlat;
         iotlb = imrc->translate(iommu_mr, addr, is_write ?
                                 IOMMU_WO : IOMMU_RO);
-        addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
-                | (addr & iotlb.addr_mask));
-        page_mask &= iotlb.addr_mask;
-        plen = MIN(plen, (addr | iotlb.addr_mask) - addr + 1);
         if (!(iotlb.perm & (1 << is_write))) {
             goto translate_fail;
         }
 
+        addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
+                | (addr & iotlb.addr_mask));
+        page_mask &= iotlb.addr_mask;
+        *plen_out = MIN(*plen_out, (addr | iotlb.addr_mask) - addr + 1);
         fv = address_space_to_flatview(iotlb.target_as);
         *target_as = iotlb.target_as;
     }
 
-    *xlat = addr;
-
-    if (page_mask == (hwaddr)(-1)) {
-        /* Not behind an IOMMU, use default page size. */
-        page_mask = ~TARGET_PAGE_MASK;
-    }
-
     if (page_mask_out) {
+        if (page_mask == (hwaddr)(-1)) {
+            /* Not behind an IOMMU, use default page size. */
+            page_mask = ~TARGET_PAGE_MASK;
+        }
         *page_mask_out = page_mask;
     }
 
-    if (plen_out) {
-        *plen_out = plen;
-    }
-
     return *section;
 
 translate_fail:
-- 
2.17.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAsy-0002x6-RM
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAsv-0001Lt-Nz
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:04 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAsv-0001LO-Ic
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:01 -0400
Received: by mail-wm0-x241.google.com with SMTP id o78-v6so24237797wmg.0
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:15:01 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-189-60.clienti.tiscali.it.
	[78.12.189.60]) by smtp.gmail.com with ESMTPSA id
	c15-v6sm14020129edr.78.2018.05.08.15.14.59
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 08 May 2018 15:14:59 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:25 +0200
Message-Id: <1525817687-34620-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/30] exec: small changes to
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/exec.c b/exec.c
index c7fcefa..8354cdc 100644
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
1.8.3.1

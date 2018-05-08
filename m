Received: from eggs.gnu.org ([2001:4830:134:3::10]:41220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAsy-0002x8-Rq
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAsx-0001MH-00
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:04 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:50327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAsw-0001M0-Le
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:02 -0400
Received: by mail-wm0-x244.google.com with SMTP id t11so21289531wmt.0
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:15:02 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-189-60.clienti.tiscali.it.
	[78.12.189.60]) by smtp.gmail.com with ESMTPSA id
	c15-v6sm14020129edr.78.2018.05.08.15.15.00
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 08 May 2018 15:15:00 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:26 +0200
Message-Id: <1525817687-34620-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/30] exec: extract
 address_space_translate_iommu, fix page_mask corner case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This will be used to process IOMMUs in a MemoryRegionCache.  This
includes a small bugfix, in that the returned page_mask is now
correctly -1 if the IOMMU memory region maps the entire address
space directly.  Previously, address_space_get_iotlb_entry would
return ~TARGET_PAGE_MASK.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 110 ++++++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 75 insertions(+), 35 deletions(-)

diff --git a/exec.c b/exec.c
index 8354cdc..5f98106 100644
--- a/exec.c
+++ b/exec.c
@@ -462,6 +462,70 @@ address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *x
 }
 
 /**
+ * address_space_translate_iommu - translate an address through an IOMMU
+ * memory region and then through the target address space.
+ *
+ * @iommu_mr: the IOMMU memory region that we start the translation from
+ * @addr: the address to be translated through the MMU
+ * @xlat: the translated address offset within the destination memory region.
+ *        It cannot be %NULL.
+ * @plen_out: valid read/write length of the translated address. It
+ *            cannot be %NULL.
+ * @page_mask_out: page mask for the translated address. This
+ *            should only be meaningful for IOMMU translated
+ *            addresses, since there may be huge pages that this bit
+ *            would tell. It can be %NULL if we don't care about it.
+ * @is_write: whether the translation operation is for write
+ * @is_mmio: whether this can be MMIO, set true if it can
+ * @target_as: the address space targeted by the IOMMU
+ *
+ * This function is called from RCU critical section.  It is the common
+ * part of flatview_do_translate and address_space_translate_cached.
+ */
+static MemoryRegionSection address_space_translate_iommu(IOMMUMemoryRegion *iommu_mr,
+                                                         hwaddr *xlat,
+                                                         hwaddr *plen_out,
+                                                         hwaddr *page_mask_out,
+                                                         bool is_write,
+                                                         bool is_mmio,
+                                                         AddressSpace **target_as)
+{
+    MemoryRegionSection *section;
+    hwaddr page_mask = (hwaddr)-1;
+
+    do {
+        hwaddr addr = *xlat;
+        IOMMUMemoryRegionClass *imrc = memory_region_get_iommu_class_nocheck(iommu_mr);
+        IOMMUTLBEntry iotlb = imrc->translate(iommu_mr, addr, is_write ?
+                                              IOMMU_WO : IOMMU_RO);
+
+        if (!(iotlb.perm & (1 << is_write))) {
+            goto unassigned;
+        }
+
+        addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
+                | (addr & iotlb.addr_mask));
+        page_mask &= iotlb.addr_mask;
+        *plen_out = MIN(*plen_out, (addr | iotlb.addr_mask) - addr + 1);
+        *target_as = iotlb.target_as;
+
+        section = address_space_translate_internal(
+                address_space_to_dispatch(iotlb.target_as), addr, xlat,
+                plen_out, is_mmio);
+
+        iommu_mr = memory_region_get_iommu(section->mr);
+    } while (unlikely(iommu_mr));
+
+    if (page_mask_out) {
+        *page_mask_out = page_mask;
+    }
+    return *section;
+
+unassigned:
+    return (MemoryRegionSection) { .mr = &io_mem_unassigned };
+}
+
+/**
  * flatview_do_translate - translate an address in FlatView
  *
  * @fv: the flat view that we want to translate on
@@ -489,55 +553,31 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,
                                                  bool is_mmio,
                                                  AddressSpace **target_as)
 {
-    IOMMUTLBEntry iotlb;
     MemoryRegionSection *section;
     IOMMUMemoryRegion *iommu_mr;
-    IOMMUMemoryRegionClass *imrc;
-    hwaddr page_mask = (hwaddr)(-1);
     hwaddr plen = (hwaddr)(-1);
 
     if (!plen_out) {
         plen_out = &plen;
     }
 
-    for (;;) {
-        section = address_space_translate_internal(
-                flatview_to_dispatch(fv), addr, xlat,
-                plen_out, is_mmio);
-
-        iommu_mr = memory_region_get_iommu(section->mr);
-        if (!iommu_mr) {
-            break;
-        }
-        imrc = memory_region_get_iommu_class_nocheck(iommu_mr);
-
-        addr = *xlat;
-        iotlb = imrc->translate(iommu_mr, addr, is_write ?
-                                IOMMU_WO : IOMMU_RO);
-        if (!(iotlb.perm & (1 << is_write))) {
-            goto translate_fail;
-        }
+    section = address_space_translate_internal(
+            flatview_to_dispatch(fv), addr, xlat,
+            plen_out, is_mmio);
 
-        addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
-                | (addr & iotlb.addr_mask));
-        page_mask &= iotlb.addr_mask;
-        *plen_out = MIN(*plen_out, (addr | iotlb.addr_mask) - addr + 1);
-        fv = address_space_to_flatview(iotlb.target_as);
-        *target_as = iotlb.target_as;
+    iommu_mr = memory_region_get_iommu(section->mr);
+    if (unlikely(iommu_mr)) {
+        return address_space_translate_iommu(iommu_mr, xlat,
+                                             plen_out, page_mask_out,
+                                             is_write, is_mmio,
+                                             target_as);
     }
-
     if (page_mask_out) {
-        if (page_mask == (hwaddr)(-1)) {
-            /* Not behind an IOMMU, use default page size. */
-            page_mask = ~TARGET_PAGE_MASK;
-        }
-        *page_mask_out = page_mask;
+        /* Not behind an IOMMU, use default page size. */
+        *page_mask_out = ~TARGET_PAGE_MASK;
     }
 
     return *section;
-
-translate_fail:
-    return (MemoryRegionSection) { .mr = &io_mem_unassigned };
 }
 
 /* Called from RCU critical section */
-- 
1.8.3.1

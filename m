Received: from eggs.gnu.org ([2001:4830:134:3::10]:36637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8RHE-0000IQ-AB
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8RHD-0003GT-8G
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:08:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51538 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f8RHD-0003GN-26
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:08:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B45B2406E97E
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 14:08:06 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-72.ams2.redhat.com
	[10.36.116.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4411C202660D
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 14:08:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Apr 2018 16:08:01 +0200
Message-Id: <20180417140802.16711-4-pbonzini@redhat.com>
In-Reply-To: <20180417140802.16711-1-pbonzini@redhat.com>
References: <20180417140802.16711-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] exec: extract
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 113 +++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 78 insertions(+), 35 deletions(-)

diff --git a/exec.c b/exec.c
index 1dea3e9c95..868f89c345 100644
--- a/exec.c
+++ b/exec.c
@@ -461,6 +461,72 @@ address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *x
     return section;
 }
 
+/**
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
+ * This function is called from RCU critical section.
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
+        if (!section) {
+            goto unassigned;
+        }
+
+        iommu_mr = memory_region_get_iommu(section->mr);
+    } while (iommu_mr);
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
 /**
  * flatview_do_translate - translate an address in FlatView
  *
@@ -489,55 +556,31 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,
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
+    section = address_space_translate_internal(
+            flatview_to_dispatch(fv), addr, xlat,
+            plen_out, is_mmio);
 
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
-
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
2.17.0

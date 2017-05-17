Received: from eggs.gnu.org ([2001:4830:134:3::10]:33117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dAuml-0006Vo-Iu
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dAumi-0000ob-Qq
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:58:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dAumi-0000o6-IF
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:58:20 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 17 May 2017 16:57:42 +0800
Message-Id: <1495011462-8735-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2] exec: abstract address_space_do_translate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

This function is an abstraction helper for address_space_translate() and
address_space_get_iotlb_entry(). It does the lookup of address into
memory region section, then do proper IOMMU translation if necessary.
With that, refactor the two existing functions a bit to use it.

This fixes a potential vhost dmar issue when with IOMMU passthrough
mode.

Tested-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v2:
- added the lines to fix issue reported by Maxime [Maxime]
- considering that what Maxime tested is exactly this patch after
  applying the change, add t-b line for Maxime
---
 exec.c | 103 +++++++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 69 insertions(+), 34 deletions(-)

diff --git a/exec.c b/exec.c
index eac6085..f942eb2 100644
--- a/exec.c
+++ b/exec.c
@@ -463,18 +463,20 @@ address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *x
 }
 
 /* Called from RCU critical section */
-IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
-                                            bool is_write)
+static MemoryRegionSection address_space_do_translate(AddressSpace *as,
+                                                      hwaddr addr,
+                                                      hwaddr *xlat,
+                                                      hwaddr *plen,
+                                                      bool is_write,
+                                                      bool is_mmio)
 {
-    IOMMUTLBEntry iotlb = {0};
+    IOMMUTLBEntry iotlb;
     MemoryRegionSection *section;
     MemoryRegion *mr;
 
     for (;;) {
         AddressSpaceDispatch *d = atomic_rcu_read(&as->dispatch);
-        section = address_space_lookup_region(d, addr, false);
-        addr = addr - section->offset_within_address_space
-               + section->offset_within_region;
+        section = address_space_translate_internal(d, addr, &addr, plen, is_mmio);
         mr = section->mr;
 
         if (!mr->iommu_ops) {
@@ -482,55 +484,88 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
         }
 
         iotlb = mr->iommu_ops->translate(mr, addr, is_write);
+        addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
+                | (addr & iotlb.addr_mask));
+        *plen = MIN(*plen, (addr | iotlb.addr_mask) - addr + 1);
         if (!(iotlb.perm & (1 << is_write))) {
-            iotlb.target_as = NULL;
-            break;
+            goto translate_fail;
         }
 
-        addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
-                | (addr & iotlb.addr_mask));
         as = iotlb.target_as;
     }
 
-    return iotlb;
+    *xlat = addr;
+
+    return *section;
+
+translate_fail:
+    return (MemoryRegionSection) { .mr = &io_mem_unassigned };
 }
 
 /* Called from RCU critical section */
-MemoryRegion *address_space_translate(AddressSpace *as, hwaddr addr,
-                                      hwaddr *xlat, hwaddr *plen,
-                                      bool is_write)
+IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
+                                            bool is_write)
 {
-    IOMMUTLBEntry iotlb;
-    MemoryRegionSection *section;
-    MemoryRegion *mr;
+    MemoryRegionSection section;
+    hwaddr xlat, plen;
 
-    for (;;) {
-        AddressSpaceDispatch *d = atomic_rcu_read(&as->dispatch);
-        section = address_space_translate_internal(d, addr, &addr, plen, true);
-        mr = section->mr;
+    /* Try to get maximum page mask during translation. */
+    plen = (hwaddr)-1;
 
-        if (!mr->iommu_ops) {
-            break;
-        }
+    /* This can never be MMIO. */
+    section = address_space_do_translate(as, addr, &xlat, &plen,
+                                         is_write, false);
 
-        iotlb = mr->iommu_ops->translate(mr, addr, is_write);
-        addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
-                | (addr & iotlb.addr_mask));
-        *plen = MIN(*plen, (addr | iotlb.addr_mask) - addr + 1);
-        if (!(iotlb.perm & (1 << is_write))) {
-            mr = &io_mem_unassigned;
-            break;
-        }
+    /* Illegal translation */
+    if (section.mr == &io_mem_unassigned) {
+        goto iotlb_fail;
+    }
 
-        as = iotlb.target_as;
+    /* Convert memory region offset into address space offset */
+    xlat += section.offset_within_address_space -
+        section.offset_within_region;
+
+    if (plen == (hwaddr)-1) {
+        /*
+         * We use default page size here. Logically it only happens
+         * for identity mappings.
+         */
+        plen = TARGET_PAGE_SIZE;
     }
 
+    /* Convert to address mask */
+    plen -= 1;
+
+    return (IOMMUTLBEntry) {
+        .target_as = section.address_space,
+        .iova = addr & ~plen,
+        .translated_addr = xlat & ~plen,
+        .addr_mask = plen,
+        /* IOTLBs are for DMAs, and DMA only allows on RAMs. */
+        .perm = IOMMU_RW,
+    };
+
+iotlb_fail:
+    return (IOMMUTLBEntry) {0};
+}
+
+/* Called from RCU critical section */
+MemoryRegion *address_space_translate(AddressSpace *as, hwaddr addr,
+                                      hwaddr *xlat, hwaddr *plen,
+                                      bool is_write)
+{
+    MemoryRegion *mr;
+    MemoryRegionSection section;
+
+    /* This can be MMIO, so setup MMIO bit. */
+    section = address_space_do_translate(as, addr, xlat, plen, is_write, true);
+    mr = section.mr;
+
     if (xen_enabled() && memory_access_is_direct(mr, is_write)) {
         hwaddr page = ((addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE) - addr;
         *plen = MIN(page, *plen);
     }
 
-    *xlat = addr;
     return mr;
 }
 
-- 
2.7.4

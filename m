Received: from eggs.gnu.org ([2001:4830:134:3::10]:35698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qxv-0003Jt-AH
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qxu-00021J-5S
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:07 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:52862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qxt-00020v-Rr
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:06 -0400
Received: by mail-wm0-x241.google.com with SMTP id k4so11169200wmc.1
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:05 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:11:57 +0200
Message-Id: <1508343141-31835-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/29] exec: add page_mask for
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
Cc: Peter Xu <peterx@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

From: Peter Xu <peterx@redhat.com>

The function is originally used for flatview_space_translate() and what
we care about most is (xlat, plen) range. However for iotlb requests, we
don't really care about "plen", but the size of the page that "xlat" is
located on. While, plen cannot really contain this information.

A simple example to show why "plen" is not good for IOTLB translations:

E.g., for huge pages, it is possible that guest mapped 1G huge page on
device side that used this GPA range:

  0x100000000 - 0x13fffffff

Then let's say we want to translate one IOVA that finally mapped to GPA
0x13ffffe00 (which is located on this 1G huge page). Then here we'll
get:

  (xlat, plen) = (0x13fffe00, 0x200)

So the IOTLB would be only covering a very small range since from
"plen" (which is 0x200 bytes) we cannot tell the size of the page.

Actually we can really know that this is a huge page - we just throw the
information away in flatview_do_translate().

This patch introduced "page_mask" optional parameter to capture that
page mask info. Also, I made "plen" an optional parameter as well, with
some comments for the whole function.

No functional change yet.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-Id: <20171010094247.10173-2-maxime.coquelin@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 51 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/exec.c b/exec.c
index 6378714..ca520ac 100644
--- a/exec.c
+++ b/exec.c
@@ -465,11 +465,29 @@ address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *x
     return section;
 }
 
-/* Called from RCU critical section */
+/**
+ * flatview_do_translate - translate an address in FlatView
+ *
+ * @fv: the flat view that we want to translate on
+ * @addr: the address to be translated in above address space
+ * @xlat: the translated address offset within memory region. It
+ *        cannot be @NULL.
+ * @plen_out: valid read/write length of the translated address. It
+ *            can be @NULL when we don't care about it.
+ * @page_mask_out: page mask for the translated address. This
+ *            should only be meaningful for IOMMU translated
+ *            addresses, since there may be huge pages that this bit
+ *            would tell. It can be @NULL if we don't care about it.
+ * @is_write: whether the translation operation is for write
+ * @is_mmio: whether this can be MMIO, set true if it can
+ *
+ * This function is called from RCU critical section
+ */
 static MemoryRegionSection flatview_do_translate(FlatView *fv,
                                                  hwaddr addr,
                                                  hwaddr *xlat,
-                                                 hwaddr *plen,
+                                                 hwaddr *plen_out,
+                                                 hwaddr *page_mask_out,
                                                  bool is_write,
                                                  bool is_mmio,
                                                  AddressSpace **target_as)
@@ -478,11 +496,17 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,
     MemoryRegionSection *section;
     IOMMUMemoryRegion *iommu_mr;
     IOMMUMemoryRegionClass *imrc;
+    hwaddr page_mask = (hwaddr)(-1);
+    hwaddr plen = (hwaddr)(-1);
+
+    if (plen_out) {
+        plen = *plen_out;
+    }
 
     for (;;) {
         section = address_space_translate_internal(
                 flatview_to_dispatch(fv), addr, &addr,
-                plen, is_mmio);
+                &plen, is_mmio);
 
         iommu_mr = memory_region_get_iommu(section->mr);
         if (!iommu_mr) {
@@ -494,7 +518,8 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,
                                 IOMMU_WO : IOMMU_RO);
         addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
                 | (addr & iotlb.addr_mask));
-        *plen = MIN(*plen, (addr | iotlb.addr_mask) - addr + 1);
+        page_mask &= iotlb.addr_mask;
+        plen = MIN(plen, (addr | iotlb.addr_mask) - addr + 1);
         if (!(iotlb.perm & (1 << is_write))) {
             goto translate_fail;
         }
@@ -505,6 +530,19 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,
 
     *xlat = addr;
 
+    if (page_mask == (hwaddr)(-1)) {
+        /* Not behind an IOMMU, use default page size. */
+        page_mask = ~TARGET_PAGE_MASK;
+    }
+
+    if (page_mask_out) {
+        *page_mask_out = page_mask;
+    }
+
+    if (plen_out) {
+        *plen_out = plen;
+    }
+
     return *section;
 
 translate_fail:
@@ -523,7 +561,7 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
 
     /* This can never be MMIO. */
     section = flatview_do_translate(address_space_to_flatview(as), addr,
-                                    &xlat, &plen, is_write, false, &as);
+                                    &xlat, &plen, NULL, is_write, false, &as);
 
     /* Illegal translation */
     if (section.mr == &io_mem_unassigned) {
@@ -567,7 +605,8 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
     AddressSpace *as = NULL;
 
     /* This can be MMIO, so setup MMIO bit. */
-    section = flatview_do_translate(fv, addr, xlat, plen, is_write, true, &as);
+    section = flatview_do_translate(fv, addr, xlat, plen, NULL,
+                                    is_write, true, &as);
     mr = section.mr;
 
     if (xen_enabled() && memory_access_is_direct(mr, is_write)) {
-- 
1.8.3.1

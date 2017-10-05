Received: from eggs.gnu.org ([2001:4830:134:3::10]:60441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1e09if-000116-JU
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 13:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1e09id-0002mw-SQ
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 13:13:57 -0400
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu,  5 Oct 2017 19:13:09 +0200
Message-Id: <20171005171309.1250-3-maxime.coquelin@redhat.com>
In-Reply-To: <20171005171309.1250-1-maxime.coquelin@redhat.com>
References: <20171005171309.1250-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [REBASED 2/2] exec: simplify
 address_space_get_iotlb_entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peterx@redhat.com, pbonzini@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>

From: Peter Xu <peterx@redhat.com>

This patch let address_space_get_iotlb_entry() to use the newly
introduced page_mask parameter in flatview_do_translate(). Then we
will be sure the IOTLB can be aligned to page mask, also we should
nicely support huge pages now when introducing a764040.

Fixes: a764040 ("exec: abstract address_space_do_translate()")
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 exec.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/exec.c b/exec.c
index c5f2752f7d..39fc96a19e 100644
--- a/exec.c
+++ b/exec.c
@@ -551,14 +551,14 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
                                             bool is_write)
 {
     MemoryRegionSection section;
-    hwaddr xlat, plen;
+    hwaddr xlat, page_mask;
 
-    /* Try to get maximum page mask during translation. */
-    plen = (hwaddr)-1;
-
-    /* This can never be MMIO. */
-    section = flatview_do_translate(address_space_to_flatview(as), addr,
-                                    &xlat, &plen, NULL, is_write, false, &as);
+    /*
+     * This can never be MMIO, and we don't really care about plen,
+     * but page mask.
+     */
+    section = flatview_do_translate(address_space_to_flatview(as), addr, &xlat,
+                                    NULL, &page_mask, is_write, false, &as);
 
     /* Illegal translation */
     if (section.mr == &io_mem_unassigned) {
@@ -569,22 +569,11 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
     xlat += section.offset_within_address_space -
         section.offset_within_region;
 
-    if (plen == (hwaddr)-1) {
-        /*
-         * We use default page size here. Logically it only happens
-         * for identity mappings.
-         */
-        plen = TARGET_PAGE_SIZE;
-    }
-
-    /* Convert to address mask */
-    plen -= 1;
-
     return (IOMMUTLBEntry) {
         .target_as = as,
-        .iova = addr & ~plen,
-        .translated_addr = xlat & ~plen,
-        .addr_mask = plen,
+        .iova = addr & ~page_mask,
+        .translated_addr = xlat & ~page_mask,
+        .addr_mask = page_mask,
         /* IOTLBs are for DMAs, and DMA only allows on RAMs. */
         .perm = IOMMU_RW,
     };
-- 
2.13.6

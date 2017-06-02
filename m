Received: from eggs.gnu.org ([2001:4830:134:3::10]:44049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dGl7R-00087l-Sv
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dGl7Q-0007jV-Ux
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:51:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dGl7Q-0007jM-PU
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:51:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B945380E7B
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 11:51:51 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri,  2 Jun 2017 19:50:53 +0800
Message-Id: <1496404254-17429-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1496404254-17429-1-git-send-email-peterx@redhat.com>
References: <1496404254-17429-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] exec: simplify
 address_space_get_iotlb_entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

This patch let address_space_get_iotlb_entry() to use the newly
introduced page_mask parameter in address_space_do_translate(). Then we
will be sure the IOTLB can be aligned to page mask, also we should
nicely support huge pages now when introducing a764040.

Fixes: a764040 ("exec: abstract address_space_do_translate()")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 exec.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/exec.c b/exec.c
index 63a3ff0..1f86253 100644
--- a/exec.c
+++ b/exec.c
@@ -544,14 +544,14 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
                                             bool is_write)
 {
     MemoryRegionSection section;
-    hwaddr xlat, plen;
+    hwaddr xlat, page_mask;
 
-    /* Try to get maximum page mask during translation. */
-    plen = (hwaddr)-1;
-
-    /* This can never be MMIO. */
-    section = address_space_do_translate(as, addr, &xlat, &plen,
-                                         NULL, is_write, false);
+    /*
+     * This can never be MMIO, and we don't really care about plen,
+     * but page mask.
+     */
+    section = address_space_do_translate(as, addr, &xlat, NULL,
+                                         &page_mask, is_write, false);
 
     /* Illegal translation */
     if (section.mr == &io_mem_unassigned) {
@@ -562,20 +562,11 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
     xlat += section.offset_within_address_space -
         section.offset_within_region;
 
-    if (plen == (hwaddr)-1) {
-        /* If not specified during translation, use default mask */
-        plen = TARGET_PAGE_MASK;
-    } else {
-        /* Make it a valid page mask */
-        assert(plen);
-        plen = pow2floor(plen) - 1;
-    }
-
     return (IOMMUTLBEntry) {
         .target_as = section.address_space,
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
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCI-0000XZ-8k
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCF-0000Rn-3a
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48070
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCE-0000RD-UX
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:31 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JEDJd024690
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:30 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epm4y6tjm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:30 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:17:29 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:19 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-27-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 26/55] exec: simplify
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
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Peter Xu <peterx@redhat.com>

This patch let address_space_get_iotlb_entry() to use the newly
introduced page_mask parameter in flatview_do_translate(). Then we
will be sure the IOTLB can be aligned to page mask, also we should
nicely support huge pages now when introducing a764040.

Fixes: a764040 ("exec: abstract address_space_do_translate()")
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20171010094247.10173-3-maxime.coquelin@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 076a93d7972c9c1e3839d2f65edc32568a2cce93)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 exec.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/exec.c b/exec.c
index 2fd65dc3f2..9a7600eb17 100644
--- a/exec.c
+++ b/exec.c
@@ -557,14 +557,14 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
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
@@ -575,22 +575,11 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
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
2.11.0

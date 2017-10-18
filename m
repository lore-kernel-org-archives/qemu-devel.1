Received: from eggs.gnu.org ([2001:4830:134:3::10]:35708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qxw-0003KR-1T
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qxv-000223-1v
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:07 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:50703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qxu-00021Q-S9
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:06 -0400
Received: by mail-wr0-x244.google.com with SMTP id q42so5603205wrb.7
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:06 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:11:58 +0200
Message-Id: <1508343141-31835-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/29] exec: simplify
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
Cc: Peter Xu <peterx@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

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
---
 exec.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/exec.c b/exec.c
index ca520ac..6579e7a 100644
--- a/exec.c
+++ b/exec.c
@@ -554,14 +554,14 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
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
@@ -572,22 +572,11 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
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
1.8.3.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiD-0004bN-Pp
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiC-0003zE-MP
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:53 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAiC-0003xV-GQ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:52 -0400
Received: by mail-wr0-x241.google.com with SMTP id g50so3841848wra.3
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:16:52 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:14 +0200
Message-Id: <1506035800-30509-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/32] exec: Explicitly export target AS from
 address_space_translate_internal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This adds an AS** parameter to address_space_do_translate()
to make it easier for the next patch to share FlatViews.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-2-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index a25a4c6..fd8994b 100644
--- a/exec.c
+++ b/exec.c
@@ -476,7 +476,8 @@ static MemoryRegionSection address_space_do_translate(AddressSpace *as,
                                                       hwaddr *xlat,
                                                       hwaddr *plen,
                                                       bool is_write,
-                                                      bool is_mmio)
+                                                      bool is_mmio,
+                                                      AddressSpace **target_as)
 {
     IOMMUTLBEntry iotlb;
     MemoryRegionSection *section;
@@ -503,6 +504,7 @@ static MemoryRegionSection address_space_do_translate(AddressSpace *as,
         }
 
         as = iotlb.target_as;
+        *target_as = iotlb.target_as;
     }
 
     *xlat = addr;
@@ -525,7 +527,7 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
 
     /* This can never be MMIO. */
     section = address_space_do_translate(as, addr, &xlat, &plen,
-                                         is_write, false);
+                                         is_write, false, &as);
 
     /* Illegal translation */
     if (section.mr == &io_mem_unassigned) {
@@ -548,7 +550,7 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
     plen -= 1;
 
     return (IOMMUTLBEntry) {
-        .target_as = section.address_space,
+        .target_as = as,
         .iova = addr & ~plen,
         .translated_addr = xlat & ~plen,
         .addr_mask = plen,
@@ -569,7 +571,8 @@ MemoryRegion *address_space_translate(AddressSpace *as, hwaddr addr,
     MemoryRegionSection section;
 
     /* This can be MMIO, so setup MMIO bit. */
-    section = address_space_do_translate(as, addr, xlat, plen, is_write, true);
+    section = address_space_do_translate(as, addr, xlat, plen, is_write, true,
+                                         &as);
     mr = section.mr;
 
     if (xen_enabled() && memory_access_is_direct(mr, is_write)) {
-- 
1.8.3.1

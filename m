Received: from eggs.gnu.org ([2001:4830:134:3::10]:42194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dtt7i-00065z-My
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dtt7e-0004MI-Ff
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:17:54 -0400
Received: from ozlabs.ru ([107.173.13.209]:35328)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dtt7e-0004M9-98
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:17:50 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 18 Sep 2017 20:16:58 +1000
Message-Id: <20170918101709.30421-3-aik@ozlabs.ru>
In-Reply-To: <20170918101709.30421-1-aik@ozlabs.ru>
References: <20170918101709.30421-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v3 02/13] exec: Explicitely export target
 AS from address_space_translate_internal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>

This is not so mechanical change in order to move to shared FlatViews
so make it a separate patch. The first argument of
address_space_do_translate() will become a FlatView, however since
address_space_get_iotlb_entry() still wants AS, hence this change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 exec.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index d20c34ca83..bd94248390 100644
--- a/exec.c
+++ b/exec.c
@@ -477,7 +477,8 @@ static MemoryRegionSection address_space_do_translate(AddressSpace *as,
                                                       hwaddr *xlat,
                                                       hwaddr *plen,
                                                       bool is_write,
-                                                      bool is_mmio)
+                                                      bool is_mmio,
+                                                      AddressSpace **target_as)
 {
     IOMMUTLBEntry iotlb;
     MemoryRegionSection *section;
@@ -504,6 +505,7 @@ static MemoryRegionSection address_space_do_translate(AddressSpace *as,
         }
 
         as = iotlb.target_as;
+        *target_as = iotlb.target_as;
     }
 
     *xlat = addr;
@@ -526,7 +528,7 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
 
     /* This can never be MMIO. */
     section = address_space_do_translate(as, addr, &xlat, &plen,
-                                         is_write, false);
+                                         is_write, false, &as);
 
     /* Illegal translation */
     if (section.mr == &io_mem_unassigned) {
@@ -549,7 +551,7 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
     plen -= 1;
 
     return (IOMMUTLBEntry) {
-        .target_as = section.address_space,
+        .target_as = as,
         .iova = addr & ~plen,
         .translated_addr = xlat & ~plen,
         .addr_mask = plen,
@@ -570,7 +572,8 @@ MemoryRegion *address_space_translate(AddressSpace *as, hwaddr addr,
     MemoryRegionSection section;
 
     /* This can be MMIO, so setup MMIO bit. */
-    section = address_space_do_translate(as, addr, xlat, plen, is_write, true);
+    section = address_space_do_translate(as, addr, xlat, plen, is_write, true,
+                                         &as);
     mr = section.mr;
 
     if (xen_enabled() && memory_access_is_direct(mr, is_write)) {
-- 
2.11.0

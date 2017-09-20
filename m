Received: from eggs.gnu.org ([2001:4830:134:3::10]:56362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmG-0003O7-NV
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmE-00058B-2a
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:00 -0400
Received: from ozlabs.ru ([107.173.13.209]:59744)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmD-00056z-M1
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:14:57 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 20 Sep 2017 21:46:20 +1000
Message-Id: <20170920114637.42004-2-aik@ozlabs.ru>
In-Reply-To: <20170920114637.42004-1-aik@ozlabs.ru>
References: <20170920114637.42004-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v4 01/18] exec: Explicitly export target
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

This adds an AS** parameter to address_space_do_translate()
to make it easier for the next patch to share FlatViews.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 exec.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index a25a4c6018..fd8994b25d 100644
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
2.11.0

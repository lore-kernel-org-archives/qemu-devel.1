Received: from eggs.gnu.org ([2001:4830:134:3::10]:50234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCu-0001Dn-On
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCr-0001EE-Pr
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCr-0001DH-HL
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:09 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JE2ER107150
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:18:08 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epm1wf7mt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:18:08 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:18:07 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:15:59 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-7-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 06/55] exec: Explicitly export target AS from
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
Cc: qemu-stable@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This adds an AS** parameter to address_space_do_translate()
to make it easier for the next patch to share FlatViews.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-2-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit e76bb18f7e430e0c50fb38d051feacf268bd78f4)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfC1-000860-Hr
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfBx-0008V4-Ag
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36812
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfBx-0008Sw-4f
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:13 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JEAun050895
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:12 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epk5h2kht-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:11 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:17:11 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:03 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-11-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 10/55] memory: Remove AddressSpace pointer from
 AddressSpaceDispatch
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

AS in ASD is only used to pass AS from mem_begin() to register_subpage()
to store it in MemoryRegionSection, we can do this directly now.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-6-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit c7752523787dc148f5ee976162e80ab594c386a1)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 exec.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/exec.c b/exec.c
index 6b0211bafc..3212c5e70d 100644
--- a/exec.c
+++ b/exec.c
@@ -194,7 +194,6 @@ struct AddressSpaceDispatch {
      */
     PhysPageEntry phys_map;
     PhysPageMap map;
-    AddressSpace *as;
 };
 
 #define SUBPAGE_IDX(addr) ((addr) & ~TARGET_PAGE_MASK)
@@ -1304,7 +1303,8 @@ static void phys_sections_free(PhysPageMap *map)
     g_free(map->nodes);
 }
 
-static void register_subpage(AddressSpaceDispatch *d, MemoryRegionSection *section)
+static void register_subpage(AddressSpace *as, AddressSpaceDispatch *d,
+                             MemoryRegionSection *section)
 {
     subpage_t *subpage;
     hwaddr base = section->offset_within_address_space
@@ -1319,8 +1319,8 @@ static void register_subpage(AddressSpaceDispatch *d, MemoryRegionSection *secti
     assert(existing->mr->subpage || existing->mr == &io_mem_unassigned);
 
     if (!(existing->mr->subpage)) {
-        subpage = subpage_init(d->as, base);
-        subsection.address_space = d->as;
+        subpage = subpage_init(as, base);
+        subsection.address_space = as;
         subsection.mr = &subpage->iomem;
         phys_page_set(d, base >> TARGET_PAGE_BITS, 1,
                       phys_section_add(&d->map, &subsection));
@@ -1357,7 +1357,7 @@ void mem_add(AddressSpace *as, FlatView *fv, MemoryRegionSection *section)
                        - now.offset_within_address_space;
 
         now.size = int128_min(int128_make64(left), now.size);
-        register_subpage(d, &now);
+        register_subpage(as, d, &now);
     } else {
         now.size = int128_zero();
     }
@@ -1367,10 +1367,10 @@ void mem_add(AddressSpace *as, FlatView *fv, MemoryRegionSection *section)
         remain.offset_within_region += int128_get64(now.size);
         now = remain;
         if (int128_lt(remain.size, page_size)) {
-            register_subpage(d, &now);
+            register_subpage(as, d, &now);
         } else if (remain.offset_within_address_space & ~TARGET_PAGE_MASK) {
             now.size = page_size;
-            register_subpage(d, &now);
+            register_subpage(as, d, &now);
         } else {
             now.size = int128_and(now.size, int128_neg(page_size));
             register_multipage(d, &now);
@@ -2686,7 +2686,6 @@ AddressSpaceDispatch *mem_begin(AddressSpace *as)
     assert(n == PHYS_SECTION_WATCH);
 
     d->phys_map  = (PhysPageEntry) { .ptr = PHYS_MAP_NODE_NIL, .skip = 1 };
-    d->as = as;
 
     return d;
 }
-- 
2.11.0

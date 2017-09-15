Received: from eggs.gnu.org ([2001:4830:134:3::10]:38162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dsmB1-0006uV-K8
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dsmB0-0002RE-Hr
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:40:43 -0400
Received: from ozlabs.ru ([107.173.13.209]:44668)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dsmB0-0002Ql-BY
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:40:42 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri, 15 Sep 2017 18:40:23 +1000
Message-Id: <20170915084030.40988-7-aik@ozlabs.ru>
In-Reply-To: <20170915084030.40988-1-aik@ozlabs.ru>
References: <20170915084030.40988-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v2 06/13] memory: Remove AddressSpace
 pointer from AddressSpaceDispatch
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

AS in ASD is only used to pass AS from mem_begin() to register_subpage()
to store it in MemoryRegionSection, we can do this directly now.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
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

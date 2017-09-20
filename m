Received: from eggs.gnu.org ([2001:4830:134:3::10]:56365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmG-0003OB-O0
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmD-00057Z-JC
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:00 -0400
Received: from ozlabs.ru ([107.173.13.209]:59744)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmD-00056z-BX
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:14:57 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 20 Sep 2017 21:46:26 +1000
Message-Id: <20170920114637.42004-8-aik@ozlabs.ru>
In-Reply-To: <20170920114637.42004-1-aik@ozlabs.ru>
References: <20170920114637.42004-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v4 07/18] memory: Cleanup after switching
 to FlatView
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

We store AddressSpaceDispatch* in FlatView anyway so there is no need
to carry it from mem_add() to register_subpage/register_multipage.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 exec.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/exec.c b/exec.c
index d2b9f60494..548ec71b4c 100644
--- a/exec.c
+++ b/exec.c
@@ -1302,9 +1302,9 @@ static void phys_sections_free(PhysPageMap *map)
     g_free(map->nodes);
 }
 
-static void register_subpage(FlatView *fv, AddressSpaceDispatch *d,
-                             MemoryRegionSection *section)
+static void register_subpage(FlatView *fv, MemoryRegionSection *section)
 {
+    AddressSpaceDispatch *d = flatview_to_dispatch(fv);
     subpage_t *subpage;
     hwaddr base = section->offset_within_address_space
         & TARGET_PAGE_MASK;
@@ -1333,9 +1333,10 @@ static void register_subpage(FlatView *fv, AddressSpaceDispatch *d,
 }
 
 
-static void register_multipage(AddressSpaceDispatch *d,
+static void register_multipage(FlatView *fv,
                                MemoryRegionSection *section)
 {
+    AddressSpaceDispatch *d = flatview_to_dispatch(fv);
     hwaddr start_addr = section->offset_within_address_space;
     uint16_t section_index = phys_section_add(&d->map, section);
     uint64_t num_pages = int128_get64(int128_rshift(section->size,
@@ -1347,7 +1348,6 @@ static void register_multipage(AddressSpaceDispatch *d,
 
 void mem_add(FlatView *fv, MemoryRegionSection *section)
 {
-    AddressSpaceDispatch *d = flatview_to_dispatch(fv);
     MemoryRegionSection now = *section, remain = *section;
     Int128 page_size = int128_make64(TARGET_PAGE_SIZE);
 
@@ -1356,7 +1356,7 @@ void mem_add(FlatView *fv, MemoryRegionSection *section)
                        - now.offset_within_address_space;
 
         now.size = int128_min(int128_make64(left), now.size);
-        register_subpage(fv, d, &now);
+        register_subpage(fv, &now);
     } else {
         now.size = int128_zero();
     }
@@ -1366,13 +1366,13 @@ void mem_add(FlatView *fv, MemoryRegionSection *section)
         remain.offset_within_region += int128_get64(now.size);
         now = remain;
         if (int128_lt(remain.size, page_size)) {
-            register_subpage(fv, d, &now);
+            register_subpage(fv, &now);
         } else if (remain.offset_within_address_space & ~TARGET_PAGE_MASK) {
             now.size = page_size;
-            register_subpage(fv, d, &now);
+            register_subpage(fv, &now);
         } else {
             now.size = int128_and(now.size, int128_neg(page_size));
-            register_multipage(d, &now);
+            register_multipage(fv, &now);
         }
     }
 }
-- 
2.11.0

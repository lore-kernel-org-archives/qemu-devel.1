Received: from eggs.gnu.org ([2001:4830:134:3::10]:42024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dtt7K-0005l4-3K
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dtt7H-0004FX-87
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:17:30 -0400
Received: from ozlabs.ru ([107.173.13.209]:35254)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dtt7H-0004Dh-1e
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:17:27 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 18 Sep 2017 20:17:04 +1000
Message-Id: <20170918101709.30421-9-aik@ozlabs.ru>
In-Reply-To: <20170918101709.30421-1-aik@ozlabs.ru>
References: <20170918101709.30421-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v3 08/13] memory: Cleanup after switching
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

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 exec.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/exec.c b/exec.c
index b561098df3..3e02b82c05 100644
--- a/exec.c
+++ b/exec.c
@@ -1303,9 +1303,9 @@ static void phys_sections_free(PhysPageMap *map)
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
@@ -1334,9 +1334,10 @@ static void register_subpage(FlatView *fv, AddressSpaceDispatch *d,
 }
 
 
-static void register_multipage(AddressSpaceDispatch *d,
+static void register_multipage(FlatView *fv,
                                MemoryRegionSection *section)
 {
+    AddressSpaceDispatch *d = flatview_to_dispatch(fv);
     hwaddr start_addr = section->offset_within_address_space;
     uint16_t section_index = phys_section_add(&d->map, section);
     uint64_t num_pages = int128_get64(int128_rshift(section->size,
@@ -1348,7 +1349,6 @@ static void register_multipage(AddressSpaceDispatch *d,
 
 void mem_add(FlatView *fv, MemoryRegionSection *section)
 {
-    AddressSpaceDispatch *d = flatview_to_dispatch(fv);
     MemoryRegionSection now = *section, remain = *section;
     Int128 page_size = int128_make64(TARGET_PAGE_SIZE);
 
@@ -1357,7 +1357,7 @@ void mem_add(FlatView *fv, MemoryRegionSection *section)
                        - now.offset_within_address_space;
 
         now.size = int128_min(int128_make64(left), now.size);
-        register_subpage(fv, d, &now);
+        register_subpage(fv, &now);
     } else {
         now.size = int128_zero();
     }
@@ -1367,13 +1367,13 @@ void mem_add(FlatView *fv, MemoryRegionSection *section)
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

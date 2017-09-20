Received: from eggs.gnu.org ([2001:4830:134:3::10]:56354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmG-0003O2-Lq
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmE-00058M-6v
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:00 -0400
Received: from ozlabs.ru ([107.173.13.209]:59740)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmD-00056x-Ln
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:14:57 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 20 Sep 2017 21:46:27 +1000
Message-Id: <20170920114637.42004-9-aik@ozlabs.ru>
In-Reply-To: <20170920114637.42004-1-aik@ozlabs.ru>
References: <20170920114637.42004-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v4 08/18] memory: Rename
 mem_begin/mem_commit/mem_add helpers
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

This renames some helpers to reflect better what they do.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v3:
* s/flatview_mem_add/flatview_add_to_dispatch/
* s/phys_page_compact_all/address_space_dispatch_compact/
* s/address_space_dispatch_alloc/address_space_dispatch_new/
---
 include/exec/memory-internal.h |  6 +++---
 exec.c                         | 12 +++---------
 memory.c                       |  6 +++---
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index 1cf8ad9869..d4a35c6e96 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -27,9 +27,9 @@ extern const MemoryRegionOps unassigned_mem_ops;
 bool memory_region_access_valid(MemoryRegion *mr, hwaddr addr,
                                 unsigned size, bool is_write);
 
-void mem_add(FlatView *fv, MemoryRegionSection *section);
-AddressSpaceDispatch *mem_begin(AddressSpace *as);
-void mem_commit(AddressSpaceDispatch *d);
+void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section);
+AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv);
+void address_space_dispatch_compact(AddressSpaceDispatch *d);
 
 AddressSpaceDispatch *address_space_to_dispatch(AddressSpace *as);
 AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv);
diff --git a/exec.c b/exec.c
index 548ec71b4c..b085f82503 100644
--- a/exec.c
+++ b/exec.c
@@ -358,7 +358,7 @@ static void phys_page_compact(PhysPageEntry *lp, Node *nodes)
     }
 }
 
-static void phys_page_compact_all(AddressSpaceDispatch *d, int nodes_nb)
+void address_space_dispatch_compact(AddressSpaceDispatch *d)
 {
     if (d->phys_map.skip) {
         phys_page_compact(&d->phys_map, d->map.nodes);
@@ -1346,7 +1346,7 @@ static void register_multipage(FlatView *fv,
     phys_page_set(d, start_addr >> TARGET_PAGE_BITS, num_pages, section_index);
 }
 
-void mem_add(FlatView *fv, MemoryRegionSection *section)
+void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section)
 {
     MemoryRegionSection now = *section, remain = *section;
     Int128 page_size = int128_make64(TARGET_PAGE_SIZE);
@@ -2672,9 +2672,8 @@ static void io_mem_init(void)
                           NULL, UINT64_MAX);
 }
 
-AddressSpaceDispatch *mem_begin(AddressSpace *as)
+AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv)
 {
-    FlatView *fv = address_space_to_flatview(as);
     AddressSpaceDispatch *d = g_new0(AddressSpaceDispatch, 1);
     uint16_t n;
 
@@ -2698,11 +2697,6 @@ void address_space_dispatch_free(AddressSpaceDispatch *d)
     g_free(d);
 }
 
-void mem_commit(AddressSpaceDispatch *d)
-{
-    phys_page_compact_all(d, d->map.nodes_nb);
-}
-
 static void tcg_commit(MemoryListener *listener)
 {
     CPUAddressSpace *cpuas;
diff --git a/memory.c b/memory.c
index 1364500eb6..990e9b8478 100644
--- a/memory.c
+++ b/memory.c
@@ -905,13 +905,13 @@ static void address_space_update_topology(AddressSpace *as)
     FlatView *new_view = generate_memory_topology(as->root);
     int i;
 
-    new_view->dispatch = mem_begin(as);
+    new_view->dispatch = address_space_dispatch_new(new_view);
     for (i = 0; i < new_view->nr; i++) {
         MemoryRegionSection mrs =
             section_from_flat_range(&new_view->ranges[i], new_view);
-        mem_add(new_view, &mrs);
+        flatview_add_to_dispatch(new_view, &mrs);
     }
-    mem_commit(new_view->dispatch);
+    address_space_dispatch_compact(new_view->dispatch);
 
     if (!QTAILQ_EMPTY(&as->listeners)) {
         address_space_update_topology_pass(as, old_view, new_view, false);
-- 
2.11.0

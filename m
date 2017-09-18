Received: from eggs.gnu.org ([2001:4830:134:3::10]:42205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dtt7j-00066q-Ki
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dtt7i-0004NU-6W
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:17:55 -0400
Received: from ozlabs.ru ([107.173.13.209]:35346)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dtt7h-0004NB-Q3
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:17:54 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 18 Sep 2017 20:17:01 +1000
Message-Id: <20170918101709.30421-6-aik@ozlabs.ru>
In-Reply-To: <20170918101709.30421-1-aik@ozlabs.ru>
References: <20170918101709.30421-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v3 05/13] memory: Move
 AddressSpaceDispatch from AddressSpace to FlatView
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

As we are going to share FlatView's between AddressSpace's,
and AddressSpaceDispatch is a structure to perform quick lookup
in FlatView, this moves ASD to FlatView.

After previosly open coded ASD rendering, we can also remove
as->next_dispatch as the new FlatView pointer is stored
on a stack and set to an AS atomically.

flatview_destroy() is executed under RCU instead of
address_space_dispatch_free() now.

This makes mem_begin/mem_commit to work with ASD and mem_add with FV
as later on mem_add will be taking FV as an argument anyway.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/exec/memory-internal.h | 12 +++++++-----
 include/exec/memory.h          |  2 --
 exec.c                         | 41 +++++++++++------------------------------
 memory.c                       | 29 +++++++++++++++++++++++------
 4 files changed, 41 insertions(+), 43 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index 9abde2f11c..6e08eda256 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -22,16 +22,18 @@
 #ifndef CONFIG_USER_ONLY
 typedef struct AddressSpaceDispatch AddressSpaceDispatch;
 
-void address_space_destroy_dispatch(AddressSpace *as);
-
 extern const MemoryRegionOps unassigned_mem_ops;
 
 bool memory_region_access_valid(MemoryRegion *mr, hwaddr addr,
                                 unsigned size, bool is_write);
 
-void mem_add(AddressSpace *as, MemoryRegionSection *section);
-void mem_begin(AddressSpace *as);
-void mem_commit(AddressSpace *as);
+void mem_add(AddressSpace *as, FlatView *fv, MemoryRegionSection *section);
+AddressSpaceDispatch *mem_begin(AddressSpace *as);
+void mem_commit(AddressSpaceDispatch *d);
+
+AddressSpaceDispatch *address_space_to_dispatch(AddressSpace *as);
+AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv);
+void address_space_dispatch_free(AddressSpaceDispatch *d);
 
 #endif
 #endif
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9581f7a7db..2346f8b863 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -316,8 +316,6 @@ struct AddressSpace {
 
     int ioeventfd_nb;
     struct MemoryRegionIoeventfd *ioeventfds;
-    struct AddressSpaceDispatch *dispatch;
-    struct AddressSpaceDispatch *next_dispatch;
     QTAILQ_HEAD(memory_listeners_as, MemoryListener) listeners;
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
 };
diff --git a/exec.c b/exec.c
index 3ed3718dea..6b0211bafc 100644
--- a/exec.c
+++ b/exec.c
@@ -188,8 +188,6 @@ typedef struct PhysPageMap {
 } PhysPageMap;
 
 struct AddressSpaceDispatch {
-    struct rcu_head rcu;
-
     MemoryRegionSection *mru_section;
     /* This is a multi-level map on the physical address space.
      * The bottom level has pointers to MemoryRegionSections.
@@ -486,7 +484,7 @@ static MemoryRegionSection address_space_do_translate(AddressSpace *as,
     IOMMUMemoryRegionClass *imrc;
 
     for (;;) {
-        AddressSpaceDispatch *d = atomic_rcu_read(&as->dispatch);
+        AddressSpaceDispatch *d = address_space_to_dispatch(as);
         section = address_space_translate_internal(d, addr, &addr, plen, is_mmio);
 
         iommu_mr = memory_region_get_iommu(section->mr);
@@ -1223,7 +1221,7 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
     } else {
         AddressSpaceDispatch *d;
 
-        d = atomic_rcu_read(&section->address_space->dispatch);
+        d = address_space_to_dispatch(section->address_space);
         iotlb = section - d->map.sections;
         iotlb += xlat;
     }
@@ -1348,9 +1346,9 @@ static void register_multipage(AddressSpaceDispatch *d,
     phys_page_set(d, start_addr >> TARGET_PAGE_BITS, num_pages, section_index);
 }
 
-void mem_add(AddressSpace *as, MemoryRegionSection *section)
+void mem_add(AddressSpace *as, FlatView *fv, MemoryRegionSection *section)
 {
-    AddressSpaceDispatch *d = as->next_dispatch;
+    AddressSpaceDispatch *d = flatview_to_dispatch(fv);
     MemoryRegionSection now = *section, remain = *section;
     Int128 page_size = int128_make64(TARGET_PAGE_SIZE);
 
@@ -2673,7 +2671,7 @@ static void io_mem_init(void)
                           NULL, UINT64_MAX);
 }
 
-void mem_begin(AddressSpace *as)
+AddressSpaceDispatch *mem_begin(AddressSpace *as)
 {
     AddressSpaceDispatch *d = g_new0(AddressSpaceDispatch, 1);
     uint16_t n;
@@ -2689,26 +2687,19 @@ void mem_begin(AddressSpace *as)
 
     d->phys_map  = (PhysPageEntry) { .ptr = PHYS_MAP_NODE_NIL, .skip = 1 };
     d->as = as;
-    as->next_dispatch = d;
+
+    return d;
 }
 
-static void address_space_dispatch_free(AddressSpaceDispatch *d)
+void address_space_dispatch_free(AddressSpaceDispatch *d)
 {
     phys_sections_free(&d->map);
     g_free(d);
 }
 
-void mem_commit(AddressSpace *as)
+void mem_commit(AddressSpaceDispatch *d)
 {
-    AddressSpaceDispatch *cur = as->dispatch;
-    AddressSpaceDispatch *next = as->next_dispatch;
-
-    phys_page_compact_all(next, next->map.nodes_nb);
-
-    atomic_rcu_set(&as->dispatch, next);
-    if (cur) {
-        call_rcu(cur, address_space_dispatch_free, rcu);
-    }
+    phys_page_compact_all(d, d->map.nodes_nb);
 }
 
 static void tcg_commit(MemoryListener *listener)
@@ -2724,21 +2715,11 @@ static void tcg_commit(MemoryListener *listener)
      * We reload the dispatch pointer now because cpu_reloading_memory_map()
      * may have split the RCU critical section.
      */
-    d = atomic_rcu_read(&cpuas->as->dispatch);
+    d = address_space_to_dispatch(cpuas->as);
     atomic_rcu_set(&cpuas->memory_dispatch, d);
     tlb_flush(cpuas->cpu);
 }
 
-void address_space_destroy_dispatch(AddressSpace *as)
-{
-    AddressSpaceDispatch *d = as->dispatch;
-
-    atomic_rcu_set(&as->dispatch, NULL);
-    if (d) {
-        call_rcu(d, address_space_dispatch_free, rcu);
-    }
-}
-
 static void memory_map_init(void)
 {
     system_memory = g_malloc(sizeof(*system_memory));
diff --git a/memory.c b/memory.c
index d3bf0da703..7d28aec5e3 100644
--- a/memory.c
+++ b/memory.c
@@ -229,6 +229,7 @@ struct FlatView {
     FlatRange *ranges;
     unsigned nr;
     unsigned nr_allocated;
+    struct AddressSpaceDispatch *dispatch;
 };
 
 typedef struct AddressSpaceOps AddressSpaceOps;
@@ -289,6 +290,9 @@ static void flatview_destroy(FlatView *view)
 {
     int i;
 
+    if (view->dispatch) {
+        address_space_dispatch_free(view->dispatch);
+    }
     for (i = 0; i < view->nr; i++) {
         memory_region_unref(view->ranges[i].mr);
     }
@@ -304,10 +308,25 @@ static void flatview_ref(FlatView *view)
 static void flatview_unref(FlatView *view)
 {
     if (atomic_fetch_dec(&view->ref) == 1) {
-        flatview_destroy(view);
+        call_rcu(view, flatview_destroy, rcu);
     }
 }
 
+static FlatView *address_space_to_flatview(AddressSpace *as)
+{
+    return atomic_rcu_read(&as->current_map);
+}
+
+AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
+{
+    return fv->dispatch;
+}
+
+AddressSpaceDispatch *address_space_to_dispatch(AddressSpace *as)
+{
+    return flatview_to_dispatch(address_space_to_flatview(as));
+}
+
 static bool can_merge(FlatRange *r1, FlatRange *r2)
 {
     return int128_eq(addrrange_end(r1->addr), r2->addr.start)
@@ -886,13 +905,13 @@ static void address_space_update_topology(AddressSpace *as)
     FlatView *new_view = generate_memory_topology(as->root);
     int i;
 
-    mem_begin(as);
+    new_view->dispatch = mem_begin(as);
     for (i = 0; i < new_view->nr; i++) {
         MemoryRegionSection mrs =
             section_from_flat_range(&new_view->ranges[i], as);
-        mem_add(as, &mrs);
+        mem_add(as, new_view, &mrs);
     }
-    mem_commit(as);
+    mem_commit(new_view->dispatch);
 
     address_space_update_topology_pass(as, old_view, new_view, false);
     address_space_update_topology_pass(as, old_view, new_view, true);
@@ -2629,7 +2648,6 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     QTAILQ_INIT(&as->listeners);
     QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
     as->name = g_strdup(name ? name : "anonymous");
-    as->dispatch = NULL;
     memory_region_update_pending |= root->enabled;
     memory_region_transaction_commit();
 }
@@ -2638,7 +2656,6 @@ static void do_address_space_destroy(AddressSpace *as)
 {
     bool do_free = as->malloced;
 
-    address_space_destroy_dispatch(as);
     assert(QTAILQ_EMPTY(&as->listeners));
 
     flatview_unref(as->current_map);
-- 
2.11.0

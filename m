Received: from eggs.gnu.org ([2001:4830:134:3::10]:48672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfC1-000863-LD
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfBy-00005L-K1
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfBy-0008VJ-7k
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:14 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JE3kN043520
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:10 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epmpw5dqk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:09 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:17:09 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:02 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-10-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 09/55] memory: Move AddressSpaceDispatch from
 AddressSpace to FlatView
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

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-5-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 66a6df1dc6d5b28cc3e65db0d71683fbdddc6b62)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 exec.c                         | 41 +++++++++++------------------------------
 include/exec/memory-internal.h | 12 +++++++-----
 include/exec/memory.h          |  2 --
 memory.c                       | 31 ++++++++++++++++++++++++-------
 4 files changed, 42 insertions(+), 44 deletions(-)

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
index 9ee0f2e846..8f26d63417 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -326,8 +326,6 @@ struct AddressSpace {
 
     int ioeventfd_nb;
     struct MemoryRegionIoeventfd *ioeventfds;
-    struct AddressSpaceDispatch *dispatch;
-    struct AddressSpaceDispatch *next_dispatch;
     QTAILQ_HEAD(memory_listeners_as, MemoryListener) listeners;
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
 };
diff --git a/memory.c b/memory.c
index c0aa296223..de57a16ece 100644
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
 
     if (!QTAILQ_EMPTY(&as->listeners)) {
         address_space_update_topology_pass(as, old_view, new_view, false);
@@ -901,7 +920,7 @@ static void address_space_update_topology(AddressSpace *as)
 
     /* Writes are protected by the BQL.  */
     atomic_rcu_set(&as->current_map, new_view);
-    call_rcu(old_view, flatview_unref, rcu);
+    flatview_unref(old_view);
 
     /* Note that all the old MemoryRegions are still alive up to this
      * point.  This relieves most MemoryListeners from the need to
@@ -2631,7 +2650,6 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     QTAILQ_INIT(&as->listeners);
     QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
     as->name = g_strdup(name ? name : "anonymous");
-    as->dispatch = NULL;
     memory_region_update_pending |= root->enabled;
     memory_region_transaction_commit();
 }
@@ -2640,7 +2658,6 @@ static void do_address_space_destroy(AddressSpace *as)
 {
     bool do_free = as->malloced;
 
-    address_space_destroy_dispatch(as);
     assert(QTAILQ_EMPTY(&as->listeners));
 
     flatview_unref(as->current_map);
-- 
2.11.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dsmB6-0006ye-Ia
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dsmB5-0002XC-9F
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:40:48 -0400
Received: from ozlabs.ru ([107.173.13.209]:44668)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dsmB4-0002Ql-Rx
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:40:47 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri, 15 Sep 2017 18:40:27 +1000
Message-Id: <20170915084030.40988-11-aik@ozlabs.ru>
In-Reply-To: <20170915084030.40988-1-aik@ozlabs.ru>
References: <20170915084030.40988-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v2 10/13] memory: Move root MR from
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/exec/memory.h |  2 +-
 hw/pci/pci.c          |  3 ++-
 memory.c              | 30 ++++++++++++++++--------------
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 7816e5d655..be8cc1ccd3 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -308,7 +308,6 @@ struct AddressSpace {
     /* All fields are private. */
     struct rcu_head rcu;
     char *name;
-    MemoryRegion *root;
     int ref_count;
     bool malloced;
 
@@ -322,6 +321,7 @@ struct AddressSpace {
 };
 
 FlatView *address_space_to_flatview(AddressSpace *as);
+MemoryRegion *address_space_root(AddressSpace *as);
 
 /**
  * MemoryRegionSection: describes a fragment of a #MemoryRegion
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 353195d154..7bf82aac9f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -90,7 +90,8 @@ static void pci_init_bus_master(PCIDevice *pci_dev)
 
     memory_region_init_alias(&pci_dev->bus_master_enable_region,
                              OBJECT(pci_dev), "bus master",
-                             dma_as->root, 0, memory_region_size(dma_as->root));
+                             address_space_root(dma_as), 0,
+                             memory_region_size(address_space_root(dma_as)));
     memory_region_set_enabled(&pci_dev->bus_master_enable_region, false);
     memory_region_add_subregion(&pci_dev->bus_master_container_region, 0,
                                 &pci_dev->bus_master_enable_region);
diff --git a/memory.c b/memory.c
index 0651be49ac..29f8588945 100644
--- a/memory.c
+++ b/memory.c
@@ -231,6 +231,7 @@ struct FlatView {
     unsigned nr;
     unsigned nr_allocated;
     struct AddressSpaceDispatch *dispatch;
+    MemoryRegion *root;
 };
 
 typedef struct AddressSpaceOps AddressSpaceOps;
@@ -260,12 +261,14 @@ static bool flatrange_equal(FlatRange *a, FlatRange *b)
         && a->readonly == b->readonly;
 }
 
-static FlatView *flatview_alloc(void)
+static FlatView *flatview_alloc(MemoryRegion *mr_root)
 {
     FlatView *view;
 
     view = g_new0(FlatView, 1);
     view->ref = 1;
+    view->root = mr_root;
+    memory_region_ref(mr_root);
 
     return view;
 }
@@ -298,6 +301,7 @@ static void flatview_destroy(FlatView *view)
         memory_region_unref(view->ranges[i].mr);
     }
     g_free(view->ranges);
+    memory_region_unref(view->root);
     g_free(view);
 }
 
@@ -629,7 +633,7 @@ static AddressSpace *memory_region_to_address_space(MemoryRegion *mr)
         mr = mr->container;
     }
     QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-        if (mr == as->root) {
+        if (mr == as->current_map->root) {
             return as;
         }
     }
@@ -728,7 +732,7 @@ static FlatView *generate_memory_topology(MemoryRegion *mr)
 {
     FlatView *view;
 
-    view = flatview_alloc();
+    view = flatview_alloc(mr);
 
     if (mr) {
         render_memory_region(view, mr, int128_zero(),
@@ -952,7 +956,7 @@ static void flatview_render_new(FlatView *old_view, FlatView *new_view)
 static void address_space_update_topology(AddressSpace *as)
 {
     FlatView *old_view = address_space_get_flatview(as);
-    FlatView *new_view = generate_memory_topology(as->root);
+    FlatView *new_view = generate_memory_topology(old_view->root);
 
     flatview_render_new(old_view, new_view);
     address_space_update_topology_pass(as, old_view, new_view, false);
@@ -2680,12 +2684,10 @@ void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset,
 
 void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
 {
-    memory_region_ref(root);
     memory_region_transaction_begin();
     as->ref_count = 1;
-    as->root = root;
     as->malloced = false;
-    as->current_map = flatview_alloc();
+    as->current_map = flatview_alloc(root);
     as->ioeventfd_nb = 0;
     as->ioeventfds = NULL;
     QTAILQ_INIT(&as->listeners);
@@ -2695,6 +2697,11 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     memory_region_transaction_commit();
 }
 
+MemoryRegion *address_space_root(AddressSpace *as)
+{
+    return as->current_map->root;
+}
+
 static void do_address_space_destroy(AddressSpace *as)
 {
     bool do_free = as->malloced;
@@ -2704,7 +2711,6 @@ static void do_address_space_destroy(AddressSpace *as)
     flatview_unref(as->current_map);
     g_free(as->name);
     g_free(as->ioeventfds);
-    memory_region_unref(as->root);
     if (do_free) {
         g_free(as);
     }
@@ -2715,7 +2721,7 @@ AddressSpace *address_space_init_shareable(MemoryRegion *root, const char *name)
     AddressSpace *as;
 
     QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-        if (root == as->root && as->malloced) {
+        if (root == address_space_root(as) && as->malloced) {
             as->ref_count++;
             return as;
         }
@@ -2729,15 +2735,12 @@ AddressSpace *address_space_init_shareable(MemoryRegion *root, const char *name)
 
 void address_space_destroy(AddressSpace *as)
 {
-    MemoryRegion *root = as->root;
-
     as->ref_count--;
     if (as->ref_count) {
         return;
     }
     /* Flush out anything from MemoryListeners listening in on this */
     memory_region_transaction_begin();
-    as->root = NULL;
     memory_region_transaction_commit();
     QTAILQ_REMOVE(&address_spaces, as, address_spaces_link);
 
@@ -2745,7 +2748,6 @@ void address_space_destroy(AddressSpace *as)
      * entries that the guest should never use.  Wait for the old
      * values to expire before freeing the data.
      */
-    as->root = root;
     call_rcu(as, do_address_space_destroy, rcu);
 }
 
@@ -2934,7 +2936,7 @@ void mtree_info(fprintf_function mon_printf, void *f, bool flatview)
 
     QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
         mon_printf(f, "address-space: %s\n", as->name);
-        mtree_print_mr(mon_printf, f, as->root, 1, 0, &ml_head);
+        mtree_print_mr(mon_printf, f, address_space_root(as), 1, 0, &ml_head);
         mon_printf(f, "\n");
     }
 
-- 
2.11.0

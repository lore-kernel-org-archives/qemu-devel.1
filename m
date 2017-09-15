Received: from eggs.gnu.org ([2001:4830:134:3::10]:38269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dsmB9-00071e-Oo
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dsmB6-0002YM-Dw
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:40:51 -0400
Received: from ozlabs.ru ([107.173.13.209]:44668)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dsmB5-0002Ql-US
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:40:48 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri, 15 Sep 2017 18:40:28 +1000
Message-Id: <20170915084030.40988-12-aik@ozlabs.ru>
In-Reply-To: <20170915084030.40988-1-aik@ozlabs.ru>
References: <20170915084030.40988-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v2 11/13] memory: Share FlatView's and
 dispatch trees between address spaces
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

This allows sharing flat views between address spaces when the same root
memory region is used when creating a new address space.

This adds a global list of flat views and a list of attached address
spaces per a flat view. Each address space references a flat view.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/exec/memory.h |   3 +-
 memory.c              | 148 ++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 108 insertions(+), 43 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index be8cc1ccd3..04993f8eca 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -308,8 +308,6 @@ struct AddressSpace {
     /* All fields are private. */
     struct rcu_head rcu;
     char *name;
-    int ref_count;
-    bool malloced;
 
     /* Accessed via RCU.  */
     struct FlatView *current_map;
@@ -318,6 +316,7 @@ struct AddressSpace {
     struct MemoryRegionIoeventfd *ioeventfds;
     QTAILQ_HEAD(memory_listeners_as, MemoryListener) listeners;
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
+    QTAILQ_ENTRY(AddressSpace) flat_view_link;
 };
 
 FlatView *address_space_to_flatview(AddressSpace *as);
diff --git a/memory.c b/memory.c
index 29f8588945..f3da9379df 100644
--- a/memory.c
+++ b/memory.c
@@ -47,6 +47,9 @@ static QTAILQ_HEAD(memory_listeners, MemoryListener) memory_listeners
 static QTAILQ_HEAD(, AddressSpace) address_spaces
     = QTAILQ_HEAD_INITIALIZER(address_spaces);
 
+static QTAILQ_HEAD(FlatViewList, FlatView) flat_views
+    = QTAILQ_HEAD_INITIALIZER(flat_views);
+
 typedef struct AddrRange AddrRange;
 
 /*
@@ -232,6 +235,8 @@ struct FlatView {
     unsigned nr_allocated;
     struct AddressSpaceDispatch *dispatch;
     MemoryRegion *root;
+    QTAILQ_ENTRY(FlatView) flat_views_link;
+    QTAILQ_HEAD(address_spaces, AddressSpace) address_spaces;
 };
 
 typedef struct AddressSpaceOps AddressSpaceOps;
@@ -269,6 +274,7 @@ static FlatView *flatview_alloc(MemoryRegion *mr_root)
     view->ref = 1;
     view->root = mr_root;
     memory_region_ref(mr_root);
+    QTAILQ_INIT(&view->address_spaces);
 
     return view;
 }
@@ -953,28 +959,99 @@ static void flatview_render_new(FlatView *old_view, FlatView *new_view)
     address_space_dispatch_compact(new_view->dispatch);
 }
 
-static void address_space_update_topology(AddressSpace *as)
+static MemoryRegion *memory_region_unalias_entire(MemoryRegion *mr)
 {
-    FlatView *old_view = address_space_get_flatview(as);
-    FlatView *new_view = generate_memory_topology(old_view->root);
-
-    flatview_render_new(old_view, new_view);
-    address_space_update_topology_pass(as, old_view, new_view, false);
-    address_space_update_topology_pass(as, old_view, new_view, true);
-
-    /* Writes are protected by the BQL.  */
-    atomic_rcu_set(&as->current_map, new_view);
-    call_rcu(old_view, flatview_unref, rcu);
-
-    /* Note that all the old MemoryRegions are still alive up to this
-     * point.  This relieves most MemoryListeners from the need to
-     * ref/unref the MemoryRegions they get---unless they use them
-     * outside the iothread mutex, in which case precise reference
-     * counting is necessary.
-     */
-    flatview_unref(old_view);
-
-    address_space_update_ioeventfds(as);
+    while (mr->alias && !mr->alias_offset &&
+           int128_ge(mr->size, mr->alias->size)) {
+        /* The alias is included in its entirety.  Use it as
+         * the "real" root, so that we can share more FlatViews.
+         */
+        mr = mr->alias;
+    }
+
+    return mr;
+}
+
+static bool flatview_can_share(FlatView *old_view, FlatView *new_view)
+{
+    MemoryRegion *old_root = memory_region_unalias_entire(old_view->root);
+    MemoryRegion *new_root = memory_region_unalias_entire(new_view->root);
+
+    if (old_root == new_root) {
+        return true;
+    }
+
+    if (!old_root->enabled && !new_root->enabled) {
+        return true;
+    }
+
+    return false;
+}
+
+static void flatview_update_topology(void)
+{
+    AddressSpace *as, *asnext;
+    FlatView *old_view, *new_view, *vnext;
+    struct FlatViewList fvs_tmp = QTAILQ_HEAD_INITIALIZER(fvs_tmp);
+    bool found;
+
+    /* Build list of unique FlatViews, FV::root is the key */
+    QTAILQ_FOREACH(old_view, &flat_views, flat_views_link) {
+        found = false;
+        QTAILQ_FOREACH(new_view, &fvs_tmp, flat_views_link) {
+            if (flatview_can_share(old_view, new_view)) {
+                found = true;
+                break;
+            }
+        }
+        if (found) {
+            continue;
+        }
+
+        new_view = generate_memory_topology(old_view->root);
+        flatview_render_new(old_view, new_view);
+        QTAILQ_INSERT_TAIL(&fvs_tmp, new_view, flat_views_link);
+    }
+
+    /* Replace old FVs with new ones */
+    QTAILQ_FOREACH_SAFE(old_view, &flat_views, flat_views_link, vnext) {
+        flatview_ref(old_view);
+
+        found = false;
+        QTAILQ_FOREACH(new_view, &fvs_tmp, flat_views_link) {
+            if (flatview_can_share(old_view, new_view)) {
+                found = true;
+                break;
+            }
+        }
+        assert(found);
+
+        QTAILQ_FOREACH_SAFE(as, &old_view->address_spaces, flat_view_link,
+                            asnext) {
+            address_space_update_topology_pass(as, old_view, new_view, false);
+            address_space_update_topology_pass(as, old_view, new_view, true);
+
+            QTAILQ_REMOVE(&old_view->address_spaces, as, flat_view_link);
+            flatview_unref(old_view);
+
+            atomic_rcu_set(&as->current_map, new_view);
+
+            flatview_ref(new_view);
+            QTAILQ_INSERT_TAIL(&new_view->address_spaces, as, flat_view_link);
+        }
+
+        QTAILQ_REMOVE(&flat_views, old_view, flat_views_link);
+
+        flatview_unref(old_view); /* unref from beginning of the scope */
+    }
+
+    /* Copy new FVs to the global list */
+    QTAILQ_FOREACH_SAFE(new_view, &fvs_tmp, flat_views_link, vnext) {
+        QTAILQ_REMOVE(&fvs_tmp, new_view, flat_views_link);
+        flatview_unref(new_view);
+
+        QTAILQ_INSERT_HEAD(&flat_views, new_view, flat_views_link);
+    }
 }
 
 void memory_region_transaction_begin(void)
@@ -994,9 +1071,10 @@ void memory_region_transaction_commit(void)
     if (!memory_region_transaction_depth) {
         if (memory_region_update_pending) {
             MEMORY_LISTENER_CALL_GLOBAL(begin, Forward);
+            flatview_update_topology();
 
             QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-                address_space_update_topology(as);
+                address_space_update_ioeventfds(as);
             }
             memory_region_update_pending = false;
             MEMORY_LISTENER_CALL_GLOBAL(commit, Forward);
@@ -2685,8 +2763,6 @@ void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset,
 void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
 {
     memory_region_transaction_begin();
-    as->ref_count = 1;
-    as->malloced = false;
     as->current_map = flatview_alloc(root);
     as->ioeventfd_nb = 0;
     as->ioeventfds = NULL;
@@ -2694,6 +2770,8 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
     as->name = g_strdup(name ? name : "anonymous");
     memory_region_update_pending |= root->enabled;
+    QTAILQ_INSERT_TAIL(&flat_views, as->current_map, flat_views_link);
+    QTAILQ_INSERT_TAIL(&as->current_map->address_spaces, as, flat_view_link);
     memory_region_transaction_commit();
 }
 
@@ -2704,41 +2782,29 @@ MemoryRegion *address_space_root(AddressSpace *as)
 
 static void do_address_space_destroy(AddressSpace *as)
 {
-    bool do_free = as->malloced;
-
     assert(QTAILQ_EMPTY(&as->listeners));
 
+    QTAILQ_REMOVE(&as->current_map->address_spaces, as, flat_view_link);
+
     flatview_unref(as->current_map);
+
     g_free(as->name);
     g_free(as->ioeventfds);
-    if (do_free) {
-        g_free(as);
-    }
+    g_free(as);
 }
 
 AddressSpace *address_space_init_shareable(MemoryRegion *root, const char *name)
 {
     AddressSpace *as;
 
-    QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-        if (root == address_space_root(as) && as->malloced) {
-            as->ref_count++;
-            return as;
-        }
-    }
-
     as = g_malloc0(sizeof *as);
     address_space_init(as, root, name);
-    as->malloced = true;
+
     return as;
 }
 
 void address_space_destroy(AddressSpace *as)
 {
-    as->ref_count--;
-    if (as->ref_count) {
-        return;
-    }
     /* Flush out anything from MemoryListeners listening in on this */
     memory_region_transaction_begin();
     memory_region_transaction_commit();
-- 
2.11.0

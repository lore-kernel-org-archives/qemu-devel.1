Received: from eggs.gnu.org ([2001:4830:134:3::10]:42055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dtt7L-0005ly-SK
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dtt7K-0004HC-KL
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:17:31 -0400
Received: from ozlabs.ru ([107.173.13.209]:35254)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dtt7K-0004Dh-CV
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:17:30 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 18 Sep 2017 20:17:07 +1000
Message-Id: <20170918101709.30421-12-aik@ozlabs.ru>
In-Reply-To: <20170918101709.30421-1-aik@ozlabs.ru>
References: <20170918101709.30421-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v3 11/13] memory: Share FlatView's and
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

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v3:
* got rid of global and per-AS lists of FlatView objects
---


I could also make all empty FlatViews (view->nr==0 but they are still
enabled) resolve to an empty FlatView but not sure it is worth it as
in real life all devices and therefore FlatViews are expected not to be
empty.


---
 memory.c | 92 ++++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 58 insertions(+), 34 deletions(-)

diff --git a/memory.c b/memory.c
index e18ef53cc2..6fca8bf932 100644
--- a/memory.c
+++ b/memory.c
@@ -917,36 +917,66 @@ static void address_space_update_topology_pass(AddressSpace *as,
     }
 }
 
-static void address_space_update_topology(AddressSpace *as)
+static gboolean flatview_unref_g_hash(gpointer key, gpointer value,
+                                      gpointer user_data)
+{
+    flatview_unref((FlatView *) value);
+    return true;
+}
+
+static void flatview_update_topology(void)
 {
-    FlatView *old_view = address_space_get_flatview(as);
-    MemoryRegion *physmr = memory_region_unalias_entire(old_view->root);
-    FlatView *new_view = generate_memory_topology(physmr);
     int i;
+    AddressSpace *as;
+    FlatView *old_view, *new_view;
+    GHashTable *views = g_hash_table_new(g_direct_hash, g_direct_equal);
+    MemoryRegion *physmr;
+    gpointer key;
 
-    new_view->dispatch = address_space_dispatch_new(new_view);
-    for (i = 0; i < new_view->nr; i++) {
-        MemoryRegionSection mrs =
-            section_from_flat_range(&new_view->ranges[i], new_view);
-        flatview_add_to_dispatch(new_view, &mrs);
+    /* Render unique FVs */
+    QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
+        old_view = as->current_map;
+        physmr = memory_region_unalias_entire(old_view->root);
+
+        key = !physmr->enabled ? 0 : physmr;
+        new_view = (FlatView *) g_hash_table_lookup(views, key);
+        if (new_view) {
+            continue;
+        }
+
+        new_view = generate_memory_topology(physmr);
+
+        new_view->dispatch = address_space_dispatch_new(new_view);
+        for (i = 0; i < new_view->nr; i++) {
+            MemoryRegionSection mrs =
+                section_from_flat_range(&new_view->ranges[i], new_view);
+            flatview_add_to_dispatch(new_view, &mrs);
+        }
+        address_space_dispatch_compact(new_view->dispatch);
+
+        g_hash_table_insert(views, key, new_view);
+    }
+
+    /* Replace FVs in ASes */
+    QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
+        old_view = as->current_map;
+        physmr = memory_region_unalias_entire(old_view->root);
+
+        key = !physmr->enabled ? 0 : physmr;
+        new_view = (FlatView *) g_hash_table_lookup(views, key);
+        assert(new_view);
+
+        address_space_update_topology_pass(as, old_view, new_view, false);
+        address_space_update_topology_pass(as, old_view, new_view, true);
+
+        flatview_ref(new_view);
+        atomic_rcu_set(&as->current_map, new_view);
+        flatview_unref(old_view);
     }
-    address_space_dispatch_compact(new_view->dispatch);
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
+
+    /* Unref FVs from temporary table */
+    g_hash_table_foreach_remove(views, flatview_unref_g_hash, 0);
+    g_hash_table_unref(views);
 }
 
 void memory_region_transaction_begin(void)
@@ -966,9 +996,10 @@ void memory_region_transaction_commit(void)
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
@@ -2690,13 +2721,6 @@ AddressSpace *address_space_init_shareable(MemoryRegion *root, const char *name)
 {
     AddressSpace *as;
 
-    QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-        if (root == as->root && as->malloced) {
-            as->ref_count++;
-            return as;
-        }
-    }
-
     as = g_malloc0(sizeof *as);
     address_space_init(as, root, name);
     as->malloced = true;
-- 
2.11.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCq-00056N-0U
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCo-0001J9-T9
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:36 -0400
Received: from ozlabs.ru ([107.173.13.209]:54112)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCo-0001CA-KH
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:34 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 21 Sep 2017 18:51:04 +1000
Message-Id: <20170921085110.25598-13-aik@ozlabs.ru>
In-Reply-To: <20170921085110.25598-1-aik@ozlabs.ru>
References: <20170921085110.25598-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v5 12/18] memory: Share FlatView's and
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

This allows sharing flat views between address spaces (AS) when
the same root memory region is used when creating a new address space.
This is done by walking through all ASes and caching one FlatView per
a physical root MR (i.e. not aliased).

This removes search for duplicates from address_space_init_shareable() as
FlatViews are shared elsewhere and keeping as::ref_count correct seems
an unnecessary and useless complication.

This should cause no change and memory use or boot time yet.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v5:
* s/flatview_set_to_address_space/address_space_set_flatview/g
* generate_memory_topology() does g_hash_table_replace() as well

v4:
* used g_hash_table_new_full() instead of g_hash_table_new() +
g_hash_table_foreach_remove()
* cached last hash table of FV globally

v3:
* got rid of global and per-AS lists of FlatView objects
---
 memory.c | 56 +++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/memory.c b/memory.c
index 9868d0f57c..56b3dd47ab 100644
--- a/memory.c
+++ b/memory.c
@@ -47,6 +47,8 @@ static QTAILQ_HEAD(memory_listeners, MemoryListener) memory_listeners
 static QTAILQ_HEAD(, AddressSpace) address_spaces
     = QTAILQ_HEAD_INITIALIZER(address_spaces);
 
+static GHashTable *flat_views;
+
 typedef struct AddrRange AddrRange;
 
 /*
@@ -760,6 +762,7 @@ static FlatView *generate_memory_topology(MemoryRegion *mr)
         flatview_add_to_dispatch(view, &mrs);
     }
     address_space_dispatch_compact(view->dispatch);
+    g_hash_table_replace(flat_views, mr, view);
 
     return view;
 }
@@ -925,11 +928,47 @@ static void address_space_update_topology_pass(AddressSpace *as,
     }
 }
 
-static void address_space_update_topology(AddressSpace *as)
+static void flatviews_init(void)
+{
+    if (flat_views) {
+        return;
+    }
+
+    flat_views = g_hash_table_new_full(g_direct_hash, g_direct_equal, NULL,
+                                       (GDestroyNotify) flatview_unref);
+}
+
+static void flatviews_reset(void)
+{
+    AddressSpace *as;
+
+    if (flat_views) {
+        g_hash_table_unref(flat_views);
+        flat_views = NULL;
+    }
+    flatviews_init();
+
+    /* Render unique FVs */
+    QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
+        MemoryRegion *physmr = memory_region_get_flatview_root(as->root);
+
+        if (g_hash_table_lookup(flat_views, physmr)) {
+            continue;
+        }
+
+        generate_memory_topology(physmr);
+    }
+}
+
+static void address_space_set_flatview(AddressSpace *as)
 {
     FlatView *old_view = address_space_get_flatview(as);
-    MemoryRegion *physmr = memory_region_get_flatview_root(old_view->root);
-    FlatView *new_view = generate_memory_topology(physmr);
+    MemoryRegion *physmr = memory_region_get_flatview_root(as->root);
+    FlatView *new_view = g_hash_table_lookup(flat_views, physmr);
+
+    assert(new_view);
+
+    flatview_ref(new_view);
 
     if (!QTAILQ_EMPTY(&as->listeners)) {
         address_space_update_topology_pass(as, old_view, new_view, false);
@@ -965,10 +1004,12 @@ void memory_region_transaction_commit(void)
     --memory_region_transaction_depth;
     if (!memory_region_transaction_depth) {
         if (memory_region_update_pending) {
+            flatviews_reset();
+
             MEMORY_LISTENER_CALL_GLOBAL(begin, Forward);
 
             QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-                address_space_update_topology(as);
+                address_space_set_flatview(as);
                 address_space_update_ioeventfds(as);
             }
             memory_region_update_pending = false;
@@ -2691,13 +2732,6 @@ AddressSpace *address_space_init_shareable(MemoryRegion *root, const char *name)
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

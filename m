Received: from eggs.gnu.org ([2001:4830:134:3::10]:56356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmG-0003O4-Mb
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmD-00057G-6X
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:00 -0400
Received: from ozlabs.ru ([107.173.13.209]:59738)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmC-00056v-Ue
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:14:57 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 20 Sep 2017 21:46:31 +1000
Message-Id: <20170920114637.42004-13-aik@ozlabs.ru>
In-Reply-To: <20170920114637.42004-1-aik@ozlabs.ru>
References: <20170920114637.42004-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v4 12/18] memory: Share FlatView's and
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
v4:
* used g_hash_table_new_full() instead of g_hash_table_new() +
g_hash_table_foreach_remove()
* cached last hash table of FV globally

v3:
* got rid of global and per-AS lists of FlatView objects
---
 memory.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/memory.c b/memory.c
index 9868d0f57c..1083fe9130 100644
--- a/memory.c
+++ b/memory.c
@@ -47,6 +47,8 @@ static QTAILQ_HEAD(memory_listeners, MemoryListener) memory_listeners
 static QTAILQ_HEAD(, AddressSpace) address_spaces
     = QTAILQ_HEAD_INITIALIZER(address_spaces);
 
+static GHashTable *flat_views;
+
 typedef struct AddrRange AddrRange;
 
 /*
@@ -925,11 +927,49 @@ static void address_space_update_topology_pass(AddressSpace *as,
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
+        FlatView *new_view = g_hash_table_lookup(flat_views, physmr);
+
+        if (new_view) {
+            continue;
+        }
+
+        new_view = generate_memory_topology(physmr);
+        g_hash_table_insert(flat_views, physmr, new_view);
+    }
+}
+
+static void flatview_set_to_address_space(AddressSpace *as)
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
@@ -965,10 +1005,12 @@ void memory_region_transaction_commit(void)
     --memory_region_transaction_depth;
     if (!memory_region_transaction_depth) {
         if (memory_region_update_pending) {
+            flatviews_reset();
+
             MEMORY_LISTENER_CALL_GLOBAL(begin, Forward);
 
             QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-                address_space_update_topology(as);
+                flatview_set_to_address_space(as);
                 address_space_update_ioeventfds(as);
             }
             memory_region_update_pending = false;
@@ -2691,13 +2733,6 @@ AddressSpace *address_space_init_shareable(MemoryRegion *root, const char *name)
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

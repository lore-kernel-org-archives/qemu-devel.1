Received: from eggs.gnu.org ([2001:4830:134:3::10]:48372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCf-0004zH-BL
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCd-0001CK-TR
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:25 -0400
Received: from ozlabs.ru ([107.173.13.209]:54112)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCd-0001CA-Kn
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:23 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 21 Sep 2017 18:50:54 +1000
Message-Id: <20170921085110.25598-3-aik@ozlabs.ru>
In-Reply-To: <20170921085110.25598-1-aik@ozlabs.ru>
References: <20170921085110.25598-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v5 02/18] memory: Open code FlatView
 rendering
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

We are going to share FlatView's between AddressSpace's and per-AS
memory listeners won't suit the purpose anymore so open code
the dispatch tree rendering.

Since there is a good chance that dispatch_listener was the only
listener, this avoids address_space_update_topology_pass() if there is
no registered listeners; this should improve starting time.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v4:
* address_space_update_topology_pass() is called now under
if (!QTAILQ_EMPTY(&as->listeners))

v3:
* inlined & simplified address_space_update_flatview
---
 include/exec/memory-internal.h |  6 ++++--
 include/exec/memory.h          |  1 -
 exec.c                         | 27 +++------------------------
 memory.c                       | 19 ++++++++++++++-----
 4 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index fb467acdba..9abde2f11c 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -22,8 +22,6 @@
 #ifndef CONFIG_USER_ONLY
 typedef struct AddressSpaceDispatch AddressSpaceDispatch;
 
-void address_space_init_dispatch(AddressSpace *as);
-void address_space_unregister(AddressSpace *as);
 void address_space_destroy_dispatch(AddressSpace *as);
 
 extern const MemoryRegionOps unassigned_mem_ops;
@@ -31,5 +29,9 @@ extern const MemoryRegionOps unassigned_mem_ops;
 bool memory_region_access_valid(MemoryRegion *mr, hwaddr addr,
                                 unsigned size, bool is_write);
 
+void mem_add(AddressSpace *as, MemoryRegionSection *section);
+void mem_begin(AddressSpace *as);
+void mem_commit(AddressSpace *as);
+
 #endif
 #endif
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 1dcd3122d7..9581f7a7db 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -318,7 +318,6 @@ struct AddressSpace {
     struct MemoryRegionIoeventfd *ioeventfds;
     struct AddressSpaceDispatch *dispatch;
     struct AddressSpaceDispatch *next_dispatch;
-    MemoryListener dispatch_listener;
     QTAILQ_HEAD(memory_listeners_as, MemoryListener) listeners;
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
 };
diff --git a/exec.c b/exec.c
index fd8994b25d..1626d254bb 100644
--- a/exec.c
+++ b/exec.c
@@ -1347,9 +1347,8 @@ static void register_multipage(AddressSpaceDispatch *d,
     phys_page_set(d, start_addr >> TARGET_PAGE_BITS, num_pages, section_index);
 }
 
-static void mem_add(MemoryListener *listener, MemoryRegionSection *section)
+void mem_add(AddressSpace *as, MemoryRegionSection *section)
 {
-    AddressSpace *as = container_of(listener, AddressSpace, dispatch_listener);
     AddressSpaceDispatch *d = as->next_dispatch;
     MemoryRegionSection now = *section, remain = *section;
     Int128 page_size = int128_make64(TARGET_PAGE_SIZE);
@@ -2673,9 +2672,8 @@ static void io_mem_init(void)
                           NULL, UINT64_MAX);
 }
 
-static void mem_begin(MemoryListener *listener)
+void mem_begin(AddressSpace *as)
 {
-    AddressSpace *as = container_of(listener, AddressSpace, dispatch_listener);
     AddressSpaceDispatch *d = g_new0(AddressSpaceDispatch, 1);
     uint16_t n;
 
@@ -2699,9 +2697,8 @@ static void address_space_dispatch_free(AddressSpaceDispatch *d)
     g_free(d);
 }
 
-static void mem_commit(MemoryListener *listener)
+void mem_commit(AddressSpace *as)
 {
-    AddressSpace *as = container_of(listener, AddressSpace, dispatch_listener);
     AddressSpaceDispatch *cur = as->dispatch;
     AddressSpaceDispatch *next = as->next_dispatch;
 
@@ -2731,24 +2728,6 @@ static void tcg_commit(MemoryListener *listener)
     tlb_flush(cpuas->cpu);
 }
 
-void address_space_init_dispatch(AddressSpace *as)
-{
-    as->dispatch = NULL;
-    as->dispatch_listener = (MemoryListener) {
-        .begin = mem_begin,
-        .commit = mem_commit,
-        .region_add = mem_add,
-        .region_nop = mem_add,
-        .priority = 0,
-    };
-    memory_listener_register(&as->dispatch_listener, as);
-}
-
-void address_space_unregister(AddressSpace *as)
-{
-    memory_listener_unregister(&as->dispatch_listener);
-}
-
 void address_space_destroy_dispatch(AddressSpace *as)
 {
     AddressSpaceDispatch *d = as->dispatch;
diff --git a/memory.c b/memory.c
index b9920a6540..101d5f4d60 100644
--- a/memory.c
+++ b/memory.c
@@ -879,14 +879,24 @@ static void address_space_update_topology_pass(AddressSpace *as,
     }
 }
 
-
 static void address_space_update_topology(AddressSpace *as)
 {
     FlatView *old_view = address_space_get_flatview(as);
     FlatView *new_view = generate_memory_topology(as->root);
+    int i;
 
-    address_space_update_topology_pass(as, old_view, new_view, false);
-    address_space_update_topology_pass(as, old_view, new_view, true);
+    mem_begin(as);
+    for (i = 0; i < new_view->nr; i++) {
+        MemoryRegionSection mrs =
+            section_from_flat_range(&new_view->ranges[i], as);
+        mem_add(as, &mrs);
+    }
+    mem_commit(as);
+
+    if (!QTAILQ_EMPTY(&as->listeners)) {
+        address_space_update_topology_pass(as, old_view, new_view, false);
+        address_space_update_topology_pass(as, old_view, new_view, true);
+    }
 
     /* Writes are protected by the BQL.  */
     atomic_rcu_set(&as->current_map, new_view);
@@ -2621,7 +2631,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     QTAILQ_INIT(&as->listeners);
     QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
     as->name = g_strdup(name ? name : "anonymous");
-    address_space_init_dispatch(as);
+    as->dispatch = NULL;
     memory_region_update_pending |= root->enabled;
     memory_region_transaction_commit();
 }
@@ -2672,7 +2682,6 @@ void address_space_destroy(AddressSpace *as)
     as->root = NULL;
     memory_region_transaction_commit();
     QTAILQ_REMOVE(&address_spaces, as, address_spaces_link);
-    address_space_unregister(as);
 
     /* At this point, as->dispatch and as->current_map are dummy
      * entries that the guest should never use.  Wait for the old
-- 
2.11.0

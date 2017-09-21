Received: from eggs.gnu.org ([2001:4830:134:3::10]:37223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiF-0004bj-CR
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiD-00041d-Vo
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:55 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:37505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAiD-0003zz-Lc
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:53 -0400
Received: by mail-wr0-x243.google.com with SMTP id u48so3840845wrf.4
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:16:53 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:15 +0200
Message-Id: <1506035800-30509-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/32] memory: Open code FlatView rendering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

We are going to share FlatView's between AddressSpace's and per-AS
memory listeners won't suit the purpose anymore so open code
the dispatch tree rendering.

Since there is a good chance that dispatch_listener was the only
listener, this avoids address_space_update_topology_pass() if there is
no registered listeners; this should improve starting time.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-3-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c                         | 27 +++------------------------
 include/exec/memory-internal.h |  6 ++++--
 include/exec/memory.h          |  1 -
 memory.c                       | 19 ++++++++++++++-----
 4 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/exec.c b/exec.c
index fd8994b..1626d25 100644
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
diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index fb467ac..9abde2f 100644
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
index 1dcd312..9581f7a 100644
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
diff --git a/memory.c b/memory.c
index 51f54ab..3241e44 100644
--- a/memory.c
+++ b/memory.c
@@ -884,14 +884,24 @@ static void address_space_update_topology_pass(AddressSpace *as,
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
@@ -2626,7 +2636,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     QTAILQ_INIT(&as->listeners);
     QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
     as->name = g_strdup(name ? name : "anonymous");
-    address_space_init_dispatch(as);
+    as->dispatch = NULL;
     memory_region_update_pending |= root->enabled;
     memory_region_transaction_commit();
 }
@@ -2677,7 +2687,6 @@ void address_space_destroy(AddressSpace *as)
     as->root = NULL;
     memory_region_transaction_commit();
     QTAILQ_REMOVE(&address_spaces, as, address_spaces_link);
-    address_space_unregister(as);
 
     /* At this point, as->dispatch and as->current_map are dummy
      * entries that the guest should never use.  Wait for the old
-- 
1.8.3.1

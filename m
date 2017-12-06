Received: from eggs.gnu.org ([2001:4830:134:3::10]:50290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCx-0001Gm-2Y
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCu-0001IY-Ce
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCu-0001Gp-2o
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:12 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JFGVp016849
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:18:11 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epm4275ah-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:18:10 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:18:08 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:00 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-8-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 07/55] memory: Open code FlatView rendering
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
(cherry picked from commit 9a62e24f45bc97f8eaf198caf58906b47c50a8d5)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 exec.c                         | 27 +++------------------------
 include/exec/memory-internal.h |  6 ++++--
 include/exec/memory.h          |  1 -
 memory.c                       | 19 ++++++++++++++-----
 4 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/exec.c b/exec.c
index bd94248390..3ed3718dea 100644
--- a/exec.c
+++ b/exec.c
@@ -1348,9 +1348,8 @@ static void register_multipage(AddressSpaceDispatch *d,
     phys_page_set(d, start_addr >> TARGET_PAGE_BITS, num_pages, section_index);
 }
 
-static void mem_add(MemoryListener *listener, MemoryRegionSection *section)
+void mem_add(AddressSpace *as, MemoryRegionSection *section)
 {
-    AddressSpace *as = container_of(listener, AddressSpace, dispatch_listener);
     AddressSpaceDispatch *d = as->next_dispatch;
     MemoryRegionSection now = *section, remain = *section;
     Int128 page_size = int128_make64(TARGET_PAGE_SIZE);
@@ -2674,9 +2673,8 @@ static void io_mem_init(void)
                           NULL, UINT64_MAX);
 }
 
-static void mem_begin(MemoryListener *listener)
+void mem_begin(AddressSpace *as)
 {
-    AddressSpace *as = container_of(listener, AddressSpace, dispatch_listener);
     AddressSpaceDispatch *d = g_new0(AddressSpaceDispatch, 1);
     uint16_t n;
 
@@ -2700,9 +2698,8 @@ static void address_space_dispatch_free(AddressSpaceDispatch *d)
     g_free(d);
 }
 
-static void mem_commit(MemoryListener *listener)
+void mem_commit(AddressSpace *as)
 {
-    AddressSpace *as = container_of(listener, AddressSpace, dispatch_listener);
     AddressSpaceDispatch *cur = as->dispatch;
     AddressSpaceDispatch *next = as->next_dispatch;
 
@@ -2732,24 +2729,6 @@ static void tcg_commit(MemoryListener *listener)
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
index 400dd4491b..9ee0f2e846 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -328,7 +328,6 @@ struct AddressSpace {
     struct MemoryRegionIoeventfd *ioeventfds;
     struct AddressSpaceDispatch *dispatch;
     struct AddressSpaceDispatch *next_dispatch;
-    MemoryListener dispatch_listener;
     QTAILQ_HEAD(memory_listeners_as, MemoryListener) listeners;
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
 };
diff --git a/memory.c b/memory.c
index c0adc35410..138e21d35d 100644
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

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiM-0004j4-D6
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiL-0004Dw-D1
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:02 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAiL-0004Cc-6n
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:01 -0400
Received: by mail-wm0-x243.google.com with SMTP id r136so6437096wmf.3
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:17:01 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:21 +0200
Message-Id: <1506035800-30509-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 13/32] memory: Rename
 mem_begin/mem_commit/mem_add helpers
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

This renames some helpers to reflect better what they do.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-9-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c                         | 12 +++---------
 include/exec/memory-internal.h |  6 +++---
 memory.c                       |  6 +++---
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/exec.c b/exec.c
index 548ec71..b085f82 100644
--- a/exec.c
+++ b/exec.c
@@ -358,7 +358,7 @@ static void phys_page_compact(PhysPageEntry *lp, Node *nodes)
     }
 }
 
-static void phys_page_compact_all(AddressSpaceDispatch *d, int nodes_nb)
+void address_space_dispatch_compact(AddressSpaceDispatch *d)
 {
     if (d->phys_map.skip) {
         phys_page_compact(&d->phys_map, d->map.nodes);
@@ -1346,7 +1346,7 @@ static void register_multipage(FlatView *fv,
     phys_page_set(d, start_addr >> TARGET_PAGE_BITS, num_pages, section_index);
 }
 
-void mem_add(FlatView *fv, MemoryRegionSection *section)
+void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section)
 {
     MemoryRegionSection now = *section, remain = *section;
     Int128 page_size = int128_make64(TARGET_PAGE_SIZE);
@@ -2672,9 +2672,8 @@ static void io_mem_init(void)
                           NULL, UINT64_MAX);
 }
 
-AddressSpaceDispatch *mem_begin(AddressSpace *as)
+AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv)
 {
-    FlatView *fv = address_space_to_flatview(as);
     AddressSpaceDispatch *d = g_new0(AddressSpaceDispatch, 1);
     uint16_t n;
 
@@ -2698,11 +2697,6 @@ void address_space_dispatch_free(AddressSpaceDispatch *d)
     g_free(d);
 }
 
-void mem_commit(AddressSpaceDispatch *d)
-{
-    phys_page_compact_all(d, d->map.nodes_nb);
-}
-
 static void tcg_commit(MemoryListener *listener)
 {
     CPUAddressSpace *cpuas;
diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index 1cf8ad9..d4a35c6 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -27,9 +27,9 @@ extern const MemoryRegionOps unassigned_mem_ops;
 bool memory_region_access_valid(MemoryRegion *mr, hwaddr addr,
                                 unsigned size, bool is_write);
 
-void mem_add(FlatView *fv, MemoryRegionSection *section);
-AddressSpaceDispatch *mem_begin(AddressSpace *as);
-void mem_commit(AddressSpaceDispatch *d);
+void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section);
+AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv);
+void address_space_dispatch_compact(AddressSpaceDispatch *d);
 
 AddressSpaceDispatch *address_space_to_dispatch(AddressSpace *as);
 AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv);
diff --git a/memory.c b/memory.c
index bf3728a..c374317 100644
--- a/memory.c
+++ b/memory.c
@@ -910,13 +910,13 @@ static void address_space_update_topology(AddressSpace *as)
     FlatView *new_view = generate_memory_topology(as->root);
     int i;
 
-    new_view->dispatch = mem_begin(as);
+    new_view->dispatch = address_space_dispatch_new(new_view);
     for (i = 0; i < new_view->nr; i++) {
         MemoryRegionSection mrs =
             section_from_flat_range(&new_view->ranges[i], new_view);
-        mem_add(new_view, &mrs);
+        flatview_add_to_dispatch(new_view, &mrs);
     }
-    mem_commit(new_view->dispatch);
+    address_space_dispatch_compact(new_view->dispatch);
 
     if (!QTAILQ_EMPTY(&as->listeners)) {
         address_space_update_topology_pass(as, old_view, new_view, false);
-- 
1.8.3.1

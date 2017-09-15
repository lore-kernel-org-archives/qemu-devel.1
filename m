Received: from eggs.gnu.org ([2001:4830:134:3::10]:38203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dsmB5-0006xU-6F
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dsmB4-0002WM-10
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:40:47 -0400
Received: from ozlabs.ru ([107.173.13.209]:44668)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dsmB3-0002Ql-NT
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:40:45 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri, 15 Sep 2017 18:40:26 +1000
Message-Id: <20170915084030.40988-10-aik@ozlabs.ru>
In-Reply-To: <20170915084030.40988-1-aik@ozlabs.ru>
References: <20170915084030.40988-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v2 09/13] memory: Rename
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>

This renames some helper to reflect better what they do.

This drops AS in address_space_update_flatview() as it is not used anymore
and renames to flatview_render_new().

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/exec/memory-internal.h |  6 +++---
 exec.c                         |  7 +++----
 memory.c                       | 14 ++++++--------
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index c8a5522510..e87a30fcae 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -28,9 +28,9 @@ extern const MemoryRegionOps unassigned_mem_ops;
 bool memory_region_access_valid(MemoryRegion *mr, hwaddr addr,
                                 unsigned size, bool is_write);
 
-void mem_add(FlatView *fv, MemoryRegionSection *section);
-AddressSpaceDispatch *mem_begin(AddressSpace *as);
-void mem_commit(AddressSpaceDispatch *d);
+void flatview_mem_add(FlatView *fv, MemoryRegionSection *section);
+AddressSpaceDispatch *address_space_dispatch_alloc(FlatView *fv);
+void address_space_dispatch_compact(AddressSpaceDispatch *d);
 
 AddressSpaceDispatch *address_space_to_dispatch(AddressSpace *as);
 AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv);
diff --git a/exec.c b/exec.c
index 3e02b82c05..11e0e3c927 100644
--- a/exec.c
+++ b/exec.c
@@ -1347,7 +1347,7 @@ static void register_multipage(FlatView *fv,
     phys_page_set(d, start_addr >> TARGET_PAGE_BITS, num_pages, section_index);
 }
 
-void mem_add(FlatView *fv, MemoryRegionSection *section)
+void flatview_mem_add(FlatView *fv, MemoryRegionSection *section)
 {
     MemoryRegionSection now = *section, remain = *section;
     Int128 page_size = int128_make64(TARGET_PAGE_SIZE);
@@ -2673,9 +2673,8 @@ static void io_mem_init(void)
                           NULL, UINT64_MAX);
 }
 
-AddressSpaceDispatch *mem_begin(AddressSpace *as)
+AddressSpaceDispatch *address_space_dispatch_alloc(FlatView *fv)
 {
-    FlatView *fv = address_space_to_flatview(as);
     AddressSpaceDispatch *d = g_new0(AddressSpaceDispatch, 1);
     uint16_t n;
 
@@ -2699,7 +2698,7 @@ void address_space_dispatch_free(AddressSpaceDispatch *d)
     g_free(d);
 }
 
-void mem_commit(AddressSpaceDispatch *d)
+void address_space_dispatch_compact(AddressSpaceDispatch *d)
 {
     phys_page_compact_all(d, d->map.nodes_nb);
 }
diff --git a/memory.c b/memory.c
index 0f51445d30..0651be49ac 100644
--- a/memory.c
+++ b/memory.c
@@ -900,14 +900,12 @@ static void address_space_update_topology_pass(AddressSpace *as,
     }
 }
 
-static void address_space_update_flatview(AddressSpace *as,
-                                          FlatView *old_view,
-                                          FlatView *new_view)
+static void flatview_render_new(FlatView *old_view, FlatView *new_view)
 {
     unsigned iold, inew;
     FlatRange *frold, *frnew;
 
-    new_view->dispatch = mem_begin(as);
+    new_view->dispatch = address_space_dispatch_alloc(new_view);
     /*
      * FIXME: this is cut-n-paste from address_space_update_topology_pass,
      * simplify it
@@ -935,7 +933,7 @@ static void address_space_update_flatview(AddressSpace *as,
             /* In both and unchanged (except logging may have changed) */
             MemoryRegionSection mrs = section_from_flat_range(frnew, new_view);
 
-            mem_add(new_view, &mrs);
+            flatview_mem_add(new_view, &mrs);
 
             ++iold;
             ++inew;
@@ -943,12 +941,12 @@ static void address_space_update_flatview(AddressSpace *as,
             /* In new */
             MemoryRegionSection mrs = section_from_flat_range(frnew, new_view);
 
-            mem_add(new_view, &mrs);
+            flatview_mem_add(new_view, &mrs);
 
             ++inew;
         }
     }
-    mem_commit(new_view->dispatch);
+    address_space_dispatch_compact(new_view->dispatch);
 }
 
 static void address_space_update_topology(AddressSpace *as)
@@ -956,7 +954,7 @@ static void address_space_update_topology(AddressSpace *as)
     FlatView *old_view = address_space_get_flatview(as);
     FlatView *new_view = generate_memory_topology(as->root);
 
-    address_space_update_flatview(as, old_view, new_view);
+    flatview_render_new(old_view, new_view);
     address_space_update_topology_pass(as, old_view, new_view, false);
     address_space_update_topology_pass(as, old_view, new_view, true);
 
-- 
2.11.0

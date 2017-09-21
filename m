Received: from eggs.gnu.org ([2001:4830:134:3::10]:48549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCt-00057y-B6
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCs-0001MO-Ai
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:39 -0400
Received: from ozlabs.ru ([107.173.13.209]:54112)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCs-0001CA-4C
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:38 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 21 Sep 2017 18:51:07 +1000
Message-Id: <20170921085110.25598-16-aik@ozlabs.ru>
In-Reply-To: <20170921085110.25598-1-aik@ozlabs.ru>
References: <20170921085110.25598-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v5 15/18] memory: Share special empty
 FlatView
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

This shares an cached empty FlatView among address spaces. The empty
FV is used every time when a root MR renders into a FV without memory
sections which happens when MR or its children are not enabled or
zero-sized. The empty_view is not NULL to keep the rest of memory
API intact; it also has a dispatch tree for the same reason.

On POWER8 with 255 CPUs, 255 virtio-net, 40 PCI bridges guest this halves
the amount of FlatView's in use (557 -> 260) and dispatch tables
(~800000 -> ~370000), however the total memory footprint is pretty much
the same as RCU is holding all these temporary FVs which are created
(and then released) to make sure that they are empty and can be replaced
with @empty_view.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v5:
* generate_memory_topology() now destroys temporary FV directly as
it is not in use anyway
* check for mr->enabled and avoid even temporaty FV allocation
---
 memory.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/memory.c b/memory.c
index 8ab953ba24..4c28b91890 100644
--- a/memory.c
+++ b/memory.c
@@ -48,6 +48,7 @@ static QTAILQ_HEAD(, AddressSpace) address_spaces
     = QTAILQ_HEAD_INITIALIZER(address_spaces);
 
 static GHashTable *flat_views;
+static FlatView *empty_view;
 
 typedef struct AddrRange AddrRange;
 
@@ -746,22 +747,43 @@ static FlatView *generate_memory_topology(MemoryRegion *mr)
 {
     int i;
     FlatView *view;
+    bool use_empty = false;
 
-    view = flatview_new(mr);
+    if (!mr->enabled) {
+        use_empty = true;
+    } else {
+        view = flatview_new(mr);
+        if (mr) {
+            render_memory_region(view, mr, int128_zero(),
+                                 addrrange_make(int128_zero(), int128_2_64()),
+                                 false);
+        }
+        flatview_simplify(view);
 
-    if (mr) {
-        render_memory_region(view, mr, int128_zero(),
-                             addrrange_make(int128_zero(), int128_2_64()), false);
+        if (!view->nr) {
+            flatview_destroy(view);
+            use_empty = true;
+        }
     }
-    flatview_simplify(view);
 
-    view->dispatch = address_space_dispatch_new(view);
-    for (i = 0; i < view->nr; i++) {
-        MemoryRegionSection mrs =
-            section_from_flat_range(&view->ranges[i], view);
-        flatview_add_to_dispatch(view, &mrs);
+    if (use_empty) {
+        if (!empty_view) {
+            empty_view = flatview_new(NULL);
+        }
+        view = empty_view;
+        flatview_ref(view);
     }
-    address_space_dispatch_compact(view->dispatch);
+
+    if (!view->dispatch) {
+        view->dispatch = address_space_dispatch_new(view);
+        for (i = 0; i < view->nr; i++) {
+            MemoryRegionSection mrs =
+                section_from_flat_range(&view->ranges[i], view);
+            flatview_add_to_dispatch(view, &mrs);
+        }
+        address_space_dispatch_compact(view->dispatch);
+    }
+
     g_hash_table_replace(flat_views, mr, view);
 
     return view;
-- 
2.11.0

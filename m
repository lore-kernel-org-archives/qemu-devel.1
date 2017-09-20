Received: from eggs.gnu.org ([2001:4830:134:3::10]:56402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmH-0003P8-Pb
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmD-00057u-Pi
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:01 -0400
Received: from ozlabs.ru ([107.173.13.209]:59748)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmD-00057N-JO
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:14:57 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 20 Sep 2017 21:46:29 +1000
Message-Id: <20170920114637.42004-11-aik@ozlabs.ru>
In-Reply-To: <20170920114637.42004-1-aik@ozlabs.ru>
References: <20170920114637.42004-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v4 10/18] memory: Alloc dispatch tree
 where topology is generared
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

This is to make next patches simpler.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 memory.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/memory.c b/memory.c
index 98b0b95e6e..eb730cd619 100644
--- a/memory.c
+++ b/memory.c
@@ -742,6 +742,7 @@ static MemoryRegion *memory_region_get_flatview_root(MemoryRegion *mr)
 /* Render a memory topology into a list of disjoint absolute ranges. */
 static FlatView *generate_memory_topology(MemoryRegion *mr)
 {
+    int i;
     FlatView *view;
 
     view = flatview_new(mr);
@@ -752,6 +753,14 @@ static FlatView *generate_memory_topology(MemoryRegion *mr)
     }
     flatview_simplify(view);
 
+    view->dispatch = address_space_dispatch_new(view);
+    for (i = 0; i < view->nr; i++) {
+        MemoryRegionSection mrs =
+            section_from_flat_range(&view->ranges[i], view);
+        flatview_add_to_dispatch(view, &mrs);
+    }
+    address_space_dispatch_compact(view->dispatch);
+
     return view;
 }
 
@@ -921,15 +930,6 @@ static void address_space_update_topology(AddressSpace *as)
     FlatView *old_view = address_space_get_flatview(as);
     MemoryRegion *physmr = memory_region_get_flatview_root(old_view->root);
     FlatView *new_view = generate_memory_topology(physmr);
-    int i;
-
-    new_view->dispatch = address_space_dispatch_new(new_view);
-    for (i = 0; i < new_view->nr; i++) {
-        MemoryRegionSection mrs =
-            section_from_flat_range(&new_view->ranges[i], new_view);
-        flatview_add_to_dispatch(new_view, &mrs);
-    }
-    address_space_dispatch_compact(new_view->dispatch);
 
     if (!QTAILQ_EMPTY(&as->listeners)) {
         address_space_update_topology_pass(as, old_view, new_view, false);
-- 
2.11.0

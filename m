Received: from eggs.gnu.org ([2001:4830:134:3::10]:56352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmG-0003O0-Lh
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmD-00057B-5f
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:00 -0400
Received: from ozlabs.ru ([107.173.13.209]:59744)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmD-00056z-16
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:14:57 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 20 Sep 2017 21:46:28 +1000
Message-Id: <20170920114637.42004-10-aik@ozlabs.ru>
In-Reply-To: <20170920114637.42004-1-aik@ozlabs.ru>
References: <20170920114637.42004-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v4 09/18] memory: Store physical root MR
 in FlatView
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

Address spaces get to keep a root MR (alias or not) but FlatView stores
the actual MR as this is going to be used later on to decide whether to
share a particular FlatView or not.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v4:
* s/memory_region_unalias_entire/memory_region_get_flatview_root/
---
 memory.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/memory.c b/memory.c
index 990e9b8478..98b0b95e6e 100644
--- a/memory.c
+++ b/memory.c
@@ -230,6 +230,7 @@ struct FlatView {
     unsigned nr;
     unsigned nr_allocated;
     struct AddressSpaceDispatch *dispatch;
+    MemoryRegion *root;
 };
 
 typedef struct AddressSpaceOps AddressSpaceOps;
@@ -259,12 +260,14 @@ static bool flatrange_equal(FlatRange *a, FlatRange *b)
         && a->readonly == b->readonly;
 }
 
-static FlatView *flatview_new(void)
+static FlatView *flatview_new(MemoryRegion *mr_root)
 {
     FlatView *view;
 
     view = g_new0(FlatView, 1);
     view->ref = 1;
+    view->root = mr_root;
+    memory_region_ref(mr_root);
 
     return view;
 }
@@ -297,6 +300,7 @@ static void flatview_destroy(FlatView *view)
         memory_region_unref(view->ranges[i].mr);
     }
     g_free(view->ranges);
+    memory_region_unref(view->root);
     g_free(view);
 }
 
@@ -722,12 +726,25 @@ static void render_memory_region(FlatView *view,
     }
 }
 
+static MemoryRegion *memory_region_get_flatview_root(MemoryRegion *mr)
+{
+    while (mr->alias && !mr->alias_offset &&
+           int128_ge(mr->size, mr->alias->size)) {
+        /* The alias is included in its entirety.  Use it as
+         * the "real" root, so that we can share more FlatViews.
+         */
+        mr = mr->alias;
+    }
+
+    return mr;
+}
+
 /* Render a memory topology into a list of disjoint absolute ranges. */
 static FlatView *generate_memory_topology(MemoryRegion *mr)
 {
     FlatView *view;
 
-    view = flatview_new();
+    view = flatview_new(mr);
 
     if (mr) {
         render_memory_region(view, mr, int128_zero(),
@@ -902,7 +919,8 @@ static void address_space_update_topology_pass(AddressSpace *as,
 static void address_space_update_topology(AddressSpace *as)
 {
     FlatView *old_view = address_space_get_flatview(as);
-    FlatView *new_view = generate_memory_topology(as->root);
+    MemoryRegion *physmr = memory_region_get_flatview_root(old_view->root);
+    FlatView *new_view = generate_memory_topology(physmr);
     int i;
 
     new_view->dispatch = address_space_dispatch_new(new_view);
@@ -2645,7 +2663,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     as->ref_count = 1;
     as->root = root;
     as->malloced = false;
-    as->current_map = flatview_new();
+    as->current_map = flatview_new(root);
     as->ioeventfd_nb = 0;
     as->ioeventfds = NULL;
     QTAILQ_INIT(&as->listeners);
-- 
2.11.0

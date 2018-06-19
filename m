Received: from eggs.gnu.org ([2001:4830:134:3::10]:45472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hh-0001Fu-OD
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5hg-0008BW-Q0
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:05 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:54 -0500
Message-Id: <20180619014319.28272-29-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 028/113] memory: inline some
 performance-sensitive accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

These accessors are called from inlined functions, and the call sequence
is much more expensive than just inlining the access.  Move the
struct declaration to memory-internal.h so that exec.c and memory.c
can both use an inline function.

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 785a507ec78bbda1c346f3d3593e5a58b62e73ef)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 include/exec/memory-internal.h | 13 +++++++++----
 include/exec/memory.h          | 22 +++++++++++++++++++++-
 memory.c                       | 30 ------------------------------
 3 files changed, 30 insertions(+), 35 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index 98d82964cc..987ff115b8 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -20,7 +20,15 @@
 #define MEMORY_INTERNAL_H
 
 #ifndef CONFIG_USER_ONLY
-typedef struct AddressSpaceDispatch AddressSpaceDispatch;
+static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
+{
+    return fv->dispatch;
+}
+
+static inline AddressSpaceDispatch *address_space_to_dispatch(AddressSpace *as)
+{
+    return flatview_to_dispatch(address_space_to_flatview(as));
+}
 
 extern const MemoryRegionOps unassigned_mem_ops;
 
@@ -30,9 +38,6 @@ bool memory_region_access_valid(MemoryRegion *mr, hwaddr addr,
 void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section);
 AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv);
 void address_space_dispatch_compact(AddressSpaceDispatch *d);
-
-AddressSpaceDispatch *address_space_to_dispatch(AddressSpace *as);
-AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv);
 void address_space_dispatch_free(AddressSpaceDispatch *d);
 
 void mtree_print_dispatch(fprintf_function mon, void *f,
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 5ed4042f87..ca544027fb 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -318,7 +318,27 @@ struct AddressSpace {
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
 };
 
-FlatView *address_space_to_flatview(AddressSpace *as);
+typedef struct AddressSpaceDispatch AddressSpaceDispatch;
+typedef struct FlatRange FlatRange;
+
+/* Flattened global view of current active memory hierarchy.  Kept in sorted
+ * order.
+ */
+struct FlatView {
+    struct rcu_head rcu;
+    unsigned ref;
+    FlatRange *ranges;
+    unsigned nr;
+    unsigned nr_allocated;
+    struct AddressSpaceDispatch *dispatch;
+    MemoryRegion *root;
+};
+
+static inline FlatView *address_space_to_flatview(AddressSpace *as)
+{
+    return atomic_rcu_read(&as->current_map);
+}
+
 
 /**
  * MemoryRegionSection: describes a fragment of a #MemoryRegion
diff --git a/memory.c b/memory.c
index 226a7e8a2c..b2e23c31f4 100644
--- a/memory.c
+++ b/memory.c
@@ -210,8 +210,6 @@ static bool memory_region_ioeventfd_equal(MemoryRegionIoeventfd a,
         && !memory_region_ioeventfd_before(b, a);
 }
 
-typedef struct FlatRange FlatRange;
-
 /* Range of memory in the global map.  Addresses are absolute. */
 struct FlatRange {
     MemoryRegion *mr;
@@ -222,19 +220,6 @@ struct FlatRange {
     bool readonly;
 };
 
-/* Flattened global view of current active memory hierarchy.  Kept in sorted
- * order.
- */
-struct FlatView {
-    struct rcu_head rcu;
-    unsigned ref;
-    FlatRange *ranges;
-    unsigned nr;
-    unsigned nr_allocated;
-    struct AddressSpaceDispatch *dispatch;
-    MemoryRegion *root;
-};
-
 typedef struct AddressSpaceOps AddressSpaceOps;
 
 #define FOR_EACH_FLAT_RANGE(var, view)          \
@@ -322,21 +307,6 @@ static void flatview_unref(FlatView *view)
     }
 }
 
-FlatView *address_space_to_flatview(AddressSpace *as)
-{
-    return atomic_rcu_read(&as->current_map);
-}
-
-AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
-{
-    return fv->dispatch;
-}
-
-AddressSpaceDispatch *address_space_to_dispatch(AddressSpace *as)
-{
-    return flatview_to_dispatch(address_space_to_flatview(as));
-}
-
 static bool can_merge(FlatRange *r1, FlatRange *r2)
 {
     return int128_eq(addrrange_end(r1->addr), r2->addr.start)
-- 
2.11.0

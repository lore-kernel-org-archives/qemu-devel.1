Received: from eggs.gnu.org ([2001:4830:134:3::10]:35084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eslcC-0004LL-M8
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:37:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eslcB-0004O8-Kt
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:37:00 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Mar 2018 09:36:50 +0100
Message-Id: <20180305083655.6186-3-pbonzini@redhat.com>
In-Reply-To: <20180305083655.6186-1-pbonzini@redhat.com>
References: <20180305083655.6186-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/7] memory: inline some performance-sensitive
 accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-stable@nongnu.org

These accessors are called from inlined functions, and the call sequence
is much more expensive than just inlining the access.  Move the
struct declaration to memory-internal.h so that exec.c and memory.c
can both use an inline function.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory-internal.h | 13 +++++++++----
 include/exec/memory.h          | 22 +++++++++++++++++++++-
 memory.c                       | 30 ------------------------------
 3 files changed, 30 insertions(+), 35 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index 4162474fd5..6a5ee42d36 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -21,7 +21,15 @@
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
 
@@ -31,9 +39,6 @@ bool memory_region_access_valid(MemoryRegion *mr, hwaddr addr,
 void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section);
 AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv);
 void address_space_dispatch_compact(AddressSpaceDispatch *d);
-
-AddressSpaceDispatch *address_space_to_dispatch(AddressSpace *as);
-AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv);
 void address_space_dispatch_free(AddressSpaceDispatch *d);
 
 void mtree_print_dispatch(fprintf_function mon, void *f,
diff --git a/include/exec/memory.h b/include/exec/memory.h
index fff9b1d871..6c8e394675 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -326,7 +326,27 @@ struct AddressSpace {
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
index c7f6588452..78d07aa51d 100644
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
2.14.3

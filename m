Received: from eggs.gnu.org ([2001:4830:134:3::10]:48213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVc-0005Gs-IR
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVW-0006NO-F2
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:20:00 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:39657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVW-0006Mh-95
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:54 -0500
Received: by mail-wr0-x241.google.com with SMTP id w77so20920129wrc.6
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:19:54 -0800 (PST)
Received: from 640k.lan (94-36-191-219.adsl-ull.clienti.tiscali.it.
	[94.36.191.219]) by smtp.gmail.com with ESMTPSA id
	l38sm25652538wrc.96.2018.03.06.05.19.51 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 06 Mar 2018 05:19:52 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:19:12 +0100
Message-Id: <1520342370-123606-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 16/34] memory: inline some performance-sensitive
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

These accessors are called from inlined functions, and the call sequence
is much more expensive than just inlining the access.  Move the
struct declaration to memory-internal.h so that exec.c and memory.c
can both use an inline function.

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory-internal.h | 13 +++++++++----
 include/exec/memory.h          | 22 +++++++++++++++++++++-
 memory.c                       | 30 ------------------------------
 3 files changed, 30 insertions(+), 35 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index 4162474..6a5ee42 100644
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
index 15e8111..4b65b56 100644
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
index 6515131..e70b64b 100644
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
1.8.3.1

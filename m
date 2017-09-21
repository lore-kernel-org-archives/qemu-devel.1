Received: from eggs.gnu.org ([2001:4830:134:3::10]:37402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiS-0004pc-N2
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiP-0004K0-Il
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:08 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:37204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAiP-0004J0-Bx
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:05 -0400
Received: by mail-wm0-x241.google.com with SMTP id f4so6421420wmh.4
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:17:05 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:25 +0200
Message-Id: <1506035800-30509-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/32] memory: Share FlatView's and dispatch
 trees between address spaces
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

This allows sharing flat views between address spaces (AS) when
the same root memory region is used when creating a new address space.
This is done by walking through all ASes and caching one FlatView per
a physical root MR (i.e. not aliased).

This removes search for duplicates from address_space_init_shareable() as
FlatViews are shared elsewhere and keeping as::ref_count correct seems
an unnecessary and useless complication.

This should cause no change and memory use or boot time yet.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-13-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 56 +++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/memory.c b/memory.c
index bb582d0..8ee3c81 100644
--- a/memory.c
+++ b/memory.c
@@ -47,6 +47,8 @@ static QTAILQ_HEAD(memory_listeners, MemoryListener) memory_listeners
 static QTAILQ_HEAD(, AddressSpace) address_spaces
     = QTAILQ_HEAD_INITIALIZER(address_spaces);
 
+static GHashTable *flat_views;
+
 typedef struct AddrRange AddrRange;
 
 /*
@@ -761,6 +763,7 @@ static FlatView *generate_memory_topology(MemoryRegion *mr)
         flatview_add_to_dispatch(view, &mrs);
     }
     address_space_dispatch_compact(view->dispatch);
+    g_hash_table_replace(flat_views, mr, view);
 
     return view;
 }
@@ -930,11 +933,47 @@ static void address_space_update_topology_pass(AddressSpace *as,
     }
 }
 
-static void address_space_update_topology(AddressSpace *as)
+static void flatviews_init(void)
+{
+    if (flat_views) {
+        return;
+    }
+
+    flat_views = g_hash_table_new_full(g_direct_hash, g_direct_equal, NULL,
+                                       (GDestroyNotify) flatview_unref);
+}
+
+static void flatviews_reset(void)
+{
+    AddressSpace *as;
+
+    if (flat_views) {
+        g_hash_table_unref(flat_views);
+        flat_views = NULL;
+    }
+    flatviews_init();
+
+    /* Render unique FVs */
+    QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
+        MemoryRegion *physmr = memory_region_get_flatview_root(as->root);
+
+        if (g_hash_table_lookup(flat_views, physmr)) {
+            continue;
+        }
+
+        generate_memory_topology(physmr);
+    }
+}
+
+static void address_space_set_flatview(AddressSpace *as)
 {
     FlatView *old_view = address_space_get_flatview(as);
-    MemoryRegion *physmr = memory_region_get_flatview_root(old_view->root);
-    FlatView *new_view = generate_memory_topology(physmr);
+    MemoryRegion *physmr = memory_region_get_flatview_root(as->root);
+    FlatView *new_view = g_hash_table_lookup(flat_views, physmr);
+
+    assert(new_view);
+
+    flatview_ref(new_view);
 
     if (!QTAILQ_EMPTY(&as->listeners)) {
         address_space_update_topology_pass(as, old_view, new_view, false);
@@ -970,10 +1009,12 @@ void memory_region_transaction_commit(void)
     --memory_region_transaction_depth;
     if (!memory_region_transaction_depth) {
         if (memory_region_update_pending) {
+            flatviews_reset();
+
             MEMORY_LISTENER_CALL_GLOBAL(begin, Forward);
 
             QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-                address_space_update_topology(as);
+                address_space_set_flatview(as);
                 address_space_update_ioeventfds(as);
             }
             memory_region_update_pending = false;
@@ -2696,13 +2737,6 @@ AddressSpace *address_space_init_shareable(MemoryRegion *root, const char *name)
 {
     AddressSpace *as;
 
-    QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-        if (root == as->root && as->malloced) {
-            as->ref_count++;
-            return as;
-        }
-    }
-
     as = g_malloc0(sizeof *as);
     address_space_init(as, root, name);
     as->malloced = true;
-- 
1.8.3.1

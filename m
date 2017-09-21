Received: from eggs.gnu.org ([2001:4830:134:3::10]:37335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiN-0004kU-QP
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiM-0004Fj-M0
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:03 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAiM-0004Ec-Eq
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:02 -0400
Received: by mail-wr0-x243.google.com with SMTP id n64so3849022wrb.2
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:17:02 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:22 +0200
Message-Id: <1506035800-30509-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/32] memory: Store physical root MR in FlatView
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

Address spaces get to keep a root MR (alias or not) but FlatView stores
the actual MR as this is going to be used later on to decide whether to
share a particular FlatView or not.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-10-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/memory.c b/memory.c
index c374317..15724db 100644
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
 
@@ -723,12 +727,25 @@ static void render_memory_region(FlatView *view,
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
@@ -907,7 +924,8 @@ static void address_space_update_topology_pass(AddressSpace *as,
 static void address_space_update_topology(AddressSpace *as)
 {
     FlatView *old_view = address_space_get_flatview(as);
-    FlatView *new_view = generate_memory_topology(as->root);
+    MemoryRegion *physmr = memory_region_get_flatview_root(old_view->root);
+    FlatView *new_view = generate_memory_topology(physmr);
     int i;
 
     new_view->dispatch = address_space_dispatch_new(new_view);
@@ -2650,7 +2668,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     as->ref_count = 1;
     as->root = root;
     as->malloced = false;
-    as->current_map = flatview_new();
+    as->current_map = flatview_new(root);
     as->ioeventfd_nb = 0;
     as->ioeventfds = NULL;
     QTAILQ_INIT(&as->listeners);
-- 
1.8.3.1

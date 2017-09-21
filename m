Received: from eggs.gnu.org ([2001:4830:134:3::10]:37351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiO-0004lJ-Jc
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiN-0004HB-Md
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:04 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAiN-0004Fx-F1
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:03 -0400
Received: by mail-wm0-x241.google.com with SMTP id e64so6456673wmi.2
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:17:03 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:23 +0200
Message-Id: <1506035800-30509-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/32] memory: Alloc dispatch tree where
 topology is generared
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

This is to make next patches simpler.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-11-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/memory.c b/memory.c
index 15724db..6f6c233 100644
--- a/memory.c
+++ b/memory.c
@@ -743,6 +743,7 @@ static MemoryRegion *memory_region_get_flatview_root(MemoryRegion *mr)
 /* Render a memory topology into a list of disjoint absolute ranges. */
 static FlatView *generate_memory_topology(MemoryRegion *mr)
 {
+    int i;
     FlatView *view;
 
     view = flatview_new(mr);
@@ -753,6 +754,14 @@ static FlatView *generate_memory_topology(MemoryRegion *mr)
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
 
@@ -926,15 +935,6 @@ static void address_space_update_topology(AddressSpace *as)
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
1.8.3.1

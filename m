Received: from eggs.gnu.org ([2001:4830:134:3::10]:37400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiS-0004pZ-MF
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiQ-0004LF-Dw
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:08 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAiQ-0004KI-7O
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:06 -0400
Received: by mail-wr0-x241.google.com with SMTP id k20so3843971wre.1
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:17:06 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:26 +0200
Message-Id: <1506035800-30509-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 18/32] memory: Do not allocate FlatView in
 address_space_init
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

This creates a new AS object without any FlatView as
memory_region_transaction_commit() may want to reuse the empty FV.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-14-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/memory.c b/memory.c
index 8ee3c81..3f6dd40 100644
--- a/memory.c
+++ b/memory.c
@@ -967,22 +967,37 @@ static void flatviews_reset(void)
 
 static void address_space_set_flatview(AddressSpace *as)
 {
-    FlatView *old_view = address_space_get_flatview(as);
+    FlatView *old_view = address_space_to_flatview(as);
     MemoryRegion *physmr = memory_region_get_flatview_root(as->root);
     FlatView *new_view = g_hash_table_lookup(flat_views, physmr);
 
     assert(new_view);
 
+    if (old_view == new_view) {
+        return;
+    }
+
+    if (old_view) {
+        flatview_ref(old_view);
+    }
+
     flatview_ref(new_view);
 
     if (!QTAILQ_EMPTY(&as->listeners)) {
-        address_space_update_topology_pass(as, old_view, new_view, false);
-        address_space_update_topology_pass(as, old_view, new_view, true);
+        FlatView tmpview = { .nr = 0 }, *old_view2 = old_view;
+
+        if (!old_view2) {
+            old_view2 = &tmpview;
+        }
+        address_space_update_topology_pass(as, old_view2, new_view, false);
+        address_space_update_topology_pass(as, old_view2, new_view, true);
     }
 
     /* Writes are protected by the BQL.  */
     atomic_rcu_set(&as->current_map, new_view);
-    flatview_unref(old_view);
+    if (old_view) {
+        flatview_unref(old_view);
+    }
 
     /* Note that all the old MemoryRegions are still alive up to this
      * point.  This relieves most MemoryListeners from the need to
@@ -990,7 +1005,9 @@ static void address_space_set_flatview(AddressSpace *as)
      * outside the iothread mutex, in which case precise reference
      * counting is necessary.
      */
-    flatview_unref(old_view);
+    if (old_view) {
+        flatview_unref(old_view);
+    }
 }
 
 void memory_region_transaction_begin(void)
@@ -2708,7 +2725,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     as->ref_count = 1;
     as->root = root;
     as->malloced = false;
-    as->current_map = flatview_new(root);
+    as->current_map = NULL;
     as->ioeventfd_nb = 0;
     as->ioeventfds = NULL;
     QTAILQ_INIT(&as->listeners);
-- 
1.8.3.1

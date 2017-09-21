Received: from eggs.gnu.org ([2001:4830:134:3::10]:48524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCs-00056z-AN
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCp-0001Jd-Tc
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:37 -0400
Received: from ozlabs.ru ([107.173.13.209]:54112)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCp-0001CA-NQ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:35 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 21 Sep 2017 18:51:05 +1000
Message-Id: <20170921085110.25598-14-aik@ozlabs.ru>
In-Reply-To: <20170921085110.25598-1-aik@ozlabs.ru>
References: <20170921085110.25598-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v5 13/18] memory: Do not allocate FlatView
 in address_space_init
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

This creates a new AS object without any FlatView as
memory_region_transaction_commit() may want to reuse the empty FV.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

I do not really want to add view!=NULL into
flatview_ref()/flatview_unref() as this is quite special case when
view==NULL.
---
 memory.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/memory.c b/memory.c
index 56b3dd47ab..c623575dac 100644
--- a/memory.c
+++ b/memory.c
@@ -962,22 +962,37 @@ static void flatviews_reset(void)
 
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
+        FlatView tmpview = { 0 }, *old_view2 = old_view;
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
@@ -985,7 +1000,9 @@ static void address_space_set_flatview(AddressSpace *as)
      * outside the iothread mutex, in which case precise reference
      * counting is necessary.
      */
-    flatview_unref(old_view);
+    if (old_view) {
+        flatview_unref(old_view);
+    }
 }
 
 void memory_region_transaction_begin(void)
@@ -2703,7 +2720,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     as->ref_count = 1;
     as->root = root;
     as->malloced = false;
-    as->current_map = flatview_new(root);
+    as->current_map = NULL;
     as->ioeventfd_nb = 0;
     as->ioeventfds = NULL;
     QTAILQ_INIT(&as->listeners);
-- 
2.11.0

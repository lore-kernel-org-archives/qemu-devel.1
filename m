Received: from eggs.gnu.org ([2001:4830:134:3::10]:56359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmG-0003O6-NA
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmE-00058R-6u
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:00 -0400
Received: from ozlabs.ru ([107.173.13.209]:59756)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmD-00057l-T7
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:14:58 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 20 Sep 2017 21:46:36 +1000
Message-Id: <20170920114637.42004-18-aik@ozlabs.ru>
In-Reply-To: <20170920114637.42004-1-aik@ozlabs.ru>
References: <20170920114637.42004-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v4 17/18] memory: Create FlatView directly
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

This avoids usual memory_region_transaction_commit() which rebuilds
all FVs.

On POWER8 with 255 CPUs, 255 virtio-net, 40 PCI bridges guest this brings
down the boot time from 25s to 20s and reduces the amount of temporary FVs
allocated during machine constructon (~800000 -> ~640000) and amount of
temporary dispatch trees (~370000 -> ~300000), the total memory footprint
goes down (18G -> 17G).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 memory.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/memory.c b/memory.c
index 25000d1035..d3b3581990 100644
--- a/memory.c
+++ b/memory.c
@@ -1020,6 +1020,20 @@ static void flatview_set_to_address_space(AddressSpace *as)
     }
 }
 
+static void flatview_update_topology_single(AddressSpace *as)
+{
+    MemoryRegion *physmr = memory_region_get_flatview_root(as->root);
+    FlatView *new_view;
+
+    flatviews_init();
+    new_view = g_hash_table_lookup(flat_views, physmr);
+    if (!new_view) {
+        new_view = generate_memory_topology(physmr);
+        g_hash_table_insert(flat_views, physmr, new_view);
+    }
+    flatview_set_to_address_space(as);
+}
+
 void memory_region_transaction_begin(void)
 {
     qemu_flush_coalesced_mmio_buffer();
@@ -2731,7 +2745,6 @@ void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset,
 void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
 {
     memory_region_ref(root);
-    memory_region_transaction_begin();
     as->root = root;
     as->current_map = NULL;
     as->ioeventfd_nb = 0;
@@ -2739,8 +2752,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     QTAILQ_INIT(&as->listeners);
     QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
     as->name = g_strdup(name ? name : "anonymous");
-    memory_region_update_pending |= root->enabled;
-    memory_region_transaction_commit();
+    flatview_update_topology_single(as);
 }
 
 static void do_address_space_destroy(AddressSpace *as)
-- 
2.11.0

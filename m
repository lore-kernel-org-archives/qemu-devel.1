Received: from eggs.gnu.org ([2001:4830:134:3::10]:48587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCw-0005Ca-IZ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCu-0001OP-FT
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:42 -0400
Received: from ozlabs.ru ([107.173.13.209]:54112)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCu-0001CA-9u
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:40 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 21 Sep 2017 18:51:09 +1000
Message-Id: <20170921085110.25598-18-aik@ozlabs.ru>
In-Reply-To: <20170921085110.25598-1-aik@ozlabs.ru>
References: <20170921085110.25598-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v5 17/18] memory: Create FlatView directly
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
Changes:
v5:
* %s/flatview_update_topology_single/address_space_update_topology/g
* fixup after moving g_hash_table_replace() to generate_memory_topology()
---
 memory.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/memory.c b/memory.c
index 57e47e990f..5c21563745 100644
--- a/memory.c
+++ b/memory.c
@@ -1027,6 +1027,17 @@ static void address_space_set_flatview(AddressSpace *as)
     }
 }
 
+static void address_space_update_topology(AddressSpace *as)
+{
+    MemoryRegion *physmr = memory_region_get_flatview_root(as->root);
+
+    flatviews_init();
+    if (!g_hash_table_lookup(flat_views, physmr)) {
+        generate_memory_topology(physmr);
+    }
+    address_space_set_flatview(as);
+}
+
 void memory_region_transaction_begin(void)
 {
     qemu_flush_coalesced_mmio_buffer();
@@ -2738,7 +2749,6 @@ void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset,
 void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
 {
     memory_region_ref(root);
-    memory_region_transaction_begin();
     as->root = root;
     as->current_map = NULL;
     as->ioeventfd_nb = 0;
@@ -2746,8 +2756,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     QTAILQ_INIT(&as->listeners);
     QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
     as->name = g_strdup(name ? name : "anonymous");
-    memory_region_update_pending |= root->enabled;
-    memory_region_transaction_commit();
+    address_space_update_topology(as);
 }
 
 static void do_address_space_destroy(AddressSpace *as)
-- 
2.11.0

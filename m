Received: from eggs.gnu.org ([2001:4830:134:3::10]:37441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiV-0004sK-60
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiU-0004QQ-29
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:11 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAiT-0004P4-RD
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:09 -0400
Received: by mail-wr0-x243.google.com with SMTP id n64so3849106wrb.2
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:17:09 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:29 +0200
Message-Id: <1506035800-30509-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 21/32] memory: Create FlatView directly
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

This avoids usual memory_region_transaction_commit() which rebuilds
all FVs.

On POWER8 with 255 CPUs, 255 virtio-net, 40 PCI bridges guest this brings
down the boot time from 25s to 20s and reduces the amount of temporary FVs
allocated during machine constructon (~800000 -> ~640000) and amount of
temporary dispatch trees (~370000 -> ~300000), the total memory footprint
goes down (18G -> 17G).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-18-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/memory.c b/memory.c
index aa7355b..706c385 100644
--- a/memory.c
+++ b/memory.c
@@ -1010,6 +1010,17 @@ static void address_space_set_flatview(AddressSpace *as)
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
@@ -2721,7 +2732,6 @@ void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset,
 void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
 {
     memory_region_ref(root);
-    memory_region_transaction_begin();
     as->root = root;
     as->current_map = NULL;
     as->ioeventfd_nb = 0;
@@ -2729,8 +2739,8 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     QTAILQ_INIT(&as->listeners);
     QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
     as->name = g_strdup(name ? name : "anonymous");
-    memory_region_update_pending |= root->enabled;
-    memory_region_transaction_commit();
+    address_space_update_topology(as);
+    address_space_update_ioeventfds(as);
 }
 
 static void do_address_space_destroy(AddressSpace *as)
-- 
1.8.3.1

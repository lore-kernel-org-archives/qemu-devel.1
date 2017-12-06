Received: from eggs.gnu.org ([2001:4830:134:3::10]:48998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCD-0000UN-SE
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCB-0000Mg-9j
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45050
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCB-0000Ls-5C
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:27 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JEtIk037303
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:26 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eppat0m2v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:26 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:17:25 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:14 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-22-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 21/55] memory: Create FlatView directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>

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
(cherry picked from commit 202fc01b05572ecb258fdf4c5bd56cf6de8140c7)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 memory.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/memory.c b/memory.c
index 2e0def18ee..c1a64a9ca2 100644
--- a/memory.c
+++ b/memory.c
@@ -1009,6 +1009,17 @@ static void address_space_set_flatview(AddressSpace *as)
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
@@ -2720,7 +2731,6 @@ void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset,
 void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
 {
     memory_region_ref(root);
-    memory_region_transaction_begin();
     as->root = root;
     as->current_map = NULL;
     as->ioeventfd_nb = 0;
@@ -2728,8 +2738,8 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
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
2.11.0

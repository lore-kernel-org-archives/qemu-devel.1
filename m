Received: from eggs.gnu.org ([2001:4830:134:3::10]:48760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfC3-00086P-SR
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfC2-0000Al-3Z
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42552
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfC1-00009r-Su
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:17 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JE25D112305
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:14 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epm58y0v9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:14 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:17:13 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:07 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-15-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 14/55] memory: Rename
 mem_begin/mem_commit/mem_add helpers
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

This renames some helpers to reflect better what they do.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-9-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 8629d3fcb77e9775e44d9051bad0fb5187925eae)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 exec.c                         | 12 +++---------
 include/exec/memory-internal.h |  6 +++---
 memory.c                       |  6 +++---
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/exec.c b/exec.c
index 3e02b82c05..b1f29d35d8 100644
--- a/exec.c
+++ b/exec.c
@@ -359,7 +359,7 @@ static void phys_page_compact(PhysPageEntry *lp, Node *nodes)
     }
 }
 
-static void phys_page_compact_all(AddressSpaceDispatch *d, int nodes_nb)
+void address_space_dispatch_compact(AddressSpaceDispatch *d)
 {
     if (d->phys_map.skip) {
         phys_page_compact(&d->phys_map, d->map.nodes);
@@ -1347,7 +1347,7 @@ static void register_multipage(FlatView *fv,
     phys_page_set(d, start_addr >> TARGET_PAGE_BITS, num_pages, section_index);
 }
 
-void mem_add(FlatView *fv, MemoryRegionSection *section)
+void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section)
 {
     MemoryRegionSection now = *section, remain = *section;
     Int128 page_size = int128_make64(TARGET_PAGE_SIZE);
@@ -2673,9 +2673,8 @@ static void io_mem_init(void)
                           NULL, UINT64_MAX);
 }
 
-AddressSpaceDispatch *mem_begin(AddressSpace *as)
+AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv)
 {
-    FlatView *fv = address_space_to_flatview(as);
     AddressSpaceDispatch *d = g_new0(AddressSpaceDispatch, 1);
     uint16_t n;
 
@@ -2699,11 +2698,6 @@ void address_space_dispatch_free(AddressSpaceDispatch *d)
     g_free(d);
 }
 
-void mem_commit(AddressSpaceDispatch *d)
-{
-    phys_page_compact_all(d, d->map.nodes_nb);
-}
-
 static void tcg_commit(MemoryListener *listener)
 {
     CPUAddressSpace *cpuas;
diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index 1cf8ad9869..d4a35c6e96 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -27,9 +27,9 @@ extern const MemoryRegionOps unassigned_mem_ops;
 bool memory_region_access_valid(MemoryRegion *mr, hwaddr addr,
                                 unsigned size, bool is_write);
 
-void mem_add(FlatView *fv, MemoryRegionSection *section);
-AddressSpaceDispatch *mem_begin(AddressSpace *as);
-void mem_commit(AddressSpaceDispatch *d);
+void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section);
+AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv);
+void address_space_dispatch_compact(AddressSpaceDispatch *d);
 
 AddressSpaceDispatch *address_space_to_dispatch(AddressSpace *as);
 AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv);
diff --git a/memory.c b/memory.c
index 6678a538d2..b7d253636b 100644
--- a/memory.c
+++ b/memory.c
@@ -909,13 +909,13 @@ static void address_space_update_topology(AddressSpace *as)
     FlatView *new_view = generate_memory_topology(as->root);
     int i;
 
-    new_view->dispatch = mem_begin(as);
+    new_view->dispatch = address_space_dispatch_new(new_view);
     for (i = 0; i < new_view->nr; i++) {
         MemoryRegionSection mrs =
             section_from_flat_range(&new_view->ranges[i], new_view);
-        mem_add(new_view, &mrs);
+        flatview_add_to_dispatch(new_view, &mrs);
     }
-    mem_commit(new_view->dispatch);
+    address_space_dispatch_compact(new_view->dispatch);
 
     if (!QTAILQ_EMPTY(&as->listeners)) {
         address_space_update_topology_pass(as, old_view, new_view, false);
-- 
2.11.0

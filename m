Received: from eggs.gnu.org ([2001:4830:134:3::10]:48835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfC7-0008PL-Pn
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfC4-0000DC-JB
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfC4-0000C5-9K
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:20 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JF6JO111434
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:19 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epm1wf6s4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:18 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:17:17 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:09 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-17-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 16/55] memory: Alloc dispatch tree where
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
Cc: qemu-stable@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This is to make next patches simpler.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-11-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 9bf561e36cf8fed9565011a19ba9ea0100e1811e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 memory.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/memory.c b/memory.c
index 7972235a06..8034520148 100644
--- a/memory.c
+++ b/memory.c
@@ -742,6 +742,7 @@ static MemoryRegion *memory_region_get_flatview_root(MemoryRegion *mr)
 /* Render a memory topology into a list of disjoint absolute ranges. */
 static FlatView *generate_memory_topology(MemoryRegion *mr)
 {
+    int i;
     FlatView *view;
 
     view = flatview_new(mr);
@@ -752,6 +753,14 @@ static FlatView *generate_memory_topology(MemoryRegion *mr)
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
 
@@ -925,15 +934,6 @@ static void address_space_update_topology(AddressSpace *as)
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
2.11.0

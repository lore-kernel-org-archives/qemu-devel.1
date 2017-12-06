Received: from eggs.gnu.org ([2001:4830:134:3::10]:48745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfC3-00086I-Or
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfC0-00008f-DT
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45908
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfC0-00007y-7b
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:16 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JE8MX024297
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:15 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epm4y6tb4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:15 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:17:15 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:08 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-16-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 15/55] memory: Store physical root MR in
 FlatView
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

Address spaces get to keep a root MR (alias or not) but FlatView stores
the actual MR as this is going to be used later on to decide whether to
share a particular FlatView or not.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-10-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 89c177bbdd6cf8e50b3fd4831697d50e195d6432)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 memory.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/memory.c b/memory.c
index b7d253636b..7972235a06 100644
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
 
@@ -722,12 +726,25 @@ static void render_memory_region(FlatView *view,
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
@@ -906,7 +923,8 @@ static void address_space_update_topology_pass(AddressSpace *as,
 static void address_space_update_topology(AddressSpace *as)
 {
     FlatView *old_view = address_space_get_flatview(as);
-    FlatView *new_view = generate_memory_topology(as->root);
+    MemoryRegion *physmr = memory_region_get_flatview_root(old_view->root);
+    FlatView *new_view = generate_memory_topology(physmr);
     int i;
 
     new_view->dispatch = address_space_dispatch_new(new_view);
@@ -2649,7 +2667,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     as->ref_count = 1;
     as->root = root;
     as->malloced = false;
-    as->current_map = flatview_new();
+    as->current_map = flatview_new(root);
     as->ioeventfd_nb = 0;
     as->ioeventfds = NULL;
     QTAILQ_INIT(&as->listeners);
-- 
2.11.0

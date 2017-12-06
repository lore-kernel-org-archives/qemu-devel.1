Received: from eggs.gnu.org ([2001:4830:134:3::10]:48922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCB-0000Hl-1b
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfC8-0000Ju-Qx
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfC8-0000IG-Jh
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:24 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JEvHh076143
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:22 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epmmmnn67-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:22 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:17:21 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:12 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-20-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 19/55] memory: Do not allocate FlatView in
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
Cc: qemu-stable@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This creates a new AS object without any FlatView as
memory_region_transaction_commit() may want to reuse the empty FV.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-14-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 67ace39b253ed5ae465275bc870f7e495547658b)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 memory.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/memory.c b/memory.c
index f0c864206a..6914d87d0d 100644
--- a/memory.c
+++ b/memory.c
@@ -966,22 +966,37 @@ static void flatviews_reset(void)
 
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
@@ -989,7 +1004,9 @@ static void address_space_set_flatview(AddressSpace *as)
      * outside the iothread mutex, in which case precise reference
      * counting is necessary.
      */
-    flatview_unref(old_view);
+    if (old_view) {
+        flatview_unref(old_view);
+    }
 }
 
 void memory_region_transaction_begin(void)
@@ -2707,7 +2724,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
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

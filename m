Received: from eggs.gnu.org ([2001:4830:134:3::10]:50273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCw-0001Fp-8P
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCt-0001GR-39
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCs-0001Et-Rx
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:11 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JEGOQ012346
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:18:10 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epm4275a8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:18:09 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:18:08 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:01 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-9-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 08/55] memory: Move FlatView allocation to a
 helper
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

This moves a FlatView allocation and initialization to a helper.
While we are nere, replace g_new with g_new0 to not to bother if we add
new fields in the future.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-4-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit cc94cd6d36602d976a5e7bc29134d1eaefb4102e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 memory.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/memory.c b/memory.c
index 138e21d35d..c0aa296223 100644
--- a/memory.c
+++ b/memory.c
@@ -258,12 +258,14 @@ static bool flatrange_equal(FlatRange *a, FlatRange *b)
         && a->readonly == b->readonly;
 }
 
-static void flatview_init(FlatView *view)
+static FlatView *flatview_new(void)
 {
+    FlatView *view;
+
+    view = g_new0(FlatView, 1);
     view->ref = 1;
-    view->ranges = NULL;
-    view->nr = 0;
-    view->nr_allocated = 0;
+
+    return view;
 }
 
 /* Insert a range into a given position.  Caller is responsible for maintaining
@@ -706,8 +708,7 @@ static FlatView *generate_memory_topology(MemoryRegion *mr)
 {
     FlatView *view;
 
-    view = g_new(FlatView, 1);
-    flatview_init(view);
+    view = flatview_new();
 
     if (mr) {
         render_memory_region(view, mr, int128_zero(),
@@ -2624,8 +2625,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     as->ref_count = 1;
     as->root = root;
     as->malloced = false;
-    as->current_map = g_new(FlatView, 1);
-    flatview_init(as->current_map);
+    as->current_map = flatview_new();
     as->ioeventfd_nb = 0;
     as->ioeventfds = NULL;
     QTAILQ_INIT(&as->listeners);
-- 
2.11.0

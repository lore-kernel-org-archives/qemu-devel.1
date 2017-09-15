Received: from eggs.gnu.org ([2001:4830:134:3::10]:38147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dsmB0-0006u1-R6
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dsmAy-0002QM-7t
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:40:42 -0400
Received: from ozlabs.ru ([107.173.13.209]:44552)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dsmAx-0002QD-Sf
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:40:40 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri, 15 Sep 2017 18:40:21 +1000
Message-Id: <20170915084030.40988-5-aik@ozlabs.ru>
In-Reply-To: <20170915084030.40988-1-aik@ozlabs.ru>
References: <20170915084030.40988-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v2 04/13] memory: Move FlatView allocation
 to a helper
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

This moves a FlatView allocation and initialization to a helper.
While we are nere, replace g_new with g_new0 to not to bother if we add
new fields in the future.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 memory.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/memory.c b/memory.c
index 62b0702d67..a8381a8bc2 100644
--- a/memory.c
+++ b/memory.c
@@ -258,12 +258,14 @@ static bool flatrange_equal(FlatRange *a, FlatRange *b)
         && a->readonly == b->readonly;
 }
 
-static void flatview_init(FlatView *view)
+static FlatView *flatview_alloc(void)
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
+    view = flatview_alloc();
 
     if (mr) {
         render_memory_region(view, mr, int128_zero(),
@@ -2665,8 +2666,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
     as->ref_count = 1;
     as->root = root;
     as->malloced = false;
-    as->current_map = g_new(FlatView, 1);
-    flatview_init(as->current_map);
+    as->current_map = flatview_alloc();
     as->ioeventfd_nb = 0;
     as->ioeventfds = NULL;
     QTAILQ_INIT(&as->listeners);
-- 
2.11.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCf-0004zI-N7
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCe-0001Co-Q8
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:25 -0400
Received: from ozlabs.ru ([107.173.13.209]:54112)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duxCe-0001CA-KD
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:51:24 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 21 Sep 2017 18:50:55 +1000
Message-Id: <20170921085110.25598-4-aik@ozlabs.ru>
In-Reply-To: <20170921085110.25598-1-aik@ozlabs.ru>
References: <20170921085110.25598-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v5 03/18] memory: Move FlatView allocation
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

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v3:
* s/flatview_alloc/flatview_new/
---
 memory.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/memory.c b/memory.c
index 101d5f4d60..9babd7d423 100644
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

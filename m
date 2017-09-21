Received: from eggs.gnu.org ([2001:4830:134:3::10]:37229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiF-0004bl-O0
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiE-00043v-OC
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:55 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAiE-00041Y-ID
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:54 -0400
Received: by mail-wm0-x241.google.com with SMTP id r136so6437005wmf.3
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:16:54 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:16 +0200
Message-Id: <1506035800-30509-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/32] memory: Move FlatView allocation to a
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This moves a FlatView allocation and initialization to a helper.
While we are nere, replace g_new with g_new0 to not to bother if we add
new fields in the future.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-4-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/memory.c b/memory.c
index 3241e44..eec668e 100644
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
@@ -707,8 +709,7 @@ static FlatView *generate_memory_topology(MemoryRegion *mr)
 {
     FlatView *view;
 
-    view = g_new(FlatView, 1);
-    flatview_init(view);
+    view = flatview_new();
 
     if (mr) {
         render_memory_region(view, mr, int128_zero(),
@@ -2629,8 +2630,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
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
1.8.3.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiY-0004vM-5k
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiX-0004VB-5r
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:14 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAiW-0004U6-V3
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:13 -0400
Received: by mail-wm0-x242.google.com with SMTP id m127so6458962wmm.0
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:17:12 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:32 +0200
Message-Id: <1506035800-30509-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 24/32] memory: Share special empty FlatView
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

This shares an cached empty FlatView among address spaces. The empty
FV is used every time when a root MR renders into a FV without memory
sections which happens when MR or its children are not enabled or
zero-sized. The empty_view is not NULL to keep the rest of memory
API intact; it also has a dispatch tree for the same reason.

On POWER8 with 255 CPUs, 255 virtio-net, 40 PCI bridges guest this halves
the amount of FlatView's in use (557 -> 260) and dispatch tables
(~800000 -> ~370000).  In an unrelated experiment with 112 non-virtio
devices on x86 ("-M pc"), only 4 FlatViews are alive, and about ~2000
are created at startup.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-16-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/memory.c b/memory.c
index 15b1bd7..5e6351a 100644
--- a/memory.c
+++ b/memory.c
@@ -317,6 +317,7 @@ static void flatview_unref(FlatView *view)
 {
     if (atomic_fetch_dec(&view->ref) == 1) {
         trace_flatview_destroy_rcu(view, view->root);
+        assert(view->root);
         call_rcu(view, flatview_destroy, rcu);
     }
 }
@@ -761,16 +762,19 @@ static MemoryRegion *memory_region_get_flatview_root(MemoryRegion *mr)
                     }
                 }
             }
+            if (found == 0) {
+                return NULL;
+            }
             if (next) {
                 mr = next;
                 continue;
             }
         }
 
-        break;
+        return mr;
     }
 
-    return mr;
+    return NULL;
 }
 
 /* Render a memory topology into a list of disjoint absolute ranges. */
@@ -966,12 +970,22 @@ static void address_space_update_topology_pass(AddressSpace *as,
 
 static void flatviews_init(void)
 {
+    static FlatView *empty_view;
+
     if (flat_views) {
         return;
     }
 
     flat_views = g_hash_table_new_full(g_direct_hash, g_direct_equal, NULL,
                                        (GDestroyNotify) flatview_unref);
+    if (!empty_view) {
+        empty_view = generate_memory_topology(NULL);
+        /* We keep it alive forever in the global variable.  */
+        flatview_ref(empty_view);
+    } else {
+        g_hash_table_replace(flat_views, NULL, empty_view);
+        flatview_ref(empty_view);
+    }
 }
 
 static void flatviews_reset(void)
-- 
1.8.3.1

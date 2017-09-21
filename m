Received: from eggs.gnu.org ([2001:4830:134:3::10]:39304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv0Gv-0002IU-J7
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv0Gr-00029E-Ue
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:08:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dv0Gr-00026w-NW
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:07:57 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 21 Sep 2017 14:07:51 +0200
Message-Id: <20170921120751.3027-4-pbonzini@redhat.com>
In-Reply-To: <20170921120751.3027-1-pbonzini@redhat.com>
References: <20170921120751.3027-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] memory: Share special empty FlatView
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aik@ozlabs.ru

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This shares an cached empty FlatView among address spaces. The empty
FV is used every time when a root MR would render into a FV without
memory sections, which happens when MR or its children are not enabled
(or zero-sized, which isn't caught yet). The empty_view is not NULL to
keep the rest of memory API intact; it also has a dispatch tree for the
same reason.

On POWER8 with 255 CPUs, 255 virtio-net, 40 PCI bridges guest this halves
the amount of FlatView's in use (557 -> 260) and dispatch tables
(~800000 -> ~370000).  In an unrelated experiment with 112 non-virtio
devices on x86 ("-M pc"), only 4 FlatViews are alive while the guest runs.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-16-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/memory.c b/memory.c
index 3207ae55e2..cb369223b1 100644
--- a/memory.c
+++ b/memory.c
@@ -316,6 +316,7 @@ static void flatview_ref(FlatView *view)
 static void flatview_unref(FlatView *view)
 {
     if (atomic_fetch_dec(&view->ref) == 1) {
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
@@ -962,12 +966,22 @@ static void address_space_update_topology_pass(AddressSpace *as,
 
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
2.13.5

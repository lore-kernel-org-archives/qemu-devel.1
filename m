Received: from eggs.gnu.org ([2001:4830:134:3::10]:49094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCG-0000VJ-KZ
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCD-0000Pm-Gm
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47330
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCD-0000Oy-BC
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:29 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JE3jg015520
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:28 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epn0ac18d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:28 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:17:28 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:17 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-25-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 24/55] memory: Share special empty FlatView
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
(cherry picked from commit 092aa2fc65b7a35121616aad8f39d47b8f921618)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 memory.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/memory.c b/memory.c
index 231bb78fa7..d90853855b 100644
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
@@ -760,16 +761,19 @@ static MemoryRegion *memory_region_get_flatview_root(MemoryRegion *mr)
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
@@ -965,12 +969,22 @@ static void address_space_update_topology_pass(AddressSpace *as,
 
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
2.11.0

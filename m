Received: from eggs.gnu.org ([2001:4830:134:3::10]:56652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmj-00042W-VN
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufme-0005Mr-MX
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:29 -0400
Received: from ozlabs.ru ([107.173.13.209]:59844)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufme-0005M0-BF
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:24 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 20 Sep 2017 21:46:37 +1000
Message-Id: <20170920114637.42004-19-aik@ozlabs.ru>
In-Reply-To: <20170920114637.42004-1-aik@ozlabs.ru>
References: <20170920114637.42004-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v4 18/18] memory: Give
 memory_region_transaction_commit a hint
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

This extends memory_region_transaction_commit() to receive a MR as
if it is a root MR or its topmost parent is, then we can only rebuild
its FlatView and update it for address spaces sharing it.

The optimization gets disabled though if there is full update about to
commit.

memory_region_set_enabled() is a special case here, it does not use
a hint when MR is being disabled.

On POWER8 with 255 CPUs, 255 virtio-net, 40 PCI bridges guest this brings
down the boot time from 20s to 12s, the total memory footprint
goes down (17G -> 8G).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This is an RFC patch, I suppose.

If memory_region_set_enabled() uses the hint all the time (like others),
then 12s become 9s and memory use is about 4.4G but
make check-qtest fails (no idea why):

  GTESTER check-qtest-ppc64
**
ERROR:/home/aik/p/qemu-kvm/tests/boot-order-test.c:40:test_a_boot_order: assertion failed (actual == expected_boot): (0x0
0000000 == 0x00000063)
---
 memory.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/memory.c b/memory.c
index d3b3581990..81a0962844 100644
--- a/memory.c
+++ b/memory.c
@@ -38,6 +38,7 @@
 
 static unsigned memory_region_transaction_depth;
 static bool memory_region_update_pending;
+static bool memory_region_full_update_pending;
 static bool ioeventfd_update_pending;
 static bool global_dirty_log = false;
 
@@ -1040,7 +1041,30 @@ void memory_region_transaction_begin(void)
     ++memory_region_transaction_depth;
 }
 
-void memory_region_transaction_commit(void)
+static bool memory_region_transaction_fast_commit(MemoryRegion *mr)
+{
+    FlatView *old_view, *new_view;
+    MemoryRegion *physmr;
+
+    while (mr->container) {
+        mr = mr->container;
+    }
+
+    physmr = memory_region_get_flatview_root(mr);
+
+    flatviews_init();
+    old_view = g_hash_table_lookup(flat_views, physmr);
+    if (!old_view) {
+        return false;
+    }
+
+    new_view = generate_memory_topology(physmr);
+    g_hash_table_replace(flat_views, physmr, new_view);
+
+    return true;
+}
+
+static void memory_region_transaction_commit_mr(MemoryRegion *mr)
 {
     AddressSpace *as;
 
@@ -1050,7 +1074,10 @@ void memory_region_transaction_commit(void)
     --memory_region_transaction_depth;
     if (!memory_region_transaction_depth) {
         if (memory_region_update_pending) {
-            flatviews_reset();
+            if (memory_region_full_update_pending || !mr ||
+                !memory_region_transaction_fast_commit(mr)) {
+                flatviews_reset();
+            }
 
             MEMORY_LISTENER_CALL_GLOBAL(begin, Forward);
 
@@ -1060,6 +1087,8 @@ void memory_region_transaction_commit(void)
             }
             memory_region_update_pending = false;
             MEMORY_LISTENER_CALL_GLOBAL(commit, Forward);
+            memory_region_full_update_pending = false;
+
         } else if (ioeventfd_update_pending) {
             QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
                 address_space_update_ioeventfds(as);
@@ -1069,6 +1098,12 @@ void memory_region_transaction_commit(void)
    }
 }
 
+void memory_region_transaction_commit(void)
+{
+    memory_region_full_update_pending = true;
+    memory_region_transaction_commit_mr(NULL);
+}
+
 static void memory_region_destructor_none(MemoryRegion *mr)
 {
 }
@@ -1678,7 +1713,7 @@ static void memory_region_finalize(Object *obj)
         MemoryRegion *subregion = QTAILQ_FIRST(&mr->subregions);
         memory_region_del_subregion(mr, subregion);
     }
-    memory_region_transaction_commit();
+    memory_region_transaction_commit_mr(mr);
 
     mr->destructor(mr);
     memory_region_clear_coalescing(mr);
@@ -1903,7 +1938,7 @@ void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
     memory_region_transaction_begin();
     mr->dirty_log_mask = (mr->dirty_log_mask & ~mask) | (log * mask);
     memory_region_update_pending |= mr->enabled;
-    memory_region_transaction_commit();
+    memory_region_transaction_commit_mr(mr);
 }
 
 bool memory_region_get_dirty(MemoryRegion *mr, hwaddr addr,
@@ -1983,7 +2018,7 @@ void memory_region_set_readonly(MemoryRegion *mr, bool readonly)
         memory_region_transaction_begin();
         mr->readonly = readonly;
         memory_region_update_pending |= mr->enabled;
-        memory_region_transaction_commit();
+        memory_region_transaction_commit_mr(mr);
     }
 }
 
@@ -1993,7 +2028,7 @@ void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
         memory_region_transaction_begin();
         mr->romd_mode = romd_mode;
         memory_region_update_pending |= mr->enabled;
-        memory_region_transaction_commit();
+        memory_region_transaction_commit_mr(mr);
     }
 }
 
@@ -2208,7 +2243,7 @@ void memory_region_add_eventfd(MemoryRegion *mr,
             sizeof(*mr->ioeventfds) * (mr->ioeventfd_nb-1 - i));
     mr->ioeventfds[i] = mrfd;
     ioeventfd_update_pending |= mr->enabled;
-    memory_region_transaction_commit();
+    memory_region_transaction_commit_mr(mr);
 }
 
 void memory_region_del_eventfd(MemoryRegion *mr,
@@ -2243,7 +2278,7 @@ void memory_region_del_eventfd(MemoryRegion *mr,
     mr->ioeventfds = g_realloc(mr->ioeventfds,
                                   sizeof(*mr->ioeventfds)*mr->ioeventfd_nb + 1);
     ioeventfd_update_pending |= mr->enabled;
-    memory_region_transaction_commit();
+    memory_region_transaction_commit_mr(mr);
 }
 
 static void memory_region_update_container_subregions(MemoryRegion *subregion)
@@ -2263,7 +2298,7 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
     QTAILQ_INSERT_TAIL(&mr->subregions, subregion, subregions_link);
 done:
     memory_region_update_pending |= mr->enabled && subregion->enabled;
-    memory_region_transaction_commit();
+    memory_region_transaction_commit_mr(mr);
 }
 
 static void memory_region_add_subregion_common(MemoryRegion *mr,
@@ -2302,7 +2337,7 @@ void memory_region_del_subregion(MemoryRegion *mr,
     QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
     memory_region_unref(subregion);
     memory_region_update_pending |= mr->enabled && subregion->enabled;
-    memory_region_transaction_commit();
+    memory_region_transaction_commit_mr(mr);
 }
 
 void memory_region_set_enabled(MemoryRegion *mr, bool enabled)
@@ -2313,7 +2348,7 @@ void memory_region_set_enabled(MemoryRegion *mr, bool enabled)
     memory_region_transaction_begin();
     mr->enabled = enabled;
     memory_region_update_pending = true;
-    memory_region_transaction_commit();
+    memory_region_transaction_commit_mr(enabled ? mr : NULL);
 }
 
 void memory_region_set_size(MemoryRegion *mr, uint64_t size)
@@ -2329,7 +2364,7 @@ void memory_region_set_size(MemoryRegion *mr, uint64_t size)
     memory_region_transaction_begin();
     mr->size = s;
     memory_region_update_pending = true;
-    memory_region_transaction_commit();
+    memory_region_transaction_commit_mr(mr);
 }
 
 static void memory_region_readd_subregion(MemoryRegion *mr)
@@ -2343,7 +2378,7 @@ static void memory_region_readd_subregion(MemoryRegion *mr)
         mr->container = container;
         memory_region_update_container_subregions(mr);
         memory_region_unref(mr);
-        memory_region_transaction_commit();
+        memory_region_transaction_commit_mr(mr);
     }
 }
 
@@ -2366,7 +2401,7 @@ void memory_region_set_alias_offset(MemoryRegion *mr, hwaddr offset)
     memory_region_transaction_begin();
     mr->alias_offset = offset;
     memory_region_update_pending |= mr->enabled;
-    memory_region_transaction_commit();
+    memory_region_transaction_commit_mr(mr);
 }
 
 uint64_t memory_region_get_alignment(const MemoryRegion *mr)
@@ -2654,7 +2689,7 @@ bool memory_region_request_mmio_ptr(MemoryRegion *mr, hwaddr addr)
     host = mr->ops->request_ptr(mr->opaque, addr - mr->addr, &size, &offset);
 
     if (!host || !size) {
-        memory_region_transaction_commit();
+        memory_region_transaction_commit_mr(mr);
         return false;
     }
 
@@ -2666,7 +2701,7 @@ bool memory_region_request_mmio_ptr(MemoryRegion *mr, hwaddr addr)
     qdev_prop_set_ptr(DEVICE(new_interface), "subregion", mr);
     object_property_set_bool(OBJECT(new_interface), true, "realized", NULL);
 
-    memory_region_transaction_commit();
+    memory_region_transaction_commit_mr(mr);
     return true;
 }
 
-- 
2.11.0

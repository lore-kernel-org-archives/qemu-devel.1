Received: from eggs.gnu.org ([2001:4830:134:3::10]:57112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dpszB-00010T-CE
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dpsz7-0007If-03
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:20:33 -0400
Received: from ozlabs.ru ([107.173.13.209]:51158)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dpsz6-0007Hc-LT
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:20:28 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu,  7 Sep 2017 19:20:10 +1000
Message-Id: <20170907092010.3605-5-aik@ozlabs.ru>
In-Reply-To: <20170907092010.3605-1-aik@ozlabs.ru>
References: <20170907092010.3605-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [RFC PATCH qemu 4/4] memory: Add flat views to HMP
 "info mtree"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>

This adds a new switch to "info mtree" to print dispatch tree internals.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

Example:

aik@fstn1-p1:~$ echo "info mtree -f -d" | nc localhost 30000
QEMU 2.9.94 monitor - type 'help' for more information
(qemu) info mtree -f -d
FlatView #0
 AS "memory"
  0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
 AS "cpu-memory"
  0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
 AS "cpu-memory"
  0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
  Dispatch
    Physical sections
      #0 @0000000000000000 root="(noname)" [unassigned]
      #1 @0000000000000000 root="(noname)" [not dirty]
      #2 @0000000000000000 root="(noname)" [ROM]
      #3 @0000000000000000 root="(noname)" [watch]
      #4 @0000000000000000 root="ppc_spapr.ram"
    Nodes (9 bits per level, 6 levels) ptr=[3] skip=4
      [0]
	  0       skip=3  ptr=[3]
	  1..511  skip=1  ptr=NIL
      [1]
	  0       skip=2  ptr=[3]
	  1..511  skip=1  ptr=NIL
      [2]
	  0       skip=1  ptr=[3]
	  1..511  skip=1  ptr=NIL
      [3]
	  0..1    skip=0  ptr=#4
	  2..511  skip=1  ptr=NIL

FlatView #1
 AS "I/O"
  0000000000000000-000000000000ffff (prio 0, i/o): io
  Dispatch
    Physical sections
      #0 @0000000000000000 root="(noname)" [unassigned]
      #1 @0000000000000000 root="(noname)" [not dirty]
      #2 @0000000000000000 root="(noname)" [ROM]
      #3 @0000000000000000 root="(noname)" [watch]
      #4 @0000000000000000 root="io"
    Nodes (9 bits per level, 6 levels) ptr=[5] skip=6
      [0]
	  0       skip=5  ptr=[5]
	  1..511  skip=1  ptr=NIL
      [1]
	  0       skip=4  ptr=[5]
	  1..511  skip=1  ptr=NIL
      [2]
	  0       skip=3  ptr=[5]
	  1..511  skip=1  ptr=NIL
      [3]
	  0       skip=2  ptr=[5]
	  1..511  skip=1  ptr=NIL
      [4]
	  0       skip=1  ptr=[5]
	  1..511  skip=1  ptr=NIL
      [5]
	  0..15   skip=0  ptr=#4
	 16..511  skip=0  ptr=#0

FlatView #2
 AS "pci@800000020000000"
  0000000000000000-000000003fffffff (prio 0, i/o): tce-iommu-80000000
  0000040000000000-000004000000ffff (prio 0, i/o): msi
  Dispatch
    Physical sections
      #0 @0000000000000000 root="(noname)" [unassigned]
      #1 @0000000000000000 root="(noname)" [not dirty]
      #2 @0000000000000000 root="(noname)" [ROM]
      #3 @0000000000000000 root="(noname)" [watch]
      #4 @0000000000000000 root="tce-iommu-80000000"
      #5 @0000040000000000 root="msi"
    Nodes (9 bits per level, 6 levels) ptr=[2] skip=3
      [0]
	  0       skip=2  ptr=[2]
	  1..511  skip=1  ptr=NIL
      [1]
	  0       skip=1  ptr=[2]
	  1..511  skip=1  ptr=NIL
      [2]
	  0       skip=0  ptr=#4
	  1..7    skip=1  ptr=NIL
	  8       skip=3  ptr=[6]
	  9..511  skip=1  ptr=NIL
      [3]
	  0       skip=0  ptr=#4
	  1..511  skip=1  ptr=NIL
      [4]
	  0       skip=2  ptr=[6]
	  1..511  skip=1  ptr=NIL
      [5]
	  0       skip=1  ptr=[6]
	  1..511  skip=1  ptr=NIL
      [6]
	  0..15   skip=0  ptr=#5
	 16..511  skip=0  ptr=#0

(qemu)
---
 include/exec/memory.h |  5 +++-
 exec.c                | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 memory.c              | 20 ++++++++++++----
 monitor.c             |  3 ++-
 hmp-commands-info.hx  |  7 +++---
 5 files changed, 92 insertions(+), 9 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 41ab165302..2a50bbe79f 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1527,7 +1527,10 @@ void memory_global_dirty_log_start(void);
  */
 void memory_global_dirty_log_stop(void);
 
-void mtree_info(fprintf_function mon_printf, void *f, bool flatview);
+void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
+                bool dispatch_tree);
+void mtree_print_dispatch(fprintf_function mon, void *f,
+                          struct AddressSpaceDispatch *d);
 
 /**
  * memory_region_request_mmio_ptr: request a pointer to an mmio
diff --git a/exec.c b/exec.c
index 51243f57f4..8c565e9102 100644
--- a/exec.c
+++ b/exec.c
@@ -3605,3 +3605,69 @@ void page_size_init(void)
     }
     qemu_host_page_mask = -(intptr_t)qemu_host_page_size;
 }
+
+static void mtree_print_phys_entries(fprintf_function mon, void *f,
+                                     int start, int end, int skip, int ptr)
+{
+    if (start == end - 1) {
+        mon(f, "\t%3d      ", start);
+    } else {
+        mon(f, "\t%3d..%-3d ", start, end - 1);
+    }
+    mon(f, " skip=%d ", skip);
+    if (ptr == PHYS_MAP_NODE_NIL) {
+        mon(f, " ptr=NIL");
+    } else if (!skip) {
+        mon(f, " ptr=#%d", ptr);
+    } else {
+        mon(f, " ptr=[%d]", ptr);
+    }
+    mon(f, "\n");
+}
+
+void mtree_print_dispatch(fprintf_function mon, void *f,
+                          AddressSpaceDispatch *d)
+{
+    int i;
+
+    mon(f, "  Dispatch\n");
+    mon(f, "    Physical sections\n");
+
+    for (i = 0; i < d->map.sections_nb; ++i) {
+        MemoryRegionSection *s = d->map.sections + i;
+        const char *names[] = { "[unassigned]", "[not dirty]",
+                                "[ROM]", "[watch]" };
+
+        mon(f, "      #%d @%016lX root=\"%s\" %s\n", i,
+                   s->offset_within_address_space,
+                   s->mr->name ? s->mr->name : "(noname)",
+                   i < ARRAY_SIZE(names) ? names[i] : "");
+    }
+
+    mon(f, "    Nodes (%d bits per level, %d levels) ptr=[%d] skip=%d\n",
+               P_L2_BITS, P_L2_LEVELS, d->phys_map.ptr, d->phys_map.skip);
+    for (i = 0; i < d->map.nodes_nb; ++i) {
+        int j, jprev;
+        PhysPageEntry prev;
+        Node *n = d->map.nodes + i;
+
+        mon(f, "      [%d]\n", i);
+
+        for (j = 0, jprev = 0, prev = *n[0]; j < ARRAY_SIZE(*n); ++j) {
+            PhysPageEntry *pe = *n + j;
+
+            if (pe->ptr == prev.ptr && pe->skip == prev.skip) {
+                continue;
+            }
+
+            mtree_print_phys_entries(mon, f, jprev, j, prev.skip, prev.ptr);
+
+            jprev = j;
+            prev = *pe;
+        }
+
+        if (jprev != ARRAY_SIZE(*n)) {
+            mtree_print_phys_entries(mon, f, jprev, j, prev.skip, prev.ptr);
+        }
+    }
+}
diff --git a/memory.c b/memory.c
index 385a507511..24938036c8 100644
--- a/memory.c
+++ b/memory.c
@@ -2939,16 +2939,28 @@ static void mtree_print_flatview(fprintf_function p, void *f,
     flatview_unref(view);
 }
 
-void mtree_info(fprintf_function mon_printf, void *f, bool flatview)
+void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
+                bool dispatch_tree)
 {
     MemoryRegionListHead ml_head;
     MemoryRegionList *ml, *ml2;
     AddressSpace *as;
+    FlatView *view;
+    int n;
 
     if (flatview) {
-        QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-            mon_printf(f, "address-space (flat view): %s\n", as->name);
-            mtree_print_flatview(mon_printf, f, as);
+        n = 0;
+        QTAILQ_FOREACH(view, &flat_views, flat_views_link) {
+            mon_printf(f, "FlatView #%d\n", n);
+            ++n;
+
+            QTAILQ_FOREACH(as, &view->address_spaces, flat_view_link) {
+                mon_printf(f, " AS \"%s\"\n", as->name);
+                mtree_print_flatview(mon_printf, f, as);
+            }
+            if (dispatch_tree) {
+                mtree_print_dispatch(mon_printf, f, view->dispatch);
+            }
             mon_printf(f, "\n");
         }
         return;
diff --git a/monitor.c b/monitor.c
index e0f880107f..191c4b016d 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1703,8 +1703,9 @@ static void hmp_boot_set(Monitor *mon, const QDict *qdict)
 static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
 {
     bool flatview = qdict_get_try_bool(qdict, "flatview", false);
+    bool dispatch_tree = qdict_get_try_bool(qdict, "dispatch_tree", false);
 
-    mtree_info((fprintf_function)monitor_printf, mon, flatview);
+    mtree_info((fprintf_function)monitor_printf, mon, flatview, dispatch_tree);
 }
 
 static void hmp_info_numa(Monitor *mon, const QDict *qdict)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index d9df238a5f..3d2edff940 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -249,9 +249,10 @@ ETEXI
 
     {
         .name       = "mtree",
-        .args_type  = "flatview:-f",
-        .params     = "[-f]",
-        .help       = "show memory tree (-f: dump flat view for address spaces)",
+        .args_type  = "flatview:-f,dispatch_tree:-d",
+        .params     = "[-f][-d]",
+        .help       = "show memory tree (-f: dump flat view for address spaces;"
+                      "-d: dump dispatch tree, valid with -f only)",
         .cmd        = hmp_info_mtree,
     },
 
-- 
2.11.0

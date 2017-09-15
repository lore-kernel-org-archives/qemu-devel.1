Received: from eggs.gnu.org ([2001:4830:134:3::10]:38279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dsmBA-00072E-BE
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dsmB8-0002ZY-IJ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:40:52 -0400
Received: from ozlabs.ru ([107.173.13.209]:44668)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dsmB8-0002Ql-8x
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:40:50 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri, 15 Sep 2017 18:40:30 +1000
Message-Id: <20170915084030.40988-14-aik@ozlabs.ru>
In-Reply-To: <20170915084030.40988-1-aik@ozlabs.ru>
References: <20170915084030.40988-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v2 13/13] memory: Add flat views to HMP
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>

This adds a new switch to "info mtree" to print dispatch tree internals.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

Example:

aik@fstn1-p1:~$ echo "info mtree -f -d" | nc localhost 30000
QEMU 2.9.94 monitor - type 'help' for more information
(qemu) info mtree -f -d
FlatView #0
 AS "memory"
 AS "cpu-memory"
 AS "cpu-memory"
 AS "cpu-memory"
 AS "cpu-memory"
 AS "cpu-memory"
 AS "cpu-memory"
 AS "cpu-memory"
 AS "cpu-memory"
 Root memory region: system
  0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
  Dispatch
    Physical sections
      #0 @0000000000000000..ffffffffffffffff (noname) [unassigned]
      #1 @0000000000000000..ffffffffffffffff (noname) [not dirty]
      #2 @0000000000000000..ffffffffffffffff (noname) [ROM]
      #3 @0000000000000000..ffffffffffffffff (noname) [watch]
      #4 @0000000000000000..000000007fffffff ppc_spapr.ram [MRU]
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
 Root memory region: io
  0000000000000000-000000000000ffff (prio 0, i/o): io
  Dispatch
    Physical sections
      #0 @0000000000000000..ffffffffffffffff (noname) [unassigned]
      #1 @0000000000000000..ffffffffffffffff (noname) [not dirty]
      #2 @0000000000000000..ffffffffffffffff (noname) [ROM]
      #3 @0000000000000000..ffffffffffffffff (noname) [watch]
      #4 @0000000000000000..000000000000ffff io [ROOT]
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
 Root memory region: pci@800000020000000.iommu-root
  0000000000000000-000000003fffffff (prio 0, i/o): tce-iommu-80000000
  0000040000000000-000004000000ffff (prio 0, i/o): msi
  Dispatch
    Physical sections
      #0 @0000000000000000..ffffffffffffffff (noname) [unassigned]
      #1 @0000000000000000..ffffffffffffffff (noname) [not dirty]
      #2 @0000000000000000..ffffffffffffffff (noname) [ROM]
      #3 @0000000000000000..ffffffffffffffff (noname) [watch]
      #4 @0000000000000000..000000003fffffff tce-iommu-80000000 [iommu]
      #5 @0000040000000000..000004000000ffff msi
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

FlatView #3
 AS ""
 Root memory region: bus master container
---
 include/exec/memory-internal.h |  4 ++
 include/exec/memory.h          |  3 +-
 exec.c                         | 84 ++++++++++++++++++++++++++++++++++++++++++
 memory.c                       | 41 ++++++++++++++++-----
 monitor.c                      |  3 +-
 hmp-commands-info.hx           |  7 ++--
 6 files changed, 128 insertions(+), 14 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index e87a30fcae..07295dba7e 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -36,5 +36,9 @@ AddressSpaceDispatch *address_space_to_dispatch(AddressSpace *as);
 AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv);
 void address_space_dispatch_free(AddressSpaceDispatch *d);
 
+void mtree_print_dispatch(fprintf_function mon, void *f,
+                          struct AddressSpaceDispatch *d,
+                          MemoryRegion *root);
+
 #endif
 #endif
diff --git a/include/exec/memory.h b/include/exec/memory.h
index a550dc21e5..3dd876f01a 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1514,7 +1514,8 @@ void memory_global_dirty_log_start(void);
  */
 void memory_global_dirty_log_stop(void);
 
-void mtree_info(fprintf_function mon_printf, void *f, bool flatview);
+void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
+                bool dispatch_tree);
 
 /**
  * memory_region_request_mmio_ptr: request a pointer to an mmio
diff --git a/exec.c b/exec.c
index 11e0e3c927..a79daf1853 100644
--- a/exec.c
+++ b/exec.c
@@ -3622,3 +3622,87 @@ void page_size_init(void)
     }
     qemu_host_page_mask = -(intptr_t)qemu_host_page_size;
 }
+
+#if !defined(CONFIG_USER_ONLY)
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
+#define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
+                           int128_sub((size), int128_one())) : 0)
+
+void mtree_print_dispatch(fprintf_function mon, void *f,
+                          AddressSpaceDispatch *d, MemoryRegion *root)
+{
+    int i;
+
+    mon(f, "  Dispatch\n");
+    mon(f, "    Physical sections\n");
+
+    for (i = 0; i < d->map.sections_nb; ++i) {
+        MemoryRegionSection *s = d->map.sections + i;
+        const char *names[] = { " [unassigned]", " [not dirty]",
+                                " [ROM]", " [watch]" };
+
+        mon(f, "      #%d @" TARGET_FMT_plx ".." TARGET_FMT_plx " %s%s%s%s%s",
+            i,
+            s->offset_within_address_space,
+            s->offset_within_address_space + MR_SIZE(s->mr->size),
+            s->mr->name ? s->mr->name : "(noname)",
+            i < ARRAY_SIZE(names) ? names[i] : "",
+            s->mr == root ? " [ROOT]" : "",
+            s == d->mru_section ? " [MRU]" : "",
+            s->mr->is_iommu ? " [iommu]" : "");
+
+        if (s->mr->alias) {
+            mon(f, " alias=%s", s->mr->alias->name ?
+                    s->mr->alias->name : "noname");
+        }
+        mon(f, "\n");
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
+
+#endif
diff --git a/memory.c b/memory.c
index 06052e63a0..ad2830a1bb 100644
--- a/memory.c
+++ b/memory.c
@@ -2933,17 +2933,26 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
 }
 
 static void mtree_print_flatview(fprintf_function p, void *f,
-                                 AddressSpace *as)
+                                 FlatView *view)
 {
-    FlatView *view = address_space_get_flatview(as);
     FlatRange *range = &view->ranges[0];
     MemoryRegion *mr;
     int n = view->nr;
+    AddressSpace *as;
+
+    QTAILQ_FOREACH(as, &view->address_spaces, flat_view_link) {
+        p(f, " AS \"%s\"\n", as->name);
+    }
+
+    p(f, " Root memory region: %s", memory_region_name(view->root));
+    if (view->root->alias) {
+        p(f, " alias %s", memory_region_name(view->root->alias));
+    }
+    p(f, "\n");
 
     if (n <= 0) {
         p(f, MTREE_INDENT "No rendered FlatView for "
           "address space '%s'\n", as->name);
-        flatview_unref(view);
         return;
     }
 
@@ -2969,21 +2978,35 @@ static void mtree_print_flatview(fprintf_function p, void *f,
         }
         range++;
     }
-
-    flatview_unref(view);
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
+            flatview_ref(view);
+
+            mon_printf(f, "FlatView #%d\n", n);
+            ++n;
+
+            mtree_print_flatview(mon_printf, f, view);
+#if !defined(CONFIG_USER_ONLY)
+            if (dispatch_tree) {
+                mtree_print_dispatch(mon_printf, f, view->dispatch,
+                                     view->root);
+            }
+#endif
             mon_printf(f, "\n");
+
+            flatview_unref(view);
         }
         return;
     }
diff --git a/monitor.c b/monitor.c
index 058045b3cb..f4856b9268 100644
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
index 1c6772597d..4f1ece93e5 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -250,9 +250,10 @@ ETEXI
 
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

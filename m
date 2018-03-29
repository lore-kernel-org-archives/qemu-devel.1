Received: from eggs.gnu.org ([2001:4830:134:3::10]:52628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1f1O91-0007OL-HR
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 23:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1f1O8x-000857-AQ
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 23:22:31 -0400
Received: from [107.173.13.209] (port=47844 helo=ozlabs.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1f1O8x-00084e-17
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 23:22:27 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 29 Mar 2018 14:21:49 +1100
Message-Id: <20180329032149.44685-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] RFC: memory/hmp: Print owners/parents in
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This adds owners/parents (which are the same, just occasionally
owner==NULL) printing for memory regions; a new '-o' flag
enabled new output.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

Does this look anything useful?

There are cases ("msi", "msix-table", "msix-pba" and probably more) when
it is not clear what owns an MR while they all have an owner (always? mostly?).


"info mtree" example:

address-space: memory
  0000000000000000-ffffffffffffffff (prio 0, i/o): system parent:{obj}
    0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram parent:{obj}
    0000200000000000-000020000000ffff (prio 0, i/o): alias pci@800000020000000.io-alias @pci@800000020000000.io 0000000000000000-000000000000ffff owner:{dev path=/machine/unattached/device[3]}
    0000200080000000-00002000ffffffff (prio 0, i/o): alias pci@800000020000000.mmio32-alias @pci@800000020000000.mmio 0000000080000000-00000000ffffffff owner:{dev path=/machine/unattached/device[3]}
    0000210000000000-000021ffffffffff (prio 0, i/o): alias pci@800000020000000.mmio64-alias @pci@800000020000000.mmio 0000210000000000-000021ffffffffff owner:{dev path=/machine/unattached/device[3]}

address-space: I/O
  0000000000000000-000000000000ffff (prio 0, i/o): io parent:{obj}

address-space: cpu-memory-0
  0000000000000000-ffffffffffffffff (prio 0, i/o): system parent:{obj}
    0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram parent:{obj}
    0000200000000000-000020000000ffff (prio 0, i/o): alias pci@800000020000000.io-alias @pci@800000020000000.io 0000000000000000-000000000000ffff owner:{dev path=/machine/unattached/device[3]}
    0000200080000000-00002000ffffffff (prio 0, i/o): alias pci@800000020000000.mmio32-alias @pci@800000020000000.mmio 0000000080000000-00000000ffffffff owner:{dev path=/machine/unattached/device[3]}
    0000210000000000-000021ffffffffff (prio 0, i/o): alias pci@800000020000000.mmio64-alias @pci@800000020000000.mmio 0000210000000000-000021ffffffffff owner:{dev path=/machine/unattached/device[3]}

address-space: pci@800000020000000
  0000000000000000-ffffffffffffffff (prio 0, i/o): pci@800000020000000.iommu-root owner:{dev path=/machine/unattached/device[3]}
    0000000000000000-ffffffffffffffff (prio 0, i/o): tce-root-80000001 owner:{dev path=/machine/unattached/device[3]/tce-table-80000001}
      0800000000000000-080000007fffffff (prio 0, i/o): tce-iommu-80000001 owner:{dev path=/machine/unattached/device[3]/tce-table-80000001}
    0000000000000000-ffffffffffffffff (prio 0, i/o): tce-root-80000000 owner:{dev path=/machine/unattached/device[3]/tce-table-80000000}
      0000000000000000-000000003fffffff (prio 0, i/o): tce-iommu-80000000 owner:{dev path=/machine/unattached/device[3]/tce-table-80000000}
    0000040000000000-000004000000ffff (prio 0, i/o): msi owner:{dev path=/machine/unattached/device[3]}

address-space: vfio-pci
  0000000000000000-ffffffffffffffff (prio 0, i/o): bus master container owner:{dev id=vfio0001_03_00_0}
    0000000000000000-ffffffffffffffff (prio 0, i/o): alias bus master @pci@800000020000000.iommu-root 0000000000000000-ffffffffffffffff owner:{dev id=vfio0001_03_00_0}

memory-region: pci@800000020000000.io
  0000000000000000-000000000000ffff (prio 0, i/o): pci@800000020000000.io owner:{dev path=/machine/unattached/device[3]}

memory-region: pci@800000020000000.mmio
  0000000000000000-ffffffffffffffff (prio 0, i/o): pci@800000020000000.mmio owner:{dev path=/machine/unattached/device[3]}
    0000210000000000-000021000000ffff (prio 1, i/o): 0001:03:00.0 base BAR 1 owner:{dev id=vfio0001_03_00_0}
      0000210000000000-000021000000ffff (prio 0, i/o): 0001:03:00.0 BAR 1 owner:{dev id=vfio0001_03_00_0}
      000021000000e000-000021000000e5ff (prio 0, i/o): msix-table owner:{dev id=vfio0001_03_00_0}
      000021000000f000-000021000000f00f (prio 0, i/o): msix-pba [disabled] owner:{dev id=vfio0001_03_00_0}
    0000210000040000-000021000007ffff (prio 1, i/o): 0001:03:00.0 base BAR 3 owner:{dev id=vfio0001_03_00_0}
      0000210000040000-000021000007ffff (prio 0, i/o): 0001:03:00.0 BAR 3 owner:{dev id=vfio0001_03_00_0}
        0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0] owner:{dev id=vfio0001_03_00_0}

memory-region: pci@800000020000000.iommu-root
  0000000000000000-ffffffffffffffff (prio 0, i/o): pci@800000020000000.iommu-root owner:{dev path=/machine/unattached/device[3]}
    0000000000000000-ffffffffffffffff (prio 0, i/o): tce-root-80000001 owner:{dev path=/machine/unattached/device[3]/tce-table-80000001}
      0800000000000000-080000007fffffff (prio 0, i/o): tce-iommu-80000001 owner:{dev path=/machine/unattached/device[3]/tce-table-80000001}
    0000000000000000-ffffffffffffffff (prio 0, i/o): tce-root-80000000 owner:{dev path=/machine/unattached/device[3]/tce-table-80000000}
      0000000000000000-000000003fffffff (prio 0, i/o): tce-iommu-80000000 owner:{dev path=/machine/unattached/device[3]/tce-table-80000000}
    0000040000000000-000004000000ffff (prio 0, i/o): msi owner:{dev path=/machine/unattached/device[3]}



Flatviews:


FlatView #0
 AS "pci@800000020000000", root: pci@800000020000000.iommu-root
 AS "vfio-pci", root: bus master container
 Root memory region: pci@800000020000000.iommu-root
  0000000000000000-000000003fffffff (prio 0, i/o): tce-iommu-80000000 owner:{dev path=/machine/unattached/device[3]/tce-table-80000000}
  0000040000000000-000004000000ffff (prio 0, i/o): msi owner:{dev path=/machine/unattached/device[3]}
  0800000000000000-080000007fffffff (prio 0, i/o): tce-iommu-80000001 owner:{dev path=/machine/unattached/device[3]/tce-table-80000001}

FlatView #1
 AS "memory", root: system
 AS "cpu-memory-0", root: system
 Root memory region: system
  0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram parent:{obj}
  0000210000000000-000021000000dfff (prio 0, i/o): 0001:03:00.0 BAR 1 owner:{dev id=vfio0001_03_00_0}
  000021000000e000-000021000000e5ff (prio 0, i/o): msix-table owner:{dev id=vfio0001_03_00_0}
  000021000000e600-000021000000ffff (prio 0, i/o): 0001:03:00.0 BAR 1 @000000000000e600 owner:{dev id=vfio0001_03_00_0}
  0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0] owner:{dev id=vfio0001_03_00_0}

FlatView #2
 AS "I/O", root: io
 Root memory region: io
  0000000000000000-000000000000ffff (prio 0, i/o): io parent:{obj}
---
 include/exec/memory.h |  2 +-
 memory.c              | 80 ++++++++++++++++++++++++++++++++++++++++++++-------
 monitor.c             |  4 ++-
 hmp-commands-info.hx  |  7 +++--
 4 files changed, 78 insertions(+), 15 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 31eae0a..3e9d67c 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1541,7 +1541,7 @@ void memory_global_dirty_log_start(void);
 void memory_global_dirty_log_stop(void);
 
 void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
-                bool dispatch_tree);
+                bool dispatch_tree, bool owner);
 
 /**
  * memory_region_request_mmio_ptr: request a pointer to an mmio
diff --git a/memory.c b/memory.c
index e70b64b..538a57c 100644
--- a/memory.c
+++ b/memory.c
@@ -2830,10 +2830,57 @@ typedef QTAILQ_HEAD(mrqueue, MemoryRegionList) MemoryRegionListHead;
                            int128_sub((size), int128_one())) : 0)
 #define MTREE_INDENT "  "
 
+static void mtree_expand_owner(fprintf_function mon_printf, void *f,
+                               const char *label, Object *obj)
+{
+    DeviceState *dev = (DeviceState *) object_dynamic_cast(obj, TYPE_DEVICE);
+    const char *id = object_property_print(obj, "id", true, NULL);
+    const char *name = object_property_print(obj, "name", true, NULL);
+
+    mon_printf(f, " %s:{", label);
+    if (dev) {
+        mon_printf(f, "dev");
+        if (dev->id) {
+            mon_printf(f, " id=%s", dev->id);
+        }
+    } else {
+        mon_printf(f, "obj");
+    }
+    if (name) {
+        mon_printf(f, " name=%s ", name);
+    }
+    if (id) {
+        mon_printf(f, " id=%s ", id);
+    }
+    if (dev && (!name && !id && !dev->id)) {
+        mon_printf(f, " path=%s", dev->canonical_path);
+    }
+    mon_printf(f, "}");
+}
+
+static void mtree_print_mr_owner(fprintf_function mon_printf, void *f,
+                                 const MemoryRegion *mr)
+{
+    Object *owner = mr->owner;
+    Object *parent = memory_region_owner((MemoryRegion *)mr);
+
+    if (!owner && !parent) {
+        mon_printf(f, " orphan");
+        return;
+    }
+    if (owner) {
+        mtree_expand_owner(mon_printf, f, "owner", owner);
+    }
+    if (parent && parent != owner) {
+        mtree_expand_owner(mon_printf, f, "parent", parent);
+    }
+}
+
 static void mtree_print_mr(fprintf_function mon_printf, void *f,
                            const MemoryRegion *mr, unsigned int level,
                            hwaddr base,
-                           MemoryRegionListHead *alias_print_queue)
+                           MemoryRegionListHead *alias_print_queue,
+                           bool owner)
 {
     MemoryRegionList *new_ml, *ml, *next_ml;
     MemoryRegionListHead submr_print_queue;
@@ -2879,7 +2926,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
         }
         mon_printf(f, TARGET_FMT_plx "-" TARGET_FMT_plx
                    " (prio %d, %s): alias %s @%s " TARGET_FMT_plx
-                   "-" TARGET_FMT_plx "%s\n",
+                   "-" TARGET_FMT_plx "%s",
                    cur_start, cur_end,
                    mr->priority,
                    memory_region_type((MemoryRegion *)mr),
@@ -2888,15 +2935,22 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
                    mr->alias_offset,
                    mr->alias_offset + MR_SIZE(mr->size),
                    mr->enabled ? "" : " [disabled]");
+        if (owner) {
+            mtree_print_mr_owner(mon_printf, f, mr);
+        }
     } else {
         mon_printf(f,
-                   TARGET_FMT_plx "-" TARGET_FMT_plx " (prio %d, %s): %s%s\n",
+                   TARGET_FMT_plx "-" TARGET_FMT_plx " (prio %d, %s): %s%s",
                    cur_start, cur_end,
                    mr->priority,
                    memory_region_type((MemoryRegion *)mr),
                    memory_region_name(mr),
                    mr->enabled ? "" : " [disabled]");
+        if (owner) {
+            mtree_print_mr_owner(mon_printf, f, mr);
+        }
     }
+    mon_printf(f, "\n");
 
     QTAILQ_INIT(&submr_print_queue);
 
@@ -2919,7 +2973,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
 
     QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
         mtree_print_mr(mon_printf, f, ml->mr, level + 1, cur_start,
-                       alias_print_queue);
+                       alias_print_queue, owner);
     }
 
     QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, mrqueue, next_ml) {
@@ -2932,6 +2986,7 @@ struct FlatViewInfo {
     void *f;
     int counter;
     bool dispatch_tree;
+    bool owner;
 };
 
 static void mtree_print_flatview(gpointer key, gpointer value,
@@ -2972,7 +3027,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
         mr = range->mr;
         if (range->offset_in_region) {
             p(f, MTREE_INDENT TARGET_FMT_plx "-"
-              TARGET_FMT_plx " (prio %d, %s): %s @" TARGET_FMT_plx "\n",
+              TARGET_FMT_plx " (prio %d, %s): %s @" TARGET_FMT_plx,
               int128_get64(range->addr.start),
               int128_get64(range->addr.start) + MR_SIZE(range->addr.size),
               mr->priority,
@@ -2981,13 +3036,17 @@ static void mtree_print_flatview(gpointer key, gpointer value,
               range->offset_in_region);
         } else {
             p(f, MTREE_INDENT TARGET_FMT_plx "-"
-              TARGET_FMT_plx " (prio %d, %s): %s\n",
+              TARGET_FMT_plx " (prio %d, %s): %s",
               int128_get64(range->addr.start),
               int128_get64(range->addr.start) + MR_SIZE(range->addr.size),
               mr->priority,
               range->readonly ? "rom" : memory_region_type(mr),
               memory_region_name(mr));
         }
+        if (fvi->owner) {
+            mtree_print_mr_owner(p, f, mr);
+        }
+        p(f, "\n");
         range++;
     }
 
@@ -3013,7 +3072,7 @@ static gboolean mtree_info_flatview_free(gpointer key, gpointer value,
 }
 
 void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
-                bool dispatch_tree)
+                bool dispatch_tree, bool owner)
 {
     MemoryRegionListHead ml_head;
     MemoryRegionList *ml, *ml2;
@@ -3025,7 +3084,8 @@ void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
             .mon_printf = mon_printf,
             .f = f,
             .counter = 0,
-            .dispatch_tree = dispatch_tree
+            .dispatch_tree = dispatch_tree,
+            .owner = owner,
         };
         GArray *fv_address_spaces;
         GHashTable *views = g_hash_table_new(g_direct_hash, g_direct_equal);
@@ -3057,14 +3117,14 @@ void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
 
     QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
         mon_printf(f, "address-space: %s\n", as->name);
-        mtree_print_mr(mon_printf, f, as->root, 1, 0, &ml_head);
+        mtree_print_mr(mon_printf, f, as->root, 1, 0, &ml_head, owner);
         mon_printf(f, "\n");
     }
 
     /* print aliased regions */
     QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
         mon_printf(f, "memory-region: %s\n", memory_region_name(ml->mr));
-        mtree_print_mr(mon_printf, f, ml->mr, 1, 0, &ml_head);
+        mtree_print_mr(mon_printf, f, ml->mr, 1, 0, &ml_head, owner);
         mon_printf(f, "\n");
     }
 
diff --git a/monitor.c b/monitor.c
index 51f4cf4..9d304a5 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1969,8 +1969,10 @@ static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
 {
     bool flatview = qdict_get_try_bool(qdict, "flatview", false);
     bool dispatch_tree = qdict_get_try_bool(qdict, "dispatch_tree", false);
+    bool owner = qdict_get_try_bool(qdict, "owner", false);
 
-    mtree_info((fprintf_function)monitor_printf, mon, flatview, dispatch_tree);
+    mtree_info((fprintf_function)monitor_printf, mon, flatview, dispatch_tree,
+               owner);
 }
 
 static void hmp_info_numa(Monitor *mon, const QDict *qdict)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ddfcd5a..5956495 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -250,10 +250,11 @@ ETEXI
 
     {
         .name       = "mtree",
-        .args_type  = "flatview:-f,dispatch_tree:-d",
-        .params     = "[-f][-d]",
+        .args_type  = "flatview:-f,dispatch_tree:-d,owner:-o",
+        .params     = "[-f][-d][-o]",
         .help       = "show memory tree (-f: dump flat view for address spaces;"
-                      "-d: dump dispatch tree, valid with -f only)",
+                      "-d: dump dispatch tree, valid with -f only);"
+                      "-o: dump region owners/parents",
         .cmd        = hmp_info_mtree,
     },
 
-- 
2.11.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAz-0007eg-W4
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAy-0000zs-F4
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:57 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:51042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAy-0000yV-4V
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:56 -0400
Received: by mail-wm0-x233.google.com with SMTP id e16-v6so10988119wmd.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:56 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:52 +0200
Message-Id: <1530216310-52873-43-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 42/60] memory/hmp: Print owners/parents in "info
 mtree"
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

This adds owners/parents (which are the same, just occasionally
owner==NULL) printing for memory regions; a new '-o' flag
enabled new output.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20180604032511.6980-1-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hmp-commands-info.hx  |  7 ++---
 include/exec/memory.h |  2 +-
 memory.c              | 72 ++++++++++++++++++++++++++++++++++++++++++++-------
 monitor.c             |  4 ++-
 4 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 6db3457..59bdd8f 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -253,10 +253,11 @@ ETEXI
 
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
 
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 050323f..448d41a 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1665,7 +1665,7 @@ void memory_global_dirty_log_start(void);
 void memory_global_dirty_log_stop(void);
 
 void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
-                bool dispatch_tree);
+                bool dispatch_tree, bool owner);
 
 /**
  * memory_region_request_mmio_ptr: request a pointer to an mmio
diff --git a/memory.c b/memory.c
index 21aa57d..e9cd446 100644
--- a/memory.c
+++ b/memory.c
@@ -2858,10 +2858,49 @@ typedef QTAILQ_HEAD(mrqueue, MemoryRegionList) MemoryRegionListHead;
                            int128_sub((size), int128_one())) : 0)
 #define MTREE_INDENT "  "
 
+static void mtree_expand_owner(fprintf_function mon_printf, void *f,
+                               const char *label, Object *obj)
+{
+    DeviceState *dev = (DeviceState *) object_dynamic_cast(obj, TYPE_DEVICE);
+
+    mon_printf(f, " %s:{%s", label, dev ? "dev" : "obj");
+    if (dev && dev->id) {
+        mon_printf(f, " id=%s", dev->id);
+    } else {
+        gchar *canonical_path = object_get_canonical_path(obj);
+        if (canonical_path) {
+            mon_printf(f, " path=%s", canonical_path);
+            g_free(canonical_path);
+        } else {
+            mon_printf(f, " type=%s", object_get_typename(obj));
+        }
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
@@ -2907,7 +2946,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
         }
         mon_printf(f, TARGET_FMT_plx "-" TARGET_FMT_plx
                    " (prio %d, %s): alias %s @%s " TARGET_FMT_plx
-                   "-" TARGET_FMT_plx "%s\n",
+                   "-" TARGET_FMT_plx "%s",
                    cur_start, cur_end,
                    mr->priority,
                    memory_region_type((MemoryRegion *)mr),
@@ -2916,15 +2955,22 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
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
 
@@ -2947,7 +2993,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
 
     QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
         mtree_print_mr(mon_printf, f, ml->mr, level + 1, cur_start,
-                       alias_print_queue);
+                       alias_print_queue, owner);
     }
 
     QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, mrqueue, next_ml) {
@@ -2960,6 +3006,7 @@ struct FlatViewInfo {
     void *f;
     int counter;
     bool dispatch_tree;
+    bool owner;
 };
 
 static void mtree_print_flatview(gpointer key, gpointer value,
@@ -3000,7 +3047,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
         mr = range->mr;
         if (range->offset_in_region) {
             p(f, MTREE_INDENT TARGET_FMT_plx "-"
-              TARGET_FMT_plx " (prio %d, %s): %s @" TARGET_FMT_plx "\n",
+              TARGET_FMT_plx " (prio %d, %s): %s @" TARGET_FMT_plx,
               int128_get64(range->addr.start),
               int128_get64(range->addr.start) + MR_SIZE(range->addr.size),
               mr->priority,
@@ -3009,13 +3056,17 @@ static void mtree_print_flatview(gpointer key, gpointer value,
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
 
@@ -3041,7 +3092,7 @@ static gboolean mtree_info_flatview_free(gpointer key, gpointer value,
 }
 
 void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
-                bool dispatch_tree)
+                bool dispatch_tree, bool owner)
 {
     MemoryRegionListHead ml_head;
     MemoryRegionList *ml, *ml2;
@@ -3053,7 +3104,8 @@ void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
             .mon_printf = mon_printf,
             .f = f,
             .counter = 0,
-            .dispatch_tree = dispatch_tree
+            .dispatch_tree = dispatch_tree,
+            .owner = owner,
         };
         GArray *fv_address_spaces;
         GHashTable *views = g_hash_table_new(g_direct_hash, g_direct_equal);
@@ -3085,14 +3137,14 @@ void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
 
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
index 0730a27..0988eb4 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2007,8 +2007,10 @@ static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
 {
     bool flatview = qdict_get_try_bool(qdict, "flatview", false);
     bool dispatch_tree = qdict_get_try_bool(qdict, "dispatch_tree", false);
+    bool owner = qdict_get_try_bool(qdict, "owner", false);
 
-    mtree_info((fprintf_function)monitor_printf, mon, flatview, dispatch_tree);
+    mtree_info((fprintf_function)monitor_printf, mon, flatview, dispatch_tree,
+               owner);
 }
 
 static void hmp_info_numa(Monitor *mon, const QDict *qdict)
-- 
1.8.3.1

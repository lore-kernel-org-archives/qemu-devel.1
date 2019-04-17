Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BA1C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8FA520835
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FA520835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58450 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGqGD-00011n-2P
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 15:30:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGq4Y-0008V2-R9
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGq4T-0008V0-8i
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:18:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGq4R-0008OP-Aw
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:18:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 118363078ADD
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 19:18:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EADB5D71F;
	Wed, 17 Apr 2019 19:18:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 88F0311329CD; Wed, 17 Apr 2019 21:18:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 21:17:56 +0200
Message-Id: <20190417191805.28198-9-armbru@redhat.com>
In-Reply-To: <20190417191805.28198-1-armbru@redhat.com>
References: <20190417191805.28198-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 17 Apr 2019 19:18:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 08/17] memory: Clean up how mtree_info()
 prints
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417191756.Q6P32mnswyXamGcBZByCR8w9zwFjxi2w6xdD4np9DPE@z>

mtree_info() takes an fprintf()-like callback and a FILE * to pass to
it, and so do its helper functions.  Passing around callback and
argument is rather tiresome.

Its only caller hmp_info_mtree() passes monitor_printf() cast to
fprintf_function and the current monitor cast to FILE *.

The type-punning is technically undefined behaviour, but works in
practice.  Clean up: drop the callback, and call qemu_printf()
instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 exec.c                         |  40 ++++-----
 include/exec/memory-internal.h |   3 +-
 include/exec/memory.h          |   3 +-
 memory.c                       | 156 ++++++++++++++++-----------------
 monitor.c                      |   3 +-
 5 files changed, 98 insertions(+), 107 deletions(-)

diff --git a/exec.c b/exec.c
index 6ab62f4eee..85d15606f1 100644
--- a/exec.c
+++ b/exec.c
@@ -35,6 +35,7 @@
 #include "qemu/timer.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
+#include "qemu/qemu-print.h"
 #if defined(CONFIG_USER_ONLY)
 #include "qemu.h"
 #else /* !CONFIG_USER_ONLY */
@@ -4117,42 +4118,41 @@ void page_size_init(void)
 
 #if !defined(CONFIG_USER_ONLY)
 
-static void mtree_print_phys_entries(fprintf_function mon, void *f,
-                                     int start, int end, int skip, int ptr)
+static void mtree_print_phys_entries(int start, int end, int skip, int ptr)
 {
     if (start == end - 1) {
-        mon(f, "\t%3d      ", start);
+        qemu_printf("\t%3d      ", start);
     } else {
-        mon(f, "\t%3d..%-3d ", start, end - 1);
+        qemu_printf("\t%3d..%-3d ", start, end - 1);
     }
-    mon(f, " skip=%d ", skip);
+    qemu_printf(" skip=%d ", skip);
     if (ptr == PHYS_MAP_NODE_NIL) {
-        mon(f, " ptr=NIL");
+        qemu_printf(" ptr=NIL");
     } else if (!skip) {
-        mon(f, " ptr=#%d", ptr);
+        qemu_printf(" ptr=#%d", ptr);
     } else {
-        mon(f, " ptr=[%d]", ptr);
+        qemu_printf(" ptr=[%d]", ptr);
     }
-    mon(f, "\n");
+    qemu_printf("\n");
 }
 
 #define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
                            int128_sub((size), int128_one())) : 0)
 
-void mtree_print_dispatch(fprintf_function mon, void *f,
-                          AddressSpaceDispatch *d, MemoryRegion *root)
+void mtree_print_dispatch(AddressSpaceDispatch *d, MemoryRegion *root)
 {
     int i;
 
-    mon(f, "  Dispatch\n");
-    mon(f, "    Physical sections\n");
+    qemu_printf("  Dispatch\n");
+    qemu_printf("    Physical sections\n");
 
     for (i = 0; i < d->map.sections_nb; ++i) {
         MemoryRegionSection *s = d->map.sections + i;
         const char *names[] = { " [unassigned]", " [not dirty]",
                                 " [ROM]", " [watch]" };
 
-        mon(f, "      #%d @" TARGET_FMT_plx ".." TARGET_FMT_plx " %s%s%s%s%s",
+        qemu_printf("      #%d @" TARGET_FMT_plx ".." TARGET_FMT_plx
+                    " %s%s%s%s%s",
             i,
             s->offset_within_address_space,
             s->offset_within_address_space + MR_SIZE(s->mr->size),
@@ -4163,20 +4163,20 @@ void mtree_print_dispatch(fprintf_function mon, void *f,
             s->mr->is_iommu ? " [iommu]" : "");
 
         if (s->mr->alias) {
-            mon(f, " alias=%s", s->mr->alias->name ?
+            qemu_printf(" alias=%s", s->mr->alias->name ?
                     s->mr->alias->name : "noname");
         }
-        mon(f, "\n");
+        qemu_printf("\n");
     }
 
-    mon(f, "    Nodes (%d bits per level, %d levels) ptr=[%d] skip=%d\n",
+    qemu_printf("    Nodes (%d bits per level, %d levels) ptr=[%d] skip=%d\n",
                P_L2_BITS, P_L2_LEVELS, d->phys_map.ptr, d->phys_map.skip);
     for (i = 0; i < d->map.nodes_nb; ++i) {
         int j, jprev;
         PhysPageEntry prev;
         Node *n = d->map.nodes + i;
 
-        mon(f, "      [%d]\n", i);
+        qemu_printf("      [%d]\n", i);
 
         for (j = 0, jprev = 0, prev = *n[0]; j < ARRAY_SIZE(*n); ++j) {
             PhysPageEntry *pe = *n + j;
@@ -4185,14 +4185,14 @@ void mtree_print_dispatch(fprintf_function mon, void *f,
                 continue;
             }
 
-            mtree_print_phys_entries(mon, f, jprev, j, prev.skip, prev.ptr);
+            mtree_print_phys_entries(jprev, j, prev.skip, prev.ptr);
 
             jprev = j;
             prev = *pe;
         }
 
         if (jprev != ARRAY_SIZE(*n)) {
-            mtree_print_phys_entries(mon, f, jprev, j, prev.skip, prev.ptr);
+            mtree_print_phys_entries(jprev, j, prev.skip, prev.ptr);
         }
     }
 }
diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index bb08fa4d2f..d1a9dd1ec8 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -45,8 +45,7 @@ AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv);
 void address_space_dispatch_compact(AddressSpaceDispatch *d);
 void address_space_dispatch_free(AddressSpaceDispatch *d);
 
-void mtree_print_dispatch(fprintf_function mon, void *f,
-                          struct AddressSpaceDispatch *d,
+void mtree_print_dispatch(struct AddressSpaceDispatch *d,
                           MemoryRegion *root);
 
 struct page_collection;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 1625913f84..9144a47f57 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1720,8 +1720,7 @@ void memory_global_dirty_log_start(void);
  */
 void memory_global_dirty_log_stop(void);
 
-void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
-                bool dispatch_tree, bool owner);
+void mtree_info(bool flatview, bool dispatch_tree, bool owner);
 
 /**
  * memory_region_dispatch_read: perform a read directly to the specified
diff --git a/memory.c b/memory.c
index 9fbca52e05..bb2b71ee38 100644
--- a/memory.c
+++ b/memory.c
@@ -22,6 +22,7 @@
 #include "qapi/visitor.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
+#include "qemu/qemu-print.h"
 #include "qom/object.h"
 #include "trace-root.h"
 
@@ -2800,46 +2801,43 @@ typedef QTAILQ_HEAD(, MemoryRegionList) MemoryRegionListHead;
                            int128_sub((size), int128_one())) : 0)
 #define MTREE_INDENT "  "
 
-static void mtree_expand_owner(fprintf_function mon_printf, void *f,
-                               const char *label, Object *obj)
+static void mtree_expand_owner(const char *label, Object *obj)
 {
     DeviceState *dev = (DeviceState *) object_dynamic_cast(obj, TYPE_DEVICE);
 
-    mon_printf(f, " %s:{%s", label, dev ? "dev" : "obj");
+    qemu_printf(" %s:{%s", label, dev ? "dev" : "obj");
     if (dev && dev->id) {
-        mon_printf(f, " id=%s", dev->id);
+        qemu_printf(" id=%s", dev->id);
     } else {
         gchar *canonical_path = object_get_canonical_path(obj);
         if (canonical_path) {
-            mon_printf(f, " path=%s", canonical_path);
+            qemu_printf(" path=%s", canonical_path);
             g_free(canonical_path);
         } else {
-            mon_printf(f, " type=%s", object_get_typename(obj));
+            qemu_printf(" type=%s", object_get_typename(obj));
         }
     }
-    mon_printf(f, "}");
+    qemu_printf("}");
 }
 
-static void mtree_print_mr_owner(fprintf_function mon_printf, void *f,
-                                 const MemoryRegion *mr)
+static void mtree_print_mr_owner(const MemoryRegion *mr)
 {
     Object *owner = mr->owner;
     Object *parent = memory_region_owner((MemoryRegion *)mr);
 
     if (!owner && !parent) {
-        mon_printf(f, " orphan");
+        qemu_printf(" orphan");
         return;
     }
     if (owner) {
-        mtree_expand_owner(mon_printf, f, "owner", owner);
+        mtree_expand_owner("owner", owner);
     }
     if (parent && parent != owner) {
-        mtree_expand_owner(mon_printf, f, "parent", parent);
+        mtree_expand_owner("parent", parent);
     }
 }
 
-static void mtree_print_mr(fprintf_function mon_printf, void *f,
-                           const MemoryRegion *mr, unsigned int level,
+static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
                            hwaddr base,
                            MemoryRegionListHead *alias_print_queue,
                            bool owner)
@@ -2855,7 +2853,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
     }
 
     for (i = 0; i < level; i++) {
-        mon_printf(f, MTREE_INDENT);
+        qemu_printf(MTREE_INDENT);
     }
 
     cur_start = base + mr->addr;
@@ -2867,7 +2865,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
      * user who is observing this.
      */
     if (cur_start < base || cur_end < cur_start) {
-        mon_printf(f, "[DETECTED OVERFLOW!] ");
+        qemu_printf("[DETECTED OVERFLOW!] ");
     }
 
     if (mr->alias) {
@@ -2886,35 +2884,35 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
             ml->mr = mr->alias;
             QTAILQ_INSERT_TAIL(alias_print_queue, ml, mrqueue);
         }
-        mon_printf(f, TARGET_FMT_plx "-" TARGET_FMT_plx
-                   " (prio %d, %s%s): alias %s @%s " TARGET_FMT_plx
-                   "-" TARGET_FMT_plx "%s",
-                   cur_start, cur_end,
-                   mr->priority,
-                   mr->nonvolatile ? "nv-" : "",
-                   memory_region_type((MemoryRegion *)mr),
-                   memory_region_name(mr),
-                   memory_region_name(mr->alias),
-                   mr->alias_offset,
-                   mr->alias_offset + MR_SIZE(mr->size),
-                   mr->enabled ? "" : " [disabled]");
+        qemu_printf(TARGET_FMT_plx "-" TARGET_FMT_plx
+                    " (prio %d, %s%s): alias %s @%s " TARGET_FMT_plx
+                    "-" TARGET_FMT_plx "%s",
+                    cur_start, cur_end,
+                    mr->priority,
+                    mr->nonvolatile ? "nv-" : "",
+                    memory_region_type((MemoryRegion *)mr),
+                    memory_region_name(mr),
+                    memory_region_name(mr->alias),
+                    mr->alias_offset,
+                    mr->alias_offset + MR_SIZE(mr->size),
+                    mr->enabled ? "" : " [disabled]");
         if (owner) {
-            mtree_print_mr_owner(mon_printf, f, mr);
+            mtree_print_mr_owner(mr);
         }
     } else {
-        mon_printf(f,
-                   TARGET_FMT_plx "-" TARGET_FMT_plx " (prio %d, %s%s): %s%s",
-                   cur_start, cur_end,
-                   mr->priority,
-                   mr->nonvolatile ? "nv-" : "",
-                   memory_region_type((MemoryRegion *)mr),
-                   memory_region_name(mr),
-                   mr->enabled ? "" : " [disabled]");
+        qemu_printf(TARGET_FMT_plx "-" TARGET_FMT_plx
+                    " (prio %d, %s%s): %s%s",
+                    cur_start, cur_end,
+                    mr->priority,
+                    mr->nonvolatile ? "nv-" : "",
+                    memory_region_type((MemoryRegion *)mr),
+                    memory_region_name(mr),
+                    mr->enabled ? "" : " [disabled]");
         if (owner) {
-            mtree_print_mr_owner(mon_printf, f, mr);
+            mtree_print_mr_owner(mr);
         }
     }
-    mon_printf(f, "\n");
+    qemu_printf("\n");
 
     QTAILQ_INIT(&submr_print_queue);
 
@@ -2936,7 +2934,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
     }
 
     QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
-        mtree_print_mr(mon_printf, f, ml->mr, level + 1, cur_start,
+        mtree_print_mr(ml->mr, level + 1, cur_start,
                        alias_print_queue, owner);
     }
 
@@ -2946,8 +2944,6 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
 }
 
 struct FlatViewInfo {
-    fprintf_function mon_printf;
-    void *f;
     int counter;
     bool dispatch_tree;
     bool owner;
@@ -2959,70 +2955,71 @@ static void mtree_print_flatview(gpointer key, gpointer value,
     FlatView *view = key;
     GArray *fv_address_spaces = value;
     struct FlatViewInfo *fvi = user_data;
-    fprintf_function p = fvi->mon_printf;
-    void *f = fvi->f;
     FlatRange *range = &view->ranges[0];
     MemoryRegion *mr;
     int n = view->nr;
     int i;
     AddressSpace *as;
 
-    p(f, "FlatView #%d\n", fvi->counter);
+    qemu_printf("FlatView #%d\n", fvi->counter);
     ++fvi->counter;
 
     for (i = 0; i < fv_address_spaces->len; ++i) {
         as = g_array_index(fv_address_spaces, AddressSpace*, i);
-        p(f, " AS \"%s\", root: %s", as->name, memory_region_name(as->root));
+        qemu_printf(" AS \"%s\", root: %s",
+                    as->name, memory_region_name(as->root));
         if (as->root->alias) {
-            p(f, ", alias %s", memory_region_name(as->root->alias));
+            qemu_printf(", alias %s", memory_region_name(as->root->alias));
         }
-        p(f, "\n");
+        qemu_printf("\n");
     }
 
-    p(f, " Root memory region: %s\n",
+    qemu_printf(" Root memory region: %s\n",
       view->root ? memory_region_name(view->root) : "(none)");
 
     if (n <= 0) {
-        p(f, MTREE_INDENT "No rendered FlatView\n\n");
+        qemu_printf(MTREE_INDENT "No rendered FlatView\n\n");
         return;
     }
 
     while (n--) {
         mr = range->mr;
         if (range->offset_in_region) {
-            p(f, MTREE_INDENT TARGET_FMT_plx "-"
-              TARGET_FMT_plx " (prio %d, %s%s): %s @" TARGET_FMT_plx,
-              int128_get64(range->addr.start),
-              int128_get64(range->addr.start) + MR_SIZE(range->addr.size),
-              mr->priority,
-              range->nonvolatile ? "nv-" : "",
-              range->readonly ? "rom" : memory_region_type(mr),
-              memory_region_name(mr),
-              range->offset_in_region);
+            qemu_printf(MTREE_INDENT TARGET_FMT_plx "-" TARGET_FMT_plx
+                        " (prio %d, %s%s): %s @" TARGET_FMT_plx,
+                        int128_get64(range->addr.start),
+                        int128_get64(range->addr.start)
+                        + MR_SIZE(range->addr.size),
+                        mr->priority,
+                        range->nonvolatile ? "nv-" : "",
+                        range->readonly ? "rom" : memory_region_type(mr),
+                        memory_region_name(mr),
+                        range->offset_in_region);
         } else {
-            p(f, MTREE_INDENT TARGET_FMT_plx "-"
-              TARGET_FMT_plx " (prio %d, %s%s): %s",
-              int128_get64(range->addr.start),
-              int128_get64(range->addr.start) + MR_SIZE(range->addr.size),
-              mr->priority,
-              range->nonvolatile ? "nv-" : "",
-              range->readonly ? "rom" : memory_region_type(mr),
-              memory_region_name(mr));
+            qemu_printf(MTREE_INDENT TARGET_FMT_plx "-" TARGET_FMT_plx
+                        " (prio %d, %s%s): %s",
+                        int128_get64(range->addr.start),
+                        int128_get64(range->addr.start)
+                        + MR_SIZE(range->addr.size),
+                        mr->priority,
+                        range->nonvolatile ? "nv-" : "",
+                        range->readonly ? "rom" : memory_region_type(mr),
+                        memory_region_name(mr));
         }
         if (fvi->owner) {
-            mtree_print_mr_owner(p, f, mr);
+            mtree_print_mr_owner(mr);
         }
-        p(f, "\n");
+        qemu_printf("\n");
         range++;
     }
 
 #if !defined(CONFIG_USER_ONLY)
     if (fvi->dispatch_tree && view->root) {
-        mtree_print_dispatch(p, f, view->dispatch, view->root);
+        mtree_print_dispatch(view->dispatch, view->root);
     }
 #endif
 
-    p(f, "\n");
+    qemu_printf("\n");
 }
 
 static gboolean mtree_info_flatview_free(gpointer key, gpointer value,
@@ -3037,8 +3034,7 @@ static gboolean mtree_info_flatview_free(gpointer key, gpointer value,
     return true;
 }
 
-void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
-                bool dispatch_tree, bool owner)
+void mtree_info(bool flatview, bool dispatch_tree, bool owner)
 {
     MemoryRegionListHead ml_head;
     MemoryRegionList *ml, *ml2;
@@ -3047,8 +3043,6 @@ void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
     if (flatview) {
         FlatView *view;
         struct FlatViewInfo fvi = {
-            .mon_printf = mon_printf,
-            .f = f,
             .counter = 0,
             .dispatch_tree = dispatch_tree,
             .owner = owner,
@@ -3082,16 +3076,16 @@ void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
     QTAILQ_INIT(&ml_head);
 
     QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-        mon_printf(f, "address-space: %s\n", as->name);
-        mtree_print_mr(mon_printf, f, as->root, 1, 0, &ml_head, owner);
-        mon_printf(f, "\n");
+        qemu_printf("address-space: %s\n", as->name);
+        mtree_print_mr(as->root, 1, 0, &ml_head, owner);
+        qemu_printf("\n");
     }
 
     /* print aliased regions */
     QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
-        mon_printf(f, "memory-region: %s\n", memory_region_name(ml->mr));
-        mtree_print_mr(mon_printf, f, ml->mr, 1, 0, &ml_head, owner);
-        mon_printf(f, "\n");
+        qemu_printf("memory-region: %s\n", memory_region_name(ml->mr));
+        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner);
+        qemu_printf("\n");
     }
 
     QTAILQ_FOREACH_SAFE(ml, &ml_head, mrqueue, ml2) {
diff --git a/monitor.c b/monitor.c
index 1650ceec3a..0819b99ef7 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1907,8 +1907,7 @@ static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
     bool dispatch_tree = qdict_get_try_bool(qdict, "dispatch_tree", false);
     bool owner = qdict_get_try_bool(qdict, "owner", false);
 
-    mtree_info((fprintf_function)monitor_printf, mon, flatview, dispatch_tree,
-               owner);
+    mtree_info(flatview, dispatch_tree, owner);
 }
 
 static void hmp_info_numa(Monitor *mon, const QDict *qdict)
-- 
2.17.2



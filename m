Received: from eggs.gnu.org ([2001:4830:134:3::10]:52404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7fap-0004zw-6a
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7faj-0007ub-BD
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:45:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g7fai-0007sn-Vd
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:45:21 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  3 Oct 2018 15:44:52 +0400
Message-Id: <20181003114454.5662-2-marcandre.lureau@redhat.com>
In-Reply-To: <20181003114454.5662-1-marcandre.lureau@redhat.com>
References: <20181003114454.5662-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] memory: learn about non-volatile memory
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, guangrong.xiao@linux.intel.com

Add a new flag to mark memory region that are used as non-volatile, by
NVDIMM for example. That bit is propagated down to the flat view, and
reflected in HMP info mtree with a "nv-" prefix on the memory type.

This way, guest_phys_blocks_region_add() can skip the NV memory
regions for dumps and TCG memory clear in a following patch.

Cc: dgilbert@redhat.com
Cc: imammedo@redhat.com
Cc: pbonzini@redhat.com
Cc: guangrong.xiao@linux.intel.com
Cc: mst@redhat.com
Cc: xiaoguangrong.eric@gmail.com
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/exec/memory.h    | 25 ++++++++++++++++++++++
 memory.c                 | 45 +++++++++++++++++++++++++++++++---------
 docs/devel/migration.rst |  1 +
 3 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 3a427aacf1..43ffa7fc15 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -355,6 +355,7 @@ struct MemoryRegion {
     bool ram;
     bool subpage;
     bool readonly; /* For RAM regions */
+    bool nonvolatile;
     bool rom_device;
     bool flush_coalesced_mmio;
     bool global_locking;
@@ -480,6 +481,7 @@ static inline FlatView *address_space_to_flatview(Add=
ressSpace *as)
  * @offset_within_address_space: the address of the first byte of the se=
ction
  *     relative to the region's address space
  * @readonly: writes to this section are ignored
+ * @nonvolatile: this section is non-volatile
  */
 struct MemoryRegionSection {
     MemoryRegion *mr;
@@ -488,6 +490,7 @@ struct MemoryRegionSection {
     Int128 size;
     hwaddr offset_within_address_space;
     bool readonly;
+    bool nonvolatile;
 };
=20
 /**
@@ -1170,6 +1173,17 @@ static inline bool memory_region_is_rom(MemoryRegi=
on *mr)
     return mr->ram && mr->readonly;
 }
=20
+/**
+ * memory_region_is_nonvolatile: check whether a memory region is non-vo=
latile
+ *
+ * Returns %true is a memory region is non-volatile memory.
+ *
+ * @mr: the memory region being queried
+ */
+static inline bool memory_region_is_nonvolatile(MemoryRegion *mr)
+{
+    return mr->nonvolatile;
+}
=20
 /**
  * memory_region_get_fd: Get a file descriptor backing a RAM memory regi=
on.
@@ -1341,6 +1355,17 @@ void memory_region_reset_dirty(MemoryRegion *mr, h=
waddr addr,
  */
 void memory_region_set_readonly(MemoryRegion *mr, bool readonly);
=20
+/**
+ * memory_region_set_nonvolatile: Turn a memory region non-volatile
+ *
+ * Allows a memory region to be marked as non-volatile.
+ * only useful on RAM regions.
+ *
+ * @mr: the region being updated.
+ * @nonvolatile: whether rhe region is to be non-volatile.
+ */
+void memory_region_set_nonvolatile(MemoryRegion *mr, bool nonvolatile);
+
 /**
  * memory_region_rom_device_set_romd: enable/disable ROMD mode
  *
diff --git a/memory.c b/memory.c
index d852f1143d..9ff5bb6b7e 100644
--- a/memory.c
+++ b/memory.c
@@ -216,6 +216,7 @@ struct FlatRange {
     uint8_t dirty_log_mask;
     bool romd_mode;
     bool readonly;
+    bool nonvolatile;
 };
=20
 #define FOR_EACH_FLAT_RANGE(var, view)          \
@@ -231,6 +232,7 @@ section_from_flat_range(FlatRange *fr, FlatView *fv)
         .size =3D fr->addr.size,
         .offset_within_address_space =3D int128_get64(fr->addr.start),
         .readonly =3D fr->readonly,
+        .nonvolatile =3D fr->nonvolatile,
     };
 }
=20
@@ -240,7 +242,8 @@ static bool flatrange_equal(FlatRange *a, FlatRange *=
b)
         && addrrange_equal(a->addr, b->addr)
         && a->offset_in_region =3D=3D b->offset_in_region
         && a->romd_mode =3D=3D b->romd_mode
-        && a->readonly =3D=3D b->readonly;
+        && a->readonly =3D=3D b->readonly
+        && a->nonvolatile =3D=3D b->nonvolatile;
 }
=20
 static FlatView *flatview_new(MemoryRegion *mr_root)
@@ -312,7 +315,8 @@ static bool can_merge(FlatRange *r1, FlatRange *r2)
                      int128_make64(r2->offset_in_region))
         && r1->dirty_log_mask =3D=3D r2->dirty_log_mask
         && r1->romd_mode =3D=3D r2->romd_mode
-        && r1->readonly =3D=3D r2->readonly;
+        && r1->readonly =3D=3D r2->readonly
+        && r1->nonvolatile =3D=3D r2->nonvolatile;
 }
=20
 /* Attempt to simplify a view by merging adjacent ranges */
@@ -592,7 +596,8 @@ static void render_memory_region(FlatView *view,
                                  MemoryRegion *mr,
                                  Int128 base,
                                  AddrRange clip,
-                                 bool readonly)
+                                 bool readonly,
+                                 bool nonvolatile)
 {
     MemoryRegion *subregion;
     unsigned i;
@@ -608,6 +613,7 @@ static void render_memory_region(FlatView *view,
=20
     int128_addto(&base, int128_make64(mr->addr));
     readonly |=3D mr->readonly;
+    nonvolatile |=3D mr->nonvolatile;
=20
     tmp =3D addrrange_make(base, mr->size);
=20
@@ -620,13 +626,15 @@ static void render_memory_region(FlatView *view,
     if (mr->alias) {
         int128_subfrom(&base, int128_make64(mr->alias->addr));
         int128_subfrom(&base, int128_make64(mr->alias_offset));
-        render_memory_region(view, mr->alias, base, clip, readonly);
+        render_memory_region(view, mr->alias, base, clip,
+                             readonly, nonvolatile);
         return;
     }
=20
     /* Render subregions in priority order. */
     QTAILQ_FOREACH(subregion, &mr->subregions, subregions_link) {
-        render_memory_region(view, subregion, base, clip, readonly);
+        render_memory_region(view, subregion, base, clip,
+                             readonly, nonvolatile);
     }
=20
     if (!mr->terminates) {
@@ -641,6 +649,7 @@ static void render_memory_region(FlatView *view,
     fr.dirty_log_mask =3D memory_region_get_dirty_log_mask(mr);
     fr.romd_mode =3D mr->romd_mode;
     fr.readonly =3D readonly;
+    fr.nonvolatile =3D nonvolatile;
=20
     /* Render the region itself into any gaps left by the current view. =
*/
     for (i =3D 0; i < view->nr && int128_nz(remain); ++i) {
@@ -726,7 +735,8 @@ static FlatView *generate_memory_topology(MemoryRegio=
n *mr)
=20
     if (mr) {
         render_memory_region(view, mr, int128_zero(),
-                             addrrange_make(int128_zero(), int128_2_64()=
), false);
+                             addrrange_make(int128_zero(), int128_2_64()=
),
+                             false, false);
     }
     flatview_simplify(view);
=20
@@ -2039,6 +2049,16 @@ void memory_region_set_readonly(MemoryRegion *mr, =
bool readonly)
     }
 }
=20
+void memory_region_set_nonvolatile(MemoryRegion *mr, bool nonvolatile)
+{
+    if (mr->nonvolatile !=3D nonvolatile) {
+        memory_region_transaction_begin();
+        mr->nonvolatile =3D nonvolatile;
+        memory_region_update_pending |=3D mr->enabled;
+        memory_region_transaction_commit();
+    }
+}
+
 void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
 {
     if (mr->romd_mode !=3D romd_mode) {
@@ -2489,6 +2509,7 @@ static MemoryRegionSection memory_region_find_rcu(M=
emoryRegion *mr,
     ret.size =3D range.size;
     ret.offset_within_address_space =3D int128_get64(range.start);
     ret.readonly =3D fr->readonly;
+    ret.nonvolatile =3D fr->nonvolatile;
     return ret;
 }
=20
@@ -2839,10 +2860,11 @@ static void mtree_print_mr(fprintf_function mon_p=
rintf, void *f,
             QTAILQ_INSERT_TAIL(alias_print_queue, ml, mrqueue);
         }
         mon_printf(f, TARGET_FMT_plx "-" TARGET_FMT_plx
-                   " (prio %d, %s): alias %s @%s " TARGET_FMT_plx
+                   " (prio %d, %s%s): alias %s @%s " TARGET_FMT_plx
                    "-" TARGET_FMT_plx "%s",
                    cur_start, cur_end,
                    mr->priority,
+                   mr->nonvolatile ? "nv-" : "",
                    memory_region_type((MemoryRegion *)mr),
                    memory_region_name(mr),
                    memory_region_name(mr->alias),
@@ -2854,9 +2876,10 @@ static void mtree_print_mr(fprintf_function mon_pr=
intf, void *f,
         }
     } else {
         mon_printf(f,
-                   TARGET_FMT_plx "-" TARGET_FMT_plx " (prio %d, %s): %s=
%s",
+                   TARGET_FMT_plx "-" TARGET_FMT_plx " (prio %d, %s%s): =
%s%s",
                    cur_start, cur_end,
                    mr->priority,
+                   mr->nonvolatile ? "nv-" : "",
                    memory_region_type((MemoryRegion *)mr),
                    memory_region_name(mr),
                    mr->enabled ? "" : " [disabled]");
@@ -2941,19 +2964,21 @@ static void mtree_print_flatview(gpointer key, gp=
ointer value,
         mr =3D range->mr;
         if (range->offset_in_region) {
             p(f, MTREE_INDENT TARGET_FMT_plx "-"
-              TARGET_FMT_plx " (prio %d, %s): %s @" TARGET_FMT_plx,
+              TARGET_FMT_plx " (prio %d, %s%s): %s @" TARGET_FMT_plx,
               int128_get64(range->addr.start),
               int128_get64(range->addr.start) + MR_SIZE(range->addr.size=
),
               mr->priority,
+              range->nonvolatile ? "nv-" : "",
               range->readonly ? "rom" : memory_region_type(mr),
               memory_region_name(mr),
               range->offset_in_region);
         } else {
             p(f, MTREE_INDENT TARGET_FMT_plx "-"
-              TARGET_FMT_plx " (prio %d, %s): %s",
+              TARGET_FMT_plx " (prio %d, %s%s): %s",
               int128_get64(range->addr.start),
               int128_get64(range->addr.start) + MR_SIZE(range->addr.size=
),
               mr->priority,
+              range->nonvolatile ? "nv-" : "",
               range->readonly ? "rom" : memory_region_type(mr),
               memory_region_name(mr));
         }
diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index 687570754d..e7658ab050 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -435,6 +435,7 @@ Examples of such memory API functions are:
   - memory_region_add_subregion()
   - memory_region_del_subregion()
   - memory_region_set_readonly()
+  - memory_region_set_nonvolatile()
   - memory_region_set_enabled()
   - memory_region_set_address()
   - memory_region_set_alias_offset()
--=20
2.19.0.271.gfe8321ec05

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=uZiT=2V=redhat.com=mst@kernel.org>)
	id 1cn8vJ-00017h-JF
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 15:12:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=uZiT=2V=redhat.com=mst@kernel.org>)
	id 1cn8vG-0008WQ-90
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 15:12:57 -0400
Received: from mail.kernel.org ([198.145.29.136]:59656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=uZiT=2V=redhat.com=mst@kernel.org>)
	id 1cn8vF-0008VO-VR
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 15:12:54 -0400
Date: Sun, 12 Mar 2017 21:12:43 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1489345956-29167-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] memory: use 128 bit in info mtree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Paolo Bonzini <pbonzini@redhat.com>

info mtree is doing 64 bit math to figure out
addresses from offsets, this does not work ncorrectly
incase of overflow.

Overflow usually indicates a guest bug, so this is unusual
but reporting correct addresses makes it easier to discover
what is going on.

Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/qemu/int128.h | 15 +++++++++++++++
 memory.c              | 28 +++++++++++++++++-----------
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/qemu/int128.h b/include/qemu/int128.h
index 5c9890d..8be5328 100644
--- a/include/qemu/int128.h
+++ b/include/qemu/int128.h
@@ -302,4 +302,19 @@ static inline void int128_subfrom(Int128 *a, Int128 b)
 }
 
 #endif /* CONFIG_INT128 */
+
+#define INT128_FMT1_plx "0x%" PRIx64
+#define INT128_FMT2_plx "%015" PRIx64
+
+static inline uint64_t int128_printf1(Int128 a)
+{
+    /* We assume 4 highest bits are clear and safe to ignore */
+    return (int128_gethi(a) << 4) | (int128_getlo(a) >> 60);
+}
+
+static inline uint64_t int128_printf2(Int128 a)
+{
+    return (int128_getlo(a) << 4) >> 4;
+}
+
 #endif /* INT128_H */
diff --git a/memory.c b/memory.c
index d61caee..b73a671 100644
--- a/memory.c
+++ b/memory.c
@@ -2487,13 +2487,14 @@ typedef QTAILQ_HEAD(queue, MemoryRegionList) MemoryRegionListHead;
 
 static void mtree_print_mr(fprintf_function mon_printf, void *f,
                            const MemoryRegion *mr, unsigned int level,
-                           hwaddr base,
+                           Int128 base,
                            MemoryRegionListHead *alias_print_queue)
 {
     MemoryRegionList *new_ml, *ml, *next_ml;
     MemoryRegionListHead submr_print_queue;
     const MemoryRegion *submr;
     unsigned int i;
+    Int128 start, end;
 
     if (!mr) {
         return;
@@ -2503,6 +2504,9 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
         mon_printf(f, MTREE_INDENT);
     }
 
+    start = int128_add(base, int128_make64(mr->addr));
+    end = int128_add(start, mr->size);
+
     if (mr->alias) {
         MemoryRegionList *ml;
         bool found = false;
@@ -2519,11 +2523,12 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
             ml->mr = mr->alias;
             QTAILQ_INSERT_TAIL(alias_print_queue, ml, queue);
         }
-        mon_printf(f, TARGET_FMT_plx "-" TARGET_FMT_plx
+        mon_printf(f, INT128_FMT1_plx INT128_FMT2_plx
+		   "-" INT128_FMT1_plx INT128_FMT2_plx
                    " (prio %d, %s): alias %s @%s " TARGET_FMT_plx
                    "-" TARGET_FMT_plx "%s\n",
-                   base + mr->addr,
-                   base + mr->addr + MR_SIZE(mr->size),
+                   int128_printf1(start), int128_printf2(start),
+                   int128_printf1(end), int128_printf2(end),
                    mr->priority,
                    memory_region_type((MemoryRegion *)mr),
                    memory_region_name(mr),
@@ -2532,10 +2537,11 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
                    mr->alias_offset + MR_SIZE(mr->size),
                    mr->enabled ? "" : " [disabled]");
     } else {
-        mon_printf(f,
-                   TARGET_FMT_plx "-" TARGET_FMT_plx " (prio %d, %s): %s%s\n",
-                   base + mr->addr,
-                   base + mr->addr + MR_SIZE(mr->size),
+        mon_printf(f, INT128_FMT1_plx INT128_FMT2_plx
+		   "-" INT128_FMT1_plx INT128_FMT2_plx
+                   " (prio %d, %s): %s%s\n",
+                   int128_printf1(start), int128_printf2(start),
+                   int128_printf1(end), int128_printf2(end),
                    mr->priority,
                    memory_region_type((MemoryRegion *)mr),
                    memory_region_name(mr),
@@ -2562,7 +2568,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
     }
 
     QTAILQ_FOREACH(ml, &submr_print_queue, queue) {
-        mtree_print_mr(mon_printf, f, ml->mr, level + 1, base + mr->addr,
+        mtree_print_mr(mon_printf, f, ml->mr, level + 1, start,
                        alias_print_queue);
     }
 
@@ -2620,14 +2626,14 @@ void mtree_info(fprintf_function mon_printf, void *f, bool flatview)
 
     QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
         mon_printf(f, "address-space: %s\n", as->name);
-        mtree_print_mr(mon_printf, f, as->root, 1, 0, &ml_head);
+        mtree_print_mr(mon_printf, f, as->root, 1, int128_zero(), &ml_head);
         mon_printf(f, "\n");
     }
 
     /* print aliased regions */
     QTAILQ_FOREACH(ml, &ml_head, queue) {
         mon_printf(f, "memory-region: %s\n", memory_region_name(ml->mr));
-        mtree_print_mr(mon_printf, f, ml->mr, 1, 0, &ml_head);
+        mtree_print_mr(mon_printf, f, ml->mr, 1, int128_zero(), &ml_head);
         mon_printf(f, "\n");
     }
 
-- 
MST

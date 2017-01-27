Received: from eggs.gnu.org ([2001:4830:134:3::10]:33400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qr-0004xe-W3
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qn-0003sI-SL
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:06 -0500
Received: from mail-wj0-x243.google.com ([2a00:1450:400c:c01::243]:33497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6qn-0003qM-La
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:01 -0500
Received: by mail-wj0-x243.google.com with SMTP id un2so6007275wjb.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:01 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:16 +0100
Message-Id: <1485524749-118532-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/41] memory: tune mtree_print_mr() to dump mr
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

We were dumping RW bits for each memory region, that might be confusing.
It'll make more sense to dump the memory region type directly rather
than the RW bits since that's how the bits are derived.

Meanwhile, with some slight cleanup in the function.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1484556005-29701-2-git-send-email-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 48 +++++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/memory.c b/memory.c
index 2bfc37f..c42bde4 100644
--- a/memory.c
+++ b/memory.c
@@ -2450,6 +2450,21 @@ void address_space_destroy(AddressSpace *as)
     call_rcu(as, do_address_space_destroy, rcu);
 }
 
+static const char *memory_region_type(MemoryRegion *mr)
+{
+    if (memory_region_is_ram_device(mr)) {
+        return "ramd";
+    } else if (memory_region_is_romd(mr)) {
+        return "romd";
+    } else if (memory_region_is_rom(mr)) {
+        return "rom";
+    } else if (memory_region_is_ram(mr)) {
+        return "ram";
+    } else {
+        return "i/o";
+    }
+}
+
 typedef struct MemoryRegionList MemoryRegionList;
 
 struct MemoryRegionList {
@@ -2459,6 +2474,10 @@ struct MemoryRegionList {
 
 typedef QTAILQ_HEAD(queue, MemoryRegionList) MemoryRegionListHead;
 
+#define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
+                           int128_sub((size), int128_one())) : 0)
+#define MTREE_INDENT "  "
+
 static void mtree_print_mr(fprintf_function mon_printf, void *f,
                            const MemoryRegion *mr, unsigned int level,
                            hwaddr base,
@@ -2474,7 +2493,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
     }
 
     for (i = 0; i < level; i++) {
-        mon_printf(f, "  ");
+        mon_printf(f, MTREE_INDENT);
     }
 
     if (mr->alias) {
@@ -2494,37 +2513,24 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
             QTAILQ_INSERT_TAIL(alias_print_queue, ml, queue);
         }
         mon_printf(f, TARGET_FMT_plx "-" TARGET_FMT_plx
-                   " (prio %d, %c%c): alias %s @%s " TARGET_FMT_plx
+                   " (prio %d, %s): alias %s @%s " TARGET_FMT_plx
                    "-" TARGET_FMT_plx "%s\n",
                    base + mr->addr,
-                   base + mr->addr
-                   + (int128_nz(mr->size) ?
-                      (hwaddr)int128_get64(int128_sub(mr->size,
-                                                      int128_one())) : 0),
+                   base + mr->addr + MR_SIZE(mr->size),
                    mr->priority,
-                   mr->romd_mode ? 'R' : '-',
-                   !mr->readonly && !(mr->rom_device && mr->romd_mode) ? 'W'
-                                                                       : '-',
+                   memory_region_type((MemoryRegion *)mr),
                    memory_region_name(mr),
                    memory_region_name(mr->alias),
                    mr->alias_offset,
-                   mr->alias_offset
-                   + (int128_nz(mr->size) ?
-                      (hwaddr)int128_get64(int128_sub(mr->size,
-                                                      int128_one())) : 0),
+                   mr->alias_offset + MR_SIZE(mr->size),
                    mr->enabled ? "" : " [disabled]");
     } else {
         mon_printf(f,
-                   TARGET_FMT_plx "-" TARGET_FMT_plx " (prio %d, %c%c): %s%s\n",
+                   TARGET_FMT_plx "-" TARGET_FMT_plx " (prio %d, %s): %s%s\n",
                    base + mr->addr,
-                   base + mr->addr
-                   + (int128_nz(mr->size) ?
-                      (hwaddr)int128_get64(int128_sub(mr->size,
-                                                      int128_one())) : 0),
+                   base + mr->addr + MR_SIZE(mr->size),
                    mr->priority,
-                   mr->romd_mode ? 'R' : '-',
-                   !mr->readonly && !(mr->rom_device && mr->romd_mode) ? 'W'
-                                                                       : '-',
+                   memory_region_type((MemoryRegion *)mr),
                    memory_region_name(mr),
                    mr->enabled ? "" : " [disabled]");
     }
-- 
1.8.3.1

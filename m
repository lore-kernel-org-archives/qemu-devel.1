Received: from eggs.gnu.org ([2001:4830:134:3::10]:48140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cIyeA-0000no-SG
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:10:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cIye9-0003P7-Ry
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:10:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cIye9-0003O9-Jj
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:10:33 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC9E88123D
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 14:10:32 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 19 Dec 2016 22:10:22 +0800
Message-Id: <1482156623-9111-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1482156623-9111-1-git-send-email-peterx@redhat.com>
References: <1482156623-9111-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] memory: provide common macros for
 mtree_print_mr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com

mtree_print_mr() has some common codes. Generalize it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 memory.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/memory.c b/memory.c
index 33110e9..5dcc2e1 100644
--- a/memory.c
+++ b/memory.c
@@ -2450,6 +2450,13 @@ struct MemoryRegionList {
 
 typedef QTAILQ_HEAD(queue, MemoryRegionList) MemoryRegionListHead;
 
+#define MR_CHAR_RD(mr) ((mr)->romd_mode ? 'R' : '-')
+#define MR_CHAR_WR(mr) (!(mr)->readonly && !((mr)->rom_device && \
+                                             (mr)->romd_mode) ? 'W' : '-')
+#define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
+                           int128_sub((size), int128_one())) : 0)
+#define MTREE_INDENT "  "
+
 static void mtree_print_mr(fprintf_function mon_printf, void *f,
                            const MemoryRegion *mr, unsigned int level,
                            hwaddr base,
@@ -2465,7 +2472,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
     }
 
     for (i = 0; i < level; i++) {
-        mon_printf(f, "  ");
+        mon_printf(f, MTREE_INDENT);
     }
 
     if (mr->alias) {
@@ -2488,34 +2495,23 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
                    " (prio %d, %c%c): alias %s @%s " TARGET_FMT_plx
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
+                   MR_CHAR_RD(mr),
+                   MR_CHAR_WR(mr),
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
                    TARGET_FMT_plx "-" TARGET_FMT_plx " (prio %d, %c%c): %s%s\n",
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
+                   MR_CHAR_RD(mr),
+                   MR_CHAR_WR(mr),
                    memory_region_name(mr),
                    mr->enabled ? "" : " [disabled]");
     }
-- 
2.7.4

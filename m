Received: from eggs.gnu.org ([2001:4830:134:3::10]:48164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cIyeD-0000pc-Un
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:10:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cIyeC-0003Pq-W8
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:10:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cIyeC-0003PS-Jq
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:10:36 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D902E4E4E6
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 14:10:35 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 19 Dec 2016 22:10:23 +0800
Message-Id: <1482156623-9111-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1482156623-9111-1-git-send-email-peterx@redhat.com>
References: <1482156623-9111-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] memory: hmp: dump flat view for 'info
 mtree'
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

Dumping flat view will be useful to debug the memory rendering logic,
also it'll be much easier with it to know what memory region is handling
what address range.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 memory.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/memory.c b/memory.c
index 5dcc2e1..a9154aa 100644
--- a/memory.c
+++ b/memory.c
@@ -2545,6 +2545,36 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
     }
 }
 
+static void mtree_print_flatview(fprintf_function p, void *f,
+                                 AddressSpace *as)
+{
+    FlatView *view = address_space_get_flatview(as);
+    FlatRange *range = &view->ranges[0];
+    MemoryRegion *mr;
+    int n = view->nr;
+
+    if (n <= 0) {
+        p(f, MTREE_INDENT "No rendered FlatView for "
+          "address space '%s'\n", as->name);
+        return;
+    }
+
+    p(f, MTREE_INDENT "FlatView (address space '%s'):\n", as->name);
+
+    while (n--) {
+        mr = range->mr;
+        p(f, MTREE_INDENT MTREE_INDENT TARGET_FMT_plx "-"
+          TARGET_FMT_plx " (prio %d, %c%c): %s\n",
+          int128_get64(range->addr.start),
+          int128_get64(range->addr.start) + MR_SIZE(mr->size),
+          mr->priority, MR_CHAR_RD(mr), MR_CHAR_WR(mr),
+          memory_region_name(mr));
+        range++;
+    }
+
+    flatview_unref(view);
+}
+
 void mtree_info(fprintf_function mon_printf, void *f)
 {
     MemoryRegionListHead ml_head;
@@ -2556,6 +2586,7 @@ void mtree_info(fprintf_function mon_printf, void *f)
     QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
         mon_printf(f, "address-space: %s\n", as->name);
         mtree_print_mr(mon_printf, f, as->root, 1, 0, &ml_head);
+        mtree_print_flatview(mon_printf, f, as);
         mon_printf(f, "\n");
     }
 
-- 
2.7.4

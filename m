Received: from eggs.gnu.org ([2001:4830:134:3::10]:56928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cPZFg-0002wf-Eb
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cPZFe-00041Y-JY
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:28:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cPZFe-00040B-CP
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:28:30 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 63E0946291
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 18:28:30 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  6 Jan 2017 18:28:11 +0000
Message-Id: <20170106182823.1960-4-dgilbert@redhat.com>
In-Reply-To: <20170106182823.1960-1-dgilbert@redhat.com>
References: <20170106182823.1960-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 03/15] postcopy: Chunk discards for hugepages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, amit.shah@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

At the start of the postcopy phase, partially sent huge pages
must be discarded.  The code for dealing with host page sizes larger
than the target page size can be reused for this case.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 40fe888..c9d8290 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1635,12 +1635,17 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
 {
     unsigned long *bitmap;
     unsigned long *unsentmap;
-    unsigned int host_ratio = qemu_host_page_size / TARGET_PAGE_SIZE;
+    unsigned int host_ratio = block->page_size / TARGET_PAGE_SIZE;
     unsigned long first = block->offset >> TARGET_PAGE_BITS;
     unsigned long len = block->used_length >> TARGET_PAGE_BITS;
     unsigned long last = first + (len - 1);
     unsigned long run_start;
 
+    if (block->page_size == TARGET_PAGE_SIZE) {
+        /* Easy case - TPS==HPS for a non-huge page RAMBlock */
+        return;
+    }
+
     bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
     unsentmap = atomic_rcu_read(&migration_bitmap_rcu)->unsentmap;
 
@@ -1744,7 +1749,8 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
  * Utility for the outgoing postcopy code.
  *
  * Discard any partially sent host-page size chunks, mark any partially
- * dirty host-page size chunks as all dirty.
+ * dirty host-page size chunks as all dirty.  In this case the host-page
+ * is the host-page for the particular RAMBlock, i.e. it might be a huge page
  *
  * Returns: 0 on success
  */
@@ -1752,11 +1758,6 @@ static int postcopy_chunk_hostpages(MigrationState *ms)
 {
     struct RAMBlock *block;
 
-    if (qemu_host_page_size == TARGET_PAGE_SIZE) {
-        /* Easy case - TPS==HPS - nothing to be done */
-        return 0;
-    }
-
     /* Easiest way to make sure we don't resume in the middle of a host-page */
     last_seen_block = NULL;
     last_sent_block = NULL;
@@ -1812,7 +1813,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
         return -EINVAL;
     }
 
-    /* Deal with TPS != HPS */
+    /* Deal with TPS != HPS and huge pages */
     ret = postcopy_chunk_hostpages(ms);
     if (ret) {
         rcu_read_unlock();
-- 
2.9.3

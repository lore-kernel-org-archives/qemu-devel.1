Received: from eggs.gnu.org ([2001:4830:134:3::10]:45334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canA9-0003t6-UB
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canA8-0006Oz-W2
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1canA8-0006OQ-RT
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:12 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F1AB8123A
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 17:33:13 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon,  6 Feb 2017 17:32:53 +0000
Message-Id: <20170206173306.20603-4-dgilbert@redhat.com>
In-Reply-To: <20170206173306.20603-1-dgilbert@redhat.com>
References: <20170206173306.20603-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/16] postcopy: Chunk discards for hugepages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

At the start of the postcopy phase, partially sent huge pages
must be discarded.  The code for dealing with host page sizes larger
than the target page size can be reused for this case.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5726563..d33bd21 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1627,12 +1627,17 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
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
 
@@ -1736,7 +1741,8 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
  * Utility for the outgoing postcopy code.
  *
  * Discard any partially sent host-page size chunks, mark any partially
- * dirty host-page size chunks as all dirty.
+ * dirty host-page size chunks as all dirty.  In this case the host-page
+ * is the host-page for the particular RAMBlock, i.e. it might be a huge page
  *
  * Returns: 0 on success
  */
@@ -1744,11 +1750,6 @@ static int postcopy_chunk_hostpages(MigrationState *ms)
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
@@ -1804,7 +1805,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
         return -EINVAL;
     }
 
-    /* Deal with TPS != HPS */
+    /* Deal with TPS != HPS and huge pages */
     ret = postcopy_chunk_hostpages(ms);
     if (ret) {
         rcu_read_unlock();
-- 
2.9.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0wiU-0004eA-MY
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0wiT-0007LH-N8
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0wiT-0007Kv-F8
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 531759D50D
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 21:00:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 19 Apr 2017 22:59:13 +0200
Message-Id: <20170419205923.8808-50-quintela@redhat.com>
In-Reply-To: <20170419205923.8808-1-quintela@redhat.com>
References: <20170419205923.8808-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 49/59] ram: Remember last_page instead of
 last_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

Improve comment
Fix typo

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 52ab14b..5b2045d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -171,8 +171,8 @@ struct RAMState {
     RAMBlock *last_seen_block;
     /* Last block from where we have sent data */
     RAMBlock *last_sent_block;
-    /* Last offset we have sent data from */
-    ram_addr_t last_offset;
+    /* Last dirty targe page we have sent */
+    ram_addr_t last_page;
     /* last ram version we have seen */
     uint32_t last_version;
     /* We are in the first round */
@@ -1061,7 +1061,7 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss,
     pss->offset = migration_bitmap_find_dirty(rs, pss->block, pss->offset,
                                               page_abs);
     if (pss->complete_round && pss->block == rs->last_seen_block &&
-        pss->offset >= rs->last_offset) {
+        (pss->offset >> TARGET_PAGE_BITS) >= rs->last_page) {
         /*
          * We've been once around the RAM and haven't found anything.
          * Give up.
@@ -1402,7 +1402,7 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
     }
 
     pss.block = rs->last_seen_block;
-    pss.offset = rs->last_offset;
+    pss.offset = rs->last_page << TARGET_PAGE_BITS;
     pss.complete_round = false;
 
     if (!pss.block) {
@@ -1424,7 +1424,7 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
     } while (!pages && again);
 
     rs->last_seen_block = pss.block;
-    rs->last_offset = pss.offset;
+    rs->last_page = pss.offset >> TARGET_PAGE_BITS;
 
     return pages;
 }
@@ -1499,7 +1499,7 @@ static void ram_state_reset(RAMState *rs)
 {
     rs->last_seen_block = NULL;
     rs->last_sent_block = NULL;
-    rs->last_offset = 0;
+    rs->last_page = 0;
     rs->last_version = ram_list.version;
     rs->ram_bulk_stage = true;
 }
@@ -1844,7 +1844,7 @@ static int postcopy_chunk_hostpages(MigrationState *ms)
     /* Easiest way to make sure we don't resume in the middle of a host-page */
     rs->last_seen_block = NULL;
     rs->last_sent_block = NULL;
-    rs->last_offset     = 0;
+    rs->last_page = 0;
 
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
         unsigned long first = block->offset >> TARGET_PAGE_BITS;
-- 
2.9.3

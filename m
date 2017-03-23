Received: from eggs.gnu.org ([2001:4830:134:3::10]:46027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9dI-00005A-2m
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9dH-0000iW-Ba
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9dH-0000iP-5p
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B56881F07
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:46:55 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:39 +0100
Message-Id: <20170323204544.12015-47-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 46/51] ram: Remember last_page instead of
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
---
 migration/ram.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index b1a031e..57b776b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -171,8 +171,8 @@ struct RAMState {
     RAMBlock *last_seen_block;
     /* Last block from where we have sent data */
     RAMBlock *last_sent_block;
-    /* Last offset we have sent data from */
-    ram_addr_t last_offset;
+    /* Last dirty page we have sent */
+    ram_addr_t last_page;
     /* last ram version we have seen */
     uint32_t last_version;
     /* We are in the first round */
@@ -1063,7 +1063,7 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss,
     pss->offset = migration_bitmap_find_dirty(rs, pss->block, pss->offset,
                                               page);
     if (pss->complete_round && pss->block == rs->last_seen_block &&
-        pss->offset >= rs->last_offset) {
+        pss->offset >= rs->last_page) {
         /*
          * We've been once around the RAM and haven't found anything.
          * Give up.
@@ -1396,7 +1396,7 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
     }
 
     pss.block = rs->last_seen_block;
-    pss.offset = rs->last_offset;
+    pss.offset = rs->last_page << TARGET_PAGE_BITS;
     pss.complete_round = false;
 
     if (!pss.block) {
@@ -1418,7 +1418,7 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
     } while (!pages && again);
 
     rs->last_seen_block = pss.block;
-    rs->last_offset = pss.offset;
+    rs->last_page = pss.offset >> TARGET_PAGE_BITS;
 
     return pages;
 }
@@ -1493,7 +1493,7 @@ static void ram_state_reset(RAMState *rs)
 {
     rs->last_seen_block = NULL;
     rs->last_sent_block = NULL;
-    rs->last_offset = 0;
+    rs->last_page = 0;
     rs->last_version = ram_list.version;
     rs->ram_bulk_stage = true;
 }
@@ -1838,7 +1838,7 @@ static int postcopy_chunk_hostpages(MigrationState *ms)
     /* Easiest way to make sure we don't resume in the middle of a host-page */
     rs->last_seen_block = NULL;
     rs->last_sent_block = NULL;
-    rs->last_offset     = 0;
+    rs->last_page = 0;
 
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
         unsigned long first = block->offset >> TARGET_PAGE_BITS;
-- 
2.9.3

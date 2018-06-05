Received: from eggs.gnu.org ([2001:4830:134:3::10]:37198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQEmN-0000s4-AN
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQEmK-0004xj-53
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:25:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53554 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fQEmK-0004xU-0O
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:25:48 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  5 Jun 2018 17:25:44 +0100
Message-Id: <20180605162545.80778-2-dgilbert@redhat.com>
In-Reply-To: <20180605162545.80778-1-dgilbert@redhat.com>
References: <20180605162545.80778-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] migration: Fixes for non-migratable
 RAMBlocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, clg@kaod.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

There are still a few cases where migration code is using the macros
and functions that do all RAMBlocks rather than just the migratable
blocks; fix those up.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c  | 4 ++--
 migration/rdma.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index a500015a2f..a7807cea84 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2516,7 +2516,7 @@ static void ram_state_resume_prepare(RAMState *rs, QEMUFile *out)
      * about dirty page logging as well.
      */
 
-    RAMBLOCK_FOREACH(block) {
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
         pages += bitmap_count_one(block->bmap,
                                   block->used_length >> TARGET_PAGE_BITS);
     }
@@ -3431,7 +3431,7 @@ static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
 
     trace_ram_dirty_bitmap_sync_start();
 
-    RAMBLOCK_FOREACH(block) {
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
         qemu_savevm_send_recv_bitmap(file, block->idstr);
         trace_ram_dirty_bitmap_request(block->idstr);
         ramblock_count++;
diff --git a/migration/rdma.c b/migration/rdma.c
index 05aee3d591..8bd7159059 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -635,7 +635,7 @@ static int qemu_rdma_init_ram_blocks(RDMAContext *rdma)
 
     assert(rdma->blockmap == NULL);
     memset(local, 0, sizeof *local);
-    qemu_ram_foreach_block(qemu_rdma_init_one_block, rdma);
+    qemu_ram_foreach_migratable_block(qemu_rdma_init_one_block, rdma);
     trace_qemu_rdma_init_ram_blocks(local->nb_blocks);
     rdma->dest_blocks = g_new0(RDMADestBlock,
                                rdma->local_ram_blocks.nb_blocks);
-- 
2.17.0

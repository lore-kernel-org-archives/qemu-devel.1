Received: from eggs.gnu.org ([2001:4830:134:3::10]:58898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNDd-0005Bg-Ts
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNDd-00025F-2f
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:25:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37886 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGNDc-00024m-Py
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:25:12 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  9 May 2018 13:24:04 +0200
Message-Id: <20180509112406.6183-40-quintela@redhat.com>
In-Reply-To: <20180509112406.6183-1-quintela@redhat.com>
References: <20180509112406.6183-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 39/41] migration: update index field when delete
 or qsort RDMALocalBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Lidong Chen <jemmy858585@gmail.com>, Lidong Chen <lidongchen@tencent.com>

From: Lidong Chen <jemmy858585@gmail.com>

rdma_delete_block function deletes RDMALocalBlock base on index field,
but not update the index field. So when next time invoke rdma_delete_block,
it will not work correctly.

If start and cancel migration repeatedly, some RDMALocalBlock not invoke
ibv_dereg_mr to decrease kernel mm_struct vmpin. When vmpin is large than
max locked memory limitation, ibv_reg_mr will failed, and migration can not
start successfully again.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <1525618499-1560-1-git-send-email-lidongchen@tencent.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>

Signed-off-by: Lidong Chen <jemmy858585@gmail.com>
---
 migration/rdma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index da474fc19f..7d233b0820 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -708,6 +708,9 @@ static int rdma_delete_block(RDMAContext *rdma, RDMALocalBlock *block)
             memcpy(local->block + block->index, old + (block->index + 1),
                 sizeof(RDMALocalBlock) *
                     (local->nb_blocks - (block->index + 1)));
+            for (x = block->index; x < local->nb_blocks - 1; x++) {
+                local->block[x].index--;
+            }
         }
     } else {
         assert(block == local->block);
@@ -3246,6 +3249,10 @@ static int qemu_rdma_registration_handle(QEMUFile *f, void *opaque)
             qsort(rdma->local_ram_blocks.block,
                   rdma->local_ram_blocks.nb_blocks,
                   sizeof(RDMALocalBlock), dest_ram_sort_func);
+            for (i = 0; i < local->nb_blocks; i++) {
+                local->block[i].index = i;
+            }
+
             if (rdma->pin_all) {
                 ret = qemu_rdma_reg_whole_ram_blocks(rdma);
                 if (ret) {
-- 
2.17.0

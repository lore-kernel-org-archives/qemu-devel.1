Received: from eggs.gnu.org ([2001:4830:134:3::10]:52024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fFL5J-0003b1-Iy
	for qemu-devel@nongnu.org; Sun, 06 May 2018 10:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fFL5E-0000aN-Ok
	for qemu-devel@nongnu.org; Sun, 06 May 2018 10:56:21 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fFL5E-0000ZS-I9
	for qemu-devel@nongnu.org; Sun, 06 May 2018 10:56:16 -0400
Received: by mail-pf0-x244.google.com with SMTP id a14so20880344pfi.1
	for <qemu-devel@nongnu.org>; Sun, 06 May 2018 07:56:16 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Sun,  6 May 2018 22:54:58 +0800
Message-Id: <1525618499-1560-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH 1/2] migration: update index field when delete
 or qsort RDMALocalBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, dgilbert@redhat.com
Cc: qemu-devel@nongnu.org, galsha@mellanox.com, aviadye@mellanox.com, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

rdma_delete_block function deletes RDMALocalBlock base on index field,
but not update the index field. So when next time invoke rdma_delete_block,
it will not work correctly.

If start and cancel migration repeatedly, some RDMALocalBlock not invoke
ibv_dereg_mr to decrease kernel mm_struct vmpin. When vmpin is large than
max locked memory limitation, ibv_reg_mr will failed, and migration can not
start successfully again.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 migration/rdma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index ed9cfb1..0dd4033 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -713,6 +713,9 @@ static int rdma_delete_block(RDMAContext *rdma, RDMALocalBlock *block)
             memcpy(local->block + block->index, old + (block->index + 1),
                 sizeof(RDMALocalBlock) *
                     (local->nb_blocks - (block->index + 1)));
+            for (x = block->index; x < local->nb_blocks - 1; x++) {
+                local->block[x].index--;
+            }
         }
     } else {
         assert(block == local->block);
@@ -3398,6 +3401,10 @@ static int qemu_rdma_registration_handle(QEMUFile *f, void *opaque)
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
1.8.3.1

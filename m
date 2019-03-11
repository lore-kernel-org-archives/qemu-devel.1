Received: from eggs.gnu.org ([209.51.188.92]:39110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1h3MaT-0008NY-IK
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1h3MaS-0001nV-LE
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:11:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:59318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <keith.busch@intel.com>)
	id 1h3MaR-0001er-MV
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:11:32 -0400
From: Keith Busch <keith.busch@intel.com>
Date: Mon, 11 Mar 2019 09:11:53 -0600
Message-Id: <20190311151153.10516-1-keith.busch@intel.com>
Subject: [Qemu-devel] [PATCH] nvme: fix write zeroes offset and count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>

The implementation used blocks units rather than the expected bytes.

Fixes: c03e7ef12a9 ("nvme: Implement Write Zeroes")
Reported-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 hw/block/nvme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 7c8c63e8f5..e8fe8f1ddd 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -324,8 +324,8 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     const uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
     uint64_t slba = le64_to_cpu(rw->slba);
     uint32_t nlb  = le16_to_cpu(rw->nlb) + 1;
-    uint64_t aio_slba = slba << (data_shift - BDRV_SECTOR_BITS);
-    uint32_t aio_nlb = nlb << (data_shift - BDRV_SECTOR_BITS);
+    uint64_t offset = slba << data_shift;
+    uint32_t count = nlb << data_shift;
 
     if (unlikely(slba + nlb > ns->id_ns.nsze)) {
         trace_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
@@ -335,7 +335,7 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     req->has_sg = false;
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
                      BLOCK_ACCT_WRITE);
-    req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, aio_slba, aio_nlb,
+    req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
                                         BDRV_REQ_MAY_UNMAP, nvme_rw_cb, req);
     return NVME_NO_COMPLETE;
 }
-- 
2.14.4

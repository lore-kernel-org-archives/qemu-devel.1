Received: from eggs.gnu.org ([2001:4830:134:3::10]:50514)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<BATV+019e3b66d60b86b6da8a+4908+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1cYGTE-0000oI-Dg
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:14:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<BATV+019e3b66d60b86b6da8a+4908+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1cYGTA-0001SJ-Q2
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:14:28 -0500
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 30 Jan 2017 19:13:51 +0100
Message-Id: <1485800032-24404-2-git-send-email-hch@lst.de>
In-Reply-To: <1485800032-24404-1-git-send-email-hch@lst.de>
References: <1485800032-24404-1-git-send-email-hch@lst.de>
Subject: [Qemu-devel] [PATCH 1/2] nvme: implement the DSM command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: keith.busch@intel.com, qemu-block@nongnu.org

Support deallocating of LBAs using the DSM command by wiring it up to
the qemu discard implementation.  The other DSM operations which are
purely advisory are ignored for now.

Based on an implementation by Keith Busch in the qemu-nvme.git repository,
but rewritten to use the qemu AIO infrastructure properly to not block
the main thread on discard requests, and cleaned up a little bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 hw/block/nvme.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/block/nvme.h |  1 +
 2 files changed, 88 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index d479fd2..d2f1d9a 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -227,6 +227,90 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     return NVME_NO_COMPLETE;
 }
 
+static void nvme_discard_cb(void *opaque, int ret)
+{
+    NvmeRequest *req = opaque;
+    NvmeSQueue *sq = req->sq;
+    NvmeCtrl *n = sq->ctrl;
+    NvmeCQueue *cq = n->cq[sq->cqid];
+
+    if (ret) {
+        req->status = NVME_INTERNAL_DEV_ERROR;
+    }
+
+    if (--req->aio_inflight > 0) {
+        return;
+    }
+
+    nvme_enqueue_req_completion(cq, req);
+}
+
+
+static uint16_t nvme_dsm_discard(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
+    NvmeRequest *req)
+{
+    uint16_t nr = (le32_to_cpu(cmd->cdw10) & 0xff) + 1;
+    uint8_t lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
+    uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds - BDRV_SECTOR_BITS;
+    NvmeDsmRange *range;
+    QEMUSGList qsg;
+    int i;
+
+    range = g_new(NvmeDsmRange, nr);
+
+    if (nvme_map_prp(&qsg, le64_to_cpu(cmd->prp1), le64_to_cpu(cmd->prp2),
+            sizeof(range), n)) {
+        goto out_free_range;
+    }
+
+    if (dma_buf_write((uint8_t *)range, sizeof(range), &qsg)) {
+        goto out_destroy_qsg;
+    }
+
+    qemu_sglist_destroy(&qsg);
+
+    req->status = NVME_SUCCESS;
+    req->has_sg = false;
+    req->aio_inflight = 1;
+
+    for (i = 0; i < nr; i++) {
+        uint64_t slba = le64_to_cpu(range[i].slba);
+        uint32_t nlb = le32_to_cpu(range[i].nlb);
+
+        if (slba + nlb > le64_to_cpu(ns->id_ns.nsze)) {
+            return NVME_LBA_RANGE | NVME_DNR;
+        }
+
+        req->aio_inflight++;
+        req->aiocb = blk_aio_pdiscard(n->conf.blk, slba << data_shift,
+                                      nlb << data_shift, nvme_discard_cb, req);
+    }
+
+    g_free(range);
+
+    if (--req->aio_inflight > 0) {
+        return NVME_NO_COMPLETE;
+    }
+
+    return NVME_SUCCESS;
+
+out_destroy_qsg:
+    qemu_sglist_destroy(&qsg);
+out_free_range:
+    g_free(range);
+    return NVME_INVALID_FIELD | NVME_DNR;
+}
+
+static uint16_t nvme_dsm(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
+    NvmeRequest *req)
+{
+    if (cmd->cdw11 & cpu_to_le32(NVME_DSMGMT_AD)) {
+        return nvme_dsm_discard(n, ns, cmd, req);
+    } else {
+        return NVME_SUCCESS;
+    }
+}
+
 static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     NvmeRequest *req)
 {
@@ -279,6 +363,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     switch (cmd->opcode) {
     case NVME_CMD_FLUSH:
         return nvme_flush(n, ns, cmd, req);
+    case NVME_CMD_DSM:
+        return nvme_dsm(n, ns, cmd, req);
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
         return nvme_rw(n, ns, cmd, req);
@@ -889,6 +975,7 @@ static int nvme_init(PCIDevice *pci_dev)
     id->sqes = (0x6 << 4) | 0x6;
     id->cqes = (0x4 << 4) | 0x4;
     id->nn = cpu_to_le32(n->num_namespaces);
+    id->oncs = cpu_to_le16(NVME_ONCS_DSM);
     id->psd[0].mp = cpu_to_le16(0x9c4);
     id->psd[0].enlat = cpu_to_le32(0x10);
     id->psd[0].exlat = cpu_to_le32(0x4);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 8fb0c10..e64a758 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -640,6 +640,7 @@ typedef struct NvmeRequest {
     BlockAIOCB              *aiocb;
     uint16_t                status;
     bool                    has_sg;
+    uint32_t                aio_inflight;
     NvmeCqe                 cqe;
     BlockAcctCookie         acct;
     QEMUSGList              qsg;
-- 
2.1.4

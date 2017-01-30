Received: from eggs.gnu.org ([2001:4830:134:3::10]:50517)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<BATV+019e3b66d60b86b6da8a+4908+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1cYGTE-0000oK-Ez
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:14:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<BATV+019e3b66d60b86b6da8a+4908+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1cYGTA-0001SO-Po
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:14:28 -0500
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 30 Jan 2017 19:13:52 +0100
Message-Id: <1485800032-24404-3-git-send-email-hch@lst.de>
In-Reply-To: <1485800032-24404-1-git-send-email-hch@lst.de>
References: <1485800032-24404-1-git-send-email-hch@lst.de>
Subject: [Qemu-devel] [PATCH 2/2] nvme: Implement Write Zeroes
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

From: Keith Busch <keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch@intel.com>
[hch: ported over from qemu-nvme.git to mainline]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 hw/block/nvme.c | 27 ++++++++++++++++++++++++++-
 hw/block/nvme.h |  1 +
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index d2f1d9a..6dac9ce 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -311,6 +311,29 @@ static uint16_t nvme_dsm(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     }
 }
 
+static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
+    NvmeRequest *req)
+{
+    NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
+    const uint8_t lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
+    const uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
+    uint64_t slba = le64_to_cpu(rw->slba);
+    uint32_t nlb  = le16_to_cpu(rw->nlb) + 1;
+    uint64_t aio_slba = slba << (data_shift - BDRV_SECTOR_BITS);
+    uint32_t aio_nlb = nlb << (data_shift - BDRV_SECTOR_BITS);
+
+    if (slba + nlb > ns->id_ns.nsze) {
+        return NVME_LBA_RANGE | NVME_DNR;
+    }
+
+    req->has_sg = false;
+    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
+                     BLOCK_ACCT_WRITE);
+    req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, aio_slba, aio_nlb, 0,
+                                        nvme_rw_cb, req);
+    return NVME_NO_COMPLETE;
+}
+
 static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     NvmeRequest *req)
 {
@@ -365,6 +388,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         return nvme_flush(n, ns, cmd, req);
     case NVME_CMD_DSM:
         return nvme_dsm(n, ns, cmd, req);
+    case NVME_CMD_WRITE_ZEROS:
+        return nvme_write_zeros(n, ns, cmd, req);
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
         return nvme_rw(n, ns, cmd, req);
@@ -975,7 +1000,7 @@ static int nvme_init(PCIDevice *pci_dev)
     id->sqes = (0x6 << 4) | 0x6;
     id->cqes = (0x4 << 4) | 0x4;
     id->nn = cpu_to_le32(n->num_namespaces);
-    id->oncs = cpu_to_le16(NVME_ONCS_DSM);
+    id->oncs = cpu_to_le16(NVME_ONCS_DSM | NVME_ONCS_WRITE_ZEROS);
     id->psd[0].mp = cpu_to_le16(0x9c4);
     id->psd[0].enlat = cpu_to_le32(0x10);
     id->psd[0].exlat = cpu_to_le32(0x4);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index e64a758..f3054b3 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -179,6 +179,7 @@ enum NvmeIoCommands {
     NVME_CMD_READ               = 0x02,
     NVME_CMD_WRITE_UNCOR        = 0x04,
     NVME_CMD_COMPARE            = 0x05,
+    NVME_CMD_WRITE_ZEROS        = 0x08,
     NVME_CMD_DSM                = 0x09,
 };
 
-- 
2.1.4

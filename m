Received: from eggs.gnu.org ([2001:4830:134:3::10]:42803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quwenruo@cn.fujitsu.com>) id 1dI94X-0003CW-SW
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:38:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quwenruo@cn.fujitsu.com>) id 1dI94W-0003qS-Ud
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:38:37 -0400
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Date: Tue, 6 Jun 2017 15:38:06 +0800
Message-ID: <20170606073806.8180-2-quwenruo@cn.fujitsu.com>
In-Reply-To: <20170606073806.8180-1-quwenruo@cn.fujitsu.com>
References: <20170606073806.8180-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/2] nvme: Check PSDT flag for admin and rw
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, keith.busch@intel.com

Check PRP or SGL for Data Transfer(PSDT) flag for admin and read/write
commands.

For NVMe-over-PCIE, admin sq entry should not set SGL bits.
and rw sq entry PSDT flag should not be set beyond controller support.

Although currently either linux kernel NVMe-over-PCIE host driver uses
SGL nor qemu nvme controller supports it, it's never a bad idea to
enhance the check.

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 hw/block/nvme.c | 11 +++++++++++
 hw/block/nvme.h |  7 ++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index fa1069160e..b2579594d9 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -284,6 +284,10 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
         block_acct_invalid(blk_get_stats(n->conf.blk), acct);
         return NVME_LBA_RANGE | NVME_DNR;
     }
+    if (!n->id_ctrl.sgls && NVME_CMD_FLAGS_PSDT(rw->flags)) {
+        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
 
     if (nvme_map_prp(&req->qsg, prp1, prp2, data_size, n)) {
         block_acct_invalid(blk_get_stats(n->conf.blk), acct);
@@ -618,6 +622,11 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 
 static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
+    /* Admin cmd for NVMe-over-PCIE should NOT use SGL */
+    if (NVME_CMD_FLAGS_PSDT(cmd->flags)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
     switch (cmd->opcode) {
     case NVME_ADM_CMD_DELETE_SQ:
         return nvme_del_sq(n, cmd);
@@ -967,6 +976,8 @@ static int nvme_init(PCIDevice *pci_dev)
     if (blk_enable_write_cache(n->conf.blk)) {
         id->vwc = 1;
     }
+    /* TODO: Support SGL in NVMe-over-PCIE in both qemu and kernel */
+    id->sgls = 0;
 
     n->bar.cap = 0;
     NVME_CAP_SET_MQES(n->bar.cap, 0x7ff);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 26be663d2d..caf21c5f94 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -229,9 +229,14 @@ typedef union NvmeDataPtr{
     NvmeKeyedSGLDesc    ksgl;
 } NvmeDataPtr;
 
+#define _NVME_CMD_FLAGS_FUSE_MASK    ((1 << 0)  + (1 << 1))
+#define _NVME_CMD_FLAGS_PSDT_MASK    ((1 << 15) + (1 << 14))
+#define NVME_CMD_FLAGS_FUSE(flags)  ((flags) & _NVME_CMD_FLAGS_FUSE_MASK)
+#define NVME_CMD_FLAGS_PSDT(flags)  ((flags) & _NVME_CMD_FLAGS_PSDT_MASK)
+
 typedef struct NvmeCmd {
     uint8_t     opcode;
-    uint8_t     fuse;
+    uint8_t     flags;
     uint16_t    cid;
     uint32_t    nsid;
     uint64_t    res1;
-- 
2.13.0

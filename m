Received: from eggs.gnu.org ([209.51.188.92]:48429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hG27U-00056R-V4
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hG27T-0007yH-V7
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:58:00 -0400
From: Maxim Levitsky <mlevitsk@redhat.com>
Date: Mon, 15 Apr 2019 16:57:44 +0300
Message-Id: <20190415135746.7571-4-mlevitsk@redhat.com>
In-Reply-To: <20190415135746.7571-1-mlevitsk@redhat.com>
References: <20190415135746.7571-1-mlevitsk@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] block/nvme: support larger that 512 bytes
 sector devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org

Currently the driver hardcodes the sector size to 512,
and doesn't check the underlying device

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/nvme.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 208242cf1f..0d9b521760 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -101,8 +101,11 @@ typedef struct {
     size_t doorbell_scale;
     bool write_cache_supported;
     EventNotifier irq_notifier;
+
     uint64_t nsze; /* Namespace size reported by identify command */
     int nsid;      /* The namespace id to read/write data. */
+    size_t blkshift;
+
     uint64_t max_transfer;
     bool plugged;
 
@@ -415,8 +418,9 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     BDRVNVMeState *s = bs->opaque;
     NvmeIdCtrl *idctrl;
     NvmeIdNs *idns;
+    NvmeLBAF *lbaf;
     uint8_t *resp;
-    int r;
+    int r, hwsect_size;
     uint64_t iova;
     NvmeCmd cmd = {
         .opcode = NVME_ADM_CMD_IDENTIFY,
@@ -463,7 +467,22 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     }
 
     s->nsze = le64_to_cpu(idns->nsze);
+    lbaf = &idns->lbaf[idns->flbas & 0x0f];
+
+    if (lbaf->ms) {
+        error_setg(errp, "Namespaces with metadata are not yet supported");
+        goto out;
+    }
+
+    hwsect_size = 1 << lbaf->ds;
+
+    if (hwsect_size < BDRV_SECTOR_BITS || hwsect_size > s->page_size) {
+        error_setg(errp, "Namespace has unsupported block size (%d)",
+                hwsect_size);
+        goto out;
+    }
 
+    s->blkshift = lbaf->ds;
 out:
     qemu_vfio_dma_unmap(s->vfio, resp);
     qemu_vfree(resp);
@@ -782,8 +801,17 @@ fail:
 static int64_t nvme_getlength(BlockDriverState *bs)
 {
     BDRVNVMeState *s = bs->opaque;
+    return s->nsze << s->blkshift;
+}
+
 
-    return s->nsze << BDRV_SECTOR_BITS;
+static int nvme_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
+{
+    BDRVNVMeState *s = bs->opaque;
+    assert(s->blkshift >= 9);
+    bsz->phys = 1 << s->blkshift;
+    bsz->log = 1 << s->blkshift;
+    return 0;
 }
 
 /* Called with s->dma_map_lock */
@@ -914,13 +942,14 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
     BDRVNVMeState *s = bs->opaque;
     NVMeQueuePair *ioq = s->queues[1];
     NVMeRequest *req;
-    uint32_t cdw12 = (((bytes >> BDRV_SECTOR_BITS) - 1) & 0xFFFF) |
+
+    uint32_t cdw12 = (((bytes >> s->blkshift) - 1) & 0xFFFF) |
                        (flags & BDRV_REQ_FUA ? 1 << 30 : 0);
     NvmeCmd cmd = {
         .opcode = is_write ? NVME_CMD_WRITE : NVME_CMD_READ,
         .nsid = cpu_to_le32(s->nsid),
-        .cdw10 = cpu_to_le32((offset >> BDRV_SECTOR_BITS) & 0xFFFFFFFF),
-        .cdw11 = cpu_to_le32(((offset >> BDRV_SECTOR_BITS) >> 32) & 0xFFFFFFFF),
+        .cdw10 = cpu_to_le32((offset >> s->blkshift) & 0xFFFFFFFF),
+        .cdw11 = cpu_to_le32(((offset >> s->blkshift) >> 32) & 0xFFFFFFFF),
         .cdw12 = cpu_to_le32(cdw12),
     };
     NVMeCoData data = {
@@ -1151,6 +1180,7 @@ static BlockDriver bdrv_nvme = {
     .bdrv_file_open           = nvme_file_open,
     .bdrv_close               = nvme_close,
     .bdrv_getlength           = nvme_getlength,
+    .bdrv_probe_blocksizes    = nvme_probe_blocksizes,
 
     .bdrv_co_preadv           = nvme_co_preadv,
     .bdrv_co_pwritev          = nvme_co_pwritev,
-- 
2.17.2

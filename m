Received: from eggs.gnu.org ([2001:4830:134:3::10]:34382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbates130272@gmail.com>) id 1dKilb-0001FD-Gg
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbates130272@gmail.com>) id 1dKilY-0001MS-01
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:09:43 -0400
From: sbates@raithlin.com
Date: Tue, 13 Jun 2017 04:08:35 -0600
Message-Id: <1497348515-6391-1-git-send-email-sbates@raithlin.com>
Subject: [Qemu-devel] [PATCH] nvme: Add support for Read Data and Write Data
 in CMBs.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keith.busch@intel.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, logang@deltatee.com
Cc: kwolf@redhat.com, mreitz@redhat.com, Stephen Bates <sbates@raithlin.com>

From: Stephen Bates <sbates@raithlin.com>

Add the ability for the NVMe model to support both the RDS and WDS
modes in the Controller Memory Buffer.

Although not currently supported in the upstreamed Linux kernel a fork
with support exists [1] and user-space test programs that build on
this also exist [2].

Useful for testing CMB functionality in preperation for real CMB
enabled NVMe devices (coming soon).

[1] https://github.com/sbates130272/linux-p2pmem
[2] https://github.com/sbates130272/p2pmem-test

Signed-off-by: Stephen Bates <sbates@raithlin.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 hw/block/nvme.c | 83 +++++++++++++++++++++++++++++++++++++++------------------
 hw/block/nvme.h |  1 +
 2 files changed, 58 insertions(+), 26 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 381dc7c..6071dc1 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -21,7 +21,7 @@
  *              cmb_size_mb=<cmb_size_mb[optional]>
  *
  * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
- * offset 0 in BAR2 and supports SQS only for now.
+ * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
  */
 
 #include "qemu/osdep.h"
@@ -93,8 +93,8 @@ static void nvme_isr_notify(NvmeCtrl *n, NvmeCQueue *cq)
     }
 }
 
-static uint16_t nvme_map_prp(QEMUSGList *qsg, uint64_t prp1, uint64_t prp2,
-    uint32_t len, NvmeCtrl *n)
+static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
+                             uint64_t prp2, uint32_t len, NvmeCtrl *n)
 {
     hwaddr trans_len = n->page_size - (prp1 % n->page_size);
     trans_len = MIN(len, trans_len);
@@ -102,10 +102,15 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, uint64_t prp1, uint64_t prp2,
 
     if (!prp1) {
         return NVME_INVALID_FIELD | NVME_DNR;
+    } else if (n->cmbsz && prp1 >= n->ctrl_mem.addr &&
+               prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size)) {
+        qsg->nsg = 0;
+        qemu_iovec_init(iov, num_prps);
+        qemu_iovec_add(iov, (void *)&n->cmbuf[prp1 - n->ctrl_mem.addr], trans_len);
+    } else {
+        pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
+        qemu_sglist_add(qsg, prp1, trans_len);
     }
-
-    pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
-    qemu_sglist_add(qsg, prp1, trans_len);
     len -= trans_len;
     if (len) {
         if (!prp2) {
@@ -118,7 +123,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, uint64_t prp1, uint64_t prp2,
 
             nents = (len + n->page_size - 1) >> n->page_bits;
             prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
-            pci_dma_read(&n->parent_obj, prp2, (void *)prp_list, prp_trans);
+            nvme_addr_read(n, prp2, (void *)prp_list, prp_trans);
             while (len != 0) {
                 uint64_t prp_ent = le64_to_cpu(prp_list[i]);
 
@@ -130,7 +135,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, uint64_t prp1, uint64_t prp2,
                     i = 0;
                     nents = (len + n->page_size - 1) >> n->page_bits;
                     prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
-                    pci_dma_read(&n->parent_obj, prp_ent, (void *)prp_list,
+                    nvme_addr_read(n, prp_ent, (void *)prp_list,
                         prp_trans);
                     prp_ent = le64_to_cpu(prp_list[i]);
                 }
@@ -140,7 +145,11 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, uint64_t prp1, uint64_t prp2,
                 }
 
                 trans_len = MIN(len, n->page_size);
-                qemu_sglist_add(qsg, prp_ent, trans_len);
+                if (qsg->nsg){
+                    qemu_sglist_add(qsg, prp_ent, trans_len);
+                } else {
+                    qemu_iovec_add(iov, (void *)&n->cmbuf[prp_ent - n->ctrl_mem.addr], trans_len);
+                }
                 len -= trans_len;
                 i++;
             }
@@ -148,7 +157,11 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, uint64_t prp1, uint64_t prp2,
             if (prp2 & (n->page_size - 1)) {
                 goto unmap;
             }
-            qemu_sglist_add(qsg, prp2, len);
+            if (qsg->nsg) {
+                qemu_sglist_add(qsg, prp2, len);
+            } else {
+                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - n->ctrl_mem.addr], trans_len);
+            }
         }
     }
     return NVME_SUCCESS;
@@ -162,16 +175,24 @@ static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
     uint64_t prp1, uint64_t prp2)
 {
     QEMUSGList qsg;
+    QEMUIOVector iov;
+    uint16_t status = NVME_SUCCESS;
 
-    if (nvme_map_prp(&qsg, prp1, prp2, len, n)) {
+    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
-    if (dma_buf_read(ptr, len, &qsg)) {
+    if (qsg.nsg > 0) {
+        if (dma_buf_read(ptr, len, &qsg)) {
+            status = NVME_INVALID_FIELD | NVME_DNR;
+        }
         qemu_sglist_destroy(&qsg);
-        return NVME_INVALID_FIELD | NVME_DNR;
+    } else {
+        if (qemu_iovec_to_buf(&iov, 0, ptr, len) != len) {
+            status = NVME_INVALID_FIELD | NVME_DNR;
+        }
+        qemu_iovec_destroy(&iov);
     }
-    qemu_sglist_destroy(&qsg);
-    return NVME_SUCCESS;
+    return status;
 }
 
 static void nvme_post_cqes(void *opaque)
@@ -285,20 +306,27 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
         return NVME_LBA_RANGE | NVME_DNR;
     }
 
-    if (nvme_map_prp(&req->qsg, prp1, prp2, data_size, n)) {
+    if (nvme_map_prp(&req->qsg, &req->iov, prp1, prp2, data_size, n)) {
         block_acct_invalid(blk_get_stats(n->conf.blk), acct);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    assert((nlb << data_shift) == req->qsg.size);
-
-    req->has_sg = true;
     dma_acct_start(n->conf.blk, &req->acct, &req->qsg, acct);
-    req->aiocb = is_write ?
-        dma_blk_write(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
-                      nvme_rw_cb, req) :
-        dma_blk_read(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
-                     nvme_rw_cb, req);
+    if (req->qsg.nsg > 0) {
+        req->has_sg = true;
+        req->aiocb = is_write ?
+            dma_blk_write(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
+                          nvme_rw_cb, req) :
+            dma_blk_read(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
+                         nvme_rw_cb, req);
+    } else {
+        req->has_sg = false;
+        req->aiocb = is_write ?
+            blk_aio_pwritev(n->conf.blk, data_offset, &req->iov, 0, nvme_rw_cb,
+                            req) :
+            blk_aio_preadv(n->conf.blk, data_offset, &req->iov, 0, nvme_rw_cb,
+                           req);
+    }
 
     return NVME_NO_COMPLETE;
 }
@@ -987,11 +1015,14 @@ static int nvme_init(PCIDevice *pci_dev)
         NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
         NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
         NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
-        NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 0);
-        NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 0);
+        NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
+        NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
         NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
         NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->cmb_size_mb);
 
+        n->cmbloc = n->bar.cmbloc;
+        n->cmbsz = n->bar.cmbsz;
+
         n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
         memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
                               "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index b4961d2..6aab338 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -712,6 +712,7 @@ typedef struct NvmeRequest {
     NvmeCqe                 cqe;
     BlockAcctCookie         acct;
     QEMUSGList              qsg;
+    QEMUIOVector            iov;
     QTAILQ_ENTRY(NvmeRequest)entry;
 } NvmeRequest;
 
-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1e0FPZ-0003Fs-Ki
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 19:18:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1e0FPX-0000Bv-4d
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 19:18:37 -0400
MIME-Version: 1.0
From: Doug Gale <doug16k@gmail.com>
Date: Thu, 5 Oct 2017 19:18:33 -0400
Message-ID: <CAEfK_45dZvxvBNQpPLo71ZJhrPN5_GJr8uJ2pJZpCaFf0+i3YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Patch to add helpful tracing output for driver authors
 in NVMe emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block@nongnu.org, keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com

I added the tracing output in this patch to assist me in implementing
an NVMe driver. It helped tremendously.

>From 1d19086cdef8d492929852d582cb41dcc5026f71 Mon Sep 17 00:00:00 2001
From: Doug Gale <doug16k@gmail.com>
Date: Thu, 5 Oct 2017 19:02:03 -0400
Subject: [PATCH] Add tracing output to NVMe emulation to help driver authors.

It is off by default, enable it by uncommenting #define DEBUG_NVME
or through CFLAGS

Signed-off-by: Doug Gale <doug16k@gmail.com>
---
 hw/block/nvme.c | 191 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 177 insertions(+), 14 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9aa32692a3..74220c0171 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -36,6 +36,14 @@

 #include "nvme.h"

+//#define DEBUG_NVME
+
+#ifdef DEBUG_NVME
+#define DPRINTF(fmt, ...) fprintf(stderr, "nvme: " fmt "\n", ## __VA_ARGS__)
+#else
+#define DPRINTF(fmt, ...) ((void)0)
+#endif
+
 static void nvme_process_sq(void *opaque);

 static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
@@ -86,10 +94,14 @@ static void nvme_isr_notify(NvmeCtrl *n, NvmeCQueue *cq)
 {
     if (cq->irq_enabled) {
         if (msix_enabled(&(n->parent_obj))) {
+            DPRINTF("raising MSI-X IRQ vector %u", cq->vector);
             msix_notify(&(n->parent_obj), cq->vector);
         } else {
+            DPRINTF("pulsing IRQ pin");
             pci_irq_pulse(&n->parent_obj);
         }
+    } else {
+        DPRINTF("IRQ is masked");
     }
 }

@@ -101,9 +113,11 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg,
QEMUIOVector *iov, uint64_t prp1,
     int num_prps = (len >> n->page_bits) + 1;

     if (!prp1) {
+        DPRINTF("Invalid PRP!");
         return NVME_INVALID_FIELD | NVME_DNR;
     } else if (n->cmbsz && prp1 >= n->ctrl_mem.addr &&
                prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size)) {
+        DPRINTF("PRP in controller memory");
         qsg->nsg = 0;
         qemu_iovec_init(iov, num_prps);
         qemu_iovec_add(iov, (void *)&n->cmbuf[prp1 -
n->ctrl_mem.addr], trans_len);
@@ -168,6 +182,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg,
QEMUIOVector *iov, uint64_t prp1,

  unmap:
     qemu_sglist_destroy(qsg);
+    DPRINTF("invalid SGL!");
     return NVME_INVALID_FIELD | NVME_DNR;
 }

@@ -178,16 +193,22 @@ static uint16_t nvme_dma_read_prp(NvmeCtrl *n,
uint8_t *ptr, uint32_t len,
     QEMUIOVector iov;
     uint16_t status = NVME_SUCCESS;

+    DPRINTF("DMA read, prp1=0x%"PRIx64" prp2=0x%"PRIx64,
+            prp1, prp2);
+
     if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
+        DPRINTF("DMA read invalid PRP field!");
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     if (qsg.nsg > 0) {
         if (dma_buf_read(ptr, len, &qsg)) {
+            DPRINTF("DMA read invalid SGL field!");
             status = NVME_INVALID_FIELD | NVME_DNR;
         }
         qemu_sglist_destroy(&qsg);
     } else {
         if (qemu_iovec_to_buf(&iov, 0, ptr, len) != len) {
+            DPRINTF("invalid field!");
             status = NVME_INVALID_FIELD | NVME_DNR;
         }
         qemu_iovec_destroy(&iov);
@@ -274,6 +295,7 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n,
NvmeNamespace *ns, NvmeCmd *cmd,
     uint32_t aio_nlb = nlb << (data_shift - BDRV_SECTOR_BITS);

     if (slba + nlb > ns->id_ns.nsze) {
+        DPRINTF("Invalid LBA!");
         return NVME_LBA_RANGE | NVME_DNR;
     }

@@ -301,13 +323,19 @@ static uint16_t nvme_rw(NvmeCtrl *n,
NvmeNamespace *ns, NvmeCmd *cmd,
     int is_write = rw->opcode == NVME_CMD_WRITE ? 1 : 0;
     enum BlockAcctType acct = is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;

+    DPRINTF("%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64,
+            is_write ? "write" : "read",
+            nlb, data_size, slba);
+
     if ((slba + nlb) > ns->id_ns.nsze) {
         block_acct_invalid(blk_get_stats(n->conf.blk), acct);
+        DPRINTF("Invalid LBA!");
         return NVME_LBA_RANGE | NVME_DNR;
     }

     if (nvme_map_prp(&req->qsg, &req->iov, prp1, prp2, data_size, n)) {
         block_acct_invalid(blk_get_stats(n->conf.blk), acct);
+        DPRINTF("Invalid PRP!");
         return NVME_INVALID_FIELD | NVME_DNR;
     }

@@ -337,6 +365,7 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd
*cmd, NvmeRequest *req)
     uint32_t nsid = le32_to_cpu(cmd->nsid);

     if (nsid == 0 || nsid > n->num_namespaces) {
+        DPRINTF("Invalid namespace!");
         return NVME_INVALID_NSID | NVME_DNR;
     }

@@ -350,6 +379,7 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd
*cmd, NvmeRequest *req)
     case NVME_CMD_READ:
         return nvme_rw(n, ns, cmd, req);
     default:
+        DPRINTF("Invalid opcode!");
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
 }
@@ -374,9 +404,12 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
     uint16_t qid = le16_to_cpu(c->qid);

     if (!qid || nvme_check_sqid(n, qid)) {
+        DPRINTF("invalid submission queue deletion! qid=%u", qid);
         return NVME_INVALID_QID | NVME_DNR;
     }

+    DPRINTF("submission queue deleted, qid=%u", qid);
+
     sq = n->sq[qid];
     while (!QTAILQ_EMPTY(&sq->out_req_list)) {
         req = QTAILQ_FIRST(&sq->out_req_list);
@@ -439,21 +472,31 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
     uint16_t qflags = le16_to_cpu(c->sq_flags);
     uint64_t prp1 = le64_to_cpu(c->prp1);

+    DPRINTF("attempting to create submission queue"
+            ", addr=0x%"PRIx64", cqid=%u, size=%u",
+            prp1, cqid, qsize);
+
     if (!cqid || nvme_check_cqid(n, cqid)) {
+        DPRINTF("...invalid completion queue id!");
         return NVME_INVALID_CQID | NVME_DNR;
     }
     if (!sqid || !nvme_check_sqid(n, sqid)) {
+        DPRINTF("...invalid submission queue id!");
         return NVME_INVALID_QID | NVME_DNR;
     }
     if (!qsize || qsize > NVME_CAP_MQES(n->bar.cap)) {
+        DPRINTF("...invalid queue size!");
         return NVME_MAX_QSIZE_EXCEEDED | NVME_DNR;
     }
     if (!prp1 || prp1 & (n->page_size - 1)) {
+        DPRINTF("...invalid address!");
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     if (!(NVME_SQ_FLAGS_PC(qflags))) {
+        DPRINTF("...invalid flags!");
         return NVME_INVALID_FIELD | NVME_DNR;
     }
+    DPRINTF("...success");
     sq = g_malloc0(sizeof(*sq));
     nvme_init_sq(sq, n, prp1, sqid, cqid, qsize + 1);
     return NVME_SUCCESS;
@@ -477,13 +520,16 @@ static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *cmd)
     uint16_t qid = le16_to_cpu(c->qid);

     if (!qid || nvme_check_cqid(n, qid)) {
+        DPRINTF("Invalid completion queue ID!");
         return NVME_INVALID_CQID | NVME_DNR;
     }

     cq = n->cq[qid];
     if (!QTAILQ_EMPTY(&cq->sq_list)) {
+        DPRINTF("invalid completion queue deletion! id=%u", qid);
         return NVME_INVALID_QUEUE_DEL;
     }
+    DPRINTF("deleted completion queue, id=%u", qid);
     nvme_free_cq(cq, n);
     return NVME_SUCCESS;
 }
@@ -516,21 +562,32 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
     uint16_t qflags = le16_to_cpu(c->cq_flags);
     uint64_t prp1 = le64_to_cpu(c->prp1);

+    DPRINTF("attempting to create completion queue"
+            ", addr=0x%"PRIx64", cqid=%u"
+            ", vector=%u, size=%u, intr_en=%u",
+            prp1, cqid, vector, qsize, NVME_CQ_FLAGS_IEN(qflags));
+
     if (!cqid || !nvme_check_cqid(n, cqid)) {
+        DPRINTF("...invalid completion queue id!");
         return NVME_INVALID_CQID | NVME_DNR;
     }
     if (!qsize || qsize > NVME_CAP_MQES(n->bar.cap)) {
+        DPRINTF("...invalid queue size!");
         return NVME_MAX_QSIZE_EXCEEDED | NVME_DNR;
     }
     if (!prp1) {
+        DPRINTF("...invalid address!");
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     if (vector > n->num_queues) {
+        DPRINTF("...invalid interrupt vector!");
         return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
     }
     if (!(NVME_CQ_FLAGS_PC(qflags))) {
+        DPRINTF("...invalid flags!");
         return NVME_INVALID_FIELD | NVME_DNR;
     }
+    DPRINTF("...success");

     cq = g_malloc0(sizeof(*cq));
     nvme_init_cq(cq, n, prp1, cqid, vector, qsize + 1,
@@ -555,10 +612,16 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n,
NvmeIdentify *c)
     uint64_t prp2 = le64_to_cpu(c->prp2);

     if (nsid == 0 || nsid > n->num_namespaces) {
+        DPRINTF("...invalid namespace ID!");
         return NVME_INVALID_NSID | NVME_DNR;
     }

     ns = &n->namespaces[nsid - 1];
+
+    DPRINTF("identify namespace, nlbaf=%u", ns->id_ns.nlbaf);
+    DPRINTF("identify namespace, lbaf[0]=0x%"PRIx32,
+            *(uint32_t*)&ns->id_ns.lbaf[0]);
+
     return nvme_dma_read_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns),
         prp1, prp2);
 }
@@ -595,12 +658,18 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)

     switch (le32_to_cpu(c->cns)) {
     case 0x00:
+        DPRINTF("...identify namespace %u",
+                le32_to_cpu(c->nsid));
         return nvme_identify_ns(n, c);
     case 0x01:
+        DPRINTF("...identify controller");
         return nvme_identify_ctrl(n, c);
     case 0x02:
+        DPRINTF("...identify namespace list, after %u",
+                le32_to_cpu(c->nsid));
         return nvme_identify_nslist(n, c);
     default:
+        DPRINTF("...invalid CNS: %u!", le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 }
@@ -618,6 +687,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n,
NvmeCmd *cmd, NvmeRequest *req)
         result = cpu_to_le32((n->num_queues - 2) | ((n->num_queues -
2) << 16));
         break;
     default:
+        DPRINTF("Invalid field!");
         return NVME_INVALID_FIELD | NVME_DNR;
     }

@@ -635,10 +705,15 @@ static uint16_t nvme_set_feature(NvmeCtrl *n,
NvmeCmd *cmd, NvmeRequest *req)
         blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
         break;
     case NVME_NUMBER_OF_QUEUES:
+        DPRINTF("Requested cq_count=%u, sq_count=%u,"
+                " responding with cq_count=%u, sq_count=%u",
+                (dw11 & 0xFFFF) + 1, ((dw11 >> 16) & 0xFFFF) + 1,
+                n->num_queues - 1, n->num_queues - 1);
         req->cqe.result =
             cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16));
         break;
     default:
+        DPRINTF("Invalid field!");
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     return NVME_SUCCESS;
@@ -648,20 +723,28 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n,
NvmeCmd *cmd, NvmeRequest *req)
 {
     switch (cmd->opcode) {
     case NVME_ADM_CMD_DELETE_SQ:
+        DPRINTF("received admin command: delete submission queue");
         return nvme_del_sq(n, cmd);
     case NVME_ADM_CMD_CREATE_SQ:
+        DPRINTF("received admin command: create submission queue");
         return nvme_create_sq(n, cmd);
     case NVME_ADM_CMD_DELETE_CQ:
+        DPRINTF("received admin command: delete completion queue");
         return nvme_del_cq(n, cmd);
     case NVME_ADM_CMD_CREATE_CQ:
+        DPRINTF("received admin command: create completion queue");
         return nvme_create_cq(n, cmd);
     case NVME_ADM_CMD_IDENTIFY:
+        DPRINTF("received admin command: identify");
         return nvme_identify(n, cmd);
     case NVME_ADM_CMD_SET_FEATURES:
+        DPRINTF("received admin command: set features");
         return nvme_set_feature(n, cmd, req);
     case NVME_ADM_CMD_GET_FEATURES:
+        DPRINTF("received admin command: get features");
         return nvme_get_feature(n, cmd, req);
     default:
+        DPRINTF("received admin command: invalid opcode!");
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
 }
@@ -721,15 +804,70 @@ static int nvme_start_ctrl(NvmeCtrl *n)
     uint32_t page_bits = NVME_CC_MPS(n->bar.cc) + 12;
     uint32_t page_size = 1 << page_bits;

-    if (n->cq[0] || n->sq[0] || !n->bar.asq || !n->bar.acq ||
-            n->bar.asq & (page_size - 1) || n->bar.acq & (page_size - 1) ||
-            NVME_CC_MPS(n->bar.cc) < NVME_CAP_MPSMIN(n->bar.cap) ||
-            NVME_CC_MPS(n->bar.cc) > NVME_CAP_MPSMAX(n->bar.cap) ||
-            NVME_CC_IOCQES(n->bar.cc) < NVME_CTRL_CQES_MIN(n->id_ctrl.cqes) ||
-            NVME_CC_IOCQES(n->bar.cc) > NVME_CTRL_CQES_MAX(n->id_ctrl.cqes) ||
-            NVME_CC_IOSQES(n->bar.cc) < NVME_CTRL_SQES_MIN(n->id_ctrl.sqes) ||
-            NVME_CC_IOSQES(n->bar.cc) > NVME_CTRL_SQES_MAX(n->id_ctrl.sqes) ||
-            !NVME_AQA_ASQS(n->bar.aqa) || !NVME_AQA_ACQS(n->bar.aqa)) {
+    if (n->cq[0]) {
+        DPRINTF("nvme_start_ctrl failed because cq[0]");
+        return -1;
+    }
+    if (n->sq[0]) {
+        DPRINTF("nvme_start_ctrl failed because sq[0]");
+        return -1;
+    }
+    if (!n->bar.asq) {
+        DPRINTF("nvme_start_ctrl failed because !bar.asq");
+        return -1;
+    }
+    if (!n->bar.acq) {
+        DPRINTF("nvme_start_ctrl failed because !bar.acq");
+        return -1;
+    }
+    if (n->bar.asq & (page_size - 1)) {
+        DPRINTF("nvme_start_ctrl failed because"
+                " bar.asq is not page aligned");
+        return -1;
+    }
+    if (n->bar.acq & (page_size - 1)) {
+        DPRINTF("nvme_start_ctrl failed because"
+                " bar.acq is not page aligned");
+        return -1;
+    }
+    if (NVME_CC_MPS(n->bar.cc) < NVME_CAP_MPSMIN(n->bar.cap)) {
+        DPRINTF("nvme_start_ctrl failed because"
+                " page size is too small");
+        return -1;
+    }
+    if (NVME_CC_MPS(n->bar.cc) > NVME_CAP_MPSMAX(n->bar.cap)) {
+        DPRINTF("nvme_start_ctrl failed because"
+                " page size is too large");
+        return -1;
+    }
+    if (NVME_CC_IOCQES(n->bar.cc) < NVME_CTRL_CQES_MIN(n->id_ctrl.cqes)) {
+        DPRINTF("nvme_start_ctrl failed because"
+                " completion queue entry size is too small");
+        return -1;
+    }
+    if (NVME_CC_IOCQES(n->bar.cc) > NVME_CTRL_CQES_MAX(n->id_ctrl.cqes)) {
+        DPRINTF("nvme_start_ctrl failed because"
+                " completion queue entry size is too large");
+        return -1;
+    }
+    if (NVME_CC_IOSQES(n->bar.cc) < NVME_CTRL_SQES_MIN(n->id_ctrl.sqes)) {
+        DPRINTF("nvme_start_ctrl failed because"
+                " submit queue entry size is too small");
+        return -1;
+    }
+    if (NVME_CC_IOSQES(n->bar.cc) > NVME_CTRL_SQES_MAX(n->id_ctrl.sqes)) {
+        DPRINTF("nvme_start_ctrl failed because"
+                " submit queue entry size is too large");
+        return -1;
+    }
+    if (!NVME_AQA_ASQS(n->bar.aqa)) {
+        DPRINTF("nvme_start_ctrl failed because"
+                " admin submit queue size is zero");
+        return -1;
+    }
+    if (!NVME_AQA_ACQS(n->bar.aqa)) {
+        DPRINTF("nvme_start_ctrl failed because"
+                " admin completion queue size is zero");
         return -1;
     }

@@ -749,16 +887,25 @@ static int nvme_start_ctrl(NvmeCtrl *n)
 static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
     unsigned size)
 {
+    DPRINTF("wrote pci config offset=0x%"PRIx64" data=0x%"PRIx64"",
+            offset, data);
+
     switch (offset) {
     case 0xc:
+        DPRINTF("...interrupt mask set 0x%"PRIx64"",
+                data & 0xffffffff);
         n->bar.intms |= data & 0xffffffff;
         n->bar.intmc = n->bar.intms;
         break;
     case 0x10:
+        DPRINTF("...interrupt mask clr 0x%"PRIx64"",
+                data & 0xffffffff);
         n->bar.intms &= ~(data & 0xffffffff);
         n->bar.intmc = n->bar.intms;
         break;
     case 0x14:
+        DPRINTF("...controller config 0x%"PRIx64"",
+                data & 0xffffffff);
         /* Windows first sends data, then sends enable bit */
         if (!NVME_CC_EN(data) && !NVME_CC_EN(n->bar.cc) &&
             !NVME_CC_SHN(data) && !NVME_CC_SHN(n->bar.cc))
@@ -769,39 +916,55 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr
offset, uint64_t data,
         if (NVME_CC_EN(data) && !NVME_CC_EN(n->bar.cc)) {
             n->bar.cc = data;
             if (nvme_start_ctrl(n)) {
+                DPRINTF("...nvme_start_ctrl failed!");
                 n->bar.csts = NVME_CSTS_FAILED;
             } else {
+                DPRINTF("...nvme_start_ctrl success, now ready!");
                 n->bar.csts = NVME_CSTS_READY;
             }
         } else if (!NVME_CC_EN(data) && NVME_CC_EN(n->bar.cc)) {
+            DPRINTF("...enable bit cleared");
             nvme_clear_ctrl(n);
             n->bar.csts &= ~NVME_CSTS_READY;
         }
         if (NVME_CC_SHN(data) && !(NVME_CC_SHN(n->bar.cc))) {
-                nvme_clear_ctrl(n);
-                n->bar.cc = data;
-                n->bar.csts |= NVME_CSTS_SHST_COMPLETE;
+            DPRINTF("...shutdown complete");
+            nvme_clear_ctrl(n);
+            n->bar.cc = data;
+            n->bar.csts |= NVME_CSTS_SHST_COMPLETE;
         } else if (!NVME_CC_SHN(data) && NVME_CC_SHN(n->bar.cc)) {
-                n->bar.csts &= ~NVME_CSTS_SHST_COMPLETE;
-                n->bar.cc = data;
+            DPRINTF("...no shutdown, normal operation");
+            n->bar.csts &= ~NVME_CSTS_SHST_COMPLETE;
+            n->bar.cc = data;
         }
         break;
     case 0x24:
+        DPRINTF("...admin queue attributes set to %u",
+                (uint32_t)(data & 0xffffffff));
         n->bar.aqa = data & 0xffffffff;
         break;
     case 0x28:
+        DPRINTF("...admin submission queue address set to %"PRIx64,
+                data);
         n->bar.asq = data;
         break;
     case 0x2c:
+        DPRINTF("...admin submission queue high half of address set to %x",
+                (uint32_t)(data & 0xffffffff));
         n->bar.asq |= data << 32;
         break;
     case 0x30:
+        DPRINTF("...admin completion queue address set to %"PRIx64,
+                data);
         n->bar.acq = data;
         break;
     case 0x34:
+        DPRINTF("...admin completion queue high half of address set to %x",
+                (uint32_t)(data & 0xffffffff));
         n->bar.acq |= data << 32;
         break;
     default:
+        DPRINTF("...ignored!");
         break;
     }
 }
-- 
2.11.0

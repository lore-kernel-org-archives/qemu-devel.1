Received: from eggs.gnu.org ([2001:4830:134:3::10]:35729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1e0jtE-0002Ha-M9
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 03:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1e0jtB-0004WO-WA
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 03:51:16 -0400
MIME-Version: 1.0
In-Reply-To: <20171006140137.GH26575@redhat.com>
References: <CAEfK_45dZvxvBNQpPLo71ZJhrPN5_GJr8uJ2pJZpCaFf0+i3YA@mail.gmail.com>
	<62e835a4-ba5d-e620-47d2-180932a33426@redhat.com>
	<20171006135425.GF26575@redhat.com>
	<CAEfK_444_fPwjnj1M8w8XNFFwiMJW-pdN7R1Tdu+FfvB38ZBtw@mail.gmail.com>
	<20171006140137.GH26575@redhat.com>
From: Doug Gale <doug16k@gmail.com>
Date: Sat, 7 Oct 2017 03:51:12 -0400
Message-ID: <CAEfK_455Hr1afv-H6=9QMQErDGZJtOBgFMk2F8QJshYTLgOa1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Patch to add helpful tracing output for driver
 authors in NVMe emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, keith.busch@intel.com, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

Completely re-implemented patch, with significant improvements (now
specifies values in several places I missed, also reduced the amount
of redundant lines). I used the nvme_ as the tracing infrastructure
prefix. Tested with -trace nvme_* on the qemu command line, worked for
me.

>From 166f57458d60d363a10a0933c3e860985531ac96 Mon Sep 17 00:00:00 2001
From: Doug Gale <doug16k@gmail.com>
Date: Thu, 5 Oct 2017 19:02:03 -0400
Subject: [PATCH] Add tracing output to NVMe emulation to help driver authors.

This uses the tracing infrastructure using nvme_ as the prefix.

Signed-off-by: Doug Gale <doug16k@gmail.com>
---
 hw/block/nvme.c       | 158 +++++++++++++++++++++++++++++++++++++++++++++-----
 hw/block/trace-events |  89 ++++++++++++++++++++++++++++
 2 files changed, 233 insertions(+), 14 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9aa32692a3..3e3cd820a3 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -34,6 +34,7 @@
 #include "qapi/visitor.h"
 #include "sysemu/block-backend.h"

+#include "trace.h"
 #include "nvme.h"

 static void nvme_process_sq(void *opaque);
@@ -86,10 +87,14 @@ static void nvme_isr_notify(NvmeCtrl *n, NvmeCQueue *cq)
 {
     if (cq->irq_enabled) {
         if (msix_enabled(&(n->parent_obj))) {
+            trace_nvme_msix_intr(cq->vector);
             msix_notify(&(n->parent_obj), cq->vector);
         } else {
+            trace_nvme_pin_intr();
             pci_irq_pulse(&n->parent_obj);
         }
+    } else {
+        trace_nvme_masked_intr();
     }
 }

@@ -101,6 +106,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg,
QEMUIOVector *iov, uint64_t prp1,
     int num_prps = (len >> n->page_bits) + 1;

     if (!prp1) {
+        trace_nvme_invalid_prp();
         return NVME_INVALID_FIELD | NVME_DNR;
     } else if (n->cmbsz && prp1 >= n->ctrl_mem.addr &&
                prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size)) {
@@ -114,6 +120,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg,
QEMUIOVector *iov, uint64_t prp1,
     len -= trans_len;
     if (len) {
         if (!prp2) {
+            trace_nvme_invalid_prp2_missing();
             goto unmap;
         }
         if (len > n->page_size) {
@@ -129,6 +136,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg,
QEMUIOVector *iov, uint64_t prp1,

                 if (i == n->max_prp_ents - 1 && len > n->page_size) {
                     if (!prp_ent || prp_ent & (n->page_size - 1)) {
+                        trace_nvme_invalid_prplist_ent(prp_ent);
                         goto unmap;
                     }

@@ -141,6 +149,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg,
QEMUIOVector *iov, uint64_t prp1,
                 }

                 if (!prp_ent || prp_ent & (n->page_size - 1)) {
+                    trace_nvme_invalid_prplist_ent(prp_ent);
                     goto unmap;
                 }

@@ -155,6 +164,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg,
QEMUIOVector *iov, uint64_t prp1,
             }
         } else {
             if (prp2 & (n->page_size - 1)) {
+                trace_nvme_invalid_prp2_align(prp2);
                 goto unmap;
             }
             if (qsg->nsg) {
@@ -178,16 +188,20 @@ static uint16_t nvme_dma_read_prp(NvmeCtrl *n,
uint8_t *ptr, uint32_t len,
     QEMUIOVector iov;
     uint16_t status = NVME_SUCCESS;

+    trace_nvme_dma_read(prp1, prp2);
+
     if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     if (qsg.nsg > 0) {
         if (dma_buf_read(ptr, len, &qsg)) {
+            trace_nvme_dma_too_short();
             status = NVME_INVALID_FIELD | NVME_DNR;
         }
         qemu_sglist_destroy(&qsg);
     } else {
         if (qemu_iovec_to_buf(&iov, 0, ptr, len) != len) {
+            trace_nvme_dma_too_short();
             status = NVME_INVALID_FIELD | NVME_DNR;
         }
         qemu_iovec_destroy(&iov);
@@ -274,6 +288,7 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n,
NvmeNamespace *ns, NvmeCmd *cmd,
     uint32_t aio_nlb = nlb << (data_shift - BDRV_SECTOR_BITS);

     if (slba + nlb > ns->id_ns.nsze) {
+        trace_nvme_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
         return NVME_LBA_RANGE | NVME_DNR;
     }

@@ -301,8 +316,11 @@ static uint16_t nvme_rw(NvmeCtrl *n,
NvmeNamespace *ns, NvmeCmd *cmd,
     int is_write = rw->opcode == NVME_CMD_WRITE ? 1 : 0;
     enum BlockAcctType acct = is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;

+    trace_nvme_rw(is_write ? "write" : "read", nlb, data_size, slba);
+
     if ((slba + nlb) > ns->id_ns.nsze) {
         block_acct_invalid(blk_get_stats(n->conf.blk), acct);
+        trace_nvme_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
         return NVME_LBA_RANGE | NVME_DNR;
     }

@@ -337,6 +355,7 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd
*cmd, NvmeRequest *req)
     uint32_t nsid = le32_to_cpu(cmd->nsid);

     if (nsid == 0 || nsid > n->num_namespaces) {
+        trace_nvme_invalid_ns(nsid, n->num_namespaces);
         return NVME_INVALID_NSID | NVME_DNR;
     }

@@ -350,6 +369,7 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd
*cmd, NvmeRequest *req)
     case NVME_CMD_READ:
         return nvme_rw(n, ns, cmd, req);
     default:
+        trace_nvme_invalid_opc(cmd->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
 }
@@ -374,9 +394,12 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
     uint16_t qid = le16_to_cpu(c->qid);

     if (!qid || nvme_check_sqid(n, qid)) {
+        trace_nvme_del_sq_invalid(qid);
         return NVME_INVALID_QID | NVME_DNR;
     }

+    trace_nvme_del_sq(qid);
+
     sq = n->sq[qid];
     while (!QTAILQ_EMPTY(&sq->out_req_list)) {
         req = QTAILQ_FIRST(&sq->out_req_list);
@@ -439,19 +462,26 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
     uint16_t qflags = le16_to_cpu(c->sq_flags);
     uint64_t prp1 = le64_to_cpu(c->prp1);

+    trace_nvme_create_sq(prp1, sqid, cqid, qsize, qflags);
+
     if (!cqid || nvme_check_cqid(n, cqid)) {
+        trace_nvme_create_sq_invalid_cqid(cqid);
         return NVME_INVALID_CQID | NVME_DNR;
     }
     if (!sqid || !nvme_check_sqid(n, sqid)) {
+        trace_nvme_create_sq_invalid_sqid(sqid);
         return NVME_INVALID_QID | NVME_DNR;
     }
     if (!qsize || qsize > NVME_CAP_MQES(n->bar.cap)) {
+        trace_nvme_create_sq_invalid_size(qsize);
         return NVME_MAX_QSIZE_EXCEEDED | NVME_DNR;
     }
     if (!prp1 || prp1 & (n->page_size - 1)) {
+        trace_nvme_create_sq_invalid_addr(prp1);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     if (!(NVME_SQ_FLAGS_PC(qflags))) {
+        trace_nvme_create_sq_invalid_qflags(NVME_SQ_FLAGS_PC(qflags));
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     sq = g_malloc0(sizeof(*sq));
@@ -477,13 +507,16 @@ static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *cmd)
     uint16_t qid = le16_to_cpu(c->qid);

     if (!qid || nvme_check_cqid(n, qid)) {
+        trace_nvme_del_cq_invalid_cqid(qid);
         return NVME_INVALID_CQID | NVME_DNR;
     }

     cq = n->cq[qid];
     if (!QTAILQ_EMPTY(&cq->sq_list)) {
+        trace_nvme_del_cq_invalid_notempty(qid);
         return NVME_INVALID_QUEUE_DEL;
     }
+    trace_nvme_del_cq(qid);
     nvme_free_cq(cq, n);
     return NVME_SUCCESS;
 }
@@ -516,19 +549,27 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
     uint16_t qflags = le16_to_cpu(c->cq_flags);
     uint64_t prp1 = le64_to_cpu(c->prp1);

+    trace_nvme_create_cq(prp1, cqid, vector, qsize, qflags,
+                         NVME_CQ_FLAGS_IEN(qflags) != 0);
+
     if (!cqid || !nvme_check_cqid(n, cqid)) {
+        trace_nvme_create_cq_invalid_cqid(cqid);
         return NVME_INVALID_CQID | NVME_DNR;
     }
     if (!qsize || qsize > NVME_CAP_MQES(n->bar.cap)) {
+        trace_nvme_create_cq_invalid_size(qsize);
         return NVME_MAX_QSIZE_EXCEEDED | NVME_DNR;
     }
     if (!prp1) {
+        trace_nvme_create_cq_invalid_addr(prp1);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     if (vector > n->num_queues) {
+        trace_nvme_create_cq_invalid_vector(vector);
         return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
     }
     if (!(NVME_CQ_FLAGS_PC(qflags))) {
+        trace_nvme_create_cq_invalid_qflags(NVME_CQ_FLAGS_PC(qflags));
         return NVME_INVALID_FIELD | NVME_DNR;
     }

@@ -543,6 +584,8 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n,
NvmeIdentify *c)
     uint64_t prp1 = le64_to_cpu(c->prp1);
     uint64_t prp2 = le64_to_cpu(c->prp2);

+    trace_nvme_identify_ctrl();
+
     return nvme_dma_read_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl),
         prp1, prp2);
 }
@@ -554,11 +597,15 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n,
NvmeIdentify *c)
     uint64_t prp1 = le64_to_cpu(c->prp1);
     uint64_t prp2 = le64_to_cpu(c->prp2);

+    trace_nvme_identify_ns(nsid);
+
     if (nsid == 0 || nsid > n->num_namespaces) {
+        trace_nvme_invalid_ns(nsid, n->num_namespaces);
         return NVME_INVALID_NSID | NVME_DNR;
     }

     ns = &n->namespaces[nsid - 1];
+
     return nvme_dma_read_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns),
         prp1, prp2);
 }
@@ -573,6 +620,8 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n,
NvmeIdentify *c)
     uint16_t ret;
     int i, j = 0;

+    trace_nvme_identify_nslist(min_nsid);
+
     list = g_malloc0(data_len);
     for (i = 0; i < n->num_namespaces; i++) {
         if (i < min_nsid) {
@@ -601,6 +650,7 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
     case 0x02:
         return nvme_identify_nslist(n, c);
     default:
+        trace_nvme_identify_invalid_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 }
@@ -613,11 +663,14 @@ static uint16_t nvme_get_feature(NvmeCtrl *n,
NvmeCmd *cmd, NvmeRequest *req)
     switch (dw10) {
     case NVME_VOLATILE_WRITE_CACHE:
         result = blk_enable_write_cache(n->conf.blk);
+        trace_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
         break;
     case NVME_NUMBER_OF_QUEUES:
         result = cpu_to_le32((n->num_queues - 2) | ((n->num_queues -
2) << 16));
+        trace_nvme_getfeat_numq(result);
         break;
     default:
+        trace_nvme_getfeat_invalid(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
     }

@@ -635,10 +688,13 @@ static uint16_t nvme_set_feature(NvmeCtrl *n,
NvmeCmd *cmd, NvmeRequest *req)
         blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
         break;
     case NVME_NUMBER_OF_QUEUES:
+        trace_nvme_setfeat_numq((dw11 & 0xFFFF) + 1, ((dw11 >> 16) &
0xFFFF) + 1,
+                                n->num_queues - 1, n->num_queues - 1);
         req->cqe.result =
             cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16));
         break;
     default:
+        trace_nvme_setfeat_invalid(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     return NVME_SUCCESS;
@@ -662,6 +718,7 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n,
NvmeCmd *cmd, NvmeRequest *req)
     case NVME_ADM_CMD_GET_FEATURES:
         return nvme_get_feature(n, cmd, req);
     default:
+        trace_nvme_invalid_admin_opc(cmd->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
 }
@@ -721,15 +778,72 @@ static int nvme_start_ctrl(NvmeCtrl *n)
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
+        trace_nvme_startfail_cq();
+        return -1;
+    }
+    if (n->sq[0]) {
+        trace_nvme_startfail_sq();
+        return -1;
+    }
+    if (!n->bar.asq) {
+        trace_nvme_startfail_nbarasq();
+        return -1;
+    }
+    if (!n->bar.acq) {
+        trace_nvme_startfail_nbaracq();
+        return -1;
+    }
+    if (n->bar.asq & (page_size - 1)) {
+        trace_nvme_startfail_asq_misaligned(n->bar.asq);
+        return -1;
+    }
+    if (n->bar.acq & (page_size - 1)) {
+        trace_nvme_startfail_acq_misaligned(n->bar.asq);
+        return -1;
+    }
+    if (NVME_CC_MPS(n->bar.cc) < NVME_CAP_MPSMIN(n->bar.cap)) {
+        trace_nvme_startfail_page_too_small(
+                    NVME_CC_MPS(n->bar.cc),
+                    NVME_CAP_MPSMIN(n->bar.cap));
+        return -1;
+    }
+    if (NVME_CC_MPS(n->bar.cc) > NVME_CAP_MPSMAX(n->bar.cap)) {
+        trace_nvme_startfail_page_too_large(
+                    NVME_CC_MPS(n->bar.cc),
+                    NVME_CAP_MPSMAX(n->bar.cap));
+        return -1;
+    }
+    if (NVME_CC_IOCQES(n->bar.cc) < NVME_CTRL_CQES_MIN(n->id_ctrl.cqes)) {
+        trace_nvme_startfail_cqent_too_small(
+                    NVME_CC_IOCQES(n->bar.cc),
+                    NVME_CTRL_CQES_MIN(n->bar.cap));
+        return -1;
+    }
+    if (NVME_CC_IOCQES(n->bar.cc) > NVME_CTRL_CQES_MAX(n->id_ctrl.cqes)) {
+        trace_nvme_startfail_cqent_too_large(
+                    NVME_CC_IOCQES(n->bar.cc),
+                    NVME_CTRL_CQES_MAX(n->bar.cap));
+        return -1;
+    }
+    if (NVME_CC_IOSQES(n->bar.cc) < NVME_CTRL_SQES_MIN(n->id_ctrl.sqes)) {
+        trace_nvme_startfail_sqent_too_small(
+                    NVME_CC_IOSQES(n->bar.cc),
+                    NVME_CTRL_SQES_MIN(n->bar.cap));
+        return -1;
+    }
+    if (NVME_CC_IOSQES(n->bar.cc) > NVME_CTRL_SQES_MAX(n->id_ctrl.sqes)) {
+        trace_nvme_startfail_sqent_too_large(
+                    NVME_CC_IOSQES(n->bar.cc),
+                    NVME_CTRL_SQES_MAX(n->bar.cap));
+        return -1;
+    }
+    if (!NVME_AQA_ASQS(n->bar.aqa)) {
+        trace_nvme_startfail_asqent_sz_zero();
+        return -1;
+    }
+    if (!NVME_AQA_ACQS(n->bar.aqa)) {
+        trace_nvme_startfail_acqent_sz_zero();
         return -1;
     }

@@ -753,12 +867,17 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr
offset, uint64_t data,
     case 0xc:
         n->bar.intms |= data & 0xffffffff;
         n->bar.intmc = n->bar.intms;
+        trace_nvme_mmio_intm_set(data & 0xffffffff,
+                                 n->bar.intmc);
         break;
     case 0x10:
         n->bar.intms &= ~(data & 0xffffffff);
         n->bar.intmc = n->bar.intms;
+        trace_nvme_mmio_intm_clr(data & 0xffffffff,
+                                 n->bar.intmc);
         break;
     case 0x14:
+        trace_nvme_mmio_cfg(data & 0xffffffff);
         /* Windows first sends data, then sends enable bit */
         if (!NVME_CC_EN(data) && !NVME_CC_EN(n->bar.cc) &&
             !NVME_CC_SHN(data) && !NVME_CC_SHN(n->bar.cc))
@@ -769,39 +888,50 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr
offset, uint64_t data,
         if (NVME_CC_EN(data) && !NVME_CC_EN(n->bar.cc)) {
             n->bar.cc = data;
             if (nvme_start_ctrl(n)) {
+                trace_nvme_mmio_start_failed();
                 n->bar.csts = NVME_CSTS_FAILED;
             } else {
+                trace_nvme_mmio_start_success();
                 n->bar.csts = NVME_CSTS_READY;
             }
         } else if (!NVME_CC_EN(data) && NVME_CC_EN(n->bar.cc)) {
+            trace_nvme_mmio_stopped();
             nvme_clear_ctrl(n);
             n->bar.csts &= ~NVME_CSTS_READY;
         }
         if (NVME_CC_SHN(data) && !(NVME_CC_SHN(n->bar.cc))) {
-                nvme_clear_ctrl(n);
-                n->bar.cc = data;
-                n->bar.csts |= NVME_CSTS_SHST_COMPLETE;
+            trace_nvme_mmio_shutdown_set();
+            nvme_clear_ctrl(n);
+            n->bar.cc = data;
+            n->bar.csts |= NVME_CSTS_SHST_COMPLETE;
         } else if (!NVME_CC_SHN(data) && NVME_CC_SHN(n->bar.cc)) {
-                n->bar.csts &= ~NVME_CSTS_SHST_COMPLETE;
-                n->bar.cc = data;
+            trace_nvme_mmio_shutdown_cleared();
+            n->bar.csts &= ~NVME_CSTS_SHST_COMPLETE;
+            n->bar.cc = data;
         }
         break;
     case 0x24:
+        trace_nvme_mmio_aqattr(data & 0xffffffff);
         n->bar.aqa = data & 0xffffffff;
         break;
     case 0x28:
+        trace_nvme_mmio_asqaddr(data);
         n->bar.asq = data;
         break;
     case 0x2c:
         n->bar.asq |= data << 32;
+        trace_nvme_mmio_asqaddr_hi(data, n->bar.asq);
         break;
     case 0x30:
+        trace_nvme_mmio_acqaddr(data);
         n->bar.acq = data;
         break;
     case 0x34:
         n->bar.acq |= data << 32;
+        trace_nvme_mmio_acqaddr_hi(data, n->bar.acq);
         break;
     default:
+        trace_nvme_mmio_ignored(offset, data);
         break;
     }
 }
diff --git a/hw/block/trace-events b/hw/block/trace-events
index cb6767b3ee..d246339336 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -10,3 +10,92 @@ virtio_blk_submit_multireq(void *vdev, void *mrb,
int start, int num_reqs, uint6
 # hw/block/hd-geometry.c
 hd_geometry_lchs_guess(void *blk, int cyls, int heads, int secs) "blk
%p LCHS %d %d %d"
 hd_geometry_guess(void *blk, uint32_t cyls, uint32_t heads, uint32_t
secs, int trans) "blk %p CHS %u %u %u trans %d"
+
+# hw/block/nvme.c
+nvme_msix_intr(uint32_t vector) "raising MSI-X IRQ vector %u"
+nvme_pin_intr(void) "pulsing IRQ pin"
+nvme_masked_intr(void) "IRQ is masked"
+
+nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read,
prp1=0x%"PRIx64" prp2=0x%"PRIx64""
+nvme_rw(char const *verb, uint32_t blk_count, uint64_t byte_count,
uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA
%"PRIu64""
+
+nvme_dma_too_short(void) "PRP/SGL is too small for transfer size"
+nvme_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or
not page aligned: 0x%"PRIx64"!"
+nvme_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: %"PRIx64"!"
+nvme_invalid_prp2_missing(void) "PRP2 is null and more data to be transferred!"
+nvme_invalid_field(void) "invalid field!"
+nvme_invalid_prp(void) "invalid PRP!"
+nvme_invalid_sgl(void) "invalid SGL!"
+nvme_invalid_ns(uint32_t ns, uint32_t limit) "invalid namespace %u
not within 1-%u!"
+nvme_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8"!"
+nvme_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8"!"
+nvme_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit)
"Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
+
+nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
+nvme_del_sq_invalid(uint16_t qid) "invalid submission queue deletion,
sid=%"PRIu16""
+
+nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t
qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64",
sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
+nvme_create_sq_invalid_cqid(uint16_t cqid) "failed creating
submission queue, invalid cqid=%"PRIu16"!"
+nvme_create_sq_invalid_sqid(uint16_t sqid) "failed creating
submission queue, invalid sqid=%"PRIu16"!"
+nvme_create_sq_invalid_size(uint16_t qsize) "failed creating
submission queue, invalid qsize=%"PRIu16"!"
+nvme_create_sq_invalid_addr(uint64_t addr) "failed creating
submission queue, addr=0x%"PRIx64"!"
+nvme_create_sq_invalid_qflags(uint16_t qflags) "failed creating
submission queue, qflags=%"PRIu16"!"
+
+nvme_del_cq_invalid_cqid(uint16_t cqid) "failed deleting completion
queue, cqid=%"PRIu16"!"
+nvme_del_cq_invalid_notempty(uint16_t cqid) "failed deleting
completion queue, it is not empty, cqid=%"PRIu16"!"
+nvme_del_cq(uint16_t cqid) "deleted completion queue, sqid=%"PRIu16""
+
+nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector,
uint16_t size, uint16_t qflags, int ien) "create completion queue,
addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16",
qflags=%"PRIu16", ien=%d"
+nvme_create_cq_invalid_cqid(uint16_t cqid) "failed creating
completion queue, cqid=%"PRIu16"!"
+nvme_create_cq_invalid_size(uint16_t size) "failed creating
completion queue, size=%"PRIu16"!"
+nvme_create_cq_invalid_addr(uint64_t addr) "failed creating
completion queue, addr=0x%"PRIx64"!"
+nvme_create_cq_invalid_vector(uint16_t vector) "failed creating
completion queue, vector=%"PRIu16"!"
+nvme_create_cq_invalid_qflags(uint16_t qflags) "failed creating
completion queue, qflags=%"PRIu16"!"
+
+nvme_identify_ctrl(void) "identify controller"
+nvme_identify_ns(uint16_t ns) "identify namespace, nsid=%"PRIu16""
+nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=%"PRIu16""
+nvme_identify_invalid_cns(uint16_t cns) "identify, invalid cns=0x%"PRIx16"!"
+
+nvme_getfeat_vwcache(char const* result) "get feature volatile write
cache, result=%s"
+nvme_getfeat_numq(int result) "get feature number of queues, result=%d"
+nvme_getfeat_invalid(int dw10) "invalid get features, dw10=%"PRIx32"!"
+nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq)
"requested cq_count=%d sq_count=%d, responding with cq_count=%d
sq_count=%d"
+nvme_setfeat_invalid(uint32_t dw10) "invalid set features, dw10=%"PRIx32"!"
+
+nvme_startfail_cq(void) "nvme_start_ctrl failed because there are
non-admin completion queues!"
+nvme_startfail_sq(void) "nvme_start_ctrl failed because there are
non-admin submission queues!"
+
+nvme_startfail_nbarasq(void) "nvme_start_ctrl failed because the
admin submission queue address is null!"
+nvme_startfail_nbaracq(void) "nvme_start_ctrl failed because the
admin completion queue address is null!"
+
+nvme_startfail_asq_misaligned(uint64_t addr) "nvme_start_ctrl failed
because the admin submission queue address is misaligned:
0x%"PRIx64"!"
+nvme_startfail_acq_misaligned(uint64_t addr) "nvme_start_ctrl failed
because the admin completion queue address is misaligned:
0x%"PRIx64"!"
+
+nvme_startfail_page_too_small(uint8_t log2ps, uint8_t maxlog2ps)
"nvme_start_ctrl failed because the page size is too small:
log2size=%u, min=%u"
+nvme_startfail_page_too_large(uint8_t log2ps, uint8_t maxlog2ps)
"nvme_start_ctrl failed because the page size is too large:
log2size=%u, max=%u"
+
+nvme_startfail_sqent_too_small(uint8_t log2ps, uint8_t maxlog2ps)
"nvme_start_ctrl failed because the submission queue entry size is too
small: log2size=%u, min=%u"
+nvme_startfail_sqent_too_large(uint8_t log2ps, uint8_t maxlog2ps)
"nvme_start_ctrl failed because the submission queue entry size is too
large: log2size=%u, max=%u"
+
+nvme_startfail_cqent_too_small(uint8_t log2ps, uint8_t maxlog2ps)
"nvme_start_ctrl failed because the completion queue entry size is too
small: log2size=%u, min=%u"
+nvme_startfail_cqent_too_large(uint8_t log2ps, uint8_t maxlog2ps)
"nvme_start_ctrl failed because the completion queue entry size is too
large: log2size=%u, max=%u"
+
+nvme_startfail_acqent_sz_zero(void) "nvme_start_ctrl failed because
the admin completion queue size is zero"
+nvme_startfail_asqent_sz_zero(void) "nvme_start_ctrl failed because
the admin submission queue size is zero"
+
+nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO,
interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
+nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO,
interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
+nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
+nvme_mmio_aqattr(uint64_t data) "wrote MMIO, admin queue
attributes=0x%"PRIx64""
+nvme_mmio_asqaddr(uint64_t data) "wrote MMIO, admin submission queue
address=0x%"PRIx64""
+nvme_mmio_acqaddr(uint64_t data) "wrote MMIO, admin completion queue
address=0x%"PRIx64""
+nvme_mmio_asqaddr_hi(uint64_t data, uint64_t new_addr) "wrote MMIO,
admin submission queue high half=0x%"PRIx64", new_address=%"PRIx64""
+nvme_mmio_acqaddr_hi(uint64_t data, uint64_t new_addr) "wrote MMIO,
admin completion queue high half=0x%"PRIx64", new_address=%"PRIx64""
+nvme_mmio_start_failed(void) "setting controller enable bit failed!"
+nvme_mmio_start_success(void) "setting controller enable bit succeeded"
+nvme_mmio_stopped(void) "cleared controller enable bit"
+nvme_mmio_shutdown_set(void) "shutdown bit set"
+nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
+nvme_mmio_ignored(uint64_t offset, uint64_t data) "invalid MMIO
write, offset=0x%"PRIx64", data=%"PRIx64"!"
+
-- 
2.11.0

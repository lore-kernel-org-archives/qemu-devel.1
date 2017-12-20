Received: from eggs.gnu.org ([2001:4830:134:3::10]:56256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eReIS-000534-Pq
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eReIO-000736-G5
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:20:32 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 20 Dec 2017 14:19:39 +0100
Message-Id: <20171220131939.27543-15-kwolf@redhat.com>
In-Reply-To: <20171220131939.27543-1-kwolf@redhat.com>
References: <20171220131939.27543-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/14] nvme: Add tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Doug Gale <doug16k@gmail.com>

Add trace output for commands, errors, and undefined behavior.
Add guest error log output for undefined behavior.
Report invalid undefined accesses to MMIO.
Annotate unlikely error checks with unlikely.

Signed-off-by: Doug Gale <doug16k@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c       | 349 ++++++++++++++++++++++++++++++++++++++++++--=
------
 hw/block/trace-events |  93 ++++++++++++++
 2 files changed, 390 insertions(+), 52 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index e530ba7a30..b9f76204a7 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -34,8 +34,17 @@
 #include "qapi/visitor.h"
 #include "sysemu/block-backend.h"
=20
+#include "qemu/log.h"
+#include "trace.h"
 #include "nvme.h"
=20
+#define NVME_GUEST_ERR(trace, fmt, ...) \
+    do { \
+        (trace_##trace)(__VA_ARGS__); \
+        qemu_log_mask(LOG_GUEST_ERROR, #trace \
+            " in %s: " fmt "\n", __func__, ## __VA_ARGS__); \
+    } while (0)
+
 static void nvme_process_sq(void *opaque);
=20
 static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size=
)
@@ -86,10 +95,14 @@ static void nvme_isr_notify(NvmeCtrl *n, NvmeCQueue *=
cq)
 {
     if (cq->irq_enabled) {
         if (msix_enabled(&(n->parent_obj))) {
+            trace_nvme_irq_msix(cq->vector);
             msix_notify(&(n->parent_obj), cq->vector);
         } else {
+            trace_nvme_irq_pin();
             pci_irq_pulse(&n->parent_obj);
         }
+    } else {
+        trace_nvme_irq_masked();
     }
 }
=20
@@ -100,7 +113,8 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOV=
ector *iov, uint64_t prp1,
     trans_len =3D MIN(len, trans_len);
     int num_prps =3D (len >> n->page_bits) + 1;
=20
-    if (!prp1) {
+    if (unlikely(!prp1)) {
+        trace_nvme_err_invalid_prp();
         return NVME_INVALID_FIELD | NVME_DNR;
     } else if (n->cmbsz && prp1 >=3D n->ctrl_mem.addr &&
                prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size))=
 {
@@ -113,7 +127,8 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOV=
ector *iov, uint64_t prp1,
     }
     len -=3D trans_len;
     if (len) {
-        if (!prp2) {
+        if (unlikely(!prp2)) {
+            trace_nvme_err_invalid_prp2_missing();
             goto unmap;
         }
         if (len > n->page_size) {
@@ -128,7 +143,8 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOV=
ector *iov, uint64_t prp1,
                 uint64_t prp_ent =3D le64_to_cpu(prp_list[i]);
=20
                 if (i =3D=3D n->max_prp_ents - 1 && len > n->page_size) =
{
-                    if (!prp_ent || prp_ent & (n->page_size - 1)) {
+                    if (unlikely(!prp_ent || prp_ent & (n->page_size - 1=
))) {
+                        trace_nvme_err_invalid_prplist_ent(prp_ent);
                         goto unmap;
                     }
=20
@@ -140,7 +156,8 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOV=
ector *iov, uint64_t prp1,
                     prp_ent =3D le64_to_cpu(prp_list[i]);
                 }
=20
-                if (!prp_ent || prp_ent & (n->page_size - 1)) {
+                if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) =
{
+                    trace_nvme_err_invalid_prplist_ent(prp_ent);
                     goto unmap;
                 }
=20
@@ -154,7 +171,8 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOV=
ector *iov, uint64_t prp1,
                 i++;
             }
         } else {
-            if (prp2 & (n->page_size - 1)) {
+            if (unlikely(prp2 & (n->page_size - 1))) {
+                trace_nvme_err_invalid_prp2_align(prp2);
                 goto unmap;
             }
             if (qsg->nsg) {
@@ -178,16 +196,20 @@ static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint=
8_t *ptr, uint32_t len,
     QEMUIOVector iov;
     uint16_t status =3D NVME_SUCCESS;
=20
+    trace_nvme_dma_read(prp1, prp2);
+
     if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     if (qsg.nsg > 0) {
-        if (dma_buf_read(ptr, len, &qsg)) {
+        if (unlikely(dma_buf_read(ptr, len, &qsg))) {
+            trace_nvme_err_invalid_dma();
             status =3D NVME_INVALID_FIELD | NVME_DNR;
         }
         qemu_sglist_destroy(&qsg);
     } else {
-        if (qemu_iovec_to_buf(&iov, 0, ptr, len) !=3D len) {
+        if (unlikely(qemu_iovec_to_buf(&iov, 0, ptr, len) !=3D len)) {
+            trace_nvme_err_invalid_dma();
             status =3D NVME_INVALID_FIELD | NVME_DNR;
         }
         qemu_iovec_destroy(&iov);
@@ -273,7 +295,8 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNam=
espace *ns, NvmeCmd *cmd,
     uint64_t aio_slba =3D slba << (data_shift - BDRV_SECTOR_BITS);
     uint32_t aio_nlb =3D nlb << (data_shift - BDRV_SECTOR_BITS);
=20
-    if (slba + nlb > ns->id_ns.nsze) {
+    if (unlikely(slba + nlb > ns->id_ns.nsze)) {
+        trace_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
         return NVME_LBA_RANGE | NVME_DNR;
     }
=20
@@ -301,8 +324,11 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *=
ns, NvmeCmd *cmd,
     int is_write =3D rw->opcode =3D=3D NVME_CMD_WRITE ? 1 : 0;
     enum BlockAcctType acct =3D is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT=
_READ;
=20
-    if ((slba + nlb) > ns->id_ns.nsze) {
+    trace_nvme_rw(is_write ? "write" : "read", nlb, data_size, slba);
+
+    if (unlikely((slba + nlb) > ns->id_ns.nsze)) {
         block_acct_invalid(blk_get_stats(n->conf.blk), acct);
+        trace_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
         return NVME_LBA_RANGE | NVME_DNR;
     }
=20
@@ -336,7 +362,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd=
, NvmeRequest *req)
     NvmeNamespace *ns;
     uint32_t nsid =3D le32_to_cpu(cmd->nsid);
=20
-    if (nsid =3D=3D 0 || nsid > n->num_namespaces) {
+    if (unlikely(nsid =3D=3D 0 || nsid > n->num_namespaces)) {
+        trace_nvme_err_invalid_ns(nsid, n->num_namespaces);
         return NVME_INVALID_NSID | NVME_DNR;
     }
=20
@@ -350,6 +377,7 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd=
, NvmeRequest *req)
     case NVME_CMD_READ:
         return nvme_rw(n, ns, cmd, req);
     default:
+        trace_nvme_err_invalid_opc(cmd->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
 }
@@ -373,10 +401,13 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *c=
md)
     NvmeCQueue *cq;
     uint16_t qid =3D le16_to_cpu(c->qid);
=20
-    if (!qid || nvme_check_sqid(n, qid)) {
+    if (unlikely(!qid || nvme_check_sqid(n, qid))) {
+        trace_nvme_err_invalid_del_sq(qid);
         return NVME_INVALID_QID | NVME_DNR;
     }
=20
+    trace_nvme_del_sq(qid);
+
     sq =3D n->sq[qid];
     while (!QTAILQ_EMPTY(&sq->out_req_list)) {
         req =3D QTAILQ_FIRST(&sq->out_req_list);
@@ -439,19 +470,26 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd=
 *cmd)
     uint16_t qflags =3D le16_to_cpu(c->sq_flags);
     uint64_t prp1 =3D le64_to_cpu(c->prp1);
=20
-    if (!cqid || nvme_check_cqid(n, cqid)) {
+    trace_nvme_create_sq(prp1, sqid, cqid, qsize, qflags);
+
+    if (unlikely(!cqid || nvme_check_cqid(n, cqid))) {
+        trace_nvme_err_invalid_create_sq_cqid(cqid);
         return NVME_INVALID_CQID | NVME_DNR;
     }
-    if (!sqid || !nvme_check_sqid(n, sqid)) {
+    if (unlikely(!sqid || !nvme_check_sqid(n, sqid))) {
+        trace_nvme_err_invalid_create_sq_sqid(sqid);
         return NVME_INVALID_QID | NVME_DNR;
     }
-    if (!qsize || qsize > NVME_CAP_MQES(n->bar.cap)) {
+    if (unlikely(!qsize || qsize > NVME_CAP_MQES(n->bar.cap))) {
+        trace_nvme_err_invalid_create_sq_size(qsize);
         return NVME_MAX_QSIZE_EXCEEDED | NVME_DNR;
     }
-    if (!prp1 || prp1 & (n->page_size - 1)) {
+    if (unlikely(!prp1 || prp1 & (n->page_size - 1))) {
+        trace_nvme_err_invalid_create_sq_addr(prp1);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
-    if (!(NVME_SQ_FLAGS_PC(qflags))) {
+    if (unlikely(!(NVME_SQ_FLAGS_PC(qflags)))) {
+        trace_nvme_err_invalid_create_sq_qflags(NVME_SQ_FLAGS_PC(qflags)=
);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     sq =3D g_malloc0(sizeof(*sq));
@@ -476,14 +514,17 @@ static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *c=
md)
     NvmeCQueue *cq;
     uint16_t qid =3D le16_to_cpu(c->qid);
=20
-    if (!qid || nvme_check_cqid(n, qid)) {
+    if (unlikely(!qid || nvme_check_cqid(n, qid))) {
+        trace_nvme_err_invalid_del_cq_cqid(qid);
         return NVME_INVALID_CQID | NVME_DNR;
     }
=20
     cq =3D n->cq[qid];
-    if (!QTAILQ_EMPTY(&cq->sq_list)) {
+    if (unlikely(!QTAILQ_EMPTY(&cq->sq_list))) {
+        trace_nvme_err_invalid_del_cq_notempty(qid);
         return NVME_INVALID_QUEUE_DEL;
     }
+    trace_nvme_del_cq(qid);
     nvme_free_cq(cq, n);
     return NVME_SUCCESS;
 }
@@ -516,19 +557,27 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd=
 *cmd)
     uint16_t qflags =3D le16_to_cpu(c->cq_flags);
     uint64_t prp1 =3D le64_to_cpu(c->prp1);
=20
-    if (!cqid || !nvme_check_cqid(n, cqid)) {
+    trace_nvme_create_cq(prp1, cqid, vector, qsize, qflags,
+                         NVME_CQ_FLAGS_IEN(qflags) !=3D 0);
+
+    if (unlikely(!cqid || !nvme_check_cqid(n, cqid))) {
+        trace_nvme_err_invalid_create_cq_cqid(cqid);
         return NVME_INVALID_CQID | NVME_DNR;
     }
-    if (!qsize || qsize > NVME_CAP_MQES(n->bar.cap)) {
+    if (unlikely(!qsize || qsize > NVME_CAP_MQES(n->bar.cap))) {
+        trace_nvme_err_invalid_create_cq_size(qsize);
         return NVME_MAX_QSIZE_EXCEEDED | NVME_DNR;
     }
-    if (!prp1) {
+    if (unlikely(!prp1)) {
+        trace_nvme_err_invalid_create_cq_addr(prp1);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
-    if (vector > n->num_queues) {
+    if (unlikely(vector > n->num_queues)) {
+        trace_nvme_err_invalid_create_cq_vector(vector);
         return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
     }
-    if (!(NVME_CQ_FLAGS_PC(qflags))) {
+    if (unlikely(!(NVME_CQ_FLAGS_PC(qflags)))) {
+        trace_nvme_err_invalid_create_cq_qflags(NVME_CQ_FLAGS_PC(qflags)=
);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
=20
@@ -543,6 +592,8 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeI=
dentify *c)
     uint64_t prp1 =3D le64_to_cpu(c->prp1);
     uint64_t prp2 =3D le64_to_cpu(c->prp2);
=20
+    trace_nvme_identify_ctrl();
+
     return nvme_dma_read_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctr=
l),
         prp1, prp2);
 }
@@ -554,11 +605,15 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeI=
dentify *c)
     uint64_t prp1 =3D le64_to_cpu(c->prp1);
     uint64_t prp2 =3D le64_to_cpu(c->prp2);
=20
-    if (nsid =3D=3D 0 || nsid > n->num_namespaces) {
+    trace_nvme_identify_ns(nsid);
+
+    if (unlikely(nsid =3D=3D 0 || nsid > n->num_namespaces)) {
+        trace_nvme_err_invalid_ns(nsid, n->num_namespaces);
         return NVME_INVALID_NSID | NVME_DNR;
     }
=20
     ns =3D &n->namespaces[nsid - 1];
+
     return nvme_dma_read_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns)=
,
         prp1, prp2);
 }
@@ -573,6 +628,8 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, Nvm=
eIdentify *c)
     uint16_t ret;
     int i, j =3D 0;
=20
+    trace_nvme_identify_nslist(min_nsid);
+
     list =3D g_malloc0(data_len);
     for (i =3D 0; i < n->num_namespaces; i++) {
         if (i < min_nsid) {
@@ -601,6 +658,7 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *c=
md)
     case 0x02:
         return nvme_identify_nslist(n, c);
     default:
+        trace_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 }
@@ -613,11 +671,14 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
     switch (dw10) {
     case NVME_VOLATILE_WRITE_CACHE:
         result =3D blk_enable_write_cache(n->conf.blk);
+        trace_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
         break;
     case NVME_NUMBER_OF_QUEUES:
         result =3D cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2=
) << 16));
+        trace_nvme_getfeat_numq(result);
         break;
     default:
+        trace_nvme_err_invalid_getfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
=20
@@ -635,10 +696,14 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
         blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
         break;
     case NVME_NUMBER_OF_QUEUES:
+        trace_nvme_setfeat_numq((dw11 & 0xFFFF) + 1,
+                                ((dw11 >> 16) & 0xFFFF) + 1,
+                                n->num_queues - 1, n->num_queues - 1);
         req->cqe.result =3D
             cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16=
));
         break;
     default:
+        trace_nvme_err_invalid_setfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
     return NVME_SUCCESS;
@@ -662,6 +727,7 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *=
cmd, NvmeRequest *req)
     case NVME_ADM_CMD_GET_FEATURES:
         return nvme_get_feature(n, cmd, req);
     default:
+        trace_nvme_err_invalid_admin_opc(cmd->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
 }
@@ -721,15 +787,78 @@ static int nvme_start_ctrl(NvmeCtrl *n)
     uint32_t page_bits =3D NVME_CC_MPS(n->bar.cc) + 12;
     uint32_t page_size =3D 1 << page_bits;
=20
-    if (n->cq[0] || n->sq[0] || !n->bar.asq || !n->bar.acq ||
-            n->bar.asq & (page_size - 1) || n->bar.acq & (page_size - 1)=
 ||
-            NVME_CC_MPS(n->bar.cc) < NVME_CAP_MPSMIN(n->bar.cap) ||
-            NVME_CC_MPS(n->bar.cc) > NVME_CAP_MPSMAX(n->bar.cap) ||
-            NVME_CC_IOCQES(n->bar.cc) < NVME_CTRL_CQES_MIN(n->id_ctrl.cq=
es) ||
-            NVME_CC_IOCQES(n->bar.cc) > NVME_CTRL_CQES_MAX(n->id_ctrl.cq=
es) ||
-            NVME_CC_IOSQES(n->bar.cc) < NVME_CTRL_SQES_MIN(n->id_ctrl.sq=
es) ||
-            NVME_CC_IOSQES(n->bar.cc) > NVME_CTRL_SQES_MAX(n->id_ctrl.sq=
es) ||
-            !NVME_AQA_ASQS(n->bar.aqa) || !NVME_AQA_ACQS(n->bar.aqa)) {
+    if (unlikely(n->cq[0])) {
+        trace_nvme_err_startfail_cq();
+        return -1;
+    }
+    if (unlikely(n->sq[0])) {
+        trace_nvme_err_startfail_sq();
+        return -1;
+    }
+    if (unlikely(!n->bar.asq)) {
+        trace_nvme_err_startfail_nbarasq();
+        return -1;
+    }
+    if (unlikely(!n->bar.acq)) {
+        trace_nvme_err_startfail_nbaracq();
+        return -1;
+    }
+    if (unlikely(n->bar.asq & (page_size - 1))) {
+        trace_nvme_err_startfail_asq_misaligned(n->bar.asq);
+        return -1;
+    }
+    if (unlikely(n->bar.acq & (page_size - 1))) {
+        trace_nvme_err_startfail_acq_misaligned(n->bar.acq);
+        return -1;
+    }
+    if (unlikely(NVME_CC_MPS(n->bar.cc) <
+                 NVME_CAP_MPSMIN(n->bar.cap))) {
+        trace_nvme_err_startfail_page_too_small(
+                    NVME_CC_MPS(n->bar.cc),
+                    NVME_CAP_MPSMIN(n->bar.cap));
+        return -1;
+    }
+    if (unlikely(NVME_CC_MPS(n->bar.cc) >
+                 NVME_CAP_MPSMAX(n->bar.cap))) {
+        trace_nvme_err_startfail_page_too_large(
+                    NVME_CC_MPS(n->bar.cc),
+                    NVME_CAP_MPSMAX(n->bar.cap));
+        return -1;
+    }
+    if (unlikely(NVME_CC_IOCQES(n->bar.cc) <
+                 NVME_CTRL_CQES_MIN(n->id_ctrl.cqes))) {
+        trace_nvme_err_startfail_cqent_too_small(
+                    NVME_CC_IOCQES(n->bar.cc),
+                    NVME_CTRL_CQES_MIN(n->bar.cap));
+        return -1;
+    }
+    if (unlikely(NVME_CC_IOCQES(n->bar.cc) >
+                 NVME_CTRL_CQES_MAX(n->id_ctrl.cqes))) {
+        trace_nvme_err_startfail_cqent_too_large(
+                    NVME_CC_IOCQES(n->bar.cc),
+                    NVME_CTRL_CQES_MAX(n->bar.cap));
+        return -1;
+    }
+    if (unlikely(NVME_CC_IOSQES(n->bar.cc) <
+                 NVME_CTRL_SQES_MIN(n->id_ctrl.sqes))) {
+        trace_nvme_err_startfail_sqent_too_small(
+                    NVME_CC_IOSQES(n->bar.cc),
+                    NVME_CTRL_SQES_MIN(n->bar.cap));
+        return -1;
+    }
+    if (unlikely(NVME_CC_IOSQES(n->bar.cc) >
+                 NVME_CTRL_SQES_MAX(n->id_ctrl.sqes))) {
+        trace_nvme_err_startfail_sqent_too_large(
+                    NVME_CC_IOSQES(n->bar.cc),
+                    NVME_CTRL_SQES_MAX(n->bar.cap));
+        return -1;
+    }
+    if (unlikely(!NVME_AQA_ASQS(n->bar.aqa))) {
+        trace_nvme_err_startfail_asqent_sz_zero();
+        return -1;
+    }
+    if (unlikely(!NVME_AQA_ACQS(n->bar.aqa))) {
+        trace_nvme_err_startfail_acqent_sz_zero();
         return -1;
     }
=20
@@ -749,16 +878,48 @@ static int nvme_start_ctrl(NvmeCtrl *n)
 static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
     unsigned size)
 {
+    if (unlikely(offset & (sizeof(uint32_t) - 1))) {
+        NVME_GUEST_ERR(nvme_ub_mmiowr_misaligned32,
+                       "MMIO write not 32-bit aligned,"
+                       " offset=3D0x%"PRIx64"", offset);
+        /* should be ignored, fall through for now */
+    }
+
+    if (unlikely(size < sizeof(uint32_t))) {
+        NVME_GUEST_ERR(nvme_ub_mmiowr_toosmall,
+                       "MMIO write smaller than 32-bits,"
+                       " offset=3D0x%"PRIx64", size=3D%u",
+                       offset, size);
+        /* should be ignored, fall through for now */
+    }
+
     switch (offset) {
-    case 0xc:
+    case 0xc:   /* INTMS */
+        if (unlikely(msix_enabled(&(n->parent_obj)))) {
+            NVME_GUEST_ERR(nvme_ub_mmiowr_intmask_with_msix,
+                           "undefined access to interrupt mask set"
+                           " when MSI-X is enabled");
+            /* should be ignored, fall through for now */
+        }
         n->bar.intms |=3D data & 0xffffffff;
         n->bar.intmc =3D n->bar.intms;
+        trace_nvme_mmio_intm_set(data & 0xffffffff,
+                                 n->bar.intmc);
         break;
-    case 0x10:
+    case 0x10:  /* INTMC */
+        if (unlikely(msix_enabled(&(n->parent_obj)))) {
+            NVME_GUEST_ERR(nvme_ub_mmiowr_intmask_with_msix,
+                           "undefined access to interrupt mask clr"
+                           " when MSI-X is enabled");
+            /* should be ignored, fall through for now */
+        }
         n->bar.intms &=3D ~(data & 0xffffffff);
         n->bar.intmc =3D n->bar.intms;
+        trace_nvme_mmio_intm_clr(data & 0xffffffff,
+                                 n->bar.intmc);
         break;
-    case 0x14:
+    case 0x14:  /* CC */
+        trace_nvme_mmio_cfg(data & 0xffffffff);
         /* Windows first sends data, then sends enable bit */
         if (!NVME_CC_EN(data) && !NVME_CC_EN(n->bar.cc) &&
             !NVME_CC_SHN(data) && !NVME_CC_SHN(n->bar.cc))
@@ -768,40 +929,82 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offs=
et, uint64_t data,
=20
         if (NVME_CC_EN(data) && !NVME_CC_EN(n->bar.cc)) {
             n->bar.cc =3D data;
-            if (nvme_start_ctrl(n)) {
+            if (unlikely(nvme_start_ctrl(n))) {
+                trace_nvme_err_startfail();
                 n->bar.csts =3D NVME_CSTS_FAILED;
             } else {
+                trace_nvme_mmio_start_success();
                 n->bar.csts =3D NVME_CSTS_READY;
             }
         } else if (!NVME_CC_EN(data) && NVME_CC_EN(n->bar.cc)) {
+            trace_nvme_mmio_stopped();
             nvme_clear_ctrl(n);
             n->bar.csts &=3D ~NVME_CSTS_READY;
         }
         if (NVME_CC_SHN(data) && !(NVME_CC_SHN(n->bar.cc))) {
-                nvme_clear_ctrl(n);
-                n->bar.cc =3D data;
-                n->bar.csts |=3D NVME_CSTS_SHST_COMPLETE;
+            trace_nvme_mmio_shutdown_set();
+            nvme_clear_ctrl(n);
+            n->bar.cc =3D data;
+            n->bar.csts |=3D NVME_CSTS_SHST_COMPLETE;
         } else if (!NVME_CC_SHN(data) && NVME_CC_SHN(n->bar.cc)) {
-                n->bar.csts &=3D ~NVME_CSTS_SHST_COMPLETE;
-                n->bar.cc =3D data;
+            trace_nvme_mmio_shutdown_cleared();
+            n->bar.csts &=3D ~NVME_CSTS_SHST_COMPLETE;
+            n->bar.cc =3D data;
+        }
+        break;
+    case 0x1C:  /* CSTS */
+        if (data & (1 << 4)) {
+            NVME_GUEST_ERR(nvme_ub_mmiowr_ssreset_w1c_unsupported,
+                           "attempted to W1C CSTS.NSSRO"
+                           " but CAP.NSSRS is zero (not supported)");
+        } else if (data !=3D 0) {
+            NVME_GUEST_ERR(nvme_ub_mmiowr_ro_csts,
+                           "attempted to set a read only bit"
+                           " of controller status");
+        }
+        break;
+    case 0x20:  /* NSSR */
+        if (data =3D=3D 0x4E564D65) {
+            trace_nvme_ub_mmiowr_ssreset_unsupported();
+        } else {
+            /* The spec says that writes of other values have no effect =
*/
+            return;
         }
         break;
-    case 0x24:
+    case 0x24:  /* AQA */
         n->bar.aqa =3D data & 0xffffffff;
+        trace_nvme_mmio_aqattr(data & 0xffffffff);
         break;
-    case 0x28:
+    case 0x28:  /* ASQ */
         n->bar.asq =3D data;
+        trace_nvme_mmio_asqaddr(data);
         break;
-    case 0x2c:
+    case 0x2c:  /* ASQ hi */
         n->bar.asq |=3D data << 32;
+        trace_nvme_mmio_asqaddr_hi(data, n->bar.asq);
         break;
-    case 0x30:
+    case 0x30:  /* ACQ */
+        trace_nvme_mmio_acqaddr(data);
         n->bar.acq =3D data;
         break;
-    case 0x34:
+    case 0x34:  /* ACQ hi */
         n->bar.acq |=3D data << 32;
+        trace_nvme_mmio_acqaddr_hi(data, n->bar.acq);
         break;
+    case 0x38:  /* CMBLOC */
+        NVME_GUEST_ERR(nvme_ub_mmiowr_cmbloc_reserved,
+                       "invalid write to reserved CMBLOC"
+                       " when CMBSZ is zero, ignored");
+        return;
+    case 0x3C:  /* CMBSZ */
+        NVME_GUEST_ERR(nvme_ub_mmiowr_cmbsz_readonly,
+                       "invalid write to read only CMBSZ, ignored");
+        return;
     default:
+        NVME_GUEST_ERR(nvme_ub_mmiowr_invalid,
+                       "invalid MMIO write,"
+                       " offset=3D0x%"PRIx64", data=3D%"PRIx64"",
+                       offset, data);
         break;
     }
 }
@@ -812,9 +1015,26 @@ static uint64_t nvme_mmio_read(void *opaque, hwaddr=
 addr, unsigned size)
     uint8_t *ptr =3D (uint8_t *)&n->bar;
     uint64_t val =3D 0;
=20
+    if (unlikely(addr & (sizeof(uint32_t) - 1))) {
+        NVME_GUEST_ERR(nvme_ub_mmiord_misaligned32,
+                       "MMIO read not 32-bit aligned,"
+                       " offset=3D0x%"PRIx64"", addr);
+        /* should RAZ, fall through for now */
+    } else if (unlikely(size < sizeof(uint32_t))) {
+        NVME_GUEST_ERR(nvme_ub_mmiord_toosmall,
+                       "MMIO read smaller than 32-bits,"
+                       " offset=3D0x%"PRIx64"", addr);
+        /* should RAZ, fall through for now */
+    }
+
     if (addr < sizeof(n->bar)) {
         memcpy(&val, ptr + addr, size);
+    } else {
+        NVME_GUEST_ERR(nvme_ub_mmiord_invalid_ofs,
+                       "MMIO read beyond last register,"
+                       " offset=3D0x%"PRIx64", returning 0", addr);
     }
+
     return val;
 }
=20
@@ -822,22 +1042,36 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
dr, int val)
 {
     uint32_t qid;
=20
-    if (addr & ((1 << 2) - 1)) {
+    if (unlikely(addr & ((1 << 2) - 1))) {
+        NVME_GUEST_ERR(nvme_ub_db_wr_misaligned,
+                       "doorbell write not 32-bit aligned,"
+                       " offset=3D0x%"PRIx64", ignoring", addr);
         return;
     }
=20
     if (((addr - 0x1000) >> 2) & 1) {
+        /* Completion queue doorbell write */
+
         uint16_t new_head =3D val & 0xffff;
         int start_sqs;
         NvmeCQueue *cq;
=20
         qid =3D (addr - (0x1000 + (1 << 2))) >> 3;
-        if (nvme_check_cqid(n, qid)) {
+        if (unlikely(nvme_check_cqid(n, qid))) {
+            NVME_GUEST_ERR(nvme_ub_db_wr_invalid_cq,
+                           "completion queue doorbell write"
+                           " for nonexistent queue,"
+                           " sqid=3D%"PRIu32", ignoring", qid);
             return;
         }
=20
         cq =3D n->cq[qid];
-        if (new_head >=3D cq->size) {
+        if (unlikely(new_head >=3D cq->size)) {
+            NVME_GUEST_ERR(nvme_ub_db_wr_invalid_cqhead,
+                           "completion queue doorbell write value"
+                           " beyond queue size, sqid=3D%"PRIu32","
+                           " new_head=3D%"PRIu16", ignoring",
+                           qid, new_head);
             return;
         }
=20
@@ -855,16 +1089,27 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
dr, int val)
             nvme_isr_notify(n, cq);
         }
     } else {
+        /* Submission queue doorbell write */
+
         uint16_t new_tail =3D val & 0xffff;
         NvmeSQueue *sq;
=20
         qid =3D (addr - 0x1000) >> 3;
-        if (nvme_check_sqid(n, qid)) {
+        if (unlikely(nvme_check_sqid(n, qid))) {
+            NVME_GUEST_ERR(nvme_ub_db_wr_invalid_sq,
+                           "submission queue doorbell write"
+                           " for nonexistent queue,"
+                           " sqid=3D%"PRIu32", ignoring", qid);
             return;
         }
=20
         sq =3D n->sq[qid];
-        if (new_tail >=3D sq->size) {
+        if (unlikely(new_tail >=3D sq->size)) {
+            NVME_GUEST_ERR(nvme_ub_db_wr_invalid_sqtail,
+                           "submission queue doorbell write value"
+                           " beyond queue size, sqid=3D%"PRIu32","
+                           " new_tail=3D%"PRIu16", ignoring",
+                           qid, new_tail);
             return;
         }
=20
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 962a3bfa24..5acd495207 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -11,6 +11,99 @@ virtio_blk_submit_multireq(void *vdev, void *mrb, int =
start, int num_reqs, uint6
 hd_geometry_lchs_guess(void *blk, int cyls, int heads, int secs) "blk %p=
 LCHS %d %d %d"
 hd_geometry_guess(void *blk, uint32_t cyls, uint32_t heads, uint32_t sec=
s, int trans) "blk %p CHS %u %u %u trans %d"
=20
+# hw/block/nvme.c
+# nvme traces for successful events
+nvme_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
+nvme_irq_pin(void) "pulsing IRQ pin"
+nvme_irq_masked(void) "IRQ is masked"
+nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=3D0x%"PRIx64=
" prp2=3D0x%"PRIx64""
+nvme_rw(char const *verb, uint32_t blk_count, uint64_t byte_count, uint6=
4_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
+nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsi=
ze, uint16_t qflags) "create submission queue, addr=3D0x%"PRIx64", sqid=3D=
%"PRIu16", cqid=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"PRIu16""
+nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t s=
ize, uint16_t qflags, int ien) "create completion queue, addr=3D0x%"PRIx6=
4", cqid=3D%"PRIu16", vector=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"P=
RIu16", ien=3D%d"
+nvme_del_sq(uint16_t qid) "deleting submission queue sqid=3D%"PRIu16""
+nvme_del_cq(uint16_t cqid) "deleted completion queue, sqid=3D%"PRIu16""
+nvme_identify_ctrl(void) "identify controller"
+nvme_identify_ns(uint16_t ns) "identify namespace, nsid=3D%"PRIu16""
+nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=3D%"PRI=
u16""
+nvme_getfeat_vwcache(char const* result) "get feature volatile write cac=
he, result=3D%s"
+nvme_getfeat_numq(int result) "get feature number of queues, result=3D%d=
"
+nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested=
 cq_count=3D%d sq_count=3D%d, responding with cq_count=3D%d sq_count=3D%d=
"
+nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interr=
upt mask set, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
+nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interr=
upt mask clr, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
+nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=3D0x%=
"PRIx64""
+nvme_mmio_aqattr(uint64_t data) "wrote MMIO, admin queue attributes=3D0x=
%"PRIx64""
+nvme_mmio_asqaddr(uint64_t data) "wrote MMIO, admin submission queue add=
ress=3D0x%"PRIx64""
+nvme_mmio_acqaddr(uint64_t data) "wrote MMIO, admin completion queue add=
ress=3D0x%"PRIx64""
+nvme_mmio_asqaddr_hi(uint64_t data, uint64_t new_addr) "wrote MMIO, admi=
n submission queue high half=3D0x%"PRIx64", new_address=3D0x%"PRIx64""
+nvme_mmio_acqaddr_hi(uint64_t data, uint64_t new_addr) "wrote MMIO, admi=
n completion queue high half=3D0x%"PRIx64", new_address=3D0x%"PRIx64""
+nvme_mmio_start_success(void) "setting controller enable bit succeeded"
+nvme_mmio_stopped(void) "cleared controller enable bit"
+nvme_mmio_shutdown_set(void) "shutdown bit set"
+nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
+
+# nvme traces for error conditions
+nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
+nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null o=
r not page aligned: 0x%"PRIx64""
+nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x=
%"PRIx64""
+nvme_err_invalid_prp2_missing(void) "PRP2 is null and more data to be tr=
ansferred"
+nvme_err_invalid_field(void) "invalid field"
+nvme_err_invalid_prp(void) "invalid PRP"
+nvme_err_invalid_sgl(void) "invalid SGL"
+nvme_err_invalid_ns(uint32_t ns, uint32_t limit) "invalid namespace %u n=
ot within 1-%u"
+nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
+nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8"=
"
+nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit)=
 "Invalid LBA start=3D%"PRIu64" len=3D%"PRIu64" limit=3D%"PRIu64""
+nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion=
, sid=3D%"PRIu16""
+nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submissi=
on queue, invalid cqid=3D%"PRIu16""
+nvme_err_invalid_create_sq_sqid(uint16_t sqid) "failed creating submissi=
on queue, invalid sqid=3D%"PRIu16""
+nvme_err_invalid_create_sq_size(uint16_t qsize) "failed creating submiss=
ion queue, invalid qsize=3D%"PRIu16""
+nvme_err_invalid_create_sq_addr(uint64_t addr) "failed creating submissi=
on queue, addr=3D0x%"PRIx64""
+nvme_err_invalid_create_sq_qflags(uint16_t qflags) "failed creating subm=
ission queue, qflags=3D%"PRIu16""
+nvme_err_invalid_del_cq_cqid(uint16_t cqid) "failed deleting completion =
queue, cqid=3D%"PRIu16""
+nvme_err_invalid_del_cq_notempty(uint16_t cqid) "failed deleting complet=
ion queue, it is not empty, cqid=3D%"PRIu16""
+nvme_err_invalid_create_cq_cqid(uint16_t cqid) "failed creating completi=
on queue, cqid=3D%"PRIu16""
+nvme_err_invalid_create_cq_size(uint16_t size) "failed creating completi=
on queue, size=3D%"PRIu16""
+nvme_err_invalid_create_cq_addr(uint64_t addr) "failed creating completi=
on queue, addr=3D0x%"PRIx64""
+nvme_err_invalid_create_cq_vector(uint16_t vector) "failed creating comp=
letion queue, vector=3D%"PRIu16""
+nvme_err_invalid_create_cq_qflags(uint16_t qflags) "failed creating comp=
letion queue, qflags=3D%"PRIu16""
+nvme_err_invalid_identify_cns(uint16_t cns) "identify, invalid cns=3D0x%=
"PRIx16""
+nvme_err_invalid_getfeat(int dw10) "invalid get features, dw10=3D0x%"PRI=
x32""
+nvme_err_invalid_setfeat(uint32_t dw10) "invalid set features, dw10=3D0x=
%"PRIx32""
+nvme_err_startfail_cq(void) "nvme_start_ctrl failed because there are no=
n-admin completion queues"
+nvme_err_startfail_sq(void) "nvme_start_ctrl failed because there are no=
n-admin submission queues"
+nvme_err_startfail_nbarasq(void) "nvme_start_ctrl failed because the adm=
in submission queue address is null"
+nvme_err_startfail_nbaracq(void) "nvme_start_ctrl failed because the adm=
in completion queue address is null"
+nvme_err_startfail_asq_misaligned(uint64_t addr) "nvme_start_ctrl failed=
 because the admin submission queue address is misaligned: 0x%"PRIx64""
+nvme_err_startfail_acq_misaligned(uint64_t addr) "nvme_start_ctrl failed=
 because the admin completion queue address is misaligned: 0x%"PRIx64""
+nvme_err_startfail_page_too_small(uint8_t log2ps, uint8_t maxlog2ps) "nv=
me_start_ctrl failed because the page size is too small: log2size=3D%u, m=
in=3D%u"
+nvme_err_startfail_page_too_large(uint8_t log2ps, uint8_t maxlog2ps) "nv=
me_start_ctrl failed because the page size is too large: log2size=3D%u, m=
ax=3D%u"
+nvme_err_startfail_cqent_too_small(uint8_t log2ps, uint8_t maxlog2ps) "n=
vme_start_ctrl failed because the completion queue entry size is too smal=
l: log2size=3D%u, min=3D%u"
+nvme_err_startfail_cqent_too_large(uint8_t log2ps, uint8_t maxlog2ps) "n=
vme_start_ctrl failed because the completion queue entry size is too larg=
e: log2size=3D%u, max=3D%u"
+nvme_err_startfail_sqent_too_small(uint8_t log2ps, uint8_t maxlog2ps) "n=
vme_start_ctrl failed because the submission queue entry size is too smal=
l: log2size=3D%u, min=3D%u"
+nvme_err_startfail_sqent_too_large(uint8_t log2ps, uint8_t maxlog2ps) "n=
vme_start_ctrl failed because the submission queue entry size is too larg=
e: log2size=3D%u, max=3D%u"
+nvme_err_startfail_asqent_sz_zero(void) "nvme_start_ctrl failed because =
the admin submission queue size is zero"
+nvme_err_startfail_acqent_sz_zero(void) "nvme_start_ctrl failed because =
the admin completion queue size is zero"
+nvme_err_startfail(void) "setting controller enable bit failed"
+
+# Traces for undefined behavior
+nvme_ub_mmiowr_misaligned32(uint64_t offset) "MMIO write not 32-bit alig=
ned, offset=3D0x%"PRIx64""
+nvme_ub_mmiowr_toosmall(uint64_t offset, unsigned size) "MMIO write smal=
ler than 32 bits, offset=3D0x%"PRIx64", size=3D%u"
+nvme_ub_mmiowr_intmask_with_msix(void) "undefined access to interrupt ma=
sk set when MSI-X is enabled"
+nvme_ub_mmiowr_ro_csts(void) "attempted to set a read only bit of contro=
ller status"
+nvme_ub_mmiowr_ssreset_w1c_unsupported(void) "attempted to W1C CSTS.NSSR=
O but CAP.NSSRS is zero (not supported)"
+nvme_ub_mmiowr_ssreset_unsupported(void) "attempted NVM subsystem reset =
but CAP.NSSRS is zero (not supported)"
+nvme_ub_mmiowr_cmbloc_reserved(void) "invalid write to reserved CMBLOC w=
hen CMBSZ is zero, ignored"
+nvme_ub_mmiowr_cmbsz_readonly(void) "invalid write to read only CMBSZ, i=
gnored"
+nvme_ub_mmiowr_invalid(uint64_t offset, uint64_t data) "invalid MMIO wri=
te, offset=3D0x%"PRIx64", data=3D0x%"PRIx64""
+nvme_ub_mmiord_misaligned32(uint64_t offset) "MMIO read not 32-bit align=
ed, offset=3D0x%"PRIx64""
+nvme_ub_mmiord_toosmall(uint64_t offset) "MMIO read smaller than 32-bits=
, offset=3D0x%"PRIx64""
+nvme_ub_mmiord_invalid_ofs(uint64_t offset) "MMIO read beyond last regis=
ter, offset=3D0x%"PRIx64", returning 0"
+nvme_ub_db_wr_misaligned(uint64_t offset) "doorbell write not 32-bit ali=
gned, offset=3D0x%"PRIx64", ignoring"
+nvme_ub_db_wr_invalid_cq(uint32_t qid) "completion queue doorbell write =
for nonexistent queue, cqid=3D%"PRIu32", ignoring"
+nvme_ub_db_wr_invalid_cqhead(uint32_t qid, uint16_t new_head) "completio=
n queue doorbell write value beyond queue size, cqid=3D%"PRIu32", new_hea=
d=3D%"PRIu16", ignoring"
+nvme_ub_db_wr_invalid_sq(uint32_t qid) "submission queue doorbell write =
for nonexistent queue, sqid=3D%"PRIu32", ignoring"
+nvme_ub_db_wr_invalid_sqtail(uint32_t qid, uint16_t new_tail) "submissio=
n queue doorbell write value beyond queue size, sqid=3D%"PRIu32", new_hea=
d=3D%"PRIu16", ignoring"
+
 # hw/block/xen_disk.c
 xen_disk_alloc(char *name) "%s"
 xen_disk_init(char *name) "%s"
--=20
2.13.6

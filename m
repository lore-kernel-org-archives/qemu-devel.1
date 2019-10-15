Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E105DC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A09912089C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09912089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKKTn-0008PV-EQ
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 06:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iKKF5-000829-Ss
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:39:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iKKF2-0006iZ-Ed
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:39:51 -0400
Received: from charlie.dont.surf ([128.199.63.193]:54886)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1iKKEt-0006FI-TM; Tue, 15 Oct 2019 06:39:40 -0400
Received: from apples.localdomain (unknown [194.62.217.57])
 by charlie.dont.surf (Postfix) with ESMTPSA id 78924BF93E;
 Tue, 15 Oct 2019 10:39:17 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v2 14/20] nvme: allow multiple aios per command
Date: Tue, 15 Oct 2019 12:38:54 +0200
Message-Id: <20191015103900.313928-15-its@irrelevant.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015103900.313928-1-its@irrelevant.dk>
References: <20191015103900.313928-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Javier Gonzalez <javier@javigon.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Paul Durrant <Paul.Durrant@citrix.com>, Stephen Bates <sbates@raithlin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This refactors how the device issues asynchronous block backend
requests. The NvmeRequest now holds a queue of NvmeAIOs that are
associated with the command. This allows multiple aios to be issued for
a command. Only when all requests have been completed will the device
post a completion queue entry.

Because the device is currently guaranteed to only issue a single aio
request per command, the benefit is not immediately obvious. But this
functionality is required to support metadata.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c       | 455 +++++++++++++++++++++++++++++++++---------
 hw/block/nvme.h       | 165 ++++++++++++---
 hw/block/trace-events |   8 +
 3 files changed, 511 insertions(+), 117 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index cbc0b6a660b6..f4b9bd36a04e 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -25,6 +25,8 @@
  *                              Default: 64
  *   cmb_size_mb=3D<uint32>     : Size of Controller Memory Buffer in MB=
s.
  *                              Default: 0 (disabled)
+ *   mdts=3D<uint8>             : Maximum Data Transfer Size (power of t=
wo)
+ *                              Default: 7
  */
=20
 #include "qemu/osdep.h"
@@ -56,6 +58,7 @@
     } while (0)
=20
 static void nvme_process_sq(void *opaque);
+static void nvme_aio_cb(void *opaque, int ret);
=20
 static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
 {
@@ -197,7 +200,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList =
*qsg, uint64_t prp1,
     }
=20
     if (nvme_addr_is_cmb(n, prp1)) {
-        req->is_cmb =3D true;
+        nvme_req_set_cmb(req);
     }
=20
     pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
@@ -255,8 +258,8 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList =
*qsg, uint64_t prp1,
                 }
=20
                 addr_is_cmb =3D nvme_addr_is_cmb(n, prp_ent);
-                if ((req->is_cmb && !addr_is_cmb) ||
-                    (!req->is_cmb && addr_is_cmb)) {
+                if ((nvme_req_is_cmb(req) && !addr_is_cmb) ||
+                    (!nvme_req_is_cmb(req) && addr_is_cmb)) {
                     status =3D NVME_INVALID_USE_OF_CMB | NVME_DNR;
                     goto unmap;
                 }
@@ -269,8 +272,8 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList =
*qsg, uint64_t prp1,
             }
         } else {
             bool addr_is_cmb =3D nvme_addr_is_cmb(n, prp2);
-            if ((req->is_cmb && !addr_is_cmb) ||
-                (!req->is_cmb && addr_is_cmb)) {
+            if ((nvme_req_is_cmb(req) && !addr_is_cmb) ||
+                (!nvme_req_is_cmb(req) && addr_is_cmb)) {
                 status =3D NVME_INVALID_USE_OF_CMB | NVME_DNR;
                 goto unmap;
             }
@@ -312,7 +315,7 @@ static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8=
_t *ptr, uint32_t len,
         return status;
     }
=20
-    if (req->is_cmb) {
+    if (nvme_req_is_cmb(req)) {
         QEMUIOVector iov;
=20
         qemu_iovec_init(&iov, qsg.nsg);
@@ -341,19 +344,18 @@ static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uin=
t8_t *ptr, uint32_t len,
 static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t le=
n,
     uint64_t prp1, uint64_t prp2, NvmeRequest *req)
 {
-    QEMUSGList qsg;
     uint16_t status =3D NVME_SUCCESS;
=20
-    status =3D nvme_map_prp(n, &qsg, prp1, prp2, len, req);
+    status =3D nvme_map_prp(n, &req->qsg, prp1, prp2, len, req);
     if (status) {
         return status;
     }
=20
-    if (req->is_cmb) {
+    if (nvme_req_is_cmb(req)) {
         QEMUIOVector iov;
=20
-        qemu_iovec_init(&iov, qsg.nsg);
-        dma_to_cmb(n, &qsg, &iov);
+        qemu_iovec_init(&iov, req->qsg.nsg);
+        dma_to_cmb(n, &req->qsg, &iov);
=20
         if (unlikely(qemu_iovec_from_buf(&iov, 0, ptr, len) !=3D len)) {
             trace_nvme_err_invalid_dma();
@@ -365,17 +367,137 @@ static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uin=
t8_t *ptr, uint32_t len,
         goto out;
     }
=20
-    if (unlikely(dma_buf_read(ptr, len, &qsg))) {
+    if (unlikely(dma_buf_read(ptr, len, &req->qsg))) {
         trace_nvme_err_invalid_dma();
         status =3D NVME_INVALID_FIELD | NVME_DNR;
     }
=20
 out:
-    qemu_sglist_destroy(&qsg);
+    qemu_sglist_destroy(&req->qsg);
=20
     return status;
 }
=20
+static uint16_t nvme_map(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+{
+    NvmeNamespace *ns =3D req->ns;
+
+    uint32_t len =3D req->nlb << nvme_ns_lbads(ns);
+    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
+
+    return nvme_map_prp(n, &req->qsg, prp1, prp2, len, req);
+}
+
+static void nvme_aio_destroy(NvmeAIO *aio)
+{
+    if (aio->iov.nalloc) {
+        qemu_iovec_destroy(&aio->iov);
+    }
+
+    g_free(aio);
+}
+
+static NvmeAIO *nvme_aio_new(BlockBackend *blk, int64_t offset,
+    QEMUSGList *qsg, NvmeRequest *req, NvmeAIOCompletionFunc *cb)
+{
+    NvmeAIO *aio =3D g_malloc0(sizeof(*aio));
+
+    *aio =3D (NvmeAIO) {
+        .blk =3D blk,
+        .offset =3D offset,
+        .req =3D req,
+        .qsg =3D qsg,
+        .cb =3D cb,
+    };
+
+    if (qsg && nvme_req_is_cmb(req)) {
+        NvmeCtrl *n =3D nvme_ctrl(req);
+
+        qemu_iovec_init(&aio->iov, qsg->nsg);
+        dma_to_cmb(n, qsg, &aio->iov);
+
+        aio->qsg =3D NULL;
+    }
+
+    return aio;
+}
+
+static inline void nvme_req_register_aio(NvmeRequest *req, NvmeAIO *aio,
+    NvmeAIOOp opc)
+{
+    aio->opc =3D opc;
+
+    trace_nvme_req_register_aio(nvme_cid(req), aio, blk_name(aio->blk),
+        aio->offset, aio->qsg ? aio->qsg->size : aio->iov.size,
+        nvme_aio_opc_str(aio), req);
+
+    if (req) {
+        QTAILQ_INSERT_TAIL(&req->aio_tailq, aio, tailq_entry);
+    }
+}
+
+static void nvme_aio(NvmeAIO *aio)
+{
+    BlockBackend *blk =3D aio->blk;
+    BlockAcctCookie *acct =3D &aio->acct;
+    BlockAcctStats *stats =3D blk_get_stats(blk);
+
+    bool is_write, dma;
+
+    switch (aio->opc) {
+    case NVME_AIO_OPC_NONE:
+        break;
+
+    case NVME_AIO_OPC_FLUSH:
+        block_acct_start(stats, acct, 0, BLOCK_ACCT_FLUSH);
+        aio->aiocb =3D blk_aio_flush(blk, nvme_aio_cb, aio);
+        break;
+
+    case NVME_AIO_OPC_WRITE_ZEROES:
+        block_acct_start(stats, acct, aio->iov.size, BLOCK_ACCT_WRITE);
+        aio->aiocb =3D blk_aio_pwrite_zeroes(aio->blk, aio->offset,
+            aio->iov.size, BDRV_REQ_MAY_UNMAP, nvme_aio_cb, aio);
+        break;
+
+    case NVME_AIO_OPC_READ:
+    case NVME_AIO_OPC_WRITE:
+        dma =3D aio->qsg !=3D NULL;
+        is_write =3D (aio->opc =3D=3D NVME_AIO_OPC_WRITE);
+
+        block_acct_start(stats, acct,
+            dma ? aio->qsg->size : aio->iov.size,
+            is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
+
+        if (dma) {
+            aio->aiocb =3D is_write ?
+                dma_blk_write(blk, aio->qsg, aio->offset,
+                    BDRV_SECTOR_SIZE, nvme_aio_cb, aio) :
+                dma_blk_read(blk, aio->qsg, aio->offset,
+                    BDRV_SECTOR_SIZE, nvme_aio_cb, aio);
+
+            return;
+        }
+
+        aio->aiocb =3D is_write ?
+            blk_aio_pwritev(blk, aio->offset, &aio->iov, 0,
+                nvme_aio_cb, aio) :
+            blk_aio_preadv(blk, aio->offset, &aio->iov, 0,
+                nvme_aio_cb, aio);
+
+        break;
+    }
+}
+
+static void nvme_rw_aio(BlockBackend *blk, uint64_t offset, QEMUSGList *=
qsg,
+    NvmeRequest *req)
+{
+    NvmeAIO *aio =3D nvme_aio_new(blk, offset, qsg, req, NULL);
+    nvme_req_register_aio(req, aio, nvme_req_is_write(req) ?
+        NVME_AIO_OPC_WRITE : NVME_AIO_OPC_READ);
+    nvme_aio(aio);
+}
+
 static void nvme_post_cqes(void *opaque)
 {
     NvmeCQueue *cq =3D opaque;
@@ -411,6 +533,11 @@ static void nvme_enqueue_req_completion(NvmeCQueue *=
cq, NvmeRequest *req)
     assert(cq->cqid =3D=3D req->sq->cqid);
=20
     trace_nvme_enqueue_req_completion(req->cid, cq->cqid, req->status);
+
+    if (req->qsg.nalloc) {
+        qemu_sglist_destroy(&req->qsg);
+    }
+
     QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
     QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
     timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
@@ -456,135 +583,266 @@ static void nvme_clear_events(NvmeCtrl *n, uint8_=
t event_type)
     }
 }
=20
-static void nvme_rw_cb(void *opaque, int ret)
+static void nvme_rw_cb(NvmeRequest *req, void *opaque)
 {
-    NvmeRequest *req =3D opaque;
     NvmeSQueue *sq =3D req->sq;
     NvmeCtrl *n =3D sq->ctrl;
     NvmeCQueue *cq =3D n->cq[sq->cqid];
-    NvmeRwCmd *rw =3D (NvmeRwCmd *) &req->cmd;
+
+    trace_nvme_rw_cb(req->cid, req->cmd.nsid);
+
+    nvme_enqueue_req_completion(cq, req);
+}
+
+static void nvme_aio_cb(void *opaque, int ret)
+{
+    NvmeAIO *aio =3D opaque;
+    NvmeRequest *req =3D aio->req;
+
+    BlockBackend *blk =3D aio->blk;
+    BlockAcctCookie *acct =3D &aio->acct;
+    BlockAcctStats *stats =3D blk_get_stats(blk);
+
+    Error *local_err =3D NULL;
+
+    trace_nvme_aio_cb(nvme_cid(req), aio, blk_name(aio->blk), aio->offse=
t,
+        nvme_aio_opc_str(aio), req);
+
+    if (req) {
+        QTAILQ_REMOVE(&req->aio_tailq, aio, tailq_entry);
+    }
=20
     if (!ret) {
-        block_acct_done(blk_get_stats(n->conf.blk), &req->acct);
-        req->status =3D NVME_SUCCESS;
+        block_acct_done(stats, acct);
+
+        if (aio->cb) {
+            aio->cb(aio, aio->cb_arg);
+        }
     } else {
-        block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
-        nvme_set_error_page(n, sq->sqid, cpu_to_le16(req->cid),
-            NVME_INTERNAL_DEV_ERROR, offsetof(NvmeRwCmd, slba), rw->slba=
, 1);
-        req->status =3D NVME_INTERNAL_DEV_ERROR | NVME_MORE;
-    }
+        block_acct_failed(stats, acct);
+
+        if (req) {
+            NvmeRwCmd *rw =3D (NvmeRwCmd *) &req->cmd;
+            NvmeSQueue *sq =3D req->sq;
+            NvmeCtrl *n =3D sq->ctrl;
+            uint16_t status;
+
+            switch (aio->opc) {
+            case NVME_AIO_OPC_READ:
+                status =3D NVME_UNRECOVERED_READ;
+                break;
+            case NVME_AIO_OPC_WRITE:
+            case NVME_AIO_OPC_WRITE_ZEROES:
+                status =3D NVME_WRITE_FAULT;
+                break;
+            default:
+                status =3D NVME_INTERNAL_DEV_ERROR;
+                break;
+            }
=20
-    if (req->qsg.nalloc) {
-        qemu_sglist_destroy(&req->qsg);
+            trace_nvme_err_aio(nvme_cid(req), aio, blk_name(aio->blk),
+                aio->offset, nvme_aio_opc_str(aio), req, status);
+
+            nvme_set_error_page(n, sq->sqid, cpu_to_le16(req->cid), stat=
us,
+                offsetof(NvmeRwCmd, slba), rw->slba, 1);
+
+            error_setg_errno(&local_err, -ret, "aio failed");
+            error_report_err(local_err);
+
+            /*
+             * An Internal Error trumps all other errors. For other erro=
rs,
+             * only set the first error encountered. Any additional erro=
rs will
+             * be recorded in the error information log page.
+             */
+            if (!req->status ||
+                nvme_is_error(status, NVME_INTERNAL_DEV_ERROR)) {
+                req->status =3D status;
+            }
+        }
     }
-    if (req->iov.nalloc) {
-        qemu_iovec_destroy(&req->iov);
+
+    if (req && QTAILQ_EMPTY(&req->aio_tailq)) {
+        if (req->cb) {
+            req->cb(req, req->cb_arg);
+        } else {
+            NvmeSQueue *sq =3D req->sq;
+            NvmeCtrl *n =3D sq->ctrl;
+            NvmeCQueue *cq =3D n->cq[sq->cqid];
+
+            nvme_enqueue_req_completion(cq, req);
+        }
     }
=20
-    nvme_enqueue_req_completion(cq, req);
+    nvme_aio_destroy(aio);
 }
=20
-static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
+static inline uint16_t nvme_check_mdts(NvmeCtrl *n, size_t len,
     NvmeRequest *req)
 {
-    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
-         BLOCK_ACCT_FLUSH);
-    req->aiocb =3D blk_aio_flush(n->conf.blk, nvme_rw_cb, req);
+    uint8_t mdts =3D n->params.mdts;
=20
-    return NVME_NO_COMPLETE;
+    if (mdts && len > n->page_size << mdts) {
+        trace_nvme_err_mdts(nvme_cid(req), n->page_size << mdts, len);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd=
 *cmd,
-    NvmeRequest *req)
+static inline uint16_t nvme_check_prinfo(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeRwCmd *rw =3D (NvmeRwCmd *)cmd;
-    const uint8_t lba_index =3D NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
-    const uint8_t data_shift =3D ns->id_ns.lbaf[lba_index].ds;
-    uint64_t slba =3D le64_to_cpu(rw->slba);
-    uint32_t nlb  =3D le16_to_cpu(rw->nlb) + 1;
-    uint64_t offset =3D slba << data_shift;
-    uint32_t count =3D nlb << data_shift;
+    NvmeRwCmd *rw =3D (NvmeRwCmd *) &req->cmd;
+    NvmeNamespace *ns =3D req->ns;
+
+    uint16_t ctrl =3D le16_to_cpu(rw->control);
+
+    if ((ctrl & NVME_RW_PRINFO_PRACT) && !(ns->id_ns.dps & DPS_TYPE_MASK=
)) {
+        trace_nvme_err_prinfo(nvme_cid(req), ctrl);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
=20
-    if (unlikely(slba + nlb > ns->id_ns.nsze)) {
-        trace_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
+static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeNamespace *ns =3D req->ns;
+    uint64_t nsze =3D le64_to_cpu(ns->id_ns.nsze);
+
+    if (unlikely((req->slba + req->nlb) > nsze)) {
+        block_acct_invalid(blk_get_stats(n->conf.blk),
+            nvme_req_is_write(req) ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ)=
;
+        trace_nvme_err_invalid_lba_range(req->slba, req->nlb, nsze);
         return NVME_LBA_RANGE | NVME_DNR;
     }
=20
-    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
-                     BLOCK_ACCT_WRITE);
-    req->aiocb =3D blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
-                                        BDRV_REQ_MAY_UNMAP, nvme_rw_cb, =
req);
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_check_rw(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeNamespace *ns =3D req->ns;
+    size_t len =3D req->nlb << nvme_ns_lbads(ns);
+    uint16_t status;
+
+    status =3D nvme_check_mdts(n, len, req);
+    if (status) {
+        return status;
+    }
+
+    status =3D nvme_check_prinfo(n, req);
+    if (status) {
+        return status;
+    }
+
+    status =3D nvme_check_bounds(n, req);
+    if (status) {
+        return status;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+{
+    NvmeAIO *aio =3D nvme_aio_new(n->conf.blk, 0x0, NULL, req, NULL);
+
+    nvme_req_register_aio(req, aio, NVME_AIO_OPC_FLUSH);
+    nvme_aio(aio);
+
     return NVME_NO_COMPLETE;
 }
=20
-static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
-    NvmeRequest *req)
+static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
 {
-    NvmeRwCmd *rw =3D (NvmeRwCmd *)cmd;
-    uint32_t nlb  =3D le32_to_cpu(rw->nlb) + 1;
-    uint64_t slba =3D le64_to_cpu(rw->slba);
-    uint64_t prp1 =3D le64_to_cpu(rw->prp1);
-    uint64_t prp2 =3D le64_to_cpu(rw->prp2);
+    NvmeAIO *aio;
=20
-    uint8_t lba_index  =3D NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
-    uint8_t data_shift =3D ns->id_ns.lbaf[lba_index].ds;
-    uint64_t data_size =3D (uint64_t)nlb << data_shift;
-    uint64_t data_offset =3D slba << data_shift;
-    int is_write =3D rw->opcode =3D=3D NVME_CMD_WRITE ? 1 : 0;
-    enum BlockAcctType acct =3D is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT=
_READ;
+    NvmeNamespace *ns =3D req->ns;
+    NvmeRwCmd *rw =3D (NvmeRwCmd *) cmd;
=20
-    trace_nvme_rw(is_write ? "write" : "read", nlb, data_size, slba);
+    int64_t offset;
+    size_t count;
+    uint16_t status;
=20
-    if (unlikely((slba + nlb) > ns->id_ns.nsze)) {
-        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
-        trace_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
-        return NVME_LBA_RANGE | NVME_DNR;
+    req->slba =3D le64_to_cpu(rw->slba);
+    req->nlb  =3D le16_to_cpu(rw->nlb) + 1;
+
+    trace_nvme_write_zeros(req->cid, le32_to_cpu(cmd->nsid), req->slba,
+        req->nlb);
+
+    status =3D nvme_check_bounds(n, req);
+    if (unlikely(status)) {
+        block_acct_invalid(blk_get_stats(n->conf.blk), BLOCK_ACCT_WRITE)=
;
+        return status;
     }
=20
-    if (nvme_map_prp(n, &req->qsg, prp1, prp2, data_size, req)) {
+    offset =3D req->slba << nvme_ns_lbads(ns);
+    count =3D req->nlb << nvme_ns_lbads(ns);
+
+    aio =3D nvme_aio_new(n->conf.blk, offset, NULL, req, NULL);
+
+    aio->iov.size =3D count;
+
+    nvme_req_register_aio(req, aio, NVME_AIO_OPC_WRITE_ZEROES);
+    nvme_aio(aio);
+
+    return NVME_NO_COMPLETE;
+}
+
+static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+{
+    NvmeRwCmd *rw =3D (NvmeRwCmd *) cmd;
+    NvmeNamespace *ns =3D req->ns;
+    int status;
+
+    enum BlockAcctType acct =3D
+        nvme_req_is_write(req) ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
+
+    req->nlb  =3D le16_to_cpu(rw->nlb) + 1;
+    req->slba =3D le64_to_cpu(rw->slba);
+
+    trace_nvme_rw(nvme_req_is_write(req) ? "write" : "read", req->nlb,
+        req->nlb << nvme_ns_lbads(req->ns), req->slba);
+
+    status =3D nvme_check_rw(n, req);
+    if (status) {
         block_acct_invalid(blk_get_stats(n->conf.blk), acct);
-        return NVME_INVALID_FIELD | NVME_DNR;
+        return status;
     }
=20
-    dma_acct_start(n->conf.blk, &req->acct, &req->qsg, acct);
-    if (!req->is_cmb) {
-        req->aiocb =3D is_write ?
-            dma_blk_write(n->conf.blk, &req->qsg, data_offset, BDRV_SECT=
OR_SIZE,
-                          nvme_rw_cb, req) :
-            dma_blk_read(n->conf.blk, &req->qsg, data_offset, BDRV_SECTO=
R_SIZE,
-                         nvme_rw_cb, req);
-    } else {
-        qemu_iovec_init(&req->iov, req->qsg.nsg);
-        dma_to_cmb(n, &req->qsg, &req->iov);
-        req->aiocb =3D is_write ?
-            blk_aio_pwritev(n->conf.blk, data_offset, &req->iov, 0, nvme=
_rw_cb,
-                            req) :
-            blk_aio_preadv(n->conf.blk, data_offset, &req->iov, 0, nvme_=
rw_cb,
-                           req);
+    status =3D nvme_map(n, cmd, req);
+    if (status) {
+        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
+        return status;
     }
=20
+    nvme_rw_aio(n->conf.blk, req->slba << nvme_ns_lbads(ns), &req->qsg, =
req);
+    nvme_req_set_cb(req, nvme_rw_cb, NULL);
+
     return NVME_NO_COMPLETE;
 }
=20
 static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
-    NvmeNamespace *ns;
     uint32_t nsid =3D le32_to_cpu(cmd->nsid);
=20
+    trace_nvme_io_cmd(req->cid, nsid, le16_to_cpu(req->sq->sqid), cmd->o=
pcode);
+
     if (unlikely(nsid =3D=3D 0 || nsid > n->num_namespaces)) {
         trace_nvme_err_invalid_ns(nsid, n->num_namespaces);
         return NVME_INVALID_NSID | NVME_DNR;
     }
=20
-    ns =3D &n->namespaces[nsid - 1];
+    req->ns =3D &n->namespaces[nsid - 1];
+
     switch (cmd->opcode) {
     case NVME_CMD_FLUSH:
-        return nvme_flush(n, ns, cmd, req);
+        return nvme_flush(n, cmd, req);
     case NVME_CMD_WRITE_ZEROS:
-        return nvme_write_zeros(n, ns, cmd, req);
+        return nvme_write_zeros(n, cmd, req);
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
-        return nvme_rw(n, ns, cmd, req);
+        return nvme_rw(n, cmd, req);
     default:
         trace_nvme_err_invalid_opc(cmd->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
@@ -609,6 +867,7 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd=
)
     NvmeRequest *req, *next;
     NvmeSQueue *sq;
     NvmeCQueue *cq;
+    NvmeAIO *aio;
     uint16_t qid =3D le16_to_cpu(c->qid);
=20
     if (unlikely(!qid || nvme_check_sqid(n, qid))) {
@@ -621,8 +880,11 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cm=
d)
     sq =3D n->sq[qid];
     while (!QTAILQ_EMPTY(&sq->out_req_list)) {
         req =3D QTAILQ_FIRST(&sq->out_req_list);
-        assert(req->aiocb);
-        blk_aio_cancel(req->aiocb);
+        while (!QTAILQ_EMPTY(&req->aio_tailq)) {
+            aio =3D QTAILQ_FIRST(&req->aio_tailq);
+            assert(aio->aiocb);
+            blk_aio_cancel(aio->aiocb);
+        }
     }
     if (!nvme_check_cqid(n, sq->cqid)) {
         cq =3D n->cq[sq->cqid];
@@ -659,6 +921,7 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n,=
 uint64_t dma_addr,
     QTAILQ_INIT(&sq->out_req_list);
     for (i =3D 0; i < sq->size; i++) {
         sq->io_req[i].sq =3D sq;
+        QTAILQ_INIT(&(sq->io_req[i].aio_tailq));
         QTAILQ_INSERT_TAIL(&(sq->req_list), &sq->io_req[i], entry);
     }
     sq->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_process_sq, sq);
@@ -820,6 +1083,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *c=
md, NvmeRequest *req)
     uint32_t numdl, numdu;
     uint64_t off, lpol, lpou;
     size_t   len;
+    uint16_t status;
=20
     numdl =3D (dw10 >> 16);
     numdu =3D (dw11 & 0xffff);
@@ -835,6 +1099,11 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *=
cmd, NvmeRequest *req)
=20
     trace_nvme_get_log(req->cid, lid, lsp, rae, len, off);
=20
+    status =3D nvme_check_mdts(n, len, req);
+    if (status) {
+        return status;
+    }
+
     switch (lid) {
     case NVME_LOG_ERROR_INFO:
         return nvme_error_info(n, cmd, rae, len, off, req);
@@ -1353,8 +1622,9 @@ static void nvme_init_req(NvmeCtrl *n, NvmeCmd *cmd=
, NvmeRequest *req)
=20
     memcpy(&req->cmd, cmd, sizeof(NvmeCmd));
     req->status =3D NVME_SUCCESS;
-    req->is_cmb =3D false;
-    req->is_write =3D false;
+    req->flags =3D 0x0;
+    req->cb =3D NULL;
+    req->cb_arg =3D NULL;
 }
=20
 static void nvme_process_sq(void *opaque)
@@ -1953,6 +2223,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     id->ieee[0] =3D 0x00;
     id->ieee[1] =3D 0x02;
     id->ieee[2] =3D 0xb3;
+    id->mdts =3D params->mdts;
     id->ver =3D cpu_to_le32(0x00010300);
     id->oacs =3D cpu_to_le16(0);
     id->acl =3D 3;
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index add9ff335aa5..2f6706899de1 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -8,7 +8,8 @@
     DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
     DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64), \
     DEFINE_PROP_UINT8("elpe", _state, _props.elpe, 24), \
-    DEFINE_PROP_UINT8("aerl", _state, _props.aerl, 3)
+    DEFINE_PROP_UINT8("aerl", _state, _props.aerl, 3), \
+    DEFINE_PROP_UINT8("mdts", _state, _props.mdts, 7)
=20
 typedef struct NvmeParams {
     char     *serial;
@@ -16,6 +17,7 @@ typedef struct NvmeParams {
     uint32_t cmb_size_mb;
     uint8_t  elpe;
     uint8_t  aerl;
+    uint8_t  mdts;
 } NvmeParams;
=20
 typedef struct NvmeAsyncEvent {
@@ -23,23 +25,124 @@ typedef struct NvmeAsyncEvent {
     NvmeAerResult result;
 } NvmeAsyncEvent;
=20
-typedef struct NvmeRequest {
-    struct NvmeSQueue       *sq;
-    BlockAIOCB              *aiocb;
-    uint16_t                status;
-    uint16_t                cid;
-    bool                    is_cmb;
-    bool                    is_write;
-    NvmeCqe                 cqe;
-    BlockAcctCookie         acct;
-    QEMUSGList              qsg;
-    QEMUIOVector            iov;
-    NvmeCmd                 cmd;
-    QTAILQ_ENTRY(NvmeRequest)entry;
-} NvmeRequest;
-
-typedef struct NvmeSQueue {
-    struct NvmeCtrl *ctrl;
+typedef enum NvmeAIOOp {
+    NVME_AIO_OPC_NONE         =3D 0x0,
+    NVME_AIO_OPC_FLUSH        =3D 0x1,
+    NVME_AIO_OPC_READ         =3D 0x2,
+    NVME_AIO_OPC_WRITE        =3D 0x3,
+    NVME_AIO_OPC_WRITE_ZEROES =3D 0x4,
+} NvmeAIOOp;
+
+typedef struct NvmeRequest NvmeRequest;
+typedef struct NvmeAIO NvmeAIO;
+typedef void NvmeAIOCompletionFunc(NvmeAIO *aio, void *opaque);
+
+struct NvmeAIO {
+    NvmeRequest *req;
+
+    NvmeAIOOp       opc;
+    int64_t         offset;
+    BlockBackend    *blk;
+    BlockAIOCB      *aiocb;
+    BlockAcctCookie acct;
+
+    NvmeAIOCompletionFunc *cb;
+    void                  *cb_arg;
+
+    QEMUSGList   *qsg;
+    QEMUIOVector iov;
+
+    QTAILQ_ENTRY(NvmeAIO) tailq_entry;
+};
+
+static inline const char *nvme_aio_opc_str(NvmeAIO *aio)
+{
+    switch (aio->opc) {
+    case NVME_AIO_OPC_NONE:         return "NVME_AIO_OP_NONE";
+    case NVME_AIO_OPC_FLUSH:        return "NVME_AIO_OP_FLUSH";
+    case NVME_AIO_OPC_READ:         return "NVME_AIO_OP_READ";
+    case NVME_AIO_OPC_WRITE:        return "NVME_AIO_OP_WRITE";
+    case NVME_AIO_OPC_WRITE_ZEROES: return "NVME_AIO_OP_WRITE_ZEROES";
+    default:                        return "NVME_AIO_OP_UNKNOWN";
+    }
+}
+
+#define NVME_REQ_TRANSFER_DMA  0x1
+#define NVME_REQ_TRANSFER_CMB  0x2
+#define NVME_REQ_TRANSFER_MASK 0x3
+
+typedef struct NvmeSQueue    NvmeSQueue;
+typedef struct NvmeNamespace NvmeNamespace;
+typedef void NvmeRequestCompletionFunc(NvmeRequest *req, void *opaque);
+
+struct NvmeRequest {
+    NvmeSQueue    *sq;
+    NvmeNamespace *ns;
+    NvmeCqe       cqe;
+    NvmeCmd       cmd;
+
+    uint64_t slba;
+    uint32_t nlb;
+    uint16_t status;
+    uint16_t cid;
+    int      flags;
+
+    NvmeRequestCompletionFunc *cb;
+    void                      *cb_arg;
+
+    QEMUSGList qsg;
+
+    QTAILQ_HEAD(, NvmeAIO)    aio_tailq;
+    QTAILQ_ENTRY(NvmeRequest) entry;
+};
+
+static inline void nvme_req_set_cb(NvmeRequest *req,
+    NvmeRequestCompletionFunc *cb, void *cb_arg)
+{
+    req->cb =3D cb;
+    req->cb_arg =3D cb_arg;
+}
+
+static inline void nvme_req_clear_cb(NvmeRequest *req)
+{
+    req->cb =3D req->cb_arg =3D NULL;
+}
+
+static inline uint16_t nvme_cid(NvmeRequest *req)
+{
+    if (req) {
+        return req->cid;
+    }
+
+    return 0xffff;
+}
+
+static inline bool nvme_req_is_cmb(NvmeRequest *req)
+{
+    return (req->flags & NVME_REQ_TRANSFER_MASK) =3D=3D NVME_REQ_TRANSFE=
R_CMB;
+}
+
+static void nvme_req_set_cmb(NvmeRequest *req)
+{
+    req->flags =3D NVME_REQ_TRANSFER_CMB;
+}
+
+static inline bool nvme_req_is_write(NvmeRequest *req)
+{
+    switch (req->cmd.opcode) {
+    case NVME_CMD_WRITE:
+    case NVME_CMD_WRITE_UNCOR:
+    case NVME_CMD_WRITE_ZEROS:
+        return true;
+    default:
+        return false;
+    }
+}
+
+typedef struct NvmeCtrl NvmeCtrl;
+
+struct NvmeSQueue {
+    NvmeCtrl    *ctrl;
     uint16_t    sqid;
     uint16_t    cqid;
     uint32_t    head;
@@ -51,10 +154,12 @@ typedef struct NvmeSQueue {
     QTAILQ_HEAD(, NvmeRequest) req_list;
     QTAILQ_HEAD(, NvmeRequest) out_req_list;
     QTAILQ_ENTRY(NvmeSQueue) entry;
-} NvmeSQueue;
+};
=20
-typedef struct NvmeCQueue {
-    struct NvmeCtrl *ctrl;
+typedef struct NvmeCQueue NvmeCQueue;
+
+struct NvmeCQueue {
+    NvmeCtrl    *ctrl;
     uint8_t     phase;
     uint16_t    cqid;
     uint16_t    irq_enabled;
@@ -66,11 +171,11 @@ typedef struct NvmeCQueue {
     QEMUTimer   *timer;
     QTAILQ_HEAD(, NvmeSQueue) sq_list;
     QTAILQ_HEAD(, NvmeRequest) req_list;
-} NvmeCQueue;
+};
=20
-typedef struct NvmeNamespace {
+struct NvmeNamespace {
     NvmeIdNs        id_ns;
-} NvmeNamespace;
+};
=20
 #define TYPE_NVME "nvme"
 #define NVME(obj) \
@@ -122,6 +227,17 @@ typedef struct NvmeCtrl {
     NvmeIdCtrl      id_ctrl;
 } NvmeCtrl;
=20
+static inline NvmeCtrl *nvme_ctrl(NvmeRequest *req)
+{
+    return req->sq->ctrl;
+}
+
+static inline bool nvme_is_error(uint16_t status, uint16_t err)
+{
+    /* strip DNR and MORE */
+    return (status & 0xfff) =3D=3D err;
+}
+
 static inline NvmeLBAF nvme_ns_lbaf(NvmeNamespace *ns)
 {
     NvmeIdNs *id_ns =3D &ns->id_ns;
@@ -143,5 +259,4 @@ static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, Nvm=
eNamespace *ns)
     return n->ns_size >> nvme_ns_lbads(ns);
 }
=20
-
 #endif /* HW_NVME_H */
diff --git a/hw/block/trace-events b/hw/block/trace-events
index e81bb3a64ed7..c7e0a1849043 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -34,7 +34,12 @@ nvme_irq_pin(void) "pulsing IRQ pin"
 nvme_irq_masked(void) "IRQ is masked"
 nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=3D0x%"PRIx64=
" prp2=3D0x%"PRIx64""
 nvme_map_prp(uint16_t cid, uint8_t opc, uint64_t trans_len, uint32_t len=
, uint64_t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" opc 0x%"PRIx=
8" trans_len %"PRIu64" len %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64" nu=
m_prps %d"
+nvme_req_register_aio(uint16_t cid, void *aio, const char *blkname, uint=
64_t offset, uint64_t count, const char *opc, void *req) "cid %"PRIu16" a=
io %p blk \"%s\" offset %"PRIu64" count %"PRIu64" opc \"%s\" req %p"
+nvme_aio_cb(uint16_t cid, void *aio, const char *blkname, uint64_t offse=
t, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"=
PRIu64" opc \"%s\" req %p"
+nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode) =
"cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
 nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint6=
4_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
+nvme_rw_cb(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
+nvme_write_zeros(uint16_t cid, uint32_t nsid, uint64_t slba, uint32_t nl=
b) "cid %"PRIu16" nsid %"PRIu32" slba %"PRIu64" nlb %"PRIu32""
 nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsi=
ze, uint16_t qflags) "create submission queue, addr=3D0x%"PRIx64", sqid=3D=
%"PRIu16", cqid=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"PRIu16""
 nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t s=
ize, uint16_t qflags, int ien) "create completion queue, addr=3D0x%"PRIx6=
4", cqid=3D%"PRIu16", vector=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"P=
RIu16", ien=3D%d"
 nvme_del_sq(uint16_t qid) "deleting submission queue sqid=3D%"PRIu16""
@@ -74,6 +79,9 @@ nvme_mmio_shutdown_set(void) "shutdown bit set"
 nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
=20
 # nvme traces for error conditions
+nvme_err_mdts(uint16_t cid, size_t mdts, size_t len) "cid %"PRIu16" mdts=
 %"PRIu64" len %"PRIu64""
+nvme_err_prinfo(uint16_t cid, uint16_t ctrl) "cid %"PRIu16" ctrl %"PRIu1=
6""
+nvme_err_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offs=
et, const char *opc, void *req, uint16_t status) "cid %"PRIu16" aio %p bl=
k \"%s\" offset %"PRIu64" opc \"%s\" req %p status 0x%"PRIx16""
 nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
 nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null o=
r not page aligned: 0x%"PRIx64""
 nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x=
%"PRIx64""
--=20
2.23.0



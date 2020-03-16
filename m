Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D726C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 215EA20663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215EA20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsc8-0002d4-6W
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDqlQ-0000Yx-Nl
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDqlM-0005my-Ro
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:30:44 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48828)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDql9-0002B7-8K; Mon, 16 Mar 2020 10:30:27 -0400
Received: from apples.local (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id B5405BFA0E;
 Mon, 16 Mar 2020 14:29:51 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v6 32/42] nvme: allow multiple aios per command
Date: Mon, 16 Mar 2020 07:29:18 -0700
Message-Id: <20200316142928.153431-33-its@irrelevant.dk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316142928.153431-1-its@irrelevant.dk>
References: <20200316142928.153431-1-its@irrelevant.dk>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

This refactors how the device issues asynchronous block backend
requests. The NvmeRequest now holds a queue of NvmeAIOs that are
associated with the command. This allows multiple aios to be issued for
a command. Only when all requests have been completed will the device
post a completion queue entry.

Because the device is currently guaranteed to only issue a single aio
request per command, the benefit is not immediately obvious. But this
functionality is required to support metadata, the dataset management
command and other features.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c       | 377 +++++++++++++++++++++++++++++++-----------
 hw/block/nvme.h       | 129 +++++++++++++--
 hw/block/trace-events |   6 +
 3 files changed, 407 insertions(+), 105 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 0d2b5b45b0c5..817384e3b1a9 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -59,6 +59,7 @@
     } while (0)
=20
 static void nvme_process_sq(void *opaque);
+static void nvme_aio_cb(void *opaque, int ret);
=20
 static inline void *nvme_addr_to_cmb(NvmeCtrl *n, hwaddr addr)
 {
@@ -373,6 +374,99 @@ static uint16_t nvme_map(NvmeCtrl *n, NvmeCmd *cmd, =
QEMUSGList *qsg,
     return nvme_map_prp(n, qsg, iov, prp1, prp2, len, req);
 }
=20
+static void nvme_aio_destroy(NvmeAIO *aio)
+{
+    g_free(aio);
+}
+
+static inline void nvme_req_register_aio(NvmeRequest *req, NvmeAIO *aio,
+                                         NvmeAIOOp opc)
+{
+    aio->opc =3D opc;
+
+    trace_nvme_dev_req_register_aio(nvme_cid(req), aio, blk_name(aio->bl=
k),
+                                    aio->offset, aio->len,
+                                    nvme_aio_opc_str(aio), req);
+
+    if (req) {
+        QTAILQ_INSERT_TAIL(&req->aio_tailq, aio, tailq_entry);
+    }
+}
+
+static void nvme_submit_aio(NvmeAIO *aio)
+{
+    BlockBackend *blk =3D aio->blk;
+    BlockAcctCookie *acct =3D &aio->acct;
+    BlockAcctStats *stats =3D blk_get_stats(blk);
+
+    bool is_write;
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
+        block_acct_start(stats, acct, aio->len, BLOCK_ACCT_WRITE);
+        aio->aiocb =3D blk_aio_pwrite_zeroes(blk, aio->offset, aio->len,
+                                           BDRV_REQ_MAY_UNMAP, nvme_aio_=
cb,
+                                           aio);
+        break;
+
+    case NVME_AIO_OPC_READ:
+    case NVME_AIO_OPC_WRITE:
+        is_write =3D (aio->opc =3D=3D NVME_AIO_OPC_WRITE);
+
+        block_acct_start(stats, acct, aio->len,
+                         is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
+
+        if (aio->qsg) {
+            if (is_write) {
+                aio->aiocb =3D dma_blk_write(blk, aio->qsg, aio->offset,
+                                           BDRV_SECTOR_SIZE, nvme_aio_cb=
, aio);
+            } else {
+                aio->aiocb =3D dma_blk_read(blk, aio->qsg, aio->offset,
+                                          BDRV_SECTOR_SIZE, nvme_aio_cb,=
 aio);
+            }
+        } else {
+            if (is_write) {
+                aio->aiocb =3D blk_aio_pwritev(blk, aio->offset, aio->io=
v, 0,
+                                             nvme_aio_cb, aio);
+            } else {
+                aio->aiocb =3D blk_aio_preadv(blk, aio->offset, aio->iov=
, 0,
+                                            nvme_aio_cb, aio);
+            }
+        }
+
+        break;
+    }
+}
+
+static void nvme_rw_aio(BlockBackend *blk, uint64_t offset, NvmeRequest =
*req)
+{
+    NvmeAIO *aio;
+    size_t len =3D req->qsg.nsg > 0 ? req->qsg.size : req->iov.size;
+
+    aio =3D g_new0(NvmeAIO, 1);
+
+    *aio =3D (NvmeAIO) {
+        .blk =3D blk,
+        .offset =3D offset,
+        .len =3D len,
+        .req =3D req,
+        .qsg =3D req->qsg.sg ? &req->qsg : NULL,
+        .iov =3D req->iov.iov ? &req->iov : NULL,
+    };
+
+    nvme_req_register_aio(req, aio, nvme_req_is_write(req) ?
+                          NVME_AIO_OPC_WRITE : NVME_AIO_OPC_READ);
+    nvme_submit_aio(aio);
+}
+
 static void nvme_post_cqes(void *opaque)
 {
     NvmeCQueue *cq =3D opaque;
@@ -396,6 +490,7 @@ static void nvme_post_cqes(void *opaque)
         nvme_inc_cq_tail(cq);
         pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
             sizeof(req->cqe));
+        nvme_req_clear(req);
         QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
     }
     if (cq->tail !=3D cq->head) {
@@ -406,8 +501,8 @@ static void nvme_post_cqes(void *opaque)
 static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req=
)
 {
     assert(cq->cqid =3D=3D req->sq->cqid);
-    trace_nvme_dev_enqueue_req_completion(nvme_cid(req), cq->cqid,
-                                          req->status);
+    trace_nvme_dev_enqueue_req_completion(nvme_cid(req), cq->cqid, req->=
status);
+
     QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
     QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
     timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
@@ -505,9 +600,11 @@ static inline uint16_t nvme_check_mdts(NvmeCtrl *n, =
size_t len,
     return NVME_SUCCESS;
 }
=20
-static inline uint16_t nvme_check_prinfo(NvmeCtrl *n, NvmeNamespace *ns,
-                                         uint16_t ctrl, NvmeRequest *req=
)
+static inline uint16_t nvme_check_prinfo(NvmeCtrl *n, uint16_t ctrl,
+                                         NvmeRequest *req)
 {
+    NvmeNamespace *ns =3D req->ns;
+
     if ((ctrl & NVME_RW_PRINFO_PRACT) && !(ns->id_ns.dps & DPS_TYPE_MASK=
)) {
         trace_nvme_dev_err_prinfo(nvme_cid(req), ctrl);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -516,10 +613,10 @@ static inline uint16_t nvme_check_prinfo(NvmeCtrl *=
n, NvmeNamespace *ns,
     return NVME_SUCCESS;
 }
=20
-static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
-                                         uint64_t slba, uint32_t nlb,
-                                         NvmeRequest *req)
+static inline uint16_t nvme_check_bounds(NvmeCtrl *n, uint64_t slba,
+                                         uint32_t nlb, NvmeRequest *req)
 {
+    NvmeNamespace *ns =3D req->ns;
     uint64_t nsze =3D le64_to_cpu(ns->id_ns.nsze);
=20
     if (unlikely(UINT64_MAX - slba < nlb || slba + nlb > nsze)) {
@@ -530,55 +627,154 @@ static inline uint16_t nvme_check_bounds(NvmeCtrl =
*n, NvmeNamespace *ns,
     return NVME_SUCCESS;
 }
=20
-static void nvme_rw_cb(void *opaque, int ret)
+static uint16_t nvme_check_rw(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeNamespace *ns =3D req->ns;
+    NvmeRwCmd *rw =3D (NvmeRwCmd *) &req->cmd;
+    uint16_t ctrl =3D le16_to_cpu(rw->control);
+    size_t len =3D req->nlb << nvme_ns_lbads(ns);
+    uint16_t status;
+
+    status =3D nvme_check_mdts(n, len, req);
+    if (status) {
+        return status;
+    }
+
+    status =3D nvme_check_prinfo(n, ctrl, req);
+    if (status) {
+        return status;
+    }
+
+    status =3D nvme_check_bounds(n, req->slba, req->nlb, req);
+    if (status) {
+        return status;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static void nvme_rw_cb(NvmeRequest *req, void *opaque)
 {
-    NvmeRequest *req =3D opaque;
     NvmeSQueue *sq =3D req->sq;
     NvmeCtrl *n =3D sq->ctrl;
     NvmeCQueue *cq =3D n->cq[sq->cqid];
=20
-    if (!ret) {
-        block_acct_done(blk_get_stats(n->conf.blk), &req->acct);
-        req->status =3D NVME_SUCCESS;
-    } else {
-        block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
-        req->status =3D NVME_INTERNAL_DEV_ERROR;
-    }
-
-    if (req->qsg.nalloc) {
-        qemu_sglist_destroy(&req->qsg);
-    }
-    if (req->iov.nalloc) {
-        qemu_iovec_destroy(&req->iov);
-    }
+    trace_nvme_dev_rw_cb(nvme_cid(req), req->cmd.nsid);
=20
     nvme_enqueue_req_completion(cq, req);
 }
=20
-static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
-    NvmeRequest *req)
+static void nvme_aio_cb(void *opaque, int ret)
 {
-    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
-         BLOCK_ACCT_FLUSH);
-    req->aiocb =3D blk_aio_flush(n->conf.blk, nvme_rw_cb, req);
+    NvmeAIO *aio =3D opaque;
+    NvmeRequest *req =3D aio->req;
+
+    BlockBackend *blk =3D aio->blk;
+    BlockAcctCookie *acct =3D &aio->acct;
+    BlockAcctStats *stats =3D blk_get_stats(blk);
+
+    Error *local_err =3D NULL;
+
+    trace_nvme_dev_aio_cb(nvme_cid(req), aio, blk_name(blk), aio->offset=
,
+                          nvme_aio_opc_str(aio), req);
+
+    if (req) {
+        QTAILQ_REMOVE(&req->aio_tailq, aio, tailq_entry);
+    }
+
+    if (!ret) {
+        block_acct_done(stats, acct);
+    } else {
+        block_acct_failed(stats, acct);
+
+        if (req) {
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
+
+            trace_nvme_dev_err_aio(nvme_cid(req), aio, blk_name(blk),
+                                   aio->offset, nvme_aio_opc_str(aio), r=
eq,
+                                   status);
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
+                nvme_status_is_error(status, NVME_INTERNAL_DEV_ERROR)) {
+                req->status =3D status;
+            }
+        }
+    }
+
+    if (aio->cb) {
+        aio->cb(aio, aio->cb_arg, ret);
+    }
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
+    }
+
+    nvme_aio_destroy(aio);
+}
+
+static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+{
+    NvmeAIO *aio =3D g_new0(NvmeAIO, 1);
+
+    *aio =3D (NvmeAIO) {
+        .blk =3D n->conf.blk,
+        .req =3D req,
+    };
+
+    nvme_req_register_aio(req, aio, NVME_AIO_OPC_FLUSH);
+    nvme_submit_aio(aio);
=20
     return NVME_NO_COMPLETE;
 }
=20
-static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd=
 *cmd,
-    NvmeRequest *req)
+static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest=
 *req)
 {
-    NvmeRwCmd *rw =3D (NvmeRwCmd *)cmd;
-    const uint8_t lba_index =3D NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
-    const uint8_t data_shift =3D ns->id_ns.lbaf[lba_index].ds;
-    uint64_t slba =3D le64_to_cpu(rw->slba);
-    uint32_t nlb  =3D le16_to_cpu(rw->nlb) + 1;
-    uint64_t offset =3D slba << data_shift;
-    uint32_t count =3D nlb << data_shift;
+    NvmeAIO *aio;
+
+    NvmeNamespace *ns =3D req->ns;
+    NvmeRwCmd *rw =3D (NvmeRwCmd *) cmd;
     uint16_t ctrl =3D le16_to_cpu(rw->control);
+
+    int64_t offset;
+    size_t count;
     uint16_t status;
=20
-    status =3D nvme_check_prinfo(n, ns, ctrl, req);
+    req->slba =3D le64_to_cpu(rw->slba);
+    req->nlb  =3D le16_to_cpu(rw->nlb) + 1;
+
+    trace_nvme_dev_write_zeroes(nvme_cid(req), le32_to_cpu(cmd->nsid),
+                                req->slba, req->nlb);
+
+    status =3D nvme_check_prinfo(n, ctrl, req);
     if (status) {
         goto invalid;
     }
@@ -588,15 +784,26 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeN=
amespace *ns, NvmeCmd *cmd,
         goto invalid;
     }
=20
-    status =3D nvme_check_bounds(n, ns, slba, nlb, req);
+    status =3D nvme_check_bounds(n, req->slba, req->nlb, req);
     if (status) {
         goto invalid;
     }
=20
-    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
-                     BLOCK_ACCT_WRITE);
-    req->aiocb =3D blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
-                                        BDRV_REQ_MAY_UNMAP, nvme_rw_cb, =
req);
+    offset =3D req->slba << nvme_ns_lbads(ns);
+    count =3D req->nlb << nvme_ns_lbads(ns);
+
+    aio =3D g_new0(NvmeAIO, 1);
+
+    *aio =3D (NvmeAIO) {
+        .blk =3D n->conf.blk,
+        .offset =3D offset,
+        .len =3D count,
+        .req =3D req,
+    };
+
+    nvme_req_register_aio(req, aio, NVME_AIO_OPC_WRITE_ZEROES);
+    nvme_submit_aio(aio);
+
     return NVME_NO_COMPLETE;
=20
 invalid:
@@ -604,63 +811,36 @@ invalid:
     return status;
 }
=20
-static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
-    NvmeRequest *req)
+static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
-    NvmeRwCmd *rw =3D (NvmeRwCmd *)cmd;
-    uint32_t nlb  =3D le32_to_cpu(rw->nlb) + 1;
-    uint64_t slba =3D le64_to_cpu(rw->slba);
-    uint16_t ctrl =3D le16_to_cpu(rw->control);
+    NvmeRwCmd *rw =3D (NvmeRwCmd *) cmd;
+    NvmeNamespace *ns =3D req->ns;
+    uint32_t len;
+    int status;
=20
-    uint8_t lba_index  =3D NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
-    uint8_t data_shift =3D ns->id_ns.lbaf[lba_index].ds;
-    uint64_t data_size =3D (uint64_t)nlb << data_shift;
-    uint64_t data_offset =3D slba << data_shift;
-    int is_write =3D rw->opcode =3D=3D NVME_CMD_WRITE ? 1 : 0;
-    enum BlockAcctType acct =3D is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT=
_READ;
-    uint16_t status;
+    enum BlockAcctType acct =3D
+        nvme_req_is_write(req) ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
=20
-    trace_nvme_dev_rw(is_write ? "write" : "read", nlb, data_size, slba)=
;
+    req->nlb  =3D le16_to_cpu(rw->nlb) + 1;
+    req->slba =3D le64_to_cpu(rw->slba);
=20
-    status =3D nvme_check_mdts(n, data_size, req);
-    if (status) {
-        goto invalid;
-    }
+    len =3D req->nlb << nvme_ns_lbads(ns);
=20
-    status =3D nvme_check_prinfo(n, ns, ctrl, req);
-    if (status) {
-        goto invalid;
-    }
+    trace_nvme_dev_rw(nvme_req_is_write(req) ? "write" : "read", req->nl=
b,
+                      req->nlb << nvme_ns_lbads(req->ns), req->slba);
=20
-    status =3D nvme_check_bounds(n, ns, slba, nlb, req);
+    status =3D nvme_check_rw(n, req);
     if (status) {
         goto invalid;
     }
=20
-    status =3D nvme_map(n, cmd, &req->qsg, &req->iov, data_size, req);
+    status =3D nvme_map(n, cmd, &req->qsg, &req->iov, len, req);
     if (status) {
         goto invalid;
     }
=20
-    if (req->qsg.nsg > 0) {
-        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->qs=
g.size,
-                         acct);
-
-        req->aiocb =3D is_write ?
-            dma_blk_write(n->conf.blk, &req->qsg, data_offset, BDRV_SECT=
OR_SIZE,
-                          nvme_rw_cb, req) :
-            dma_blk_read(n->conf.blk, &req->qsg, data_offset, BDRV_SECTO=
R_SIZE,
-                         nvme_rw_cb, req);
-    } else {
-        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->io=
v.size,
-                         acct);
-
-        req->aiocb =3D is_write ?
-            blk_aio_pwritev(n->conf.blk, data_offset, &req->iov, 0, nvme=
_rw_cb,
-                            req) :
-            blk_aio_preadv(n->conf.blk, data_offset, &req->iov, 0, nvme_=
rw_cb,
-                           req);
-    }
+    nvme_rw_aio(n->conf.blk, req->slba << nvme_ns_lbads(ns), req);
+    nvme_req_set_cb(req, nvme_rw_cb, NULL);
=20
     return NVME_NO_COMPLETE;
=20
@@ -671,23 +851,26 @@ invalid:
=20
 static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
-    NvmeNamespace *ns;
     uint32_t nsid =3D le32_to_cpu(cmd->nsid);
=20
+    trace_nvme_dev_io_cmd(nvme_cid(req), nsid, le16_to_cpu(req->sq->sqid=
),
+                          cmd->opcode);
+
     if (unlikely(nsid =3D=3D 0 || nsid > n->num_namespaces)) {
         trace_nvme_dev_err_invalid_ns(nsid, n->num_namespaces);
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
+        return nvme_write_zeroes(n, cmd, req);
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
-        return nvme_rw(n, ns, cmd, req);
+        return nvme_rw(n, cmd, req);
     default:
         trace_nvme_dev_err_invalid_opc(cmd->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
@@ -711,6 +894,7 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd=
)
     NvmeRequest *req, *next;
     NvmeSQueue *sq;
     NvmeCQueue *cq;
+    NvmeAIO *aio;
     uint16_t qid =3D le16_to_cpu(c->qid);
=20
     if (unlikely(!qid || nvme_check_sqid(n, qid))) {
@@ -723,8 +907,11 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cm=
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
@@ -761,6 +948,7 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n,=
 uint64_t dma_addr,
     QTAILQ_INIT(&sq->out_req_list);
     for (i =3D 0; i < sq->size; i++) {
         sq->io_req[i].sq =3D sq;
+        QTAILQ_INIT(&(sq->io_req[i].aio_tailq));
         QTAILQ_INSERT_TAIL(&(sq->req_list), &sq->io_req[i], entry);
     }
     sq->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_process_sq, sq);
@@ -1474,8 +1662,9 @@ static void nvme_process_sq(void *opaque)
         req =3D QTAILQ_FIRST(&sq->req_list);
         QTAILQ_REMOVE(&sq->req_list, req, entry);
         QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
-        memset(&req->cqe, 0, sizeof(req->cqe));
+
         req->cqe.cid =3D cmd.cid;
+        memcpy(&req->cmd, &cmd, sizeof(NvmeCmd));
=20
         status =3D sq->sqid ? nvme_io_cmd(n, &cmd, req) :
             nvme_admin_cmd(n, &cmd, req);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index b05c2153aebf..5d5fa8c8833a 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -27,16 +27,58 @@ typedef struct NvmeAsyncEvent {
     NvmeAerResult result;
 } NvmeAsyncEvent;
=20
-typedef struct NvmeRequest {
-    struct NvmeSQueue       *sq;
-    BlockAIOCB              *aiocb;
-    uint16_t                status;
-    NvmeCqe                 cqe;
-    BlockAcctCookie         acct;
-    QEMUSGList              qsg;
-    QEMUIOVector            iov;
-    QTAILQ_ENTRY(NvmeRequest)entry;
-} NvmeRequest;
+typedef struct NvmeRequest NvmeRequest;
+typedef void NvmeRequestCompletionFunc(NvmeRequest *req, void *opaque);
+
+struct NvmeRequest {
+    struct NvmeSQueue    *sq;
+    struct NvmeNamespace *ns;
+
+    NvmeCqe  cqe;
+    NvmeCmd  cmd;
+    uint16_t status;
+
+    uint64_t slba;
+    uint32_t nlb;
+
+    QEMUSGList   qsg;
+    QEMUIOVector iov;
+
+    NvmeRequestCompletionFunc *cb;
+    void                      *cb_arg;
+
+    QTAILQ_HEAD(, NvmeAIO)    aio_tailq;
+    QTAILQ_ENTRY(NvmeRequest) entry;
+};
+
+static inline void nvme_req_clear(NvmeRequest *req)
+{
+    req->ns =3D NULL;
+    memset(&req->cqe, 0, sizeof(req->cqe));
+    req->status =3D NVME_SUCCESS;
+    req->slba =3D req->nlb =3D 0x0;
+    req->cb =3D req->cb_arg =3D NULL;
+
+    if (req->qsg.sg) {
+        qemu_sglist_destroy(&req->qsg);
+    }
+
+    if (req->iov.iov) {
+        qemu_iovec_destroy(&req->iov);
+    }
+}
+
+static inline void nvme_req_set_cb(NvmeRequest *req,
+                                   NvmeRequestCompletionFunc *cb, void *=
cb_arg)
+{
+    req->cb =3D cb;
+    req->cb_arg =3D cb_arg;
+}
+
+static inline void nvme_req_clear_cb(NvmeRequest *req)
+{
+    req->cb =3D req->cb_arg =3D NULL;
+}
=20
 typedef struct NvmeSQueue {
     struct NvmeCtrl *ctrl;
@@ -88,6 +130,60 @@ static inline size_t nvme_ns_lbads_bytes(NvmeNamespac=
e *ns)
     return 1 << nvme_ns_lbads(ns);
 }
=20
+typedef enum NvmeAIOOp {
+    NVME_AIO_OPC_NONE         =3D 0x0,
+    NVME_AIO_OPC_FLUSH        =3D 0x1,
+    NVME_AIO_OPC_READ         =3D 0x2,
+    NVME_AIO_OPC_WRITE        =3D 0x3,
+    NVME_AIO_OPC_WRITE_ZEROES =3D 0x4,
+} NvmeAIOOp;
+
+typedef struct NvmeAIO NvmeAIO;
+typedef void NvmeAIOCompletionFunc(NvmeAIO *aio, void *opaque, int ret);
+
+struct NvmeAIO {
+    NvmeRequest *req;
+
+    NvmeAIOOp       opc;
+    int64_t         offset;
+    size_t          len;
+    BlockBackend    *blk;
+    BlockAIOCB      *aiocb;
+    BlockAcctCookie acct;
+
+    NvmeAIOCompletionFunc *cb;
+    void                  *cb_arg;
+
+    QEMUSGList   *qsg;
+    QEMUIOVector *iov;
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
 #define TYPE_NVME "nvme"
 #define NVME(obj) \
         OBJECT_CHECK(NvmeCtrl, (obj), TYPE_NVME)
@@ -140,10 +236,21 @@ static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, N=
vmeNamespace *ns)
 static inline uint16_t nvme_cid(NvmeRequest *req)
 {
     if (req) {
-        return le16_to_cpu(req->cqe.cid);
+        return le16_to_cpu(req->cmd.cid);
     }
=20
     return 0xffff;
 }
=20
+static inline bool nvme_status_is_error(uint16_t status, uint16_t err)
+{
+    /* strip DNR and MORE */
+    return (status & 0xfff) =3D=3D err;
+}
+
+static inline NvmeCtrl *nvme_ctrl(NvmeRequest *req)
+{
+    return req->sq->ctrl;
+}
+
 #endif /* HW_NVME_H */
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 2aceb0537e05..aa449e314818 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -34,7 +34,12 @@ nvme_dev_irq_pin(void) "pulsing IRQ pin"
 nvme_dev_irq_masked(void) "IRQ is masked"
 nvme_dev_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=3D0x%"PR=
Ix64" prp2=3D0x%"PRIx64""
 nvme_dev_map_prp(uint16_t cid, uint64_t trans_len, uint32_t len, uint64_=
t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" trans_len %"PRIu64" l=
en %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64" num_prps %d"
+nvme_dev_req_register_aio(uint16_t cid, void *aio, const char *blkname, =
uint64_t offset, uint64_t count, const char *opc, void *req) "cid %"PRIu1=
6" aio %p blk \"%s\" offset %"PRIu64" count %"PRIu64" opc \"%s\" req %p"
+nvme_dev_aio_cb(uint16_t cid, void *aio, const char *blkname, uint64_t o=
ffset, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offse=
t %"PRIu64" opc \"%s\" req %p"
+nvme_dev_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opco=
de) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
 nvme_dev_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, u=
int64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
+nvme_dev_rw_cb(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32=
""
+nvme_dev_write_zeroes(uint16_t cid, uint32_t nsid, uint64_t slba, uint32=
_t nlb) "cid %"PRIu16" nsid %"PRIu32" slba %"PRIu64" nlb %"PRIu32""
 nvme_dev_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t=
 qsize, uint16_t qflags) "create submission queue, addr=3D0x%"PRIx64", sq=
id=3D%"PRIu16", cqid=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"PRIu16""
 nvme_dev_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16=
_t size, uint16_t qflags, int ien) "create completion queue, addr=3D0x%"P=
RIx64", cqid=3D%"PRIu16", vector=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D=
%"PRIu16", ien=3D%d"
 nvme_dev_del_sq(uint16_t qid) "deleting submission queue sqid=3D%"PRIu16=
""
@@ -81,6 +86,7 @@ nvme_dev_mmio_doorbell_sq(uint16_t sqid, uint16_t new_t=
ail) "cqid %"PRIu16" new_
 # nvme traces for error conditions
 nvme_dev_err_mdts(uint16_t cid, size_t mdts, size_t len) "cid %"PRIu16" =
mdts %"PRIu64" len %"PRIu64""
 nvme_dev_err_prinfo(uint16_t cid, uint16_t ctrl) "cid %"PRIu16" ctrl %"P=
RIu16""
+nvme_dev_err_aio(uint16_t cid, void *aio, const char *blkname, uint64_t =
offset, const char *opc, void *req, uint16_t status) "cid %"PRIu16" aio %=
p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p status 0x%"PRIx16""
 nvme_dev_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
 nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is nu=
ll or not page aligned: 0x%"PRIx64""
 nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned=
: 0x%"PRIx64""
--=20
2.25.1



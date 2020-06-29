Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10468C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 20:00:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10AF206A1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 20:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10AF206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpzxP-0007bA-3b
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 16:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jpznt-0007Z9-AV; Mon, 29 Jun 2020 15:50:57 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jpznp-0005zV-I8; Mon, 29 Jun 2020 15:50:56 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 7E392BF724;
 Mon, 29 Jun 2020 19:50:29 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 15/17] hw/block/nvme: allow multiple aios per command
Date: Mon, 29 Jun 2020 21:50:15 +0200
Message-Id: <20200629195017.1217056-16-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629195017.1217056-1-its@irrelevant.dk>
References: <20200629195017.1217056-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 14:26:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
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
command as well as zoned namespaces and other features that require
additional persistent state.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c       | 330 +++++++++++++++++++++++++++++++++---------
 hw/block/nvme.h       | 104 +++++++++++--
 hw/block/trace-events |   3 +
 3 files changed, 360 insertions(+), 77 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 3309f8e0eac1..d836319f068a 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -74,6 +74,7 @@
     } while (0)
 
 static void nvme_process_sq(void *opaque);
+static void nvme_aio_cb(void *opaque, int ret);
 
 static inline void *nvme_addr_to_cmb(NvmeCtrl *n, hwaddr addr)
 {
@@ -178,6 +179,9 @@ static void nvme_req_clear(NvmeRequest *req)
 {
     req->ns = NULL;
     memset(&req->cqe, 0x0, sizeof(req->cqe));
+    req->status = NVME_SUCCESS;
+    req->slba = req->nlb = 0x0;
+    req->cb = req->cb_arg = NULL;
 
     if (req->qsg.sg) {
         qemu_sglist_destroy(&req->qsg);
@@ -399,6 +403,91 @@ static uint16_t nvme_map(NvmeCtrl *n, size_t len, NvmeRequest *req)
     return nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len, req);
 }
 
+static void nvme_aio_destroy(NvmeAIO *aio)
+{
+    g_free(aio);
+}
+
+/*
+ * Submit an asynchronous I/O operation as described by the given NvmeAIO. This
+ * function takes care of accounting and special handling of reads and writes
+ * going to the Controller Memory Buffer.
+ */
+static void nvme_submit_aio(NvmeAIO *aio)
+{
+    BlockBackend *blk = aio->blk;
+    BlockAcctCookie *acct = &aio->acct;
+    BlockAcctStats *stats = blk_get_stats(blk);
+
+    bool is_write;
+
+    switch (aio->opc) {
+    case NVME_AIO_OPC_NONE:
+        break;
+
+    case NVME_AIO_OPC_FLUSH:
+        block_acct_start(stats, acct, 0, BLOCK_ACCT_FLUSH);
+        aio->aiocb = blk_aio_flush(blk, nvme_aio_cb, aio);
+        break;
+
+    case NVME_AIO_OPC_WRITE_ZEROES:
+        block_acct_start(stats, acct, aio->len, BLOCK_ACCT_WRITE);
+        aio->aiocb = blk_aio_pwrite_zeroes(blk, aio->offset, aio->len,
+                                           BDRV_REQ_MAY_UNMAP, nvme_aio_cb,
+                                           aio);
+        break;
+
+    case NVME_AIO_OPC_READ:
+    case NVME_AIO_OPC_WRITE:
+        is_write = (aio->opc == NVME_AIO_OPC_WRITE);
+
+        block_acct_start(stats, acct, aio->len,
+                         is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
+
+        if (aio->flags & NVME_AIO_DMA) {
+            QEMUSGList *qsg = (QEMUSGList *)aio->payload;
+
+            if (is_write) {
+                aio->aiocb = dma_blk_write(blk, qsg, aio->offset,
+                                           BDRV_SECTOR_SIZE, nvme_aio_cb, aio);
+            } else {
+                aio->aiocb = dma_blk_read(blk, qsg, aio->offset,
+                                          BDRV_SECTOR_SIZE, nvme_aio_cb, aio);
+            }
+        } else {
+            QEMUIOVector *iov = (QEMUIOVector *)aio->payload;
+
+            if (is_write) {
+                aio->aiocb = blk_aio_pwritev(blk, aio->offset, iov, 0,
+                                             nvme_aio_cb, aio);
+            } else {
+                aio->aiocb = blk_aio_preadv(blk, aio->offset, iov, 0,
+                                            nvme_aio_cb, aio);
+            }
+        }
+
+        break;
+    }
+}
+
+/*
+ * Register an asynchronous I/O operation with the NvmeRequest. The NvmeRequest
+ * will not complete until all registered AIO's have completed and the
+ * aio_tailq goes empty.
+ */
+static inline void nvme_req_add_aio(NvmeRequest *req, NvmeAIO *aio)
+{
+    assert(req);
+
+    trace_pci_nvme_req_add_aio(nvme_cid(req), aio, blk_name(aio->blk),
+                               aio->offset, aio->len,
+                               nvme_aio_opc_str(aio), req);
+
+    QTAILQ_INSERT_TAIL(&req->aio_tailq, aio, tailq_entry);
+
+    nvme_submit_aio(aio);
+}
+
 static void nvme_post_cqes(void *opaque)
 {
     NvmeCQueue *cq = opaque;
@@ -435,6 +524,7 @@ static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
     assert(cq->cqid == req->sq->cqid);
     trace_pci_nvme_enqueue_req_completion(nvme_cid(req), cq->cqid,
                                           req->status);
+
     QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
     QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
     timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
@@ -542,31 +632,128 @@ static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
     return NVME_SUCCESS;
 }
 
-static void nvme_rw_cb(void *opaque, int ret)
+static void nvme_rw_cb(NvmeRequest *req, void *opaque)
 {
-    NvmeRequest *req = opaque;
     NvmeSQueue *sq = req->sq;
     NvmeCtrl *n = sq->ctrl;
     NvmeCQueue *cq = n->cq[sq->cqid];
 
     trace_pci_nvme_rw_cb(nvme_cid(req));
 
-    if (!ret) {
-        block_acct_done(blk_get_stats(n->conf.blk), &req->acct);
-        req->status = NVME_SUCCESS;
-    } else {
-        block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
-        req->status = NVME_INTERNAL_DEV_ERROR;
+    nvme_enqueue_req_completion(cq, req);
+}
+
+static void nvme_aio_cb(void *opaque, int ret)
+{
+    NvmeAIO *aio = opaque;
+    NvmeRequest *req = aio->req;
+
+    BlockBackend *blk = aio->blk;
+    BlockAcctCookie *acct = &aio->acct;
+    BlockAcctStats *stats = blk_get_stats(blk);
+
+    Error *local_err = NULL;
+
+    trace_pci_nvme_aio_cb(nvme_cid(req), aio, blk_name(blk), aio->offset,
+                          nvme_aio_opc_str(aio), req);
+
+    if (req) {
+        QTAILQ_REMOVE(&req->aio_tailq, aio, tailq_entry);
     }
 
-    nvme_enqueue_req_completion(cq, req);
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
+                status = NVME_UNRECOVERED_READ;
+                break;
+            case NVME_AIO_OPC_WRITE:
+            case NVME_AIO_OPC_WRITE_ZEROES:
+                status = NVME_WRITE_FAULT;
+                break;
+            default:
+                status = NVME_INTERNAL_DEV_ERROR;
+                break;
+            }
+
+            trace_pci_nvme_err_aio(nvme_cid(req), aio, blk_name(blk),
+                                   aio->offset, nvme_aio_opc_str(aio), req,
+                                   status);
+
+            error_setg_errno(&local_err, -ret, "aio failed");
+            error_report_err(local_err);
+
+            /*
+             * An Internal Error trumps all other errors. For other errors,
+             * only set the first error encountered. Any additional errors will
+             * be recorded in the error information log page.
+             */
+            if (!req->status || (status & 0xfff) == NVME_INTERNAL_DEV_ERROR) {
+                req->status = status;
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
+            NvmeSQueue *sq = req->sq;
+            NvmeCtrl *n = sq->ctrl;
+            NvmeCQueue *cq = n->cq[sq->cqid];
+
+            nvme_enqueue_req_completion(cq, req);
+        }
+    }
+
+    nvme_aio_destroy(aio);
+}
+
+static void nvme_aio_rw(NvmeNamespace *ns, BlockBackend *blk, NvmeAIOOp opc,
+                        NvmeRequest *req)
+{
+    NvmeAIO *aio = g_new(NvmeAIO, 1);
+
+    *aio = (NvmeAIO) {
+        .opc = opc,
+        .blk = blk,
+        .offset = req->slba << nvme_ns_lbads(ns),
+        .req = req,
+    };
+
+    if (req->qsg.sg) {
+        aio->payload = &req->qsg;
+        aio->len = req->qsg.size;
+        aio->flags |= NVME_AIO_DMA;
+    } else {
+        aio->payload = &req->iov;
+        aio->len = req->iov.size;
+    }
+
+    nvme_req_add_aio(req, aio);
 }
 
 static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
 {
-    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
-         BLOCK_ACCT_FLUSH);
-    req->aiocb = blk_aio_flush(n->conf.blk, nvme_rw_cb, req);
+    NvmeAIO *aio = g_new0(NvmeAIO, 1);
+
+    *aio = (NvmeAIO) {
+        .opc = NVME_AIO_OPC_FLUSH,
+        .blk = n->conf.blk,
+        .req = req,
+    };
+
+    nvme_req_add_aio(req, aio);
 
     return NVME_NO_COMPLETE;
 }
@@ -575,26 +762,39 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
-    const uint8_t lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
-    const uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
-    uint64_t slba = le64_to_cpu(rw->slba);
-    uint32_t nlb  = le16_to_cpu(rw->nlb) + 1;
-    uint64_t offset = slba << data_shift;
-    uint32_t count = nlb << data_shift;
+    NvmeAIO *aio;
+
+    int64_t offset;
+    size_t count;
     uint16_t status;
 
-    trace_pci_nvme_write_zeroes(nvme_cid(req), slba, nlb);
+    req->slba = le64_to_cpu(rw->slba);
+    req->nlb  = le16_to_cpu(rw->nlb) + 1;
 
-    status = nvme_check_bounds(n, ns, slba, nlb);
+    trace_pci_nvme_write_zeroes(nvme_cid(req), req->slba, req->nlb);
+
+    status = nvme_check_bounds(n, ns, req->slba, req->nlb);
     if (status) {
-        trace_pci_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
+        trace_pci_nvme_err_invalid_lba_range(req->slba, req->nlb,
+                                             ns->id_ns.nsze);
         return status;
     }
 
-    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
-                     BLOCK_ACCT_WRITE);
-    req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
-                                        BDRV_REQ_MAY_UNMAP, nvme_rw_cb, req);
+    offset = req->slba << nvme_ns_lbads(ns);
+    count = req->nlb << nvme_ns_lbads(ns);
+
+    aio = g_new0(NvmeAIO, 1);
+
+    *aio = (NvmeAIO) {
+        .opc = NVME_AIO_OPC_WRITE_ZEROES,
+        .blk = n->conf.blk,
+        .offset = offset,
+        .len = count,
+        .req = req,
+    };
+
+    nvme_req_add_aio(req, aio);
+
     return NVME_NO_COMPLETE;
 }
 
@@ -602,57 +802,52 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
-    uint32_t nlb  = le32_to_cpu(rw->nlb) + 1;
-    uint64_t slba = le64_to_cpu(rw->slba);
 
-    uint8_t lba_index  = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
-    uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
-    uint64_t data_size = (uint64_t)nlb << data_shift;
-    uint64_t data_offset = slba << data_shift;
-    int is_write = rw->opcode == NVME_CMD_WRITE ? 1 : 0;
-    enum BlockAcctType acct = is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
-    uint16_t status;
+    uint32_t len;
+    int status;
 
-    trace_pci_nvme_rw(is_write ? "write" : "read", nlb, data_size, slba);
+    enum BlockAcctType acct = BLOCK_ACCT_READ;
+    NvmeAIOOp opc = NVME_AIO_OPC_READ;
 
-    status = nvme_check_mdts(n, data_size);
+    if (nvme_req_is_write(req)) {
+        acct = BLOCK_ACCT_WRITE;
+        opc = NVME_AIO_OPC_WRITE;
+    }
+
+    req->nlb  = le16_to_cpu(rw->nlb) + 1;
+    req->slba = le64_to_cpu(rw->slba);
+
+    len = req->nlb << nvme_ns_lbads(ns);
+
+    trace_pci_nvme_rw(nvme_req_is_write(req) ? "write" : "read", req->nlb,
+                      len, req->slba);
+
+    status = nvme_check_mdts(n, len);
     if (status) {
-        trace_pci_nvme_err_mdts(nvme_cid(req), data_size);
-        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
-        return status;
+        trace_pci_nvme_err_mdts(nvme_cid(req), len);
+        goto invalid;
     }
 
-    status = nvme_check_bounds(n, ns, slba, nlb);
+    status = nvme_check_bounds(n, ns, req->slba, req->nlb);
     if (status) {
-        trace_pci_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
-        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
-        return status;
+        trace_pci_nvme_err_invalid_lba_range(req->slba, req->nlb,
+                                             ns->id_ns.nsze);
+        goto invalid;
     }
 
-    if (nvme_map(n, data_size, req)) {
-        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
-        return NVME_INVALID_FIELD | NVME_DNR;
+    status = nvme_map(n, len, req);
+    if (status) {
+        goto invalid;
     }
 
-    if (req->qsg.nsg > 0) {
-        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->qsg.size,
-                         acct);
-        req->aiocb = is_write ?
-            dma_blk_write(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
-                          nvme_rw_cb, req) :
-            dma_blk_read(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
-                         nvme_rw_cb, req);
-    } else {
-        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->iov.size,
-                         acct);
-        req->aiocb = is_write ?
-            blk_aio_pwritev(n->conf.blk, data_offset, &req->iov, 0, nvme_rw_cb,
-                            req) :
-            blk_aio_preadv(n->conf.blk, data_offset, &req->iov, 0, nvme_rw_cb,
-                           req);
-    }
+    nvme_aio_rw(ns, n->conf.blk, opc, req);
+    nvme_req_set_cb(req, nvme_rw_cb, NULL);
 
     return NVME_NO_COMPLETE;
+
+invalid:
+    block_acct_invalid(blk_get_stats(n->conf.blk), acct);
+    return status;
 }
 
 static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
@@ -699,6 +894,7 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
     NvmeRequest *r, *next;
     NvmeSQueue *sq;
     NvmeCQueue *cq;
+    NvmeAIO *aio;
     uint16_t qid = le16_to_cpu(c->qid);
 
     if (unlikely(!qid || nvme_check_sqid(n, qid))) {
@@ -711,8 +907,11 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
     sq = n->sq[qid];
     while (!QTAILQ_EMPTY(&sq->out_req_list)) {
         r = QTAILQ_FIRST(&sq->out_req_list);
-        assert(r->aiocb);
-        blk_aio_cancel(r->aiocb);
+        while (!QTAILQ_EMPTY(&r->aio_tailq)) {
+            aio = QTAILQ_FIRST(&r->aio_tailq);
+            assert(aio->aiocb);
+            blk_aio_cancel(aio->aiocb);
+        }
     }
     if (!nvme_check_cqid(n, sq->cqid)) {
         cq = n->cq[sq->cqid];
@@ -749,6 +948,7 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
     QTAILQ_INIT(&sq->out_req_list);
     for (i = 0; i < sq->size; i++) {
         sq->io_req[i].sq = sq;
+        QTAILQ_INIT(&(sq->io_req[i].aio_tailq));
         QTAILQ_INSERT_TAIL(&(sq->req_list), &sq->io_req[i], entry);
     }
     sq->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_process_sq, sq);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 454b15945bee..c75b13a77efd 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -19,18 +19,36 @@ typedef struct NvmeAsyncEvent {
     NvmeAerResult result;
 } NvmeAsyncEvent;
 
-typedef struct NvmeRequest {
-    struct NvmeSQueue       *sq;
-    struct NvmeNamespace    *ns;
-    BlockAIOCB              *aiocb;
-    uint16_t                status;
-    NvmeCqe                 cqe;
-    NvmeCmd                 cmd;
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
+static inline void nvme_req_set_cb(NvmeRequest *req,
+                                   NvmeRequestCompletionFunc *cb, void *cb_arg)
+{
+    req->cb = cb;
+    req->cb_arg = cb_arg;
+}
 
 typedef struct NvmeSQueue {
     struct NvmeCtrl *ctrl;
@@ -77,6 +95,68 @@ static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
     return nvme_ns_lbaf(ns)->ds;
 }
 
+typedef enum NvmeAIOOp {
+    NVME_AIO_OPC_NONE         = 0x0,
+    NVME_AIO_OPC_FLUSH        = 0x1,
+    NVME_AIO_OPC_READ         = 0x2,
+    NVME_AIO_OPC_WRITE        = 0x3,
+    NVME_AIO_OPC_WRITE_ZEROES = 0x4,
+} NvmeAIOOp;
+
+typedef enum NvmeAIOFlags {
+    NVME_AIO_DMA = 1 << 0,
+} NvmeAIOFlags;
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
+    int flags;
+    void *payload;
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
+    case NVME_CMD_WRITE_ZEROES:
+        return true;
+    default:
+        return false;
+    }
+}
+
+static inline bool nvme_req_is_dma(NvmeRequest *req)
+{
+    return req->qsg.sg != NULL;
+}
+
 #define TYPE_NVME "nvme"
 #define NVME(obj) \
         OBJECT_CHECK(NvmeCtrl, (obj), TYPE_NVME)
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 5d7d4679650b..1b2c431e569e 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -36,6 +36,8 @@ pci_nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2
 pci_nvme_map_addr(uint64_t addr, uint64_t len) "addr 0x%"PRIx64" len %"PRIu64""
 pci_nvme_map_addr_cmb(uint64_t addr, uint64_t len) "addr 0x%"PRIx64" len %"PRIu64""
 pci_nvme_map_prp(uint16_t cid, uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" trans_len %"PRIu64" len %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64" num_prps %d"
+pci_nvme_req_add_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offset, uint64_t count, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" count %"PRIu64" opc \"%s\" req %p"
+pci_nvme_aio_cb(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p"
 pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
 pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8""
 pci_nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
@@ -86,6 +88,7 @@ pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
 
 # nvme traces for error conditions
 pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %"PRIu64""
+pci_nvme_err_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req, uint16_t status) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p status 0x%"PRIx16""
 pci_nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
 pci_nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
 pci_nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
-- 
2.27.0



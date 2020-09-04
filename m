Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93673C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35FC2206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="ghIzXHlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FC2206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECfv-0006pN-9S
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kECa2-0002X7-R4; Fri, 04 Sep 2020 10:20:42 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kECa0-0002j1-5Q; Fri, 04 Sep 2020 10:20:42 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 1644DBFAF8;
 Fri,  4 Sep 2020 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1599229234;
 bh=o9LhlPSuEq62L2IPIXUW56rb6l9LYLLXVqfjyEEIlfk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ghIzXHlH9OLq8d9X1tUr6e3fLSphsVhGizoinapk95F05eo0hL3riqL4uzxqZEwEd
 m/+Q7mmNIHWJMkBlDHatPMJY6IKql6Hw7bvbaYwYzfNnmZTQguo0vq7Xe+z0YRI4qf
 VjjKXLXjjUbpA+XyYhdThGO5jnupwZmXXSYSzVNzN+wYl1xbHQN/mIS+puTlrWFloY
 k6HaVykx+ePPxbzb1vMOlWfwwnQ0uIoAyf1I4TcHIt7pJnaqQo9bUtiutF+xhgCFFl
 dAbCbRJJK5edoq54HBcf2sK7tR7594xmk+FuDntYssMSruPa6vvw1rbavOy3FQ8Zvq
 JvQZIScrUL7pg==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/17] hw/block/nvme: refactor aio submission
Date: Fri,  4 Sep 2020 16:19:47 +0200
Message-Id: <20200904141956.576630-9-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904141956.576630-1-its@irrelevant.dk>
References: <20200904141956.576630-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 10:20:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

This pulls block layer aio submission to a common function an introduces
the NvmeAIO structure that encapsulates this.

This adds more code with no immediate benefit, but is in preparation for
supporting multiple aios per request.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c       | 191 ++++++++++++++++++++++++++++++++----------
 hw/block/nvme.h       |  51 +++++++++++
 hw/block/trace-events |   3 +
 3 files changed, 203 insertions(+), 42 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index bfac3385cb64..3e32f39c7c1d 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -110,6 +110,7 @@ static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
 };
 
 static void nvme_process_sq(void *opaque);
+static void nvme_aio_cb(void *opaque, int ret);
 
 static uint16_t nvme_cid(NvmeRequest *req)
 {
@@ -611,39 +612,151 @@ static inline uint16_t nvme_check_bounds(NvmeCtrl *n, NvmeNamespace *ns,
     return NVME_SUCCESS;
 }
 
-static void nvme_rw_cb(void *opaque, int ret)
+static NvmeAIO *nvme_aio_new(NvmeAIOOp opc, BlockBackend *blk, int64_t offset)
 {
-    NvmeRequest *req = opaque;
-    NvmeSQueue *sq = req->sq;
-    NvmeCtrl *n = sq->ctrl;
-    NvmeCQueue *cq = n->cq[sq->cqid];
+    NvmeAIO *aio = g_new0(NvmeAIO, 1);
 
-    trace_pci_nvme_rw_cb(nvme_cid(req));
+    aio->opc = opc;
+    aio->blk = blk;
+    aio->offset = offset;
 
-    if (!ret) {
-        block_acct_done(blk_get_stats(n->conf.blk), &req->acct);
-        req->status = NVME_SUCCESS;
-    } else {
-        block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
-        req->status = NVME_INTERNAL_DEV_ERROR;
+    return aio;
+}
+
+static void nvme_aio_destroy(NvmeAIO *aio)
+{
+    g_free(aio);
+}
+
+static uint16_t nvme_do_aio(NvmeAIO *aio)
+{
+    NvmeRequest *req = aio->req;
+
+    BlockBackend *blk = aio->blk;
+    BlockAcctCookie *acct = &req->acct;
+    BlockAcctStats *stats = blk_get_stats(blk);
+
+    bool is_write;
+
+    switch (aio->opc) {
+    case NVME_AIO_OPC_FLUSH:
+        block_acct_start(stats, acct, 0, BLOCK_ACCT_FLUSH);
+        req->aiocb = blk_aio_flush(blk, nvme_aio_cb, aio);
+        break;
+
+    case NVME_AIO_OPC_WRITE_ZEROES:
+        block_acct_start(stats, acct, aio->len, BLOCK_ACCT_WRITE);
+        req->aiocb = blk_aio_pwrite_zeroes(blk, aio->offset, aio->len,
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
+                req->aiocb = dma_blk_write(blk, qsg, aio->offset,
+                                           BDRV_SECTOR_SIZE, nvme_aio_cb, aio);
+            } else {
+                req->aiocb = dma_blk_read(blk, qsg, aio->offset,
+                                          BDRV_SECTOR_SIZE, nvme_aio_cb, aio);
+            }
+        } else {
+            QEMUIOVector *iov = (QEMUIOVector *)aio->payload;
+
+            if (is_write) {
+                req->aiocb = blk_aio_pwritev(blk, aio->offset, iov, 0,
+                                             nvme_aio_cb, aio);
+            } else {
+                req->aiocb = blk_aio_preadv(blk, aio->offset, iov, 0,
+                                            nvme_aio_cb, aio);
+            }
+        }
+
+        break;
     }
 
-    nvme_enqueue_req_completion(cq, req);
+    return NVME_NO_COMPLETE;
+}
+
+static uint16_t nvme_aio_add(NvmeRequest *req, NvmeAIO *aio)
+{
+    aio->req = req;
+
+    trace_pci_nvme_aio_add(nvme_cid(req), aio, blk_name(aio->blk),
+                           aio->offset, aio->len, nvme_aio_opc_str(aio),
+                           req);
+
+    return nvme_do_aio(aio);
+}
+
+static void nvme_aio_cb(void *opaque, int ret)
+{
+    NvmeAIO *aio = opaque;
+    NvmeRequest *req = aio->req;
+
+    BlockBackend *blk = aio->blk;
+    BlockAcctCookie *acct = &req->acct;
+    BlockAcctStats *stats = blk_get_stats(blk);
+
+    Error *local_err = NULL;
+
+    trace_pci_nvme_aio_cb(nvme_cid(req), aio, blk_name(blk), aio->offset,
+                          aio->len, nvme_aio_opc_str(aio), req);
+
+    if (!ret) {
+        block_acct_done(stats, acct);
+        req->status = NVME_SUCCESS;
+    } else {
+        uint16_t status;
+
+        block_acct_failed(stats, acct);
+
+        switch (aio->opc) {
+        case NVME_AIO_OPC_READ:
+            status = NVME_UNRECOVERED_READ;
+            break;
+        case NVME_AIO_OPC_FLUSH:
+        case NVME_AIO_OPC_WRITE:
+        case NVME_AIO_OPC_WRITE_ZEROES:
+            status = NVME_WRITE_FAULT;
+            break;
+        default:
+            status = NVME_INTERNAL_DEV_ERROR;
+            break;
+        }
+
+        trace_pci_nvme_err_aio(nvme_cid(req), aio, blk_name(blk),
+                               aio->offset, nvme_aio_opc_str(aio), req,
+                               status);
+
+        error_setg_errno(&local_err, -ret, "aio failed");
+        error_report_err(local_err);
+
+        req->status = status;
+    }
+
+    nvme_enqueue_req_completion(nvme_cq(req), req);
+    nvme_aio_destroy(aio);
 }
 
 static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
 {
-    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
-                     BLOCK_ACCT_FLUSH);
-    req->aiocb = blk_aio_flush(n->conf.blk, nvme_rw_cb, req);
-
-    return NVME_NO_COMPLETE;
+    return nvme_aio_add(req, nvme_aio_new(NVME_AIO_OPC_FLUSH, n->conf.blk, 0));
 }
 
 static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
+    NvmeAIO *aio;
     uint64_t slba = le64_to_cpu(rw->slba);
     uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
     uint64_t offset = nvme_l2b(ns, slba);
@@ -658,24 +771,23 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
         return status;
     }
 
-    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
-                     BLOCK_ACCT_WRITE);
-    req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
-                                       BDRV_REQ_MAY_UNMAP, nvme_rw_cb, req);
-    return NVME_NO_COMPLETE;
+    aio = nvme_aio_new(NVME_AIO_OPC_WRITE_ZEROES, n->conf.blk, offset);
+    aio->len = count;
+
+    return nvme_aio_add(req, aio);
 }
 
 static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
+    NvmeAIO *aio;
     uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
     uint64_t slba = le64_to_cpu(rw->slba);
 
     uint64_t data_size = nvme_l2b(ns, nlb);
     uint64_t data_offset = nvme_l2b(ns, slba);
-    int is_write = rw->opcode == NVME_CMD_WRITE ? 1 : 0;
-    enum BlockAcctType acct = is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
+    bool is_write = nvme_req_is_write(req);
     uint16_t status;
 
     trace_pci_nvme_rw(nvme_cid(req), nvme_io_opc_str(rw->opcode), nlb,
@@ -698,28 +810,23 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
-    if (req->qsg.nsg > 0) {
-        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->qsg.size,
-                         acct);
-        req->aiocb = is_write ?
-            dma_blk_write(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
-                          nvme_rw_cb, req) :
-            dma_blk_read(n->conf.blk, &req->qsg, data_offset, BDRV_SECTOR_SIZE,
-                         nvme_rw_cb, req);
+    aio = nvme_aio_new(is_write ? NVME_AIO_OPC_WRITE : NVME_AIO_OPC_READ,
+                       n->conf.blk, data_offset);
+
+    if (req->qsg.sg) {
+        aio->payload = &req->qsg;
+        aio->len = req->qsg.size;
+        aio->flags |= NVME_AIO_DMA;
     } else {
-        block_acct_start(blk_get_stats(n->conf.blk), &req->acct, req->iov.size,
-                         acct);
-        req->aiocb = is_write ?
-            blk_aio_pwritev(n->conf.blk, data_offset, &req->iov, 0, nvme_rw_cb,
-                            req) :
-            blk_aio_preadv(n->conf.blk, data_offset, &req->iov, 0, nvme_rw_cb,
-                           req);
+        aio->payload = &req->iov;
+        aio->len = req->iov.size;
     }
 
-    return NVME_NO_COMPLETE;
+    return nvme_aio_add(req, aio);
 
 invalid:
-    block_acct_invalid(blk_get_stats(n->conf.blk), acct);
+    block_acct_invalid(blk_get_stats(n->conf.blk),
+                       is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
     return status;
 }
 
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index ce9e931420d7..7a11b0b37317 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -32,6 +32,17 @@ typedef struct NvmeRequest {
     QTAILQ_ENTRY(NvmeRequest)entry;
 } NvmeRequest;
 
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
 static inline const char *nvme_adm_opc_str(uint8_t opc)
 {
     switch (opc) {
@@ -60,6 +71,38 @@ static inline const char *nvme_io_opc_str(uint8_t opc)
     }
 }
 
+typedef enum NvmeAIOOp {
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
+typedef struct NvmeAIO {
+    NvmeAIOOp       opc;
+    NvmeRequest     *req;
+    BlockBackend    *blk;
+    int64_t         offset;
+    size_t          len;
+    int             flags;
+    void            *payload;
+} NvmeAIO;
+
+static inline const char *nvme_aio_opc_str(NvmeAIO *aio)
+{
+    switch (aio->opc) {
+    case NVME_AIO_OPC_FLUSH:        return "NVME_AIO_OPC_FLUSH";
+    case NVME_AIO_OPC_READ:         return "NVME_AIO_OPC_READ";
+    case NVME_AIO_OPC_WRITE:        return "NVME_AIO_OPC_WRITE";
+    case NVME_AIO_OPC_WRITE_ZEROES: return "NVME_AIO_OPC_WRITE_ZEROES";
+    default:                        return "NVME_AIO_OPC_UNKNOWN";
+    }
+}
+
 typedef struct NvmeSQueue {
     struct NvmeCtrl *ctrl;
     uint16_t    sqid;
@@ -171,4 +214,12 @@ static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
     return n->ns_size >> nvme_ns_lbads(ns);
 }
 
+static inline NvmeCQueue *nvme_cq(NvmeRequest *req)
+{
+    NvmeSQueue *sq = req->sq;
+    NvmeCtrl *n = sq->ctrl;
+
+    return n->cq[sq->cqid];
+}
+
 #endif /* HW_NVME_H */
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 0823d0fb47c5..fb3bf1be5e07 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -39,6 +39,8 @@ pci_nvme_map_prp(uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2,
 pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode, const char *opname) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8" opname \"%s\""
 pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode, const char *opname) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8" opname \"%s\""
 pci_nvme_rw(uint16_t cid, const char *verb, uint32_t nlb, uint64_t count, uint64_t lba) "cid %"PRIu16" \"%s\" nlb %"PRIu32" count %"PRIu64" lba 0x%"PRIx64""
+pci_nvme_aio_add(uint16_t cid, void *aio, const char *blkname, uint64_t offset, uint64_t len, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" len %"PRIu64" opc \"%s\" req %p"
+pci_nvme_aio_cb(uint16_t cid, void *aio, const char *blkname, uint64_t offset, uint64_t len, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" len %"PRIu64" opc \"%s\" req %p"
 pci_nvme_rw_cb(uint16_t cid) "cid %"PRIu16""
 pci_nvme_write_zeroes(uint16_t cid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" slba %"PRIu64" nlb %"PRIu32""
 pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
@@ -88,6 +90,7 @@ pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
 pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
 pci_nvme_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
+pci_nvme_err_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req, uint16_t status) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p status 0x%"PRIx16""
 pci_nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
 pci_nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
 pci_nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
-- 
2.28.0



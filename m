Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5B3C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A7D206B8
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="IxrQUm89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A7D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEChm-0001o5-BD
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kECa3-0002Xm-3P; Fri, 04 Sep 2020 10:20:43 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kECa0-0002j9-Hc; Fri, 04 Sep 2020 10:20:42 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id C6F6FBFB07;
 Fri,  4 Sep 2020 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1599229235;
 bh=kq9SZ7rxoSp0pOdHatuuNolGXaFd09h9ScnJjZG7sWM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IxrQUm89KYDz8wsutcBMQ3WUaEk2UkMiy+FQ0Q+QFAVqT1ycwkilsi/qssK5bBul5
 /9A1cxWso/bsOipS79gbf4wTjS/rH9sC3+PtOckhdMtbiYWRuIHthWJvrSTqtwW6KD
 nMpG0+ViARS/LKWU2xT2D7K4D93cGj192uSsAgjm81TOEgzf/pEr7mOBPi5/JHOBH9
 2Afo6GkrMqkJB34bh1fn8ohJH2xbBYALZzf+yyftBRfpOP/k6A1zHE3BzOWt3Qb5Lq
 +PjZp3RdY+pvEDVM/a8AvjpujgHzG6lGmVD9yzrVCdi8km4q3aXLjef3gvgoAdfFhR
 Ss9AP65KNmhzQ==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/17] hw/block/nvme: support multiple parallel aios per
 request
Date: Fri,  4 Sep 2020 16:19:49 +0200
Message-Id: <20200904141956.576630-11-its@irrelevant.dk>
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

Move the BlockAIOCB to NvmeAIO and add a queue of pending AIOs to the
NvmeRequest. Only when the queue is empty is a completion enqueued.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 44 ++++++++++++++++++++++++++++++--------------
 hw/block/nvme.h |  6 ++++--
 2 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 64c8f232e3ea..36ec8cbb1168 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -629,10 +629,8 @@ static void nvme_aio_destroy(NvmeAIO *aio)
 
 static uint16_t nvme_do_aio(NvmeAIO *aio)
 {
-    NvmeRequest *req = aio->req;
-
     BlockBackend *blk = aio->blk;
-    BlockAcctCookie *acct = &req->acct;
+    BlockAcctCookie *acct = &aio->acct;
     BlockAcctStats *stats = blk_get_stats(blk);
 
     bool is_write;
@@ -640,12 +638,12 @@ static uint16_t nvme_do_aio(NvmeAIO *aio)
     switch (aio->opc) {
     case NVME_AIO_OPC_FLUSH:
         block_acct_start(stats, acct, 0, BLOCK_ACCT_FLUSH);
-        req->aiocb = blk_aio_flush(blk, nvme_aio_cb, aio);
+        aio->aiocb = blk_aio_flush(blk, nvme_aio_cb, aio);
         break;
 
     case NVME_AIO_OPC_WRITE_ZEROES:
         block_acct_start(stats, acct, aio->len, BLOCK_ACCT_WRITE);
-        req->aiocb = blk_aio_pwrite_zeroes(blk, aio->offset, aio->len,
+        aio->aiocb = blk_aio_pwrite_zeroes(blk, aio->offset, aio->len,
                                            BDRV_REQ_MAY_UNMAP, nvme_aio_cb,
                                            aio);
         break;
@@ -661,20 +659,20 @@ static uint16_t nvme_do_aio(NvmeAIO *aio)
             QEMUSGList *qsg = (QEMUSGList *)aio->payload;
 
             if (is_write) {
-                req->aiocb = dma_blk_write(blk, qsg, aio->offset,
+                aio->aiocb = dma_blk_write(blk, qsg, aio->offset,
                                            BDRV_SECTOR_SIZE, nvme_aio_cb, aio);
             } else {
-                req->aiocb = dma_blk_read(blk, qsg, aio->offset,
+                aio->aiocb = dma_blk_read(blk, qsg, aio->offset,
                                           BDRV_SECTOR_SIZE, nvme_aio_cb, aio);
             }
         } else {
             QEMUIOVector *iov = (QEMUIOVector *)aio->payload;
 
             if (is_write) {
-                req->aiocb = blk_aio_pwritev(blk, aio->offset, iov, 0,
+                aio->aiocb = blk_aio_pwritev(blk, aio->offset, iov, 0,
                                              nvme_aio_cb, aio);
             } else {
-                req->aiocb = blk_aio_preadv(blk, aio->offset, iov, 0,
+                aio->aiocb = blk_aio_preadv(blk, aio->offset, iov, 0,
                                             nvme_aio_cb, aio);
             }
         }
@@ -693,6 +691,8 @@ static uint16_t nvme_aio_add(NvmeRequest *req, NvmeAIO *aio)
                            aio->offset, aio->len, nvme_aio_opc_str(aio),
                            req);
 
+    QTAILQ_INSERT_TAIL(&req->aio_tailq, aio, entry);
+
     return nvme_do_aio(aio);
 }
 
@@ -702,7 +702,7 @@ static void nvme_aio_cb(void *opaque, int ret)
     NvmeRequest *req = aio->req;
 
     BlockBackend *blk = aio->blk;
-    BlockAcctCookie *acct = &req->acct;
+    BlockAcctCookie *acct = &aio->acct;
     BlockAcctStats *stats = blk_get_stats(blk);
 
     Error *local_err = NULL;
@@ -710,6 +710,8 @@ static void nvme_aio_cb(void *opaque, int ret)
     trace_pci_nvme_aio_cb(nvme_cid(req), aio, blk_name(blk), aio->offset,
                           aio->len, nvme_aio_opc_str(aio), req);
 
+    QTAILQ_REMOVE(&req->aio_tailq, aio, entry);
+
     if (!ret) {
         block_acct_done(stats, acct);
     } else {
@@ -738,10 +740,19 @@ static void nvme_aio_cb(void *opaque, int ret)
         error_setg_errno(&local_err, -ret, "aio failed");
         error_report_err(local_err);
 
-        req->status = status;
+        /*
+         * An Internal Error trumps all other errors. For other errors, only
+         * set the first encountered.
+         */
+        if (!req->status || (status & 0xfff) == NVME_INTERNAL_DEV_ERROR) {
+            req->status = status;
+        }
+    }
+
+    if (QTAILQ_EMPTY(&req->aio_tailq)) {
+        nvme_enqueue_req_completion(nvme_cq(req), req);
     }
 
-    nvme_enqueue_req_completion(nvme_cq(req), req);
     nvme_aio_destroy(aio);
 }
 
@@ -872,6 +883,7 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
     NvmeRequest *r, *next;
     NvmeSQueue *sq;
     NvmeCQueue *cq;
+    NvmeAIO *aio;
     uint16_t qid = le16_to_cpu(c->qid);
 
     if (unlikely(!qid || nvme_check_sqid(n, qid))) {
@@ -884,8 +896,11 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
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
@@ -923,6 +938,7 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
     for (i = 0; i < sq->size; i++) {
         sq->io_req[i].sq = sq;
         QTAILQ_INSERT_TAIL(&(sq->req_list), &sq->io_req[i], entry);
+        QTAILQ_INIT(&(sq->io_req[i].aio_tailq));
     }
     sq->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_process_sq, sq);
 
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 7a11b0b37317..baedcb226cb1 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -22,14 +22,13 @@ typedef struct NvmeAsyncEvent {
 typedef struct NvmeRequest {
     struct NvmeSQueue       *sq;
     struct NvmeNamespace    *ns;
-    BlockAIOCB              *aiocb;
     uint16_t                status;
     NvmeCqe                 cqe;
     NvmeCmd                 cmd;
-    BlockAcctCookie         acct;
     QEMUSGList              qsg;
     QEMUIOVector            iov;
     QTAILQ_ENTRY(NvmeRequest)entry;
+    QTAILQ_HEAD(, NvmeAIO)  aio_tailq;
 } NvmeRequest;
 
 static inline bool nvme_req_is_write(NvmeRequest *req)
@@ -86,10 +85,13 @@ typedef struct NvmeAIO {
     NvmeAIOOp       opc;
     NvmeRequest     *req;
     BlockBackend    *blk;
+    BlockAcctCookie acct;
+    BlockAIOCB      *aiocb;
     int64_t         offset;
     size_t          len;
     int             flags;
     void            *payload;
+    QTAILQ_ENTRY(NvmeAIO) entry;
 } NvmeAIO;
 
 static inline const char *nvme_aio_opc_str(NvmeAIO *aio)
-- 
2.28.0



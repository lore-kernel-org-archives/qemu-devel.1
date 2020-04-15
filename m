Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60725C2BB85
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CC020737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CC020737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43747 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jObCG-0002ka-5B
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 02:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOaz6-000354-Nq
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOaz4-0002vG-8n
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:16 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47580)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOayw-0002b9-GE; Wed, 15 Apr 2020 01:53:06 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id D229FBFDC1;
 Wed, 15 Apr 2020 05:52:30 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 35/48] nvme: remove NvmeCmd parameter
Date: Wed, 15 Apr 2020 07:51:27 +0200
Message-Id: <20200415055140.466900-36-its@irrelevant.dk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415055140.466900-1-its@irrelevant.dk>
References: <20200415055140.466900-1-its@irrelevant.dk>
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
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Keep a copy of the raw nvme command in the NvmeRequest and remove the
now redundant NvmeCmd parameter.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 177 +++++++++++++++++++++++++-----------------------
 hw/block/nvme.h |   1 +
 2 files changed, 93 insertions(+), 85 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index a7c5f93fc545..846aa31eaae9 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -378,9 +378,10 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *p=
tr, uint32_t len,
     return status;
 }
=20
-static uint16_t nvme_map(NvmeCtrl *n, NvmeCmd *cmd, QEMUSGList *qsg,
-                         QEMUIOVector *iov, size_t len, NvmeRequest *req=
)
+static uint16_t nvme_map(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov=
,
+                         size_t len, NvmeRequest *req)
 {
+    NvmeCmd *cmd =3D &req->cmd;
     uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
     uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
=20
@@ -561,7 +562,7 @@ static void nvme_rw_cb(void *opaque, int ret)
     nvme_enqueue_req_completion(cq, req);
 }
=20
-static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
 {
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
          BLOCK_ACCT_FLUSH);
@@ -570,9 +571,9 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd,=
 NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
=20
-static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest=
 *req)
+static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeRwCmd *rw =3D (NvmeRwCmd *)cmd;
+    NvmeRwCmd *rw =3D (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns =3D req->ns;
     const uint8_t lba_index =3D NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
     const uint8_t data_shift =3D ns->id_ns.lbaf[lba_index].ds;
@@ -596,9 +597,9 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
=20
-static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeRwCmd *rw =3D (NvmeRwCmd *)cmd;
+    NvmeRwCmd *rw =3D (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns =3D req->ns;
     uint32_t nlb  =3D le32_to_cpu(rw->nlb) + 1;
     uint64_t slba =3D le64_to_cpu(rw->slba);
@@ -625,7 +626,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, Nv=
meRequest *req)
         return status;
     }
=20
-    if (nvme_map(n, cmd, &req->qsg, &req->iov, data_size, req)) {
+    if (nvme_map(n, &req->qsg, &req->iov, data_size, req)) {
         block_acct_invalid(blk_get_stats(n->conf.blk), acct);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
@@ -651,12 +652,12 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, =
NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
=20
-static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
 {
-    uint32_t nsid =3D le32_to_cpu(cmd->nsid);
+    uint32_t nsid =3D le32_to_cpu(req->cmd.nsid);
=20
     trace_nvme_dev_io_cmd(nvme_cid(req), nsid, le16_to_cpu(req->sq->sqid=
),
-                          cmd->opcode);
+                          req->cmd.opcode);
=20
     if (unlikely(nsid =3D=3D 0 || nsid > n->num_namespaces)) {
         trace_nvme_dev_err_invalid_ns(nsid, n->num_namespaces);
@@ -664,16 +665,16 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *c=
md, NvmeRequest *req)
     }
=20
     req->ns =3D &n->namespaces[nsid - 1];
-    switch (cmd->opcode) {
+    switch (req->cmd.opcode) {
     case NVME_CMD_FLUSH:
-        return nvme_flush(n, cmd, req);
+        return nvme_flush(n, req);
     case NVME_CMD_WRITE_ZEROES:
-        return nvme_write_zeroes(n, cmd, req);
+        return nvme_write_zeroes(n, req);
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
-        return nvme_rw(n, cmd, req);
+        return nvme_rw(n, req);
     default:
-        trace_nvme_dev_err_invalid_opc(cmd->opcode);
+        trace_nvme_dev_err_invalid_opc(req->cmd.opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
 }
@@ -689,10 +690,10 @@ static void nvme_free_sq(NvmeSQueue *sq, NvmeCtrl *=
n)
     }
 }
=20
-static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeDeleteQ *c =3D (NvmeDeleteQ *)cmd;
-    NvmeRequest *req, *next;
+    NvmeDeleteQ *c =3D (NvmeDeleteQ *)&req->cmd;
+    NvmeRequest *r, *next;
     NvmeSQueue *sq;
     NvmeCQueue *cq;
     uint16_t qid =3D le16_to_cpu(c->qid);
@@ -706,19 +707,19 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *c=
md)
=20
     sq =3D n->sq[qid];
     while (!QTAILQ_EMPTY(&sq->out_req_list)) {
-        req =3D QTAILQ_FIRST(&sq->out_req_list);
-        assert(req->aiocb);
-        blk_aio_cancel(req->aiocb);
+        r =3D QTAILQ_FIRST(&sq->out_req_list);
+        assert(r->aiocb);
+        blk_aio_cancel(r->aiocb);
     }
     if (!nvme_check_cqid(n, sq->cqid)) {
         cq =3D n->cq[sq->cqid];
         QTAILQ_REMOVE(&cq->sq_list, sq, entry);
=20
         nvme_post_cqes(cq);
-        QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next) {
-            if (req->sq =3D=3D sq) {
-                QTAILQ_REMOVE(&cq->req_list, req, entry);
-                QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
+        QTAILQ_FOREACH_SAFE(r, &cq->req_list, entry, next) {
+            if (r->sq =3D=3D sq) {
+                QTAILQ_REMOVE(&cq->req_list, r, entry);
+                QTAILQ_INSERT_TAIL(&sq->req_list, r, entry);
             }
         }
     }
@@ -755,10 +756,10 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *=
n, uint64_t dma_addr,
     n->sq[sqid] =3D sq;
 }
=20
-static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeSQueue *sq;
-    NvmeCreateSq *c =3D (NvmeCreateSq *)cmd;
+    NvmeCreateSq *c =3D (NvmeCreateSq *)&req->cmd;
=20
     uint16_t cqid =3D le16_to_cpu(c->cqid);
     uint16_t sqid =3D le16_to_cpu(c->sqid);
@@ -793,10 +794,10 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd=
 *cmd)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
-                                uint32_t buf_len, uint64_t off,
-                                NvmeRequest *req)
+static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_l=
en,
+                                uint64_t off, NvmeRequest *req)
 {
+    NvmeCmd *cmd =3D &req->cmd;
     uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
     uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
     uint32_t nsid =3D le32_to_cpu(cmd->nsid);
@@ -852,10 +853,11 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCm=
d *cmd, uint8_t rae,
                         DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf=
_len,
-                                 uint64_t off, NvmeRequest *req)
+static uint16_t nvme_fw_log_info(NvmeCtrl *n, uint32_t buf_len, uint64_t=
 off,
+                                 NvmeRequest *req)
 {
     uint32_t trans_len;
+    NvmeCmd *cmd =3D &req->cmd;
     uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
     uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
     NvmeFwSlotInfoLog fw_log;
@@ -872,11 +874,11 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeC=
md *cmd, uint32_t buf_len,
                         DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
-                                uint32_t buf_len, uint64_t off,
-                                NvmeRequest *req)
+static uint16_t nvme_error_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_l=
en,
+                                uint64_t off, NvmeRequest *req)
 {
     uint32_t trans_len;
+    NvmeCmd *cmd =3D &req->cmd;
     uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
     uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
     NvmeErrorLog errlog;
@@ -897,8 +899,10 @@ static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd=
 *cmd, uint8_t rae,
                         DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req=
)
+static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeCmd *cmd =3D &req->cmd;
+
     uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
     uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
     uint32_t dw12 =3D le32_to_cpu(cmd->cdw12);
@@ -932,11 +936,11 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *=
cmd, NvmeRequest *req)
=20
     switch (lid) {
     case NVME_LOG_ERROR_INFO:
-        return nvme_error_info(n, cmd, rae, len, off, req);
+        return nvme_error_info(n, rae, len, off, req);
     case NVME_LOG_SMART_INFO:
-        return nvme_smart_info(n, cmd, rae, len, off, req);
+        return nvme_smart_info(n, rae, len, off, req);
     case NVME_LOG_FW_SLOT_INFO:
-        return nvme_fw_log_info(n, cmd, len, off, req);
+        return nvme_fw_log_info(n, len, off, req);
     default:
         trace_nvme_dev_err_invalid_log_page(nvme_cid(req), lid);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -954,9 +958,9 @@ static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *n)
     }
 }
=20
-static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeDeleteQ *c =3D (NvmeDeleteQ *)cmd;
+    NvmeDeleteQ *c =3D (NvmeDeleteQ *)&req->cmd;
     NvmeCQueue *cq;
     uint16_t qid =3D le16_to_cpu(c->qid);
=20
@@ -994,10 +998,10 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *=
n, uint64_t dma_addr,
     cq->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_post_cqes, cq);
 }
=20
-static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeCQueue *cq;
-    NvmeCreateCq *c =3D (NvmeCreateCq *)cmd;
+    NvmeCreateCq *c =3D (NvmeCreateCq *)&req->cmd;
     uint16_t cqid =3D le16_to_cpu(c->cqid);
     uint16_t vector =3D le16_to_cpu(c->irq_vector);
     uint16_t qsize =3D le16_to_cpu(c->qsize);
@@ -1041,9 +1045,9 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd=
 *cmd)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c,
-                                   NvmeRequest *req)
+static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
     uint64_t prp1 =3D le64_to_cpu(c->prp1);
     uint64_t prp2 =3D le64_to_cpu(c->prp2);
=20
@@ -1053,10 +1057,10 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, N=
vmeIdentify *c,
                         prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
-                                 NvmeRequest *req)
+static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns;
+    NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
     uint32_t nsid =3D le32_to_cpu(c->nsid);
     uint64_t prp1 =3D le64_to_cpu(c->prp1);
     uint64_t prp2 =3D le64_to_cpu(c->prp2);
@@ -1074,9 +1078,9 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeI=
dentify *c,
                         prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c,
-                                     NvmeRequest *req)
+static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
     static const int data_len =3D NVME_IDENTIFY_DATA_SIZE;
     uint32_t min_nsid =3D le32_to_cpu(c->nsid);
     uint64_t prp1 =3D le64_to_cpu(c->prp1);
@@ -1103,9 +1107,9 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, N=
vmeIdentify *c,
     return ret;
 }
=20
-static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c=
,
-                                            NvmeRequest *req)
+static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *re=
q)
 {
+    NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
     uint32_t nsid =3D le32_to_cpu(c->nsid);
     uint64_t prp1 =3D le64_to_cpu(c->prp1);
     uint64_t prp2 =3D le64_to_cpu(c->prp2);
@@ -1142,28 +1146,28 @@ static uint16_t nvme_identify_ns_descr_list(NvmeC=
trl *n, NvmeIdentify *c,
                         DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *re=
q)
+static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeIdentify *c =3D (NvmeIdentify *)cmd;
+    NvmeIdentify *c =3D (NvmeIdentify *)&req->cmd;
=20
     switch (le32_to_cpu(c->cns)) {
     case NVME_ID_CNS_NS:
-        return nvme_identify_ns(n, c, req);
+        return nvme_identify_ns(n, req);
     case NVME_ID_CNS_CTRL:
-        return nvme_identify_ctrl(n, c, req);
+        return nvme_identify_ctrl(n, req);
     case NVME_ID_CNS_NS_ACTIVE_LIST:
-        return nvme_identify_nslist(n, c, req);
+        return nvme_identify_nslist(n, req);
     case NVME_ID_CNS_NS_DESCR_LIST:
-        return nvme_identify_ns_descr_list(n, c, req);
+        return nvme_identify_ns_descr_list(n, req);
     default:
         trace_nvme_dev_err_invalid_identify_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 }
=20
-static uint16_t nvme_abort(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest *req)
 {
-    uint16_t sqid =3D le32_to_cpu(cmd->cdw10) & 0xffff;
+    uint16_t sqid =3D le32_to_cpu(req->cmd.cdw10) & 0xffff;
=20
     req->cqe.result =3D 1;
     if (nvme_check_sqid(n, sqid)) {
@@ -1213,9 +1217,9 @@ static inline uint64_t nvme_get_timestamp(const Nvm=
eCtrl *n)
     return cpu_to_le64(ts.all);
 }
=20
-static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
-                                           NvmeRequest *req)
+static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeRequest *req=
)
 {
+    NvmeCmd *cmd =3D &req->cmd;
     uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
     uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
=20
@@ -1225,8 +1229,9 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl=
 *n, NvmeCmd *cmd,
                         prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
+static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeCmd *cmd =3D &req->cmd;
     uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
     uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
     uint32_t result;
@@ -1274,7 +1279,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
         trace_nvme_dev_getfeat_numq(result);
         break;
     case NVME_TIMESTAMP:
-        return nvme_get_feature_timestamp(n, cmd, req);
+        return nvme_get_feature_timestamp(n, req);
     case NVME_INTERRUPT_COALESCING:
         result =3D cpu_to_le32(n->features.int_coalescing);
         break;
@@ -1300,11 +1305,11 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, Nvm=
eCmd *cmd, NvmeRequest *req)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
-                                           NvmeRequest *req)
+static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeRequest *req=
)
 {
     uint16_t ret;
     uint64_t timestamp;
+    NvmeCmd *cmd =3D &req->cmd;
     uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
     uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
=20
@@ -1319,8 +1324,9 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl=
 *n, NvmeCmd *cmd,
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
+static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeCmd *cmd =3D &req->cmd;
     uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
     uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
=20
@@ -1380,7 +1386,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
                                       ((n->params.max_ioqpairs - 1) << 1=
6));
         break;
     case NVME_TIMESTAMP:
-        return nvme_set_feature_timestamp(n, cmd, req);
+        return nvme_set_feature_timestamp(n, req);
     case NVME_ASYNCHRONOUS_EVENT_CONF:
         n->features.async_config =3D dw11;
         break;
@@ -1398,7 +1404,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_aer(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_aer(NvmeCtrl *n, NvmeRequest *req)
 {
     trace_nvme_dev_aer(nvme_cid(req));
=20
@@ -1417,34 +1423,34 @@ static uint16_t nvme_aer(NvmeCtrl *n, NvmeCmd *cm=
d, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
=20
-static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *r=
eq)
+static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
 {
     trace_nvme_dev_admin_cmd(nvme_cid(req), le16_to_cpu(req->sq->sqid),
-                             cmd->opcode);
+                             req->cmd.opcode);
=20
-    switch (cmd->opcode) {
+    switch (req->cmd.opcode) {
     case NVME_ADM_CMD_DELETE_SQ:
-        return nvme_del_sq(n, cmd);
+        return nvme_del_sq(n, req);
     case NVME_ADM_CMD_CREATE_SQ:
-        return nvme_create_sq(n, cmd);
+        return nvme_create_sq(n, req);
     case NVME_ADM_CMD_GET_LOG_PAGE:
-        return nvme_get_log(n, cmd, req);
+        return nvme_get_log(n, req);
     case NVME_ADM_CMD_DELETE_CQ:
-        return nvme_del_cq(n, cmd);
+        return nvme_del_cq(n, req);
     case NVME_ADM_CMD_CREATE_CQ:
-        return nvme_create_cq(n, cmd);
+        return nvme_create_cq(n, req);
     case NVME_ADM_CMD_IDENTIFY:
-        return nvme_identify(n, cmd, req);
+        return nvme_identify(n, req);
     case NVME_ADM_CMD_ABORT:
-        return nvme_abort(n, cmd, req);
+        return nvme_abort(n, req);
     case NVME_ADM_CMD_SET_FEATURES:
-        return nvme_set_feature(n, cmd, req);
+        return nvme_set_feature(n, req);
     case NVME_ADM_CMD_GET_FEATURES:
-        return nvme_get_feature(n, cmd, req);
+        return nvme_get_feature(n, req);
     case NVME_ADM_CMD_ASYNC_EV_REQ:
-        return nvme_aer(n, cmd, req);
+        return nvme_aer(n, req);
     default:
-        trace_nvme_dev_err_invalid_admin_opc(cmd->opcode);
+        trace_nvme_dev_err_invalid_admin_opc(req->cmd.opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
 }
@@ -1469,9 +1475,10 @@ static void nvme_process_sq(void *opaque)
         QTAILQ_REMOVE(&sq->req_list, req, entry);
         QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
         req->cqe.cid =3D cmd.cid;
+        memcpy(&req->cmd, &cmd, sizeof(NvmeCmd));
=20
-        status =3D sq->sqid ? nvme_io_cmd(n, &cmd, req) :
-            nvme_admin_cmd(n, &cmd, req);
+        status =3D sq->sqid ? nvme_io_cmd(n, req) :
+            nvme_admin_cmd(n, req);
         if (status !=3D NVME_NO_COMPLETE) {
             req->status =3D status;
             nvme_enqueue_req_completion(cq, req);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 11a42fa213ab..a781528a0ccd 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -33,6 +33,7 @@ typedef struct NvmeRequest {
     BlockAIOCB              *aiocb;
     uint16_t                status;
     NvmeCqe                 cqe;
+    NvmeCmd                 cmd;
     BlockAcctCookie         acct;
     QEMUSGList              qsg;
     QEMUIOVector            iov;
--=20
2.26.0



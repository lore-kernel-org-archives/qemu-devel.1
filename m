Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B31C3815B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD97C20737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD97C20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jObDg-00060R-MV
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 02:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOaz2-0002vW-JN
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOaz0-0002s8-N8
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:12 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47576)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOayw-0002ad-2X; Wed, 15 Apr 2020 01:53:06 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 7AE27BFDAE;
 Wed, 15 Apr 2020 05:52:30 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 34/48] nvme: refactor NvmeRequest
Date: Wed, 15 Apr 2020 07:51:26 +0200
Message-Id: <20200415055140.466900-35-its@irrelevant.dk>
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

Add a reference to the NvmeNamespace and move clearing of the structure
from "clear before use" to "clear after use".

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 38 +++++++++++++++++++++-----------------
 hw/block/nvme.h |  1 +
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 94d42046149e..a7c5f93fc545 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -159,6 +159,12 @@ static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQueu=
e *cq)
     }
 }
=20
+static void nvme_req_clear(NvmeRequest *req)
+{
+    req->ns =3D NULL;
+    memset(&req->cqe, 0x0, sizeof(req->cqe));
+}
+
 static uint16_t nvme_map_addr_cmb(NvmeCtrl *n, QEMUIOVector *iov, hwaddr=
 addr,
                                   size_t len)
 {
@@ -404,6 +410,7 @@ static void nvme_post_cqes(void *opaque)
         nvme_inc_cq_tail(cq);
         pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
             sizeof(req->cqe));
+        nvme_req_clear(req);
         QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
     }
     if (cq->tail !=3D cq->head) {
@@ -513,10 +520,10 @@ static inline uint16_t nvme_check_mdts(NvmeCtrl *n,=
 size_t len,
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
@@ -554,8 +561,7 @@ static void nvme_rw_cb(void *opaque, int ret)
     nvme_enqueue_req_completion(cq, req);
 }
=20
-static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
-    NvmeRequest *req)
+static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
          BLOCK_ACCT_FLUSH);
@@ -564,10 +570,10 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespa=
ce *ns, NvmeCmd *cmd,
     return NVME_NO_COMPLETE;
 }
=20
-static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeNamespace *ns, NvmeCm=
d *cmd,
-    NvmeRequest *req)
+static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest=
 *req)
 {
     NvmeRwCmd *rw =3D (NvmeRwCmd *)cmd;
+    NvmeNamespace *ns =3D req->ns;
     const uint8_t lba_index =3D NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
     const uint8_t data_shift =3D ns->id_ns.lbaf[lba_index].ds;
     uint64_t slba =3D le64_to_cpu(rw->slba);
@@ -578,7 +584,7 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeNa=
mespace *ns, NvmeCmd *cmd,
=20
     trace_nvme_dev_write_zeroes(nvme_cid(req), slba, nlb);
=20
-    status =3D nvme_check_bounds(n, ns, slba, nlb, req);
+    status =3D nvme_check_bounds(n, slba, nlb, req);
     if (status) {
         return status;
     }
@@ -590,10 +596,10 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, Nvme=
Namespace *ns, NvmeCmd *cmd,
     return NVME_NO_COMPLETE;
 }
=20
-static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
-    NvmeRequest *req)
+static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
     NvmeRwCmd *rw =3D (NvmeRwCmd *)cmd;
+    NvmeNamespace *ns =3D req->ns;
     uint32_t nlb  =3D le32_to_cpu(rw->nlb) + 1;
     uint64_t slba =3D le64_to_cpu(rw->slba);
=20
@@ -613,7 +619,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *n=
s, NvmeCmd *cmd,
         return status;
     }
=20
-    status =3D nvme_check_bounds(n, ns, slba, nlb, req);
+    status =3D nvme_check_bounds(n, slba, nlb, req);
     if (status) {
         block_acct_invalid(blk_get_stats(n->conf.blk), acct);
         return status;
@@ -647,7 +653,6 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *n=
s, NvmeCmd *cmd,
=20
 static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
-    NvmeNamespace *ns;
     uint32_t nsid =3D le32_to_cpu(cmd->nsid);
=20
     trace_nvme_dev_io_cmd(nvme_cid(req), nsid, le16_to_cpu(req->sq->sqid=
),
@@ -658,15 +663,15 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *c=
md, NvmeRequest *req)
         return NVME_INVALID_NSID | NVME_DNR;
     }
=20
-    ns =3D &n->namespaces[nsid - 1];
+    req->ns =3D &n->namespaces[nsid - 1];
     switch (cmd->opcode) {
     case NVME_CMD_FLUSH:
-        return nvme_flush(n, ns, cmd, req);
+        return nvme_flush(n, cmd, req);
     case NVME_CMD_WRITE_ZEROES:
-        return nvme_write_zeroes(n, ns, cmd, req);
+        return nvme_write_zeroes(n, cmd, req);
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
-        return nvme_rw(n, ns, cmd, req);
+        return nvme_rw(n, cmd, req);
     default:
         trace_nvme_dev_err_invalid_opc(cmd->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
@@ -1463,7 +1468,6 @@ static void nvme_process_sq(void *opaque)
         req =3D QTAILQ_FIRST(&sq->req_list);
         QTAILQ_REMOVE(&sq->req_list, req, entry);
         QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
-        memset(&req->cqe, 0, sizeof(req->cqe));
         req->cqe.cid =3D cmd.cid;
=20
         status =3D sq->sqid ? nvme_io_cmd(n, &cmd, req) :
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index a25568723d0d..11a42fa213ab 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -29,6 +29,7 @@ typedef struct NvmeAsyncEvent {
=20
 typedef struct NvmeRequest {
     struct NvmeSQueue       *sq;
+    struct NvmeNamespace    *ns;
     BlockAIOCB              *aiocb;
     uint16_t                status;
     NvmeCqe                 cqe;
--=20
2.26.0



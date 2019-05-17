Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3969CC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:46:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF297206A3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF297206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44592 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRYVa-0000UM-4D
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 04:46:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hRYTH-0007V2-VE
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hRYTF-00063y-9G
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:44:07 -0400
Received: from charlie.dont.surf ([128.199.63.193]:40178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klaus@birkelund.eu>)
	id 1hRYT8-0005u2-Mh; Fri, 17 May 2019 04:43:58 -0400
Received: from apples.localdomain (ip-5-186-120-196.cgn.fibianet.dk
	[5.186.120.196])
	by charlie.dont.surf (Postfix) with ESMTPSA id 56E90C06DF;
	Fri, 17 May 2019 08:43:56 +0000 (UTC)
From: Klaus Birkelund Jensen <klaus@birkelund.eu>
To: qemu-block@nongnu.org
Date: Fri, 17 May 2019 10:42:30 +0200
Message-Id: <20190517084234.26923-5-klaus@birkelund.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190517084234.26923-1-klaus@birkelund.eu>
References: <20190517084234.26923-1-klaus@birkelund.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: [Qemu-devel] [PATCH 4/8] nvme: allow multiple i/o's per request
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce a new NvmeBlockBackendRequest and move the QEMUSGList and
QEMUIOVector from the NvmeRequest.

This is in preparation for metadata support and makes it easier to
handle multiple block backend requests to different offsets.

Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c       | 319 ++++++++++++++++++++++++++++++++----------
 hw/block/nvme.h       |  47 +++++--
 hw/block/trace-events |   2 +
 3 files changed, 286 insertions(+), 82 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 453213f9abb4..c514f93f3867 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -322,6 +322,88 @@ static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8=
_t *ptr, uint32_t len,
     return err;
 }
=20
+static void nvme_blk_req_destroy(NvmeBlockBackendRequest *blk_req)
+{
+    if (blk_req->qsg.nalloc) {
+        qemu_sglist_destroy(&blk_req->qsg);
+    }
+
+    if (blk_req->iov.nalloc) {
+        qemu_iovec_destroy(&blk_req->iov);
+    }
+
+    g_free(blk_req);
+}
+
+static void nvme_blk_req_put(NvmeCtrl *n, NvmeBlockBackendRequest *blk_r=
eq)
+{
+    nvme_blk_req_destroy(blk_req);
+}
+
+static NvmeBlockBackendRequest *nvme_blk_req_get(NvmeCtrl *n, NvmeReques=
t *req,
+    QEMUSGList *qsg)
+{
+    NvmeBlockBackendRequest *blk_req =3D g_malloc0(sizeof(*blk_req));
+
+    blk_req->req =3D req;
+
+    if (qsg) {
+        pci_dma_sglist_init(&blk_req->qsg, &n->parent_obj, qsg->nsg);
+        memcpy(blk_req->qsg.sg, qsg->sg, qsg->nsg * sizeof(ScatterGather=
Entry));
+
+        blk_req->qsg.nsg =3D qsg->nsg;
+        blk_req->qsg.size =3D qsg->size;
+    }
+
+    return blk_req;
+}
+
+static uint16_t nvme_blk_setup(NvmeCtrl *n, NvmeNamespace *ns, QEMUSGLis=
t *qsg,
+    uint64_t blk_offset, uint32_t unit_len, NvmeRequest *req)
+{
+    NvmeBlockBackendRequest *blk_req =3D nvme_blk_req_get(n, req, qsg);
+    if (!blk_req) {
+        NVME_GUEST_ERR(nvme_err_internal_dev_error, "nvme_blk_req_get: %=
s",
+            "could not allocate memory");
+        return NVME_INTERNAL_DEV_ERROR;
+    }
+
+    blk_req->slba =3D req->slba;
+    blk_req->nlb =3D req->nlb;
+    blk_req->blk_offset =3D blk_offset + req->slba * unit_len;
+
+    QTAILQ_INSERT_TAIL(&req->blk_req_tailq, blk_req, tailq_entry);
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_blk_map(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req=
)
+{
+    NvmeNamespace *ns =3D req->ns;
+    uint16_t err;
+
+    QEMUSGList qsg;
+
+    uint32_t unit_len =3D nvme_ns_lbads_bytes(ns);
+    uint32_t len =3D req->nlb * unit_len;
+    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
+
+    err =3D nvme_map_prp(n, &qsg, prp1, prp2, len, req);
+    if (err) {
+        return err;
+    }
+
+    err =3D nvme_blk_setup(n, ns, &qsg, ns->blk_offset, unit_len, req);
+    if (err) {
+        return err;
+    }
+
+    qemu_sglist_destroy(&qsg);
+
+    return NVME_SUCCESS;
+}
+
 static void nvme_post_cqe(NvmeCQueue *cq, NvmeRequest *req)
 {
     NvmeCtrl *n =3D cq->ctrl;
@@ -447,114 +529,190 @@ static void nvme_process_aers(void *opaque)
=20
 static void nvme_rw_cb(void *opaque, int ret)
 {
-    NvmeRequest *req =3D opaque;
+    NvmeBlockBackendRequest *blk_req =3D opaque;
+    NvmeRequest *req =3D blk_req->req;
     NvmeSQueue *sq =3D req->sq;
     NvmeCtrl *n =3D sq->ctrl;
     NvmeCQueue *cq =3D n->cq[sq->cqid];
+    NvmeNamespace *ns =3D req->ns;
+
+    QTAILQ_REMOVE(&req->blk_req_tailq, blk_req, tailq_entry);
+
+    trace_nvme_rw_cb(req->cqe.cid, ns->id);
=20
     if (!ret) {
-        block_acct_done(blk_get_stats(n->conf.blk), &req->acct);
-        req->status =3D NVME_SUCCESS;
+        block_acct_done(blk_get_stats(n->conf.blk), &blk_req->acct);
     } else {
-        block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
-        req->status =3D NVME_INTERNAL_DEV_ERROR;
+        block_acct_failed(blk_get_stats(n->conf.blk), &blk_req->acct);
+        NVME_GUEST_ERR(nvme_err_internal_dev_error, "block request faile=
d: %s",
+            strerror(-ret));
+        req->status =3D NVME_INTERNAL_DEV_ERROR | NVME_DNR;
     }
=20
-    if (req->qsg.nalloc) {
-        qemu_sglist_destroy(&req->qsg);
-    }
-    if (req->iov.nalloc) {
-        qemu_iovec_destroy(&req->iov);
+    if (QTAILQ_EMPTY(&req->blk_req_tailq)) {
+        nvme_enqueue_req_completion(cq, req);
     }
=20
-    nvme_enqueue_req_completion(cq, req);
+    nvme_blk_req_put(n, blk_req);
 }
=20
-static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
-    NvmeRequest *req)
+static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
-    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
+    NvmeBlockBackendRequest *blk_req =3D nvme_blk_req_get(n, req, NULL);
+    if (!blk_req) {
+        NVME_GUEST_ERR(nvme_err_internal_dev_error, "nvme_blk_req_get: %=
s",
+            "could not allocate memory");
+        return NVME_INTERNAL_DEV_ERROR;
+    }
+
+    block_acct_start(blk_get_stats(n->conf.blk), &blk_req->acct, 0,
          BLOCK_ACCT_FLUSH);
-    req->aiocb =3D blk_aio_flush(n->conf.blk, nvme_rw_cb, req);
+    blk_req->aiocb =3D blk_aio_flush(n->conf.blk, nvme_rw_cb, blk_req);
+
+    QTAILQ_INSERT_TAIL(&req->blk_req_tailq, blk_req, tailq_entry);
=20
     return NVME_NO_COMPLETE;
 }
=20
-static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd=
 *cmd,
-    NvmeRequest *req)
+static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
 {
     NvmeRwCmd *rw =3D (NvmeRwCmd *)cmd;
-    const uint8_t lba_index =3D NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
-    const uint8_t data_shift =3D ns->id_ns.lbaf[lba_index].lbads;
+    NvmeBlockBackendRequest *blk_req;
+    const uint8_t lbads =3D nvme_ns_lbads(req->ns);
     uint64_t slba =3D le64_to_cpu(rw->slba);
     uint32_t nlb  =3D le16_to_cpu(rw->nlb) + 1;
-    uint64_t offset =3D slba << data_shift;
-    uint32_t count =3D nlb << data_shift;
+    uint64_t offset =3D slba << lbads;
+    uint32_t count =3D nlb << lbads;
=20
-    if (unlikely(slba + nlb > ns->id_ns.nsze)) {
-        trace_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
+    if (unlikely(slba + nlb > req->ns->id_ns.nsze)) {
+        trace_nvme_err_invalid_lba_range(slba, nlb, req->ns->id_ns.nsze)=
;
         return NVME_LBA_RANGE | NVME_DNR;
     }
=20
-    block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
-                     BLOCK_ACCT_WRITE);
-    req->aiocb =3D blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
-                                        BDRV_REQ_MAY_UNMAP, nvme_rw_cb, =
req);
+    blk_req =3D nvme_blk_req_get(n, req, NULL);
+    if (!blk_req) {
+        NVME_GUEST_ERR(nvme_err_internal_dev_error, "nvme_blk_req_get: %=
s",
+            "could not allocate memory");
+        return NVME_INTERNAL_DEV_ERROR;
+    }
+
+    block_acct_start(blk_get_stats(n->conf.blk), &blk_req->acct, 0,
+        BLOCK_ACCT_WRITE);
+
+    blk_req->aiocb =3D blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
+        BDRV_REQ_MAY_UNMAP, nvme_rw_cb, blk_req);
+
+    QTAILQ_INSERT_TAIL(&req->blk_req_tailq, blk_req, tailq_entry);
+
+    return NVME_NO_COMPLETE;
+}
+
+static uint16_t nvme_rw_check_req(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest=
 *req)
+{
+    NvmeNamespace *ns =3D req->ns;
+    NvmeRwCmd *rw =3D (NvmeRwCmd *) cmd;
+
+    uint16_t ctrl =3D le16_to_cpu(rw->control);
+    uint32_t data_size =3D req->nlb << nvme_ns_lbads(ns);
+
+    if (n->params.mdts && data_size > n->page_size * (1 << n->params.mdt=
s)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    if ((ctrl & NVME_RW_PRINFO_PRACT) && !(ns->id_ns.dps & DPS_TYPE_MASK=
)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static void nvme_blk_submit_dma(NvmeCtrl *n, NvmeBlockBackendRequest *bl=
k_req,
+    BlockCompletionFunc *cb)
+{
+    NvmeRequest *req =3D blk_req->req;
+
+    if (req->is_write) {
+        dma_acct_start(n->conf.blk, &blk_req->acct, &blk_req->qsg,
+            BLOCK_ACCT_WRITE);
+
+        blk_req->aiocb =3D dma_blk_write(n->conf.blk, &blk_req->qsg,
+            blk_req->blk_offset, BDRV_SECTOR_SIZE, cb, blk_req);
+    } else {
+        dma_acct_start(n->conf.blk, &blk_req->acct, &blk_req->qsg,
+            BLOCK_ACCT_READ);
+
+        blk_req->aiocb =3D dma_blk_read(n->conf.blk, &blk_req->qsg,
+            blk_req->blk_offset, BDRV_SECTOR_SIZE, cb, blk_req);
+    }
+}
+
+static void nvme_blk_submit_cmb(NvmeCtrl *n, NvmeBlockBackendRequest *bl=
k_req,
+    BlockCompletionFunc *cb)
+{
+    NvmeRequest *req =3D blk_req->req;
+
+    qemu_iovec_init(&blk_req->iov, blk_req->qsg.nsg);
+    dma_to_cmb(n, &blk_req->qsg, &blk_req->iov);
+
+    if (req->is_write) {
+        block_acct_start(blk_get_stats(n->conf.blk), &blk_req->acct,
+            blk_req->iov.size, BLOCK_ACCT_WRITE);
+
+        blk_req->aiocb =3D blk_aio_pwritev(n->conf.blk, blk_req->blk_off=
set,
+            &blk_req->iov, 0, cb, blk_req);
+    } else {
+        block_acct_start(blk_get_stats(n->conf.blk), &blk_req->acct,
+            blk_req->iov.size, BLOCK_ACCT_READ);
+
+        blk_req->aiocb =3D blk_aio_preadv(n->conf.blk, blk_req->blk_offs=
et,
+            &blk_req->iov, 0, cb, blk_req);
+    }
+}
+
+static uint16_t nvme_blk_submit_io(NvmeCtrl *n, NvmeRequest *req,
+    BlockCompletionFunc *cb)
+{
+    NvmeBlockBackendRequest *blk_req;
+
+    if (QTAILQ_EMPTY(&req->blk_req_tailq)) {
+        return NVME_SUCCESS;
+    }
+
+    QTAILQ_FOREACH(blk_req, &req->blk_req_tailq, tailq_entry) {
+        if (req->is_cmb) {
+            nvme_blk_submit_cmb(n, blk_req, cb);
+        } else {
+            nvme_blk_submit_dma(n, blk_req, cb);
+        }
+    }
+
     return NVME_NO_COMPLETE;
 }
=20
-static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
-    NvmeRequest *req)
+static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
     NvmeRwCmd *rw =3D (NvmeRwCmd *)cmd;
     uint32_t nlb  =3D le32_to_cpu(rw->nlb) + 1;
     uint64_t slba =3D le64_to_cpu(rw->slba);
-    uint64_t prp1 =3D le64_to_cpu(rw->prp1);
-    uint64_t prp2 =3D le64_to_cpu(rw->prp2);
=20
-    uint8_t lba_index  =3D NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
-    uint8_t data_shift =3D ns->id_ns.lbaf[lba_index].lbads;
-    uint64_t data_size =3D (uint64_t)nlb << data_shift;
-    uint64_t data_offset =3D ns->blk_offset + (slba << data_shift);
-    int is_write =3D rw->opcode =3D=3D NVME_CMD_WRITE ? 1 : 0;
-    enum BlockAcctType acct =3D is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT=
_READ;
+    req->is_write =3D nvme_rw_is_write(req);
=20
-    trace_nvme_rw(is_write ? "write" : "read", nlb, data_size, slba);
+    trace_nvme_rw(req->is_write ? "write" : "read", nlb,
+        nlb << nvme_ns_lbads(req->ns), slba);
=20
-    if (unlikely((slba + nlb) > ns->id_ns.nsze)) {
-        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
-        trace_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
-        return NVME_LBA_RANGE | NVME_DNR;
+    int err =3D nvme_blk_map(n, cmd, req);
+    if (err) {
+        return err;
     }
=20
-    if (nvme_map_prp(n, &req->qsg, prp1, prp2, data_size, req)) {
-        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
-        return NVME_INVALID_FIELD | NVME_DNR;
-    }
-
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
-    }
-
-    return NVME_NO_COMPLETE;
+    return nvme_blk_submit_io(n, req, nvme_rw_cb);
 }
=20
 static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
-    NvmeNamespace *ns;
+    NvmeRwCmd *rw;
+    int err;
+
     uint32_t nsid =3D le32_to_cpu(cmd->nsid);
=20
     if (unlikely(nsid =3D=3D 0 || nsid > n->params.num_ns)) {
@@ -562,15 +720,26 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *c=
md, NvmeRequest *req)
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
+        rw =3D (NvmeRwCmd *)cmd;
+
+        req->nlb  =3D le16_to_cpu(rw->nlb) + 1;
+        req->slba =3D le64_to_cpu(rw->slba);
+
+        err =3D nvme_rw_check_req(n, cmd, req);
+        if (err) {
+            return err;
+        }
+
+        return nvme_rw(n, cmd, req);
     default:
         trace_nvme_err_invalid_opc(cmd->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
@@ -595,6 +764,7 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd=
)
     NvmeRequest *req, *next;
     NvmeSQueue *sq;
     NvmeCQueue *cq;
+    NvmeBlockBackendRequest *blk_req;
     uint16_t qid =3D le16_to_cpu(c->qid);
=20
     if (unlikely(!qid || nvme_check_sqid(n, qid))) {
@@ -607,8 +777,11 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cm=
d)
     sq =3D n->sq[qid];
     while (!QTAILQ_EMPTY(&sq->out_req_list)) {
         req =3D QTAILQ_FIRST(&sq->out_req_list);
-        assert(req->aiocb);
-        blk_aio_cancel(req->aiocb);
+        while (!QTAILQ_EMPTY(&req->blk_req_tailq)) {
+            blk_req =3D QTAILQ_FIRST(&req->blk_req_tailq);
+            assert(blk_req->aiocb);
+            blk_aio_cancel(blk_req->aiocb);
+        }
     }
     if (!nvme_check_cqid(n, sq->cqid)) {
         cq =3D n->cq[sq->cqid];
@@ -645,6 +818,7 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n,=
 uint64_t dma_addr,
     QTAILQ_INIT(&sq->out_req_list);
     for (i =3D 0; i < sq->size; i++) {
         sq->io_req[i].sq =3D sq;
+        QTAILQ_INIT(&(sq->io_req[i].blk_req_tailq));
         QTAILQ_INSERT_TAIL(&(sq->req_list), &sq->io_req[i], entry);
     }
     sq->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_process_sq, sq);
@@ -1842,6 +2016,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     id->ieee[1] =3D 0x02;
     id->ieee[2] =3D 0xb3;
     id->cmic =3D 0;
+    id->mdts =3D params->mdts;
     id->ver =3D cpu_to_le32(0x00010300);
     id->oacs =3D cpu_to_le16(0);
     id->acl =3D 3;
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 05217257ca3f..711ca249eac5 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -7,12 +7,14 @@
     DEFINE_PROP_STRING("serial", _state, _props.serial), \
     DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
     DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64), \
-    DEFINE_PROP_UINT32("num_ns", _state, _props.num_ns, 1)
+    DEFINE_PROP_UINT32("num_ns", _state, _props.num_ns, 1), \
+    DEFINE_PROP_UINT8("mdts", _state, _props.mdts, 7)
=20
 typedef struct NvmeParams {
     char     *serial;
     uint32_t num_queues;
     uint32_t num_ns;
+    uint8_t  mdts;
     uint32_t cmb_size_mb;
 } NvmeParams;
=20
@@ -21,16 +23,36 @@ typedef struct NvmeAsyncEvent {
     NvmeAerResult result;
 } NvmeAsyncEvent;
=20
+typedef struct NvmeBlockBackendRequest {
+    uint64_t slba;
+    uint16_t nlb;
+    uint64_t blk_offset;
+
+    struct NvmeRequest *req;
+
+    BlockAIOCB      *aiocb;
+    BlockAcctCookie acct;
+
+    QEMUSGList   qsg;
+    QEMUIOVector iov;
+
+    QTAILQ_ENTRY(NvmeBlockBackendRequest) tailq_entry;
+    QSLIST_ENTRY(NvmeBlockBackendRequest) slist_entry;
+} NvmeBlockBackendRequest;
+
 typedef struct NvmeRequest {
-    struct NvmeSQueue       *sq;
-    BlockAIOCB              *aiocb;
-    uint16_t                status;
-    bool                    is_cmb;
-    uint8_t                 cmd_opcode;
-    NvmeCqe                 cqe;
-    BlockAcctCookie         acct;
-    QEMUSGList              qsg;
-    QEMUIOVector            iov;
+    struct NvmeSQueue    *sq;
+    struct NvmeNamespace *ns;
+    NvmeCqe              cqe;
+
+    uint64_t slba;
+    uint16_t nlb;
+    uint16_t status;
+    bool     is_cmb;
+    bool     is_write;
+    uint8_t  cmd_opcode;
+
+    QTAILQ_HEAD(, NvmeBlockBackendRequest) blk_req_tailq;
     QTAILQ_ENTRY(NvmeRequest)entry;
 } NvmeRequest;
=20
@@ -116,6 +138,11 @@ typedef struct NvmeCtrl {
     NvmeIdCtrl      id_ctrl;
 } NvmeCtrl;
=20
+static inline bool nvme_rw_is_write(NvmeRequest *req)
+{
+    return req->cmd_opcode =3D=3D NVME_CMD_WRITE;
+}
+
 static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
 {
     NvmeIdNs *id =3D &ns->id_ns;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 676a3a615c9d..56fec40d130c 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -37,6 +37,7 @@ nvme_irq_masked(void) "IRQ is masked"
 nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=3D0x%"PRIx64=
" prp2=3D0x%"PRIx64""
 nvme_map_prp(uint8_t cmd_opcode, uint64_t trans_len, uint32_t len, uint6=
4_t prp1, uint64_t prp2, int num_prps) "cmd_opcode=3D0x%"PRIx8", trans_le=
n=3D%"PRIu64", len=3D%"PRIu32", prp1=3D0x%"PRIx64", prp2=3D0x%"PRIx64", n=
um_prps=3D%d"
 nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint6=
4_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
+nvme_rw_cb(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
 nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsi=
ze, uint16_t qflags) "create submission queue, addr=3D0x%"PRIx64", sqid=3D=
%"PRIu16", cqid=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"PRIu16""
 nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t s=
ize, uint16_t qflags, int ien) "create completion queue, addr=3D0x%"PRIx6=
4", cqid=3D%"PRIu16", vector=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"P=
RIu16", ien=3D%d"
 nvme_del_sq(uint16_t qid) "deleting submission queue sqid=3D%"PRIu16""
@@ -115,6 +116,7 @@ nvme_err_startfail_sqent_too_large(uint8_t log2ps, ui=
nt8_t maxlog2ps) "nvme_star
 nvme_err_startfail_asqent_sz_zero(void) "nvme_start_ctrl failed because =
the admin submission queue size is zero"
 nvme_err_startfail_acqent_sz_zero(void) "nvme_start_ctrl failed because =
the admin completion queue size is zero"
 nvme_err_startfail(void) "setting controller enable bit failed"
+nvme_err_internal_dev_error(const char *reason) "%s"
=20
 # Traces for undefined behavior
 nvme_ub_mmiowr_misaligned32(uint64_t offset) "MMIO write not 32-bit alig=
ned, offset=3D0x%"PRIx64""
--=20
2.21.0



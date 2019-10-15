Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFA9C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB3F2089C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB3F2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKKWa-00039T-1V
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 06:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iKKF7-00083o-4c
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:39:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iKKF3-0006jE-Dp
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:39:52 -0400
Received: from charlie.dont.surf ([128.199.63.193]:54876)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1iKKEv-0006F0-QR; Tue, 15 Oct 2019 06:39:42 -0400
Received: from apples.localdomain (unknown [194.62.217.57])
 by charlie.dont.surf (Postfix) with ESMTPSA id 281DABF930;
 Tue, 15 Oct 2019 10:39:17 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v2 13/20] nvme: refactor prp mapping
Date: Tue, 15 Oct 2019 12:38:53 +0200
Message-Id: <20191015103900.313928-14-its@irrelevant.dk>
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

Instead of handling both QSGs and IOVs in multiple places, simply use
QSGs everywhere by assuming that the request does not involve the
controller memory buffer (CMB). If the request is found to involve the
CMB, convert the QSG to an IOV and issue the I/O. The QSG is converted
to an IOV by the dma helpers anyway, so the CMB path is not unfairly
affected by this simplifying change.

As a side-effect, this patch also allows PRPs to be located in the CMB.
The logic ensures that if some of the PRP is in the CMB, all of it must
be located there, as per the specification.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c       | 255 ++++++++++++++++++++++++++++--------------
 hw/block/nvme.h       |   4 +-
 hw/block/trace-events |   1 +
 include/block/nvme.h  |   1 +
 4 files changed, 174 insertions(+), 87 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 1e2320b38b14..cbc0b6a660b6 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -179,138 +179,200 @@ static void nvme_set_error_page(NvmeCtrl *n, uint=
16_t sqid, uint16_t cid,
     n->elp_index =3D (n->elp_index + 1) % n->params.elpe;
 }
=20
-static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_=
t prp1,
-                             uint64_t prp2, uint32_t len, NvmeCtrl *n)
+static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, uint64_t prp1=
,
+    uint64_t prp2, uint32_t len, NvmeRequest *req)
 {
     hwaddr trans_len =3D n->page_size - (prp1 % n->page_size);
     trans_len =3D MIN(len, trans_len);
     int num_prps =3D (len >> n->page_bits) + 1;
+    uint16_t status =3D NVME_SUCCESS;
+    bool prp_list_in_cmb =3D false;
+
+    trace_nvme_map_prp(req->cid, req->cmd.opcode, trans_len, len, prp1, =
prp2,
+        num_prps);
=20
     if (unlikely(!prp1)) {
         trace_nvme_err_invalid_prp();
         return NVME_INVALID_FIELD | NVME_DNR;
-    } else if (n->cmbsz && prp1 >=3D n->ctrl_mem.addr &&
-               prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size))=
 {
-        qsg->nsg =3D 0;
-        qemu_iovec_init(iov, num_prps);
-        qemu_iovec_add(iov, (void *)&n->cmbuf[prp1 - n->ctrl_mem.addr], =
trans_len);
-    } else {
-        pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
-        qemu_sglist_add(qsg, prp1, trans_len);
     }
+
+    if (nvme_addr_is_cmb(n, prp1)) {
+        req->is_cmb =3D true;
+    }
+
+    pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
+    qemu_sglist_add(qsg, prp1, trans_len);
+
     len -=3D trans_len;
     if (len) {
         if (unlikely(!prp2)) {
             trace_nvme_err_invalid_prp2_missing();
+            status =3D NVME_INVALID_FIELD | NVME_DNR;
             goto unmap;
         }
+
         if (len > n->page_size) {
             uint64_t prp_list[n->max_prp_ents];
             uint32_t nents, prp_trans;
             int i =3D 0;
=20
+            if (nvme_addr_is_cmb(n, prp2)) {
+                prp_list_in_cmb =3D true;
+            }
+
             nents =3D (len + n->page_size - 1) >> n->page_bits;
             prp_trans =3D MIN(n->max_prp_ents, nents) * sizeof(uint64_t)=
;
-            nvme_addr_read(n, prp2, (void *)prp_list, prp_trans);
+            nvme_addr_read(n, prp2, (void *) prp_list, prp_trans);
             while (len !=3D 0) {
+                bool addr_is_cmb;
                 uint64_t prp_ent =3D le64_to_cpu(prp_list[i]);
=20
                 if (i =3D=3D n->max_prp_ents - 1 && len > n->page_size) =
{
                     if (unlikely(!prp_ent || prp_ent & (n->page_size - 1=
))) {
                         trace_nvme_err_invalid_prplist_ent(prp_ent);
+                        status =3D NVME_INVALID_FIELD | NVME_DNR;
+                        goto unmap;
+                    }
+
+                    addr_is_cmb =3D nvme_addr_is_cmb(n, prp_ent);
+                    if ((prp_list_in_cmb && !addr_is_cmb) ||
+                        (!prp_list_in_cmb && addr_is_cmb)) {
+                        status =3D NVME_INVALID_USE_OF_CMB | NVME_DNR;
                         goto unmap;
                     }
=20
                     i =3D 0;
                     nents =3D (len + n->page_size - 1) >> n->page_bits;
                     prp_trans =3D MIN(n->max_prp_ents, nents) * sizeof(u=
int64_t);
-                    nvme_addr_read(n, prp_ent, (void *)prp_list,
-                        prp_trans);
+                    nvme_addr_read(n, prp_ent, (void *) prp_list, prp_tr=
ans);
                     prp_ent =3D le64_to_cpu(prp_list[i]);
                 }
=20
                 if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) =
{
                     trace_nvme_err_invalid_prplist_ent(prp_ent);
+                    status =3D NVME_INVALID_FIELD | NVME_DNR;
                     goto unmap;
                 }
=20
-                trans_len =3D MIN(len, n->page_size);
-                if (qsg->nsg){
-                    qemu_sglist_add(qsg, prp_ent, trans_len);
-                } else {
-                    qemu_iovec_add(iov, (void *)&n->cmbuf[prp_ent - n->c=
trl_mem.addr], trans_len);
+                addr_is_cmb =3D nvme_addr_is_cmb(n, prp_ent);
+                if ((req->is_cmb && !addr_is_cmb) ||
+                    (!req->is_cmb && addr_is_cmb)) {
+                    status =3D NVME_INVALID_USE_OF_CMB | NVME_DNR;
+                    goto unmap;
                 }
+
+                trans_len =3D MIN(len, n->page_size);
+                qemu_sglist_add(qsg, prp_ent, trans_len);
+
                 len -=3D trans_len;
                 i++;
             }
         } else {
+            bool addr_is_cmb =3D nvme_addr_is_cmb(n, prp2);
+            if ((req->is_cmb && !addr_is_cmb) ||
+                (!req->is_cmb && addr_is_cmb)) {
+                status =3D NVME_INVALID_USE_OF_CMB | NVME_DNR;
+                goto unmap;
+            }
+
             if (unlikely(prp2 & (n->page_size - 1))) {
                 trace_nvme_err_invalid_prp2_align(prp2);
+                status =3D NVME_INVALID_FIELD | NVME_DNR;
                 goto unmap;
             }
-            if (qsg->nsg) {
-                qemu_sglist_add(qsg, prp2, len);
-            } else {
-                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - n->ctrl_mem=
.addr], trans_len);
-            }
+
+            qemu_sglist_add(qsg, prp2, len);
         }
     }
+
     return NVME_SUCCESS;
=20
- unmap:
+unmap:
     qemu_sglist_destroy(qsg);
-    return NVME_INVALID_FIELD | NVME_DNR;
+
+    return status;
+}
+
+static void dma_to_cmb(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov)
+{
+    for (int i =3D 0; i < qsg->nsg; i++) {
+        void *addr =3D &n->cmbuf[qsg->sg[i].base - n->ctrl_mem.addr];
+        qemu_iovec_add(iov, addr, qsg->sg[i].len);
+    }
 }
=20
 static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t l=
en,
-                                   uint64_t prp1, uint64_t prp2)
+    uint64_t prp1, uint64_t prp2, NvmeRequest *req)
 {
     QEMUSGList qsg;
-    QEMUIOVector iov;
     uint16_t status =3D NVME_SUCCESS;
=20
-    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
-        return NVME_INVALID_FIELD | NVME_DNR;
+    status =3D nvme_map_prp(n, &qsg, prp1, prp2, len, req);
+    if (status) {
+        return status;
     }
-    if (qsg.nsg > 0) {
-        if (dma_buf_write(ptr, len, &qsg)) {
-            status =3D NVME_INVALID_FIELD | NVME_DNR;
-        }
-        qemu_sglist_destroy(&qsg);
-    } else {
-        if (qemu_iovec_to_buf(&iov, 0, ptr, len) !=3D len) {
+
+    if (req->is_cmb) {
+        QEMUIOVector iov;
+
+        qemu_iovec_init(&iov, qsg.nsg);
+        dma_to_cmb(n, &qsg, &iov);
+
+        if (unlikely(qemu_iovec_to_buf(&iov, 0, ptr, len) !=3D len)) {
+            trace_nvme_err_invalid_dma();
             status =3D NVME_INVALID_FIELD | NVME_DNR;
         }
+
         qemu_iovec_destroy(&iov);
+
+        return status;
+    }
+
+    if (unlikely(dma_buf_write(ptr, len, &qsg))) {
+        trace_nvme_err_invalid_dma();
+        status =3D NVME_INVALID_FIELD | NVME_DNR;
     }
+
+    qemu_sglist_destroy(&qsg);
+
     return status;
 }
=20
 static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t le=
n,
-    uint64_t prp1, uint64_t prp2)
+    uint64_t prp1, uint64_t prp2, NvmeRequest *req)
 {
     QEMUSGList qsg;
-    QEMUIOVector iov;
     uint16_t status =3D NVME_SUCCESS;
=20
-    trace_nvme_dma_read(prp1, prp2);
-
-    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
-        return NVME_INVALID_FIELD | NVME_DNR;
+    status =3D nvme_map_prp(n, &qsg, prp1, prp2, len, req);
+    if (status) {
+        return status;
     }
-    if (qsg.nsg > 0) {
-        if (unlikely(dma_buf_read(ptr, len, &qsg))) {
-            trace_nvme_err_invalid_dma();
-            status =3D NVME_INVALID_FIELD | NVME_DNR;
-        }
-        qemu_sglist_destroy(&qsg);
-    } else {
+
+    if (req->is_cmb) {
+        QEMUIOVector iov;
+
+        qemu_iovec_init(&iov, qsg.nsg);
+        dma_to_cmb(n, &qsg, &iov);
+
         if (unlikely(qemu_iovec_from_buf(&iov, 0, ptr, len) !=3D len)) {
             trace_nvme_err_invalid_dma();
             status =3D NVME_INVALID_FIELD | NVME_DNR;
         }
+
         qemu_iovec_destroy(&iov);
+
+        goto out;
     }
+
+    if (unlikely(dma_buf_read(ptr, len, &qsg))) {
+        trace_nvme_err_invalid_dma();
+        status =3D NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+out:
+    qemu_sglist_destroy(&qsg);
+
     return status;
 }
=20
@@ -400,6 +462,7 @@ static void nvme_rw_cb(void *opaque, int ret)
     NvmeSQueue *sq =3D req->sq;
     NvmeCtrl *n =3D sq->ctrl;
     NvmeCQueue *cq =3D n->cq[sq->cqid];
+    NvmeRwCmd *rw =3D (NvmeRwCmd *) &req->cmd;
=20
     if (!ret) {
         block_acct_done(blk_get_stats(n->conf.blk), &req->acct);
@@ -407,19 +470,23 @@ static void nvme_rw_cb(void *opaque, int ret)
     } else {
         block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
         nvme_set_error_page(n, sq->sqid, cpu_to_le16(req->cid),
-            NVME_INTERNAL_DEV_ERROR, 0, 0, 1);
+            NVME_INTERNAL_DEV_ERROR, offsetof(NvmeRwCmd, slba), rw->slba=
, 1);
         req->status =3D NVME_INTERNAL_DEV_ERROR | NVME_MORE;
     }
-    if (req->has_sg) {
+
+    if (req->qsg.nalloc) {
         qemu_sglist_destroy(&req->qsg);
     }
+    if (req->iov.nalloc) {
+        qemu_iovec_destroy(&req->iov);
+    }
+
     nvme_enqueue_req_completion(cq, req);
 }
=20
 static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     NvmeRequest *req)
 {
-    req->has_sg =3D false;
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
          BLOCK_ACCT_FLUSH);
     req->aiocb =3D blk_aio_flush(n->conf.blk, nvme_rw_cb, req);
@@ -443,7 +510,6 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNam=
espace *ns, NvmeCmd *cmd,
         return NVME_LBA_RANGE | NVME_DNR;
     }
=20
-    req->has_sg =3D false;
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
                      BLOCK_ACCT_WRITE);
     req->aiocb =3D blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
@@ -475,21 +541,21 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace =
*ns, NvmeCmd *cmd,
         return NVME_LBA_RANGE | NVME_DNR;
     }
=20
-    if (nvme_map_prp(&req->qsg, &req->iov, prp1, prp2, data_size, n)) {
+    if (nvme_map_prp(n, &req->qsg, prp1, prp2, data_size, req)) {
         block_acct_invalid(blk_get_stats(n->conf.blk), acct);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
=20
     dma_acct_start(n->conf.blk, &req->acct, &req->qsg, acct);
-    if (req->qsg.nsg > 0) {
-        req->has_sg =3D true;
+    if (!req->is_cmb) {
         req->aiocb =3D is_write ?
             dma_blk_write(n->conf.blk, &req->qsg, data_offset, BDRV_SECT=
OR_SIZE,
                           nvme_rw_cb, req) :
             dma_blk_read(n->conf.blk, &req->qsg, data_offset, BDRV_SECTO=
R_SIZE,
                          nvme_rw_cb, req);
     } else {
-        req->has_sg =3D false;
+        qemu_iovec_init(&req->iov, req->qsg.nsg);
+        dma_to_cmb(n, &req->qsg, &req->iov);
         req->aiocb =3D is_write ?
             blk_aio_pwritev(n->conf.blk, data_offset, &req->iov, 0, nvme=
_rw_cb,
                             req) :
@@ -587,7 +653,7 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n,=
 uint64_t dma_addr,
     sq->size =3D size;
     sq->cqid =3D cqid;
     sq->head =3D sq->tail =3D 0;
-    sq->io_req =3D g_new(NvmeRequest, sq->size);
+    sq->io_req =3D g_new0(NvmeRequest, sq->size);
=20
     QTAILQ_INIT(&sq->req_list);
     QTAILQ_INIT(&sq->out_req_list);
@@ -660,7 +726,7 @@ static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd =
*cmd, uint8_t rae,
     }
=20
     return nvme_dma_read_prp(n, (uint8_t *) n->elpes + off, trans_len, p=
rp1,
-        prp2);
+        prp2, req);
 }
=20
 static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
@@ -719,7 +785,7 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd =
*cmd, uint8_t rae,
     }
=20
     return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp=
1,
-        prp2);
+        prp2, req);
 }
=20
 static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf=
_len,
@@ -739,7 +805,7 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd=
 *cmd, uint32_t buf_len,
     trans_len =3D MIN(sizeof(fw_log) - off, buf_len);
=20
     return nvme_dma_read_prp(n, (uint8_t *) &fw_log + off, trans_len, pr=
p1,
-        prp2);
+        prp2, req);
 }
=20
 static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req=
)
@@ -875,7 +941,8 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *=
cmd)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c)
+static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c,
+    NvmeRequest *req)
 {
     uint64_t prp1 =3D le64_to_cpu(c->prp1);
     uint64_t prp2 =3D le64_to_cpu(c->prp2);
@@ -883,10 +950,11 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, Nvm=
eIdentify *c)
     trace_nvme_identify_ctrl();
=20
     return nvme_dma_read_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctr=
l),
-        prp1, prp2);
+        prp1, prp2, req);
 }
=20
-static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
+static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
+    NvmeRequest *req)
 {
     NvmeNamespace *ns;
     uint32_t nsid =3D le32_to_cpu(c->nsid);
@@ -903,10 +971,11 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeI=
dentify *c)
     ns =3D &n->namespaces[nsid - 1];
=20
     return nvme_dma_read_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns)=
,
-        prp1, prp2);
+        prp1, prp2, req);
 }
=20
-static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c)
+static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c,
+    NvmeRequest *req)
 {
     static const int data_len =3D 4 * KiB;
     uint32_t min_nsid =3D le32_to_cpu(c->nsid);
@@ -928,12 +997,13 @@ static uint16_t nvme_identify_ns_list(NvmeCtrl *n, =
NvmeIdentify *c)
             break;
         }
     }
-    ret =3D nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2);
+    ret =3D nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2, =
req);
     g_free(list);
     return ret;
 }
=20
-static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeCmd *c)
+static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c=
,
+    NvmeRequest *req)
 {
     static const int len =3D 4096;
=20
@@ -963,24 +1033,24 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCt=
rl *n, NvmeCmd *c)
     list->nidl =3D 0x10;
     *(uint32_t *) &list->nid[12] =3D cpu_to_be32(nsid);
=20
-    ret =3D nvme_dma_read_prp(n, (uint8_t *) list, len, prp1, prp2);
+    ret =3D nvme_dma_read_prp(n, (uint8_t *) list, len, prp1, prp2, req)=
;
     g_free(list);
     return ret;
 }
=20
-static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *re=
q)
 {
     NvmeIdentify *c =3D (NvmeIdentify *)cmd;
=20
     switch (le32_to_cpu(c->cns)) {
     case 0x00:
-        return nvme_identify_ns(n, c);
+        return nvme_identify_ns(n, c, req);
     case 0x01:
-        return nvme_identify_ctrl(n, c);
+        return nvme_identify_ctrl(n, c, req);
     case 0x02:
-        return nvme_identify_ns_list(n, c);
+        return nvme_identify_ns_list(n, c, req);
     case 0x03:
-        return nvme_identify_ns_descr_list(n, cmd);
+        return nvme_identify_ns_descr_list(n, c, req);
     default:
         trace_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1039,15 +1109,16 @@ static inline uint64_t nvme_get_timestamp(const N=
vmeCtrl *n)
     return cpu_to_le64(ts.all);
 }
=20
-static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
+    NvmeRequest *req)
 {
     uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
     uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
=20
     uint64_t timestamp =3D nvme_get_timestamp(n);
=20
-    return nvme_dma_read_prp(n, (uint8_t *)&timestamp,
-                                 sizeof(timestamp), prp1, prp2);
+    return nvme_dma_read_prp(n, (uint8_t *)&timestamp, sizeof(timestamp)=
,
+        prp1, prp2, req);
 }
=20
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
@@ -1081,7 +1152,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
         trace_nvme_getfeat_numq(result);
         break;
     case NVME_TIMESTAMP:
-        return nvme_get_feature_timestamp(n, cmd);
+        return nvme_get_feature_timestamp(n, cmd, req);
     case NVME_INTERRUPT_COALESCING:
         result =3D cpu_to_le32(n->features.int_coalescing);
         break;
@@ -1107,7 +1178,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
+    NvmeRequest *req)
 {
     uint16_t ret;
     uint64_t timestamp;
@@ -1115,7 +1187,7 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl=
 *n, NvmeCmd *cmd)
     uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
=20
     ret =3D nvme_dma_write_prp(n, (uint8_t *)&timestamp,
-                                sizeof(timestamp), prp1, prp2);
+                                sizeof(timestamp), prp1, prp2, req);
     if (ret !=3D NVME_SUCCESS) {
         return ret;
     }
@@ -1163,7 +1235,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
             ((n->params.num_queues - 2) << 16));
         break;
     case NVME_TIMESTAMP:
-        return nvme_set_feature_timestamp(n, cmd);
+        return nvme_set_feature_timestamp(n, cmd, req);
     case NVME_ASYNCHRONOUS_EVENT_CONF:
         n->features.async_config =3D dw11;
         break;
@@ -1212,7 +1284,7 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
     case NVME_ADM_CMD_CREATE_CQ:
         return nvme_create_cq(n, cmd);
     case NVME_ADM_CMD_IDENTIFY:
-        return nvme_identify(n, cmd);
+        return nvme_identify(n, cmd, req);
     case NVME_ADM_CMD_ABORT:
         return nvme_abort(n, cmd, req);
     case NVME_ADM_CMD_SET_FEATURES:
@@ -1273,6 +1345,18 @@ static void nvme_process_aers(void *opaque)
     }
 }
=20
+static void nvme_init_req(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+{
+    memset(&req->cqe, 0, sizeof(req->cqe));
+    req->cqe.cid =3D cmd->cid;
+    req->cid =3D le16_to_cpu(cmd->cid);
+
+    memcpy(&req->cmd, cmd, sizeof(NvmeCmd));
+    req->status =3D NVME_SUCCESS;
+    req->is_cmb =3D false;
+    req->is_write =3D false;
+}
+
 static void nvme_process_sq(void *opaque)
 {
     NvmeSQueue *sq =3D opaque;
@@ -1292,9 +1376,8 @@ static void nvme_process_sq(void *opaque)
         req =3D QTAILQ_FIRST(&sq->req_list);
         QTAILQ_REMOVE(&sq->req_list, req, entry);
         QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
-        memset(&req->cqe, 0, sizeof(req->cqe));
-        req->cqe.cid =3D cmd.cid;
-        req->cid =3D le16_to_cpu(cmd.cid);
+
+        nvme_init_req(n, &cmd, req);
=20
         status =3D sq->sqid ? nvme_io_cmd(n, &cmd, req) :
             nvme_admin_cmd(n, &cmd, req);
@@ -1815,7 +1898,7 @@ static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *p=
ci_dev)
=20
     NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
     NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 1);
-    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
+    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 1);
     NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
     NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
     NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 3f7bd627e824..add9ff335aa5 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -28,11 +28,13 @@ typedef struct NvmeRequest {
     BlockAIOCB              *aiocb;
     uint16_t                status;
     uint16_t                cid;
-    bool                    has_sg;
+    bool                    is_cmb;
+    bool                    is_write;
     NvmeCqe                 cqe;
     BlockAcctCookie         acct;
     QEMUSGList              qsg;
     QEMUIOVector            iov;
+    NvmeCmd                 cmd;
     QTAILQ_ENTRY(NvmeRequest)entry;
 } NvmeRequest;
=20
diff --git a/hw/block/trace-events b/hw/block/trace-events
index f62fa99dc2cd..e81bb3a64ed7 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -33,6 +33,7 @@ nvme_irq_msix(uint32_t vector) "raising MSI-X IRQ vecto=
r %u"
 nvme_irq_pin(void) "pulsing IRQ pin"
 nvme_irq_masked(void) "IRQ is masked"
 nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=3D0x%"PRIx64=
" prp2=3D0x%"PRIx64""
+nvme_map_prp(uint16_t cid, uint8_t opc, uint64_t trans_len, uint32_t len=
, uint64_t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" opc 0x%"PRIx=
8" trans_len %"PRIu64" len %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64" nu=
m_prps %d"
 nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint6=
4_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
 nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsi=
ze, uint16_t qflags) "create submission queue, addr=3D0x%"PRIx64", sqid=3D=
%"PRIu16", cqid=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"PRIu16""
 nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t s=
ize, uint16_t qflags, int ien) "create completion queue, addr=3D0x%"PRIx6=
4", cqid=3D%"PRIu16", vector=3D%"PRIu16", qsize=3D%"PRIu16", qflags=3D%"P=
RIu16", ien=3D%d"
diff --git a/include/block/nvme.h b/include/block/nvme.h
index f0f5728b5ec4..d4990db4fdf8 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -427,6 +427,7 @@ enum NvmeStatusCodes {
     NVME_CMD_ABORT_MISSING_FUSE =3D 0x000a,
     NVME_INVALID_NSID           =3D 0x000b,
     NVME_CMD_SEQ_ERROR          =3D 0x000c,
+    NVME_INVALID_USE_OF_CMB     =3D 0x0012,
     NVME_LBA_RANGE              =3D 0x0080,
     NVME_CAP_EXCEEDED           =3D 0x0081,
     NVME_NS_NOT_READY           =3D 0x0082,
--=20
2.23.0



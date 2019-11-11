Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FF6C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 12:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621FB2067B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 12:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621FB2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU91N-0000lA-H3
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 07:42:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iU8mA-0008HY-OT
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 07:26:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iU8m6-0003aq-FL
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 07:26:34 -0500
Received: from charlie.dont.surf ([128.199.63.193]:52254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1iU8lz-0003QE-57; Mon, 11 Nov 2019 07:26:23 -0500
Received: from apples.localdomain (unknown [194.62.217.57])
 by charlie.dont.surf (Postfix) with ESMTPSA id 197F3BFB10;
 Mon, 11 Nov 2019 12:26:02 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v3 15/21] nvme: add support for scatter gather lists
Date: Mon, 11 Nov 2019 13:25:39 +0100
Message-Id: <20191111122545.252478-16-its@irrelevant.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111122545.252478-1-its@irrelevant.dk>
References: <20191111122545.252478-1-its@irrelevant.dk>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Javier Gonzalez <javier@javigon.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Ross Lagerwall <ross.lagerwall@citrix.com>,
 Paul Durrant <Paul.Durrant@citrix.com>, Keith Busch <kbusch@kernel.org>,
 Stephen Bates <sbates@raithlin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For now, support the Data Block, Segment and Last Segment descriptor
types.

See NVM Express 1.3d, Section 4.4 ("Scatter Gather List (SGL)").

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
Acked-by: Fam Zheng <fam@euphon.net>
---
 block/nvme.c          |  18 +-
 hw/block/nvme.c       | 380 ++++++++++++++++++++++++++++++++++++------
 hw/block/trace-events |   3 +
 include/block/nvme.h  |  62 ++++++-
 4 files changed, 398 insertions(+), 65 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index d41c4bda6e39..521f521054d5 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -446,7 +446,7 @@ static void nvme_identify(BlockDriverState *bs, int n=
amespace, Error **errp)
         error_setg(errp, "Cannot map buffer for DMA");
         goto out;
     }
-    cmd.prp1 =3D cpu_to_le64(iova);
+    cmd.dptr.prp.prp1 =3D cpu_to_le64(iova);
=20
     if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
         error_setg(errp, "Failed to identify controller");
@@ -545,7 +545,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, E=
rror **errp)
     }
     cmd =3D (NvmeCmd) {
         .opcode =3D NVME_ADM_CMD_CREATE_CQ,
-        .prp1 =3D cpu_to_le64(q->cq.iova),
+        .dptr.prp.prp1 =3D cpu_to_le64(q->cq.iova),
         .cdw10 =3D cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
         .cdw11 =3D cpu_to_le32(0x3),
     };
@@ -556,7 +556,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, E=
rror **errp)
     }
     cmd =3D (NvmeCmd) {
         .opcode =3D NVME_ADM_CMD_CREATE_SQ,
-        .prp1 =3D cpu_to_le64(q->sq.iova),
+        .dptr.prp.prp1 =3D cpu_to_le64(q->sq.iova),
         .cdw10 =3D cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
         .cdw11 =3D cpu_to_le32(0x1 | (n << 16)),
     };
@@ -906,16 +906,16 @@ try_map:
     case 0:
         abort();
     case 1:
-        cmd->prp1 =3D pagelist[0];
-        cmd->prp2 =3D 0;
+        cmd->dptr.prp.prp1 =3D pagelist[0];
+        cmd->dptr.prp.prp2 =3D 0;
         break;
     case 2:
-        cmd->prp1 =3D pagelist[0];
-        cmd->prp2 =3D pagelist[1];
+        cmd->dptr.prp.prp1 =3D pagelist[0];
+        cmd->dptr.prp.prp2 =3D pagelist[1];
         break;
     default:
-        cmd->prp1 =3D pagelist[0];
-        cmd->prp2 =3D cpu_to_le64(req->prp_list_iova + sizeof(uint64_t))=
;
+        cmd->dptr.prp.prp1 =3D pagelist[0];
+        cmd->dptr.prp.prp2 =3D cpu_to_le64(req->prp_list_iova + sizeof(u=
int64_t));
         break;
     }
     trace_nvme_cmd_map_qiov(s, cmd, req, qiov, entries);
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 230f4277f6e5..06b2530aa06c 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -296,6 +296,198 @@ unmap:
     return status;
 }
=20
+static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
+    NvmeSglDescriptor *segment, uint64_t nsgld, uint32_t *len,
+    NvmeRequest *req)
+{
+    dma_addr_t addr, trans_len;
+
+    for (int i =3D 0; i < nsgld; i++) {
+        if (NVME_SGL_TYPE(segment[i].type) !=3D SGL_DESCR_TYPE_DATA_BLOC=
K) {
+            trace_nvme_err_invalid_sgl_descriptor(req->cid,
+                NVME_SGL_TYPE(segment[i].type));
+            return NVME_SGL_DESCRIPTOR_TYPE_INVALID | NVME_DNR;
+        }
+
+        if (*len =3D=3D 0) {
+            if (!NVME_CTRL_SGLS_EXCESS_LENGTH(n->id_ctrl.sgls)) {
+                trace_nvme_err_invalid_sgl_excess_length(req->cid);
+                return NVME_DATA_SGL_LENGTH_INVALID | NVME_DNR;
+            }
+
+            break;
+        }
+
+        addr =3D le64_to_cpu(segment[i].addr);
+        trans_len =3D MIN(*len, le64_to_cpu(segment[i].len));
+
+        if (nvme_addr_is_cmb(n, addr)) {
+            /*
+             * All data and metadata, if any, associated with a particul=
ar
+             * command shall be located in either the CMB or host memory=
. Thus,
+             * if an address if found to be in the CMB and we have alrea=
dy
+             * mapped data that is in host memory, the use is invalid.
+             */
+            if (!nvme_req_is_cmb(req) && qsg->size) {
+                return NVME_INVALID_USE_OF_CMB | NVME_DNR;
+            }
+
+            nvme_req_set_cmb(req);
+        } else {
+            /*
+             * Similarly, if the address does not reference the CMB, but=
 we
+             * have already established that the request has data or met=
adata
+             * in the CMB, the use is invalid.
+             */
+            if (nvme_req_is_cmb(req)) {
+                return NVME_INVALID_USE_OF_CMB | NVME_DNR;
+            }
+        }
+
+        qemu_sglist_add(qsg, addr, trans_len);
+
+        *len -=3D trans_len;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList *qsg,
+    NvmeSglDescriptor sgl, uint32_t len, NvmeRequest *req)
+{
+    const int MAX_NSGLD =3D 256;
+
+    NvmeSglDescriptor segment[MAX_NSGLD];
+    uint64_t nsgld;
+    uint16_t status;
+    bool sgl_in_cmb =3D false;
+    hwaddr addr =3D le64_to_cpu(sgl.addr);
+
+    trace_nvme_map_sgl(req->cid, NVME_SGL_TYPE(sgl.type), req->nlb, len)=
;
+
+    pci_dma_sglist_init(qsg, &n->parent_obj, 1);
+
+    /*
+     * If the entire transfer can be described with a single data block =
it can
+     * be mapped directly.
+     */
+    if (NVME_SGL_TYPE(sgl.type) =3D=3D SGL_DESCR_TYPE_DATA_BLOCK) {
+        status =3D nvme_map_sgl_data(n, qsg, &sgl, 1, &len, req);
+        if (status) {
+            goto unmap;
+        }
+
+        goto out;
+    }
+
+    /*
+     * If the segment is located in the CMB, the submission queue of the
+     * request must also reside there.
+     */
+    if (nvme_addr_is_cmb(n, addr)) {
+        if (!nvme_addr_is_cmb(n, req->sq->dma_addr)) {
+            return NVME_INVALID_USE_OF_CMB | NVME_DNR;
+        }
+
+        sgl_in_cmb =3D true;
+    }
+
+    while (NVME_SGL_TYPE(sgl.type) =3D=3D SGL_DESCR_TYPE_SEGMENT) {
+        bool addr_is_cmb;
+
+        nsgld =3D le64_to_cpu(sgl.len) / sizeof(NvmeSglDescriptor);
+
+        /* read the segment in chunks of 256 descriptors (4k) */
+        while (nsgld > MAX_NSGLD) {
+            nvme_addr_read(n, addr, segment, sizeof(segment));
+
+            status =3D nvme_map_sgl_data(n, qsg, segment, MAX_NSGLD, &le=
n, req);
+            if (status) {
+                goto unmap;
+            }
+
+            nsgld -=3D MAX_NSGLD;
+            addr +=3D MAX_NSGLD * sizeof(NvmeSglDescriptor);
+        }
+
+        nvme_addr_read(n, addr, segment, nsgld * sizeof(NvmeSglDescripto=
r));
+
+        sgl =3D segment[nsgld - 1];
+        addr =3D le64_to_cpu(sgl.addr);
+
+        /* an SGL is allowed to end with a Data Block in a regular Segme=
nt */
+        if (NVME_SGL_TYPE(sgl.type) =3D=3D SGL_DESCR_TYPE_DATA_BLOCK) {
+            status =3D nvme_map_sgl_data(n, qsg, segment, nsgld, &len, r=
eq);
+            if (status) {
+                goto unmap;
+            }
+
+            goto out;
+        }
+
+        /* do not map last descriptor */
+        status =3D nvme_map_sgl_data(n, qsg, segment, nsgld - 1, &len, r=
eq);
+        if (status) {
+            goto unmap;
+        }
+
+        /*
+         * If the next segment is in the CMB, make sure that the sgl was
+         * already located there.
+         */
+        addr_is_cmb =3D nvme_addr_is_cmb(n, addr);
+        if ((sgl_in_cmb && !addr_is_cmb) || (!sgl_in_cmb && addr_is_cmb)=
) {
+            status =3D NVME_INVALID_USE_OF_CMB | NVME_DNR;
+            goto unmap;
+        }
+    }
+
+    /*
+     * If the segment did not end with a Data Block or a Segment descrip=
tor, it
+     * must be a Last Segment descriptor.
+     */
+    if (NVME_SGL_TYPE(sgl.type) !=3D SGL_DESCR_TYPE_LAST_SEGMENT) {
+        trace_nvme_err_invalid_sgl_descriptor(req->cid,
+            NVME_SGL_TYPE(sgl.type));
+        return NVME_SGL_DESCRIPTOR_TYPE_INVALID | NVME_DNR;
+    }
+
+    nsgld =3D le64_to_cpu(sgl.len) / sizeof(NvmeSglDescriptor);
+
+    while (nsgld > MAX_NSGLD) {
+        nvme_addr_read(n, addr, segment, sizeof(segment));
+
+        status =3D nvme_map_sgl_data(n, qsg, segment, MAX_NSGLD, &len, r=
eq);
+        if (status) {
+            goto unmap;
+        }
+
+        nsgld -=3D MAX_NSGLD;
+        addr +=3D MAX_NSGLD * sizeof(NvmeSglDescriptor);
+    }
+
+    nvme_addr_read(n, addr, segment, nsgld * sizeof(NvmeSglDescriptor));
+
+    status =3D nvme_map_sgl_data(n, qsg, segment, nsgld, &len, req);
+    if (status) {
+        goto unmap;
+    }
+
+out:
+    /* if there is any residual left in len, the SGL was too short */
+    if (len) {
+        status =3D NVME_DATA_SGL_LENGTH_INVALID | NVME_DNR;
+        goto unmap;
+    }
+
+    return NVME_SUCCESS;
+
+unmap:
+    qemu_sglist_destroy(qsg);
+
+    return status;
+}
+
 static void dma_to_cmb(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov)
 {
     for (int i =3D 0; i < qsg->nsg; i++) {
@@ -341,6 +533,56 @@ static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint=
8_t *ptr, uint32_t len,
     return status;
 }
=20
+static uint16_t nvme_dma_write_sgl(NvmeCtrl *n, uint8_t *ptr, uint32_t l=
en,
+    NvmeSglDescriptor sgl, NvmeRequest *req)
+{
+    QEMUSGList qsg;
+    uint16_t err =3D NVME_SUCCESS;
+
+    err =3D nvme_map_sgl(n, &qsg, sgl, len, req);
+    if (err) {
+        return err;
+    }
+
+    if (nvme_req_is_cmb(req)) {
+        QEMUIOVector iov;
+
+        qemu_iovec_init(&iov, qsg.nsg);
+        dma_to_cmb(n, &qsg, &iov);
+
+        if (unlikely(qemu_iovec_to_buf(&iov, 0, ptr, len) !=3D len)) {
+            trace_nvme_err_invalid_dma();
+            err =3D NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        qemu_iovec_destroy(&iov);
+
+        return err;
+    }
+
+    if (unlikely(dma_buf_write(ptr, len, &qsg))) {
+        trace_nvme_err_invalid_dma();
+        err =3D NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    qemu_sglist_destroy(&qsg);
+
+    return err;
+}
+
+static uint16_t nvme_dma_write(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
+    NvmeCmd *cmd, NvmeRequest *req)
+{
+    if (NVME_CMD_FLAGS_PSDT(cmd->flags)) {
+        return nvme_dma_write_sgl(n, ptr, len, cmd->dptr.sgl, req);
+    }
+
+    uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp.prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp.prp2);
+
+    return nvme_dma_write_prp(n, ptr, len, prp1, prp2, req);
+}
+
 static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t le=
n,
     uint64_t prp1, uint64_t prp2, NvmeRequest *req)
 {
@@ -378,13 +620,68 @@ out:
     return status;
 }
=20
+static uint16_t nvme_dma_read_sgl(NvmeCtrl *n, uint8_t *ptr, uint32_t le=
n,
+    NvmeSglDescriptor sgl, NvmeCmd *cmd, NvmeRequest *req)
+{
+    QEMUSGList qsg;
+    uint16_t err =3D NVME_SUCCESS;
+
+    err =3D nvme_map_sgl(n, &qsg, sgl, len, req);
+    if (err) {
+        return err;
+    }
+
+    if (nvme_req_is_cmb(req)) {
+        QEMUIOVector iov;
+
+        qemu_iovec_init(&iov, qsg.nsg);
+        dma_to_cmb(n, &qsg, &iov);
+
+        if (unlikely(qemu_iovec_from_buf(&iov, 0, ptr, len) !=3D len)) {
+            trace_nvme_err_invalid_dma();
+            err =3D NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        qemu_iovec_destroy(&iov);
+
+        goto out;
+    }
+
+    if (unlikely(dma_buf_read(ptr, len, &qsg))) {
+        trace_nvme_err_invalid_dma();
+        err =3D NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+out:
+    qemu_sglist_destroy(&qsg);
+
+    return err;
+}
+
+static uint16_t nvme_dma_read(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
+    NvmeCmd *cmd, NvmeRequest *req)
+{
+    if (NVME_CMD_FLAGS_PSDT(cmd->flags)) {
+        return nvme_dma_read_sgl(n, ptr, len, cmd->dptr.sgl, cmd, req);
+    }
+
+    uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp.prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp.prp2);
+
+    return nvme_dma_read_prp(n, ptr, len, prp1, prp2, req);
+}
+
 static uint16_t nvme_map(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
-    NvmeNamespace *ns =3D req->ns;
+    uint32_t len =3D req->nlb << nvme_ns_lbads(req->ns);
+    uint64_t prp1, prp2;
+
+    if (NVME_CMD_FLAGS_PSDT(cmd->flags)) {
+        return nvme_map_sgl(n, &req->qsg, cmd->dptr.sgl, len, req);
+    }
=20
-    uint32_t len =3D req->nlb << nvme_ns_lbads(ns);
-    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
+    prp1 =3D le64_to_cpu(cmd->dptr.prp.prp1);
+    prp2 =3D le64_to_cpu(cmd->dptr.prp.prp2);
=20
     return nvme_map_prp(n, &req->qsg, prp1, prp2, len, req);
 }
@@ -975,8 +1272,6 @@ static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd=
 *cmd, uint8_t rae,
     uint32_t buf_len, uint64_t off, NvmeRequest *req)
 {
     uint32_t trans_len;
-    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
=20
     if (off > sizeof(*n->elpes) * (n->params.elpe + 1)) {
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -988,15 +1283,12 @@ static uint16_t nvme_error_info(NvmeCtrl *n, NvmeC=
md *cmd, uint8_t rae,
         nvme_clear_events(n, NVME_AER_TYPE_ERROR);
     }
=20
-    return nvme_dma_read_prp(n, (uint8_t *) n->elpes + off, trans_len, p=
rp1,
-        prp2, req);
+    return nvme_dma_read(n, (uint8_t *) n->elpes + off, trans_len, cmd, =
req);
 }
=20
 static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
     uint32_t buf_len, uint64_t off, NvmeRequest *req)
 {
-    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
     uint32_t nsid =3D le32_to_cpu(cmd->nsid);
=20
     uint32_t trans_len;
@@ -1046,16 +1338,13 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, Nvme=
Cmd *cmd, uint8_t rae,
         nvme_clear_events(n, NVME_AER_TYPE_SMART);
     }
=20
-    return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp=
1,
-        prp2, req);
+    return nvme_dma_read(n, (uint8_t *) &smart + off, trans_len, cmd, re=
q);
 }
=20
 static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf=
_len,
     uint64_t off, NvmeRequest *req)
 {
     uint32_t trans_len;
-    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
     NvmeFwSlotInfoLog fw_log;
=20
     if (off > sizeof(fw_log)) {
@@ -1066,8 +1355,7 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeC=
md *cmd, uint32_t buf_len,
=20
     trans_len =3D MIN(sizeof(fw_log) - off, buf_len);
=20
-    return nvme_dma_read_prp(n, (uint8_t *) &fw_log + off, trans_len, pr=
p1,
-        prp2, req);
+    return nvme_dma_read(n, (uint8_t *) &fw_log + off, trans_len, cmd, r=
eq);
 }
=20
 static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req=
)
@@ -1209,25 +1497,18 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeC=
md *cmd)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c,
-    NvmeRequest *req)
+static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeCmd *cmd, NvmeReques=
t *req)
 {
-    uint64_t prp1 =3D le64_to_cpu(c->prp1);
-    uint64_t prp2 =3D le64_to_cpu(c->prp2);
-
     trace_nvme_identify_ctrl();
=20
-    return nvme_dma_read_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctr=
l),
-        prp1, prp2, req);
+    return nvme_dma_read(n, (uint8_t *) &n->id_ctrl, sizeof(n->id_ctrl),=
 cmd,
+        req);
 }
=20
-static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
-    NvmeRequest *req)
+static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
 {
     NvmeNamespace *ns;
-    uint32_t nsid =3D le32_to_cpu(c->nsid);
-    uint64_t prp1 =3D le64_to_cpu(c->prp1);
-    uint64_t prp2 =3D le64_to_cpu(c->prp2);
+    uint32_t nsid =3D le32_to_cpu(cmd->nsid);
=20
     trace_nvme_identify_ns(nsid);
=20
@@ -1238,17 +1519,15 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, Nvm=
eIdentify *c,
=20
     ns =3D &n->namespaces[nsid - 1];
=20
-    return nvme_dma_read_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns)=
,
-        prp1, prp2, req);
+    return nvme_dma_read(n, (uint8_t *) &ns->id_ns, sizeof(ns->id_ns), c=
md,
+        req);
 }
=20
-static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c,
+static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeCmd *cmd,
     NvmeRequest *req)
 {
     static const int data_len =3D 4 * KiB;
-    uint32_t min_nsid =3D le32_to_cpu(c->nsid);
-    uint64_t prp1 =3D le64_to_cpu(c->prp1);
-    uint64_t prp2 =3D le64_to_cpu(c->prp2);
+    uint32_t min_nsid =3D le32_to_cpu(cmd->nsid);
     uint32_t *list;
     uint16_t ret;
     int i, j =3D 0;
@@ -1265,12 +1544,12 @@ static uint16_t nvme_identify_ns_list(NvmeCtrl *n=
, NvmeIdentify *c,
             break;
         }
     }
-    ret =3D nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2, =
req);
+    ret =3D nvme_dma_read(n, (uint8_t *) list, data_len, cmd, req);
     g_free(list);
     return ret;
 }
=20
-static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c=
,
+static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeCmd *cmd,
     NvmeRequest *req)
 {
     static const int len =3D 4096;
@@ -1282,9 +1561,7 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtr=
l *n, NvmeIdentify *c,
         uint8_t nid[16];
     };
=20
-    uint32_t nsid =3D le32_to_cpu(c->nsid);
-    uint64_t prp1 =3D le64_to_cpu(c->prp1);
-    uint64_t prp2 =3D le64_to_cpu(c->prp2);
+    uint32_t nsid =3D le32_to_cpu(cmd->nsid);
=20
     struct ns_descr *list;
     uint16_t ret;
@@ -1301,7 +1578,7 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtr=
l *n, NvmeIdentify *c,
     list->nidl =3D 0x10;
     *(uint32_t *) &list->nid[12] =3D cpu_to_be32(nsid);
=20
-    ret =3D nvme_dma_read_prp(n, (uint8_t *) list, len, prp1, prp2, req)=
;
+    ret =3D nvme_dma_read(n, (uint8_t *) list, len, cmd, req);
     g_free(list);
     return ret;
 }
@@ -1312,13 +1589,13 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
=20
     switch (le32_to_cpu(c->cns)) {
     case 0x00:
-        return nvme_identify_ns(n, c, req);
+        return nvme_identify_ns(n, cmd, req);
     case 0x01:
-        return nvme_identify_ctrl(n, c, req);
+        return nvme_identify_ctrl(n, cmd, req);
     case 0x02:
-        return nvme_identify_ns_list(n, c, req);
+        return nvme_identify_ns_list(n, cmd, req);
     case 0x03:
-        return nvme_identify_ns_descr_list(n, c, req);
+        return nvme_identify_ns_descr_list(n, cmd, req);
     default:
         trace_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1380,13 +1657,10 @@ static inline uint64_t nvme_get_timestamp(const N=
vmeCtrl *n)
 static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
     NvmeRequest *req)
 {
-    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
-
     uint64_t timestamp =3D nvme_get_timestamp(n);
=20
-    return nvme_dma_read_prp(n, (uint8_t *)&timestamp, sizeof(timestamp)=
,
-        prp1, prp2, req);
+    return nvme_dma_read(n, (uint8_t *)&timestamp, sizeof(timestamp), cm=
d,
+        req);
 }
=20
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
@@ -1451,11 +1725,9 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtr=
l *n, NvmeCmd *cmd,
 {
     uint16_t ret;
     uint64_t timestamp;
-    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
=20
-    ret =3D nvme_dma_write_prp(n, (uint8_t *)&timestamp,
-                                sizeof(timestamp), prp1, prp2, req);
+    ret =3D nvme_dma_write(n, (uint8_t *)&timestamp, sizeof(timestamp), =
cmd,
+        req);
     if (ret !=3D NVME_SUCCESS) {
         return ret;
     }
@@ -2240,6 +2512,8 @@ static void nvme_init_ctrl(NvmeCtrl *n)
         id->vwc =3D 1;
     }
=20
+    id->sgls =3D cpu_to_le32(0x1);
+
     strcpy((char *) id->subnqn, "nqn.2019-08.org.qemu:");
     pstrcat((char *) id->subnqn, sizeof(id->subnqn), n->params.serial);
=20
diff --git a/hw/block/trace-events b/hw/block/trace-events
index c7e0a1849043..59d42a3b8c39 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -34,6 +34,7 @@ nvme_irq_pin(void) "pulsing IRQ pin"
 nvme_irq_masked(void) "IRQ is masked"
 nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=3D0x%"PRIx64=
" prp2=3D0x%"PRIx64""
 nvme_map_prp(uint16_t cid, uint8_t opc, uint64_t trans_len, uint32_t len=
, uint64_t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" opc 0x%"PRIx=
8" trans_len %"PRIu64" len %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64" nu=
m_prps %d"
+nvme_map_sgl(uint16_t cid, uint8_t typ, uint32_t nlb, uint64_t len) "cid=
 %"PRIu16" type 0x%"PRIx8" nlb %"PRIu32" len %"PRIu64""
 nvme_req_register_aio(uint16_t cid, void *aio, const char *blkname, uint=
64_t offset, uint64_t count, const char *opc, void *req) "cid %"PRIu16" a=
io %p blk \"%s\" offset %"PRIu64" count %"PRIu64" opc \"%s\" req %p"
 nvme_aio_cb(uint16_t cid, void *aio, const char *blkname, uint64_t offse=
t, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offset %"=
PRIu64" opc \"%s\" req %p"
 nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode) =
"cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
@@ -82,6 +83,8 @@ nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
 nvme_err_mdts(uint16_t cid, size_t mdts, size_t len) "cid %"PRIu16" mdts=
 %"PRIu64" len %"PRIu64""
 nvme_err_prinfo(uint16_t cid, uint16_t ctrl) "cid %"PRIu16" ctrl %"PRIu1=
6""
 nvme_err_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offs=
et, const char *opc, void *req, uint16_t status) "cid %"PRIu16" aio %p bl=
k \"%s\" offset %"PRIu64" opc \"%s\" req %p status 0x%"PRIx16""
+nvme_err_invalid_sgl_descriptor(uint16_t cid, uint8_t typ) "cid %"PRIu16=
" type 0x%"PRIx8""
+nvme_err_invalid_sgl_excess_length(uint16_t cid) "cid %"PRIu16""
 nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
 nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null o=
r not page aligned: 0x%"PRIx64""
 nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x=
%"PRIx64""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 2aaa45e20566..418dadf3c5c6 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -205,15 +205,53 @@ enum NvmeCmbszMask {
 #define NVME_CMBSZ_GETSIZE(cmbsz) \
     (NVME_CMBSZ_SZ(cmbsz) * (1 << (12 + 4 * NVME_CMBSZ_SZU(cmbsz))))
=20
+enum NvmeSglDescriptorType {
+    SGL_DESCR_TYPE_DATA_BLOCK           =3D 0x0,
+    SGL_DESCR_TYPE_BIT_BUCKET           =3D 0x1,
+    SGL_DESCR_TYPE_SEGMENT              =3D 0x2,
+    SGL_DESCR_TYPE_LAST_SEGMENT         =3D 0x3,
+    SGL_DESCR_TYPE_KEYED_DATA_BLOCK     =3D 0x4,
+
+    SGL_DESCR_TYPE_VENDOR_SPECIFIC      =3D 0xf,
+};
+
+enum NvmeSglDescriptorSubtype {
+    SGL_DESCR_SUBTYPE_ADDRESS =3D 0x0,
+    SGL_DESCR_SUBTYPE_OFFSET  =3D 0x1,
+};
+
+typedef struct NvmeSglDescriptor {
+    uint64_t addr;
+    uint32_t len;
+    uint8_t  rsvd[3];
+    uint8_t  type;
+} NvmeSglDescriptor;
+
+#define NVME_SGL_TYPE(type)     (type >> 4)
+
+typedef union NvmeCmdDptr {
+    struct {
+        uint64_t    prp1;
+        uint64_t    prp2;
+    } prp;
+
+    NvmeSglDescriptor sgl;
+} NvmeCmdDptr;
+
+enum NvmePsdt {
+    PSDT_PRP                 =3D 0x0,
+    PSDT_SGL_MPTR_CONTIGUOUS =3D 0x1,
+    PSDT_SGL_MPTR_SGL        =3D 0x2,
+};
+
 typedef struct NvmeCmd {
     uint8_t     opcode;
-    uint8_t     fuse;
+    uint8_t     flags;
     uint16_t    cid;
     uint32_t    nsid;
     uint64_t    res1;
     uint64_t    mptr;
-    uint64_t    prp1;
-    uint64_t    prp2;
+    NvmeCmdDptr dptr;
     uint32_t    cdw10;
     uint32_t    cdw11;
     uint32_t    cdw12;
@@ -222,6 +260,9 @@ typedef struct NvmeCmd {
     uint32_t    cdw15;
 } NvmeCmd;
=20
+#define NVME_CMD_FLAGS_FUSE(flags) (flags & 0x3)
+#define NVME_CMD_FLAGS_PSDT(flags) ((flags >> 6) & 0x3)
+
 enum NvmeAdminCommands {
     NVME_ADM_CMD_DELETE_SQ      =3D 0x00,
     NVME_ADM_CMD_CREATE_SQ      =3D 0x01,
@@ -427,6 +468,11 @@ enum NvmeStatusCodes {
     NVME_CMD_ABORT_MISSING_FUSE =3D 0x000a,
     NVME_INVALID_NSID           =3D 0x000b,
     NVME_CMD_SEQ_ERROR          =3D 0x000c,
+    NVME_INVALID_SGL_SEG_DESCRIPTOR  =3D 0x000d,
+    NVME_INVALID_NUM_SGL_DESCRIPTORS =3D 0x000e,
+    NVME_DATA_SGL_LENGTH_INVALID     =3D 0x000f,
+    NVME_METADATA_SGL_LENGTH_INVALID =3D 0x0010,
+    NVME_SGL_DESCRIPTOR_TYPE_INVALID =3D 0x0011,
     NVME_INVALID_USE_OF_CMB     =3D 0x0012,
     NVME_LBA_RANGE              =3D 0x0080,
     NVME_CAP_EXCEEDED           =3D 0x0081,
@@ -623,6 +669,16 @@ enum NvmeIdCtrlOncs {
 #define NVME_CTRL_CQES_MIN(cqes) ((cqes) & 0xf)
 #define NVME_CTRL_CQES_MAX(cqes) (((cqes) >> 4) & 0xf)
=20
+#define NVME_CTRL_SGLS_SUPPORTED(sgls)                 ((sgls) & 0x3)
+#define NVME_CTRL_SGLS_SUPPORTED_NO_ALIGNMENT(sgls)    ((sgls) & (0x1 <<=
  0))
+#define NVME_CTRL_SGLS_SUPPORTED_DWORD_ALIGNMENT(sgls) ((sgls) & (0x1 <<=
  1))
+#define NVME_CTRL_SGLS_KEYED(sgls)                     ((sgls) & (0x1 <<=
  2))
+#define NVME_CTRL_SGLS_BITBUCKET(sgls)                 ((sgls) & (0x1 <<=
 16))
+#define NVME_CTRL_SGLS_MPTR_CONTIGUOUS(sgls)           ((sgls) & (0x1 <<=
 17))
+#define NVME_CTRL_SGLS_EXCESS_LENGTH(sgls)             ((sgls) & (0x1 <<=
 18))
+#define NVME_CTRL_SGLS_MPTR_SGL(sgls)                  ((sgls) & (0x1 <<=
 19))
+#define NVME_CTRL_SGLS_ADDR_OFFSET(sgls)               ((sgls) & (0x1 <<=
 20))
+
 typedef struct NvmeFeatureVal {
     uint32_t    arbitration;
     uint32_t    power_mgmt;
--=20
2.24.0



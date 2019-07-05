Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E940C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:36:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9223218BC
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9223218BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjIlM-0001zJ-4C
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 03:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44406)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <klaus@birkelund.eu>) id 1hjIaA-0005g3-E7
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <klaus@birkelund.eu>) id 1hjIa4-00066e-Q0
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:24:32 -0400
Received: from charlie.dont.surf ([128.199.63.193]:50550)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <klaus@birkelund.eu>)
 id 1hjIZr-0005jA-NY; Fri, 05 Jul 2019 03:24:16 -0400
Received: from localhost.localdomain (ip-5-186-120-196.cgn.fibianet.dk
 [5.186.120.196])
 by charlie.dont.surf (Postfix) with ESMTPSA id 9172DC0653;
 Fri,  5 Jul 2019 07:23:54 +0000 (UTC)
From: Klaus Birkelund Jensen <klaus@birkelund.eu>
To: qemu-block@nongnu.org
Date: Fri,  5 Jul 2019 09:23:32 +0200
Message-Id: <20190705072333.17171-16-klaus@birkelund.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705072333.17171-1-klaus@birkelund.eu>
References: <20190705072333.17171-1-klaus@birkelund.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: [Qemu-devel] [PATCH 15/16] nvme: support scatter gather lists
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
Cc: kwolf@redhat.com, matt.fitzpatrick@oakgatetech.com, qemu-devel@nongnu.org,
 armbru@redhat.com, keith.busch@intel.com, mreitz@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For now, support the Data Block, Segment and Last Segment descriptor
types.

See NVM Express 1.3d, Section 4.4 ("Scatter Gather List (SGL)").

Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
---
 block/nvme.c          |  18 +-
 hw/block/nvme.c       | 390 +++++++++++++++++++++++++++++++++++-------
 hw/block/nvme.h       |   6 +
 hw/block/trace-events |   3 +
 include/block/nvme.h  |  64 ++++++-
 5 files changed, 410 insertions(+), 71 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 73ed5fa75f2e..907a610633f2 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -438,7 +438,7 @@ static void nvme_identify(BlockDriverState *bs, int n=
amespace, Error **errp)
         error_setg(errp, "Cannot map buffer for DMA");
         goto out;
     }
-    cmd.prp1 =3D cpu_to_le64(iova);
+    cmd.dptr.prp.prp1 =3D cpu_to_le64(iova);
=20
     if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
         error_setg(errp, "Failed to identify controller");
@@ -512,7 +512,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, E=
rror **errp)
     }
     cmd =3D (NvmeCmd) {
         .opcode =3D NVME_ADM_CMD_CREATE_CQ,
-        .prp1 =3D cpu_to_le64(q->cq.iova),
+        .dptr.prp.prp1 =3D cpu_to_le64(q->cq.iova),
         .cdw10 =3D cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
         .cdw11 =3D cpu_to_le32(0x3),
     };
@@ -523,7 +523,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, E=
rror **errp)
     }
     cmd =3D (NvmeCmd) {
         .opcode =3D NVME_ADM_CMD_CREATE_SQ,
-        .prp1 =3D cpu_to_le64(q->sq.iova),
+        .dptr.prp.prp1 =3D cpu_to_le64(q->sq.iova),
         .cdw10 =3D cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
         .cdw11 =3D cpu_to_le32(0x1 | (n << 16)),
     };
@@ -858,16 +858,16 @@ try_map:
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
index b285119fd29a..6bf62952dd13 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -273,6 +273,198 @@ unmap:
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
+            trace_nvme_err_invalid_sgl_descriptor(req->cqe.cid,
+                NVME_SGL_TYPE(segment[i].type));
+            return NVME_SGL_DESCRIPTOR_TYPE_INVALID | NVME_DNR;
+        }
+
+        if (*len =3D=3D 0) {
+            if (!NVME_CTRL_SGLS_EXCESS_LENGTH(n->id_ctrl.sgls)) {
+                trace_nvme_err_invalid_sgl_excess_length(req->cqe.cid);
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
+            if (!req->is_cmb && qsg->size) {
+                return NVME_INVALID_USE_OF_CMB | NVME_DNR;
+            }
+
+            req->is_cmb =3D true;
+        } else {
+            /*
+             * Similarly, if the address does not reference the CMB, but=
 we
+             * have already established that the request has data or met=
adata
+             * in the CMB, the use is invalid.
+             */
+            if (req->is_cmb) {
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
+    trace_nvme_map_sgl(req->cqe.cid, NVME_SGL_TYPE(sgl.type), req->nlb, =
len);
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
+        trace_nvme_err_invalid_sgl_descriptor(req->cqe.cid,
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
@@ -318,6 +510,56 @@ static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint=
8_t *ptr, uint32_t len,
     return err;
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
+    if (req->is_cmb) {
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
@@ -355,6 +597,57 @@ out:
     return err;
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
+    if (req->is_cmb) {
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
 static void nvme_blk_req_destroy(NvmeBlockBackendRequest *blk_req)
 {
     if (blk_req->iov.nalloc) {
@@ -408,20 +701,25 @@ static uint16_t nvme_blk_map(NvmeCtrl *n, NvmeCmd *=
cmd, NvmeRequest *req)
     uint16_t err;
=20
     uint32_t len =3D req->nlb * nvme_ns_lbads_bytes(ns);
-    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
=20
-    err =3D nvme_map_prp(n, &req->qsg, prp1, prp2, len, req);
-    if (err) {
-        return err;
+    if (NVME_CMD_FLAGS_PSDT(cmd->flags)) {
+        err =3D nvme_map_sgl(n, &req->qsg, cmd->dptr.sgl, len, req);
+        if (err) {
+            return err;
+        }
+    } else {
+        uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp.prp1);
+        uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp.prp2);
+
+        err =3D nvme_map_prp(n, &req->qsg, prp1, prp2, len, req);
+        if (err) {
+            return err;
+        }
     }
=20
     err =3D nvme_blk_setup(n, ns, &req->qsg, req);
-    if (err) {
-        return err;
-    }
=20
-    return NVME_SUCCESS;
+    return err;
 }
=20
 static void nvme_post_cqes(void *opaque)
@@ -984,25 +1282,18 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCm=
d *cmd)
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
@@ -1013,17 +1304,15 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, Nvm=
eIdentify *c,
=20
     ns =3D &n->namespace;
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
@@ -1040,12 +1329,12 @@ static uint16_t nvme_identify_ns_list(NvmeCtrl *n=
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
-static uint16_t nvme_identify_ns_descriptor_list(NvmeCtrl *n, NvmeCmd *c=
,
+static uint16_t nvme_identify_ns_descriptor_list(NvmeCtrl *n, NvmeCmd *c=
md,
     NvmeRequest *req)
 {
     static const int data_len =3D 4 * KiB;
@@ -1063,9 +1352,7 @@ static uint16_t nvme_identify_ns_descriptor_list(Nv=
meCtrl *n, NvmeCmd *c,
         uint32_t nid;
     };
=20
-    uint32_t nsid =3D le32_to_cpu(c->nsid);
-    uint64_t prp1 =3D le64_to_cpu(c->prp1);
-    uint64_t prp2 =3D le64_to_cpu(c->prp2);
+    uint32_t nsid =3D le32_to_cpu(cmd->nsid);
=20
     struct ns_descr *list;
     uint16_t ret;
@@ -1082,7 +1369,7 @@ static uint16_t nvme_identify_ns_descriptor_list(Nv=
meCtrl *n, NvmeCmd *c,
     list->nidl =3D 0x10;
     list->nid =3D cpu_to_be32(nsid);
=20
-    ret =3D nvme_dma_read_prp(n, (uint8_t *) list, data_len, prp1, prp2,=
 req);
+    ret =3D nvme_dma_read(n, (uint8_t *) list, data_len, cmd, req);
     g_free(list);
     return ret;
 }
@@ -1093,11 +1380,11 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCm=
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
         return nvme_identify_ns_descriptor_list(n, cmd, req);
     default:
@@ -1149,13 +1436,10 @@ static inline uint64_t nvme_get_timestamp(const N=
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
@@ -1220,11 +1504,9 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtr=
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
@@ -1301,8 +1583,6 @@ static uint16_t nvme_error_log_info(NvmeCtrl *n, Nv=
meCmd *cmd, uint8_t rae,
     uint32_t buf_len, uint64_t off, NvmeRequest *req)
 {
     uint32_t trans_len;
-    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
=20
     if (off > sizeof(*n->elpes) * (NVME_ELPE + 1)) {
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1314,16 +1594,12 @@ static uint16_t nvme_error_log_info(NvmeCtrl *n, =
NvmeCmd *cmd, uint8_t rae,
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
-
     uint32_t trans_len;
     time_t current_ms;
     NvmeSmartLog smart;
@@ -1357,16 +1633,13 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, Nvme=
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
@@ -1377,8 +1650,7 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeC=
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
=20
@@ -2137,6 +2409,8 @@ static void nvme_init_ctrl(NvmeCtrl *n)
         id->vwc =3D 1;
     }
=20
+    id->sgls =3D cpu_to_le32(0x1);
+
     strcpy((char *) id->subnqn, "nqn.2014-08.org.nvmexpress:uuid:");
     qemu_uuid_unparse(&qemu_uuid,
         (char *) id->subnqn + strlen((char *) id->subnqn));
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 832094f77845..1d52b183d263 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -142,6 +142,12 @@ static inline bool nvme_rw_is_write(NvmeRequest *req=
)
     return req->cmd.opcode =3D=3D NVME_CMD_WRITE;
 }
=20
+static inline bool nvme_is_error(uint16_t status, uint16_t err)
+{
+    /* strip DNR and MORE */
+    return (status & 0xfff) =3D=3D err;
+}
+
 static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
 {
     NvmeIdNs *id =3D &ns->id_ns;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index b324751ad990..b239e92294e4 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -34,6 +34,7 @@ nvme_irq_pin(void) "pulsing IRQ pin"
 nvme_irq_masked(void) "IRQ is masked"
 nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=3D0x%"PRIx64=
" prp2=3D0x%"PRIx64""
 nvme_map_prp(uint8_t cmd_opcode, uint64_t trans_len, uint32_t len, uint6=
4_t prp1, uint64_t prp2, int num_prps) "cmd_opcode=3D0x%"PRIx8", trans_le=
n=3D%"PRIu64", len=3D%"PRIu32", prp1=3D0x%"PRIx64", prp2=3D0x%"PRIx64", n=
um_prps=3D%d"
+nvme_map_sgl(uint16_t cid, uint8_t typ, uint16_t nlb, uint64_t len) "cid=
 %"PRIu16" type 0x%"PRIx8" nlb %"PRIu16" len %"PRIu64""
 nvme_io_cmd(uint16_t cid, uint32_t nsid, uint8_t opcode) "cid %"PRIu16" =
nsid %"PRIu32" opc %"PRIu8""
 nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint6=
4_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
 nvme_rw_cb(uint16_t cid, uint32_t nsid) "cid %"PRIu16" nsid %"PRIu32""
@@ -76,6 +77,8 @@ nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
=20
 # nvme traces for error conditions
 nvme_err(uint16_t cid, const char *s, uint16_t status) "cid %"PRIu16" \"=
%s\" status 0x%"PRIx16""
+nvme_err_invalid_sgl_descriptor(uint16_t cid, uint8_t typ) "cid %"PRIu16=
" type 0x%"PRIx8""
+nvme_err_invalid_sgl_excess_length(uint16_t cid) "cid %"PRIu16""
 nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
 nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null o=
r not page aligned: 0x%"PRIx64""
 nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x=
%"PRIx64""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index a6ef8d8ff25a..f79c71ba3f8c 100644
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
-    uint64_t    res1;
+    uint64_t    rsvd2;
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
2.20.1



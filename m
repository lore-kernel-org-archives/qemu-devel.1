Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD697C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C9E2051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C9E2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtBC-0003AQ-J4
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDqld-0000dC-Kr
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDqlZ-000743-Ns
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:30:57 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48838)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDqlQ-0003sA-Uc; Mon, 16 Mar 2020 10:30:45 -0400
Received: from apples.local (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id B0D19BFA80;
 Mon, 16 Mar 2020 14:29:53 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v6 36/42] nvme: add support for scatter gather lists
Date: Mon, 16 Mar 2020 07:29:22 -0700
Message-Id: <20200316142928.153431-37-its@irrelevant.dk>
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

For now, support the Data Block, Segment and Last Segment descriptor
types.

See NVM Express 1.3d, Section 4.4 ("Scatter Gather List (SGL)").

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
Acked-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c       | 310 +++++++++++++++++++++++++++++++++++-------
 hw/block/trace-events |   4 +
 2 files changed, 262 insertions(+), 52 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 49d323566393..b89b96990f52 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -76,7 +76,12 @@ static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwadd=
r addr)
=20
 static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 {
-    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
+    hwaddr hi =3D addr + size;
+    if (hi < addr) {
+        return 1;
+    }
+
+    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr) && nvme_addr_is_cmb(n,=
 hi)) {
         memcpy(buf, nvme_addr_to_cmb(n, addr), size);
         return 0;
     }
@@ -328,13 +333,242 @@ unmap:
     return status;
 }
=20
-static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
-                             uint64_t prp1, uint64_t prp2, DMADirection =
dir,
+static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
+                                  QEMUIOVector *iov,
+                                  NvmeSglDescriptor *segment, uint64_t n=
sgld,
+                                  size_t *len, NvmeRequest *req)
+{
+    dma_addr_t addr, trans_len;
+    uint32_t blk_len;
+    uint16_t status;
+
+    for (int i =3D 0; i < nsgld; i++) {
+        uint8_t type =3D NVME_SGL_TYPE(segment[i].type);
+
+        if (type !=3D NVME_SGL_DESCR_TYPE_DATA_BLOCK) {
+            switch (type) {
+            case NVME_SGL_DESCR_TYPE_BIT_BUCKET:
+            case NVME_SGL_DESCR_TYPE_KEYED_DATA_BLOCK:
+                return NVME_SGL_DESCR_TYPE_INVALID | NVME_DNR;
+            default:
+                return NVME_INVALID_NUM_SGL_DESCRS | NVME_DNR;
+            }
+        }
+
+        if (*len =3D=3D 0) {
+            uint16_t sgls =3D le16_to_cpu(n->id_ctrl.sgls);
+            if (sgls & NVME_CTRL_SGLS_EXCESS_LENGTH) {
+                break;
+            }
+
+            trace_nvme_dev_err_invalid_sgl_excess_length(nvme_cid(req));
+            return NVME_DATA_SGL_LEN_INVALID | NVME_DNR;
+        }
+
+        addr =3D le64_to_cpu(segment[i].addr);
+        blk_len =3D le32_to_cpu(segment[i].len);
+
+        if (!blk_len) {
+            continue;
+        }
+
+        if (UINT64_MAX - addr < blk_len) {
+            return NVME_DATA_SGL_LEN_INVALID | NVME_DNR;
+        }
+
+        trans_len =3D MIN(*len, blk_len);
+
+        status =3D nvme_map_addr(n, qsg, iov, addr, trans_len);
+        if (status) {
+            return status;
+        }
+
+        *len -=3D trans_len;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector =
*iov,
+                             NvmeSglDescriptor sgl, size_t len,
                              NvmeRequest *req)
+{
+    /*
+     * Read the segment in chunks of 256 descriptors (one 4k page) to av=
oid
+     * dynamically allocating a potentially large SGL. The spec allows t=
he SGL
+     * to be larger than the command transfer size, so it is not bounded=
 by
+     * MDTS.
+     */
+    const int SEG_CHUNK_SIZE =3D 256;
+
+    NvmeSglDescriptor segment[SEG_CHUNK_SIZE], *sgld, *last_sgld;
+    uint64_t nsgld;
+    uint32_t seg_len;
+    uint16_t status;
+    bool sgl_in_cmb =3D false;
+    hwaddr addr;
+    int ret;
+
+    sgld =3D &sgl;
+    addr =3D le64_to_cpu(sgl.addr);
+
+    trace_nvme_dev_map_sgl(nvme_cid(req), NVME_SGL_TYPE(sgl.type), req->=
nlb,
+                           len);
+
+    /*
+     * If the entire transfer can be described with a single data block =
it can
+     * be mapped directly.
+     */
+    if (NVME_SGL_TYPE(sgl.type) =3D=3D NVME_SGL_DESCR_TYPE_DATA_BLOCK) {
+        status =3D nvme_map_sgl_data(n, qsg, iov, sgld, 1, &len, req);
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
+    for (;;) {
+        seg_len =3D le32_to_cpu(sgld->len);
+
+        if (!seg_len || seg_len & 0xf) {
+            return NVME_INVALID_SGL_SEG_DESCR | NVME_DNR;
+        }
+
+        if (UINT64_MAX - addr < seg_len) {
+            return NVME_DATA_SGL_LEN_INVALID | NVME_DNR;
+        }
+
+        nsgld =3D seg_len / sizeof(NvmeSglDescriptor);
+
+        while (nsgld > SEG_CHUNK_SIZE) {
+            if (nvme_addr_read(n, addr, segment, sizeof(segment))) {
+                trace_nvme_dev_err_addr_read(addr);
+                status =3D NVME_DATA_TRANSFER_ERROR;
+                goto unmap;
+            }
+
+            status =3D nvme_map_sgl_data(n, qsg, iov, segment, SEG_CHUNK=
_SIZE,
+                                       &len, req);
+            if (status) {
+                goto unmap;
+            }
+
+            nsgld -=3D SEG_CHUNK_SIZE;
+            addr +=3D SEG_CHUNK_SIZE * sizeof(NvmeSglDescriptor);
+        }
+
+        ret =3D nvme_addr_read(n, addr, segment, nsgld *
+                             sizeof(NvmeSglDescriptor));
+        if (ret) {
+            trace_nvme_dev_err_addr_read(addr);
+            status =3D NVME_DATA_TRANSFER_ERROR;
+            goto unmap;
+        }
+
+        last_sgld =3D &segment[nsgld - 1];
+
+        /* if the segment ends with a Data Block, then we are done */
+        if (NVME_SGL_TYPE(last_sgld->type) =3D=3D NVME_SGL_DESCR_TYPE_DA=
TA_BLOCK) {
+            status =3D nvme_map_sgl_data(n, qsg, iov, segment, nsgld, &l=
en, req);
+            if (status) {
+                goto unmap;
+            }
+
+            break;
+        }
+
+        /* a Last Segment must end with a Data Block descriptor */
+        if (NVME_SGL_TYPE(sgld->type) =3D=3D NVME_SGL_DESCR_TYPE_LAST_SE=
GMENT) {
+            status =3D NVME_INVALID_SGL_SEG_DESCR | NVME_DNR;
+            goto unmap;
+        }
+
+        sgld =3D last_sgld;
+        addr =3D le64_to_cpu(sgld->addr);
+
+        /*
+         * Do not map the last descriptor; it will be a Segment or Last =
Segment
+         * descriptor instead and handled by the next iteration.
+         */
+        status =3D nvme_map_sgl_data(n, qsg, iov, segment, nsgld - 1, &l=
en, req);
+        if (status) {
+            goto unmap;
+        }
+
+        /*
+         * If the next segment is in the CMB, make sure that the sgl was
+         * already located there.
+         */
+        if (sgl_in_cmb !=3D nvme_addr_is_cmb(n, addr)) {
+            status =3D NVME_INVALID_USE_OF_CMB | NVME_DNR;
+            goto unmap;
+        }
+    }
+
+out:
+    /* if there is any residual left in len, the SGL was too short */
+    if (len) {
+        status =3D NVME_DATA_SGL_LEN_INVALID | NVME_DNR;
+        goto unmap;
+    }
+
+    return NVME_SUCCESS;
+
+unmap:
+    if (iov->iov) {
+        qemu_iovec_destroy(iov);
+    }
+
+    if (qsg->sg) {
+        qemu_sglist_destroy(qsg);
+    }
+
+    return status;
+}
+
+static uint16_t nvme_map(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov=
,
+                         size_t len, NvmeRequest *req)
+{
+    uint64_t prp1, prp2;
+
+    switch (NVME_CMD_FLAGS_PSDT(req->cmd.flags)) {
+    case PSDT_PRP:
+        prp1 =3D le64_to_cpu(req->cmd.dptr.prp1);
+        prp2 =3D le64_to_cpu(req->cmd.dptr.prp2);
+
+        return nvme_map_prp(n, qsg, iov, prp1, prp2, len, req);
+    case PSDT_SGL_MPTR_CONTIGUOUS:
+    case PSDT_SGL_MPTR_SGL:
+        /* SGLs shall not be used for Admin commands in NVMe over PCIe *=
/
+        if (!req->sq->sqid) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        return nvme_map_sgl(n, qsg, iov, req->cmd.dptr.sgl, len, req);
+    default:
+        return NVME_INVALID_FIELD;
+    }
+}
+
+static uint16_t nvme_dma(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
+                         DMADirection dir, NvmeRequest *req)
 {
     uint16_t status =3D NVME_SUCCESS;
=20
-    status =3D nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len, re=
q);
+    status =3D nvme_map(n, &req->qsg, &req->iov, len, req);
     if (status) {
         return status;
     }
@@ -370,15 +604,6 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *p=
tr, uint32_t len,
     return status;
 }
=20
-static uint16_t nvme_map(NvmeCtrl *n, NvmeCmd *cmd, QEMUSGList *qsg,
-                         QEMUIOVector *iov, size_t len, NvmeRequest *req=
)
-{
-    uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
-
-    return nvme_map_prp(n, qsg, iov, prp1, prp2, len, req);
-}
-
 static void nvme_aio_destroy(NvmeAIO *aio)
 {
     g_free(aio);
@@ -846,7 +1071,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, N=
vmeRequest *req)
         goto invalid;
     }
=20
-    status =3D nvme_map(n, cmd, &req->qsg, &req->iov, len, req);
+    status =3D nvme_map(n, &req->qsg, &req->iov, len, req);
     if (status) {
         goto invalid;
     }
@@ -1013,8 +1238,6 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCm=
d *cmd, uint8_t rae,
                                 uint32_t buf_len, uint64_t off,
                                 NvmeRequest *req)
 {
-    uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
     uint32_t nsid =3D le32_to_cpu(cmd->nsid);
=20
     uint32_t trans_len;
@@ -1064,16 +1287,14 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, Nvme=
Cmd *cmd, uint8_t rae,
         nvme_clear_events(n, NVME_AER_TYPE_SMART);
     }
=20
-    return nvme_dma_prp(n, (uint8_t *) &smart + off, trans_len, prp1, pr=
p2,
-                        DMA_DIRECTION_FROM_DEVICE, req);
+    return nvme_dma(n, (uint8_t *) &smart + off, trans_len,
+                    DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
 static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf=
_len,
                                  uint64_t off, NvmeRequest *req)
 {
     uint32_t trans_len;
-    uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
     NvmeFwSlotInfoLog fw_log;
=20
     if (off > sizeof(fw_log)) {
@@ -1084,8 +1305,8 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeC=
md *cmd, uint32_t buf_len,
=20
     trans_len =3D MIN(sizeof(fw_log) - off, buf_len);
=20
-    return nvme_dma_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1, p=
rp2,
-                        DMA_DIRECTION_FROM_DEVICE, req);
+    return nvme_dma(n, (uint8_t *) &fw_log + off, trans_len,
+                    DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
 static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
@@ -1093,8 +1314,6 @@ static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCm=
d *cmd, uint8_t rae,
                                 NvmeRequest *req)
 {
     uint32_t trans_len;
-    uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
     uint8_t errlog[64];
=20
     if (!rae) {
@@ -1109,8 +1328,7 @@ static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCm=
d *cmd, uint8_t rae,
=20
     trans_len =3D MIN(sizeof(errlog) - off, buf_len);
=20
-    return nvme_dma_prp(n, errlog, trans_len, prp1, prp2,
-                        DMA_DIRECTION_FROM_DEVICE, req);
+    return nvme_dma(n, errlog, trans_len, DMA_DIRECTION_FROM_DEVICE, req=
);
 }
=20
 static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req=
)
@@ -1255,13 +1473,10 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeC=
md *cmd)
 static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c,
                                    NvmeRequest *req)
 {
-    uint64_t prp1 =3D le64_to_cpu(c->prp1);
-    uint64_t prp2 =3D le64_to_cpu(c->prp2);
-
     trace_nvme_dev_identify_ctrl();
=20
-    return nvme_dma_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl), p=
rp1,
-                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
+    return nvme_dma(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl),
+                    DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
 static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
@@ -1269,8 +1484,6 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeI=
dentify *c,
 {
     NvmeNamespace *ns;
     uint32_t nsid =3D le32_to_cpu(c->nsid);
-    uint64_t prp1 =3D le64_to_cpu(c->prp1);
-    uint64_t prp2 =3D le64_to_cpu(c->prp2);
=20
     trace_nvme_dev_identify_ns(nsid);
=20
@@ -1281,8 +1494,8 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeI=
dentify *c,
=20
     ns =3D &n->namespaces[nsid - 1];
=20
-    return nvme_dma_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns), prp=
1,
-                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
+    return nvme_dma(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns),
+                    DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
 static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c,
@@ -1290,8 +1503,6 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, N=
vmeIdentify *c,
 {
     static const int data_len =3D NVME_IDENTIFY_DATA_SIZE;
     uint32_t min_nsid =3D le32_to_cpu(c->nsid);
-    uint64_t prp1 =3D le64_to_cpu(c->prp1);
-    uint64_t prp2 =3D le64_to_cpu(c->prp2);
     uint32_t *list;
     uint16_t ret;
     int i, j =3D 0;
@@ -1308,8 +1519,8 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, N=
vmeIdentify *c,
             break;
         }
     }
-    ret =3D nvme_dma_prp(n, (uint8_t *)list, data_len, prp1, prp2,
-                       DMA_DIRECTION_FROM_DEVICE, req);
+    ret =3D nvme_dma(n, (uint8_t *)list, data_len, DMA_DIRECTION_FROM_DE=
VICE,
+                   req);
     g_free(list);
     return ret;
 }
@@ -1318,8 +1529,6 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtr=
l *n, NvmeIdentify *c,
                                             NvmeRequest *req)
 {
     uint32_t nsid =3D le32_to_cpu(c->nsid);
-    uint64_t prp1 =3D le64_to_cpu(c->prp1);
-    uint64_t prp2 =3D le64_to_cpu(c->prp2);
=20
     void *list;
     uint16_t ret;
@@ -1345,8 +1554,8 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtr=
l *n, NvmeIdentify *c,
     ns_descr->nidl =3D NVME_NIDT_UUID_LEN;
     stl_be_p(ns_descr + sizeof(*ns_descr), nsid);
=20
-    ret =3D nvme_dma_prp(n, (uint8_t *) list, NVME_IDENTIFY_DATA_SIZE, p=
rp1,
-                       prp2, DMA_DIRECTION_FROM_DEVICE, req);
+    ret =3D nvme_dma(n, (uint8_t *)list, NVME_IDENTIFY_DATA_SIZE,
+                   DMA_DIRECTION_FROM_DEVICE, req);
     g_free(list);
     return ret;
 }
@@ -1425,13 +1634,10 @@ static inline uint64_t nvme_get_timestamp(const N=
vmeCtrl *n)
 static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
                                            NvmeRequest *req)
 {
-    uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
-
     uint64_t timestamp =3D nvme_get_timestamp(n);
=20
-    return nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp), prp=
1,
-                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
+    return nvme_dma(n, (uint8_t *)&timestamp, sizeof(timestamp),
+                    DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
@@ -1514,11 +1720,9 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtr=
l *n, NvmeCmd *cmd,
 {
     uint16_t ret;
     uint64_t timestamp;
-    uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
-    uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
=20
-    ret =3D nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp), pr=
p1,
-                       prp2, DMA_DIRECTION_TO_DEVICE, req);
+    ret =3D nvme_dma(n, (uint8_t *)&timestamp, sizeof(timestamp),
+                   DMA_DIRECTION_TO_DEVICE, req);
     if (ret !=3D NVME_SUCCESS) {
         return ret;
     }
@@ -2306,6 +2510,8 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     id->nn =3D cpu_to_le32(n->num_namespaces);
     id->oncs =3D cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP=
);
=20
+    id->sgls =3D cpu_to_le32(NVME_CTRL_SGLS_SUPPORTED_NO_ALIGNMENT);
+
     pstrcpy((char *) id->subnqn, sizeof(id->subnqn), "nqn.2019-08.org.qe=
mu:");
     pstrcat((char *) id->subnqn, sizeof(id->subnqn), n->params.serial);
=20
diff --git a/hw/block/trace-events b/hw/block/trace-events
index d51c09a4e454..70702cc67d5a 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -34,6 +34,7 @@ nvme_dev_irq_pin(void) "pulsing IRQ pin"
 nvme_dev_irq_masked(void) "IRQ is masked"
 nvme_dev_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=3D0x%"PR=
Ix64" prp2=3D0x%"PRIx64""
 nvme_dev_map_prp(uint16_t cid, uint64_t trans_len, uint32_t len, uint64_=
t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" trans_len %"PRIu64" l=
en %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64" num_prps %d"
+nvme_dev_map_sgl(uint16_t cid, uint8_t typ, uint32_t nlb, uint64_t len) =
"cid %"PRIu16" type 0x%"PRIx8" nlb %"PRIu32" len %"PRIu64""
 nvme_dev_req_register_aio(uint16_t cid, void *aio, const char *blkname, =
uint64_t offset, uint64_t count, const char *opc, void *req) "cid %"PRIu1=
6" aio %p blk \"%s\" offset %"PRIu64" count %"PRIu64" opc \"%s\" req %p"
 nvme_dev_aio_cb(uint16_t cid, void *aio, const char *blkname, uint64_t o=
ffset, const char *opc, void *req) "cid %"PRIu16" aio %p blk \"%s\" offse=
t %"PRIu64" opc \"%s\" req %p"
 nvme_dev_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opco=
de) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
@@ -89,6 +90,9 @@ nvme_dev_err_prinfo(uint16_t cid, uint16_t ctrl) "cid %=
"PRIu16" ctrl %"PRIu16""
 nvme_dev_err_aio(uint16_t cid, void *aio, const char *blkname, uint64_t =
offset, const char *opc, void *req, uint16_t status) "cid %"PRIu16" aio %=
p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p status 0x%"PRIx16""
 nvme_dev_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
 nvme_dev_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
+nvme_dev_err_invalid_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" type=
 0x%"PRIx8""
+nvme_dev_err_invalid_num_sgld(uint16_t cid, uint8_t typ) "cid %"PRIu16" =
type 0x%"PRIx8""
+nvme_dev_err_invalid_sgl_excess_length(uint16_t cid) "cid %"PRIu16""
 nvme_dev_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
 nvme_dev_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is nu=
ll or not page aligned: 0x%"PRIx64""
 nvme_dev_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned=
: 0x%"PRIx64""
--=20
2.25.1



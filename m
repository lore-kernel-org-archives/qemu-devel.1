Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C167CC2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA65206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA65206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jObQy-0001dq-MK
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 02:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOaz3-0002wp-I0
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOaz0-0002rQ-2O
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:12 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47564)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOayu-0002Ze-QS; Wed, 15 Apr 2020 01:53:05 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 48F65BFD93;
 Wed, 15 Apr 2020 05:52:28 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 28/48] nvme: pass request along for tracing
Date: Wed, 15 Apr 2020 07:51:20 +0200
Message-Id: <20200415055140.466900-29-its@irrelevant.dk>
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

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c       | 67 +++++++++++++++++++++++++------------------
 hw/block/trace-events |  2 +-
 2 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 2ff7dd695cd7..66f92f6f6f2d 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -210,14 +210,18 @@ static uint16_t nvme_map_addr(NvmeCtrl *n, QEMUSGLi=
st *qsg, QEMUIOVector *iov,
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_=
t prp1,
-                             uint64_t prp2, uint32_t len, NvmeCtrl *n)
+static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector =
*iov,
+                             uint64_t prp1, uint64_t prp2, uint32_t len,
+                             NvmeRequest *req)
 {
     hwaddr trans_len =3D n->page_size - (prp1 % n->page_size);
     trans_len =3D MIN(len, trans_len);
     int num_prps =3D (len >> n->page_bits) + 1;
     uint16_t status;
=20
+    trace_nvme_dev_map_prp(nvme_cid(req), trans_len, len, prp1, prp2,
+                           num_prps);
+
     if (unlikely(!prp1)) {
         trace_nvme_dev_err_invalid_prp();
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -308,13 +312,14 @@ unmap:
 }
=20
 static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
-                             uint64_t prp1, uint64_t prp2, DMADirection =
dir)
+                             uint64_t prp1, uint64_t prp2, DMADirection =
dir,
+                             NvmeRequest *req)
 {
     QEMUSGList qsg;
     QEMUIOVector iov;
     uint16_t status =3D NVME_SUCCESS;
=20
-    status =3D nvme_map_prp(&qsg, &iov, prp1, prp2, len, n);
+    status =3D nvme_map_prp(n, &qsg, &iov, prp1, prp2, len, req);
     if (status) {
         return status;
     }
@@ -559,7 +564,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *n=
s, NvmeCmd *cmd,
         return NVME_LBA_RANGE | NVME_DNR;
     }
=20
-    if (nvme_map_prp(&req->qsg, &req->iov, prp1, prp2, data_size, n)) {
+    if (nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, data_size, req=
)) {
         block_acct_invalid(blk_get_stats(n->conf.blk), acct);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
@@ -784,7 +789,7 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd =
*cmd, uint8_t rae,
     }
=20
     return nvme_dma_prp(n, (uint8_t *) &smart + off, trans_len, prp1, pr=
p2,
-                        DMA_DIRECTION_FROM_DEVICE);
+                        DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
 static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf=
_len,
@@ -804,7 +809,7 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd=
 *cmd, uint32_t buf_len,
     trans_len =3D MIN(sizeof(fw_log) - off, buf_len);
=20
     return nvme_dma_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1, p=
rp2,
-                        DMA_DIRECTION_FROM_DEVICE);
+                        DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
 static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
@@ -829,7 +834,7 @@ static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd =
*cmd, uint8_t rae,
     trans_len =3D MIN(sizeof(errlog) - off, buf_len);
=20
     return nvme_dma_prp(n, (uint8_t *)&errlog, trans_len, prp1, prp2,
-                        DMA_DIRECTION_FROM_DEVICE);
+                        DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
 static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req=
)
@@ -970,7 +975,8 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *=
cmd)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c)
+static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c,
+                                   NvmeRequest *req)
 {
     uint64_t prp1 =3D le64_to_cpu(c->prp1);
     uint64_t prp2 =3D le64_to_cpu(c->prp2);
@@ -978,10 +984,11 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, Nvm=
eIdentify *c)
     trace_nvme_dev_identify_ctrl();
=20
     return nvme_dma_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl), p=
rp1,
-                        prp2, DMA_DIRECTION_FROM_DEVICE);
+                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
+static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
+                                 NvmeRequest *req)
 {
     NvmeNamespace *ns;
     uint32_t nsid =3D le32_to_cpu(c->nsid);
@@ -998,10 +1005,11 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, Nvme=
Identify *c)
     ns =3D &n->namespaces[nsid - 1];
=20
     return nvme_dma_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns), prp=
1,
-                        prp2, DMA_DIRECTION_FROM_DEVICE);
+                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
+static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c,
+                                     NvmeRequest *req)
 {
     static const int data_len =3D NVME_IDENTIFY_DATA_SIZE;
     uint32_t min_nsid =3D le32_to_cpu(c->nsid);
@@ -1024,12 +1032,13 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n,=
 NvmeIdentify *c)
         }
     }
     ret =3D nvme_dma_prp(n, (uint8_t *)list, data_len, prp1, prp2,
-                       DMA_DIRECTION_FROM_DEVICE);
+                       DMA_DIRECTION_FROM_DEVICE, req);
     g_free(list);
     return ret;
 }
=20
-static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c=
)
+static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c=
,
+                                            NvmeRequest *req)
 {
     uint32_t nsid =3D le32_to_cpu(c->nsid);
     uint64_t prp1 =3D le64_to_cpu(c->prp1);
@@ -1064,22 +1073,22 @@ static uint16_t nvme_identify_ns_descr_list(NvmeC=
trl *n, NvmeIdentify *c)
     stl_be_p(&ns_descrs->uuid.v, nsid);
=20
     return nvme_dma_prp(n, list, NVME_IDENTIFY_DATA_SIZE, prp1, prp2,
-                        DMA_DIRECTION_FROM_DEVICE);
+                        DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *re=
q)
 {
     NvmeIdentify *c =3D (NvmeIdentify *)cmd;
=20
     switch (le32_to_cpu(c->cns)) {
     case NVME_ID_CNS_NS:
-        return nvme_identify_ns(n, c);
+        return nvme_identify_ns(n, c, req);
     case NVME_ID_CNS_CTRL:
-        return nvme_identify_ctrl(n, c);
+        return nvme_identify_ctrl(n, c, req);
     case NVME_ID_CNS_NS_ACTIVE_LIST:
-        return nvme_identify_nslist(n, c);
+        return nvme_identify_nslist(n, c, req);
     case NVME_ID_CNS_NS_DESCR_LIST:
-        return nvme_identify_ns_descr_list(n, c);
+        return nvme_identify_ns_descr_list(n, c, req);
     default:
         trace_nvme_dev_err_invalid_identify_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1138,7 +1147,8 @@ static inline uint64_t nvme_get_timestamp(const Nvm=
eCtrl *n)
     return cpu_to_le64(ts.all);
 }
=20
-static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
+                                           NvmeRequest *req)
 {
     uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
     uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
@@ -1146,7 +1156,7 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl=
 *n, NvmeCmd *cmd)
     uint64_t timestamp =3D nvme_get_timestamp(n);
=20
     return nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp), prp=
1,
-                        prp2, DMA_DIRECTION_FROM_DEVICE);
+                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
@@ -1198,7 +1208,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
         trace_nvme_dev_getfeat_numq(result);
         break;
     case NVME_TIMESTAMP:
-        return nvme_get_feature_timestamp(n, cmd);
+        return nvme_get_feature_timestamp(n, cmd, req);
     case NVME_INTERRUPT_COALESCING:
         result =3D cpu_to_le32(n->features.int_coalescing);
         break;
@@ -1224,7 +1234,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
+                                           NvmeRequest *req)
 {
     uint16_t ret;
     uint64_t timestamp;
@@ -1232,7 +1243,7 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl=
 *n, NvmeCmd *cmd)
     uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
=20
     ret =3D nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp), pr=
p1,
-                       prp2, DMA_DIRECTION_TO_DEVICE);
+                       prp2, DMA_DIRECTION_TO_DEVICE, req);
     if (ret !=3D NVME_SUCCESS) {
         return ret;
     }
@@ -1303,7 +1314,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
                                       ((n->params.max_ioqpairs - 1) << 1=
6));
         break;
     case NVME_TIMESTAMP:
-        return nvme_set_feature_timestamp(n, cmd);
+        return nvme_set_feature_timestamp(n, cmd, req);
     case NVME_ASYNCHRONOUS_EVENT_CONF:
         n->features.async_config =3D dw11;
         break;
@@ -1357,7 +1368,7 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
     case NVME_ADM_CMD_CREATE_CQ:
         return nvme_create_cq(n, cmd);
     case NVME_ADM_CMD_IDENTIFY:
-        return nvme_identify(n, cmd);
+        return nvme_identify(n, cmd, req);
     case NVME_ADM_CMD_ABORT:
         return nvme_abort(n, cmd, req);
     case NVME_ADM_CMD_SET_FEATURES:
diff --git a/hw/block/trace-events b/hw/block/trace-events
index aff67b52d1e8..e050af87ece4 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -33,7 +33,7 @@ nvme_dev_irq_msix(uint32_t vector) "raising MSI-X IRQ v=
ector %u"
 nvme_dev_irq_pin(void) "pulsing IRQ pin"
 nvme_dev_irq_masked(void) "IRQ is masked"
 nvme_dev_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=3D0x%"PR=
Ix64" prp2=3D0x%"PRIx64""
-nvme_dev_map_prp(uint16_t cid, uint8_t opc, uint64_t trans_len, uint32_t=
 len, uint64_t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" opc 0x%"=
PRIx8" trans_len %"PRIu64" len %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64=
" num_prps %d"
+nvme_dev_map_prp(uint16_t cid, uint64_t trans_len, uint32_t len, uint64_=
t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" trans_len %"PRIu64" l=
en %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64" num_prps %d"
 nvme_dev_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opco=
de) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
 nvme_dev_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode) "cid %"P=
RIu16" sqid %"PRIu16" opc 0x%"PRIx8""
 nvme_dev_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, u=
int64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
--=20
2.26.0



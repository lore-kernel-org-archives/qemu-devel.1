Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701F0C2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 378432051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 378432051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtEh-0001ky-E7
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDqlg-0000fG-Ct
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDqld-0007J8-Nd
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:31:00 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48850)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDqlT-00045f-Og; Mon, 16 Mar 2020 10:30:48 -0400
Received: from apples.local (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id 2B893BFAB3;
 Mon, 16 Mar 2020 14:29:56 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v6 41/42] nvme: remove redundant NvmeCmd pointer parameter
Date: Mon, 16 Mar 2020 07:29:27 -0700
Message-Id: <20200316142928.153431-42-its@irrelevant.dk>
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

The command struct is available in the NvmeRequest that we generally
pass around anyway.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c | 164 +++++++++++++++++++++++-------------------------
 1 file changed, 78 insertions(+), 86 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index f176d859a85e..4f1504fc00fe 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -986,7 +986,7 @@ static void nvme_aio_cb(void *opaque, int ret)
     nvme_aio_destroy(aio);
 }
=20
-static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns =3D req->ns;
     NvmeAIO *aio =3D g_new0(NvmeAIO, 1);
@@ -1002,12 +1002,12 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *=
cmd, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
=20
-static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest=
 *req)
+static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeAIO *aio;
=20
     NvmeNamespace *ns =3D req->ns;
-    NvmeRwCmd *rw =3D (NvmeRwCmd *) cmd;
+    NvmeRwCmd *rw =3D (NvmeRwCmd *) &req->cmd;
     uint16_t ctrl =3D le16_to_cpu(rw->control);
=20
     int64_t offset;
@@ -1057,9 +1057,9 @@ invalid:
     return status;
 }
=20
-static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeRwCmd *rw =3D (NvmeRwCmd *) cmd;
+    NvmeRwCmd *rw =3D (NvmeRwCmd *) &req->cmd;
     NvmeNamespace *ns =3D req->ns;
     uint32_t len;
     int status;
@@ -1095,12 +1095,12 @@ invalid:
     return status;
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
     if (!nvme_nsid_valid(n, nsid)) {
         return NVME_INVALID_NSID | NVME_DNR;
@@ -1112,16 +1112,16 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd =
*cmd, NvmeRequest *req)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
=20
-    switch (cmd->opcode) {
+    switch (req->cmd.opcode) {
     case NVME_CMD_FLUSH:
-        return nvme_flush(n, cmd, req);
+        return nvme_flush(n, req);
     case NVME_CMD_WRITE_ZEROS:
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
@@ -1137,10 +1137,10 @@ static void nvme_free_sq(NvmeSQueue *sq, NvmeCtrl=
 *n)
     }
 }
=20
-static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeDeleteQ *c =3D (NvmeDeleteQ *)cmd;
-    NvmeRequest *req, *next;
+    NvmeDeleteQ *c =3D (NvmeDeleteQ *) &req->cmd;
+    NvmeRequest *next;
     NvmeSQueue *sq;
     NvmeCQueue *cq;
     NvmeAIO *aio;
@@ -1208,10 +1208,10 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl=
 *n, uint64_t dma_addr,
     n->sq[sqid] =3D sq;
 }
=20
-static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeSQueue *sq;
-    NvmeCreateSq *c =3D (NvmeCreateSq *)cmd;
+    NvmeCreateSq *c =3D (NvmeCreateSq *) &req->cmd;
=20
     uint16_t cqid =3D le16_to_cpu(c->cqid);
     uint16_t sqid =3D le16_to_cpu(c->sqid);
@@ -1246,11 +1246,10 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeC=
md *cmd)
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
-    uint32_t nsid =3D le32_to_cpu(cmd->nsid);
+    uint32_t nsid =3D le32_to_cpu(req->cmd.nsid);
=20
     uint32_t trans_len;
     time_t current_ms;
@@ -1309,8 +1308,8 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCm=
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
     NvmeFwSlotInfoLog fw_log;
@@ -1327,9 +1326,8 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeC=
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
     uint8_t errlog[64];
@@ -1349,12 +1347,12 @@ static uint16_t nvme_error_info(NvmeCtrl *n, Nvme=
Cmd *cmd, uint8_t rae,
     return nvme_dma(n, errlog, trans_len, DMA_DIRECTION_FROM_DEVICE, req=
);
 }
=20
-static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req=
)
+static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
 {
-    uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
-    uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
-    uint32_t dw12 =3D le32_to_cpu(cmd->cdw12);
-    uint32_t dw13 =3D le32_to_cpu(cmd->cdw13);
+    uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
+    uint32_t dw11 =3D le32_to_cpu(req->cmd.cdw11);
+    uint32_t dw12 =3D le32_to_cpu(req->cmd.cdw12);
+    uint32_t dw13 =3D le32_to_cpu(req->cmd.cdw13);
     uint8_t  lid =3D dw10 & 0xff;
     uint8_t  lsp =3D (dw10 >> 8) & 0xf;
     uint8_t  rae =3D (dw10 >> 15) & 0x1;
@@ -1384,11 +1382,11 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
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
@@ -1406,9 +1404,9 @@ static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *=
n)
     }
 }
=20
-static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeDeleteQ *c =3D (NvmeDeleteQ *)cmd;
+    NvmeDeleteQ *c =3D (NvmeDeleteQ *) &req->cmd;
     NvmeCQueue *cq;
     uint16_t qid =3D le16_to_cpu(c->qid);
=20
@@ -1446,10 +1444,10 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl=
 *n, uint64_t dma_addr,
     cq->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_post_cqes, cq);
 }
=20
-static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeCQueue *cq;
-    NvmeCreateCq *c =3D (NvmeCreateCq *)cmd;
+    NvmeCreateCq *c =3D (NvmeCreateCq *) &req->cmd;
     uint16_t cqid =3D le16_to_cpu(c->cqid);
     uint16_t vector =3D le16_to_cpu(c->irq_vector);
     uint16_t qsize =3D le16_to_cpu(c->qsize);
@@ -1488,8 +1486,7 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd=
 *cmd)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c,
-                                   NvmeRequest *req)
+static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
 {
     trace_nvme_dev_identify_ctrl();
=20
@@ -1497,11 +1494,10 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, N=
vmeIdentify *c,
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
-                                 NvmeRequest *req)
+static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeIdNs *id_ns, inactive =3D { 0 };
-    uint32_t nsid =3D le32_to_cpu(c->nsid);
+    uint32_t nsid =3D le32_to_cpu(req->cmd.nsid);
     NvmeNamespace *ns;
=20
     trace_nvme_dev_identify_ns(nsid);
@@ -1521,11 +1517,10 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, Nvm=
eIdentify *c,
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c,
-                                     NvmeRequest *req)
+static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
 {
     static const int data_len =3D NVME_IDENTIFY_DATA_SIZE;
-    uint32_t min_nsid =3D le32_to_cpu(c->nsid);
+    uint32_t min_nsid =3D le32_to_cpu(req->cmd.nsid);
     uint32_t *list;
     uint16_t ret;
     int j =3D 0;
@@ -1548,10 +1543,9 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, =
NvmeIdentify *c,
     return ret;
 }
=20
-static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c=
,
-                                            NvmeRequest *req)
+static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *re=
q)
 {
-    uint32_t nsid =3D le32_to_cpu(c->nsid);
+    uint32_t nsid =3D le32_to_cpu(req->cmd.nsid);
=20
     void *list;
     uint16_t ret;
@@ -1586,28 +1580,28 @@ static uint16_t nvme_identify_ns_descr_list(NvmeC=
trl *n, NvmeIdentify *c,
     return ret;
 }
=20
-static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *re=
q)
+static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeIdentify *c =3D (NvmeIdentify *)cmd;
+    NvmeIdentify *c =3D (NvmeIdentify *) &req->cmd;
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
@@ -1657,8 +1651,7 @@ static inline uint64_t nvme_get_timestamp(const Nvm=
eCtrl *n)
     return cpu_to_le64(ts.all);
 }
=20
-static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
-                                           NvmeRequest *req)
+static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeRequest *req=
)
 {
     uint64_t timestamp =3D nvme_get_timestamp(n);
=20
@@ -1666,10 +1659,10 @@ static uint16_t nvme_get_feature_timestamp(NvmeCt=
rl *n, NvmeCmd *cmd,
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
=20
-static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
+static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
 {
-    uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
-    uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
+    uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
+    uint32_t dw11 =3D le32_to_cpu(req->cmd.cdw11);
     uint32_t result;
=20
     trace_nvme_dev_getfeat(nvme_cid(req), dw10);
@@ -1715,7 +1708,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
         trace_nvme_dev_getfeat_numq(result);
         break;
     case NVME_TIMESTAMP:
-        return nvme_get_feature_timestamp(n, cmd, req);
+        return nvme_get_feature_timestamp(n, req);
     case NVME_INTERRUPT_COALESCING:
         result =3D cpu_to_le32(n->features.int_coalescing);
         break;
@@ -1741,8 +1734,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
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
@@ -1758,12 +1750,12 @@ static uint16_t nvme_set_feature_timestamp(NvmeCt=
rl *n, NvmeCmd *cmd,
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
+static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns;
=20
-    uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
-    uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
+    uint32_t dw10 =3D le32_to_cpu(req->cmd.cdw10);
+    uint32_t dw11 =3D le32_to_cpu(req->cmd.cdw11);
=20
     trace_nvme_dev_setfeat(nvme_cid(req), dw10, dw11);
=20
@@ -1832,7 +1824,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
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
@@ -1850,7 +1842,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_aer(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_aer(NvmeCtrl *n, NvmeRequest *req)
 {
     trace_nvme_dev_aer(nvme_cid(req));
=20
@@ -1869,31 +1861,31 @@ static uint16_t nvme_aer(NvmeCtrl *n, NvmeCmd *cm=
d, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
=20
-static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *r=
eq)
+static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
 {
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
@@ -1926,8 +1918,8 @@ static void nvme_process_sq(void *opaque)
         req->cqe.cid =3D cmd.cid;
         memcpy(&req->cmd, &cmd, sizeof(NvmeCmd));
=20
-        status =3D sq->sqid ? nvme_io_cmd(n, &cmd, req) :
-            nvme_admin_cmd(n, &cmd, req);
+        status =3D sq->sqid ? nvme_io_cmd(n, req) :
+            nvme_admin_cmd(n, req);
         if (status !=3D NVME_NO_COMPLETE) {
             req->status =3D status;
             nvme_enqueue_req_completion(cq, req);
--=20
2.25.1



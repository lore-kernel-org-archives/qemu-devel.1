Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9079C2BB85
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C5020767
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C5020767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOb8I-000341-RU
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 02:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOayf-0001n2-Rr
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOaye-0002cz-11
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:52:49 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47250)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOayZ-0002Q6-81; Wed, 15 Apr 2020 01:52:43 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 19A40BFD3D;
 Wed, 15 Apr 2020 05:52:22 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 13/48] nvme: add support for the get log page command
Date: Wed, 15 Apr 2020 07:51:05 +0200
Message-Id: <20200415055140.466900-14-its@irrelevant.dk>
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

Add support for the Get Log Page command and basic implementations of
the mandatory Error Information, SMART / Health Information and Firmware
Slot Information log pages.

In violation of the specification, the SMART / Health Information log
page does not persist information over the lifetime of the controller
because the device has no place to store such persistent state.

Note that the LPA field in the Identify Controller data structure
intentionally has bit 0 cleared because there is no namespace specific
information in the SMART / Health information log page.

Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
Section 5.10 ("Get Log Page command").

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c       | 138 +++++++++++++++++++++++++++++++++++++++++-
 hw/block/nvme.h       |  11 ++++
 hw/block/trace-events |   2 +
 3 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index e777cc9075c1..76acc112fa7e 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -569,6 +569,138 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd=
 *cmd)
     return NVME_SUCCESS;
 }
=20
+static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_=
len,
+                                uint64_t off, NvmeRequest *req)
+{
+    uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
+    uint32_t nsid =3D le32_to_cpu(cmd->nsid);
+
+    uint32_t trans_len;
+    time_t current_ms;
+    uint64_t units_read =3D 0, units_written =3D 0;
+    uint64_t read_commands =3D 0, write_commands =3D 0;
+    NvmeSmartLog smart;
+    BlockAcctStats *s;
+
+    if (nsid && nsid !=3D 0xffffffff) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    s =3D blk_get_stats(n->conf.blk);
+
+    units_read =3D s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS;
+    units_written =3D s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_BITS;
+    read_commands =3D s->nr_ops[BLOCK_ACCT_READ];
+    write_commands =3D s->nr_ops[BLOCK_ACCT_WRITE];
+
+    if (off > sizeof(smart)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    trans_len =3D MIN(sizeof(smart) - off, buf_len);
+
+    memset(&smart, 0x0, sizeof(smart));
+
+    smart.data_units_read[0] =3D cpu_to_le64(units_read / 1000);
+    smart.data_units_written[0] =3D cpu_to_le64(units_written / 1000);
+    smart.host_read_commands[0] =3D cpu_to_le64(read_commands);
+    smart.host_write_commands[0] =3D cpu_to_le64(write_commands);
+
+    smart.temperature[0] =3D n->temperature & 0xff;
+    smart.temperature[1] =3D (n->temperature >> 8) & 0xff;
+
+    if ((n->temperature > n->features.temp_thresh_hi) ||
+        (n->temperature < n->features.temp_thresh_low)) {
+        smart.critical_warning |=3D NVME_SMART_TEMPERATURE;
+    }
+
+    current_ms =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    smart.power_on_hours[0] =3D
+        cpu_to_le64((((current_ms - n->starttime_ms) / 1000) / 60) / 60)=
;
+
+    return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp=
1,
+                             prp2);
+}
+
+static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf=
_len,
+                                 uint64_t off, NvmeRequest *req)
+{
+    uint32_t trans_len;
+    uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
+    NvmeFwSlotInfoLog fw_log;
+
+    if (off > sizeof(fw_log)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    memset(&fw_log, 0, sizeof(NvmeFwSlotInfoLog));
+
+    trans_len =3D MIN(sizeof(fw_log) - off, buf_len);
+
+    return nvme_dma_read_prp(n, (uint8_t *) &fw_log + off, trans_len, pr=
p1,
+                             prp2);
+}
+
+static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_=
len,
+                                uint64_t off, NvmeRequest *req)
+{
+    uint32_t trans_len;
+    uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
+    NvmeErrorLog errlog;
+
+    if (off > sizeof(errlog)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    memset(&errlog, 0x0, sizeof(errlog));
+
+    trans_len =3D MIN(sizeof(errlog) - off, buf_len);
+
+    return nvme_dma_read_prp(n, (uint8_t *)&errlog, trans_len, prp1, prp=
2);
+}
+
+static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req=
)
+{
+    uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
+    uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
+    uint32_t dw12 =3D le32_to_cpu(cmd->cdw12);
+    uint32_t dw13 =3D le32_to_cpu(cmd->cdw13);
+    uint8_t  lid =3D dw10 & 0xff;
+    uint8_t  rae =3D (dw10 >> 15) & 0x1;
+    uint32_t numdl, numdu;
+    uint64_t off, lpol, lpou;
+    size_t   len;
+
+    numdl =3D (dw10 >> 16);
+    numdu =3D (dw11 & 0xffff);
+    lpol =3D dw12;
+    lpou =3D dw13;
+
+    len =3D (((numdu << 16) | numdl) + 1) << 2;
+    off =3D (lpou << 32ULL) | lpol;
+
+    if (off & 0x3) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    trace_nvme_dev_get_log(nvme_cid(req), lid, rae, len, off);
+
+    switch (lid) {
+    case NVME_LOG_ERROR_INFO:
+        return nvme_error_info(n, cmd, len, off, req);
+    case NVME_LOG_SMART_INFO:
+        return nvme_smart_info(n, cmd, len, off, req);
+    case NVME_LOG_FW_SLOT_INFO:
+        return nvme_fw_log_info(n, cmd, len, off, req);
+    default:
+        trace_nvme_dev_err_invalid_log_page(nvme_cid(req), lid);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+}
+
 static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *n)
 {
     n->cq[cq->cqid] =3D NULL;
@@ -914,6 +1046,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd =
*cmd, NvmeRequest *req)
         return nvme_del_sq(n, cmd);
     case NVME_ADM_CMD_CREATE_SQ:
         return nvme_create_sq(n, cmd);
+    case NVME_ADM_CMD_GET_LOG_PAGE:
+        return nvme_get_log(n, cmd, req);
     case NVME_ADM_CMD_DELETE_CQ:
         return nvme_del_cq(n, cmd);
     case NVME_ADM_CMD_CREATE_CQ:
@@ -1415,7 +1549,9 @@ static void nvme_init_state(NvmeCtrl *n)
     n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
     n->sq =3D g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
     n->cq =3D g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
+    n->temperature =3D NVME_TEMPERATURE;
     n->features.temp_thresh_hi =3D NVME_TEMPERATURE_WARNING;
+    n->starttime_ms =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
 }
=20
 static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
@@ -1492,7 +1628,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
      */
     id->acl =3D 3;
     id->frmw =3D 7 << 1;
-    id->lpa =3D 1 << 0;
+    id->lpa =3D 1 << 2;
=20
     /* recommended default value (~70 C) */
     id->wctemp =3D cpu_to_le16(NVME_TEMPERATURE_WARNING);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 807c4ad19dcc..54644815e10a 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -108,6 +108,8 @@ typedef struct NvmeCtrl {
     uint64_t    irq_status;
     uint64_t    host_timestamp;                 /* Timestamp sent by the=
 host */
     uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
+    uint64_t    starttime_ms;
+    uint16_t    temperature;
=20
     NvmeNamespace   *namespaces;
     NvmeSQueue      **sq;
@@ -123,4 +125,13 @@ static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, Nv=
meNamespace *ns)
     return n->ns_size >> nvme_ns_lbads(ns);
 }
=20
+static inline uint16_t nvme_cid(NvmeRequest *req)
+{
+    if (req) {
+        return le16_to_cpu(req->cqe.cid);
+    }
+
+    return 0xffff;
+}
+
 #endif /* HW_NVME_H */
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 75b0c7a0cb60..1a5b5d764594 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -46,6 +46,7 @@ nvme_dev_getfeat_numq(int result) "get feature number o=
f queues, result=3D%d"
 nvme_dev_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "reque=
sted cq_count=3D%d sq_count=3D%d, responding with cq_count=3D%d sq_count=3D=
%d"
 nvme_dev_setfeat_timestamp(uint64_t ts) "set feature timestamp =3D 0x%"P=
RIx64""
 nvme_dev_getfeat_timestamp(uint64_t ts) "get feature timestamp =3D 0x%"P=
RIx64""
+nvme_dev_get_log(uint16_t cid, uint8_t lid, uint8_t rae, uint32_t len, u=
int64_t off) "cid %"PRIu16" lid 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" o=
ff %"PRIu64""
 nvme_dev_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, in=
terrupt mask set, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
 nvme_dev_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, in=
terrupt mask clr, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
 nvme_dev_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=3D=
0x%"PRIx64""
@@ -85,6 +86,7 @@ nvme_dev_err_invalid_create_cq_qflags(uint16_t qflags) =
"failed creating completi
 nvme_dev_err_invalid_identify_cns(uint16_t cns) "identify, invalid cns=3D=
0x%"PRIx16""
 nvme_dev_err_invalid_getfeat(int dw10) "invalid get features, dw10=3D0x%=
"PRIx32""
 nvme_dev_err_invalid_setfeat(uint32_t dw10) "invalid set features, dw10=3D=
0x%"PRIx32""
+nvme_dev_err_invalid_log_page(uint16_t cid, uint16_t lid) "cid %"PRIu16"=
 lid 0x%"PRIx16""
 nvme_dev_err_startfail_cq(void) "nvme_start_ctrl failed because there ar=
e non-admin completion queues"
 nvme_dev_err_startfail_sq(void) "nvme_start_ctrl failed because there ar=
e non-admin submission queues"
 nvme_dev_err_startfail_nbarasq(void) "nvme_start_ctrl failed because the=
 admin submission queue address is null"
--=20
2.26.0



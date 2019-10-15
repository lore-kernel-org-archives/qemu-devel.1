Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A158ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12FE20854
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12FE20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40225 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKKKR-00050Z-5C
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 06:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iKKEd-0007V5-Ez
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iKKEb-0006Ip-Db
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:39:23 -0400
Received: from charlie.dont.surf ([128.199.63.193]:54822)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1iKKEW-0006CR-KQ; Tue, 15 Oct 2019 06:39:16 -0400
Received: from apples.localdomain (unknown [194.62.217.57])
 by charlie.dont.surf (Postfix) with ESMTPSA id 77E1BBF907;
 Tue, 15 Oct 2019 10:39:15 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v2 08/20] nvme: add support for the get log page command
Date: Tue, 15 Oct 2019 12:38:48 +0200
Message-Id: <20191015103900.313928-9-its@irrelevant.dk>
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

Add support for the Get Log Page command and basic implementations
of the mandatory Error Information, SMART/Health Information and
Firmware Slot Information log pages.

In violation of the specification, the SMART/Health Information log page
does not persist information over the lifetime of the controller because
the device has no place to store such persistent state.

Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
Section 5.10 ("Get Log Page command").

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c       | 150 +++++++++++++++++++++++++++++++++++++++++-
 hw/block/nvme.h       |   9 ++-
 hw/block/trace-events |   2 +
 include/block/nvme.h  |   2 +-
 4 files changed, 160 insertions(+), 3 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 1fdb3b8655ed..4412a3bea3bc 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -44,6 +44,7 @@
 #include "nvme.h"
=20
 #define NVME_MAX_QS PCI_MSIX_FLAGS_QSIZE
+#define NVME_TEMPERATURE 0x143
=20
 #define NVME_GUEST_ERR(trace, fmt, ...) \
     do { \
@@ -577,6 +578,137 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd=
 *cmd)
     return NVME_SUCCESS;
 }
=20
+static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd,
+    uint32_t buf_len, uint64_t off, NvmeRequest *req)
+{
+    uint32_t trans_len;
+    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
+
+    if (off > sizeof(*n->elpes) * (n->params.elpe + 1)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    trans_len =3D MIN(sizeof(*n->elpes) * (n->params.elpe + 1) - off, bu=
f_len);
+
+    return nvme_dma_read_prp(n, (uint8_t *) n->elpes + off, trans_len, p=
rp1,
+        prp2);
+}
+
+static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_=
len,
+    uint64_t off, NvmeRequest *req)
+{
+    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
+    uint32_t nsid =3D le32_to_cpu(cmd->nsid);
+
+    uint32_t trans_len;
+    time_t current_ms;
+    uint64_t units_read =3D 0, units_written =3D 0, read_commands =3D 0,
+        write_commands =3D 0;
+    NvmeSmartLog smart;
+    BlockAcctStats *s;
+
+    if (!nsid || (nsid !=3D 0xffffffff && nsid > n->num_namespaces)) {
+        trace_nvme_err_invalid_ns(nsid, n->num_namespaces);
+        return NVME_INVALID_NSID | NVME_DNR;
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
+    smart.number_of_error_log_entries[0] =3D cpu_to_le64(0);
+    smart.temperature[0] =3D n->temperature & 0xff;
+    smart.temperature[1] =3D (n->temperature >> 8) & 0xff;
+
+    if (n->features.temp_thresh <=3D n->temperature) {
+        smart.critical_warning |=3D NVME_SMART_TEMPERATURE;
+    }
+
+    current_ms =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    smart.power_on_hours[0] =3D cpu_to_le64(
+        (((current_ms - n->starttime_ms) / 1000) / 60) / 60);
+
+    return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp=
1,
+        prp2);
+}
+
+static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf=
_len,
+    uint64_t off, NvmeRequest *req)
+{
+    uint32_t trans_len;
+    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
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
+        prp2);
+}
+
+static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req=
)
+{
+    uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
+    uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
+    uint32_t dw12 =3D le32_to_cpu(cmd->cdw12);
+    uint32_t dw13 =3D le32_to_cpu(cmd->cdw13);
+    uint16_t lid =3D dw10 & 0xff;
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
+    trace_nvme_get_log(req->cid, lid, rae, len, off);
+
+    switch (lid) {
+    case NVME_LOG_ERROR_INFO:
+        return nvme_error_info(n, cmd, len, off, req);
+    case NVME_LOG_SMART_INFO:
+        return nvme_smart_info(n, cmd, len, off, req);
+    case NVME_LOG_FW_SLOT_INFO:
+        return nvme_fw_log_info(n, cmd, len, off, req);
+    default:
+        trace_nvme_err_invalid_log_page(req->cid, lid);
+        return NVME_INVALID_LOG_ID | NVME_DNR;
+    }
+}
+
 static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *n)
 {
     n->cq[cq->cqid] =3D NULL;
@@ -812,6 +944,9 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
     uint32_t result;
=20
     switch (dw10) {
+    case NVME_TEMPERATURE_THRESHOLD:
+        result =3D cpu_to_le32(n->features.temp_thresh);
+        break;
     case NVME_VOLATILE_WRITE_CACHE:
         result =3D blk_enable_write_cache(n->conf.blk);
         trace_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
@@ -856,6 +991,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
     uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
=20
     switch (dw10) {
+    case NVME_TEMPERATURE_THRESHOLD:
+        n->features.temp_thresh =3D dw11;
+        break;
+
     case NVME_VOLATILE_WRITE_CACHE:
         blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
         break;
@@ -884,6 +1023,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd =
*cmd, NvmeRequest *req)
         return nvme_del_sq(n, cmd);
     case NVME_ADM_CMD_CREATE_SQ:
         return nvme_create_sq(n, cmd);
+    case NVME_ADM_CMD_GET_LOG_PAGE:
+        return nvme_get_log(n, cmd, req);
     case NVME_ADM_CMD_DELETE_CQ:
         return nvme_del_cq(n, cmd);
     case NVME_ADM_CMD_CREATE_CQ:
@@ -923,6 +1064,7 @@ static void nvme_process_sq(void *opaque)
         QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
         memset(&req->cqe, 0, sizeof(req->cqe));
         req->cqe.cid =3D cmd.cid;
+        req->cid =3D le16_to_cpu(cmd.cid);
=20
         status =3D sq->sqid ? nvme_io_cmd(n, &cmd, req) :
             nvme_admin_cmd(n, &cmd, req);
@@ -1378,6 +1520,10 @@ static void nvme_init_state(NvmeCtrl *n)
     n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
     n->sq =3D g_new0(NvmeSQueue *, n->params.num_queues);
     n->cq =3D g_new0(NvmeCQueue *, n->params.num_queues);
+    n->elpes =3D g_new0(NvmeErrorLog, n->params.elpe + 1);
+    n->starttime_ms =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    n->temperature =3D NVME_TEMPERATURE;
+    n->features.temp_thresh =3D 0x14d;
 }
=20
 static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
@@ -1446,7 +1592,8 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     id->oacs =3D cpu_to_le16(0);
     id->acl =3D 3;
     id->frmw =3D 7 << 1;
-    id->lpa =3D 1 << 0;
+    id->lpa =3D 1 << 2;
+    id->elpe =3D n->params.elpe;
     id->sqes =3D (0x6 << 4) | 0x6;
     id->cqes =3D (0x4 << 4) | 0x4;
     id->nn =3D cpu_to_le32(n->num_namespaces);
@@ -1530,6 +1677,7 @@ static void nvme_exit(PCIDevice *pci_dev)
     g_free(n->namespaces);
     g_free(n->cq);
     g_free(n->sq);
+    g_free(n->elpes);
=20
     if (n->params.cmb_size_mb) {
         g_free(n->cmbuf);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 7c3c07bde887..fcfd504e3f9f 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -6,12 +6,14 @@
 #define DEFINE_NVME_PROPERTIES(_state, _props) \
     DEFINE_PROP_STRING("serial", _state, _props.serial), \
     DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
-    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64)
+    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64), \
+    DEFINE_PROP_UINT8("elpe", _state, _props.elpe, 24)
=20
 typedef struct NvmeParams {
     char     *serial;
     uint32_t num_queues;
     uint32_t cmb_size_mb;
+    uint8_t  elpe;
 } NvmeParams;
=20
 typedef struct NvmeAsyncEvent {
@@ -23,6 +25,7 @@ typedef struct NvmeRequest {
     struct NvmeSQueue       *sq;
     BlockAIOCB              *aiocb;
     uint16_t                status;
+    uint16_t                cid;
     bool                    has_sg;
     NvmeCqe                 cqe;
     BlockAcctCookie         acct;
@@ -92,12 +95,16 @@ typedef struct NvmeCtrl {
     uint64_t    irq_status;
     uint64_t    host_timestamp;                 /* Timestamp sent by the=
 host */
     uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
+    uint64_t    starttime_ms;
+    uint16_t    temperature;
=20
     NvmeNamespace   *namespaces;
     NvmeSQueue      **sq;
     NvmeCQueue      **cq;
     NvmeSQueue      admin_sq;
     NvmeCQueue      admin_cq;
+    NvmeFeatureVal  features;
+    NvmeErrorLog    *elpes;
     NvmeIdCtrl      id_ctrl;
 } NvmeCtrl;
=20
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 13d1b21dd4e4..a2c7919c861e 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -46,6 +46,7 @@ nvme_getfeat_numq(int result) "get feature number of qu=
eues, result=3D%d"
 nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested=
 cq_count=3D%d sq_count=3D%d, responding with cq_count=3D%d sq_count=3D%d=
"
 nvme_setfeat_timestamp(uint64_t ts) "set feature timestamp =3D 0x%"PRIx6=
4""
 nvme_getfeat_timestamp(uint64_t ts) "get feature timestamp =3D 0x%"PRIx6=
4""
+nvme_get_log(uint16_t cid, uint16_t lid, uint8_t rae, uint32_t len, uint=
64_t off) "cid %"PRIu16" lid 0x%"PRIx16" rae 0x%"PRIx8" len %"PRIu32" off=
 %"PRIu64""
 nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interr=
upt mask set, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
 nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interr=
upt mask clr, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
 nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=3D0x%=
"PRIx64""
@@ -85,6 +86,7 @@ nvme_err_invalid_create_cq_qflags(uint16_t qflags) "fai=
led creating completion q
 nvme_err_invalid_identify_cns(uint16_t cns) "identify, invalid cns=3D0x%=
"PRIx16""
 nvme_err_invalid_getfeat(int dw10) "invalid get features, dw10=3D0x%"PRI=
x32""
 nvme_err_invalid_setfeat(uint32_t dw10) "invalid set features, dw10=3D0x=
%"PRIx32""
+nvme_err_invalid_log_page(uint16_t cid, uint16_t lid) "cid %"PRIu16" lid=
 0x%"PRIx16""
 nvme_err_startfail_cq(void) "nvme_start_ctrl failed because there are no=
n-admin completion queues"
 nvme_err_startfail_sq(void) "nvme_start_ctrl failed because there are no=
n-admin submission queues"
 nvme_err_startfail_nbarasq(void) "nvme_start_ctrl failed because the adm=
in submission queue address is null"
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 1b0accd4fe2b..a088ec7d4e38 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -515,7 +515,7 @@ enum NvmeSmartWarn {
     NVME_SMART_FAILED_VOLATILE_MEDIA  =3D 1 << 4,
 };
=20
-enum LogIdentifier {
+enum NvmeLogIdentifier {
     NVME_LOG_ERROR_INFO     =3D 0x01,
     NVME_LOG_SMART_INFO     =3D 0x02,
     NVME_LOG_FW_SLOT_INFO   =3D 0x03,
--=20
2.23.0



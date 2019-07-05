Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591C4C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20FA0218BA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20FA0218BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjIf4-0003eQ-ES
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 03:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44207)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <klaus@birkelund.eu>) id 1hjIZr-0005R7-Ao
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <klaus@birkelund.eu>) id 1hjIZn-0005tf-5y
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:24:15 -0400
Received: from charlie.dont.surf ([128.199.63.193]:50538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <klaus@birkelund.eu>)
 id 1hjIZW-0005hX-Ck; Fri, 05 Jul 2019 03:23:54 -0400
Received: from localhost.localdomain (ip-5-186-120-196.cgn.fibianet.dk
 [5.186.120.196])
 by charlie.dont.surf (Postfix) with ESMTPSA id 5F8A5C0637;
 Fri,  5 Jul 2019 07:23:53 +0000 (UTC)
From: Klaus Birkelund Jensen <klaus@birkelund.eu>
To: qemu-block@nongnu.org
Date: Fri,  5 Jul 2019 09:23:27 +0200
Message-Id: <20190705072333.17171-11-klaus@birkelund.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705072333.17171-1-klaus@birkelund.eu>
References: <20190705072333.17171-1-klaus@birkelund.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: [Qemu-devel] [PATCH 10/16] nvme: support Get Log Page command
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

Add support for the Get Log Page command and stub/dumb implementations
of the mandatory Error Information, SMART/Health Information and
Firmware Slot Information log pages.

Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
Section 5.10 ("Get Log Page command").

Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c       | 209 ++++++++++++++++++++++++++++++++++++++++++
 hw/block/nvme.h       |   3 +
 hw/block/trace-events |   3 +
 include/block/nvme.h  |   4 +-
 4 files changed, 217 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index a20576654f1b..93f5dff197e0 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -39,6 +39,8 @@
 #include "nvme.h"
=20
 #define NVME_MAX_QS PCI_MSIX_FLAGS_QSIZE
+#define NVME_TEMPERATURE 0x143
+#define NVME_ELPE 3
 #define NVME_AERL 3
 #define NVME_OP_ABORTED 0xff
 #define NVME_GUEST_ERR(trace, fmt, ...) \
@@ -319,6 +321,36 @@ static void nvme_enqueue_req_completion(NvmeCQueue *=
cq, NvmeRequest *req)
     timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
 }
=20
+static void nvme_enqueue_event(NvmeCtrl *n, uint8_t event_type,
+    uint8_t event_info, uint8_t log_page)
+{
+    NvmeAsyncEvent *event;
+
+    trace_nvme_enqueue_event(event_type, event_info, log_page);
+
+    /*
+     * Do not enqueue the event if something of this type is already que=
ued.
+     * This bounds the size of the event queue and makes sure it does no=
t grow
+     * indefinitely when events are not processed by the host (i.e. does=
 not
+     * issue any AERs).
+     */
+    if (n->aer_mask_queued & (1 << event_type)) {
+        return;
+    }
+    n->aer_mask_queued |=3D (1 << event_type);
+
+    event =3D g_new(NvmeAsyncEvent, 1);
+    event->result =3D (NvmeAerResult) {
+        .event_type =3D event_type,
+        .event_info =3D event_info,
+        .log_page   =3D log_page,
+    };
+
+    QSIMPLEQ_INSERT_TAIL(&n->aer_queue, event, entry);
+
+    timer_mod(n->aer_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500)=
;
+}
+
 static void nvme_process_aers(void *opaque)
 {
     NvmeCtrl *n =3D opaque;
@@ -831,6 +863,10 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
     uint32_t result;
=20
     switch (dw10) {
+    case NVME_TEMPERATURE_THRESHOLD:
+        result =3D cpu_to_le32(n->features.temp_thresh);
+        break;
+    case NVME_ERROR_RECOVERY:
     case NVME_VOLATILE_WRITE_CACHE:
         result =3D blk_enable_write_cache(n->conf.blk);
         trace_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
@@ -878,6 +914,13 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
     uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
=20
     switch (dw10) {
+    case NVME_TEMPERATURE_THRESHOLD:
+        n->features.temp_thresh =3D dw11;
+        if (n->features.temp_thresh <=3D n->temperature) {
+            nvme_enqueue_event(n, NVME_AER_TYPE_SMART,
+                NVME_AER_INFO_SMART_TEMP_THRESH, NVME_LOG_SMART_INFO);
+        }
+        break;
     case NVME_VOLATILE_WRITE_CACHE:
         blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
         break;
@@ -902,6 +945,137 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
     return NVME_SUCCESS;
 }
=20
+static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
+{
+    n->aer_mask &=3D ~(1 << event_type);
+    if (!QSIMPLEQ_EMPTY(&n->aer_queue)) {
+        timer_mod(n->aer_timer,
+            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
+    }
+}
+
+static uint16_t nvme_error_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t r=
ae,
+    uint32_t buf_len, uint64_t off, NvmeRequest *req)
+{
+    uint32_t trans_len;
+    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
+
+    if (off > sizeof(*n->elpes) * (NVME_ELPE + 1)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    trans_len =3D MIN(sizeof(*n->elpes) * (NVME_ELPE + 1) - off, buf_len=
);
+
+    if (!rae) {
+        nvme_clear_events(n, NVME_AER_TYPE_ERROR);
+    }
+
+    return nvme_dma_read_prp(n, (uint8_t *) n->elpes + off, trans_len, p=
rp1,
+        prp2);
+}
+
+static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
+    uint32_t buf_len, uint64_t off, NvmeRequest *req)
+{
+    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
+
+    uint32_t trans_len;
+    time_t current_ms;
+    NvmeSmartLog smart;
+
+    if (cmd->nsid !=3D 0 && cmd->nsid !=3D 0xffffffff) {
+        trace_nvme_err(req->cqe.cid, "smart log not supported for namesp=
ace",
+            NVME_INVALID_FIELD | NVME_DNR);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    if (off > sizeof(smart)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    trans_len =3D MIN(sizeof(smart) - off, buf_len);
+
+    memset(&smart, 0x0, sizeof(smart));
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
+    if (!rae) {
+        nvme_clear_events(n, NVME_AER_TYPE_SMART);
+    }
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
+    uint32_t numdl, numdu, len;
+    uint64_t off, lpol, lpou;
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
+    trace_nvme_get_log(req->cqe.cid, lid);
+
+    switch (lid) {
+    case NVME_LOG_ERROR_INFO:
+        return nvme_error_log_info(n, cmd, rae, len, off, req);
+    case NVME_LOG_SMART_INFO:
+        return nvme_smart_info(n, cmd, rae, len, off, req);
+    case NVME_LOG_FW_SLOT_INFO:
+        return nvme_fw_log_info(n, cmd, len, off, req);
+    default:
+        trace_nvme_err_invalid_log_page(req->cqe.cid, lid);
+        return NVME_INVALID_LOG_ID | NVME_DNR;
+    }
+}
+
 static uint16_t nvme_aer(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
     trace_nvme_aer(req->cqe.cid);
@@ -982,6 +1156,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd =
*cmd, NvmeRequest *req)
         return nvme_set_feature(n, cmd, req);
     case NVME_ADM_CMD_GET_FEATURES:
         return nvme_get_feature(n, cmd, req);
+    case NVME_ADM_CMD_GET_LOG_PAGE:
+        return nvme_get_log(n, cmd, req);
     case NVME_ADM_CMD_ASYNC_EV_REQ:
         return nvme_aer(n, cmd, req);
     case NVME_ADM_CMD_ABORT:
@@ -1347,6 +1523,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
dr, int val)
                            "completion queue doorbell write"
                            " for nonexistent queue,"
                            " sqid=3D%"PRIu32", ignoring", qid);
+
+            if (n->outstanding_aers) {
+                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
+                    NVME_AER_INFO_ERR_INVALID_DB_REGISTER,
+                    NVME_LOG_ERROR_INFO);
+            }
+
             return;
         }
=20
@@ -1357,6 +1540,12 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
dr, int val)
                            " beyond queue size, sqid=3D%"PRIu32","
                            " new_head=3D%"PRIu16", ignoring",
                            qid, new_head);
+
+            if (n->outstanding_aers) {
+                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
+                    NVME_AER_INFO_ERR_INVALID_DB_VALUE, NVME_LOG_ERROR_I=
NFO);
+            }
+
             return;
         }
=20
@@ -1385,6 +1574,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
dr, int val)
                            "submission queue doorbell write"
                            " for nonexistent queue,"
                            " sqid=3D%"PRIu32", ignoring", qid);
+
+            if (n->outstanding_aers) {
+                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
+                    NVME_AER_INFO_ERR_INVALID_DB_REGISTER,
+                    NVME_LOG_ERROR_INFO);
+            }
+
             return;
         }
=20
@@ -1395,6 +1591,12 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
dr, int val)
                            " beyond queue size, sqid=3D%"PRIu32","
                            " new_tail=3D%"PRIu16", ignoring",
                            qid, new_tail);
+
+            if (n->outstanding_aers) {
+                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
+                    NVME_AER_INFO_ERR_INVALID_DB_VALUE, NVME_LOG_ERROR_I=
NFO);
+            }
+
             return;
         }
=20
@@ -1484,9 +1686,13 @@ static void nvme_init_state(NvmeCtrl *n)
 {
     n->num_namespaces =3D 1;
     n->reg_size =3D pow2ceil(0x1004 + 2 * (n->params.num_queues + 1) * 4=
);
+    n->starttime_ms =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
     n->sq =3D g_new0(NvmeSQueue *, n->params.num_queues);
     n->cq =3D g_new0(NvmeCQueue *, n->params.num_queues);
+    n->elpes =3D g_new0(NvmeErrorLog, NVME_ELPE + 1);
     n->aer_reqs =3D g_new0(NvmeRequest *, NVME_AERL + 1);
+    n->temperature =3D NVME_TEMPERATURE;
+    n->features.temp_thresh =3D 0x14d;
 }
=20
 static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
@@ -1556,6 +1762,8 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     id->acl =3D 3;
     id->aerl =3D NVME_AERL;
     id->frmw =3D 7 << 1;
+    id->lpa =3D 1 << 2;
+    id->elpe =3D NVME_ELPE;
     id->sqes =3D (0x6 << 4) | 0x6;
     id->cqes =3D (0x4 << 4) | 0x4;
     id->nn =3D cpu_to_le32(n->num_namespaces);
@@ -1666,6 +1874,7 @@ static void nvme_exit(PCIDevice *pci_dev)
     nvme_clear_ctrl(n);
     g_free(n->cq);
     g_free(n->sq);
+    g_free(n->elpes);
     g_free(n->aer_reqs);
=20
     if (n->params.cmb_size_mb) {
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 48d26108eef1..ed3fa3faa718 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -77,6 +77,8 @@ typedef struct NvmeCtrl {
     BlockConf    conf;
     NvmeParams   params;
=20
+    uint64_t    starttime_ms;
+    uint16_t    temperature;
     uint32_t    page_size;
     uint16_t    page_bits;
     uint16_t    max_prp_ents;
@@ -99,6 +101,7 @@ typedef struct NvmeCtrl {
     NvmeRequest **aer_reqs;
     QSIMPLEQ_HEAD(, NvmeAsyncEvent) aer_queue;
=20
+    NvmeErrorLog    *elpes;
     NvmeNamespace   namespace;
     NvmeSQueue      **sq;
     NvmeCQueue      **cq;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 5e3919752a90..ed666bbc94f2 100644
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
+nvme_get_log(uint16_t cid, uint16_t lid) "cid %"PRIu16" lid 0x%"PRIx16""
 nvme_process_aers(void) "processing aers"
 nvme_aer(uint16_t cid) "cid %"PRIu16""
 nvme_aer_aerl_exceeded(void) "aerl exceeded"
@@ -67,6 +68,7 @@ nvme_mmio_shutdown_set(void) "shutdown bit set"
 nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
=20
 # nvme traces for error conditions
+nvme_err(uint16_t cid, const char *s, uint16_t status) "cid %"PRIu16" \"=
%s\" status 0x%"PRIx16""
 nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
 nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null o=
r not page aligned: 0x%"PRIx64""
 nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x=
%"PRIx64""
@@ -92,6 +94,7 @@ nvme_err_invalid_create_cq_qflags(uint16_t qflags) "fai=
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
index 1b0accd4fe2b..5a10b8b67468 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -386,8 +386,8 @@ enum NvmeAsyncEventRequest {
     NVME_AER_TYPE_SMART                     =3D 1,
     NVME_AER_TYPE_IO_SPECIFIC               =3D 6,
     NVME_AER_TYPE_VENDOR_SPECIFIC           =3D 7,
-    NVME_AER_INFO_ERR_INVALID_SQ            =3D 0,
-    NVME_AER_INFO_ERR_INVALID_DB            =3D 1,
+    NVME_AER_INFO_ERR_INVALID_DB_REGISTER   =3D 0,
+    NVME_AER_INFO_ERR_INVALID_DB_VALUE      =3D 1,
     NVME_AER_INFO_ERR_DIAG_FAIL             =3D 2,
     NVME_AER_INFO_ERR_PERS_INTERNAL_ERR     =3D 3,
     NVME_AER_INFO_ERR_TRANS_INTERNAL_ERR    =3D 4,
--=20
2.20.1



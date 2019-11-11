Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA62DC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 12:28:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A2F2190F
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 12:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A2F2190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU8nn-0001Zi-Pq
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 07:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iU8lk-0007hC-Uz
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 07:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iU8li-0003SP-K6
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 07:26:08 -0500
Received: from charlie.dont.surf ([128.199.63.193]:52196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1iU8ld-0003OT-Gf; Mon, 11 Nov 2019 07:26:01 -0500
Received: from apples.localdomain (unknown [194.62.217.57])
 by charlie.dont.surf (Postfix) with ESMTPSA id 23C2BBF9A8;
 Mon, 11 Nov 2019 12:26:00 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v3 09/21] nvme: add support for the asynchronous event request
 command
Date: Mon, 11 Nov 2019 13:25:33 +0100
Message-Id: <20191111122545.252478-10-its@irrelevant.dk>
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

Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
Section 5.2 ("Asynchronous Event Request command").

Mostly imported from Keith's qemu-nvme tree. Modified to not enqueue
events if something of the same type is already queued (but not cleared
by the host).

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c       | 180 ++++++++++++++++++++++++++++++++++++++++--
 hw/block/nvme.h       |  13 ++-
 hw/block/trace-events |   8 ++
 include/block/nvme.h  |   4 +-
 4 files changed, 196 insertions(+), 9 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index c50683e0d171..f1a9b2cf5cbd 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -334,6 +334,46 @@ static void nvme_enqueue_req_completion(NvmeCQueue *=
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
+        trace_nvme_enqueue_event_masked(event_type);
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
+    QTAILQ_INSERT_TAIL(&n->aer_queue, event, entry);
+
+    timer_mod(n->aer_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500)=
;
+}
+
+static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
+{
+    n->aer_mask &=3D ~(1 << event_type);
+    if (!QTAILQ_EMPTY(&n->aer_queue)) {
+        timer_mod(n->aer_timer,
+            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
+    }
+}
+
 static void nvme_rw_cb(void *opaque, int ret)
 {
     NvmeRequest *req =3D opaque;
@@ -578,7 +618,7 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *=
cmd)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd,
+static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
     uint32_t buf_len, uint64_t off, NvmeRequest *req)
 {
     uint32_t trans_len;
@@ -591,12 +631,16 @@ static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCm=
d *cmd,
=20
     trans_len =3D MIN(sizeof(*n->elpes) * (n->params.elpe + 1) - off, bu=
f_len);
=20
+    if (!rae) {
+        nvme_clear_events(n, NVME_AER_TYPE_ERROR);
+    }
+
     return nvme_dma_read_prp(n, (uint8_t *) n->elpes + off, trans_len, p=
rp1,
         prp2);
 }
=20
-static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_=
len,
-    uint64_t off, NvmeRequest *req)
+static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
+    uint32_t buf_len, uint64_t off, NvmeRequest *req)
 {
     uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
     uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
@@ -645,6 +689,10 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd=
 *cmd, uint32_t buf_len,
     smart.power_on_hours[0] =3D cpu_to_le64(
         (((current_ms - n->starttime_ms) / 1000) / 60) / 60);
=20
+    if (!rae) {
+        nvme_clear_events(n, NVME_AER_TYPE_SMART);
+    }
+
     return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp=
1,
         prp2);
 }
@@ -697,9 +745,9 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cm=
d, NvmeRequest *req)
=20
     switch (lid) {
     case NVME_LOG_ERROR_INFO:
-        return nvme_error_info(n, cmd, len, off, req);
+        return nvme_error_info(n, cmd, rae, len, off, req);
     case NVME_LOG_SMART_INFO:
-        return nvme_smart_info(n, cmd, len, off, req);
+        return nvme_smart_info(n, cmd, rae, len, off, req);
     case NVME_LOG_FW_SLOT_INFO:
         return nvme_fw_log_info(n, cmd, len, off, req);
     default:
@@ -957,6 +1005,9 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
         break;
     case NVME_TIMESTAMP:
         return nvme_get_feature_timestamp(n, cmd);
+    case NVME_ASYNCHRONOUS_EVENT_CONF:
+        result =3D cpu_to_le32(n->features.async_config);
+        break;
     default:
         trace_nvme_err_invalid_getfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -992,6 +1043,12 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
     switch (dw10) {
     case NVME_TEMPERATURE_THRESHOLD:
         n->features.temp_thresh =3D dw11;
+
+        if (n->features.temp_thresh <=3D n->temperature) {
+            nvme_enqueue_event(n, NVME_AER_TYPE_SMART,
+                NVME_AER_INFO_SMART_TEMP_THRESH, NVME_LOG_SMART_INFO);
+        }
+
         break;
=20
     case NVME_VOLATILE_WRITE_CACHE:
@@ -1007,6 +1064,9 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
         break;
     case NVME_TIMESTAMP:
         return nvme_set_feature_timestamp(n, cmd);
+    case NVME_ASYNCHRONOUS_EVENT_CONF:
+        n->features.async_config =3D dw11;
+        break;
     default:
         trace_nvme_err_invalid_setfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1015,6 +1075,22 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, Nvme=
Cmd *cmd, NvmeRequest *req)
     return NVME_SUCCESS;
 }
=20
+static uint16_t nvme_aer(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+{
+    trace_nvme_aer(req->cid);
+
+    if (n->outstanding_aers > n->params.aerl) {
+        trace_nvme_aer_aerl_exceeded();
+        return NVME_AER_LIMIT_EXCEEDED;
+    }
+
+    n->aer_reqs[n->outstanding_aers] =3D req;
+    timer_mod(n->aer_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500)=
;
+    n->outstanding_aers++;
+
+    return NVME_NO_COMPLETE;
+}
+
 static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *r=
eq)
 {
     switch (cmd->opcode) {
@@ -1036,12 +1112,60 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
         return nvme_set_feature(n, cmd, req);
     case NVME_ADM_CMD_GET_FEATURES:
         return nvme_get_feature(n, cmd, req);
+    case NVME_ADM_CMD_ASYNC_EV_REQ:
+        return nvme_aer(n, cmd, req);
     default:
         trace_nvme_err_invalid_admin_opc(cmd->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
 }
=20
+static void nvme_process_aers(void *opaque)
+{
+    NvmeCtrl *n =3D opaque;
+    NvmeAsyncEvent *event, *next;
+
+    trace_nvme_process_aers();
+
+    QTAILQ_FOREACH_SAFE(event, &n->aer_queue, entry, next) {
+        NvmeRequest *req;
+        NvmeAerResult *result;
+
+        /* can't post cqe if there is nothing to complete */
+        if (!n->outstanding_aers) {
+            trace_nvme_no_outstanding_aers();
+            break;
+        }
+
+        /* ignore if masked (cqe posted, but event not cleared) */
+        if (n->aer_mask & (1 << event->result.event_type)) {
+            trace_nvme_aer_masked(event->result.event_type, n->aer_mask)=
;
+            continue;
+        }
+
+        QTAILQ_REMOVE(&n->aer_queue, event, entry);
+
+        n->aer_mask |=3D 1 << event->result.event_type;
+        n->aer_mask_queued &=3D ~(1 << event->result.event_type);
+        n->outstanding_aers--;
+
+        req =3D n->aer_reqs[n->outstanding_aers];
+
+        result =3D (NvmeAerResult *) &req->cqe.result;
+        result->event_type =3D event->result.event_type;
+        result->event_info =3D event->result.event_info;
+        result->log_page =3D event->result.log_page;
+        g_free(event);
+
+        req->status =3D NVME_SUCCESS;
+
+        trace_nvme_aer_post_cqe(result->event_type, result->event_info,
+            result->log_page);
+
+        nvme_enqueue_req_completion(&n->admin_cq, req);
+    }
+}
+
 static void nvme_process_sq(void *opaque)
 {
     NvmeSQueue *sq =3D opaque;
@@ -1091,6 +1215,20 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
         }
     }
=20
+    if (n->aer_timer) {
+        timer_del(n->aer_timer);
+        timer_free(n->aer_timer);
+        n->aer_timer =3D NULL;
+    }
+
+    while (!QTAILQ_EMPTY(&n->aer_queue)) {
+        NvmeAsyncEvent *event =3D QTAILQ_FIRST(&n->aer_queue);
+        QTAILQ_REMOVE(&n->aer_queue, event, entry);
+        g_free(event);
+    }
+
+    n->outstanding_aers =3D 0;
+
     blk_flush(n->conf.blk);
     n->bar.cc =3D 0;
 }
@@ -1187,6 +1325,9 @@ static int nvme_start_ctrl(NvmeCtrl *n)
=20
     nvme_set_timestamp(n, 0ULL);
=20
+    n->aer_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_process_aers,=
 n);
+    QTAILQ_INIT(&n->aer_queue);
+
     return 0;
 }
=20
@@ -1379,6 +1520,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
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
@@ -1389,6 +1537,12 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
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
@@ -1417,6 +1571,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
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
@@ -1427,6 +1588,12 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
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
@@ -1523,6 +1690,7 @@ static void nvme_init_state(NvmeCtrl *n)
     n->starttime_ms =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
     n->temperature =3D NVME_TEMPERATURE;
     n->features.temp_thresh =3D 0x14d;
+    n->aer_reqs =3D g_new0(NvmeRequest *, n->params.aerl + 1);
 }
=20
 static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
@@ -1590,6 +1758,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     id->ver =3D cpu_to_le32(0x00010201);
     id->oacs =3D cpu_to_le16(0);
     id->acl =3D 3;
+    id->aerl =3D n->params.aerl;
     id->frmw =3D 7 << 1;
     id->lpa =3D 1 << 2;
     id->elpe =3D n->params.elpe;
@@ -1677,6 +1846,7 @@ static void nvme_exit(PCIDevice *pci_dev)
     g_free(n->cq);
     g_free(n->sq);
     g_free(n->elpes);
+    g_free(n->aer_reqs);
=20
     if (n->params.cmb_size_mb) {
         g_free(n->cmbuf);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index fcfd504e3f9f..3fc36f577b46 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -7,17 +7,19 @@
     DEFINE_PROP_STRING("serial", _state, _props.serial), \
     DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
     DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64), \
-    DEFINE_PROP_UINT8("elpe", _state, _props.elpe, 24)
+    DEFINE_PROP_UINT8("elpe", _state, _props.elpe, 24), \
+    DEFINE_PROP_UINT8("aerl", _state, _props.aerl, 3)
=20
 typedef struct NvmeParams {
     char     *serial;
     uint32_t num_queues;
     uint32_t cmb_size_mb;
     uint8_t  elpe;
+    uint8_t  aerl;
 } NvmeParams;
=20
 typedef struct NvmeAsyncEvent {
-    QSIMPLEQ_ENTRY(NvmeAsyncEvent) entry;
+    QTAILQ_ENTRY(NvmeAsyncEvent) entry;
     NvmeAerResult result;
 } NvmeAsyncEvent;
=20
@@ -89,6 +91,7 @@ typedef struct NvmeCtrl {
     uint32_t    num_namespaces;
     uint32_t    max_q_ents;
     uint64_t    ns_size;
+    uint8_t     outstanding_aers;
     uint32_t    cmbsz;
     uint32_t    cmbloc;
     uint8_t     *cmbuf;
@@ -98,6 +101,12 @@ typedef struct NvmeCtrl {
     uint64_t    starttime_ms;
     uint16_t    temperature;
=20
+    QEMUTimer   *aer_timer;
+    uint8_t     aer_mask;
+    uint8_t     aer_mask_queued;
+    NvmeRequest **aer_reqs;
+    QTAILQ_HEAD(, NvmeAsyncEvent) aer_queue;
+
     NvmeNamespace   *namespaces;
     NvmeSQueue      **sq;
     NvmeCQueue      **cq;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index a2c7919c861e..6ddb13d34061 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -47,6 +47,14 @@ nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int=
 gotsq) "requested cq_coun
 nvme_setfeat_timestamp(uint64_t ts) "set feature timestamp =3D 0x%"PRIx6=
4""
 nvme_getfeat_timestamp(uint64_t ts) "get feature timestamp =3D 0x%"PRIx6=
4""
 nvme_get_log(uint16_t cid, uint16_t lid, uint8_t rae, uint32_t len, uint=
64_t off) "cid %"PRIu16" lid 0x%"PRIx16" rae 0x%"PRIx8" len %"PRIu32" off=
 %"PRIu64""
+nvme_process_aers(void) "processing aers"
+nvme_aer(uint16_t cid) "cid %"PRIu16""
+nvme_aer_aerl_exceeded(void) "aerl exceeded"
+nvme_aer_masked(uint8_t type, uint8_t mask) "type 0x%"PRIx8" mask 0x%"PR=
Ix8""
+nvme_aer_post_cqe(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%=
"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
+nvme_enqueue_event(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x=
%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
+nvme_enqueue_event_masked(uint8_t typ) "type 0x%"PRIx8""
+nvme_no_outstanding_aers(void) "ignoring event; no outstanding AERs"
 nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interr=
upt mask set, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
 nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interr=
upt mask clr, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
 nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=3D0x%=
"PRIx64""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 52abc3297b62..ded2ade1b462 100644
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
2.24.0



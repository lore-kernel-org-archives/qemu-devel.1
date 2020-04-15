Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6248C3815B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 05:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D8A02076A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 05:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8A02076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOb5K-0006Wv-JQ
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 01:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOayk-00023m-KH
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOayi-0002fU-AP
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:52:54 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47260)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOayZ-0002QD-L4; Wed, 15 Apr 2020 01:52:43 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 75934BFD4F;
 Wed, 15 Apr 2020 05:52:22 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 14/48] nvme: add support for the asynchronous event request
 command
Date: Wed, 15 Apr 2020 07:51:06 +0200
Message-Id: <20200415055140.466900-15-its@irrelevant.dk>
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

Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
Section 5.2 ("Asynchronous Event Request command").

Mostly imported from Keith's qemu-nvme tree. Modified with a max number
of queued events (controllable with the aer_max_queued device
parameter). The spec states that the controller *should* retain
events, so we do best effort here.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c       | 178 ++++++++++++++++++++++++++++++++++++++++--
 hw/block/nvme.h       |  14 +++-
 hw/block/trace-events |   9 +++
 include/block/nvme.h  |   8 +-
 4 files changed, 199 insertions(+), 10 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 76acc112fa7e..b45840ddf8b3 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -325,6 +325,85 @@ static void nvme_enqueue_req_completion(NvmeCQueue *=
cq, NvmeRequest *req)
     timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
 }
=20
+static void nvme_process_aers(void *opaque)
+{
+    NvmeCtrl *n =3D opaque;
+    NvmeAsyncEvent *event, *next;
+
+    trace_nvme_dev_process_aers(n->aer_queued);
+
+    QTAILQ_FOREACH_SAFE(event, &n->aer_queue, entry, next) {
+        NvmeRequest *req;
+        NvmeAerResult *result;
+
+        /* can't post cqe if there is nothing to complete */
+        if (!n->outstanding_aers) {
+            trace_nvme_dev_no_outstanding_aers();
+            break;
+        }
+
+        /* ignore if masked (cqe posted, but event not cleared) */
+        if (n->aer_mask & (1 << event->result.event_type)) {
+            trace_nvme_dev_aer_masked(event->result.event_type, n->aer_m=
ask);
+            continue;
+        }
+
+        QTAILQ_REMOVE(&n->aer_queue, event, entry);
+        n->aer_queued--;
+
+        n->aer_mask |=3D 1 << event->result.event_type;
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
+        trace_nvme_dev_aer_post_cqe(result->event_type, result->event_in=
fo,
+                                    result->log_page);
+
+        nvme_enqueue_req_completion(&n->admin_cq, req);
+    }
+}
+
+static void nvme_enqueue_event(NvmeCtrl *n, uint8_t event_type,
+                               uint8_t event_info, uint8_t log_page)
+{
+    NvmeAsyncEvent *event;
+
+    trace_nvme_dev_enqueue_event(event_type, event_info, log_page);
+
+    if (n->aer_queued =3D=3D n->params.aer_max_queued) {
+        trace_nvme_dev_enqueue_event_noqueue(n->aer_queued);
+        return;
+    }
+
+    event =3D g_new(NvmeAsyncEvent, 1);
+    event->result =3D (NvmeAerResult) {
+        .event_type =3D event_type,
+        .event_info =3D event_info,
+        .log_page   =3D log_page,
+    };
+
+    QTAILQ_INSERT_TAIL(&n->aer_queue, event, entry);
+    n->aer_queued++;
+
+    nvme_process_aers(n);
+}
+
+static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
+{
+    n->aer_mask &=3D ~(1 << event_type);
+    if (!QTAILQ_EMPTY(&n->aer_queue)) {
+        nvme_process_aers(n);
+    }
+}
+
 static void nvme_rw_cb(void *opaque, int ret)
 {
     NvmeRequest *req =3D opaque;
@@ -569,8 +648,9 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *=
cmd)
     return NVME_SUCCESS;
 }
=20
-static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_=
len,
-                                uint64_t off, NvmeRequest *req)
+static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
+                                uint32_t buf_len, uint64_t off,
+                                NvmeRequest *req)
 {
     uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
     uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
@@ -619,6 +699,10 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd=
 *cmd, uint32_t buf_len,
     smart.power_on_hours[0] =3D
         cpu_to_le64((((current_ms - n->starttime_ms) / 1000) / 60) / 60)=
;
=20
+    if (!rae) {
+        nvme_clear_events(n, NVME_AER_TYPE_SMART);
+    }
+
     return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp=
1,
                              prp2);
 }
@@ -643,14 +727,19 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeC=
md *cmd, uint32_t buf_len,
                              prp2);
 }
=20
-static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_=
len,
-                                uint64_t off, NvmeRequest *req)
+static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
+                                uint32_t buf_len, uint64_t off,
+                                NvmeRequest *req)
 {
     uint32_t trans_len;
     uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
     uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
     NvmeErrorLog errlog;
=20
+    if (!rae) {
+        nvme_clear_events(n, NVME_AER_TYPE_ERROR);
+    }
+
     if (off > sizeof(errlog)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
@@ -690,9 +779,9 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cm=
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
@@ -969,6 +1058,9 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
         break;
     case NVME_TIMESTAMP:
         return nvme_get_feature_timestamp(n, cmd);
+    case NVME_ASYNCHRONOUS_EVENT_CONF:
+        result =3D cpu_to_le32(n->features.async_config);
+        break;
     default:
         trace_nvme_dev_err_invalid_getfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1018,6 +1110,14 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, Nvme=
Cmd *cmd, NvmeRequest *req)
             return NVME_INVALID_FIELD | NVME_DNR;
         }
=20
+        if (((n->temperature > n->features.temp_thresh_hi) ||
+            (n->temperature < n->features.temp_thresh_low)) &&
+            NVME_AEC_SMART(n->features.async_config) & NVME_SMART_TEMPER=
ATURE) {
+            nvme_enqueue_event(n, NVME_AER_TYPE_SMART,
+                               NVME_AER_INFO_SMART_TEMP_THRESH,
+                               NVME_LOG_SMART_INFO);
+        }
+
         break;
     case NVME_VOLATILE_WRITE_CACHE:
         blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
@@ -1032,6 +1132,9 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
         break;
     case NVME_TIMESTAMP:
         return nvme_set_feature_timestamp(n, cmd);
+    case NVME_ASYNCHRONOUS_EVENT_CONF:
+        n->features.async_config =3D dw11;
+        break;
     default:
         trace_nvme_dev_err_invalid_setfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1039,6 +1142,25 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, Nvme=
Cmd *cmd, NvmeRequest *req)
     return NVME_SUCCESS;
 }
=20
+static uint16_t nvme_aer(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+{
+    trace_nvme_dev_aer(nvme_cid(req));
+
+    if (n->outstanding_aers > n->params.aerl) {
+        trace_nvme_dev_aer_aerl_exceeded();
+        return NVME_AER_LIMIT_EXCEEDED;
+    }
+
+    n->aer_reqs[n->outstanding_aers] =3D req;
+    n->outstanding_aers++;
+
+    if (!QTAILQ_EMPTY(&n->aer_queue)) {
+        nvme_process_aers(n);
+    }
+
+    return NVME_NO_COMPLETE;
+}
+
 static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *r=
eq)
 {
     switch (cmd->opcode) {
@@ -1060,6 +1182,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
         return nvme_set_feature(n, cmd, req);
     case NVME_ADM_CMD_GET_FEATURES:
         return nvme_get_feature(n, cmd, req);
+    case NVME_ADM_CMD_ASYNC_EV_REQ:
+        return nvme_aer(n, cmd, req);
     default:
         trace_nvme_dev_err_invalid_admin_opc(cmd->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
@@ -1114,6 +1238,15 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
         }
     }
=20
+    while (!QTAILQ_EMPTY(&n->aer_queue)) {
+        NvmeAsyncEvent *event =3D QTAILQ_FIRST(&n->aer_queue);
+        QTAILQ_REMOVE(&n->aer_queue, event, entry);
+        g_free(event);
+    }
+
+    n->aer_queued =3D 0;
+    n->outstanding_aers =3D 0;
+
     blk_flush(n->conf.blk);
     n->bar.cc =3D 0;
 }
@@ -1210,6 +1343,8 @@ static int nvme_start_ctrl(NvmeCtrl *n)
=20
     nvme_set_timestamp(n, 0ULL);
=20
+    QTAILQ_INIT(&n->aer_queue);
+
     return 0;
 }
=20
@@ -1400,6 +1535,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
dr, int val)
                            "completion queue doorbell write"
                            " for nonexistent queue,"
                            " sqid=3D%"PRIu32", ignoring", qid);
+
+            if (n->outstanding_aers) {
+                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
+                                   NVME_AER_INFO_ERR_INVALID_DB_REGISTER=
,
+                                   NVME_LOG_ERROR_INFO);
+            }
+
             return;
         }
=20
@@ -1410,6 +1552,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
dr, int val)
                            " beyond queue size, sqid=3D%"PRIu32","
                            " new_head=3D%"PRIu16", ignoring",
                            qid, new_head);
+
+            if (n->outstanding_aers) {
+                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
+                                   NVME_AER_INFO_ERR_INVALID_DB_VALUE,
+                                   NVME_LOG_ERROR_INFO);
+            }
+
             return;
         }
=20
@@ -1438,6 +1587,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
dr, int val)
                            "submission queue doorbell write"
                            " for nonexistent queue,"
                            " sqid=3D%"PRIu32", ignoring", qid);
+
+            if (n->outstanding_aers) {
+                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
+                                   NVME_AER_INFO_ERR_INVALID_DB_REGISTER=
,
+                                   NVME_LOG_ERROR_INFO);
+            }
+
             return;
         }
=20
@@ -1448,6 +1604,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
dr, int val)
                            " beyond queue size, sqid=3D%"PRIu32","
                            " new_tail=3D%"PRIu16", ignoring",
                            qid, new_tail);
+
+            if (n->outstanding_aers) {
+                nvme_enqueue_event(n, NVME_AER_TYPE_ERROR,
+                                   NVME_AER_INFO_ERR_INVALID_DB_VALUE,
+                                   NVME_LOG_ERROR_INFO);
+            }
+
             return;
         }
=20
@@ -1552,6 +1715,7 @@ static void nvme_init_state(NvmeCtrl *n)
     n->temperature =3D NVME_TEMPERATURE;
     n->features.temp_thresh_hi =3D NVME_TEMPERATURE_WARNING;
     n->starttime_ms =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    n->aer_reqs =3D g_new0(NvmeRequest *, n->params.aerl + 1);
 }
=20
 static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
@@ -1627,6 +1791,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
      * inconsequential.
      */
     id->acl =3D 3;
+    id->aerl =3D n->params.aerl;
     id->frmw =3D 7 << 1;
     id->lpa =3D 1 << 2;
=20
@@ -1712,6 +1877,7 @@ static void nvme_exit(PCIDevice *pci_dev)
     g_free(n->namespaces);
     g_free(n->cq);
     g_free(n->sq);
+    g_free(n->aer_reqs);
=20
     if (n->params.cmb_size_mb) {
         g_free(n->cmbuf);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 54644815e10a..321d37aeaca4 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -7,17 +7,21 @@
     DEFINE_PROP_STRING("serial", _state, _props.serial), \
     DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
     DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 0), \
-    DEFINE_PROP_UINT32("max_ioqpairs", _state, _props.max_ioqpairs, 64)
+    DEFINE_PROP_UINT32("max_ioqpairs", _state, _props.max_ioqpairs, 64),=
 \
+    DEFINE_PROP_UINT8("aerl", _state, _props.aerl, 3), \
+    DEFINE_PROP_UINT32("aer_max_queued", _state, _props.aer_max_queued, =
64)
=20
 typedef struct NvmeParams {
     char     *serial;
     uint32_t num_queues;
     uint32_t max_ioqpairs;
     uint32_t cmb_size_mb;
+    uint8_t  aerl;
+    uint32_t aer_max_queued;
 } NvmeParams;
=20
 typedef struct NvmeAsyncEvent {
-    QSIMPLEQ_ENTRY(NvmeAsyncEvent) entry;
+    QTAILQ_ENTRY(NvmeAsyncEvent) entry;
     NvmeAerResult result;
 } NvmeAsyncEvent;
=20
@@ -104,6 +108,7 @@ typedef struct NvmeCtrl {
     uint32_t    num_namespaces;
     uint32_t    max_q_ents;
     uint64_t    ns_size;
+    uint8_t     outstanding_aers;
     uint8_t     *cmbuf;
     uint64_t    irq_status;
     uint64_t    host_timestamp;                 /* Timestamp sent by the=
 host */
@@ -111,6 +116,11 @@ typedef struct NvmeCtrl {
     uint64_t    starttime_ms;
     uint16_t    temperature;
=20
+    uint8_t     aer_mask;
+    NvmeRequest **aer_reqs;
+    QTAILQ_HEAD(, NvmeAsyncEvent) aer_queue;
+    int         aer_queued;
+
     NvmeNamespace   *namespaces;
     NvmeSQueue      **sq;
     NvmeCQueue      **cq;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 1a5b5d764594..a0a6de7dd5aa 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -47,6 +47,15 @@ nvme_dev_setfeat_numq(int reqcq, int reqsq, int gotcq,=
 int gotsq) "requested cq_
 nvme_dev_setfeat_timestamp(uint64_t ts) "set feature timestamp =3D 0x%"P=
RIx64""
 nvme_dev_getfeat_timestamp(uint64_t ts) "get feature timestamp =3D 0x%"P=
RIx64""
 nvme_dev_get_log(uint16_t cid, uint8_t lid, uint8_t rae, uint32_t len, u=
int64_t off) "cid %"PRIu16" lid 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" o=
ff %"PRIu64""
+nvme_dev_process_aers(int queued) "queued %d"
+nvme_dev_aer(uint16_t cid) "cid %"PRIu16""
+nvme_dev_aer_aerl_exceeded(void) "aerl exceeded"
+nvme_dev_aer_masked(uint8_t type, uint8_t mask) "type 0x%"PRIx8" mask 0x=
%"PRIx8""
+nvme_dev_aer_post_cqe(uint8_t typ, uint8_t info, uint8_t log_page) "type=
 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
+nvme_dev_enqueue_event(uint8_t typ, uint8_t info, uint8_t log_page) "typ=
e 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
+nvme_dev_enqueue_event_noqueue(int queued) "queued %d"
+nvme_dev_enqueue_event_masked(uint8_t typ) "type 0x%"PRIx8""
+nvme_dev_no_outstanding_aers(void) "ignoring event; no outstanding AERs"
 nvme_dev_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, in=
terrupt mask set, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
 nvme_dev_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, in=
terrupt mask clr, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
 nvme_dev_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=3D=
0x%"PRIx64""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index a0519814ecec..0df5534cb8bf 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -425,8 +425,8 @@ enum NvmeAsyncEventRequest {
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
@@ -722,6 +722,10 @@ typedef struct NvmeFeatureVal {
=20
 #define NVME_TEMP_TMPTH(temp) ((temp >>  0) & 0xffff)
=20
+#define NVME_AEC_SMART(aec)         (aec & 0xff)
+#define NVME_AEC_NS_ATTR(aec)       ((aec >> 8) & 0x1)
+#define NVME_AEC_FW_ACTIVATION(aec) ((aec >> 9) & 0x1)
+
 enum NvmeFeatureIds {
     NVME_ARBITRATION                =3D 0x1,
     NVME_POWER_MANAGEMENT           =3D 0x2,
--=20
2.26.0



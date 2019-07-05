Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C08CC5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91DF218BE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91DF218BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjIha-00072q-8h
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 03:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44206)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <klaus@birkelund.eu>) id 1hjIZr-0005R6-Ac
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <klaus@birkelund.eu>) id 1hjIZn-0005te-5y
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:24:15 -0400
Received: from charlie.dont.surf ([128.199.63.193]:50534)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <klaus@birkelund.eu>)
 id 1hjIZW-0005hD-3l; Fri, 05 Jul 2019 03:23:54 -0400
Received: from localhost.localdomain (ip-5-186-120-196.cgn.fibianet.dk
 [5.186.120.196])
 by charlie.dont.surf (Postfix) with ESMTPSA id 26896C062D;
 Fri,  5 Jul 2019 07:23:53 +0000 (UTC)
From: Klaus Birkelund Jensen <klaus@birkelund.eu>
To: qemu-block@nongnu.org
Date: Fri,  5 Jul 2019 09:23:26 +0200
Message-Id: <20190705072333.17171-10-klaus@birkelund.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705072333.17171-1-klaus@birkelund.eu>
References: <20190705072333.17171-1-klaus@birkelund.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: [Qemu-devel] [PATCH 09/16] nvme: support Asynchronous Event Request
 command
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

Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
Section 5.2 ("Asynchronous Event Request command").

Modified from Keith's qemu-nvme tree.

Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c       | 88 ++++++++++++++++++++++++++++++++++++++++++-
 hw/block/nvme.h       |  7 ++++
 hw/block/trace-events |  7 ++++
 3 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index eb6af6508e2d..a20576654f1b 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -39,6 +39,7 @@
 #include "nvme.h"
=20
 #define NVME_MAX_QS PCI_MSIX_FLAGS_QSIZE
+#define NVME_AERL 3
 #define NVME_OP_ABORTED 0xff
 #define NVME_GUEST_ERR(trace, fmt, ...) \
     do { \
@@ -318,6 +319,51 @@ static void nvme_enqueue_req_completion(NvmeCQueue *=
cq, NvmeRequest *req)
     timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
 }
=20
+static void nvme_process_aers(void *opaque)
+{
+    NvmeCtrl *n =3D opaque;
+    NvmeRequest *req;
+    NvmeAerResult *result;
+    NvmeAsyncEvent *event, *next;
+
+    trace_nvme_process_aers();
+
+    QSIMPLEQ_FOREACH_SAFE(event, &n->aer_queue, entry, next) {
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
+        QSIMPLEQ_REMOVE_HEAD(&n->aer_queue, entry);
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
 static void nvme_rw_cb(void *opaque, int ret)
 {
     NvmeRequest *req =3D opaque;
@@ -796,6 +842,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
         break;
     case NVME_TIMESTAMP:
         return nvme_get_feature_timestamp(n, cmd);
+    case NVME_ASYNCHRONOUS_EVENT_CONF:
+        result =3D cpu_to_le32(n->features.async_config);
         break;
     default:
         trace_nvme_err_invalid_getfeat(dw10);
@@ -841,11 +889,11 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
md *cmd, NvmeRequest *req)
         req->cqe.result =3D cpu_to_le32((n->params.num_queues - 2) |
             ((n->params.num_queues - 2) << 16));
         break;
-
     case NVME_TIMESTAMP:
         return nvme_set_feature_timestamp(n, cmd);
+    case NVME_ASYNCHRONOUS_EVENT_CONF:
+        n->features.async_config =3D dw11;
         break;
-
     default:
         trace_nvme_err_invalid_setfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -854,6 +902,22 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
     return NVME_SUCCESS;
 }
=20
+static uint16_t nvme_aer(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+{
+    trace_nvme_aer(req->cqe.cid);
+
+    if (n->outstanding_aers > NVME_AERL) {
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
 static uint16_t nvme_abort(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
     NvmeSQueue *sq;
@@ -918,6 +982,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *=
cmd, NvmeRequest *req)
         return nvme_set_feature(n, cmd, req);
     case NVME_ADM_CMD_GET_FEATURES:
         return nvme_get_feature(n, cmd, req);
+    case NVME_ADM_CMD_ASYNC_EV_REQ:
+        return nvme_aer(n, cmd, req);
     case NVME_ADM_CMD_ABORT:
         return nvme_abort(n, cmd, req);
     default:
@@ -963,6 +1029,7 @@ static void nvme_process_sq(void *opaque)
=20
 static void nvme_clear_ctrl(NvmeCtrl *n)
 {
+    NvmeAsyncEvent *event;
     int i;
=20
     blk_drain(n->conf.blk);
@@ -978,8 +1045,19 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
         }
     }
=20
+    if (n->aer_timer) {
+        timer_del(n->aer_timer);
+        timer_free(n->aer_timer);
+        n->aer_timer =3D NULL;
+    }
+    while ((event =3D QSIMPLEQ_FIRST(&n->aer_queue)) !=3D NULL) {
+        QSIMPLEQ_REMOVE_HEAD(&n->aer_queue, entry);
+        g_free(event);
+    }
+
     blk_flush(n->conf.blk);
     n->bar.cc =3D 0;
+    n->outstanding_aers =3D 0;
 }
=20
 static int nvme_start_ctrl(NvmeCtrl *n)
@@ -1074,6 +1152,9 @@ static int nvme_start_ctrl(NvmeCtrl *n)
=20
     nvme_set_timestamp(n, 0ULL);
=20
+    n->aer_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_process_aers,=
 n);
+    QSIMPLEQ_INIT(&n->aer_queue);
+
     return 0;
 }
=20
@@ -1405,6 +1486,7 @@ static void nvme_init_state(NvmeCtrl *n)
     n->reg_size =3D pow2ceil(0x1004 + 2 * (n->params.num_queues + 1) * 4=
);
     n->sq =3D g_new0(NvmeSQueue *, n->params.num_queues);
     n->cq =3D g_new0(NvmeCQueue *, n->params.num_queues);
+    n->aer_reqs =3D g_new0(NvmeRequest *, NVME_AERL + 1);
 }
=20
 static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
@@ -1472,6 +1554,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     id->ver =3D cpu_to_le32(0x00010201);
     id->oacs =3D cpu_to_le16(0);
     id->acl =3D 3;
+    id->aerl =3D NVME_AERL;
     id->frmw =3D 7 << 1;
     id->sqes =3D (0x6 << 4) | 0x6;
     id->cqes =3D (0x4 << 4) | 0x4;
@@ -1583,6 +1666,7 @@ static void nvme_exit(PCIDevice *pci_dev)
     nvme_clear_ctrl(n);
     g_free(n->cq);
     g_free(n->sq);
+    g_free(n->aer_reqs);
=20
     if (n->params.cmb_size_mb) {
         g_free(n->cmbuf);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index bea622ea71e0..48d26108eef1 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -86,18 +86,25 @@ typedef struct NvmeCtrl {
     uint32_t    num_namespaces;
     uint32_t    max_q_ents;
     uint64_t    ns_size;
+    uint8_t     outstanding_aers;
     uint32_t    cmbsz;
     uint32_t    cmbloc;
     uint8_t     *cmbuf;
     uint64_t    irq_status;
     uint64_t    host_timestamp;                 /* Timestamp sent by the=
 host */
     uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
+    QEMUTimer   *aer_timer;
+    uint8_t     aer_mask;
+    uint8_t     aer_mask_queued;
+    NvmeRequest **aer_reqs;
+    QSIMPLEQ_HEAD(, NvmeAsyncEvent) aer_queue;
=20
     NvmeNamespace   namespace;
     NvmeSQueue      **sq;
     NvmeCQueue      **cq;
     NvmeSQueue      admin_sq;
     NvmeCQueue      admin_cq;
+    NvmeFeatureVal  features;
     NvmeIdCtrl      id_ctrl;
 } NvmeCtrl;
=20
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 13d1b21dd4e4..5e3919752a90 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -46,6 +46,13 @@ nvme_getfeat_numq(int result) "get feature number of q=
ueues, result=3D%d"
 nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested=
 cq_count=3D%d sq_count=3D%d, responding with cq_count=3D%d sq_count=3D%d=
"
 nvme_setfeat_timestamp(uint64_t ts) "set feature timestamp =3D 0x%"PRIx6=
4""
 nvme_getfeat_timestamp(uint64_t ts) "get feature timestamp =3D 0x%"PRIx6=
4""
+nvme_process_aers(void) "processing aers"
+nvme_aer(uint16_t cid) "cid %"PRIu16""
+nvme_aer_aerl_exceeded(void) "aerl exceeded"
+nvme_aer_masked(uint8_t type, uint8_t mask) "type 0x%"PRIx8" mask 0x%"PR=
Ix8""
+nvme_aer_post_cqe(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%=
"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
+nvme_enqueue_event(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x=
%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
+nvme_no_outstanding_aers(void) "ignoring event; no outstanding AERs"
 nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interr=
upt mask set, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
 nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interr=
upt mask clr, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
 nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=3D0x%=
"PRIx64""
--=20
2.20.1



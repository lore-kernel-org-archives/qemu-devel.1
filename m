Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F01C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:09:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47ABF20663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Q47VskJD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47ABF20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwUd-0004TP-VR
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYr-0001bY-Cr
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYn-0006UK-P6
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:49 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55878)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1ihvYm-0006N3-E9
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:44 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20191219130942euoutp02e78b1364ac2779c955faed3f66aab6c5~hx8Jvd5mZ0697606976euoutp02K
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 13:09:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20191219130942euoutp02e78b1364ac2779c955faed3f66aab6c5~hx8Jvd5mZ0697606976euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576760982;
 bh=D7Uu7H/O9k9KLHgU07viEjq4vsmzlQf+Wl5TTb2p8b8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=Q47VskJDdEAqem9wI6Crwq64pODm8zX5zvXqcjXMdeWu90PFSXlXEWbKo7vJsUuzA
 2yG72sPFVi2kSy4+OTeQa7cYe72osAnWybHb0MYkFYigreSa30GKF0pg7Q0GKuEJPv
 XE2S57cLSW9GOlxIW+sTeYq0PI2gILSBrr9qPcAM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20191219130942eucas1p2dca05af2a5d6dd528ee87984274017ec~hx8JiPYsu0349703497eucas1p2K;
 Thu, 19 Dec 2019 13:09:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 86.05.60679.6967BFD5; Thu, 19
 Dec 2019 13:09:42 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20191219130941eucas1p1ac686ade1ad42395500069d8884f9179~hx8JQnQWA1176311763eucas1p13;
 Thu, 19 Dec 2019 13:09:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20191219130941eusmtrp23ef7b14dadba4e1457017f149e7d671a~hx8JQEnIN3097130971eusmtrp2Q;
 Thu, 19 Dec 2019 13:09:41 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-db-5dfb76960c53
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id B5.4D.08375.5967BFD5; Thu, 19
 Dec 2019 13:09:41 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130941eusmtip2de339237da17c35856c1118405ea9a27~hx8JHVkrq2556225562eusmtip2b;
 Thu, 19 Dec 2019 13:09:41 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 19 Dec 2019 13:09:41 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:09:40 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v4 11/24] nvme: add support for the asynchronous event
 request command
Date: Thu, 19 Dec 2019 14:09:08 +0100
Message-ID: <20191219130921.309264-12-k.jensen@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219130921.309264-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djPc7rTyn7HGrQ947bY3N/OaDHp0DVG
 iyUXUy3m3VK2mPWunc3ieO8OFgc2j02rOtk87lzbw+bx5NpmJo/3+66yBbBEcdmkpOZklqUW
 6dslcGVsf7yctWBaecXjP2/YGhhnR3QxcnJICJhIfPyygbmLkYtDSGAFo8SFE3vZIZwvjBIX
 52xkhHA+M0qcfdvMDtPSceAhE0RiOaPE9YdP2eGqJu66A5U5wyix99lhVghnF6PE1a9/2UD6
 2QQ0Jbb/+c8CYosISEu0X50EVsQscJ1R4tDvi2BLhAUiJNad+sAMYrMIqErc/nIUrIFXwFri
 8ckLzBCHyEts/faJFcTmBIpv6b3NCFEjKHFy5hOwemagmuats5khbAmJgy9egP0qIbCKXeJ+
 316gWzmAHBeJUzskIGYKS7w6vgXqURmJ/zvnM0HUdzNK9H34CtU8g1Fi+rLvbBDN1hJ9Z3Ig
 GhwltjWcZIUI80nceCsIsZdPYtK26cwQYV6JjjYhiGo1iR1NWxknMCrPQnL1LCRXz0Jy9QJG
 5lWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiB6eX0v+NfdjDu+pN0iFGAg1GJh/dF8u9Y
 IdbEsuLK3EOMEhzMSiK8tzt+xgrxpiRWVqUW5ccXleakFh9ilOZgURLnNV70MlZIID2xJDU7
 NbUgtQgmy8TBKdXAWLrTQytr3+znJS8dGbnvvOjmX1AQc0Gt1d/+e5DUE66peqtz+Ko7T07j
 mMUjEaAkE7BmW45O9J4YiV67BUIJvPM+XWW8on0qa24Ry562Rub53xpmnXlonXzpm3Faz8y4
 vzseF2aKTyrKmfXmLPv+9Z9zFT/WXtp0uGHbAx/PYzP+Hb1XUj/VT4mlOCPRUIu5qDgRAMkj
 C2grAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xe7pTy37HGnxdZGaxub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ0rMpyi8tSVXI
 yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MvY/ng5a8G08orHf96w
 NTDOjuhi5OSQEDCR6DjwkKmLkYtDSGApo8SrvysYIRIyEp+ufGSHsIUl/lzrYoMo+sgosXLW
 XnYI5wyjxJ/Nu5hBqoQEdjFK/PuXBGKzCWhKbP/znwXEFhGQlmi/OokVpIFZ4DqjxKHfF8HG
 CguESWyY2csEYrMIqErc/nIUrIFXwFri8ckLzBCr5SW2fvvECmJzAsW39N5mhFhmJfH450eo
 ekGJkzOfgNnMQPXNW2czQ9gSEgdfvGCewCg8C0nZLCRls5CULWBkXsUoklpanJueW2yoV5yY
 W1yal66XnJ+7iREYY9uO/dy8g/HSxuBDjAIcjEo8vC+Tf8cKsSaWFVfmHmKU4GBWEuG93fEz
 Vog3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgfGfVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZI
 ID2xJDU7NbUgtQimj4mDU6qBsT/y9u9Zh+Z0C6wr+23d6Z3aH7acna9vB1e7bYifcs636pNR
 5go52jfWtW568+B1VOOCtB8Sk3OzJjz70VTE/+HbpJ8/dkftsEwQ4P/Ce+3PO01RIeHt19YV
 7ZE1EKk4fei0Hk+rhuJHy7XLDlpYllgvrGic4BkVpaBS9qp3rtlPYaVrx7ZlKbEUZyQaajEX
 FScCAP7AmRTHAgAA
X-CMS-MailID: 20191219130941eucas1p1ac686ade1ad42395500069d8884f9179
X-Msg-Generator: CA
X-RootMTR: 20191219130941eucas1p1ac686ade1ad42395500069d8884f9179
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130941eucas1p1ac686ade1ad42395500069d8884f9179
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130941eucas1p1ac686ade1ad42395500069d8884f9179@eucas1p1.samsung.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 210.118.77.12
X-Mailman-Approved-At: Thu, 19 Dec 2019 08:56:47 -0500
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
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
Section 5.2 ("Asynchronous Event Request command").

Mostly imported from Keith's qemu-nvme tree. Modified with a max number
of queued events (controllable with the aer_max_queued device
parameter). The spec states that the controller *should* retain
events, so we do best effort here.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c       | 167 +++++++++++++++++++++++++++++++++++++++++-
 hw/block/nvme.h       |  14 +++-
 hw/block/trace-events |   9 +++
 include/block/nvme.h  |   8 +-
 4 files changed, 191 insertions(+), 7 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 38a555c047d3..113b64ea1843 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -323,6 +323,85 @@ static void nvme_enqueue_req_completion(NvmeCQueue *=
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
+            result->log_page);
+
+        nvme_enqueue_req_completion(&n->admin_cq, req);
+    }
+}
+
+static void nvme_enqueue_event(NvmeCtrl *n, uint8_t event_type,
+    uint8_t event_info, uint8_t log_page)
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
@@ -567,8 +646,8 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *=
cmd)
     return NVME_SUCCESS;
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
@@ -617,6 +696,10 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd=
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
@@ -669,13 +752,17 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *=
cmd, NvmeRequest *req)
=20
     switch (lid) {
     case NVME_LOG_ERROR_INFO:
+        if (!rae) {
+            nvme_clear_events(n, NVME_AER_TYPE_ERROR);
+        }
+
         if (off) {
             return NVME_INVALID_FIELD | NVME_DNR;
         }
=20
         return NVME_SUCCESS;
     case NVME_LOG_SMART_INFO:
-        return nvme_smart_info(n, cmd, len, off, req);
+        return nvme_smart_info(n, cmd, rae, len, off, req);
     case NVME_LOG_FW_SLOT_INFO:
         return nvme_fw_log_info(n, cmd, len, off, req);
     default:
@@ -951,6 +1038,9 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCm=
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
@@ -1000,6 +1090,13 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, Nvme=
Cmd *cmd, NvmeRequest *req)
             return NVME_INVALID_FIELD | NVME_DNR;
         }
=20
+        if (((n->temperature > n->features.temp_thresh_hi) ||
+            (n->temperature < n->features.temp_thresh_low)) &&
+            NVME_AEC_SMART(n->features.async_config) & NVME_SMART_TEMPER=
ATURE) {
+            nvme_enqueue_event(n, NVME_AER_TYPE_SMART,
+                NVME_AER_INFO_SMART_TEMP_THRESH, NVME_LOG_SMART_INFO);
+        }
+
         break;
     case NVME_VOLATILE_WRITE_CACHE:
         blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
@@ -1013,6 +1110,9 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeC=
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
@@ -1021,6 +1121,25 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, Nvme=
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
@@ -1042,6 +1161,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
         return nvme_set_feature(n, cmd, req);
     case NVME_ADM_CMD_GET_FEATURES:
         return nvme_get_feature(n, cmd, req);
+    case NVME_ADM_CMD_ASYNC_EV_REQ:
+        return nvme_aer(n, cmd, req);
     default:
         trace_nvme_dev_err_invalid_admin_opc(cmd->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
@@ -1096,6 +1217,15 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
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
@@ -1192,6 +1322,8 @@ static int nvme_start_ctrl(NvmeCtrl *n)
=20
     nvme_set_timestamp(n, 0ULL);
=20
+    QTAILQ_INIT(&n->aer_queue);
+
     return 0;
 }
=20
@@ -1384,6 +1516,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
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
@@ -1394,6 +1533,12 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
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
@@ -1422,6 +1567,13 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
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
@@ -1432,6 +1584,12 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr ad=
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
@@ -1528,6 +1686,7 @@ static void nvme_init_state(NvmeCtrl *n)
     n->temperature =3D NVME_TEMPERATURE;
     n->features.temp_thresh_hi =3D le16_to_cpu(n->id_ctrl.wctemp);
     n->starttime_ms =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    n->aer_reqs =3D g_new0(NvmeRequest *, n->params.aerl + 1);
 }
=20
 static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
@@ -1607,6 +1766,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
      * inconsequential.
      */
     id->acl =3D 3;
+    id->aerl =3D n->params.aerl;
     id->frmw =3D 7 << 1;
     id->lpa =3D 1 << 2;
=20
@@ -1697,6 +1857,7 @@ static void nvme_exit(PCIDevice *pci_dev)
     g_free(n->namespaces);
     g_free(n->cq);
     g_free(n->sq);
+    g_free(n->aer_reqs);
=20
     if (n->params.cmb_size_mb) {
         g_free(n->cmbuf);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 89b0aafa02a2..1e715ab1d75c 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -6,16 +6,20 @@
 #define DEFINE_NVME_PROPERTIES(_state, _props) \
     DEFINE_PROP_STRING("serial", _state, _props.serial), \
     DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
-    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64)
+    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64), \
+    DEFINE_PROP_UINT8("aerl", _state, _props.aerl, 3), \
+    DEFINE_PROP_UINT32("aer_max_queued", _state, _props.aer_max_queued, =
64)
=20
 typedef struct NvmeParams {
     char     *serial;
     uint32_t num_queues;
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
@@ -102,6 +106,7 @@ typedef struct NvmeCtrl {
     uint32_t    num_namespaces;
     uint32_t    max_q_ents;
     uint64_t    ns_size;
+    uint8_t     outstanding_aers;
     uint32_t    cmbsz;
     uint32_t    cmbloc;
     uint8_t     *cmbuf;
@@ -111,6 +116,11 @@ typedef struct NvmeCtrl {
     uint16_t    temperature;
     uint64_t    starttime_ms;
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
index 7da088479f39..3952c36774cf 100644
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
index 9a6055adeb61..a24be047a311 100644
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
@@ -640,6 +640,10 @@ typedef struct NvmeFeatureVal {
 #define NVME_TEMP_TMPSEL(temp) ((temp >> 16) & 0xf)
 #define NVME_TEMP_TMPTH(temp)  (temp & 0xffff)
=20
+#define NVME_AEC_SMART(aec)         (aec & 0xff)
+#define NVME_AEC_NS_ATTR(aec)       ((aec >> 8) & 0x1)
+#define NVME_AEC_FW_ACTIVATION(aec) ((aec >> 9) & 0x1)
+
 enum NvmeFeatureIds {
     NVME_ARBITRATION                =3D 0x1,
     NVME_POWER_MANAGEMENT           =3D 0x2,
--=20
2.24.1



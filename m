Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544C0C282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 21:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0931E20663
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 21:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0931E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47245 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCWdx-0002XO-Hk
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 17:45:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kenneth.heitke@intel.com>) id 1hCWaZ-0001qc-6e
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 17:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kenneth.heitke@intel.com>) id 1hCWaX-0002DF-NM
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 17:41:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:32221)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kenneth.heitke@intel.com>)
	id 1hCWaS-0001qr-Bv; Fri, 05 Apr 2019 17:41:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 Apr 2019 14:41:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,313,1549958400"; d="scan'208";a="148475450"
Received: from kheitke-ubuntu.lm.intel.com ([10.232.116.89])
	by orsmga002.jf.intel.com with ESMTP; 05 Apr 2019 14:41:17 -0700
From: Kenneth Heitke <kenneth.heitke@intel.com>
To: qemu-block@nongnu.org
Date: Fri,  5 Apr 2019 15:41:17 -0600
Message-Id: <20190405214117.1850-1-kenneth.heitke@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.100
X-Mailman-Approved-At: Fri, 05 Apr 2019 17:44:08 -0400
Subject: [Qemu-devel] [PATCH] nvme: add Get/Set Feature Timestamp support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: keith.busch@intel.com, kwolf@redhat.com,
	Kenneth Heitke <kenneth.heitke@intel.com>, qemu-devel@nongnu.org,
	mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190405214117.ykhj7Yxp88oCOgeukGVB3XgCpeM3JHx0AvgEPpoDbBc@z>

Signed-off-by: Kenneth Heitke <kenneth.heitke@intel.com>
---
 hw/block/nvme.c       | 120 +++++++++++++++++++++++++++++++++++++++++-
 hw/block/nvme.h       |   3 ++
 hw/block/trace-events |   2 +
 include/block/nvme.h  |   2 +
 4 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 7caf92532a..e775e89299 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -219,6 +219,30 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
     return NVME_INVALID_FIELD | NVME_DNR;
 }
 
+static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
+                                   uint64_t prp1, uint64_t prp2)
+{
+    QEMUSGList qsg;
+    QEMUIOVector iov;
+    uint16_t status = NVME_SUCCESS;
+
+    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+    if (qsg.nsg > 0) {
+        if (dma_buf_write(ptr, len, &qsg)) {
+            status = NVME_INVALID_FIELD | NVME_DNR;
+        }
+        qemu_sglist_destroy(&qsg);
+    } else {
+        if (qemu_iovec_from_buf(&iov, 0, ptr, len) != len) {
+            status = NVME_INVALID_FIELD | NVME_DNR;
+        }
+        qemu_iovec_destroy(&iov);
+    }
+    return status;
+}
+
 static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
     uint64_t prp1, uint64_t prp2)
 {
@@ -678,7 +702,6 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
     return ret;
 }
 
-
 static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
 {
     NvmeIdentify *c = (NvmeIdentify *)cmd;
@@ -696,6 +719,63 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
     }
 }
 
+static inline void nvme_set_timestamp(NvmeCtrl *n, uint64_t ts)
+{
+    n->host_timestamp = ts;
+    n->timestamp_set_qemu_clock_ms = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+}
+
+static inline uint64_t nvme_get_timestamp(const NvmeCtrl *n)
+{
+    uint64_t current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    uint64_t elapsed_time = current_time - n->timestamp_set_qemu_clock_ms;
+
+    union nvme_timestamp {
+        struct {
+            uint64_t timestamp:48;
+            uint64_t sync:1;
+            uint64_t origin:3;
+            uint64_t rsvd1:12;
+        };
+        uint64_t all;
+    };
+
+    union nvme_timestamp ts;
+    ts.all = 0;
+
+    /*
+     * If the sum of the Timestamp value set by the host and the elapsed
+     * time exceeds 2^48, the value returned should be reduced modulo 2^48.
+     */
+    ts.timestamp = (n->host_timestamp + elapsed_time) & 0xffffffffffff;
+
+    /* If the host timestamp is non-zero, set the timestamp origin */
+    ts.origin = n->host_timestamp ? 0x01 : 0x00;
+
+    return ts.all;
+}
+
+static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
+{
+    uint32_t dw10 = le32_to_cpu(cmd->cdw10);
+    uint64_t prp1 = le64_to_cpu(cmd->prp1);
+    uint64_t prp2 = le64_to_cpu(cmd->prp2);
+
+    uint64_t timestamp = nvme_get_timestamp(n);
+
+    if (!(n->oncs & NVME_ONCS_TIMESTAMP)) {
+        trace_nvme_err_invalid_getfeat(dw10);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    trace_nvme_getfeat_timestamp(timestamp);
+
+    timestamp = cpu_to_le64(timestamp);
+
+    return nvme_dma_read_prp(n, (uint8_t *)&timestamp,
+                                 sizeof(timestamp), prp1, prp2);
+}
+
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
     uint32_t dw10 = le32_to_cpu(cmd->cdw10);
@@ -710,6 +790,9 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         result = cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16));
         trace_nvme_getfeat_numq(result);
         break;
+    case NVME_TIMESTAMP:
+        return nvme_get_feature_timestamp(n, cmd);
+        break;
     default:
         trace_nvme_err_invalid_getfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -719,6 +802,31 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     return NVME_SUCCESS;
 }
 
+static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
+{
+    uint16_t ret;
+    uint64_t timestamp;
+    uint32_t dw10 = le32_to_cpu(cmd->cdw10);
+    uint64_t prp1 = le64_to_cpu(cmd->prp1);
+    uint64_t prp2 = le64_to_cpu(cmd->prp2);
+
+    if (!(n->oncs & NVME_ONCS_TIMESTAMP)) {
+        trace_nvme_err_invalid_setfeat(dw10);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    ret = nvme_dma_write_prp(n, (uint8_t *)&timestamp,
+                                sizeof(timestamp), prp1, prp2);
+    if (ret != NVME_SUCCESS) {
+        return ret;
+    }
+
+    nvme_set_timestamp(n, le64_to_cpu(timestamp));
+    trace_nvme_setfeat_timestamp(timestamp);
+
+    return NVME_SUCCESS;
+}
+
 static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
     uint32_t dw10 = le32_to_cpu(cmd->cdw10);
@@ -735,6 +843,11 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         req->cqe.result =
             cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16));
         break;
+
+    case NVME_TIMESTAMP:
+        return nvme_set_feature_timestamp(n, cmd);
+        break;
+
     default:
         trace_nvme_err_invalid_setfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -907,6 +1020,8 @@ static int nvme_start_ctrl(NvmeCtrl *n)
     nvme_init_sq(&n->admin_sq, n, n->bar.asq, 0, 0,
         NVME_AQA_ASQS(n->bar.aqa) + 1);
 
+    nvme_set_timestamp(n, 0ULL);
+
     return 0;
 }
 
@@ -1270,7 +1385,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     id->sqes = (0x6 << 4) | 0x6;
     id->cqes = (0x4 << 4) | 0x4;
     id->nn = cpu_to_le32(n->num_namespaces);
-    id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROS);
+    id->oncs = cpu_to_le16(n->oncs);
     id->psd[0].mp = cpu_to_le16(0x9c4);
     id->psd[0].enlat = cpu_to_le32(0x10);
     id->psd[0].exlat = cpu_to_le32(0x4);
@@ -1350,6 +1465,7 @@ static Property nvme_props[] = {
     DEFINE_PROP_STRING("serial", NvmeCtrl, serial),
     DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, cmb_size_mb, 0),
     DEFINE_PROP_UINT32("num_queues", NvmeCtrl, num_queues, 64),
+    DEFINE_PROP_UINT16("oncs", NvmeCtrl, oncs, NVME_ONCS_WRITE_ZEROS),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 56c9d4b4b1..d7277e72b7 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -69,6 +69,7 @@ typedef struct NvmeCtrl {
     uint16_t    max_prp_ents;
     uint16_t    cqe_size;
     uint16_t    sqe_size;
+    uint16_t    oncs;
     uint32_t    reg_size;
     uint32_t    num_namespaces;
     uint32_t    num_queues;
@@ -79,6 +80,8 @@ typedef struct NvmeCtrl {
     uint32_t    cmbloc;
     uint8_t     *cmbuf;
     uint64_t    irq_status;
+    uint64_t    host_timestamp;                 /* Timestamp sent by the host */
+    uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
 
     char            *serial;
     NvmeNamespace   *namespaces;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index b92039a573..97a17838ed 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -46,6 +46,8 @@ nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=%"PRIu16""
 nvme_getfeat_vwcache(const char* result) "get feature volatile write cache, result=%s"
 nvme_getfeat_numq(int result) "get feature number of queues, result=%d"
 nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_count=%d sq_count=%d, responding with cq_count=%d sq_count=%d"
+nvme_setfeat_timestamp(uint64_t ts) "set feature timestamp = 0x%"PRIx64""
+nvme_getfeat_timestamp(uint64_t ts) "get feature timestamp = 0x%"PRIx64""
 nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 849a6f3fa3..3ec8efcc43 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -581,6 +581,7 @@ enum NvmeIdCtrlOncs {
     NVME_ONCS_WRITE_ZEROS   = 1 << 3,
     NVME_ONCS_FEATURES      = 1 << 4,
     NVME_ONCS_RESRVATIONS   = 1 << 5,
+    NVME_ONCS_TIMESTAMP     = 1 << 6,
 };
 
 #define NVME_CTRL_SQES_MIN(sqes) ((sqes) & 0xf)
@@ -622,6 +623,7 @@ enum NvmeFeatureIds {
     NVME_INTERRUPT_VECTOR_CONF      = 0x9,
     NVME_WRITE_ATOMICITY            = 0xa,
     NVME_ASYNCHRONOUS_EVENT_CONF    = 0xb,
+    NVME_TIMESTAMP                  = 0xe,
     NVME_SOFTWARE_PROGRESS_MARKER   = 0x80
 };
 
-- 
2.17.1



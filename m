Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2D7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 04:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8131720936
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 04:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8131720936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq7x5-0008Uq-PS
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 00:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jq7vf-0006xl-EO; Tue, 30 Jun 2020 00:31:31 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jq7vb-0004SP-Om; Tue, 30 Jun 2020 00:31:31 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 07FAEBF735;
 Tue, 30 Jun 2020 04:31:25 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 2/3] hw/block/nvme: add commands supported and effects log page
Date: Tue, 30 Jun 2020 06:31:21 +0200
Message-Id: <20200630043122.1307043-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200630043122.1307043-1-its@irrelevant.dk>
References: <20200630043122.1307043-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:09:10
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 Gollu Appalanaidu <anaidu.gollu@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gollu Appalanaidu <anaidu.gollu@samsung.com>

This is to support for the Commands Supported and Effects log page. See
NVM Express Spec 1.3d, sec. 5.14.1.5 ("Commands Supported and Effects")

Signed-off-by: Gollu Appalanaidu <anaidu.gollu@samsung.com>
Co-authored-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c      | 20 +++++++++++++++++++-
 hw/block/nvme.h      | 25 +++++++++++++++++++++++++
 include/block/nvme.h | 21 +++++++++++++++++++++
 3 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 07ac409f37c9..9f1a1ba03b8a 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -67,6 +67,7 @@
 #define NVME_TEMPERATURE_WARNING 0x157
 #define NVME_TEMPERATURE_CRITICAL 0x175
 #define NVME_NUM_FW_SLOTS 1
+#define NVME_MAX_ADM_IO_CMDS 0xFF
 
 #define NVME_GUEST_ERR(trace, fmt, ...) \
     do { \
@@ -1471,6 +1472,21 @@ static uint16_t nvme_error_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
+static uint16_t nvme_effects_log(NvmeCtrl *n, uint32_t buf_len, uint64_t off,
+    NvmeRequest *req)
+{
+    uint32_t trans_len;
+
+    if (off > sizeof(nvme_effects)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    trans_len = MIN(sizeof(nvme_effects) - off, buf_len);
+
+    return nvme_dma(n, (uint8_t *)&nvme_effects + off, trans_len,
+                    DMA_DIRECTION_FROM_DEVICE, req);
+}
+
 static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeCmd *cmd = &req->cmd;
@@ -1514,6 +1530,8 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
         return nvme_smart_info(n, rae, len, off, req);
     case NVME_LOG_FW_SLOT_INFO:
         return nvme_fw_log_info(n, len, off, req);
+    case NVME_LOG_EFFECTS:
+        return nvme_effects_log(n, len, off, req);
     default:
         trace_pci_nvme_err_invalid_log_page(nvme_cid(req), lid);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -2927,7 +2945,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->acl = 3;
     id->aerl = n->params.aerl;
     id->frmw = (NVME_NUM_FW_SLOTS << 1) | NVME_FRMW_SLOT1_RO;
-    id->lpa = NVME_LPA_EXTENDED;
+    id->lpa = NVME_LPA_EFFECTS_LOG | NVME_LPA_EXTENDED;
 
     /* recommended default value (~70 C) */
     id->wctemp = cpu_to_le16(NVME_TEMPERATURE_WARNING);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 66187902b7cf..e62bcd12a7a8 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -18,6 +18,31 @@ typedef struct NvmeParams {
     bool     use_intel_id;
 } NvmeParams;
 
+static const NvmeEffectsLog nvme_effects = {
+    .acs = {
+        [NVME_ADM_CMD_DELETE_SQ]    = NVME_EFFECTS_CSUPP,
+        [NVME_ADM_CMD_CREATE_SQ]    = NVME_EFFECTS_CSUPP,
+        [NVME_ADM_CMD_GET_LOG_PAGE] = NVME_EFFECTS_CSUPP,
+        [NVME_ADM_CMD_DELETE_CQ]    = NVME_EFFECTS_CSUPP,
+        [NVME_ADM_CMD_CREATE_CQ]    = NVME_EFFECTS_CSUPP,
+        [NVME_ADM_CMD_IDENTIFY]     = NVME_EFFECTS_CSUPP,
+        [NVME_ADM_CMD_ABORT]        = NVME_EFFECTS_CSUPP,
+        [NVME_ADM_CMD_SET_FEATURES] = NVME_EFFECTS_CSUPP | NVME_EFFECTS_CCC |
+            NVME_EFFECTS_NIC | NVME_EFFECTS_NCC,
+        [NVME_ADM_CMD_GET_FEATURES] = NVME_EFFECTS_CSUPP,
+        [NVME_ADM_CMD_FORMAT_NVM]   = NVME_EFFECTS_CSUPP | NVME_EFFECTS_LBCC |
+            NVME_EFFECTS_NCC | NVME_EFFECTS_NIC | NVME_EFFECTS_CSE_MULTI,
+        [NVME_ADM_CMD_ASYNC_EV_REQ] = NVME_EFFECTS_CSUPP,
+    },
+
+    .iocs = {
+        [NVME_CMD_FLUSH]            = NVME_EFFECTS_CSUPP,
+        [NVME_CMD_WRITE]            = NVME_EFFECTS_CSUPP | NVME_EFFECTS_LBCC,
+        [NVME_CMD_READ]             = NVME_EFFECTS_CSUPP,
+        [NVME_CMD_WRITE_ZEROES]     = NVME_EFFECTS_CSUPP | NVME_EFFECTS_LBCC,
+    },
+};
+
 typedef struct NvmeAsyncEvent {
     QTAILQ_ENTRY(NvmeAsyncEvent) entry;
     NvmeAerResult result;
diff --git a/include/block/nvme.h b/include/block/nvme.h
index b27be237cd33..040e4ef36ddc 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -824,6 +824,24 @@ typedef struct NvmeSmartLog {
     uint8_t     reserved2[320];
 } NvmeSmartLog;
 
+typedef struct NvmeEffectsLog {
+    uint32_t acs[256];
+    uint32_t iocs[256];
+    uint8_t  rsvd2048[2048];
+} NvmeEffectsLog;
+
+enum {
+    NVME_EFFECTS_CSUPP      = 1 <<  0,
+    NVME_EFFECTS_LBCC       = 1 <<  1,
+    NVME_EFFECTS_NCC        = 1 <<  2,
+    NVME_EFFECTS_NIC        = 1 <<  3,
+    NVME_EFFECTS_CCC        = 1 <<  4,
+    NVME_EFFECTS_CSE_SINGLE = 1 << 16,
+    NVME_EFFECTS_CSE_MULTI  = 1 << 17,
+    NVME_EFFECTS_CSE_MASK   = 3 << 16,
+    NVME_EFFECTS_UUID_SEL   = 1 << 19,
+};
+
 enum NvmeSmartWarn {
     NVME_SMART_SPARE                  = 1 << 0,
     NVME_SMART_TEMPERATURE            = 1 << 1,
@@ -854,6 +872,7 @@ enum NvmeLogIdentifier {
     NVME_LOG_ERROR_INFO     = 0x01,
     NVME_LOG_SMART_INFO     = 0x02,
     NVME_LOG_FW_SLOT_INFO   = 0x03,
+    NVME_LOG_EFFECTS        = 0x05,
 };
 
 typedef struct NvmePSD {
@@ -980,6 +999,7 @@ enum NvmeIdCtrlFrmw {
 };
 
 enum NvmeIdCtrlLpa {
+    NVME_LPA_EFFECTS_LOG  = 1 << 1,
     NVME_LPA_EXTENDED = 1 << 2,
 };
 
@@ -1195,5 +1215,6 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeNvmSetAttributes) != 128);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNvmSetList) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeBar) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
 }
 #endif
-- 
2.27.0



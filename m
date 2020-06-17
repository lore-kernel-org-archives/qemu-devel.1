Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1F6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 22:06:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F7342082F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 22:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O9DllsKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7342082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlgCX-00062y-4s
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 18:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfhf-0003fo-Ei; Wed, 17 Jun 2020 17:34:39 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfhd-0005DU-7t; Wed, 17 Jun 2020 17:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592429676; x=1623965676;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aqgqaLO1ZcNkybwn5HB7GQlLkwoHClg6t6ocDRLv81s=;
 b=O9DllsKzaIhb/iDuNHTyJc/2UQ/3R8m7CSVhPh+7H1VIZX/1syfvqKDd
 EqJ7IKYzjAG94qF0jMRZR+8VuVUyVInYRjZF4IasBwYbyGU5oReRy1HKj
 diRjK4VBEh8pAa/Q224FvDrkBUt9Tf/cI32IT+Od5z4wSMFbt7fbS+Mw5
 cmyGR9ueIY7OqpKzN8jzDvjDK5rMjCyeGcQDFtpFnXiv6fk77u7+OcZqY
 7nVv/FRpDBo3pI6yiW0dGTrIcQyDbNgIh+ppzoO0iDbIvO6sDWSibX2Ri
 UkXMIFfoGxoxiLkZI7HmA/o5OGoRutauErNrguvtr/gdruk6r9JAaoswI g==;
IronPort-SDR: gXyfMwM3GvpEDv+LKNY+ILdioz+8pgRnpWHAWRKdKkHb0vt3k5mycyA1gpP9hyVsbPCwHmyrms
 NFCqUt7vJtB4BS0sCzaSontL8cCIfxWbBOuRTm0/dMeE2iCjrZ5vnUUQHvpPDqCeO+gyAwFdfd
 CK0E7jDHj1mEsomRj6NLWgdZqQNsJTPNemyZNNtV9y/rGpXNlAGssxMygH79NGscwh19aapFEy
 B/3sBqTqrJsLdpAOAeUJdupsj7rJFBt4yOfswileXcV13HI0c38/0/qNFZB1V8HSK+hquqqKTg
 fko=
X-IronPort-AV: E=Sophos;i="5.73,523,1583164800"; d="scan'208";a="249439796"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 05:34:35 +0800
IronPort-SDR: /j9pauwMqTfyxF2AJLczocKSD+4QeDzme8iweFXFXyp12Om7f4K27ymxIkjtJ8ma5q8FqM43Kg
 eGWGSXAl3xuBeKrVMmfj5eZHAXhKmLWrs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 14:23:16 -0700
IronPort-SDR: RXZbLbNO2L+8aoDA/8kGOgeP/C1DU/k5Uosx3JCTU4VLj+0Lp1SEuTkaURo5agUru2v7DXUhpe
 KDbcCK97fIvQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2020 14:34:33 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>
Subject: [PATCH v2 04/18] hw/block/nvme: Add Commands Supported and Effects log
Date: Thu, 18 Jun 2020 06:34:01 +0900
Message-Id: <20200617213415.22417-5-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=430b82a1d=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 17:34:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This log page becomes necessary to implement to allow checking for
Zone Append command support in Zoned Namespace Command Set.

This commit adds the code to report this log page for NVM Command
Set only. The parts that are specific to zoned operation will be
added later in the series.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme.c       | 62 +++++++++++++++++++++++++++++++++++++++++++
 hw/block/trace-events |  4 +++
 include/block/nvme.h  | 18 +++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index a1bbc9acde..03b8deee85 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -871,6 +871,66 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     return NVME_SUCCESS;
 }
 
+static uint16_t nvme_handle_cmd_effects(NvmeCtrl *n, NvmeCmd *cmd,
+    uint64_t prp1, uint64_t prp2, uint64_t ofs, uint32_t len)
+{
+   NvmeEffectsLog cmd_eff_log = {};
+   uint32_t *iocs = cmd_eff_log.iocs;
+
+    trace_pci_nvme_cmd_supp_and_effects_log_read();
+
+    if (ofs != 0) {
+        trace_pci_nvme_err_invalid_effects_log_offset(ofs);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+    if (len != sizeof(cmd_eff_log)) {
+        trace_pci_nvme_err_invalid_effects_log_len(len);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    iocs[NVME_ADM_CMD_DELETE_SQ] = NVME_CMD_EFFECTS_CSUPP;
+    iocs[NVME_ADM_CMD_CREATE_SQ] = NVME_CMD_EFFECTS_CSUPP;
+    iocs[NVME_ADM_CMD_DELETE_CQ] = NVME_CMD_EFFECTS_CSUPP;
+    iocs[NVME_ADM_CMD_CREATE_CQ] = NVME_CMD_EFFECTS_CSUPP;
+    iocs[NVME_ADM_CMD_IDENTIFY] = NVME_CMD_EFFECTS_CSUPP;
+    iocs[NVME_ADM_CMD_SET_FEATURES] = NVME_CMD_EFFECTS_CSUPP;
+    iocs[NVME_ADM_CMD_GET_FEATURES] = NVME_CMD_EFFECTS_CSUPP;
+    iocs[NVME_ADM_CMD_GET_LOG_PAGE] = NVME_CMD_EFFECTS_CSUPP;
+
+    iocs[NVME_CMD_FLUSH] = NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC;
+    iocs[NVME_CMD_WRITE_ZEROS] = NVME_CMD_EFFECTS_CSUPP |
+                                 NVME_CMD_EFFECTS_LBCC;
+    iocs[NVME_CMD_WRITE] = NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC;
+    iocs[NVME_CMD_READ] = NVME_CMD_EFFECTS_CSUPP;
+
+    return nvme_dma_read_prp(n, (uint8_t *)&cmd_eff_log, len, prp1, prp2);
+}
+
+static uint16_t nvme_get_log_page(NvmeCtrl *n, NvmeCmd *cmd)
+{
+    uint64_t prp1 = le64_to_cpu(cmd->prp1);
+    uint64_t prp2 = le64_to_cpu(cmd->prp2);
+    uint32_t dw10 = le32_to_cpu(cmd->cdw10);
+    uint32_t dw11 = le32_to_cpu(cmd->cdw11);
+    uint64_t dw12 = le32_to_cpu(cmd->cdw12);
+    uint64_t dw13 = le32_to_cpu(cmd->cdw13);
+    uint64_t ofs = (dw13 << 32) | dw12;
+    uint32_t numdl, numdu, len;
+    uint16_t lid = dw10 & 0xff;
+
+    numdl = dw10 >> 16;
+    numdu = dw11 & 0xffff;
+    len = (((numdu << 16) | numdl) + 1) << 2;
+
+    switch (lid) {
+    case NVME_LOG_CMD_EFFECTS:
+        return nvme_handle_cmd_effects(n, cmd, prp1, prp2, ofs, len);
+    }
+
+    trace_pci_nvme_unsupported_log_page(lid);
+    return NVME_INVALID_FIELD | NVME_DNR;
+}
+
 static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
     switch (cmd->opcode) {
@@ -888,6 +948,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         return nvme_set_feature(n, cmd, req);
     case NVME_ADM_CMD_GET_FEATURES:
         return nvme_get_feature(n, cmd, req);
+    case NVME_ADM_CMD_GET_LOG_PAGE:
+        return nvme_get_log_page(n, cmd);
     default:
         trace_pci_nvme_err_invalid_admin_opc(cmd->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 958fcc5508..423d491e27 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -58,6 +58,7 @@ pci_nvme_mmio_start_success(void) "setting controller enable bit succeeded"
 pci_nvme_mmio_stopped(void) "cleared controller enable bit"
 pci_nvme_mmio_shutdown_set(void) "shutdown bit set"
 pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
+pci_nvme_cmd_supp_and_effects_log_read(void) "commands supported and effects log read"
 
 # nvme traces for error conditions
 pci_nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
@@ -69,6 +70,8 @@ pci_nvme_err_invalid_ns(uint32_t ns, uint32_t limit) "invalid namespace %u not w
 pci_nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
 pci_nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8""
 pci_nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit) "Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
+pci_nvme_err_invalid_effects_log_offset(uint64_t ofs) "commands supported and effects log offset must be 0, got %"PRIu64""
+pci_nvme_err_invalid_effects_log_len(uint32_t len) "commands supported and effects log size is 4096, got %"PRIu32""
 pci_nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion, sid=%"PRIu16""
 pci_nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submission queue, invalid cqid=%"PRIu16""
 pci_nvme_err_invalid_create_sq_sqid(uint16_t sqid) "failed creating submission queue, invalid sqid=%"PRIu16""
@@ -123,6 +126,7 @@ pci_nvme_ub_db_wr_invalid_cq(uint32_t qid) "completion queue doorbell write for
 pci_nvme_ub_db_wr_invalid_cqhead(uint32_t qid, uint16_t new_head) "completion queue doorbell write value beyond queue size, cqid=%"PRIu32", new_head=%"PRIu16", ignoring"
 pci_nvme_ub_db_wr_invalid_sq(uint32_t qid) "submission queue doorbell write for nonexistent queue, sqid=%"PRIu32", ignoring"
 pci_nvme_ub_db_wr_invalid_sqtail(uint32_t qid, uint16_t new_tail) "submission queue doorbell write value beyond queue size, sqid=%"PRIu32", new_head=%"PRIu16", ignoring"
+pci_nvme_unsupported_log_page(uint16_t lid) "unsupported log page 0x%"PRIx16""
 
 # xen-block.c
 xen_block_realize(const char *type, uint32_t disk, uint32_t partition) "%s d%up%u"
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 3099df99eb..6a58bac0c2 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -691,10 +691,27 @@ enum NvmeSmartWarn {
     NVME_SMART_FAILED_VOLATILE_MEDIA  = 1 << 4,
 };
 
+typedef struct NvmeEffectsLog {
+  uint32_t      acs[256];
+  uint32_t      iocs[256];
+  uint8_t       resv[2048];
+} NvmeEffectsLog;
+
+enum {
+   NVME_CMD_EFFECTS_CSUPP             = 1 << 0,
+   NVME_CMD_EFFECTS_LBCC              = 1 << 1,
+   NVME_CMD_EFFECTS_NCC               = 1 << 2,
+   NVME_CMD_EFFECTS_NIC               = 1 << 3,
+   NVME_CMD_EFFECTS_CCC               = 1 << 4,
+   NVME_CMD_EFFECTS_CSE_MASK          = 3 << 16,
+   NVME_CMD_EFFECTS_UUID_SEL          = 1 << 19,
+};
+
 enum LogIdentifier {
     NVME_LOG_ERROR_INFO     = 0x01,
     NVME_LOG_SMART_INFO     = 0x02,
     NVME_LOG_FW_SLOT_INFO   = 0x03,
+    NVME_LOG_CMD_EFFECTS    = 0x05,
 };
 
 typedef struct NvmePSD {
@@ -898,5 +915,6 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
 }
 #endif
-- 
2.21.0



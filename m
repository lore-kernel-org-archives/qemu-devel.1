Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B231CC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 075202193E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UBUW1ZBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075202193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL9aQ-0008JZ-Uz
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 14:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5287de305=dmitry.fomichev@wdc.com>)
 id 1kL9Ny-0004wM-RH; Wed, 23 Sep 2020 14:20:58 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5287de305=dmitry.fomichev@wdc.com>)
 id 1kL9Nv-00087h-JM; Wed, 23 Sep 2020 14:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600886179; x=1632422179;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3L1xJrdrnoIaUBLZiVws5W3GT63gHksGAR+Pnb5390Y=;
 b=UBUW1ZBIR6dh9f/eeYcP0aLCfTi0xxRbxSJXiErYNjgUpotXhUsZd0lS
 uODDkIBf/xiDDd/Iiw+epnil9fkfNCKlA6SmhaT43vA+A2rXDDmb7Ro0j
 cSd3x+KiXJwd+pkpSIUuLZ1uuLFFwy4Nw7FOA28s3dhalk7d3mbGY7C7d
 /qAcHut0LVbKo35qmk6GhXkBkXtY9d+ovB87IiqOl4/nsKLJWaSvhQWya
 r9HothsxZbmN7KTy1d3/vMxfkFiXcvumGVEr+pzIrQ+4nEP9otvNgp1cz
 ihUJDCct7KVV+Tgn5i3ctqngHwg7NdwBO7ZHSxPLvv4wAV66tBLoROf2s Q==;
IronPort-SDR: Q/SIMtSniVSpnA8PQnqUXBPl1821hZSOzsf+W8L9MCNAuLBcdDmZQJi0XiUchmcjmXmUdaBVJS
 sgeKFeon37DQoW9uT1vnD8F6XMlQIsYE1MuseNCb2BLUBVNVBALvCgTyiiXL81p+pep/VVEO5T
 3TfyIV4ndanQHncvfAjHycNzVtWd/Y1K3KR/wiSYnusi71OIbnd7f8AOd/yV56HkyHgSShh+rn
 auJZrSEgY0pLjXDqB5LdU+4ff6bF428vQQNs9ab5wTw/f5HQNci3qzWuT7jTsc3cFSyHOxj7aJ
 bfg=
X-IronPort-AV: E=Sophos;i="5.77,293,1596470400"; d="scan'208";a="251496340"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2020 02:36:15 +0800
IronPort-SDR: RPj6njuSFkbl/3OJPL44czUW08DQDx5BYQGrI+4kpoZ7wEYPHS+/ZghSAJ8lWS94GiD9nF4uKo
 IOWCJz36LNyg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 11:06:58 -0700
IronPort-SDR: OkEkcxQGLK9kVBOgQxRamOz6AuYkhMsom8Sjeenp+axT/KX6hmBc1RwJK5JfrMRqU3fgFGB/vi
 Dme+5LroF6jw==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Sep 2020 11:20:50 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v4 02/14] hw/block/nvme: Add Commands Supported and Effects log
Date: Thu, 24 Sep 2020 03:20:09 +0900
Message-Id: <20200923182021.3724-3-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=5287de305=dmitry.fomichev@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 14:20:48
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Alistair Francis <alistair.francis@wdc.com>,
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
 hw/block/nvme.c       | 44 ++++++++++++++++++++++++++++++++++++++++++-
 hw/block/trace-events |  2 ++
 include/block/nvme.h  | 19 +++++++++++++++++++
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index f60e968c4a..7807f296d3 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -957,6 +957,46 @@ static uint16_t nvme_error_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
                         DMA_DIRECTION_FROM_DEVICE, req);
 }
 
+static uint16_t nvme_cmd_effects(NvmeCtrl *n, uint32_t buf_len,
+                                 uint64_t off, NvmeRequest *req)
+{
+    NvmeCmd *cmd = &req->cmd;
+    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
+    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
+    NvmeEffectsLog cmd_eff_log = {};
+    uint32_t *iocs = cmd_eff_log.iocs;
+    uint32_t *acs = cmd_eff_log.acs;
+    uint32_t trans_len;
+
+    trace_pci_nvme_cmd_supp_and_effects_log_read();
+
+    if (off >= sizeof(cmd_eff_log)) {
+        trace_pci_nvme_err_invalid_effects_log_offset(off);
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    acs[NVME_ADM_CMD_DELETE_SQ] = NVME_CMD_EFFECTS_CSUPP;
+    acs[NVME_ADM_CMD_CREATE_SQ] = NVME_CMD_EFFECTS_CSUPP;
+    acs[NVME_ADM_CMD_DELETE_CQ] = NVME_CMD_EFFECTS_CSUPP;
+    acs[NVME_ADM_CMD_CREATE_CQ] = NVME_CMD_EFFECTS_CSUPP;
+    acs[NVME_ADM_CMD_IDENTIFY] = NVME_CMD_EFFECTS_CSUPP;
+    acs[NVME_ADM_CMD_SET_FEATURES] = NVME_CMD_EFFECTS_CSUPP;
+    acs[NVME_ADM_CMD_GET_FEATURES] = NVME_CMD_EFFECTS_CSUPP;
+    acs[NVME_ADM_CMD_GET_LOG_PAGE] = NVME_CMD_EFFECTS_CSUPP;
+    acs[NVME_ADM_CMD_ASYNC_EV_REQ] = NVME_CMD_EFFECTS_CSUPP;
+
+    iocs[NVME_CMD_FLUSH] = NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC;
+    iocs[NVME_CMD_WRITE_ZEROES] = NVME_CMD_EFFECTS_CSUPP |
+                                  NVME_CMD_EFFECTS_LBCC;
+    iocs[NVME_CMD_WRITE] = NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC;
+    iocs[NVME_CMD_READ] = NVME_CMD_EFFECTS_CSUPP;
+
+    trans_len = MIN(sizeof(cmd_eff_log) - off, buf_len);
+
+    return nvme_dma_prp(n, ((uint8_t *)&cmd_eff_log) + off, trans_len,
+                        prp1, prp2, DMA_DIRECTION_FROM_DEVICE, req);
+}
+
 static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeCmd *cmd = &req->cmd;
@@ -1000,6 +1040,8 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
         return nvme_smart_info(n, rae, len, off, req);
     case NVME_LOG_FW_SLOT_INFO:
         return nvme_fw_log_info(n, len, off, req);
+    case NVME_LOG_CMD_EFFECTS:
+        return nvme_cmd_effects(n, len, off, req);
     default:
         trace_pci_nvme_err_invalid_log_page(nvme_cid(req), lid);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -2350,7 +2392,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->acl = 3;
     id->aerl = n->params.aerl;
     id->frmw = (NVME_NUM_FW_SLOTS << 1) | NVME_FRMW_SLOT1_RO;
-    id->lpa = NVME_LPA_EXTENDED;
+    id->lpa = NVME_LPA_CSE | NVME_LPA_EXTENDED;
 
     /* recommended default value (~70 C) */
     id->wctemp = cpu_to_le16(NVME_TEMPERATURE_WARNING);
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 72cf2d15cb..79c9da652d 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -83,6 +83,7 @@ pci_nvme_mmio_start_success(void) "setting controller enable bit succeeded"
 pci_nvme_mmio_stopped(void) "cleared controller enable bit"
 pci_nvme_mmio_shutdown_set(void) "shutdown bit set"
 pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
+pci_nvme_cmd_supp_and_effects_log_read(void) "commands supported and effects log read"
 
 # nvme traces for error conditions
 pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
@@ -95,6 +96,7 @@ pci_nvme_err_invalid_ns(uint32_t ns, uint32_t limit) "invalid namespace %u not w
 pci_nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
 pci_nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8""
 pci_nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit) "Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
+pci_nvme_err_invalid_effects_log_offset(uint64_t ofs) "commands supported and effects log offset must be 0, got %"PRIu64""
 pci_nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion, sid=%"PRIu16""
 pci_nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submission queue, invalid cqid=%"PRIu16""
 pci_nvme_err_invalid_create_sq_sqid(uint16_t sqid) "failed creating submission queue, invalid sqid=%"PRIu16""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 65e68a82c8..71126ae1ff 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -734,10 +734,27 @@ enum NvmeSmartWarn {
     NVME_SMART_FAILED_VOLATILE_MEDIA  = 1 << 4,
 };
 
+typedef struct NvmeEffectsLog {
+    uint32_t    acs[256];
+    uint32_t    iocs[256];
+    uint8_t     resv[2048];
+} NvmeEffectsLog;
+
+enum {
+    NVME_CMD_EFFECTS_CSUPP             = 1 << 0,
+    NVME_CMD_EFFECTS_LBCC              = 1 << 1,
+    NVME_CMD_EFFECTS_NCC               = 1 << 2,
+    NVME_CMD_EFFECTS_NIC               = 1 << 3,
+    NVME_CMD_EFFECTS_CCC               = 1 << 4,
+    NVME_CMD_EFFECTS_CSE_MASK          = 3 << 16,
+    NVME_CMD_EFFECTS_UUID_SEL          = 1 << 19,
+};
+
 enum NvmeLogIdentifier {
     NVME_LOG_ERROR_INFO     = 0x01,
     NVME_LOG_SMART_INFO     = 0x02,
     NVME_LOG_FW_SLOT_INFO   = 0x03,
+    NVME_LOG_CMD_EFFECTS    = 0x05,
 };
 
 typedef struct QEMU_PACKED NvmePSD {
@@ -849,6 +866,7 @@ enum NvmeIdCtrlFrmw {
 };
 
 enum NvmeIdCtrlLpa {
+    NVME_LPA_CSE      = 1 << 1,
     NVME_LPA_EXTENDED = 1 << 2,
 };
 
@@ -1048,6 +1066,7 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeErrorLog) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeFwSlotInfoLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSglDescriptor) != 16);
-- 
2.21.0



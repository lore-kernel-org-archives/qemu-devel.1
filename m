Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA6DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17D82073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17D82073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDBU-0001SM-Tb
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5d-0007mi-Mt; Tue, 30 Jun 2020 06:02:10 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqD5P-0004JF-IW; Tue, 30 Jun 2020 06:02:09 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 5C087BF735;
 Tue, 30 Jun 2020 10:01:53 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 02/10] hw/block/nvme: add zns specific fields and types
Date: Tue, 30 Jun 2020 12:01:31 +0200
Message-Id: <20200630100139.1483002-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200630100139.1483002-1-its@irrelevant.dk>
References: <20200630100139.1483002-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 04:46:49
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add new fields, types and data structures for TP 4053 ("Zoned Namespaces").

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 include/block/nvme.h | 186 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 180 insertions(+), 6 deletions(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index 637be0ddd2fc..ddf948132272 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -465,7 +465,8 @@ enum NvmeCmbmscMask {
 #define NVME_CMBSTS_CBAI(cmbsts) (cmsts & 0x1)
 
 enum NvmeCommandSet {
-    NVME_IOCS_NVM = 0x0,
+    NVME_IOCS_NVM   = 0x0,
+    NVME_IOCS_ZONED = 0x2,
 };
 
 enum NvmeSglDescriptorType {
@@ -552,6 +553,11 @@ enum NvmeIoCommands {
     NVME_CMD_COMPARE            = 0x05,
     NVME_CMD_WRITE_ZEROES       = 0x08,
     NVME_CMD_DSM                = 0x09,
+
+    /* Zoned Command Set */
+    NVME_CMD_ZONE_MGMT_SEND     = 0x79,
+    NVME_CMD_ZONE_MGMT_RECV     = 0x7a,
+    NVME_CMD_ZONE_APPEND        = 0x7d,
 };
 
 typedef struct NvmeDeleteQ {
@@ -664,6 +670,82 @@ enum {
     NVME_RW_PRINFO_PRCHK_REF    = 1 << 10,
 };
 
+typedef struct NvmeZoneAppendCmd {
+    uint8_t     opcode;
+    uint8_t     flags;
+    uint16_t    cid;
+    uint32_t    nsid;
+    uint32_t    rsvd8[2];
+    uint64_t    mptr;
+    NvmeCmdDptr dptr;
+    uint64_t    zslba;
+    uint16_t    nlb;
+    uint8_t     rsvd50;
+    uint8_t     control;
+    uint32_t    ilbrt;
+    uint16_t    lbat;
+    uint16_t    lbatm;
+} NvmeZoneAppendCmd;
+
+typedef struct NvmeZoneManagementSendCmd {
+    uint8_t     opcode;
+    uint8_t     flags;
+    uint16_t    cid;
+    uint32_t    nsid;
+    uint32_t    rsvd8[4];
+    NvmeCmdDptr dptr;
+    uint64_t    slba;
+    uint32_t    rsvd48;
+    uint8_t     zsa;
+    uint8_t     zsflags;
+    uint16_t    rsvd54;
+    uint32_t    rsvd56[2];
+} NvmeZoneManagementSendCmd;
+
+#define NVME_CMD_ZONE_MGMT_SEND_SELECT_ALL(zsflags) ((zsflags) & 0x1)
+
+typedef enum NvmeZoneManagementSendAction {
+    NVME_CMD_ZONE_MGMT_SEND_CLOSE   = 0x1,
+    NVME_CMD_ZONE_MGMT_SEND_FINISH  = 0x2,
+    NVME_CMD_ZONE_MGMT_SEND_OPEN    = 0x3,
+    NVME_CMD_ZONE_MGMT_SEND_RESET   = 0x4,
+    NVME_CMD_ZONE_MGMT_SEND_OFFLINE = 0x5,
+    NVME_CMD_ZONE_MGMT_SEND_SET_ZDE = 0x10,
+} NvmeZoneManagementSendAction;
+
+typedef struct NvmeZoneManagementRecvCmd {
+    uint8_t     opcode;
+    uint8_t     flags;
+    uint16_t    cid;
+    uint32_t    nsid;
+    uint8_t     rsvd8[16];
+    NvmeCmdDptr dptr;
+    uint64_t    slba;
+    uint32_t    numdw;
+    uint8_t     zra;
+    uint8_t     zrasp;
+    uint8_t     zrasf;
+    uint8_t     rsvd55[9];
+} NvmeZoneManagementRecvCmd;
+
+typedef enum NvmeZoneManagementRecvAction {
+    NVME_CMD_ZONE_MGMT_RECV_REPORT_ZONES          = 0x0,
+    NVME_CMD_ZONE_MGMT_RECV_EXTENDED_REPORT_ZONES = 0x1,
+} NvmeZoneManagementRecvAction;
+
+typedef enum NvmeZoneManagementRecvActionSpecificField {
+    NVME_CMD_ZONE_MGMT_RECV_LIST_ALL  = 0x0,
+    NVME_CMD_ZONE_MGMT_RECV_LIST_ZSE  = 0x1,
+    NVME_CMD_ZONE_MGMT_RECV_LIST_ZSIO = 0x2,
+    NVME_CMD_ZONE_MGMT_RECV_LIST_ZSEO = 0x3,
+    NVME_CMD_ZONE_MGMT_RECV_LIST_ZSC  = 0x4,
+    NVME_CMD_ZONE_MGMT_RECV_LIST_ZSF  = 0x5,
+    NVME_CMD_ZONE_MGMT_RECV_LIST_ZSRO = 0x6,
+    NVME_CMD_ZONE_MGMT_RECV_LIST_ZSO  = 0x7,
+} NvmeZoneManagementRecvActionSpecificField;
+
+#define NVME_CMD_ZONE_MGMT_RECEIVE_PARTIAL 0x1
+
 typedef struct NvmeDsmCmd {
     uint8_t     opcode;
     uint8_t     flags;
@@ -702,13 +784,15 @@ enum NvmeAsyncEventRequest {
     NVME_AER_INFO_SMART_RELIABILITY         = 0,
     NVME_AER_INFO_SMART_TEMP_THRESH         = 1,
     NVME_AER_INFO_SMART_SPARE_THRESH        = 2,
+    NVME_AER_INFO_NOTICE_ZONE_DESCR_CHANGED = 0xef,
 };
 
 typedef struct NvmeAerResult {
-    uint8_t event_type;
-    uint8_t event_info;
-    uint8_t log_page;
-    uint8_t resv;
+    uint8_t  event_type;
+    uint8_t  event_info;
+    uint8_t  log_page;
+    uint8_t  resv;
+    uint32_t nsid;
 } NvmeAerResult;
 
 typedef struct NvmeCqe {
@@ -775,6 +859,14 @@ enum NvmeStatusCodes {
     NVME_CONFLICTING_ATTRS      = 0x0180,
     NVME_INVALID_PROT_INFO      = 0x0181,
     NVME_WRITE_TO_RO            = 0x0182,
+    NVME_ZONE_BOUNDARY_ERROR    = 0x01b8,
+    NVME_ZONE_IS_FULL           = 0x01b9,
+    NVME_ZONE_IS_READ_ONLY      = 0x01ba,
+    NVME_ZONE_IS_OFFLINE        = 0x01bb,
+    NVME_ZONE_INVALID_WRITE     = 0x01bc,
+    NVME_TOO_MANY_ACTIVE_ZONES  = 0x01bd,
+    NVME_TOO_MANY_OPEN_ZONES    = 0x01be,
+    NVME_INVALID_ZONE_STATE_TRANSITION = 0x01bf,
     NVME_WRITE_FAULT            = 0x0280,
     NVME_UNRECOVERED_READ       = 0x0281,
     NVME_E2E_GUARD_ERROR        = 0x0282,
@@ -868,6 +960,46 @@ enum {
     NVME_EFFECTS_UUID_SEL   = 1 << 19,
 };
 
+typedef enum NvmeZoneType {
+    NVME_ZT_SEQ = 0x2,
+} NvmeZoneType;
+
+typedef enum NvmeZoneState {
+    NVME_ZS_ZSE  = 0x1,
+    NVME_ZS_ZSIO = 0x2,
+    NVME_ZS_ZSEO = 0x3,
+    NVME_ZS_ZSC  = 0x4,
+    NVME_ZS_ZSRO = 0xd,
+    NVME_ZS_ZSF  = 0xe,
+    NVME_ZS_ZSO  = 0xf,
+} NvmeZoneState;
+
+typedef struct NvmeZoneDescriptor {
+    uint8_t  zt;
+    uint8_t  zs;
+    uint8_t  za;
+    uint8_t  rsvd3[5];
+    uint64_t zcap;
+    uint64_t zslba;
+    uint64_t wp;
+    uint8_t  rsvd32[32];
+} NvmeZoneDescriptor;
+
+#define NVME_ZS(zs) (((zs) >> 4) & 0xf)
+#define NVME_ZS_SET(zs, state) ((zs) = ((state) << 4))
+
+#define NVME_ZA_ZFC(za)  ((za) & (1 << 0))
+#define NVME_ZA_FZR(za)  ((za) & (1 << 1))
+#define NVME_ZA_RZR(za)  ((za) & (1 << 2))
+#define NVME_ZA_ZDEV(za) ((za) & (1 << 7))
+
+#define NVME_ZA_SET_ZFC(za, val)  ((za) |= (((val) & 1) << 0))
+#define NVME_ZA_SET_FZR(za, val)  ((za) |= (((val) & 1) << 1))
+#define NVME_ZA_SET_RZR(za, val)  ((za) |= (((val) & 1) << 2))
+#define NVME_ZA_SET_ZDEV(za, val) ((za) |= (((val) & 1) << 7))
+
+#define NVME_ZA_CLEAR(za) ((za) = 0x0)
+
 enum NvmeSmartWarn {
     NVME_SMART_SPARE                  = 1 << 0,
     NVME_SMART_TEMPERATURE            = 1 << 1,
@@ -899,6 +1031,7 @@ enum NvmeLogIdentifier {
     NVME_LOG_SMART_INFO     = 0x02,
     NVME_LOG_FW_SLOT_INFO   = 0x03,
     NVME_LOG_EFFECTS        = 0x05,
+    NVME_LOG_CHANGED_ZONE_LIST = 0xbf,
 };
 
 typedef struct NvmePSD {
@@ -1008,6 +1141,10 @@ typedef struct NvmeIdCtrl {
     uint8_t     vs[1024];
 } NvmeIdCtrl;
 
+enum NvmeIdCtrlOaes {
+    NVME_OAES_ZDCN = 1 << 27,
+};
+
 enum NvmeIdCtrlOacs {
     NVME_OACS_SECURITY  = 1 << 0,
     NVME_OACS_FORMAT    = 1 << 1,
@@ -1048,6 +1185,11 @@ enum NvmeIdCtrlLpa {
 #define NVME_CTRL_SGLS_MPTR_SGL                  (0x1 << 19)
 #define NVME_CTRL_SGLS_ADDR_OFFSET               (0x1 << 20)
 
+typedef struct NvmeIdCtrlZns {
+    uint8_t zasl;
+    uint8_t rsvd1[4095];
+} NvmeIdCtrlZns;
+
 #define NVME_ARB_AB(arb)    (arb & 0x7)
 #define NVME_ARB_AB_NOLIMIT 0x7
 #define NVME_ARB_LPW(arb)   ((arb >> 8) & 0xff)
@@ -1071,6 +1213,7 @@ enum NvmeIdCtrlLpa {
 #define NVME_AEC_SMART(aec)         (aec & 0xff)
 #define NVME_AEC_NS_ATTR(aec)       ((aec >> 8) & 0x1)
 #define NVME_AEC_FW_ACTIVATION(aec) ((aec >> 9) & 0x1)
+#define NVME_AEC_ZDCN(aec)          ((aec >> 27) & 0x1)
 
 #define NVME_ERR_REC_TLER(err_rec)  (err_rec & 0xffff)
 #define NVME_ERR_REC_DULBE(err_rec) (err_rec & 0x10000)
@@ -1226,9 +1369,33 @@ enum NvmeIdNsDps {
     DPS_FIRST_EIGHT = 8,
 };
 
+typedef struct NvmeLBAFE {
+    uint64_t    zsze;
+    uint8_t     zdes;
+    uint8_t     rsvd9[7];
+} NvmeLBAFE;
+
+typedef struct NvmeIdNsZns {
+    uint16_t    zoc;
+    uint16_t    ozcs;
+    uint32_t    mar;
+    uint32_t    mor;
+    uint32_t    rrl;
+    uint32_t    frl;
+    uint8_t     rsvd20[2795];
+    NvmeLBAFE   lbafe[16];
+    uint8_t     rsvd3072[768];
+    uint8_t     vs[256];
+} NvmeIdNsZns;
+
+#define NVME_ID_NS_ZNS_ZOC_VZC (1 << 0)
+#define NVME_ID_NS_ZNS_ZOC_ZAE (1 << 1)
+
+#define NVME_ID_NS_ZNS_OZCS_RAZB (1 << 0)
+
 static inline void _nvme_check_size(void)
 {
-    QEMU_BUILD_BUG_ON(sizeof(NvmeAerResult) != 4);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeAerResult) != 8);
     QEMU_BUILD_BUG_ON(sizeof(NvmeCqe) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeDsmRange) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeCmd) != 64);
@@ -1237,17 +1404,24 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeCreateSq) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdentify) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeRwCmd) != 64);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeZoneAppendCmd) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeDsmCmd) != 64);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeZoneManagementSendCmd) != 64);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeZoneManagementRecvCmd) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeRangeType) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeErrorLog) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeFwSlotInfoLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeEnduranceGroupLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrlZns) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsNvm) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsZns) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeNvmSetAttributes) != 128);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNvmSetList) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeBar) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeZoneDescriptor) != 64);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeLBAFE) != 16);
 }
 #endif
-- 
2.27.0



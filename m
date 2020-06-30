Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA52C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 04:32:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F68720809
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 04:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F68720809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq7x0-0008Kq-GW
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 00:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jq7ve-0006xT-T7; Tue, 30 Jun 2020 00:31:30 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jq7vb-0004SL-Kx; Tue, 30 Jun 2020 00:31:30 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 8CB02BF717;
 Tue, 30 Jun 2020 04:31:25 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 1/3] hw/block/nvme: add NVMe 1.4 specific fields
Date: Tue, 30 Jun 2020 06:31:20 +0200
Message-Id: <20200630043122.1307043-2-its@irrelevant.dk>
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Add new fields from NVM Express v1.4.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c      |   3 +-
 include/block/nvme.h | 195 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 172 insertions(+), 26 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 8e147b667c81..07ac409f37c9 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -60,7 +60,7 @@
 #define NVME_MAX_IOQPAIRS 0xffff
 #define NVME_REG_SIZE 0x1000
 #define NVME_DB_SIZE  4
-#define NVME_SPEC_VER 0x00010300
+#define NVME_SPEC_VER 0x00010400
 #define NVME_CMB_BIR 2
 #define NVME_PMR_BIR 2
 #define NVME_TEMPERATURE 0x143
@@ -2910,6 +2910,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->ieee[2] = 0xb3;
     id->mdts = n->params.mdts;
     id->ver = cpu_to_le32(NVME_SPEC_VER);
+    id->cntrltype = 0x1;
     id->oacs = cpu_to_le16(0);
 
     /*
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 2a9c5e95bfd2..b27be237cd33 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -7,7 +7,7 @@ typedef struct NvmeBar {
     uint32_t    intms;
     uint32_t    intmc;
     uint32_t    cc;
-    uint32_t    rsvd1;
+    uint8_t     rsvd24[4];
     uint32_t    csts;
     uint32_t    nssrc;
     uint32_t    aqa;
@@ -15,14 +15,20 @@ typedef struct NvmeBar {
     uint64_t    acq;
     uint32_t    cmbloc;
     uint32_t    cmbsz;
-    uint8_t     padding[3520]; /* not used by QEMU */
+    uint32_t    bpinfo;
+    uint32_t    bprsel;
+    uint64_t    bpmbl;
+    uint64_t    cmbmsc;
+    uint32_t    cmbsts;
+    uint8_t     rsvd92[3492];
     uint32_t    pmrcap;
     uint32_t    pmrctl;
     uint32_t    pmrsts;
     uint32_t    pmrebs;
     uint32_t    pmrswtp;
-    uint32_t    pmrmsc;
-} NvmeBar;
+    uint64_t    pmrmsc;
+    uint8_t     rsvd3612[484];
+} QEMU_PACKED NvmeBar;
 
 enum NvmeCapShift {
     CAP_MQES_SHIFT     = 0,
@@ -34,7 +40,8 @@ enum NvmeCapShift {
     CAP_CSS_SHIFT      = 37,
     CAP_MPSMIN_SHIFT   = 48,
     CAP_MPSMAX_SHIFT   = 52,
-    CAP_PMR_SHIFT      = 56,
+    CAP_PMRS_SHIFT     = 56,
+    CAP_CMBS_SHIFT     = 57,
 };
 
 enum NvmeCapMask {
@@ -47,7 +54,8 @@ enum NvmeCapMask {
     CAP_CSS_MASK       = 0xff,
     CAP_MPSMIN_MASK    = 0xf,
     CAP_MPSMAX_MASK    = 0xf,
-    CAP_PMR_MASK       = 0x1,
+    CAP_PMRS_MASK      = 0x1,
+    CAP_CMBS_MASK      = 0x1,
 };
 
 #define NVME_CAP_MQES(cap)  (((cap) >> CAP_MQES_SHIFT)   & CAP_MQES_MASK)
@@ -59,6 +67,8 @@ enum NvmeCapMask {
 #define NVME_CAP_CSS(cap)   (((cap) >> CAP_CSS_SHIFT)    & CAP_CSS_MASK)
 #define NVME_CAP_MPSMIN(cap)(((cap) >> CAP_MPSMIN_SHIFT) & CAP_MPSMIN_MASK)
 #define NVME_CAP_MPSMAX(cap)(((cap) >> CAP_MPSMAX_SHIFT) & CAP_MPSMAX_MASK)
+#define NVME_CAP_PMRS(cap)  (((cap) >> CAP_PMRS_SHIFT)   & CAP_PMRS_MASK)
+#define NVME_CAP_CMBS(cap)  (((cap) >> CAP_CMBS_SHIFT)   & CAP_CMBS_MASK)
 
 #define NVME_CAP_SET_MQES(cap, val)   (cap |= (uint64_t)(val & CAP_MQES_MASK)  \
                                                            << CAP_MQES_SHIFT)
@@ -78,8 +88,10 @@ enum NvmeCapMask {
                                                            << CAP_MPSMIN_SHIFT)
 #define NVME_CAP_SET_MPSMAX(cap, val) (cap |= (uint64_t)(val & CAP_MPSMAX_MASK)\
                                                             << CAP_MPSMAX_SHIFT)
-#define NVME_CAP_SET_PMRS(cap, val) (cap |= (uint64_t)(val & CAP_PMR_MASK)\
-                                                            << CAP_PMR_SHIFT)
+#define NVME_CAP_SET_PMRS(cap, val)   (cap |= (uint64_t)(val & CAP_PMRS_MASK)\
+                                                            << CAP_PMRS_SHIFT)
+#define NVME_CAP_SET_CMBS(cap, val)   (cap |= (uint64_t)(val & CAP_CMBS_MASK)\
+                                                            << CAP_CMBS_SHIFT)
 
 enum NvmeCcShift {
     CC_EN_SHIFT     = 0,
@@ -151,22 +163,58 @@ enum NvmeAqaMask {
 #define NVME_AQA_ACQS(aqa) ((aqa >> AQA_ACQS_SHIFT) & AQA_ACQS_MASK)
 
 enum NvmeCmblocShift {
-    CMBLOC_BIR_SHIFT  = 0,
-    CMBLOC_OFST_SHIFT = 12,
+    CMBLOC_BIR_SHIFT     = 0,
+    CMBLOC_CQMMS_SHIFT   = 3,
+    CMBLOC_CQPDS_SHIFT   = 4,
+    CMBLOC_CDPMLS_SHIFT  = 5,
+    CMBLOC_CDPCILS_SHIFT = 6,
+    CMBLOC_CDMMMS_SHIFT  = 7,
+    CMBLOC_CQDA_SHIFT    = 8,
+    CMBLOC_OFST_SHIFT    = 12,
 };
 
 enum NvmeCmblocMask {
-    CMBLOC_BIR_MASK  = 0x7,
-    CMBLOC_OFST_MASK = 0xfffff,
+    CMBLOC_BIR_MASK     = 0x7,
+    CMBLOC_CQMMS_MASK   = 0x1,
+    CMBLOC_CQPDS_MASK   = 0x1,
+    CMBLOC_CDPMLS_MASK  = 0x1,
+    CMBLOC_CDPCILS_MASK = 0x1,
+    CMBLOC_CDMMMS_MASK  = 0x1,
+    CMBLOC_CQDA_MASK    = 0x1,
+    CMBLOC_OFST_MASK    = 0xfffff,
 };
 
-#define NVME_CMBLOC_BIR(cmbloc) ((cmbloc >> CMBLOC_BIR_SHIFT)  & \
-                                 CMBLOC_BIR_MASK)
-#define NVME_CMBLOC_OFST(cmbloc)((cmbloc >> CMBLOC_OFST_SHIFT) & \
-                                 CMBLOC_OFST_MASK)
+#define NVME_CMBLOC_BIR(cmbloc) \
+    ((cmbloc >> CMBLOC_BIR_SHIFT) & CMBLOC_BIR_MASK)
+#define NVME_CMBLOC_CQMMS(cmbloc) \
+    ((cmbloc >> CMBLOC_CQMMS_SHIFT) & CMBLOC_CQMMS_MASK)
+#define NVME_CMBLOC_CQPDS(cmbloc) \
+    ((cmbloc >> CMBLOC_CQPDS_SHIFT) & CMBLOC_CQPDS_MASK)
+#define NVME_CMBLOC_CDPMLS(cmbloc) \
+    ((cmbloc >> CMBLOC_CDPMLS_SHIFT) & CMBLOC_CDPMLS_MASK)
+#define NVME_CMBLOC_CDPCILS(cmbloc) \
+    ((cmbloc >> CMBLOC_CDPCILS_SHIFT) & CMBLOC_CDPCILS_MASK)
+#define NVME_CMBLOC_CDMMS(cmbloc) \
+    ((cmbloc >> CMBLOC_CDMMS_SHIFT) & CMBLOC_CDMMS_MASK)
+#define NVME_CMBLOC_CQDA(cmbloc) \
+    ((cmbloc >> CMBLOC_CQDA_SHIFT) & CMBLOC_CQDA_MASK)
+#define NVME_CMBLOC_OFST(cmbloc) \
+    ((cmbloc >> CMBLOC_OFST_SHIFT) & CMBLOC_OFST_MASK)
 
-#define NVME_CMBLOC_SET_BIR(cmbloc, val)  \
+#define NVME_CMBLOC_SET_BIR(cmbloc, val) \
     (cmbloc |= (uint64_t)(val & CMBLOC_BIR_MASK) << CMBLOC_BIR_SHIFT)
+#define NVME_CMBLOC_SET_CQMMS(cmbloc, val) \
+    (cmbloc |= (uint64_t)(val & CMBLOC_CQMMS_MASK) << CMBLOC_CQMMS_SHIFT)
+#define NVME_CMBLOC_SET_CQPDS(cmbloc, val) \
+    (cmbloc |= (uint64_t)(val & CMBLOC_CQPDS_MASK) << CMBLOC_CQPDS_SHIFT)
+#define NVME_CMBLOC_SET_CDPMLS(cmbloc, val) \
+    (cmbloc |= (uint64_t)(val & CMBLOC_CDPMLS_MASK) << CMBLOC_CDPMLS_SHIFT)
+#define NVME_CMBLOC_SET_CDPCILS(cmbloc, val) \
+    (cmbloc |= (uint64_t)(val & CMBLOC_CDPCILS_MASK) << CMBLOC_CDPCILS_SHIFT)
+#define NVME_CMBLOC_SET_CDMMS(cmbloc, val) \
+    (cmbloc |= (uint64_t)(val & CMBLOC_CDMMS_MASK) << CMBLOC_CDMMS_SHIFT)
+#define NVME_CMBLOC_SET_CQDA(cmbloc, val) \
+    (cmbloc |= (uint64_t)(val & CMBLOC_CQDA_MASK) << CMBLOC_CQDA_SHIFT)
 #define NVME_CMBLOC_SET_OFST(cmbloc, val) \
     (cmbloc |= (uint64_t)(val & CMBLOC_OFST_MASK) << CMBLOC_OFST_SHIFT)
 
@@ -377,6 +425,35 @@ enum NvmePmrmscMask {
 #define NVME_PMRMSC_SET_CBA(pmrmsc, val)   \
     (pmrmsc |= (uint64_t)(val & PMRMSC_CBA_MASK) << PMRMSC_CBA_SHIFT)
 
+enum NvmeCmbmscShift {
+    CMBMSC_CRE_SHIFT  = 0,
+    CMBMSC_CMSE_SHIFT = 1,
+    CMBMSC_CBA_SHIFT  = 12,
+};
+
+enum NvmeCmbmscMask {
+    CMBMSC_CRE_MASK  = 0x1,
+    CMBMSC_CMSE_MASK = 0x1,
+};
+
+#define CMBMSC_CBA_MASK ((1 << 52) - 1)
+
+#define NVME_CMBMSC_CRE(cmbmsc) \
+    ((cmbmsc >> CMBMSC_CRE_SHIFT)  & CMBMSC_CRE_MASK)
+#define NVME_CMBMSC_CMSE(cmbmsc) \
+    ((cmbmsc >> CMBMSC_CMSE_SHIFT) & CMBMSC_CMSE_MASK)
+#define NVME_CMBMSC_CBA(cmbmsc) \
+    ((cmbmsc >> CMBMSC_CBA_SHIFT)  & CMBMSC_CBA_MASK)
+
+#define NVME_CMBMSC_SET_CRE(cmbmsc, val)  \
+    (cmbmsc |= (uint64_t)(val & CMBMSC_CRE_MASK) << CMBMSC_CRE_SHIFT)
+#define NVME_CMBMSC_SET_CMSE(cmbmsc, val) \
+    (cmbmsc |= (uint64_t)(val & CMBMSC_CMSE_MASK) << CMBMSC_CMSE_SHIFT)
+#define NVME_CMBMSC_SET_CBA(cmbmsc, val)  \
+    (cmbmsc |= (uint64_t)(val & CMBMSC_CBA_MASK) << CMBMSC_CBA_SHIFT)
+
+#define NVME_CMBSTS_CBAI(cmbsts) (cmsts & 0x1)
+
 enum NvmeSglDescriptorType {
     NVME_SGL_DESCR_TYPE_DATA_BLOCK          = 0x0,
     NVME_SGL_DESCR_TYPE_BIT_BUCKET          = 0x1,
@@ -523,8 +600,12 @@ typedef struct NvmeIdentify {
     uint64_t    rsvd2[2];
     uint64_t    prp1;
     uint64_t    prp2;
-    uint32_t    cns;
-    uint32_t    rsvd11[5];
+    uint8_t     cns;
+    uint8_t     rsvd3;
+    uint16_t    cntid;
+    uint16_t    nvmsetid;
+    uint16_t    rsvd4;
+    uint32_t    rsvd11[4];
 } NvmeIdentify;
 
 typedef struct NvmeRwCmd {
@@ -681,6 +762,23 @@ enum NvmeStatusCodes {
     NVME_NO_COMPLETE            = 0xffff,
 };
 
+typedef struct NvmeNvmSetAttributes {
+    uint16_t nvmsetid;
+    uint16_t endgid;
+    uint8_t  rsvd7[4];
+    uint32_t rrt;
+    uint32_t ows;
+    uint8_t  tnvmsetcap[16];
+    uint8_t  unvmsetcap[16];
+    uint8_t  rsvd127[80];
+} NvmeNvmSetAttributes;
+
+typedef struct NvmeIdNvmSetList {
+    uint8_t nid;
+    uint8_t rsvd127[127];
+    NvmeNvmSetAttributes sets[31];
+} NvmeIdNvmSetList;
+
 typedef struct NvmeFwSlotInfoLog {
     uint8_t     afi;
     uint8_t     reserved1[7];
@@ -734,6 +832,24 @@ enum NvmeSmartWarn {
     NVME_SMART_FAILED_VOLATILE_MEDIA  = 1 << 4,
 };
 
+typedef struct NvmeEnduranceGroupLog {
+    uint8_t critical_warning;
+    uint8_t rsvd2[2];
+    uint8_t available_spare;
+    uint8_t available_spare_threshold;
+    uint8_t percentage_used;
+    uint8_t rsvd31[26];
+    uint8_t endurance_estimate[16];
+    uint8_t data_units_read[16];
+    uint8_t data_units_written[16];
+    uint8_t media_units_written[16];
+    uint8_t host_read_commands[16];
+    uint8_t host_write_commands[16];
+    uint8_t media_and_data_integrity_errors[16];
+    uint8_t number_of_error_information_log_entries[16];
+    uint8_t rsvd511[352];
+} NvmeEnduranceGroupLog;
+
 enum NvmeLogIdentifier {
     NVME_LOG_ERROR_INFO     = 0x01,
     NVME_LOG_SMART_INFO     = 0x02,
@@ -777,9 +893,14 @@ typedef struct NvmeIdCtrl {
     uint32_t    rtd3e;
     uint32_t    oaes;
     uint32_t    ctratt;
-    uint8_t     rsvd100[12];
+    uint16_t    rrls;
+    uint8_t     rsvd102[9];
+    uint8_t     cntrltype;
     uint8_t     fguid[16];
-    uint8_t     rsvd128[128];
+    uint16_t    crdt1;
+    uint16_t    crdt2;
+    uint16_t    crdt3;
+    uint8_t     rsvd134[122];
     uint16_t    oacs;
     uint8_t     acl;
     uint8_t     aerl;
@@ -805,7 +926,16 @@ typedef struct NvmeIdCtrl {
     uint16_t    mntmt;
     uint16_t    mxtmt;
     uint32_t    sanicap;
-    uint8_t     rsvd332[180];
+    uint32_t    hmminds;
+    uint16_t    hmmaxd;
+    uint16_t    nsetidmax;
+    uint16_t    endgidmax;
+    uint8_t     anatt;
+    uint8_t     anacap;
+    uint32_t    anagrpmax;
+    uint32_t    nanagrpid;
+    uint32_t    pels;
+    uint8_t     rsvd356[156];
     uint8_t     sqes;
     uint8_t     cqes;
     uint16_t    maxcmd;
@@ -817,11 +947,12 @@ typedef struct NvmeIdCtrl {
     uint16_t    awun;
     uint16_t    awupf;
     uint8_t     nvscc;
-    uint8_t     rsvd531;
+    uint8_t     nwpc;
     uint16_t    acwu;
     uint8_t     rsvd534[2];
     uint32_t    sgls;
-    uint8_t     rsvd540[228];
+    uint32_t    mnan;
+    uint8_t     rsvd544[224];
     uint8_t     subnqn[256];
     uint8_t     rsvd1024[1024];
     NvmePSD     psd[32];
@@ -976,7 +1107,17 @@ typedef struct NvmeIdNs {
     uint16_t    nabspf;
     uint16_t    noiob;
     uint8_t     nvmcap[16];
-    uint8_t     rsvd64[40];
+    uint16_t    npwg;
+    uint16_t    npwa;
+    uint16_t    npdg;
+    uint16_t    npda;
+    uint16_t    nows;
+    uint8_t     rsvd74[18];
+    uint32_t    anagrpid;
+    uint8_t     rsvd96[3];
+    uint8_t     nsattr;
+    uint16_t    nvmsetid;
+    uint16_t    endgid;
     uint8_t     nguid[16];
     uint64_t    eui64;
     NvmeLBAF    lbaf[16];
@@ -1048,7 +1189,11 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeErrorLog) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeFwSlotInfoLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) != 512);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeEnduranceGroupLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeNvmSetAttributes) != 128);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNvmSetList) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeBar) != 4096);
 }
 #endif
-- 
2.27.0



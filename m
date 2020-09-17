Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC738C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A0452087D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0452087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIt7n-0002yb-5T
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 08:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1kIswl-0008Je-Lx; Thu, 17 Sep 2020 08:23:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4712 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1kIswf-0003PA-35; Thu, 17 Sep 2020 08:23:31 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 61BBBA25FC46152E5D83;
 Thu, 17 Sep 2020 20:23:20 +0800 (CST)
Received: from localhost.localdomain (10.175.104.175) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 20:23:12 +0800
From: Peng Liang <liangpeng10@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [RFC v2 04/10] target/arm: convert isar regs to array
Date: Thu, 17 Sep 2020 20:14:43 +0800
Message-ID: <20200917121449.3442059-5-liangpeng10@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200917121449.3442059-1-liangpeng10@huawei.com>
References: <20200917121449.3442059-1-liangpeng10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=liangpeng10@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 08:17:13
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: peter.maydell@linaro.org, drjones@redhat.com,
 zhang.zhanghailiang@huawei.com, mst@redhat.com, cohuck@redhat.com,
 xiexiangyou@huawei.com, Peng Liang <liangpeng10@huawei.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The isar in ARMCPU is a struct, each field of which represents an ID
register.  It's not convenient for us to support CPU feature in AArch64.
So let's change it to an array first and add an enum as the index of the
array for convenience.  Since we will never access high 32-bits of ID
registers in AArch32, it's harmless to change the ID registers in
AArch32 to 64-bits.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Peng Liang <liangpeng10@huawei.com>
---
 target/arm/cpu.h       | 225 +++++++++++++++++++------------------
 target/arm/internals.h |  15 +--
 hw/intc/armv7m_nvic.c  |  28 ++---
 target/arm/cpu.c       | 231 ++++++++++++++++++-------------------
 target/arm/cpu64.c     | 174 ++++++++++++++--------------
 target/arm/cpu_tcg.c   | 250 +++++++++++++++++++++--------------------
 target/arm/helper.c    |  54 ++++-----
 target/arm/kvm64.c     |  72 ++++++------
 8 files changed, 531 insertions(+), 518 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d89043448923..d93ad0f8f00e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -67,6 +67,36 @@
 #define ARMV7M_EXCP_PENDSV  14
 #define ARMV7M_EXCP_SYSTICK 15
 
+typedef enum CPUIDReg {
+    ID_ISAR0,
+    ID_ISAR1,
+    ID_ISAR2,
+    ID_ISAR3,
+    ID_ISAR4,
+    ID_ISAR5,
+    ID_ISAR6,
+    ID_MMFR0,
+    ID_MMFR1,
+    ID_MMFR2,
+    ID_MMFR3,
+    ID_MMFR4,
+    MVFR0,
+    MVFR1,
+    MVFR2,
+    ID_DFR0,
+    DBGDIDR,
+    ID_AA64ISAR0,
+    ID_AA64ISAR1,
+    ID_AA64PFR0,
+    ID_AA64PFR1,
+    ID_AA64MMFR0,
+    ID_AA64MMFR1,
+    ID_AA64MMFR2,
+    ID_AA64DFR0,
+    ID_AA64DFR1,
+    ID_MAX
+} CPUIDReg;
+
 /* For M profile, some registers are banked secure vs non-secure;
  * these are represented as a 2-element array where the first element
  * is the non-secure copy and the second is the secure copy.
@@ -894,32 +924,7 @@ struct ARMCPU {
      * field by reading the value from the KVM vCPU.
      */
     struct ARMISARegisters {
-        uint32_t id_isar0;
-        uint32_t id_isar1;
-        uint32_t id_isar2;
-        uint32_t id_isar3;
-        uint32_t id_isar4;
-        uint32_t id_isar5;
-        uint32_t id_isar6;
-        uint32_t id_mmfr0;
-        uint32_t id_mmfr1;
-        uint32_t id_mmfr2;
-        uint32_t id_mmfr3;
-        uint32_t id_mmfr4;
-        uint32_t mvfr0;
-        uint32_t mvfr1;
-        uint32_t mvfr2;
-        uint32_t id_dfr0;
-        uint32_t dbgdidr;
-        uint64_t id_aa64isar0;
-        uint64_t id_aa64isar1;
-        uint64_t id_aa64pfr0;
-        uint64_t id_aa64pfr1;
-        uint64_t id_aa64mmfr0;
-        uint64_t id_aa64mmfr1;
-        uint64_t id_aa64mmfr2;
-        uint64_t id_aa64dfr0;
-        uint64_t id_aa64dfr1;
+        uint64_t regs[ID_MAX];
     } isar;
     uint64_t midr;
     uint32_t revidr;
@@ -3458,82 +3463,82 @@ static inline MemTxAttrs *typecheck_memtxattrs(MemTxAttrs *x)
  */
 static inline bool isar_feature_aa32_thumb_div(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar0, ID_ISAR0, DIVIDE) != 0;
+    return FIELD_EX32(id->regs[ID_ISAR0], ID_ISAR0, DIVIDE) != 0;
 }
 
 static inline bool isar_feature_aa32_arm_div(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar0, ID_ISAR0, DIVIDE) > 1;
+    return FIELD_EX32(id->regs[ID_ISAR0], ID_ISAR0, DIVIDE) > 1;
 }
 
 static inline bool isar_feature_aa32_jazelle(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar1, ID_ISAR1, JAZELLE) != 0;
+    return FIELD_EX32(id->regs[ID_ISAR1], ID_ISAR1, JAZELLE) != 0;
 }
 
 static inline bool isar_feature_aa32_aes(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar5, ID_ISAR5, AES) != 0;
+    return FIELD_EX32(id->regs[ID_ISAR5], ID_ISAR5, AES) != 0;
 }
 
 static inline bool isar_feature_aa32_pmull(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar5, ID_ISAR5, AES) > 1;
+    return FIELD_EX32(id->regs[ID_ISAR5], ID_ISAR5, AES) > 1;
 }
 
 static inline bool isar_feature_aa32_sha1(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar5, ID_ISAR5, SHA1) != 0;
+    return FIELD_EX32(id->regs[ID_ISAR5], ID_ISAR5, SHA1) != 0;
 }
 
 static inline bool isar_feature_aa32_sha2(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar5, ID_ISAR5, SHA2) != 0;
+    return FIELD_EX32(id->regs[ID_ISAR5], ID_ISAR5, SHA2) != 0;
 }
 
 static inline bool isar_feature_aa32_crc32(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar5, ID_ISAR5, CRC32) != 0;
+    return FIELD_EX32(id->regs[ID_ISAR5], ID_ISAR5, CRC32) != 0;
 }
 
 static inline bool isar_feature_aa32_rdm(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar5, ID_ISAR5, RDM) != 0;
+    return FIELD_EX32(id->regs[ID_ISAR5], ID_ISAR5, RDM) != 0;
 }
 
 static inline bool isar_feature_aa32_vcma(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar5, ID_ISAR5, VCMA) != 0;
+    return FIELD_EX32(id->regs[ID_ISAR5], ID_ISAR5, VCMA) != 0;
 }
 
 static inline bool isar_feature_aa32_jscvt(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar6, ID_ISAR6, JSCVT) != 0;
+    return FIELD_EX32(id->regs[ID_ISAR6], ID_ISAR6, JSCVT) != 0;
 }
 
 static inline bool isar_feature_aa32_dp(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar6, ID_ISAR6, DP) != 0;
+    return FIELD_EX32(id->regs[ID_ISAR6], ID_ISAR6, DP) != 0;
 }
 
 static inline bool isar_feature_aa32_fhm(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar6, ID_ISAR6, FHM) != 0;
+    return FIELD_EX32(id->regs[ID_ISAR6], ID_ISAR6, FHM) != 0;
 }
 
 static inline bool isar_feature_aa32_sb(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar6, ID_ISAR6, SB) != 0;
+    return FIELD_EX32(id->regs[ID_ISAR6], ID_ISAR6, SB) != 0;
 }
 
 static inline bool isar_feature_aa32_predinv(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_isar6, ID_ISAR6, SPECRES) != 0;
+    return FIELD_EX32(id->regs[ID_ISAR6], ID_ISAR6, SPECRES) != 0;
 }
 
 static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->mvfr1, MVFR1, FPHP) >= 3;
+    return FIELD_EX32(id->regs[MVFR1], MVFR1, FPHP) >= 3;
 }
 
 static inline bool isar_feature_aa32_vfp_simd(const ARMISARegisters *id)
@@ -3542,42 +3547,42 @@ static inline bool isar_feature_aa32_vfp_simd(const ARMISARegisters *id)
      * Return true if either VFP or SIMD is implemented.
      * In this case, a minimum of VFP w/ D0-D15.
      */
-    return FIELD_EX32(id->mvfr0, MVFR0, SIMDREG) > 0;
+    return FIELD_EX32(id->regs[MVFR0], MVFR0, SIMDREG) > 0;
 }
 
 static inline bool isar_feature_aa32_simd_r32(const ARMISARegisters *id)
 {
     /* Return true if D16-D31 are implemented */
-    return FIELD_EX32(id->mvfr0, MVFR0, SIMDREG) >= 2;
+    return FIELD_EX32(id->regs[MVFR0], MVFR0, SIMDREG) >= 2;
 }
 
 static inline bool isar_feature_aa32_fpshvec(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->mvfr0, MVFR0, FPSHVEC) > 0;
+    return FIELD_EX32(id->regs[MVFR0], MVFR0, FPSHVEC) > 0;
 }
 
 static inline bool isar_feature_aa32_fpsp_v2(const ARMISARegisters *id)
 {
     /* Return true if CPU supports single precision floating point, VFPv2 */
-    return FIELD_EX32(id->mvfr0, MVFR0, FPSP) > 0;
+    return FIELD_EX32(id->regs[MVFR0], MVFR0, FPSP) > 0;
 }
 
 static inline bool isar_feature_aa32_fpsp_v3(const ARMISARegisters *id)
 {
     /* Return true if CPU supports single precision floating point, VFPv3 */
-    return FIELD_EX32(id->mvfr0, MVFR0, FPSP) >= 2;
+    return FIELD_EX32(id->regs[MVFR0], MVFR0, FPSP) >= 2;
 }
 
 static inline bool isar_feature_aa32_fpdp_v2(const ARMISARegisters *id)
 {
     /* Return true if CPU supports double precision floating point, VFPv2 */
-    return FIELD_EX32(id->mvfr0, MVFR0, FPDP) > 0;
+    return FIELD_EX32(id->regs[MVFR0], MVFR0, FPDP) > 0;
 }
 
 static inline bool isar_feature_aa32_fpdp_v3(const ARMISARegisters *id)
 {
     /* Return true if CPU supports double precision floating point, VFPv3 */
-    return FIELD_EX32(id->mvfr0, MVFR0, FPDP) >= 2;
+    return FIELD_EX32(id->regs[MVFR0], MVFR0, FPDP) >= 2;
 }
 
 static inline bool isar_feature_aa32_vfp(const ARMISARegisters *id)
@@ -3592,12 +3597,12 @@ static inline bool isar_feature_aa32_vfp(const ARMISARegisters *id)
  */
 static inline bool isar_feature_aa32_fp16_spconv(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->mvfr1, MVFR1, FPHP) > 0;
+    return FIELD_EX32(id->regs[MVFR1], MVFR1, FPHP) > 0;
 }
 
 static inline bool isar_feature_aa32_fp16_dpconv(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->mvfr1, MVFR1, FPHP) > 1;
+    return FIELD_EX32(id->regs[MVFR1], MVFR1, FPHP) > 1;
 }
 
 /*
@@ -3609,71 +3614,71 @@ static inline bool isar_feature_aa32_fp16_dpconv(const ARMISARegisters *id)
  */
 static inline bool isar_feature_aa32_simdfmac(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->mvfr1, MVFR1, SIMDFMAC) != 0;
+    return FIELD_EX32(id->regs[MVFR1], MVFR1, SIMDFMAC) != 0;
 }
 
 static inline bool isar_feature_aa32_vsel(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 1;
+    return FIELD_EX32(id->regs[MVFR2], MVFR2, FPMISC) >= 1;
 }
 
 static inline bool isar_feature_aa32_vcvt_dr(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 2;
+    return FIELD_EX32(id->regs[MVFR2], MVFR2, FPMISC) >= 2;
 }
 
 static inline bool isar_feature_aa32_vrint(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 3;
+    return FIELD_EX32(id->regs[MVFR2], MVFR2, FPMISC) >= 3;
 }
 
 static inline bool isar_feature_aa32_vminmaxnm(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 4;
+    return FIELD_EX32(id->regs[MVFR2], MVFR2, FPMISC) >= 4;
 }
 
 static inline bool isar_feature_aa32_pan(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr3, ID_MMFR3, PAN) != 0;
+    return FIELD_EX32(id->regs[ID_MMFR3], ID_MMFR3, PAN) != 0;
 }
 
 static inline bool isar_feature_aa32_ats1e1(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr3, ID_MMFR3, PAN) >= 2;
+    return FIELD_EX32(id->regs[ID_MMFR3], ID_MMFR3, PAN) >= 2;
 }
 
 static inline bool isar_feature_aa32_pmu_8_1(const ARMISARegisters *id)
 {
     /* 0xf means "non-standard IMPDEF PMU" */
-    return FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) >= 4 &&
-        FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) != 0xf;
+    return FIELD_EX32(id->regs[ID_DFR0], ID_DFR0, PERFMON) >= 4 &&
+        FIELD_EX32(id->regs[ID_DFR0], ID_DFR0, PERFMON) != 0xf;
 }
 
 static inline bool isar_feature_aa32_pmu_8_4(const ARMISARegisters *id)
 {
     /* 0xf means "non-standard IMPDEF PMU" */
-    return FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) >= 5 &&
-        FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) != 0xf;
+    return FIELD_EX32(id->regs[ID_DFR0], ID_DFR0, PERFMON) >= 5 &&
+        FIELD_EX32(id->regs[ID_DFR0], ID_DFR0, PERFMON) != 0xf;
 }
 
 static inline bool isar_feature_aa32_hpd(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, HPDS) != 0;
+    return FIELD_EX32(id->regs[ID_MMFR4], ID_MMFR4, HPDS) != 0;
 }
 
 static inline bool isar_feature_aa32_ac2(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, AC2) != 0;
+    return FIELD_EX32(id->regs[ID_MMFR4], ID_MMFR4, AC2) != 0;
 }
 
 static inline bool isar_feature_aa32_ccidx(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, CCIDX) != 0;
+    return FIELD_EX32(id->regs[ID_MMFR4], ID_MMFR4, CCIDX) != 0;
 }
 
 static inline bool isar_feature_aa32_tts2uxn(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, XNX) != 0;
+    return FIELD_EX32(id->regs[ID_MMFR4], ID_MMFR4, XNX) != 0;
 }
 
 /*
@@ -3681,92 +3686,92 @@ static inline bool isar_feature_aa32_tts2uxn(const ARMISARegisters *id)
  */
 static inline bool isar_feature_aa64_aes(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, AES) != 0;
+    return FIELD_EX64(id->regs[ID_AA64ISAR0], ID_AA64ISAR0, AES) != 0;
 }
 
 static inline bool isar_feature_aa64_pmull(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, AES) > 1;
+    return FIELD_EX64(id->regs[ID_AA64ISAR0], ID_AA64ISAR0, AES) > 1;
 }
 
 static inline bool isar_feature_aa64_sha1(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SHA1) != 0;
+    return FIELD_EX64(id->regs[ID_AA64ISAR0], ID_AA64ISAR0, SHA1) != 0;
 }
 
 static inline bool isar_feature_aa64_sha256(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SHA2) != 0;
+    return FIELD_EX64(id->regs[ID_AA64ISAR0], ID_AA64ISAR0, SHA2) != 0;
 }
 
 static inline bool isar_feature_aa64_sha512(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SHA2) > 1;
+    return FIELD_EX64(id->regs[ID_AA64ISAR0], ID_AA64ISAR0, SHA2) > 1;
 }
 
 static inline bool isar_feature_aa64_crc32(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, CRC32) != 0;
+    return FIELD_EX64(id->regs[ID_AA64ISAR0], ID_AA64ISAR0, CRC32) != 0;
 }
 
 static inline bool isar_feature_aa64_atomics(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, ATOMIC) != 0;
+    return FIELD_EX64(id->regs[ID_AA64ISAR0], ID_AA64ISAR0, ATOMIC) != 0;
 }
 
 static inline bool isar_feature_aa64_rdm(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, RDM) != 0;
+    return FIELD_EX64(id->regs[ID_AA64ISAR0], ID_AA64ISAR0, RDM) != 0;
 }
 
 static inline bool isar_feature_aa64_sha3(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SHA3) != 0;
+    return FIELD_EX64(id->regs[ID_AA64ISAR0], ID_AA64ISAR0, SHA3) != 0;
 }
 
 static inline bool isar_feature_aa64_sm3(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SM3) != 0;
+    return FIELD_EX64(id->regs[ID_AA64ISAR0], ID_AA64ISAR0, SM3) != 0;
 }
 
 static inline bool isar_feature_aa64_sm4(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, SM4) != 0;
+    return FIELD_EX64(id->regs[ID_AA64ISAR0], ID_AA64ISAR0, SM4) != 0;
 }
 
 static inline bool isar_feature_aa64_dp(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, DP) != 0;
+    return FIELD_EX64(id->regs[ID_AA64ISAR0], ID_AA64ISAR0, DP) != 0;
 }
 
 static inline bool isar_feature_aa64_fhm(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, FHM) != 0;
+    return FIELD_EX64(id->regs[ID_AA64ISAR0], ID_AA64ISAR0, FHM) != 0;
 }
 
 static inline bool isar_feature_aa64_condm_4(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TS) != 0;
+    return FIELD_EX64(id->regs[ID_AA64ISAR0], ID_AA64ISAR0, TS) != 0;
 }
 
 static inline bool isar_feature_aa64_condm_5(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TS) >= 2;
+    return FIELD_EX64(id->regs[ID_AA64ISAR0], ID_AA64ISAR0, TS) >= 2;
 }
 
 static inline bool isar_feature_aa64_rndr(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, RNDR) != 0;
+    return FIELD_EX64(id->regs[ID_AA64ISAR0], ID_AA64ISAR0, RNDR) != 0;
 }
 
 static inline bool isar_feature_aa64_jscvt(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, JSCVT) != 0;
+    return FIELD_EX64(id->regs[ID_AA64ISAR1], ID_AA64ISAR1, JSCVT) != 0;
 }
 
 static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FCMA) != 0;
+    return FIELD_EX64(id->regs[ID_AA64ISAR1], ID_AA64ISAR1, FCMA) != 0;
 }
 
 static inline bool isar_feature_aa64_pauth(const ARMISARegisters *id)
@@ -3777,7 +3782,7 @@ static inline bool isar_feature_aa64_pauth(const ARMISARegisters *id)
      * defined algorithms, and thus API+GPI, and this predicate controls
      * migration of the 128-bit keys.
      */
-    return (id->id_aa64isar1 &
+    return (id->regs[ID_AA64ISAR1] &
             (FIELD_DP64(0, ID_AA64ISAR1, APA, 0xf) |
              FIELD_DP64(0, ID_AA64ISAR1, API, 0xf) |
              FIELD_DP64(0, ID_AA64ISAR1, GPA, 0xf) |
@@ -3786,121 +3791,121 @@ static inline bool isar_feature_aa64_pauth(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa64_sb(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, SB) != 0;
+    return FIELD_EX64(id->regs[ID_AA64ISAR1], ID_AA64ISAR1, SB) != 0;
 }
 
 static inline bool isar_feature_aa64_predinv(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, SPECRES) != 0;
+    return FIELD_EX64(id->regs[ID_AA64ISAR1], ID_AA64ISAR1, SPECRES) != 0;
 }
 
 static inline bool isar_feature_aa64_frint(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FRINTTS) != 0;
+    return FIELD_EX64(id->regs[ID_AA64ISAR1], ID_AA64ISAR1, FRINTTS) != 0;
 }
 
 static inline bool isar_feature_aa64_dcpop(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) != 0;
+    return FIELD_EX64(id->regs[ID_AA64ISAR1], ID_AA64ISAR1, DPB) != 0;
 }
 
 static inline bool isar_feature_aa64_dcpodp(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) >= 2;
+    return FIELD_EX64(id->regs[ID_AA64ISAR1], ID_AA64ISAR1, DPB) >= 2;
 }
 
 static inline bool isar_feature_aa64_fp_simd(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically.  */
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) != 0xf;
+    return FIELD_EX64(id->regs[ID_AA64PFR0], ID_AA64PFR0, FP) != 0xf;
 }
 
 static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically wrt FP16.  */
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) == 1;
+    return FIELD_EX64(id->regs[ID_AA64PFR0], ID_AA64PFR0, FP) == 1;
 }
 
 static inline bool isar_feature_aa64_aa32(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL0) >= 2;
+    return FIELD_EX64(id->regs[ID_AA64PFR0], ID_AA64PFR0, EL0) >= 2;
 }
 
 static inline bool isar_feature_aa64_sve(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SVE) != 0;
+    return FIELD_EX64(id->regs[ID_AA64PFR0], ID_AA64PFR0, SVE) != 0;
 }
 
 static inline bool isar_feature_aa64_vh(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, VH) != 0;
+    return FIELD_EX64(id->regs[ID_AA64MMFR1], ID_AA64MMFR1, VH) != 0;
 }
 
 static inline bool isar_feature_aa64_lor(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, LO) != 0;
+    return FIELD_EX64(id->regs[ID_AA64MMFR1], ID_AA64MMFR1, LO) != 0;
 }
 
 static inline bool isar_feature_aa64_pan(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) != 0;
+    return FIELD_EX64(id->regs[ID_AA64MMFR1], ID_AA64MMFR1, PAN) != 0;
 }
 
 static inline bool isar_feature_aa64_ats1e1(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) >= 2;
+    return FIELD_EX64(id->regs[ID_AA64MMFR1], ID_AA64MMFR1, PAN) >= 2;
 }
 
 static inline bool isar_feature_aa64_uao(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, UAO) != 0;
+    return FIELD_EX64(id->regs[ID_AA64MMFR2], ID_AA64MMFR2, UAO) != 0;
 }
 
 static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
+    return FIELD_EX64(id->regs[ID_AA64PFR1], ID_AA64PFR1, BT) != 0;
 }
 
 static inline bool isar_feature_aa64_mte_insn_reg(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) != 0;
+    return FIELD_EX64(id->regs[ID_AA64PFR1], ID_AA64PFR1, MTE) != 0;
 }
 
 static inline bool isar_feature_aa64_mte(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, MTE) >= 2;
+    return FIELD_EX64(id->regs[ID_AA64PFR1], ID_AA64PFR1, MTE) >= 2;
 }
 
 static inline bool isar_feature_aa64_pmu_8_1(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 4 &&
-        FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
+    return FIELD_EX64(id->regs[ID_AA64DFR0], ID_AA64DFR0, PMUVER) >= 4 &&
+        FIELD_EX64(id->regs[ID_AA64DFR0], ID_AA64DFR0, PMUVER) != 0xf;
 }
 
 static inline bool isar_feature_aa64_pmu_8_4(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) >= 5 &&
-        FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
+    return FIELD_EX64(id->regs[ID_AA64DFR0], ID_AA64DFR0, PMUVER) >= 5 &&
+        FIELD_EX64(id->regs[ID_AA64DFR0], ID_AA64DFR0, PMUVER) != 0xf;
 }
 
 static inline bool isar_feature_aa64_rcpc_8_3(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) != 0;
+    return FIELD_EX64(id->regs[ID_AA64ISAR1], ID_AA64ISAR1, LRCPC) != 0;
 }
 
 static inline bool isar_feature_aa64_rcpc_8_4(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) >= 2;
+    return FIELD_EX64(id->regs[ID_AA64ISAR1], ID_AA64ISAR1, LRCPC) >= 2;
 }
 
 static inline bool isar_feature_aa64_ccidx(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, CCIDX) != 0;
+    return FIELD_EX64(id->regs[ID_AA64MMFR2], ID_AA64MMFR2, CCIDX) != 0;
 }
 
 static inline bool isar_feature_aa64_tts2uxn(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, XNX) != 0;
+    return FIELD_EX64(id->regs[ID_AA64MMFR1], ID_AA64MMFR1, XNX) != 0;
 }
 
 /*
diff --git a/target/arm/internals.h b/target/arm/internals.h
index ae99725d2b5c..bcb9ba9954b5 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -237,7 +237,7 @@ static inline unsigned int arm_pamax(ARMCPU *cpu)
         [5] = 48,
     };
     unsigned int parange =
-        FIELD_EX64(cpu->isar.id_aa64mmfr0, ID_AA64MMFR0, PARANGE);
+        FIELD_EX64(cpu->isar.regs[ID_AA64MMFR0], ID_AA64MMFR0, PARANGE);
 
     /* id_aa64mmfr0 is a read-only register so values outside of the
      * supported mappings can be considered an implementation error.  */
@@ -991,9 +991,9 @@ static inline uint32_t arm_debug_exception_fsr(CPUARMState *env)
 static inline int arm_num_brps(ARMCPU *cpu)
 {
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-        return FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, BRPS) + 1;
+        return FIELD_EX64(cpu->isar.regs[ID_AA64DFR0], ID_AA64DFR0, BRPS) + 1;
     } else {
-        return FIELD_EX32(cpu->isar.dbgdidr, DBGDIDR, BRPS) + 1;
+        return FIELD_EX32(cpu->isar.regs[DBGDIDR], DBGDIDR, BRPS) + 1;
     }
 }
 
@@ -1005,9 +1005,9 @@ static inline int arm_num_brps(ARMCPU *cpu)
 static inline int arm_num_wrps(ARMCPU *cpu)
 {
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-        return FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, WRPS) + 1;
+        return FIELD_EX64(cpu->isar.regs[ID_AA64DFR0], ID_AA64DFR0, WRPS) + 1;
     } else {
-        return FIELD_EX32(cpu->isar.dbgdidr, DBGDIDR, WRPS) + 1;
+        return FIELD_EX32(cpu->isar.regs[DBGDIDR], DBGDIDR, WRPS) + 1;
     }
 }
 
@@ -1019,9 +1019,10 @@ static inline int arm_num_wrps(ARMCPU *cpu)
 static inline int arm_num_ctx_cmps(ARMCPU *cpu)
 {
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-        return FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, CTX_CMPS) + 1;
+        return FIELD_EX64(cpu->isar.regs[ID_AA64DFR0], ID_AA64DFR0,
+                          CTX_CMPS) + 1;
     } else {
-        return FIELD_EX32(cpu->isar.dbgdidr, DBGDIDR, CTX_CMPS) + 1;
+        return FIELD_EX32(cpu->isar.regs[DBGDIDR], DBGDIDR, CTX_CMPS) + 1;
     }
 }
 
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 7876c1ba07ec..afa0e3595e88 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1242,29 +1242,29 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
     case 0xd44: /* PFR1.  */
         return cpu->id_pfr1;
     case 0xd48: /* DFR0.  */
-        return cpu->isar.id_dfr0;
+        return cpu->isar.regs[ID_DFR0];
     case 0xd4c: /* AFR0.  */
         return cpu->id_afr0;
     case 0xd50: /* MMFR0.  */
-        return cpu->isar.id_mmfr0;
+        return cpu->isar.regs[ID_MMFR0];
     case 0xd54: /* MMFR1.  */
-        return cpu->isar.id_mmfr1;
+        return cpu->isar.regs[ID_MMFR1];
     case 0xd58: /* MMFR2.  */
-        return cpu->isar.id_mmfr2;
+        return cpu->isar.regs[ID_MMFR2];
     case 0xd5c: /* MMFR3.  */
-        return cpu->isar.id_mmfr3;
+        return cpu->isar.regs[ID_MMFR3];
     case 0xd60: /* ISAR0.  */
-        return cpu->isar.id_isar0;
+        return cpu->isar.regs[ID_ISAR0];
     case 0xd64: /* ISAR1.  */
-        return cpu->isar.id_isar1;
+        return cpu->isar.regs[ID_ISAR1];
     case 0xd68: /* ISAR2.  */
-        return cpu->isar.id_isar2;
+        return cpu->isar.regs[ID_ISAR2];
     case 0xd6c: /* ISAR3.  */
-        return cpu->isar.id_isar3;
+        return cpu->isar.regs[ID_ISAR3];
     case 0xd70: /* ISAR4.  */
-        return cpu->isar.id_isar4;
+        return cpu->isar.regs[ID_ISAR4];
     case 0xd74: /* ISAR5.  */
-        return cpu->isar.id_isar5;
+        return cpu->isar.regs[ID_ISAR5];
     case 0xd78: /* CLIDR */
         return cpu->clidr;
     case 0xd7c: /* CTR */
@@ -1468,11 +1468,11 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         }
         return cpu->env.v7m.fpdscr[attrs.secure];
     case 0xf40: /* MVFR0 */
-        return cpu->isar.mvfr0;
+        return cpu->isar.regs[MVFR0];
     case 0xf44: /* MVFR1 */
-        return cpu->isar.mvfr1;
+        return cpu->isar.regs[MVFR1];
     case 0xf48: /* MVFR2 */
-        return cpu->isar.mvfr2;
+        return cpu->isar.regs[MVFR2];
     default:
     bad_offset:
         qemu_log_mask(LOG_GUEST_ERROR, "NVIC: Bad read offset 0x%x\n", offset);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7b5ea65fab95..1dd7228875db 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -170,9 +170,9 @@ static void arm_cpu_reset(DeviceState *dev)
     g_hash_table_foreach(cpu->cp_regs, cp_reg_check_reset, cpu);
 
     env->vfp.xregs[ARM_VFP_FPSID] = cpu->reset_fpsid;
-    env->vfp.xregs[ARM_VFP_MVFR0] = cpu->isar.mvfr0;
-    env->vfp.xregs[ARM_VFP_MVFR1] = cpu->isar.mvfr1;
-    env->vfp.xregs[ARM_VFP_MVFR2] = cpu->isar.mvfr2;
+    env->vfp.xregs[ARM_VFP_MVFR0] = cpu->isar.regs[MVFR0];
+    env->vfp.xregs[ARM_VFP_MVFR1] = cpu->isar.regs[MVFR1];
+    env->vfp.xregs[ARM_VFP_MVFR2] = cpu->isar.regs[MVFR2];
 
     cpu->power_state = s->start_powered_off ? PSCI_OFF : PSCI_ON;
 
@@ -1406,19 +1406,19 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         uint64_t t;
         uint32_t u;
 
-        t = cpu->isar.id_aa64isar1;
+        t = cpu->isar.regs[ID_AA64ISAR1];
         t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 0);
-        cpu->isar.id_aa64isar1 = t;
+        cpu->isar.regs[ID_AA64ISAR1] = t;
 
-        t = cpu->isar.id_aa64pfr0;
+        t = cpu->isar.regs[ID_AA64PFR0];
         t = FIELD_DP64(t, ID_AA64PFR0, FP, 0xf);
-        cpu->isar.id_aa64pfr0 = t;
+        cpu->isar.regs[ID_AA64PFR0] = t;
 
-        u = cpu->isar.id_isar6;
+        u = cpu->isar.regs[ID_ISAR6];
         u = FIELD_DP32(u, ID_ISAR6, JSCVT, 0);
-        cpu->isar.id_isar6 = u;
+        cpu->isar.regs[ID_ISAR6] = u;
 
-        u = cpu->isar.mvfr0;
+        u = cpu->isar.regs[MVFR0];
         u = FIELD_DP32(u, MVFR0, FPSP, 0);
         u = FIELD_DP32(u, MVFR0, FPDP, 0);
         u = FIELD_DP32(u, MVFR0, FPTRAP, 0);
@@ -1426,17 +1426,17 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         u = FIELD_DP32(u, MVFR0, FPSQRT, 0);
         u = FIELD_DP32(u, MVFR0, FPSHVEC, 0);
         u = FIELD_DP32(u, MVFR0, FPROUND, 0);
-        cpu->isar.mvfr0 = u;
+        cpu->isar.regs[MVFR0] = u;
 
-        u = cpu->isar.mvfr1;
+        u = cpu->isar.regs[MVFR1];
         u = FIELD_DP32(u, MVFR1, FPFTZ, 0);
         u = FIELD_DP32(u, MVFR1, FPDNAN, 0);
         u = FIELD_DP32(u, MVFR1, FPHP, 0);
-        cpu->isar.mvfr1 = u;
+        cpu->isar.regs[MVFR1] = u;
 
-        u = cpu->isar.mvfr2;
+        u = cpu->isar.regs[MVFR2];
         u = FIELD_DP32(u, MVFR2, FPMISC, 0);
-        cpu->isar.mvfr2 = u;
+        cpu->isar.regs[MVFR2] = u;
     }
 
     if (!cpu->has_neon) {
@@ -1445,60 +1445,60 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
         unset_feature(env, ARM_FEATURE_NEON);
 
-        t = cpu->isar.id_aa64isar0;
+        t = cpu->isar.regs[ID_AA64ISAR0];
         t = FIELD_DP64(t, ID_AA64ISAR0, DP, 0);
-        cpu->isar.id_aa64isar0 = t;
+        cpu->isar.regs[ID_AA64ISAR0] = t;
 
-        t = cpu->isar.id_aa64isar1;
+        t = cpu->isar.regs[ID_AA64ISAR1];
         t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 0);
-        cpu->isar.id_aa64isar1 = t;
+        cpu->isar.regs[ID_AA64ISAR1] = t;
 
-        t = cpu->isar.id_aa64pfr0;
+        t = cpu->isar.regs[ID_AA64PFR0];
         t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 0xf);
-        cpu->isar.id_aa64pfr0 = t;
+        cpu->isar.regs[ID_AA64PFR0] = t;
 
-        u = cpu->isar.id_isar5;
+        u = cpu->isar.regs[ID_ISAR5];
         u = FIELD_DP32(u, ID_ISAR5, RDM, 0);
         u = FIELD_DP32(u, ID_ISAR5, VCMA, 0);
-        cpu->isar.id_isar5 = u;
+        cpu->isar.regs[ID_ISAR5] = u;
 
-        u = cpu->isar.id_isar6;
+        u = cpu->isar.regs[ID_ISAR6];
         u = FIELD_DP32(u, ID_ISAR6, DP, 0);
         u = FIELD_DP32(u, ID_ISAR6, FHM, 0);
-        cpu->isar.id_isar6 = u;
+        cpu->isar.regs[ID_ISAR6] = u;
 
-        u = cpu->isar.mvfr1;
+        u = cpu->isar.regs[MVFR1];
         u = FIELD_DP32(u, MVFR1, SIMDLS, 0);
         u = FIELD_DP32(u, MVFR1, SIMDINT, 0);
         u = FIELD_DP32(u, MVFR1, SIMDSP, 0);
         u = FIELD_DP32(u, MVFR1, SIMDHP, 0);
-        cpu->isar.mvfr1 = u;
+        cpu->isar.regs[MVFR1] = u;
 
-        u = cpu->isar.mvfr2;
+        u = cpu->isar.regs[MVFR2];
         u = FIELD_DP32(u, MVFR2, SIMDMISC, 0);
-        cpu->isar.mvfr2 = u;
+        cpu->isar.regs[MVFR2] = u;
     }
 
     if (!cpu->has_neon && !cpu->has_vfp) {
         uint64_t t;
         uint32_t u;
 
-        t = cpu->isar.id_aa64isar0;
+        t = cpu->isar.regs[ID_AA64ISAR0];
         t = FIELD_DP64(t, ID_AA64ISAR0, FHM, 0);
-        cpu->isar.id_aa64isar0 = t;
+        cpu->isar.regs[ID_AA64ISAR0] = t;
 
-        t = cpu->isar.id_aa64isar1;
+        t = cpu->isar.regs[ID_AA64ISAR1];
         t = FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 0);
-        cpu->isar.id_aa64isar1 = t;
+        cpu->isar.regs[ID_AA64ISAR1] = t;
 
-        u = cpu->isar.mvfr0;
+        u = cpu->isar.regs[MVFR0];
         u = FIELD_DP32(u, MVFR0, SIMDREG, 0);
-        cpu->isar.mvfr0 = u;
+        cpu->isar.regs[MVFR0] = u;
 
         /* Despite the name, this field covers both VFP and Neon */
-        u = cpu->isar.mvfr1;
+        u = cpu->isar.regs[MVFR1];
         u = FIELD_DP32(u, MVFR1, SIMDFMAC, 0);
-        cpu->isar.mvfr1 = u;
+        cpu->isar.regs[MVFR1] = u;
     }
 
     if (arm_feature(env, ARM_FEATURE_M) && !cpu->has_dsp) {
@@ -1506,19 +1506,19 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
         unset_feature(env, ARM_FEATURE_THUMB_DSP);
 
-        u = cpu->isar.id_isar1;
+        u = cpu->isar.regs[ID_ISAR1];
         u = FIELD_DP32(u, ID_ISAR1, EXTEND, 1);
-        cpu->isar.id_isar1 = u;
+        cpu->isar.regs[ID_ISAR1] = u;
 
-        u = cpu->isar.id_isar2;
+        u = cpu->isar.regs[ID_ISAR2];
         u = FIELD_DP32(u, ID_ISAR2, MULTU, 1);
         u = FIELD_DP32(u, ID_ISAR2, MULTS, 1);
-        cpu->isar.id_isar2 = u;
+        cpu->isar.regs[ID_ISAR2] = u;
 
-        u = cpu->isar.id_isar3;
+        u = cpu->isar.regs[ID_ISAR3];
         u = FIELD_DP32(u, ID_ISAR3, SIMD, 1);
         u = FIELD_DP32(u, ID_ISAR3, SATURATE, 0);
-        cpu->isar.id_isar3 = u;
+        cpu->isar.regs[ID_ISAR3] = u;
     }
 
     /* Some features automatically imply others: */
@@ -1661,7 +1661,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * registers as well. These are id_pfr1[7:4] and id_aa64pfr0[15:12].
          */
         cpu->id_pfr1 &= ~0xf0;
-        cpu->isar.id_aa64pfr0 &= ~0xf000;
+        cpu->isar.regs[ID_AA64PFR0] &= ~0xf000;
     }
 
     if (!cpu->has_el2) {
@@ -1684,9 +1684,10 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
                 cpu);
 #endif
     } else {
-        cpu->isar.id_aa64dfr0 =
-            FIELD_DP64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, PMUVER, 0);
-        cpu->isar.id_dfr0 = FIELD_DP32(cpu->isar.id_dfr0, ID_DFR0, PERFMON, 0);
+        cpu->isar.regs[ID_AA64DFR0] =
+            FIELD_DP64(cpu->isar.regs[ID_AA64DFR0], ID_AA64DFR0, PMUVER, 0);
+        cpu->isar.regs[ID_DFR0] = FIELD_DP32(cpu->isar.regs[ID_DFR0], ID_DFR0,
+                                             PERFMON, 0);
         cpu->pmceid0 = 0;
         cpu->pmceid1 = 0;
     }
@@ -1696,7 +1697,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * registers if we don't have EL2. These are id_pfr1[15:12] and
          * id_aa64pfr0_el1[11:8].
          */
-        cpu->isar.id_aa64pfr0 &= ~0xf00;
+        cpu->isar.regs[ID_AA64PFR0] &= ~0xf00;
         cpu->id_pfr1 &= ~0xf000;
     }
 
@@ -1706,8 +1707,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * Disable the MTE feature bits if we do not have tag-memory
          * provided by the machine.
          */
-        cpu->isar.id_aa64pfr1 =
-            FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 0);
+        cpu->isar.regs[ID_AA64PFR1] =
+            FIELD_DP64(cpu->isar.regs[ID_AA64PFR1], ID_AA64PFR1, MTE, 0);
     }
 #endif
 
@@ -1891,24 +1892,24 @@ static void cortex_a8_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     cpu->midr = 0x410fc080;
     cpu->reset_fpsid = 0x410330c0;
-    cpu->isar.mvfr0 = 0x11110222;
-    cpu->isar.mvfr1 = 0x00011111;
+    cpu->isar.regs[MVFR0] = 0x11110222;
+    cpu->isar.regs[MVFR1] = 0x00011111;
     cpu->ctr = 0x82048004;
     cpu->reset_sctlr = 0x00c50078;
     cpu->id_pfr0 = 0x1031;
     cpu->id_pfr1 = 0x11;
-    cpu->isar.id_dfr0 = 0x400;
+    cpu->isar.regs[ID_DFR0] = 0x400;
     cpu->id_afr0 = 0;
-    cpu->isar.id_mmfr0 = 0x31100003;
-    cpu->isar.id_mmfr1 = 0x20000000;
-    cpu->isar.id_mmfr2 = 0x01202000;
-    cpu->isar.id_mmfr3 = 0x11;
-    cpu->isar.id_isar0 = 0x00101111;
-    cpu->isar.id_isar1 = 0x12112111;
-    cpu->isar.id_isar2 = 0x21232031;
-    cpu->isar.id_isar3 = 0x11112131;
-    cpu->isar.id_isar4 = 0x00111142;
-    cpu->isar.dbgdidr = 0x15141000;
+    cpu->isar.regs[ID_MMFR0] = 0x31100003;
+    cpu->isar.regs[ID_MMFR1] = 0x20000000;
+    cpu->isar.regs[ID_MMFR2] = 0x01202000;
+    cpu->isar.regs[ID_MMFR3] = 0x11;
+    cpu->isar.regs[ID_ISAR0] = 0x00101111;
+    cpu->isar.regs[ID_ISAR1] = 0x12112111;
+    cpu->isar.regs[ID_ISAR2] = 0x21232031;
+    cpu->isar.regs[ID_ISAR3] = 0x11112131;
+    cpu->isar.regs[ID_ISAR4] = 0x00111142;
+    cpu->isar.regs[DBGDIDR] = 0x15141000;
     cpu->clidr = (1 << 27) | (2 << 24) | 3;
     cpu->ccsidr[0] = 0xe007e01a; /* 16k L1 dcache. */
     cpu->ccsidr[1] = 0x2007e01a; /* 16k L1 icache. */
@@ -1963,24 +1964,24 @@ static void cortex_a9_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_CBAR);
     cpu->midr = 0x410fc090;
     cpu->reset_fpsid = 0x41033090;
-    cpu->isar.mvfr0 = 0x11110222;
-    cpu->isar.mvfr1 = 0x01111111;
+    cpu->isar.regs[MVFR0] = 0x11110222;
+    cpu->isar.regs[MVFR1] = 0x01111111;
     cpu->ctr = 0x80038003;
     cpu->reset_sctlr = 0x00c50078;
     cpu->id_pfr0 = 0x1031;
     cpu->id_pfr1 = 0x11;
-    cpu->isar.id_dfr0 = 0x000;
+    cpu->isar.regs[ID_DFR0] = 0x000;
     cpu->id_afr0 = 0;
-    cpu->isar.id_mmfr0 = 0x00100103;
-    cpu->isar.id_mmfr1 = 0x20000000;
-    cpu->isar.id_mmfr2 = 0x01230000;
-    cpu->isar.id_mmfr3 = 0x00002111;
-    cpu->isar.id_isar0 = 0x00101111;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232041;
-    cpu->isar.id_isar3 = 0x11112131;
-    cpu->isar.id_isar4 = 0x00111142;
-    cpu->isar.dbgdidr = 0x35141000;
+    cpu->isar.regs[ID_MMFR0] = 0x00100103;
+    cpu->isar.regs[ID_MMFR1] = 0x20000000;
+    cpu->isar.regs[ID_MMFR2] = 0x01230000;
+    cpu->isar.regs[ID_MMFR3] = 0x00002111;
+    cpu->isar.regs[ID_ISAR0] = 0x00101111;
+    cpu->isar.regs[ID_ISAR1] = 0x13112111;
+    cpu->isar.regs[ID_ISAR2] = 0x21232041;
+    cpu->isar.regs[ID_ISAR3] = 0x11112131;
+    cpu->isar.regs[ID_ISAR4] = 0x00111142;
+    cpu->isar.regs[DBGDIDR] = 0x35141000;
     cpu->clidr = (1 << 27) | (1 << 24) | 3;
     cpu->ccsidr[0] = 0xe00fe019; /* 16k L1 dcache. */
     cpu->ccsidr[1] = 0x200fe019; /* 16k L1 icache. */
@@ -2027,27 +2028,27 @@ static void cortex_a7_initfn(Object *obj)
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A7;
     cpu->midr = 0x410fc075;
     cpu->reset_fpsid = 0x41023075;
-    cpu->isar.mvfr0 = 0x10110222;
-    cpu->isar.mvfr1 = 0x11111111;
+    cpu->isar.regs[MVFR0] = 0x10110222;
+    cpu->isar.regs[MVFR1] = 0x11111111;
     cpu->ctr = 0x84448003;
     cpu->reset_sctlr = 0x00c50078;
     cpu->id_pfr0 = 0x00001131;
     cpu->id_pfr1 = 0x00011011;
-    cpu->isar.id_dfr0 = 0x02010555;
+    cpu->isar.regs[ID_DFR0] = 0x02010555;
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x10101105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01240000;
-    cpu->isar.id_mmfr3 = 0x02102211;
+    cpu->isar.regs[ID_MMFR0] = 0x10101105;
+    cpu->isar.regs[ID_MMFR1] = 0x40000000;
+    cpu->isar.regs[ID_MMFR2] = 0x01240000;
+    cpu->isar.regs[ID_MMFR3] = 0x02102211;
     /* a7_mpcore_r0p5_trm, page 4-4 gives 0x01101110; but
      * table 4-41 gives 0x02101110, which includes the arm div insns.
      */
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232041;
-    cpu->isar.id_isar3 = 0x11112131;
-    cpu->isar.id_isar4 = 0x10011142;
-    cpu->isar.dbgdidr = 0x3515f005;
+    cpu->isar.regs[ID_ISAR0] = 0x02101110;
+    cpu->isar.regs[ID_ISAR1] = 0x13112111;
+    cpu->isar.regs[ID_ISAR2] = 0x21232041;
+    cpu->isar.regs[ID_ISAR3] = 0x11112131;
+    cpu->isar.regs[ID_ISAR4] = 0x10011142;
+    cpu->isar.regs[DBGDIDR] = 0x3515f005;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x701fe00a; /* 32K L1 dcache */
     cpu->ccsidr[1] = 0x201fe00a; /* 32K L1 icache */
@@ -2072,24 +2073,24 @@ static void cortex_a15_initfn(Object *obj)
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A15;
     cpu->midr = 0x412fc0f1;
     cpu->reset_fpsid = 0x410430f0;
-    cpu->isar.mvfr0 = 0x10110222;
-    cpu->isar.mvfr1 = 0x11111111;
+    cpu->isar.regs[MVFR0] = 0x10110222;
+    cpu->isar.regs[MVFR1] = 0x11111111;
     cpu->ctr = 0x8444c004;
     cpu->reset_sctlr = 0x00c50078;
     cpu->id_pfr0 = 0x00001131;
     cpu->id_pfr1 = 0x00011011;
-    cpu->isar.id_dfr0 = 0x02010555;
+    cpu->isar.regs[ID_DFR0] = 0x02010555;
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x10201105;
-    cpu->isar.id_mmfr1 = 0x20000000;
-    cpu->isar.id_mmfr2 = 0x01240000;
-    cpu->isar.id_mmfr3 = 0x02102211;
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232041;
-    cpu->isar.id_isar3 = 0x11112131;
-    cpu->isar.id_isar4 = 0x10011142;
-    cpu->isar.dbgdidr = 0x3515f021;
+    cpu->isar.regs[ID_MMFR0] = 0x10201105;
+    cpu->isar.regs[ID_MMFR1] = 0x20000000;
+    cpu->isar.regs[ID_MMFR2] = 0x01240000;
+    cpu->isar.regs[ID_MMFR3] = 0x02102211;
+    cpu->isar.regs[ID_ISAR0] = 0x02101110;
+    cpu->isar.regs[ID_ISAR1] = 0x13112111;
+    cpu->isar.regs[ID_ISAR2] = 0x21232041;
+    cpu->isar.regs[ID_ISAR3] = 0x11112131;
+    cpu->isar.regs[ID_ISAR4] = 0x10011142;
+    cpu->isar.regs[DBGDIDR] = 0x3515f021;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x701fe00a; /* 32K L1 dcache */
     cpu->ccsidr[1] = 0x201fe00a; /* 32K L1 icache */
@@ -2110,7 +2111,7 @@ static void arm_max_initfn(Object *obj)
     cortex_a15_initfn(obj);
 
     /* old-style VFP short-vector support */
-    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
+    cpu->isar.regs[MVFR0] = FIELD_DP32(cpu->isar.[MVFR0], MVFR0, FPSHVEC, 1);
 
 #ifdef CONFIG_USER_ONLY
     /*
@@ -2122,43 +2123,43 @@ static void arm_max_initfn(Object *obj)
     {
         uint32_t t;
 
-        t = cpu->isar.id_isar5;
+        t = cpu->isar.regs[ID_ISAR5];
         t = FIELD_DP32(t, ID_ISAR5, AES, 2);
         t = FIELD_DP32(t, ID_ISAR5, SHA1, 1);
         t = FIELD_DP32(t, ID_ISAR5, SHA2, 1);
         t = FIELD_DP32(t, ID_ISAR5, CRC32, 1);
         t = FIELD_DP32(t, ID_ISAR5, RDM, 1);
         t = FIELD_DP32(t, ID_ISAR5, VCMA, 1);
-        cpu->isar.id_isar5 = t;
+        cpu->isar.regs[ID_ISAR5] = t;
 
-        t = cpu->isar.id_isar6;
+        t = cpu->isar.regs[ID_ISAR6];
         t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);
         t = FIELD_DP32(t, ID_ISAR6, DP, 1);
         t = FIELD_DP32(t, ID_ISAR6, FHM, 1);
         t = FIELD_DP32(t, ID_ISAR6, SB, 1);
         t = FIELD_DP32(t, ID_ISAR6, SPECRES, 1);
-        cpu->isar.id_isar6 = t;
+        cpu->isar.regs[ID_ISAR6] = t;
 
-        t = cpu->isar.mvfr1;
+        t = cpu->isar.regs[MVFR1];
         t = FIELD_DP32(t, MVFR1, FPHP, 3);     /* v8.2-FP16 */
         t = FIELD_DP32(t, MVFR1, SIMDHP, 2);   /* v8.2-FP16 */
-        cpu->isar.mvfr1 = t;
+        cpu->isar.regs[MVFR1] = t;
 
-        t = cpu->isar.mvfr2;
+        t = cpu->isar.regs[MVFR2];
         t = FIELD_DP32(t, MVFR2, SIMDMISC, 3); /* SIMD MaxNum */
         t = FIELD_DP32(t, MVFR2, FPMISC, 4);   /* FP MaxNum */
-        cpu->isar.mvfr2 = t;
+        cpu->isar.regs[MVFR2] = t;
 
-        t = cpu->isar.id_mmfr3;
+        t = cpu->isar.regs[ID_MMFR3];
         t = FIELD_DP32(t, ID_MMFR3, PAN, 2); /* ATS1E1 */
-        cpu->isar.id_mmfr3 = t;
+        cpu->isar.regs[ID_MMFR3] = t;
 
-        t = cpu->isar.id_mmfr4;
+        t = cpu->isar.regs[ID_MMFR4];
         t = FIELD_DP32(t, ID_MMFR4, HPDS, 1); /* AA32HPD */
         t = FIELD_DP32(t, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
         t = FIELD_DP32(t, ID_MMFR4, CNP, 1); /* TTCNP */
         t = FIELD_DP32(t, ID_MMFR4, XNX, 1); /* TTS2UXN */
-        cpu->isar.id_mmfr4 = t;
+        cpu->isar.regs[ID_MMFR4] = t;
     }
 #endif
 }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 3c2b3d959937..2ff9cf3c1471 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -103,31 +103,31 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->midr = 0x411fd070;
     cpu->revidr = 0x00000000;
     cpu->reset_fpsid = 0x41034070;
-    cpu->isar.mvfr0 = 0x10110222;
-    cpu->isar.mvfr1 = 0x12111111;
-    cpu->isar.mvfr2 = 0x00000043;
+    cpu->isar.regs[MVFR0] = 0x10110222;
+    cpu->isar.regs[MVFR1] = 0x12111111;
+    cpu->isar.regs[MVFR2] = 0x00000043;
     cpu->ctr = 0x8444c004;
     cpu->reset_sctlr = 0x00c50838;
     cpu->id_pfr0 = 0x00000131;
     cpu->id_pfr1 = 0x00011011;
-    cpu->isar.id_dfr0 = 0x03010066;
+    cpu->isar.regs[ID_DFR0] = 0x03010066;
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x10101105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02102211;
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232042;
-    cpu->isar.id_isar3 = 0x01112131;
-    cpu->isar.id_isar4 = 0x00011142;
-    cpu->isar.id_isar5 = 0x00011121;
-    cpu->isar.id_isar6 = 0;
-    cpu->isar.id_aa64pfr0 = 0x00002222;
-    cpu->isar.id_aa64dfr0 = 0x10305106;
-    cpu->isar.id_aa64isar0 = 0x00011120;
-    cpu->isar.id_aa64mmfr0 = 0x00001124;
-    cpu->isar.dbgdidr = 0x3516d000;
+    cpu->isar.regs[ID_MMFR0] = 0x10101105;
+    cpu->isar.regs[ID_MMFR1] = 0x40000000;
+    cpu->isar.regs[ID_MMFR2] = 0x01260000;
+    cpu->isar.regs[ID_MMFR3] = 0x02102211;
+    cpu->isar.regs[ID_ISAR0] = 0x02101110;
+    cpu->isar.regs[ID_ISAR1] = 0x13112111;
+    cpu->isar.regs[ID_ISAR2] = 0x21232042;
+    cpu->isar.regs[ID_ISAR3] = 0x01112131;
+    cpu->isar.regs[ID_ISAR4] = 0x00011142;
+    cpu->isar.regs[ID_ISAR5] = 0x00011121;
+    cpu->isar.regs[ID_ISAR6] = 0;
+    cpu->isar.regs[ID_AA64PFR0] = 0x00002222;
+    cpu->isar.regs[ID_AA64DFR0] = 0x10305106;
+    cpu->isar.regs[ID_AA64ISAR0] = 0x00011120;
+    cpu->isar.regs[ID_AA64MMFR0] = 0x00001124;
+    cpu->isar.regs[DBGDIDR] = 0x3516d000;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
     cpu->ccsidr[1] = 0x201fe012; /* 48KB L1 icache */
@@ -156,31 +156,31 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->midr = 0x410fd034;
     cpu->revidr = 0x00000000;
     cpu->reset_fpsid = 0x41034070;
-    cpu->isar.mvfr0 = 0x10110222;
-    cpu->isar.mvfr1 = 0x12111111;
-    cpu->isar.mvfr2 = 0x00000043;
+    cpu->isar.regs[MVFR0] = 0x10110222;
+    cpu->isar.regs[MVFR1] = 0x12111111;
+    cpu->isar.regs[MVFR2] = 0x00000043;
     cpu->ctr = 0x84448004; /* L1Ip = VIPT */
     cpu->reset_sctlr = 0x00c50838;
     cpu->id_pfr0 = 0x00000131;
     cpu->id_pfr1 = 0x00011011;
-    cpu->isar.id_dfr0 = 0x03010066;
+    cpu->isar.regs[ID_DFR0] = 0x03010066;
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x10101105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02102211;
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232042;
-    cpu->isar.id_isar3 = 0x01112131;
-    cpu->isar.id_isar4 = 0x00011142;
-    cpu->isar.id_isar5 = 0x00011121;
-    cpu->isar.id_isar6 = 0;
-    cpu->isar.id_aa64pfr0 = 0x00002222;
-    cpu->isar.id_aa64dfr0 = 0x10305106;
-    cpu->isar.id_aa64isar0 = 0x00011120;
-    cpu->isar.id_aa64mmfr0 = 0x00001122; /* 40 bit physical addr */
-    cpu->isar.dbgdidr = 0x3516d000;
+    cpu->isar.regs[ID_MMFR0] = 0x10101105;
+    cpu->isar.regs[ID_MMFR1] = 0x40000000;
+    cpu->isar.regs[ID_MMFR2] = 0x01260000;
+    cpu->isar.regs[ID_MMFR3] = 0x02102211;
+    cpu->isar.regs[ID_ISAR0] = 0x02101110;
+    cpu->isar.regs[ID_ISAR1] = 0x13112111;
+    cpu->isar.regs[ID_ISAR2] = 0x21232042;
+    cpu->isar.regs[ID_ISAR3] = 0x01112131;
+    cpu->isar.regs[ID_ISAR4] = 0x00011142;
+    cpu->isar.regs[ID_ISAR5] = 0x00011121;
+    cpu->isar.regs[ID_ISAR6] = 0;
+    cpu->isar.regs[ID_AA64PFR0] = 0x00002222;
+    cpu->isar.regs[ID_AA64DFR0] = 0x10305106;
+    cpu->isar.regs[ID_AA64ISAR0] = 0x00011120;
+    cpu->isar.regs[ID_AA64MMFR0] = 0x00001122; /* 40 bit physical addr */
+    cpu->isar.regs[DBGDIDR] = 0x3516d000;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x700fe01a; /* 32KB L1 dcache */
     cpu->ccsidr[1] = 0x201fe00a; /* 32KB L1 icache */
@@ -208,30 +208,30 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->midr = 0x410fd083;
     cpu->revidr = 0x00000000;
     cpu->reset_fpsid = 0x41034080;
-    cpu->isar.mvfr0 = 0x10110222;
-    cpu->isar.mvfr1 = 0x12111111;
-    cpu->isar.mvfr2 = 0x00000043;
+    cpu->isar.regs[MVFR0] = 0x10110222;
+    cpu->isar.regs[MVFR1] = 0x12111111;
+    cpu->isar.regs[MVFR2] = 0x00000043;
     cpu->ctr = 0x8444c004;
     cpu->reset_sctlr = 0x00c50838;
     cpu->id_pfr0 = 0x00000131;
     cpu->id_pfr1 = 0x00011011;
-    cpu->isar.id_dfr0 = 0x03010066;
+    cpu->isar.regs[ID_DFR0] = 0x03010066;
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x10201105;
-    cpu->isar.id_mmfr1 = 0x40000000;
-    cpu->isar.id_mmfr2 = 0x01260000;
-    cpu->isar.id_mmfr3 = 0x02102211;
-    cpu->isar.id_isar0 = 0x02101110;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232042;
-    cpu->isar.id_isar3 = 0x01112131;
-    cpu->isar.id_isar4 = 0x00011142;
-    cpu->isar.id_isar5 = 0x00011121;
-    cpu->isar.id_aa64pfr0 = 0x00002222;
-    cpu->isar.id_aa64dfr0 = 0x10305106;
-    cpu->isar.id_aa64isar0 = 0x00011120;
-    cpu->isar.id_aa64mmfr0 = 0x00001124;
-    cpu->isar.dbgdidr = 0x3516d000;
+    cpu->isar.regs[ID_MMFR0] = 0x10201105;
+    cpu->isar.regs[ID_MMFR1] = 0x40000000;
+    cpu->isar.regs[ID_MMFR2] = 0x01260000;
+    cpu->isar.regs[ID_MMFR3] = 0x02102211;
+    cpu->isar.regs[ID_ISAR0] = 0x02101110;
+    cpu->isar.regs[ID_ISAR1] = 0x13112111;
+    cpu->isar.regs[ID_ISAR2] = 0x21232042;
+    cpu->isar.regs[ID_ISAR3] = 0x01112131;
+    cpu->isar.regs[ID_ISAR4] = 0x00011142;
+    cpu->isar.regs[ID_ISAR5] = 0x00011121;
+    cpu->isar.regs[ID_AA64PFR0] = 0x00002222;
+    cpu->isar.regs[ID_AA64DFR0] = 0x10305106;
+    cpu->isar.regs[ID_AA64ISAR0] = 0x00011120;
+    cpu->isar.regs[ID_AA64MMFR0] = 0x00001124;
+    cpu->isar.regs[DBGDIDR] = 0x3516d000;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
     cpu->ccsidr[1] = 0x201fe012; /* 48KB L1 icache */
@@ -552,9 +552,9 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    t = cpu->isar.id_aa64pfr0;
+    t = cpu->isar.regs[ID_AA64PFR0];
     t = FIELD_DP64(t, ID_AA64PFR0, SVE, value);
-    cpu->isar.id_aa64pfr0 = t;
+    cpu->isar.regs[ID_AA64PFR0] = t;
 }
 
 void aarch64_add_sve_properties(Object *obj)
@@ -607,7 +607,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, MIDR_EL1, REVISION, 0);
         cpu->midr = t;
 
-        t = cpu->isar.id_aa64isar0;
+        t = cpu->isar.regs[ID_AA64ISAR0];
         t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2); /* AES + PMULL */
         t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);
         t = FIELD_DP64(t, ID_AA64ISAR0, SHA2, 2); /* SHA512 */
@@ -621,9 +621,9 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64ISAR0, FHM, 1);
         t = FIELD_DP64(t, ID_AA64ISAR0, TS, 2); /* v8.5-CondM */
         t = FIELD_DP64(t, ID_AA64ISAR0, RNDR, 1);
-        cpu->isar.id_aa64isar0 = t;
+        cpu->isar.regs[ID_AA64ISAR0] = t;
 
-        t = cpu->isar.id_aa64isar1;
+        t = cpu->isar.regs[ID_AA64ISAR1];
         t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);
         t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);
@@ -635,15 +635,15 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64ISAR1, SPECRES, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 1);
         t = FIELD_DP64(t, ID_AA64ISAR1, LRCPC, 2); /* ARMv8.4-RCPC */
-        cpu->isar.id_aa64isar1 = t;
+        cpu->isar.regs[ID_AA64ISAR1] = t;
 
-        t = cpu->isar.id_aa64pfr0;
+        t = cpu->isar.regs[ID_AA64PFR0];
         t = FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
         t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);
         t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);
-        cpu->isar.id_aa64pfr0 = t;
+        cpu->isar.regs[ID_AA64PFR0] = t;
 
-        t = cpu->isar.id_aa64pfr1;
+        t = cpu->isar.regs[ID_AA64PFR1];
         t = FIELD_DP64(t, ID_AA64PFR1, BT, 1);
         /*
          * Begin with full support for MTE. This will be downgraded to MTE=0
@@ -651,63 +651,63 @@ static void aarch64_max_initfn(Object *obj)
          * we do for EL2 with the virtualization=on property.
          */
         t = FIELD_DP64(t, ID_AA64PFR1, MTE, 2);
-        cpu->isar.id_aa64pfr1 = t;
+        cpu->isar.regs[ID_AA64PFR1] = t;
 
-        t = cpu->isar.id_aa64mmfr1;
+        t = cpu->isar.regs[ID_AA64MMFR1];
         t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1); /* HPD */
         t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
         t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);
         t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 2); /* ATS1E1 */
         t = FIELD_DP64(t, ID_AA64MMFR1, VMIDBITS, 2); /* VMID16 */
         t = FIELD_DP64(t, ID_AA64MMFR1, XNX, 1); /* TTS2UXN */
-        cpu->isar.id_aa64mmfr1 = t;
+        cpu->isar.regs[ID_AA64MMFR1] = t;
 
-        t = cpu->isar.id_aa64mmfr2;
+        t = cpu->isar.regs[ID_AA64MMFR2];
         t = FIELD_DP64(t, ID_AA64MMFR2, UAO, 1);
         t = FIELD_DP64(t, ID_AA64MMFR2, CNP, 1); /* TTCNP */
-        cpu->isar.id_aa64mmfr2 = t;
+        cpu->isar.regs[ID_AA64MMFR2] = t;
 
         /* Replicate the same data to the 32-bit id registers.  */
-        u = cpu->isar.id_isar5;
+        u = cpu->isar.regs[ID_ISAR5];
         u = FIELD_DP32(u, ID_ISAR5, AES, 2); /* AES + PMULL */
         u = FIELD_DP32(u, ID_ISAR5, SHA1, 1);
         u = FIELD_DP32(u, ID_ISAR5, SHA2, 1);
         u = FIELD_DP32(u, ID_ISAR5, CRC32, 1);
         u = FIELD_DP32(u, ID_ISAR5, RDM, 1);
         u = FIELD_DP32(u, ID_ISAR5, VCMA, 1);
-        cpu->isar.id_isar5 = u;
+        cpu->isar.regs[ID_ISAR5] = u;
 
-        u = cpu->isar.id_isar6;
+        u = cpu->isar.regs[ID_ISAR6];
         u = FIELD_DP32(u, ID_ISAR6, JSCVT, 1);
         u = FIELD_DP32(u, ID_ISAR6, DP, 1);
         u = FIELD_DP32(u, ID_ISAR6, FHM, 1);
         u = FIELD_DP32(u, ID_ISAR6, SB, 1);
         u = FIELD_DP32(u, ID_ISAR6, SPECRES, 1);
-        cpu->isar.id_isar6 = u;
+        cpu->isar.regs[ID_ISAR6] = u;
 
-        u = cpu->isar.id_mmfr3;
+        u = cpu->isar.regs[ID_MMFR3];
         u = FIELD_DP32(u, ID_MMFR3, PAN, 2); /* ATS1E1 */
-        cpu->isar.id_mmfr3 = u;
+        cpu->isar.regs[ID_MMFR3] = u;
 
-        u = cpu->isar.id_mmfr4;
+        u = cpu->isar.regs[ID_MMFR4];
         u = FIELD_DP32(u, ID_MMFR4, HPDS, 1); /* AA32HPD */
         u = FIELD_DP32(u, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
         u = FIELD_DP32(u, ID_MMFR4, CNP, 1); /* TTCNP */
         u = FIELD_DP32(u, ID_MMFR4, XNX, 1); /* TTS2UXN */
-        cpu->isar.id_mmfr4 = u;
+        cpu->isar.regs[ID_MMFR4] = u;
 
-        t = cpu->isar.id_aa64dfr0;
+        t = cpu->isar.regs[ID_AA64DFR0];
         t = FIELD_DP64(t, ID_AA64DFR0, PMUVER, 5); /* v8.4-PMU */
-        cpu->isar.id_aa64dfr0 = t;
+        cpu->isar.regs[ID_AA64DFR0] = t;
 
-        u = cpu->isar.id_dfr0;
+        u = cpu->isar.regs[ID_DFR0];
         u = FIELD_DP32(u, ID_DFR0, PERFMON, 5); /* v8.4-PMU */
-        cpu->isar.id_dfr0 = u;
+        cpu->isar.regs[ID_DFR0] = u;
 
-        u = cpu->isar.mvfr1;
+        u = cpu->isar.regs[MVFR1];
         u = FIELD_DP32(u, MVFR1, FPHP, 3);      /* v8.2-FP16 */
         u = FIELD_DP32(u, MVFR1, SIMDHP, 2);    /* v8.2-FP16 */
-        cpu->isar.mvfr1 = u;
+        cpu->isar.regs[MVFR1] = u;
 
 #ifdef CONFIG_USER_ONLY
         /* For usermode -cpu max we can use a larger and more efficient DCZ
diff --git a/target/arm/cpu_tcg.c b/target/arm/cpu_tcg.c
index 00b0e08f33e1..715f831fafe0 100644
--- a/target/arm/cpu_tcg.c
+++ b/target/arm/cpu_tcg.c
@@ -56,14 +56,16 @@ static void arm926_initfn(Object *obj)
      * ARMv5 does not have the ID_ISAR registers, but we can still
      * set the field to indicate Jazelle support within QEMU.
      */
-    cpu->isar.id_isar1 = FIELD_DP32(cpu->isar.id_isar1, ID_ISAR1, JAZELLE, 1);
+    cpu->isar.regs[ID_ISAR1] = FIELD_DP32(cpu->isar.regs[ID_ISAR1], ID_ISAR1,
+                                          JAZELLE, 1);
     /*
      * Similarly, we need to set MVFR0 fields to enable vfp and short vector
      * support even though ARMv5 doesn't have this register.
      */
-    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
-    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSP, 1);
-    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPDP, 1);
+    cpu->isar.regs[MVFR0] = FIELD_DP32(cpu->isar.regs[MVFR0], MVFR0,
+                                       FPSHVEC, 1);
+    cpu->isar.regs[MVFR0] = FIELD_DP32(cpu->isar.regs[MVFR0], MVFR0, FPSP, 1);
+    cpu->isar.regs[MVFR0] = FIELD_DP32(cpu->isar.regs[MVFR0], MVFR0, FPDP, 1);
 }
 
 static void arm946_initfn(Object *obj)
@@ -98,14 +100,16 @@ static void arm1026_initfn(Object *obj)
      * ARMv5 does not have the ID_ISAR registers, but we can still
      * set the field to indicate Jazelle support within QEMU.
      */
-    cpu->isar.id_isar1 = FIELD_DP32(cpu->isar.id_isar1, ID_ISAR1, JAZELLE, 1);
+    cpu->isar.regs[ID_ISAR1] = FIELD_DP32(cpu->isar.regs[ID_ISAR1], ID_ISAR1,
+                                          JAZELLE, 1);
     /*
      * Similarly, we need to set MVFR0 fields to enable vfp and short vector
      * support even though ARMv5 doesn't have this register.
      */
-    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
-    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSP, 1);
-    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPDP, 1);
+    cpu->isar.regs[MVFR0] = FIELD_DP32(cpu->isar.regs[MVFR0], MVFR0,
+                                       FPSHVEC, 1);
+    cpu->isar.regs[MVFR0] = FIELD_DP32(cpu->isar.regs[MVFR0], MVFR0, FPSP, 1);
+    cpu->isar.regs[MVFR0] = FIELD_DP32(cpu->isar.regs[MVFR0], MVFR0, FPDP, 1);
 
     {
         /* The 1026 had an IFAR at c6,c0,0,1 rather than the ARMv6 c6,c0,0,2 */
@@ -138,22 +142,22 @@ static void arm1136_r2_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
     cpu->midr = 0x4107b362;
     cpu->reset_fpsid = 0x410120b4;
-    cpu->isar.mvfr0 = 0x11111111;
-    cpu->isar.mvfr1 = 0x00000000;
+    cpu->isar.regs[MVFR0] = 0x11111111;
+    cpu->isar.regs[MVFR1] = 0x00000000;
     cpu->ctr = 0x1dd20d2;
     cpu->reset_sctlr = 0x00050078;
     cpu->id_pfr0 = 0x111;
     cpu->id_pfr1 = 0x1;
-    cpu->isar.id_dfr0 = 0x2;
+    cpu->isar.regs[ID_DFR0] = 0x2;
     cpu->id_afr0 = 0x3;
-    cpu->isar.id_mmfr0 = 0x01130003;
-    cpu->isar.id_mmfr1 = 0x10030302;
-    cpu->isar.id_mmfr2 = 0x01222110;
-    cpu->isar.id_isar0 = 0x00140011;
-    cpu->isar.id_isar1 = 0x12002111;
-    cpu->isar.id_isar2 = 0x11231111;
-    cpu->isar.id_isar3 = 0x01102131;
-    cpu->isar.id_isar4 = 0x141;
+    cpu->isar.regs[ID_MMFR0] = 0x01130003;
+    cpu->isar.regs[ID_MMFR1] = 0x10030302;
+    cpu->isar.regs[ID_MMFR2] = 0x01222110;
+    cpu->isar.regs[ID_ISAR0] = 0x00140011;
+    cpu->isar.regs[ID_ISAR1] = 0x12002111;
+    cpu->isar.regs[ID_ISAR2] = 0x11231111;
+    cpu->isar.regs[ID_ISAR3] = 0x01102131;
+    cpu->isar.regs[ID_ISAR4] = 0x141;
     cpu->reset_auxcr = 7;
 }
 
@@ -169,22 +173,22 @@ static void arm1136_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
     cpu->midr = 0x4117b363;
     cpu->reset_fpsid = 0x410120b4;
-    cpu->isar.mvfr0 = 0x11111111;
-    cpu->isar.mvfr1 = 0x00000000;
+    cpu->isar.regs[MVFR0] = 0x11111111;
+    cpu->isar.regs[MVFR1] = 0x00000000;
     cpu->ctr = 0x1dd20d2;
     cpu->reset_sctlr = 0x00050078;
     cpu->id_pfr0 = 0x111;
     cpu->id_pfr1 = 0x1;
-    cpu->isar.id_dfr0 = 0x2;
+    cpu->isar.regs[ID_DFR0] = 0x2;
     cpu->id_afr0 = 0x3;
-    cpu->isar.id_mmfr0 = 0x01130003;
-    cpu->isar.id_mmfr1 = 0x10030302;
-    cpu->isar.id_mmfr2 = 0x01222110;
-    cpu->isar.id_isar0 = 0x00140011;
-    cpu->isar.id_isar1 = 0x12002111;
-    cpu->isar.id_isar2 = 0x11231111;
-    cpu->isar.id_isar3 = 0x01102131;
-    cpu->isar.id_isar4 = 0x141;
+    cpu->isar.regs[ID_MMFR0] = 0x01130003;
+    cpu->isar.regs[ID_MMFR1] = 0x10030302;
+    cpu->isar.regs[ID_MMFR2] = 0x01222110;
+    cpu->isar.regs[ID_ISAR0] = 0x00140011;
+    cpu->isar.regs[ID_ISAR1] = 0x12002111;
+    cpu->isar.regs[ID_ISAR2] = 0x11231111;
+    cpu->isar.regs[ID_ISAR3] = 0x01102131;
+    cpu->isar.regs[ID_ISAR4] = 0x141;
     cpu->reset_auxcr = 7;
 }
 
@@ -201,22 +205,22 @@ static void arm1176_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     cpu->midr = 0x410fb767;
     cpu->reset_fpsid = 0x410120b5;
-    cpu->isar.mvfr0 = 0x11111111;
-    cpu->isar.mvfr1 = 0x00000000;
+    cpu->isar.regs[MVFR0] = 0x11111111;
+    cpu->isar.regs[MVFR1] = 0x00000000;
     cpu->ctr = 0x1dd20d2;
     cpu->reset_sctlr = 0x00050078;
     cpu->id_pfr0 = 0x111;
     cpu->id_pfr1 = 0x11;
-    cpu->isar.id_dfr0 = 0x33;
+    cpu->isar.regs[ID_DFR0] = 0x33;
     cpu->id_afr0 = 0;
-    cpu->isar.id_mmfr0 = 0x01130003;
-    cpu->isar.id_mmfr1 = 0x10030302;
-    cpu->isar.id_mmfr2 = 0x01222100;
-    cpu->isar.id_isar0 = 0x0140011;
-    cpu->isar.id_isar1 = 0x12002111;
-    cpu->isar.id_isar2 = 0x11231121;
-    cpu->isar.id_isar3 = 0x01102131;
-    cpu->isar.id_isar4 = 0x01141;
+    cpu->isar.regs[ID_MMFR0] = 0x01130003;
+    cpu->isar.regs[ID_MMFR1] = 0x10030302;
+    cpu->isar.regs[ID_MMFR2] = 0x01222100;
+    cpu->isar.regs[ID_ISAR0] = 0x0140011;
+    cpu->isar.regs[ID_ISAR1] = 0x12002111;
+    cpu->isar.regs[ID_ISAR2] = 0x11231121;
+    cpu->isar.regs[ID_ISAR3] = 0x01102131;
+    cpu->isar.regs[ID_ISAR4] = 0x01141;
     cpu->reset_auxcr = 7;
 }
 
@@ -231,21 +235,21 @@ static void arm11mpcore_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     cpu->midr = 0x410fb022;
     cpu->reset_fpsid = 0x410120b4;
-    cpu->isar.mvfr0 = 0x11111111;
-    cpu->isar.mvfr1 = 0x00000000;
+    cpu->isar.regs[MVFR0] = 0x11111111;
+    cpu->isar.regs[MVFR1] = 0x00000000;
     cpu->ctr = 0x1d192992; /* 32K icache 32K dcache */
     cpu->id_pfr0 = 0x111;
     cpu->id_pfr1 = 0x1;
-    cpu->isar.id_dfr0 = 0;
+    cpu->isar.regs[ID_DFR0] = 0;
     cpu->id_afr0 = 0x2;
-    cpu->isar.id_mmfr0 = 0x01100103;
-    cpu->isar.id_mmfr1 = 0x10020302;
-    cpu->isar.id_mmfr2 = 0x01222000;
-    cpu->isar.id_isar0 = 0x00100011;
-    cpu->isar.id_isar1 = 0x12002111;
-    cpu->isar.id_isar2 = 0x11221011;
-    cpu->isar.id_isar3 = 0x01102131;
-    cpu->isar.id_isar4 = 0x141;
+    cpu->isar.regs[ID_MMFR0] = 0x01100103;
+    cpu->isar.regs[ID_MMFR1] = 0x10020302;
+    cpu->isar.regs[ID_MMFR2] = 0x01222000;
+    cpu->isar.regs[ID_ISAR0] = 0x00100011;
+    cpu->isar.regs[ID_ISAR1] = 0x12002111;
+    cpu->isar.regs[ID_ISAR2] = 0x11221011;
+    cpu->isar.regs[ID_ISAR3] = 0x01102131;
+    cpu->isar.regs[ID_ISAR4] = 0x141;
     cpu->reset_auxcr = 1;
 }
 
@@ -268,19 +272,19 @@ static void cortex_m3_initfn(Object *obj)
     cpu->pmsav7_dregion = 8;
     cpu->id_pfr0 = 0x00000030;
     cpu->id_pfr1 = 0x00000200;
-    cpu->isar.id_dfr0 = 0x00100000;
+    cpu->isar.regs[ID_DFR0] = 0x00100000;
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00000030;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x00000000;
-    cpu->isar.id_mmfr3 = 0x00000000;
-    cpu->isar.id_isar0 = 0x01141110;
-    cpu->isar.id_isar1 = 0x02111000;
-    cpu->isar.id_isar2 = 0x21112231;
-    cpu->isar.id_isar3 = 0x01111110;
-    cpu->isar.id_isar4 = 0x01310102;
-    cpu->isar.id_isar5 = 0x00000000;
-    cpu->isar.id_isar6 = 0x00000000;
+    cpu->isar.regs[ID_MMFR0] = 0x00000030;
+    cpu->isar.regs[ID_MMFR1] = 0x00000000;
+    cpu->isar.regs[ID_MMFR2] = 0x00000000;
+    cpu->isar.regs[ID_MMFR3] = 0x00000000;
+    cpu->isar.regs[ID_ISAR0] = 0x01141110;
+    cpu->isar.regs[ID_ISAR1] = 0x02111000;
+    cpu->isar.regs[ID_ISAR2] = 0x21112231;
+    cpu->isar.regs[ID_ISAR3] = 0x01111110;
+    cpu->isar.regs[ID_ISAR4] = 0x01310102;
+    cpu->isar.regs[ID_ISAR5] = 0x00000000;
+    cpu->isar.regs[ID_ISAR6] = 0x00000000;
 }
 
 static void cortex_m4_initfn(Object *obj)
@@ -293,24 +297,24 @@ static void cortex_m4_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
     cpu->midr = 0x410fc240; /* r0p0 */
     cpu->pmsav7_dregion = 8;
-    cpu->isar.mvfr0 = 0x10110021;
-    cpu->isar.mvfr1 = 0x11000011;
-    cpu->isar.mvfr2 = 0x00000000;
+    cpu->isar.regs[MVFR0] = 0x10110021;
+    cpu->isar.regs[MVFR1] = 0x11000011;
+    cpu->isar.regs[MVFR2] = 0x00000000;
     cpu->id_pfr0 = 0x00000030;
     cpu->id_pfr1 = 0x00000200;
-    cpu->isar.id_dfr0 = 0x00100000;
+    cpu->isar.regs[ID_DFR0] = 0x00100000;
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00000030;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x00000000;
-    cpu->isar.id_mmfr3 = 0x00000000;
-    cpu->isar.id_isar0 = 0x01141110;
-    cpu->isar.id_isar1 = 0x02111000;
-    cpu->isar.id_isar2 = 0x21112231;
-    cpu->isar.id_isar3 = 0x01111110;
-    cpu->isar.id_isar4 = 0x01310102;
-    cpu->isar.id_isar5 = 0x00000000;
-    cpu->isar.id_isar6 = 0x00000000;
+    cpu->isar.regs[ID_MMFR0] = 0x00000030;
+    cpu->isar.regs[ID_MMFR1] = 0x00000000;
+    cpu->isar.regs[ID_MMFR2] = 0x00000000;
+    cpu->isar.regs[ID_MMFR3] = 0x00000000;
+    cpu->isar.regs[ID_ISAR0] = 0x01141110;
+    cpu->isar.regs[ID_ISAR1] = 0x02111000;
+    cpu->isar.regs[ID_ISAR2] = 0x21112231;
+    cpu->isar.regs[ID_ISAR3] = 0x01111110;
+    cpu->isar.regs[ID_ISAR4] = 0x01310102;
+    cpu->isar.regs[ID_ISAR5] = 0x00000000;
+    cpu->isar.regs[ID_ISAR6] = 0x00000000;
 }
 
 static void cortex_m7_initfn(Object *obj)
@@ -323,24 +327,24 @@ static void cortex_m7_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
     cpu->midr = 0x411fc272; /* r1p2 */
     cpu->pmsav7_dregion = 8;
-    cpu->isar.mvfr0 = 0x10110221;
-    cpu->isar.mvfr1 = 0x12000011;
-    cpu->isar.mvfr2 = 0x00000040;
+    cpu->isar.regs[MVFR0] = 0x10110221;
+    cpu->isar.regs[MVFR1] = 0x12000011;
+    cpu->isar.regs[MVFR2] = 0x00000040;
     cpu->id_pfr0 = 0x00000030;
     cpu->id_pfr1 = 0x00000200;
-    cpu->isar.id_dfr0 = 0x00100000;
+    cpu->isar.regs[ID_DFR0] = 0x00100000;
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00100030;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x01000000;
-    cpu->isar.id_mmfr3 = 0x00000000;
-    cpu->isar.id_isar0 = 0x01101110;
-    cpu->isar.id_isar1 = 0x02112000;
-    cpu->isar.id_isar2 = 0x20232231;
-    cpu->isar.id_isar3 = 0x01111131;
-    cpu->isar.id_isar4 = 0x01310132;
-    cpu->isar.id_isar5 = 0x00000000;
-    cpu->isar.id_isar6 = 0x00000000;
+    cpu->isar.regs[ID_MMFR0] = 0x00100030;
+    cpu->isar.regs[ID_MMFR1] = 0x00000000;
+    cpu->isar.regs[ID_MMFR2] = 0x01000000;
+    cpu->isar.regs[ID_MMFR3] = 0x00000000;
+    cpu->isar.regs[ID_ISAR0] = 0x01101110;
+    cpu->isar.regs[ID_ISAR1] = 0x02112000;
+    cpu->isar.regs[ID_ISAR2] = 0x20232231;
+    cpu->isar.regs[ID_ISAR3] = 0x01111131;
+    cpu->isar.regs[ID_ISAR4] = 0x01310132;
+    cpu->isar.regs[ID_ISAR5] = 0x00000000;
+    cpu->isar.regs[ID_ISAR6] = 0x00000000;
 }
 
 static void cortex_m33_initfn(Object *obj)
@@ -355,24 +359,24 @@ static void cortex_m33_initfn(Object *obj)
     cpu->midr = 0x410fd213; /* r0p3 */
     cpu->pmsav7_dregion = 16;
     cpu->sau_sregion = 8;
-    cpu->isar.mvfr0 = 0x10110021;
-    cpu->isar.mvfr1 = 0x11000011;
-    cpu->isar.mvfr2 = 0x00000040;
+    cpu->isar.regs[MVFR0] = 0x10110021;
+    cpu->isar.regs[MVFR1] = 0x11000011;
+    cpu->isar.regs[MVFR2] = 0x00000040;
     cpu->id_pfr0 = 0x00000030;
     cpu->id_pfr1 = 0x00000210;
-    cpu->isar.id_dfr0 = 0x00200000;
+    cpu->isar.regs[ID_DFR0] = 0x00200000;
     cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00101F40;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x01000000;
-    cpu->isar.id_mmfr3 = 0x00000000;
-    cpu->isar.id_isar0 = 0x01101110;
-    cpu->isar.id_isar1 = 0x02212000;
-    cpu->isar.id_isar2 = 0x20232232;
-    cpu->isar.id_isar3 = 0x01111131;
-    cpu->isar.id_isar4 = 0x01310132;
-    cpu->isar.id_isar5 = 0x00000000;
-    cpu->isar.id_isar6 = 0x00000000;
+    cpu->isar.regs[ID_MMFR0] = 0x00101F40;
+    cpu->isar.regs[ID_MMFR1] = 0x00000000;
+    cpu->isar.regs[ID_MMFR2] = 0x01000000;
+    cpu->isar.regs[ID_MMFR3] = 0x00000000;
+    cpu->isar.regs[ID_ISAR0] = 0x01101110;
+    cpu->isar.regs[ID_ISAR1] = 0x02212000;
+    cpu->isar.regs[ID_ISAR2] = 0x20232232;
+    cpu->isar.regs[ID_ISAR3] = 0x01111131;
+    cpu->isar.regs[ID_ISAR4] = 0x01310132;
+    cpu->isar.regs[ID_ISAR5] = 0x00000000;
+    cpu->isar.regs[ID_ISAR6] = 0x00000000;
     cpu->clidr = 0x00000000;
     cpu->ctr = 0x8000c000;
 }
@@ -399,19 +403,19 @@ static void cortex_r5_initfn(Object *obj)
     cpu->midr = 0x411fc153; /* r1p3 */
     cpu->id_pfr0 = 0x0131;
     cpu->id_pfr1 = 0x001;
-    cpu->isar.id_dfr0 = 0x010400;
+    cpu->isar.regs[ID_DFR0] = 0x010400;
     cpu->id_afr0 = 0x0;
-    cpu->isar.id_mmfr0 = 0x0210030;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x01200000;
-    cpu->isar.id_mmfr3 = 0x0211;
-    cpu->isar.id_isar0 = 0x02101111;
-    cpu->isar.id_isar1 = 0x13112111;
-    cpu->isar.id_isar2 = 0x21232141;
-    cpu->isar.id_isar3 = 0x01112131;
-    cpu->isar.id_isar4 = 0x0010142;
-    cpu->isar.id_isar5 = 0x0;
-    cpu->isar.id_isar6 = 0x0;
+    cpu->isar.regs[ID_MMFR0] = 0x0210030;
+    cpu->isar.regs[ID_MMFR1] = 0x00000000;
+    cpu->isar.regs[ID_MMFR2] = 0x01200000;
+    cpu->isar.regs[ID_MMFR3] = 0x0211;
+    cpu->isar.regs[ID_ISAR0] = 0x02101111;
+    cpu->isar.regs[ID_ISAR1] = 0x13112111;
+    cpu->isar.regs[ID_ISAR2] = 0x21232141;
+    cpu->isar.regs[ID_ISAR3] = 0x01112131;
+    cpu->isar.regs[ID_ISAR4] = 0x0010142;
+    cpu->isar.regs[ID_ISAR5] = 0x0;
+    cpu->isar.regs[ID_ISAR6] = 0x0;
     cpu->mp_is_up = true;
     cpu->pmsav7_dregion = 16;
     define_arm_cp_regs(cpu, cortexr5_cp_reginfo);
@@ -422,8 +426,8 @@ static void cortex_r5f_initfn(Object *obj)
     ARMCPU *cpu = ARM_CPU(obj);
 
     cortex_r5_initfn(obj);
-    cpu->isar.mvfr0 = 0x10110221;
-    cpu->isar.mvfr1 = 0x00000011;
+    cpu->isar.regs[MVFR0] = 0x10110221;
+    cpu->isar.regs[MVFR1] = 0x00000011;
 }
 
 static void ti925t_initfn(Object *obj)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3a48bc4e4809..26fef7424904 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6471,7 +6471,7 @@ static void define_debug_regs(ARMCPU *cpu)
     ARMCPRegInfo dbgdidr = {
         .name = "DBGDIDR", .cp = 14, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 0,
         .access = PL0_R, .accessfn = access_tda,
-        .type = ARM_CP_CONST, .resetvalue = cpu->isar.dbgdidr,
+        .type = ARM_CP_CONST, .resetvalue = cpu->isar.regs[DBGDIDR],
     };
 
     /* Note that all these register fields hold "number of Xs minus 1". */
@@ -6637,7 +6637,7 @@ static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
 static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     ARMCPU *cpu = env_archcpu(env);
-    uint64_t pfr0 = cpu->isar.id_aa64pfr0;
+    uint64_t pfr0 = cpu->isar.regs[ID_AA64PFR0];
 
     if (env->gicv3state) {
         pfr0 |= 1 << 24;
@@ -7272,7 +7272,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_dfr0 },
+              .resetvalue = cpu->isar.regs[ID_DFR0] },
             { .name = "ID_AFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -7282,62 +7282,62 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_mmfr0 },
+              .resetvalue = cpu->isar.regs[ID_MMFR0] },
             { .name = "ID_MMFR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_mmfr1 },
+              .resetvalue = cpu->isar.regs[ID_MMFR1] },
             { .name = "ID_MMFR2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_mmfr2 },
+              .resetvalue = cpu->isar.regs[ID_MMFR2] },
             { .name = "ID_MMFR3", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_mmfr3 },
+              .resetvalue = cpu->isar.regs[ID_MMFR3] },
             { .name = "ID_ISAR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_isar0 },
+              .resetvalue = cpu->isar.regs[ID_ISAR0] },
             { .name = "ID_ISAR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_isar1 },
+              .resetvalue = cpu->isar.regs[ID_ISAR1] },
             { .name = "ID_ISAR2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_isar2 },
+              .resetvalue = cpu->isar.regs[ID_ISAR2] },
             { .name = "ID_ISAR3", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_isar3 },
+              .resetvalue = cpu->isar.regs[ID_ISAR3] },
             { .name = "ID_ISAR4", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_isar4 },
+              .resetvalue = cpu->isar.regs[ID_ISAR4] },
             { .name = "ID_ISAR5", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_isar5 },
+              .resetvalue = cpu->isar.regs[ID_ISAR5] },
             { .name = "ID_MMFR4", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_mmfr4 },
+              .resetvalue = cpu->isar.regs[ID_MMFR4] },
             { .name = "ID_ISAR6", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa32_tid3,
-              .resetvalue = cpu->isar.id_isar6 },
+              .resetvalue = cpu->isar.regs[ID_ISAR6] },
             REGINFO_SENTINEL
         };
         define_arm_cp_regs(cpu, v6_idregs);
@@ -7387,7 +7387,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R,
 #ifdef CONFIG_USER_ONLY
               .type = ARM_CP_CONST,
-              .resetvalue = cpu->isar.id_aa64pfr0
+              .resetvalue = cpu->isar.regs[ID_AA64PFR0]
 #else
               .type = ARM_CP_NO_RAW,
               .accessfn = access_aa64_tid3,
@@ -7399,7 +7399,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64pfr1},
+              .resetvalue = cpu->isar.regs[ID_AA64PFR1]},
             { .name = "ID_AA64PFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -7435,12 +7435,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64dfr0 },
+              .resetvalue = cpu->isar.regs[ID_AA64DFR0] },
             { .name = "ID_AA64DFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64dfr1 },
+              .resetvalue = cpu->isar.regs[ID_AA64DFR1] },
             { .name = "ID_AA64DFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -7475,12 +7475,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64isar0 },
+              .resetvalue = cpu->isar.regs[ID_AA64ISAR0] },
             { .name = "ID_AA64ISAR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64isar1 },
+              .resetvalue = cpu->isar.regs[ID_AA64ISAR1] },
             { .name = "ID_AA64ISAR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -7515,17 +7515,17 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64mmfr0 },
+              .resetvalue = cpu->isar.regs[ID_AA64MMFR0] },
             { .name = "ID_AA64MMFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64mmfr1 },
+              .resetvalue = cpu->isar.regs[ID_AA64MMFR1] },
             { .name = "ID_AA64MMFR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64mmfr2 },
+              .resetvalue = cpu->isar.regs[ID_AA64MMFR2] },
             { .name = "ID_AA64MMFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -7555,17 +7555,17 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.mvfr0 },
+              .resetvalue = cpu->isar.regs[MVFR0] },
             { .name = "MVFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.mvfr1 },
+              .resetvalue = cpu->isar.regs[MVFR1] },
             { .name = "MVFR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.mvfr2 },
+              .resetvalue = cpu->isar.regs[MVFR2] },
             { .name = "MVFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 987b35e33fea..542ade8fac9d 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -449,7 +449,7 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
     }
 }
 
-static int read_sys_reg32(int fd, uint32_t *pret, uint64_t id)
+static int read_sys_reg32(int fd, uint64_t *pret, uint64_t id)
 {
     uint64_t ret;
     struct kvm_one_reg idreg = { .id = id, .addr = (uintptr_t)&ret };
@@ -509,7 +509,7 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     ahcf->target = init.target;
     ahcf->dtb_compatible = "arm,arm-v8";
 
-    err = read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64pfr0,
+    err = read_sys_reg64(fdarray[2], &ahcf->isar.regs[ID_AA64PFR0],
                          ARM64_SYS_REG(3, 0, 0, 4, 0));
     if (unlikely(err < 0)) {
         /*
@@ -528,24 +528,24 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
          * ??? Either of these sounds like too much effort just
          *     to work around running a modern host kernel.
          */
-        ahcf->isar.id_aa64pfr0 = 0x00000011; /* EL1&0, AArch64 only */
+        ahcf->isar.regs[ID_AA64PFR0] = 0x00000011; /* EL1&0, AArch64 only */
         err = 0;
     } else {
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64pfr1,
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.regs[ID_AA64PFR1],
                               ARM64_SYS_REG(3, 0, 0, 4, 1));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr0,
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.regs[ID_AA64DFR0],
                               ARM64_SYS_REG(3, 0, 0, 5, 0));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr1,
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.regs[ID_AA64DFR1],
                               ARM64_SYS_REG(3, 0, 0, 5, 1));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar0,
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.regs[ID_AA64ISAR0],
                               ARM64_SYS_REG(3, 0, 0, 6, 0));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar1,
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.regs[ID_AA64ISAR1],
                               ARM64_SYS_REG(3, 0, 0, 6, 1));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr0,
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.regs[ID_AA64MMFR0],
                               ARM64_SYS_REG(3, 0, 0, 7, 0));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr1,
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.regs[ID_AA64MMFR1],
                               ARM64_SYS_REG(3, 0, 0, 7, 1));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr2,
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.regs[ID_AA64MMFR2],
                               ARM64_SYS_REG(3, 0, 0, 7, 2));
 
         /*
@@ -555,38 +555,38 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
          * than skipping the reads and leaving 0, as we must avoid
          * considering the values in every case.
          */
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_dfr0,
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.regs[ID_DFR0],
                               ARM64_SYS_REG(3, 0, 0, 1, 2));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr0,
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.regs[ID_MMFR0],
                               ARM64_SYS_REG(3, 0, 0, 1, 4));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr1,
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.regs[ID_MMFR1],
                               ARM64_SYS_REG(3, 0, 0, 1, 5));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr2,
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.regs[ID_MMFR2],
                               ARM64_SYS_REG(3, 0, 0, 1, 6));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr3,
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.regs[ID_MMFR3],
                               ARM64_SYS_REG(3, 0, 0, 1, 7));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar0,
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.regs[ID_ISAR0],
                               ARM64_SYS_REG(3, 0, 0, 2, 0));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar1,
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.regs[ID_ISAR1],
                               ARM64_SYS_REG(3, 0, 0, 2, 1));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar2,
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.regs[ID_ISAR2],
                               ARM64_SYS_REG(3, 0, 0, 2, 2));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar3,
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.regs[ID_ISAR3],
                               ARM64_SYS_REG(3, 0, 0, 2, 3));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar4,
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.regs[ID_ISAR4],
                               ARM64_SYS_REG(3, 0, 0, 2, 4));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar5,
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.regs[ID_ISAR5],
                               ARM64_SYS_REG(3, 0, 0, 2, 5));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr4,
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.regs[ID_MMFR4],
                               ARM64_SYS_REG(3, 0, 0, 2, 6));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar6,
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.regs[ID_ISAR6],
                               ARM64_SYS_REG(3, 0, 0, 2, 7));
 
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr0,
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.regs[MVFR0],
                               ARM64_SYS_REG(3, 0, 0, 3, 0));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr1,
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.regs[MVFR1],
                               ARM64_SYS_REG(3, 0, 0, 3, 1));
-        err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr2,
+        err |= read_sys_reg32(fdarray[2], &ahcf->isar.regs[MVFR2],
                               ARM64_SYS_REG(3, 0, 0, 3, 2));
 
         /*
@@ -599,14 +599,16 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
          * arch/arm64/kvm/sys_regs.c:trap_dbgidr() does.
          * We only do this if the CPU supports AArch32 at EL1.
          */
-        if (FIELD_EX32(ahcf->isar.id_aa64pfr0, ID_AA64PFR0, EL1) >= 2) {
-            int wrps = FIELD_EX64(ahcf->isar.id_aa64dfr0, ID_AA64DFR0, WRPS);
-            int brps = FIELD_EX64(ahcf->isar.id_aa64dfr0, ID_AA64DFR0, BRPS);
+        if (FIELD_EX32(ahcf->isar.regs[ID_AA64PFR0], ID_AA64PFR0, EL1) >= 2) {
+            int wrps = FIELD_EX64(ahcf->isar.regs[ID_AA64DFR0],
+                                  ID_AA64DFR0, WRPS);
+            int brps = FIELD_EX64(ahcf->isar.regs[ID_AA64DFR0],
+                                  ID_AA64DFR0, BRPS);
             int ctx_cmps =
-                FIELD_EX64(ahcf->isar.id_aa64dfr0, ID_AA64DFR0, CTX_CMPS);
+                FIELD_EX64(ahcf->isar.regs[ID_AA64DFR0], ID_AA64DFR0, CTX_CMPS);
             int version = 6; /* ARMv8 debug architecture */
             bool has_el3 =
-                !!FIELD_EX32(ahcf->isar.id_aa64pfr0, ID_AA64PFR0, EL3);
+                !!FIELD_EX32(ahcf->isar.regs[ID_AA64PFR0], ID_AA64PFR0, EL3);
             uint32_t dbgdidr = 0;
 
             dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, WRPS, wrps);
@@ -616,7 +618,7 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
             dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, NSUHD_IMP, has_el3);
             dbgdidr = FIELD_DP32(dbgdidr, DBGDIDR, SE_IMP, has_el3);
             dbgdidr |= (1 << 15); /* RES1 bit */
-            ahcf->isar.dbgdidr = dbgdidr;
+            ahcf->isar.regs[DBGDIDR] = dbgdidr;
         }
     }
 
@@ -630,9 +632,9 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     /* Add feature bits that can't appear until after VCPU init. */
     if (sve_supported) {
-        t = ahcf->isar.id_aa64pfr0;
+        t = ahcf->isar.regs[ID_AA64PFR0];
         t = FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
-        ahcf->isar.id_aa64pfr0 = t;
+        ahcf->isar.regs[ID_AA64PFR0] = t;
     }
 
     /*
-- 
2.26.2



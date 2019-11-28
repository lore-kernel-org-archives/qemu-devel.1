Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B31C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 18:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DF5F2176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 18:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF5F2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaO8E-0005aQ-1m
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 13:03:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1iaMUJ-0000lY-1L
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:17:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1iaMUG-000574-3U
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:17:49 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:44631)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>) id 1iaMUE-0004ya-Hm
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:17:47 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by cheepnis.misterjones.org with esmtpsa
 (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128) (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iaMU3-0002vd-9I; Thu, 28 Nov 2019 17:17:35 +0100
From: Marc Zyngier <maz@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] target/arm: Honor HCR_EL2.TID1 trapping requirements
Date: Thu, 28 Nov 2019 16:17:17 +0000
Message-Id: <20191128161718.24361-3-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191128161718.24361-1-maz@kernel.org>
References: <20191128161718.24361-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: qemu-devel@nongnu.org, kvmarm@lists.cs.columbia.edu,
 peter.maydell@linaro.org, richard.henderson@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org);
 SAEximRunCond expanded to false
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 213.251.177.50
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
Cc: Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org,
 kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

HCR_EL2.TID1 mandates that access from EL1 to REVIDR_EL1, AIDR_EL1
(and their 32bit equivalents) as well as TCMTR, TLBTR are trapped
to EL2. QEMU ignores it, naking it harder for a hypervisor to
virtualize the HW (though to be fair, no known hypervisor actually
cares).

Do the right thing by trapping to EL2 if HCR_EL2.TID1 is set.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 target/arm/helper.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0b6887b100..9bff769692 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1973,6 +1973,26 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return ret;
 }
 
+static CPAccessResult access_aa64_tid1(CPUARMState *env, const ARMCPRegInfo *ri,
+                                       bool isread)
+{
+    if (arm_hcr_el2_eff(env) & HCR_TID1) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+
+    return CP_ACCESS_OK;
+}
+
+static CPAccessResult access_aa32_tid1(CPUARMState *env, const ARMCPRegInfo *ri,
+                                       bool isread)
+{
+    if (arm_feature(env, ARM_FEATURE_V8)) {
+        return access_aa64_tid1(env, ri, isread);
+    }
+
+    return CP_ACCESS_OK;
+}
+
 static const ARMCPRegInfo v7_cp_reginfo[] = {
     /* the old v6 WFI, UNPREDICTABLE in v7 but we choose to NOP */
     { .name = "NOP", .cp = 15, .crn = 7, .crm = 0, .opc1 = 0, .opc2 = 4,
@@ -2136,7 +2156,9 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
      */
     { .name = "AIDR", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 1, .crn = 0, .crm = 0, .opc2 = 7,
-      .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = 0 },
+      .access = PL1_R, .type = ARM_CP_CONST,
+      .accessfn = access_aa64_tid1,
+      .resetvalue = 0 },
     /* Auxiliary fault status registers: these also are IMPDEF, and we
      * choose to RAZ/WI for all cores.
      */
@@ -6732,7 +6754,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .resetvalue = cpu->midr },
             { .name = "REVIDR_EL1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 0, .opc2 = 6,
-              .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = cpu->revidr },
+              .access = PL1_R,
+              .accessfn = access_aa64_tid1,
+              .type = ARM_CP_CONST, .resetvalue = cpu->revidr },
             REGINFO_SENTINEL
         };
         ARMCPRegInfo id_cp_reginfo[] = {
@@ -6747,14 +6771,18 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             /* TCMTR and TLBTR exist in v8 but have no 64-bit versions */
             { .name = "TCMTR",
               .cp = 15, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 2,
-              .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = 0 },
+              .access = PL1_R,
+              .accessfn = access_aa32_tid1,
+              .type = ARM_CP_CONST, .resetvalue = 0 },
             REGINFO_SENTINEL
         };
         /* TLBTR is specific to VMSA */
         ARMCPRegInfo id_tlbtr_reginfo = {
               .name = "TLBTR",
               .cp = 15, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 3,
-              .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = 0,
+              .access = PL1_R,
+              .accessfn = access_aa32_tid1,
+              .type = ARM_CP_CONST, .resetvalue = 0,
         };
         /* MPUIR is specific to PMSA V6+ */
         ARMCPRegInfo id_mpuir_reginfo = {
-- 
2.20.1



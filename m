Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7787C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56309217D6
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56309217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaMYM-0002ej-Ol
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 11:22:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1iaMUJ-0000lf-5V
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:17:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1iaMUG-00056u-3G
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:17:49 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:48039)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>) id 1iaMUE-0004yk-Ha
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:17:47 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by cheepnis.misterjones.org with esmtpsa
 (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128) (Exim 4.80)
 (envelope-from <maz@kernel.org>)
 id 1iaMU3-0002vd-Lt; Thu, 28 Nov 2019 17:17:35 +0100
From: Marc Zyngier <maz@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] target/arm: Handle trapping to EL2 of AArch32 VMRS
 instructions
Date: Thu, 28 Nov 2019 16:17:18 +0000
Message-Id: <20191128161718.24361-4-maz@kernel.org>
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

HCR_EL2.TID3 requires that AArch32 reads of MVFR[012] are trapped to
EL2, and that HCR_EL2.TID0 does the same for reads of FPSID.
In order to handle this, introduce a new TCG helper function that
checks for these control bits before executing the VMRC instruction.

Tested with a hacked-up version of KVM/arm64 that sets the control
bits for 32bit guests.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 target/arm/helper-a64.h        |  2 ++
 target/arm/internals.h         |  8 ++++++++
 target/arm/translate-vfp.inc.c | 12 +++++++++---
 target/arm/vfp_helper.c        | 27 +++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index a915c1247f..311ced44e6 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -102,3 +102,5 @@ DEF_HELPER_FLAGS_3(autda, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(autdb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_2(xpaci, TCG_CALL_NO_RWG_SE, i64, env, i64)
 DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
+
+DEF_HELPER_3(check_hcr_el2_trap, void, env, int, int)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index f5313dd3d4..5a55e960de 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -430,6 +430,14 @@ static inline uint32_t syn_simd_access_trap(int cv, int cond, bool is_16bit)
         | (cv << 24) | (cond << 20) | (1 << 5);
 }
 
+static inline uint32_t syn_vmrs_trap(int rt, int reg)
+{
+    return (EC_FPIDTRAP << ARM_EL_EC_SHIFT)
+        | ARM_EL_IL
+        | (1 << 24) | (0xe << 20) | (7 << 14)
+        | (reg << 10) | (rt << 5) | 1;
+}
+
 static inline uint32_t syn_sve_access_trap(void)
 {
     return EC_SVEACCESSTRAP << ARM_EL_EC_SHIFT;
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 85c5ef897b..4c435b6c35 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -759,15 +759,21 @@ static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
     }
 
     if (a->l) {
+        TCGv_i32 tcg_rt, tcg_reg;
+
         /* VMRS, move VFP special register to gp register */
         switch (a->reg) {
+        case ARM_VFP_MVFR0:
+        case ARM_VFP_MVFR1:
+        case ARM_VFP_MVFR2:
         case ARM_VFP_FPSID:
+            tcg_rt = tcg_const_i32(a->rt);
+            tcg_reg = tcg_const_i32(a->reg);
+            gen_helper_check_hcr_el2_trap(cpu_env, tcg_rt, tcg_reg);
+            /* fall through */
         case ARM_VFP_FPEXC:
         case ARM_VFP_FPINST:
         case ARM_VFP_FPINST2:
-        case ARM_VFP_MVFR0:
-        case ARM_VFP_MVFR1:
-        case ARM_VFP_MVFR2:
             tmp = load_cpu_field(vfp.xregs[a->reg]);
             break;
         case ARM_VFP_FPSCR:
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 9710ef1c3e..44e538e51c 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -1322,4 +1322,31 @@ float64 HELPER(frint64_d)(float64 f, void *fpst)
     return frint_d(f, fpst, 64);
 }
 
+void HELPER(check_hcr_el2_trap)(CPUARMState *env, int rt, int reg)
+{
+    if (arm_current_el(env) != 1) {
+        return;
+    }
+
+    switch (reg) {
+    case ARM_VFP_MVFR0:
+    case ARM_VFP_MVFR1:
+    case ARM_VFP_MVFR2:
+        if (!(arm_hcr_el2_eff(env) & HCR_TID3)) {
+            return;
+        }
+        break;
+    case ARM_VFP_FPSID:
+        if (!(arm_hcr_el2_eff(env) & HCR_TID0)) {
+            return;
+        }
+        break;
+    default:
+        /* Shouldn't be here... */
+        return;
+    }
+
+    raise_exception(env, EXCP_HYP_TRAP, syn_vmrs_trap(rt, reg), 2);
+}
+
 #endif
-- 
2.20.1



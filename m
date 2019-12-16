Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF05C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED28B206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vpY+9M/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED28B206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igohl-000454-QN
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFn-0007sV-J1
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFm-0008JW-7p
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:31 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33423)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFm-0008Is-1S
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:30 -0500
Received: by mail-wr1-x441.google.com with SMTP id b6so6756290wrq.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=hppP2bCQOezxDFaY7+RUxIWUw1GUMX8Ov6ZmLeYdIro=;
 b=vpY+9M/S9UQqJYDklq7y9Lz/MW8jRDn/kFs8Fp2qC6UQgyaPpDAlm/VEoBJGOfl87I
 HVtjlNh2n/L8l4FKiCnQLcHnjSFAqqkdScI3iR7YhcstnEtYquoRL7y7IctrwLpJ11QW
 sKmvbm8Ij5iYdlo1t5ILumop6gwujk35GyxWCMnQAHk9i694Kx7Bg6EjFnISnCl/cNXv
 FmMwTNOHe0WmKMo2eEdqzZYsXSM0d5rLT98l9o/fxGYwiBfsipcC+cTzoxIdn3vO98L2
 bEtkJqgI25Kg2zzqcqWzcFnrDuZWJjYANiuXX0KoNxhi2PpKAWOBROJNpKOvPzhWHhB5
 cUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hppP2bCQOezxDFaY7+RUxIWUw1GUMX8Ov6ZmLeYdIro=;
 b=j2S5ol8MbzNkUtUD7qgYNvXDHpr5T0Wd6ibJV3VHp3qLkPAqaEu7nerXS/N1fvFlUU
 K3pOAJD7ko6heEeOclO21nVXsw78Bh8WDB+SMrsiJY11loOc1Bor0UCDAsfaYMrlKhwL
 PDmwnCULqwcBw+bz1/sfEBGEexMS3fcSGMtSZtNeFogXNGtNVX/KGfmJyzhQaHMIeU7I
 bnwJNyJBVjHZBvo+nkHvqyoicmegAkEoviVX7sF9OmQBCEUhmpcaN2Q6aAuiYBdoQWeN
 p2qzJwxbQJQsmjeZ+KFf58GUEdqRanaLBHM4EzDAfifiiM4/rgBDINARnJE704bAn/uZ
 VBoA==
X-Gm-Message-State: APjAAAWThMs+cyfBdq/rCd7VW62sRhPD2iLpi2z786oUte6UoSPILDEf
 yjVSHy4QLxwmyNwTP+OO0BH0YPlpaJGZ/w==
X-Google-Smtp-Source: APXvYqz3SAnmK44b9xVZIzopGJv/LgyUHXlo39/GrYVy8uuZTPM742DFJaJoReLx4p86w42fFNHS6A==
X-Received: by 2002:a5d:6350:: with SMTP id b16mr30060425wrw.132.1576494568862; 
 Mon, 16 Dec 2019 03:09:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/34] target/arm: Honor HCR_EL2.TID2 trapping requirements
Date: Mon, 16 Dec 2019 11:08:50 +0000
Message-Id: <20191216110904.30815-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc Zyngier <maz@kernel.org>

HCR_EL2.TID2 mandates that access from EL1 to CTR_EL0, CCSIDR_EL1,
CCSIDR2_EL1, CLIDR_EL1, CSSELR_EL1 are trapped to EL2, and QEMU
completely ignores it, making it impossible for hypervisors to
virtualize the cache hierarchy.

Do the right thing by trapping to EL2 if HCR_EL2.TID2 is set.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191201122018.25808-2-maz@kernel.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0bf8f53d4b8..1e546096b82 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1910,6 +1910,17 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     raw_write(env, ri, value);
 }
 
+static CPAccessResult access_aa64_tid2(CPUARMState *env,
+                                       const ARMCPRegInfo *ri,
+                                       bool isread)
+{
+    if (arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_TID2)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+
+    return CP_ACCESS_OK;
+}
+
 static uint64_t ccsidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -2110,10 +2121,14 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .writefn = pmintenclr_write },
     { .name = "CCSIDR", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 1, .opc2 = 0,
-      .access = PL1_R, .readfn = ccsidr_read, .type = ARM_CP_NO_RAW },
+      .access = PL1_R,
+      .accessfn = access_aa64_tid2,
+      .readfn = ccsidr_read, .type = ARM_CP_NO_RAW },
     { .name = "CSSELR", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 2, .opc2 = 0,
-      .access = PL1_RW, .writefn = csselr_write, .resetvalue = 0,
+      .access = PL1_RW,
+      .accessfn = access_aa64_tid2,
+      .writefn = csselr_write, .resetvalue = 0,
       .bank_fieldoffsets = { offsetof(CPUARMState, cp15.csselr_s),
                              offsetof(CPUARMState, cp15.csselr_ns) } },
     /* Auxiliary ID register: this actually has an IMPDEF value but for now
@@ -5204,6 +5219,11 @@ static CPAccessResult ctr_el0_access(CPUARMState *env, const ARMCPRegInfo *ri,
     if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UCT)) {
         return CP_ACCESS_TRAP;
     }
+
+    if (arm_current_el(env) < 2 && arm_hcr_el2_eff(env) & HCR_TID2) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+
     return CP_ACCESS_OK;
 }
 
@@ -6184,7 +6204,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         ARMCPRegInfo clidr = {
             .name = "CLIDR", .state = ARM_CP_STATE_BOTH,
             .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 1, .opc2 = 1,
-            .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = cpu->clidr
+            .access = PL1_R, .type = ARM_CP_CONST,
+            .accessfn = access_aa64_tid2,
+            .resetvalue = cpu->clidr
         };
         define_one_arm_cp_reg(cpu, &clidr);
         define_arm_cp_regs(cpu, v7_cp_reginfo);
@@ -6717,7 +6739,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             /* These are common to v8 and pre-v8 */
             { .name = "CTR",
               .cp = 15, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 1,
-              .access = PL1_R, .type = ARM_CP_CONST, .resetvalue = cpu->ctr },
+              .access = PL1_R, .accessfn = ctr_el0_access,
+              .type = ARM_CP_CONST, .resetvalue = cpu->ctr },
             { .name = "CTR_EL0", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 3, .opc2 = 1, .crn = 0, .crm = 0,
               .access = PL0_R, .accessfn = ctr_el0_access,
-- 
2.20.1



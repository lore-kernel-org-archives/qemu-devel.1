Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7E5C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:48:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7B9720637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nClBpPxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B9720637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tfd-00065v-OT
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPE-0003dv-GY
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPD-0002Wc-E4
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:28 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tPD-0002VF-7l
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:27 -0500
Received: by mail-wr1-x443.google.com with SMTP id n15so2459578wrw.13
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=63BtL3A7s5V/jzIhDC3vd/bTesp/g8P1iFKQFff6LWo=;
 b=nClBpPxjndfhpoJl1hjUUYvHDudxt3C40qKEBcV0F8m1tHwrctqPTgjSOgxDZX+Tjl
 X+SxlJGMzcPujcLvLt+tgvhEe3sWUlOec9DZupQote12LvKPANjrzjSc1Gc8udC/LYZ3
 I+yHGpCh9POwj3NGS1kIFucmbSJItJYcFfO3ioNzO4di+fMQbE1IoE8yDPSmzoAm7eGI
 Ki8aAOwdGYQ8LB/Rz16JE8W9Q5dykHpEBZrYHh6KuHiaLv43CsBeRUnAMcH+q7rnWnm9
 a1P36iJVlS0dWFlZ7+lpjWX3aiOG4pAzCHdN/ZdB3wFTku4Oui/loBzYYfT5e4jDBUL5
 /OUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=63BtL3A7s5V/jzIhDC3vd/bTesp/g8P1iFKQFff6LWo=;
 b=c4h7oiD/MSaDN1VpeaB5McvTkOjgAlI06/105KeHne9DEOz0aKfD1ndyybMLrKdL4d
 L4lIJo8oeZYzO1mbILcrgMETOryplwiGI2qQqLGAKuxeG/q3vSQ+HzRXFGwNEAZul7/C
 lghHuSJB713imt+6F0vo7+8qE0Ey9z5P7vjwuRtu19Jmc420e9ZTCHn2C6p3Xxle0FlN
 UgkbAfE5+yunB6IG1N82fE/fAWOHbcaBLcplpVpkMfu/HkCVLDfXTQd4zIyjeq+wrqQK
 QfelKUAoJKOItrBHAGgPgWAks2DJCr3m5R4sjJj6fqitsMVGoTkfgf5Wlt+thK6XGg/A
 XxHw==
X-Gm-Message-State: ANhLgQ36OP4nWgZVDwzSuN4ZZ2NjspZTKug+A6Mvx9rN9yhXrTAG1y4v
 Z4iPf4gDkPNtsbGbzGvCH3Rygd6Z2uzCLA==
X-Google-Smtp-Source: ADFU+vuGyfydR8YAxAutrN36z0+zy9CFsH2Ns9QxkZPmrcrE2WUeuAZ24i9wcVfmfEGghWwaDDYLzg==
X-Received: by 2002:adf:dd4d:: with SMTP id u13mr10990247wrm.70.1583425886040; 
 Thu, 05 Mar 2020 08:31:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/37] target/arm: Honor the HCR_EL2.TACR bit
Date: Thu,  5 Mar 2020 16:30:45 +0000
Message-Id: <20200305163100.22912-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

From: Richard Henderson <richard.henderson@linaro.org>

This bit traps EL1 access to the auxiliary control registers.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200229012811.24129-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index feb279f44e9..e362d420eb4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -553,6 +553,16 @@ static CPAccessResult access_tsw(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+/* Check for traps from EL1 due to HCR_EL2.TACR.  */
+static CPAccessResult access_tacr(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  bool isread)
+{
+    if (arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_TACR)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    return CP_ACCESS_OK;
+}
+
 static void dacr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -6961,8 +6971,8 @@ static const ARMCPRegInfo ats1cp_reginfo[] = {
 static const ARMCPRegInfo actlr2_hactlr2_reginfo[] = {
     { .name = "ACTLR2", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 3,
-      .access = PL1_RW, .type = ARM_CP_CONST,
-      .resetvalue = 0 },
+      .access = PL1_RW, .accessfn = access_tacr,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
     { .name = "HACTLR2", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 4, .crn = 1, .crm = 0, .opc2 = 3,
       .access = PL2_RW, .type = ARM_CP_CONST,
@@ -7718,8 +7728,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         ARMCPRegInfo auxcr_reginfo[] = {
             { .name = "ACTLR_EL1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 1,
-              .access = PL1_RW, .type = ARM_CP_CONST,
-              .resetvalue = cpu->reset_auxcr },
+              .access = PL1_RW, .accessfn = access_tacr,
+              .type = ARM_CP_CONST, .resetvalue = cpu->reset_auxcr },
             { .name = "ACTLR_EL2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 0, .opc2 = 1,
               .access = PL2_RW, .type = ARM_CP_CONST,
-- 
2.20.1



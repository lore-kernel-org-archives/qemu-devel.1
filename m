Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE74DC76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3E42184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HSYCYLmd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3E42184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoa5s-000879-Ny
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 17:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55179)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3Y-00084E-Ri
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3V-0005XY-Ig
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:43 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hoa3T-00058S-AG
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:41 -0400
Received: by mail-pl1-x642.google.com with SMTP id m9so16102967pls.8
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 14:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=OcsEJOTB78UGcdvycEnpdFbtKzZSWFgFYymdrWCmqJI=;
 b=HSYCYLmdDzbD3ZUpLDiHLF66nlPHVr/TiC8xuH1MpvktCb6nbDOlXaOj1lyWC3jR+7
 GcguiHBi22gG+FfxpGhqrxDm4v1g8DjSH6UQPODbM0SRIXKnPSgOrGRguwL8seX+UiO9
 AEFI8hA018qRB4hYFu76NrWopd8PI+Rbl77WL88jL3nNw03nzHqAjszUMO57RVW3Al+H
 mQzWSTnYFBPG8NfTz0Kut+fBXuWvjiZr8QToveTsVvV5kL5AuL6ppoDPCR3yF01YGXZf
 QbVOPAhfLrUroSu+czU0jsy1jgJ9FMDp9n9yPNE/dRC89iWnjw78nwNdD8QB5z0+cnvO
 vkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=OcsEJOTB78UGcdvycEnpdFbtKzZSWFgFYymdrWCmqJI=;
 b=YDqwtinEOBC+k24mfuVyY0v3kl+yqWd2Wss5HJ2jK529ys6iDueEIAnoPKyPdlFD3+
 XPHcjAAhzTyLaNQAZancLhPKWEoiKwXg87hApmnhdyb60YP+rWmLceNfgkpBn7lkTwEo
 PHZQd+7se3YQTQh480StgMTp38w3EcWSJRN/3NaiAAV6CHQcNnnivP9tgU7tAH8I4cnp
 ZSMvnPp2sdiiits0daSQUBBL/7gXpvXCw7anTj2NzbzYjcK0shqRdQLAzomdoxxOC3ki
 YG7S/KvzTltRJBmAk87ifT4kDY4LvLS+yz4XCGoLyIQu+SGM2bHMBjEmLF2cXaWzQbr5
 4afQ==
X-Gm-Message-State: APjAAAVXsXCevRXOgzmiqgJ5v7yveSPsWO1ftw/6woKFxULrNzXfw108
 6k0cR+5k4g2nDE5M6SJdqk5fKLcs4Is=
X-Google-Smtp-Source: APXvYqyK8Z1c20y4Z1QGPMAV+bqWW27bCiIncSBLokblh/xv7O06luzZr+NszvbJnDj6V8JFxgZDQQ==
X-Received: by 2002:a17:902:a417:: with SMTP id
 p23mr58208281plq.136.1563570219317; 
 Fri, 19 Jul 2019 14:03:39 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id i6sm32724751pgi.40.2019.07.19.14.03.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 14:03:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 14:03:11 -0700
Message-Id: <20190719210326.15466-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719210326.15466-1-richard.henderson@linaro.org>
References: <20190719210326.15466-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH for-4.2 09/24] target/arm: Add TTBR1_EL2
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the same time, add writefn to TTBR0_EL2 and TCR_EL2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d1bf31ab74..da2e0627b2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3449,6 +3449,15 @@ static void vmsa_ttbr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    uint64_t value)
+{
+    raw_write(env, ri, value);
+    if (arm_hcr_el2_eff(env) & HCR_E2H) {
+        /* The ASID field is active.  */
+    }
+}
+
 static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
@@ -4844,10 +4853,8 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .resetvalue = 0 },
     { .name = "TCR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 2,
-      .access = PL2_RW,
-      /* no .writefn needed as this can't cause an ASID change;
-       * no .raw_writefn or .resetfn needed as we never use mask/base_mask
-       */
+      .access = PL2_RW, .writefn = vmsa_tcr_ttbr_el2_write,
+      /* no .raw_writefn or .resetfn needed as we never use mask/base_mask */
       .fieldoffset = offsetof(CPUARMState, cp15.tcr_el[2]) },
     { .name = "VTCR", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 2,
@@ -4881,7 +4888,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.tpidr_el[2]) },
     { .name = "TTBR0_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 0,
-      .access = PL2_RW, .resetvalue = 0,
+      .access = PL2_RW, .resetvalue = 0, .writefn = vmsa_tcr_ttbr_el2_write,
       .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[2]) },
     { .name = "HTTBR", .cp = 15, .opc1 = 4, .crm = 2,
       .access = PL2_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS,
@@ -6807,6 +6814,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 4, .crn = 13, .crm = 0, .opc2 = 1,
               .access = PL2_RW,
               .fieldoffset = offsetof(CPUARMState, cp15.contextidr_el[2]) },
+            { .name = "TTBR1_EL2", .state = ARM_CP_STATE_AA64,
+              .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 1,
+              .access = PL2_RW, .writefn = vmsa_tcr_ttbr_el2_write,
+              .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el[2]) },
             REGINFO_SENTINEL
         };
         define_arm_cp_regs(cpu, vhe_reginfo);
-- 
2.17.1



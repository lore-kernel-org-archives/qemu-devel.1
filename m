Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A598C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3059B20637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iakjqyEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3059B20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tVF-0006aO-9s
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPG-0003fa-5I
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPE-0002ZB-NN
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:30 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tPE-0002Xi-GG
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:28 -0500
Received: by mail-wr1-x442.google.com with SMTP id v2so7780483wrp.12
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=cBpCaClb9/Cygo6mKyCev/5pUMwMYtTJNviojF+pUgs=;
 b=iakjqyEhuffLB3W6UrYStftfKEseihDk7eqC6Us48xyi8i7GHCAbrFIRM7ZjSz2oHW
 LpIdkMCbuhXgr6RDvXy7Q+4dxALrEYV2AHcv+MTfnigQ/QFhGaMMJoxejXAGHxof8/QH
 wIBtlTXqCBhPVD+e2CtFl2f58NIhpbMZRUDpvNJ5OpIE8TOsrz0X8B/zJZlQPWq8v1m7
 60OJSH5gIEMbAumNe8lAtnTaukYRxBlVep/9bNgKLQ/s929IJ23L1TN65zHkPWKAOpaE
 ZaoE5o2+Tpzai6pKZszdJDLfM1ZtUJNyEOn1QU44hZfPFHIBUq2g76gSNfTZRmBkEmp1
 9Sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cBpCaClb9/Cygo6mKyCev/5pUMwMYtTJNviojF+pUgs=;
 b=FRbztYOKhZsWCH4RQ0C/T49rR5gvDazp6JXamttZaJbmqjdPLobo9Ogalghqsw1YU8
 kMvpVytkVVAj10WTcKAr/ddQ4e8ZCLkOfhQsEa3GX7P3DFQThoXvYQnLU03D5Hwps1sb
 FCEVHYwkB/YEL1gz9uWF3xIOgyrMtOlzs6Drz6xJHB5pyOyS6MXOscZfzTJCsHu8D4X0
 0JIy2WFUjMkOfntkBGTaHfXOXp9UyvFyxkvMhc++ptKfloJgvbmLMU8S8D53I8gXtfkk
 BdHIxEWWbz5rWmAj8dj3OTLWdvnQOIqgYG0ru7g3jvMvHvxpYkzZJsJ4ZO16KQHdWKaA
 wFqQ==
X-Gm-Message-State: ANhLgQ0DQ2mnGO4tRaSRwpB75TNg44eDz9bWuj531UkQX63btfG6wtU9
 a90rc/K8GfcPGFXnnkW8O+mCO+yH2naHPg==
X-Google-Smtp-Source: ADFU+vv4jXOd0B5kPknWeGGDGR6RttbXBDFksxaMh5J0vV6FczDlxh4F7LN/4HHbLXSCMZPanV1Eyw==
X-Received: by 2002:adf:ec50:: with SMTP id w16mr11312961wrn.9.1583425886968; 
 Thu, 05 Mar 2020 08:31:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/37] target/arm: Honor the HCR_EL2.TPCP bit
Date: Thu,  5 Mar 2020 16:30:46 +0000
Message-Id: <20200305163100.22912-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

This bit traps EL1 access to cache maintenance insns that operate
to the point of coherency or persistence.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200229012811.24129-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e362d420eb4..e6eaec8ad31 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4314,6 +4314,28 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult aa64_cacheop_poc_access(CPUARMState *env,
+                                              const ARMCPRegInfo *ri,
+                                              bool isread)
+{
+    /* Cache invalidate/clean to Point of Coherency or Persistence...  */
+    switch (arm_current_el(env)) {
+    case 0:
+        /* ... EL0 must UNDEF unless SCTLR_EL1.UCI is set.  */
+        if (!(arm_sctlr(env, 0) & SCTLR_UCI)) {
+            return CP_ACCESS_TRAP;
+        }
+        /* fall through */
+    case 1:
+        /* ... EL1 must trap to EL2 if HCR_EL2.TPCP is set.  */
+        if (arm_hcr_el2_eff(env) & HCR_TPCP) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+        break;
+    }
+    return CP_ACCESS_OK;
+}
+
 /* See: D4.7.2 TLB maintenance requirements and the TLB maintenance instructions
  * Page D4-1736 (DDI0487A.b)
  */
@@ -4721,14 +4743,15 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .accessfn = aa64_cacheop_access },
     { .name = "DC_IVAC", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 1,
-      .access = PL1_W, .type = ARM_CP_NOP },
+      .access = PL1_W, .accessfn = aa64_cacheop_poc_access,
+      .type = ARM_CP_NOP },
     { .name = "DC_ISW", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 2,
       .access = PL1_W, .accessfn = access_tsw, .type = ARM_CP_NOP },
     { .name = "DC_CVAC", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 10, .opc2 = 1,
       .access = PL0_W, .type = ARM_CP_NOP,
-      .accessfn = aa64_cacheop_access },
+      .accessfn = aa64_cacheop_poc_access },
     { .name = "DC_CSW", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 2,
       .access = PL1_W, .accessfn = access_tsw, .type = ARM_CP_NOP },
@@ -4739,7 +4762,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "DC_CIVAC", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 14, .opc2 = 1,
       .access = PL0_W, .type = ARM_CP_NOP,
-      .accessfn = aa64_cacheop_access },
+      .accessfn = aa64_cacheop_poc_access },
     { .name = "DC_CISW", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 2,
       .access = PL1_W, .accessfn = access_tsw, .type = ARM_CP_NOP },
@@ -4921,17 +4944,17 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "BPIMVA", .cp = 15, .opc1 = 0, .crn = 7, .crm = 5, .opc2 = 7,
       .type = ARM_CP_NOP, .access = PL1_W },
     { .name = "DCIMVAC", .cp = 15, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 1,
-      .type = ARM_CP_NOP, .access = PL1_W },
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = aa64_cacheop_poc_access },
     { .name = "DCISW", .cp = 15, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 2,
       .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
     { .name = "DCCMVAC", .cp = 15, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 1,
-      .type = ARM_CP_NOP, .access = PL1_W },
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = aa64_cacheop_poc_access },
     { .name = "DCCSW", .cp = 15, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 2,
       .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
     { .name = "DCCMVAU", .cp = 15, .opc1 = 0, .crn = 7, .crm = 11, .opc2 = 1,
       .type = ARM_CP_NOP, .access = PL1_W },
     { .name = "DCCIMVAC", .cp = 15, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 1,
-      .type = ARM_CP_NOP, .access = PL1_W },
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = aa64_cacheop_poc_access },
     { .name = "DCCISW", .cp = 15, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 2,
       .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
     /* MMU Domain access control / MPU write buffer control */
@@ -6750,7 +6773,7 @@ static const ARMCPRegInfo dcpop_reg[] = {
     { .name = "DC_CVAP", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 12, .opc2 = 1,
       .access = PL0_W, .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
-      .accessfn = aa64_cacheop_access, .writefn = dccvap_writefn },
+      .accessfn = aa64_cacheop_poc_access, .writefn = dccvap_writefn },
     REGINFO_SENTINEL
 };
 
@@ -6758,7 +6781,7 @@ static const ARMCPRegInfo dcpodp_reg[] = {
     { .name = "DC_CVADP", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 13, .opc2 = 1,
       .access = PL0_W, .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
-      .accessfn = aa64_cacheop_access, .writefn = dccvap_writefn },
+      .accessfn = aa64_cacheop_poc_access, .writefn = dccvap_writefn },
     REGINFO_SENTINEL
 };
 #endif /*CONFIG_USER_ONLY*/
-- 
2.20.1



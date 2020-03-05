Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F7FC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F03B220637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XKqL5+Te"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03B220637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tUc-00050p-1h
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:37:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPD-0003dO-Rr
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPC-0002V0-JN
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:27 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:53668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tPC-0002Ss-D9
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:26 -0500
Received: by mail-wm1-x333.google.com with SMTP id g134so7044259wme.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Y/oEr6VfZD0tMuDYbhpwmohDwbWl4E1kQNKWWMvPtRI=;
 b=XKqL5+Telvdi3EXFGIMxrMF3dlzl6G8GTClU+b+PWCW4HYWTwFt13vfaDdiatt5aIx
 NLJIAGTyYHCTTwmztVradp8GyH4eT3W7Q92DRgWeoTVZwBJmZgqkzYymnZKDqlpk0u2J
 AhxP6fRNsKrAGB5I4qr26By7G1RG+7fLpL9lc/uoGw9VzhyGhU2clO0Xgnw4P6ItzBTB
 fcEQb6aJvIprkzfypSgn2EUgj9ZuTwOzrBkTsDlqEckUxAGlm7JwsPrhiB4v5BeAtVWW
 boRge7nxBH0yYYeo2JP8HefY+NPwqHhNzpep+6vQhvLpM4gc7MaQrVzl5Hgx4YjTtAoE
 ITTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y/oEr6VfZD0tMuDYbhpwmohDwbWl4E1kQNKWWMvPtRI=;
 b=unKcuiGoD7DSf+w+RzEnsk8rzTISQb0U2YJmUZDaC0Z8slr8BbkcWdJHPocn+3zqGB
 E1FPtJq0Zp6H2QkN2LB3emdihAhCe3dUKPC8qf3PWaDKX2I5bnwHCQlkwsdQ1WvpSzWW
 Ft/D+QSurzG5sLridsYNEavIBKu7dSRQzyLlbyUadgIK0XQQGrCc2o+ZRwFfWywa7WsQ
 JYteeNELNXwl5GjSP2gvaGAVJpJxcD9/E9MRQFwNXMnhxECMzolp2ZSZUfi813+PrAsh
 m/KBS9UM3Nts5OO1wlKfM64XT/D5gkEOwQtVjNFO4HB7h82eDpaLTrtdmd32QrS2yyhL
 wLUw==
X-Gm-Message-State: ANhLgQ3uXlKCXyH3G++DlxG17huobZdvjWtkcUYPs1Umb5ht8FYWvrag
 qn+Vl3PSRftILT4n6eCX3oHP5UeuQN437A==
X-Google-Smtp-Source: ADFU+vs38FBZZSCj9+6smHd0ATdQoqRmPNGhcWNXQSD7Kfvf3f3wEG9Ek773NqFt1zZ8Io/aiZz6dg==
X-Received: by 2002:a1c:a1c2:: with SMTP id k185mr1542331wme.164.1583425885107; 
 Thu, 05 Mar 2020 08:31:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/37] target/arm: Honor the HCR_EL2.TSW bit
Date: Thu,  5 Mar 2020 16:30:44 +0000
Message-Id: <20200305163100.22912-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

These bits trap EL1 access to set/way cache maintenance insns.

Buglink: https://bugs.launchpad.net/bugs/1863685
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200229012811.24129-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c78429bca2a..feb279f44e9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -543,6 +543,16 @@ static CPAccessResult access_tvm_trvm(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+/* Check for traps from EL1 due to HCR_EL2.TSW.  */
+static CPAccessResult access_tsw(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 bool isread)
+{
+    if (arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_TSW)) {
+        return CP_ACCESS_TRAP_EL2;
+    }
+    return CP_ACCESS_OK;
+}
+
 static void dacr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -4704,14 +4714,14 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .access = PL1_W, .type = ARM_CP_NOP },
     { .name = "DC_ISW", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 2,
-      .access = PL1_W, .type = ARM_CP_NOP },
+      .access = PL1_W, .accessfn = access_tsw, .type = ARM_CP_NOP },
     { .name = "DC_CVAC", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 10, .opc2 = 1,
       .access = PL0_W, .type = ARM_CP_NOP,
       .accessfn = aa64_cacheop_access },
     { .name = "DC_CSW", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 2,
-      .access = PL1_W, .type = ARM_CP_NOP },
+      .access = PL1_W, .accessfn = access_tsw, .type = ARM_CP_NOP },
     { .name = "DC_CVAU", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 11, .opc2 = 1,
       .access = PL0_W, .type = ARM_CP_NOP,
@@ -4722,7 +4732,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .accessfn = aa64_cacheop_access },
     { .name = "DC_CISW", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 2,
-      .access = PL1_W, .type = ARM_CP_NOP },
+      .access = PL1_W, .accessfn = access_tsw, .type = ARM_CP_NOP },
     /* TLBI operations */
     { .name = "TLBI_VMALLE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 0,
@@ -4903,17 +4913,17 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "DCIMVAC", .cp = 15, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 1,
       .type = ARM_CP_NOP, .access = PL1_W },
     { .name = "DCISW", .cp = 15, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 2,
-      .type = ARM_CP_NOP, .access = PL1_W },
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
     { .name = "DCCMVAC", .cp = 15, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 1,
       .type = ARM_CP_NOP, .access = PL1_W },
     { .name = "DCCSW", .cp = 15, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 2,
-      .type = ARM_CP_NOP, .access = PL1_W },
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
     { .name = "DCCMVAU", .cp = 15, .opc1 = 0, .crn = 7, .crm = 11, .opc2 = 1,
       .type = ARM_CP_NOP, .access = PL1_W },
     { .name = "DCCIMVAC", .cp = 15, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 1,
       .type = ARM_CP_NOP, .access = PL1_W },
     { .name = "DCCISW", .cp = 15, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 2,
-      .type = ARM_CP_NOP, .access = PL1_W },
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
     /* MMU Domain access control / MPU write buffer control */
     { .name = "DACR", .cp = 15, .opc1 = 0, .crn = 3, .crm = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm, .resetvalue = 0,
-- 
2.20.1



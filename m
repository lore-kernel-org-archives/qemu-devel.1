Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68A8C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:48:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 925D72080C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cIUPm46r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925D72080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyd1c-0008W5-Ox
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0W-0006bf-DF
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0V-00036o-5F
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:24 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40912)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iyd0U-000362-VY
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:23 -0500
Received: by mail-wm1-x343.google.com with SMTP id t14so17462462wmi.5
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2RHX+9VAaI14LH2Ijti0R37fLYBPx3ELl/51B+kqxLE=;
 b=cIUPm46rPwr1I2vTyH53gapoGurLqsjkZf01uMi+qP3jbXo851VSVwMIuA1zXtKENk
 OiyA3e6ZIYbSA1Bzi+BD4i2viejbv4XVgMDnhThQtbVQiScPQ6uid0LUt5dnMYPZXzGA
 tiBKbnmn+X176XgmSMyNmMaKwS0tEDEHbNDbwswKaxRtfFYAmH3pnX720lrlVdzJsrz9
 L0ltE/KnTV/FoMte2heRWvgsgbqQTzQMTal3Miz0oRMkAtQErH6MN9zbZy5DHT56Byo4
 3jQMFvUE8vt9alwOfCx0Ako1mG1GTBkdEfOn23e12OBgINtxqpuCb1y3Uyn8H7tpM8Ym
 RQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2RHX+9VAaI14LH2Ijti0R37fLYBPx3ELl/51B+kqxLE=;
 b=e9Jah7JOCghFkxFMGzxSl0BuDrpd8vqcHTnO84VkA8lj2Z/ZR45oKydzHUZFwCcnq4
 6gpIOIGnoWSRkiZbc+t329qH8OcVCBk+cRLVXNYR/ltb+RofP7nISKAAd9bgsqHxzbrd
 tX22beE1DKsLJzOpVAwOyXwWwrMPPinsF9IYDLjpfTlLt4RJw/3fVftq1YSj1nzLc5Bx
 OGLhnhjXFYNAr9rRrPLiLb50D3ZDE4qumw+P1fS3rHb0wZPDAOTYx71XDirvXxjCqcf/
 xmzgkMW8Vd0wb0K4kOcJTWDeYYZmtjBO5K/5f6lwt/hZIpnInqr4UTC/X7+EsYpOOQN4
 vx3Q==
X-Gm-Message-State: APjAAAUjwDRPjLEv22YnlQzVtO64VF9tfVuSdM/tqzFB9qnRlEDuM7FN
 HGwdr/ynFCTuqdusxD64AQbRJC8NcS99Pg==
X-Google-Smtp-Source: APXvYqyOvMQ+ffoeAHDFEZZ3/wYB6JcYlNYIzO3tik8dShR+rv2kh0TAuFfgfwk3ei1VGHdLPOUzyA==
X-Received: by 2002:a1c:cc11:: with SMTP id h17mr28766142wmb.19.1580741241613; 
 Mon, 03 Feb 2020 06:47:21 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id h2sm26429739wrt.45.2020.02.03.06.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 06:47:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/20] target/arm: Move LOR regdefs to file scope
Date: Mon,  3 Feb 2020 14:47:00 +0000
Message-Id: <20200203144716.32204-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203144716.32204-1-richard.henderson@linaro.org>
References: <20200203144716.32204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For static const regdefs, file scope is preferred.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 57 +++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 739d2d4cc5..795ef727d0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6343,6 +6343,35 @@ static CPAccessResult access_lor_other(CPUARMState *env,
     return access_lor_ns(env);
 }
 
+/*
+ * A trivial implementation of ARMv8.1-LOR leaves all of these
+ * registers fixed at 0, which indicates that there are zero
+ * supported Limited Ordering regions.
+ */
+static const ARMCPRegInfo lor_reginfo[] = {
+    { .name = "LORSA_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 0,
+      .access = PL1_RW, .accessfn = access_lor_other,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "LOREA_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 1,
+      .access = PL1_RW, .accessfn = access_lor_other,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "LORN_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 2,
+      .access = PL1_RW, .accessfn = access_lor_other,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "LORC_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 3,
+      .access = PL1_RW, .accessfn = access_lor_other,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "LORID_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 7,
+      .access = PL1_R, .accessfn = access_lorid,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    REGINFO_SENTINEL
+};
+
 #ifdef TARGET_AARCH64
 static CPAccessResult access_pauth(CPUARMState *env, const ARMCPRegInfo *ri,
                                    bool isread)
@@ -7577,34 +7606,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     }
 
     if (cpu_isar_feature(aa64_lor, cpu)) {
-        /*
-         * A trivial implementation of ARMv8.1-LOR leaves all of these
-         * registers fixed at 0, which indicates that there are zero
-         * supported Limited Ordering regions.
-         */
-        static const ARMCPRegInfo lor_reginfo[] = {
-            { .name = "LORSA_EL1", .state = ARM_CP_STATE_AA64,
-              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 0,
-              .access = PL1_RW, .accessfn = access_lor_other,
-              .type = ARM_CP_CONST, .resetvalue = 0 },
-            { .name = "LOREA_EL1", .state = ARM_CP_STATE_AA64,
-              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 1,
-              .access = PL1_RW, .accessfn = access_lor_other,
-              .type = ARM_CP_CONST, .resetvalue = 0 },
-            { .name = "LORN_EL1", .state = ARM_CP_STATE_AA64,
-              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 2,
-              .access = PL1_RW, .accessfn = access_lor_other,
-              .type = ARM_CP_CONST, .resetvalue = 0 },
-            { .name = "LORC_EL1", .state = ARM_CP_STATE_AA64,
-              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 3,
-              .access = PL1_RW, .accessfn = access_lor_other,
-              .type = ARM_CP_CONST, .resetvalue = 0 },
-            { .name = "LORID_EL1", .state = ARM_CP_STATE_AA64,
-              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 7,
-              .access = PL1_R, .accessfn = access_lorid,
-              .type = ARM_CP_CONST, .resetvalue = 0 },
-            REGINFO_SENTINEL
-        };
         define_arm_cp_regs(cpu, lor_reginfo);
     }
 
-- 
2.20.1



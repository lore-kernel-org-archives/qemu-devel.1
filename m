Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3C8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3539D20709
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="miWWnPz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3539D20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofIJ-0006ao-Db
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof68-0000Ay-LV
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:16 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof66-0001uU-In
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:16 -0400
Received: by mail-pl1-x644.google.com with SMTP id 35so3769852ple.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HSjBCHwavjNr37NIxaEpavJpEI8ou/nda9kEqEE9VlM=;
 b=miWWnPz5TKHVh/oD5UPi0M1GOkbPbVTeLTbRbcTS8bgzkBgBZs7w3Sg1qvqA0ZdhyO
 7Zp4rEDoATiAm6kLy33kZjmLKYpUdvi4tdJFIf3Lq1o46Y4uGUhSUx+M1SMNjIUOXw0j
 MA8JsPxyhFAkWWG4Am/Wn0LPvlNrWHna4lZPDNGzu3kkIrF4/cRo9yiDJq7IsMFCsLGl
 9BYrZi3Psr4vGiOHK7h7lmbXXr1HVC5IoJ9SVu9KD9WFr0YaMoyYr1eTxhtf/7UR8UDx
 8UCkyk4ISQoakvFzDc7/PQa4YhGI2DIG67v4xKqBVDLoohHjfNMgr27yv156yZUMfw6y
 eFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HSjBCHwavjNr37NIxaEpavJpEI8ou/nda9kEqEE9VlM=;
 b=YcyDrjTFNG05nIQDR/m+NMWOVNgCBzaUNIzswAKYfIQygPvJzCUQ9JoykCdG7PJKJU
 nPHn98z+C/OJMR3rXUQ5xUhTq4qyfexW9C8gwzRvX4XeZOcUJ3YficSCWuSIbJglitYb
 yAXgAvJT5SCTwPCp6oE3o9d8nSMotj4Lq26/+HjDz7o3KxbalfcMDFj2Yk2KEtHNmpO1
 vmfn6mky6MNBHMRgvsu3bL19HGVsU0UUcwlMJ02JZR68sOE+2ijDTuczKxhH5PbgNpim
 m9Xq31k4Rnt8gPCVSSPDyNoHhUVcgGq/e5ax+46sLav6iZ6pPktX8ys78NBSebbEHdxz
 uIbw==
X-Gm-Message-State: AOAM533SsNExnCT7YckYRFL0gx66eJDxCRbtJGHiPeKy1EZdx5IYqdFb
 lhtvMtcl/dPCg3ihh2n4PN0IHV1M6vg=
X-Google-Smtp-Source: ABdhPJyk2/Yu6AAaHM5w0vB8R3JWjjoPoQn+/Eq5TlkIh3oVrYtUno91PrU9QiGQA6AC6hLipPseTw==
X-Received: by 2002:a17:90a:a62:: with SMTP id
 o89mr1093458pjo.188.1593142332856; 
 Thu, 25 Jun 2020 20:32:12 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 20/46] target/arm: Implement the access tag cache flushes
Date: Thu, 25 Jun 2020 20:31:18 -0700
Message-Id: <20200626033144.790098-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Like the regular data cache flushes, these are nops within qemu.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v6: Split out and handle el0 cache ops properly.
---
 target/arm/helper.c | 65 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2c6ec244af..d8c31d03da 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6929,6 +6929,32 @@ static const ARMCPRegInfo mte_reginfo[] = {
       .opc0 = 3, .opc1 = 3, .crn = 4, .crm = 2, .opc2 = 7,
       .type = ARM_CP_NO_RAW,
       .access = PL0_RW, .readfn = tco_read, .writefn = tco_write },
+    { .name = "DC_IGVAC", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 3,
+      .type = ARM_CP_NOP, .access = PL1_W,
+      .accessfn = aa64_cacheop_poc_access },
+    { .name = "DC_IGSW", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 4,
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
+    { .name = "DC_IGDVAC", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 5,
+      .type = ARM_CP_NOP, .access = PL1_W,
+      .accessfn = aa64_cacheop_poc_access },
+    { .name = "DC_IGDSW", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 6,
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
+    { .name = "DC_CGSW", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 4,
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
+    { .name = "DC_CGDSW", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 10, .opc2 = 6,
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
+    { .name = "DC_CIGSW", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 4,
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
+    { .name = "DC_CIGDSW", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 6,
+      .type = ARM_CP_NOP, .access = PL1_W, .accessfn = access_tsw },
     REGINFO_SENTINEL
 };
 
@@ -6938,6 +6964,43 @@ static const ARMCPRegInfo mte_tco_ro_reginfo[] = {
       .type = ARM_CP_CONST, .access = PL0_RW, },
     REGINFO_SENTINEL
 };
+
+static const ARMCPRegInfo mte_el0_cacheop_reginfo[] = {
+    { .name = "DC_CGVAC", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 10, .opc2 = 3,
+      .type = ARM_CP_NOP, .access = PL0_W,
+      .accessfn = aa64_cacheop_poc_access },
+    { .name = "DC_CGDVAC", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 10, .opc2 = 5,
+      .type = ARM_CP_NOP, .access = PL0_W,
+      .accessfn = aa64_cacheop_poc_access },
+    { .name = "DC_CGVAP", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 12, .opc2 = 3,
+      .type = ARM_CP_NOP, .access = PL0_W,
+      .accessfn = aa64_cacheop_poc_access },
+    { .name = "DC_CGDVAP", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 12, .opc2 = 5,
+      .type = ARM_CP_NOP, .access = PL0_W,
+      .accessfn = aa64_cacheop_poc_access },
+    { .name = "DC_CGVADP", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 13, .opc2 = 3,
+      .type = ARM_CP_NOP, .access = PL0_W,
+      .accessfn = aa64_cacheop_poc_access },
+    { .name = "DC_CGDVADP", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 13, .opc2 = 5,
+      .type = ARM_CP_NOP, .access = PL0_W,
+      .accessfn = aa64_cacheop_poc_access },
+    { .name = "DC_CIGVAC", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 14, .opc2 = 3,
+      .type = ARM_CP_NOP, .access = PL0_W,
+      .accessfn = aa64_cacheop_poc_access },
+    { .name = "DC_CIGDVAC", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 14, .opc2 = 5,
+      .type = ARM_CP_NOP, .access = PL0_W,
+      .accessfn = aa64_cacheop_poc_access },
+    REGINFO_SENTINEL
+};
+
 #endif
 
 static CPAccessResult access_predinv(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -8071,8 +8134,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
      */
     if (cpu_isar_feature(aa64_mte, cpu)) {
         define_arm_cp_regs(cpu, mte_reginfo);
+        define_arm_cp_regs(cpu, mte_el0_cacheop_reginfo);
     } else if (cpu_isar_feature(aa64_mte_insn_reg, cpu)) {
         define_arm_cp_regs(cpu, mte_tco_ro_reginfo);
+        define_arm_cp_regs(cpu, mte_el0_cacheop_reginfo);
     }
 #endif
 
-- 
2.25.1



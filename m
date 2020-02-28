Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82885C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B4D824697
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCghQKzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4D824697
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7inn-0007pY-Fs
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifZ-0008NU-O9
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifY-00028I-9A
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:21 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40817)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7ifY-00027p-2c
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:20 -0500
Received: by mail-wm1-x342.google.com with SMTP id d138so2304968wmd.5
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5oQ35QsMhetApJIHGz3Rua7oGdC5Wob+G0lA1+c8/Fw=;
 b=SCghQKzZ0n5jys0ixaZ7beD5qPwkCXiQKVoGJ20dZ5/0G+sizZg5xvKWaLmkkll2DB
 OFyHBjEJN5jqdG6kY4xVjH4D+1qulKIG2c2ywWSlLw1v7iKRRHk0CYQZVOaJlEzU6Q7C
 XfaIOZQxTrVnqnl5w3Ul2X79GXh5PnbrTzVqkX1g58JuTTuM2YhXvjzgusSVCtmzr+4W
 VFaz8BirU53/Hm5OxGictG37WLGgy6aLycahac4zrkM67slOmV9pzh0x5dmujhbCQTQp
 w0xjAIXJeRTdKjTbxAo1qtPUr7AHjjpP7VyBnHGgnZhTJeKhofrOAAuw1lPsd3AZgc+Y
 XsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5oQ35QsMhetApJIHGz3Rua7oGdC5Wob+G0lA1+c8/Fw=;
 b=hIWZkcYPHU13m+4CmSvH7MOcR2+oesCfqMuxl5aSZoJgdbQSzcmDXiEo9TnVEDMxXo
 BDEUN2baF+wyFLurA0sjkA1ttObXRc7SOlJTFfSe5zXUqlTgJwNC9hawr2IC2ujsgBLd
 JR6b4w0OHkNS64EAbYUTNoR2BmjAjJHdvW8UVFVj8Fhm+dv/UYpGf6/0D6fCeBxAKw9n
 sisoxa5NHkx5WkAa/bAUNEW0BAhuJW1IPnZY5ndmcmIvEG2UzvC7pN8XO7MNCFyOglHS
 +NqA7Yq4qojU0py0wCHM1rOpwsqxx2LVz9a+gRmjQ6CWvQAfMrh6a88zDTHjq1/wpjFl
 qxhw==
X-Gm-Message-State: APjAAAXFfCQTbmPbTFFZCUMdTti9PbwU09m2wV8B9AKfUntP/a4LRJ/a
 jTOtA5Hp/Q8J3FokFD8VjhVTykArWuBRKQ==
X-Google-Smtp-Source: APXvYqzLA2MHcxBIs1BgVBXpU97gJfV1kBa/rD3UY91e4uu4953h+6GsBVgDgujcT+rAgcOPbfuj+A==
X-Received: by 2002:a1c:750f:: with SMTP id o15mr5708199wmc.111.1582907958750; 
 Fri, 28 Feb 2020 08:39:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.39.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:39:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/33] target/arm: Implement ARMv8.3-CCIDX
Date: Fri, 28 Feb 2020 16:38:39 +0000
Message-Id: <20200228163840.23585-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

The ARMv8.3-CCIDX extension makes the CCSIDR_EL1 system ID registers
have a format that uses the full 64 bit width of the register, and
adds a new CCSIDR2 register so AArch32 can get at the high 32 bits.

QEMU doesn't implement caches, so we just treat these ID registers as
opaque values that are set to the correct constant values for each
CPU.  The only thing we need to do is allow 64-bit values in our
cssidr[] array and provide the CCSIDR2 accessors.

We don't set the CCIDX field in our 'max' CPU because the CCSIDR
constant values we use are the same as the ones used by the
Cortex-A57 and they are in the old 32-bit format. This means
that the extra regdef added here is unused currently, but it
means that whenever in the future we add a CPU that does need
the new 64-bit format it will just work when we set the cssidr
values and the ID registers for it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200224182626.29252-1-peter.maydell@linaro.org
---
 target/arm/cpu.h    | 17 ++++++++++++++++-
 target/arm/helper.c | 19 +++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ce1e2a090e5..0b84742b66a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -904,7 +904,7 @@ struct ARMCPU {
     /* The elements of this array are the CCSIDR values for each cache,
      * in the order L1DCache, L1ICache, L2DCache, L2ICache, etc.
      */
-    uint32_t ccsidr[16];
+    uint64_t ccsidr[16];
     uint64_t reset_cbar;
     uint32_t reset_auxcr;
     bool reset_hivecs;
@@ -3577,6 +3577,11 @@ static inline bool isar_feature_aa32_ac2(const ARMISARegisters *id)
     return FIELD_EX32(id->id_mmfr4, ID_MMFR4, AC2) != 0;
 }
 
+static inline bool isar_feature_aa32_ccidx(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, CCIDX) != 0;
+}
+
 /*
  * 64-bit feature tests via id registers.
  */
@@ -3784,6 +3789,11 @@ static inline bool isar_feature_aa64_rcpc_8_4(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) >= 2;
 }
 
+static inline bool isar_feature_aa64_ccidx(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, CCIDX) != 0;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
@@ -3807,6 +3817,11 @@ static inline bool isar_feature_any_pmu_8_4(const ARMISARegisters *id)
     return isar_feature_aa64_pmu_8_4(id) || isar_feature_aa32_pmu_8_4(id);
 }
 
+static inline bool isar_feature_any_ccidx(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_ccidx(id) || isar_feature_aa32_ccidx(id);
+}
+
 /*
  * Forward to the above feature tests given an ARMCPU pointer.
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8841cc7fde8..6be9ffa09ef 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6726,6 +6726,21 @@ static const ARMCPRegInfo predinv_reginfo[] = {
     REGINFO_SENTINEL
 };
 
+static uint64_t ccsidr2_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /* Read the high 32 bits of the current CCSIDR */
+    return extract64(ccsidr_read(env, ri), 32, 32);
+}
+
+static const ARMCPRegInfo ccsidr2_reginfo[] = {
+    { .name = "CCSIDR2", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 1, .crn = 0, .crm = 0, .opc2 = 2,
+      .access = PL1_R,
+      .accessfn = access_aa64_tid2,
+      .readfn = ccsidr2_read, .type = ARM_CP_NO_RAW },
+    REGINFO_SENTINEL
+};
+
 static CPAccessResult access_aa64_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
                                        bool isread)
 {
@@ -7788,6 +7803,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
 
+    if (cpu_isar_feature(any_ccidx, cpu)) {
+        define_arm_cp_regs(cpu, ccsidr2_reginfo);
+    }
+
 #ifndef CONFIG_USER_ONLY
     /*
      * Register redirections and aliases must be done last,
-- 
2.20.1



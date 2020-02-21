Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625EFC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:24:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1D7206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qxqtQAhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1D7206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58I8-0008Nv-AK
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582a-0007ia-7C
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582Z-0003Bj-3Y
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:24 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582Y-0003BD-TW
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:23 -0500
Received: by mail-wr1-x441.google.com with SMTP id m16so1976732wrx.11
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=e7EtrQPP4lbwreuGx+Kl/vTgu6XaCFRgZZBcf+txFYM=;
 b=qxqtQAhJtgPVW55AUGEcg+1dYw1H3n31/Y9h1gAWo2jL7EOqyZodicKMDAJ6N88GhQ
 hzzxJNxS4Up3sGfCvSX+O0HJf2CCXW6ZsPy5sooixrH1QdRhp8jfeQJKG8WttCq5Fqd0
 u6Jc9uR+sxn1k/OgmLZ9OaMKL2kVtRisSa3QuA1RkxQa/v/WX/dJwMUXZT5OrGwt9sD5
 P7TVQW5SjlxAxMPMGsOb97qtgVSQ631lwT4Q23N74RC4GD5AAP8HNs0SzltRA6FSNbFT
 T1eAwQvu05u6nuFR4RHA+EKwUdj0rECtpZmEoax0VowwDmeT3QxMVZpoGdJc9Hv0BcKc
 1iiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e7EtrQPP4lbwreuGx+Kl/vTgu6XaCFRgZZBcf+txFYM=;
 b=tWgursUStjVDfAdcylMrix7UaxIKHkTQ447kubK1c6AiqIrLGYuPBT+iVJKrfT+T0/
 49ZE8j6D99G36S4YMD6udUt3SFyVN5M0fEnU4zByVbCM7dpuDUgNvOt+4L4IbVAL3qj6
 1S849BBirGfVy4PmcGpAxn5p3zArCc7bDXBXnTQU6zs2RZZ3Iw7ccrUHF4EALD3scFIx
 WhwGzkRDj4pXvMxyYuOKaIgfBGStvdQqqMHdkozMF8MrhTuJK/PuyOCAPO4dtLAFBixq
 z6Z978BJYssL+7MMIn4m9P4wlzcCDoEoL3a/n6KxdjU0Tu5OO86Wq6LySjHFFINb6qxO
 FZHQ==
X-Gm-Message-State: APjAAAW+O1ZaTq2apsXuarANL4Ihvt3+AB3YpSWUxWzWrzZnf/EB+ztC
 2NH1/X854in5dwl8+h/ASc6KJ4o765O8oQ==
X-Google-Smtp-Source: APXvYqzJKqDCWzj2nMrulNwFlJHqfoxXn+xGLpFRhd74B8RnFrhNaDQXaVeq1uCIims1eH1Jl7CSlA==
X-Received: by 2002:adf:fa87:: with SMTP id h7mr51177548wrr.172.1582290501558; 
 Fri, 21 Feb 2020 05:08:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/52] target/arm: Use isar_feature function for testing
 AA32HPD feature
Date: Fri, 21 Feb 2020 13:07:20 +0000
Message-Id: <20200221130740.7583-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
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

Now we have moved ID_MMFR4 into the ARMISARegisters struct, we
can define and use an isar_feature for the presence of the
ARMv8.2-AA32HPD feature, rather than open-coding the test.

While we're here, correct a comment typo which missed an 'A'
from the feature name.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200214175116.9164-20-peter.maydell@linaro.org
---
 target/arm/cpu.h    | 5 +++++
 target/arm/helper.c | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ba97fc75c1d..276030a5cf3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3526,6 +3526,11 @@ static inline bool isar_feature_aa32_pmu_8_4(const ARMISARegisters *id)
         FIELD_EX32(id->id_dfr0, ID_DFR0, PERFMON) != 0xf;
 }
 
+static inline bool isar_feature_aa32_hpd(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_mmfr4, ID_MMFR4, HPDS) != 0;
+}
+
 /*
  * 64-bit feature tests via id registers.
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 441e8bb6022..19d749a1913 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7408,8 +7408,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     } else {
         define_arm_cp_regs(cpu, vmsa_pmsa_cp_reginfo);
         define_arm_cp_regs(cpu, vmsa_cp_reginfo);
-        /* TTCBR2 is introduced with ARMv8.2-A32HPD.  */
-        if (FIELD_EX32(cpu->isar.id_mmfr4, ID_MMFR4, HPDS) != 0) {
+        /* TTCBR2 is introduced with ARMv8.2-AA32HPD.  */
+        if (cpu_isar_feature(aa32_hpd, cpu)) {
             define_one_arm_cp_reg(cpu, &ttbcr2_reginfo);
         }
     }
-- 
2.20.1



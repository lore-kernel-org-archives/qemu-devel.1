Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848E4C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E8E208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x7c21t0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E8E208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58aA-0004Q0-Vy
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582v-00007F-8Z
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582u-00043S-1s
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:45 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:34885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582t-00041g-R4
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:43 -0500
Received: by mail-wr1-x431.google.com with SMTP id w12so2012364wrt.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=OE8kMh53THu/LOHp2dUI69ASdc4neCkr/cEZCIA4G00=;
 b=x7c21t0/ASt5sQMjtnq9eFH6tgbzKMhFX7BmwGOHHwzp3w8W8pMqE4qwarKRrzQg1t
 aMQGdlgCQGZgCyQWL7lUdJpQ+SPQuCnWtDRVXgUOA9PabRedUXdWeB1McfwfAF/je6Rp
 DBQbm8aP3+h15iqnsTL7J+Fvz/mXyA09yoJk7axQkuNgGf4BVwwLQ4XjGUbwqxP9IGu1
 qr60hWLg8HRTU5owXu3fpOwOtVYarrNCi4zGeiT1TuBJrsDfXWRjG1ANo2nVkldvGa5n
 kZT5MiKPjMEjHaOm8jG294a4D0kx/eOmmmjh/fdkHJFet88LxxXPqbvHtX+gb5Bw60fE
 K2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OE8kMh53THu/LOHp2dUI69ASdc4neCkr/cEZCIA4G00=;
 b=PPY1km17qrQVnEZntKlGNraahh5xuEHk/R+3FHbkx9gIQV8Pl1n/5UjkQPpwzlXNZr
 XFRz5TYLlOkoAO4YIpwHoVO2XzoE1887eC9avn49F2Hu3bFqKPLaT30UDWpfBrWfLOms
 qCxBrFPEZVcZYVkggClmy9WQLLbtIQuz7LFyx8NglzN7s2bmyYEAgBO7htdIv4Z5lIxC
 4H7A830K7xMLV4MoNDfuR3RPGii2f2w+LW5Ra9/BQwheWMczB7LUV4rLRz4iOSnqjP1y
 fYS9v/03o70RzNyKaO29XPepMjjJmvW6cJqVEC53HLOaYNAynUX2CDs57w6hKQIZ66X7
 fnEQ==
X-Gm-Message-State: APjAAAUND0g1zha4x16V3tXSpdudal622ijxoUwOn0XyG0hIu5X3egwD
 yVwHOFAMROmsLwXQoCwSKUoZamLZxik41w==
X-Google-Smtp-Source: APXvYqwd6bUFm1HvedTFDKg4NPAZLVBj626COG8/BduzWhgtlZrm0rUu7VDmrE8V3ZcmcdDTJ2bcHA==
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr52714383wrw.60.1582290522540; 
 Fri, 21 Feb 2020 05:08:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/52] target/arm: Add isar_feature_aa32_{fpsp_v2, fpsp_v3,
 fpdp_v3}
Date: Fri, 21 Feb 2020 13:07:37 +0000
Message-Id: <20200221130740.7583-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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

We will shortly use these to test for VFPv2 and VFPv3
in different situations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200214181547.21408-8-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1e2aae276bf..a7fc86c23cf 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3467,12 +3467,30 @@ static inline bool isar_feature_aa32_fpshvec(const ARMISARegisters *id)
     return FIELD_EX32(id->mvfr0, MVFR0, FPSHVEC) > 0;
 }
 
+static inline bool isar_feature_aa32_fpsp_v2(const ARMISARegisters *id)
+{
+    /* Return true if CPU supports single precision floating point, VFPv2 */
+    return FIELD_EX32(id->mvfr0, MVFR0, FPSP) > 0;
+}
+
+static inline bool isar_feature_aa32_fpsp_v3(const ARMISARegisters *id)
+{
+    /* Return true if CPU supports single precision floating point, VFPv3 */
+    return FIELD_EX32(id->mvfr0, MVFR0, FPSP) >= 2;
+}
+
 static inline bool isar_feature_aa32_fpdp_v2(const ARMISARegisters *id)
 {
     /* Return true if CPU supports double precision floating point, VFPv2 */
     return FIELD_EX32(id->mvfr0, MVFR0, FPDP) > 0;
 }
 
+static inline bool isar_feature_aa32_fpdp_v3(const ARMISARegisters *id)
+{
+    /* Return true if CPU supports double precision floating point, VFPv3 */
+    return FIELD_EX32(id->mvfr0, MVFR0, FPDP) >= 2;
+}
+
 /*
  * We always set the FP and SIMD FP16 fields to indicate identical
  * levels of support (assuming SIMD is implemented at all), so
-- 
2.20.1



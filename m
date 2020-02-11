Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4031C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A78D2086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QeptztjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A78D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ZUy-0007g2-Ka
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTi-0005ie-B7
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTh-00045l-2Q
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:42 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35037)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1ZTc-0003xd-Gg
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:38 -0500
Received: by mail-wr1-x444.google.com with SMTP id w12so13502732wrt.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Gu4Ok/18d9t4bS+gGDbkd/ibAEuGshhJuDPzFWbBLFg=;
 b=QeptztjYmsEtwOMPBO1gx3GM1omBAVUTTQiGSINmsShZFPYKPIFkS8QWky51611EO6
 F8MRQmNEOUrP52u6mOqMNBTHXF17GU7r6dcLzcxe7DoxvTCoid1RyLaMmlnbwoh3xMeH
 cclwaFtf3ZRlHQboaoISYlUxVk/1S0DX6KINECo7VvlGrgyu0YISVbLYLeuOR6kUnw9R
 +knYmlTyBoHMr6itQR4rxKbvhITXE82ElRcQi1cp6tV8AsXPs6jyR4+AoO/Q6o/93jLl
 sjopF2H1WKFNKVz7gRJLyleSO8NB3MhT9TdONFtAWOtUPiTUKB5yn/wjd/bPVYhW1wnA
 gRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Gu4Ok/18d9t4bS+gGDbkd/ibAEuGshhJuDPzFWbBLFg=;
 b=ihO2qU1kvwui1Zb+GgQGEpiTeYiHFS14rxBb/xFsj0Ke+3e+lAkpQTzCTcuyN7BSE+
 Ezze1DbdlLhjszkNA5Nift5YxEmRnpsGc69LwlKfDS2IEhTg22C/cloY/Ly/LbeHPGot
 ncnnKPScGJs+6GZDhZl6YH808uqK3/r9+Uq6ts3hg/YwlY0i1mh/yEU7xiWldZPUDdVw
 SeUpgd9n7JR+WOX9CcKxazsYU/ShMhnizCW+ZMaTlcCs5LbTga3Jv+tMi45sxhK2raLU
 FOPlnHFJ1dPUNNmqVxiAkuoBbtJoqolG8EyiI0Sq9A2SBBvMs9HM4KPAIwpkgbRFnkS4
 R+mg==
X-Gm-Message-State: APjAAAVEXD/WEXgrRRU0XlqR2H+WxmjcGQoxOLQvRQswq6U8QKbfzYxp
 j73Du9WIaOeSxM0iKB4yugnpow==
X-Google-Smtp-Source: APXvYqxhc2S8/ZQFr/8/LN64VPQr7wT0DuHqgIzsnZd7Zqpiskze1XSmHbQr9+KhVyINneNTA6uyxA==
X-Received: by 2002:a5d:4b03:: with SMTP id v3mr10073902wrq.178.1581442653418; 
 Tue, 11 Feb 2020 09:37:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y1sm6109675wrq.16.2020.02.11.09.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 09:37:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 03/13] target/arm: Define and use any_predinv isar_feature test
Date: Tue, 11 Feb 2020 17:37:16 +0000
Message-Id: <20200211173726.22541-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200211173726.22541-1-peter.maydell@linaro.org>
References: <20200211173726.22541-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of open-coding "ARM_FEATURE_AARCH64 ? aa64_predinv: aa32_predinv",
define and use an any_predinv isar_feature test function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 5 +++++
 target/arm/helper.c | 9 +--------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ac4b7950166..b1f3ecfd942 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3719,6 +3719,11 @@ static inline bool isar_feature_any_fp16(const ARMISARegisters *id)
     return isar_feature_aa64_fp16(id) || isar_feature_aa32_fp16_arith(id);
 }
 
+static inline bool isar_feature_any_predinv(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_predinv(id) || isar_feature_aa32_predinv(id);
+}
+
 /*
  * Forward to the above feature tests given an ARMCPU pointer.
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ddfd0183d98..bf083c369fc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7116,14 +7116,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
 #endif /*CONFIG_USER_ONLY*/
 #endif
 
-    /*
-     * While all v8.0 cpus support aarch64, QEMU does have configurations
-     * that do not set ID_AA64ISAR1, e.g. user-only qemu-arm -cpu max,
-     * which will set ID_ISAR6.
-     */
-    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)
-        ? cpu_isar_feature(aa64_predinv, cpu)
-        : cpu_isar_feature(aa32_predinv, cpu)) {
+    if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
     }
 }
-- 
2.20.1



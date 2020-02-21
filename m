Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4D8C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD04824653
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uiK6Yz0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD04824653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58Bu-0006UW-UJ
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582Q-0007HT-C7
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582P-0002yl-4w
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:14 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38221)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582O-0002xq-Ud
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:13 -0500
Received: by mail-wr1-x441.google.com with SMTP id e8so1995464wrm.5
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ixHvPZovlXIaICo5d8Ua17czbh6t9v18RdBxgNVk+74=;
 b=uiK6Yz0QMBMXZmWJxR4OR/8fFbi/FJCDi7v5Zu+MEdW90Rnc5cXgh/HQvbBkyMyAJP
 SQhrlqwSCEKRCXYcs4mhWQ6OzCoe9qI3BPqozeEQbLNE44Tz79BpgRhUqslqymgoVz6+
 T2jouRDPO0jJZ6NjNOMuIGfmok80fn3TME4VORWKtz5HAxU9U0PxIyEm2/nFFLmCdzJk
 EYdOD9KrdI9sEpDaS5Kg+gy90/i/koMuiDdmABRWI1W0qariE6fPP8y55QE+HXRms3PS
 wMRCwr2ZbqiS22mtN1sM6uK3eGr9S0teeO3BfdOb3qTXuzIpe7e7rDkYCSlgZhtw4uXn
 XIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ixHvPZovlXIaICo5d8Ua17czbh6t9v18RdBxgNVk+74=;
 b=uWIlMEAU+DsMiV9+bxnITT6MXc9g5vrjoY+hra2n9goIgScfVpOo6785PvEW9IBAvu
 CfwVtRpYOKimxE9curKSnciGvfWfGlc5fZcwX5twu208jmKkq9T4KS7SQ4tQGBqpfF6M
 4NJ8TT3+a8D9w/19bnvbuO0taoR92RUeg3zKuISMNURAU+h3+W53BkMMBWt34pS/nMjO
 HTUPCepkskpouaofzhJDu2CaSBIAL/ALHoN0eKbBsR/GeoPKbxux+2peKgJlBdlthFbj
 Yad80EX7fNQnjGUvRxzOKGNB0T8FmmbVskgWecXAzCP4a4h6ClHUa1fZTGW/Wd3paNGP
 GjtQ==
X-Gm-Message-State: APjAAAW3cMzwIo2UZhEGGfCq9c9X9GcIj550LjLZDJUiIIbkn+9DPfDC
 e07nl6bMCvsjPJnvjDbpjxP7mTcHG0RcXg==
X-Google-Smtp-Source: APXvYqyFpcQXMa3fdTprKsXLnd7RXSqzK1D73mCS2Jh6TFBbzf9krhwhb+cwk+9hDLmEFiyRFCr+Gw==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr48163725wrp.321.1582290485753; 
 Fri, 21 Feb 2020 05:08:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/52] target/arm: Add and use FIELD definitions for
 ID_AA64DFR0_EL1
Date: Fri, 21 Feb 2020 13:07:07 +0000
Message-Id: <20200221130740.7583-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add FIELD() definitions for the ID_AA64DFR0_EL1 and use them
where we currently have hard-coded bit values.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200214175116.9164-7-peter.maydell@linaro.org
---
 target/arm/cpu.h    | 10 ++++++++++
 target/arm/cpu.c    |  2 +-
 target/arm/helper.c |  6 +++---
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ef0feb228ab..081955094dc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1821,6 +1821,16 @@ FIELD(ID_AA64MMFR2, BBM, 52, 4)
 FIELD(ID_AA64MMFR2, EVT, 56, 4)
 FIELD(ID_AA64MMFR2, E0PD, 60, 4)
 
+FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
+FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
+FIELD(ID_AA64DFR0, PMUVER, 8, 4)
+FIELD(ID_AA64DFR0, BRPS, 12, 4)
+FIELD(ID_AA64DFR0, WRPS, 20, 4)
+FIELD(ID_AA64DFR0, CTX_CMPS, 28, 4)
+FIELD(ID_AA64DFR0, PMSVER, 32, 4)
+FIELD(ID_AA64DFR0, DOUBLELOCK, 36, 4)
+FIELD(ID_AA64DFR0, TRACEFILT, 40, 4)
+
 FIELD(ID_DFR0, COPDBG, 0, 4)
 FIELD(ID_DFR0, COPSDBG, 4, 4)
 FIELD(ID_DFR0, MMAPDBG, 8, 4)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 56f2ab865da..12bf9688007 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1718,7 +1718,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
                 cpu);
 #endif
     } else {
-        cpu->id_aa64dfr0 &= ~0xf00;
+        cpu->id_aa64dfr0 = FIELD_DP64(cpu->id_aa64dfr0, ID_AA64DFR0, PMUVER, 0);
         cpu->id_dfr0 &= ~(0xf << 24);
         cpu->pmceid0 = 0;
         cpu->pmceid1 = 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index cb2f4d8bbdb..f183ac5cbfe 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6266,9 +6266,9 @@ static void define_debug_regs(ARMCPU *cpu)
      * check that if they both exist then they agree.
      */
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-        assert(extract32(cpu->id_aa64dfr0, 12, 4) == brps);
-        assert(extract32(cpu->id_aa64dfr0, 20, 4) == wrps);
-        assert(extract32(cpu->id_aa64dfr0, 28, 4) == ctx_cmps);
+        assert(FIELD_EX64(cpu->id_aa64dfr0, ID_AA64DFR0, BRPS) == brps);
+        assert(FIELD_EX64(cpu->id_aa64dfr0, ID_AA64DFR0, WRPS) == wrps);
+        assert(FIELD_EX64(cpu->id_aa64dfr0, ID_AA64DFR0, CTX_CMPS) == ctx_cmps);
     }
 
     define_one_arm_cp_reg(cpu, &dbgdidr);
-- 
2.20.1



Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3974DC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:20:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 047F12073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TPSstwLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047F12073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58Dp-0001DR-2v
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582I-0006ut-7b
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582H-0002nO-4V
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:06 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:37632)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582G-0002lJ-TV
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:05 -0500
Received: by mail-wr1-x42c.google.com with SMTP id w15so1997303wru.4
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=HSTddCvvLAI7dOqdxIhz4N+v4u/0AHPDflmr9CxICTo=;
 b=TPSstwLm7q0kCRtSyxH49Fo6OwJLN3Na+9lc2NJxWqVcWx/MVXcSOJh8gWSQkZHbie
 9tJV+ocGqfm13kVOSglxRpU7n4peFnGfHAUfUZCbh0HRLT6lFCfYp6ngACwdZpQESnuN
 w9oNEqCEvSQsCpm73jd6iFrdjB+apP05fpd/v3JJiB/ecxiqHOOlgzsOxD5fDu263VaQ
 XGk03b7OmZvPZkSF3vV+KnLukW30ruhjZgYIQfHpnqhKSVQXSUNaytka71GC9oqy65vF
 K0P+9UkXX5FonyhegwxLWTBfnDlO9cGIJrO3Py7kiyTRZemZmtlIlwfttytrbcO84GZJ
 bFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HSTddCvvLAI7dOqdxIhz4N+v4u/0AHPDflmr9CxICTo=;
 b=n7ZvR9/C+UEIIakpMoAvYnfYqFHZWCXtp25DpbX495lBjAlrhVbze5kE/uF0mMj7Rz
 oVy8t7+BzbpEhCEMmKfnxdZ4nt2NnZTyssngbdfzenutSWloUCIyi4k2AHwg3iB/qzY3
 JhmKgYct6rPuJjsmSVOagwm0sJNs5+Vpcn71PJyCUew24OtT+7RklrmOCtup31Kittx1
 cY4D9SLq+wO8V6KC+8XqQAhFhWLBXBoY7FuoVXev43ah+ywTXbp4vSmyh6MfGHRPzlbR
 vVZYCOWasfBAg5hSBQXm/C438SiC1y4DG8oFTKTfsqJD/Ytc/rCYUQDgtPb/RmsYm1Ib
 f9OA==
X-Gm-Message-State: APjAAAUBizvMTfP/p0fGb+Obccza1AZrDg4srdVzdieMaUe8LtEfQfAD
 fkB6c5gLi7xkkoMT71PPp0rl+tdnW+p9EQ==
X-Google-Smtp-Source: APXvYqwcRHFnChCUCi9ACzEeKAukCuIXpXA0dUjYq6SAEFI2LENkJ1FJxloUdHHt4Rhj6sUYZrpFHw==
X-Received: by 2002:adf:a1d9:: with SMTP id v25mr47783904wrv.160.1582290483588; 
 Fri, 21 Feb 2020 05:08:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/52] target/arm: Define and use any_predinv isar_feature test
Date: Fri, 21 Feb 2020 13:07:05 +0000
Message-Id: <20200221130740.7583-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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

Instead of open-coding "ARM_FEATURE_AARCH64 ? aa64_predinv: aa32_predinv",
define and use an any_predinv isar_feature test function.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200214175116.9164-5-peter.maydell@linaro.org
---
 target/arm/cpu.h    | 5 +++++
 target/arm/helper.c | 9 +--------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7ccd65bdce3..ef0feb228ab 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3677,6 +3677,11 @@ static inline bool isar_feature_any_fp16(const ARMISARegisters *id)
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
index ad2bfa9ef83..ab36f33b719 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7721,14 +7721,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
 
-- 
2.20.1



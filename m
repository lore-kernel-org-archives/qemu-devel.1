Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A25C3B1AF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136882468E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYCp5AzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136882468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fBU-0006I8-9R
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 12:55:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7i-0005pz-BZ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7f-0000hq-CQ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:30 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2f7f-0000hB-6W
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:27 -0500
Received: by mail-wr1-x443.google.com with SMTP id g3so11868395wrs.12
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 09:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5yFL6qJIGrr6vMsTkdaf8oL+HzuN+eqpKkJ6fDD8yLs=;
 b=IYCp5AzTtdyojqddY7SiOZHntlgKyZ3KYGFsC69DYHBgd6uzM0lTbYhCcM0+E4dxg4
 9ZyceTGxmOGIM3eaQlaWbt6OK1lyhYcVdTT+KY1aRhxDnJdUCrRDCxUQkW4SLkYwn4cW
 Xq9wWEo4kt3UpUi+Or2rVPWLUljpKBY8Jq0A/HitrCP2NuH96gNLzhf2lO+sRBF+VhN/
 3QeeJ7kKFrkoJ3KI1KfC0oxHUGJtzguiNPJLhnnqsayN0RYNCWJy0iM5MF1e+b8JR068
 DBTN7NY5gK4FqFfaNoz80rAsWEUmyG2PBVG2cyhyCRWriWVsup/6QV15gkK3f9fpisNy
 Igwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5yFL6qJIGrr6vMsTkdaf8oL+HzuN+eqpKkJ6fDD8yLs=;
 b=Usjkt65Wy61zKd0PMfKV2gbJ+3GGe6fNsnnSAgeFD0koNV/dLFEOUQ8sgYdqq8/yyM
 cAP0X5F0AEooqOu/RVcM0TdISRP8NEUwmgXqHqoMn+aMjXDxASWSHhHIv+INoGalB5XZ
 jfPIzjp2X93u0za3OqP6ARRrtLJUs0c8ItJQ4l85c0cReVzLDDqi+wjnch8gX8nvOfhR
 GH28IDmlYK+FuhFkk3bmjSWPSiwI+xxCSDG1iQznCiX7k7xM+tmewAGwkA9TJsnZUeWW
 DrrSCdnW8tvYDlAgoOBUL7PnVD5/ikvx7W5arrBoMlFGEYuoJO1zbVwBdk7S6QhI4BN5
 I7LQ==
X-Gm-Message-State: APjAAAXIx9PR8n8bth/YQmUpv1NqgPNJevLF8M86dMfAP3ili0N5mvSD
 zG954wunh1v8Zq/9sprn68YkeQ==
X-Google-Smtp-Source: APXvYqy1MC/x2LSE7lEyzVkpTtGmSJG3QhOq7Cj7XIelCzHql3tfGSF1dlHR/IUSp31yInVnIQH3cA==
X-Received: by 2002:adf:b60f:: with SMTP id f15mr5381955wre.372.1581702686270; 
 Fri, 14 Feb 2020 09:51:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v8sm8001857wrw.2.2020.02.14.09.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 09:51:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 04/21] target/arm: Define and use any_predinv isar_feature
 test
Date: Fri, 14 Feb 2020 17:50:59 +0000
Message-Id: <20200214175116.9164-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214175116.9164-1-peter.maydell@linaro.org>
References: <20200214175116.9164-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of open-coding "ARM_FEATURE_AARCH64 ? aa64_predinv: aa32_predinv",
define and use an any_predinv isar_feature test function.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index d4ed52981fa..b3ced7f78ba 100644
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



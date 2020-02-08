Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9CAC35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF79620726
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vZd9KFp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF79620726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0PoT-0007j9-0w
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 08:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgy-0000tA-75
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgx-0005Cm-3n
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:36 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j0Pgw-0005CQ-Tn
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:35 -0500
Received: by mail-wr1-x442.google.com with SMTP id t3so2034515wru.7
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 04:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pbTFZCO7ADOXNmgFtzr7ygDnLBWMHSNndfGhWIzZQwI=;
 b=vZd9KFp/o1gku7+YTTB3ZPy6CWA3zCkpVbSEvc9Q+jjL6tTueWi2V1tghhF8EL4ciP
 B9uQkt9w88ux0EgLcYMGVJwsmEVPPkyXcH7fJ5jbnpNLPMSV0xsQEv4Rqgk6OTS6uOV1
 XNAFBYrKO2RQA/6gZ5IgPUvtC6W0G7srKBi2bCs7s2TFnQwqZ7SG6Rhr12O9NQDJlWuf
 t+FzNJIMyroE8pV/Iam+E2+bsjN1u2OfFJYFbFWMwNv1xrumXkl1RpUJQ5Nu/Y6bxbrU
 eKQsJKkEggQfJDo9B8HTkC3UPmuc1+a8m9BcgvYdPQjSmmQJKhw0J2IIx1JCjb1d8Z9Z
 Tiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pbTFZCO7ADOXNmgFtzr7ygDnLBWMHSNndfGhWIzZQwI=;
 b=lDUn4755voCcx4Bzd7DvJxo5y56lJdpqRvHrqPoJn5SbF7hHiK8TpflQ4AHsCvG5Hf
 jWb0uiwY/noSKl2y10UoDIB0d7mhDQID6CVRNgq3w2HcWDK93Mjy9oej11nH4CYMT/M8
 jBvbfsCuz8f4+VrFSmcbbSfm8bEmTCtikt4YWEXWo5zPmgtSkAPazwoEWrQsJHnCebbP
 PrmIZs6q0M1FO1iHIeBReG2UdtYmKbpD0QMBFaqgS7yFGYTFAxAi1Y5YJcJp8p7GL68L
 Or3/4Ia7+zkKfvlLqvVXiLl1QlBy8zsc18AAQ+lkx2m5UlTIt6qc8hKD8ANlInxSECz1
 U+Hw==
X-Gm-Message-State: APjAAAVA4fXd3ocvUPXTcZxSN8QjeG1wpc9Lw63g2+Zb01dpo8akdkDF
 qSQkwyjqZ4tbrS3tjuCBYJuw1lWT3GY4ew==
X-Google-Smtp-Source: APXvYqyV/8XuAImAdJswvRtOS7Y0OZsvObumZtXvZxovDKBKkesiizssw7yIEa7nv9T+UwTdEhSBBg==
X-Received: by 2002:a05:6000:1208:: with SMTP id
 e8mr1701697wrx.351.1581166713755; 
 Sat, 08 Feb 2020 04:58:33 -0800 (PST)
Received: from localhost.localdomain ([82.3.55.76])
 by smtp.gmail.com with ESMTPSA id p5sm7490534wrt.79.2020.02.08.04.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 04:58:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 16/20] target/arm: Enable ARMv8.2-ATS1E1 in -cpu max
Date: Sat,  8 Feb 2020 12:58:12 +0000
Message-Id: <20200208125816.14954-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208125816.14954-1-richard.henderson@linaro.org>
References: <20200208125816.14954-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

This includes enablement of ARMv8.1-PAN.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c   | 4 ++++
 target/arm/cpu64.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b0762a76c4..de733aceeb 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2709,6 +2709,10 @@ static void arm_max_initfn(Object *obj)
             t = FIELD_DP32(t, MVFR2, FPMISC, 4);   /* FP MaxNum */
             cpu->isar.mvfr2 = t;
 
+            t = cpu->id_mmfr3;
+            t = FIELD_DP32(t, ID_MMFR3, PAN, 2); /* ATS1E1 */
+            cpu->id_mmfr3 = t;
+
             t = cpu->id_mmfr4;
             t = FIELD_DP32(t, ID_MMFR4, HPDS, 1); /* AA32HPD */
             cpu->id_mmfr4 = t;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c80fb5fd43..57fbc5eade 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -673,6 +673,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1); /* HPD */
         t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
         t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);
+        t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 2); /* ATS1E1 */
         cpu->isar.id_aa64mmfr1 = t;
 
         /* Replicate the same data to the 32-bit id registers.  */
@@ -693,6 +694,10 @@ static void aarch64_max_initfn(Object *obj)
         u = FIELD_DP32(u, ID_ISAR6, SPECRES, 1);
         cpu->isar.id_isar6 = u;
 
+        u = cpu->id_mmfr3;
+        u = FIELD_DP32(u, ID_MMFR3, PAN, 2); /* ATS1E1 */
+        cpu->id_mmfr3 = u;
+
         /*
          * FIXME: We do not yet support ARMv8.2-fp16 for AArch32 yet,
          * so do not set MVFR1.FPHP.  Strictly speaking this is not legal,
-- 
2.20.1



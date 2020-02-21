Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84462C35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52892222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UwXYwoa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52892222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58N9-0007LJ-GF
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582b-0007mD-Fi
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582a-0003DQ-ER
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:25 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:54442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582a-0003By-86
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:24 -0500
Received: by mail-wm1-x335.google.com with SMTP id n3so1726051wmk.4
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=VpFi9ia1qLZ3xYtg0o1IQedP9GIh+OffzPSN9uWqPKI=;
 b=UwXYwoa3cPc+cUb74Qzy2tfbgswAMf9vj6Rs8RdJmI9ShU2itOh0gErIACSZ7p6j3g
 Dh9iDIEykS8hbCTrZbqk5CChd97oFAwzrJwH+3ZEvVhExsS8i/hPZp7z0bwk19IPvIOl
 H9Hj6GD/xP6Df/SbiYPF4NlCekLQDN8X9bNFoA4RiN67qr8Ta0crRr6YMN5rI+nOPMHA
 /HbZaPTDeCNh9bUXSun0qe96M6ZvvgcNTIPWOMNXjiLhmPGDB80yjcGhTE3nYWX8iSn/
 2isqr30XU+4H4ED1OMGQtz/dqpeuUZy5KWmyQapyguX6KfYR9bWPcHtZs4fL1o1OWOQ7
 2WaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VpFi9ia1qLZ3xYtg0o1IQedP9GIh+OffzPSN9uWqPKI=;
 b=PWJlL3QjNj2pwA9Db3Axwe0Y5oFGCcjFC1qvpY9nFOzE2eWwUSxtxNSw2ipcIHfvXO
 Dz29rIO3XBMUUdjElteOQqZW7mLvJEavgB8l7JSyyqOJbxkpURJMle4yELKqNPYTrmVP
 bW/ORwrkDt/5QVn2ZOqirFSdz7H/g2E0ESPb/w+d1bD7b4tXOvU+UJkIWaf1MIwtP5kr
 T2Wr+R3Morzi58ba0I+cMQiYAeTU1DL+OzhtvAFzkc6JMScpDGQm09vIXgBivIJ+1jux
 L2f7nSzBFdDQUqjC6cwYl2YvoZA6DRe0WwAMWcG5xUaV0VTdwl5orFXg8WHDpo1ClzPn
 sD3A==
X-Gm-Message-State: APjAAAU/GqnQ7GWingrJSNmjSTbHzAjiq7EatBRq897emBcj6FIgbf7s
 nWck+51pJWjdlwxy5Xvkn4WMlsQmGFMFLw==
X-Google-Smtp-Source: APXvYqxzlPczsDuYAk4VVMRP1w+5gbUMN5M/hyJUIQhf+nXlxosNtPmxap0L6CoWyXqknrJ94XGptA==
X-Received: by 2002:a7b:cd1a:: with SMTP id f26mr3618095wmj.184.1582290502618; 
 Fri, 21 Feb 2020 05:08:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/52] target/arm: Use FIELD_EX32 for testing 32-bit fields
Date: Fri, 21 Feb 2020 13:07:21 +0000
Message-Id: <20200221130740.7583-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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

Cut-and-paste errors mean we're using FIELD_EX64() to extract fields from
some 32-bit ID register fields. Use FIELD_EX32() instead. (This makes
no difference in behaviour, it's just more consistent.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200214175116.9164-21-peter.maydell@linaro.org
---
 target/arm/cpu.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 276030a5cf3..c6af3290caf 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3453,18 +3453,18 @@ static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
 static inline bool isar_feature_aa32_fp_d32(const ARMISARegisters *id)
 {
     /* Return true if D16-D31 are implemented */
-    return FIELD_EX64(id->mvfr0, MVFR0, SIMDREG) >= 2;
+    return FIELD_EX32(id->mvfr0, MVFR0, SIMDREG) >= 2;
 }
 
 static inline bool isar_feature_aa32_fpshvec(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->mvfr0, MVFR0, FPSHVEC) > 0;
+    return FIELD_EX32(id->mvfr0, MVFR0, FPSHVEC) > 0;
 }
 
 static inline bool isar_feature_aa32_fpdp(const ARMISARegisters *id)
 {
     /* Return true if CPU supports double precision floating point */
-    return FIELD_EX64(id->mvfr0, MVFR0, FPDP) > 0;
+    return FIELD_EX32(id->mvfr0, MVFR0, FPDP) > 0;
 }
 
 /*
@@ -3474,32 +3474,32 @@ static inline bool isar_feature_aa32_fpdp(const ARMISARegisters *id)
  */
 static inline bool isar_feature_aa32_fp16_spconv(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->mvfr1, MVFR1, FPHP) > 0;
+    return FIELD_EX32(id->mvfr1, MVFR1, FPHP) > 0;
 }
 
 static inline bool isar_feature_aa32_fp16_dpconv(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->mvfr1, MVFR1, FPHP) > 1;
+    return FIELD_EX32(id->mvfr1, MVFR1, FPHP) > 1;
 }
 
 static inline bool isar_feature_aa32_vsel(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >= 1;
+    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 1;
 }
 
 static inline bool isar_feature_aa32_vcvt_dr(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >= 2;
+    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 2;
 }
 
 static inline bool isar_feature_aa32_vrint(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >= 3;
+    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 3;
 }
 
 static inline bool isar_feature_aa32_vminmaxnm(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >= 4;
+    return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 4;
 }
 
 static inline bool isar_feature_aa32_pan(const ARMISARegisters *id)
-- 
2.20.1



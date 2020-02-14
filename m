Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F80C3B1B4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB912465D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HAapWzTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB912465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fKn-0004TB-FB
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:05:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f80-0006DG-13
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7y-00019w-Rv
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:47 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:35922)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2f7y-00019O-M2
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:46 -0500
Received: by mail-wm1-x330.google.com with SMTP id p17so11556211wma.1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 09:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gwjHIqzoFrNguGa6rFd3Yw+93bK6HEFcxL1oIdQTlPE=;
 b=HAapWzTQPSkjNJfzWOqLKcvQqesRABnCUBA1RS/jBGOQF2dliLnIpJHKVM8+3u3x5V
 CMMGDDCIjC968NsIJmfni3J7xQOQrXnVJEm3HjCfK3CVUjzLT328iI18ETj4NtnQ+chP
 T18rsdlfu8MeRUZdFcu/hPOeT7Z0KAhWQHMviO8539lX3hsqaplN0Ok0+LoI9bf0U1Su
 0wmJ4g7f4mSan5mDsfGojca8gmfvJCMQgwnIl+JRjoGYlCLz8zPAdkwXUYB/Oc7Rvaxg
 mfFhDB+SmC6B0ZcgbcQ+sj3Nq6uu9q+g3sOXFYPmTGham2kk8fNjBPzupkZfudde63xG
 REuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gwjHIqzoFrNguGa6rFd3Yw+93bK6HEFcxL1oIdQTlPE=;
 b=TtDCp466nNBoO3p+36OSu7+7u0qvCJ2lr/hwjS+obHTb10GnnwPDGAMIs/+Yy2KyK+
 Uwe9r6AqNkARuUI9WWVGx7B5YkOJwcpNH8YlcJCwas0nV5iAMpdC+4IS6+xBgXN+Ll9p
 /kAgVaul/GmUf0g+a4jWrg5jyiIUSdeg/wcbjLo6ndwJOpWN+BX5ZEc3+ey7YFjpwvWf
 OmQ9mxP3OHQ9UxAm9+RSVOFDMDbVwUwIB2355f03Zs4yfpqKtg9U7YgLDiIQDSkU8EnI
 GUgXh2zCECDnvZk4t8CF85q5loLRF/gMssNl/xyiwYThxzje69MCXjnn5epuddu4tGgf
 TFYg==
X-Gm-Message-State: APjAAAVEAfxNxNpusAbktQyYr554wyMiW74Blbo6DtMQsDpLG55wh1/+
 CcA0saI2dCXLDuCSFHaqufAyFg==
X-Google-Smtp-Source: APXvYqwoNLJuEV2dO3gJMpTOVCGjIeb9fezspxNrQ0OGZOY+Pa4xwfU1gUNdpYDIP/UWU4Ah4Ug2bA==
X-Received: by 2002:a05:600c:2255:: with SMTP id
 a21mr5882419wmm.79.1581702705723; 
 Fri, 14 Feb 2020 09:51:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v8sm8001857wrw.2.2020.02.14.09.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 09:51:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 20/21] target/arm: Use FIELD_EX32 for testing 32-bit fields
Date: Fri, 14 Feb 2020 17:51:15 +0000
Message-Id: <20200214175116.9164-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214175116.9164-1-peter.maydell@linaro.org>
References: <20200214175116.9164-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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

Cut-and-paste errors mean we're using FIELD_EX64() to extract fields from
some 32-bit ID register fields. Use FIELD_EX32() instead. (This makes
no difference in behaviour, it's just more consistent.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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



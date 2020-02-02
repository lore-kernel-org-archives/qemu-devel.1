Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA83BC3524B
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79E1C20661
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PMDiici7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E1C20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy3i5-0005HG-MR
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 20:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3gt-0003Tr-7Q
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3gs-0001uZ-81
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:47 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33031)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iy3gs-0001tQ-2o
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:46 -0500
Received: by mail-pg1-x543.google.com with SMTP id 6so5755974pgk.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 17:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hPQ0dR0RCVOoDHLNqnKbILWZrurFdQJzDpp0jJ4Jtv4=;
 b=PMDiici73X5qrzNu3CGsv++vvI7YAWVLMsXO2GjxyqJohfoAQj6m9r+CCzGf3voyBY
 IXveZCVic9//JAcYsq0OkKuUnggyDdXm8wKyiSXi6dvhtgytPSzRks7ovC1un0eWB9Z9
 F125KVK8fW1pMOCcTMuP3XmapQ6bUoPfiuY53G8Z0DopQELVMEUD1KfQtBWEx0AXYNLR
 P1moRd5RfJuCPDbHVI44dUhUltYxmdc2X39v5vFh6woP3S7OAmBMbjt9BYZ0TaFvvee1
 HQU6cdoNnqFSnZ3Wn52q8NvocrtZ83Ia4q/8bbunl8y5YJyDxRvZU7T7L+5ng4FuXAXY
 0NFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hPQ0dR0RCVOoDHLNqnKbILWZrurFdQJzDpp0jJ4Jtv4=;
 b=s+N/NqHsIKx1LdlN1rlcQTvp5wub65secYU7UpCHKy+ZrlYB5YjWAcL3Ou6eJsLmb3
 nilToRPzeNBUPdHFt/V/Y3KeTZtY6QXcxbww625lVNouFy8jYgcQGykHfD0o63Q9QoNi
 z0gIwVT0nC7zbOkxscB6S8oRNNyaevOyr4WsvSJCPCbU1LHSHatSs8ceH9eb756GfBfl
 fsJ+q7+9BrauH0wmpch6T7VxocZ6m2a5bKbipVBGmwSjkycbtIqM7TLTwTKbht9rSUyF
 5owbIO+uob3EotUel9hAANEGq11pU99CcyquDz2zlHFPQxDia9MgB70UmtVwdaFb1mPR
 kP6Q==
X-Gm-Message-State: APjAAAXXH2TQAqAwul4PxHcY0Sp6fE1w8lzwllDL4Ag64SdBXk90Yj99
 MpLkJzRLLR4L/ZNmV+vqhtPOgo7lT0A=
X-Google-Smtp-Source: APXvYqynsExQQSTXqD5AMJW32L5Uu2PO2ieHj1Sc7/yDlGoitZ7+Ns5iyw/5sUXO35VVcB9+WxPHAw==
X-Received: by 2002:a62:5547:: with SMTP id j68mr18389545pfb.6.1580605484830; 
 Sat, 01 Feb 2020 17:04:44 -0800 (PST)
Received: from cloudburst.WiFi.IPv4InfoBelow
 (h210.212.133.40.static.ip.windstream.net. [40.133.212.210])
 by smtp.gmail.com with ESMTPSA id 13sm14678975pfi.78.2020.02.01.17.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 17:04:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/14] target/arm: Add isar_feature tests for PAN + ATS1E1
Date: Sat,  1 Feb 2020 17:04:28 -0800
Message-Id: <20200202010439.6410-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200202010439.6410-1-richard.henderson@linaro.org>
References: <20200202010439.6410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

Include definitions for all of the bits in ID_MMFR3.
We already have a definition for ID_AA64MMFR1.PAN.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c63bceaaa5..08b2f5d73e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1727,6 +1727,15 @@ FIELD(ID_ISAR6, FHM, 8, 4)
 FIELD(ID_ISAR6, SB, 12, 4)
 FIELD(ID_ISAR6, SPECRES, 16, 4)
 
+FIELD(ID_MMFR3, CMAINTVA, 0, 4)
+FIELD(ID_MMFR3, CMAINTSW, 4, 4)
+FIELD(ID_MMFR3, BPMAINT, 8, 4)
+FIELD(ID_MMFR3, MAINTBCST, 12, 4)
+FIELD(ID_MMFR3, PAN, 16, 4)
+FIELD(ID_MMFR3, COHWALK, 20, 4)
+FIELD(ID_MMFR3, CMEMSZ, 24, 4)
+FIELD(ID_MMFR3, SUPERSEC, 28, 4)
+
 FIELD(ID_MMFR4, SPECSEI, 0, 4)
 FIELD(ID_MMFR4, AC2, 4, 4)
 FIELD(ID_MMFR4, XNX, 8, 4)
@@ -3443,6 +3452,16 @@ static inline bool isar_feature_aa32_vminmaxnm(const ARMISARegisters *id)
     return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >= 4;
 }
 
+static inline bool isar_feature_aa32_pan(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->mvfr0, ID_MMFR3, PAN) != 0;
+}
+
+static inline bool isar_feature_aa32_ats1e1(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->mvfr0, ID_MMFR3, PAN) >= 2;
+}
+
 /*
  * 64-bit feature tests via id registers.
  */
@@ -3602,6 +3621,16 @@ static inline bool isar_feature_aa64_lor(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, LO) != 0;
 }
 
+static inline bool isar_feature_aa64_pan(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) != 0;
+}
+
+static inline bool isar_feature_aa64_ats1e1(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, PAN) >= 2;
+}
+
 static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
-- 
2.20.1



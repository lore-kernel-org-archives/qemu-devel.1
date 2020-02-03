Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB247C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B7572080C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYAWXrk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7572080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyd1a-0008Or-K5
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0V-0006Zw-1x
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0U-00035h-1T
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:22 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33033)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iyd0T-00034G-Rr
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:21 -0500
Received: by mail-wm1-x344.google.com with SMTP id m10so68312wmc.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xtW+FSSefxatLNrrEmn+GvZA5uNXwjZFYEeWUyFoKGE=;
 b=pYAWXrk2KaditU/d70ufbRDBxFmocZ0IyAosh+BQ5QRhwbmifU4tsZhWj0kyneL1r7
 tUQQktCCNpcG/Y8DRpYhoehZ1Rvf8dNMd0zdO+DXYbJrjzoGWs9pXhqnSggPh6hrQuuC
 b3ikGPmCagEegNH1PI+AP/nAnALq+OVsWxiYyUFNwJRVgs3TgoB88z1NK5JlJ746y47c
 5wJkgMvta15IWIMNjedeBslCada1NedQSEJyBsenzk50jDSe6Fq56uqWrGNA2JB52T1X
 6p7g9mxSH66a+BRSn3I2gOBVMRWeeZINwG4Bj3Xm4iJ0aDtziYi4h2zm/q0+3KTp/S94
 T1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xtW+FSSefxatLNrrEmn+GvZA5uNXwjZFYEeWUyFoKGE=;
 b=hU97+sNnH6SEqR3p777eXCG2Uiz4hTZsgR7Qvngio4Z5N9W7eenOtQjhzOmDeU7e/E
 dSnHQOLZU4XsefhgP64lMwKqagvKlR8R6/0/TvpDHLVUOlIGT57aaA6ICik9mdIvULen
 GyBj9SZKJiRQeJzRh9RTolRKqaYxvErbGJI5QCDrFTF724L+4xONt2qOlsH9PwxcEvR3
 Cvhgm5ojXgSilIddOZwsbA0bh+LAhDxgT2bG+H3quBKRq0HQ7iF1dlJDbXRZvwObJHWP
 sjqqCprrkcdnT/xFTFNTzUpBZgL3BQZBiz9gVRxOT9K7MdzGCedJCdwTDAZ6K/peGHmY
 OArQ==
X-Gm-Message-State: APjAAAWaCXLXR4+DB3decBbYVtlac8kYAHslSikxal4o5KyCDJ6J9H8C
 YxjaMajzYhTPFByIb8bJ+GBKwcYAl54qKw==
X-Google-Smtp-Source: APXvYqyxwsU5/Vf3HmMEoob40uvxNdbO/14/tdJUhmVmbH9U9iFAYaFKOqlL2aek9KBfssL1D/He2g==
X-Received: by 2002:a05:600c:2218:: with SMTP id
 z24mr29295363wml.50.1580741240505; 
 Mon, 03 Feb 2020 06:47:20 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id h2sm26429739wrt.45.2020.02.03.06.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 06:47:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/20] target/arm: Add isar_feature tests for PAN + ATS1E1
Date: Mon,  3 Feb 2020 14:46:59 +0000
Message-Id: <20200203144716.32204-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203144716.32204-1-richard.henderson@linaro.org>
References: <20200203144716.32204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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



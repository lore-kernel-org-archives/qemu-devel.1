Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F72C31E40
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ADB92073D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EsBd2ZXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADB92073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htz7Y-0003cq-AP
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 14:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60614)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4e-00066g-AI
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4d-000792-B7
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:12 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35702)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz4d-00078X-6U
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:11 -0400
Received: by mail-pf1-x442.google.com with SMTP id u14so37642037pfn.2
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6IeFtwkeZbBPVLT5Rmllb3ExAsBhlKcdIq9EZhAeEOQ=;
 b=EsBd2ZXyAs12YJkUflSxdyWDy4dQ1VA7S1sjPBpz/feC0S7PjxPutW98hpXE48BQqZ
 duze6YgLkmYtrK/9qzMMjqatC1CnyovW9Detsfq/azWI7VgxbyYirVQXMBjlehgbmcJY
 HfD0KpZXBfFvIAEmRtEXUO08hR5q6CKDMYULvli7jPWnoV3G828NSM8kGVuPxfXO3OPh
 PJhqZ3T4pSzJaVcrVBP52obs3ZUOSQESU5L4W+37vtXyru47NuaJCbF5BVYq754WLFDi
 d5+Lr6uoqePJXIa+64fy6wIuJIy/7nc3ggwjX93XLCoF3qE/rU07bekJKepVfBI8MAtS
 7KTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6IeFtwkeZbBPVLT5Rmllb3ExAsBhlKcdIq9EZhAeEOQ=;
 b=cf9eId0d4xND7iDdrhWFiLjvakS92V4+czPW4EvFxsBFpALFqL2HiqzXmReZiyj4lG
 G1i1rn2g56WdpL7nmE4Kso88KEQaTj2sg0cBLFzRQGb264MZxDgJ70XG+aFxflMm0+4/
 CPXAP+5dVmSWNvDScfYERSwzAZ/ClV3f+83pLekJo8pEWgl0UseJgVEX6XlLq8wDUFsw
 30ZtKSGZCC0jemKHL6LfhI7tntQb30FrMBLqZqdpH5Q1QtOyPed9E1EJFwqqwMzTXreZ
 wbdYVIfLn7VrONypKqHTKZ35kRA6x2qqIvQsU5gZl/O3s3PygMDNziTomB+vLYEeOkuw
 WPvQ==
X-Gm-Message-State: APjAAAX+9o0x5rPs4V6RFa8B6h20EFKVQcT+Rzz3egxBwK5rbZTl/oFf
 mNYHJlX/NSpiQfCryIHEDHZApIVWjyU=
X-Google-Smtp-Source: APXvYqwXV2QxS3KeOZOgNnPklX8LG4SYpVuUQA9Dsz7tKOaKwVfMkcm0N83J0qPGGm/xg3pem1KQTg==
X-Received: by 2002:a62:28b:: with SMTP id 133mr65294339pfc.251.1564858090005; 
 Sat, 03 Aug 2019 11:48:10 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.08
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:47:32 -0700
Message-Id: <20190803184800.8221-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803184800.8221-1-richard.henderson@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v3 06/34] target/arm: Define
 isar_feature_aa64_vh
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 94c990cddb..e6a76d14c6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3573,6 +3573,11 @@ static inline bool isar_feature_aa64_sve(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SVE) != 0;
 }
 
+static inline bool isar_feature_aa64_vh(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, VH) != 0;
+}
+
 static inline bool isar_feature_aa64_lor(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, LO) != 0;
-- 
2.17.1



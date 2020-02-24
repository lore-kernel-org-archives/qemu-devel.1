Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7167C38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:31:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88667222C2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uqbxg0jS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88667222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MFm-0002BD-Kg
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:31:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7d-00043h-1z
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7b-0005mb-Uw
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:40 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45681)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6M7b-0005kz-Og
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:39 -0500
Received: by mail-pf1-x442.google.com with SMTP id 2so6053155pfg.12
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+KPvmzpCR5seSYv8kHpAw1AZPr6kKDFij7TNxO0T5iM=;
 b=Uqbxg0jSTQpcnURf4xEmKosWe03wCLnDnGlU62zj/rU1xQnYsUL6vQG0jaC9wVQPXK
 WtQff6VthTSvakTFz3/W48U2KAmz1ecxTW2YtTKKJcpUBA5mFUF66a+hScksICwFjzFp
 6Jx+BTSAHh5bSaUNHhiG+8my02XfdjFc9oxNwoPRWYeAuVVrEvZwX4AvVmIPGtSwtE/V
 GiMAskG/CbY5Y4X2h09T25GrenbWLQwWBergpjA/5zPM8bhnIbpRmbe/OcqIYL6bu469
 PE00pxAprU2rjHmVybQtqoMaC9amatDPxORqbb3//kIu0dbLah9VUG7vdo6iOM8n1ECW
 il7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+KPvmzpCR5seSYv8kHpAw1AZPr6kKDFij7TNxO0T5iM=;
 b=tcjG2SEzxHT/aIEhNs+iUSHZFXYFnbuWyYGGxgE+yUtEAhPe9iB+qipYfUK2hkHdOL
 jM+DshqIbWhzu/rrYsLY3G8UUW0CWwKiVzhKKWvllIckp+N4zaC9qHzD0b5lhmKAzMd0
 WbZqA0sUnbb7j0Lj2PSpqbTnYayypNfbZQXsQu1/1LIo5Hy1W71c4M4rp3kYnDSMYSN5
 qtDjaP7+IRLJriSzwM1IgVt3v92CSM4hNNAKEcme1IQNZScbNxuCUJ77C62h4mOKwxM4
 FVAsmXfswlXWC1Cli78HIwHkU/H8mx+u9MprKbAKcvwNLl2PxJ9Qh4oK9iKaybh2n+l7
 a19w==
X-Gm-Message-State: APjAAAXhWkFPer01NmA8BIdWo7AObRBoV2QkCZ1z8SaczI/l8hen1T5C
 DbpzT44rMMjKqXOAdpHfn4Ju0Daj+8k=
X-Google-Smtp-Source: APXvYqwYmDDa1kiSLy6Lyv/nLy8yB9hev2ZoIks/fwYW5rdpiub2h4RP07XawZgGNCJLO2Wtk1eA0A==
X-Received: by 2002:aa7:8ad9:: with SMTP id b25mr53268382pfd.70.1582582958411; 
 Mon, 24 Feb 2020 14:22:38 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id o6sm13897097pgg.37.2020.02.24.14.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:22:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/17] target/arm: Add isar_feature_aa32_{fpsp_v2, fpsp_v3,
 fpdp_v3}
Date: Mon, 24 Feb 2020 14:22:18 -0800
Message-Id: <20200224222232.13807-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200224222232.13807-1-richard.henderson@linaro.org>
References: <20200224222232.13807-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will shortly use these to test for VFPv2 and VFPv3
in different situations.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1e6eac0cd2..f7a90f512e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3470,12 +3470,30 @@ static inline bool isar_feature_aa32_fpshvec(const ARMISARegisters *id)
     return FIELD_EX32(id->mvfr0, MVFR0, FPSHVEC) > 0;
 }
 
+static inline bool isar_feature_aa32_fpsp_v2(const ARMISARegisters *id)
+{
+    /* Return true if CPU supports single precision floating point, VFPv2 */
+    return FIELD_EX32(id->mvfr0, MVFR0, FPSP) > 0;
+}
+
+static inline bool isar_feature_aa32_fpsp_v3(const ARMISARegisters *id)
+{
+    /* Return true if CPU supports single precision floating point, VFPv3 */
+    return FIELD_EX32(id->mvfr0, MVFR0, FPSP) >= 2;
+}
+
 static inline bool isar_feature_aa32_fpdp_v2(const ARMISARegisters *id)
 {
     /* Return true if CPU supports double precision floating point, VFPv2 */
     return FIELD_EX32(id->mvfr0, MVFR0, FPDP) > 0;
 }
 
+static inline bool isar_feature_aa32_fpdp_v3(const ARMISARegisters *id)
+{
+    /* Return true if CPU supports double precision floating point, VFPv3 */
+    return FIELD_EX32(id->mvfr0, MVFR0, FPDP) >= 2;
+}
+
 /*
  * We always set the FP and SIMD FP16 fields to indicate identical
  * levels of support (assuming SIMD is implemented at all), so
-- 
2.20.1



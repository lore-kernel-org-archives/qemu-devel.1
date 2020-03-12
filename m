Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1F0C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:00:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BDA8205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zyEfpJzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDA8205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCU0O-0002VD-IC
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 16:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjJ-0005hI-JF
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjI-0002Be-Al
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:53 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34521)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTjI-0002AZ-3R
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:42:52 -0400
Received: by mail-pl1-x641.google.com with SMTP id a23so3080278plm.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Kqb/ekSCjd3NGP5caJeLUqYBI+D5wVD+00pKBar9ftg=;
 b=zyEfpJzC8n0DGsJTLkFv4XBCHbl7Zo7VXBxw7FUjt7ig0XTgV0zZJtXk/twPg74NT5
 5cEvY/xbiDelwu4lgRDkdNvKtFBaO1ugk8iATZP0zKWiaFl7pCE337961lxalS6EfH0Q
 Z+q0Y8pfDuxPPwWXnOfVUsZujR8MTSUxnLoKpXiTXWKelldFLDB7aHHBTd6yKwHuqvth
 dB0qmlW1cOJ+jO2FI4zfFEOx+cLiZx/P5YQ/4KqM8WyD0i+yA61iHlUE1oNLtXsPCUlL
 M27efZ9wMZmM9ysa71WhsKYa4SOe0nDnXCKbrPfLLiCzl2Kk4JIwhv0xgg5HCebs+oyZ
 Zhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Kqb/ekSCjd3NGP5caJeLUqYBI+D5wVD+00pKBar9ftg=;
 b=IihpDwZHyVBExxqH51K9DJ89qDFCS7J7Xw3wCGFaY19Kk5elEeJ6bB4RdXoczDHOjI
 B0XAGlyjYzS0hwUnW0JbhVmoi58pCvmkO8N62JXHlxQTBEJIhMmliFTnFxMv2On3SXmT
 YnQ3LQf1ULfQrJ/HLmB1o/+xSwR2RTqkolM1MS5easNkQJe6i7s1w9qLh8GL1juexuBc
 R//giQgP7ycIiH0kIcYddveEl0MGHSSMFQRFZxS5ZJp8bvFQkF6SJn1kugQdIiMjCSSV
 mXKPoSQAz+srHngJ2VQ6j9dfv5vE2sBhyNauaNTSe7g5XCwwpsqz3kUe0sMjvCw+28dd
 YWFg==
X-Gm-Message-State: ANhLgQ2/+WkhPHiZZVZFzSIN6J4YA0nQCiF7WHMT9o+wpY3Y8YMmoqQ0
 mO69BrEypnR5ca6XiHEA2otoB5WG6gA=
X-Google-Smtp-Source: ADFU+vtrnEhf0fLWU8QylZUW37j6GCE4vArUjqWs9aYbiiagDuVpeKYPlSQzx9kFmEanihj93RcDgw==
X-Received: by 2002:a17:902:7794:: with SMTP id
 o20mr9505928pll.312.1584042170835; 
 Thu, 12 Mar 2020 12:42:50 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:42:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 22/42] target/arm: Move regime_tcr to internals.h
Date: Thu, 12 Mar 2020 12:41:59 -0700
Message-Id: <20200312194219.24406-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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

We will shortly need this in mte_helper.c as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 9 +++++++++
 target/arm/helper.c    | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index f091891312..56fb07f2b6 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -948,6 +948,15 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     }
 }
 
+/* Return the TCR controlling this translation regime */
+static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
+{
+    if (mmu_idx == ARMMMUIdx_Stage2) {
+        return &env->cp15.vtcr_el2;
+    }
+    return &env->cp15.tcr_el[regime_el(env, mmu_idx)];
+}
+
 /* Return the FSR value for a debug exception (watchpoint, hardware
  * breakpoint or BKPT insn) targeting the specified exception level.
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2a50d4e9a2..e4b4366af7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9835,15 +9835,6 @@ static inline uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx,
 
 #endif /* !CONFIG_USER_ONLY */
 
-/* Return the TCR controlling this translation regime */
-static inline TCR *regime_tcr(CPUARMState *env, ARMMMUIdx mmu_idx)
-{
-    if (mmu_idx == ARMMMUIdx_Stage2) {
-        return &env->cp15.vtcr_el2;
-    }
-    return &env->cp15.tcr_el[regime_el(env, mmu_idx)];
-}
-
 /* Convert a possible stage1+2 MMU index into the appropriate
  * stage 1 MMU index
  */
-- 
2.20.1



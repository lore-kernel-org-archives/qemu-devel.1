Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7CDC3B1B1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D90B20873
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NcHHIMcr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D90B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fG9-0005YW-En
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:00:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7v-00064a-V8
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7t-0000wG-Fy
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:42 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35103)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2f7t-0000tP-7V
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:41 -0500
Received: by mail-wm1-x343.google.com with SMTP id b17so11575236wmb.0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 09:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VbLItfxzzwVIogOn7W2BSKPPHmmspgIMmaJYOYePbHA=;
 b=NcHHIMcrfMMDyIWzSxccuCJZQIr4b2c9J6b/8eEQ6kX6D4/KeCDV4KyvZ7Y88F8A6g
 QTGojyP3Sl2htawQ8RGQ0U00aF8SDOVytmOd8LBqqpmMXd7o7hPwPqCA8fuLLPpvlHGO
 kcJyxjAcOMcV+oPyNoB2zabt7YA/Rz9LBhbH2lxrsS/W2aTLKCSMT4eDsQBUt4UdiakM
 XtdqEXrLFHzfPYBLAyrWfTE1Msmy9fuG0+U5Di1MjAD4Ai3uuVKTwAX9vkVsIGYciIHF
 1PL6dnjVJmN9VYxipwjgAhtUWQflXcRWo3QRnSArQhfaaHVLPBhRmJLwAhgkXOnVwy7B
 2m1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VbLItfxzzwVIogOn7W2BSKPPHmmspgIMmaJYOYePbHA=;
 b=pWhVj9aDdLyqfEHES4XmkhOlAz03xa3dXMkcPXfCrdzFl1hpTXICsyv+Mc25sOhim5
 XFptsQFs+m0Yhk7/ucF1CM7PyXGwNueiXQ2OGLYEYZNsJcz5QwSUH4yugIuy4tqbAwwq
 RKmE4i5NMgaE0wZ1bOMXz9EpQmkvvA2GjZc50PjYtgRSMnpl7rLXzXDu5ZZmnj7V1xqG
 OljTEHkQz1C7J64TYXJdz+XetLwPfU7+hS8O1oskPDRVTPwg87qNSm8nMqs96cTxs4ix
 0arFgqCEnW38fL8iYRjEps5TBzk8mzAM2Y2HePe217hlew8VLTCebPs9U24W2mvb9kJA
 /gSw==
X-Gm-Message-State: APjAAAX88R6UxHp4ixj5lQ2Gb5Wzq5+TRHWJklT3VtVRp0hCPO5/hzkD
 ZxgeEgWoRPGkBLFj4HfR/9peYg==
X-Google-Smtp-Source: APXvYqw0IUGZmGesAQ4cxyEP3kKbZKKR2Sgxzv6pMnIOngCoFxiVHhYjStl1GwlxQa0OKnaod8IuMw==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr6069503wmi.10.1581702699939; 
 Fri, 14 Feb 2020 09:51:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v8sm8001857wrw.2.2020.02.14.09.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 09:51:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 15/21] target/arm: Provide ARMv8.4-PMU in '-cpu max'
Date: Fri, 14 Feb 2020 17:51:10 +0000
Message-Id: <20200214175116.9164-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214175116.9164-1-peter.maydell@linaro.org>
References: <20200214175116.9164-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

Set the ID register bits to provide ARMv8.4-PMU (and implicitly
also ARMv8.1-PMU) in the 'max' CPU.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v1->v2: use FIELD_DP64 for 64-bit idreg
---
 target/arm/cpu64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index f8f74a7ecda..c9452894035 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -703,6 +703,14 @@ static void aarch64_max_initfn(Object *obj)
         u = FIELD_DP32(u, ID_MMFR3, PAN, 2); /* ATS1E1 */
         cpu->id_mmfr3 = u;
 
+        u = cpu->isar.id_aa64dfr0;
+        u = FIELD_DP64(u, ID_AA64DFR0, PMUVER, 5); /* v8.4-PMU */
+        cpu->isar.id_aa64dfr0 = u;
+
+        u = cpu->isar.id_dfr0;
+        u = FIELD_DP32(u, ID_DFR0, PERFMON, 5); /* v8.4-PMU */
+        cpu->isar.id_dfr0 = u;
+
         /*
          * FIXME: We do not yet support ARMv8.2-fp16 for AArch32 yet,
          * so do not set MVFR1.FPHP.  Strictly speaking this is not legal,
-- 
2.20.1



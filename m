Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63631ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:05:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF752190F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W6SHTLM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF752190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvXl-0007D4-KE
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 10:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJM-00064m-25
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJK-00049b-V6
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:27 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:46086)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIvJK-00049M-Rc
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:26 -0400
Received: by mail-yb1-xb42.google.com with SMTP id h202so3098694ybg.13
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XGJIZDe8e48mjnd3S1UnH/xuMhjquSRYJ/YgYFRxSl4=;
 b=W6SHTLM1x7e1T4AuRr+qe1lW5dgNk0JSG4O6ttxTNvnWs2DoR4p80QHSkJ5IGkf17R
 w2a1AAZX4NwS1586L6OGsSubrOml5J5is/pFeobTC+rVhll7oaiXCN3Ahq7ziuAbKK/y
 7hA105SQYNrRHpCTot1wFywnaDN4IEMqc4HqlnezwsYtDlNGJRYqqOIEeCXppHrT+r4O
 j2KZX7qk/v4mNoLDyXO3PKf5wGEi2JwpQA6kkw5OqmbENZatIPElawjV8rWzqglyz4Jc
 AT1LQwU2ZLlu4za50/KHujxayAZdN1ZsbPSVKZH0X9ZOXxAPVzmhKLpKfXlhYcKieXnf
 0quA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XGJIZDe8e48mjnd3S1UnH/xuMhjquSRYJ/YgYFRxSl4=;
 b=lJJ2uCFdwbMPy409BZCwq9vxZoAdFE5/DwpOtgdFgl+0xSccqO6pYtS/iylzWMczwQ
 6nqJCMK81JL0pyIFlzBuTHxQgOpzjkOlT4oqDUcxVjO5725MoQyu/OIOzxPudeXUdHzx
 bVBD0/WeYPCGJmN6f99JsUICbH5SfL94toKPa/8WPon16dno2Onf6uieQonKFXxsOOZU
 Q/9SJhp0MW8fQVCTkMBxvtaV5kAmaqeYxEN9Xl4QIUhLo4SvbjXLh9FqSj/VscfJ1Yv9
 qJOBHzL5MOO0VI3kszfVAE+aaYZy9JlejGFfOWVogPDWiK7kGRQWUrgCcJYP1V3owlj1
 xlIA==
X-Gm-Message-State: APjAAAWsEQ5jBfzB1C2SMtrGHr7eSnykU3E0Gef80ere152DKQOzKov2
 nfmjmO5bK0l1kJlDotuj7/nDlMYl034=
X-Google-Smtp-Source: APXvYqxbx3sKSMdy5fyyvYz5IEmiYnRZFmHkbxDrlkQpxJlrF6a4mulwXf7h1dKYsOokMyhxqSp7Xw==
X-Received: by 2002:a25:3041:: with SMTP id w62mr10789764ybw.67.1570801825958; 
 Fri, 11 Oct 2019 06:50:25 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id f68sm2534000ywb.96.2019.10.11.06.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 06:50:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 18/22] target/arm: Enable MTE
Date: Fri, 11 Oct 2019 09:47:40 -0400
Message-Id: <20191011134744.2477-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011134744.2477-1-richard.henderson@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
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

We now implement all of the components of MTE, without actually
supporting any tagged memory.  All MTE instructions will work,
trivially, so we can enable support.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c   | 10 ++++++++++
 target/arm/cpu64.c |  1 +
 2 files changed, 11 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2399c14471..12fffa3ee4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -209,6 +209,16 @@ static void arm_cpu_reset(CPUState *s)
          * make no difference to the user-level emulation.
          */
         env->cp15.tcr_el[1].raw_tcr = (3ULL << 37);
+        /* Enable MTE allocation tags.  */
+        env->cp15.hcr_el2 |= HCR_ATA;
+        env->cp15.scr_el3 |= SCR_ATA;
+        env->cp15.sctlr_el[1] |= SCTLR_ATA0;
+        /* Enable synchronous tag check failures.  */
+        env->cp15.sctlr_el[1] |= 1ull << 38;
+#ifdef TARGET_AARCH64
+        /* Set MTE seed to non-zero value, otherwise RandomTag fails.  */
+        env->cp15.rgsr_el1 = 0x123400;
+#endif
 #else
         /* Reset into the highest available EL */
         if (arm_feature(env, ARM_FEATURE_EL3)) {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index d7f5bf610a..ac1e2dc2c4 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -350,6 +350,7 @@ static void aarch64_max_initfn(Object *obj)
 
         t = cpu->isar.id_aa64pfr1;
         t = FIELD_DP64(t, ID_AA64PFR1, BT, 1);
+        t = FIELD_DP64(t, ID_AA64PFR1, MTE, 2);
         cpu->isar.id_aa64pfr1 = t;
 
         t = cpu->isar.id_aa64mmfr1;
-- 
2.17.1



Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3109C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E7662073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wHr8YC4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7662073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j587K-0007xl-P2
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582G-0006ou-6T
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582F-0002jX-3j
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:04 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:45251)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582E-0002ho-Td
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:03 -0500
Received: by mail-wr1-x435.google.com with SMTP id g3so1977739wrs.12
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=WKYx4GPNYSXdP+wNoi6Rt9rVKRj/zD7o674eYcMYUY8=;
 b=wHr8YC4Ixy2MsWtlzAbJCt18Nsr2mwCKKb6VbSL87eHNEPDNf3MOddWEJmbsaUWq0p
 bUnylDfLLBJRzwIAXDytqNyuy6Yi/JRZzb9zDq06GcVvQVfxfUVRQwaQHCxRojIV9UZV
 wd5+dV3AIFOKvhbJvRzR1NdBZGR9I3a6f5xm7EBinIZw0Oop0171Q2X+iW4B/VEodqaS
 8yT7ZkiZwqX39bafNmcVfF76A/ora0LDhYy4f+IyvDUx+x9JkGjRlmrdUxCjfjvRUrEl
 qnFDIoQ8U92lBsLOau3EI9i5qhdFZkLPYLMMO0BrnH5/eICl99q4zHERJfD+7FVhkV5x
 pMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WKYx4GPNYSXdP+wNoi6Rt9rVKRj/zD7o674eYcMYUY8=;
 b=uTMYtBjVvh8e+WbRXZ0h5e0pk9fJ3+3M2PZcwD8odiKEx0rZbrxZDN0HtM2FH7eb+Q
 6dciy7YcwQDJKDPphHFF6rm3UKOrmFQ8EdADZVfi2g3m2hA9KeEkoVPjSIwMxLaVYg2C
 LEpCrWCFFJHpM4gctqFQI3eM/e7NcoJ6hvIUyifsiIepfTiBdtWcLhRW3pRLVMhcUBLg
 lQnuymT5LMpPKZ80Vyn6KmjSAp2wWmrSHWKKw0FEr6RWYdspqxJedCq4xmgNZf21kCYC
 iPSLemZlTOjADtIyJvZBfoclxInJDvbU5V9cmJqgPmVvHq6jj5/s6ZFsf7l3lgsWnOCX
 6K4g==
X-Gm-Message-State: APjAAAXWbF1oxNB6Psu9Hg6Fh8fHfx/mUmN9ptnVAG/yCa310Lvhjs/B
 WyB6CT4slWHGFoApLoysPSlnEO0JxslDDQ==
X-Google-Smtp-Source: APXvYqxYNfVFmAVZN9K4IgzF85pR7GqGQZFLChMg2EykQugmshFaAas27xDyI2x/gpqsLn+OhC7NYw==
X-Received: by 2002:a5d:55d2:: with SMTP id i18mr46938212wrw.287.1582290481174; 
 Fri, 21 Feb 2020 05:08:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.07.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/52] target/arm: Check aa32_pan in take_aarch32_exception(),
 not aa64_pan
Date: Fri, 21 Feb 2020 13:07:03 +0000
Message-Id: <20200221130740.7583-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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

In take_aarch32_exception(), we know we are dealing with a CPU that
has AArch32, so the right isar_feature test is aa32_pan, not aa64_pan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200214175116.9164-3-peter.maydell@linaro.org
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9c02d5d6b8e..ad2bfa9ef83 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8858,7 +8858,7 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
         env->elr_el[2] = env->regs[15];
     } else {
         /* CPSR.PAN is normally preserved preserved unless...  */
-        if (cpu_isar_feature(aa64_pan, env_archcpu(env))) {
+        if (cpu_isar_feature(aa32_pan, env_archcpu(env))) {
             switch (new_el) {
             case 3:
                 if (!arm_is_secure_below_el3(env)) {
-- 
2.20.1



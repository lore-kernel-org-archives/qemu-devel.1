Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9ECC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29225206A2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I0PMN74Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29225206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxZ7-0000KW-D2
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:20:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCk-0004XN-0C
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCi-0000N6-J3
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:05 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCi-0000Hf-C3
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:04 -0500
Received: by mail-pl1-x641.google.com with SMTP id p9so586159plk.9
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=47cVy0hqEAMv3Vw0sowdk1lwNWBNZcow7HnX+kqWQog=;
 b=I0PMN74QX8YKAideovtud78B/mmx1V0afCiAs48L0qR3IhdK/tg6zIt9HK28LyMTot
 adiLSME/LqU73M2qDlZ05swbc9yo2bq8E3M6FegykSd5U+Rw1JYtW5Bhi9Hyz8MZBwyY
 M7Goyv59WAnIpkWV7Ib2KL3uLvEdD/cmxXGVvighOtKn3Bqj2TIwRWoZRJBnIWrLoXKS
 LNgBIK8hheI6/RHPuIHcCxgvUphAP3YlV972LTLSxPtIuaYVHITf99mk4ikn95h5WH0w
 pTK7T5J5eL8v3EAMy5dwgw5T4K2qBfz77NbgC+BQnitK6Y0UT4fJSbo+/6lVsVvYoSSj
 JLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=47cVy0hqEAMv3Vw0sowdk1lwNWBNZcow7HnX+kqWQog=;
 b=LoJrngawNvYzHFE00KsGjkQP1rbLfUdjsOuMqlQcbUPVuR2upH8HGeK7lwHciUqfXj
 GR8xnL61qQHLGXEGDkIap2hZiLPh8j5DkplvGTABC9NIQ+XdBbMd97d7smvnFBSCMmhw
 R/lOaMrVPMrCUZOYdm9D+7q77wUKM9xp1BHyNAK3qxkxVYdeNP0Exc3wSO+OTnUvCm+z
 lyMt4WR13Z0+dGNes+MT447DHeyv3Ldiohlf2uL6Zo2Dtcvt+zkxvsC58U5KFoqPuQFO
 qV6hhe9YTCHlAFl7gCSkFtTQ7tZ1nACXLFfnSN/PNVpJnZphp/h8+qNO4mTOpU7vkeyX
 apPw==
X-Gm-Message-State: APjAAAVH1dMdPf4XmnfQqI84lgkZ5ezhOQ8oPdO4kkIOTOhneS46tgHz
 9S/VYczp7amxLtmzeS6wSOJ5NTkfDVc=
X-Google-Smtp-Source: APXvYqx0WzVeEPGXCOSLCQN9kzyNAKxA7W5BlqufqhHIMQ6o9+LJLSUpkmfCA6DZMO/HrtUxxDAWKQ==
X-Received: by 2002:a17:902:680c:: with SMTP id
 h12mr1939230plk.102.1580342219398; 
 Wed, 29 Jan 2020 15:56:59 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 34/41] target/arm: check TGE and E2H flags for EL0 pauth
 traps
Date: Wed, 29 Jan 2020 15:56:07 -0800
Message-Id: <20200129235614.29829-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

According to ARM ARM we should only trap from the EL1&0 regime.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/pauth_helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index e0c401c4a9..9746e32bf8 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -371,7 +371,10 @@ static void pauth_check_trap(CPUARMState *env, int el, uintptr_t ra)
     if (el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
         uint64_t hcr = arm_hcr_el2_eff(env);
         bool trap = !(hcr & HCR_API);
-        /* FIXME: ARMv8.1-VHE: trap only applies to EL1&0 regime.  */
+        if (el == 0) {
+            /* Trap only applies to EL1&0 regime.  */
+            trap &= (hcr & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE);
+        }
         /* FIXME: ARMv8.3-NV: HCR_NV trap takes precedence for ERETA[AB].  */
         if (trap) {
             pauth_trap(env, 2, ra);
-- 
2.20.1



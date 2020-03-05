Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C5AC3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F98A20637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5g94zAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F98A20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tVk-0007TI-5x
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tOv-0003Gx-42
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tOt-00026N-S2
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:09 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:39801)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tOt-00025Y-LF
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:07 -0500
Received: by mail-wr1-x436.google.com with SMTP id y17so7802676wrn.6
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=1ef+BYDS8rTe5i0BI9ywJQpdyAoxyoAQZCX8XvfU9aI=;
 b=V5g94zARXCWjtrHWfE9gIuQpbY1ZKvJcCm4ihRaOFXNd6Cxd2Zv+6gQPa38Bq7Oehs
 BnTQAX/Pi7vyekCZyIuVpoVldvn+iaWr23ZDoEXQVk0YtVMTl3c3YnNN5cP8nyWNWunL
 1s1gMo4zMaVVfbwDRvgBcXnmnnTIqOrmVvJQW4kp8+uETQB9xdn3iqlYM6W+A2StHaYT
 TrL2OkaXue6rbTa4TErZ/00/8kFVgaixhsMK30c96GgNg5gQ3B5AgEI+SDNir/QcDqNG
 w3J0xXIs+x1iAsHs+e0KjJyrkrmb5xlQUarWDyw6gBvt67hEyIoTqkj9Kb1BH/5YzGRM
 1evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1ef+BYDS8rTe5i0BI9ywJQpdyAoxyoAQZCX8XvfU9aI=;
 b=avTuGDnYFvxvXnhK2rNBf8+oQf3zuPXrBylS9N49RiqJl+11QgBWimRJg4FiiE0ru/
 hmpUm1Rf6rGyie+elFVCnfHytH1cSHMSWCIs8avIZo22p7m2a+hqaMnDjmAgcwrol8Cx
 TyMd3lf4Fz6O7uE28Wy4ShbyTjE7t8C1V3ZnXrgyqAZF2LAJgfo8MBuW9g7DalLWxkUQ
 31REvxNUpAnx7fThZwBJTuDpwh8Zr9fYm8Ahm9GJ0GQeAEjftfGQj/fSYpZd6EzLDNTs
 /9zXzUW2A2whlexLAi8PsEkXmYmWJK3N/K5Hke5Ww3bQPWBGUa3wHn77oJpHNWa6+72l
 0+ow==
X-Gm-Message-State: ANhLgQ2klPo8TpGdM6NbBP6fnGgNPwsc399eqPLOH26YiwV1uogx6GSV
 VPcKyBqnobIwF7ziI7paCys5+eXFL44Qmg==
X-Google-Smtp-Source: ADFU+vsLGq40XEGFIxc6tct9GkXAyKJ7azS8wlp649g8+b8+oGYtDg3pQ/y1mcssALeN0uQpq2HE+Q==
X-Received: by 2002:adf:b345:: with SMTP id k5mr11656251wrd.55.1583425866143; 
 Thu, 05 Mar 2020 08:31:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/37] target/arm: Implement (trivially) ARMv8.2-TTCNP
Date: Thu,  5 Mar 2020 16:30:26 +0000
Message-Id: <20200305163100.22912-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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

The ARMv8.2-TTCNP extension allows an implementation to optimize by
sharing TLB entries between multiple cores, provided that software
declares that it's ready to deal with this by setting a CnP bit in
the TTBRn_ELx.  It is mandatory from ARMv8.2 onward.

For QEMU's TLB implementation, sharing TLB entries between different
cores would not really benefit us and would be a lot of work to
implement.  So we implement this extension in the "trivial" manner:
we allow the guest to set and read back the CnP bit, but don't change
our behaviour (this is an architecturally valid implementation
choice).

The only code path which looks at the TTBRn_ELx values for the
long-descriptor format where the CnP bit is defined is already doing
enough masking to not get confused when the CnP bit at the bottom of
the register is set, so we can simply add a comment noting why we're
relying on that mask.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200225193822.18874-1-peter.maydell@linaro.org
---
 target/arm/cpu.c    | 1 +
 target/arm/cpu64.c  | 2 ++
 target/arm/helper.c | 4 ++++
 3 files changed, 7 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e6016e33cec..de00a45e903 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2702,6 +2702,7 @@ static void arm_max_initfn(Object *obj)
             t = cpu->isar.id_mmfr4;
             t = FIELD_DP32(t, ID_MMFR4, HPDS, 1); /* AA32HPD */
             t = FIELD_DP32(t, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
+            t = FIELD_DP32(t, ID_MMFR4, CNP, 1); /* TTCNP */
             cpu->isar.id_mmfr4 = t;
         }
 #endif
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index b842e2b664a..62d36f9e8d3 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -677,6 +677,7 @@ static void aarch64_max_initfn(Object *obj)
 
         t = cpu->isar.id_aa64mmfr2;
         t = FIELD_DP64(t, ID_AA64MMFR2, UAO, 1);
+        t = FIELD_DP64(t, ID_AA64MMFR2, CNP, 1); /* TTCNP */
         cpu->isar.id_aa64mmfr2 = t;
 
         /* Replicate the same data to the 32-bit id registers.  */
@@ -704,6 +705,7 @@ static void aarch64_max_initfn(Object *obj)
         u = cpu->isar.id_mmfr4;
         u = FIELD_DP32(u, ID_MMFR4, HPDS, 1); /* AA32HPD */
         u = FIELD_DP32(u, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
+        u = FIELD_DP32(t, ID_MMFR4, CNP, 1); /* TTCNP */
         cpu->isar.id_mmfr4 = u;
 
         u = cpu->isar.id_aa64dfr0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6be9ffa09ef..4eaf7333c7b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10591,6 +10591,10 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
 
     /* Now we can extract the actual base address from the TTBR */
     descaddr = extract64(ttbr, 0, 48);
+    /*
+     * We rely on this masking to clear the RES0 bits at the bottom of the TTBR
+     * and also to mask out CnP (bit 0) which could validly be non-zero.
+     */
     descaddr &= ~indexmask;
 
     /* The address field in the descriptor goes up to bit 39 for ARMv7
-- 
2.20.1



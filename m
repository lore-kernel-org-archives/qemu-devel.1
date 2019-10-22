Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF8DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872CE2184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ChjA06Mj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872CE2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuXN-0005ao-Et
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGt-0002nI-UP
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGs-0001LE-Mb
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41525)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuGs-0001KB-GO
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id p4so18098506wrm.8
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=BWBhqaHT6GxtdOFufe6tBUWH35ddd8XEs+xAm5zDJYo=;
 b=ChjA06Mjs77Lz1pNn0SauLjs1aNQ4JlOWfXdPWOxYMxPaC3f1hG4QBSQwiSv89s6Ns
 PmA9rhairAiLrO6KATD/8MwYWwDOvowWnIOuusVfzEDMar3mHOP9aEhkFQb5kKASpGhR
 qXYrblqelxnL5ecg+MiojmmoOpoYulafafUOqM92/X5K2HXoOH9odlkcsvYYiV5SIWeA
 kz7RsP0PqMUSyUiZIOP5pXJU5yrmWGZFZY9yyYOKWRjR715h9kPlKz4SujpjRd0nTG4/
 iSPVLwRB4O0yruGRz01qDzeY1yQtnpDTXCnN5SKxN1qrWKaLPEMzszRIIMDyqc5yNYAF
 VPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BWBhqaHT6GxtdOFufe6tBUWH35ddd8XEs+xAm5zDJYo=;
 b=khthkiMPS+hIQrgazLjeHCvY3eueO6kHzqGDTL1DQ8uBOMTkBdC2ezg7k3kgr+hzfs
 J+THjL0bmVd9Ifs7si539i5A/9Ti9R4Gg0JKmjozJ9z64AKRenOVbI+P7ooQZdn8Y3Dm
 Zahpjb5z03jKSeHbBr+nlKQ0cadgk6Fyqvgo3A9xCSrxlCDn4qMd2vGy14A67ETdirRj
 4MbnH5ZJ2B9oBb3oX+ktlbrshEzqyWum1x60ryvSm7KBd70GrqO+iUTrHDy3ObFkaOkN
 ZgnQzrl8uijURkK4YZxdcmcW5Kes2IciDQgv17n31DVEwfoPQIwqkVDLger9yaqEzUMb
 0X8w==
X-Gm-Message-State: APjAAAUayxIDPIC9MeIQefS/JlHmLPjpcArjqpiKijhlkc9H6xkK1e84
 azq4jn5Tnj7iO2wGtwn4gEkFIpF3yG8=
X-Google-Smtp-Source: APXvYqzkREi5mBGFv1E8nESnaqAyu8EIpiN2Qo4/RK6TRUJOhMcuCx+F3f0xL1knMlklyenrX2fK6A==
X-Received: by 2002:adf:e9c7:: with SMTP id l7mr3573891wrn.57.1571751141024;
 Tue, 22 Oct 2019 06:32:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.32.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:32:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/41] target/arm: Split out rebuild_hflags_aprofile
Date: Tue, 22 Oct 2019 14:31:11 +0100
Message-Id: <20191022133134.14487-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

From: Richard Henderson <richard.henderson@linaro.org>

Create a function to compute the values of the TBFLAG_ANY bits
that will be cached, and are used by A-profile.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191018174431.1784-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d1cd54cc931..ddd21edfcf1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11106,18 +11106,28 @@ static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
+static uint32_t rebuild_hflags_aprofile(CPUARMState *env)
+{
+    int flags = 0;
+
+    flags = FIELD_DP32(flags, TBFLAG_ANY, DEBUG_TARGET_EL,
+                       arm_debug_target_el(env));
+    return flags;
+}
+
 static uint32_t rebuild_hflags_a32(CPUARMState *env, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
-    return rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+    uint32_t flags = rebuild_hflags_aprofile(env);
+    return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
 static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
+    uint32_t flags = rebuild_hflags_aprofile(env);
     ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
     ARMVAParameters p0 = aa64_va_parameters_both(env, 0, stage1);
-    uint32_t flags = 0;
     uint64_t sctlr;
     int tbii, tbid;
 
@@ -11262,12 +11272,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         }
     }
 
-    if (!arm_feature(env, ARM_FEATURE_M)) {
-        int target_el = arm_debug_target_el(env);
-
-        flags = FIELD_DP32(flags, TBFLAG_ANY, DEBUG_TARGET_EL, target_el);
-    }
-
     *pflags = flags;
     *cs_base = 0;
 }
-- 
2.20.1



Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EBBCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A266C21872
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yzPCQ5Yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A266C21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuVE-0003Ug-D7
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGj-0002bA-Dg
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGi-0001GX-6c
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:13 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34647)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuGi-0001GK-0S
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:12 -0400
Received: by mail-wm1-x343.google.com with SMTP id v3so4015437wmh.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=qHBbFwWpTe9roVO0og+7rDfMnZMMxLAZ2erc0L9NCXQ=;
 b=yzPCQ5Yq8nEOBeKJM0TAPSJi+P15qxM5/ZwxiA611iwg+Wn3HitkINS2Q9hfoZZozS
 LG/vvVSMdHkxnqr0AYugCqzMg17MhQ19KFx5yAvCjzLxQ+13hKcMuhYBLkMEjyu/V+4X
 Yj+ebfav5zg6GsqYkQ7yPHbGIodxHnf/7WXXMSWHP58DJofFKXNG/+TW8IWRAWojXLE8
 ltdK31IrzQ/XH5rjKlvyES3eKQ3tJke74uTqbw1SsQ0X+2hNJt3KxYMBOBLtlMdAn/iu
 XZHT6CKH/jguv089BTOuhziHTi6zgspxBd8cyg50y8H9acMp4yuMT7JqTns9dfsYJhcl
 6fQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qHBbFwWpTe9roVO0og+7rDfMnZMMxLAZ2erc0L9NCXQ=;
 b=WT7M1h55USJfI6Suo/UOuma3Z7QbIeYjTfVLDRoQ8oQqCpRAapW5PRilmLF/iRQBJz
 iacSKyElIZIC08h7TL7bCWUR7d6Zn9NneYFJYiHe0UsopdOcUQs1jlffIzTKUWXENoZX
 3zCDtdUlB5eahAQvyLVf3FW7ooKt5j8XVJgp/g5XN1TQ1iDRx0jUVAkUckwjKgpbVM2T
 3uSxd/vnu9diUKnBFABULxfd61cqdtGb4VAM11KNP9S/UXY77mgLNubMWsDSGYvkoKpZ
 +YeseW1sC5KjXvjsqKG8FroZtsbnYFVqt6ZNiHHvvp9Z83r5J1bvbaMo5lSy1qiorVwK
 5XzA==
X-Gm-Message-State: APjAAAUUSWDcFeZROPVOMhUb8/S1EC7EsI/iWsSEk868ahWT1KvlscD2
 Ai+ocmB7WZ5BLCM4QYYdM1O1x+oDmc8=
X-Google-Smtp-Source: APXvYqxwDvQmixuxTDGikJuy4A5MBJ2usHkkbP8LfOPGP0g6AB63jrp40DqYHFyefJPRwWsKoaHL2A==
X-Received: by 2002:a7b:c924:: with SMTP id h4mr3206806wml.46.1571751130503;
 Tue, 22 Oct 2019 06:32:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.32.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:32:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/41] target/arm: Split out rebuild_hflags_common_32
Date: Tue, 22 Oct 2019 14:31:06 +0100
Message-Id: <20191022133134.14487-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Create a function to compute the values of the TBFLAG_A32 bits
that will be cached, and are used by all profiles.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191018174431.1784-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 69da04786e8..f05d0424745 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11070,6 +11070,15 @@ static uint32_t rebuild_hflags_common(CPUARMState *env, int fp_el,
     return flags;
 }
 
+static uint32_t rebuild_hflags_common_32(CPUARMState *env, int fp_el,
+                                         ARMMMUIdx mmu_idx, uint32_t flags)
+{
+    flags = FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env));
+    flags = FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(env));
+
+    return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
+}
+
 static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
@@ -11141,7 +11150,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
     int current_el = arm_current_el(env);
     int fp_el = fp_exception_el(env, current_el);
-    uint32_t flags = 0;
+    uint32_t flags;
 
     if (is_a64(env)) {
         *pc = env->pc;
@@ -11151,12 +11160,11 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         }
     } else {
         *pc = env->regs[15];
+        flags = rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
         flags = FIELD_DP32(flags, TBFLAG_A32, VECLEN, env->vfp.vec_len);
         flags = FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE, env->vfp.vec_stride);
         flags = FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_bits);
-        flags = FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env));
-        flags = FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(env));
         if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
             || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)) {
             flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
@@ -11166,8 +11174,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             flags = FIELD_DP32(flags, TBFLAG_A32,
                                XSCALE_CPAR, env->cp15.c15_cpar);
         }
-
-        flags = rebuild_hflags_common(env, fp_el, mmu_idx, flags);
     }
 
     /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
-- 
2.20.1



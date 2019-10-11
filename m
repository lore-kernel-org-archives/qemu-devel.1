Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB475ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B00214E0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lU7J01XE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B00214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIxdv-0003mC-NC
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 12:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGx-0002db-Hk
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxGw-0007mj-Bw
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:07 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:34612)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIxGw-0007mL-8N
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:06 -0400
Received: by mail-yw1-xc44.google.com with SMTP id d192so3653768ywa.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Iin/3YIyrPimduLw1VgVV/RDqodmDq3TgBG1S+Tb+Mo=;
 b=lU7J01XEmy7MwlGMcLEal+OIpkx5U72IeW5sQlWZeUUQtC5BH2JLG+pYtkNuCPJxjO
 Yz/GRsQBIDXjb+YO17oID6BTV2CEolWF2Dm8AZE2kKbj4vxdgtHSNV7P9McwOyAhlGu/
 Z1JndOwbmAcUXggIo4tocmtf9kzatvQwqA4927qeMkFKrq5Qrw0jMhRWDYXPP1O5+hAT
 e4awSXVvlPTzqEeZhVXlT4Ck5ar3PbPpouryt2ROWj55gL4t/UsoRau2E+tu/2WYZrg0
 CxuEgKP+NUnNLaFkfDfzUQ94zHE5acyxLO3I6UpAg9edJsOsjRQJuAcpIsFC8MqTCkfB
 UYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Iin/3YIyrPimduLw1VgVV/RDqodmDq3TgBG1S+Tb+Mo=;
 b=WB4QeVt8XBb7UlQTevu5Z7+U/of9rLE7H0WFu305mkK0PZquPy+1OEl5xYFP0VWAEP
 yEY7gMLBbZb/elIUtuVT1GHo2rdsBgZz/QLBVd5rZCoOMb+6VgmpAlrjlFmHgIP16n88
 nol1rHTYfBtIUvbTuQsI1J25QrHYQovZmhhsA1UGAI+m96fvE8qjVQ2KWRhJzGJHn/G0
 RDGpabyC2BAaj0nPOiYXuTsTh/RyAIvlpnq2FYLXkl7ayZlYtgYdNoJyavSWI+fpziWD
 US6MM8OB1XMldVLHlD0jpSIsWm9nxQXEIWt9KgI081moeRxxKZMzFE2oQKW7yE0UbQUx
 aUSg==
X-Gm-Message-State: APjAAAV/SDCWVJ65XRnMqfoCvtKKwkakoWBnk/OXZHUa9xjM49PhB04n
 FdcRwC67W+PRrqhj4fJYUSqOWWhhkis=
X-Google-Smtp-Source: APXvYqzB2U7t4OwWDTLOQSrLtqH83asSKK/okmpAwye7ra1LpLdPxxtEIN68YMgAd96dWe7Nr9ctOw==
X-Received: by 2002:a81:441b:: with SMTP id r27mr2817947ywa.371.1570809365305; 
 Fri, 11 Oct 2019 08:56:05 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id d17sm2473139ywb.95.2019.10.11.08.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 08:56:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 15/20] target/arm: Add HELPER(rebuild_hflags_{a32, a64,
 m32})
Date: Fri, 11 Oct 2019 11:55:41 -0400
Message-Id: <20191011155546.14342-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011155546.14342-1-richard.henderson@linaro.org>
References: <20191011155546.14342-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This functions are given the mode and el state of the cpu
and writes the computed value to env->hflags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h |  4 ++++
 target/arm/helper.c | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 1fb2cb5a77..3d4ec267a2 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -90,6 +90,10 @@ DEF_HELPER_4(msr_banked, void, env, i32, i32, i32)
 DEF_HELPER_2(get_user_reg, i32, env, i32)
 DEF_HELPER_3(set_user_reg, void, env, i32, i32)
 
+DEF_HELPER_FLAGS_2(rebuild_hflags_m32, TCG_CALL_NO_RWG, void, env, int)
+DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
+DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, int)
+
 DEF_HELPER_1(vfp_get_fpscr, i32, env)
 DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 37424e3d4d..b2d701cf00 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11220,6 +11220,30 @@ void arm_rebuild_hflags(CPUARMState *env)
     env->hflags = rebuild_hflags_internal(env);
 }
 
+void HELPER(rebuild_hflags_m32)(CPUARMState *env, int el)
+{
+    int fp_el = fp_exception_el(env, el);
+    ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, el);
+
+    env->hflags = rebuild_hflags_m32(env, fp_el, mmu_idx);
+}
+
+void HELPER(rebuild_hflags_a32)(CPUARMState *env, int el)
+{
+    int fp_el = fp_exception_el(env, el);
+    ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, el);
+
+    env->hflags = rebuild_hflags_a32(env, fp_el, mmu_idx);
+}
+
+void HELPER(rebuild_hflags_a64)(CPUARMState *env, int el)
+{
+    int fp_el = fp_exception_el(env, el);
+    ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, el);
+
+    env->hflags = rebuild_hflags_a64(env, el, fp_el, mmu_idx);
+}
+
 void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
-- 
2.17.1



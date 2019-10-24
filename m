Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76EECA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916ED20650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CgF4v0w7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916ED20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgaV-0003IW-0k
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxn-0007Pi-Qr
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxm-0000oO-Kk
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:51 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:46187)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfxm-0000o5-Ee
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:50 -0400
Received: by mail-wr1-x42d.google.com with SMTP id n15so16009048wrw.13
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=QUTF96nfti+DI0q+OP0hhjq9ZudXZCCZu7o5L2KL3Xc=;
 b=CgF4v0w7Ch4pv6uqfAaj6aoEIUd1eYNcqDlUMirVC7/ePRFwlgmw7vlwpXtow6k0m9
 RFnZaVKO1S7rvTqS57CSIAzC90qXt13XZ/CGwP+PX+iR9KSpac93vmpFosRygwlxtypx
 E7IgCFvv89/2puDJdDS88oYU7L3dTkUCaV1ZAH5BEv9WPfKrShYGozepuSP311H3SfkQ
 90cOX1sZdAjkve8ONMDESzGS+74eOtejCAAT/G3sXtl2AnsafUMbC+k+rky9XEJUgpI3
 g3d5oNFlmwMiprB1OhxYYoLGCS/I3biYEAPL1ebIGb4pKD+zjZJZqFY1UyJdoCdQkIHQ
 qkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QUTF96nfti+DI0q+OP0hhjq9ZudXZCCZu7o5L2KL3Xc=;
 b=ijfJkfp8mnhjnHehY1wQaH7Joj+Ey6uZd+rPE4hGSH5OscCThVxsUlKhl1ixde4w4n
 1F+bFXIcHYl5i+KRPvDzK6vA+1e8NgHf04UEZhHCN9xWK1ZvPjsVuIogSKwX/FxkF0ZN
 lqW6QpX+AbNqZ+8yw9gnYaIS2VnQCY9xUToN8EDMDLg3pSJ8UMX6MHA457ssdsm6jjF8
 gt7U4B214QC18rhlEYE4O3V7llY5ieYf3FtMdjWrP3UyY2deHRNhslFJ76zcfMjvkLgW
 PE9+xAFuo7vaiane0yOiyb+e3+cJthvYhlUwECVpg68gNkugXR+d8AOyKu+jjN3pbG38
 aK5A==
X-Gm-Message-State: APjAAAXOhaLlYYmDJTBcBTXT9+2GgnjEuTts9S7UIFqYRYV8sGAq9IHI
 78dsGX4DWxfV2TvQ3Z+Yl3U7Rnz93Dc=
X-Google-Smtp-Source: APXvYqwYzIAoxBN/NwYshtdky3UYo2667QDCgMVf8+9FBBMXVrUztP8s6RdqG9G7JKPE2wCei+sEiQ==
X-Received: by 2002:a05:6000:4f:: with SMTP id
 k15mr4414830wrx.137.1571934468647; 
 Thu, 24 Oct 2019 09:27:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.27.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:27:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/51] target/arm: Add HELPER(rebuild_hflags_{a32, a64, m32})
Date: Thu, 24 Oct 2019 17:26:50 +0100
Message-Id: <20191024162724.31675-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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

This functions are given the mode and el state of the cpu
and writes the computed value to env->hflags.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191023150057.25731-16-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h |  4 ++++
 target/arm/helper.c | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 1fb2cb5a777..3d4ec267a2c 100644
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
index 37424e3d4dd..b2d701cf004 100644
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
2.20.1



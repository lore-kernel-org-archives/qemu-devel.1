Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769CDECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 19:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A9DE21848
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 19:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JcrQDLns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9DE21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLB86-00044b-Cg
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 15:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLAsA-0001ME-LU
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLAs8-0000zT-Uw
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:42 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36747)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLAs8-0000yl-Or
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:40 -0400
Received: by mail-pf1-x441.google.com with SMTP id y22so2221674pfr.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 11:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5TK2BjuSMMDdIP7qbR+6sWroGlmanOV91VZR8RZQmXE=;
 b=JcrQDLnsOHSe9OyD5Zy33o/NYsS5jm2PtO8t9wA+JNCeiNg/JNjUU/zTy9KXazvmhb
 JDz8qU5zMmSH5WHTefmctKIklYK1R1jN3JI5RVkCYedvhYV9+8r3hH70aQEdkXgrfdXY
 hhVvifhcN1p8omoFqNJfHooBdB3pu7wo6cV6bs9PQeBjUdQx+Xflm+0TPoRYlTt4nZrN
 x5vhKaaxlF4mzq3db994HFE75BE7Hj4WBDaXc/PYV8BcCVkDDhSt8/RnBY1f7QsNoaMK
 ETqjZj6jy6ljn/2UiVNogl2Z/bRaCl1TbttY9saqn1gFzVBomKQtN/eEv120/91dGkmu
 l5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5TK2BjuSMMDdIP7qbR+6sWroGlmanOV91VZR8RZQmXE=;
 b=bY60ndDXBlddLATuaxqGk5kXE0tog3Z2DP8fIX194oSm2upeTbW1Czaj3/MbAGHTTJ
 l1wscbkSQPr42PWjf092/wmaV72sA4b/m3vxOIQ4pfst1MubaNZdfwzw5htTFeMmfi9R
 LafeYTJ+CuHFZ/YgdHV6KX3Iua7/AvENZ5vkNsWWx3YsbE5AscTFS6SwqOaVf5tQJmAm
 QQqjFnqEwFPODinH1PlUb0tHzYoywW2HuV+zggwm65fgkQLiYL4feOJbh8Xih/8LOUxn
 xaEvmMaEMs5sxXFC+q9xaq6skA+ZECc8hnghHaZ32HSpxoTY+nBmp0fTG6tDlkki7EQp
 W5zg==
X-Gm-Message-State: APjAAAXSHq2xYDgwVdCqgPOxXvoVDcExu0WW3lDC5+18cU95TaZil1D5
 jfPIv/VtG8ahrYxMWzqya240wIYkZ2E=
X-Google-Smtp-Source: APXvYqybSN6DtjpQsxMfTau2T2/1g+b8I7mOUzw0J0WwpH+l/YGe0QKm3Cto0GUt6o80ICauEDPInQ==
X-Received: by 2002:a63:dd11:: with SMTP id t17mr5742808pgg.242.1571338299344; 
 Thu, 17 Oct 2019 11:51:39 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s97sm5009256pjc.4.2019.10.17.11.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 11:51:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 20/20] target/arm: Rely on hflags correct in
 cpu_get_tb_cpu_state
Date: Thu, 17 Oct 2019 11:51:10 -0700
Message-Id: <20191017185110.539-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017185110.539-1-richard.henderson@linaro.org>
References: <20191017185110.539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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

This is the payoff.

From perf record -g data of ubuntu 18 boot and shutdown:

BEFORE:

-   23.02%     2.82%  qemu-system-aar  [.] helper_lookup_tb_ptr
   - 20.22% helper_lookup_tb_ptr
      + 10.05% tb_htable_lookup
      - 9.13% cpu_get_tb_cpu_state
           3.20% aa64_va_parameters_both
           0.55% fp_exception_el

-   11.66%     4.74%  qemu-system-aar  [.] cpu_get_tb_cpu_state
   - 6.96% cpu_get_tb_cpu_state
        3.63% aa64_va_parameters_both
        0.60% fp_exception_el
        0.53% sve_exception_el

AFTER:

-   16.40%     3.40%  qemu-system-aar  [.] helper_lookup_tb_ptr
   - 13.03% helper_lookup_tb_ptr
      + 11.19% tb_htable_lookup
        0.55% cpu_get_tb_cpu_state

     0.98%     0.71%  qemu-system-aar  [.] cpu_get_tb_cpu_state

     0.87%     0.24%  qemu-system-aar  [.] rebuild_hflags_a64

Before, helper_lookup_tb_ptr is the second hottest function in the
application, consuming almost a quarter of the runtime.  Within the
entire execution, cpu_get_tb_cpu_state consumes about 12%.

After, helper_lookup_tb_ptr has dropped to the fourth hottest function,
with consumption dropping to a sixth of the runtime.  Within the
entire execution, cpu_get_tb_cpu_state has dropped below 1%, and the
supporting function to rebuild hflags also consumes about 1%.

Assertions are retained for --enable-debug-tcg.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Retain asserts for future debugging.
---
 target/arm/helper.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index aae7b62458..c3e3dd2c41 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11249,12 +11249,15 @@ void HELPER(rebuild_hflags_a64)(CPUARMState *env, int el)
 void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
-    uint32_t flags, pstate_for_ss;
+    uint32_t flags = env->hflags;
+    uint32_t pstate_for_ss;
 
     *cs_base = 0;
-    flags = rebuild_hflags_internal(env);
+#ifdef CONFIG_DEBUG_TCG
+    assert(flags == rebuild_hflags_internal(env));
+#endif
 
-    if (is_a64(env)) {
+    if (FIELD_EX32(flags, TBFLAG_ANY, AARCH64_STATE)) {
         *pc = env->pc;
         if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
             flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
-- 
2.17.1



Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4C2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D05EA20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YX2/l1yY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05EA20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFDX-0004Xg-15
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF55-0001Lp-2k
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:03 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF53-0007Tp-2e
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:02 -0400
Received: by mail-wm1-x343.google.com with SMTP id r15so3871597wmh.5
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AhFkiGFNXdst6Xbi7nbMnw/kboTQarT4OU0u4/cvDkU=;
 b=YX2/l1yY+lY0w6SdYempW6wtkUJVCVhyvNDxltxec/OgDv83sra5Au5Y8+q3WJ728J
 sX7erYahfTsS8J1Gt5faQfL7dk9WH8YIlrHyMJNlR2rohySaQQgx8Ozodck8NRU55dn4
 XtfqASHTD5pnfagh8f2wkLu2V7F1jS2vJ8JLRKkAEUSi73QCOHD8xFhSzest6bi6suyQ
 yuXqp/sVeK03G2Cko+eJ5QS2+JUBOhXY6uDkVUgVH6vV01KU2kXVJFkgPNxMybvkdUW0
 82UU3W/f2a+TWXwo5nyfGaq2CLk3sRlrAq6IJj1qk7QEK6Zyvk3p8Lusw6MhY1ZFACcp
 isyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AhFkiGFNXdst6Xbi7nbMnw/kboTQarT4OU0u4/cvDkU=;
 b=CKPrbtKQMiA0/XXWL9uSj7punQQZR0GsOPxXsYwCi2z8/uOQtA1qd22JPKj/fq9ymq
 GuQ5neEyJl84cl/6GrOkMtrFTvAdYU3FFiM36LqkrrOBrbGhFGRydvTvORSWLDNZ279e
 +cpLgoDgkc/kAzZCQx4D92Ja/2vzf2RtYdiW8T42lF406rvWgji9w8cnxBeuMKiU6EnB
 e3K9R2OIyyY/3zPdPLqpkfYGgYvqn8WYZ5KEJ8P36vEwZ8S6KzOY+xjFclLHMaECbB4Z
 D2ju/KutK5p9OoCozlITKgqmhZJP1pmhI0wPxBJBOU8QNJAd6TnrKHVT6+77Dm1DCUi5
 qkPg==
X-Gm-Message-State: AOAM533Soiywv6txiZyBWRXtBAFnPVcPK1XZsEXXr/2e1tJjdY3qxNr2
 cr4CCQd3enI3N9CtJ3lUAfTO/Q==
X-Google-Smtp-Source: ABdhPJwcYSj4iucJavVtSz4BkIXpldWL6WnRCdfVnqfeNKiDuX4Zrfu51PKon9hu2938J7xBoHMbwA==
X-Received: by 2002:a1c:60d6:: with SMTP id u205mr4462949wmb.163.1592327339742; 
 Tue, 16 Jun 2020 10:08:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y80sm5263216wmc.34.2020.06.16.10.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:08:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 09/21] target/arm: Rename NeonGenOneOpFn to NeonGenOne64OpFn
Date: Tue, 16 Jun 2020 18:08:32 +0100
Message-Id: <20200616170844.13318-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616170844.13318-1-peter.maydell@linaro.org>
References: <20200616170844.13318-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NeonGenOneOpFn typedef breaks with the pattern of the other
NeonGen*Fn typedefs, because it is a TCGv_i64 -> TCGv_i64 operation
but it does not have '64' in its name. Rename it to NeonGenOne64OpFn,
so that the old name is available for a TCGv_i32 -> TCGv_i32 operation
(which we will need in a subsequent commit).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.h     | 2 +-
 target/arm/translate-a64.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 62ed5c4780c..35218b3fdf1 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -374,7 +374,7 @@ typedef void NeonGenWidenFn(TCGv_i64, TCGv_i32);
 typedef void NeonGenTwoOpWidenFn(TCGv_i64, TCGv_i32, TCGv_i32);
 typedef void NeonGenTwoSingleOPFn(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
 typedef void NeonGenTwoDoubleOPFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr);
-typedef void NeonGenOneOpFn(TCGv_i64, TCGv_i64);
+typedef void NeonGenOne64OpFn(TCGv_i64, TCGv_i64);
 typedef void CryptoTwoOpFn(TCGv_ptr, TCGv_ptr);
 typedef void CryptoThreeOpIntFn(TCGv_ptr, TCGv_ptr, TCGv_i32);
 typedef void CryptoThreeOpFn(TCGv_ptr, TCGv_ptr, TCGv_ptr);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index a0e72ad6942..7cb5fbfba80 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11917,8 +11917,8 @@ static void handle_2misc_pairwise(DisasContext *s, int opcode, bool u,
     } else {
         for (pass = 0; pass < maxpass; pass++) {
             TCGv_i64 tcg_op = tcg_temp_new_i64();
-            NeonGenOneOpFn *genfn;
-            static NeonGenOneOpFn * const fns[2][2] = {
+            NeonGenOne64OpFn *genfn;
+            static NeonGenOne64OpFn * const fns[2][2] = {
                 { gen_helper_neon_addlp_s8,  gen_helper_neon_addlp_u8 },
                 { gen_helper_neon_addlp_s16,  gen_helper_neon_addlp_u16 },
             };
-- 
2.20.1



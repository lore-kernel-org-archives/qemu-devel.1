Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8834CC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E7420FC3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IIdj+w3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E7420FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8Ak-0005O6-GB
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83L-0007Hp-MQ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:31 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:34047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83J-00069c-4e
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:31 -0400
Received: by mail-wr1-x434.google.com with SMTP id t10so1140665wrv.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=DxK53YpFTp+YktfbiVN38wkS45bmg8hIgJqiRfg6/KA=;
 b=IIdj+w3ffqoS+vYLz9SRmSRqTIH5E/LGITcl5wyVKUY1uqrUhNL+OIUvJhvUsxT+2O
 8glYKkaTubwhHtn2NF5uPtVtvvtkSUoEi497r78t/iCU5BBUNWaBycaXOeOl9tCQUBj0
 fCeY1K/4/gqwwf9Ja73WQce20fSz0PjK9KKOkUFu4y8GpMlaa2UbwoE37ZM/RsmOBfWS
 he1IWo3izkg6G89NSDFcDNB/OAcUqhQ3IYaPIuDZxMHANBuEmiDKtNqKj61cYvq78IqC
 j3FIxglWJoCQPfQNa5ZWJVTnj/WzSGVP3OYjKZX5Xf8bWXSgG4nmociNkSTLDSlkPiaD
 qhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DxK53YpFTp+YktfbiVN38wkS45bmg8hIgJqiRfg6/KA=;
 b=oX0ZmAiSJq4VIerFvxADcnt4u5SaT/rTKH0olg4OUOXOc+U4sfGBjuvSKpLcy1CZGd
 mGaa4ingWToNRkclrAmz+GtyFLhQIr+BvyM2StHpBY2zWIC1pqLcZn1BS/qI2M1kh1J+
 I+zbSGWHuXKgAlGkVsnKThCVp2VSYQnPaG5/TYuFlr6WGOomIs2bRL0s5WHHwBrARvd/
 3a0smpEZ7qKrR4fU4RqQTG4n6r2ENCNoAuyvSAk9ZAu1/i6m39F70UihTfpWJWc/9JWa
 0epYfmJSI5AbSdxuPU3qcBlz2LwHOyLQ0aWVAuqaaMuA9oAdVZhG7iY+fwoSoMp0gH4u
 /zbg==
X-Gm-Message-State: AOAM533X53W/5HhDm7B/kz9UsU7TTmka2KJc54TNMt4xbIy2HAR8tRTV
 VbKbdNCS7MZaZMTawjllwaqU2F2NrOYVlpYQ
X-Google-Smtp-Source: ABdhPJy3FKKrIHWl/hXFxU+wq4gvhqabP9fRoFQF3iwzp91TzdyFhhHzZ26fNpJ3lrfqMzR89C2EMA==
X-Received: by 2002:adf:8187:: with SMTP id 7mr2485014wra.266.1598973506831;
 Tue, 01 Sep 2020 08:18:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.18.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:18:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/47] target/arm: Remove local definitions of float constants
Date: Tue,  1 Sep 2020 16:17:37 +0100
Message-Id: <20200901151823.29785-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In several places the target/arm code defines local float constants
for 2, 3 and 1.5, which are also provided by include/fpu/softfloat.h.
Remove the unnecessary local duplicate versions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-2-peter.maydell@linaro.org
---
 target/arm/helper-a64.c    | 11 -----------
 target/arm/translate-sve.c |  4 ----
 target/arm/vfp_helper.c    |  4 ----
 3 files changed, 19 deletions(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 8682630ff6c..030821489b3 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -234,17 +234,6 @@ uint64_t HELPER(neon_cgt_f64)(float64 a, float64 b, void *fpstp)
  * versions, these do a fully fused multiply-add or
  * multiply-add-and-halve.
  */
-#define float16_two make_float16(0x4000)
-#define float16_three make_float16(0x4200)
-#define float16_one_point_five make_float16(0x3e00)
-
-#define float32_two make_float32(0x40000000)
-#define float32_three make_float32(0x40400000)
-#define float32_one_point_five make_float32(0x3fc00000)
-
-#define float64_two make_float64(0x4000000000000000ULL)
-#define float64_three make_float64(0x4008000000000000ULL)
-#define float64_one_point_five make_float64(0x3FF8000000000000ULL)
 
 uint32_t HELPER(recpsf_f16)(uint32_t a, uint32_t b, void *fpstp)
 {
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 15ad6c7d323..e4cd6b62517 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3803,10 +3803,6 @@ static bool trans_##NAME##_zpzi(DisasContext *s, arg_rpri_esz *a)         \
     return true;                                                          \
 }
 
-#define float16_two  make_float16(0x4000)
-#define float32_two  make_float32(0x40000000)
-#define float64_two  make_float64(0x4000000000000000ULL)
-
 DO_FP_IMM(FADD, fadds, half, one)
 DO_FP_IMM(FSUB, fsubs, half, one)
 DO_FP_IMM(FMUL, fmuls, half, two)
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 64266ece620..02ab8d7f2d8 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -582,10 +582,6 @@ uint32_t HELPER(vfp_fcvt_f64_to_f16)(float64 a, void *fpstp, uint32_t ahp_mode)
     return r;
 }
 
-#define float32_two make_float32(0x40000000)
-#define float32_three make_float32(0x40400000)
-#define float32_one_point_five make_float32(0x3fc00000)
-
 float32 HELPER(recps_f32)(CPUARMState *env, float32 a, float32 b)
 {
     float_status *s = &env->vfp.standard_fp_status;
-- 
2.20.1



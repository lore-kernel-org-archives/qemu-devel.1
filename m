Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5314FC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF30206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JevuJfS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF30206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUusE-0000c1-1Q
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kUue1-0007rV-JA
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:37:53 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kUudw-0000yr-GQ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:37:51 -0400
Received: by mail-wr1-x443.google.com with SMTP id n18so2977442wrs.5
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 09:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cI8HSGwWCnif3JZAlzq92xQoHYw4ZrAg/ruryZjOnLA=;
 b=JevuJfS8onUQ+xp4X9CVG/9Y3xqJwIGTUeQMQmRfqGoiGHiTtIMpdf72wp8OxM+D6d
 00r7QZLh20wJJTj8b+zbfvMdzTXTC+85r0W0O6uqal4US/U9IogVEoz2r7Cl7fZYR72Q
 AITvILNNt/mOVendPby/sIoQoY94MSSTO/bwTmzYpMfkJM16sPNB0D2CZdm4+XoY4Oyc
 s/1rQVI4Ub3Zt5TWnHho6ll/WTf8ZS2vFJt1wycjE8ibVlOovVJcHW8hWK+tKFKhWdM5
 pOAc3ZCXkFb9Qd6XKfxV6EZtEPnBhyCfXc/q1rtW0OgN7rsVuyO5cNuw07tfRvHDm6fH
 i63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cI8HSGwWCnif3JZAlzq92xQoHYw4ZrAg/ruryZjOnLA=;
 b=gCWDYCPuCf6m1l+KET46w7M/3wJw9tu/KRn1UnlQ7BGFFlOTPseZHKRblaVnVKxqal
 dG0ojKAEvippgvJcx8wVJ1vw/McW4ZaUIlkXfKAKbZRyvzTBXuEAZR8argH6cBCeBP9B
 HHSiNq2Kpdu5kFeuw937cRhAwIh52SLfdUoc8cvfqnUI6DWS9pbBFKHKpfUwJyORiUIl
 e2UmQmXW0Cbkk/DlV3HeBD2psmh/tgWAo1dP8yYyWtwYpNfbM7hM0fcDvOjmyzyyxOgR
 xqG8cjlCHRi9BRT1uLaI+1xGOUX41637a+bEtJ8kv8wVGejPO9TtQekOfIoOUMIzS5Tr
 jSTQ==
X-Gm-Message-State: AOAM530OHbM4QbXQiHo43WEthAzn1AGCZsed87dJ/cpMqMFgPtrgrl7F
 Hl0kTKfBY0vpHat3GjMV0HMLAg==
X-Google-Smtp-Source: ABdhPJzikJKbzedokXdIM7nQmKI5+50Boao2Sy/MZjmaE3JS1eG+u1aso49OA2K1f9TbcvfiBg4ddw==
X-Received: by 2002:adf:f104:: with SMTP id r4mr4533876wro.202.1603211867164; 
 Tue, 20 Oct 2020 09:37:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v123sm3071360wme.7.2020.10.20.09.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 09:37:42 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 984CC1FF90;
 Tue, 20 Oct 2020 17:37:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH  4/8] softfloat: Add float_cmask and constants
Date: Tue, 20 Oct 2020 17:37:34 +0100
Message-Id: <20201020163738.27700-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020163738.27700-1-alex.bennee@linaro.org>
References: <20201020163738.27700-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Testing more than one class at a time is better done with masks.
This reduces the static branch count.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200925152047.709901-5-richard.henderson@linaro.org>
---
 fpu/softfloat.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 9db55d2b11..3e625c47cd 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -469,6 +469,20 @@ typedef enum __attribute__ ((__packed__)) {
     float_class_snan,
 } FloatClass;
 
+#define float_cmask(bit)  (1u << (bit))
+
+enum {
+    float_cmask_zero    = float_cmask(float_class_zero),
+    float_cmask_normal  = float_cmask(float_class_normal),
+    float_cmask_inf     = float_cmask(float_class_inf),
+    float_cmask_qnan    = float_cmask(float_class_qnan),
+    float_cmask_snan    = float_cmask(float_class_snan),
+
+    float_cmask_infzero = float_cmask_zero | float_cmask_inf,
+    float_cmask_anynan  = float_cmask_qnan | float_cmask_snan,
+};
+
+
 /* Simple helpers for checking if, or what kind of, NaN we have */
 static inline __attribute__((unused)) bool is_nan(FloatClass c)
 {
@@ -1335,24 +1349,27 @@ bfloat16 QEMU_FLATTEN bfloat16_mul(bfloat16 a, bfloat16 b, float_status *status)
 static FloatParts muladd_floats(FloatParts a, FloatParts b, FloatParts c,
                                 int flags, float_status *s)
 {
-    bool inf_zero = ((1 << a.cls) | (1 << b.cls)) ==
-                    ((1 << float_class_inf) | (1 << float_class_zero));
-    bool p_sign;
+    bool inf_zero, p_sign;
     bool sign_flip = flags & float_muladd_negate_result;
     FloatClass p_class;
     uint64_t hi, lo;
     int p_exp;
+    int ab_mask, abc_mask;
+
+    ab_mask = float_cmask(a.cls) | float_cmask(b.cls);
+    abc_mask = float_cmask(c.cls) | ab_mask;
+    inf_zero = ab_mask == float_cmask_infzero;
 
     /* It is implementation-defined whether the cases of (0,inf,qnan)
      * and (inf,0,qnan) raise InvalidOperation or not (and what QNaN
      * they return if they do), so we have to hand this information
      * off to the target-specific pick-a-NaN routine.
      */
-    if (is_nan(a.cls) || is_nan(b.cls) || is_nan(c.cls)) {
+    if (unlikely(abc_mask & float_cmask_anynan)) {
         return pick_nan_muladd(a, b, c, inf_zero, s);
     }
 
-    if (inf_zero) {
+    if (unlikely(inf_zero)) {
         s->float_exception_flags |= float_flag_invalid;
         return parts_default_nan(s);
     }
@@ -1367,9 +1384,9 @@ static FloatParts muladd_floats(FloatParts a, FloatParts b, FloatParts c,
         p_sign ^= 1;
     }
 
-    if (a.cls == float_class_inf || b.cls == float_class_inf) {
+    if (ab_mask & float_cmask_inf) {
         p_class = float_class_inf;
-    } else if (a.cls == float_class_zero || b.cls == float_class_zero) {
+    } else if (ab_mask & float_cmask_zero) {
         p_class = float_class_zero;
     } else {
         p_class = float_class_normal;
-- 
2.20.1



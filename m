Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C073FC5517A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 05:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 108C821741
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 05:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xoHr+HPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108C821741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV6LV-0006zx-1r
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 01:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66f-0000rn-5U
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:52:13 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:32943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66d-0005m8-0A
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:52:12 -0400
Received: by mail-pl1-x641.google.com with SMTP id b19so596118pld.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 21:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/Q7lv4GqR2/SIM1b3yPymEDSrlpCY5Yq9u6Hd3MEusk=;
 b=xoHr+HPo9q1SYnCL5vPFZOV5gqkt3GS3ME38eufrXEnZoKsZQ1mHrWRaB/Odu8nupw
 jWF5TDp+ds/pd5jrhWgBcCpQzi0XNakvAiTG71QWINkYWxfHoNUa0hzxZExXL6eA0eR8
 5Fn8k+jBQKrG1L4BpnKkyM1qbwvgLVOPRn9NOz/PD/5fRdhKx0yIRNqmIlu1P+mjmT4W
 wsC4kJK4ncll56S3bGmsRRymnzstmDGcLd/TYALyleLA173H4Kkj3zI+GPysXTiQDY6s
 JLy633vjkTcwp2t3qpvTB8SZPVUObzXY8SSzAX51Xn8v4FVV0DG3LGVkfzJ4w2QXgEQU
 Cebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/Q7lv4GqR2/SIM1b3yPymEDSrlpCY5Yq9u6Hd3MEusk=;
 b=ZU4VMZrFdmzF6U4aABCtOM+0JOM4V5iZe9CEzv0VtPNa9y7gXYGx7XSNL0DuId7sEd
 QuDG9JA1C3krH9nxJ/4O8CvT5npGO0DXUWwF1HePkG+uOSSvR3sfeTWg0AezlCySrSXP
 lG20N63hRBiRQdMJWGfDfGuJExq3kVoAvHBd7mx4AjHK/qc0665AN5EIcBBXTD6IX2La
 rq/VC1+nHeZcvZyI6eMC62P4f5PfIb4vGYTVAKsnZwROQka10IlTjlB1eDeauGAe/EDf
 wEmHunptD8fAlZJ/khIWTHUm/aZ/o2k5+CK4BQlFGNFQ0SijVhBe+UVQkQLOxRLeTAsL
 K9DQ==
X-Gm-Message-State: AOAM531enXOMdxzb70ZQLEEMrdM7H7a/g/NoNx7FJhjUix0mMJqgjQGY
 VeE55gq53Qp5mfUOPLIKAXl8WG6Hok3LKw==
X-Google-Smtp-Source: ABdhPJwa9nKsULQXsvkSKlkZYKe+rlBghBDE2bEl2KJLT4Txnn9o0fOjeFodhzLZmEVBxqBzyJLZUw==
X-Received: by 2002:a17:90a:348e:: with SMTP id
 p14mr1474671pjb.75.1603255929391; 
 Tue, 20 Oct 2020 21:52:09 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j11sm620070pfh.143.2020.10.20.21.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 21:52:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 14/15] softfloat: Use float_cmask for addsub_floats
Date: Tue, 20 Oct 2020 21:51:48 -0700
Message-Id: <20201021045149.1582203-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021045149.1582203-1-richard.henderson@linaro.org>
References: <20201021045149.1582203-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Testing more than one class at a time is better done with masks.
Sort a few case combinations before the NaN check, which should
be assumed to be least probable.  Share the pick_nan call between
the add and subtract cases.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 70 +++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 49bde45521..d2b6454903 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -247,13 +247,13 @@ static PARTS_TYPE
 FUNC(addsub_floats)(PARTS_TYPE a, PARTS_TYPE b,
                     bool subtract, float_status *s)
 {
-    bool a_sign = a.sign;
     bool b_sign = b.sign ^ subtract;
+    int ab_mask = float_cmask(a.cls) | float_cmask(b.cls);
 
-    if (a_sign != b_sign) {
+    if (a.sign != b_sign) {
         /* Subtraction */
 
-        if (a.cls == float_class_normal && b.cls == float_class_normal) {
+        if (likely(ab_mask == float_cmask_normal)) {
             if (a.exp > b.exp || (a.exp == b.exp && GEU(a.frac, b.frac))) {
                 b.frac = SHR_JAM(b.frac, a.exp - b.exp);
                 a.frac = SUB(a.frac, b.frac);
@@ -261,7 +261,7 @@ FUNC(addsub_floats)(PARTS_TYPE a, PARTS_TYPE b,
                 a.frac = SHR_JAM(a.frac, b.exp - a.exp);
                 a.frac = SUB(b.frac, a.frac);
                 a.exp = b.exp;
-                a_sign ^= 1;
+                a.sign ^= 1;
             }
 
             if (EQ0(a.frac)) {
@@ -270,35 +270,37 @@ FUNC(addsub_floats)(PARTS_TYPE a, PARTS_TYPE b,
             } else {
                 int shift = CLZ(a.frac) - 1;
                 a.frac = SHL(a.frac, shift);
-                a.exp = a.exp - shift;
-                a.sign = a_sign;
+                a.exp -= shift;
             }
             return a;
         }
-        if (is_nan(a.cls) || is_nan(b.cls)) {
-            return FUNC(pick_nan)(a, b, s);
-        }
-        if (a.cls == float_class_inf) {
-            if (b.cls == float_class_inf) {
-                float_raise(float_flag_invalid, s);
-                return FUNC(parts_default_nan)(s);
-            }
-            return a;
-        }
-        if (a.cls == float_class_zero && b.cls == float_class_zero) {
+
+        /* 0 - 0 */
+        if (ab_mask == float_cmask_zero) {
             a.sign = s->float_rounding_mode == float_round_down;
             return a;
         }
-        if (a.cls == float_class_zero || b.cls == float_class_inf) {
-            b.sign = a_sign ^ 1;
-            return b;
+
+        /* Inf - Inf */
+        if (unlikely(ab_mask == float_cmask_inf)) {
+            float_raise(float_flag_invalid, s);
+            return FUNC(parts_default_nan)(s);
         }
-        if (b.cls == float_class_zero) {
-            return a;
+
+        if (!(ab_mask & float_cmask_anynan)) {
+            if (a.cls == float_class_inf || b.cls == float_class_zero) {
+                return a;
+            }
+            if (b.cls == float_class_inf || a.cls == float_class_zero) {
+                b.sign = a.sign ^ 1;
+                return b;
+            }
+            g_assert_not_reached();
         }
     } else {
         /* Addition */
-        if (a.cls == float_class_normal && b.cls == float_class_normal) {
+
+        if (likely(ab_mask == float_cmask_normal)) {
             if (a.exp > b.exp) {
                 b.frac = SHR_JAM(b.frac, a.exp - b.exp);
             } else if (a.exp < b.exp) {
@@ -312,16 +314,18 @@ FUNC(addsub_floats)(PARTS_TYPE a, PARTS_TYPE b,
             }
             return a;
         }
-        if (is_nan(a.cls) || is_nan(b.cls)) {
-            return FUNC(pick_nan)(a, b, s);
-        }
-        if (a.cls == float_class_inf || b.cls == float_class_zero) {
-            return a;
-        }
-        if (b.cls == float_class_inf || a.cls == float_class_zero) {
-            b.sign = b_sign;
-            return b;
+
+        if (!(ab_mask & float_cmask_anynan)) {
+            if (a.cls == float_class_inf || b.cls == float_class_zero) {
+                return a;
+            }
+            if (b.cls == float_class_inf || a.cls == float_class_zero) {
+                b.sign = b_sign;
+                return b;
+            }
+            g_assert_not_reached();
         }
     }
-    g_assert_not_reached();
+
+    return FUNC(pick_nan)(a, b, s);
 }
-- 
2.25.1



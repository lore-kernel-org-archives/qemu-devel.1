Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8220BC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87AB21D20
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WAB3sCo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87AB21D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLG4Y-0003Fk-00
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 21:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLG0R-0004wS-AI
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:25:07 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:42676)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLG0O-0005hz-Sg
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:25:06 -0400
Received: by mail-pf1-x42c.google.com with SMTP id d6so822775pfn.9
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 18:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=98iXaPYRLY+m1y4PoyF25H+hGcwsxS4GdvBUZnInWc0=;
 b=WAB3sCo+8HKLC2N/WUmOQHgeS1BJxs6WZhSgYBvu3wUqZGm0uh9Mj3lji+gS1+6yX2
 FgwTpYSqUia2OVUG23FByuOqNJJwBTVehj7FuYQc/ABsmiW+2M7f44FXzHnHIrCdtJPa
 bkJrDWUO73ea6BuHyo8BQKD+czDWD9st5121KqXOveQF1cNzUNlYhik8Zy4HhQk+Q6SY
 5qaZQN2EVmT5k0psrW9AEwibYr1yP3AaZw+uZZhxMd0MBcdnpKJQGNK2Ft8aV7RCdXCq
 SzJg1LMi8ep7TRIAXfYfKj5zoTBSKy7jX9AYebqE9lY4LC8gXIjxAuOJLubQAreILSO8
 TwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=98iXaPYRLY+m1y4PoyF25H+hGcwsxS4GdvBUZnInWc0=;
 b=VKdfrQKfX53XANnhsc+tPMTDh9MJLghTOvR8Lep+Rpo5W75eiYv1H5jHvLg9f6MH9e
 neA86/0gkfsx1N/uWpVJJLVqjbCN3vbATaJadPXdss8rKZzS91RH7qAQE0QCYtpa6ZAi
 TnzrsBntvknoCN4pQvjn67mHItNzcKClId1dDposdeSyhWAJvLmptJcqwzDxLWvKLG1n
 ib7iJTZF4z/DCgh4CEmtwy8Pkg5rAmc9bZ8BYbZvOBGDtwYlHmnkAbMNe/WI5CJANdhW
 WjadvO+3cb2XP7y8/kksl/Udxoze4Fjy4qFMrnl2eNMfZrfaAxOJ4CkRKpTQLdVykJOb
 lNmw==
X-Gm-Message-State: AOAM532HUO2Tb8X3hlWEfmQUmlqOUj6C3evVwTZXJZVa+xESgdliKEox
 K8Mo6O284gVUO98895MnCW07Oh0XekPsqA==
X-Google-Smtp-Source: ABdhPJzMybFSHt83rnDOLZL3l79NtHFGW9MsWyOOgpfn1knbRKQBjFNgnSbySV1mwZWG22NIgg6LQA==
X-Received: by 2002:a63:fd08:: with SMTP id d8mr2015949pgh.223.1600910702658; 
 Wed, 23 Sep 2020 18:25:02 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k27sm938432pgm.29.2020.09.23.18.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 18:25:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/8] softfloat: Implement float128_muladd
Date: Wed, 23 Sep 2020 18:24:51 -0700
Message-Id: <20200924012453.659757-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924012453.659757-1-richard.henderson@linaro.org>
References: <20200924012453.659757-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
Cc: bharata@linux.ibm.com, alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h |   2 +
 fpu/softfloat.c         | 356 +++++++++++++++++++++++++++++++++++++++-
 tests/fp/fp-test.c      |   2 +-
 tests/fp/wrap.c.inc     |  12 ++
 4 files changed, 370 insertions(+), 2 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 78ad5ca738..a38433deb4 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -1196,6 +1196,8 @@ float128 float128_sub(float128, float128, float_status *status);
 float128 float128_mul(float128, float128, float_status *status);
 float128 float128_div(float128, float128, float_status *status);
 float128 float128_rem(float128, float128, float_status *status);
+float128 float128_muladd(float128, float128, float128, int,
+                         float_status *status);
 float128 float128_sqrt(float128, float_status *status);
 FloatRelation float128_compare(float128, float128, float_status *status);
 FloatRelation float128_compare_quiet(float128, float128, float_status *status);
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index e038434a07..5b714fbd82 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -512,11 +512,19 @@ static inline __attribute__((unused)) bool is_qnan(FloatClass c)
 
 typedef struct {
     uint64_t frac;
-    int32_t  exp;
+    int32_t exp;
     FloatClass cls;
     bool sign;
 } FloatParts;
 
+/* Similar for float128.  */
+typedef struct {
+    uint64_t frac0, frac1;
+    int32_t exp;
+    FloatClass cls;
+    bool sign;
+} FloatParts128;
+
 #define DECOMPOSED_BINARY_POINT    (64 - 2)
 #define DECOMPOSED_IMPLICIT_BIT    (1ull << DECOMPOSED_BINARY_POINT)
 #define DECOMPOSED_OVERFLOW_BIT    (DECOMPOSED_IMPLICIT_BIT << 1)
@@ -4574,6 +4582,46 @@ static void
 
 }
 
+/*----------------------------------------------------------------------------
+| Returns the parts of floating-point value `a'.
+*----------------------------------------------------------------------------*/
+
+static void float128_unpack(FloatParts128 *p, float128 a, float_status *status)
+{
+    p->sign = extractFloat128Sign(a);
+    p->exp = extractFloat128Exp(a);
+    p->frac0 = extractFloat128Frac0(a);
+    p->frac1 = extractFloat128Frac1(a);
+
+    if (p->exp == 0) {
+        if ((p->frac0 | p->frac1) == 0) {
+            p->cls = float_class_zero;
+        } else if (status->flush_inputs_to_zero) {
+            float_raise(float_flag_input_denormal, status);
+            p->cls = float_class_zero;
+            p->frac0 = p->frac1 = 0;
+        } else {
+            normalizeFloat128Subnormal(p->frac0, p->frac1, &p->exp,
+                                       &p->frac0, &p->frac1);
+            p->exp -= 0x3fff;
+            p->cls = float_class_normal;
+        }
+    } else if (p->exp == 0x7fff) {
+        if ((p->frac0 | p->frac1) == 0) {
+            p->cls = float_class_inf;
+        } else if (float128_is_signaling_nan(a, status)) {
+            p->cls = float_class_snan;
+        } else {
+            p->cls = float_class_qnan;
+        }
+    } else {
+        /* Add the implicit bit. */
+        p->frac0 |= UINT64_C(0x0001000000000000);
+        p->exp -= 0x3fff;
+        p->cls = float_class_normal;
+    }
+}
+
 /*----------------------------------------------------------------------------
 | Packs the sign `zSign', the exponent `zExp', and the significand formed
 | by the concatenation of `zSig0' and `zSig1' into a quadruple-precision
@@ -7205,6 +7253,312 @@ float128 float128_mul(float128 a, float128 b, float_status *status)
 
 }
 
+static void shortShift256Left(uint64_t p[4], unsigned count)
+{
+    int negcount = -count & 63;
+
+    if (count == 0) {
+        return;
+    }
+    g_assert(count < 64);
+    p[0] = (p[0] << count) | (p[1] >> negcount);
+    p[1] = (p[1] << count) | (p[2] >> negcount);
+    p[2] = (p[2] << count) | (p[3] >> negcount);
+    p[3] = (p[3] << count);
+}
+
+static void shift256RightJamming(uint64_t p[4], int count)
+{
+    uint64_t in = 0;
+
+    g_assert(count >= 0);
+
+    count = MIN(count, 256);
+    for (; count >= 64; count -= 64) {
+        in |= p[3];
+        p[3] = p[2];
+        p[2] = p[1];
+        p[1] = p[0];
+        p[0] = 0;
+    }
+
+    if (count) {
+        int negcount = -count & 63;
+
+        in |= p[3] << negcount;
+        p[3] = (p[2] << negcount) | (p[3] >> count);
+        p[2] = (p[1] << negcount) | (p[2] >> count);
+        p[1] = (p[0] << negcount) | (p[1] >> count);
+        p[0] = p[0] >> count;
+    }
+    p[3] |= (in != 0);
+}
+
+/* R = A - B */
+static void sub256(uint64_t r[4], uint64_t a[4], uint64_t b[4])
+{
+    bool borrow = false;
+
+    for (int i = 3; i >= 0; --i) {
+        if (borrow) {
+            borrow = a[i] <= b[i];
+            r[i] = a[i] - b[i] - 1;
+        } else {
+            borrow = a[i] < b[i];
+            r[i] = a[i] - b[i];
+        }
+    }
+}
+
+/* A = -A */
+static void neg256(uint64_t a[4])
+{
+    a[3] = -a[3];
+    if (likely(a[3])) {
+        goto not2;
+    }
+    a[2] = -a[2];
+    if (likely(a[2])) {
+        goto not1;
+    }
+    a[1] = -a[1];
+    if (likely(a[1])) {
+        goto not0;
+    }
+    a[0] = -a[0];
+    return;
+ not2:
+    a[2] = ~a[2];
+ not1:
+    a[1] = ~a[1];
+ not0:
+    a[0] = ~a[0];
+}
+
+/* A += B */
+static void add256(uint64_t a[4], uint64_t b[4])
+{
+    bool carry = false;
+
+    for (int i = 3; i >= 0; --i) {
+        uint64_t t = a[i] + b[i];
+        if (carry) {
+            t += 1;
+            carry = t <= a[i];
+        } else {
+            carry = t < a[i];
+        }
+        a[i] = t;
+    }
+}
+
+float128 float128_muladd(float128 a_f, float128 b_f, float128 c_f,
+                         int flags, float_status *status)
+{
+    bool inf_zero, p_sign, sign_flip;
+    uint64_t p_frac[4];
+    FloatParts128 a, b, c;
+    int p_exp, exp_diff, shift, ab_mask, abc_mask;
+    FloatClass p_cls;
+
+    float128_unpack(&a, a_f, status);
+    float128_unpack(&b, b_f, status);
+    float128_unpack(&c, c_f, status);
+
+    ab_mask = float_cmask(a.cls) | float_cmask(b.cls);
+    abc_mask = float_cmask(c.cls) | ab_mask;
+    inf_zero = ab_mask == float_cmask_infzero;
+
+    /* If any input is a NaN, select the required result. */
+    if (unlikely(abc_mask & float_cmask_anynan)) {
+        if (unlikely(abc_mask & float_cmask_snan)) {
+            float_raise(float_flag_invalid, status);
+        }
+
+        int which = pickNaNMulAdd(a.cls, b.cls, c.cls, inf_zero, status);
+        if (status->default_nan_mode) {
+            which = 3;
+        }
+        switch (which) {
+        case 0:
+            break;
+        case 1:
+            a_f = b_f;
+            a.cls = b.cls;
+            break;
+        case 2:
+            a_f = c_f;
+            a.cls = c.cls;
+            break;
+        case 3:
+            return float128_default_nan(status);
+        }
+        if (is_snan(a.cls)) {
+            return float128_silence_nan(a_f, status);
+        }
+        return a_f;
+    }
+
+    /* After dealing with input NaNs, look for Inf * Zero. */
+    if (unlikely(inf_zero)) {
+        float_raise(float_flag_invalid, status);
+        return float128_default_nan(status);
+    }
+
+    p_sign = a.sign ^ b.sign;
+
+    if (flags & float_muladd_negate_c) {
+        c.sign ^= 1;
+    }
+    if (flags & float_muladd_negate_product) {
+        p_sign ^= 1;
+    }
+    sign_flip = (flags & float_muladd_negate_result);
+
+    if (ab_mask & float_cmask_inf) {
+        p_cls = float_class_inf;
+    } else if (ab_mask & float_cmask_zero) {
+        p_cls = float_class_zero;
+    } else {
+        p_cls = float_class_normal;
+    }
+
+    if (c.cls == float_class_inf) {
+        if (p_cls == float_class_inf && p_sign != c.sign) {
+            /* +Inf + -Inf = NaN */
+            float_raise(float_flag_invalid, status);
+            return float128_default_nan(status);
+        }
+        /* Inf + Inf = Inf of the proper sign; reuse the return below. */
+        p_cls = float_class_inf;
+        p_sign = c.sign;
+    }
+
+    if (p_cls == float_class_inf) {
+        return packFloat128(p_sign ^ sign_flip, 0x7fff, 0, 0);
+    }
+
+    if (p_cls == float_class_zero) {
+        if (c.cls == float_class_zero) {
+            if (p_sign != c.sign) {
+                p_sign = status->float_rounding_mode == float_round_down;
+            }
+            return packFloat128(p_sign ^ sign_flip, 0, 0, 0);
+        }
+
+        if (flags & float_muladd_halve_result) {
+            c.exp -= 1;
+        }
+        return roundAndPackFloat128(c.sign ^ sign_flip,
+                                    c.exp + 0x3fff - 1,
+                                    c.frac0, c.frac1, 0, status);
+    }
+
+    /* a & b should be normals now... */
+    assert(a.cls == float_class_normal && b.cls == float_class_normal);
+
+    /* Multiply of 2 113-bit numbers produces a 226-bit result.  */
+    mul128To256(a.frac0, a.frac1, b.frac0, b.frac1,
+                &p_frac[0], &p_frac[1], &p_frac[2], &p_frac[3]);
+
+    /* Realign the binary point at bit 48 of p_frac[0].  */
+    shift = clz64(p_frac[0]) - 15;
+    g_assert(shift == 15 || shift == 16);
+    shortShift256Left(p_frac, shift);
+    p_exp = a.exp + b.exp - (shift - 16);
+    exp_diff = p_exp - c.exp;
+
+    uint64_t c_frac[4] = { c.frac0, c.frac1, 0, 0 };
+
+    /* Add or subtract C from the intermediate product. */
+    if (c.cls == float_class_zero) {
+        /* Fall through to rounding after addition (with zero). */
+    } else if (p_sign != c.sign) {
+        /* Subtraction */
+        if (exp_diff < 0) {
+            shift256RightJamming(p_frac, -exp_diff);
+            sub256(p_frac, c_frac, p_frac);
+            p_exp = c.exp;
+            p_sign ^= 1;
+        } else if (exp_diff > 0) {
+            shift256RightJamming(c_frac, exp_diff);
+            sub256(p_frac, p_frac, c_frac);
+        } else {
+            /* Low 128 bits of C are known to be zero. */
+            sub128(p_frac[0], p_frac[1], c_frac[0], c_frac[1],
+                   &p_frac[0], &p_frac[1]);
+            /*
+             * Since we have normalized to bit 48 of p_frac[0],
+             * a negative result means C > P and we need to invert.
+             */
+            if ((int64_t)p_frac[0] < 0) {
+                neg256(p_frac);
+                p_sign ^= 1;
+            }
+        }
+
+        /*
+         * Gross normalization of the 256-bit subtraction result.
+         * Fine tuning below shared with addition.
+         */
+        if (p_frac[0] != 0) {
+            /* nothing to do */
+        } else if (p_frac[1] != 0) {
+            p_exp -= 64;
+            p_frac[0] = p_frac[1];
+            p_frac[1] = p_frac[2];
+            p_frac[2] = p_frac[3];
+            p_frac[3] = 0;
+        } else if (p_frac[2] != 0) {
+            p_exp -= 128;
+            p_frac[0] = p_frac[2];
+            p_frac[1] = p_frac[3];
+            p_frac[2] = 0;
+            p_frac[3] = 0;
+        } else if (p_frac[3] != 0) {
+            p_exp -= 192;
+            p_frac[0] = p_frac[3];
+            p_frac[1] = 0;
+            p_frac[2] = 0;
+            p_frac[3] = 0;
+        } else {
+            /* Subtraction was exact: result is zero. */
+            p_sign = status->float_rounding_mode == float_round_down;
+            return packFloat128(p_sign ^ sign_flip, 0, 0, 0);
+        }
+    } else {
+        /* Addition */
+        if (exp_diff <= 0) {
+            shift256RightJamming(p_frac, -exp_diff);
+            /* Low 128 bits of C are known to be zero. */
+            add128(p_frac[0], p_frac[1], c_frac[0], c_frac[1],
+                   &p_frac[0], &p_frac[1]);
+            p_exp = c.exp;
+        } else {
+            shift256RightJamming(c_frac, exp_diff);
+            add256(p_frac, c_frac);
+        }
+    }
+
+    /* Fine normalization of the 256-bit result: p_frac[0] != 0. */
+    shift = clz64(p_frac[0]) - 15;
+    if (shift < 0) {
+        shift256RightJamming(p_frac, -shift);
+    } else if (shift > 0) {
+        shortShift256Left(p_frac, shift);
+    }
+    p_exp -= shift;
+
+    if (flags & float_muladd_halve_result) {
+        p_exp -= 1;
+    }
+    return roundAndPackFloat128(p_sign ^ sign_flip,
+                                p_exp + 0x3fff - 1,
+                                p_frac[0], p_frac[1],
+                                p_frac[2] | (p_frac[3] != 0),
+                                status);
+}
+
 /*----------------------------------------------------------------------------
 | Returns the result of dividing the quadruple-precision floating-point value
 | `a' by the corresponding value `b'.  The operation is performed according to
diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index 06ffebd6db..9bbb0dba67 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -717,7 +717,7 @@ static void do_testfloat(int op, int rmode, bool exact)
         test_abz_f128(true_abz_f128M, subj_abz_f128M);
         break;
     case F128_MULADD:
-        not_implemented();
+        test_abcz_f128(slow_f128M_mulAdd, qemu_f128_mulAdd);
         break;
     case F128_SQRT:
         test_az_f128(slow_f128M_sqrt, qemu_f128M_sqrt);
diff --git a/tests/fp/wrap.c.inc b/tests/fp/wrap.c.inc
index 0cbd20013e..65a713deae 100644
--- a/tests/fp/wrap.c.inc
+++ b/tests/fp/wrap.c.inc
@@ -574,6 +574,18 @@ WRAP_MULADD(qemu_f32_mulAdd, float32_muladd, float32)
 WRAP_MULADD(qemu_f64_mulAdd, float64_muladd, float64)
 #undef WRAP_MULADD
 
+static void qemu_f128_mulAdd(const float128_t *ap, const float128_t *bp,
+                             const float128_t *cp, float128_t *res)
+{
+    float128 a, b, c, ret;
+
+    a = soft_to_qemu128(*ap);
+    b = soft_to_qemu128(*bp);
+    c = soft_to_qemu128(*cp);
+    ret = float128_muladd(a, b, c, 0, &qsf);
+    *res = qemu_to_soft128(ret);
+}
+
 #define WRAP_CMP16(name, func, retcond)         \
     static bool name(float16_t a, float16_t b)  \
     {                                           \
-- 
2.25.1



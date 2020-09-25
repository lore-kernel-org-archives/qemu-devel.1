Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBA0C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3B520878
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DfH0PnmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3B520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpie-0003su-MV
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpX3-0001C4-S4
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:21:10 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:39335)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpWv-0005Rg-EA
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:21:08 -0400
Received: by mail-pg1-x52e.google.com with SMTP id d13so2858870pgl.6
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zvybnY1s2mhvbUfv1u1LxWyNi6dAzmSLhIeilyMRabs=;
 b=DfH0PnmOuG4uC9lp3V0SzThWm7AyCQRMHcLgHYgUDVl3HLYELOrlJehzK/i9mhjTWs
 IL7wTgAYA2Zo3Z6Cx8rAOFfvwujGT6eCPzDIdmescbNecjh8YoOpQK5sKLSKMTmROPIw
 0Ew2YUXLfNx1ENJFfTK3DETQMeFNSBj4ucedVc2krG5lC1BzEUEyAyTIZQrRV20bQNSL
 F8rAoscHdyrQ+G/6qbUjjyv4IWn27OZ2ErPHoUJopR4Z6lWk2WCSt8drNHGMuL9af5ZJ
 dxYuULK1hLcaFxDqOs+55RcgZ43ui5ZwEaCZh/2z1p+LMEkl0+hkuzpMM/6wBrfjx1ZV
 Y7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zvybnY1s2mhvbUfv1u1LxWyNi6dAzmSLhIeilyMRabs=;
 b=cWyJXelB7lbQBWnEuzGxg95Iy7mmZrf4DGJc1+JPOEiqUv9Gc7isiKXbQd92cGwpR/
 znqhvK5TYXlXHKnwML6uW1vZ1lL+z6i/wWhfihwBLT820BG5nzkOxvDrE/WLItUE3Bol
 8kkxkRmhkMG5hhNG5nMtJTRn2S1+II6TQSWUds6LAhGRmCV+gNbc168tH5sATf8h+U4p
 bLwgfiGSNFWAF38sMT1uy1ToJoEgSbJaWREawNYkuKgNA4zj7Qfy1OwuRiesfBqsFdtF
 ZiUfvh3wy3gwetwhgRrwqd2as/L30r8kR4VFyiiDK9gTh3c7U68GdMwNeGc1dwgYSpBs
 yDJQ==
X-Gm-Message-State: AOAM533pXnNeISZ6VAvBk5tiKVILkKEwAc+tfvcOsJ2dtcVx/ZREO5ee
 1x43zW/2OnZHbQEAGbKz3ljW/sfJUQZ7EQ==
X-Google-Smtp-Source: ABdhPJwyLVlec+j1Py++fqic64/0TS91bv+9Bjkcq+hIJwZpDvsUdQ+m808tehO2w6+TAZ+t3amX7Q==
X-Received: by 2002:a05:6a00:22d4:b029:150:bd5d:ce11 with SMTP id
 f20-20020a056a0022d4b0290150bd5dce11mr4537140pfj.38.1601047258117; 
 Fri, 25 Sep 2020 08:20:58 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a5sm2717859pgk.13.2020.09.25.08.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:20:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/10] softfloat: Implement float128_muladd
Date: Fri, 25 Sep 2020 08:20:43 -0700
Message-Id: <20200925152047.709901-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925152047.709901-1-richard.henderson@linaro.org>
References: <20200925152047.709901-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
 fpu/softfloat.c         | 416 +++++++++++++++++++++++++++++++++++++++-
 tests/fp/fp-test.c      |   2 +-
 tests/fp/wrap.c.inc     |  12 ++
 4 files changed, 430 insertions(+), 2 deletions(-)

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
index e038434a07..49de31fec2 100644
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
@@ -7205,6 +7253,372 @@ float128 float128_mul(float128 a, float128 b, float_status *status)
 
 }
 
+typedef struct UInt256 {
+    /* Indexed big-endian, to match the rest of softfloat numbering. */
+    uint64_t w[4];
+} UInt256;
+
+static inline uint64_t shl_double(uint64_t h, uint64_t l, unsigned lsh)
+{
+    return lsh ? (h << lsh) | (l >> (64 - lsh)) : h;
+}
+
+static inline uint64_t shr_double(uint64_t h, uint64_t l, unsigned rsh)
+{
+    return rsh ? (h << (64 - rsh)) | (l >> rsh) : l;
+}
+
+static void shortShift256Left(UInt256 *p, unsigned lsh)
+{
+    if (lsh != 0) {
+        p->w[0] = shl_double(p->w[0], p->w[1], lsh);
+        p->w[1] = shl_double(p->w[1], p->w[2], lsh);
+        p->w[2] = shl_double(p->w[2], p->w[3], lsh);
+        p->w[3] <<= lsh;
+    }
+}
+
+static inline void shift256RightJamming(UInt256 *p, unsigned count)
+{
+    uint64_t out, p0, p1, p2, p3;
+
+    p0 = p->w[0];
+    p1 = p->w[1];
+    p2 = p->w[2];
+    p3 = p->w[3];
+
+    if (unlikely(count == 0)) {
+        return;
+    } else if (likely(count < 64)) {
+        out = 0;
+    } else if (likely(count < 256)) {
+        if (count < 128) {
+            out = p3;
+            p3 = p2;
+            p2 = p1;
+            p1 = p0;
+            p0 = 0;
+        } else if (count < 192) {
+            out = p2 | p3;
+            p3 = p1;
+            p2 = p0;
+            p1 = 0;
+            p0 = 0;
+        } else {
+            out = p1 | p2 | p3;
+            p3 = p0;
+            p2 = 0;
+            p1 = 0;
+            p0 = 0;
+        }
+        count &= 63;
+        if (count == 0) {
+            goto done;
+        }
+    } else {
+        out = p0 | p1 | p2 | p3;
+        p3 = 0;
+        p2 = 0;
+        p1 = 0;
+        p0 = 0;
+        goto done;
+    }
+
+    out |= shr_double(p3, 0, count);
+    p3 = shr_double(p2, p3, count);
+    p2 = shr_double(p1, p2, count);
+    p1 = shr_double(p0, p1, count);
+    p0 = p0 >> count;
+
+ done:
+    p->w[3] = p3 | (out != 0);
+    p->w[2] = p2;
+    p->w[1] = p1;
+    p->w[0] = p0;
+}
+
+/* R = A - B */
+static void sub256(UInt256 *r, UInt256 *a, UInt256 *b)
+{
+    bool borrow = false;
+
+    for (int i = 3; i >= 0; --i) {
+        uint64_t at = a->w[i];
+        uint64_t bt = b->w[i];
+        uint64_t rt = at - bt;
+
+        if (borrow) {
+            borrow = at <= bt;
+            rt -= 1;
+        } else {
+            borrow = at < bt;
+        }
+        r->w[i] = rt;
+    }
+}
+
+/* A = -A */
+static void neg256(UInt256 *a)
+{
+    /*
+     * Recall that -X - 1 = ~X, and that since this is negation,
+     * once we find a non-zero number, all subsequent words will
+     * have borrow-in, and thus use NOT.
+     */
+    uint64_t t = a->w[3];
+    if (likely(t)) {
+        a->w[3] = -t;
+        goto not2;
+    }
+    t = a->w[2];
+    if (likely(t)) {
+        a->w[2] = -t;
+        goto not1;
+    }
+    t = a->w[1];
+    if (likely(t)) {
+        a->w[1] = -t;
+        goto not0;
+    }
+    a->w[0] = -a->w[0];
+    return;
+ not2:
+    a->w[2] = ~a->w[2];
+ not1:
+    a->w[1] = ~a->w[1];
+ not0:
+    a->w[0] = ~a->w[0];
+}
+
+/* A += B */
+static void add256(UInt256 *a, UInt256 *b)
+{
+    bool carry = false;
+
+    for (int i = 3; i >= 0; --i) {
+        uint64_t bt = b->w[i];
+        uint64_t at = a->w[i] + bt;
+
+        if (carry) {
+            at += 1;
+            carry = at <= bt;
+        } else {
+            carry = at < bt;
+        }
+        a->w[i] = at;
+    }
+}
+
+float128 float128_muladd(float128 a_f, float128 b_f, float128 c_f,
+                         int flags, float_status *status)
+{
+    bool inf_zero, p_sign, sign_flip;
+    int p_exp, exp_diff, shift, ab_mask, abc_mask;
+    FloatParts128 a, b, c;
+    FloatClass p_cls;
+    UInt256 p_frac, c_frac;
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
+                &p_frac.w[0], &p_frac.w[1], &p_frac.w[2], &p_frac.w[3]);
+
+    /* Realign the binary point at bit 48 of p_frac[0].  */
+    shift = clz64(p_frac.w[0]) - 15;
+    shortShift256Left(&p_frac, shift);
+    p_exp = a.exp + b.exp - (shift - 16);
+    exp_diff = p_exp - c.exp;
+
+    /* Extend the fraction part of the addend to 256 bits.  */
+    c_frac.w[0] = c.frac0;
+    c_frac.w[1] = c.frac1;
+    c_frac.w[2] = 0;
+    c_frac.w[3] = 0;
+
+    /* Add or subtract C from the intermediate product. */
+    if (c.cls == float_class_zero) {
+        /* Fall through to rounding after addition (with zero). */
+    } else if (p_sign != c.sign) {
+        /* Subtraction */
+        if (exp_diff < 0) {
+            shift256RightJamming(&p_frac, -exp_diff);
+            sub256(&p_frac, &c_frac, &p_frac);
+            p_exp = c.exp;
+            p_sign ^= 1;
+        } else if (exp_diff > 0) {
+            shift256RightJamming(&c_frac, exp_diff);
+            sub256(&p_frac, &p_frac, &c_frac);
+        } else {
+            /* Low 128 bits of C are known to be zero. */
+            sub128(p_frac.w[0], p_frac.w[1], c_frac.w[0], c_frac.w[1],
+                   &p_frac.w[0], &p_frac.w[1]);
+            /*
+             * Since we have normalized to bit 48 of p_frac[0],
+             * a negative result means C > P and we need to invert.
+             */
+            if ((int64_t)p_frac.w[0] < 0) {
+                neg256(&p_frac);
+                p_sign ^= 1;
+            }
+        }
+
+        /*
+         * Gross normalization of the 256-bit subtraction result.
+         * Fine tuning below shared with addition.
+         */
+        if (p_frac.w[0] != 0) {
+            /* nothing to do */
+        } else if (p_frac.w[1] != 0) {
+            p_exp -= 64;
+            p_frac.w[0] = p_frac.w[1];
+            p_frac.w[1] = p_frac.w[2];
+            p_frac.w[2] = p_frac.w[3];
+            p_frac.w[3] = 0;
+        } else if (p_frac.w[2] != 0) {
+            p_exp -= 128;
+            p_frac.w[0] = p_frac.w[2];
+            p_frac.w[1] = p_frac.w[3];
+            p_frac.w[2] = 0;
+            p_frac.w[3] = 0;
+        } else if (p_frac.w[3] != 0) {
+            p_exp -= 192;
+            p_frac.w[0] = p_frac.w[3];
+            p_frac.w[1] = 0;
+            p_frac.w[2] = 0;
+            p_frac.w[3] = 0;
+        } else {
+            /* Subtraction was exact: result is zero. */
+            p_sign = status->float_rounding_mode == float_round_down;
+            return packFloat128(p_sign ^ sign_flip, 0, 0, 0);
+        }
+    } else {
+        /* Addition */
+        if (exp_diff <= 0) {
+            shift256RightJamming(&p_frac, -exp_diff);
+            /* Low 128 bits of C are known to be zero. */
+            add128(p_frac.w[0], p_frac.w[1], c_frac.w[0], c_frac.w[1],
+                   &p_frac.w[0], &p_frac.w[1]);
+            p_exp = c.exp;
+        } else {
+            shift256RightJamming(&c_frac, exp_diff);
+            add256(&p_frac, &c_frac);
+        }
+    }
+
+    /* Fine normalization of the 256-bit result: p_frac[0] != 0. */
+    shift = clz64(p_frac.w[0]) - 15;
+    if (shift < 0) {
+        shift256RightJamming(&p_frac, -shift);
+    } else if (shift > 0) {
+        shortShift256Left(&p_frac, shift);
+    }
+    p_exp -= shift;
+
+    if (flags & float_muladd_halve_result) {
+        p_exp -= 1;
+    }
+    return roundAndPackFloat128(p_sign ^ sign_flip,
+                                p_exp + 0x3fff - 1,
+                                p_frac.w[0], p_frac.w[1],
+                                p_frac.w[2] | (p_frac.w[3] != 0),
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



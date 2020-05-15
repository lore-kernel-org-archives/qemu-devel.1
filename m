Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B898EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B75D2076A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l+QqZYzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B75D2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbG8-0006yQ-Nl
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZbD4-0000xL-Rc
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:21:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:39760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZbD3-0003tW-Eg
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:21:10 -0400
Received: by mail-wm1-x332.google.com with SMTP id w64so2855444wmg.4
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t3k1YQ3YiPwjNYyBRfLq+hISGgzCVFU8auqRb6w56y0=;
 b=l+QqZYzCRr4nLEcvxPdjVOcUe+AmZvJMVlwv1eegUJSgpEiV0ddzolUhCwsNp1caIy
 4Ggg8u4OQRgHjltGvee35g0Lo2nz2hvcRi6rz5XQKN79KoStIV6UKsdk36FSrxOUYCoe
 h3X6vHgetEq9HiUcMDm+O4Q+hvWt29bSpkDc9km/3EZGU2sACcLw1EWeEf+xvtY5D+rn
 JftWx53MtYyzHY7lt+2tQpDpC0rIc40xhZ2/ngPH4kt7bujzxZxsXcGP+e+hoIlkRsGA
 d4Gm+K29/cmPJsTwVrzVRx/sTGvJXFZedJfFuyo9IkCoOswiOuyZAfmVwPDxsVk/PrCb
 I7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t3k1YQ3YiPwjNYyBRfLq+hISGgzCVFU8auqRb6w56y0=;
 b=npqUjLH4aTgPyCh/qyvn4a1Pq8mM00Ujt1yBR32ZSautbGYL29Mena44uot7nkNrHJ
 fykIswWDt7vimnOIdENPPDH2oovY4yW9QeaCUVaFPQi3bl8/WMf571qZuUeY4dmk0ceF
 xWsioBA6T82Q0eiQCZjNtHdeYpl1Tfks0wTGeA10mlUk/LtgCYpplUNS/yM9SyIAVgvI
 yKA0YoLN0Jbhh7INJ0SLtVaqQbVATGLLBoeadmYq1vk3L83VTvmZ3UBh3Qe7dvrs/cS+
 6CnIav5gArWAYdJ1t0D+cvB+2rx2M0/TENhwmbOCxQCAFWd0KE/D4iYYH9Isozz9SuUJ
 +9hQ==
X-Gm-Message-State: AOAM530u1BJDWADwOgn1XwASDTljrmdeg9uP8iKxsP0wFNTx0DjpmSTZ
 JCairNyWbpB7+gObUpDl8cf2rw==
X-Google-Smtp-Source: ABdhPJzOmWOjMnaik0TPqiDzqwTgPG1DsgK7bB0+C4pxzn4ibawFND08mWp8d/wiaQRpjPtkPirSjg==
X-Received: by 2002:a1c:dd09:: with SMTP id u9mr4384418wmg.77.1589552467889;
 Fri, 15 May 2020 07:21:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s14sm3738327wmh.18.2020.05.15.07.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 07:21:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 08/10] target/arm: Convert Neon VSHLL, VMOVL to decodetree
Date: Fri, 15 May 2020 15:20:54 +0100
Message-Id: <20200515142056.21346-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515142056.21346-1-peter.maydell@linaro.org>
References: <20200515142056.21346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Convert the VSHLL and VMOVL insns from the 2-reg-shift group
to decodetree. Since the loop always has two passes, we unroll
it to avoid the awkward reassignment of one TCGv to another.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       | 14 ++++++
 target/arm/translate-neon.inc.c | 81 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 46 +------------------
 3 files changed, 97 insertions(+), 44 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index bf4ef8c555f..4438c1c8728 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -404,3 +404,17 @@ VQRSHRN_U32_2sh  1111 001 1 1 . 01 ....     .... 1001 0 . . 1 .... \
                  @2reg_shift_q1 size=2 shift=%neon_rshift_i4
 VQRSHRN_U16_2sh  1111 001 1 1 . 001 ...     .... 1001 0 . . 1 .... \
                  @2reg_shift_q1 size=1 shift=%neon_rshift_i3
+
+VSHLL_S_2sh      1111 001 0 1 . 1 shift:5   .... 1010 0 . . 1 .... \
+                 @2reg_shift_q0 size=2
+VSHLL_S_2sh      1111 001 0 1 . 01 shift:4  .... 1010 0 . . 1 .... \
+                 @2reg_shift_q0 size=1
+VSHLL_S_2sh      1111 001 0 1 . 001 shift:3 .... 1010 0 . . 1 .... \
+                 @2reg_shift_q0 size=0
+
+VSHLL_U_2sh      1111 001 1 1 . 1 shift:5   .... 1010 0 . . 1 .... \
+                 @2reg_shift_q0 size=2
+VSHLL_U_2sh      1111 001 1 1 . 01 shift:4  .... 1010 0 . . 1 .... \
+                 @2reg_shift_q0 size=1
+VSHLL_U_2sh      1111 001 1 1 . 001 shift:3 .... 1010 0 . . 1 .... \
+                 @2reg_shift_q0 size=0
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 9a75a69a4f5..5678bfd0d4d 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1687,3 +1687,84 @@ DO_2SN_32(VQSHRN_U16, gen_helper_neon_shl_u16, gen_helper_neon_narrow_sat_u8)
 DO_2SN_64(VQRSHRN_U64, gen_helper_neon_rshl_u64, gen_helper_neon_narrow_sat_u32)
 DO_2SN_32(VQRSHRN_U32, gen_helper_neon_rshl_u32, gen_helper_neon_narrow_sat_u16)
 DO_2SN_32(VQRSHRN_U16, gen_helper_neon_rshl_u16, gen_helper_neon_narrow_sat_u8)
+
+static bool do_vshll_2sh(DisasContext *s, arg_2reg_shift *a,
+                         NeonGenWidenFn *widenfn, bool u)
+{
+    TCGv_i64 tmp;
+    TCGv_i32 rm0, rm1;
+    uint64_t widen_mask = 0;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (a->vd & 1) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    /*
+     * This is a widen-and-shift operation. The shift is always less
+     * than the width of the source type, so after widening the input
+     * vector we can simply shift the whole 64-bit widened register,
+     * and then clear the potential overflow bits resulting from left
+     * bits of the narrow input appearing as right bits of the left
+     * neighbour narrow input. Calculate a mask of bits to clear.
+     */
+    if ((a->shift != 0) && (a->size < 2 || u)) {
+        int esize = 8 << a->size;
+        widen_mask = MAKE_64BIT_MASK(0, esize);
+        widen_mask >>= esize - a->shift;
+        widen_mask = dup_const(a->size + 1, widen_mask);
+    }
+
+    rm0 = neon_load_reg(a->vm, 0);
+    rm1 = neon_load_reg(a->vm, 1);
+    tmp = tcg_temp_new_i64();
+
+    widenfn(tmp, rm0);
+    if (a->shift != 0) {
+        tcg_gen_shli_i64(tmp, tmp, a->shift);
+        tcg_gen_andi_i64(tmp, tmp, ~widen_mask);
+    }
+    neon_store_reg64(tmp, a->vd);
+
+    widenfn(tmp, rm1);
+    if (a->shift != 0) {
+        tcg_gen_shli_i64(tmp, tmp, a->shift);
+        tcg_gen_andi_i64(tmp, tmp, ~widen_mask);
+    }
+    neon_store_reg64(tmp, a->vd + 1);
+    tcg_temp_free_i64(tmp);
+    return true;
+}
+
+static bool trans_VSHLL_S_2sh(DisasContext *s, arg_2reg_shift *a)
+{
+    NeonGenWidenFn *widenfn[] = {
+        gen_helper_neon_widen_s8,
+        gen_helper_neon_widen_s16,
+        tcg_gen_ext_i32_i64,
+    };
+    return do_vshll_2sh(s, a, widenfn[a->size], false);
+}
+
+static bool trans_VSHLL_U_2sh(DisasContext *s, arg_2reg_shift *a)
+{
+    NeonGenWidenFn *widenfn[] = {
+        gen_helper_neon_widen_u8,
+        gen_helper_neon_widen_u16,
+        tcg_gen_extu_i32_i64,
+    };
+    return do_vshll_2sh(s, a, widenfn[a->size], true);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index f728231b198..ef39c89f10a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5248,6 +5248,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             case 7: /* VQSHL */
             case 8: /* VSHRN, VRSHRN, VQSHRUN, VQRSHRUN */
             case 9: /* VQSHRN, VQRSHRN */
+            case 10: /* VSHLL, including VMOVL */
                 return 1; /* handled by decodetree */
             default:
                 break;
@@ -5265,50 +5266,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     size--;
             }
             shift = (insn >> 16) & ((1 << (3 + size)) - 1);
-            if (op == 10) {
-                /* VSHLL, VMOVL */
-                if (q || (rd & 1)) {
-                    return 1;
-                }
-                tmp = neon_load_reg(rm, 0);
-                tmp2 = neon_load_reg(rm, 1);
-                for (pass = 0; pass < 2; pass++) {
-                    if (pass == 1)
-                        tmp = tmp2;
-
-                    gen_neon_widen(cpu_V0, tmp, size, u);
-
-                    if (shift != 0) {
-                        /* The shift is less than the width of the source
-                           type, so we can just shift the whole register.  */
-                        tcg_gen_shli_i64(cpu_V0, cpu_V0, shift);
-                        /* Widen the result of shift: we need to clear
-                         * the potential overflow bits resulting from
-                         * left bits of the narrow input appearing as
-                         * right bits of left the neighbour narrow
-                         * input.  */
-                        if (size < 2 || !u) {
-                            uint64_t imm64;
-                            if (size == 0) {
-                                imm = (0xffu >> (8 - shift));
-                                imm |= imm << 16;
-                            } else if (size == 1) {
-                                imm = 0xffff >> (16 - shift);
-                            } else {
-                                /* size == 2 */
-                                imm = 0xffffffff >> (32 - shift);
-                            }
-                            if (size < 2) {
-                                imm64 = imm | (((uint64_t)imm) << 32);
-                            } else {
-                                imm64 = imm;
-                            }
-                            tcg_gen_andi_i64(cpu_V0, cpu_V0, ~imm64);
-                        }
-                    }
-                    neon_store_reg64(cpu_V0, rd + pass);
-                }
-            } else if (op >= 14) {
+            if (op >= 14) {
                 /* VCVT fixed-point.  */
                 TCGv_ptr fpst;
                 TCGv_i32 shiftv;
-- 
2.20.1



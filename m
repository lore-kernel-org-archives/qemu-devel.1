Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4FCC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:00:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78E84206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r+ZcPchG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E84206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFi9-0006ca-II
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFYF-000279-Fw
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:39 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:46400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFYE-0001iM-1m
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:39 -0400
Received: by mail-wr1-x42b.google.com with SMTP id x6so10397017wrm.13
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=inEmm25PSoBT/PmMf2iRhKsKWqibfLb33Ig759bQ+NQ=;
 b=r+ZcPchGMQOzTdKNuHh2m4cB1nkszZbcIxpksyFt5QRl6Sxkm9mrhodiIZqHpReI84
 Xa0DkwDzArl/1DgE/pPIZmzxlCFNUOG+lMbaGteWzqDNfHbhqvkTtCiMJ5vtIRtfx/8y
 tcazHmUeZAv+fjNlWsU3vm+T/MRhMwA5SkCaZSPOSiOpxeM9Mhwo6pv3Ua/zAnsq4kYm
 nyyIQE6T7ZJ6sr2R3tDXohENZy0LCBilSlNveN9iy3v+8msgAbOV2JJwxIhKHyCsBKBt
 YfLPyrVeZCsVVKWdMWMNy9KfBoXAQ6a+QWrnH2MHFN2nfnQvtmgwdSwhl/5bLFD/xtHE
 XaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=inEmm25PSoBT/PmMf2iRhKsKWqibfLb33Ig759bQ+NQ=;
 b=tAjvxarn+s5sJCAveie8B6eEXGkmRtWMKsIAu+DTR0Dv/irBcbHYHPQLUJzNKPsuLw
 PiexWZEcr9Y8DaRDwHB8Aa9354PrbP7v03CYEEbagMLXHbG5HCztWAqxA4nUt0PTuBw8
 B9YrU6pe8tNMf6zEtpJ5bKX/DUEbwrW6vHlVptj7tdKXaVe0hlRAoXhy0VPoUQZ5beVz
 RJnC9IrO8b4F05kbi42CJR9dzzEGx112JuDI9h2JY2xaUNwZIDSNfnPDw0SGBc3fgdaQ
 QZjqBPsASCn9FKyL3+fQrcj+1c0Rsajhk+ViG+Q4KvpsjuhnhKI5FVS6fAFO/kC1QkY/
 mnxw==
X-Gm-Message-State: AOAM530eMbZZhwghVDwHQyZNTe4UAhdRd+lPX2mmKWD1VcDQtF8NGkkV
 TJcbSubNReLRoJHlu6V2ARFWRF2iNFf6Cg==
X-Google-Smtp-Source: ABdhPJwsla04rrGfBxF2OiJ6zLvT1qf2YWndwVyKuS2vjRsrtgzsEl7KxgGVTSEb+UlneGk9fp2Mfg==
X-Received: by 2002:a5d:4d01:: with SMTP id z1mr11346066wrt.29.1591375836137; 
 Fri, 05 Jun 2020 09:50:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c140sm12272724wmd.18.2020.06.05.09.50.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:50:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/29] target/arm: Convert VQSHLU,
 VQSHL 2-reg-shift insns to decodetree
Date: Fri,  5 Jun 2020 17:50:02 +0100
Message-Id: <20200605165007.12095-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605165007.12095-1-peter.maydell@linaro.org>
References: <20200605165007.12095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VQSHLU and QVSHL 2-reg-shift insns to decodetree.
These are the last of the simple shift-by-immediate insns.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200522145520.6778-5-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  15 +++++
 target/arm/translate-neon.inc.c | 108 +++++++++++++++++++++++++++++++
 target/arm/translate.c          | 110 +-------------------------------
 3 files changed, 126 insertions(+), 107 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 659cf139303..66c41a53e59 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -286,3 +286,18 @@ VSLI_2sh         1111 001 1 1 . ...... .... 0101 . . . 1 .... @2reg_shl_d
 VSLI_2sh         1111 001 1 1 . ...... .... 0101 . . . 1 .... @2reg_shl_s
 VSLI_2sh         1111 001 1 1 . ...... .... 0101 . . . 1 .... @2reg_shl_h
 VSLI_2sh         1111 001 1 1 . ...... .... 0101 . . . 1 .... @2reg_shl_b
+
+VQSHLU_64_2sh    1111 001 1 1 . ...... .... 0110 . . . 1 .... @2reg_shl_d
+VQSHLU_2sh       1111 001 1 1 . ...... .... 0110 . . . 1 .... @2reg_shl_s
+VQSHLU_2sh       1111 001 1 1 . ...... .... 0110 . . . 1 .... @2reg_shl_h
+VQSHLU_2sh       1111 001 1 1 . ...... .... 0110 . . . 1 .... @2reg_shl_b
+
+VQSHL_S_64_2sh   1111 001 0 1 . ...... .... 0111 . . . 1 .... @2reg_shl_d
+VQSHL_S_2sh      1111 001 0 1 . ...... .... 0111 . . . 1 .... @2reg_shl_s
+VQSHL_S_2sh      1111 001 0 1 . ...... .... 0111 . . . 1 .... @2reg_shl_h
+VQSHL_S_2sh      1111 001 0 1 . ...... .... 0111 . . . 1 .... @2reg_shl_b
+
+VQSHL_U_64_2sh   1111 001 1 1 . ...... .... 0111 . . . 1 .... @2reg_shl_d
+VQSHL_U_2sh      1111 001 1 1 . ...... .... 0111 . . . 1 .... @2reg_shl_s
+VQSHL_U_2sh      1111 001 1 1 . ...... .... 0111 . . . 1 .... @2reg_shl_h
+VQSHL_U_2sh      1111 001 1 1 . ...... .... 0111 . . . 1 .... @2reg_shl_b
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 28688000594..baa985b16c3 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1288,3 +1288,111 @@ static bool trans_VSHR_U_2sh(DisasContext *s, arg_2reg_shift *a)
         return do_vector_2sh(s, a, tcg_gen_gvec_shri);
     }
 }
+
+static bool do_2shift_env_64(DisasContext *s, arg_2reg_shift *a,
+                             NeonGenTwo64OpEnvFn *fn)
+{
+    /*
+     * 2-reg-and-shift operations, size == 3 case, where the
+     * function needs to be passed cpu_env.
+     */
+    TCGv_i64 constimm;
+    int pass;
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
+    if ((a->vm | a->vd) & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    /*
+     * To avoid excessive duplication of ops we implement shift
+     * by immediate using the variable shift operations.
+     */
+    constimm = tcg_const_i64(dup_const(a->size, a->shift));
+
+    for (pass = 0; pass < a->q + 1; pass++) {
+        TCGv_i64 tmp = tcg_temp_new_i64();
+
+        neon_load_reg64(tmp, a->vm + pass);
+        fn(tmp, cpu_env, tmp, constimm);
+        neon_store_reg64(tmp, a->vd + pass);
+    }
+    tcg_temp_free_i64(constimm);
+    return true;
+}
+
+static bool do_2shift_env_32(DisasContext *s, arg_2reg_shift *a,
+                             NeonGenTwoOpEnvFn *fn)
+{
+    /*
+     * 2-reg-and-shift operations, size < 3 case, where the
+     * helper needs to be passed cpu_env.
+     */
+    TCGv_i32 constimm;
+    int pass;
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
+    if ((a->vm | a->vd) & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    /*
+     * To avoid excessive duplication of ops we implement shift
+     * by immediate using the variable shift operations.
+     */
+    constimm = tcg_const_i32(dup_const(a->size, a->shift));
+
+    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
+        TCGv_i32 tmp = neon_load_reg(a->vm, pass);
+        fn(tmp, cpu_env, tmp, constimm);
+        neon_store_reg(a->vd, pass, tmp);
+    }
+    tcg_temp_free_i32(constimm);
+    return true;
+}
+
+#define DO_2SHIFT_ENV(INSN, FUNC)                                       \
+    static bool trans_##INSN##_64_2sh(DisasContext *s, arg_2reg_shift *a) \
+    {                                                                   \
+        return do_2shift_env_64(s, a, gen_helper_neon_##FUNC##64);      \
+    }                                                                   \
+    static bool trans_##INSN##_2sh(DisasContext *s, arg_2reg_shift *a)  \
+    {                                                                   \
+        static NeonGenTwoOpEnvFn * const fns[] = {                      \
+            gen_helper_neon_##FUNC##8,                                  \
+            gen_helper_neon_##FUNC##16,                                 \
+            gen_helper_neon_##FUNC##32,                                 \
+        };                                                              \
+        assert(a->size < ARRAY_SIZE(fns));                              \
+        return do_2shift_env_32(s, a, fns[a->size]);                    \
+    }
+
+DO_2SHIFT_ENV(VQSHLU, qshlu_s)
+DO_2SHIFT_ENV(VQSHL_U, qshl_u)
+DO_2SHIFT_ENV(VQSHL_S, qshl_s)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2d08c644839..c32a16085c7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3011,29 +3011,6 @@ static inline void gen_neon_rsb(int size, TCGv_i32 t0, TCGv_i32 t1)
     }
 }
 
-#define GEN_NEON_INTEGER_OP_ENV(name) do { \
-    switch ((size << 1) | u) { \
-    case 0: \
-        gen_helper_neon_##name##_s8(tmp, cpu_env, tmp, tmp2); \
-        break; \
-    case 1: \
-        gen_helper_neon_##name##_u8(tmp, cpu_env, tmp, tmp2); \
-        break; \
-    case 2: \
-        gen_helper_neon_##name##_s16(tmp, cpu_env, tmp, tmp2); \
-        break; \
-    case 3: \
-        gen_helper_neon_##name##_u16(tmp, cpu_env, tmp, tmp2); \
-        break; \
-    case 4: \
-        gen_helper_neon_##name##_s32(tmp, cpu_env, tmp, tmp2); \
-        break; \
-    case 5: \
-        gen_helper_neon_##name##_u32(tmp, cpu_env, tmp, tmp2); \
-        break; \
-    default: return 1; \
-    }} while (0)
-
 static TCGv_i32 neon_load_scratch(int scratch)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
@@ -5252,7 +5229,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     int size;
     int shift;
     int pass;
-    int count;
     int u;
     int vec_size;
     uint32_t imm;
@@ -5302,6 +5278,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             case 3: /* VRSRA */
             case 4: /* VSRI */
             case 5: /* VSHL, VSLI */
+            case 6: /* VQSHLU */
+            case 7: /* VQSHL */
                 return 1; /* handled by decodetree */
             default:
                 break;
@@ -5319,89 +5297,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     size--;
             }
             shift = (insn >> 16) & ((1 << (3 + size)) - 1);
-            if (op < 8) {
-                /* Shift by immediate:
-                   VSHR, VSRA, VRSHR, VRSRA, VSRI, VSHL, VQSHL, VQSHLU.  */
-                if (q && ((rd | rm) & 1)) {
-                    return 1;
-                }
-                if (!u && (op == 4 || op == 6)) {
-                    return 1;
-                }
-                /* Right shifts are encoded as N - shift, where N is the
-                   element size in bits.  */
-                if (op <= 4) {
-                    shift = shift - (1 << (size + 3));
-                }
-
-                if (size == 3) {
-                    count = q + 1;
-                } else {
-                    count = q ? 4: 2;
-                }
-
-                /* To avoid excessive duplication of ops we implement shift
-                 * by immediate using the variable shift operations.
-                  */
-                imm = dup_const(size, shift);
-
-                for (pass = 0; pass < count; pass++) {
-                    if (size == 3) {
-                        neon_load_reg64(cpu_V0, rm + pass);
-                        tcg_gen_movi_i64(cpu_V1, imm);
-                        switch (op) {
-                        case 6: /* VQSHLU */
-                            gen_helper_neon_qshlu_s64(cpu_V0, cpu_env,
-                                                      cpu_V0, cpu_V1);
-                            break;
-                        case 7: /* VQSHL */
-                            if (u) {
-                                gen_helper_neon_qshl_u64(cpu_V0, cpu_env,
-                                                         cpu_V0, cpu_V1);
-                            } else {
-                                gen_helper_neon_qshl_s64(cpu_V0, cpu_env,
-                                                         cpu_V0, cpu_V1);
-                            }
-                            break;
-                        default:
-                            g_assert_not_reached();
-                        }
-                        neon_store_reg64(cpu_V0, rd + pass);
-                    } else { /* size < 3 */
-                        /* Operands in T0 and T1.  */
-                        tmp = neon_load_reg(rm, pass);
-                        tmp2 = tcg_temp_new_i32();
-                        tcg_gen_movi_i32(tmp2, imm);
-                        switch (op) {
-                        case 6: /* VQSHLU */
-                            switch (size) {
-                            case 0:
-                                gen_helper_neon_qshlu_s8(tmp, cpu_env,
-                                                         tmp, tmp2);
-                                break;
-                            case 1:
-                                gen_helper_neon_qshlu_s16(tmp, cpu_env,
-                                                          tmp, tmp2);
-                                break;
-                            case 2:
-                                gen_helper_neon_qshlu_s32(tmp, cpu_env,
-                                                          tmp, tmp2);
-                                break;
-                            default:
-                                abort();
-                            }
-                            break;
-                        case 7: /* VQSHL */
-                            GEN_NEON_INTEGER_OP_ENV(qshl);
-                            break;
-                        default:
-                            g_assert_not_reached();
-                        }
-                        tcg_temp_free_i32(tmp2);
-                        neon_store_reg(rd, pass, tmp);
-                    }
-                } /* for pass */
-            } else if (op < 10) {
+            if (op < 10) {
                 /* Shift by immediate and narrow:
                    VSHRN, VRSHRN, VQSHRN, VQRSHRN.  */
                 int input_unsigned = (op == 8) ? !u : u;
-- 
2.20.1



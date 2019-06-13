Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553F8C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185A52064A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNa8JizK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185A52064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39716 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPor-0005Ue-A5
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60056)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOeN-0000DY-7l
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOeF-0005OB-QL
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:16:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54474)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOe6-0004nO-SI
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:16:03 -0400
Received: by mail-wm1-x344.google.com with SMTP id g135so9953733wme.4
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5gtpw2YUK/SlJN0xIUzASKxApJAmaIC/1IkdztKlHx0=;
 b=UNa8JizKuD3noTjRRWXOi0qVIDZpZkTbDbpGSR+M99Rw9+nfjjk5UcNsXGAjb75E/d
 4P9aqhhPimpcu2HNpgluey1XDs2LNE8P+JAGtxz9UIDtlE0suJtfMRpD0/nsC4IOb+wL
 VoUJd6RBubV35YK2sHnjXjTlQKvbgAt66Nzgl158aulsq3bhZo+IxgvXwMxtPJGvHoyv
 OkBp6R3ntNcPr9SpVLZ2EBp/aHGflEkCkXPRQoy7EmA+XsPlFiM8gXGohoQhr23Qaz9N
 FoKSTEZQN0OnCUl3mIwFqV3C0DTkexSoKy9Iyv8tcQ9iVQ1AToe6JXZskqalXPT4eiUj
 k/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5gtpw2YUK/SlJN0xIUzASKxApJAmaIC/1IkdztKlHx0=;
 b=HtHdwLatQxsazZXLSu+kr0tgE1wMv4JCEKUdFHBMmtaJT0Q5aTX5qH3nlYLELZPC1w
 h0SjwtKO3HThrHSulClzoXCDFI6lGx48QY9ZdTtoR7GD4Ik7HxIhWAWxCGvVZvIbYQob
 ZNXEvx2+PCWDRr5pGnOCmNrxXRvnqydqUXJ2AESt5/yWsViZ5KHStv7ZPruBHc5V8SNY
 PBVf3YatWSoXZiJK6TblheyVfWaHQEr/q/bylw/0mBhluox3zMfyBBYfckSLY6EEnHsN
 RIVs/6ZNu6czndJc2u/uZaZqtY+1OzMf0T+b3Fg2+GbHwBwrv6tM2vAAARxT/VQjK6nj
 yUxQ==
X-Gm-Message-State: APjAAAW+eatYEdhDdm1HcCaAeMxRHD9fmy2hp7R8AF5Xx53r/cMsVab+
 0UAT5d63lp3yBgl1U1lz4eYv0CSsR4x1tw==
X-Google-Smtp-Source: APXvYqxRHNjzcJA5tnftSwf64b6oXCqoIiXghOZlM0ZJWrqg011cY6GI1TpJLnpgGfhvX+2EHyRQgg==
X-Received: by 2002:a05:600c:2149:: with SMTP id
 v9mr3470964wml.141.1560428125378; 
 Thu, 13 Jun 2019 05:15:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:32 +0100
Message-Id: <20190613121433.5246-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PULL 47/48] target/arm: Convert float-to-integer VCVT
 insns to decodetree
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

Convert the float-to-integer VCVT instructions to decodetree.
Since these are the last unconverted instructions, we can
delete the old decoder structure entirely now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c |  72 ++++++++++
 target/arm/translate.c         | 241 +--------------------------------
 target/arm/vfp.decode          |   6 +
 3 files changed, 80 insertions(+), 239 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index db07fdd8736..8216dba796e 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -2578,3 +2578,75 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
     tcg_temp_free_ptr(fpst);
     return true;
 }
+
+static bool trans_VCVT_sp_int(DisasContext *s, arg_VCVT_sp_int *a)
+{
+    TCGv_i32 vm;
+    TCGv_ptr fpst;
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(false);
+    vm = tcg_temp_new_i32();
+    neon_load_reg32(vm, a->vm);
+
+    if (a->s) {
+        if (a->rz) {
+            gen_helper_vfp_tosizs(vm, vm, fpst);
+        } else {
+            gen_helper_vfp_tosis(vm, vm, fpst);
+        }
+    } else {
+        if (a->rz) {
+            gen_helper_vfp_touizs(vm, vm, fpst);
+        } else {
+            gen_helper_vfp_touis(vm, vm, fpst);
+        }
+    }
+    neon_store_reg32(vm, a->vd);
+    tcg_temp_free_i32(vm);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
+
+static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
+{
+    TCGv_i32 vd;
+    TCGv_i64 vm;
+    TCGv_ptr fpst;
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vm & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(false);
+    vm = tcg_temp_new_i64();
+    vd = tcg_temp_new_i32();
+    neon_load_reg64(vm, a->vm);
+
+    if (a->s) {
+        if (a->rz) {
+            gen_helper_vfp_tosizd(vd, vm, fpst);
+        } else {
+            gen_helper_vfp_tosid(vd, vm, fpst);
+        }
+    } else {
+        if (a->rz) {
+            gen_helper_vfp_touizd(vd, vm, fpst);
+        } else {
+            gen_helper_vfp_touid(vd, vm, fpst);
+        }
+    }
+    neon_store_reg32(vd, a->vd);
+    tcg_temp_free_i32(vd);
+    tcg_temp_free_i64(vm);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d7a77fca9ac..4a66a35a7f6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1418,9 +1418,7 @@ static inline void gen_vfp_##name(int dp, int neon) \
     tcg_temp_free_ptr(statusptr); \
 }
 
-VFP_GEN_FTOI(toui)
 VFP_GEN_FTOI(touiz)
-VFP_GEN_FTOI(tosi)
 VFP_GEN_FTOI(tosiz)
 #undef VFP_GEN_FTOI
 
@@ -1612,33 +1610,7 @@ static TCGv_ptr vfp_reg_ptr(bool dp, int reg)
 }
 
 #define tcg_gen_ld_f32 tcg_gen_ld_i32
-#define tcg_gen_ld_f64 tcg_gen_ld_i64
 #define tcg_gen_st_f32 tcg_gen_st_i32
-#define tcg_gen_st_f64 tcg_gen_st_i64
-
-static inline void gen_mov_F0_vreg(int dp, int reg)
-{
-    if (dp)
-        tcg_gen_ld_f64(cpu_F0d, cpu_env, vfp_reg_offset(dp, reg));
-    else
-        tcg_gen_ld_f32(cpu_F0s, cpu_env, vfp_reg_offset(dp, reg));
-}
-
-static inline void gen_mov_F1_vreg(int dp, int reg)
-{
-    if (dp)
-        tcg_gen_ld_f64(cpu_F1d, cpu_env, vfp_reg_offset(dp, reg));
-    else
-        tcg_gen_ld_f32(cpu_F1s, cpu_env, vfp_reg_offset(dp, reg));
-}
-
-static inline void gen_mov_vreg_F0(int dp, int reg)
-{
-    if (dp)
-        tcg_gen_st_f64(cpu_F0d, cpu_env, vfp_reg_offset(dp, reg));
-    else
-        tcg_gen_st_f32(cpu_F0s, cpu_env, vfp_reg_offset(dp, reg));
-}
 
 #define ARM_CP_RW_BIT   (1 << 20)
 
@@ -2983,9 +2955,6 @@ static void gen_neon_dup_high16(TCGv_i32 var)
  */
 static int disas_vfp_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t rd, rn, rm, op, delta_d, delta_m, bank_mask;
-    int dp, veclen;
-
     if (!arm_dc_feature(s, ARM_FEATURE_VFP)) {
         return 1;
     }
@@ -3005,214 +2974,8 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             return 0;
         }
     }
-
-    if (extract32(insn, 28, 4) == 0xf) {
-        /*
-         * Encodings with T=1 (Thumb) or unconditional (ARM): these
-         * were all handled by the decodetree decoder, so any insn
-         * patterns which get here must be UNDEF.
-         */
-        return 1;
-    }
-
-    /*
-     * FIXME: this access check should not take precedence over UNDEF
-     * for invalid encodings; we will generate incorrect syndrome information
-     * for attempts to execute invalid vfp/neon encodings with FP disabled.
-     */
-    if (!vfp_access_check(s)) {
-        return 0;
-    }
-
-    dp = ((insn & 0xf00) == 0xb00);
-    switch ((insn >> 24) & 0xf) {
-    case 0xe:
-        if (insn & (1 << 4)) {
-            /* already handled by decodetree */
-            return 1;
-        } else {
-            /* data processing */
-            bool rd_is_dp = dp;
-            bool rm_is_dp = dp;
-            bool no_output = false;
-
-            /* The opcode is in bits 23, 21, 20 and 6.  */
-            op = ((insn >> 20) & 8) | ((insn >> 19) & 6) | ((insn >> 6) & 1);
-            rn = VFP_SREG_N(insn);
-
-            switch (op) {
-            case 0 ... 14:
-                /* Already handled by decodetree */
-                return 1;
-            case 15:
-                switch (rn) {
-                case 0 ... 23:
-                case 28 ... 31:
-                    /* Already handled by decodetree */
-                    return 1;
-                default:
-                    break;
-                }
-            default:
-                break;
-            }
-
-            if (op == 15) {
-                /* rn is opcode, encoded as per VFP_SREG_N. */
-                switch (rn) {
-                case 0x18: /* vcvtr.u32.fxx */
-                case 0x19: /* vcvtz.u32.fxx */
-                case 0x1a: /* vcvtr.s32.fxx */
-                case 0x1b: /* vcvtz.s32.fxx */
-                    rd_is_dp = false;
-                    break;
-
-                default:
-                    return 1;
-                }
-            } else if (dp) {
-                /* rn is register number */
-                VFP_DREG_N(rn, insn);
-            }
-
-            if (rd_is_dp) {
-                VFP_DREG_D(rd, insn);
-            } else {
-                rd = VFP_SREG_D(insn);
-            }
-            if (rm_is_dp) {
-                VFP_DREG_M(rm, insn);
-            } else {
-                rm = VFP_SREG_M(insn);
-            }
-
-            veclen = s->vec_len;
-            if (op == 15 && rn > 3) {
-                veclen = 0;
-            }
-
-            /* Shut up compiler warnings.  */
-            delta_m = 0;
-            delta_d = 0;
-            bank_mask = 0;
-
-            if (veclen > 0) {
-                if (dp)
-                    bank_mask = 0xc;
-                else
-                    bank_mask = 0x18;
-
-                /* Figure out what type of vector operation this is.  */
-                if ((rd & bank_mask) == 0) {
-                    /* scalar */
-                    veclen = 0;
-                } else {
-                    if (dp)
-                        delta_d = (s->vec_stride >> 1) + 1;
-                    else
-                        delta_d = s->vec_stride + 1;
-
-                    if ((rm & bank_mask) == 0) {
-                        /* mixed scalar/vector */
-                        delta_m = 0;
-                    } else {
-                        /* vector */
-                        delta_m = delta_d;
-                    }
-                }
-            }
-
-            /* Load the initial operands.  */
-            if (op == 15) {
-                switch (rn) {
-                default:
-                    /* One source operand.  */
-                    gen_mov_F0_vreg(rm_is_dp, rm);
-                    break;
-                }
-            } else {
-                /* Two source operands.  */
-                gen_mov_F0_vreg(dp, rn);
-                gen_mov_F1_vreg(dp, rm);
-            }
-
-            for (;;) {
-                /* Perform the calculation.  */
-                switch (op) {
-                case 15: /* extension space */
-                    switch (rn) {
-                    case 24: /* ftoui */
-                        gen_vfp_toui(dp, 0);
-                        break;
-                    case 25: /* ftouiz */
-                        gen_vfp_touiz(dp, 0);
-                        break;
-                    case 26: /* ftosi */
-                        gen_vfp_tosi(dp, 0);
-                        break;
-                    case 27: /* ftosiz */
-                        gen_vfp_tosiz(dp, 0);
-                        break;
-                    default: /* undefined */
-                        g_assert_not_reached();
-                    }
-                    break;
-                default: /* undefined */
-                    return 1;
-                }
-
-                /* Write back the result, if any.  */
-                if (!no_output) {
-                    gen_mov_vreg_F0(rd_is_dp, rd);
-                }
-
-                /* break out of the loop if we have finished  */
-                if (veclen == 0) {
-                    break;
-                }
-
-                if (op == 15 && delta_m == 0) {
-                    /* single source one-many */
-                    while (veclen--) {
-                        rd = ((rd + delta_d) & (bank_mask - 1))
-                             | (rd & bank_mask);
-                        gen_mov_vreg_F0(dp, rd);
-                    }
-                    break;
-                }
-                /* Setup the next operands.  */
-                veclen--;
-                rd = ((rd + delta_d) & (bank_mask - 1))
-                     | (rd & bank_mask);
-
-                if (op == 15) {
-                    /* One source operand.  */
-                    rm = ((rm + delta_m) & (bank_mask - 1))
-                         | (rm & bank_mask);
-                    gen_mov_F0_vreg(dp, rm);
-                } else {
-                    /* Two source operands.  */
-                    rn = ((rn + delta_d) & (bank_mask - 1))
-                         | (rn & bank_mask);
-                    gen_mov_F0_vreg(dp, rn);
-                    if (delta_m) {
-                        rm = ((rm + delta_m) & (bank_mask - 1))
-                             | (rm & bank_mask);
-                        gen_mov_F1_vreg(dp, rm);
-                    }
-                }
-            }
-        }
-        break;
-    case 0xc:
-    case 0xd:
-        /* Already handled by decodetree */
-        return 1;
-    default:
-        /* Should never happen.  */
-        return 1;
-    }
-    return 0;
+    /* If the decodetree decoder didn't handle this insn, it must be UNDEF */
+    return 1;
 }
 
 static inline bool use_goto_tb(DisasContext *s, target_ulong dest)
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index c3223a124ac..ea24365bb4c 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -234,3 +234,9 @@ VCVT_fix_sp  ---- 1110 1.11 1.1. .... 1010 .1.0 .... \
              vd=%vd_sp imm=%vm_sp opc=%vcvt_fix_op
 VCVT_fix_dp  ---- 1110 1.11 1.1. .... 1011 .1.0 .... \
              vd=%vd_dp imm=%vm_sp opc=%vcvt_fix_op
+
+# VCVT float to integer (VCVT and VCVTR): Vd always single; Vd depends on size
+VCVT_sp_int  ---- 1110 1.11 110 s:1 .... 1010 rz:1 1.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VCVT_dp_int  ---- 1110 1.11 110 s:1 .... 1011 rz:1 1.0 .... \
+             vd=%vd_sp vm=%vm_dp
-- 
2.20.1



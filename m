Received: from eggs.gnu.org ([209.51.188.92]:57203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1guOVD-00034z-Jf
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 16:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1guOSO-0002h3-0B
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 16:22:11 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1guOSN-0002Ic-Jk
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 16:22:07 -0500
Received: by mail-pl1-x642.google.com with SMTP id r14so3784318pls.12
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 13:21:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Feb 2019 13:21:43 -0800
Message-Id: <20190214212144.12784-3-richard.henderson@linaro.org>
In-Reply-To: <20190214212144.12784-1-richard.henderson@linaro.org>
References: <20190214212144.12784-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 2/3] target/arm: Rearrange decode of
 Floating-point data-processing (2 regs)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

There are lots of special cases within these insns.  Split the
major argument decode/loading/saving into no_output (compares),
rd_is_dp, and rm_is_dp.

We still need to special case argument load for compare (rd as
input, rm as zero) and vcvt fixed (rd as input+output), but lots
of special cases do disappear.

Now that we have a full switch at the beginning, hoist the ISA
checks from the code generation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 227 ++++++++++++++++++++---------------------
 1 file changed, 111 insertions(+), 116 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index dac737f6ca..64c5fe0df3 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3639,52 +3639,108 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             }
         } else {
             /* data processing */
+            bool rd_is_dp = dp;
+            bool rm_is_dp = dp;
+            bool no_output = false;
+
             /* The opcode is in bits 23, 21, 20 and 6.  */
             op = ((insn >> 20) & 8) | ((insn >> 19) & 6) | ((insn >> 6) & 1);
-            if (dp) {
-                if (op == 15) {
-                    /* rn is opcode */
-                    rn = ((insn >> 15) & 0x1e) | ((insn >> 7) & 1);
-                } else {
-                    /* rn is register number */
-                    VFP_DREG_N(rn, insn);
-                }
+            rn = VFP_SREG_N(insn);
 
-                if (op == 15 && (rn == 15 || ((rn & 0x1c) == 0x18) ||
-                                 ((rn & 0x1e) == 0x6))) {
-                    /* Integer or single/half precision destination.  */
-                    rd = VFP_SREG_D(insn);
-                } else {
-                    VFP_DREG_D(rd, insn);
-                }
-                if (op == 15 &&
-                    (((rn & 0x1c) == 0x10) || ((rn & 0x14) == 0x14) ||
-                     ((rn & 0x1e) == 0x4))) {
-                    /* VCVT from int or half precision is always from S reg
-                     * regardless of dp bit. VCVT with immediate frac_bits
-                     * has same format as SREG_M.
+            if (op == 15) {
+                /* rn is opcode, encoded as per VFP_SREG_N. */
+                switch (rn) {
+                case 0x00: /* vmov */
+                case 0x01: /* vabs */
+                case 0x02: /* vneg */
+                case 0x03: /* vsqrt */
+                    break;
+
+                case 0x04: /* vcvtb.f64.f16, vcvtb.f32.f16 */
+                case 0x05: /* vcvtt.f64.f16, vcvtt.f32.f16 */
+                    /*
+                     * VCVTB, VCVTT: only present with the halfprec extension
+                     * UNPREDICTABLE if bit 8 is set prior to ARMv8
+                     * (we choose to UNDEF)
                      */
-                    rm = VFP_SREG_M(insn);
-                } else {
-                    VFP_DREG_M(rm, insn);
+                    if ((dp && !arm_dc_feature(s, ARM_FEATURE_V8)) ||
+                        !arm_dc_feature(s, ARM_FEATURE_VFP_FP16)) {
+                        return 1;
+                    }
+                    rm_is_dp = false;
+                    break;
+                case 0x06: /* vcvtb.f16.f32, vcvtb.f16.f64 */
+                case 0x07: /* vcvtt.f16.f32, vcvtt.f16.f64 */
+                    if ((dp && !arm_dc_feature(s, ARM_FEATURE_V8)) ||
+                        !arm_dc_feature(s, ARM_FEATURE_VFP_FP16)) {
+                        return 1;
+                    }
+                    rd_is_dp = false;
+                    break;
+
+                case 0x08: case 0x0a: /* vcmp, vcmpz */
+                case 0x09: case 0x0b: /* vcmpe, vcmpez */
+                    no_output = true;
+                    break;
+
+                case 0x0c: /* vrintr */
+                case 0x0d: /* vrintz */
+                case 0x0e: /* vrintx */
+                    break;
+
+                case 0x0f: /* vcvt double<->single */
+                    rd_is_dp = !dp;
+                    break;
+
+                case 0x10: /* vcvt.fxx.u32 */
+                case 0x11: /* vcvt.fxx.s32 */
+                    rm_is_dp = false;
+                    break;
+                case 0x18: /* vcvtr.u32.fxx */
+                case 0x19: /* vcvtz.u32.fxx */
+                case 0x1a: /* vcvtr.s32.fxx */
+                case 0x1b: /* vcvtz.s32.fxx */
+                    rd_is_dp = false;
+                    break;
+
+                case 0x14: /* vcvt fp <-> fixed */
+                case 0x15:
+                case 0x16:
+                case 0x17:
+                case 0x1c:
+                case 0x1d:
+                case 0x1e:
+                case 0x1f:
+                    if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
+                        return 1;
+                    }
+                    /* Immediate frac_bits has same format as SREG_M.  */
+                    rm_is_dp = false;
+                    break;
+
+                default:
+                    return 1;
                 }
+            } else if (dp) {
+                /* rn is register number */
+                VFP_DREG_N(rn, insn);
+            }
+
+            if (rd_is_dp) {
+                VFP_DREG_D(rd, insn);
+            } else {
+                rd = VFP_SREG_D(insn);
+            }
+            if (rm_is_dp) {
+                VFP_DREG_M(rm, insn);
             } else {
-                rn = VFP_SREG_N(insn);
-                if (op == 15 && rn == 15) {
-                    /* Double precision destination.  */
-                    VFP_DREG_D(rd, insn);
-                } else {
-                    rd = VFP_SREG_D(insn);
-                }
-                /* NB that we implicitly rely on the encoding for the frac_bits
-                 * in VCVT of fixed to float being the same as that of an SREG_M
-                 */
                 rm = VFP_SREG_M(insn);
             }
 
             veclen = s->vec_len;
-            if (op == 15 && rn > 3)
+            if (op == 15 && rn > 3) {
                 veclen = 0;
+            }
 
             /* Shut up compiler warnings.  */
             delta_m = 0;
@@ -3720,55 +3776,28 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             /* Load the initial operands.  */
             if (op == 15) {
                 switch (rn) {
-                case 16:
-                case 17:
-                    /* Integer source */
-                    gen_mov_F0_vreg(0, rm);
-                    break;
-                case 8:
-                case 9:
-                    /* Compare */
+                case 0x08: case 0x09: /* Compare */
                     gen_mov_F0_vreg(dp, rd);
                     gen_mov_F1_vreg(dp, rm);
                     break;
-                case 10:
-                case 11:
-                    /* Compare with zero */
+                case 0x0a: case 0x0b: /* Compare with zero */
                     gen_mov_F0_vreg(dp, rd);
                     gen_vfp_F1_ld0(dp);
                     break;
-                case 20:
-                case 21:
-                case 22:
-                case 23:
-                case 28:
-                case 29:
-                case 30:
-                case 31:
+                case 0x14: /* vcvt fp <-> fixed */
+                case 0x15:
+                case 0x16:
+                case 0x17:
+                case 0x1c:
+                case 0x1d:
+                case 0x1e:
+                case 0x1f:
                     /* Source and destination the same.  */
                     gen_mov_F0_vreg(dp, rd);
                     break;
-                case 4:
-                case 5:
-                case 6:
-                case 7:
-                    /* VCVTB, VCVTT: only present with the halfprec extension
-                     * UNPREDICTABLE if bit 8 is set prior to ARMv8
-                     * (we choose to UNDEF)
-                     */
-                    if ((dp && !arm_dc_feature(s, ARM_FEATURE_V8)) ||
-                        !arm_dc_feature(s, ARM_FEATURE_VFP_FP16)) {
-                        return 1;
-                    }
-                    if (!extract32(rn, 1, 1)) {
-                        /* Half precision source.  */
-                        gen_mov_F0_vreg(0, rm);
-                        break;
-                    }
-                    /* Otherwise fall through */
                 default:
                     /* One source operand.  */
-                    gen_mov_F0_vreg(dp, rm);
+                    gen_mov_F0_vreg(rm_is_dp, rm);
                     break;
                 }
             } else {
@@ -4047,10 +4076,11 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                         break;
                     }
                     case 15: /* single<->double conversion */
-                        if (dp)
+                        if (dp) {
                             gen_helper_vfp_fcvtsd(cpu_F0s, cpu_F0d, cpu_env);
-                        else
+                        } else {
                             gen_helper_vfp_fcvtds(cpu_F0d, cpu_F0s, cpu_env);
+                        }
                         break;
                     case 16: /* fuito */
                         gen_vfp_uito(dp, 0);
@@ -4059,27 +4089,15 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                         gen_vfp_sito(dp, 0);
                         break;
                     case 20: /* fshto */
-                        if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
-                            return 1;
-                        }
                         gen_vfp_shto(dp, 16 - rm, 0);
                         break;
                     case 21: /* fslto */
-                        if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
-                            return 1;
-                        }
                         gen_vfp_slto(dp, 32 - rm, 0);
                         break;
                     case 22: /* fuhto */
-                        if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
-                            return 1;
-                        }
                         gen_vfp_uhto(dp, 16 - rm, 0);
                         break;
                     case 23: /* fulto */
-                        if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
-                            return 1;
-                        }
                         gen_vfp_ulto(dp, 32 - rm, 0);
                         break;
                     case 24: /* ftoui */
@@ -4095,57 +4113,34 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                         gen_vfp_tosiz(dp, 0);
                         break;
                     case 28: /* ftosh */
-                        if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
-                            return 1;
-                        }
                         gen_vfp_tosh(dp, 16 - rm, 0);
                         break;
                     case 29: /* ftosl */
-                        if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
-                            return 1;
-                        }
                         gen_vfp_tosl(dp, 32 - rm, 0);
                         break;
                     case 30: /* ftouh */
-                        if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
-                            return 1;
-                        }
                         gen_vfp_touh(dp, 16 - rm, 0);
                         break;
                     case 31: /* ftoul */
-                        if (!arm_dc_feature(s, ARM_FEATURE_VFP3)) {
-                            return 1;
-                        }
                         gen_vfp_toul(dp, 32 - rm, 0);
                         break;
                     default: /* undefined */
-                        return 1;
+                        g_assert_not_reached();
                     }
                     break;
                 default: /* undefined */
                     return 1;
                 }
 
-                /* Write back the result.  */
-                if (op == 15 && (rn >= 8 && rn <= 11)) {
-                    /* Comparison, do nothing.  */
-                } else if (op == 15 && dp && ((rn & 0x1c) == 0x18 ||
-                                              (rn & 0x1e) == 0x6)) {
-                    /* VCVT double to int: always integer result.
-                     * VCVT double to half precision is always a single
-                     * precision result.
-                     */
-                    gen_mov_vreg_F0(0, rd);
-                } else if (op == 15 && rn == 15) {
-                    /* conversion */
-                    gen_mov_vreg_F0(!dp, rd);
-                } else {
-                    gen_mov_vreg_F0(dp, rd);
+                /* Write back the result, if any.  */
+                if (!no_output) {
+                    gen_mov_vreg_F0(rd_is_dp, rd);
                 }
 
                 /* break out of the loop if we have finished  */
-                if (veclen == 0)
+                if (veclen == 0) {
                     break;
+                }
 
                 if (op == 15 && delta_m == 0) {
                     /* single source one-many */
-- 
2.17.2

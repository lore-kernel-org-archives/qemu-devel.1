Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D8EC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAE29218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jMfWkLTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE29218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4QX-0001kr-EN
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57779)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mu-00032X-Sm
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Ms-00085f-Rt
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:00 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43172)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Ms-000848-J9
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:58 -0400
Received: by mail-pl1-x641.google.com with SMTP id 4so18030380pld.10
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=huKGKNTHhMAQYotnG12iGCpac4tzd+qILlBM8dReHjw=;
 b=jMfWkLTryN7tAbDeHKBPic2jIb1HBpMyRuEeMb8G2f4qeSgDIv/W6wxA2HcZjix8EB
 gfgqObU8D4SqtRPvBh0HYDwZba1Hq0KN9DbcFqLyoWNDMpxu/lFCM9qRoNj1mpHSOc9c
 CzN9kDtOVk+B5pk96pfv2vPDjUS4AQsDsvQBM3V6z3BOVsimbUVFafnoSFKrveexDrMM
 Y0lhn86ttRdgzqc87XySdU7ZMv/B3N8hVqAofAxeI7bxJKbjxiyBFGne8cy+cHfM4MPh
 KGNHeKV++/1IfYVKckZXkb2yKtbjEYvA4JsLLPHQKCUVpiqlC9UBjZ8pg0l97kqU3dxU
 vutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=huKGKNTHhMAQYotnG12iGCpac4tzd+qILlBM8dReHjw=;
 b=C+oiaEAUzQdj1eNSAZ9LfCHK8K8smPrc4vecifJyN5eQNo5sCkcc9Cu+WQl+i6Be++
 xVKS8zPyYhmJlwyyxmQe6qNSUJWx7Z860Z3fSt/XnBvyfZI0ku8dxfwHcwKZB3BTFPuv
 6n2/EXhuptkOVs3kIX3XjVMCS2ojVMdDAdRF5+9tPUi1fWKvbcfS6D5rkO+tZoNmMQ1j
 TSviv2j6ot4JAav4isauOFmUm8Qh0AHeSYUvxpVUqDrC1czAROG+bZzR1P35bktoO+Aa
 hkL5ZkGTATgJcnFM+TAmZzy8H1LpLO1WQmxV8o6MjwlCF7+qsD10TjKP4Rey2Cazrl4V
 rHoA==
X-Gm-Message-State: APjAAAUv3px7NioNbhGZLiiNOckwFY1Qbq/1+Gqk1mz2s0pUoB0N44ew
 +YxNEBEUrKM7O7aeOX+jmNJAAOdJ+fA=
X-Google-Smtp-Source: APXvYqwZqsv0eJvuvhu4OfYCsv6JCaxxFMHhQg3XPvajEI5huoVWC22Sf/0mo+5iFkQu07nnFa9WKA==
X-Received: by 2002:a17:902:a612:: with SMTP id
 u18mr94716011plq.181.1564163457290; 
 Fri, 26 Jul 2019 10:50:57 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.50.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:50:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:45 -0700
Message-Id: <20190726175032.6769-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH 20/67] target/arm: Convert the rest of A32
 Miscelaneous instructions
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes an exiting bug with the T5 encoding of SUBS PC, LR, #IMM,
in that it may be executed from user mode as with any other encoding
of SUBS, not as ERET.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 273 +++++++++++++++--------------------------
 target/arm/a32.decode  |  21 ++++
 target/arm/t32.decode  |  20 +++
 3 files changed, 143 insertions(+), 171 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ed7041d0e4..09310b1c3a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8500,6 +8500,101 @@ static bool trans_MSR_v7m(DisasContext *s, arg_MSR_v7m *a)
     return true;
 }
 
+static bool trans_BX(DisasContext *s, arg_BX *a)
+{
+    if (!ENABLE_ARCH_4T) {
+        return false;
+    }
+    gen_bx(s, load_reg(s, a->rm));
+    return true;
+}
+
+static bool trans_BXJ(DisasContext *s, arg_BXJ *a)
+{
+    if (!ENABLE_ARCH_5J || arm_dc_feature(s, ARM_FEATURE_M)) {
+        return false;
+    }
+    /* Trivial implementation equivalent to bx.  */
+    gen_bx(s, load_reg(s, a->rm));
+    return true;
+}
+
+static bool trans_BLX_r(DisasContext *s, arg_BLX_r *a)
+{
+    TCGv_i32 tmp;
+
+    if (!ENABLE_ARCH_5) {
+        return false;
+    }
+    tmp = load_reg(s, a->rm);
+    tcg_gen_movi_i32(cpu_R[14], s->pc | s->thumb);
+    gen_bx(s, tmp);
+    return true;
+}
+
+static bool trans_CLZ(DisasContext *s, arg_CLZ *a)
+{
+    TCGv_i32 tmp;
+
+    if (!ENABLE_ARCH_5) {
+        return false;
+    }
+    tmp = load_reg(s, a->rm);
+    tcg_gen_clzi_i32(tmp, tmp, 32);
+    store_reg(s, a->rd, tmp);
+    return true;
+}
+
+static bool trans_ERET(DisasContext *s, arg_ERET *a)
+{
+    TCGv_i32 tmp;
+
+    if (IS_USER(s) || !arm_dc_feature(s, ARM_FEATURE_V7VE)) {
+        return false;
+    }
+    if (s->current_el == 2) {
+        /* ERET from Hyp uses ELR_Hyp, not LR */
+        tmp = load_cpu_field(elr_el[2]);
+    } else {
+        tmp = load_reg(s, 14);
+    }
+    gen_exception_return(s, tmp);
+    return true;
+}
+
+static bool trans_HLT(DisasContext *s, arg_HLT *a)
+{
+    gen_hlt(s, a->imm);
+    return true;
+}
+
+static bool trans_BKPT(DisasContext *s, arg_BKPT *a)
+{
+    if (!ENABLE_ARCH_5) {
+        return false;
+    }
+    gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, false));
+    return true;
+}
+
+static bool trans_HVC(DisasContext *s, arg_HVC *a)
+{
+    if (!ENABLE_ARCH_7 || IS_USER(s) || arm_dc_feature(s, ARM_FEATURE_M)) {
+        return false;
+    }
+    gen_hvc(s, a->imm);
+    return true;
+}
+
+static bool trans_SMC(DisasContext *s, arg_SMC *a)
+{
+    if (!ENABLE_ARCH_6K || IS_USER(s) || arm_dc_feature(s, ARM_FEATURE_M)) {
+        return false;
+    }
+    gen_smc(s);
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -8777,124 +8872,8 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
     } else if ((insn & 0x0f900000) == 0x01000000
                && (insn & 0x00000090) != 0x00000090) {
         /* miscellaneous instructions */
-        op1 = (insn >> 21) & 3;
-        sh = (insn >> 4) & 0xf;
-        rm = insn & 0xf;
-        switch (sh) {
-        case 0x0:
-            /* MSR/MRS (banked/register) */
-            /* All done in decodetree.  Illegal ops already signalled.  */
-            g_assert_not_reached();
-        case 0x1:
-            if (op1 == 1) {
-                /* branch/exchange thumb (bx).  */
-                ARCH(4T);
-                tmp = load_reg(s, rm);
-                gen_bx(s, tmp);
-            } else if (op1 == 3) {
-                /* clz */
-                ARCH(5);
-                rd = (insn >> 12) & 0xf;
-                tmp = load_reg(s, rm);
-                tcg_gen_clzi_i32(tmp, tmp, 32);
-                store_reg(s, rd, tmp);
-            } else {
-                goto illegal_op;
-            }
-            break;
-        case 0x2:
-            if (op1 == 1) {
-                ARCH(5J); /* bxj */
-                /* Trivial implementation equivalent to bx.  */
-                tmp = load_reg(s, rm);
-                gen_bx(s, tmp);
-            } else {
-                goto illegal_op;
-            }
-            break;
-        case 0x3:
-            if (op1 != 1)
-              goto illegal_op;
-
-            ARCH(5);
-            /* branch link/exchange thumb (blx) */
-            tmp = load_reg(s, rm);
-            tmp2 = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp2, s->pc);
-            store_reg(s, 14, tmp2);
-            gen_bx(s, tmp);
-            break;
-        case 0x4:
-            /* crc32 */
-            /* All done in decodetree.  Illegal ops reach here.  */
-            goto illegal_op;
-        case 0x5:
-            /* Saturating addition and subtraction.  */
-            /* All done in decodetree.  Reach here for illegal ops.  */
-            goto illegal_op;
-        case 0x6: /* ERET */
-            if (op1 != 3) {
-                goto illegal_op;
-            }
-            if (!arm_dc_feature(s, ARM_FEATURE_V7VE)) {
-                goto illegal_op;
-            }
-            if ((insn & 0x000fff0f) != 0x0000000e) {
-                /* UNPREDICTABLE; we choose to UNDEF */
-                goto illegal_op;
-            }
-
-            if (s->current_el == 2) {
-                tmp = load_cpu_field(elr_el[2]);
-            } else {
-                tmp = load_reg(s, 14);
-            }
-            gen_exception_return(s, tmp);
-            break;
-        case 7:
-        {
-            int imm16 = extract32(insn, 0, 4) | (extract32(insn, 8, 12) << 4);
-            switch (op1) {
-            case 0:
-                /* HLT */
-                gen_hlt(s, imm16);
-                break;
-            case 1:
-                /* bkpt */
-                ARCH(5);
-                gen_exception_bkpt_insn(s, syn_aa32_bkpt(imm16, false));
-                break;
-            case 2:
-                /* Hypervisor call (v7) */
-                ARCH(7);
-                if (IS_USER(s)) {
-                    goto illegal_op;
-                }
-                gen_hvc(s, imm16);
-                break;
-            case 3:
-                /* Secure monitor call (v6+) */
-                ARCH(6K);
-                if (IS_USER(s)) {
-                    goto illegal_op;
-                }
-                gen_smc(s);
-                break;
-            default:
-                g_assert_not_reached();
-            }
-            break;
-        }
-        case 0x8:
-        case 0xa:
-        case 0xc:
-        case 0xe:
-            /* Halfword multiply and multiply accumulate.  */
-            /* All done in decodetree.  Reach here for illegal ops.  */
-            goto illegal_op;
-        default:
-            goto illegal_op;
-        }
+        /* All done in decodetree.  Illegal ops reach here.  */
+        goto illegal_op;
     } else if (((insn & 0x0e000000) == 0 &&
                 (insn & 0x00000090) != 0x90) ||
                ((insn & 0x0e000000) == (1 << 25))) {
@@ -10270,13 +10249,13 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 case 0x08: /* rev */
                 case 0x09: /* rev16 */
                 case 0x0b: /* revsh */
-                case 0x18: /* clz */
                     break;
                 case 0x10: /* sel */
                     if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
                         goto illegal_op;
                     }
                     break;
+                case 0x18: /* clz, in decodetree */
                 case 0x20: /* crc32/crc32c, in decodetree */
                 case 0x21:
                 case 0x22:
@@ -10309,9 +10288,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     tcg_temp_free_i32(tmp3);
                     tcg_temp_free_i32(tmp2);
                     break;
-                case 0x18: /* clz */
-                    tcg_gen_clzi_i32(tmp, tmp, 32);
-                    break;
                 default:
                     g_assert_not_reached();
                 }
@@ -10578,26 +10554,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     goto illegal_op;
 
                 if (insn & (1 << 26)) {
-                    if (arm_dc_feature(s, ARM_FEATURE_M)) {
-                        goto illegal_op;
-                    }
-                    if (!(insn & (1 << 20))) {
-                        /* Hypervisor call (v7) */
-                        int imm16 = extract32(insn, 16, 4) << 12
-                            | extract32(insn, 0, 12);
-                        ARCH(7);
-                        if (IS_USER(s)) {
-                            goto illegal_op;
-                        }
-                        gen_hvc(s, imm16);
-                    } else {
-                        /* Secure monitor call (v6+) */
-                        ARCH(6K);
-                        if (IS_USER(s)) {
-                            goto illegal_op;
-                        }
-                        gen_smc(s);
-                    }
+                    /* hvc, smc, in decodetree */
+                    goto illegal_op;
                 } else {
                     op = (insn >> 20) & 7;
                     switch (op) {
@@ -10666,35 +10624,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                             goto illegal_op;
                         }
                         break;
-                    case 4: /* bxj */
-                        /* Trivial implementation equivalent to bx.
-                         * This instruction doesn't exist at all for M-profile.
-                         */
-                        if (arm_dc_feature(s, ARM_FEATURE_M)) {
-                            goto illegal_op;
-                        }
-                        tmp = load_reg(s, rn);
-                        gen_bx(s, tmp);
-                        break;
-                    case 5: /* Exception return.  */
-                        if (IS_USER(s)) {
-                            goto illegal_op;
-                        }
-                        if (rn != 14 || rd != 15) {
-                            goto illegal_op;
-                        }
-                        if (s->current_el == 2) {
-                            /* ERET from Hyp uses ELR_Hyp, not LR */
-                            if (insn & 0xff) {
-                                goto illegal_op;
-                            }
-                            tmp = load_cpu_field(elr_el[2]);
-                        } else {
-                            tmp = load_reg(s, rn);
-                            tcg_gen_subi_i32(tmp, tmp, insn & 0xff);
-                        }
-                        gen_exception_return(s, tmp);
-                        break;
+                    case 4: /* bxj, in decodetree */
+                    case 5: /* eret, in decodetree */
                     case 6: /* MRS, in decodetree */
                     case 7: /* MSR, in decodetree */
                         goto illegal_op;
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 5751e615cd..32d1833037 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -29,6 +29,9 @@
 &s_rrrr          s rd rn rm ra
 &rrrr            rd rn rm ra
 &rrr             rd rn rm
+&rr              rd rm
+&r               rm
+&i               imm
 &msr_reg         rn r mask
 &mrs_reg         rd r
 &msr_bank        rn r sysm
@@ -194,9 +197,27 @@ CRC32CW          .... 0001 0100 .... .... 0010 0100 ....      @rndm
 # Miscellaneous instructions
 
 %sysm            8:1 16:4
+%imm16_8_0       8:12 0:4
+
+@rm              ---- .... .... .... .... .... .... rm:4      &r
+@rdm             ---- .... .... .... rd:4 .... .... rm:4      &rr
+@i16             ---- .... .... .... .... .... .... ....      &i imm=%imm16_8_0
 
 MRS_bank         ---- 0001 0 r:1 00 .... rd:4 001. 0000 0000  &mrs_bank %sysm
 MSR_bank         ---- 0001 0 r:1 10 .... 1111 001. 0000 rn:4  &msr_bank %sysm
 
 MRS_reg          ---- 0001 0 r:1 00 1111   rd:4 0000 0000 0000  &mrs_reg
 MSR_reg          ---- 0001 0 r:1 10 mask:4 1111 0000 0000 rn:4  &msr_reg
+
+BX               .... 0001 0010 1111 1111 1111 0001 ....      @rm
+BXJ              .... 0001 0010 1111 1111 1111 0010 ....      @rm
+BLX_r            .... 0001 0010 1111 1111 1111 0011 ....      @rm
+
+CLZ              .... 0001 0110 1111 .... 1111 0001 ....      @rdm
+
+ERET             ---- 0001 0110 0000 0000 0000 0110 1110
+
+HLT              .... 0001 0000 .... .... .... 0111 ....      @i16
+BKPT             .... 0001 0010 .... .... .... 0111 ....      @i16
+HVC              .... 0001 0100 .... .... .... 0111 ....      @i16
+SMC              ---- 0001 0110 0000 0000 0000 0111 imm:4     &i
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 30971787d4..abd233180d 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -26,6 +26,9 @@
 &s_rrrr          !extern s rd rn rm ra
 &rrrr            !extern rd rn rm ra
 &rrr             !extern rd rn rm
+&rr              !extern rd rm
+&r               !extern rm
+&i               !extern imm
 &msr_reg         !extern rn r mask
 &mrs_reg         !extern rd r
 &msr_bank        !extern rn r sysm
@@ -125,6 +128,7 @@ RSB_rri          1111 0.0 1110 . .... 0 ... .... ........     @s_rri_rot
 @rnadm           .... .... .... rn:4 ra:4 rd:4 .... rm:4      &rrrr
 @rn0dm           .... .... .... rn:4 .... rd:4 .... rm:4      &rrrr ra=0
 @rndm            .... .... .... rn:4 .... rd:4 .... rm:4      &rrr
+@rdm             .... .... .... .... .... rd:4 .... rm:4      &rr
 
 {
   MUL            1111 1011 0000 .... 1111 .... 0000 ....      @s0_rn0dm
@@ -179,10 +183,15 @@ CRC32CB          1111 1010 1101 .... 1111 .... 1000 ....      @rndm
 CRC32CH          1111 1010 1101 .... 1111 .... 1001 ....      @rndm
 CRC32CW          1111 1010 1101 .... 1111 .... 1010 ....      @rndm
 
+# Ignore Rn, as allowed by constrained unpredictable.
+# This matches the behaviour of the legacy decoder.
+CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
+
 # Branches and miscellaneous control
 
 %msr_sysm        4:1 8:4
 %mrs_sysm        4:1 16:4
+%imm16_16_0      16:4 0:12
 
 {
   {
@@ -211,4 +220,15 @@ CRC32CW          1111 1010 1101 .... 1111 .... 1010 ....      @rndm
     MSR_reg      1111 0011 100 r:1 rn:4 1000 mask:4 0000 0000  &msr_reg
     MSR_v7m      1111 0011 100 0   rn:4 1000 mask:2 00 sysm:8
   }
+  BXJ            1111 0011 1100 rm:4 1000 1111 0000 0000      &r
+  {
+    # At v6T2, this is the T5 encoding of SUBS PC, LR, #IMM, and works as for
+    # every other encoding of SUBS.  With v7VE, IMM=0 is redefined as ERET.
+    ERET         1111 0011 1101 1110 1000 1111 0000 0000
+    SUB_rri      1111 0011 1101 1110 1000 1111 imm:8          \
+                 &s_rri_rot rot=0 s=1 rd=15 rn=14
+  }
+  SMC            1111 0111 1111 imm:4 1000 0000 0000 0000     &i
+  HVC            1111 0111 1110 .... 1000 .... .... ....      \
+                 &i imm=%imm16_16_0
 }
-- 
2.17.1



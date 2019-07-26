Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F113AC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4734218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yymeXIZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4734218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4ON-0000ZQ-JW
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57204)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mf-0001yj-Px
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Me-0007Sb-6U
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:45 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:47016)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Md-0007Qi-UX
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:44 -0400
Received: by mail-pf1-x443.google.com with SMTP id c3so1719748pfa.13
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Pnib07gWtNaIz4hXa+LeNfIkt6V2ivnRlJh4fSqlOtg=;
 b=yymeXIZoGGWSsCTrKP+HCYXDSwRBBeCIMq4Mz+1ZRSsqYYuYyAHFTqVM7/UZVqagaw
 cYLawWwjccTvUpZcE6D7P8sp/narzyhkCsCBk0HkNwN2Z5AbkhN0x9nXEar4B4rIt3M8
 iHhcyjrmB1NMA9nJDtLOE1K9EleEN+/nU9i+704l6d1+RPamG3rDiOQet3vsoR4aHneN
 z1K7IZmrGFG6v+CqRGp21XnFVdFW1LJSzQey7maUCB/3NRE3czaxTLFxaqeQkSeyuSYR
 R1+m6ZXKkZ+5jslzWSc9QlJYhraVgGKsMKgS73u/+QAyB+Br1dBsDobT5wRNSci6XbRn
 D2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Pnib07gWtNaIz4hXa+LeNfIkt6V2ivnRlJh4fSqlOtg=;
 b=FwmgrD8/5NpMJwYQNFwqT3j9j9fm8DMDtUZlP8GfYQMdgDxlT2pmcVI2EVCRpRWtxH
 zg7LmCLTA/0pYqz959/q/kssNYRy6FbYCvPjPhefKnT9wXIGyK/k5DjPAc5C9DKnlSNA
 nFcd4pbNC9V2IKRXauyvtkTcAxJDH2992La8Bv9qZ1xLMGlqK4mFNDJiV/6hJ9MUQHpH
 Ala2Wd3AN6pL9hq/lzlxgk/cqOM336LyuNzHpvVQp0e61Zexdi+pVffcaqVnUvrQ5qp7
 NrlerC16y3PfXPgvtecjrC2Qxwbig9cHHki+WlFO09AyHvxu4tK4CSGAasORjUTu0xCD
 QYjg==
X-Gm-Message-State: APjAAAV7pMqEvPXa8NwQN0putQd2OeO/LGc0tjl8v02WU3xfPAaHDRx9
 e4i6R9Tft3RMTNUC0Ju0FyaKArOnIfk=
X-Google-Smtp-Source: APXvYqzMC68nScuPaEoaVr1EtKcqD6x1ie9iGYiOXBsgsqzssW35xct6u32wSWBnNkWgyeWwxTaRzA==
X-Received: by 2002:a62:2d3:: with SMTP id 202mr23838214pfc.131.1564163442663; 
 Fri, 26 Jul 2019 10:50:42 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.50.41
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:50:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:32 -0700
Message-Id: <20190726175032.6769-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 07/67] target/arm: Introduce add_reg_for_lit
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

Used only on the thumb side so far, but will be more obvious
once we start unifying the implementation of A32+T32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c |  34 +------
 target/arm/translate.c         | 163 +++++++++++++++------------------
 2 files changed, 76 insertions(+), 121 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index e7389bc057..4066b2febf 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -941,14 +941,7 @@ static bool trans_VLDR_VSTR_sp(DisasContext *s, arg_VLDR_VSTR_sp *a)
         offset = -offset;
     }
 
-    if (s->thumb && a->rn == 15) {
-        /* This is actually UNPREDICTABLE */
-        addr = tcg_temp_new_i32();
-        tcg_gen_movi_i32(addr, s->pc & ~2);
-    } else {
-        addr = load_reg(s, a->rn);
-    }
-    tcg_gen_addi_i32(addr, addr, offset);
+    addr = add_reg_for_lit(s, a->rn, offset);
     tmp = tcg_temp_new_i32();
     if (a->l) {
         gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
@@ -983,14 +976,7 @@ static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_dp *a)
         offset = -offset;
     }
 
-    if (s->thumb && a->rn == 15) {
-        /* This is actually UNPREDICTABLE */
-        addr = tcg_temp_new_i32();
-        tcg_gen_movi_i32(addr, s->pc & ~2);
-    } else {
-        addr = load_reg(s, a->rn);
-    }
-    tcg_gen_addi_i32(addr, addr, offset);
+    addr = add_reg_for_lit(s, a->rn, offset);
     tmp = tcg_temp_new_i64();
     if (a->l) {
         gen_aa32_ld64(s, tmp, addr, get_mem_index(s));
@@ -1029,13 +1015,7 @@ static bool trans_VLDM_VSTM_sp(DisasContext *s, arg_VLDM_VSTM_sp *a)
         return true;
     }
 
-    if (s->thumb && a->rn == 15) {
-        /* This is actually UNPREDICTABLE */
-        addr = tcg_temp_new_i32();
-        tcg_gen_movi_i32(addr, s->pc & ~2);
-    } else {
-        addr = load_reg(s, a->rn);
-    }
+    addr = add_reg_for_lit(s, a->rn, 0);
     if (a->p) {
         /* pre-decrement */
         tcg_gen_addi_i32(addr, addr, -(a->imm << 2));
@@ -1112,13 +1092,7 @@ static bool trans_VLDM_VSTM_dp(DisasContext *s, arg_VLDM_VSTM_dp *a)
         return true;
     }
 
-    if (s->thumb && a->rn == 15) {
-        /* This is actually UNPREDICTABLE */
-        addr = tcg_temp_new_i32();
-        tcg_gen_movi_i32(addr, s->pc & ~2);
-    } else {
-        addr = load_reg(s, a->rn);
-    }
+    addr = add_reg_for_lit(s, a->rn, 0);
     if (a->p) {
         /* pre-decrement */
         tcg_gen_addi_i32(addr, addr, -(a->imm << 2));
diff --git a/target/arm/translate.c b/target/arm/translate.c
index a48e9a90f8..5e2dd8bb16 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -214,6 +214,23 @@ static inline TCGv_i32 load_reg(DisasContext *s, int reg)
     return tmp;
 }
 
+/*
+ * Create a new temp, incremented by OFS, except PC is aligned but not
+ * incremented for thumb.  This is used for load/store for which use of
+ * PC implies (literal), or ADD that implies ADR.
+ */
+static TCGv_i32 add_reg_for_lit(DisasContext *s, int reg, int ofs)
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    if (reg == 15) {
+        tcg_gen_movi_i32(tmp, (s->pc_read & ~3) + ofs);
+    } else {
+        tcg_gen_addi_i32(tmp, cpu_R[reg], ofs);
+    }
+    return tmp;
+}
+
 /* Set a CPU register.  The source must be a temporary and will be
    marked as dead.  */
 static void store_reg(DisasContext *s, int reg, TCGv_i32 var)
@@ -9468,16 +9485,12 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                  */
                 bool wback = extract32(insn, 21, 1);
 
-                if (rn == 15) {
-                    if (insn & (1 << 21)) {
-                        /* UNPREDICTABLE */
-                        goto illegal_op;
-                    }
-                    addr = tcg_temp_new_i32();
-                    tcg_gen_movi_i32(addr, s->pc_read & ~3);
-                } else {
-                    addr = load_reg(s, rn);
+                if (rn == 15 && (insn & (1 << 21))) {
+                    /* UNPREDICTABLE */
+                    goto illegal_op;
                 }
+
+                addr = add_reg_for_lit(s, rn, 0);
                 offset = (insn & 0xff) * 4;
                 if ((insn & (1 << 23)) == 0) {
                     offset = -offset;
@@ -10683,27 +10696,15 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                         store_reg(s, rd, tmp);
                     } else {
                         /* Add/sub 12-bit immediate.  */
-                        if (rn == 15) {
-                            offset = s->pc_read & ~(uint32_t)3;
-                            if (insn & (1 << 23))
-                                offset -= imm;
-                            else
-                                offset += imm;
-                            tmp = tcg_temp_new_i32();
-                            tcg_gen_movi_i32(tmp, offset);
-                            store_reg(s, rd, tmp);
+                        if (insn & (1 << 23)) {
+                            imm = -imm;
+                        }
+                        tmp = add_reg_for_lit(s, rn, imm);
+                        if (rn == 13 && rd == 13) {
+                            /* ADD SP, SP, imm or SUB SP, SP, imm */
+                            store_sp_checked(s, tmp);
                         } else {
-                            tmp = load_reg(s, rn);
-                            if (insn & (1 << 23))
-                                tcg_gen_subi_i32(tmp, tmp, imm);
-                            else
-                                tcg_gen_addi_i32(tmp, tmp, imm);
-                            if (rn == 13 && rd == 13) {
-                                /* ADD SP, SP, imm or SUB SP, SP, imm */
-                                store_sp_checked(s, tmp);
-                            } else {
-                                store_reg(s, rd, tmp);
-                            }
+                            store_reg(s, rd, tmp);
                         }
                     }
                 }
@@ -10817,60 +10818,51 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             }
         }
         memidx = get_mem_index(s);
-        if (rn == 15) {
-            addr = tcg_temp_new_i32();
-            /* PC relative.  */
-            imm = s->pc_read & 0xfffffffc;
-            if (insn & (1 << 23))
-                imm += insn & 0xfff;
-            else
-                imm -= insn & 0xfff;
-            tcg_gen_movi_i32(addr, imm);
+        imm = insn & 0xfff;
+        if (insn & (1 << 23)) {
+            /* PC relative or Positive offset.  */
+            addr = add_reg_for_lit(s, rn, imm);
+        } else if (rn == 15) {
+            /* PC relative with negative offset.  */
+            addr = add_reg_for_lit(s, rn, -imm);
         } else {
             addr = load_reg(s, rn);
-            if (insn & (1 << 23)) {
-                /* Positive offset.  */
-                imm = insn & 0xfff;
-                tcg_gen_addi_i32(addr, addr, imm);
-            } else {
-                imm = insn & 0xff;
-                switch ((insn >> 8) & 0xf) {
-                case 0x0: /* Shifted Register.  */
-                    shift = (insn >> 4) & 0xf;
-                    if (shift > 3) {
-                        tcg_temp_free_i32(addr);
-                        goto illegal_op;
-                    }
-                    tmp = load_reg(s, rm);
-                    if (shift)
-                        tcg_gen_shli_i32(tmp, tmp, shift);
-                    tcg_gen_add_i32(addr, addr, tmp);
-                    tcg_temp_free_i32(tmp);
-                    break;
-                case 0xc: /* Negative offset.  */
-                    tcg_gen_addi_i32(addr, addr, -imm);
-                    break;
-                case 0xe: /* User privilege.  */
-                    tcg_gen_addi_i32(addr, addr, imm);
-                    memidx = get_a32_user_mem_index(s);
-                    break;
-                case 0x9: /* Post-decrement.  */
-                    imm = -imm;
-                    /* Fall through.  */
-                case 0xb: /* Post-increment.  */
-                    postinc = 1;
-                    writeback = 1;
-                    break;
-                case 0xd: /* Pre-decrement.  */
-                    imm = -imm;
-                    /* Fall through.  */
-                case 0xf: /* Pre-increment.  */
-                    writeback = 1;
-                    break;
-                default:
+            imm = insn & 0xff;
+            switch ((insn >> 8) & 0xf) {
+            case 0x0: /* Shifted Register.  */
+                shift = (insn >> 4) & 0xf;
+                if (shift > 3) {
                     tcg_temp_free_i32(addr);
                     goto illegal_op;
                 }
+                tmp = load_reg(s, rm);
+                tcg_gen_shli_i32(tmp, tmp, shift);
+                tcg_gen_add_i32(addr, addr, tmp);
+                tcg_temp_free_i32(tmp);
+                break;
+            case 0xc: /* Negative offset.  */
+                tcg_gen_addi_i32(addr, addr, -imm);
+                break;
+            case 0xe: /* User privilege.  */
+                tcg_gen_addi_i32(addr, addr, imm);
+                memidx = get_a32_user_mem_index(s);
+                break;
+            case 0x9: /* Post-decrement.  */
+                imm = -imm;
+                /* Fall through.  */
+            case 0xb: /* Post-increment.  */
+                postinc = 1;
+                writeback = 1;
+                break;
+            case 0xd: /* Pre-decrement.  */
+                imm = -imm;
+                /* Fall through.  */
+            case 0xf: /* Pre-increment.  */
+                writeback = 1;
+                break;
+            default:
+                tcg_temp_free_i32(addr);
+                goto illegal_op;
             }
         }
 
@@ -11066,10 +11058,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         if (insn & (1 << 11)) {
             rd = (insn >> 8) & 7;
             /* load pc-relative.  Bit 1 of PC is ignored.  */
-            val = s->pc_read + ((insn & 0xff) * 4);
-            val &= ~(uint32_t)2;
-            addr = tcg_temp_new_i32();
-            tcg_gen_movi_i32(addr, val);
+            addr = add_reg_for_lit(s, 15, (insn & 0xff) * 4);
             tmp = tcg_temp_new_i32();
             gen_aa32_ld32u_iss(s, tmp, addr, get_mem_index(s),
                                rd | ISSIs16Bit);
@@ -11447,16 +11436,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
          *  - Add PC/SP (immediate)
          */
         rd = (insn >> 8) & 7;
-        if (insn & (1 << 11)) {
-            /* SP */
-            tmp = load_reg(s, 13);
-        } else {
-            /* PC. bit 1 is ignored.  */
-            tmp = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp, s->pc_read & ~(uint32_t)2);
-        }
         val = (insn & 0xff) * 4;
-        tcg_gen_addi_i32(tmp, tmp, val);
+        tmp = add_reg_for_lit(s, insn & (1 << 11) ? 13 : 15, val);
         store_reg(s, rd, tmp);
         break;
 
-- 
2.17.1



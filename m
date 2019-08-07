Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2E6C19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 972B021743
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p+gGLAe/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972B021743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvE0r-0000LR-T0
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 00:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40659)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxQ-0001Cs-B1
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxO-0004od-HO
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:52 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45837)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvDxO-0004o1-9b
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:50 -0400
Received: by mail-pl1-x641.google.com with SMTP id y8so38795990plr.12
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 21:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1+ZCh0ppqRckFKlk6UR/b/e9Pyhyh5ijaXz+rNnMkc4=;
 b=p+gGLAe/m+zU0edleywRdT2G7HCx7Bu+nzK9e4ItOJ497cRaMWZC91wayPIMM5t2EW
 Xfsd8LrA9hiFEzRuP2UUHMWwG2NdsGiNrn/NZKl/njB8x9dQ2kiURzxjGtaUFvqw/5kj
 KNWc+Ji3ddsVuLOJO47gOkjQFWlLF7s2e9CR52Z/sFwAkpIJygD9T0JxniFPODtJ/NpC
 oe8SS/5r9NBm16AM7lqSda5kBojf+uQK8pjXlKzNJB1ZxG5EtC4iDmnJ4ieNagAj5luO
 1Nk4vpc6D1BagxgoA3q8vUtKN1blMyOD9nWvBmHURIllizd43qZ/zJbGQXFmPwVhnB2/
 1P0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1+ZCh0ppqRckFKlk6UR/b/e9Pyhyh5ijaXz+rNnMkc4=;
 b=DiiRJCKXoaGda12ml6EpSagezRGb2ERArtniLIerCDmAnJr8z7hZ8mFCHhuw5lqCYJ
 xnnSsI0Q3oY1YRDJX0a9bhkzCaoJtFT33xc89QiwLj8+YMcWfKbUWgHQT4omvUhg4Prz
 umcNeY4m0aZwZRfNBQ6T4/OakciIdxH3SoHe2auYDfJ6kZ4jBP8I4JM9ygBcRUqrad6q
 /icDW2EAQZs02eC9NwvGa2Sd6zQVLtLGHxJm5IsR20T7M5wKeXtwODjvDKNo+q8MnsiK
 7sYKPecMmJ1rpDj1kgY/g3YkeJdIC1IdbDOtVKTLZ07Vye1TuHXTxYtwNqacPR/qVpt7
 4WIg==
X-Gm-Message-State: APjAAAVkqyth2xUjUWBT2ryhHw/glOK8fQP6vMiJiyEDBkbeDDZdhu4/
 Ovo6p2WrdeAoW5gQwoIwiAc3s01V+Ks=
X-Google-Smtp-Source: APXvYqwNgGysT41mUAwtIcZMclukwFb71MFLmZeo6U0+X9BOMazGaCj/5efppNfu+Uf3ThzuxaZEDQ==
X-Received: by 2002:a17:902:2ae8:: with SMTP id
 j95mr5932957plb.276.1565153628891; 
 Tue, 06 Aug 2019 21:53:48 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t9sm24347921pji.18.2019.08.06.21.53.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 06 Aug 2019 21:53:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  6 Aug 2019 21:53:28 -0700
Message-Id: <20190807045335.1361-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807045335.1361-1-richard.henderson@linaro.org>
References: <20190807045335.1361-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH 04/11] target/arm: Introduce add_reg_for_lit
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provide a common routine for the places that require ALIGN(PC, 4)
as the base address as opposed to plain PC.  The two are always
the same for A32, but the difference is meaningful for thumb mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Note: This patch is easier to read with -b, as there are several
large-ish indentation changes as the if statements fold together.
---
 target/arm/translate-vfp.inc.c |  38 ++------
 target/arm/translate.c         | 166 +++++++++++++++------------------
 2 files changed, 82 insertions(+), 122 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 092eb5ec53..262d4177e5 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -941,14 +941,8 @@ static bool trans_VLDR_VSTR_sp(DisasContext *s, arg_VLDR_VSTR_sp *a)
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
+    /* For thumb, use of PC is UNPREDICTABLE.  */
+    addr = add_reg_for_lit(s, a->rn, offset);
     tmp = tcg_temp_new_i32();
     if (a->l) {
         gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
@@ -983,14 +977,8 @@ static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_dp *a)
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
+    /* For thumb, use of PC is UNPREDICTABLE.  */
+    addr = add_reg_for_lit(s, a->rn, offset);
     tmp = tcg_temp_new_i64();
     if (a->l) {
         gen_aa32_ld64(s, tmp, addr, get_mem_index(s));
@@ -1029,13 +1017,8 @@ static bool trans_VLDM_VSTM_sp(DisasContext *s, arg_VLDM_VSTM_sp *a)
         return true;
     }
 
-    if (s->thumb && a->rn == 15) {
-        /* This is actually UNPREDICTABLE */
-        addr = tcg_temp_new_i32();
-        tcg_gen_movi_i32(addr, s->pc & ~2);
-    } else {
-        addr = load_reg(s, a->rn);
-    }
+    /* For thumb, use of PC is UNPREDICTABLE.  */
+    addr = add_reg_for_lit(s, a->rn, 0);
     if (a->p) {
         /* pre-decrement */
         tcg_gen_addi_i32(addr, addr, -(a->imm << 2));
@@ -1112,13 +1095,8 @@ static bool trans_VLDM_VSTM_dp(DisasContext *s, arg_VLDM_VSTM_dp *a)
         return true;
     }
 
-    if (s->thumb && a->rn == 15) {
-        /* This is actually UNPREDICTABLE */
-        addr = tcg_temp_new_i32();
-        tcg_gen_movi_i32(addr, s->pc & ~2);
-    } else {
-        addr = load_reg(s, a->rn);
-    }
+    /* For thumb, use of PC is UNPREDICTABLE.  */
+    addr = add_reg_for_lit(s, a->rn, 0);
     if (a->p) {
         /* pre-decrement */
         tcg_gen_addi_i32(addr, addr, -(a->imm << 2));
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 61933865d5..71d94c053b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -220,6 +220,23 @@ static inline TCGv_i32 load_reg(DisasContext *s, int reg)
     return tmp;
 }
 
+/*
+ * Create a new temp, REG + OFS, except PC is ALIGN(PC, 4).
+ * This is used for load/store for which use of PC implies (literal),
+ * or ADD that implies ADR.
+ */
+static TCGv_i32 add_reg_for_lit(DisasContext *s, int reg, int ofs)
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    if (reg == 15) {
+        tcg_gen_movi_i32(tmp, (read_pc(s) & ~3) + ofs);
+    } else {
+        tcg_gen_addi_i32(tmp, cpu_R[reg], ofs);
+    }
+    return tmp;
+}
+
 /* Set a CPU register.  The source must be a temporary and will be
    marked as dead.  */
 static void store_reg(DisasContext *s, int reg, TCGv_i32 var)
@@ -9472,16 +9489,12 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                  */
                 bool wback = extract32(insn, 21, 1);
 
-                if (rn == 15) {
-                    if (insn & (1 << 21)) {
-                        /* UNPREDICTABLE */
-                        goto illegal_op;
-                    }
-                    addr = tcg_temp_new_i32();
-                    tcg_gen_movi_i32(addr, s->pc & ~3);
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
@@ -10682,27 +10695,15 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                         store_reg(s, rd, tmp);
                     } else {
                         /* Add/sub 12-bit immediate.  */
-                        if (rn == 15) {
-                            offset = s->pc & ~(uint32_t)3;
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
@@ -10816,61 +10817,53 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             }
         }
         memidx = get_mem_index(s);
-        if (rn == 15) {
-            addr = tcg_temp_new_i32();
-            /* PC relative.  */
-            /* s->pc has already been incremented by 4.  */
-            imm = s->pc & 0xfffffffc;
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
+                if (shift) {
+                    tcg_gen_shli_i32(tmp, tmp, shift);
+                }
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
 
@@ -11066,10 +11059,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         if (insn & (1 << 11)) {
             rd = (insn >> 8) & 7;
             /* load pc-relative.  Bit 1 of PC is ignored.  */
-            val = read_pc(s) + ((insn & 0xff) * 4);
-            val &= ~(uint32_t)2;
-            addr = tcg_temp_new_i32();
-            tcg_gen_movi_i32(addr, val);
+            addr = add_reg_for_lit(s, 15, (insn & 0xff) * 4);
             tmp = tcg_temp_new_i32();
             gen_aa32_ld32u_iss(s, tmp, addr, get_mem_index(s),
                                rd | ISSIs16Bit);
@@ -11447,16 +11437,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
          *  - Add PC/SP (immediate)
          */
         rd = (insn >> 8) & 7;
-        if (insn & (1 << 11)) {
-            /* SP */
-            tmp = load_reg(s, 13);
-        } else {
-            /* PC. bit 1 is ignored.  */
-            tmp = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp, read_pc(s) & ~(uint32_t)2);
-        }
         val = (insn & 0xff) * 4;
-        tcg_gen_addi_i32(tmp, tmp, val);
+        tmp = add_reg_for_lit(s, insn & (1 << 11) ? 13 : 15, val);
         store_reg(s, rd, tmp);
         break;
 
-- 
2.17.1



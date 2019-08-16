Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1A0C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:32:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14EF62086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DRbuGR7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EF62086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycKu-0003py-BF
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6o-0003M1-ER
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6m-0005Qf-K4
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:34 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50784)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc6m-0005PN-AC
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:32 -0400
Received: by mail-wm1-x344.google.com with SMTP id v15so4027640wml.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Wgiq1J2fZfQodsNc/t2jPTW/fxmKXvbe+M6s4QX1K4I=;
 b=DRbuGR7smcmGFc+TTiCtNgqyFCvikaM5R44iZpB5YUkXVC/4OJA15TQ9xn1LTVRBXY
 JQwPcFLNHPQORMcDHwomZMFeBpUApEVpQ6M6imOOIPQZT/7Yf5cT4sQbtin2BpDIMtoQ
 T0JJEigwXmhrSEQx1wlb9L7ok2u4FEoyrEJ3JBOKMTrIBkNQIo+m67ewZiqWbZs6sGHt
 m4yTEQXgmU35irZdexfxYOFPfHJlurceQiNxIWkobQbK9eXKlOuHMK/8XbiN/9uENfUi
 DKr0Ogzpyc+smjQ1OaF6cVpdEBgyo+XKFlIDLEgFcJZtablxO17smah3C/WzfOsL7ffe
 +hbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wgiq1J2fZfQodsNc/t2jPTW/fxmKXvbe+M6s4QX1K4I=;
 b=gnAtZq5ZPqoATXFz3herLS9viA4E5KhZpm985fkCEeLQlhntk6zabcBufUyRnjDlMg
 F4fsjAPTN+zekP5/gaSPSwAdLuCTBBCmsDq7suoYo9pZ6WQIv/RsmgMT8z2hC58BtAYi
 zmthCoGtKo/S6LFK63348bDEB9UAWwIEgkkk5xIxXs669+PKQSH/GGRPNaLkrNj/aMpV
 raLGtGjMfNBkEA2ElxpnGfBTznPU9T3A9x0cFqJYxzunWu3cRJ9haHy2SW4hGxMlEAZT
 W+1Qb2VhV6tJx/kYMsy3M/rvsmaJ6gp3DBJmsyyfn7OIHMfQrLQWL3i4XSNACXaAET1p
 SAQg==
X-Gm-Message-State: APjAAAWqQN3xXTdb2c9Lij+HLDvdlIx+9iErTM7cDl2P7NBMH+PxUb6w
 vZJH76rrn/RQlk4RTayr+PxwTjQvsoldgg==
X-Google-Smtp-Source: APXvYqzwoiZqfoHRxPOXXKcMr6yj1AXizlikaguU49m2xMVIQdk+116k7C08S0DQMXupzYbK1NlrCQ==
X-Received: by 2002:a1c:a909:: with SMTP id s9mr7422279wme.20.1565961450522;
 Fri, 16 Aug 2019 06:17:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:16:59 +0100
Message-Id: <20190816131719.28244-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PULL 09/29] target/arm: Introduce add_reg_for_lit
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

From: Richard Henderson <richard.henderson@linaro.org>

Provide a common routine for the places that require ALIGN(PC, 4)
as the base address as opposed to plain PC.  The two are always
the same for A32, but the difference is meaningful for thumb mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190807045335.1361-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c |  38 ++------
 target/arm/translate.c         | 166 +++++++++++++++------------------
 2 files changed, 82 insertions(+), 122 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 092eb5ec53d..262d4177e50 100644
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
index 41523c0241f..f481b87f997 100644
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
@@ -9457,16 +9474,12 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
@@ -10667,27 +10680,15 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
@@ -10801,61 +10802,53 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
 
@@ -11051,10 +11044,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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
@@ -11432,16 +11422,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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
2.20.1



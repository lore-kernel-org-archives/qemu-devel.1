Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4894EC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03529218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AEPIVRJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03529218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Oq-0002Z4-Nd
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57202)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mf-0001yU-MA
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Me-0007SK-3e
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:45 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Md-0007Nt-SD
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:44 -0400
Received: by mail-pg1-x541.google.com with SMTP id f25so25099263pgv.10
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6LNL9cQ9yWdMRQZwn41TfZpx+HeuRN2JtOhgGfdhQks=;
 b=AEPIVRJLeTkmpkjpMSvPSsr7TtKp5T8GAvionYrUfv63wLNamHKVC0JHNww/VFwegK
 2iz+YmbJ1Xhk5BHFySQCkFZoNeWTwvAevyfV2FmjiKi7xh/jnWrMpdTh1CMezdw9Lf8c
 C8R++Kwe3wfsdrjB8p2hGze3Kac2MS7ytX+sM9446ZmAObLxSg4pclC19AIm1cTTCHm9
 z7JpWshbvctFgUrhJuz55H8kaCAgC0YHwlolii2pXJlT4udtrYrU9QTbaSHghBAib7J9
 PvMT/0mGE2p0JmIll4Ge2riBl3XXvJDMLtfTugWD6cfid7uDJ9b0ydrudecJbo6pcUjl
 bOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6LNL9cQ9yWdMRQZwn41TfZpx+HeuRN2JtOhgGfdhQks=;
 b=rPaj0WWRDj8uTEFbheeF8YwY507MRpWp8cxj2EgWn2WXwL34D1pfXEgQ1wRjfjKe14
 viivIAg4r9FJw7q3u9KxeG2YTKwnkabh2DwtkjSu1N3uijp4r7Kyr6aYQB5cu8H7yUTa
 3gnTko/04vhOuweqbELbCvqAe8ErcjuHf3WCUTJphqjZ/6BG5rLEZ0KsXx3QtDSq/zsB
 M4jbHbONPKy4EiZimdXcXtJ0xUE0sS5C0iNIMnP13XgWolq5Gj2W9GLpkm3jz/JMmo41
 WNcaym2FWlnGPChd88Oc8C+3uIozz18tInQb4LWI9rlhPfAv7BBtMfmluyxwBgJktdVK
 mZ/Q==
X-Gm-Message-State: APjAAAVSjmEYOFqpM6dSvUO18D1jyzUtrkdX161zy4rM+IDjr0lYLxP6
 IAvEDT3tvDhGbLgZDHbYqI76t5TSVVE=
X-Google-Smtp-Source: APXvYqyqlbEWF5aa08O0nDsVGe9gu2xvA9ZlwkZnxhsEXLn0bD4W1B0MfYCnvItUNGztuL1ohm19Bg==
X-Received: by 2002:a17:90a:4803:: with SMTP id
 a3mr101406097pjh.58.1564163441598; 
 Fri, 26 Jul 2019 10:50:41 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.50.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:50:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:31 -0700
Message-Id: <20190726175032.6769-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 06/67] target/arm: Introduce pc_read
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

We currently have 3 different ways of computing the architectural
value of "PC" as seen in the ARM ARM.

The value of s->pc has been incremented past the current insn,
but that is all.  Thus for a32, PC = s->pc + 4; for t32, PC = s->pc;
for t16, PC = s->pc + 2.  These differing computations make it
impossible at present to unify the various code paths.

Let s->pc_read hold the architectural value of PC for all cases.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h | 10 ++++++++
 target/arm/translate.c | 53 ++++++++++++++++++------------------------
 2 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index a20f6e2056..2dfdd8ca66 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -9,7 +9,17 @@ typedef struct DisasContext {
     DisasContextBase base;
     const ARMISARegisters *isar;
 
+    /*
+     * Summary of the various values for "PC":
+     * base.pc_next -- the start of the current insn
+     * pc           -- the start of the next insn
+     * pc_read      -- the value for "PC" in the ARM ARM;
+     *                 in arm mode, the current insn + 8;
+     *                 in thumb mode, the current insn + 4;
+     *                 in aa64 mode, unused.
+     */
     target_ulong pc;
+    target_ulong pc_read;
     target_ulong page_start;
     uint32_t insn;
     /* Nonzero if this instruction has been conditionally skipped.  */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 595385e1b1..a48e9a90f8 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -200,13 +200,7 @@ static inline void store_cpu_offset(TCGv_i32 var, int offset)
 static void load_reg_var(DisasContext *s, TCGv_i32 var, int reg)
 {
     if (reg == 15) {
-        uint32_t addr;
-        /* normally, since we updated PC, we need only to add one insn */
-        if (s->thumb)
-            addr = (long)s->pc + 2;
-        else
-            addr = (long)s->pc + 4;
-        tcg_gen_movi_i32(var, addr);
+        tcg_gen_movi_i32(var, s->pc_read);
     } else {
         tcg_gen_mov_i32(var, cpu_R[reg]);
     }
@@ -7868,16 +7862,14 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             /* branch link and change to thumb (blx <offset>) */
             int32_t offset;
 
-            val = (uint32_t)s->pc;
             tmp = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp, val);
+            tcg_gen_movi_i32(tmp, s->pc);
             store_reg(s, 14, tmp);
             /* Sign-extend the 24-bit offset */
             offset = (((int32_t)insn) << 8) >> 8;
+            val = s->pc_read;
             /* offset * 4 + bit24 * 2 + (thumb bit) */
             val += (offset << 2) | ((insn >> 23) & 2) | 1;
-            /* pipeline offset */
-            val += 4;
             /* protected by ARCH(5); above, near the start of uncond block */
             gen_bx_im(s, val);
             return;
@@ -9154,9 +9146,8 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                             /* store */
                             if (i == 15) {
                                 /* special case: r15 = PC + 8 */
-                                val = (long)s->pc + 4;
                                 tmp = tcg_temp_new_i32();
-                                tcg_gen_movi_i32(tmp, val);
+                                tcg_gen_movi_i32(tmp, s->pc_read);
                             } else if (user) {
                                 tmp = tcg_temp_new_i32();
                                 tmp2 = tcg_const_i32(i);
@@ -9222,14 +9213,13 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 int32_t offset;
 
                 /* branch (and link) */
-                val = (int32_t)s->pc;
                 if (insn & (1 << 24)) {
                     tmp = tcg_temp_new_i32();
-                    tcg_gen_movi_i32(tmp, val);
+                    tcg_gen_movi_i32(tmp, s->pc);
                     store_reg(s, 14, tmp);
                 }
                 offset = sextract32(insn << 2, 0, 26);
-                val += offset + 4;
+                val = s->pc_read + offset;
                 gen_jmp(s, val);
             }
             break;
@@ -9484,7 +9474,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                         goto illegal_op;
                     }
                     addr = tcg_temp_new_i32();
-                    tcg_gen_movi_i32(addr, s->pc & ~3);
+                    tcg_gen_movi_i32(addr, s->pc_read & ~3);
                 } else {
                     addr = load_reg(s, rn);
                 }
@@ -9590,7 +9580,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 /* Table Branch.  */
                 if (rn == 15) {
                     addr = tcg_temp_new_i32();
-                    tcg_gen_movi_i32(addr, s->pc);
+                    tcg_gen_movi_i32(addr, s->pc_read);
                 } else {
                     addr = load_reg(s, rn);
                 }
@@ -9609,7 +9599,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 }
                 tcg_temp_free_i32(addr);
                 tcg_gen_shli_i32(tmp, tmp, 1);
-                tcg_gen_addi_i32(tmp, tmp, s->pc);
+                tcg_gen_addi_i32(tmp, tmp, s->pc_read);
                 store_reg(s, 15, tmp);
             } else {
                 bool is_lasr = false;
@@ -10342,7 +10332,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     tcg_gen_movi_i32(cpu_R[14], s->pc | 1);
                 }
 
-                offset += s->pc;
+                offset += s->pc_read;
                 if (insn & (1 << 12)) {
                     /* b/bl */
                     gen_jmp(s, offset);
@@ -10583,7 +10573,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 offset |= (insn & (1 << 11)) << 8;
 
                 /* jump to the offset */
-                gen_jmp(s, s->pc + offset);
+                gen_jmp(s, s->pc_read + offset);
             }
         } else {
             /*
@@ -10694,7 +10684,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     } else {
                         /* Add/sub 12-bit immediate.  */
                         if (rn == 15) {
-                            offset = s->pc & ~(uint32_t)3;
+                            offset = s->pc_read & ~(uint32_t)3;
                             if (insn & (1 << 23))
                                 offset -= imm;
                             else
@@ -10830,8 +10820,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
         if (rn == 15) {
             addr = tcg_temp_new_i32();
             /* PC relative.  */
-            /* s->pc has already been incremented by 4.  */
-            imm = s->pc & 0xfffffffc;
+            imm = s->pc_read & 0xfffffffc;
             if (insn & (1 << 23))
                 imm += insn & 0xfff;
             else
@@ -11077,7 +11066,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         if (insn & (1 << 11)) {
             rd = (insn >> 8) & 7;
             /* load pc-relative.  Bit 1 of PC is ignored.  */
-            val = s->pc + 2 + ((insn & 0xff) * 4);
+            val = s->pc_read + ((insn & 0xff) * 4);
             val &= ~(uint32_t)2;
             addr = tcg_temp_new_i32();
             tcg_gen_movi_i32(addr, val);
@@ -11464,7 +11453,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         } else {
             /* PC. bit 1 is ignored.  */
             tmp = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp, (s->pc + 2) & ~(uint32_t)2);
+            tcg_gen_movi_i32(tmp, s->pc_read & ~(uint32_t)2);
         }
         val = (insn & 0xff) * 4;
         tcg_gen_addi_i32(tmp, tmp, val);
@@ -11584,7 +11573,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
                 tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, s->condlabel);
             tcg_temp_free_i32(tmp);
             offset = ((insn & 0xf8) >> 2) | (insn & 0x200) >> 3;
-            val = (uint32_t)s->pc + 2;
+            val = s->pc_read;
             val += offset;
             gen_jmp(s, val);
             break;
@@ -11750,7 +11739,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         arm_skip_unless(s, cond);
 
         /* jump to the offset */
-        val = (uint32_t)s->pc + 2;
+        val = s->pc_read;
         offset = ((int32_t)insn << 24) >> 24;
         val += offset << 1;
         gen_jmp(s, val);
@@ -11776,9 +11765,9 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             break;
         }
         /* unconditional branch */
-        val = (uint32_t)s->pc;
+        val = s->pc_read;
         offset = ((int32_t)insn << 21) >> 21;
-        val += (offset << 1) + 2;
+        val += offset << 1;
         gen_jmp(s, val);
         break;
 
@@ -11802,7 +11791,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             /* 0b1111_0xxx_xxxx_xxxx : BL/BLX prefix */
             uint32_t uoffset = ((int32_t)insn << 21) >> 9;
 
-            tcg_gen_movi_i32(cpu_R[14], s->pc + 2 + uoffset);
+            tcg_gen_movi_i32(cpu_R[14], s->pc_read + uoffset);
         }
         break;
     }
@@ -12055,6 +12044,7 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 
     insn = arm_ldl_code(env, dc->pc, dc->sctlr_b);
     dc->insn = insn;
+    dc->pc_read = dc->pc + 8;
     dc->pc += 4;
     disas_arm_insn(dc, insn);
 
@@ -12123,6 +12113,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 
     insn = arm_lduw_code(env, dc->pc, dc->sctlr_b);
     is_16bit = thumb_insn_is_16bit(dc, insn);
+    dc->pc_read = dc->pc + 4;
     dc->pc += 2;
     if (!is_16bit) {
         uint32_t insn2 = arm_lduw_code(env, dc->pc, dc->sctlr_b);
-- 
2.17.1



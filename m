Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FD0C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B9421655
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6kpUeSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B9421655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycBK-0000Iw-F3
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6o-0003Lv-Cb
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6m-0005QZ-JF
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:54855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc6m-0005O9-9S
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:32 -0400
Received: by mail-wm1-x335.google.com with SMTP id p74so4022923wme.4
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=C/JEEaZRwqLGuvRocz89/Usr+xyIhfyyDXXpmxVSBvI=;
 b=j6kpUeSE+0hpVOmsBWC56DSFLDS2Yki5H6ITbYDnoE+si+4EynVU/5Ca0e4ngDeOL7
 5JiHHbMoDB4UH/2HETRmzLP5NJfFxDZIH5UaxHZ0e8qGh5xIY6EMtAyTiiDRjB5cdL5+
 hdseATFko0Dp0nbH5UXtNgxcu955Jo9InD43o9B1b10Zvk0pD291vz0RsJeDot+S7Ffg
 nZEeamC2K1iTSnQ+W08a/AsbiUI08KJm0Ztc4RoIZreWmly5asDhKrgylYowtKZKip5M
 8q65WIC0GpMGIA19eDOCFsxG0b+Mjt9F0Xl5ryw+/jjUbAoV51rs/A01aF/XTwcKXVGi
 tAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C/JEEaZRwqLGuvRocz89/Usr+xyIhfyyDXXpmxVSBvI=;
 b=brNRWy5D1PfojFFMxvyNWgjv7003/FV9PHyaJhWO3By88Os37yicntTfEi5t9zIGI3
 64hO9kTui50eL0NW+g5vJL73yBz9FmtXoZ7hUucGDHiW/wBzvH6tE2gPm39vz/NlMYcE
 StelV1JSdDAjWoPp7OEWTDEY4aGrqWW1a4LX41sX7QsZImLkelol9RVirdnb0SS4ZBUI
 zeDjwiZlF+pYAX3HY9HcPUwkdTePFzgmdWv6hlrGwSAxOGtWXv4z6iO2xqfFgFrnwYbN
 qUP6DuNSMhhNdJtAOjoEyoiOhdhCcRRFTjAVqI+I7JOTIJN53G+uY+vA9pnIOonQigko
 HejQ==
X-Gm-Message-State: APjAAAVO5yrQ7KEIloYcPsQw/zA3wlWXYmqKeBUR9LMxrBVBPOmsgIem
 ImbDFVYPF5zIW3XGn/i4ezbC5CL1oaaXqQ==
X-Google-Smtp-Source: APXvYqxZXJAL9dP6Hu33w+V8ifNV1p0DlCkdqNUv7uF8uIyHavx/Aq0k6hqanl1DI55d6k8mnMI/xQ==
X-Received: by 2002:a1c:107:: with SMTP id 7mr7515583wmb.84.1565961449492;
 Fri, 16 Aug 2019 06:17:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:16:58 +0100
Message-Id: <20190816131719.28244-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
Subject: [Qemu-devel] [PULL 08/29] target/arm: Introduce read_pc
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

We currently have 3 different ways of computing the architectural
value of "PC" as seen in the ARM ARM.

The value of s->pc has been incremented past the current insn,
but that is all.  Thus for a32, PC = s->pc + 4; for t32, PC = s->pc;
for t16, PC = s->pc + 2.  These differing computations make it
impossible at present to unify the various code paths.

With the newly introduced s->pc_curr, we can compute the correct
value for all cases, using the formula given in the ARM ARM.

This changes the behaviour for load_reg() and load_reg_var()
when called with reg==15 from a 32-bit Thumb instruction:
previously they would have returned the incorrect value
of pc_curr + 6, and now they will return the architecturally
correct value of PC, which is pc_curr + 4. This will not
affect well-behaved guest software, because all of the places
we call these functions from T32 code are instructions where
using r15 is UNPREDICTABLE. Using the architectural PC value
here is more consistent with the T16 and A32 behaviour.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190807045335.1361-4-richard.henderson@linaro.org
[PMM: added commit message note about UNPREDICTABLE T32 cases]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 59 ++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 36 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index fed08c63f81..41523c0241f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -196,17 +196,17 @@ static inline void store_cpu_offset(TCGv_i32 var, int offset)
 #define store_cpu_field(var, name) \
     store_cpu_offset(var, offsetof(CPUARMState, name))
 
+/* The architectural value of PC.  */
+static uint32_t read_pc(DisasContext *s)
+{
+    return s->pc_curr + (s->thumb ? 4 : 8);
+}
+
 /* Set a variable to the value of a CPU register.  */
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
+        tcg_gen_movi_i32(var, read_pc(s));
     } else {
         tcg_gen_mov_i32(var, cpu_R[reg]);
     }
@@ -7853,16 +7853,14 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             /* branch link and change to thumb (blx <offset>) */
             int32_t offset;
 
-            val = (uint32_t)s->pc;
             tmp = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp, val);
+            tcg_gen_movi_i32(tmp, s->pc);
             store_reg(s, 14, tmp);
             /* Sign-extend the 24-bit offset */
             offset = (((int32_t)insn) << 8) >> 8;
+            val = read_pc(s);
             /* offset * 4 + bit24 * 2 + (thumb bit) */
             val += (offset << 2) | ((insn >> 23) & 2) | 1;
-            /* pipeline offset */
-            val += 4;
             /* protected by ARCH(5); above, near the start of uncond block */
             gen_bx_im(s, val);
             return;
@@ -9138,10 +9136,8 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                         } else {
                             /* store */
                             if (i == 15) {
-                                /* special case: r15 = PC + 8 */
-                                val = (long)s->pc + 4;
                                 tmp = tcg_temp_new_i32();
-                                tcg_gen_movi_i32(tmp, val);
+                                tcg_gen_movi_i32(tmp, read_pc(s));
                             } else if (user) {
                                 tmp = tcg_temp_new_i32();
                                 tmp2 = tcg_const_i32(i);
@@ -9207,15 +9203,13 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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
-                gen_jmp(s, val);
+                gen_jmp(s, read_pc(s) + offset);
             }
             break;
         case 0xc:
@@ -9573,12 +9567,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 tcg_temp_free_i32(addr);
             } else if ((insn & (7 << 5)) == 0) {
                 /* Table Branch.  */
-                if (rn == 15) {
-                    addr = tcg_temp_new_i32();
-                    tcg_gen_movi_i32(addr, s->pc);
-                } else {
-                    addr = load_reg(s, rn);
-                }
+                addr = load_reg(s, rn);
                 tmp = load_reg(s, rm);
                 tcg_gen_add_i32(addr, addr, tmp);
                 if (insn & (1 << 4)) {
@@ -9594,7 +9583,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 }
                 tcg_temp_free_i32(addr);
                 tcg_gen_shli_i32(tmp, tmp, 1);
-                tcg_gen_addi_i32(tmp, tmp, s->pc);
+                tcg_gen_addi_i32(tmp, tmp, read_pc(s));
                 store_reg(s, 15, tmp);
             } else {
                 bool is_lasr = false;
@@ -10327,7 +10316,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     tcg_gen_movi_i32(cpu_R[14], s->pc | 1);
                 }
 
-                offset += s->pc;
+                offset += read_pc(s);
                 if (insn & (1 << 12)) {
                     /* b/bl */
                     gen_jmp(s, offset);
@@ -10568,7 +10557,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 offset |= (insn & (1 << 11)) << 8;
 
                 /* jump to the offset */
-                gen_jmp(s, s->pc + offset);
+                gen_jmp(s, read_pc(s) + offset);
             }
         } else {
             /*
@@ -11062,7 +11051,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         if (insn & (1 << 11)) {
             rd = (insn >> 8) & 7;
             /* load pc-relative.  Bit 1 of PC is ignored.  */
-            val = s->pc + 2 + ((insn & 0xff) * 4);
+            val = read_pc(s) + ((insn & 0xff) * 4);
             val &= ~(uint32_t)2;
             addr = tcg_temp_new_i32();
             tcg_gen_movi_i32(addr, val);
@@ -11449,7 +11438,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         } else {
             /* PC. bit 1 is ignored.  */
             tmp = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp, (s->pc + 2) & ~(uint32_t)2);
+            tcg_gen_movi_i32(tmp, read_pc(s) & ~(uint32_t)2);
         }
         val = (insn & 0xff) * 4;
         tcg_gen_addi_i32(tmp, tmp, val);
@@ -11569,9 +11558,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
                 tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, s->condlabel);
             tcg_temp_free_i32(tmp);
             offset = ((insn & 0xf8) >> 2) | (insn & 0x200) >> 3;
-            val = (uint32_t)s->pc + 2;
-            val += offset;
-            gen_jmp(s, val);
+            gen_jmp(s, read_pc(s) + offset);
             break;
 
         case 15: /* IT, nop-hint.  */
@@ -11735,7 +11722,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         arm_skip_unless(s, cond);
 
         /* jump to the offset */
-        val = (uint32_t)s->pc + 2;
+        val = read_pc(s);
         offset = ((int32_t)insn << 24) >> 24;
         val += offset << 1;
         gen_jmp(s, val);
@@ -11761,9 +11748,9 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             break;
         }
         /* unconditional branch */
-        val = (uint32_t)s->pc;
+        val = read_pc(s);
         offset = ((int32_t)insn << 21) >> 21;
-        val += (offset << 1) + 2;
+        val += offset << 1;
         gen_jmp(s, val);
         break;
 
@@ -11787,7 +11774,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             /* 0b1111_0xxx_xxxx_xxxx : BL/BLX prefix */
             uint32_t uoffset = ((int32_t)insn << 21) >> 9;
 
-            tcg_gen_movi_i32(cpu_R[14], s->pc + 2 + uoffset);
+            tcg_gen_movi_i32(cpu_R[14], read_pc(s) + uoffset);
         }
         break;
     }
-- 
2.20.1



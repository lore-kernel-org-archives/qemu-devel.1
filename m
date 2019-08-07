Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE2BC19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B57D21743
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eu3OOrlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B57D21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvDyP-0003Oi-De
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 00:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40618)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxO-00016a-ON
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxN-0004nR-7e
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:50 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45717)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvDxN-0004le-22
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:49 -0400
Received: by mail-pg1-x541.google.com with SMTP id o13so42775669pgp.12
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 21:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1zzimgpgSpr/kyzutrALdKavhpYiAUiw3e1Jv+/dxZI=;
 b=Eu3OOrlOz2UgnxrLF/PsCxjK42U+FsE/Kh/qrZ0XKPdKP4J+7ys7ZOP3i4bf3Xd9qH
 U5LWOu3WIM+w3goJBqnBafHzPhXZcQCIEpLGII/a83mwGu39xWUipdf5ajmGuLqxGfbx
 Geb2PHAkOgrMzUwONpUhspbccujgjnCWtavPO2tL2AZuRZ8L8sMuTv6s6F3kPMdjtFnG
 MQjQeDvDhQP+m7jS7A4zaaxZjkYmV/XcGGrKwO3n9+VX/2xRrU+FkuznHhLJRvVPypNj
 nzJn3wQoYBlig13plZoFjpC0KLdSWBjTV37tcoQH6ELktpsu4R1XTa6thcPXfjOwrcNR
 yQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1zzimgpgSpr/kyzutrALdKavhpYiAUiw3e1Jv+/dxZI=;
 b=PFGEkvfsT1wQiStihuCXZGsPzJH1naoil8p0oGjthHX63HYDVS4rcmzdSImoY6sfWi
 AbxRusbmY3QlNuHC7eVV3NYWJaSXuf7kJnD6GNTLbLMYITESoDnpkVkyQ8IZ6ZjiWx2V
 LmmZmEgjQBV3p9RDXad6n1IAX+7C6xAiEKotszNdXz3s9+Rr3bJbeo/BlPdGhXPMDkns
 C1Fkzh5LjMKJ/JF/qY/EAs6B5Nwx9J596XFLjBgZjZLnjZsGIiTPkj31jMUS7L1bsPVz
 3E3hAMTH/IRKljyvV0L925WOVHllgMVXFkbGA2F/N2S9/inlDUGrv+ur70iPUzNHW0WX
 kSzQ==
X-Gm-Message-State: APjAAAXEWPeOGSZHvHyLrszfCnzC+B5lPADE2J0Cmr2jeQeA7u9wXdpA
 e34SLJoxHHX/L4PXWGQVNKjxkG13/lI=
X-Google-Smtp-Source: APXvYqwOaU4nlvS2gVRJfO6b6IwNvcfm5er6WWbRf0ZVoufB+NF23mkG5VZsCW/PJMNzlj0OjrmPUA==
X-Received: by 2002:a65:5342:: with SMTP id w2mr5999727pgr.261.1565153627374; 
 Tue, 06 Aug 2019 21:53:47 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t9sm24347921pji.18.2019.08.06.21.53.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 06 Aug 2019 21:53:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  6 Aug 2019 21:53:27 -0700
Message-Id: <20190807045335.1361-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807045335.1361-1-richard.henderson@linaro.org>
References: <20190807045335.1361-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 03/11] target/arm: Introduce read_pc
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

We currently have 3 different ways of computing the architectural
value of "PC" as seen in the ARM ARM.

The value of s->pc has been incremented past the current insn,
but that is all.  Thus for a32, PC = s->pc + 4; for t32, PC = s->pc;
for t16, PC = s->pc + 2.  These differing computations make it
impossible at present to unify the various code paths.

With the newly introduced s->pc_curr, we can compute the correct
value for all cases, using the formula given in the ARM ARM.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 59 ++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 36 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 59e35aafbf..61933865d5 100644
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
@@ -7868,16 +7868,14 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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
@@ -9153,10 +9151,8 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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
@@ -9222,15 +9218,13 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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
@@ -9588,12 +9582,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
@@ -9609,7 +9598,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 }
                 tcg_temp_free_i32(addr);
                 tcg_gen_shli_i32(tmp, tmp, 1);
-                tcg_gen_addi_i32(tmp, tmp, s->pc);
+                tcg_gen_addi_i32(tmp, tmp, read_pc(s));
                 store_reg(s, 15, tmp);
             } else {
                 bool is_lasr = false;
@@ -10342,7 +10331,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     tcg_gen_movi_i32(cpu_R[14], s->pc | 1);
                 }
 
-                offset += s->pc;
+                offset += read_pc(s);
                 if (insn & (1 << 12)) {
                     /* b/bl */
                     gen_jmp(s, offset);
@@ -10583,7 +10572,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 offset |= (insn & (1 << 11)) << 8;
 
                 /* jump to the offset */
-                gen_jmp(s, s->pc + offset);
+                gen_jmp(s, read_pc(s) + offset);
             }
         } else {
             /*
@@ -11077,7 +11066,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         if (insn & (1 << 11)) {
             rd = (insn >> 8) & 7;
             /* load pc-relative.  Bit 1 of PC is ignored.  */
-            val = s->pc + 2 + ((insn & 0xff) * 4);
+            val = read_pc(s) + ((insn & 0xff) * 4);
             val &= ~(uint32_t)2;
             addr = tcg_temp_new_i32();
             tcg_gen_movi_i32(addr, val);
@@ -11464,7 +11453,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         } else {
             /* PC. bit 1 is ignored.  */
             tmp = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp, (s->pc + 2) & ~(uint32_t)2);
+            tcg_gen_movi_i32(tmp, read_pc(s) & ~(uint32_t)2);
         }
         val = (insn & 0xff) * 4;
         tcg_gen_addi_i32(tmp, tmp, val);
@@ -11584,9 +11573,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
                 tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, s->condlabel);
             tcg_temp_free_i32(tmp);
             offset = ((insn & 0xf8) >> 2) | (insn & 0x200) >> 3;
-            val = (uint32_t)s->pc + 2;
-            val += offset;
-            gen_jmp(s, val);
+            gen_jmp(s, read_pc(s) + offset);
             break;
 
         case 15: /* IT, nop-hint.  */
@@ -11750,7 +11737,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         arm_skip_unless(s, cond);
 
         /* jump to the offset */
-        val = (uint32_t)s->pc + 2;
+        val = read_pc(s);
         offset = ((int32_t)insn << 24) >> 24;
         val += offset << 1;
         gen_jmp(s, val);
@@ -11776,9 +11763,9 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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
 
@@ -11802,7 +11789,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             /* 0b1111_0xxx_xxxx_xxxx : BL/BLX prefix */
             uint32_t uoffset = ((int32_t)insn << 21) >> 9;
 
-            tcg_gen_movi_i32(cpu_R[14], s->pc + 2 + uoffset);
+            tcg_gen_movi_i32(cpu_R[14], read_pc(s) + uoffset);
         }
         break;
     }
-- 
2.17.1



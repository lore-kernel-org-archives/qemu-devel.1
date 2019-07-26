Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F016C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D85021842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/NyunXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D85021842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4ZN-0003fo-JX
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59733)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nv-0007Wc-Ml
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nu-0001PK-2p
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:03 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43351)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Nt-00015p-Qg
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:01 -0400
Received: by mail-pf1-x442.google.com with SMTP id i189so24859782pfg.10
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kW5KBD6wPpayXUHizYdiz+TBRbqx6bgCGmxteuVYILs=;
 b=P/NyunXcP/IxoRd21r8LFlzNsCYrAu6YIymG9KavT2DR7sxxz19uDsHBFb1qt8XIi7
 jpvFuIoGGINF0D06C9w/2gEtGWiIowCQxwB7c07LvT6OxWKsK7L4SKmiuHbcPnSkyDLD
 EqE0WLtr5WEWfxBIs9ZYHX8UhXUCTGubbR8A50e47WmstEN55Ln5Zs+xsELxUcPalCdJ
 kwkzTuTPnjIxo43G7SCZ0lrjtNv2s8kGe4Aq3fo+hX+4EecyK4nflkk41qrzLyH2PlZP
 WTLnB451CMQivPVPQaUJqASpW34JWUD6e/b5P3qI/H/CvSzhplNDzOBHEssqkeKj4Zsq
 DB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kW5KBD6wPpayXUHizYdiz+TBRbqx6bgCGmxteuVYILs=;
 b=gAMU02LhD1WJi8RQge+GuvzWSPoAEoNyxnQ37i3fQIbg2kX4sUxvh4Kw9FBsowRcCH
 m7hr/dWNiCdxAR3PuffC/Bo1LEGE32HlSfLaYmWupA4gDybQwNDr86sd3VhkiVS6O1Pk
 CMfpoIL11v9SQOa/P613uHepWTspTW16rQxu2RXRiM5CK0n2rR3UpeKttrU7W9w9YXzW
 0rsN0a7X03/l7qdgf4og8CVl9Bd1RCdRyZqd/q3T/qOoQAXh/hW5pXtUHiJXJR/nIC6u
 HhhvPJxEk4H765jjHnsUPlaNxO3U1gGQgQtaON1e4OPZsPTEXezRBqNktZzdPAa/Y8rP
 DgZw==
X-Gm-Message-State: APjAAAUVV/sRvrwaFXGAlio3F9kObaywNVFZ9snJDVoNSdWK5Dds15Cy
 9adz023FVxybEb1D0QaxlnFdaBE/BMQ=
X-Google-Smtp-Source: APXvYqwCHY7DHVEOhzrT5JP5/duzgDe6SkCg5mQuQ4fu0HzD+iEFYkZMadgK2cLvAC9CfTqeMPHMkw==
X-Received: by 2002:a65:5c4b:: with SMTP id v11mr49756112pgr.62.1564163504727; 
 Fri, 26 Jul 2019 10:51:44 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:24 -0700
Message-Id: <20190726175032.6769-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 59/67] target/arm: Convert T16,
 Conditional branches, Supervisor call
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 26 +++-----------------------
 target/arm/t16.decode  | 12 ++++++++++++
 2 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5d0d0779c8..97c472c8f7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10626,7 +10626,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t val, op, rm, rd, shift, cond;
+    uint32_t val, op, rm, rd, shift;
     int32_t offset;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
@@ -10767,28 +10767,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         }
         break;
 
-    case 13:
-        /* conditional branch or swi */
-        cond = (insn >> 8) & 0xf;
-        if (cond == 0xe)
-            goto undef;
-
-        if (cond == 0xf) {
-            /* swi */
-            gen_set_pc_im(s, s->pc);
-            s->svc_imm = extract32(insn, 0, 8);
-            s->base.is_jmp = DISAS_SWI;
-            break;
-        }
-        /* generate a conditional jump to next instruction */
-        arm_skip_unless(s, cond);
-
-        /* jump to the offset */
-        val = s->pc_read;
-        offset = ((int32_t)insn << 24) >> 24;
-        val += offset << 1;
-        gen_jmp(s, val);
-        break;
+    case 13: /* conditional branch or swi, in decodetree */
+        goto illegal_op;
 
     case 14:
         if (insn & (1 << 11)) {
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 10cdca1fbb..f4091c812d 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -28,11 +28,13 @@
 &rr              !extern rd rm
 &ri              !extern rd imm
 &r               !extern rm
+&i               !extern imm
 &ldst_rr         !extern p w u rn rt rm shimm shtype
 &ldst_ri         !extern p w u rn rt imm
 &ldst_block      !extern rn i b u w list
 &setend          !extern E
 &cps             !extern mode imod M A I F
+&ci              !extern cond imm
 
 # Set S if the instruction is outside of an IT block.
 %s               !function=t16_setflags
@@ -231,3 +233,13 @@ STM             1011 010 ......... \
                 &ldst_block i=0 b=1 u=0 w=1 rn=13 list=%push_list
 LDM             1011 110 ......... \
                 &ldst_block i=1 b=0 u=0 w=1 rn=13 list=%pop_list
+
+# Conditional branches, Supervisor call
+
+%imm8_0x2       0:s8 !function=times_2
+
+{
+  UDF           1101 1110 ---- ----
+  SVC           1101 1111 imm:8                 &i
+  B_cond_thumb  1101 cond:4 ........            &ci imm=%imm8_0x2
+}
-- 
2.17.1



Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D26C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12E9214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FK+sZt64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12E9214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33RC-0005Nn-WA
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Fy-0003HZ-ON
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Fs-0008LO-PG
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:22 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35769)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Fs-0008Kq-Bn
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:16 -0400
Received: by mail-pf1-x442.google.com with SMTP id d85so404543pfd.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=b8pLyu80ByK5bjQKITtTY/uW/k9pGohqmOEr3RJeigk=;
 b=FK+sZt64dEgio/3pfoLpi9DL1F7YWE2P0LT0q7GfMrJcc65LpUG8DrZY6oaTE/fGzn
 aEmhpu5MdgiiioBXKwHWmqDPAIJCQK1gtGZkpLEb7kqWx7Spx/1GOpFOZIgDj3vLHrEB
 eXVJB3QihgfgB81V7RIHdHIHXDg4SNHkRCzzEpOM2JlguN0dlFspFc2T0XhUf3glOHKl
 iA6m43zFnFbIgPTgN0BUcNYHBqYbTrKR/CY7lJer0Mz7YE835Hy3UGCIqHhQZAr0qfHk
 oA43UyOHhXPCtDV1StI4126QAkquj8b4N/94L0DHrWhfhC5OuAI/OfXlqhSwYxdRkuEd
 wChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=b8pLyu80ByK5bjQKITtTY/uW/k9pGohqmOEr3RJeigk=;
 b=qsg6EHgQeNrjJxkdjKZkGHwPH69k8euYRv4XvPSpmomY/pXQ2SJcce7urI1FOvI6Qa
 uDZzmzK+RqUtWUQVGaYNQ2edFfeOmQkKCTuJolv0tpXchXKXJ26XusgphB/psD/SIgDy
 oyi3lhSpyHNE5U8DxHRw7+baxJi1Vp+bN7bcjm8WN3AEm6ElMhDaxSmaaoBI+oGaUNAf
 gKnEfYgSe0PcXqqrR/RE1UcAEr7Vn9u+/c0lo44lT5GzpfQvANcfI+wzEsJsDfRjo/26
 HdtXP4kMyno0tZWNizZiK41aYaOv95xEXD4ZrqM9yeiFIvmd3cafTEZ9r3+s7TR0kObA
 RlaA==
X-Gm-Message-State: APjAAAW6LRifG9WV0oAgvOFyUZzbNBiYbPISjSjshQ17zxj6/AiA7aT0
 EM4QyTmEf4Yfqa/7hfLuN+NAsxGt5ec=
X-Google-Smtp-Source: APXvYqw2Qv/42HXUYwnFzAfTgfddkgU3sth6fdYmPUB3OlKNlR1BP0pA/R07jlVamSkaXJNxOOVrRw==
X-Received: by 2002:a63:5945:: with SMTP id j5mr4740469pgm.452.1567019114863; 
 Wed, 28 Aug 2019 12:05:14 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:03:59 -0700
Message-Id: <20190828190456.30315-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v3 12/69] target/arm: Convert MSR (immediate)
 and hints
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 60 +++++++++++++++++++++++++++++-------------
 target/arm/a32.decode  | 25 ++++++++++++++++++
 target/arm/t32.decode  | 17 ++++++++++++
 3 files changed, 84 insertions(+), 18 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index fad07499d2..d1599db2df 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8256,6 +8256,44 @@ DO_SMLAWX(SMLAWT, 1, 1)
 
 #undef DO_SMLAWX
 
+/*
+ * MSR (immediate) and hints
+ */
+
+static bool trans_YIELD(DisasContext *s, arg_YIELD *a)
+{
+    gen_nop_hint(s, 1);
+    return true;
+}
+
+static bool trans_WFE(DisasContext *s, arg_WFE *a)
+{
+    gen_nop_hint(s, 2);
+    return true;
+}
+
+static bool trans_WFI(DisasContext *s, arg_WFI *a)
+{
+    gen_nop_hint(s, 3);
+    return true;
+}
+
+static bool trans_NOP(DisasContext *s, arg_NOP *a)
+{
+    return true;
+}
+
+static bool trans_MSR_imm(DisasContext *s, arg_MSR_imm *a)
+{
+    uint32_t val = ror32(a->imm, a->rot * 2);
+    uint32_t mask = msr_mask(s, a->mask, a->r);
+
+    if (gen_set_psr_im(s, mask, a->r, val)) {
+        unallocated_encoding(s);
+    }
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -8529,21 +8567,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             }
             store_reg(s, rd, tmp);
         } else {
-            if (((insn >> 12) & 0xf) != 0xf)
-                goto illegal_op;
-            if (((insn >> 16) & 0xf) == 0) {
-                gen_nop_hint(s, insn & 0xff);
-            } else {
-                /* CPSR = immediate */
-                val = insn & 0xff;
-                shift = ((insn >> 8) & 0xf) * 2;
-                val = ror32(val, shift);
-                i = ((insn & (1 << 22)) != 0);
-                if (gen_set_psr_im(s, msr_mask(s, (insn >> 16) & 0xf, i),
-                                   i, val)) {
-                    goto illegal_op;
-                }
-            }
+            /* MSR (immediate) and hints */
+            /* All done in decodetree.  Illegal ops already signalled.  */
+            g_assert_not_reached();
         }
     } else if ((insn & 0x0f900000) == 0x01000000
                && (insn & 0x00000090) != 0x00000090) {
@@ -10480,9 +10506,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                             goto illegal_op;
                         break;
                     case 2: /* cps, nop-hint.  */
-                        if (((insn >> 8) & 7) == 0) {
-                            gen_nop_hint(s, insn & 0xff);
-                        }
+                        /* nop hints in decodetree */
                         /* Implemented as NOP in user mode.  */
                         if (IS_USER(s))
                             break;
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 19d12e726b..3d5c5408f9 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -22,6 +22,7 @@
 # All insns that have 0xf in insn[31:28] are in a32-uncond.decode.
 #
 
+&empty
 &s_rrr_shi       s rd rn rm shim shty
 &s_rrr_shr       s rn rd rm rs shty
 &s_rri_rot       s rn rd imm rot
@@ -152,3 +153,27 @@ SMULBB           .... 0001 0110 .... 0000 .... 1000 ....      @rd0mn
 SMULBT           .... 0001 0110 .... 0000 .... 1100 ....      @rd0mn
 SMULTB           .... 0001 0110 .... 0000 .... 1010 ....      @rd0mn
 SMULTT           .... 0001 0110 .... 0000 .... 1110 ....      @rd0mn
+
+# MSR (immediate) and hints
+
+&msr_i           r mask rot imm
+@msr_i           ---- .... .... mask:4 .... rot:4 imm:8       &msr_i
+
+{
+  {
+    YIELD        ---- 0011 0010 0000 1111 ---- 0000 0001
+    WFE          ---- 0011 0010 0000 1111 ---- 0000 0010
+    WFI          ---- 0011 0010 0000 1111 ---- 0000 0011
+
+    # TODO: Implement SEV, SEVL; may help SMP performance.
+    # SEV        ---- 0011 0010 0000 1111 ---- 0000 0100
+    # SEVL       ---- 0011 0010 0000 1111 ---- 0000 0101
+
+    # The canonical nop ends in 00000000, but the whole of the
+    # rest of the space executes as nop if otherwise unsupported.
+    NOP          ---- 0011 0010 0000 1111 ---- ---- ----
+  }
+  # Note mask = 0 is covered by NOP
+  MSR_imm        .... 0011 0010 .... 1111 .... .... ....      @msr_i r=0
+}
+MSR_imm          .... 0011 0110 .... 1111 .... .... ....      @msr_i r=1
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 122a0537ed..ccb7cdd4ef 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -19,6 +19,7 @@
 # This file is processed by scripts/decodetree.py
 #
 
+&empty           !extern
 &s_rrr_shi       !extern s rd rn rm shim shty
 &s_rrr_shr       !extern s rn rd rm rs shty
 &s_rri_rot       !extern s rn rd imm rot
@@ -166,3 +167,19 @@ QADD             1111 1010 1000 .... 1111 .... 1000 ....      @rndm
 QSUB             1111 1010 1000 .... 1111 .... 1010 ....      @rndm
 QDADD            1111 1010 1000 .... 1111 .... 1001 ....      @rndm
 QDSUB            1111 1010 1000 .... 1111 .... 1011 ....      @rndm
+
+# Branches and miscellaneous control
+
+{
+  YIELD          1111 0011 1010 1111 1000 0000 0000 0001
+  WFE            1111 0011 1010 1111 1000 0000 0000 0010
+  WFI            1111 0011 1010 1111 1000 0000 0000 0011
+
+  # TODO: Implement SEV, SEVL; may help SMP performance.
+  # SEV          1111 0011 1010 1111 1000 0000 0000 0100
+  # SEVL         1111 0011 1010 1111 1000 0000 0000 0101
+
+  # The canonical nop ends in 0000 0000, but the whole rest
+  # of the space is "reserved hint, behaves as nop".
+  NOP            1111 0011 1010 1111 1000 0000 ---- ----
+}
-- 
2.17.1



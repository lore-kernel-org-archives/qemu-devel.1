Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED020C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B797421726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 19:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tHoGUVce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B797421726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bFy-0004Uu-CR
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 15:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5azv-0004KC-Eh
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5azt-0002Ek-JI
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:19 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5azt-0002E1-Ab
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:17 -0400
Received: by mail-pl1-x643.google.com with SMTP id y1so10011102plp.9
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qIboakrWv9IiGA+mdMxhBvLjlTlOJK5d1FVqxlQZi7U=;
 b=tHoGUVceZAs8Vh4SMtRsAay5YBKllYR3EERReCZ7oqZws/QiS1wYSKRM01SXA5Fz/n
 nDYYu9GVabSJr0K/i667V2zI2nkC+Yd6c7DlxkNjOK9GYBZtvSCpBHNkTIYtA0D4kCgp
 +ScJJ6BeKxvmnukc0AKJCa9lw8P9ArRPH88riZPYm/pJLFZXIis3TeWztY3LhYa0VzXr
 KNgNINPkEXloRwEgUw5oUXCHyi+8GMSQhCaPmaZQh/PxqLJm3BzbTXkVxsZHPwX6oOGd
 7iwYhlttSJVKEevJEvOsD/SaPje29+1mq2zsGzi8nEvhmdo3ttGhUmrN1J5QrGUbH8WB
 iWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qIboakrWv9IiGA+mdMxhBvLjlTlOJK5d1FVqxlQZi7U=;
 b=eRM0zmQ0RVCLT1rsasTurd8p3Q5JAOYby4h089fprA2bIxQwQRFwb4WWvYMOBsVai/
 BuNukEx+e9HuUrMDd8lfBhNjpm873A9On3hsd+lO989PRNXa8fKbGvjxAMG+f5MZ4SRx
 Q0Q/hudrMC9ku0mAEpF0sZevUFg4kF7wnImGyNUyEl2C5koEVhnAn2beGPVKZZg6q4Lt
 6a3hw1JnhWErvmoiyHAlHY2nk/uheqvQJcXX+mKhHanwUK5kzzA0wrDDkS3WsFpngXt2
 XRD0vsvQso12gZxwSlqoMOxCn4hnSI3k/vikzGxMwQhgTpynr6s9gI95z19NbZwDa3nQ
 2ldQ==
X-Gm-Message-State: APjAAAXCjedoeEsmkGO5K+xrR5HUyXf7t1xrSabY6BOeTaDbYe34Yh5s
 3Vulz42xQPklRkjetBo+ivfT/xtxBjM=
X-Google-Smtp-Source: APXvYqxVxFJ3OAcZkRJ7W6DFwVq5/eT8jAW04Ar/u9B0VJ/hQQkKJx22+TyHvb15UobKAQyY1Nj+Xw==
X-Received: by 2002:a17:902:6842:: with SMTP id
 f2mr43499203pln.39.1567625476030; 
 Wed, 04 Sep 2019 12:31:16 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:02 -0700
Message-Id: <20190904193059.26202-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v4 12/69] target/arm: Convert MSR (immediate)
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
index 71cc96b70e..58bfbb8ed9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8282,6 +8282,44 @@ DO_SMLAWX(SMLAWT, 1, 1)
 
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
@@ -8555,21 +8593,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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
@@ -10522,9 +10548,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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



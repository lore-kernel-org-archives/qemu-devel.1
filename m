Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C68C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9502A20861
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6Zfhjte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9502A20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50646 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvqU-0001M2-Tr
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50785)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcvp1-0007iQ-OE
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcvp0-0000gL-1e
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:53:35 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43845)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcvox-0000eN-SE
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:53:33 -0400
Received: by mail-wr1-x442.google.com with SMTP id p13so10916016wru.10
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=575i0kl12NVak4MXLXn7jsLioeAHAQ7GMt0OozyFMPE=;
 b=U6Zfhjte7H1zjJkqBenhLCw1tAgmTlKq/0q9BWk2JkWrXIUcYqp+vqPBu0w7GL9Q4O
 bEUqqAJN/f9/R+M3pjyh02+p0iUAkCilSBVAzSdKULqfFexI70Wplkuqpmty6iLFON3Y
 exJ0/+7QXwOqxptLkkPrTg9ZvAIUobfhkqWcH5PVpcHxEkXDMmlNqhcuWHP8CaGc7GPL
 b4b35DL4edaG3fv3hd3otwIAXnfTGQZ1n9gtk0nFoi8CVmQCbdjSjqoheZDym/ujS8hV
 knl7w4+LRmHbRo72HdVzpfgtsAD4jGeB5LUo46tKYfPdifLzOYR7/gBVu6ZoT8cUksFJ
 jTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=575i0kl12NVak4MXLXn7jsLioeAHAQ7GMt0OozyFMPE=;
 b=MKbPW7c7LA217bFetVBhVxizsajVlEnZ0U0U5Na9wVAUoDWmmEPNkPc+AZh4YZPK1c
 VugBTLg8dmUN8Rvls4EOpx6l0rieH+S9+crFmR4UvClrMFFOhSYPloUzzUDzaxUWf7VG
 svfssgTvHuTtD9QVvc97mWF+D73UGOHa7OADv8WjloGCcx9BvhXs0F1ImyWhQfHarn4k
 u/w81TuNqcCY6+CohK9V0+jqGBFuvkefyWkKOitOjjaMzvqFyNT81QjT7N6rDoeG9VV0
 FtTUDTtlxWZvs3ajE+WVnJmECjsA+zgxxfPOc0a783YdVRWjLFNMBA4m2p/rsOggWXU/
 Cc/w==
X-Gm-Message-State: APjAAAX88vS1LD/OACiKKOEwXB0ShhbhLu7VbzO5OQgPBQfl+RhMYlih
 hH0d9e/BV2ECIE5wK78ED3I0Pg==
X-Google-Smtp-Source: APXvYqwCnzfbNl71vf1VjTNwpY2n3SFlq62hnzgtm++QyT5fIiqpC5CAXkNZiLm8eutY0+fQYKwY5w==
X-Received: by 2002:a5d:51d1:: with SMTP id n17mr21127446wrv.52.1560794009196; 
 Mon, 17 Jun 2019 10:53:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t14sm8713619wrr.33.2019.06.17.10.53.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 10:53:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 18:53:17 +0100
Message-Id: <20190617175317.27557-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617175317.27557-1-peter.maydell@linaro.org>
References: <20190617175317.27557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 6/6] target/arm: Execute Thumb instructions
 when their condbits are 0xf
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

Thumb instructions in an IT block are set up to be conditionally
executed depending on a set of condition bits encoded into the IT
bits of the CPSR/XPSR.  The architecture specifies that if the
condition bits are 0b1111 this means "always execute" (like 0b1110),
not "never execute"; we were treating it as "never execute".  (See
the ConditionHolds() pseudocode in both the A-profile and M-profile
Arm ARM.)

This is a bit of an obscure corner case, because the only legal
way to get to an 0b1111 set of condbits is to do an exception
return which sets the XPSR/CPSR up that way. An IT instruction
which encodes a condition sequence that would include an 0b1111 is
UNPREDICTABLE, and for v8A the CONSTRAINED UNPREDICTABLE choices
for such an IT insn are to NOP, UNDEF, or treat 0b1111 like 0b1110.
Add a comment noting that we take the latter option.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4750b9fa1bb..45ea0a11c7c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11595,7 +11595,14 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
                 gen_nop_hint(s, (insn >> 4) & 0xf);
                 break;
             }
-            /* If Then.  */
+            /*
+             * IT (If-Then)
+             *
+             * Combinations of firstcond and mask which set up an 0b1111
+             * condition are UNPREDICTABLE; we take the CONSTRAINED
+             * UNPREDICTABLE choice to treat 0b1111 the same as 0b1110,
+             * i.e. both meaning "execute always".
+             */
             s->condexec_cond = (insn >> 4) & 0xe;
             s->condexec_mask = insn & 0x1f;
             /* No actual code generated for this insn, just setup state.  */
@@ -12129,7 +12136,11 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     if (dc->condexec_mask && !thumb_insn_is_unconditional(dc, insn)) {
         uint32_t cond = dc->condexec_cond;
 
-        if (cond != 0x0e) {     /* Skip conditional when condition is AL. */
+        /*
+         * Conditionally skip the insn. Note that both 0xe and 0xf mean
+         * "always"; 0xf is not "never".
+         */
+        if (cond < 0x0e) {
             arm_skip_unless(dc, cond);
         }
     }
-- 
2.20.1



Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629B1C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0AF1218A0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tSXv39r1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AF1218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj4XM-0007NB-UQ
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 12:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44221)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hj4Hd-00084K-W0
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hj4Hb-0002JM-Ve
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:29 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hj4HU-00029z-9v
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:22 -0400
Received: by mail-wm1-x342.google.com with SMTP id n9so6260236wmi.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=jcWZDKHnpMlELavBPABwOL/us8df3sdUAODi66ZZKI0=;
 b=tSXv39r13iwNG0UMBVZxL5JOUyLSsMKDQbaRCGhSqkt1FWsOdMal/CvCbXCi2nLdxA
 idWGRwgkXZmjDwg/rLVNlcPxDj3HV69/HtdTYd36IouEMcclmRmJuta31v476WlV2xf6
 noepUSQ7aq3jgHqUQiwG8qhl2bdvigoPnlKygNMdHaFRh6obu3sbs5TkmBAle5fIM1cC
 sqsJT0x3uWYmECCQwU69yHhauh8uudmSDzL0xQNXZDUaDpG3zMzFFupG+NK1PNyNToMD
 6DuMUiOEKum2CB6NXGxsFsIJcLnAO0yugMs0my9qB7bpaDhcdlSkNrxtIXHbHna8DTjp
 /F1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jcWZDKHnpMlELavBPABwOL/us8df3sdUAODi66ZZKI0=;
 b=hK1sMVyGX4KZ17v6oHpoLtRXuRH1ygM4Kurt0lZDol64Psw7usia7MpvRIfKraTWbp
 EUxqeGe+OLF2Va/GUAATmeVnwUuJBe7jsB+ElFiqDh4AVLVUcumGFHDp4sZ5sah1xgJA
 CoRa12o8u3NCTW81szeefNBAD6Q+UOibhx/mgXwg+wjwDiIeZxq3ELf/AeRMgsifEfOu
 vmM6xKGNpHOsLbwk2arL+KfADxFLBYOJdqgFwMtPsXogYPpbyPcz+40NxReGjhWL0qSW
 GVEkDuD5YVOcRdf5OBevs8zo7eP+dulBpIDVHJppOKaes+zcsczkgfl4B+STp1QNM04E
 BeUQ==
X-Gm-Message-State: APjAAAUdOm6sSXEAdLp7amh9wctMXnALrm6ExqCdvHVUVKCJ+QSX9aYt
 D+7/cuWxQsCpTgRnqSsR/nLRVHyCg/NnAQ==
X-Google-Smtp-Source: APXvYqzBX+EHenXYqytwBzWzz1kyfQkeD/L8LEBMOOgUEIk+aZ55TMN9OaUV0FRdIHrnlBnXaV/+EA==
X-Received: by 2002:a05:600c:2189:: with SMTP id
 e9mr209600wme.56.1562256496744; 
 Thu, 04 Jul 2019 09:08:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s2sm3849690wmj.33.2019.07.04.09.08.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 04 Jul 2019 09:08:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  4 Jul 2019 17:08:01 +0100
Message-Id: <20190704160802.12419-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190704160802.12419-1-peter.maydell@linaro.org>
References: <20190704160802.12419-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PULL 8/9] target/arm: Execute Thumb instructions when
 their condbits are 0xf
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190617175317.27557-7-peter.maydell@linaro.org
---
 target/arm/translate.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index a5d77234232..7853462b21b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11594,7 +11594,14 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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
@@ -12128,7 +12135,11 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
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



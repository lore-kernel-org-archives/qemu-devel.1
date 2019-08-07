Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4746BC19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:54:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1138021743
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 04:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a7oeOzFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1138021743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvDy4-0002fz-AY
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 00:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40563)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxM-00012U-8G
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvDxK-0004iY-EZ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:48 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvDxK-0004hh-9B
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 00:53:46 -0400
Received: by mail-pf1-x442.google.com with SMTP id m30so42774759pff.8
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 21:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sTmPUIypnziYaVGRFy0ALsWEJTPu9wrCWxAaqC9PPBw=;
 b=a7oeOzFRGXtuyzqaFWdbCMWvJXEENm+AagrmWV5f4ziqMOwceC8DCKliWoyOQN/wqK
 DyEybt0iOtL7E4bl6MgQSonlrbKd1cm9XH8uuFhwzzl3xTRhp5qD8LyV55UlntCMITWQ
 YGbgzwa+mj+PFWq1NSTnF7+SgWgOsZN8d0ciZs7dqTqxJky2iyvI2+2oHe9liYkjIyPE
 zvVHMu4gBHN/kjqnwQ65S2p4yniXLuLytHYn8qA8L8XsXtutSALGK9pBxscoCglFvI8e
 KyUfrk34QknjqIXIgiygCQzilJZssWbEsbm3VIj4GNlXN3ek1k64ZVzz5W3XXLuTQS5b
 0u5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sTmPUIypnziYaVGRFy0ALsWEJTPu9wrCWxAaqC9PPBw=;
 b=GfauLBSKHBXn69k8YU5V9YZFY4VZdRpAshWzkvrM0QM34Pc3z+3QGyst7r8//zzulc
 DQv92ud/efubb138dUEyiLHAn/5jSRXGt/1IMGLwF21BZL3DnxikOKvY0Mh4NI8lB+GI
 lPoFYS4/FztJ0yTkJTuIpY5ezeuvp2X3SKfI2HuE+RxvKYMyNJs3LSHtGidCoInRIV1w
 JWVphiYUGvrwyWYsLLlGersp2bcUpS2+6Xbrj034s0LjdLJLC7YVmqsYt/AtxGO0Kyhz
 M4fEkwGZtIvYp6JZk42iSEbaGbRTSpGdBLy/KzTqt/G1YVqMmku/QfNEk5UOihrPI8G1
 5IvQ==
X-Gm-Message-State: APjAAAU0vBE0CIkd3Ere0CnZJKrBLNKyuQAV2G68qC0U4aXcv83fJtEq
 0GypipY8QIr8xigHPSKx2Rdn01/ZsHk=
X-Google-Smtp-Source: APXvYqzRD0LvDC5Z4IDb8BPFg0/ezNm9Xny6F3ipFGZSQlbfL97b+juRlBs1aXXuBgqdeDloOa4glw==
X-Received: by 2002:a17:90a:8d0c:: with SMTP id
 c12mr6350022pjo.140.1565153624961; 
 Tue, 06 Aug 2019 21:53:44 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t9sm24347921pji.18.2019.08.06.21.53.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 06 Aug 2019 21:53:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  6 Aug 2019 21:53:25 -0700
Message-Id: <20190807045335.1361-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807045335.1361-1-richard.henderson@linaro.org>
References: <20190807045335.1361-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 01/11] target/arm: Pass in pc to
 thumb_insn_is_16bit
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

This function is used in two different contexts, and it will be
clearer if the function is given the address to which it applies.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7853462b21..1f15f14022 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9261,11 +9261,11 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
     }
 }
 
-static bool thumb_insn_is_16bit(DisasContext *s, uint32_t insn)
+static bool thumb_insn_is_16bit(DisasContext *s, uint32_t pc, uint32_t insn)
 {
-    /* Return true if this is a 16 bit instruction. We must be precise
-     * about this (matching the decode).  We assume that s->pc still
-     * points to the first 16 bits of the insn.
+    /*
+     * Return true if this is a 16 bit instruction. We must be precise
+     * about this (matching the decode).
      */
     if ((insn >> 11) < 0x1d) {
         /* Definitely a 16-bit instruction */
@@ -9285,7 +9285,7 @@ static bool thumb_insn_is_16bit(DisasContext *s, uint32_t insn)
         return false;
     }
 
-    if ((insn >> 11) == 0x1e && s->pc - s->page_start < TARGET_PAGE_SIZE - 3) {
+    if ((insn >> 11) == 0x1e && pc - s->page_start < TARGET_PAGE_SIZE - 3) {
         /* 0b1111_0xxx_xxxx_xxxx : BL/BLX prefix, and the suffix
          * is not on the next page; we merge this into a 32-bit
          * insn.
@@ -11824,7 +11824,7 @@ static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
      */
     uint16_t insn = arm_lduw_code(env, s->pc, s->sctlr_b);
 
-    return !thumb_insn_is_16bit(s, insn);
+    return !thumb_insn_is_16bit(s, s->pc, insn);
 }
 
 static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
@@ -12122,7 +12122,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     }
 
     insn = arm_lduw_code(env, dc->pc, dc->sctlr_b);
-    is_16bit = thumb_insn_is_16bit(dc, insn);
+    is_16bit = thumb_insn_is_16bit(dc, dc->pc, insn);
     dc->pc += 2;
     if (!is_16bit) {
         uint32_t insn2 = arm_lduw_code(env, dc->pc, dc->sctlr_b);
-- 
2.17.1



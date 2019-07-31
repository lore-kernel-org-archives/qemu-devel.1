Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D81C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B47D2067D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDf7QpKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B47D2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvbM-0004GM-Mb
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33229)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvNG-0005du-Fk
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:39:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvNE-0003rp-Gl
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:39:02 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvN8-0003oW-W5
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:58 -0400
Received: by mail-pf1-x443.google.com with SMTP id 19so32508020pfa.4
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1OFhZYB7REGpAAmdzyA7otQ/hGEth32oUJ6nOIibRSY=;
 b=NDf7QpKnwte7o2e/AQwdvefCheNM2JdcDcBOF3wBDKoSgnTGFpCO9saXeQGplF+LTO
 pQeKjSPhi4mSD/xCCu8EReRtXylQ4qDXgMtQ6/pFUUqkBxhBGT7FX0Ys7NVUU5Irf0vL
 OQpPbWODiN95XCblrujJIMXYzVhYePWixrN3JAsghy5vnHTnvu6u/bt/+K6dtQx6HlHI
 xYaL+1H47ngKC9c4g9inXLp+PCRlaxa06Sk4PZLMzKdYA4T8VBg59Ucq/e7F0gplKOhm
 IvoTDlFg56dZD93W0+jiPZa3X2p3XAYbozan0337sMlmGrQoIguBwzz8vNGHqBqoHe58
 eO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1OFhZYB7REGpAAmdzyA7otQ/hGEth32oUJ6nOIibRSY=;
 b=UmRqo/w/9hiqvmFdWQl4mkmhXSnEn4oc7DwtrFvMM9wa1XSSq/I8jSxZ/22yCWVA32
 VSrSYtjooYQNsbJSzXYIgP8kj6ZR+EP8UsG4Jamg1qjxb5OG5EwDiKAWFX9eCFoDOOlP
 vlIevvwQlDVPH6bO+NjmjZa/C/p9qq/BIfPhfVD4GIAS5aBMHeIi1NRbR0n/lavx78mB
 JcwFzUaa5aKocG2pCMLhGnJQNALk8/ezIwZzPXQI5qr3oMt8Cy7G5EKllxK5s2J5Bwxr
 4VVfLqv2qsJtHQly+x6jbXSpUhBqHbCEKAUA18J95hqIMxjVehgMEZ1eCr65NwPkh5xt
 zhvw==
X-Gm-Message-State: APjAAAUp2ofG4qh52oyJMfn0MrsW9i96Bp+HCQEVUkM50icNWgW0XR1Q
 +An1cTtdg4JAeiARoIBVXZheiwvDi14=
X-Google-Smtp-Source: APXvYqxGYhWlVndlnlNldzfoXAoz0yztGfhbJKW3XqxS5inma4EnKr9T7KDJpzdp8PCTG2s3KVThDw==
X-Received: by 2002:aa7:956d:: with SMTP id x13mr49793061pfq.132.1564605533112; 
 Wed, 31 Jul 2019 13:38:53 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:38:12 -0700
Message-Id: <20190731203813.30765-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v2 31/32] target/arm: check TGE and E2H flags
 for EL0 pauth traps
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

From: Alex Bennée <alex.bennee@linaro.org>

According to ARM ARM we should only trap from EL0
when TCG or E2H are 0.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/pauth_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index 42c9141bb7..9fa002068e 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -371,7 +371,9 @@ static void pauth_check_trap(CPUARMState *env, int el, uintptr_t ra)
     if (el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
         uint64_t hcr = arm_hcr_el2_eff(env);
         bool trap = !(hcr & HCR_API);
-        /* FIXME: ARMv8.1-VHE: trap only applies to EL1&0 regime.  */
+        if (el < 1) {
+            trap &= !(hcr & HCR_TGE) | !(hcr & HCR_E2H);
+        }
         /* FIXME: ARMv8.3-NV: HCR_NV trap takes precedence for ERETA[AB].  */
         if (trap) {
             pauth_trap(env, 2, ra);
-- 
2.17.1



Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77842C41514
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 02:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478B9206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 02:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LEmWMpKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478B9206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2QnY-0001VK-7w
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 22:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2QmS-0000vv-6P
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 22:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2QmQ-0006yW-Ln
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 22:00:19 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33609)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2QmP-0006wL-Vy
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 22:00:18 -0400
Received: by mail-pg1-x543.google.com with SMTP id n190so11713091pgn.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 19:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=bJA2+ktpjDLGHMwu4tIOVTroGCG/bmh52cf78i4dezA=;
 b=LEmWMpKaeOcDn1Ur7h7N84XHvdiogXzC5uTZrI+tE8Am/5l8uW5gNPg49VVj3JGngx
 h4j5z7JWVTvl7rl/zWUdNx8Vd8qVtwheQ1lV2UTfmSvpm0GcCjmRWBdIMd9Vkbw91JCr
 fjsrBnprytr9uxhUwHhoOH+ExBMq18i211Z1xLLSNhefIGKt6FqXQgbtHEY3K9eP8m3V
 mf/j1GlnVXEyG/f4pBftFqIDuHDo2dWA6FjqBy2dOFYfpu3WZIegn6aPsiNZzCGWOSd1
 1XPby5Z+C509rGJXan4YvEG+UqGhKBDc79rqJ4VVLv9Lx3SbghhYmVRFpvcRF5sdrQBM
 H7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=bJA2+ktpjDLGHMwu4tIOVTroGCG/bmh52cf78i4dezA=;
 b=r5s92ADTjmBwCJar5S8xVX+DJkFu68vXn3mziwTiivLDtOQEQQak4+FALJV5yLmmot
 vyqdrSWhQiBV7pjONtWEmPF+6L2y1j635ianh4i0MsjWTZ+m//s2il66RuPJPseCf7X/
 xmZqRrdm4vtY74g6fap9qGNJ5enDG/ArZZOXK6XkUis6OO4705VgjNS9LfondGU+z0az
 +X1n1xNGmm8kzXQ7ne0UrecXyemdXb+a17h3UPQgXVFR9UGXHz8eKObrxKFSofnaDoLm
 QFSC7Xq5J+A7zOgudyZkjvtDmPJSI+Rshsv1VohmBfzEgqUXAf8ev1nR0VztC1+KznXl
 d9Qg==
X-Gm-Message-State: APjAAAVFp8GZ2t4N4eobe6IJ/WXgz3/+Uer4Uio49H/oMpkhfy+66dBc
 yYJci10HpKtWEb7FmSeuXmt/nTPkOhc=
X-Google-Smtp-Source: APXvYqwwiwN911neKtvs4FsIbrQDSrK9VYg8TG2Cnjx4RjXpDDJvxvp4cfemNka52SeWZ5+YFQT4GQ==
X-Received: by 2002:a63:1d4:: with SMTP id 203mr18925320pgb.441.1566871215850; 
 Mon, 26 Aug 2019 19:00:15 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s4sm653707pjp.15.2019.08.26.19.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 19:00:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 19:00:13 -0700
Message-Id: <20190827020013.27154-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH] target/ppc: Set float_tininess_before_rounding
 at cpu reset
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
Cc: qemu-ppc@nongnu.org, pc@us.ibm.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As defined in Power 3.0 section 4.4.4 "Underflow Exception",
a tiny result is detected before rounding.

Fixes: https://bugs.launchpad.net/qemu/+bug/1841491
Reported-by: Paul Clarke <pc@us.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate_init.inc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 4a21ed7289..023138c2f9 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10461,6 +10461,10 @@ static void ppc_cpu_reset(CPUState *s)
     s->exception_index = POWERPC_EXCP_NONE;
     env->error_code = 0;
 
+    /* tininess for underflow is detected before rounding */
+    set_float_detect_tininess(float_tininess_before_rounding,
+                              &env->fp_status);
+
     for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
         ppc_spr_t *spr = &env->spr_cb[i];
 
-- 
2.17.1



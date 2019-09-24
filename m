Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0395CC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD89920872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="THY2tt0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD89920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCs3q-0001PM-8j
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 17:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw0-0002XQ-RF
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrvy-0004Tr-K8
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:20 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33517)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCrvv-0004S9-2e
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:17 -0400
Received: by mail-wm1-x342.google.com with SMTP id r17so2494174wme.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ga7uunm/945QAukjyLgeNBXLoqr7gtD7KgepZs9QTXE=;
 b=THY2tt0w+DowVHywlbF5pOM+PuCes/RILuoRPdQiVA3hvhUM7gRSi8L4I/84USKrTg
 22LDMceo+S3M4I12vHAwPzS7QuQCIVRssZI3Z65Db6ht8gjv4q/D06gJm3YIfxHwoYnP
 mAoWxS7wdxPzuLnwOb8lfUCYTf18IAivX/bO/Qw344Z8C/fe3366F6ktPGxZ0cQXkuGv
 LXDTs9eOIdp3OB5i4UOZ3B3S2ivDLadn9IjEUc3jQ+wbdsAP8d5iEOhehDPmPAKxhS4r
 8yxKK4OupLZr3EG0PkE5dnRWFWVug/rOitn62wjSwZ/Z/DkDLDYQJR3IeElWJPKm2OI0
 xY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ga7uunm/945QAukjyLgeNBXLoqr7gtD7KgepZs9QTXE=;
 b=pyBlA5gtmxhrb5HNceEr2m/zvjJgUQVQJT+X7BBNlAdwCdxpq/aH4B85TPQrDuwmKy
 wFkoFlCvM4RjD0gxA48Rkp4ZFgHBb2uQNIkn/BHLLYs/vA0dE7W4+sL5vQNBXF6ofqqr
 +/aKZGkRMprk5BwHkSe6Y7cbeL4dwGMdRmZZQOnxrfup90XqMwqXQwOLSXnU1B5B0Z08
 86nJZrzS2k8fkgzsPTW200sOrpyZAY6HrDyRlL7Bd6xFxluQNlDpu85my+5hqDA0YDph
 pl8+ywKW+FZq76j7ywPiPnQMsRWuFItecP5FNDu/9T/gV+hFit/smlVGki3oo+gGtBIV
 2NeA==
X-Gm-Message-State: APjAAAUy0Np/x7/IKTRmKddbq6vcEk6zqCEt7hFQRUID4TwoR+geyRUa
 nYsP6B1hjvWbSLoI/QbLH82ACw==
X-Google-Smtp-Source: APXvYqwJHpsLQmTggSQcF30Yp/eSswvzt9198HiB0OZgjIuZuPzdBS45XALZOl7/50e3zK8iMX29Dg==
X-Received: by 2002:a7b:c0d4:: with SMTP id s20mr2585705wmh.101.1569358869962; 
 Tue, 24 Sep 2019 14:01:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y14sm4548491wrd.84.2019.09.24.14.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:01:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 21EE81FF90;
 Tue, 24 Sep 2019 22:01:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 03/33] target/alpha: Fix SWCR_TRAP_ENABLE_MASK
Date: Tue, 24 Sep 2019 22:00:36 +0100
Message-Id: <20190924210106.27117-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jsnow@redhat.com,
 f4bug@amsat.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The CONFIG_USER_ONLY adjustment blindly mashed the swcr
exception enable bits into the fpcr exception disable bits.

However, fpcr_exc_enable has already converted the exception
disable bits into the exception status bits in order to make
it easier to mask status bits at runtime.

Instead, merge the swcr enable bits with the fpcr before we
convert to status bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190921043256.4575-4-richard.henderson@linaro.org>
---
 target/alpha/helper.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 10602fb3394..e21c488aa32 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -46,34 +46,39 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
     uint32_t fpcr = val >> 32;
     uint32_t t = 0;
 
+    /* Record the raw value before adjusting for linux-user.  */
+    env->fpcr = fpcr;
+
+#ifdef CONFIG_USER_ONLY
+    /*
+     * Override some of these bits with the contents of ENV->SWCR.
+     * In system mode, some of these would trap to the kernel, at
+     * which point the kernel's handler would emulate and apply
+     * the software exception mask.
+     */
+    uint32_t soft_fpcr = alpha_ieee_swcr_to_fpcr(env->swcr) >> 32;
+    fpcr |= soft_fpcr & FPCR_STATUS_MASK;
+#endif
+
     t |= CONVERT_BIT(fpcr, FPCR_INED, FPCR_INE);
     t |= CONVERT_BIT(fpcr, FPCR_UNFD, FPCR_UNF);
     t |= CONVERT_BIT(fpcr, FPCR_OVFD, FPCR_OVF);
     t |= CONVERT_BIT(fpcr, FPCR_DZED, FPCR_DZE);
     t |= CONVERT_BIT(fpcr, FPCR_INVD, FPCR_INV);
 
-    env->fpcr = fpcr;
     env->fpcr_exc_enable = ~t & FPCR_STATUS_MASK;
 
     env->fpcr_dyn_round = rm_map[(fpcr & FPCR_DYN_MASK) >> FPCR_DYN_SHIFT];
 
     env->fpcr_flush_to_zero = (fpcr & FPCR_UNFD) && (fpcr & FPCR_UNDZ);
     env->fp_status.flush_inputs_to_zero = (fpcr & FPCR_DNZ) != 0;
-
 #ifdef CONFIG_USER_ONLY
-    /*
-     * Override some of these bits with the contents of ENV->SWCR.
-     * In system mode, some of these would trap to the kernel, at
-     * which point the kernel's handler would emulate and apply
-     * the software exception mask.
-     */
     if (env->swcr & SWCR_MAP_DMZ) {
         env->fp_status.flush_inputs_to_zero = 1;
     }
     if (env->swcr & SWCR_MAP_UMZ) {
         env->fpcr_flush_to_zero = 1;
     }
-    env->fpcr_exc_enable &= ~(alpha_ieee_swcr_to_fpcr(env->swcr) >> 32);
 #endif
 }
 
-- 
2.20.1



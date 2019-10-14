Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B54C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405212133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fnNV9lQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405212133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3DK-0001SL-TZ
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qB-0004Oh-GT
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qA-0007Yy-Ah
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:59 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34927)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qA-0007Y7-4l
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:58 -0400
Received: by mail-wm1-x343.google.com with SMTP id y21so17309012wmi.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=OCgOaHwxCv0IbpTF8r+Cdvboj+Te5f+2dZxg5QmbFwY=;
 b=fnNV9lQG02kvxBczkbpP6nZHP0KzBoJ3i6BwxKIkgWuUtA7QjfN3PoJXrZTjEXmpZD
 oxiYPvBG52+5G69zlAT6VoUDrDtofgfsPF7uCjYyAEIO3Ntv8cdAsgbcGGARZNQLXHTL
 btHfmFqJL70pKnqsdc7BcvuPqCznmoXpxZMWETlOA9mpdU64Wv7bqr1Hi+c+4ML9VSzX
 f40vRa4Gd4e+a1B+6YBvu4RIpPKwEKYE1wAKqmLVNEtOVmAV7HuvbHhILKoy8m5cyEgm
 cFJLROHwSW/gRdTO7rPVmE6y5gBg3k8O+1iQGEW1Hgqns9pwp7RLCmzH3CTqTRm0CH5g
 BTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OCgOaHwxCv0IbpTF8r+Cdvboj+Te5f+2dZxg5QmbFwY=;
 b=RiOyQqjiNKbpizEtY0erFhwUVGJ7x4M5DmCBg3u4TKfC6HGXv1RM7vQt9fjCxNgjuD
 0Qm3e/uKvpXO27JRPaQc082/T5CmcB63HFrqTIYdIjJl6nQ1MqJ4eXBLJHgKuP9lNc1V
 jR/4wQTf7pefQ3mFTSJVHBFYNtLJ/+6XDArqvfLRyP7P1iRWcsl6IGP+hLlErHkkCquT
 Jc/vqCm/zN3hQC3PJ74sn+lY29R87xpfsA3rh5iFchzhn1fiIKTesTR5UDQbJmG8a2G3
 Fht93JbKpHvwswONJ/cv1UGIsoJmtNgjUjql8EkwsaTBvRaoHoCOcTuGtHgFBokLrxjn
 WYKA==
X-Gm-Message-State: APjAAAXEE8JlcPS1mwrD9ud7p6A7BWvkYHo0xK6VEPJKV/7NaafGY/aN
 Pw03cAB1kXbvfd7qm9Pmy+Em7IVD7Rt+iQ==
X-Google-Smtp-Source: APXvYqw8zf2dUVMThtymXMvF18Qr5PO0eGF7rikiJV3yUlf8hE6FqEzCqG7Lmkt+9W+sN0QsojntHA==
X-Received: by 2002:a7b:caa9:: with SMTP id r9mr14869686wml.133.1571069096769; 
 Mon, 14 Oct 2019 09:04:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/68] target/arm/arm-semi: Correct comment about gdb syscall
 races
Date: Mon, 14 Oct 2019 17:03:23 +0100
Message-Id: <20191014160404.19553-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

In arm_gdb_syscall() we have a comment suggesting a race
because the syscall completion callback might not happen
before the gdb_do_syscallv() call returns. The comment is
correct that the callback may not happen but incorrect about
the effects. Correct it and note the important caveat that
callers must never do any work of any kind after return from
arm_gdb_syscall() that depends on its return value.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190916141544.17540-4-peter.maydell@linaro.org
---
 target/arm/arm-semi.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 51b55816faf..302529f2278 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -217,10 +217,21 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gdb_syscall_complete_cb cb,
     gdb_do_syscallv(cb, fmt, va);
     va_end(va);
 
-    /* FIXME: we are implicitly relying on the syscall completing
-     * before this point, which is not guaranteed. We should
-     * put in an explicit synchronization between this and
-     * the callback function.
+    /*
+     * FIXME: in softmmu mode, the gdbstub will schedule our callback
+     * to occur, but will not actually call it to complete the syscall
+     * until after this function has returned and we are back in the
+     * CPU main loop. Therefore callers to this function must not
+     * do anything with its return value, because it is not necessarily
+     * the result of the syscall, but could just be the old value of X0.
+     * The only thing safe to do with this is that the callers of
+     * do_arm_semihosting() will write it straight back into X0.
+     * (In linux-user mode, the callback will have happened before
+     * gdb_do_syscallv() returns.)
+     *
+     * We should tidy this up so neither this function nor
+     * do_arm_semihosting() return a value, so the mistake of
+     * doing something with the return value is not possible to make.
      */
 
     return is_a64(env) ? env->xregs[0] : env->regs[0];
-- 
2.20.1



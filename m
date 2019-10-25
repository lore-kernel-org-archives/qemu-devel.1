Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC671CA9EBC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:48:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C96521D7B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rI/Usq5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C96521D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNy55-0001ji-Tp
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwP-0006gF-2K
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwK-0006dP-FL
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:34 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:43147)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNxwJ-0006bg-Ex
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:31 -0400
Received: by mail-qk1-x741.google.com with SMTP id a194so1390358qkg.10
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 04:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=s0q1vqFGnAcsw/qw8CdtCPCtjm1BmD/+WvFX3Z3uxE4=;
 b=rI/Usq5OenuuvTlRkFeZwBOfcZNf9ytXpIcywXy9m/M8IZ2mPyUS50ReGVbqmJTGcK
 6SdGdFYeIdaAAnG/RXVWxBx4cI6SA6/8sNcdVlorKPbVgH9k1iA9QMAz3W7sXNNxoVk0
 48Za501PLhL7T45dHqHyex6UmTH95Nf5KJujwROOeK/iWUTLjVzuIZJ8z7xAwFI+z780
 Bx6S5fiMefqedeKM+B2hr3NewIbGkj24iHwCR5KdkoPAej8hkEQbMloCvQtnDsSSpeU1
 1tKN8epoJCIODXYFWSNibNSYI/uPIYDrLe+y2Lw+VKtb7dg0OkaCMFc+UmpwRz1TE++s
 eQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=s0q1vqFGnAcsw/qw8CdtCPCtjm1BmD/+WvFX3Z3uxE4=;
 b=SRlf3p2HixRdQxfEWxaY0+gSFXbY7KdYYbImctVJgaZDKPvTbhpkLsR2aYYoMnoHTH
 FgAex1+LTmy88W6+MS8sIn+jdMqc1PhxB5S2yyFuZlTNKlzteCh7xw0BFk0ZI6g7OaKf
 Z9rwTq1JJ+pY6VW10KWMA93MR1eJayFEnMIhiEyluqXBVrmcEkbIslWx6sFw+e4uHyUa
 NI8GW/8ZrtctldwZxdITy83maVwDER6JdS4dUzQHIS3/zcX6MMM9SLa8AFI6g1k2eSlM
 6r+BVT0uIm4GDinLmJbiJI8D1uC2ejd/MrTxflFFguTDW6bFQzV8TNh41l/UH7bO1Har
 YIMQ==
X-Gm-Message-State: APjAAAUHa0HNr3vrXkjn47uWd1DK/3+5KS948pwFUyu1e1GFtuljCmOg
 jUM1wnjYMOpbjBhx/KwOI4VDQ5ghUXQ=
X-Google-Smtp-Source: APXvYqwng05J8eA2QXskL8IGIoydiKvqPSwJY3peuZwGomX5CnrahBUbtHWG8D33cJUODw75m/tSRw==
X-Received: by 2002:a37:816:: with SMTP id 22mr2479620qki.454.1572003569270;
 Fri, 25 Oct 2019 04:39:29 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id x38sm1473335qtc.64.2019.10.25.04.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 04:39:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/12] linux-user/sparc: Use WREG_SP constant in
 sparc/signal.c
Date: Fri, 25 Oct 2019 07:39:15 -0400
Message-Id: <20191025113921.9412-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025113921.9412-1-richard.henderson@linaro.org>
References: <20191025113921.9412-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

s/UREG_FP/WREG_SP/g

This is non-obvious because the UREG_FP constant is fact wrong.
However, the previous search-and-replace patch made it clear that
UREG_FP expands to WREG_O6, and we can see from the enumeration in
target/sparc/cpu.h that WREG_O6 is in fact WREG_SP, the stack pointer.

The UREG_SP define is unused; remove it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc/signal.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index a967e2db73..0db4c5f84f 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -104,9 +104,6 @@ struct target_rt_signal_frame {
     qemu_siginfo_fpu_t  fpu_state;
 };
 
-#define UREG_FP        WREG_O6
-#define UREG_SP        WREG_I6
-
 static inline abi_ulong get_sigframe(struct target_sigaction *sa, 
                                      CPUSPARCState *env,
                                      unsigned long framesize)
@@ -201,7 +198,7 @@ void setup_frame(int sig, struct target_sigaction *ka,
         goto sigsegv;
 
     /* 3. signal handler back-trampoline and parameters */
-    env->regwptr[UREG_FP] = sf_addr;
+    env->regwptr[WREG_SP] = sf_addr;
     env->regwptr[WREG_O0] = sig;
     env->regwptr[WREG_O1] = sf_addr +
             offsetof(struct target_signal_frame, info);
@@ -255,7 +252,7 @@ long do_sigreturn(CPUSPARCState *env)
     sigset_t host_set;
     int i;
 
-    sf_addr = env->regwptr[UREG_FP];
+    sf_addr = env->regwptr[WREG_SP];
     trace_user_do_sigreturn(env, sf_addr);
     if (!lock_user_struct(VERIFY_READ, sf, sf_addr, 1)) {
         goto segv_and_exit;
-- 
2.17.1



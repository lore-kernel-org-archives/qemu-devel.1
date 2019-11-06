Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84631C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD2B2077C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rhp4LYJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD2B2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJgu-00054k-3A
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZD-0003nQ-DZ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZC-0007NS-9w
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:39 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35645)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iSJZC-0007HH-3l
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:38 -0500
Received: by mail-wm1-x344.google.com with SMTP id 8so2953669wmo.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=s3dwTlrDDpUYfBm35ZTmNP1iU/J47qcplhioQiqvjIo=;
 b=Rhp4LYJmaMgM95v343vixf0U4RAGvipb82Hwie/A42J68lE0AwWTrx43EaHhPXyvmV
 MApd5eoLvFk6GGMzZIb9zB7ebsGZGQBlFnf06cQDr+G6KNu2m6GF3OUnWD1+2fbA5awx
 K2S/h76WzLHPqGgslcjnjeeuHWWpWXZxvP7zsc1PzCCNwYsP8ain60dpSXjhZrLLQDnG
 ZTesOZWwUxKIIsXOeiHW75OfpLdavoUkhj1tz0i0h3oX0ZOznuYeP68Bg6vyr2oOGv+G
 cl1h0beY1DxQ+XAfl8X30AqkqrEkNlfeZqC2FK3X5AHTjXvupaAmkd752IeOzD4VME6c
 54SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=s3dwTlrDDpUYfBm35ZTmNP1iU/J47qcplhioQiqvjIo=;
 b=PaG0cJO7zC5IS2PWSQLiB5XeGXHrU5EpXNDaKocnAKC6cKUWvHQGai9+cYlHEv5R56
 UuZs4s5v1TdbTzyUKFACFXbDmp11OPVxXfWAbQCkSzXpT2hii+JD18DRQQKZIffCsHg4
 gSodBxCM5ZYHuXtdeqMzfCm12BX/w2M6sRrr3JwRfiAQAuV6D+GFAwzw20sdYMxJ2AUs
 lS6McM4R2ScSJwLFMnFxcJvn6VbDReRVpX+oXC4QMlWjeCyOWDFyZjjyXmpKLtyHBcpe
 rpeY4HB4aIqWyLxDsltBTMETnK/bhA5DJaywI2mzrzwmqFaxy5YVBKbvMKlyRtAju4RT
 EPuw==
X-Gm-Message-State: APjAAAX+gxW6m6q6iq05XzSoBPwkd5/atI3pV4So72EaGsdgUICxsEAO
 6eB83v/xTXeLYybdA05NMYf2EJ81pym4tw==
X-Google-Smtp-Source: APXvYqw/FywvKYpNtgAE+XOG6ioL+hMw90o7f0MWMcMF+L25nuUYIHoR2kqfM6IJ0A7psh18L2t1Vw==
X-Received: by 2002:a7b:c858:: with SMTP id c24mr2135270wml.174.1573040015600; 
 Wed, 06 Nov 2019 03:33:35 -0800 (PST)
Received: from localhost.localdomain
 (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
 by smtp.gmail.com with ESMTPSA id q124sm1776907wme.13.2019.11.06.03.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 03:33:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/12] linux-user/sparc: Use WREG constants in
 sparc/target_cpu.h
Date: Wed,  6 Nov 2019 12:33:10 +0100
Message-Id: <20191106113318.10226-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106113318.10226-1-richard.henderson@linaro.org>
References: <20191106113318.10226-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes a naming bug wherein we used "UREG_FP" to access the
stack pointer.  OTOH, the "UREG_FP" constant was also defined
incorrectly such that it *did* reference the stack pointer.

Note that the kernel legitimately uses the name "FP", because it
utilizes the rolled stack window in processing the system call.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191025113921.9412-5-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/sparc/target_cpu.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index 1ffc0ae9f2..b30fbc72c4 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -41,15 +41,9 @@ static inline void cpu_set_tls(CPUSPARCState *env, target_ulong newtls)
     env->gregs[7] = newtls;
 }
 
-#ifndef UREG_I6
-#define UREG_I6        6
-#endif
-#ifndef UREG_FP
-#define UREG_FP        UREG_I6
-#endif
-
 static inline abi_ulong get_sp_from_cpustate(CPUSPARCState *state)
 {
-    return state->regwptr[UREG_FP];
+    return state->regwptr[WREG_SP];
 }
+
 #endif
-- 
2.17.1



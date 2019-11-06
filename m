Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE90C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56602077C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P1J0U3fD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56602077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJdc-00018z-Dh
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZE-0003pP-Qt
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZD-0007Vu-O2
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:40 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35532)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iSJZD-0007Sh-HY
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:39 -0500
Received: by mail-wr1-x441.google.com with SMTP id p2so101342wro.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XRFH5cdPSAgNEt1BQCmYoOshHVpFTmX+EPnlR0Bd3jE=;
 b=P1J0U3fDOqGZZKMiIN+Em3ax0zOPZd2ojUNW47Za3sM5GMAZIRiq69oj4GJZ04ds25
 C2OYvPF/F1Gbpu31RWlV55bgdhIMhWZJC+J95rQW8KfYkqCtL8MsyN1uzjSWFUs8MXg1
 E8wnAsT/yuvxEFVoVwDTa/75iOLFRcleg2NpXnt93Z5HE1C9c+/lDre53G9lQytEVcjf
 atAyImxEOqXlOZXDDgSoBSSGZWIud5afUcLE+XlVm/+BABLzFObVKCsk4pOyzBSYxO8s
 tabugns0ZwpjGEZpu1WEWQJHNoOs63XakNfkUuJDmVWIAn2+9BprRdFdb7+6q6yZO/cG
 7LSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XRFH5cdPSAgNEt1BQCmYoOshHVpFTmX+EPnlR0Bd3jE=;
 b=la5G3W/qc3TFARK1s5WdvnSgpqjxA8X6UXhzSj7eNNYJUMsYySr6eGu0s7yuzzsqPO
 9RKMswYbbAOOtJexgVAKRE9XfybDe61x0SyR88c3dOy+syw6uM+QQclY4kJoe3IKm3+s
 LSLmAGTRpBHoMV7j3HeFXoqNg9glM+ZoQw+79i1kUCA/KYRC6/jzn1gGuTVHAq5KkKoz
 2I8Zyo5bhvmj/UxdU1WjawGZACHoQWW5V/ICFwiWqnXbjTTFoqZim9Q9f3DnOLujh/p7
 N+ceFOoikKDriTVXrF/GaNQQj/E382gqe2d/S2j7VsVK86My90XTlppj/rECbjQ4brq+
 RmvQ==
X-Gm-Message-State: APjAAAVwuzUFbebpoYNm44S3xmBLlafpV0UH5jLoaLQUMslw/VExjO2u
 8XaDx4z+Popall2jM85yKLrGjuubJooRag==
X-Google-Smtp-Source: APXvYqxGgYa82Vp6tL7KOoaOkVSdrPgbQA04iN3YmxrhCSivGL9d+Z+aIAcbuTIV1KsVdTRe/loj5A==
X-Received: by 2002:adf:f585:: with SMTP id f5mr2190612wro.272.1573040018179; 
 Wed, 06 Nov 2019 03:33:38 -0800 (PST)
Received: from localhost.localdomain
 (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
 by smtp.gmail.com with ESMTPSA id q124sm1776907wme.13.2019.11.06.03.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 03:33:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/12] linux-user/sparc: Use WREG_SP constant in
 sparc/signal.c
Date: Wed,  6 Nov 2019 12:33:12 +0100
Message-Id: <20191106113318.10226-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106113318.10226-1-richard.henderson@linaro.org>
References: <20191106113318.10226-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

s/UREG_FP/WREG_SP/g

This is non-obvious because the UREG_FP constant is fact wrong.
However, the previous search-and-replace patch made it clear that
UREG_FP expands to WREG_O6, and we can see from the enumeration in
target/sparc/cpu.h that WREG_O6 is in fact WREG_SP, the stack pointer.

The UREG_SP define is unused; remove it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191025113921.9412-7-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/sparc/signal.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index aac37da239..e05693f204 100644
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



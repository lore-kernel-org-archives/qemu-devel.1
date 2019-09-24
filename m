Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20915C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C6520872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VrsqwyAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C6520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCrzC-0004uQ-7P
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 17:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw3-0002ZN-4Z
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw0-0004VE-R7
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:22 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35372)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCrw0-0004SU-DA
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:20 -0400
Received: by mail-wr1-x443.google.com with SMTP id v8so3622618wrt.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qaJUV8jGxUXRdkCn1OSBrOh+BLwVQ4a81fS54bVOr5k=;
 b=VrsqwyAcpY68lBd7Wf6m4+qAdJlkrLNFQJBhnK614B2vIHOzzZr4IwxAHW0CJ8pF8y
 S63Bpc+O6jKvDHsrPVMkZlYQgwzXQ5ufxC2uM6YoVMsbpacxS9t07LOU6gTOEWzveXSv
 pUY+CZGIbm7MWPyJgtiCUffZYtiBTxI+HxVbHbK3nnoora1TosQzr/oA8F+dFC4/yhkk
 XXPTuEZrx1FQ+pzT2cGI4XZbYXERlXdmR3rbkGwEjuvqPASBgeZR3Qopl/wV1D6RriPK
 IG0BOoC/Ei/TWnLX22c1d6beNgDZKYbBXnQti3WMMkjHO+Mim2+Dk1T7ZSa2HeRA0C+h
 1hsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qaJUV8jGxUXRdkCn1OSBrOh+BLwVQ4a81fS54bVOr5k=;
 b=gMBeL54tVo2HYwlrp3jqRlPrbteqVmPQwBiQ9ccp4LSRoVoJ/x2fzfmpyKURKZC3MU
 QPCbJJNIEcqZF246Q8OWz1VSplrV6n62FIAcVTLzf74lOCjJyXIbj1toU2IBG+tlOtdE
 jXBecD+FWJQjFA6AOnpOGEwiIAEahaziGmDAoyUSG9/QoalJ88it8UBFeE4jQJ6p75m1
 gJ2/H4leZ6EZ6eT053oCiMCQk0zevpZpsK951RZoUjqidNYeJQ4dZmM/42g0cyZuSeIp
 E4nplHS8YZxyxA97yIymRjkVnuB++3F7y3IHMeudcnwYTssQijEmlXYLPIQhgvsKegRK
 p2MA==
X-Gm-Message-State: APjAAAXQ95scCnMOvU6IOu4kVbM8aZGpST9mkSP8nZ/hVeMIVbNZJRiv
 J9oPQVEYBGk20jZz8mCCrcwFag==
X-Google-Smtp-Source: APXvYqwDLUqi593AvPR5nfTYDcNJK6iTc/EK92L8u7WOVrWdTCA8ysnvZZni+Cd+86VSsZx4hQceGw==
X-Received: by 2002:a5d:4044:: with SMTP id w4mr4930713wrp.281.1569358872583; 
 Tue, 24 Sep 2019 14:01:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r13sm4426603wrn.0.2019.09.24.14.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:01:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4A95C1FF92;
 Tue, 24 Sep 2019 22:01:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 05/33] target/alpha: Write to fpcr_flush_to_zero once
Date: Tue, 24 Sep 2019 22:00:38 +0100
Message-Id: <20190924210106.27117-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

Tidy the computation of the value; no functional change.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190921043256.4575-6-richard.henderson@linaro.org>
---
 target/alpha/helper.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 2f959c65efb..1b3479738b7 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -69,14 +69,13 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
     env->fpcr_exc_enable = ~t & FPCR_STATUS_MASK;
 
     env->fpcr_dyn_round = rm_map[(fpcr & FPCR_DYN_MASK) >> FPCR_DYN_SHIFT];
-
-    env->fpcr_flush_to_zero = (fpcr & FPCR_UNFD) && (fpcr & FPCR_UNDZ);
     env->fp_status.flush_inputs_to_zero = (fpcr & FPCR_DNZ) != 0;
+
+    t = (fpcr & FPCR_UNFD) && (fpcr & FPCR_UNDZ);
 #ifdef CONFIG_USER_ONLY
-    if (env->swcr & SWCR_MAP_UMZ) {
-        env->fpcr_flush_to_zero = 1;
-    }
+    t |= (env->swcr & SWCR_MAP_UMZ) != 0;
 #endif
+    env->fpcr_flush_to_zero = t;
 }
 
 uint64_t helper_load_fpcr(CPUAlphaState *env)
-- 
2.20.1



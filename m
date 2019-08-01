Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A160EC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69BFE206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqZOm/i/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BFE206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htFtj-0000g5-Hq
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 14:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59294)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1htFqS-0005uF-B6
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1htFqR-0002S1-6K
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39211)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1htFqP-0002P2-3T
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id x4so21465714wrt.6
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 11:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3FODED0uQTCIp9i/Uj2KBnwfZMeWNFHFWbEgO2/SvW0=;
 b=oqZOm/i/bOVCchgn/ikeoTHNUCQViOfo9VrsFdncb4TrJxV6DIYHvaJhIyhbp8M34E
 O3efUZoqCgALq8pUphOj+7qyTYBnlNY5C3k/3C1Lm7tD9Sx+CgNGoSXPKpjqwkHYQSdI
 9dukHmgtjFmgoIRLX5XnqDx0D9SuUTRvyhgEHsP7wbcsmmWS18JqH1XwEFo5ul3/aZIO
 Usrem6Nv59KpZlqjROXcezV4+z9GiH64PPmQwuAN+GfRIpy6a5NVfO+gYhSkTPFkeyuj
 Iu8LWanrDjhIPltgHGD556Et+UtcxssPq3rViehJwFI/MxN9aEJB0S7Ut4L0dGvXNo4F
 NdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3FODED0uQTCIp9i/Uj2KBnwfZMeWNFHFWbEgO2/SvW0=;
 b=Gxc2n8KCCKnN3kvUIRzgH8Ryc13RvE5rS+UbFLYhtouh90ZzEbHAV6Ys5CWZJllzoR
 6hibhuKL0mrc9Jx7VENJmtdRQQ0qdj5KV5Ny8jP/xjR5A79jW8O9Uf9f6+gr2kl9ztof
 QNL4O73y/5Pk3rkPtJZToYMVkTZdkdXcizrRSqezOfVXr+/DRMcPMzaKEjLhGXAOR77T
 PjBHghrN4n0lCaGhYrFc3G36dm6bQIOs+PHvZx6OKAxBKV7Du11+EZPJ5ilcyxL2otAY
 skaKS4MDubbbhTcCw4cXqqSQOvSaX76IMCQswjkv3IHfMQMfBRtCLlnrNEkimOsaS0Bt
 fvfQ==
X-Gm-Message-State: APjAAAUAiOZ2428IshkI114KaT2n6sqJVaAsjWwXEUIBPMqbMSO2NZV0
 FMC/6TAAfHzPgdrCTVqAF8w3hW5BOIjH5g==
X-Google-Smtp-Source: APXvYqyJZTdlkTvpfeIWyOpDX2kFhFewQNSxALyxkYQz+1bTsNWgedBOoUIP71HbUDihG9bI7QdapQ==
X-Received: by 2002:a05:6000:1189:: with SMTP id
 g9mr108059412wrx.51.1564684221350; 
 Thu, 01 Aug 2019 11:30:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e6sm71702104wrw.23.2019.08.01.11.30.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 11:30:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  1 Aug 2019 19:30:11 +0100
Message-Id: <20190801183012.17564-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190801183012.17564-1-peter.maydell@linaro.org>
References: <20190801183012.17564-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 6/7] target/sparc: Remove unused ldl_phys from
 dump_mmu()
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The dump_mmu() function does a ldl_phys() at the start, but
then never uses the value it loads at all. Remove the
unused code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/sparc/mmu_helper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index d90aabfa4d2..9a9f2cf9535 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -375,11 +375,9 @@ void dump_mmu(CPUSPARCState *env)
     CPUState *cs = env_cpu(env);
     target_ulong va, va1, va2;
     unsigned int n, m, o;
-    hwaddr pde_ptr, pa;
+    hwaddr pa;
     uint32_t pde;
 
-    pde_ptr = (env->mmuregs[1] << 4) + (env->mmuregs[2] << 2);
-    pde = ldl_phys(cs->as, pde_ptr);
     qemu_printf("Root ptr: " TARGET_FMT_plx ", ctx: %d\n",
                 (hwaddr)env->mmuregs[1] << 4, env->mmuregs[2]);
     for (n = 0, va = 0; n < 256; n++, va += 16 * 1024 * 1024) {
-- 
2.20.1



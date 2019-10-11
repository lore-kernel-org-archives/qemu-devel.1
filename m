Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F956ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69EE120673
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rgQUFRww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EE120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvRG-0007gy-5F
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 09:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJC-0005nI-KW
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJB-0003zN-He
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:18 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:43494)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIvJB-0003z4-ER
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:17 -0400
Received: by mail-yb1-xb41.google.com with SMTP id y204so3107061yby.10
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=loK2jdE9Lal6vbE+5e7UnQvjF9Y+wxx/GDkdqZVvRmE=;
 b=rgQUFRwwaWMEgX5YCcnaVMpy3V0hXYTFShehuEbdsWzUWaJmEQlOeXEtWM1y27D7mM
 CSUMBgNLjfDQL/gi5E+/8rgfOt3WmIoZs4N4b6au6hoxDwnvhu5uGFooADfmlXnyWJcY
 mS/yl1wyPd1OllYK2lTPH4jVTwQ7eLiX+tGFbZF9f2vwWZbGAt4YeBGp4eP9dUYua0hD
 Y8h4whClCNhCo6tZoN46BceCJO8hM5113fOqxFUWzV3euz1kHcrs/4VSquCvjYvak4sn
 eWsLuCvjZhzCsb+mENz7ZvQa77x/xbXpQ47GS9SPXMhnGk81Vv282w8LwV3JW1qIY8cN
 bvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=loK2jdE9Lal6vbE+5e7UnQvjF9Y+wxx/GDkdqZVvRmE=;
 b=rj47UZPIimds9VbLRkN943AVpdbQh4cUGGPKVj0QIL+aKtNmy/WnA627KbGIaDNgNQ
 KyabqpaH+0qsgzHyGKF7oal1mtF9Ly0+Dn0nxlzz8jbZRHZOo2qQs6PNmshtEicEUFoE
 uKxTcWH+Ye1wPs5O6lS0+DfUPTj54VpzL8ajHTfXgUygj6nI/PjNXrgXexbffAmJrrAe
 6IYAJwqj/C3eSf1X82xCge+5uy/HRcnSbeJNNfOAg/ZFRA5IGHotpMaYs3uacXMannhC
 dNnfeVXLZFa3QyZ7ZjPXqse6vLNDQyKg5Yf2LeFpxeQ84NU/N6c3Cqv9iOahixnEGz9j
 yfrQ==
X-Gm-Message-State: APjAAAU4ruCSuH1IkYp7yP0jKgU/vRUzNAhpB6bj08o8hB9eF63nDrB3
 drpGEGU9VpH136rwQxRiJ7DqVn5bAns=
X-Google-Smtp-Source: APXvYqwI0yhVcQ6ScFN0xzgNUIeDt4772vHwaBy6KG/3Osw7VS9Ug7xXAF0x0dAiMIaCYDml7wSAHg==
X-Received: by 2002:a25:cbce:: with SMTP id
 b197mr10026823ybg.355.1570801816528; 
 Fri, 11 Oct 2019 06:50:16 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id f68sm2534000ywb.96.2019.10.11.06.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 06:50:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 10/22] target/arm: Define arm_cpu_do_unaligned_access for
 CONFIG_USER_ONLY
Date: Fri, 11 Oct 2019 09:47:32 -0400
Message-Id: <20191011134744.2477-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011134744.2477-1-richard.henderson@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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

We will need this to raise unaligned exceptions from user mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tlb_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
index 5feb312941..29b92a1149 100644
--- a/target/arm/tlb_helper.c
+++ b/target/arm/tlb_helper.c
@@ -10,8 +10,6 @@
 #include "internals.h"
 #include "exec/exec-all.h"
 
-#if !defined(CONFIG_USER_ONLY)
-
 static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
                                             unsigned int target_el,
                                             bool same_el, bool ea,
@@ -122,6 +120,7 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
 }
 
+#ifndef CONFIG_USER_ONLY
 /*
  * arm_cpu_do_transaction_failed: handle a memory system error response
  * (eg "no device/memory present at address") by raising an external abort
-- 
2.17.1



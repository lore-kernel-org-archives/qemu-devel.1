Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF86C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB048222C4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sRiYXcNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB048222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifFqZ-0008Co-JM
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:13:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFf7-00011y-Fs
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFf6-0004PB-99
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:13 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifFf6-0004NB-1g
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:12 -0500
Received: by mail-pg1-x543.google.com with SMTP id r11so446641pgf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gVD0Cco3EmSuZ4UAvZCQGkeEhpYCeBDscZpWml9gxJs=;
 b=sRiYXcNa4wHsd674U2C3vEEdQ7JKEbwql6cN0BXjGBRisQZ51exLO1qFOBacjTI4gB
 DjDDkuQ9Fu6vfz/s3TuNnq6ejqtrNlYLLUuR7UE1Lr5uhEAI33RTloe3yTJYVg8surfV
 rjFIzciPn7RUCdMX8L/uw11YpddQU3gtvDBkvV8bYUTJcsdbRpuGo5g2uRZeaUQkOhTm
 IzD+VUe9E1OGypW+hGUYCJo/Hl7lvO1vnm24dgUY9KIVymplzEaQ4wuDBRWYhhqU9Yrp
 sRrAYz3CBQ+CqdetU4QTc9WsEps3co0u6Kg++xvZ6sTJk8zL+yU34SBWwqIWJsFoZXS1
 IStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gVD0Cco3EmSuZ4UAvZCQGkeEhpYCeBDscZpWml9gxJs=;
 b=q7bCcP1Xje2QINiHschJBH4bgko/84hkZp/Vqw3ZgR6M/eucbKQxtXE1tkj7wwTl3E
 aBavdjfyRyeF9icQG0gMWeLasxQfCAQvp5dcBDY0NjKfCD+VT3wa5RN/Wi2tAKZlb9rR
 qwp7hxxkdoDS0QlyZ+HAW5J3lkJwD5fVbiRSOo4GvbfP4Z4oudYDHhxwCU5LpV6tf8XW
 232KJCK6rNNq9fM0Ymf0dmEWvz2yMKKyoezzkAaT85GOXj0SVQaS3+VinNGAULjGGxFv
 fbu3VehvZvQ26TbM0xw6Q7O6xaok5WxY9+M4yvbnyKVNYryQD/JLgbooh36rtsw0r2TD
 TnWQ==
X-Gm-Message-State: APjAAAXwJMMQthk7POteWRk16x5JIz8g8tBhss30tTX8KpTsKvcWVZTL
 EyyYAxwipUHKcf6xVg4VaGi1mQrgt10=
X-Google-Smtp-Source: APXvYqy3pYh3PgyFyC0Jlozu1i4cbMzCMF0uw+aoikuliwFXbTBav0HsNJ1MufhRQeTpRGdwTQ6H2A==
X-Received: by 2002:a63:12:: with SMTP id 18mr8159398pga.294.1576123268895;
 Wed, 11 Dec 2019 20:01:08 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z130sm4666391pgz.6.2019.12.11.20.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 20:01:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/28] target/xtensa: Remove MMU_MODE{0,1,2,3}_SUFFIX
Date: Wed, 11 Dec 2019 20:00:33 -0800
Message-Id: <20191212040039.26546-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212040039.26546-1-richard.henderson@linaro.org>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/cpu.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index b363ffcf10..f5a7ea48bb 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -685,10 +685,6 @@ static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
 }
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _ring0
-#define MMU_MODE1_SUFFIX _ring1
-#define MMU_MODE2_SUFFIX _ring2
-#define MMU_MODE3_SUFFIX _ring3
 #define MMU_USER_IDX 3
 
 static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
-- 
2.20.1



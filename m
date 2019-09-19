Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074A8C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 23:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5FD4218AF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 23:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNgytJWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5FD4218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB601-0006s6-Up
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 19:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iB5s9-0006Jv-Vl
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 19:30:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iB5s8-0000l9-QQ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 19:30:01 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39637)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iB5s8-0000kg-Kg
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 19:30:00 -0400
Received: by mail-pg1-x544.google.com with SMTP id u17so2734856pgi.6
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 16:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rPvPWOfw9gxBJUIgR2g0hYWJxDjG7PfgkcfZjjTlu/I=;
 b=dNgytJWu3DysilndtjVQ/G7mr/w5sHBC6L9k/4mLvM9lNAp0Q87LNCJbKLDdu9YMlZ
 ECO8Ed6likncOc70MbwGpKuPiO4ZovS09XzfiWiKLanRkpmeGqijIVBZn9/7eLPbdTjI
 iDR6TdNJlS+1DEUfkYsU4ZEVYvWZYi95RI0lGs0Trrl8mDYwaoxt30NJIy/ukVmkTKi1
 m1Vqh4y1cNPVH8m3+v4K4BqiKYbAG4UfqNEhndHqCppX6vvRTpAr4yhnKAcOHL7U8/al
 6b+4y/8a39dHndeTfago1M+PKL/XzK1qkQ3oNsLDF+aQzdquXs+VV/RgXBCyejLDfxmh
 /tIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rPvPWOfw9gxBJUIgR2g0hYWJxDjG7PfgkcfZjjTlu/I=;
 b=SFgDi/CwvRl9i24uGviXEmTPC6AlAyG3fgR84fmfdJ0wSb/iQURoz02XqHuA4Zlnsr
 nmbG85POPzEzNEZk4ydkgLubLiFcmu3fvt2Jnc1m0NJnEf3feDBEGjpl3nKkgpFMLVHI
 dWtJVknzF/wvGZmZC/mujMHOT4ZbiN3dNVDw9z8i5REGqWxvGrVbf2OY5sLkrpU4fCcY
 Cg+ocgrGezuyluDnWcx4lRzKdH1PlT/jNyeIjCfQfXn8FutHYphNFsRWUV9+uCeQopad
 qFJfaW/d45jpv9AiCYv5SO0k30rK0R356uTjB7x40sdwSHmOq2gigoMF63wM8qnf5CFi
 9hdA==
X-Gm-Message-State: APjAAAWaOCXZyppp+QpZ6bjOlLqdBFbGJ6dzaItq0q/vQN5hKKLWvCmm
 e2SBDOIsHPPc/2RZLpAMAQzz6+ih8ok=
X-Google-Smtp-Source: APXvYqwwKD41Bg75H1C+OpoqU3JFXgkQSjsoBOWiN2ZsJr1bhJ335I4+0vWWo+GtQOOzY9vmrtEwEQ==
X-Received: by 2002:a63:1918:: with SMTP id z24mr11162633pgl.94.1568935799385; 
 Thu, 19 Sep 2019 16:29:59 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id h8sm103340pfo.64.2019.09.19.16.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 16:29:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] exec: Restrict TARGET_PAGE_BITS_VARY assert to
 CONFIG_DEBUG_TCG
Date: Thu, 19 Sep 2019 16:29:49 -0700
Message-Id: <20190919232952.6382-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919232952.6382-1-richard.henderson@linaro.org>
References: <20190919232952.6382-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: pbonzini@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reduces the size of a release build by about 10k.
Noticably, within the tlb miss helpers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index a53b761b48..b11ee1f711 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -215,7 +215,11 @@ typedef struct {
     int bits;
 } TargetPageBits;
 extern const TargetPageBits target_page;
-#define TARGET_PAGE_BITS (assert(target_page.decided), target_page.bits)
+# ifdef CONFIG_DEBUG_TCG
+#  define TARGET_PAGE_BITS (assert(target_page.decided), target_page.bits)
+# else
+#  define TARGET_PAGE_BITS target_page.bits
+# endif
 #else
 #define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
 #endif
-- 
2.17.1



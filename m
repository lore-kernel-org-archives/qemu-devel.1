Return-Path: <SRS0=thrq=XR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236A8C3A5A6
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 03:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E008020820
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 03:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mzf07D+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E008020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBszi-0003Ru-9a
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 23:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsxn-0001MM-Sg
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsxm-00086B-Rq
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:07 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41594)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBsxm-00085u-M6
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:06 -0400
Received: by mail-pg1-x543.google.com with SMTP id s1so4882533pgv.8
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 20:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=On6urL98+WZbXDi+CGo9wCKTkADz471arOAqlknvUss=;
 b=mzf07D+1+eSSdk4vlsWKfeYbpKYvnq/e2qA1sVpw82Lw64Axs3G5NNQxpHdGKeTiCs
 ubieAxUdl7rEn/Pln5AHUqHF0q/ME5UhqIHGGR90dtOY1po833be97r/S88aAT0lrAHV
 VeffzqjdKWnFwxAJwFhTAUjQbhJ49lzrt8BScNnN0CGD5f6iqHcW/1VV/i9yjVPsYanS
 pUxA5V18owr0dCw3lRWDP8htaWSiVzIgW2R+/kq+yZ6rOOGFVU9+zEvOhAAEbw2YPtKI
 /zPza+mUa2cJch6CVS9ald3ncJQlTF91JJsXZJPJTdYRYlzgEKD9L8vOSE2ASnbhv/YJ
 HH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=On6urL98+WZbXDi+CGo9wCKTkADz471arOAqlknvUss=;
 b=q5L8XL+Vv1B34n1qPw6mar+TACXxIFIIE3XQ8hO+5XJnDaSnKOK0olV13DRNhQ7SBu
 t43f6khXE3YU7Qi08yWbe4nq8n/M/wtw5MQyAW/oog/aPv87EqCqg/BYiGfwM8P9FHvK
 PsyCMrRC7I9NiRIQQkFynFAfD2Opi494gTVpqfggGwba3/ds8egPfQ6FFIT1BshBUbX7
 VVEZyzwCJbUe/H2Z1FiMllNmxwARDSCdTtCAD5kRDGLow7JsC/vYlp8AvC6mvJatDU8m
 D1jxIXQClhAcpsaYnpYuLm7YgA7ywRxVks7RL+v+9g/J11gNzQZIs69RZjFchjHxB8FO
 H2BA==
X-Gm-Message-State: APjAAAUjhYQMo3OOKdwD68RN6ksJG6FNishG2/xswa5qCXYrhR/+j8yN
 LuScxNaSW/tD1RV9J8djq551vJFmrDA=
X-Google-Smtp-Source: APXvYqwNHbldR76EXo5PcsHD1zO7WhEtxrI71hDHs9B6/dlaR8IMPwQC8NmOTOIYV7NI1brZT/FJJg==
X-Received: by 2002:a63:5549:: with SMTP id f9mr23270702pgm.346.1569124505431; 
 Sat, 21 Sep 2019 20:55:05 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z4sm6452921pjt.17.2019.09.21.20.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2019 20:55:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/20] exec: Restrict TARGET_PAGE_BITS_VARY assert to
 CONFIG_DEBUG_TCG
Date: Sat, 21 Sep 2019 20:54:42 -0700
Message-Id: <20190922035458.14879-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190922035458.14879-1-richard.henderson@linaro.org>
References: <20190922035458.14879-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reduces the size of a release build by about 10k.
Noticably, within the tlb miss helpers.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
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



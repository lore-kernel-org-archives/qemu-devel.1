Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0386FC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE1920767
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7LhMucO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE1920767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmMV-0008Rx-V2
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmJw-0003Od-Ih
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:12 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034]:54427)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmJs-0005tk-US
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:12 -0400
Received: by mail-pj1-x1034.google.com with SMTP id mm21so21775pjb.4
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4SYcyC7WRrB7DQoqG8Jlb5pwufeHvMZ+/v7u+myx2PU=;
 b=d7LhMucORIONCqg2i3gR/PrClkr4YL03oYPiyxNr/RkK2dgmxxE5WzAAGw9tI7g8uw
 VkIueu2ZfbdZVl7+FVcWh4VDqmAW5Xs2xUYy34E7n3pDGw4fN4K6yB88C6kLUHf16mt4
 csGmS+B7F2S4GhH3F7Eh762+Jc6s7z3PfZMlVTFxtW+ZrWXIyZ0RTABM3ehB7jhlqvht
 q/O3qJovqQx8IUHc7+PQ/lGz9T10sq7T7ZGxVZsYT1gNOhKOHjJxo5MKSl0bIERUuafD
 j3LjlPEj6CPxQ5giBYlkTeWbV0n4NkJt4YqIRE118qgSks9jMWzdvOWt4dqR69dLZAyw
 nTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4SYcyC7WRrB7DQoqG8Jlb5pwufeHvMZ+/v7u+myx2PU=;
 b=pYPLuQCN2eEtEvTHCBOIBofoX2NLItZQ6VHEhGzemCkZRzTWGL+HY21AP3TD08G7nC
 HeqpmAetWFlsZHQ6aPsVSiKLpD5J4qevnkvj4fv33Nvi2hBdcIsYBIWWq4XjSf1inuZ7
 TZo6x16tRaky1CFXfOAnRqvplufbAWmPnbOGhLQkKsQlbF2dPkBTHp2Cs3GzggaGv4RX
 VzSK8HkckpvUrCZOfhKTc5LQxFABn1TiOsWqnJwuaIsKl89+PeU8FLlsa/mucJcG6sNE
 d1mneFvKJR2c1JPeiQgsb5mk34zYrkIdmW6ZUXkSq1wDWVHyZObtlQbuu/4dOl5jvAOh
 1fbg==
X-Gm-Message-State: AOAM5301i3APVgHE1N09zEpYJjSw44IVnhmsls00Z+yAnup+alDMfN+A
 FqJ0+P/ifZsAjkvYCbT4luHKhknrGVUH8A==
X-Google-Smtp-Source: ABdhPJzApW96pj/9JW00R2DM/ZzsuuHyUo76E2/pS4u+QZTw/0DuK3fJ6cxK9QblLD3p8DN3roFRFQ==
X-Received: by 2002:a17:902:6902:: with SMTP id j2mr1554291plk.2.1598889967255; 
 Mon, 31 Aug 2020 09:06:07 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/76] tests/tcg: Do not require FE_TOWARDZERO
Date: Mon, 31 Aug 2020 09:04:47 -0700
Message-Id: <20200831160601.833692-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is optional in ISO C, and not all cpus provide it.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/float_convs.c | 2 ++
 tests/tcg/multiarch/float_madds.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tests/tcg/multiarch/float_convs.c b/tests/tcg/multiarch/float_convs.c
index 47e24b8b16..e9be75c2d5 100644
--- a/tests/tcg/multiarch/float_convs.c
+++ b/tests/tcg/multiarch/float_convs.c
@@ -30,7 +30,9 @@ float_mapping round_flags[] = {
 #ifdef FE_DOWNWARD
     { FE_DOWNWARD, "downwards" },
 #endif
+#ifdef FE_TOWARDZERO
     { FE_TOWARDZERO, "to zero" }
+#endif
 };
 
 static void print_input(float input)
diff --git a/tests/tcg/multiarch/float_madds.c b/tests/tcg/multiarch/float_madds.c
index eceb4ae38b..e422608ccd 100644
--- a/tests/tcg/multiarch/float_madds.c
+++ b/tests/tcg/multiarch/float_madds.c
@@ -29,7 +29,9 @@ float_mapping round_flags[] = {
 #ifdef FE_DOWNWARD
     { FE_DOWNWARD, "downwards" },
 #endif
+#ifdef FE_TOWARDZERO
     { FE_TOWARDZERO, "to zero" }
+#endif
 };
 
 
-- 
2.25.1



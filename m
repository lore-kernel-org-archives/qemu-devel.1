Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6345BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F197207ED
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m6TbyN5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F197207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaipx-0003YF-9t
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jaipB-0002Ev-5t
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:41:09 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:38609)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jaipA-0005sT-Be
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:41:08 -0400
Received: by mail-pj1-x1041.google.com with SMTP id t40so72605pjb.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YR8AXhnmaa7YBf0c5Txz/pTDpNw3zZphMDFYyOMiCJ8=;
 b=m6TbyN5laTTBvFTy6dbGCymQ8XGAHSt9MWDS9wOC1JRSL0jOjRlcPbDDX0LYFJQ54/
 zuKCGzuYx5MDQ7UfFtnXtJCV2wq3Jakp0TGdhwWk5OTj6J8nr/07jBcjmtJ+ZzZH0uLN
 63Q9xN98GjPEOntQYXBS+u/1vIfZ38F7mRp8NeBNXa87UGzZmw8KPnvjQy3hxOLhQsCK
 +e0cOd/3o98BsSuFdIZZ9hST7kKzFu12E36RrP3RCcQtbVRXVpjOUEFlNxGzyHKg2Gxw
 3Z+U39QBEaWotqlkjt+aUlfnSxV6f9mpPROfVRTR0JJ0RnYFyEOp0hIyQI1LfDbyFClD
 euOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YR8AXhnmaa7YBf0c5Txz/pTDpNw3zZphMDFYyOMiCJ8=;
 b=N9oTc6RyYHawOlKNuAOJxwjPHtxqmR8qm9RMMpF23TWStFOWYU0J1bMOdkRUCWWrPr
 DUwD7jllyHAmS2oCCZ40ulG8qlvhzJ84rsaCb/9Ce1LIXnAliLLfoDi5BdwuM80Ek0Pg
 7eDcQXp24VrAP+7aBD9kNNgg9BxU+mcv8iJxDGPeAjUJ8eEI1Nda5N8V8YIQQS2HQdrq
 v+bl50iTm1QrbqEVLDQ/im4CXX3R76jfIAI0XI8amrvtGOByDVeKVwybkUVUjDMqB4/W
 dYgn6pxokLZtYgtdjb7tKNlYZjf3WXSFp4nKdE5jEn4DT0CmBMZHqaoHOd1+YAvyCdzS
 juYQ==
X-Gm-Message-State: AOAM532jpH3jqGoG4tQ+xUQl8AMxiuQ/0uB3UC5dNjtWtATPXrEqA4gY
 uX9n87j/bum4/IfDJZRvhliG+yvrH3A=
X-Google-Smtp-Source: ABdhPJyC2WcR8cpD4mCsJcmm9co/3LKICqp5LpiByFkGYddzLBX2jgUxOv3PeeUsp7eJSj8muOkjXg==
X-Received: by 2002:a17:90a:589:: with SMTP id i9mr274327pji.156.1589820066767; 
 Mon, 18 May 2020 09:41:06 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x132sm5790610pfd.214.2020.05.18.09.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 09:41:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 8/8] target/arm: Use a non-overlapping group for misc control
Date: Mon, 18 May 2020 09:40:52 -0700
Message-Id: <20200518164052.18689-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518164052.18689-1-richard.henderson@linaro.org>
References: <20200518164052.18689-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This sub-group in the t32 deocode are mutually exclusive.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/t32.decode | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index c63082fc9c..c21a988f97 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -312,13 +312,13 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
                  &cps
 
     # Miscellaneous control
-    {
+    [
       CLREX      1111 0011 1011 1111 1000 1111 0010 1111
       DSB        1111 0011 1011 1111 1000 1111 0100 ----
       DMB        1111 0011 1011 1111 1000 1111 0101 ----
       ISB        1111 0011 1011 1111 1000 1111 0110 ----
       SB         1111 0011 1011 1111 1000 1111 0111 0000
-    }
+    ]
 
     # Note that the v7m insn overlaps both the normal and banked insn.
     {
-- 
2.20.1



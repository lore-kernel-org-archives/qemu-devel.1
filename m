Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10285CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:45:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC8D2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t+CH6D1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC8D2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNy1s-0006V4-AZ
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwP-0006gG-0m
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwK-0006dn-Tb
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:34 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:38737)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNxwK-0006de-QC
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:32 -0400
Received: by mail-qk1-x743.google.com with SMTP id p4so1403638qkf.5
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 04:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=m328r1FYSeCQVBFpcE1l4M4AliU0R8Zo7qDrsYY6RNg=;
 b=t+CH6D1q+c6ybGFyc7uqbCqi3hmT+rWYMs3PBalQ17bvjwt2XR5A0nuC/zb1+wdhXo
 d2zy3tbXaUWICq5RcIm1WN0h8Pfj2b8d6Nk4ATlFLTVACTuoYB58p52TKz1vPg1HRLoo
 mf5b/HO+FjffDsUrjfCXrCv/QoO5wPdcTnn8bED5rRkkD8LwSqUeD+hwaA9D1YS7dCyj
 jcxjzCXZs6NqEsUcVIxujx+U05gUueav1vPE+HAB2my8RmkEdHmrbmFFTN3DR8C/taOp
 l5IzK24lzXGVwnk0Cfzxz2s3NAUsEad+9A9ztP41/xYELs5MAkRfwBmRZCfmkA3VzZ+X
 yWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=m328r1FYSeCQVBFpcE1l4M4AliU0R8Zo7qDrsYY6RNg=;
 b=nXWslMshUHa/Uq0KTALGwb3VmHTdE8HS9TsgesCH01jlDsbp9XfefrWMDCVe1qvQyY
 Zzzu3c3M6vzqaVjlYU6IJ24IrPxs7roVJRG38YV54WHrVj21CjQzaDKAG1Dd11E9vM0d
 hHJAL5w/CiOMV3+DTnXTQsaQVj3fcnJ+xQGEC5NY3I+l9m/WEyP2ThqWECBkwrAr+LsA
 +Bv4YRj20tDXvLyzBpYCwa3H2cMjtohZs/sAp50Q/QIYxz6rMkrSfqyDhsrH7gLtEMJ3
 jghqb4RIjbpqzeyC7MJHUYlk8NCqzC8+TpKc4U/psKcyqor9+O8YJQjHfwlx+2KhPHT9
 AzFA==
X-Gm-Message-State: APjAAAWUxHb8dj8Qkb4s8qAyUp+W4oO4/kRCNabEZCtK61xLSzGgyj07
 D6Al4BNAjzG0CT1X14/IYzxMEIaSKB8=
X-Google-Smtp-Source: APXvYqyWlgK3HEosAj+fc/Dj08EFwl8zjoxnnDyu5SEKJ6q/W+DMJo2QBFuFy6LnUFOZgQvXLatVgg==
X-Received: by 2002:a37:6442:: with SMTP id y63mr2331654qkb.31.1572003571500; 
 Fri, 25 Oct 2019 04:39:31 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id x38sm1473335qtc.64.2019.10.25.04.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 04:39:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/12] linux-user/sparc64: Fix target_signal_frame
Date: Fri, 25 Oct 2019 07:39:17 -0400
Message-Id: <20191025113921.9412-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025113921.9412-1-richard.henderson@linaro.org>
References: <20191025113921.9412-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instructions are always 4 bytes; use uint32_t not abi_ulong.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index efb0df7e2b..ecfdf937e4 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -87,7 +87,7 @@ struct target_signal_frame {
     struct sparc_stackf ss;
     __siginfo_t         info;
     abi_ulong           fpu_save;
-    abi_ulong           insns[2] __attribute__ ((aligned (8)));
+    uint32_t            insns[2] __attribute__ ((aligned (8)));
     abi_ulong           extramask[TARGET_NSIG_WORDS - 1];
     abi_ulong           extra_size; /* Should be 0 */
     qemu_siginfo_fpu_t fpu_state;
@@ -98,7 +98,7 @@ struct target_rt_signal_frame {
     abi_ulong           regs[20];
     sigset_t            mask;
     abi_ulong           fpu_save;
-    unsigned int        insns[2];
+    uint32_t            insns[2];
     stack_t             stack;
     unsigned int        extra_size; /* Should be 0 */
     qemu_siginfo_fpu_t  fpu_state;
-- 
2.17.1



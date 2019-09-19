Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFFAC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 23:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B79921907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 23:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a46hdUq/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B79921907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB5yV-0004nr-8m
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 19:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iB5sB-0006L3-DN
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 19:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iB5sA-0000lq-4X
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 19:30:03 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42686)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iB5s9-0000lQ-Tp
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 19:30:02 -0400
Received: by mail-pg1-x544.google.com with SMTP id z12so2722886pgp.9
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 16:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3xo3uadk4TAHtPwy0OEr5aDTmDZwQ+SU4GyeG6+uHcw=;
 b=a46hdUq/Uplx3ALd41T3Y825t5C6Ac10mta7RtSqNUsbENNIPYV48/5HZE9t4RhCHt
 LvPkx4U3VY+Cbgg0/igei+MbVxlOnXPO5d2lpLASe0AYRqLy9VSoO7it8Pl7YIiuoncX
 bilSp+Z753KWPwh3p0tGBicHbGZQ68m/APNXzbxB/wXlFvbcQQYpJpfjTCuS2XoZv9DB
 MCAJCFaAog/R0G8ge4Qf1z6p8pPK/uswNDCIs0T9p3QVfag2l9Y28MmlXGnwa/2Xm/S7
 XShD9lxQybseO7V3Ru9vaFbrXPQSYYssK6vtyhqbq50O+HV3EzqWhM5OgkKR9d1weoyB
 e5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3xo3uadk4TAHtPwy0OEr5aDTmDZwQ+SU4GyeG6+uHcw=;
 b=p8TLCnPwBH260VjDXKdcBiCN6Z+KoXALsu0OkY0fuwKONdz5GDrALJnCCdjRsLB2jW
 WxG1jG1jicHBZiHVf59K9g2JeScOYuqhkzYSCKSkcXSDzqX788Jt0Ib2nVCiZIqr5hlF
 aXYWdIoFXCrCtgsdk9gvk11z378wVF8MNV5aZ1nQRHHHBD/OVzkfMMgJm56K+B0/PY6o
 ZvScqGKlmlbkbNDnuU2mcdOl6X5qjwtfzFNW8ydoT6Qlq/4vAEAT/pdCfMisLYTGjtdW
 4ReKO9YAYWBY9jlg6rKCHF6wTQ3GeVabe/aIpPKQVGIlV3V9oLZG9bYCBBIz+TOmzd+J
 7B+g==
X-Gm-Message-State: APjAAAUGWCdKa5jYiyaHfV1cmut8SM8R/BL4vlMDPIuDmNsVrC63jQTj
 iPUB1knq20vcLcOBQE9MpvuphlRXb+M=
X-Google-Smtp-Source: APXvYqyse6//CGLyn6zPRTDp6ATheHlIB2fOeLsOzYV+PUVjXpsOu8fOQbThdi/BgXuXJ5HmIfzWEQ==
X-Received: by 2002:a63:225f:: with SMTP id t31mr11575495pgm.50.1568935800607; 
 Thu, 19 Sep 2019 16:30:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id h8sm103340pfo.64.2019.09.19.16.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 16:30:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] exec: Promote TARGET_PAGE_MASK to target_long
Date: Thu, 19 Sep 2019 16:29:50 -0700
Message-Id: <20190919232952.6382-6-richard.henderson@linaro.org>
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

There are some uint64_t uses that expect TARGET_PAGE_MASK to
extend for a 32-bit, so this must continue to be a signed type.
Define based on TARGET_PAGE_BITS not TARGET_PAGE_SIZE; this
will make a following patch more clear.

This should not have a functional effect so far.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index b11ee1f711..34d36cebca 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -225,7 +225,7 @@ extern const TargetPageBits target_page;
 #endif
 
 #define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
-#define TARGET_PAGE_MASK ~(TARGET_PAGE_SIZE - 1)
+#define TARGET_PAGE_MASK ((target_long)-1 << TARGET_PAGE_BITS)
 #define TARGET_PAGE_ALIGN(addr) (((addr) + TARGET_PAGE_SIZE - 1) & TARGET_PAGE_MASK)
 
 /* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
-- 
2.17.1



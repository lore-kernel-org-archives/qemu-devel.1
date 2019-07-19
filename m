Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CA8C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:06:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E45C2184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VGr5Jh50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E45C2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoa4s-000525-P0
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 17:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55272)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3d-0008Nz-Nx
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3b-0005bZ-Lz
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:48 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hoa3a-00057i-3H
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:46 -0400
Received: by mail-pg1-x542.google.com with SMTP id i70so4229534pgd.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 14:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=q16Z6V/byGstcVAnFkbLcB6CkWJAuthTp/eBqCA8iHY=;
 b=VGr5Jh50vwbOQDkr3N0O4cPMhzm/QTZ4jFE870g+zk3A+oEfZ2q4Y+7XdOM5Ypn2oy
 vyqJbk9wOPswHQSsWDG1c5x3uLoWzwJzCwf7e32FKINj6qhN7g31sy3LpbA3vqRa2D9x
 fYXEhTlSNmdkvKi3QRdB+5vygWE7NkqWxac/OrxR3hBE0qKQP0+YCrgYC3pLcEkV9zHj
 CqUgpolLc/J3Jb5koy1oKf+aiLTNm4IvlbQe8+tFLIXJe6g0ftiGgLXopVgDGuF2UVsg
 TcJWwQMCmzrwpD/p8NB7eE7pGfAvOWrXYBwzY6fl13DAcWIBhnPbAA0N/UE99FRyzFti
 tk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=q16Z6V/byGstcVAnFkbLcB6CkWJAuthTp/eBqCA8iHY=;
 b=gVXaug8jJmUZ/QfWgM31HzZHaobrFTcufZTUGMdMAo6ge42eZYBiEm5xDzdZzyMPuM
 VlYOH28ESV5WVbrj0hJKVXmHR9W7x4LvORil9BwfN4kPFQ+2brvMhQSyrur+d71rNw+V
 2J/CFw6Ndl6rcyOptHI4+wTzQSqEIu2VJZY1o8TEogplXw089fnJ7k7qOIarw57yNzLJ
 9rZvQfqXzzb5oa/9TZ0zo/dFvT36KOhtsIm17FdoPKFgJRbfo1My46Wg9dWp5ihlZUHG
 sArIje5vmUyXXWI0OjxsBDodPPKrkVS2/NIaB4S7EdbJ+i/P5ttTZCPTsiZ2mEs6VjJ8
 S3PQ==
X-Gm-Message-State: APjAAAXxF/yPlAsHvXL00S1d9Fl00o14leGyDBSMWcrldheBvsX2bmjv
 bqPcqplTFrI+NuOu+THrFMLzkTagrYc=
X-Google-Smtp-Source: APXvYqyyUTk3wVZUBhHN6M24LlI8RSCU6LbaA0NSq1JDhmBht0AQkHffLnIK4/6Pi9V2iD9desWw3g==
X-Received: by 2002:a65:60cd:: with SMTP id r13mr29218513pgv.315.1563570216818; 
 Fri, 19 Jul 2019 14:03:36 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id i6sm32724751pgi.40.2019.07.19.14.03.35
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 14:03:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 14:03:09 -0700
Message-Id: <20190719210326.15466-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719210326.15466-1-richard.henderson@linaro.org>
References: <20190719210326.15466-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH for-4.2 07/24] target/arm: Enable HCR_E2H for
 VHE
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 7 -------
 target/arm/helper.c | 6 +++++-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e6a76d14c6..e37008a4f7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1366,13 +1366,6 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define HCR_ATA       (1ULL << 56)
 #define HCR_DCT       (1ULL << 57)
 
-/*
- * When we actually implement ARMv8.1-VHE we should add HCR_E2H to
- * HCR_MASK and then clear it again if the feature bit is not set in
- * hcr_write().
- */
-#define HCR_MASK      ((1ULL << 34) - 1)
-
 #define SCR_NS                (1U << 0)
 #define SCR_IRQ               (1U << 1)
 #define SCR_FIQ               (1U << 2)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3a9f35bf4b..0a55096770 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4623,7 +4623,8 @@ static const ARMCPRegInfo el3_no_el2_v8_cp_reginfo[] = {
 static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     ARMCPU *cpu = env_archcpu(env);
-    uint64_t valid_mask = HCR_MASK;
+    /* Begin with bits defined in base ARMv8.0.  */
+    uint64_t valid_mask = MAKE_64BIT_MASK(0, 34);
 
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         valid_mask &= ~HCR_HCD;
@@ -4637,6 +4638,9 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
          */
         valid_mask &= ~HCR_TSC;
     }
+    if (cpu_isar_feature(aa64_vh, cpu)) {
+        valid_mask |= HCR_E2H;
+    }
     if (cpu_isar_feature(aa64_lor, cpu)) {
         valid_mask |= HCR_TLOR;
     }
-- 
2.17.1



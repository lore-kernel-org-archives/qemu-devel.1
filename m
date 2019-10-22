Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956ECCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F24720700
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OEgkaEBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F24720700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuRX-0007Qu-VE
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGr-0002kn-QE
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGq-0001J6-N1
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:21 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:46974)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuGq-0001Ie-H1
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:20 -0400
Received: by mail-wr1-x432.google.com with SMTP id n15so7300120wrw.13
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=47L8tC+k0dqNep0IiM8o7WB4AEO/g2+8C4jrYkr9oDs=;
 b=OEgkaEBvo0adjaDJKsU7r+f1ZktlbQLZuofPeddEQ8wF2cUMyeHf0oJcWcq0knPApY
 EOb2m2b7zS/fw+wW3XeanU2aGDOejVkpuBfwlXe+pr5dUkj1olJ7SIckemVVLGpu9NnU
 Lr+MyP2uKWsvrWUA/UIzk5cLd31ClBMBcQ7GRnMl3hXwEpVlua2QXYcb0bLfk60ZFIi2
 FTgKc/zlYeOiMm1B8thsioKyIu16BiQeI8/7S6Wmon7y5I/j3X/JRSXJ7w685C2D9AxW
 NmyUIsO9HNjc1778+amjUE4IYzxB23n9pA5KVnH+6GSIG83o6yGGYvt2MGkfCVnm8p0Q
 kI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=47L8tC+k0dqNep0IiM8o7WB4AEO/g2+8C4jrYkr9oDs=;
 b=QhoYGIEhORlZ0LfuXcksH1MbanFkqf8pWAhQwde75hWyeps8/bSaY7Cohk8DmenGJU
 GWF4a/sqcrFn4ABSRclxdHyJMADGZqf3pHRBzroikavpmXf+n3//+UCXRToaEzog+J/l
 p5u8AV8Xj6/ZrTbTcw/dtIFOZqNfSsCSB83Sph6DTWEWkMhU/CkD49LUBnWkqhz2z21h
 y1xZvLpWq2baebLRfAKqWRDb9QwNgfh7bkltXoIoeBAYCbHCmHvNHHFJWDx9rqMtizPD
 E58qHj2KeTzvKa7YadrQgtEThgJ0a63ODxZfFxKxVhKqdyCifh/EZlEmq0ekQcqlAmSl
 uDhA==
X-Gm-Message-State: APjAAAXtrgd8S3klAHYihCshBzBUzyhT3XaVzWDuDFw/NrwACRAxQA3w
 6ZXrSatEg/bmWnq/jRH/LCrk6u4elJo=
X-Google-Smtp-Source: APXvYqwTELJQ4O1qcYFniYpz4iOSddzNZqsyTotypgO0DLnmeubnCPILSjcUOe2xbUn2r7Kq80fPLw==
X-Received: by 2002:adf:fdd0:: with SMTP id i16mr3742789wrs.227.1571751139068; 
 Tue, 22 Oct 2019 06:32:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.32.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:32:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/41] target/arm: Split out rebuild_hflags_a32
Date: Tue, 22 Oct 2019 14:31:10 +0100
Message-Id: <20191022133134.14487-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Currently a trivial wrapper for rebuild_hflags_common_32.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191018174431.1784-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 296a4b2232c..d1cd54cc931 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11106,6 +11106,12 @@ static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
+static uint32_t rebuild_hflags_a32(CPUARMState *env, int fp_el,
+                                   ARMMMUIdx mmu_idx)
+{
+    return rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+}
+
 static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
@@ -11218,7 +11224,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                 flags = FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
             }
         } else {
-            flags = rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+            flags = rebuild_hflags_a32(env, fp_el, mmu_idx);
         }
 
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
-- 
2.20.1



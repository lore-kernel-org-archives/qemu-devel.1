Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAD0C54FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34EF120722
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RR3hgNfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EF120722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGR5B-00063T-CY
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 13:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGR3h-0004OK-Ku
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGR3g-0003hV-Ih
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:40:17 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39028)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGR3g-0003fe-5u
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:40:16 -0400
Received: by mail-wm1-x344.google.com with SMTP id a9so436401wmj.4
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=P717LorGeXb892L2rPZftLo69BBrecynggE4xn2hmr0=;
 b=RR3hgNfbENzWCdCJP17GedyzqJeSMjgzBerbhmsLVmpiNXXbm62VCqcogTQdbHt0/m
 l3+J5ZziKVyAWOb25wOOf0s9UTRsDwGT6lNjeef4bZWNWO/sVx0Kf/xkVA9Xm/2js3az
 lyu6ofMag9bqCdLMf214FHZ333eMJjvIQDLX/MEnTlt6ze0caVaYAL234fLOgsbglvyf
 6tAhY+qraEemNKpBwg8BWQUDRVakng5bNBPQnnnw+Coa+Lp+v77uHMBB2e6lcpdCtouY
 DWr9hCR15FfV91LygBcd2aEUTSImfwnd+OSyvtUfYRiHMPKZtxhkndwOZ3V1VTl5+f7q
 qwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P717LorGeXb892L2rPZftLo69BBrecynggE4xn2hmr0=;
 b=UZmZXECaw1dMAXRW+L6Url+6Y460+4Awa/iyi8Z8cP6hcBaaTfXzn8bdeBUKMZOC72
 2x++vnQ4DNa/1t2XOueZhr0RXVW/UigPDQGLSEbgjrS43mImsqHsfAMAMkIP39FriQKJ
 8Y3lZBHyPSk0OpiR82t99c9JtH8KBUbqDsxQ0hTTN2C7QsEAoFpWQcv2fxWWwCz16/ZQ
 2n11o7jT0XtjXa+YNZHd1tF1IMoy3nzaY8x7NHJQEdxE+s++ktHrAdxO8Y4IWvwA9Qla
 rbf5269HsPXPu6txi8KzEP7iwdbV+wPiINrJYefBfEevfzI37yqr51fbj0Na4xIrh8sl
 BW+w==
X-Gm-Message-State: ANhLgQ3UDVrvfysYdGzjh4exZchRHdMwCmkzpvZoPGrYbdDMSsMHN5WB
 qf8dwHlauDEJDLa3A/1EwyWsATj5JnOe+Q==
X-Google-Smtp-Source: ADFU+vuS1DVLUB7gaYFecguqL6bB913zJn/KrOk9izmSV4Ljjbzn7E8FsoyvzXYGTBR//v1RcVzs1A==
X-Received: by 2002:a1c:4c1a:: with SMTP id z26mr422398wmf.11.1584985213048;
 Mon, 23 Mar 2020 10:40:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o9sm25145282wrw.20.2020.03.23.10.40.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 10:40:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] target/arm: Rearrange disabled check for watchpoints
Date: Mon, 23 Mar 2020 17:40:04 +0000
Message-Id: <20200323174006.8468-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323174006.8468-1-peter.maydell@linaro.org>
References: <20200323174006.8468-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

Coverity rightly notes that ctz32(bas) on 0 will return 32,
which makes the len calculation a BAD_SHIFT.

A value of 0 in DBGWCR<n>_EL1.BAS is reserved.  Simply move
the existing check we have for this case.

Reported-by: Coverity (CID 1421964)
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200320160622.8040-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d2ec2c53510..b7b6887241d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6340,17 +6340,18 @@ void hw_watchpoint_update(ARMCPU *cpu, int n)
         int bas = extract64(wcr, 5, 8);
         int basstart;
 
-        if (bas == 0) {
-            /* This must act as if the watchpoint is disabled */
-            return;
-        }
-
         if (extract64(wvr, 2, 1)) {
             /* Deprecated case of an only 4-aligned address. BAS[7:4] are
              * ignored, and BAS[3:0] define which bytes to watch.
              */
             bas &= 0xf;
         }
+
+        if (bas == 0) {
+            /* This must act as if the watchpoint is disabled */
+            return;
+        }
+
         /* The BAS bits are supposed to be programmed to indicate a contiguous
          * range of bytes. Otherwise it is CONSTRAINED UNPREDICTABLE whether
          * we fire for each byte in the word/doubleword addressed by the WVR.
-- 
2.20.1



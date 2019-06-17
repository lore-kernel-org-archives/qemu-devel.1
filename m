Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FD1C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F332084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRcDRMwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F332084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48284 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hctAw-0005mL-Lu
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46907)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsib-0003pr-PC
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsia-0008IQ-4u
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:45 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiY-0008Ek-JA
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:43 -0400
Received: by mail-wr1-x441.google.com with SMTP id r16so10201418wrl.11
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LDkGhdEmd/3w+lVgH7xwzSp5iBC3yN2clKihNtTszW0=;
 b=FRcDRMwF4YTGwFkpL6fBQDPj2lDi4dq+p43fTm52zvKADTls/2Nw1Y2HusfYQ8RABm
 s+dj+m1kG0CkwzdEE0gE53nK+7cT6B++Io02JuKxv/YCORQupk9M0WNSzwKQS8AX/8Im
 iOL3Rs38fWC9LGVW8oi1GMuLGxJ6sYV846BPwzlI/f4EDeXWJi3HsOWxBT76exxcn7OG
 Xpo1tQUMhMS4lgetmHTeSz8TgEQt5N8HKMmcXe0grrVPA4fYiZ6fJQGIh6D0oIfPYN3f
 SFvxnir9syocdUI25art3EsdmeD0nU1mQr1m700luMJSSwP2wXszI0vRXeQhMlp5mbdE
 5XaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LDkGhdEmd/3w+lVgH7xwzSp5iBC3yN2clKihNtTszW0=;
 b=TgnZLckPk3Hv8rosSokvreNjNOtZgVxUh7Bs8ABaS7kMSbVHZ/4t49uSIbqiz59AQR
 zRfzHoE+hI9GvFiXZriUjNEh+eypmaep9DNLxWp1vEnDCEYGuo2a/UtSOO0mAb4DghGn
 r4iptauvEC2w/eAv6vh3HBm9C3eSzXOXajSDPoTr/m/S3lJpHTdqSUnFvTamDiQa+Z5e
 JbfIo/Qr+HaHSjw0Q1yzUyHQ8+ZKTS4/OMAjJn6dkDBIs2bM2VdD9wd1AsRAVXJMfq2o
 4PjeopGNfxCmiWqQJHZp19HAqaL8F4NI8UFm+x7zXC+d4pZMZWnER71N50+rHFZ39AW+
 c/jg==
X-Gm-Message-State: APjAAAUih12JaQ4TeTreXyd+ho0/0/1TRvdYBRMvq0MqBlq0v0isRSxA
 rVVDsBBbIHoQFUedp4aJsgO5Dd778Q/xUw==
X-Google-Smtp-Source: APXvYqy2r6f9+9CpmG3mr9Ve1JiCvTWAozClGIHHVNY0edGXC7FX2fgb/fal2f6dXadbcOdTAh+ADg==
X-Received: by 2002:adf:e40f:: with SMTP id g15mr285112wrm.174.1560782078038; 
 Mon, 17 Jun 2019 07:34:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:34:10 +0100
Message-Id: <20190617143412.5734-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
References: <20190617143412.5734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL 22/24] target/arm: Remove unused cpu_F0s, cpu_F0d,
 cpu_F1s, cpu_F1d
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

Remove the now unused TCG globals cpu_F0s, cpu_F0d, cpu_F1s, cpu_F1d.

cpu_M0 is still used by the iwmmxt code, and cpu_V0 and
cpu_V1 are used by both iwmmxt and Neon.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190613163917.28589-13-peter.maydell@linaro.org
---
 target/arm/translate.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8f124a953b6..4750b9fa1bb 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -67,10 +67,6 @@ TCGv_i32 cpu_CF, cpu_NF, cpu_VF, cpu_ZF;
 TCGv_i64 cpu_exclusive_addr;
 TCGv_i64 cpu_exclusive_val;
 
-/* FIXME:  These should be removed.  */
-static TCGv_i32 cpu_F0s, cpu_F1s;
-static TCGv_i64 cpu_F0d, cpu_F1d;
-
 #include "exec/gen-icount.h"
 
 static const char * const regnames[] =
@@ -11911,12 +11907,8 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         dc->base.max_insns = MIN(dc->base.max_insns, bound);
     }
 
-    cpu_F0s = tcg_temp_new_i32();
-    cpu_F1s = tcg_temp_new_i32();
-    cpu_F0d = tcg_temp_new_i64();
-    cpu_F1d = tcg_temp_new_i64();
-    cpu_V0 = cpu_F0d;
-    cpu_V1 = cpu_F1d;
+    cpu_V0 = tcg_temp_new_i64();
+    cpu_V1 = tcg_temp_new_i64();
     /* FIXME: cpu_M0 can probably be the same as cpu_V0.  */
     cpu_M0 = tcg_temp_new_i64();
 }
-- 
2.20.1



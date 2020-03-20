Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9D9C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E7020739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mauQ6A8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E7020739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFKBi-00041n-0U
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 12:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jFKAG-0001wi-6D
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jFKAF-0001aI-5d
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:06:28 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:47080)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jFKAE-0001Zg-Vr
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:06:27 -0400
Received: by mail-pl1-x642.google.com with SMTP id r3so2659868pls.13
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 09:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z+SDME4E2sCY/GphbA3qjA/hZrqxGNEA6/MPHDiVJqY=;
 b=mauQ6A8a9rBMA3rXL0UlYYMFBZUNKfZWi/KhS+T4kl1u7hBr11rrtv7ujJbx5ujx3U
 zClxvn/SdO4ludJjbBdr+XeQ7ebWa22HvZkdZtjr6PBEdt0dmObvR0+ndjOR4z3C1HrD
 sC2ITIiKq/YWPKh1yzfH3fTyXr9c2HVbIt7+qqmPuek965F3dWi/LkmX2p+MrLyuH8K/
 ODrpP0tjkQdaqGTg2jCcbPxB9v3WTzQ08ID6E5JiD93saoiiqvGtOmV8AoHSMnP4yayS
 Wr8e8T1DJENUBZY4ifmcC8ekBjvcRXCr0tzaqjKLyAqp3Ukb7NFQIs6TurvZC6wjmD6L
 89Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z+SDME4E2sCY/GphbA3qjA/hZrqxGNEA6/MPHDiVJqY=;
 b=MO9NQVvZuRCM1lF17o1B+IrjgJWhdt6bXaeZfhAyLLP4/XqFcY62dBxOHYd4Ur5EZD
 nRJiVqAXYkZ20/IsgPEkDB+mZRtiTKMXBhSFsLsHlSuprgwY5tkYTiiI60Q0T3YeV1Cp
 K+8vbxOcfub6NFC+H/VM6IleZoEu/XFVlwQkW13/bHlA9/SXk/u4Uhh9BzoHWSBb2c2V
 nTiLexd6TkhnVlCbvDWMd6QZ4Y5U2cvHbvYKhSrpUBd8sVpjVGvgqXs/Eo8HHhBloO0y
 USEKoD7a3GbdQqVATuyYhtLr6hCRR099csD8rEs9ZuwkZ+/NDJVo0zYiIj8iphjR3INi
 3Uvw==
X-Gm-Message-State: ANhLgQ2B5aVxNdlZ9ecaOQKKqpK0garypN6Pq7RC3N5xywUJm9SvY3sC
 2AgHWNfA41vTv5Ly/ELATQlrRhG7y1M=
X-Google-Smtp-Source: ADFU+vv1ip7zS0WUJ4bL+8xS6APyw4z2AccLRzWZQXrd9q8K43Ps4y47bc9gqK1Gt21i5zzkZehxUg==
X-Received: by 2002:a17:90a:c244:: with SMTP id
 d4mr10382017pjx.136.1584720385438; 
 Fri, 20 Mar 2020 09:06:25 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id nu13sm5272745pjb.22.2020.03.20.09.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 09:06:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] target/arm: Rearrange disabled check for watchpoints
Date: Fri, 20 Mar 2020 09:06:20 -0700
Message-Id: <20200320160622.8040-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320160622.8040-1-richard.henderson@linaro.org>
References: <20200320160622.8040-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity rightly notes that ctz32(bas) on 0 will return 32,
which makes the len calculation a BAD_SHIFT.

A value of 0 in DBGWCR<n>_EL1.BAS is reserved.  Simply move
the existing check we have for this case.

Reported-by: Coverity (CID 1421964)
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d2ec2c5351..b7b6887241 100644
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



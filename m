Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F968C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68AF4206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i3pr+Hvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AF4206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59027 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYYf-0008FM-Iv
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYL1-0007dZ-W1
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYL0-00021z-Uj
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:47 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:38432)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYL0-00021n-Qn
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:46 -0400
Received: by mail-qt1-x842.google.com with SMTP id z12so6541628qtq.5
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1YbnvmhNqAhmF66BGNb4cMj4pII5ByUEQJWinpDd9pc=;
 b=i3pr+HvvhQIFADoBcT7sx9m+QTpGYEogcCuTQ+bZBNrl8SvOIkdFVNrqnyNessQppy
 4ujYK061whwILEBeMvHoS6YbPUSGE5HfSXx0wmeihfoRrOfB+XuWt78VIhnR/6TXH5Rx
 GprQnMi2/dRXK5DZPb5xpE5YmAt3drMPWLrZ/rKPvkTJ2Y1J4KbG7LJ1XnvxM5BZu0cP
 ozRMqEDN0lIKjyZYdZIz8Pa39MhTi6TGh85t5e9bZvNY0kt58yPpwuT1H+zHMUh/ugUO
 xwLXqOtSLgkhR4smttm5pRfZzIrwRbHAzlWLKIE7v5bACrnu+T4p1qH5bBvCFGyNqyND
 W9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1YbnvmhNqAhmF66BGNb4cMj4pII5ByUEQJWinpDd9pc=;
 b=bD7Dwik/sgNbKFCa8J45hQByYC3jw0+YgxJ8yMzsQUp0UUsfp5vI1n+FPQnUjZRoJL
 VxbujDD0vohvQrVxQ9YKQnctb4WagePm6HXU7Z7E0NCKABNlnGy3g+0n8Cl49cdhwxnc
 LnIPoeblvTYZMiJ444XwRgFjnhurf0sG1Fhs0ZQGCrEX92QeosY5PGj2MNFRlykeXIyd
 XKGsNuHpNOueIvvPs1q06Svjmru5dHaK00ZiBedPDUjP/0MDXQo4a8fUqX+sQwP7XjOw
 jBWAqvp+suljb+eQXa4UqbuQUvBw59JBZ5cc8KiEYtqNJm9n8mX5XXLTVXXr4DFsJztT
 2RBQ==
X-Gm-Message-State: ANhLgQ1xSpPyLxqJXjqb52bF+WH4cS7EBM12qiLpG7547q4KqhEgKOp/
 VZeRau3j/w3FojU+5yGpPlBLRY6E208Z5g==
X-Google-Smtp-Source: ADFU+vu8uMzGrx+vbrzz/WXcQAwn0CF8wof6U40HdRfOrCbc+zdCHS+eiTG046JJm9zywXejV3cxdg==
X-Received: by 2002:ac8:748d:: with SMTP id v13mr10396369qtq.390.1585251525197; 
 Thu, 26 Mar 2020 12:38:45 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:44 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 52/74] nios: convert to cpu_interrupt_request
Date: Thu, 26 Mar 2020 15:31:34 -0400
Message-Id: <20200326193156.4322-53-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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
Cc: Marek Vasut <marex@denx.de>, robert.foley@linaro.org,
 Chris Wulff <crwulff@gmail.com>, richard.henderson@linaro.org,
 "Emilio G. Cota" <cota@braap.org>, peter.puhov@linaro.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Chris Wulff <crwulff@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/nios2/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 8f7011fcb9..fe5fd9adfd 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -36,7 +36,7 @@ static void nios2_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool nios2_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
+    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
 static void nios2_cpu_reset(DeviceState *dev)
-- 
2.17.1



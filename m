Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236FAC432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 09:01:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFFCD2075C
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 09:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BZEo51bF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFCD2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iayd6-0003av-Ul
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 04:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iayWl-0004zi-Ql
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iayWk-0006ay-85
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:54:55 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37247)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iayWj-0006Yy-Vh
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:54:54 -0500
Received: by mail-wr1-x441.google.com with SMTP id w15so6842789wru.4
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2019 00:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wMWcP86dFfxoFCRo+Y7X3QjBtQNUy7uzWavkLda0OPM=;
 b=BZEo51bFOFQaBiq7JgDDqfLRwyyqR56QtpkZ+YQGmQF75Mvn7xSpv2YFDs8j9skbof
 dHuA15HeTcuYnX7y2NhvLTTxVEc8BcxujVddEy2/DqQRVezVSRU0yaHDGZ9AOAgCzxF3
 AE9oZ5b4PbH4SfETatnCt108vEyF3f0qfQ1fk4aklbf+ukovFL+x1N/zuSbolkq8AFgZ
 JD+YPB8nTeHLtl1U0SUwjrkns1mI6sxmvyem1KQHI5eTkd8ZN68e2t6RVsi5P7TebgjP
 j+s0QcnJtouFyo7K6Y/NByk95YB3lxLB0SVwt4vP17NVmD6ZREky799GlTLMNIRMAHr5
 tQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wMWcP86dFfxoFCRo+Y7X3QjBtQNUy7uzWavkLda0OPM=;
 b=gFS8m2lrmITwlt6HGjw+aU7r5XMbthDRPHlbUosihQ1LvpPIaBdRKuw48CqFPaTRmL
 TawvTUnt5na2JjRnJxu/Z02K5Eytv4rMN9zOL+2s/66LHOmrFYV0Vk0iAEk6W+XPptxb
 otHronDqadMS9v1W4X2O7v6ncKcD9s3UASEQ4CnSZ6BPhbn2wUFlPmuAZdwkrjWdcZ5K
 oecD4UmiAt1sdNmmgPP4p59rgmrOcsc++TFSqdyd7wvhSAuJI8Kwohsl0HoF9ODUfQaM
 R/g9J4JKhHi0HpWCvF9LjnSEl5R2p5wpv4IswsjQhebHDjCbyA+aqyl5ZFhqkAaVK9d3
 lxfQ==
X-Gm-Message-State: APjAAAWONRzoKnwv9to1hm5fOqp0NUMKuIXNSSaAa0vcFzqN98BD8L5U
 xpHTkku3z3ijTCieZ8t7CUTzvw==
X-Google-Smtp-Source: APXvYqyPs8p1fVrqmvMBqsWtU1Imm3MLvVEcdCOJCgViZyEA6tDgA62kYgCOJGwXQBX+lQR2LHLpQw==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr38104754wrm.264.1575104091870; 
 Sat, 30 Nov 2019 00:54:51 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s65sm320942wmf.48.2019.11.30.00.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2019 00:54:50 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A60D01FF9A;
 Sat, 30 Nov 2019 08:46:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/14] target/arm: default SVE length to 64 bytes for
 linux-user
Date: Sat, 30 Nov 2019 08:45:59 +0000
Message-Id: <20191130084602.10818-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191130084602.10818-1-alex.bennee@linaro.org>
References: <20191130084602.10818-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org, richard.henderson@linaro.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Linux kernel chooses the default of 64 bytes for SVE registers on
the basis that it is the largest size that won't grow the signal
frame. When debugging larger sizes are also unwieldy in gdb as each
zreg will take over a page of terminal to display.

The user can of course always specify a larger size with the
sve-max-vq property on the command line:

  -cpu max,sve-max-vq=16

This should not make any difference to SVE enabled software as the SVE
is of course vector length agnostic.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/cpu64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index a39d6fcea34..bc5d6c4b974 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -703,6 +703,9 @@ static void aarch64_max_initfn(Object *obj)
          */
         cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
         cpu->dcz_blocksize = 7; /*  512 bytes */
+
+        /* Default sve-max-vq to a reasonable numer */
+        cpu->sve_max_vq = 4;
 #endif
     }
 
-- 
2.20.1



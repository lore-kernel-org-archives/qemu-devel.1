Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F72C2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EBC32173E
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m4DZn6pq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EBC32173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLGr-0006D2-RX
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFQ-0004Rj-5q
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFP-0004Xu-6K
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:11:52 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44273)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLFO-0004ST-Vl
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:11:51 -0500
Received: by mail-pl1-x643.google.com with SMTP id az3so13187530plb.11
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IAnQiL0iMLFMCcApEq0tSytTxXGtPzjLxfXmOHANo3I=;
 b=m4DZn6pq/Yce5SNLuRzLHSGpx42AOIExlGxe33SsAPi38uOR39XAxQwlJxUJbBnKFC
 7h73DBeFpQuuGkLQioK2nu5FUV3GO8qJPhGRdeirBkqANT6XesFHbyegXskgsIE9mtWr
 COa8O72+6CsRDdwKKPs9hN7e0VkRiq2s6lzWqW5WbTFAZClzd7KIzjJWCiYn+ELHbW8B
 NJ37navf6EDf+9DNI55GvHW9Fp7rhyOtqhtw72a9L42/QUYdn8MHS5h6pnCgi5pTdPXQ
 Zkt0No69PhVuksZc6QlUyE73xkMgSlClNyEp5cZJgWowHlAnepMuzXh+2DobiVl/IM/S
 TpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IAnQiL0iMLFMCcApEq0tSytTxXGtPzjLxfXmOHANo3I=;
 b=n5GasFkyFrrO2b/v/x5NJDz9yOho6WsPSsCPHh6+vlBV1kIdjZI+W+TVJjkSbhrqFe
 MF1ZwacqpY7QZgsVkgdVtV8idjwpVUYXJXLKDxlbaTYPqqn2p9vT4PX8tChEKp8ob18I
 7K5OQWpv9IMwOApPlco2H9psRScaGW/GtCfumssagzfd+BItGIubc3U9QdYWZc4s/dvg
 UEmrR4FOwiVgaVE6gKpl3IB09DpdT417BDGmHa+Vy3YDTspE1Q12pSnOoYdBruCNsFMT
 uwIpbtoH4YNnRpWkdMTgZlRNfMiqUZsE8eo4NnbeMGn7JdI16JbWaWpfokqEAMqeSVlr
 fVkA==
X-Gm-Message-State: APjAAAXCy/TzoRcfkJ0DeWUC1Qhcf5B/u2KEOYfU3VaeB7gejt+yPVNU
 vFSJINSq4EjOQagexcyddfAxvUkOEJg=
X-Google-Smtp-Source: APXvYqz58R5Ay//v87VbZJW1lOjT3XkIxpo1dSB9HQ56gr09xPp2DVtM7uEr26VqpQYU8RZy43SZ8w==
X-Received: by 2002:a17:902:76cb:: with SMTP id
 j11mr59894432plt.175.1577574709617; 
 Sat, 28 Dec 2019 15:11:49 -0800 (PST)
Received: from localhost.localdomain (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id c18sm21077186pfr.40.2019.12.28.15.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2019 15:11:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/29] target/arm: Include tcg.h in sve_helper.c
Date: Sun, 29 Dec 2019 10:11:00 +1100
Message-Id: <20191228231124.18307-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191228231124.18307-1-richard.henderson@linaro.org>
References: <20191228231124.18307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Code movement in an upcoming patch will show that this file
was implicitly depending on tcg.h being included indirectly.

Cc: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index fc0c1755d2..83cc7f5bb5 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -25,6 +25,7 @@
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
+#include "tcg.h"
 
 
 /* Note that vector data is stored in host-endian 64-bit chunks,
-- 
2.20.1



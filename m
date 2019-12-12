Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A221CC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEA922B48
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HOJyPutX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEA922B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifFlr-0001QA-5c
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:08:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFey-0000uv-1v
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFew-0004Cm-Oc
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:03 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:32871)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifFev-00042M-K3
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:02 -0500
Received: by mail-pj1-x1044.google.com with SMTP id r67so455633pjb.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Tm+3zU2+l6eymlzwCB1U0xOnxx40yaNG/9+U/KiDb/I=;
 b=HOJyPutXkwI28qe8MJ/lJTYi+Ndl2nzk5rKbS19xQD7ZHzKEJTdOPENYVBpQXudL1Z
 nKfM4kdBEP+OyOvRFbXeFBv0OWD+i9JJ0uAjQkX4lwFzy6X0Qhdy1/8WsKBHoLFployP
 oW0cmwqvmPNHTUGKorW4PDJGwXpqRtWBBtJKDf3bUhLsRVbs/JXr0ipYdMgn2HNLyS6F
 Buv56vaQevz2cidA0Rf2osCCRGGOP9U0+mCree8Ar1z7lBUJ2eInIqvSjhhx6Q/X4u80
 38hxvEKRvkEIfMJlS3GsWI3RnD6U9TxIsMMtktxgTEwCESIbLqywwRZRmemS75tIte9D
 Rh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Tm+3zU2+l6eymlzwCB1U0xOnxx40yaNG/9+U/KiDb/I=;
 b=FksV/UrQyTEXMJgSuciQXRHQfzfIYeqwARiBuhxkiNicYMhk133ImnZ1+XpRgwrOhX
 XTVV6YwCSZ6aoyHLJIrHetzY+3yGUDahUW1KcT91VdPrW0D2PyxLx5jBGh5ygrQuHZEa
 F7nhW2H80cQHnUMULAxo04YdOLvIUoBvcixG9QSduQFk87UjLs5aVRbjOse6/1UxxLcb
 YuB6r4rbwmNI+qmbamy0taeDRl4B6i4XI9POsnbtJG+pEyC8jTOQ7UiaTC3rxbOGvYeW
 jqMskIGZOulSr5puqBRQcMpkAwd2RpPzTbJGKqSKymLmUXB5eBjXOdzczNmxlKYEC9ot
 tU4g==
X-Gm-Message-State: APjAAAWFvWMgNHdT8QeOnhSKL5FL+6uLnN+s6qfI/FKXeQyK6HUWQaOO
 CoUfDmuFBJS4IOPoDPqzo59QwadYYc8=
X-Google-Smtp-Source: APXvYqyerPYRt8akK7G65410Cpln9mxpuei9VDkgmUKGFS6qc5lqO1oqtct8nBOfH11EXfuEZYpUJA==
X-Received: by 2002:a17:90a:e98a:: with SMTP id
 v10mr7597126pjy.67.1576123254761; 
 Wed, 11 Dec 2019 20:00:54 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z130sm4666391pgz.6.2019.12.11.20.00.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 20:00:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/28] accel/tcg: Include tcg.h in tcg-runtime.c
Date: Wed, 11 Dec 2019 20:00:22 -0800
Message-Id: <20191212040039.26546-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212040039.26546-1-richard.henderson@linaro.org>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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

Code movement in an upcoming patch will show that this file
was implicitly depending on tcg.h being included indirectly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 8a1e408e31..4ab2cf7f75 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -30,6 +30,7 @@
 #include "exec/tb-lookup.h"
 #include "disas/disas.h"
 #include "exec/log.h"
+#include "tcg.h"
 
 /* 32-bit helpers */
 
-- 
2.20.1



Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C79DC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA0602070A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UBgM/EaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0602070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2N1-0001sc-IL
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 22:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2IN-0003sM-0l
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2IL-00032r-Ue
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:10 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:42613)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2IL-000323-Mk
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:09 -0500
Received: by mail-pg1-x52e.google.com with SMTP id s64so861745pgb.9
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=70gIRC3ozz6Ck0EZOpvXdwR/Q+/44XMCWq0hBLqYbys=;
 b=UBgM/EaTMkHpFsrSn0zqhrvl+YuTWb/KvNepzACb0txmLeQEYMl28e+CqyjlYNPv5X
 bOzfy3/k+SYnKJIUKO0HTEtTOBHE+rbwVtp1tmG/BUGWi/pwbsLBB1tiNZzGMra7Bz2n
 otnTn8jMAsfoQGch9/7+jvr5Vn0sUhxW9yISzTtwU44WIyWgX2IiORrSqcfhGFOB6qwT
 YCGEUi+vXlUAXf57UJ5pjHi7nfVPnKiv787PNtV1+tsrMwwBVqqcFJAGaRQZ435LQWcv
 S7xI4HytiVyW9RrL+aepX7UNQgnOgC6GdE2iF+Q9z+wfpLKhVchA0YzllqddqfNEnMS+
 FYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=70gIRC3ozz6Ck0EZOpvXdwR/Q+/44XMCWq0hBLqYbys=;
 b=CqTbQTVVnfLfBaEJ28qtU3x0/yy5GsJiT+Cg8zm/8ABnL/fXAvOpJbH6n/wlD2dxi4
 wxr19ghdpr6gIOS8zBExVQwDyljAjfbY7qu+cXHhyV3cR8cCFRfCCJJbzeI6aMM4c+vl
 /+6KeTp4zjzxRzhUcM836cDh3TKK/FD7ZOBfRdKFqhqe/nT5SVLHrTfQSJl5WZT1RG9i
 dgzYFdzhc2aCbsKWIo1tVDPriyjMWeI8zP947NF2BYK8JyJKsp+o/zIr2sugIfj4C2q8
 G1AMRkK1d71DQKbZ8AE/vR1FpYQpaWfp/Lvk7pSA9JhwEES6Cp0uUMpcyveH80yF0cKe
 kbFA==
X-Gm-Message-State: APjAAAWrUfBVefdEgWHTv+Qh2DAFrtuILnf/6JCGTU0exxDgwqqLcqQK
 01qQsdSaXcu9GO4IN09ASyE1Mruuc9dIiQ==
X-Google-Smtp-Source: APXvYqy+Yixw/b/KGBdo+4YCvEpXTYUh7omXN+Ka4+RYzKDYPJB1co+oaFhrEJH2rzen9Dc/ukRMkw==
X-Received: by 2002:aa7:86d4:: with SMTP id h20mr2789630pfo.232.1578455168614; 
 Tue, 07 Jan 2020 19:46:08 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:46:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/41] accel/tcg: Include tcg.h in tcg-runtime.c
Date: Wed,  8 Jan 2020 14:44:55 +1100
Message-Id: <20200108034523.17349-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52e
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Code movement in an upcoming patch will show that this file
was implicitly depending on tcg.h being included indirectly.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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



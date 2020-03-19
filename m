Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52101C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:34:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C13A2072D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QjikPO/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C13A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF0wE-0005YV-8u
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 15:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jF0v6-0004H4-F9
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jF0v5-0005ta-E4
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:33:32 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39738)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jF0v5-0005ro-87
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:33:31 -0400
Received: by mail-wm1-x342.google.com with SMTP id a9so688574wmj.4
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 12:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xmJXguFcCJyV8YvdEoeDLFSPVywWgWvisk8RAVF+M1Y=;
 b=QjikPO/llx/bix7LQibhTzqpE1buWelkBsfPF54WGEloF4eLaQRrKbAYm0N8144J0g
 OHkTXCw/6EXjG/YRKSt6hdqOhAe4LHR7UTDdbJw+pbZRFd6u3fczIJsn19FwxoJ9msgL
 yEwSj4v6AWOZrHLoUbvT9Rc1DvzSblFlCn641om6KYbyQWHS+pL3pQ86P1ZnHyMLoF4H
 Gq79P0K1ILHWu5OCDhcOmXP3jcSCAWKTLxhVMUb9JgQrwWFDYCQ4RGC3JPRBV+KJEo8g
 zaXs2kjVYCKKhGYMGD292ccZokD0h7wiFjHwtHDlmrPINM2d+F6Ha5OyZIP+AvKhczkq
 hSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xmJXguFcCJyV8YvdEoeDLFSPVywWgWvisk8RAVF+M1Y=;
 b=eYTGV8oPuHq2dfD5KEvcRNG8yAYZpUOoowgjvrrx/ILPc/4hV1CeROYS2+fFmMiw2x
 sNY4CCagrCgoeFzDrCWt8WcJCoL8AazVd90110lfKPvrHg3WXYkpxf2/JbnURPqXVT0b
 i3P6Z4YenyRNMf3X5rEPZPPYzERyjpBkjvgYZaf9JpTSQn27K5psE5Y4Wdxh1neHqiXc
 EQjZEL6fPcBf6WOGPGQHLCcLXRLDyF2F4QiICfLWsjj12sqsaqVprzoIWd4+XiiGKT1G
 o/6H9tO4vYSShcWsOf/xH6VbOTagpioeeAX3qQ9JtQejvuc9ULv/1J0AnD21cRjIlGV0
 4hcg==
X-Gm-Message-State: ANhLgQ18emOd7CLAXQB03tU2UI0gU30PiPSdRL1ontRLMqig2J3rgone
 b1f6yBKIUmcs8KLzWFL4L6zwaDGK6kAkPw==
X-Google-Smtp-Source: ADFU+vvhAldbnZZHuzl/F9/Uit3jFUwRn/W5naVQPAW9aBh+QtgCKYBW8+yc9+BOKyzXfXF0Jl59cw==
X-Received: by 2002:a1c:ba04:: with SMTP id k4mr5648802wmf.165.1584646409886; 
 Thu, 19 Mar 2020 12:33:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o9sm4984794wrw.20.2020.03.19.12.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2020 12:33:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/6] linux-user/flatload.c: Use "" for include of QEMU
 header target_flat.h
Date: Thu, 19 Mar 2020 19:33:21 +0000
Message-Id: <20200319193323.2038-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200319193323.2038-1-peter.maydell@linaro.org>
References: <20200319193323.2038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The target_flat.h file is a QEMU header, so we should include it using
quotes, not angle brackets.

Coverity otherwise is unable to find the header:

"../linux-user/flatload.c", line 40: error #1712: cannot open source file
          "target_flat.h"
  #include <target_flat.h>
                          ^

because the relevant directory is only on the -iquote path, not the -I path.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I don't know why Coverity in particular has trouble here but
real compilers don't. Still, the "" is the right thing.
---
 linux-user/flatload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 0122ab3afe6..66901f39cc5 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -37,7 +37,7 @@
 
 #include "qemu.h"
 #include "flat.h"
-#include <target_flat.h>
+#include "target_flat.h"
 
 //#define DEBUG
 
-- 
2.20.1



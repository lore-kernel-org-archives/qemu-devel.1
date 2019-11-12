Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C51C17440
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 666042067B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q9idqCMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666042067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXko-0001ta-Ap
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 10:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iUXgf-0005yt-Jk
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:02:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iUXge-0002MP-HV
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:02:33 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iUXge-0002LR-CR
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:02:32 -0500
Received: by mail-pg1-x544.google.com with SMTP id z24so12027673pgu.4
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 07:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PT8V7FGR+uiq7NVQ+Sjew78XVlFsZNWfaPZAmYaVr1k=;
 b=Q9idqCMz9VimN1mMjs3zKKOgu3qH6ebvRMGUkdIvw/xpWGHSAvFdW0RRmKk4cbYfhK
 ZSu6sw1X8Nxrz0mzIg9luOOw0qjM+woe2NyjLoYXO/Rj3lx4uYKXIMCPNeUT3Mpkrau6
 MsgJEIlRHL98krpYf1g1e0vvSZjPivYElyJhVZhaYXlM7DjgLFJBJF7WO3GivsNUuh0s
 jDy+/WegJGFa9AXNU/rsQswCjZ6B2/gIMMOOcJpQGkyn0GoU8j7t3FlL0dKiMqtX+IlU
 bRah0LBoS/jPrug038fn2IdSP5iR7bc1NcxuFMVWgEfAQYE/orTeYCR/Z2kd4zOgyD8i
 JTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PT8V7FGR+uiq7NVQ+Sjew78XVlFsZNWfaPZAmYaVr1k=;
 b=mEi7pFTrHEgscKGXaH4q7H4Lrx3pgF6B4l+fNqE+DRz3i84htLS6u2zHFVhs/VTEk+
 xtxV4M0vOiVe9vewdFxHTs74XJz/Wk1GpEo68RdTABwhQunhSpnh6bj6lHcFrsfJTWWy
 joXlh7bSUSdspK9WJq+vRSPp+9eu5JDnUYorlWMXbviOvm7+wH29cSqjkjGhnEoC+iPD
 H9zBWSZlN2BjXWirqnYfHLTJEGr5EhYP4w/tC+mIrg0KhSptagp1n+AsbJlTlEnGxs0V
 8gcUhHOr5UFoPKdUDwvZrcNosJiKdFH73jIeqJ3OCJ9mrHD+4ky2zvO6mOXsdPXV0xDC
 YJZA==
X-Gm-Message-State: APjAAAXUSHrSXvX6klO0Ny6kXL1sm71jwpxyu2oJbDf5+DrqGX99wXkJ
 2JojW2eKZ97l+YpUoaXIZdhkxBJ6m38=
X-Google-Smtp-Source: APXvYqydZHbRXKOaskx2KED5Vp78LHwgvDL/dT3tqHdIZNtzSzeP0L1fGWWKw2Y7QjcZms6bcnrIJQ==
X-Received: by 2002:a63:f501:: with SMTP id w1mr36813394pgh.307.1573570951144; 
 Tue, 12 Nov 2019 07:02:31 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id a3sm8235511pfo.71.2019.11.12.07.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 07:02:30 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 5/5] Fix double free issue in qemu_set_log_filename().
Date: Tue, 12 Nov 2019 10:01:05 -0500
Message-Id: <20191112150105.2498-6-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112150105.2498-1-robert.foley@linaro.org>
References: <20191112150105.2498-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: peter.puhov@linaro.org, alex.bennee@linaro.org, robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After freeing the logfilename, we set logfilename to NULL, in case of an
error which returns without setting logfilename.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
v1
    - This is new in the patch v1.
---
 util/log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/log.c b/util/log.c
index 802b8de42e..1eed74788c 100644
--- a/util/log.c
+++ b/util/log.c
@@ -148,6 +148,7 @@ void qemu_set_log_filename(const char *filename, Error **errp)
     char *pidstr;
 
     g_free(logfilename);
+    logfilename = NULL;
 
     pidstr = strstr(filename, "%");
     if (pidstr) {
-- 
2.17.1



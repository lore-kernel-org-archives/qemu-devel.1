Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0995C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98B9206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="baRLPYTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98B9206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWHx-000791-U4
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 08:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53593)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hxWFO-0002MJ-Oj
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hxWFN-0000iE-TH
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:54 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hxWFN-0000hQ-NP
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:53 -0400
Received: by mail-wr1-x444.google.com with SMTP id q12so17367345wrj.12
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 05:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cEKv00Em9U5YApD5FMoRIKqjxBDA/UgVlGfBKWggZY4=;
 b=baRLPYTP/xvzEBB8qghJskeYWBvRPOTZsoSTjbiXlmMDci22FZLIFlYGBCiY8n76ou
 7XTwFd1BPzcfzTpjqDHng82VJB7Dt9jriJbtib0UOllKpL597z63WP0HcNYOsAMBTac4
 kJ+6bzLjJ5AQL5SaQiI79Xo4vydh1lSV1NbGCaayjOU0Qhbhcby8y8bpCEl2em7JITS1
 vTucUUQmESnr7OvxboB8ESIVsc+c2oBRhg9oi202tyg2cZvxfkHGDh8YcK9vg5xEYI+z
 PWaP6LjZli///fyGuA2BNgIEP+yC8XU7MwStFeEOi5utfL6zsMGZ/BkeYW3AwGcEi4Ly
 7ldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cEKv00Em9U5YApD5FMoRIKqjxBDA/UgVlGfBKWggZY4=;
 b=Hi10SGZ8yKnT0lt+f3JvtOdOSIcy4xtCwWqxfreIQHLZYvOXF0c6pTzoUbhHyNIvrJ
 ysL4Su4h3dIFPO2mXE+Emnq0nQzSaGs2adIttZN5zjtAJmytSNw9/I2SgdFhc+1SWiRz
 vpCajZa1k7oT0uQexKTaCCtWrct7r8JSmRqFhgubl17zxj/Piv30L3j2UB1ZWdOcUN4W
 ZAx1Zs7m1bWDZIoqo6yxUU36sOc/TMQPE6vcnoHFloeluIcZYPVqhsznzINVsD1NYUZk
 U64jxmsGk0h4+wRkjXlUwv5pn71AL4110Nt+UXOCetW0AOydq6NqBvwscs2lxFtAeizY
 tbOg==
X-Gm-Message-State: APjAAAXb1ExZhHj2+jLeYCe7Ej5ge3smD6koldGYxSlg7ykDS1RI4HfC
 5HUBcauYK1KQZXWEX/rSpCTNhw==
X-Google-Smtp-Source: APXvYqyuOeZsvRxpa9osma+u4fYvGCeGa6ED9QEDeYmxlAiiGH95LkcFJi9zeFI49tTRssWh7mI9mg==
X-Received: by 2002:adf:cd81:: with SMTP id q1mr48012266wrj.16.1565700592616; 
 Tue, 13 Aug 2019 05:49:52 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id f17sm1588521wmj.27.2019.08.13.05.49.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 13 Aug 2019 05:49:50 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 85FAA1FF96;
 Tue, 13 Aug 2019 13:49:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 13:49:40 +0100
Message-Id: <20190813124946.25322-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813124946.25322-1-alex.bennee@linaro.org>
References: <20190813124946.25322-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH  v3 07/13] fpu: remove the LIT64 macro
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, armbru@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now the rest of the code has been cleaned up we can remove this.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/fpu/softfloat.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 3ff3fa52245..d9333eb65b8 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -82,8 +82,6 @@ this code that are retained.
 #ifndef SOFTFLOAT_H
 #define SOFTFLOAT_H
 
-#define LIT64( a ) a##LL
-
 /*----------------------------------------------------------------------------
 | Software IEC/IEEE floating-point ordering relations
 *----------------------------------------------------------------------------*/
-- 
2.20.1



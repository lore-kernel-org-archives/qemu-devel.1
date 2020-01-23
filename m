Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DB2C32771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0AA921835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nMyS+6v0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AA921835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuQIQ-0007dH-Kl
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 19:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzd-0002Fd-HI
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzS-0002Hf-UX
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:05:02 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40783)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuPzS-0002H1-P2
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:54 -0500
Received: by mail-pg1-f196.google.com with SMTP id k25so383792pgt.7
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 16:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jaQrQFKhStbfHQZg/A4k6/bsA1l7dnccnZkJW3y3CwU=;
 b=nMyS+6v0pqvAya/RO8U20tzAjuQHTPS344wgmeBhwzBFDy/rGclcYYR1oaSno0yYSU
 cxlPBvRg557rDtKIiTlyKmK0ORXw+VFc1kbkrWBITPBhe3vUfR+pCdWrGT3mnUI4Meqo
 p0Hna5xnUsrrz0EKpLwpvnn/eC7sMNdoMJnPfsECzho4JTuZl4Vm10pLt86XoffFcG5y
 8cO/nyCkQCOEB+4BMZQgauX5R7ZFrfmpFutX8P3qWRWJh9a+pBtOYzICrc8G7McLY+Ii
 ejCdpEanJoEkdp3w9wcX7Sux82CgCDNrIRVUCZU+7m92LVt7T6d6Unm9a7wgXaLHcBbO
 jLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jaQrQFKhStbfHQZg/A4k6/bsA1l7dnccnZkJW3y3CwU=;
 b=R9Pjrpi6n7uVWlqawn7nghQ92JtAFBcwv9XJiVmjLPIX+NeYson6UF1FjR++MdPQ7s
 VXV0llO2nZprhRy+I4Rp955YU7XfKF4viIgt9wLQ3dEPcNaTlyWBxU7k3HQKiv5iIyat
 3fBIIXWvydGbVrQPCyV8dZOg9yFNfpKWBfgGMD0XpNPxe9BiGPCKf8ZqdBh/MJdWBoA2
 gdkBSQw9lsttQVrwnd6hE4adZ1KTRVTAzmhvcF+KtKumB8JRaCRRCvV8Z7mxjmvNEOz5
 1S6lPbkAvhMdFlbv5HM5EpaEB6Q8TSQeeSV7x/01FbsR/to3oR9oe5PqPZow34ggx5Uq
 G/9A==
X-Gm-Message-State: APjAAAUo2q1NXs2+vCm571Ot6lp0xxKWTsFJ7ttYGXMgYu4SgqW3QAU6
 F8zp1WuW99PIWQY3dIdtD7dAHbOxPUk=
X-Google-Smtp-Source: APXvYqxSBe/uwGOEc30Nrw78YaT7OeUZP6J45Nyt98GpWsullp0wpAn4NktwOs9TCp0Sbv8i97M80g==
X-Received: by 2002:a63:7701:: with SMTP id s1mr958854pgc.271.1579737833498;
 Wed, 22 Jan 2020 16:03:53 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id b21sm84521pfp.0.2020.01.22.16.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 16:03:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH rc1 18/24] hw/avr: Introduce ATMEL_ATMEGA_MCU config
Date: Wed, 22 Jan 2020 14:03:01 -1000
Message-Id: <20200123000307.11541-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123000307.11541-1-richard.henderson@linaro.org>
References: <20200123000307.11541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.196
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
Cc: thuth@redhat.com, me@xcancerberox.com.ar, S.E.Harris@kent.ac.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 dovgaluk@ispras.ru, imammedo@redhat.com, mrolnik@gmail.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200120220107.17825-13-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/avr/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 hw/avr/Kconfig

diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
new file mode 100644
index 0000000000..da3b10afec
--- /dev/null
+++ b/hw/avr/Kconfig
@@ -0,0 +1,5 @@
+config ATMEL_ATMEGA_MCU
+    bool
+    select ATMEL_TIMER16
+    select ATMEL_USART
+    select ATMEL_POWER
-- 
2.20.1



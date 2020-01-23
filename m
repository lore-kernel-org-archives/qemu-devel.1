Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD09C32771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:15:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D6C24125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iwlvuR7x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D6C24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuQA1-00066q-Eq
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 19:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzZ-0002F3-DU
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzQ-0002GA-Qc
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:05:00 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:40435)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuPzQ-0002Dv-4L
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:52 -0500
Received: by mail-pf1-f178.google.com with SMTP id q8so609447pfh.7
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 16:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rlIp4XTZtTxjVzIGixZMSBGNZLFWLQy2m4oEKua7yhQ=;
 b=iwlvuR7xkCkYPCDDeHWajhFmiVzwCuWDW0x4D3PkcFW/r/glxTOtIeAAoAhYcDcoUO
 Cj6OCHqoJOqeP/D19K1sCXz302NfiRiKuKDkE5Fh7dQjHuGNTHBrrhvobx4SbXGel7ao
 aFKiaB0mbTkC5cr+cRNNKYpxprWaE60nDPWIVAzEDgNbo/FnLytWyjQou/+UnMvjMn1a
 5CFJbRtilmsUe30Q47s7pe+k2ugCemhTIrWwLBg2OdKrmNUXxTWXY1MXMrUqGpC4PUL2
 SkV9zTrsPhVStGmVtuqbj5Cd3re+ifNYTNBDdwSEtuwi1CNXktXMgJGRKpNICLv7uUAL
 Bwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rlIp4XTZtTxjVzIGixZMSBGNZLFWLQy2m4oEKua7yhQ=;
 b=cDHa03kMs9H9Ig8zQORTMvAcKIFpZaTDEEZj1+31f3WRbYVZ/v5L6JoKrq42aV6zi3
 ID+c+eR7FYQTVwM7gHT2X4ieqeR12cvxv6YO2X9d5zre71qmp/eF5rdMPdtLQOefyLn+
 iyVvqIT+rbo1WcSxm16B2wXUb/xzM+05JWvDfncFhSVEINgomYSYjH4mR4ODM/ljTHmB
 Hu7I/K7NLuLSM7aDezLApXO5UlGwDOYJF3pCpDw53PKvKkBdDZwVgkWot6rpY+thW6du
 PD4nsbjNsbncLKUyieKd1TSN+a3mqFRjSUELcxhowRWZon4ZwzmB0su0kY4mn514qHAN
 rgzA==
X-Gm-Message-State: APjAAAXOV0fudQ2fn+W4rul6r+LgN6vV4f0KSypvQhFHIUjw+jtIqzGh
 dGq/EaJa5Fhx0hnKrTiokG8OSUsktgE=
X-Google-Smtp-Source: APXvYqwKO54wbOya75mkNOcbIe6L8W7GbAFgba6heULhRrZZUNShhU8FQg3/YTGsrrIOrWfAYHWg/Q==
X-Received: by 2002:a63:e309:: with SMTP id f9mr910909pgh.391.1579737829149;
 Wed, 22 Jan 2020 16:03:49 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id b21sm84521pfp.0.2020.01.22.16.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 16:03:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH rc1 16/24] target/avr: Add machine none test
Date: Wed, 22 Jan 2020 14:02:59 -1000
Message-Id: <20200123000307.11541-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123000307.11541-1-richard.henderson@linaro.org>
References: <20200123000307.11541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.178
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
 dovgaluk@ispras.ru, Aleksandar Markovic <amarkovic@wavecomp.com>,
 imammedo@redhat.com, mrolnik@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20200118191416.19934-18-mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/qtest/machine-none-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index 5953d31755..3e5c74e73e 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] = {
     /* tested targets list */
     { "arm", "cortex-a15" },
     { "aarch64", "cortex-a57" },
+    { "avr", "avr6-avr-cpu" },
     { "x86_64", "qemu64,apic-id=0" },
     { "i386", "qemu32,apic-id=0" },
     { "alpha", "ev67" },
-- 
2.20.1



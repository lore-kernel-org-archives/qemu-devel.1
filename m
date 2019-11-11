Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC64C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 12:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11BEF21872
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 12:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l0+kwUjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BEF21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU9Fe-0001RP-7H
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 07:57:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iU9EM-0000lK-CS
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 07:55:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iU9EL-0006Bi-3L
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 07:55:41 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36375)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iU9EK-0006BO-Sc
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 07:55:41 -0500
Received: by mail-wr1-x442.google.com with SMTP id r10so14542671wrx.3
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 04:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WpXKEsMaXmP8vqDmswKMng2igukqeb7RB8LRQZsgWoE=;
 b=l0+kwUjZzlHTrGa2M02TSxCslzBYIo4gzMquhlXFkCoklmF3hta3IgdvOS82qPppXI
 jq2vMwO5c7lnQ+aFHs4bMzA5yOK8OM9vfkSEAAbYVkskSLl7p8R5NrGdK8baFsRePiUC
 nffVH63hGzFTys1j0IXGFhTem3VZuB0WBoTU6AVBrpu5MbKi7sePV8huk49jRLlsjIQJ
 Ag3paP02TFHfcIsT5HzIlc0ph/EKduU+1/EncQ9hCeRDetFre/2UXDHf+v5lvA1lr2b4
 aCBZZoXRbeXUW5oTxDGRXyVmEmvNM51qCaoJH2PXxar8rr1RuyhECdAkbfsUb4WwCqzV
 Tl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WpXKEsMaXmP8vqDmswKMng2igukqeb7RB8LRQZsgWoE=;
 b=EfssaVq0XzTERUPVz0TldC2iTgaon9DBwFepmu+3L9db+5NYK+1SpWUiT4URjml7CZ
 kjAuUchFX4eqGXCtX3k54mkMmfNDtQzFuxVx8gETUXvNzprq78t40sW3VSRTkV8Zo20V
 +SDpZ4qt7gXCuNEX4uLFhJzt12ehESsDQz1OvrO0gImSwlV+DUfsDdxgjYB80/2r9Nfx
 AlBni5Z4CebxKArqPd37VIglhhcBlbMMH4n/C1SeNPWGsWD05kE3xsgyJfOZMSDt81Hh
 6F05OHA9Yz3poN7E1ZK+pqi+dZAmLlWzVayLYWchO193lpo+40jWO0wnkulQoGvpaJqR
 kQ3A==
X-Gm-Message-State: APjAAAX/1z+m09aZokAsdGt3AQlO0Ujc3QspWQQHJavYTnY2x+gD9Vul
 m9C+Q5oSMm0Xr52rxKW23GKRaw==
X-Google-Smtp-Source: APXvYqzYgJcWMdovhtjwqLrbAg8aK9MBXdBMEpkNxr3jEQp3QegChoSnRuicM85slFxM+RG/xrFYDw==
X-Received: by 2002:a5d:4645:: with SMTP id j5mr13090957wrs.329.1573476939287; 
 Mon, 11 Nov 2019 04:55:39 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g4sm16779813wru.75.2019.11.11.04.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 04:55:37 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4FA001FF87;
 Mon, 11 Nov 2019 12:55:37 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/migration: use the common library function
Date: Mon, 11 Nov 2019 12:55:30 +0000
Message-Id: <20191111125530.26579-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/migration/stress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/migration/stress.c b/tests/migration/stress.c
index 0c239646934..915389b53ae 100644
--- a/tests/migration/stress.c
+++ b/tests/migration/stress.c
@@ -31,7 +31,7 @@ const char *argv0;
 
 static int gettid(void)
 {
-    return syscall(SYS_gettid);
+    return qemu_get_thread_id();
 }
 
 static __attribute__((noreturn)) void exit_failure(void)
-- 
2.20.1



Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1A4C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45360217D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c5yaFzXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45360217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4jiW-0001xf-5d
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 06:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSp-0004n3-Pj
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSn-0004JH-Po
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:35 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:33442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i4jSn-0004Ig-K5
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:33 -0400
Received: by mail-wr1-x429.google.com with SMTP id u16so13459788wrr.0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 03:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oPHGA4epXrz3sRBaImYzLMH9SUMVM871U98ActdGL7I=;
 b=c5yaFzXnNK+06rXJ44PKu9mbQ2TS4OONs6hkX2z7ANU6cVuzgyq1J/gKl59NJb2wKd
 7VjEcGFVjKYWqzTaw8HsY7fPT1FuXo5muL3l4lnIr9Wt8Hw7o/AkrTqmbfiQZo4pRSbK
 XfP+b/Rtib4Xev2ThdvNOU8KCA513S7TxknGwimJxLefB30C7PhGJq6j8do6/v/4B73h
 UstXAHC5au/wvxdOrokoi9UTacq5TeCH6Q8RSoGODu3UucetVLMVnoujC1JX1gXLm4H6
 laduExguTVg/G4uCfYfYhxgGPsNpAE+3bLGRt1G/oX7ZKOG86wYO+NwtSQXT19Jjeqm3
 +7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oPHGA4epXrz3sRBaImYzLMH9SUMVM871U98ActdGL7I=;
 b=uK6Lu1++MoGC+EIH5OrBAiZJ8AR+3a2QuB4qqYmyKpS6+bia3ze3PbD7Y+LW3mBrPN
 ukvhYGUqphjwDYKvj5eoYtlLZfHHdalxF7fOuIHNoPx3RpWTkgjaV1H3AoBeWIlYx3cs
 WoGLfOl6AuAa0gQT+IvjtLAGOuo2sUETLPpmHVjelhHQAjlZJr6w0W9F6vyA+PvLlEAU
 +BLWi2VMdBKB7SAsttWnXArF0RBPIwmFgGzsq5x0RGQwSV18jOsoJJYVeu0JW+Urbi/i
 +nGcwhIHm1y69F9VX9yIkbx0rUpZlsRtWBosSsV9BtfyFpM3m6w3g7pE/rjk9Lfs02A9
 w2ag==
X-Gm-Message-State: APjAAAXelnKdItW0Xgr2UP6oPgrKkiZwfJwnKrnB+Y5x2Ow3ROo77NN/
 iA3Es3WE/JhfLlm5QZopTJL5o9TKTQA=
X-Google-Smtp-Source: APXvYqyJQNqghJ9WGWvxukvgBBuCFfbAoYgHttJVjtAawlKuOY+Zzb2js5S3LBQuTKg0woLnpOicTg==
X-Received: by 2002:a5d:460e:: with SMTP id t14mr37069670wrq.171.1567419691561; 
 Mon, 02 Sep 2019 03:21:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b26sm15848046wmj.14.2019.09.02.03.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 03:21:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 319451FF9B;
 Mon,  2 Sep 2019 11:21:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon,  2 Sep 2019 11:21:21 +0100
Message-Id: <20190902102122.1128-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902102122.1128-1-alex.bennee@linaro.org>
References: <20190902102122.1128-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PULL 11/12] tests: fix modules-test with no default
 machine
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Fixes: eb062cfa733 ("tests: add module loading test")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190827140241.20818-2-marcandre.lureau@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/modules-test.c b/tests/modules-test.c
index a8118e90427..d1a6ace218c 100644
--- a/tests/modules-test.c
+++ b/tests/modules-test.c
@@ -1,12 +1,14 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 
+const char common_args[] = "-nodefaults -machine none";
+
 static void test_modules_load(const void *data)
 {
     QTestState *qts;
     const char **args = (const char **)data;
 
-    qts = qtest_init(NULL);
+    qts = qtest_init(common_args);
     qtest_module_load(qts, args[0], args[1]);
     qtest_quit(qts);
 }
-- 
2.20.1



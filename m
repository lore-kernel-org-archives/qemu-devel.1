Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8A1C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C62E920673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="om2TkERL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62E920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipYma-000514-Kd
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 09:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYed-0001HS-Jc
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYec-0006fV-13
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:19 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:37117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipYeb-0006V2-OM
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:17 -0500
Received: by mail-wr1-x42d.google.com with SMTP id w15so7602544wru.4
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 06:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pGFuI2VzsueFfRYgKlL+5ZNBMLyILhWpz0lMo+21zas=;
 b=om2TkERLug/e2mX2sKxqeYlKCTEz6CkscUruXLZVP/UhL+03jWepUphhMDXCScn//H
 K8WVfxoZv4ZkSDOoc/+Bmq4fkuqFOJqW0wybrY6dovHhvF1BQtNchKVXo+W9bZ2j1yNR
 d9xW49f2i98uRTZ4POWXDmVKSr3770U39CiYJh59GqgTJWIYtfDc0utWaiIvpmQX1TRv
 cn0zk4S/QJBdKkwVNExj+eEZM3bon+C3YzjE+AahWkPffp5mWa+IQBCmgl3sj/BraP54
 fDI1LA33ZKMk0+IZHKTvs7PO21537RNfmQeZE8CJ/W9xGxSKb7I+Yo25HQSDheXh4rBx
 //tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pGFuI2VzsueFfRYgKlL+5ZNBMLyILhWpz0lMo+21zas=;
 b=l7Z7PeQgGAp9TmND+1z4SSgxOeroc93L5nraAapNvkVU9J38/Zzb0zABB0BocDPVFb
 m2Y0u6KsBVKrP94vYLyQUzfMhscB8EViFuWYNX/z89fnf6A+1tq9hsh7aoLhV7SuKUXb
 UAZKNftcdwGA9YFPH+XhafhpREsWNLqHXZiIuyJp7HaGcBfRpx0DIOUYS7qfo/KuYB/0
 Ps/0a1cIn/WmKwLd6Ox+xLtXli6HNNxYSrtcaGi5tCMQMvRlIwhdxVN4rKQ9ChKtTu46
 GbhKyzhLPs2KGjjdYXN4RT6zjR1JLLIzHcDIGYJJBj+hUOOaS3K77U7dADidGOkkbu/o
 GOBg==
X-Gm-Message-State: APjAAAV4SUT/CUINjPJIHDZeZkuBeZKEd+3sZc6/IxQTcj0rOLyhby69
 O8Yj6nPETxLAbQ8PpxfbhvOBRQ==
X-Google-Smtp-Source: APXvYqxKBZ02K7n2kBkUZPE2jiffSNKuN+wzVvPzrZ0BalxMNMui5+Os/Dp+0VIU0ZTpNDCbOehcgA==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr11989859wru.382.1578579555650; 
 Thu, 09 Jan 2020 06:19:15 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y7sm4022013wmd.1.2020.01.09.06.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 06:19:08 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 445081FF9E;
 Thu,  9 Jan 2020 14:19:00 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 14/14] tests/tcg: add user version of dumb-as-bricks
 semiconsole test
Date: Thu,  9 Jan 2020 14:18:58 +0000
Message-Id: <20200109141858.14376-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109141858.14376-1-alex.bennee@linaro.org>
References: <20200109141858.14376-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are linux-user users of semihosting so we'd better check things
work for them as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/tests/tcg/arm/semiconsole.c b/tests/tcg/arm/semiconsole.c
new file mode 100644
index 00000000000..6ef0bd24500
--- /dev/null
+++ b/tests/tcg/arm/semiconsole.c
@@ -0,0 +1,27 @@
+/*
+ * linux-user semihosting console
+ *
+ * Copyright (c) 2019
+ * Written by Alex Bennée <alex.bennee@linaro.org>
+ *
+ * SPDX-License-Identifier: GPL-3.0-or-later
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+#include "semicall.h"
+
+int main(void)
+{
+    char c;
+
+    printf("Semihosting Console Test\n");
+    printf("hit X to exit:");
+
+    do {
+        c = __semi_call(SYS_READC, 0);
+        printf("got '%c'\n", c);
+    } while (c != 'X');
+
+    return 0;
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 96d2321045a..df3fe8032c3 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -32,4 +32,11 @@ run-plugin-semihosting-with-%:
 		 $(call strip-plugin,$<) 2> $<.err, \
 		"$< on $(TARGET_NAME) with $*")
 
+AARCH64_TESTS += semiconsole
+run-semiconsole: semiconsole
+	$(call skip-test, $<, "MANUAL ONLY")
+
+run-plugin-semiconsole-with-%:
+	$(call skip-test, $<, "MANUAL ONLY")
+
 TESTS += $(AARCH64_TESTS)
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 41aa26f4e17..11c39c601ea 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -49,6 +49,25 @@ run-plugin-semihosting-with-%:
 		 $(call strip-plugin,$<) 2> $<.err, \
 		"$< on $(TARGET_NAME) with $*")
 
+ARM_TESTS += semiconsole semiconsole-arm
+
+semiconsole: CFLAGS += -mthumb
+run-semiconsole: semiconsole
+	$(call skip-test, $<, "MANUAL ONLY")
+
+run-plugin-semiconsole-with-%:
+	$(call skip-test, $<, "MANUAL ONLY")
+
+semiconsole-arm: CFLAGS += -marm
+semiconsole-arm: semiconsole.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+
+run-semiconsole-arm: semiconsole-arm
+	$(call skip-test, $<, "MANUAL ONLY")
+
+run-plugin-semiconsole-arm-with-%:
+	$(call skip-test, $<, "MANUAL ONLY")
+
 TESTS += $(ARM_TESTS)
 
 # On ARM Linux only supports 4k pages
-- 
2.20.1



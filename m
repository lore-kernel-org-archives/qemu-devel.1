Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9E1C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5462E20692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WC6Pb645"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5462E20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCvf-00036e-B3
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 10:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipCrP-0004nA-Bw
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipCrO-0000v3-3x
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:03:03 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:50651)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipCrN-0000uM-T4
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:03:02 -0500
Received: by mail-wm1-x32d.google.com with SMTP id a5so2843879wmb.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 07:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O+jDkffcXWGWrl2ViCkscRGcA34TMzzu2DuCiFiOkiM=;
 b=WC6Pb645SD32eTokZLUUFYs16cSub/2drjdA+E2dHVPXHCoITQo+4MOI2iIlM9L0yh
 wZTp+GZCuI0QOi8H5O7P66tyCrpGh2C3uSd5wGboDdrnZn7hYE+NZ5IhMM942mEx67a7
 VDJdb1XHwWd2wgHRA4/I62AOEsiyNm/gP2TgKxi7IfoPWdrqdjGgqh2BeRX0Un72EPKF
 6iNQCOLl6djXbA4C1Apv2zWt0xRVNf5gwjGI9ot9zXvGzVW2k50l/LU9nVFwGkq/PytP
 UIYu0SGXryxT5b+3xv/5hYPPLECpv3KQzWubDNxzBcSnJOGdyntAlJhwVlHqk0TXIfZV
 wodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O+jDkffcXWGWrl2ViCkscRGcA34TMzzu2DuCiFiOkiM=;
 b=VWYaapDSRZy/bbFm2WCCL/cNdfZSCS3+IRredNr8wUTbf0fFVYYKfNIn0ZUyNHDhV0
 DBfQayGr07YL33IXYZZRc+o3vScIndHtfmCM0y/vFiBm6Qp6vmceO7uL7RqWyJsoqJtq
 hvSyjmx8UMeO2OFiJ7ByZsSQ1B394VjPz31cG0uV11fqU6XaDgKrEyIbSMNHv5Fn0BCQ
 3rqXvPBs7kVmLnbGBw/tkKCqPD4DaZ9vMso8whbUBZeqwkZXrfHWO1yENQtek2M9WxjU
 lqscRbV29El0ZzrMqrgXbmMgGGaPxjOsX0Sr4Shg+ARqcXSaMJqaWHn2ElsdT2+/WZ+Y
 RSYQ==
X-Gm-Message-State: APjAAAVx5WjLlsTvLM1aK/ep/M1oBA4diyvS1VpUp4VIbSfExQ3peN1F
 Fv2vS6TvhJx0IuobV+sREI58Mw==
X-Google-Smtp-Source: APXvYqyrOjzFqVs9HXdTkjmY5ZCQNJebEOqxQ1qsQZruXODVEdPuukZHmOIrYKffjMS5i1ZuJnzyDA==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr4474756wmi.0.1578495780862;
 Wed, 08 Jan 2020 07:03:00 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 5sm4621418wrh.5.2020.01.08.07.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 07:02:57 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 884581FF93;
 Wed,  8 Jan 2020 15:02:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/6] tests/tcg: add user version of dumb-as-bricks
 semiconsole test
Date: Wed,  8 Jan 2020 15:02:52 +0000
Message-Id: <20200108150252.6216-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108150252.6216-1-alex.bennee@linaro.org>
References: <20200108150252.6216-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: Peter Maydell <peter.maydell@linaro.org>, keithp@keithp.com,
 qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are linux-user users of semihosting so we'd better check things
work for them as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - include aarch64 version
v4
  - use common semicall.h, test thumb & arm
---
 tests/tcg/arm/semiconsole.c       | 27 +++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  7 +++++++
 tests/tcg/arm/Makefile.target     | 19 +++++++++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 tests/tcg/arm/semiconsole.c

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
index 96d2321045a..4281c766419 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -32,4 +32,11 @@ run-plugin-semihosting-with-%:
 		 $(call strip-plugin,$<) 2> $<.err, \
 		"$< on $(TARGET_NAME) with $*")
 
+AARCH64_TESTS += semiconsole
+run-semiconsole: semiconsole
+	$(call skip-test, $<, "MANUAL ONLY")
+
+run-semiconsole-with-%:
+	$(call skip-test, $<, "MANUAL ONLY")
+
 TESTS += $(AARCH64_TESTS)
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 41aa26f4e17..a104ca30281 100644
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
+run-semiconsole-with-%:
+	$(call skip-test, $<, "MANUAL ONLY")
+
+semiconsole-arm: CFLAGS += -marm
+semiconsole-arm: semiconsole.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+
+run-semiconsole-arm: semiconsole-arm
+	$(call skip-test, $<, "MANUAL ONLY")
+
+run-semiconsole-arm-with-%:
+	$(call skip-test, $<, "MANUAL ONLY")
+
 TESTS += $(ARM_TESTS)
 
 # On ARM Linux only supports 4k pages
-- 
2.20.1



Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE61C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9850C20678
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="swGWagYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9850C20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCtT-0007B8-V6
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 10:05:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipCrR-0004qG-Ia
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:03:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipCrQ-0000wW-6m
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:03:05 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35862)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipCrQ-0000wA-05
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:03:04 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so2854442wma.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 07:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tWCHuSggB5szQdLA+HidJI7cGodm3lgcmToLZIxmHFk=;
 b=swGWagYMry1Jdy12VPJ1h2eLBouDR70SwNzTte+TF26FtU5WCEIaxEnS2dq2yBzpld
 jdv5P0tQHPfjxi9PVkobAPNRaMuDlImo2BsUX4/wWBd/4gViCm6pNSnNQEPSEv7hqpSb
 Y4IAWZmuDc8MO+K3AWf7atsTgzk/E55gTqzBXaGAbaGcgwPRrCsr5q2ccWIu3cJTNb7t
 ZaChmjWwCDt+OHAs2kWrW1j3O1V23KvSLeoJDiGqV2334It23SaPP9CQkvM6yedP/vcy
 QIQextG/jzqUnqprCFLQM9nElqYWNAxS2YleMCxyTA+XjD22Q97pRl97RJ4TkHjrpA8r
 XhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tWCHuSggB5szQdLA+HidJI7cGodm3lgcmToLZIxmHFk=;
 b=oESQjMw5cVDOwOYC3ivAKk3ex7qoeMaqtKaxinXfDugGmJPCaSV2jyxSvc2ccT97eJ
 RMPW5Kp5SuTzsjyMfsfTX2EqD+XcP3GBl732dMqDfU8O/6aQ3MiaQ83tjwfpj7wSmRc+
 WKQSa7eO7eDnSLe1ystBJcbQwz9qNZvvxMWe5OM0Ot21tR/FzMROjCoBvRKTEzkhGM6d
 tJ3d1zYeT4T/xRfJLdivp441DWBCm6d1yHDfZ2vI0uTp2uEdCJaiD9j7f2YoEg5WydQ6
 KQIo9w66opIYnZ+95FJnQ3aFd73jXdX9jHuojX08vzN/ETfWv0Jze0i0fDcfRp0yeFER
 /2WA==
X-Gm-Message-State: APjAAAWi76D/c4tG4OjQ3LzVmMqrU3TU6sTIUTaWY96blpxzhI5THsAp
 cCe4upHjpS/LDG512sBVYPYYeQ==
X-Google-Smtp-Source: APXvYqz78JEN1/xD/Vaisyak2INRO53JvRa3CY0pP177yI4npGLT+ZuJ3QPBEpAR+ONW7yWof/2swQ==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr4323837wmj.117.1578495782807; 
 Wed, 08 Jan 2020 07:03:02 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z21sm3922551wml.5.2020.01.08.07.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 07:02:57 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 58E2E1FF91;
 Wed,  8 Jan 2020 15:02:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/6] tests/tcg: add a dumb-as-bricks semihosting console
 test
Date: Wed,  8 Jan 2020 15:02:50 +0000
Message-Id: <20200108150252.6216-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108150252.6216-1-alex.bennee@linaro.org>
References: <20200108150252.6216-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Richard Henderson <richard.henderson@linaro.org>, keithp@keithp.com,
 qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't run this during check-tcg as we would need to check stuff is
echoed back. However we can still build the binary so people can test
it manually.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v8
  - actually return the result!
---
 tests/tcg/aarch64/system/semiconsole.c    | 38 +++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.softmmu-target |  9 +++++-
 2 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/system/semiconsole.c

diff --git a/tests/tcg/aarch64/system/semiconsole.c b/tests/tcg/aarch64/system/semiconsole.c
new file mode 100644
index 00000000000..bfe7c9e26b4
--- /dev/null
+++ b/tests/tcg/aarch64/system/semiconsole.c
@@ -0,0 +1,38 @@
+/*
+ * Semihosting Console Test
+ *
+ * Copyright (c) 2019 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <inttypes.h>
+#include <minilib.h>
+
+#define SYS_READC 0x7
+
+uintptr_t __semi_call(uintptr_t type, uintptr_t arg0)
+{
+    register uintptr_t t asm("x0") = type;
+    register uintptr_t a0 asm("x1") = arg0;
+    asm("hlt 0xf000"
+        : "=r" (t)
+        : "r" (t), "r" (a0));
+
+    return t;
+}
+
+int main(void)
+{
+    char c;
+
+    ml_printf("Semihosting Console Test\n");
+    ml_printf("hit X to exit:");
+
+    do {
+        c = __semi_call(SYS_READC, 0);
+        __sys_outc(c);
+    } while (c != 'X');
+
+    return 0;
+}
diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 950dbb4bac2..9bdcfd9e7e4 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -31,7 +31,14 @@ LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 memory: CFLAGS+=-DCHECK_UNALIGNED=1
 
 # Running
-QEMU_OPTS+=-M virt -cpu max -display none -semihosting-config enable=on,target=native,chardev=output -kernel
+QEMU_BASE_MACHINE=-M virt -cpu max -display none
+QEMU_OPTS+=$(QEMU_BASE_MACHINE) -semihosting-config enable=on,target=native,chardev=output -kernel
+
+# console test is manual only
+QEMU_SEMIHOST=-chardev stdio,mux=on,id=stdio0 -semihosting-config enable=on,chardev=stdio0 -mon chardev=stdio0,mode=readline
+run-semiconsole: QEMU_OPTS=$(QEMU_BASE_MACHINE) $(QEMU_SEMIHOST)  -kernel
+run-semiconsole: semiconsole
+	$(call skip-test, $<, "MANUAL ONLY")
 
 # Simple Record/Replay Test
 .PHONY: memory-record
-- 
2.20.1



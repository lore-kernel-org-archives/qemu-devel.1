Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A53C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E41720693
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dDRaEnPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E41720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8nPc-00031b-Aa
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8nLZ-0007iX-Pi
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8nLY-0000MB-Cn
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:18:53 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:46746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8nLY-0000LO-5a
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:18:52 -0400
Received: by mail-wr1-x42e.google.com with SMTP id o18so1267440wrv.13
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 08:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oUGBFAHXbEtLB6rKz0bX2N4c3TgTMSpFBwXxOPwbThM=;
 b=dDRaEnPgqbmDrdt7FbnpQcCI9+WKLDBCb7Gh9JurDGqmrK7pJ9UD9PB+GiY/oyO23j
 fjxhqYoRXUa3tO0CYEa/Bz4mAuX2Z63blTQU6fyOgNC+dyY4pCI7Gz6YKP3qyNAZx/tJ
 oVJ7lqhqYBa5XAoi/2EgX7+/FcgoA+ZW0atZcMYzqtCj2uyhNE7JHAN14ccF0+h9FOi6
 4tbic3OpnOOZsrbGiesT0/+ztpyrA7B4B2Zd4Og3BoRJgPu6aIElWmUFykaNdO0cfism
 esKqUkGpbjLV5DkS5H7NuS35GKiKL0AxOamhT4JHIVbiqarqA+QTcaotvMXTdYoxyvw4
 sz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oUGBFAHXbEtLB6rKz0bX2N4c3TgTMSpFBwXxOPwbThM=;
 b=npylfsmo4Is2f//nt/pC9HBbdMH5+hFJlCLSKeVA5fQbGoo5cPHQXNjIAOt91XbJK8
 cXRJ21W4Yn+uRxJnqVk+mcTuUXEh6Ne5HnucntZULVzHGG+IeIYVieCG/K7WmG4+f8Vr
 +d/JHNdPji647z2JuWjW+zPevXxS5OyxPGndqkAsugEpWH2PDmSng+8xUh7G4s4u4TCH
 8Fp6YSWMmlH4rpbVCdXFrcbPqc6XKYOG3V2YyyUgWTIrQsgX2mNgoVn/i/NcUmnU/6zE
 z91swNrLtmVGUsOj/5gCg/jyPA1AwBsQsCdLVqhEOg82EKQP5XQ2owcGmK0RaIkf0BKL
 n5Ig==
X-Gm-Message-State: APjAAAUpzc60OXZekUDaYiQnBRGb5Aqb1WmNNbs5T+kdaU/NztLZ2xpW
 b0fNue8SnHYsMkLQRzG0SasbkQ==
X-Google-Smtp-Source: APXvYqx4MnzRpeuPlR/9YnDCpz0suKthBB7vhm5lYjuHTMrPXa738rHNg5CkwuhTyb3GUyZaEXdAQA==
X-Received: by 2002:adf:de0d:: with SMTP id b13mr10723070wrm.140.1568387930984; 
 Fri, 13 Sep 2019 08:18:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m2sm1504574wmi.30.2019.09.13.08.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 08:18:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0017C1FF93;
 Fri, 13 Sep 2019 16:18:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri, 13 Sep 2019 16:18:45 +0100
Message-Id: <20190913151845.12582-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913151845.12582-1-alex.bennee@linaro.org>
References: <20190913151845.12582-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
Subject: [Qemu-devel] [PATCH v6 6/6] tests/tcg: add linux-user semihosting
 smoke test for ARM
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already use semihosting for the system stuff so this is a simple
smoke test to ensure we are working OK on linux-user.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/Makefile.target |  5 ++++
 tests/tcg/arm/Makefile.target     |  5 ++++
 tests/tcg/arm/semihosting.c       | 45 +++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 tests/tcg/arm/semihosting.c

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 9758f89f905..509f1afa93d 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -21,4 +21,9 @@ run-fcvt: fcvt
 AARCH64_TESTS += pauth-1 pauth-2
 run-pauth-%: QEMU_OPTS += -cpu max
 
+# Semihosting smoke test for linux-user
+AARCH64_TESTS += semihosting
+run-semihosting: semihosting
+	$(call run-test,$<,$(QEMU) $< 2> $<.err, "$< on $(TARGET_NAME)")
+
 TESTS += $(AARCH64_TESTS)
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 7347d3d0adb..3b7fc9a64be 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -27,6 +27,11 @@ run-fcvt: fcvt
 	$(call run-test,fcvt,$(QEMU) $<,"$< on $(TARGET_NAME)")
 	$(call diff-out,fcvt,$(ARM_SRC)/fcvt.ref)
 
+# Semihosting smoke test for linux-user
+ARM_TESTS += semihosting
+run-semihosting: semihosting
+	$(call run-test,$<,$(QEMU) $< 2> $<.err, "$< on $(TARGET_NAME)")
+
 TESTS += $(ARM_TESTS)
 
 # On ARM Linux only supports 4k pages
diff --git a/tests/tcg/arm/semihosting.c b/tests/tcg/arm/semihosting.c
new file mode 100644
index 00000000000..09c89cb481a
--- /dev/null
+++ b/tests/tcg/arm/semihosting.c
@@ -0,0 +1,45 @@
+/*
+ * linux-user semihosting checks
+ *
+ * Copyright (c) 2019
+ * Written by Alex Bennée <alex.bennee@linaro.org>
+ *
+ * SPDX-License-Identifier: GPL-3.0-or-later
+ */
+
+#include <stdint.h>
+
+#define SYS_WRITE0      0x04
+#define SYS_REPORTEXC   0x18
+
+void __semi_call(uintptr_t type, uintptr_t arg0)
+{
+#if defined(__arm__)
+    register uintptr_t t asm("r0") = type;
+    register uintptr_t a0 asm("r1") = arg0;
+    asm("svc 0xab"
+        : /* no return */
+        : "r" (t), "r" (a0));
+#else
+    register uintptr_t t asm("x0") = type;
+    register uintptr_t a0 asm("x1") = arg0;
+    asm("hlt 0xf000"
+        : /* no return */
+        : "r" (t), "r" (a0));
+#endif
+}
+
+int main(int argc, char *argv[argc])
+{
+#if defined(__arm__)
+    uintptr_t exit_code = 0x20026;
+#else
+    uintptr_t exit_block[2] = {0x20026, 0};
+    uintptr_t exit_code = (uintptr_t) &exit_block;
+#endif
+
+    __semi_call(SYS_WRITE0, (uintptr_t) "Hello World");
+    __semi_call(SYS_REPORTEXC, exit_code);
+    /* if we get here we failed */
+    return -1;
+}
-- 
2.20.1



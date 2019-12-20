Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B683FC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8231D206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V3ktwIJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8231D206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiIMA-0000B8-DQ
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:30:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiIF7-0007Wz-2w
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:22:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiIF5-0005dH-Hx
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:22:56 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46275)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiIF5-0005Yf-58
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:22:55 -0500
Received: by mail-wr1-x442.google.com with SMTP id z7so9361041wrl.13
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 05:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tWCHuSggB5szQdLA+HidJI7cGodm3lgcmToLZIxmHFk=;
 b=V3ktwIJCtO2n9oJK7KwaYijwukdLxDfE24R88UvTsU3NDWkbMn/So8kJg0gq3Q0fMD
 /QN4lV9GaKWwd5Z8h5qR3gZ2Qr8xGQVDHRXIMKbomug9YfrwqP+YVy8a1O3plJYTTxZL
 9PPf3cfWhxH2VLSq6g171VNZSK7ZzXSD5CNvM60CN4vVc05sLiHgrT7j9ri7GKklgY0p
 xM4p51wo1VwTpLKxluqGfIrPcVbTYLWuwFjnV2RiOf5ZX+0EFSl/lSfKRKIEHdFpfzso
 B0rPP95jSvsZDi22kfoQdTXjmEU4K7Fq3uKsMG3F+TVvx4ZwtQoWfPLRg+G4b/6a15JF
 Obaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tWCHuSggB5szQdLA+HidJI7cGodm3lgcmToLZIxmHFk=;
 b=m9sApvWawVKWCo0taqzbW3ceiYBinSZ/Sg0W8++OKj6CyyoJKc28ujagxwybKWGXav
 wC8YvJmqRWo8gSqC3Tv9GtucKpoENBJ1vY8HMc+U3sl9MQVvKUX6eeIz4XfZ/Mu3JJTK
 2Kdn4ipCVszW92pNpBdZ7lzhpabmsxjeO7PgYHDjDsNwUstz/ACACFmz4zltfYo+aN7R
 0r05zS7wp4ZqZM9mqQ1m7HngftfGT58u2HLIMwzao0T+nF7Vn5aIHtpe7Y/oHpmS+Jy+
 OGpYMqBy6U37mS4nx2hfK8DEqI1B/isPunuJbz+t4EU3z88etpjGsIs9Ubp7CICTQ+W7
 659Q==
X-Gm-Message-State: APjAAAUq5BxAYcVVmoHKha0bcxyjzbd/9rZFVqXMKxE4zSmy8bqh6LtP
 UD6RBr2q9Kl9fCAlb1n7nDxVwQ==
X-Google-Smtp-Source: APXvYqxUKjMRQFj6C9Oe7b6xQzSLyDeyPE3MHbkZsmx/Km5T19B17j9M9tRSMYwDSYGXH68I2gMXbg==
X-Received: by 2002:a5d:5091:: with SMTP id a17mr15166170wrt.362.1576848173831; 
 Fri, 20 Dec 2019 05:22:53 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n16sm9986070wro.88.2019.12.20.05.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 05:22:47 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0C7811FF91;
 Fri, 20 Dec 2019 13:22:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] tests/tcg: add a dumb-as-bricks semihosting console
 test
Date: Fri, 20 Dec 2019 13:22:45 +0000
Message-Id: <20191220132246.6759-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220132246.6759-1-alex.bennee@linaro.org>
References: <20191220132246.6759-1-alex.bennee@linaro.org>
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
Cc: Richard Henderson <richard.henderson@linaro.org>, keithp@keithp.com,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
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



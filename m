Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9B6C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC56D20673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhPiecig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC56D20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipYoH-0007Ur-Qa
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 09:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYn1-0006AC-RY
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:28:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYn0-0000bs-Dq
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:27:59 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51316)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipYn0-0000VT-6F
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:27:58 -0500
Received: by mail-wm1-x342.google.com with SMTP id d73so3145329wmd.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 06:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NV2VUwrrmQ2uGetdZViLV5rTXAKkK45XpFI605l5Fz8=;
 b=FhPiecigUNAOdk5ugdvMpRywP1jqVNWtTNNAYCyEvNzuYRtdY3Ym3/xizqpwHI6gDG
 nGVA11QTDV5Jyig4D3GSIYrMJzJT7h34KT1AjiXcBKr+swq3p5QnJMOlLSgwYORTh+FW
 my+pM6JOOZnKRkLjamOCkKD08ZeFwQjGnAllBjtGa/ASC6sT+9Q0mC8LEmDmFiRrYmH8
 ZphcLGHFLQqnN0oeZQVsTsYWwqIbT0n1lvEnWdwPzcwhY4YVdx+aDqDF6V1Ih0EVXjae
 Jhaffr/xrSvfAiXmNlUH4xbr/6XjYF5ZKBzjQPpcBjKx0WwW3sfdtQe6vqqfSUy6nr4w
 qtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NV2VUwrrmQ2uGetdZViLV5rTXAKkK45XpFI605l5Fz8=;
 b=TOWbFltHOaVuisIu1Mt/KMGmW2T+hOq0F3VOt/VGiYPJgfZVMsNKTr8E+xTAcPtBrK
 0tNzj4WfYbFzFoLFqluwOADnerc9BOnqvrO5Is8AWabmfh/PKCqO5jYvAsvD/cwi+6ll
 NM4/Ginmow406idxwoG8Z3M44zQ7xatj6/8gpdCvbq8FM2fdp06C/DoOZgyE2UtZ7tZJ
 KASIuaoh9oCuFTg5Xh08vTWefAfccfHF0eNecQ7HfpuKQMrrYzg/4ZaY7v3z/HcyXe3F
 ye286yWR64hbBNF79qYCCd+xRcE9QVtOXcwz3facxJ9q2cOOrpuTwAx366h33t482fQa
 KZ+A==
X-Gm-Message-State: APjAAAX6LeVZZ0C/oOnIaJJYsa6xw25P+bVJnZA2ipFxzNojjEoQu8QA
 z4kcFgRwUHeUu+kER1UtKC46Gg==
X-Google-Smtp-Source: APXvYqw0/t1ZtUN7fBTY+z4YemVo0YzmtsDq2SJ3FyIazrPflN8BhRvYhOd+wUpIvymDcGArGw7lIA==
X-Received: by 2002:a7b:c407:: with SMTP id k7mr5428321wmi.46.1578580076788;
 Thu, 09 Jan 2020 06:27:56 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i5sm3095532wml.31.2020.01.09.06.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 06:27:55 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 14A451FF9C;
 Thu,  9 Jan 2020 14:19:00 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 12/14] tests/tcg: add a dumb-as-bricks semihosting console
 test
Date: Thu,  9 Jan 2020 14:18:56 +0000
Message-Id: <20200109141858.14376-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109141858.14376-1-alex.bennee@linaro.org>
References: <20200109141858.14376-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

We don't run this during check-tcg as we would need to check stuff is
echoed back. However we can still build the binary so people can test
it manually.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

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
index 950dbb4bac2..7b4eede3f07 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -31,7 +31,16 @@ LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
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
+run-plugin-semiconsole-with-%: semiconsole
+	$(call skip-test, $<, "MANUAL ONLY")
 
 # Simple Record/Replay Test
 .PHONY: memory-record
-- 
2.20.1



Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD95C33CA1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F135C20673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VlggaQ7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F135C20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipYll-0003LM-P6
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 09:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYed-0001HL-GW
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYec-0006fJ-0p
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:19 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:45061)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipYeb-0006a0-MQ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:17 -0500
Received: by mail-wr1-x42f.google.com with SMTP id j42so7509681wrj.12
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 06:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I5Dv8/kwCGKxfL2DONHaGwatmBamOmmlOOpjBdJ4GDk=;
 b=VlggaQ7OvHn05Uy5WgLmwQ5NyxctDPWK1THmluPitpIJ9M/Lllvjaq+ngBiNHpniCJ
 FN09flBpjZ/fn3FaPPofl6r0LImLdGoQIjZYMuZHPYF9z8leRIqW2n44WF/P2qiWCeL2
 dSw0x4v4r1Ax9C/E0W7kZ5mPIBqD0zz8V2BWrqiQ+F3iKmowN050wnC9yYGPH06iqjwv
 9iuZ2fbXk+k3NofIxTsrowSwmcNHsPBdN+VM2y45XUvcw1d+c/7mx58Hhg0Az7OXY4jC
 6xtFdoiOJqQIWeggKOkoXPFL5/GyZ73omsMkJJWpPKpS9Fujvr7QDmEeGK8pPDOtxlyz
 cVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I5Dv8/kwCGKxfL2DONHaGwatmBamOmmlOOpjBdJ4GDk=;
 b=oP4573tLI7e7lB3cg9WIMQkpCRKq/3CGht+uYkjv6Wr0XCujwkUwSenopSxv0uDeda
 /tQFSj50P2Sy8DYA2kmFYcjfN1+3DHkoCIjlCgcrL3V9M1EK+tt2jYUhVknDca+OMSB8
 WZsR3L6bL3IdNrAlOaazObHG6nP8KI8vqMXHNgVV2fTaBE/Mt6KteHXsTKG9ZGo3nDsl
 PtmupRpUVX6/fC30X/glroi86Uisg7ICspL09EGn0jizy4F8jfUZYhe71lNSH+NpcW4R
 fJP18ZULr6dMC9GNlQ0ZbaPEt4E1DXRtFkoHeNzJH0sybq//bWuLrOzeco/pJ1j4i5DN
 sgkA==
X-Gm-Message-State: APjAAAWCPaVdGrlMcjDepE0+WdmE8UDBat9ZRvw2d6L+TX2dZjnOXyNj
 q5z0tvImgoKtY9IFRe7tbXnEEg==
X-Google-Smtp-Source: APXvYqzG9/RYs58qaZu0Ze9aaPiQcrJnSsJlICJHYMzyajIWha8Nt89lFdaYTPPfJDsedn2/v7VW8g==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr11421172wru.220.1578579556594; 
 Thu, 09 Jan 2020 06:19:16 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q15sm8326055wrr.11.2020.01.09.06.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 06:19:08 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2CCA01FF9D;
 Thu,  9 Jan 2020 14:19:00 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 13/14] tests/tcg: extract __semi_call into a header and
 expand
Date: Thu,  9 Jan 2020 14:18:57 +0000
Message-Id: <20200109141858.14376-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109141858.14376-1-alex.bennee@linaro.org>
References: <20200109141858.14376-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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

There are two types of ARM semicall - lets test them both. Putting the
logic in a header will make re-using the functions easier later.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/tests/tcg/arm/semicall.h b/tests/tcg/arm/semicall.h
new file mode 100644
index 00000000000..d4f6818192d
--- /dev/null
+++ b/tests/tcg/arm/semicall.h
@@ -0,0 +1,35 @@
+/*
+ * Semihosting Tests
+ *
+ * Copyright (c) 2019
+ * Written by Alex Bennée <alex.bennee@linaro.org>
+ *
+ * SPDX-License-Identifier: GPL-3.0-or-later
+ */
+
+#define SYS_WRITE0      0x04
+#define SYS_READC       0x07
+#define SYS_REPORTEXC   0x18
+
+uintptr_t __semi_call(uintptr_t type, uintptr_t arg0)
+{
+#if defined(__arm__)
+    register uintptr_t t asm("r0") = type;
+    register uintptr_t a0 asm("r1") = arg0;
+#ifdef __thumb__
+#  define SVC  "svc 0xab"
+#else
+#  define SVC  "svc 0x123456"
+#endif
+    asm(SVC : "=r" (t)
+        : "r" (t), "r" (a0));
+#else
+    register uintptr_t t asm("x0") = type;
+    register uintptr_t a0 asm("x1") = arg0;
+    asm("hlt 0xf000"
+        : "=r" (t)
+        : "r" (t), "r" (a0));
+#endif
+
+    return t;
+}
diff --git a/tests/tcg/arm/semihosting.c b/tests/tcg/arm/semihosting.c
index 09c89cb481a..33faac9916e 100644
--- a/tests/tcg/arm/semihosting.c
+++ b/tests/tcg/arm/semihosting.c
@@ -8,26 +8,7 @@
  */
 
 #include <stdint.h>
-
-#define SYS_WRITE0      0x04
-#define SYS_REPORTEXC   0x18
-
-void __semi_call(uintptr_t type, uintptr_t arg0)
-{
-#if defined(__arm__)
-    register uintptr_t t asm("r0") = type;
-    register uintptr_t a0 asm("r1") = arg0;
-    asm("svc 0xab"
-        : /* no return */
-        : "r" (t), "r" (a0));
-#else
-    register uintptr_t t asm("x0") = type;
-    register uintptr_t a0 asm("x1") = arg0;
-    asm("hlt 0xf000"
-        : /* no return */
-        : "r" (t), "r" (a0));
-#endif
-}
+#include "semicall.h"
 
 int main(int argc, char *argv[argc])
 {
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 0765f37ff04..41aa26f4e17 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -31,9 +31,18 @@ run-fcvt: fcvt
 
 # Semihosting smoke test for linux-user
 ARM_TESTS += semihosting
+semihosting: CFLAGS += -mthumb
 run-semihosting: semihosting
 	$(call run-test,$<,$(QEMU) $< 2> $<.err, "$< on $(TARGET_NAME)")
 
+ARM_TESTS += semihosting-arm
+semihosting-arm: CFLAGS += -marm
+semihosting-arm: semihosting.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+
+run-semihosting-arm: semihosting-arm
+	$(call run-test,$<,$(QEMU) $< 2> $<.err, "$< on $(TARGET_NAME)")
+
 run-plugin-semihosting-with-%:
 	$(call run-test, $@, $(QEMU) $(QEMU_OPTS) \
 		-plugin $(PLUGIN_DIR)/$(call extract-plugin,$@) \
-- 
2.20.1



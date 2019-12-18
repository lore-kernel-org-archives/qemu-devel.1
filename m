Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F7DC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7754A218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t1/rW/JE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7754A218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihdf3-0006aL-To
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 13:03:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihdct-0004t3-RL
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:00:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihdcq-0002cJ-Fn
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:00:46 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46914)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihdck-0002Uz-QH
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:00:38 -0500
Received: by mail-wr1-x443.google.com with SMTP id z7so3243396wrl.13
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 10:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/fziV75QNz3yxBKb+2AS+Ep/ueUtdymBYxSkJU+JtSY=;
 b=t1/rW/JEf3QKkVLVHg/gMsC+Ct+fbSOVTMHB6e3lPTf8+mVzhJNsJicHkXGdsSuXGm
 v2HjumhoPfj+8dgr3Jn5ygkIPsvtEj/VtgMSQ2rMdVXJXF51FwDRkkxJOiDmmuzk/toR
 cwDd33Si5xtF5J1Ss8konCvEY/g6yNuWxOZBHwIB36G3pd242Gis0QblrX4ZIjlyoZPF
 5MNkwic/du7t/sp7sRWnRrIKmkpJ7e+AB4UxPtJkUzorX8/0mWfWSJmiqo/wXDP8VrF4
 q9q3yuWWd+87zXz1GhkNFJoIh2q2RWu6bbWyyWjJr9qcTDS+5VjuC3OeuimccTHKibAl
 Bk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/fziV75QNz3yxBKb+2AS+Ep/ueUtdymBYxSkJU+JtSY=;
 b=YMziV8xLjROqNj3A+7XO7aXoeqieNuCnTEWKmnk4lSH7fPW7nFGphyyriiv9zSsVzU
 rdKssng7lb0ChcDkrjuZfE3DHpUCGjrYCLl8THmBqCV3eDkDqtQPEsj6SQ0raA9SFMVt
 N6ReY9wRYiPxcV/wTvrvS452HO2EEzFygUgMpLzg/KossSj/i40h3wEKHG5d1gIhPQkj
 +fqic3rcemSk3yI27bqxLqMH1joKGxgQorJlf4O1yc+wyFQinfnWN5BIGJGKKyVT/uRw
 q7ikRafJag9eP6woiuyHeKdqwLvrQDEkdILq4KwIeoUV1KqOL1RrRKR7qdiEY2vhO27D
 ISMA==
X-Gm-Message-State: APjAAAVmEWiJO2IMELYm4OHNKCSDH/TDwXZsTaXvJCe3SImcXCWxMSkA
 E8n8+4CiFeIbTVtgHt05cER79w==
X-Google-Smtp-Source: APXvYqxORnpNvCZ1TWKw5pjTA2FxMC7ZCXLs9w3zhiQZoxiNteuM6bF9kbEMVWkL/M3E8N9Y7wF8ag==
X-Received: by 2002:adf:e812:: with SMTP id o18mr4105823wrm.127.1576692036528; 
 Wed, 18 Dec 2019 10:00:36 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q19sm3164111wmc.12.2019.12.18.10.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 10:00:33 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CB2F41FF91;
 Wed, 18 Dec 2019 18:00:30 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 4/4] tests/tcg: add a dumb-as-bricks semihosting console
 test
Date: Wed, 18 Dec 2019 18:00:29 +0000
Message-Id: <20191218180029.6744-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218180029.6744-1-alex.bennee@linaro.org>
References: <20191218180029.6744-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: pbonzini@redhat.com, keithp@keithp.com,
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
---
 tests/tcg/aarch64/system/semiconsole.c    | 36 +++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.softmmu-target |  9 +++++-
 2 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/system/semiconsole.c

diff --git a/tests/tcg/aarch64/system/semiconsole.c b/tests/tcg/aarch64/system/semiconsole.c
new file mode 100644
index 00000000000..636537fbe4b
--- /dev/null
+++ b/tests/tcg/aarch64/system/semiconsole.c
@@ -0,0 +1,36 @@
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



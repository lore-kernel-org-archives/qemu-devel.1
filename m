Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66298C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 16:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C232067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 16:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UU45cmE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C232067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipae3-0004Aq-Av
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 11:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipadC-00033c-NB
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 11:25:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipadB-0007Xa-5R
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 11:25:58 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39066)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipadA-0007QO-TB
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 11:25:57 -0500
Received: by mail-wr1-x444.google.com with SMTP id y11so8049548wrt.6
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 08:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gPs75ugX3MsLL8a+BHErQT13eXuWatfkB6ufWiA3coI=;
 b=UU45cmE6jnLsi8EFBjHz+NWJYVkM6q/jfSahwRS1V69vhTzvYT+XX/LRy7+taVkVj4
 meP8PAjTKk1rVmZwNGh53Hhx0l40axT7TyLCLEa3CuIdw9TMAnJArrhLMzSPF4jHmROD
 q5niJB+2kf4rP9vf+y1vbJaHC7RoNBBeexHdM2psNLFADIksCjEUoYQNRxWSOZVMoG9m
 ChWBsECBJDbKyXkPMx0h0afPBuVrrGk6V2t0LKblmZdusL+NM/17bCnxW3/jyIEEf3mH
 5SdyWvwSipkORytZZbNRrAPm9uALvz1xXAHPhatSO7VRSmZXoT42oiRbQBRAc9zac6HS
 wYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gPs75ugX3MsLL8a+BHErQT13eXuWatfkB6ufWiA3coI=;
 b=VnTpAOKpIuTl8PZolUH/jpNuoQyaFC+ABGgj4iDwbW5KwT5o2zAPAPV3DFA0yjNwFk
 uN3VnLUJFKr6bIBOqsRLORHVMia6JWddqrWe1mCqzMAFTsM8psUV127pamEDU1A/PfzE
 ft6X6rjZVr8Ribll1ZPIBPnLvA3nYQCGmWK7nKGkPVdC9Wm4Qm0pBrANBJruZ45fpDaW
 ym0HOFWCOXBaeTtiPSMwIV6RIPbEx1dXbvYfCXd/Q45YHZwOKKZteUm0U7js+6aGvsTs
 1QpSCGBGc1yHcZ6ekzlPb0tAL+HwV2EBbz4p6q2GAw43BtXsOPfj46kTN3duvyg84H+d
 CLww==
X-Gm-Message-State: APjAAAU44gWJsZhHEHYtkYRs+m4iIfwAGElIMcFM4HcV5BFZ4mezsW1t
 THRW1NI7zj8xb1UiuMyl1aOJIQ==
X-Google-Smtp-Source: APXvYqwZHIWMKpWEaLi+TiMUOZePFbAz+5/K6l0NKgyFh/1/177lxaeNfhPhvyxJ4lfikwWejBfV7g==
X-Received: by 2002:a5d:51c1:: with SMTP id n1mr11623719wrv.335.1578587155421; 
 Thu, 09 Jan 2020 08:25:55 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y7sm4353442wmd.1.2020.01.09.08.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 08:25:54 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 814761FF87;
 Thu,  9 Jan 2020 16:25:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] tests/tcg: add a vtimer test for aarch64
Date: Thu,  9 Jan 2020 16:25:45 +0000
Message-Id: <20200109162545.1970-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157857629827.5165.2496570379985305724.malonedeb@gac.canonical.com>
References: <157857629827.5165.2496570379985305724.malonedeb@gac.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>, 1859021@bugs.launchpad.net,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bug: https://bugs.launchpad.net/bugs/1859021

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/system/vtimer.c         | 48 +++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.softmmu-target |  4 ++
 2 files changed, 52 insertions(+)
 create mode 100644 tests/tcg/aarch64/system/vtimer.c

diff --git a/tests/tcg/aarch64/system/vtimer.c b/tests/tcg/aarch64/system/vtimer.c
new file mode 100644
index 00000000000..42f2f7796c7
--- /dev/null
+++ b/tests/tcg/aarch64/system/vtimer.c
@@ -0,0 +1,48 @@
+/*
+ * Simple Virtual Timer Test
+ *
+ * Copyright (c) 2020 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <inttypes.h>
+#include <minilib.h>
+
+/* grabbed from Linux */
+#define __stringify_1(x...) #x
+#define __stringify(x...)   __stringify_1(x)
+
+#define read_sysreg(r) ({                                           \
+            uint64_t __val;                                         \
+            asm volatile("mrs %0, " __stringify(r) : "=r" (__val)); \
+            __val;                                                  \
+})
+
+#define write_sysreg(r, v) do {                     \
+        uint64_t __val = (uint64_t)(v);             \
+        asm volatile("msr " __stringify(r) ", %x0"  \
+                 : : "rZ" (__val));                 \
+} while (0)
+
+int main(void)
+{
+    int i;
+
+    ml_printf("VTimer Test\n");
+
+    write_sysreg(cntvoff_el2, 1);
+    write_sysreg(cntv_cval_el0, -1);
+    write_sysreg(cntv_ctl_el0, 1);
+
+    ml_printf("cntvoff_el2=%lx\n", read_sysreg(cntvoff_el2));
+    ml_printf("cntv_cval_el0=%lx\n", read_sysreg(cntv_cval_el0));
+    ml_printf("cntv_ctl_el0=%lx\n", read_sysreg(cntv_ctl_el0));
+
+    /* Now read cval a few times */
+    for (i = 0; i < 10; i++) {
+        ml_printf("%d: cntv_cval_el0=%lx\n", i, read_sysreg(cntv_cval_el0));
+    }
+
+    return 0;
+}
diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 7b4eede3f07..62cdddbb215 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -62,3 +62,7 @@ run-memory-replay: memory-replay run-memory-record
 	  "$< on $(TARGET_NAME)")
 
 EXTRA_TESTS+=memory-record memory-replay
+
+# vtimer test
+QEMU_EL2_MACHINE=-machine virt,virtualization=on,gic-version=2 -cpu cortex-a57 -smp 4
+run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_SEMIHOST)  -kernel
-- 
2.20.1



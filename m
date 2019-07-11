Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A8AC74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:58:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0734220872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LDFvgt4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0734220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlZaS-0002k0-Ax
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 09:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52373)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hlZZv-0002Dy-Nr
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hlZZu-00083u-2I
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:57:43 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hlZZt-00082k-Ps
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:57:42 -0400
Received: by mail-wr1-x444.google.com with SMTP id z1so6383250wru.13
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 06:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bi8dU3YswBUNK8hvA2kj9LNKvdDpPRPxbDdjBslW3go=;
 b=LDFvgt4tx4FAeA8cP9ADnZDM+/69MyTtAfg7zcXA/G4uptsUGZnuuJzCRgPZr+iL1V
 dKHB/eGJtzOY4Eg+04x7is7fubq06FjuQmU1aakBdUJ/6y6IwtSbA3Y43ThHjSEZSSzf
 PLee28DRgGDLZN000EK6fAEW/UqixP/jdytPbl0NBc7gipu95KIpg547h43VmPiAk/iZ
 HLbe5JX2ZfB+OloTdxU90A7M3fyafyfrgPZWtq4/U2LWfeuWGSmmb73PV4UBrcbKBEhp
 3KheOMpIOBLpDsWSTd2bFovGkeUj004lVpjzZMXOyBI0h2dKwXxms8pewO67SaKShCsV
 SgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bi8dU3YswBUNK8hvA2kj9LNKvdDpPRPxbDdjBslW3go=;
 b=EqMseWC064HeOtKLrKcwiCq4XUFgMz37XJhNaJeGA2L0kiown9nXRDyI6LT1miVo+5
 f9B/EPyAVAxTnxEsuNOlTXrtBmb/r6eb63oALulN1bP+1YttaAwhkquHzTqPr3FhLAHD
 irW/tK4GU+vrV4O2rY1/Vjs7f8iv4U6daX+8rjKiCgDPu8C8lnoLqGwj9KEzQkXLj+ua
 IT025vZ0CqxoEI+PPRlLF3N1GlmCrtQNqA0w8vAs363vJPddFm7vAZROcmLCYtcj8Z1u
 CwgtvBXxPzEqjh0pcr+UTIfLeAkwImkrJQX9nBSBSTUMt/jyHhDZMeHUOmZHQL/HTBI+
 C9pw==
X-Gm-Message-State: APjAAAWahD+uAFelQDSNMkiP64qg1NvTI/VI4FPku1KDLNAdljd8G07E
 WYcHFXBAUSaf6VCjFeJlkhDpPQ==
X-Google-Smtp-Source: APXvYqzWz+UcO3k/kQ/+uliHeAbxnBZSddTI0So2WVBhlhXXaPUEqzE5dFj6ZDfklEHtfq0UHzlg0w==
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr5502735wrt.227.1562853459907; 
 Thu, 11 Jul 2019 06:57:39 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o20sm12818590wrh.8.2019.07.11.06.57.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 06:57:39 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D2B021FF87;
 Thu, 11 Jul 2019 14:57:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Thu, 11 Jul 2019 14:57:26 +0100
Message-Id: <20190711135726.14191-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH for semihosting-tests] semihosting tests: add
 v7m tests
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

M-profile has yet another way of triggering semihosting calls using
the BKPT instruction. To support this we need to add a M-profile setup
so we use the nice and simple microbit model which has a Cortex-M0 in
it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - add copyright headers
  - better linker script
  - use .type foo, function instead of hacks
v3
  - fix ENTRY(), add comment
---
 Makefile         | 14 ++++++++++++-
 microbit.lds     | 48 ++++++++++++++++++++++++++++++++++++++++++++
 semicall.S       |  8 +++++++-
 start-microbit.S | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 usertest.c       |  4 +++-
 5 files changed, 123 insertions(+), 3 deletions(-)
 create mode 100644 microbit.lds
 create mode 100644 start-microbit.S

diff --git a/Makefile b/Makefile
index 7ad2512..1296fde 100644
--- a/Makefile
+++ b/Makefile
@@ -40,6 +40,7 @@
 
 A32GCC := arm-linux-gnueabihf-gcc -marm
 T32GCC := arm-linux-gnueabihf-gcc -mthumb
+V7MGCC := arm-none-eabi-gcc -mcpu=cortex-m0 -mfloat-abi=soft
 A64GCC := aarch64-linux-gnu-gcc
 
 A32LD := arm-linux-gnueabihf-ld
@@ -47,6 +48,8 @@ A32LD := arm-linux-gnueabihf-ld
 A32LINKOPTS := -nostdlib -lgcc -Xlinker --script=baremetal.lds -Xlinker --build-id=none
 A64LINKOPTS := -nostdlib -lgcc -Xlinker --script=baremetal-a64.lds -Xlinker --build-id=none
 
+AV7MLINKOPTS := -nostdlib -lgcc -Xlinker --script=microbit.lds -Xlinker --build-id=none
+
 QEMU_BUILDDIR := ~/linaro/qemu-from-laptop/qemu/build/x86
 
 ifdef GDBPORT
@@ -62,11 +65,13 @@ QEMU_SYSTEM_AARCH64 = $(QEMU_BUILDDIR)/aarch64-softmmu/qemu-system-aarch64 $(SYS
 all: usertest-a32 usertest-a64 usertest-t32 \
 	systest-a32.axf systest-t32.axf \
 	systest-a32-hlt.axf systest-t32-hlt.axf \
+	systest-t32-bkpt.axf \
 	systest-a64.axf
 
 usertest-srcs = usertest.c semihosting.c semicall.S printf/printf.c
 
 systest-srcs = start.S string.c $(usertest-srcs)
+microbit-systest-srcs = microbit.lds start-microbit.S string.c $(usertest-srcs)
 
 usertest-a32: $(usertest-srcs)
 	$(A32GCC) --static -o $@ $^
@@ -95,6 +100,9 @@ systest-a32-hlt.axf: $(systest-srcs)
 systest-t32-hlt.axf: $(systest-srcs)
 	$(T32GCC) -DUSE_HLT -o $@ $^ $(A32LINKOPTS)
 
+systest-t32-bkpt.axf: $(microbit-systest-srcs)
+	$(V7MGCC) -DUSE_BKPT -o $@ $^ $(AV7MLINKOPTS)
+
 systest-a64.axf: $(systest-srcs)
 	$(A64GCC) -nostdlib -o $@ $^ $(A64LINKOPTS)
 
@@ -125,6 +133,9 @@ run-systest-a32-hlt: systest-a32-hlt.axf
 run-systest-t32-hlt: systest-t32-hlt.axf
 	$(QEMU_SYSTEM_ARM) -M virt --display none --semihosting -kernel $^
 
+run-systest-t32-bkpt: systest-t32-bkpt.axf
+	$(QEMU_SYSTEM_ARM) -M microbit --display none --semihosting -kernel $^
+
 run-systest-a64: systest-a64.axf
 	$(QEMU_SYSTEM_AARCH64) -M virt --display none --semihosting \
 		-cpu cortex-a57 -kernel $^
@@ -132,4 +143,5 @@ run-systest-a64: systest-a64.axf
 run: run-usertest-a32 run-usertest-t32 run-usertest-a64 \
 	run-systest-a32 run-systest-t32 run-systest-a64 \
 	run-usertest-a32-hlt run-usertest-t32-hlt \
-	run-systest-a32-hlt run-systest-t32-hlt
+	run-systest-a32-hlt run-systest-t32-hlt \
+	run-systest-t32-bkpt
diff --git a/microbit.lds b/microbit.lds
new file mode 100644
index 0000000..7ce43e2
--- /dev/null
+++ b/microbit.lds
@@ -0,0 +1,48 @@
+/*
+ * microbit.lds : simple linker script for baremetal ARM-M test cases
+ *
+ * Copyright (C) 2019 Linaro Limited. All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ * 3. Neither the name of Linaro Limited nor the names of its
+ *    contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Memory layout is for the BBC Microbit board which puts RAM at 0x20000000
+ */
+
+RAMSTART = 0x20000000;
+/* 2kb stack, from the top of RAM */
+STACKBOT = 0x20003800;
+STACKTOP = 0x20004000;
+
+/* QEMU ignores this in favour of vector_table anyway */
+ENTRY(reset_thumb)
+
+SECTIONS
+{
+    . = 0x0;
+    .text : {
+        *(.text)
+    }
+    . = RAMSTART;
+    .data : {
+        *(.data)
+    }
+    .bss : {
+        *(.bss)
+    }
+    /* linker should complain if data+bss run into this */
+    . = STACKBOT;
+    /DISCARD/ : {
+        *(.ARM.attributes)
+    }
+}
diff --git a/semicall.S b/semicall.S
index 1418a42..6213cea 100644
--- a/semicall.S
+++ b/semicall.S
@@ -29,6 +29,7 @@
 #endif
 
         .globl __semi_call
+        .type __semi_call, function
 __semi_call:
 #if defined(__aarch64__)
         hlt 0xf000
@@ -51,8 +52,13 @@ __semi_call:
 #else
         /* traditional svc */
 #if defined(__thumb__)
-        /* NB: assumes not M-profile (which is BKPT) */
+#if defined(USE_BKPT)
+        /* M-profile T32 */
+        bkpt 0xab
+#else
+        /* A+R Profile T32 */
         svc 0xab
+#endif
 #else
         svc 0x123456
 #endif
diff --git a/start-microbit.S b/start-microbit.S
new file mode 100644
index 0000000..9998bf2
--- /dev/null
+++ b/start-microbit.S
@@ -0,0 +1,52 @@
+/*
+ * start-microbit.S - assembly code for startup on baremetal M-profile tests
+ *
+ * Copyright (c) 2015 Linaro Limited
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ * 3. Neither the name of Linaro Limited nor the names of its
+ *    contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ */
+
+        .syntax unified
+        .cpu cortex-m0
+        .thumb
+
+        .text
+
+vector_table:
+        .word STACKTOP          /* 0. SP_main */
+        .word reset_thumb       /* 1. Reset */
+        .word 0                 /* 2. NMI */
+        .word 0                 /* 3. HardFault */
+        .rept 7
+        .word 0                 /* 4-10. Reserved */
+        .endr
+        .word 0                 /* 11. SVCall */
+        .word 0                 /* 12. Reserved */
+        .word 0                 /* 13. Reserved */
+        .word 0                 /* 14. PendSV */
+        .word 0                 /* 15. SysTick */
+        .rept 32
+        .word 0                 /* 16-47. External Interrupts */
+        .endr
+
+        /* declare as a function so pointers are appropriatley "thumbed" */
+        .type reset_thumb, function
+        .global reset_thumb
+reset_thumb:
+
+        bl main
+        bl semi_exit
+        # not reached
+1:      b 1b
diff --git a/usertest.c b/usertest.c
index 16ef0fe..d95cf90 100644
--- a/usertest.c
+++ b/usertest.c
@@ -1,5 +1,7 @@
 /*
- * usertest.c -- top level test file for usermode tests
+ * usertest.c -- top level test file for usermode tests.
+ *
+ * System tests also call this main after start[-microbit].S
  *
  * Copyright (c) 2015 Linaro Limited
  * All rights reserved.
-- 
2.20.1



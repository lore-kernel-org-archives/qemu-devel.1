Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D61C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819A82133D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L98TUzUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819A82133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51502 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbmDi-0006Ba-HF
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 09:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39750)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mrolnik@gmail.com>) id 1hbm5a-0000ke-OI
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1hbm5Z-00072B-8S
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:17:54 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hbm5Y-00070w-Vm
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:17:53 -0400
Received: by mail-wm1-x343.google.com with SMTP id a15so2326434wmj.5
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=y8C9xUiQWgRmNgofcL1xvoEyCtrpUgRP/KveYn3UxVc=;
 b=L98TUzUVyZXRHujTSQd7KhpI+5ALEJiWGd0Pn17Vq7kTrPLn5kN29PVDlC34T+XKZ9
 tiKLFf3eKE54bzgH1v3paFH4miElMZGhD0A/UX6bbv5Dbsp9VvdEf9OBKgbQyOHNviBe
 kOXCYaQXDKF0tBicBlKJBJ9onID7BsX+XnSDHRotFYt/NOZ5WVt0fKmE76Gf8Om8TYEu
 PHqvNfw8SHQirjF2m7/wqBiHpYgDAmKSgoG6jHhdNhX/LXIXyMoTiHPi2DXPtyKVyAYp
 uEiPT1t5kIvpUw9z7BQT9CV2k0+qp8Hf7aYpLDcn/Inn95IqP3iMYORs404/N877hk/j
 GkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=y8C9xUiQWgRmNgofcL1xvoEyCtrpUgRP/KveYn3UxVc=;
 b=GhieaJttp7ri0sRX1pjT86hOKYiyx2rg4Go+d+/SiqEH9ytIAqgVM/wTeU3Z71oVYC
 rnFIuOswUGt7IlTAc0tRs/ft4bNrlj1UBQWhZ+cvM8VFlxzAeJMZmAHL7g7WPFPPPN6Q
 XGZtxJXEBrJEV8sVpZrFLMxyu9GlT7aBAJfkJ+pEJBqC1REoaBHF8v1O9CSld7+dubzf
 0+nt4D0iuSpI4+dJmyJgpzh+w+D6yPy2kBcCWZXq9zpgyWlntkSDirx2s0kVySBbGYlE
 RsIp5q8UD0kKHqBlTtv3XIgMwIyBNdg2f0u7rZ80W+YOlmBHmGJC1LQ+fM5gacuKCXJe
 zCsQ==
X-Gm-Message-State: APjAAAWKYhlu0kmVzyPf2HY8unXZIfd89kK3yUzyfbpqD9cVTusp2bIh
 6a8YXkcbmSV5M72E0U00076ZSrEGfqZi3w==
X-Google-Smtp-Source: APXvYqzmY7oipY4dmwVKE5XMtP1tYPQlUOv0VLswWcaPVW65vqJsslcUR4XLj4nAFnFxC1IQk4sLSQ==
X-Received: by 2002:a7b:cb48:: with SMTP id v8mr7800059wmj.108.1560518270211; 
 Fri, 14 Jun 2019 06:17:50 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-181-22-16.red.bezeqint.net.
 [79.181.22.16])
 by smtp.gmail.com with ESMTPSA id s9sm2217336wmc.11.2019.06.14.06.17.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 06:17:49 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 16:17:24 +0300
Message-Id: <20190614131724.33928-8-mrolnik@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190614131724.33928-1-mrolnik@gmail.com>
References: <20190614131724.33928-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v22 7/7] target/avr: Register AVR support with
 the rest of QEMU, the build system, and the MAINTAINERS file
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, richard.henderson@linaro.org,
 Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sarah Harris <S.E.Harris@kent.ac.uk>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 MAINTAINERS                     |  6 ++++++
 arch_init.c                     |  2 ++
 configure                       |  7 +++++++
 default-configs/avr-softmmu.mak |  5 +++++
 include/disas/dis-asm.h         |  6 ++++++
 include/sysemu/arch_init.h      |  1 +
 qapi/common.json                |  3 ++-
 target/avr/Makefile.objs        | 33 +++++++++++++++++++++++++++++++++
 tests/machine-none-test.c       |  1 +
 9 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 default-configs/avr-softmmu.mak
 create mode 100644 target/avr/Makefile.objs

diff --git a/MAINTAINERS b/MAINTAINERS
index acbad134ec..d85c306a62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -163,6 +163,12 @@ S: Maintained
 F: hw/arm/smmu*
 F: include/hw/arm/smmu*
 
+AVR TCG CPUs
+M: Michael Rolnik <mrolnik@gmail.com>
+S: Maintained
+F: target/avr/
+F: hw/avr/
+
 CRIS TCG CPUs
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
diff --git a/arch_init.c b/arch_init.c
index 74b0708634..413ad7acfd 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -85,6 +85,8 @@ int graphic_depth = 32;
 #define QEMU_ARCH QEMU_ARCH_UNICORE32
 #elif defined(TARGET_XTENSA)
 #define QEMU_ARCH QEMU_ARCH_XTENSA
+#elif defined(TARGET_AVR)
+#define QEMU_ARCH QEMU_ARCH_AVR
 #endif
 
 const uint32_t arch_type = QEMU_ARCH;
diff --git a/configure b/configure
index b091b82cb3..715050a743 100755
--- a/configure
+++ b/configure
@@ -7499,6 +7499,10 @@ case "$target_name" in
     target_compiler=$cross_cc_aarch64
     eval "target_compiler_cflags=\$cross_cc_cflags_${target_name}"
   ;;
+  avr)
+	gdb_xml_files="avr-cpu.xml"
+    target_compiler=$cross_cc_avr
+  ;;
   cris)
     target_compiler=$cross_cc_cris
   ;;
@@ -7776,6 +7780,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
       disas_config "ARM_A64"
     fi
   ;;
+  avr)
+    disas_config "AVR"
+  ;;
   cris)
     disas_config "CRIS"
   ;;
diff --git a/default-configs/avr-softmmu.mak b/default-configs/avr-softmmu.mak
new file mode 100644
index 0000000000..d1e1c28118
--- /dev/null
+++ b/default-configs/avr-softmmu.mak
@@ -0,0 +1,5 @@
+# Default configuration for avr-softmmu
+
+# Boards:
+#
+CONFIG_AVR_SAMPLE=y
diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index e9c7dd8eb4..8bedce17ac 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -211,6 +211,12 @@ enum bfd_architecture
 #define bfd_mach_m32r          0  /* backwards compatibility */
   bfd_arch_mn10200,    /* Matsushita MN10200 */
   bfd_arch_mn10300,    /* Matsushita MN10300 */
+  bfd_arch_avr,       /* Atmel AVR microcontrollers.  */
+#define bfd_mach_avr1          1
+#define bfd_mach_avr2          2
+#define bfd_mach_avr3          3
+#define bfd_mach_avr4          4
+#define bfd_mach_avr5          5
   bfd_arch_cris,       /* Axis CRIS */
 #define bfd_mach_cris_v0_v10   255
 #define bfd_mach_cris_v32      32
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 10cbafe970..aff57bfe61 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -25,6 +25,7 @@ enum {
     QEMU_ARCH_NIOS2 = (1 << 17),
     QEMU_ARCH_HPPA = (1 << 18),
     QEMU_ARCH_RISCV = (1 << 19),
+    QEMU_ARCH_AVR = (1 << 20),
 };
 
 extern const uint32_t arch_type;
diff --git a/qapi/common.json b/qapi/common.json
index 99d313ef3b..53f5018b9c 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -183,11 +183,12 @@
 #        is true even for "qemu-system-x86_64".
 #
 # ppcemb: dropped in 3.1
+# avr: since 4.1
 #
 # Since: 3.0
 ##
 { 'enum' : 'SysEmuTarget',
-  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
+  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386', 'lm32',
              'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
              'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
              'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
diff --git a/target/avr/Makefile.objs b/target/avr/Makefile.objs
new file mode 100644
index 0000000000..1034d87525
--- /dev/null
+++ b/target/avr/Makefile.objs
@@ -0,0 +1,33 @@
+#
+#  QEMU AVR CPU
+#
+#  Copyright (c) 2016 Michael Rolnik
+#
+#  This library is free software; you can redistribute it and/or
+#  modify it under the terms of the GNU Lesser General Public
+#  License as published by the Free Software Foundation; either
+#  version 2.1 of the License, or (at your option) any later version.
+#
+#  This library is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+#  Lesser General Public License for more details.
+#
+#  You should have received a copy of the GNU Lesser General Public
+#  License along with this library; if not, see
+#  <http://www.gnu.org/licenses/lgpl-2.1.html>
+#
+
+DECODETREE = $(SRC_PATH)/scripts/decodetree.py
+decode-y = $(SRC_PATH)/target/avr/insn.decode
+
+target/avr/decode_insn.inc.c: $(decode-y) $(DECODETREE)
+	$(call quiet-command, \
+	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn --insnwidth 16 $<, \
+	  "GEN", $(TARGET_DIR)$@)
+
+target/avr/translate.o: target/avr/decode_insn.inc.c
+
+obj-y += translate.o cpu.o helper.o
+obj-y += gdbstub.o
+obj-$(CONFIG_SOFTMMU) += machine.o
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 4c6d470798..361927bb76 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] = {
     /* tested targets list */
     { "arm", "cortex-a15" },
     { "aarch64", "cortex-a57" },
+    { "avr", "avr6" },
     { "x86_64", "qemu64,apic-id=0" },
     { "i386", "qemu32,apic-id=0" },
     { "alpha", "ev67" },
-- 
2.18.0



Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7971DC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43FEA208E3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlBqZbes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FEA208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgr16-00083m-Au
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 09:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44527)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mrolnik@gmail.com>) id 1hgqMm-0003rk-Tp
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1hgqMh-0005cw-B9
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:52:35 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:41315)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hgqMh-0005Yz-1F
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:52:31 -0400
Received: by mail-wr1-x42d.google.com with SMTP id c2so6168332wrm.8
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 05:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=F1Q9dO1MJtBD4BuOPkl5FyT3pib0cGGJUVpBcSUVYeU=;
 b=nlBqZbesg60lSndbrnmS8BdC9Fcz0dT6NOb+iBsYHn0mPlNsz2EMHtGjjIxaUPj7ba
 skayDNiJYanAa7Bf1z8gRfmvzeKgCOPtv/MzWdN1ItOrCXdOXGLSJ8qJFQh/J4bGuId4
 LE+uxOs6ZgOzzf258JtW+rcwRWTGTpCVwE4267DbpwfHWXy1Ek9fsDEFcSo7/3Bw9sdm
 HouWOd0GfQQyuinbVK3+KjT27D6o4xMQCbutvp9Qvzvj7W3mAI1Djc9ltstyZBAB5bC7
 S/FgDnu2drRtQ/NZ6MPXWgh790w0hdKprHPZC6KUyK2rO8kJvZdSpuX/UkbM+aSF3c6I
 F91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=F1Q9dO1MJtBD4BuOPkl5FyT3pib0cGGJUVpBcSUVYeU=;
 b=rF2WLNb/Hr3ynWmgPAFmWEnl/dh0GfkmsXhsveiRVeo86qOxiAFUvWfOsfUM7GOFGF
 NQZoQgQHprFb7FPG+1m87SI42aMpB40cPTZiA8cBbOVK9ll2/hIdwO56nhp+amhP/K02
 ykKRmbw5AZQ9xV+FM2He06edOpazXd4mwctpXCjZt61RnPIHMRSCPbox9MUyt5anHqQH
 hRMKO1uiMPZ7Fcu/RKBo8vXaZVdmtesEkYMeki3dATsz10EA3jYrUN9SDmEOahbCOB4v
 YQrx6EKlxOOGp6VhgZXjqJG1M9gwKA3sCUeR0N7WC6p5bAOBsnPrbHissPCdIeUpZ6lf
 fhNQ==
X-Gm-Message-State: APjAAAXd+gYT5fxW3SaVfQeO0mwl1qxnjv+6IvIbS/0lGQ/9mwtP77Pz
 VGMzKn6nwhos2V6IydUw49NJM9eaCCyRnA==
X-Google-Smtp-Source: APXvYqxC2rwKa7dlisw9h1FMdc96p9jReVkU1NVZTDAfxfag8JHS55MC12POEUJWegmSObXBCdK1/w==
X-Received: by 2002:a5d:6190:: with SMTP id j16mr7992247wru.49.1561723306628; 
 Fri, 28 Jun 2019 05:01:46 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-182-104-87.red.bezeqint.net.
 [79.182.104.87])
 by smtp.gmail.com with ESMTPSA id v18sm2281229wrd.51.2019.06.28.05.01.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Jun 2019 05:01:46 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 15:01:18 +0300
Message-Id: <20190628120118.78920-8-mrolnik@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190628120118.78920-1-mrolnik@gmail.com>
References: <20190628120118.78920-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
Subject: [Qemu-devel] [PATCH v24 7/7] target/avr: Register AVR support with
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
Cc: imammedo@redhat.com, Sarah Harris <S.E.Harris@kent.ac.uk>,
 richard.henderson@linaro.org, Michael Rolnik <mrolnik@gmail.com>
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
 target/avr/cpu.c                |  5 -----
 tests/machine-none-test.c       |  1 +
 10 files changed, 63 insertions(+), 6 deletions(-)
 create mode 100644 default-configs/avr-softmmu.mak
 create mode 100644 target/avr/Makefile.objs

diff --git a/MAINTAINERS b/MAINTAINERS
index cad58b9487..c2ad82beb9 100644
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
index 99d313ef3b..6866c3e81d 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -183,11 +183,12 @@
 #        is true even for "qemu-system-x86_64".
 #
 # ppcemb: dropped in 3.1
+# avr: added in 4.1
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
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index ac85508156..5b926420ce 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -136,11 +136,6 @@ static void avr_cpu_initfn(Object *obj)
 #endif
 }
 
-static char *avr_cpu_type_name(const char *cpu_model)
-{
-    return g_strdup_printf(AVR_CPU_TYPE_NAME("%s"), cpu_model);
-}
-
 static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 4c6d470798..d0907e6bd4 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] = {
     /* tested targets list */
     { "arm", "cortex-a15" },
     { "aarch64", "cortex-a57" },
+    { "avr", "avr6-avr-cpu" },
     { "x86_64", "qemu64,apic-id=0" },
     { "i386", "qemu32,apic-id=0" },
     { "alpha", "ev67" },
-- 
2.18.0



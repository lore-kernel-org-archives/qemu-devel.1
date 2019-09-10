Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73C1C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D8A22084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ok9sG2dr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8A22084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7lwR-0002vz-1u
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 15:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7lu6-0000yq-5f
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7lu2-0006mV-NT
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:34:17 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40544)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7lu2-0006l8-Fg
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:34:14 -0400
Received: by mail-wr1-x441.google.com with SMTP id w13so21872081wru.7
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 12:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3O9EXRDiG8lwCqPTGZE4nRj1SK0nw1gH8b5voet+7G4=;
 b=ok9sG2drhxGaTcRjHImZarNSTWYdKF6qlsF+2On5RfTVYyIHeDVPWG85Te9b1gxgLU
 SS2X+GjnELhF8uKHt3Mwn+NfaNb9WItgH3zpEfHo+mXkWp52xO33Cu5KKf3c1ly8f2oV
 DWLWdVMX7y3bnsyLUeftLXcFPYFbO5Kduz3//0W/5lexSUziXnSWnHlUoREZeUBvX28u
 LtYQ/BUWgIvPJMJ35nJ7ID4wAuSxygPVnx/0CSXyAfXllU9S0Iq8AkCfyr8d9Q0QukfW
 R/utiGzh6W7uqBU6QkOHEzqd4QZeWF8xQoWhI5lZjn8vfKpd/NxJY74VEXqUGydXIb4V
 7QbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3O9EXRDiG8lwCqPTGZE4nRj1SK0nw1gH8b5voet+7G4=;
 b=UdvRkJ63jn+e/L2SPaXgxzXCFdWxXTlLb+1/1YimUjJQguTUT2whqVk2vRTlSdCX6M
 ra+xMCxOjIk2IF2yKgaVUXgL7OeWo2TVu2IG5F0OhZiPOQ/bnh8Ah/+BxDPpRmt9tksh
 FktvfFRmrUMW4VpHQz8gRIEY5k3OXAtxCHVQ13D0At/+AvscMyQs1b/Xw1aYiAaW6dL4
 26KblyUEdaBZnqqdFdmQfjjvrWKkLgCVQ5ohKPaKgOnelK1gEs6Ww9+MtXknnQ1lIiHN
 0DBtSkkIXzNs4dU3lN0vDOz0RBOUOf+9wzpxZ6e1OCLQNvhTcO/UMoImPSOSmNPsFZ91
 eb+g==
X-Gm-Message-State: APjAAAUIaePi2dDQeM1kL1jP+ntxRSPFoNIuPW9rl1RS5UBINOJ/GVbJ
 L6m6SwyFFWf26ApQD5Xc2RvABA==
X-Google-Smtp-Source: APXvYqymAt3lB0DcJAMvyPp9kWz/TrliaKxsGUMQsn/8SgqYWnNGDs1F7Kos5USgN1ll6UNhDqKA4g==
X-Received: by 2002:a05:6000:49:: with SMTP id k9mr7739815wrx.21.1568144053125; 
 Tue, 10 Sep 2019 12:34:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b194sm925871wmg.46.2019.09.10.12.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 12:34:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6B4941FF91;
 Tue, 10 Sep 2019 20:34:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 20:34:08 +0100
Message-Id: <20190910193408.28917-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910193408.28917-1-alex.bennee@linaro.org>
References: <20190910193408.28917-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v1 4/4] elf: move ELF_ARCH definition to
 elf-arch.h
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is preparatory for plugins which will want to report the
architecture to plugins. Move the ELF_ARCH definition out of the
loader and into its own header.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 bsd-user/elfload.c     |  13 +----
 include/elf/elf-arch.h | 109 +++++++++++++++++++++++++++++++++++++++++
 linux-user/elfload.c   |  27 ++--------
 3 files changed, 115 insertions(+), 34 deletions(-)
 create mode 100644 include/elf/elf-arch.h

diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 321ee98b86b..adaae0e0dca 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -5,6 +5,7 @@
 #include "qemu.h"
 #include "disas/disas.h"
 #include "qemu/path.h"
+#include "elf/elf-arch.h"
 
 #ifdef _ARCH_PPC64
 #undef ARCH_DLINFO
@@ -12,7 +13,6 @@
 #undef ELF_HWCAP
 #undef ELF_CLASS
 #undef ELF_DATA
-#undef ELF_ARCH
 #endif
 
 /* from personality.h */
@@ -115,7 +115,6 @@ static uint32_t get_elf_hwcap(void)
 
 #define ELF_CLASS      ELFCLASS64
 #define ELF_DATA       ELFDATA2LSB
-#define ELF_ARCH       EM_X86_64
 
 static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
 {
@@ -141,7 +140,6 @@ static inline void init_thread(struct target_pt_regs *regs, struct image_info *i
  */
 #define ELF_CLASS       ELFCLASS32
 #define ELF_DATA        ELFDATA2LSB
-#define ELF_ARCH        EM_386
 
 static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
 {
@@ -176,7 +174,6 @@ static inline void init_thread(struct target_pt_regs *regs, struct image_info *i
 #else
 #define ELF_DATA        ELFDATA2LSB
 #endif
-#define ELF_ARCH        EM_ARM
 
 static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
 {
@@ -231,7 +228,6 @@ enum
 
 #define ELF_CLASS   ELFCLASS64
 #define ELF_DATA    ELFDATA2MSB
-#define ELF_ARCH    EM_SPARCV9
 
 #define STACK_BIAS              2047
 
@@ -265,7 +261,6 @@ static inline void init_thread(struct target_pt_regs *regs, struct image_info *i
 
 #define ELF_CLASS   ELFCLASS32
 #define ELF_DATA    ELFDATA2MSB
-#define ELF_ARCH    EM_SPARC
 
 static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
 {
@@ -302,7 +297,6 @@ static inline void init_thread(struct target_pt_regs *regs, struct image_info *i
 #else
 #define ELF_DATA        ELFDATA2LSB
 #endif
-#define ELF_ARCH        EM_PPC
 
 /*
  * We need to put in some extra aux table entries to tell glibc what
@@ -388,7 +382,6 @@ static inline void init_thread(struct target_pt_regs *_regs, struct image_info *
 #else
 #define ELF_DATA        ELFDATA2LSB
 #endif
-#define ELF_ARCH    EM_MIPS
 
 static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
 {
@@ -410,7 +403,6 @@ static inline void init_thread(struct target_pt_regs *regs, struct image_info *i
 
 #define ELF_CLASS ELFCLASS32
 #define ELF_DATA  ELFDATA2LSB
-#define ELF_ARCH  EM_SH
 
 static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
 {
@@ -432,7 +424,6 @@ static inline void init_thread(struct target_pt_regs *regs, struct image_info *i
 
 #define ELF_CLASS ELFCLASS32
 #define ELF_DATA  ELFDATA2LSB
-#define ELF_ARCH  EM_CRIS
 
 static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
 {
@@ -452,7 +443,6 @@ static inline void init_thread(struct target_pt_regs *regs, struct image_info *i
 
 #define ELF_CLASS       ELFCLASS32
 #define ELF_DATA        ELFDATA2MSB
-#define ELF_ARCH        EM_68K
 
 /* ??? Does this need to do anything?
 #define ELF_PLAT_INIT(_r) */
@@ -477,7 +467,6 @@ static inline void init_thread(struct target_pt_regs *regs, struct image_info *i
 
 #define ELF_CLASS      ELFCLASS64
 #define ELF_DATA       ELFDATA2MSB
-#define ELF_ARCH       EM_ALPHA
 
 static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
 {
diff --git a/include/elf/elf-arch.h b/include/elf/elf-arch.h
new file mode 100644
index 00000000000..9e052543c51
--- /dev/null
+++ b/include/elf/elf-arch.h
@@ -0,0 +1,109 @@
+/*
+ * Elf Architecture Definition
+ *
+ * This is a simple expansion to define common Elf types for the
+ * various machines for the various places it's needed in the source
+ * tree.
+ *
+ * Copyright (c) 2019 Alex Bennée <alex.bennee@linaro.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef _ELF_ARCH_H_
+#define _ELF_ARCH_H_
+
+#include "elf/elf.h"
+
+#ifndef NEED_CPU_H
+#error Needs an target definition
+#endif
+
+#ifdef ELF_ARCH
+#error ELF_ARCH should only be defined once in this file
+#endif
+
+#ifdef TARGET_I386
+#ifdef TARGET_X86_64
+#define ELF_ARCH EM_X86_64
+#else
+#define ELF_ARCH EM_386
+#endif
+#endif
+
+#ifdef TARGET_ARM
+#ifndef TARGET_AARCH64
+#define ELF_ARCH EM_ARM
+#else
+#define ELF_ARCH EM_AARCH64
+#endif
+#endif
+
+#ifdef TARGET_SPARC
+#ifdef TARGET_SPARC64
+#define ELF_ARCH EM_SPARCV9
+#else
+#define ELF_ARCH EM_SPARC
+#endif
+#endif
+
+#ifdef TARGET_PPC
+#define ELF_ARCH EM_PPC
+#endif
+
+#ifdef TARGET_MIPS
+#define ELF_ARCH EM_MIPS
+#endif
+
+#ifdef TARGET_MICROBLAZE
+#define ELF_ARCH EM_MICROBLAZE
+#endif
+
+#ifdef TARGET_NIOS2
+#define ELF_ARCH EM_ALTERA_NIOS2
+#endif
+
+#ifdef TARGET_OPENRISC
+#define ELF_ARCH EM_OPENRISC
+#endif
+
+#ifdef TARGET_SH4
+#define ELF_ARCH EM_SH
+#endif
+
+#ifdef TARGET_CRIS
+#define ELF_ARCH EM_CRIS
+#endif
+
+#ifdef TARGET_M68K
+#define ELF_ARCH EM_68K
+#endif
+
+#ifdef TARGET_ALPHA
+#define ELF_ARCH EM_ALPHA
+#endif
+
+#ifdef TARGET_S390X
+#define ELF_ARCH EM_S390
+#endif
+
+#ifdef TARGET_TILEGX
+#define ELF_ARCH EM_TILEGX
+#endif
+
+#ifdef TARGET_RISCV
+#define ELF_ARCH EM_RISCV
+#endif
+
+#ifdef TARGET_HPPA
+#define ELF_ARCH EM_PARISC
+#endif
+
+#ifdef TARGET_XTENSA
+#define ELF_ARCH EM_XTENSA
+#endif
+
+#endif /* _ELF_ARCH_H_ */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 59a0d21c6f1..3ac7016a7e3 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -8,10 +8,15 @@
 #include "qemu.h"
 #include "disas/disas.h"
 #include "elf/elf.h"
+#include "elf/elf-arch.h"
 #include "qemu/path.h"
 #include "qemu/queue.h"
 #include "qemu/guest-random.h"
 
+#ifndef ELF_ARCH
+#error something got missed
+#endif
+
 #ifdef _ARCH_PPC64
 #undef ARCH_DLINFO
 #undef ELF_PLATFORM
@@ -19,7 +24,6 @@
 #undef ELF_HWCAP2
 #undef ELF_CLASS
 #undef ELF_DATA
-#undef ELF_ARCH
 #endif
 
 #define ELF_OSABI   ELFOSABI_SYSV
@@ -148,7 +152,6 @@ static uint32_t get_elf_hwcap(void)
 #define ELF_START_MMAP 0x2aaaaab000ULL
 
 #define ELF_CLASS      ELFCLASS64
-#define ELF_ARCH       EM_X86_64
 
 static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
 {
@@ -211,7 +214,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
  * These are used to set parameters in the core dumps.
  */
 #define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_386
 
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
@@ -273,7 +275,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
 
 #define ELF_START_MMAP 0x80000000
 
-#define ELF_ARCH        EM_ARM
 #define ELF_CLASS       ELFCLASS32
 
 static inline void init_thread(struct target_pt_regs *regs,
@@ -539,7 +540,6 @@ static const char *get_elf_platform(void)
 /* 64 bit ARM definitions */
 #define ELF_START_MMAP 0x80000000
 
-#define ELF_ARCH        EM_AARCH64
 #define ELF_CLASS       ELFCLASS64
 #ifdef TARGET_WORDS_BIGENDIAN
 # define ELF_PLATFORM    "aarch64_be"
@@ -667,7 +667,6 @@ static uint32_t get_elf_hwcap(void)
 #endif
 
 #define ELF_CLASS   ELFCLASS64
-#define ELF_ARCH    EM_SPARCV9
 
 #define STACK_BIAS              2047
 
@@ -696,7 +695,6 @@ static inline void init_thread(struct target_pt_regs *regs,
                     | HWCAP_SPARC_MULDIV)
 
 #define ELF_CLASS   ELFCLASS32
-#define ELF_ARCH    EM_SPARC
 
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
@@ -728,8 +726,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #endif
 
-#define ELF_ARCH        EM_PPC
-
 /* Feature masks for the Aux Vector Hardware Capabilities (AT_HWCAP).
    See arch/powerpc/include/asm/cputable.h.  */
 enum {
@@ -921,7 +917,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *en
 #else
 #define ELF_CLASS   ELFCLASS32
 #endif
-#define ELF_ARCH    EM_MIPS
 
 #define elf_check_arch(x) ((x) == EM_MIPS || (x) == EM_NANOMIPS)
 
@@ -1014,7 +1009,6 @@ static uint32_t get_elf_hwcap(void)
 #define elf_check_arch(x) ( (x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
 
 #define ELF_CLASS   ELFCLASS32
-#define ELF_ARCH    EM_MICROBLAZE
 
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
@@ -1053,7 +1047,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env
 #define elf_check_arch(x) ((x) == EM_ALTERA_NIOS2)
 
 #define ELF_CLASS   ELFCLASS32
-#define ELF_ARCH    EM_ALTERA_NIOS2
 
 static void init_thread(struct target_pt_regs *regs, struct image_info *infop)
 {
@@ -1107,7 +1100,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 #define ELF_START_MMAP 0x08000000
 
-#define ELF_ARCH EM_OPENRISC
 #define ELF_CLASS ELFCLASS32
 #define ELF_DATA  ELFDATA2MSB
 
@@ -1146,7 +1138,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define ELF_START_MMAP 0x80000000
 
 #define ELF_CLASS ELFCLASS32
-#define ELF_ARCH  EM_SH
 
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
@@ -1228,7 +1219,6 @@ static uint32_t get_elf_hwcap(void)
 #define ELF_START_MMAP 0x80000000
 
 #define ELF_CLASS ELFCLASS32
-#define ELF_ARCH  EM_CRIS
 
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
@@ -1245,7 +1235,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 #define ELF_START_MMAP 0x80000000
 
 #define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_68K
 
 /* ??? Does this need to do anything?
    #define ELF_PLAT_INIT(_r) */
@@ -1296,7 +1285,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUM68KState *e
 #define ELF_START_MMAP (0x30000000000ULL)
 
 #define ELF_CLASS      ELFCLASS64
-#define ELF_ARCH       EM_ALPHA
 
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
@@ -1316,7 +1304,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #define ELF_CLASS	ELFCLASS64
 #define ELF_DATA	ELFDATA2MSB
-#define ELF_ARCH	EM_S390
 
 #define ELF_HWCAP get_elf_hwcap()
 
@@ -1362,7 +1349,6 @@ static inline void init_thread(struct target_pt_regs *regs, struct image_info *i
 
 #define ELF_CLASS   ELFCLASS64
 #define ELF_DATA    ELFDATA2LSB
-#define ELF_ARCH    EM_TILEGX
 
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
@@ -1379,7 +1365,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 #ifdef TARGET_RISCV
 
 #define ELF_START_MMAP 0x80000000
-#define ELF_ARCH  EM_RISCV
 
 #ifdef TARGET_RISCV32
 #define ELF_CLASS ELFCLASS32
@@ -1402,7 +1387,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 #define ELF_START_MMAP  0x80000000
 #define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_PARISC
 #define ELF_PLATFORM    "PARISC"
 #define STACK_GROWS_DOWN 0
 #define STACK_ALIGNMENT  64
@@ -1427,7 +1411,6 @@ static inline void init_thread(struct target_pt_regs *regs,
 #define ELF_START_MMAP 0x20000000
 
 #define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_XTENSA
 
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
-- 
2.20.1



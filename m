Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F85C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C76F21019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zOBIaOPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C76F21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33078 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTky0-0007jk-Gb
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:28:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkuy-0005SJ-4W
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkut-0000zC-Dx
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:47 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTkuo-0000r6-0t
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:41 -0400
Received: by mail-wr1-x442.google.com with SMTP id t7so5339817wrr.10
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=iuJju+zdPT7iceeAnurMB98v66ii11jMwZw4RWJ0mLs=;
	b=zOBIaOPCAtci9VUXZuZmO52h461g4aeHlo5uME49gsa8cZzWgkeWajAxvkuVPrLD1J
	H/UeAX9l0UoOhilm6Mc4AZAlpFf1rC7slgwOCaHw62OzT1tM6Dyn5pXKuXAHK7SoV0pD
	p/szUnm1kPgJxUBFnfUnfrZVEcAj0VmGizMSwRjNoLrWw5y7zjhhM9JXCrAuSoB/8Vg8
	bLRLm2ZzFYzER4LJR82VqVZ689T+4uUpQ1+sN4Pgj6Fg6/eZ/8b5mdGYcjRvuOYzPisi
	v/xqYakEl3NlftvuH96E3Vv98B3Gz9JsbPg8S5RmK/NwYzGbLLpSSpI/44msa66ShBKj
	LYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=iuJju+zdPT7iceeAnurMB98v66ii11jMwZw4RWJ0mLs=;
	b=fv2rmt5aFNKDFEu4xWZsDAScGHD/vpMM7s87+MuvbzEWRX3WHKRl5qotJACw5HWwvF
	FsWBl4sBqGl62jBsPdCxP8zGrecvgztVLoTmxD+m8DGt1dRfMik4Kl49BGbpDgeejBAM
	fICflbOYHgoh3JqCDo30fwFR5OxyQEnfJk3vniYXFJSG03puAMGjlBDv0jVUAafOUdIf
	v0s99JqGQS9MWuodu4L4tOx3EaYXgD/gqIf7JRXOodkWq8S3z1aqCjkr+7i2kzrw63aI
	U3rt6GsmWCYkxF16p1orWkTa6sH+jX8HCW9obzdIqvXF/X71C31627sURvk1vni4rE7n
	DHVA==
X-Gm-Message-State: APjAAAXLi8QIEfxUbcPQesabbqVE70kNWfsKwVDoO5Xojug2ZTtPWR4y
	SfbEORI/JYwa5v+iM4+sC3zsjw==
X-Google-Smtp-Source: APXvYqwBArJPpQasGae5ROy+ktYjk32aet5aRMWjzlxHv1KOTLd6VP7flPLBUjkUbkDC1N+ExSY2jQ==
X-Received: by 2002:adf:eb02:: with SMTP id s2mr53026004wrn.29.1558607133794; 
	Thu, 23 May 2019 03:25:33 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	q11sm11417258wmc.15.2019.05.23.03.25.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:25:33 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 741F01FF8C;
	Thu, 23 May 2019 11:25:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:25:05 +0100
Message-Id: <20190523102532.10486-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102532.10486-1-alex.bennee@linaro.org>
References: <20190523102532.10486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v2 01/28] semihosting: move semihosting
 configuration into its own directory
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Walle <michael@walle.cc>, qemu-arm@nongnu.org,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In preparation for having some more common semihosting code let's
excise the current config magic from vl.c into its own file. We shall
later add more conditionals to the build configurations so we can
avoid building this if we don't need it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 gdbstub.c                                   |   2 +-
 hw/Makefile.objs                            |   1 +
 hw/mips/mips_malta.c                        |   2 +-
 hw/semihosting/Makefile.objs                |   1 +
 hw/semihosting/config.c                     | 160 ++++++++++++++++++++
 include/{exec => hw/semihosting}/semihost.h |  10 +-
 include/sysemu/sysemu.h                     |   1 +
 target/arm/arm-semi.c                       |   2 +-
 target/arm/helper.c                         |   2 +-
 target/arm/translate-a64.c                  |   2 +-
 target/arm/translate.c                      |   2 +-
 target/lm32/helper.c                        |   2 +-
 target/m68k/op_helper.c                     |   2 +-
 target/mips/mips-semi.c                     |   2 +-
 target/mips/translate.c                     |   2 +-
 target/nios2/helper.c                       |   2 +-
 target/xtensa/translate.c                   |   2 +-
 target/xtensa/xtensa-semi.c                 |   2 +-
 vl.c                                        | 126 +--------------
 19 files changed, 186 insertions(+), 139 deletions(-)
 create mode 100644 hw/semihosting/Makefile.objs
 create mode 100644 hw/semihosting/config.c
 rename include/{exec => hw/semihosting}/semihost.h (85%)

diff --git a/gdbstub.c b/gdbstub.c
index d54abd17cc2..793218bb43a 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -37,7 +37,7 @@
 #include "qemu/sockets.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
-#include "exec/semihost.h"
+#include "hw/semihosting/semihost.h"
 #include "exec/exec-all.h"
 
 #ifdef CONFIG_USER_ONLY
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 82aa7fab8e4..d770926ba96 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -36,6 +36,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += watchdog/
 devices-dirs-$(CONFIG_SOFTMMU) += xen/
 devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
 devices-dirs-$(CONFIG_SOFTMMU) += smbios/
+devices-dirs-y += semihosting/
 devices-dirs-y += core/
 common-obj-y += $(devices-dirs-y)
 obj-y += $(devices-dirs-y)
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 439665ab45e..3b009fda25f 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -55,7 +55,7 @@
 #include "qemu/error-report.h"
 #include "hw/empty_slot.h"
 #include "sysemu/kvm.h"
-#include "exec/semihost.h"
+#include "hw/semihosting/semihost.h"
 #include "hw/mips/cps.h"
 
 #define ENVP_ADDR		0x80002000l
diff --git a/hw/semihosting/Makefile.objs b/hw/semihosting/Makefile.objs
new file mode 100644
index 00000000000..546954f4ff4
--- /dev/null
+++ b/hw/semihosting/Makefile.objs
@@ -0,0 +1 @@
+common-obj-$(CONFIG_SOFTMMU) += config.o
diff --git a/hw/semihosting/config.c b/hw/semihosting/config.c
new file mode 100644
index 00000000000..f1d3fe1e4c6
--- /dev/null
+++ b/hw/semihosting/config.c
@@ -0,0 +1,160 @@
+/*
+ * Semihosting configuration
+ *
+ * Copyright (c) 2015 Imagination Technologies
+ * Copyright (c) 2019 Linaro Ltd
+ *
+ * This controls the configuration of semihosting for all guest
+ * targets that support it. Architecture specific handling is handled
+ * in target/HW/HW-semi.c
+ *
+ * Semihosting is sightly strange in that it is also supported by some
+ * linux-user targets. However in that use case no configuration of
+ * the outputs and command lines is supported.
+ *
+ * The config module is common to all softmmu targets however as vl.c
+ * needs to link against the helpers.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
+#include "qemu/error-report.h"
+#include "hw/semihosting/semihost.h"
+
+QemuOptsList qemu_semihosting_config_opts = {
+    .name = "semihosting-config",
+    .implied_opt_name = "enable",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_semihosting_config_opts.head),
+    .desc = {
+        {
+            .name = "enable",
+            .type = QEMU_OPT_BOOL,
+        }, {
+            .name = "target",
+            .type = QEMU_OPT_STRING,
+        }, {
+            .name = "arg",
+            .type = QEMU_OPT_STRING,
+        },
+        { /* end of list */ }
+    },
+};
+
+typedef struct SemihostingConfig {
+    bool enabled;
+    SemihostingTarget target;
+    const char **argv;
+    int argc;
+    const char *cmdline; /* concatenated argv */
+} SemihostingConfig;
+
+static SemihostingConfig semihosting;
+
+bool semihosting_enabled(void)
+{
+    return semihosting.enabled;
+}
+
+SemihostingTarget semihosting_get_target(void)
+{
+    return semihosting.target;
+}
+
+const char *semihosting_get_arg(int i)
+{
+    if (i >= semihosting.argc) {
+        return NULL;
+    }
+    return semihosting.argv[i];
+}
+
+int semihosting_get_argc(void)
+{
+    return semihosting.argc;
+}
+
+const char *semihosting_get_cmdline(void)
+{
+    if (semihosting.cmdline == NULL && semihosting.argc > 0) {
+        semihosting.cmdline = g_strjoinv(" ", (gchar **)semihosting.argv);
+    }
+    return semihosting.cmdline;
+}
+
+static int add_semihosting_arg(void *opaque,
+                               const char *name, const char *val,
+                               Error **errp)
+{
+    SemihostingConfig *s = opaque;
+    if (strcmp(name, "arg") == 0) {
+        s->argc++;
+        /* one extra element as g_strjoinv() expects NULL-terminated array */
+        s->argv = g_realloc(s->argv, (s->argc + 1) * sizeof(void *));
+        s->argv[s->argc - 1] = val;
+        s->argv[s->argc] = NULL;
+    }
+    return 0;
+}
+
+/* Use strings passed via -kernel/-append to initialize semihosting.argv[] */
+void semihosting_arg_fallback(const char *file, const char *cmd)
+{
+    char *cmd_token;
+
+    /* argv[0] */
+    add_semihosting_arg(&semihosting, "arg", file, NULL);
+
+    /* split -append and initialize argv[1..n] */
+    cmd_token = strtok(g_strdup(cmd), " ");
+    while (cmd_token) {
+        add_semihosting_arg(&semihosting, "arg", cmd_token, NULL);
+        cmd_token = strtok(NULL, " ");
+    }
+}
+
+void qemu_semihosting_enable(void)
+{
+    semihosting.enabled = true;
+    semihosting.target = SEMIHOSTING_TARGET_AUTO;
+}
+
+int qemu_semihosting_config_options(const char *optarg)
+{
+    QemuOptsList *opt_list = qemu_find_opts("semihosting-config");
+    QemuOpts *opts = qemu_opts_parse_noisily(opt_list, optarg, false);
+
+    semihosting.enabled = true;
+
+    if (opts != NULL) {
+        semihosting.enabled = qemu_opt_get_bool(opts, "enable",
+                                                true);
+        const char *target = qemu_opt_get(opts, "target");
+        if (target != NULL) {
+            if (strcmp("native", target) == 0) {
+                semihosting.target = SEMIHOSTING_TARGET_NATIVE;
+            } else if (strcmp("gdb", target) == 0) {
+                semihosting.target = SEMIHOSTING_TARGET_GDB;
+            } else  if (strcmp("auto", target) == 0) {
+                semihosting.target = SEMIHOSTING_TARGET_AUTO;
+            } else {
+                error_report("unsupported semihosting-config %s",
+                             optarg);
+                return 1;
+            }
+        } else {
+            semihosting.target = SEMIHOSTING_TARGET_AUTO;
+        }
+        /* Set semihosting argument count and vector */
+        qemu_opt_foreach(opts, add_semihosting_arg,
+                         &semihosting, NULL);
+    } else {
+        error_report("unsupported semihosting-config %s", optarg);
+        return 1;
+    }
+
+    return 0;
+}
+
diff --git a/include/exec/semihost.h b/include/hw/semihosting/semihost.h
similarity index 85%
rename from include/exec/semihost.h
rename to include/hw/semihosting/semihost.h
index 5980939c7b8..07ea40a322f 100644
--- a/include/exec/semihost.h
+++ b/include/hw/semihosting/semihost.h
@@ -51,12 +51,16 @@ static inline const char *semihosting_get_cmdline(void)
 {
     return NULL;
 }
-#else
+#else /* !CONFIG_USER_ONLY */
 bool semihosting_enabled(void);
 SemihostingTarget semihosting_get_target(void);
 const char *semihosting_get_arg(int i);
 int semihosting_get_argc(void);
 const char *semihosting_get_cmdline(void);
-#endif
+void semihosting_arg_fallback(const char *file, const char *cmd);
+/* for vl.c hooks */
+void qemu_semihosting_enable(void);
+int qemu_semihosting_config_options(const char *opt);
+#endif /* CONFIG_USER_ONLY */
 
-#endif
+#endif /* SEMIHOST_H */
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 5f133cae837..61579ae71ef 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -193,5 +193,6 @@ extern QemuOptsList qemu_nic_opts;
 extern QemuOptsList qemu_net_opts;
 extern QemuOptsList qemu_global_opts;
 extern QemuOptsList qemu_mon_opts;
+extern QemuOptsList qemu_semihosting_config_opts;
 
 #endif
diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 8b5fd7bc6e3..3273306c8ea 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/semihost.h"
+#include "hw/semihosting/semihost.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e2d5c8e34fe..c1f0a07efd8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -16,7 +16,7 @@
 #include "exec/cpu_ldst.h"
 #include "arm_ldst.h"
 #include <zlib.h> /* For crc32 */
-#include "exec/semihost.h"
+#include "hw/semihosting/semihost.h"
 #include "sysemu/cpus.h"
 #include "sysemu/kvm.h"
 #include "fpu/softfloat.h"
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b7c5a928b4a..8844a75e53d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -29,7 +29,7 @@
 #include "qemu/host-utils.h"
 #include "qemu/qemu-print.h"
 
-#include "exec/semihost.h"
+#include "hw/semihosting/semihost.h"
 #include "exec/gen-icount.h"
 
 #include "exec/helper-proto.h"
diff --git a/target/arm/translate.c b/target/arm/translate.c
index dd053c80d62..f2a65c0b5b0 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -30,7 +30,7 @@
 #include "qemu/bitops.h"
 #include "qemu/qemu-print.h"
 #include "arm_ldst.h"
-#include "exec/semihost.h"
+#include "hw/semihosting/semihost.h"
 
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
diff --git a/target/lm32/helper.c b/target/lm32/helper.c
index 20ea17ba23c..8cd48400521 100644
--- a/target/lm32/helper.c
+++ b/target/lm32/helper.c
@@ -22,7 +22,7 @@
 #include "exec/exec-all.h"
 #include "qemu/host-utils.h"
 #include "sysemu/sysemu.h"
-#include "exec/semihost.h"
+#include "hw/semihosting/semihost.h"
 #include "exec/log.h"
 
 bool lm32_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 1ecc772b5cb..bde2d551ff6 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -21,7 +21,7 @@
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
-#include "exec/semihost.h"
+#include "hw/semihosting/semihost.h"
 
 #if defined(CONFIG_USER_ONLY)
 
diff --git a/target/mips/mips-semi.c b/target/mips/mips-semi.c
index a7aefbaefc8..eac8374fb34 100644
--- a/target/mips/mips-semi.c
+++ b/target/mips/mips-semi.c
@@ -22,7 +22,7 @@
 #include "qemu/log.h"
 #include "exec/helper-proto.h"
 #include "exec/softmmu-semi.h"
-#include "exec/semihost.h"
+#include "hw/semihosting/semihost.h"
 
 typedef enum UHIOp {
     UHI_exit = 1,
diff --git a/target/mips/translate.c b/target/mips/translate.c
index f96c0d01ef1..3cd5b11b16b 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -32,7 +32,7 @@
 
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-#include "exec/semihost.h"
+#include "hw/semihosting/semihost.h"
 
 #include "target/mips/trace.h"
 #include "trace-tcg.h"
diff --git a/target/nios2/helper.c b/target/nios2/helper.c
index ffb83fc1045..57c97bde3c6 100644
--- a/target/nios2/helper.c
+++ b/target/nios2/helper.c
@@ -26,7 +26,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "exec/helper-proto.h"
-#include "exec/semihost.h"
+#include "hw/semihosting/semihost.h"
 
 #if defined(CONFIG_USER_ONLY)
 
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 53dce470c17..6f1da878752 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -38,7 +38,7 @@
 #include "qemu/qemu-print.h"
 #include "sysemu/sysemu.h"
 #include "exec/cpu_ldst.h"
-#include "exec/semihost.h"
+#include "hw/semihosting/semihost.h"
 #include "exec/translator.h"
 
 #include "exec/helper-proto.h"
diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index 5f5ce4f344c..38efa3485af 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -29,7 +29,7 @@
 #include "cpu.h"
 #include "chardev/char-fe.h"
 #include "exec/helper-proto.h"
-#include "exec/semihost.h"
+#include "hw/semihosting/semihost.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
diff --git a/vl.c b/vl.c
index 201144b1628..6b19ea42bfe 100644
--- a/vl.c
+++ b/vl.c
@@ -116,7 +116,7 @@ int main(int argc, char **argv)
 #include "qapi/opts-visitor.h"
 #include "qapi/clone-visitor.h"
 #include "qom/object_interfaces.h"
-#include "exec/semihost.h"
+#include "hw/semihosting/semihost.h"
 #include "crypto/init.h"
 #include "sysemu/replay.h"
 #include "qapi/qapi-events-run-state.h"
@@ -500,25 +500,6 @@ static QemuOptsList qemu_icount_opts = {
     },
 };
 
-static QemuOptsList qemu_semihosting_config_opts = {
-    .name = "semihosting-config",
-    .implied_opt_name = "enable",
-    .head = QTAILQ_HEAD_INITIALIZER(qemu_semihosting_config_opts.head),
-    .desc = {
-        {
-            .name = "enable",
-            .type = QEMU_OPT_BOOL,
-        }, {
-            .name = "target",
-            .type = QEMU_OPT_STRING,
-        }, {
-            .name = "arg",
-            .type = QEMU_OPT_STRING,
-        },
-        { /* end of list */ }
-    },
-};
-
 static QemuOptsList qemu_fw_cfg_opts = {
     .name = "fw_cfg",
     .implied_opt_name = "name",
@@ -1350,80 +1331,6 @@ static void configure_msg(QemuOpts *opts)
     enable_timestamp_msg = qemu_opt_get_bool(opts, "timestamp", true);
 }
 
-/***********************************************************/
-/* Semihosting */
-
-typedef struct SemihostingConfig {
-    bool enabled;
-    SemihostingTarget target;
-    const char **argv;
-    int argc;
-    const char *cmdline; /* concatenated argv */
-} SemihostingConfig;
-
-static SemihostingConfig semihosting;
-
-bool semihosting_enabled(void)
-{
-    return semihosting.enabled;
-}
-
-SemihostingTarget semihosting_get_target(void)
-{
-    return semihosting.target;
-}
-
-const char *semihosting_get_arg(int i)
-{
-    if (i >= semihosting.argc) {
-        return NULL;
-    }
-    return semihosting.argv[i];
-}
-
-int semihosting_get_argc(void)
-{
-    return semihosting.argc;
-}
-
-const char *semihosting_get_cmdline(void)
-{
-    if (semihosting.cmdline == NULL && semihosting.argc > 0) {
-        semihosting.cmdline = g_strjoinv(" ", (gchar **)semihosting.argv);
-    }
-    return semihosting.cmdline;
-}
-
-static int add_semihosting_arg(void *opaque,
-                               const char *name, const char *val,
-                               Error **errp)
-{
-    SemihostingConfig *s = opaque;
-    if (strcmp(name, "arg") == 0) {
-        s->argc++;
-        /* one extra element as g_strjoinv() expects NULL-terminated array */
-        s->argv = g_realloc(s->argv, (s->argc + 1) * sizeof(void *));
-        s->argv[s->argc - 1] = val;
-        s->argv[s->argc] = NULL;
-    }
-    return 0;
-}
-
-/* Use strings passed via -kernel/-append to initialize semihosting.argv[] */
-static inline void semihosting_arg_fallback(const char *file, const char *cmd)
-{
-    char *cmd_token;
-
-    /* argv[0] */
-    add_semihosting_arg(&semihosting, "arg", file, NULL);
-
-    /* split -append and initialize argv[1..n] */
-    cmd_token = strtok(g_strdup(cmd), " ");
-    while (cmd_token) {
-        add_semihosting_arg(&semihosting, "arg", cmd_token, NULL);
-        cmd_token = strtok(NULL, " ");
-    }
-}
 
 /* Now we still need this for compatibility with XEN. */
 bool has_igd_gfx_passthru;
@@ -3739,37 +3646,10 @@ int main(int argc, char **argv, char **envp)
                 nb_option_roms++;
                 break;
             case QEMU_OPTION_semihosting:
-                semihosting.enabled = true;
-                semihosting.target = SEMIHOSTING_TARGET_AUTO;
+                qemu_semihosting_enable();
                 break;
             case QEMU_OPTION_semihosting_config:
-                semihosting.enabled = true;
-                opts = qemu_opts_parse_noisily(qemu_find_opts("semihosting-config"),
-                                               optarg, false);
-                if (opts != NULL) {
-                    semihosting.enabled = qemu_opt_get_bool(opts, "enable",
-                                                            true);
-                    const char *target = qemu_opt_get(opts, "target");
-                    if (target != NULL) {
-                        if (strcmp("native", target) == 0) {
-                            semihosting.target = SEMIHOSTING_TARGET_NATIVE;
-                        } else if (strcmp("gdb", target) == 0) {
-                            semihosting.target = SEMIHOSTING_TARGET_GDB;
-                        } else  if (strcmp("auto", target) == 0) {
-                            semihosting.target = SEMIHOSTING_TARGET_AUTO;
-                        } else {
-                            error_report("unsupported semihosting-config %s",
-                                         optarg);
-                            exit(1);
-                        }
-                    } else {
-                        semihosting.target = SEMIHOSTING_TARGET_AUTO;
-                    }
-                    /* Set semihosting argument count and vector */
-                    qemu_opt_foreach(opts, add_semihosting_arg,
-                                     &semihosting, NULL);
-                } else {
-                    error_report("unsupported semihosting-config %s", optarg);
+                if (qemu_semihosting_config_options(optarg) != 0) {
                     exit(1);
                 }
                 break;
-- 
2.20.1



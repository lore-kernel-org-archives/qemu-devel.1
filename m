Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16395CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C640221D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9w/5TQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C640221D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtYr-0007M2-G9
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtE9-0003UE-45
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtE7-0008UV-60
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:37 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:42521)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtE6-0008Ts-VJ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:35 -0400
Received: by mail-wr1-x430.google.com with SMTP id r1so902161wrs.9
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J5mwez8/3JgAsIrNmKybl1GLPKvB5P922l8oGG8eRMA=;
 b=E9w/5TQUAp6jdk9+CbKxG5Yl3oW0bD4ZX/SSnleoKdOGiIngdaGCBdMwHBs57YW5U2
 fqyjfTmUwGRaXGs5PwUt65uGnxGJfsLGj2LCTW3bxGaPEaQr57trc9jFODJ3FaGEFchS
 0zvNJmhx6rx6dpvJ4vNkH44ImH++DkBosSCGfn0XsbMvkKB0nnpulk1OrZZ8VDm2ZotU
 q6Z6G/pgCrhGxwcDALw3/sIjj3pZAnrigfbSbeLgi1FdCEZQvMTTHsB4O7nnr42VxHXL
 /J7PCYHt1o/AvwnXgn3qXpNdsA6vmzbPI2655vORAUnlMtacskeNXxQBEa11rIge3DvE
 NvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J5mwez8/3JgAsIrNmKybl1GLPKvB5P922l8oGG8eRMA=;
 b=rxvK5chselQU4VbG2UeZBn9axGcCTYA5BX8UU7pUiaQ8UrCihsyIyRmz2COFprQoJB
 P1n8t8AJbIrw5uopQavYfC5AaaAnC8cfn3LVYr8bH1aY2o+XQJxg//8AGVB8aPKZ9HQq
 DQIxzYKpgc0IXP+fJfLOn5L7ckFiFtOG0pLAfbEJdb3hKKnaFYQqpsJA33tZOGYDXe4P
 H2r6VPSY8X4PZUovTNu7Ca8EYHfYH4qboazDzGBPy1lXG24S6PV1CaUUZ7HReno5C3Qa
 zeamQA9dDpJURvLZib24RrhVM8z8WSp6XRL5oOiiU2GAyILCKxe7WLVraFCK5gC4xj90
 Rfqw==
X-Gm-Message-State: APjAAAUht/FPiVpz3AQIbUFKz2DuxtHnbGwkOmRyA0EwUiT/GFx0iDDH
 kJqI/nz8Pj8n6Rn7YcrdzQs1XQ==
X-Google-Smtp-Source: APXvYqzPL7RL3ZbdhkdVAGxYeyV1MHVsI0afWmGOu6usjkiFZa/DxBP+GfyFQYn4KsPZmh7RL9D3iA==
X-Received: by 2002:a5d:4808:: with SMTP id l8mr1268388wrq.118.1571985453718; 
 Thu, 24 Oct 2019 23:37:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h205sm1147080wmf.35.2019.10.24.23.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:37:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4F65E1FFD1;
 Fri, 25 Oct 2019 07:37:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 59/73] tests/plugin: add sample plugins
Date: Fri, 25 Oct 2019 07:36:59 +0100
Message-Id: <20191025063713.23374-60-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
 "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Pass arguments with -plugin=libfoo.so,arg=bar,arg=baz

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/configure b/configure
index eabe84af6ed..f77c4dc09a6 100755
--- a/configure
+++ b/configure
@@ -7903,6 +7903,7 @@ DIRS="$DIRS roms/seabios roms/vgabios"
 LINKS="Makefile"
 LINKS="$LINKS tests/tcg/lm32/Makefile po/Makefile"
 LINKS="$LINKS tests/tcg/Makefile.target tests/fp/Makefile"
+LINKS="$LINKS tests/plugin/Makefile"
 LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
 LINKS="$LINKS pc-bios/s390-ccw/Makefile"
 LINKS="$LINKS roms/seabios/Makefile roms/vgabios/Makefile"
diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
new file mode 100644
index 00000000000..f9a3546ea32
--- /dev/null
+++ b/tests/plugin/Makefile
@@ -0,0 +1,28 @@
+BUILD_DIR := $(CURDIR)/../..
+
+include $(BUILD_DIR)/config-host.mak
+include $(SRC_PATH)/rules.mak
+
+$(call set-vpath, $(SRC_PATH)/tests/plugin)
+
+NAMES :=
+NAMES += bb
+NAMES += empty
+NAMES += insn
+NAMES += mem
+
+SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
+
+QEMU_CFLAGS += -fPIC
+QEMU_CFLAGS += -I$(SRC_PATH)/include/qemu
+
+all: $(SONAMES)
+
+lib%.so: %.o
+	$(CC) -shared -Wl,-soname,$@ -o $@ $^ $(LDLIBS)
+
+clean:
+	rm -f *.o *.so *.d
+	rm -Rf .libs
+
+.PHONY: all clean
diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
new file mode 100644
index 00000000000..45e1de5bd68
--- /dev/null
+++ b/tests/plugin/bb.c
@@ -0,0 +1,64 @@
+/*
+ * Copyright (C) 2018, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#include <inttypes.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <glib.h>
+
+#include <qemu-plugin.h>
+
+static uint64_t bb_count;
+static uint64_t insn_count;
+static bool do_inline;
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    g_autofree gchar *out;
+    out = g_strdup_printf("bb's: %" PRIu64", insns: %" PRIu64 "\n",
+                          bb_count, insn_count);
+    qemu_plugin_outs(out);
+}
+
+static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
+{
+    unsigned long n_insns = (unsigned long)udata;
+
+    insn_count += n_insns;
+    bb_count++;
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    unsigned long n_insns = qemu_plugin_tb_n_insns(tb);
+
+    if (do_inline) {
+        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
+                                                 &bb_count, 1);
+        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
+                                                 &insn_count, n_insns);
+    } else {
+        qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
+                                             QEMU_PLUGIN_CB_NO_REGS,
+                                             (void *)n_insns);
+    }
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    if (argc && strcmp(argv[0], "inline") == 0) {
+        do_inline = true;
+    }
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    return 0;
+}
diff --git a/tests/plugin/empty.c b/tests/plugin/empty.c
new file mode 100644
index 00000000000..3f60f690278
--- /dev/null
+++ b/tests/plugin/empty.c
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2018, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#include <inttypes.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+/*
+ * Empty TB translation callback.
+ * This allows us to measure the overhead of injecting and then
+ * removing empty instrumentation.
+ */
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{ }
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    return 0;
+}
diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
new file mode 100644
index 00000000000..e5fd07fb64b
--- /dev/null
+++ b/tests/plugin/insn.c
@@ -0,0 +1,61 @@
+/*
+ * Copyright (C) 2018, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#include <inttypes.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <glib.h>
+
+#include <qemu-plugin.h>
+
+static uint64_t insn_count;
+static bool do_inline;
+
+static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
+{
+    insn_count++;
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    size_t n = qemu_plugin_tb_n_insns(tb);
+    size_t i;
+
+    for (i = 0; i < n; i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+
+        if (do_inline) {
+            qemu_plugin_register_vcpu_insn_exec_inline(
+                insn, QEMU_PLUGIN_INLINE_ADD_U64, &insn_count, 1);
+        } else {
+            qemu_plugin_register_vcpu_insn_exec_cb(
+                insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS, NULL);
+        }
+    }
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    g_autofree gchar *out;
+    out = g_strdup_printf("insns: %" PRIu64 "\n", insn_count);
+    qemu_plugin_outs(out);
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    if (argc && !strcmp(argv[0], "inline")) {
+        do_inline = true;
+    }
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    return 0;
+}
diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
new file mode 100644
index 00000000000..d9673889896
--- /dev/null
+++ b/tests/plugin/mem.c
@@ -0,0 +1,97 @@
+/*
+ * Copyright (C) 2018, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#include <inttypes.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <glib.h>
+
+#include <qemu-plugin.h>
+
+static uint64_t mem_count;
+static uint64_t io_count;
+static bool do_inline;
+static bool do_haddr;
+static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    g_autoptr(GString) out = g_string_new("");
+
+    g_string_printf(out, "mem accesses: %" PRIu64 "\n", mem_count);
+    if (do_haddr) {
+        g_string_append_printf(out, "io accesses: %" PRIu64 "\n", mem_count);
+    }
+    qemu_plugin_outs(out->str);
+}
+
+static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
+                     uint64_t vaddr, void *udata)
+{
+    if (do_haddr) {
+        struct qemu_plugin_hwaddr *hwaddr;
+        hwaddr = qemu_plugin_get_hwaddr(meminfo, vaddr);
+        if (qemu_plugin_hwaddr_is_io(hwaddr)) {
+            io_count++;
+        } else {
+            mem_count++;
+        }
+    } else {
+        mem_count++;
+    }
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    size_t n = qemu_plugin_tb_n_insns(tb);
+    size_t i;
+
+    for (i = 0; i < n; i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+
+        if (do_inline) {
+            qemu_plugin_register_vcpu_mem_inline(insn, rw,
+                                                 QEMU_PLUGIN_INLINE_ADD_U64,
+                                                 &mem_count, 1);
+        } else {
+            qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem,
+                                             QEMU_PLUGIN_CB_NO_REGS,
+                                             rw, NULL);
+        }
+    }
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    if (argc) {
+        if (argc >= 3) {
+            if (!strcmp(argv[2], "haddr")) {
+                do_haddr = true;
+            }
+        }
+        if (argc >= 2) {
+            const char *str = argv[1];
+
+            if (!strcmp(str, "r")) {
+                rw = QEMU_PLUGIN_MEM_R;
+            } else if (!strcmp(str, "w")) {
+                rw = QEMU_PLUGIN_MEM_W;
+            }
+        }
+        if (!strcmp(argv[0], "inline")) {
+            do_inline = true;
+        }
+    }
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    return 0;
+}
-- 
2.20.1



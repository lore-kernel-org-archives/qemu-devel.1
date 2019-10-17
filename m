Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DF8FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:43:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F986214E0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H7B6CHxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F986214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL63c-0006gi-5M
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5do-0008By-CR
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5dm-0005Vm-GN
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:32 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:42718)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5dm-0005VH-8d
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:30 -0400
Received: by mail-wr1-x429.google.com with SMTP id n14so2303117wrw.9
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SV7LIVH8inKUDnsFl367qU/UVX1J8Nzuw++QSYd8XdE=;
 b=H7B6CHxTfNKKQk3kgKUvZZ2wZmPNlRtPkDpiMwBHJEheYDGRW6cMNI2nbgFzO53/SF
 pNBKvUUo2E+pBYYRnBlJSDDzU+mfUubeTcORC4Ut76X1nXGeYGC/BHXNlgDfPG2dRyuD
 3sQm3BeQNuhgw2D1s9b6kfx5awHn+X5m53NKb6xn9J+LHrRPePHDiJjT0sRVtFcj6+C0
 MYxTVlfm4BGD6bOnqu2gFS0NsEYVNP620ZQHFCeQkXi0pknXUA7A4uxLBoMuuvA2uMOL
 0yufnh+MzFd+VRqyEoTHoPgMRXMj9GD6yF+T7oLW1KcuZxeBuLPXgJfF9rGxiQXpCh+N
 nWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SV7LIVH8inKUDnsFl367qU/UVX1J8Nzuw++QSYd8XdE=;
 b=nOFhqyG5MGjO2Pab0mHwiRbAosR278LBSoHk9yebM6ycGl6ztN9kwJR4TczJEde+6U
 Sb3IbwFdos02Fkov+/raiGcRI5K8cBGiY3j+tQogPYjSigciAN6fiDh/9hv+fNizufJv
 F2jiTpHHqOTcv2PF0Lg74zJe0OHPWNPudTyAbMbIQJiVlkIlXDqqWNboe47gUk4WKEZP
 fQwlD9qt+aCT+lN8ZgQpmZgF1B68khaOvMqdvb7k3UJCq9AXezEtXwXWlUBq7FUOQWO+
 IPROLFSND83U2jYXV2mIzgELUZjI7xG2tC/bqQP4/iVOAlaV9DNtizFnvTJ/mIpYLPgI
 aiyQ==
X-Gm-Message-State: APjAAAV7qI2ZAbSNPmGQyS8m8CzeVAwdqiJgVll2e4xmNv7A3fSMdUO+
 TXgZZjgdAwGGqMfiyK0XW5WMTA==
X-Google-Smtp-Source: APXvYqw5dmzE4Y0xqCBNfkwi2P3ZZBrDS+s6BN0yMeStMhTFsRSsusnb+dn6ydDLIuqb3SWUAt+hIg==
X-Received: by 2002:a5d:5444:: with SMTP id w4mr2932358wrv.18.1571318189026;
 Thu, 17 Oct 2019 06:16:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z15sm2412542wrr.19.2019.10.17.06.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:16:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D99521FFC1;
 Thu, 17 Oct 2019 14:16:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 42/54] tests/plugin: add sample plugins
Date: Thu, 17 Oct 2019 14:16:03 +0100
Message-Id: <20191017131615.19660-43-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Pass arguments with -plugin=libfoo.so,arg=bar,arg=baz

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v4
   - tweaks for hwaddr API
v6
   - init/outs api updates
---
 configure             |  1 +
 tests/plugin/Makefile | 28 +++++++++++++
 tests/plugin/bb.c     | 64 ++++++++++++++++++++++++++++
 tests/plugin/empty.c  | 30 +++++++++++++
 tests/plugin/insn.c   | 61 +++++++++++++++++++++++++++
 tests/plugin/mem.c    | 97 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 281 insertions(+)
 create mode 100644 tests/plugin/Makefile
 create mode 100644 tests/plugin/bb.c
 create mode 100644 tests/plugin/empty.c
 create mode 100644 tests/plugin/insn.c
 create mode 100644 tests/plugin/mem.c

diff --git a/configure b/configure
index 163eda23b7..63c9569aa0 100755
--- a/configure
+++ b/configure
@@ -7890,6 +7890,7 @@ DIRS="$DIRS roms/seabios roms/vgabios"
 LINKS="Makefile"
 LINKS="$LINKS tests/tcg/lm32/Makefile po/Makefile"
 LINKS="$LINKS tests/tcg/Makefile.target tests/fp/Makefile"
+LINKS="$LINKS tests/plugin/Makefile"
 LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
 LINKS="$LINKS pc-bios/s390-ccw/Makefile"
 LINKS="$LINKS roms/seabios/Makefile roms/vgabios/Makefile"
diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
new file mode 100644
index 0000000000..f9a3546ea3
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
index 0000000000..45e1de5bd6
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
index 0000000000..3f60f69027
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
index 0000000000..e5fd07fb64
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
index 0000000000..d967388989
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



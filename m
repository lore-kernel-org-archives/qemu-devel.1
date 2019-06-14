Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7648DC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 19:00:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3246D2183E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 19:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQbO9Fxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3246D2183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54382 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbrRX-0000Ip-B2
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 15:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39288)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbqJb-0004XL-Ts
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbqJZ-0003Xt-AQ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:48:39 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:44100)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbqJT-0003S0-Tn
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:48:35 -0400
Received: by mail-wr1-x42c.google.com with SMTP id r16so3386355wrl.11
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VXpK415OMJJqmZ3w36Oxw/kJSG0YBc4gbksES0oJVX8=;
 b=xQbO9FxeBWXSzUk5RTFwKb4C9mLDDfH+MkxTaAut61ZmxEBhRrP4MCI7MJv/Mc1/Gn
 qDahXRiKHpL54Vs/w3jxE2qA0+zcBwnDqzI8XG230SO4A0383ULxQEb3d8KRzfgHlKQt
 jul3QLDY8fldQ0BqBLLcGcfY8dFUNPE3upEPnI04jEw8pNzEsgYJtDmi4NtTNQLgnAu7
 TjWrZ1OjMnDTyI1xnQyWOyf3iRItfBYgjkyqZw2gDTTLyv47uLSZANHBF+O4uR6xM8kb
 1VrENiaA+nEi/OV64t4BO0pjb9TNn8kcHy2/yXzWNp2z0DoOBgE+Mr2kkh6t6xvJFRzD
 2bIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VXpK415OMJJqmZ3w36Oxw/kJSG0YBc4gbksES0oJVX8=;
 b=aBKQmP3ZqEPXrug/sfvmi/l7kCkraCyIxXq61aVDRWSG2YkXdBO16APip0D4GgOc/D
 m/XrNOI4u8f9mFTk0fT8INA5jhp/jHqjRe4uBCedE1qQVfg7tY1CNUnxhrgp0xZCUq+f
 6U/f/qIuGEa2MlvEdcOuvaiyA498VT/FX0hquD4ZHNfiJ2UKR/PgwLyHGLDx3Y/M0s2v
 Pco+IqpiHspAow0ZO6lTHqNNR+rC2Y6T67DjWOYl30vYHx60I5DWlsfLif63KH0XRJVe
 /YMEbI1KPLFFvLGwyIf3xxK+Yt7gY1nRQrOt+yNvum5334mEWKFlOQhsUmU3yGczGrE7
 Qi7w==
X-Gm-Message-State: APjAAAUy4RFLK+ViZoRLQ7qDYwefQVzbSj71X33VBJuVNv5Fp2Wf1SyW
 OVSijJ8t/cZljFCTg3yrpAy+eA==
X-Google-Smtp-Source: APXvYqwzVELrPux0c6U0ZsBBsmjubvRsPsv4uWGLUMQpraPiD/TfJooSwaP7KGEeNylKrfDOYKwxRQ==
X-Received: by 2002:a5d:4302:: with SMTP id h2mr36455054wrq.137.1560534509002; 
 Fri, 14 Jun 2019 10:48:29 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id h84sm5730516wmf.43.2019.06.14.10.48.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:48:27 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 24B3E1FFC0;
 Fri, 14 Jun 2019 18:12:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:51 +0100
Message-Id: <20190614171200.21078-42-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PATCH  v3 41/50] tests/plugin: add sample plugins
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
Cc: "Emilio G. Cota" <cota@braap.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Pass arguments with -plugin=libfoo.so,arg=bar,arg=baz

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 configure             |  4 +-
 tests/plugin/Makefile | 28 +++++++++++++
 tests/plugin/bb.c     | 66 ++++++++++++++++++++++++++++++
 tests/plugin/empty.c  | 30 ++++++++++++++
 tests/plugin/insn.c   | 63 +++++++++++++++++++++++++++++
 tests/plugin/mem.c    | 93 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 282 insertions(+), 2 deletions(-)
 create mode 100644 tests/plugin/Makefile
 create mode 100644 tests/plugin/bb.c
 create mode 100644 tests/plugin/empty.c
 create mode 100644 tests/plugin/insn.c
 create mode 100644 tests/plugin/mem.c

diff --git a/configure b/configure
index d3bf254191..2af8c436f2 100755
--- a/configure
+++ b/configure
@@ -7995,14 +7995,14 @@ fi
 # tests might fail. Prefer to keep the relevant files in their own
 # directory and symlink the directory instead.
 DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests tests/vm"
-DIRS="$DIRS tests/fp tests/qgraph"
+DIRS="$DIRS tests/fp tests/qgraph tests/plugin"
 DIRS="$DIRS docs docs/interop fsdev scsi"
 DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
 DIRS="$DIRS roms/seabios roms/vgabios"
 LINKS="Makefile tests/tcg/Makefile"
 LINKS="$LINKS tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
 LINKS="$LINKS tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Makefile"
-LINKS="$LINKS tests/fp/Makefile"
+LINKS="$LINKS tests/fp/Makefile tests/plugin/Makefile"
 LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
 LINKS="$LINKS pc-bios/spapr-rtas/Makefile"
 LINKS="$LINKS pc-bios/s390-ccw/Makefile"
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
index 0000000000..bb868599a9
--- /dev/null
+++ b/tests/plugin/bb.c
@@ -0,0 +1,66 @@
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
+static uint64_t bb_count;
+static uint64_t insn_count;
+static int stdout_fd;
+static bool do_inline;
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    dprintf(stdout_fd, "bb's: %" PRIu64", insns: %" PRIu64 "\n",
+            bb_count, insn_count);
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
+static void vcpu_tb_trans(qemu_plugin_id_t id, unsigned int cpu_index,
+                          struct qemu_plugin_tb *tb)
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
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
+                                           char **argv)
+{
+    if (argc && strcmp(argv[0], "inline") == 0) {
+        do_inline = true;
+    }
+
+    /* to be used when in the exit hook */
+    stdout_fd = dup(STDOUT_FILENO);
+    assert(stdout_fd);
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    return 0;
+}
diff --git a/tests/plugin/empty.c b/tests/plugin/empty.c
new file mode 100644
index 0000000000..b2e30bddb2
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
+static void vcpu_tb_trans(qemu_plugin_id_t id, unsigned int cpu_index,
+                          struct qemu_plugin_tb *tb)
+{ }
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
+                                           char **argv)
+{
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    return 0;
+}
diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
new file mode 100644
index 0000000000..11afe0e8f1
--- /dev/null
+++ b/tests/plugin/insn.c
@@ -0,0 +1,63 @@
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
+static int stdout_fd;
+static uint64_t insn_count;
+static bool do_inline;
+
+static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
+{
+    insn_count++;
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, unsigned int cpu_index,
+                          struct qemu_plugin_tb *tb)
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
+    dprintf(stdout_fd, "insns: %" PRIu64 "\n", insn_count);
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
+                                           char **argv)
+{
+    if (argc && !strcmp(argv[0], "inline")) {
+        do_inline = true;
+    }
+
+    /* to be used when in the exit hook */
+    stdout_fd = dup(STDOUT_FILENO);
+    assert(stdout_fd);
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    return 0;
+}
diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
new file mode 100644
index 0000000000..c13c672c91
--- /dev/null
+++ b/tests/plugin/mem.c
@@ -0,0 +1,93 @@
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
+static uint64_t mem_count;
+static int stdout_fd;
+static bool do_inline;
+static bool do_haddr;
+static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    dprintf(stdout_fd, "accesses: %" PRIu64 "\n", mem_count);
+}
+
+static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
+                     uint64_t vaddr, void *udata)
+{
+    mem_count++;
+}
+
+static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
+                       uint64_t vaddr, void *haddr, void *udata)
+{
+    mem_count++;
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, unsigned int cpu_index,
+                          struct qemu_plugin_tb *tb)
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
+        } else if (do_haddr) {
+            qemu_plugin_register_vcpu_mem_haddr_cb(insn, vcpu_haddr,
+                                                   QEMU_PLUGIN_CB_NO_REGS,
+                                                   rw, NULL);
+        } else {
+            qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem,
+                                             QEMU_PLUGIN_CB_NO_REGS,
+                                             rw, NULL);
+        }
+    }
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
+                                           char **argv)
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
+    /* plugin_exit might write to stdout after stdout has been closed */
+    stdout_fd = dup(STDOUT_FILENO);
+    assert(stdout_fd);
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    return 0;
+}
-- 
2.20.1



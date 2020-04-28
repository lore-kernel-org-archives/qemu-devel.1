Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCDEC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763E02082E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fRc9Kp4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763E02082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTTrd-0001wb-KU
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 13:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jTTqp-0001LW-SE
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jTTqg-0002tb-JP
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:16:55 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:33896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jTTqg-0002t5-1c
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:16:46 -0400
Received: by mail-wr1-x42a.google.com with SMTP id j1so25604261wrt.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 10:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1pq1lHLSOmmH7N125+R4HUhPyCkUqHE2ejEQyvBBBJ0=;
 b=fRc9Kp4BL4wukY/0nQJpg2aiHYkkTUFAPptu/gIqTYe94FEU1PBi8G7Cax89hS+5cU
 X0lfZk1Llx9L7tsRFaLQlRhe8AZhR56VQZvnvu+wac1C5HTtIYMbLNr4ip9ljjanEg7c
 rjpj2AzwCzvRQ7qPbopfxM3T5K1v3q2fFQa44rV8sZCmP8IBt1qa1TkmmcydckbvoJsF
 NkpvzpWO/0uegOV+IHmVJvtwBs7GVTMSEjtV28DLjFPvy7y5cuDS9wju7ELTHvRyDJ/I
 6mCU295luYqZGOoVhugRiDWgkgaZGtlSGCrEd1d9VI1bJBoPYK5p6J/ms/RU+hOKlU6B
 mqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1pq1lHLSOmmH7N125+R4HUhPyCkUqHE2ejEQyvBBBJ0=;
 b=MAPd0NlQi7NvpLTZXd2JSYAaM11eGfhS98M2Y1n0vRS34CeBb/VADDwIP1ONODhS2S
 gYiT2/PEJFuUEdNpM2zrFD24hsiNwNSqjg+yNcD0DtldikhGvk2J0bjAzGeT/Lk4bztn
 5WEEJEmnbP/vmLNAaawPG80NxIBaMiKQwAybD1y69RHVIajIWUawUdccCWzTYyl1oXHG
 lv7463PBmKdycnW0jiQVChZW01cXa8z+W6it1SmnvCmCMnXYoVvJlR7KPI4f6Vmx6N3/
 kIlCN4kGZtXyD1Hgkm0anKyqmwEBm7GXJmpM6SZ4VfYhIz28V/WaTEmZyyz26CZDr/3Q
 Zy3w==
X-Gm-Message-State: AGi0Pubkr2ThaL7EtBrh3qz0CgGfAjniw3BpXlwEGFMYMh+Yv2FbsokM
 w6iyHanan3bgP0riXQiJWYiyBQ==
X-Google-Smtp-Source: APiQypLveZJoKkg8Z/+93IyggNTiYpAxrmImkFgS39j9RPIs3/35ZsTrsKYoGYVj3gryAyPQv1cjqg==
X-Received: by 2002:adf:e5c8:: with SMTP id a8mr37306195wrn.56.1588094203607; 
 Tue, 28 Apr 2020 10:16:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r2sm4199028wmg.2.2020.04.28.10.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:16:42 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 59C091FF7E;
 Tue, 28 Apr 2020 18:16:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] plugins: new lockstep plugin for debugging TCG changes
Date: Tue, 28 Apr 2020 18:16:33 +0100
Message-Id: <20200428171633.17487-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we make changes to the TCG we sometimes cause regressions that
are deep into the execution cycle of the guest. Debugging this often
requires comparing large volumes of trace information to figure out
where behaviour has diverged.

The lockstep plugin utilises a shared socket so two QEMU's running
with the plugin will write their current execution position and wait
to receive the position of their partner process. When execution
diverges the plugins output where they were and the previous few
blocks before unloading themselves and letting execution continue.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 tests/plugin/lockstep.c | 244 ++++++++++++++++++++++++++++++++++++++++
 tests/plugin/Makefile   |   1 +
 2 files changed, 245 insertions(+)
 create mode 100644 tests/plugin/lockstep.c

diff --git a/tests/plugin/lockstep.c b/tests/plugin/lockstep.c
new file mode 100644
index 0000000000..2c386d2b83
--- /dev/null
+++ b/tests/plugin/lockstep.c
@@ -0,0 +1,244 @@
+/*
+ * Lockstep Execution Plugin
+ *
+ * Allows you to execute two QEMU instances in lockstep and report
+ * when their execution diverges. This is mainly useful for developers
+ * who want to see where a change to TCG code generation has
+ * introduced a subtle and hard to find bug.
+ *
+ * Caveats:
+ *   - single-threaded linux-user apps only with non-deterministic syscalls
+ *   - icount based system emulation (no MTTCG)
+ *
+ * This code is not thread safe!
+ *
+ * Copyright (c) 2020 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <glib.h>
+#include <inttypes.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <stdio.h>
+#include <errno.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+/* saved so we can uninstall later */
+static qemu_plugin_id_t our_id;
+
+static unsigned long bb_count;
+static unsigned long insn_count;
+
+typedef struct {
+    uint64_t pc;
+    uint64_t insns_in_block;
+    uint64_t insns_executed;
+} BlockInfo;
+
+static GSList *log;
+
+static int socket_fd;
+static char *path_to_unlink;
+
+
+static void plugin_cleanup(qemu_plugin_id_t id)
+{
+
+    /* Free our block data */
+    g_slist_free_full(log, &g_free);
+
+    close(socket_fd);
+    if (path_to_unlink) {
+        unlink(path_to_unlink);
+    }
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    g_autoptr(GString) out = g_string_new("No divergence :-)\n");
+    g_string_append_printf(out, "Executed %ld/%d blocks\n",
+                           bb_count, g_slist_length(log));
+    g_string_append_printf(out, "Executed ~%ld instructions\n", insn_count);
+    qemu_plugin_outs(out->str);
+
+    plugin_cleanup(id);
+}
+
+static void report_divergance(BlockInfo *us, BlockInfo *them)
+{
+    int i;
+    GSList *entry = log;
+    g_autoptr(GString) out = g_string_new("I feel a divergence in the force\n");
+    g_string_append_printf(out, "Us @ %#016lx (%ld)\n",
+                           us->pc, us->insns_executed);
+    g_string_append_printf(out, "Them @ %#016lx (%ld)\n",
+                           them->pc, them->insns_executed);
+    for (i = 0; i < 5; i++) {
+        BlockInfo *prev = (BlockInfo *) entry->data;
+        g_string_append_printf(out, "  previously @ %#016lx\n", prev->pc);
+        entry = g_slist_next(entry);
+    }
+
+    qemu_plugin_outs(out->str);
+
+    /* we can't do anything else now so uninstall ourselves */
+    qemu_plugin_uninstall(our_id, plugin_cleanup);
+}
+
+static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
+{
+    BlockInfo *bi = (BlockInfo *) udata;
+    BlockInfo remote;
+    ssize_t bytes;
+
+    bi->insns_executed = insn_count;
+
+    /* write our execution state */
+    bytes = write(socket_fd, bi, sizeof(BlockInfo));
+    if (bytes < sizeof(BlockInfo)) {
+        if (bytes < 0) {
+            qemu_plugin_outs("problem writing to socket");
+            abort();
+        }
+        qemu_plugin_outs("wrote less than expected");
+    }
+    /* read where our peer has reached */
+    bytes = read(socket_fd, &remote, sizeof(BlockInfo));
+    if (bytes < sizeof(BlockInfo)) {
+        if (bytes < 0) {
+            qemu_plugin_outs("problem reading from socket");
+            abort();
+        }
+        qemu_plugin_outs("read less than expected");
+        abort();
+    }
+
+    // compare and bail
+    if ((bi->pc != remote.pc) ||
+        (bi->insns_executed != remote.insns_executed)) {
+        report_divergance(bi, &remote);
+    }
+
+    // mark the execution as complete
+    log = g_slist_prepend(log, bi);
+    insn_count += bi->insns_in_block;
+    bb_count++;
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    BlockInfo *bi = g_new0(BlockInfo, 1);
+    bi->pc = qemu_plugin_tb_vaddr(tb);
+    bi->insns_in_block = qemu_plugin_tb_n_insns(tb);
+
+    qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
+                                         QEMU_PLUGIN_CB_NO_REGS, (void *)bi);
+}
+
+
+/*
+ * Instead of encoding master/slave status into what is essentially
+ * two peers we shall just take the simple approach of checking for
+ * the existence of the pipe and assuming if it's not there we are the
+ * first process.
+ */
+static bool setup_socket(const char *path)
+{
+    struct sockaddr_un sockaddr;
+    int fd;
+
+    fd = socket(AF_UNIX, SOCK_STREAM, 0);
+    if (fd < 0) {
+        perror("create socket");
+        return false;
+    }
+
+    sockaddr.sun_family = AF_UNIX;
+    g_strlcpy(sockaddr.sun_path, path, sizeof(sockaddr.sun_path)-1);
+    if (bind(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr)) < 0) {
+        perror("bind socket");
+        close(fd);
+        return false;
+    }
+
+    /* remember to clean-up */
+    path_to_unlink = g_strdup(path);
+
+    if (listen(fd, 1) < 0) {
+        perror("listen socket");
+        close(fd);
+        return false;
+    }
+
+    socket_fd = accept(fd, NULL, NULL);
+    if (socket_fd < 0 && errno != EINTR) {
+        perror("accept socket");
+        return false;
+    }
+
+    qemu_plugin_outs("setup_socket::ready\n");
+
+    return true;
+}
+
+static bool connect_socket(const char *path)
+{
+    int fd;
+    struct sockaddr_un sockaddr;
+
+    fd = socket(AF_UNIX, SOCK_STREAM, 0);
+    if (fd < 0) {
+        perror("create socket");
+        return false;
+    }
+
+    sockaddr.sun_family = AF_UNIX;
+    g_strlcpy(sockaddr.sun_path, path, sizeof(sockaddr.sun_path)-1);
+
+    if (connect(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr)) < 0) {
+        perror("failed to connect");
+        return false;
+    }
+
+    qemu_plugin_outs("connect_socket::ready\n");
+
+    socket_fd = fd;
+    return true;
+}
+
+static bool setup_unix_socket(const char *path)
+{
+    if (g_file_test(path, G_FILE_TEST_EXISTS)) {
+        return connect_socket(path);
+    } else {
+        return setup_socket(path);
+    }
+}
+
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    if (!argc || !argv[0]) {
+        qemu_plugin_outs("Need a socket path to talk to other instance.");
+        return -1;
+    }
+
+    if (!setup_unix_socket(argv[0])) {
+        qemu_plugin_outs("Failed to setup socket for communications.");
+        return -1;
+    }
+
+    our_id = id;
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    return 0;
+}
diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
index 75467b6db8..b3250e2504 100644
--- a/tests/plugin/Makefile
+++ b/tests/plugin/Makefile
@@ -13,6 +13,7 @@ NAMES += mem
 NAMES += hotblocks
 NAMES += howvec
 NAMES += hotpages
+NAMES += lockstep
 
 SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
 
-- 
2.20.1



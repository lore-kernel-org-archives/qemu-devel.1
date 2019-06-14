Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF0FC31E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:00:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3BC72183E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FsDqUtUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BC72183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53936 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbqUo-0003tD-5Z
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 14:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58675)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpqj-0005bu-9i
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpqe-000783-KF
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:48 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39878)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbpqe-0006fC-3P
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:44 -0400
Received: by mail-wm1-x344.google.com with SMTP id z23so3054935wma.4
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ePNB7fMxER8fpxE4Yb4C2baLVHXAfUjyVC7rsoU1lSM=;
 b=FsDqUtUjD4LnyXrNK1AXGYb/CqVAuQ0Y4D2tUE/Wt7OWqWc5QestQaLwg8zAJAp2H3
 d+62SsPi6gaVIWTjM4fK/OzOTwpSgz+svCuH0Z1FV9I53hnb33apW8godXC8poFc1dMs
 4L4sVVRFlCTOQ8E3u3CfyrU6/SjIrbSoER2rsict6zoQ4uzavJb59LejPQPA1NSs07xd
 e7yY19EfEDN5YWeYTvhUwTXCdgX/5eCoBJXNqmgAsncenAONg2cmZxj4i3GM6K68wsqP
 /Ndoo/iYQTAXm0YNDLEFSfssRIJOL9ccZ6+edKpsVKN1w9voW4D6BSeXzMUAjsci8Byh
 h/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ePNB7fMxER8fpxE4Yb4C2baLVHXAfUjyVC7rsoU1lSM=;
 b=GWZC/XjTCwokX5STKWTWM9AAAFKirYVn4dBa93bcUGnZPG9PPA0HEzbl+FBTY5wMwu
 Goe1W3atD6NgyvR68F9MNBMbmZh1yMAZPip6/hha5/3uHnFAfLCtjatzGDjUCDYpgHmt
 YCcTfNW5TPnkrouyFfDU2bYpEk3z+UqsKxgEOeZxV4F9WmDkki9LAYpORNGWmEDdQZIV
 gN3XuzVAktZDAzw5EvNgyT+zVwqwvSiFV/yPc21SSyRGcl0MWgJJ6W9gEDfLDbictNJ1
 A6CsM6PApRjFliz1NhcZAUvmAaVKR8ZfnL1RA7v4zERJtqcW9eqAJiBfEgWXOllar+2D
 GcDQ==
X-Gm-Message-State: APjAAAX6h+LMkhPO5KEl+Dz9aei0T7BcjbnTtB0ZmY1kW5kKdKetvAU0
 LGqCgNR4RKenG282VdWqnqmB5g==
X-Google-Smtp-Source: APXvYqw8gwtsGMuDacw+jESeSyhKn2bpfqd0YYL9O+VE0Y/Lfe1WcVRT62k5Vi8nr5+MZlwmrpfLGA==
X-Received: by 2002:a1c:452:: with SMTP id 79mr9021511wme.149.1560532709802;
 Fri, 14 Jun 2019 10:18:29 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o8sm4744500wrj.71.2019.06.14.10.18.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:18:27 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5211B1FFC3;
 Fri, 14 Jun 2019 18:12:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:53 +0100
Message-Id: <20190614171200.21078-44-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v3 43/50] tests/plugin: add a hotblocks plugin
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a simple plugin to track which translation blocks are call
most often. As we don't have a view of the internals of TCG we can
only work by the address of the start of the block so we also need to
tracks how often the address is translated.

As there will be multiple blocks starting at the same address. We can
try and work around this by futzing the value to feed to the hash with
the insn count.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/plugin/Makefile    |   1 +
 tests/plugin/hotblocks.c | 145 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 146 insertions(+)
 create mode 100644 tests/plugin/hotblocks.c

diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
index f9a3546ea3..e74940eaac 100644
--- a/tests/plugin/Makefile
+++ b/tests/plugin/Makefile
@@ -10,6 +10,7 @@ NAMES += bb
 NAMES += empty
 NAMES += insn
 NAMES += mem
+NAMES += hotblocks
 
 SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
 
diff --git a/tests/plugin/hotblocks.c b/tests/plugin/hotblocks.c
new file mode 100644
index 0000000000..acb890e320
--- /dev/null
+++ b/tests/plugin/hotblocks.c
@@ -0,0 +1,145 @@
+/*
+ * Copyright (C) 2019, Alex Bennée <alex.bennee@linaro.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#include <inttypes.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <inttypes.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <glib.h>
+
+#include <qemu-plugin.h>
+
+static bool do_inline;
+static int stdout_fd;
+
+/* Plugins need to take care of their own locking */
+static GMutex lock;
+static GHashTable *hotblocks;
+static guint64 limit = 20;
+
+/*
+ * Counting Structure
+ *
+ * The internals of the TCG are not exposed to plugins so we can only
+ * get the starting PC for each block. As a result we will see
+ * multiple translations at the same PC, we aggregate them here.
+ */
+typedef struct {
+    uint64_t start_addr;
+    uint64_t exec_count;
+    int      trans_count;
+    unsigned long insns;
+} ExecCount;
+
+static gint cmp_exec_count(gconstpointer a, gconstpointer b)
+{
+    ExecCount *ea = (ExecCount *) a;
+    ExecCount *eb = (ExecCount *) b;
+    return ea->exec_count > eb->exec_count ? -1 : 1;
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    GString *report = g_string_new("collected ");
+    GList *counts, *it;
+    int i;
+
+    g_mutex_lock(&lock);
+    g_string_append_printf(report, "%d entries in the hash table\n",
+                           g_hash_table_size(hotblocks));
+    counts = g_hash_table_get_values(hotblocks);
+    it = g_list_sort(counts, cmp_exec_count);
+
+    for (i = 0; i < limit && it->next; i++, it = it->next) {
+        ExecCount *rec = (ExecCount *) it->data;
+        g_string_append_printf(report, "  pc: %#" PRIx64 " (%d block%s, %ld insns, %" PRId64" total hits)\n",
+                               rec->start_addr,
+                               rec->trans_count, rec->trans_count < 2 ? "" : "s",
+                               rec->insns, rec->exec_count);
+    }
+
+    g_mutex_unlock(&lock);
+    g_list_free(it);
+
+    dprintf(stdout_fd, "%s", report->str);
+    g_string_free(report, true);
+}
+
+static void plugin_init(void)
+{
+    hotblocks = g_hash_table_new(NULL, g_direct_equal);
+}
+
+static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
+{
+    ExecCount *cnt;
+    uint64_t cheap_hash = (uint64_t) udata;
+
+    g_mutex_lock(&lock);
+    cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) cheap_hash);
+    /* should always succeed */
+    g_assert(cnt);
+    cnt->exec_count++;
+    g_mutex_unlock(&lock);
+}
+
+/*
+ * When do_inline we ask the plugin to increment the counter for us.
+ * Otherwise a helper is inserted which calls the vcpu_tb_exec
+ * callback.
+ */
+static void vcpu_tb_trans(qemu_plugin_id_t id, unsigned int cpu_index,
+                          struct qemu_plugin_tb *tb)
+{
+    ExecCount *cnt;
+    uint64_t pc = qemu_plugin_tb_vaddr(tb);
+    unsigned long insns = qemu_plugin_tb_n_insns(tb);
+    uint64_t cheap_hash = pc ^ insns;
+
+    g_mutex_lock(&lock);
+    cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) cheap_hash);
+    if (cnt) {
+        cnt->trans_count++;
+    } else {
+        cnt = g_new0(ExecCount, 1);
+        cnt->start_addr = pc;
+        cnt->trans_count = 1;
+        cnt->insns = insns;
+        g_hash_table_insert(hotblocks, (gpointer) cheap_hash, (gpointer) cnt);
+    }
+
+    g_mutex_unlock(&lock);
+
+    if (do_inline) {
+        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
+                                                 &cnt->exec_count, 1);
+    } else {
+        qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
+                                             QEMU_PLUGIN_CB_NO_REGS,
+                                             (void *)cheap_hash);
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
+    plugin_init();
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    return 0;
+}
-- 
2.20.1



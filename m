Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738EFC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40763206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gexkOurS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40763206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrXA-00057Y-Gn
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45209)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPn-000527-ND
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPm-0000N0-Fh
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:23 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53598)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrPm-0000MG-8n
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:22 -0400
Received: by mail-wm1-x342.google.com with SMTP id x15so61507168wmj.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=898tEWdGiv953asq1ongyZK/wyng6GChLBGHElMvPoQ=;
 b=gexkOurS8jNsbNusFYOIW6SeQiWs1BjBexsFvouTeFiDNAIFY/PSUuP1bKrqNMDCQ1
 KJYUlPMI7Yei5R8KvuZkJek1A5rMUCn0nQM1LZZqGsYvvcDOlsPcMVsfBQsVkYZ9z4/9
 ugktaMsy+VsFhW2v1NNl4BV/7tP33kgZnMAg2yvXXuJyVM2H135AxWGlxQK19C/UpbTP
 OeMjEBItE8Peu/WjPcE7OyLtIq8SWHc6vXRUtJESaz9bwxNTQF9dQamKRSS95jAbfvHM
 taAbmFqT+SiE8QBBE5YLY515Pj3UYnhhvrP+Wq96SFTeDpirJhwWVSSLEmJTeXxOpIAo
 SWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=898tEWdGiv953asq1ongyZK/wyng6GChLBGHElMvPoQ=;
 b=WolpCh51rWnPK8UtxZyqKxyMTp7iQQFqsUC1ZdVoaA3XUMVMLMZlIkeNf3ATQLI56D
 +bu3gTjuSs2mMs9tXzmjRBElqnpmnAHoIPJVlFZZ/chN9WajI1r21SDMa9sbgrd2aS80
 0NJ8u7Py2N/Bw3MKkoTFUtDXJVecSXy7z76EGYSEywAvXpF+lXORULNccMJ/pMrqmhbs
 D/tzfSoxZ13iwFa4AqqaKVVzTrz++y3qKFhHOUWHC6nqTpuWNtnHARLCZKUszJ2q6g5l
 0ditOxKNbF6sFEgXJ2CbcwSHUnCqdoyBj6VFt6rrJGqo/xnsH3XcO2DXc0emKQ4n+Ugr
 dICQ==
X-Gm-Message-State: APjAAAVrVi7+ShTnsK77P8eW44wNfecZC93UGcuECKf+02TVPi1uzSMB
 WFAHJldQEyDwo7/3idDgj+a8ig==
X-Google-Smtp-Source: APXvYqzk/p2MlFFfstjPpWfDlo9YswlPRmvPD+VXlyUGmgVleNaUaVzyIkpfzvX/XKpsgcvA4VxsgQ==
X-Received: by 2002:a05:600c:230c:: with SMTP id
 12mr14294064wmo.151.1564590321196; 
 Wed, 31 Jul 2019 09:25:21 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id q193sm54698640wme.8.2019.07.31.09.25.15
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:25:17 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E58F51FFC6;
 Wed, 31 Jul 2019 17:07:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:07:13 +0100
Message-Id: <20190731160719.11396-49-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v4 48/54] tests/plugin: add a hotblocks plugin
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
Cc: bobby.prani@gmail.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 aaron@os.amperecomputing.com
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
 tests/plugin/hotblocks.c | 146 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)
 create mode 100644 tests/plugin/hotblocks.c

diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
index f9a3546ea32..e74940eaac5 100644
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
index 00000000000..3654afbc887
--- /dev/null
+++ b/tests/plugin/hotblocks.c
@@ -0,0 +1,146 @@
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
+ * get the starting PC for each block. We cheat this slightly by
+ * xor'ing the number of instructions to the hash to help
+ * differentiate.
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
+    g_string_append_printf(report, "pc, tcount, icount, ecount\n");
+
+    for (i = 0; i < limit && it->next; i++, it = it->next) {
+        ExecCount *rec = (ExecCount *) it->data;
+        g_string_append_printf(report, "%#016"PRIx64", %d, %ld, %"PRId64"\n",
+                               rec->start_addr, rec->trans_count,
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
+    uint64_t hash = (uint64_t) udata;
+
+    g_mutex_lock(&lock);
+    cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
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
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    ExecCount *cnt;
+    uint64_t pc = qemu_plugin_tb_vaddr(tb);
+    unsigned long insns = qemu_plugin_tb_n_insns(tb);
+    uint64_t hash = pc ^ insns;
+
+    g_mutex_lock(&lock);
+    cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
+    if (cnt) {
+        cnt->trans_count++;
+    } else {
+        cnt = g_new0(ExecCount, 1);
+        cnt->start_addr = pc;
+        cnt->trans_count = 1;
+        cnt->insns = insns;
+        g_hash_table_insert(hotblocks, (gpointer) hash, (gpointer) cnt);
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
+                                             (void *)hash);
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



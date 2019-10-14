Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984D6C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:28:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E5CB20673
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKHSn+DL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5CB20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyWb-0007NF-8H
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy2B-0006fH-Ec
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy29-0005Aj-QG
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:03 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34513)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJy29-00058x-Hr
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:01 -0400
Received: by mail-wm1-x341.google.com with SMTP id y135so14227108wmc.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ouNEnxImoHWm/wNyLGaSm67QiP36d/93Hs/vzEx9qe0=;
 b=SKHSn+DL+ng4qlmoynBsiGbH9Azsi1Xdh+ct127aWpKhh+BQb3kZ1asd6U24F5Naxl
 NhItxw4YbYFwKJK3BYhtJz1k2cfMdyJHyif519PJaaf6/Gjuw9XTJNYi55PORgR7yqDD
 +TskcI3Mro0hkR8deZEPJx3i/AIQxSadcadb2QWaePDjNAQfmU/bUtbLW7cxsYmgPtbo
 ytg6a/CZtqjwEdUhnaWn+hcVIgICihpniZIZf2b/sdCZlO4lvhsdQMYUnlAs2ynuE3t6
 Kfbs6by66Gb7L0ysf1WbAF3u+Wo3ijKMS0WEH7B3cwalhBM80tt4YnTvSoR8S9BWY7CT
 V1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ouNEnxImoHWm/wNyLGaSm67QiP36d/93Hs/vzEx9qe0=;
 b=BFMVqYROXTd0NNC4Iluor45Yn1v/eQn53jNS45lvkJU40N0Ka/h0ra9ss4X7iY/joZ
 bCv+d3SBWocxHOdrVlSc4iVT0gffpTzu5otAbM9wmm9ijr52EsCdJu+uKF1z3/9oKywD
 pIk1927Lmb5LX8W2wzDVQxP0rJYKuH8FBpaAqRtUqlzdqkC5IKJiSPfKnVdUVcZEnHLb
 n2m2MfZFDomtL3kdI9cDh/7VXQ+l2CoZzDTh7oiQ5IxpxIMF32cRY6yLVzP0BLoWKl4/
 xTJL4AvhYeFqCPDTTgYrdKkdJjZxfaGMQlFm3SkEmsR7pI9ktYoymL+0mI7Okgr7/unx
 n8PA==
X-Gm-Message-State: APjAAAV9ZiGusI3eBuEOBj2dUmQ1u7qq8+FwhkVyuigfUwo5SQtEsiqs
 WW6l8efxUAyz1B5NJq9jMz8IDA==
X-Google-Smtp-Source: APXvYqyrG9R0GEghCulVC8xqX27IaWRMMsGsPmr+eydxF+vyTlIvWeSmvZUMD5gqhHwsi1j7S2lbMQ==
X-Received: by 2002:a7b:c206:: with SMTP id x6mr7007965wmi.147.1571050620018; 
 Mon, 14 Oct 2019 03:57:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f9sm21400754wre.74.2019.10.14.03.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:56:56 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0D94C1FF99;
 Mon, 14 Oct 2019 11:49:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 45/55] tests/plugin: add a hotblocks plugin
Date: Mon, 14 Oct 2019 11:49:38 +0100
Message-Id: <20191014104948.4291-46-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 robert.foley@futurewei.com, peter.puhov@futurewei.com
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
v5
  - handle 0 length report
---
 tests/plugin/Makefile    |   1 +
 tests/plugin/hotblocks.c | 148 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+)
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
index 0000000000..a150179a5c
--- /dev/null
+++ b/tests/plugin/hotblocks.c
@@ -0,0 +1,148 @@
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
+    if (it) {
+        g_string_append_printf(report, "pc, tcount, icount, ecount\n");
+
+        for (i = 0; i < limit && it->next; i++, it = it->next) {
+            ExecCount *rec = (ExecCount *) it->data;
+            g_string_append_printf(report, "%#016"PRIx64", %d, %ld, %"PRId64"\n",
+                                   rec->start_addr, rec->trans_count,
+                                   rec->insns, rec->exec_count);
+        }
+
+        g_list_free(it);
+        g_mutex_unlock(&lock);
+    }
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



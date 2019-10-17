Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C1AECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEFD62082C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SC8qN0Q/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFD62082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6DI-0000r4-Mi
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mV-0002Hp-FW
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5mU-0001Hr-2d
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:31 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:53409)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5mT-0001HP-S1
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:25:30 -0400
Received: by mail-wm1-x32a.google.com with SMTP id i16so2564614wmd.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2I9Xg4qOydxt2Irqp2d5IKEYfjCajVr5MTKGy7FknVU=;
 b=SC8qN0Q/Mg/qkl7yS7oEgA6MzUQqgH8zj4IUo8bCf4WjlZhT5PrZYFs6bqJTg9iB3H
 xp5UZWt61Qy28ReYoZ29Ui/WZKudfG6oFNLp/95mXnD3vou3E0ZmhaVFfNClUXOB7pna
 jthDjALf5lV8q10E9S/d0+vCzrV3eSA06QRV1xk19ewvkwCETBh+WSXGTWGqxD+vEyGB
 ixgmoxYj5wSJcIVhEG45OVSO4GpMbx94XZ7AxcUtUPPi9B7oXjPLOrQbTtbwbnk5KXGN
 /WKqHAU1YpViFd96DVojtcncp46asazssDwk4BwNLAHqvM31gap+lXlqBmkxvQyZX9i6
 c8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2I9Xg4qOydxt2Irqp2d5IKEYfjCajVr5MTKGy7FknVU=;
 b=saloc1i9nJoJEo+cawvx1+qkTAtiwNtF2JYUhYc5vlcgRjdava3ytRAFcjJDR8S18t
 rQrua0LSMUr9gelg/AzuShn/U6EayfokunPG4Uq44LzNpA+5I51CilPVIL2K10O8tG7O
 dA+EOXccFFzfoKXe3qojX/8MORRYCXo9dbHhfAxu5Jjro/JSVHs99Gd47roNPvWNTq6U
 WVj4ws1uyOMbTIYNLckxIEcfmX9OjNR4sKXzLXlWhPM955GYx2mCiGIih9DKM2MOOCeC
 KiG+EPbvzJotqIjGarQQ36hRTqi4CcF9O+EUcfEq3vYW5x5N31MfQfYAR+fjvSC2WU0w
 W68g==
X-Gm-Message-State: APjAAAUGYDWVrqvdoxPOIg1D1NB3zQ59rhgU9XixNPUsbJOcbHvmbQcM
 JnvXjhdv9N3K0RZzOgpXsZlAxw==
X-Google-Smtp-Source: APXvYqxqzSqnfaTfImoWOId1ZC0HZZayvZT2IjIVfhtnXA/kim4BMVYp97057K1K9nV852ngrqYhlQ==
X-Received: by 2002:a7b:c938:: with SMTP id h24mr2912915wml.117.1571318728580; 
 Thu, 17 Oct 2019 06:25:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y186sm2689296wmb.41.2019.10.17.06.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:25:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6C3471FFC6;
 Thu, 17 Oct 2019 14:16:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 48/54] tests/plugin: add a hotblocks plugin
Date: Thu, 17 Oct 2019 14:16:09 +0100
Message-Id: <20191017131615.19660-49-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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

This is a simple plugin to track which translation blocks are call
most often. As we don't have a view of the internals of TCG we can
only work by the address of the start of the block so we also need to
tracks how often the address is translated.

As there will be multiple blocks starting at the same address. We can
try and work around this by futzing the value to feed to the hash with
the insn count.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v5
  - handle 0 length report
v6
  - init api update
  - use plugin_outs

squash! tests/plugin: add a hotblocks plugin
---
 tests/plugin/Makefile    |   1 +
 tests/plugin/hotblocks.c | 143 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+)
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
index 0000000000..1bd183849a
--- /dev/null
+++ b/tests/plugin/hotblocks.c
@@ -0,0 +1,143 @@
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
+    g_autoptr(GString) report = g_string_new("collected ");
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
+    qemu_plugin_outs(report->str);
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
+QEMU_PLUGIN_EXPORT
+int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
+                        int argc, char **argv)
+{
+    if (argc && strcmp(argv[0], "inline") == 0) {
+        do_inline = true;
+    }
+
+    plugin_init();
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    return 0;
+}
-- 
2.20.1



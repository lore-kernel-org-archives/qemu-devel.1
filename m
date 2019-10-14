Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F46ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7B6206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lns6ajTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7B6206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyeR-00081r-CP
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy2E-0006n1-Rb
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy2D-0005FB-EU
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:06 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJy2C-0005DK-SV
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:05 -0400
Received: by mail-wr1-x441.google.com with SMTP id j18so19147263wrq.10
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ye+x/1nnHia5cN2gZpTEgLE2DtA5hK08gljlzreXCM8=;
 b=Lns6ajTccNlQWQJkH+x1Ht04T+FIXEVgxdMYSH7Wbuc8WU56z/9PAWkFtK3Pto6FDv
 YYmiPeIZ5Z5qv9/P6bAiBpzT2YEf1jAYSLRu7PL/0B2mt3DoJhc0Yu6mcV74QdERKQF5
 Y91EHWMnLv6AKRtbUIsQuy8lbSaovC//fdq9D0VBQGUAvjxqo7eyxA/Okq/QxuH9McPD
 0KerWVd7JKmCzsX2XmfW5bHtLrKPJNTomxzMBjcEvOMF8pBE5braLPdI0KJU0LDEu/pr
 +fGbmog8T8XS58Wcq1Q4amABYazSBNQRm7OEKSdb6GB/ss9TakdvOFgJuambHy64W3SE
 7X8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ye+x/1nnHia5cN2gZpTEgLE2DtA5hK08gljlzreXCM8=;
 b=Hbo/LZkZZ5EpaygYAim2ZWpeJeJKgV5OqzTkx3dpzjXsovMuEeF+cZKWrL7iCp90fx
 japHUaIs2gGOQh36l02ne3jhJtRSuOA0Rv4uYk4egTtHTnryOPab2VWUn0o0+9+l9UnD
 +EzudjnUWQOBeYHzsbqkdkEZ+HC9CYrCs+355/owspmn808VgFMDnfs8b8FyIIMxMJyM
 PthZZsYUjvAfv3QmSmb6yQ2mFL/aAupNu8HMNRd1yHRAmum04OkQN/kFZBz/8qyuNOOR
 oucUXgkE+D3AqYJ99+TQb+zSavMx0vpZwtXr9Fep91hQcCc7K3gzJe9QLYvEhpPEZ79c
 SIlw==
X-Gm-Message-State: APjAAAXaJpuVNxtbI8PdP2M+/QWBXEKD9JsZKVic/om2TbtnvAxNgKOX
 4JPLNJ7mzLafebfD4Dx8i6SbjzaiCL0=
X-Google-Smtp-Source: APXvYqzZqCHuG42EdrYTaDC2cR3avfNgkYtzmHyO9KM6VgqvryFAWiBSJi0g1dgKeeLvoIcmPlATBw==
X-Received: by 2002:a5d:43c1:: with SMTP id v1mr25996208wrr.91.1571050623389; 
 Mon, 14 Oct 2019 03:57:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c21sm13133247wmb.46.2019.10.14.03.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:57:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B7E301FFD3;
 Mon, 14 Oct 2019 11:49:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 48/55] tests/plugin: add hotpages plugin to breakdown
 memory access patterns
Date: Mon, 14 Oct 2019 11:49:41 +0100
Message-Id: <20191014104948.4291-49-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

This plugin gives a break down of access patterns grouped into pages.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
   - tweaks for new hwaddr api
   - add sorting and pagesize selection args
---
 tests/plugin/Makefile   |   1 +
 tests/plugin/hotpages.c | 179 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 180 insertions(+)
 create mode 100644 tests/plugin/hotpages.c

diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
index 3656429d46..75467b6db8 100644
--- a/tests/plugin/Makefile
+++ b/tests/plugin/Makefile
@@ -12,6 +12,7 @@ NAMES += insn
 NAMES += mem
 NAMES += hotblocks
 NAMES += howvec
+NAMES += hotpages
 
 SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
 
diff --git a/tests/plugin/hotpages.c b/tests/plugin/hotpages.c
new file mode 100644
index 0000000000..13ce8ffeb8
--- /dev/null
+++ b/tests/plugin/hotpages.c
@@ -0,0 +1,179 @@
+/*
+ * Copyright (C) 2019, Alex Bennée <alex.bennee@linaro.org>
+ *
+ * Hot Pages - show which pages saw the most memory accesses.
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+
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
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+static uint64_t page_size = 4096;
+static uint64_t page_mask;
+static int stdout_fd;
+static int limit = 50;
+static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
+
+enum sort_type {
+    SORT_RW = 0,
+    SORT_R,
+    SORT_W
+};
+
+static int sort_by = SORT_RW;
+
+typedef struct {
+    uint64_t page_address;
+    int cpu_read;
+    int cpu_write;
+    uint64_t reads;
+    uint64_t writes;
+} PageCounters;
+
+static GMutex lock;
+static GHashTable *pages;
+
+static gint cmp_access_count(gconstpointer a, gconstpointer b)
+{
+    PageCounters *ea = (PageCounters *) a;
+    PageCounters *eb = (PageCounters *) b;
+    int r;
+    switch (sort_by) {
+    case SORT_RW:
+        r = (ea->reads + ea->writes) > (eb->reads + eb->writes) ? -1 : 1;
+        break;
+    case SORT_R:
+        r = ea->reads > eb->reads ? -1 : 1;
+        break;
+    case SORT_W:
+        r = ea->writes > eb->writes ? -1 : 1;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return r;
+}
+
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    GString *report = g_string_new("Addr, RCPUs, Reads, WCPUs, Writes\n");
+    int i;
+    GList *counts;
+
+    counts = g_hash_table_get_values(pages);
+    if (counts && g_list_next(counts)) {
+        GList *it;
+
+        it = g_list_sort(counts, cmp_access_count);
+
+        for (i = 0; i < limit && it->next; i++, it = it->next) {
+            PageCounters *rec = (PageCounters *) it->data;
+            g_string_append_printf(report,
+                                   "%#016"PRIx64", 0x%04x, %"PRId64
+                                   ", 0x%04x, %"PRId64"\n",
+                                   rec->page_address,
+                                   rec->cpu_read, rec->reads,
+                                   rec->cpu_write, rec->writes);
+        }
+        g_list_free(it);
+    }
+
+    dprintf(stdout_fd, "%s", report->str);
+    g_string_free(report, true);
+}
+
+static void plugin_init(void)
+{
+    page_mask = (page_size - 1);
+    pages = g_hash_table_new(NULL, g_direct_equal);
+}
+
+static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
+                       uint64_t vaddr, void *udata)
+{
+    struct qemu_plugin_hwaddr *hwaddr = qemu_plugin_get_hwaddr(meminfo, vaddr);
+    uint64_t page;
+    PageCounters *count;
+
+    /* We only get a hwaddr for system emulation */
+    if (hwaddr) {
+        page = (uint64_t) qemu_plugin_hwaddr_to_raddr(hwaddr);
+    } else {
+        page = vaddr;
+    }
+    page &= ~page_mask;
+
+    g_mutex_lock(&lock);
+    count = (PageCounters *) g_hash_table_lookup(pages, GUINT_TO_POINTER(page));
+
+    if (!count) {
+        count = g_new0(PageCounters, 1);
+        count->page_address = page;
+        g_hash_table_insert(pages, GUINT_TO_POINTER(page), (gpointer) count);
+    }
+    if (qemu_plugin_mem_is_store(meminfo)) {
+        count->writes++;
+        count->cpu_write |= (1 << cpu_index);
+    } else {
+        count->reads++;
+        count->cpu_read |= (1 << cpu_index);
+    }
+
+    g_mutex_unlock(&lock);
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    size_t n = qemu_plugin_tb_n_insns(tb);
+    size_t i;
+
+    for (i = 0; i < n; i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+        qemu_plugin_register_vcpu_mem_cb(insn, vcpu_haddr,
+                                         QEMU_PLUGIN_CB_NO_REGS,
+                                         rw, NULL);
+    }
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
+                                           char **argv)
+{
+    int i;
+
+    /* to be used when in the exit hook */
+    stdout_fd = dup(STDOUT_FILENO);
+    assert(stdout_fd);
+
+    for (i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        if (g_strcmp0(opt, "reads") == 0) {
+            sort_by = SORT_R;
+        } else if (g_strcmp0(opt, "writes") == 0) {
+            sort_by = SORT_W;
+        } else if (g_str_has_prefix(opt, "pagesize=")) {
+            page_size = g_ascii_strtoull(opt + 9, NULL, 10);
+        } else {
+            dprintf(stdout_fd, "option parsing failed: %s\n", opt);
+            return -1;
+        }
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



Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEB4CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10B420867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rQdLN9LL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10B420867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNu8k-0004wD-7X
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWZ-0003ML-8C
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWX-0007eG-HA
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:39 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:45945)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtWX-0007dj-AZ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:37 -0400
Received: by mail-wr1-x436.google.com with SMTP id q13so937125wrs.12
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pfQAx5RZvYEJHOBZFdvbNXzxHOiZtn/smcq9fr6c6xw=;
 b=rQdLN9LL7OSVSBNwRt42fhy6eOOZvLF+fTCCcGBq2hqN3SH8cHRn+AyGf8sQ7tmner
 femniAfqG6UYFI5hOwU8B/1octAeyrCa11tqMsNB0YOmWxgJnTrnU3DF0whJQxEZsTmd
 8DufYLTM/q6cPrLDrGkkVrikdMx1anB5BNdRx31/r0wxro9qaWxvL1sh0LO8AtFj+gct
 +8SgV5biM7hZRDch7AZljkeM168LLob4LUFMXdTcy0QBzkcLcMxJfxQzAGrUnlR1HeuU
 LUJdU3NM74JKlPoXnFd8NKX999vlUH+K7MFQmsY+1QGZR/zMPrR59qQ62Puv2h2/kPKG
 yPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pfQAx5RZvYEJHOBZFdvbNXzxHOiZtn/smcq9fr6c6xw=;
 b=SuOZlfFQ15ks0ujf07U9S5Qx9iUZlIRukbeon1pjN0Av4Q8ICLbXZPzF+0H6HIcDYk
 ELP6wHwFo0s5sDssX/XTMKVM9ACm1HibBjd3LiRKiftvzop54QgnWBhZhOsoFkUXX94s
 RHk4uquzYLe2weTWMQgNEO3BcpZ0oI/ERySzgEi8dIGnFFmkaqds9SERp/HbXfX66oie
 FyMJkVKj9FnXmKjs8VLkKTYPJAib/gWC98m5dzbAwv16vhhoHzznOVbacmOkY6mDkVvv
 s0EuBPARKHVFeGjLmjG5bX737ZhcPXc3ImKfV5jNHxxfJGqq0yoeDeh9Y4WP06fzyJbg
 U6EQ==
X-Gm-Message-State: APjAAAXP7Ot2okIh9+3R4zD4ZkNyYE+sCxJEmSn//CQBEoOUAkxT5hvf
 VptmIBP/sdgTgBg89vN3ZCDJ4w==
X-Google-Smtp-Source: APXvYqyf/H8O2WHnlc6exp7bfrHqRpoI73xr/VlMrOVUF5yEXbmyzn6tnl1bx8ZOI5Yq2ur3Tva2og==
X-Received: by 2002:adf:ea01:: with SMTP id q1mr1300847wrm.240.1571986596106; 
 Thu, 24 Oct 2019 23:56:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g10sm1244118wrr.28.2019.10.24.23.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:56:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0E7841FFD9;
 Fri, 25 Oct 2019 07:37:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 67/73] tests/plugin: add hotpages to analyse memory access
 patterns
Date: Fri, 25 Oct 2019 07:37:07 +0100
Message-Id: <20191025063713.23374-68-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This plugin gives a summary of access patterns grouped by "pages" and
showing read/write patterns by vCPUS.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
index 3656429d46b..75467b6db85 100644
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
index 00000000000..77df07a3ccf
--- /dev/null
+++ b/tests/plugin/hotpages.c
@@ -0,0 +1,191 @@
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
+static int limit = 50;
+static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
+static bool track_io;
+
+enum sort_type {
+    SORT_RW = 0,
+    SORT_R,
+    SORT_W,
+    SORT_A
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
+    case SORT_A:
+        r = ea->page_address > eb->page_address ? -1 : 1;
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
+    g_autoptr(GString) report = g_string_new("Addr, RCPUs, Reads, WCPUs, Writes\n");
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
+    qemu_plugin_outs(report->str);
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
+    if (track_io) {
+        if (hwaddr && qemu_plugin_hwaddr_is_io(hwaddr)) {
+            page = vaddr;
+        } else {
+            return;
+        }
+    } else {
+        if (hwaddr && !qemu_plugin_hwaddr_is_io(hwaddr)) {
+            page = (uint64_t) qemu_plugin_hwaddr_device_offset(hwaddr);
+        } else {
+            page = vaddr;
+        }
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
+QEMU_PLUGIN_EXPORT
+int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
+                        int argc, char **argv)
+{
+    int i;
+
+    for (i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        if (g_strcmp0(opt, "reads") == 0) {
+            sort_by = SORT_R;
+        } else if (g_strcmp0(opt, "writes") == 0) {
+            sort_by = SORT_W;
+        } else if (g_strcmp0(opt, "address") == 0) {
+            sort_by = SORT_A;
+        } else if (g_strcmp0(opt, "io") == 0) {
+            track_io = true;
+        } else if (g_str_has_prefix(opt, "pagesize=")) {
+            page_size = g_ascii_strtoull(opt + 9, NULL, 10);
+        } else {
+            fprintf(stderr, "option parsing failed: %s\n", opt);
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



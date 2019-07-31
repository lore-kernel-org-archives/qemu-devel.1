Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EA2C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC0E206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ib3eNgFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC0E206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrOS-0000WV-Hr
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42509)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrGA-00068W-Th
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG8-0004CZ-V2
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:40609)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrG8-0004Bl-NC
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:24 -0400
Received: by mail-wm1-x32c.google.com with SMTP id v19so60387930wmj.5
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xwP+mV0r3qT985xxGF4TCqT0a6cc9tGilhISQJihOk8=;
 b=ib3eNgFRsowNuceFgiSQlQ3r2izO2U77qb3q2+PRrv2Fb5i3/T+lFFh8nKNfWbDqYG
 V8PUbSTC7kaVzYa96HSn/7B7JGm1YvFfaOwQ1DRUOctmE/hsMQEhuQh/EfadbrwnPY1K
 /IEOujmnF5RN8p5Ym7t9k2b7IH5KQeYPSo9K69w8gd/mQSkG9EkBDTIhMTCNoXZMPIHv
 3dD2Sys8GJ9Zw0+Sudo0bWxxDEdECAEGQqXde6nat5/JmDlgpznR22ooIoI8CyS0RpKA
 tnIKIPc3y/SNePcPmPk/m5396X2yvD0vBBy1ZbDWS4rfDRTk6jqzdzucnoS6FqWg3FYf
 Xlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xwP+mV0r3qT985xxGF4TCqT0a6cc9tGilhISQJihOk8=;
 b=sD1aCgmuqBQhPFE02fJhIEwkLvwLW23XxJZOumt2V2keLw9tKKdgXo+SeBL2FnZ9xh
 3H/5UfWcCEuSPt5vyHZOdubrS9zgTC7KCOzy0o1C+D7LhequMo7GNsPYYydcDq1sVlTC
 NAqwp3kWcTsNbHro6MPUwdOvxZIZA1ZLxRTWMvBx9khHZfvZ6oV/g4w3DBNiJMoIxI4Y
 vrw5JHfFH+bJx7981c6qS7fpNeL7nqiOh+YIQeZwDb80WDAamlCV3dvOLscAzWAZas6B
 BENN4zYa2JYknmVEg3FVXGrYaesGc2J/cP0c1iQGAkwVOXBDlLxyN0RMuTd4c6XPb1I/
 rKQQ==
X-Gm-Message-State: APjAAAVCoi4rVva50Ri9jzr6sn6iGvZCdgVBV6D7MZk5a4yazGisLIng
 /EjEUhbG7S6VJkfLXR54XF9LYA==
X-Google-Smtp-Source: APXvYqw5SnAM0P2MRNGTZrpZD9RrGxfHaM79RruQ2iUySw07WKKx2HCOMAhQB8UxC116gPhSJHd9lw==
X-Received: by 2002:a1c:c5c2:: with SMTP id
 v185mr118307155wmf.161.1564589723370; 
 Wed, 31 Jul 2019 09:15:23 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id z25sm71736508wmf.38.2019.07.31.09.15.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:15:18 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1E31B1FFC8;
 Wed, 31 Jul 2019 17:07:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:07:15 +0100
Message-Id: <20190731160719.11396-51-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
Subject: [Qemu-devel] [PATCH v4 50/54] tests/plugin: add instruction
 execution breakdown
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

This gives a break down of instruction classes and individual
instruction types.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/plugin/Makefile |   1 +
 tests/plugin/howvec.c | 301 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 302 insertions(+)
 create mode 100644 tests/plugin/howvec.c

diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
index e74940eaac5..3656429d46b 100644
--- a/tests/plugin/Makefile
+++ b/tests/plugin/Makefile
@@ -11,6 +11,7 @@ NAMES += empty
 NAMES += insn
 NAMES += mem
 NAMES += hotblocks
+NAMES += howvec
 
 SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
 
diff --git a/tests/plugin/howvec.c b/tests/plugin/howvec.c
new file mode 100644
index 00000000000..accf8611ff4
--- /dev/null
+++ b/tests/plugin/howvec.c
@@ -0,0 +1,301 @@
+/*
+ * Copyright (C) 2019, Alex Bennée <alex.bennee@linaro.org>
+ *
+ * How vectorised is this code?
+ *
+ * Attempt to measure the amount of vectorisation that has been done
+ * on some code by counting classes of instruction. This is very much
+ * ARM specific.
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
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+typedef enum {
+    COUNT_CLASS,
+    COUNT_INDIVIDUAL,
+    COUNT_NONE
+} CountType;
+
+static int limit = 50;
+static int stdout_fd;
+static bool do_inline;
+static bool verbose;
+
+static GMutex lock;
+static GHashTable *insns;
+
+typedef struct {
+    const char *class;
+    const char *opt;
+    uint32_t mask;
+    uint32_t pattern;
+    CountType what;
+    uint64_t count;
+} InsnClassExecCount;
+
+typedef struct {
+    char *insn;
+    uint32_t opcode;
+    uint64_t count;
+    InsnClassExecCount *class;
+} InsnExecCount;
+
+/*
+ * Matchers for classes of instructions, order is important.
+ *
+ * Your most precise match must be before looser matches. If no match
+ * is found in the table we can create an individual entry.
+ */
+InsnClassExecCount insn_classes[] = {
+    /* "Reserved"" */
+    { "  UDEF",              "udef",   0xffff0000, 0x00000000, COUNT_NONE},
+    { "  SVE",               "sve",    0x1e000000, 0x04000000, COUNT_CLASS},
+    { "Reserved",            "res",    0x1e000000, 0x00000000, COUNT_CLASS},
+    /* Data Processing Immediate */
+    { "  PCrel addr",        "pcrel",  0x1f000000, 0x10000000, COUNT_CLASS},
+    { "  Add/Sub (imm,tags)","asit",   0x1f800000, 0x11800000, COUNT_CLASS},
+    { "  Add/Sub (imm)",     "asi",    0x1f000000, 0x11000000, COUNT_CLASS},
+    { "  Logical (imm)",     "logi",   0x1f800000, 0x12000000, COUNT_CLASS},
+    { "  Move Wide (imm)",   "movwi",  0x1f800000, 0x12800000, COUNT_CLASS},
+    { "  Bitfield",          "bitf",   0x1f800000, 0x13000000, COUNT_CLASS},
+    { "  Extract",           "extr",   0x1f800000, 0x13800000, COUNT_CLASS},
+    { "Data Proc Imm",       "dpri",   0x1c000000, 0x10000000, COUNT_CLASS},
+    /* Branches */
+    { "  Cond Branch (imm)", "cndb",   0xfe000000, 0x54000000, COUNT_CLASS},
+    { "  Exception Gen",     "excp",   0xff000000, 0xd4000000, COUNT_CLASS},
+    { "    NOP",             "nop",    0xffffffff, 0xd503201f, COUNT_NONE},
+    { "  Hints",             "hint",   0xfffff000, 0xd5032000, COUNT_CLASS},
+    { "  Barriers",          "barr",   0xfffff000, 0xd5033000, COUNT_CLASS},
+    { "  PSTATE",            "psta",   0xfff8f000, 0xd5004000, COUNT_CLASS},
+    { "  System Insn",       "sins",   0xffd80000, 0xd5080000, COUNT_CLASS},
+    { "  System Reg",        "sreg",   0xffd00000, 0xd5100000, COUNT_CLASS},
+    { "  Branch (reg)",      "breg",   0xfe000000, 0xd6000000, COUNT_CLASS},
+    { "  Branch (imm)",      "bimm",   0x7c000000, 0x14000000, COUNT_CLASS},
+    { "  Cmp & Branch",      "cmpb",   0x7e000000, 0x34000000, COUNT_CLASS},
+    { "  Tst & Branch",      "tstb",   0x7e000000, 0x36000000, COUNT_CLASS},
+    { "Branches",            "branch", 0x1c000000, 0x14000000, COUNT_CLASS},
+    /* Loads and Stores */
+    { "  AdvSimd ldstmult",  "advlsm", 0xbfbf0000, 0x0c000000, COUNT_CLASS},
+    { "  AdvSimd ldstmult++","advlsmp",0xbfb00000, 0x0c800000, COUNT_CLASS},
+    { "  AdvSimd ldst",      "advlss", 0xbf9f0000, 0x0d000000, COUNT_CLASS},
+    { "  AdvSimd ldst++",    "advlssp",0xbf800000, 0x0d800000, COUNT_CLASS},
+    { "  ldst excl",         "ldstx",  0x3f000000, 0x08000000, COUNT_CLASS},
+    { "    Prefetch",        "prfm",   0xff000000, 0xd8000000, COUNT_CLASS},
+    { "  Load Reg (lit)",    "ldlit",  0x1b000000, 0x18000000, COUNT_CLASS},
+    { "  ldst noalloc pair", "ldstnap",0x3b800000, 0x28000000, COUNT_CLASS},
+    { "  ldst pair",         "ldstp",  0x38000000, 0x28000000, COUNT_CLASS},
+    { "  ldst reg",          "ldstr",  0x3b200000, 0x38000000, COUNT_CLASS},
+    { "  Atomic ldst",       "atomic", 0x3b200c00, 0x38200000, COUNT_CLASS},
+    { "  ldst reg (reg off)","ldstro", 0x3b200b00, 0x38200800, COUNT_CLASS},
+    { "  ldst reg (pac)",    "ldstpa", 0x3b200200, 0x38200800, COUNT_CLASS},
+    { "  ldst reg (imm)",    "ldsti",  0x3b000000, 0x39000000, COUNT_CLASS},
+    { "Loads & Stores",      "ldst",   0x0a000000, 0x08000000, COUNT_CLASS},
+    /* Data Processing Register */
+    { "Data Proc Reg",       "dprr",   0x0e000000, 0x0a000000, COUNT_CLASS},
+    /* Scalar FP */
+    { "Scalar FP ",          "fpsimd", 0x0e000000, 0x0e000000, COUNT_CLASS},
+    /* Unclassified */
+    { "Unclassified",        "unclas", 0x00000000, 0x00000000, COUNT_CLASS}
+};
+
+static gint cmp_exec_count(gconstpointer a, gconstpointer b)
+{
+    InsnExecCount *ea = (InsnExecCount *) a;
+    InsnExecCount *eb = (InsnExecCount *) b;
+    return ea->count > eb->count ? -1 : 1;
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    GString *report = g_string_new("Instruction Classes:\n");
+    int i;
+    GList *counts;
+
+    for (i = 0; i < ARRAY_SIZE(insn_classes); i++) {
+        switch (insn_classes[i].what) {
+        case COUNT_CLASS:
+            if (insn_classes[i].count || verbose) {
+                g_string_append_printf(report, "Class: %-24s\t(%ld hits)\n",
+                                       insn_classes[i].class,
+                                       insn_classes[i].count);
+            }
+            break;
+        case COUNT_INDIVIDUAL:
+            g_string_append_printf(report, "Class: %-24s\tcounted individually\n",
+                                   insn_classes[i].class);
+            break;
+        case COUNT_NONE:
+            g_string_append_printf(report, "Class: %-24s\tnot counted\n",
+                                   insn_classes[i].class);
+            break;
+        default:
+            break;
+        }
+    }
+
+    counts = g_hash_table_get_values(insns);
+    if (counts && g_list_next(counts)) {
+        GList *it;
+
+        g_string_append_printf(report,"Individual Instructions:\n");
+
+        it = g_list_sort(counts, cmp_exec_count);
+
+        for (i = 0; i < limit && it->next; i++, it = it->next) {
+            InsnExecCount *rec = (InsnExecCount *) it->data;
+            g_string_append_printf(report, "Instr: %-24s\t(%ld hits)\t(op=%#08x/%s)\n",
+                                   rec->insn,
+                                   rec->count,
+                                   rec->opcode,
+                                   rec->class ?
+                                   rec->class->class : "un-categorised");
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
+    insns = g_hash_table_new(NULL, g_direct_equal);
+}
+
+static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
+{
+    uint64_t *count = (uint64_t *) udata;
+    (*count)++;
+}
+
+static uint64_t * find_counter(struct qemu_plugin_insn *insn)
+{
+    int i;
+    uint64_t *cnt = NULL;
+    uint32_t opcode;
+    InsnClassExecCount *class = NULL;
+
+    /* we expect all instructions to by 32 bits for ARM */
+    g_assert(qemu_plugin_insn_size(insn) == 4);
+    opcode = *((uint32_t *)qemu_plugin_insn_data(insn));
+
+    for (i = 0; !cnt && i < ARRAY_SIZE(insn_classes); i++) {
+        uint32_t masked_bits = opcode & insn_classes[i].mask;
+        if (masked_bits == insn_classes[i].pattern) {
+            class = &insn_classes[i];
+            break;
+        }
+    }
+
+    g_assert(class);
+
+    switch (class->what) {
+    case COUNT_NONE:
+        return NULL;
+    case COUNT_CLASS:
+        return &class->count;
+    case COUNT_INDIVIDUAL:
+    {
+        InsnExecCount *icount;
+
+        g_mutex_lock(&lock);
+        icount = (InsnExecCount *) g_hash_table_lookup(insns,
+                                                       GUINT_TO_POINTER(opcode));
+
+        if (!icount) {
+            icount = g_new0(InsnExecCount, 1);
+            icount->opcode = opcode;
+            icount->insn = qemu_plugin_insn_disas(insn);
+            icount->class = class;
+
+            if (verbose) {
+                dprintf(stdout_fd, "adding for %s (%#08x @ %#20lx from %s)\n",
+                        icount->insn, opcode, qemu_plugin_insn_vaddr(insn),
+                        class->class);
+            }
+            g_hash_table_insert(insns, GUINT_TO_POINTER(opcode),
+                                (gpointer) icount);
+        }
+        g_mutex_unlock(&lock);
+
+        return &icount->count;
+    }
+    default:
+        g_assert_not_reached();
+    }
+
+    return NULL;
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    size_t n = qemu_plugin_tb_n_insns(tb);
+    size_t i;
+
+    for (i = 0; i < n; i++) {
+        uint64_t *cnt;
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+        cnt = find_counter(insn);
+
+        if (cnt) {
+            if (do_inline) {
+                qemu_plugin_register_vcpu_insn_exec_inline(
+                    insn, QEMU_PLUGIN_INLINE_ADD_U64, cnt, 1);
+            } else {
+                qemu_plugin_register_vcpu_insn_exec_cb(
+                    insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS, cnt);
+            }
+        }
+    }
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
+                                           char **argv)
+{
+    int i;
+
+    for (i = 0; i < argc; i++) {
+        char *p = argv[i];
+        if (strcmp(p, "inline") == 0) {
+            do_inline = true;
+        } else if (strcmp(p, "verbose") == 0) {
+            verbose = true;
+        } else {
+            int j;
+            CountType type = COUNT_INDIVIDUAL;
+            if (*p == '!') {
+                type = COUNT_NONE;
+                p++;
+            }
+            for (j = 0; j < ARRAY_SIZE(insn_classes); j++) {
+                if (strcmp(p, insn_classes[j].opt) == 0) {
+                    insn_classes[j].what = type;
+                    break;
+                }
+            }
+        }
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



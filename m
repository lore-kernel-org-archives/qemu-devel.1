Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299D8C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:16:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBDE920663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MKDcZtTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBDE920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyKg-0000Ol-E6
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvY-0007da-2s
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvW-0006Lk-3Y
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:11 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJxvV-0006Ke-Sq
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:10 -0400
Received: by mail-wr1-x443.google.com with SMTP id y18so9677718wrn.5
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wSPReI6vXrdAyz5OkGAAu64UwO/gQv+p6h6aCIL3M10=;
 b=MKDcZtTdkkkqtJ8gwELlV+iKjy4Li0rE87TSFvvoMi5VatV4fXd50X3tHK0t2ulBza
 ShCBh1GeJ27x+WCJlrYa6mTDrk2LMfzLS6K8qr3B/Pj0+kU5h4PxE77EpWWuShJT27hn
 Oc+eCcB1JjZ7HACxueflHk/ZFQ7pwx4bedGo1slvBMrG+RGBAt31kNNvIFEpONpC4wGz
 EchA/IJ9132dgy8/1ru+BKTmAn8P+9baCGbl1MyPlGydXQczFn/nY967bDEqo4LGyJIa
 WIf3p8HTHJoKwwt+oYIiBVkfk3BYUUBZnWAl91Ge6CC41ND2nWY48Lh3Xd7crNt5640s
 kgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wSPReI6vXrdAyz5OkGAAu64UwO/gQv+p6h6aCIL3M10=;
 b=UXs3abIk9vhxBElO/BPoNmIJc/HmFhf1pAd6s4BG8CUi7OjhCtGeQxt1xb2vBrEhCJ
 7FE8IM39cI6pVcV/zwpKyb8yh6D7mzM3CSdNQlccp+zHfaQw5BWKHf/7S7dAp+D/V/j9
 bVSsscuTU63eR1rw0spjK8vqnUAedjv8AuI26hP273/7m0EdCFqzLgILBgMkhLNIul01
 yu76u9873GYFOLNox4oyaYEr1W3gwYP7V44SJDgzdXVB79hKrzBCMVKExaG7zbnmgZis
 pqaD8Sq+MddrSYP2kTEoOffP0Dfw6N6t5e5qVPJw1aNsf9z+YIsJyTPkQoYTW+0fhH7N
 1Syw==
X-Gm-Message-State: APjAAAUZvkM9195vsHvugpU+Kz624AdqUYlV8JcX24SA1cPwL+Rhhk6a
 YEb8AkNQ5+LSr2LWytzWGB0/BA==
X-Google-Smtp-Source: APXvYqz71uD22LeIx+s3X1iNAWyPsyTHPEZ1jDu8b7govSWpLoGssOMwFvmLatL5v+RBSwtQCHGAxA==
X-Received: by 2002:adf:fac2:: with SMTP id a2mr24059544wrs.290.1571050208772; 
 Mon, 14 Oct 2019 03:50:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a2sm19750943wrp.11.2019.10.14.03.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:50:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4EFBB1FFDC;
 Mon, 14 Oct 2019 11:50:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 54/55] plugins: add qemu_plugin_outs and use it
Date: Mon, 14 Oct 2019 11:49:47 +0100
Message-Id: <20191014104948.4291-55-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 robert.foley@futurewei.com, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Having the plugins grab stdout and spew stuff there is a bit ugly and
certainly makes the tests look ugly. Provide a hook back into QEMU
which can be redirected as needed.

For the newer plugins that use GString already this falls out pretty
naturally. For the older printf style plugins we convert to
g_strdup_printf and pass that. While we are at it we can use
g_autoptr/g_autofree to let the compiler worry about freeing things.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/log.h           |  1 +
 include/qemu/qemu-plugin.h   |  6 ++++++
 plugins/api.c                |  8 ++++++++
 plugins/qemu-plugins.symbols |  1 +
 tests/plugin/bb.c            | 12 +++++-------
 tests/plugin/hotblocks.c     | 10 ++--------
 tests/plugin/hotpages.c      | 12 +++---------
 tests/plugin/howvec.c        | 15 ++-------------
 tests/plugin/insn.c          | 10 ++++------
 tests/plugin/mem.c           | 12 ++++++------
 tests/tcg/Makefile.target    |  2 ++
 util/log.c                   |  3 +++
 12 files changed, 43 insertions(+), 49 deletions(-)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index b097a6cae1..a91105b2ad 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -45,6 +45,7 @@ static inline bool qemu_log_separate(void)
 /* LOG_TRACE (1 << 15) is defined in log-for-trace.h */
 #define CPU_LOG_TB_OP_IND  (1 << 16)
 #define CPU_LOG_TB_FPU     (1 << 17)
+#define CPU_LOG_PLUGIN     (1 << 18)
 
 /* Lock output for a series of related logs.  Since this is not needed
  * for a single qemu_log / qemu_log_mask / qemu_log_mask_and_addr, we
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 719d7054a1..060e253b74 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -379,4 +379,10 @@ int qemu_plugin_n_vcpus(void);
 /* returns -1 in user-mode */
 int qemu_plugin_n_max_vcpus(void);
 
+/**
+ * qemu_plugin_outs() - output string via QEMU's logging system
+ * @string: a string
+ */
+void qemu_plugin_outs(const char *string);
+
 #endif /* QEMU_PLUGIN_API_H */
diff --git a/plugins/api.c b/plugins/api.c
index a9fa229369..701c232668 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -324,3 +324,11 @@ int qemu_plugin_n_max_vcpus(void)
     return get_ms()->smp.max_cpus;
 #endif
 }
+
+/*
+ * Plugin output
+ */
+void qemu_plugin_outs(const char *string)
+{
+    qemu_log_mask(CPU_LOG_PLUGIN, "%s", string);
+}
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 267ec381b4..4bdb381f48 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -36,4 +36,5 @@
   qemu_plugin_vcpu_for_each;
   qemu_plugin_n_vcpus;
   qemu_plugin_n_max_vcpus;
+  qemu_plugin_outs;
 };
diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
index 4a6d6ca0bc..45e1de5bd6 100644
--- a/tests/plugin/bb.c
+++ b/tests/plugin/bb.c
@@ -10,18 +10,20 @@
 #include <string.h>
 #include <unistd.h>
 #include <stdio.h>
+#include <glib.h>
 
 #include <qemu-plugin.h>
 
 static uint64_t bb_count;
 static uint64_t insn_count;
-static int stdout_fd;
 static bool do_inline;
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
-    dprintf(stdout_fd, "bb's: %" PRIu64", insns: %" PRIu64 "\n",
-            bb_count, insn_count);
+    g_autofree gchar *out;
+    out = g_strdup_printf("bb's: %" PRIu64", insns: %" PRIu64 "\n",
+                          bb_count, insn_count);
+    qemu_plugin_outs(out);
 }
 
 static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
@@ -56,10 +58,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         do_inline = true;
     }
 
-    /* to be used when in the exit hook */
-    stdout_fd = dup(STDOUT_FILENO);
-    assert(stdout_fd);
-
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
diff --git a/tests/plugin/hotblocks.c b/tests/plugin/hotblocks.c
index 57bea765b3..1bd183849a 100644
--- a/tests/plugin/hotblocks.c
+++ b/tests/plugin/hotblocks.c
@@ -16,7 +16,6 @@
 #include <qemu-plugin.h>
 
 static bool do_inline;
-static int stdout_fd;
 
 /* Plugins need to take care of their own locking */
 static GMutex lock;
@@ -47,7 +46,7 @@ static gint cmp_exec_count(gconstpointer a, gconstpointer b)
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
-    GString *report = g_string_new("collected ");
+    g_autoptr(GString) report = g_string_new("collected ");
     GList *counts, *it;
     int i;
 
@@ -71,8 +70,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
         g_mutex_unlock(&lock);
     }
 
-    dprintf(stdout_fd, "%s", report->str);
-    g_string_free(report, true);
+    qemu_plugin_outs(report->str);
 }
 
 static void plugin_init(void)
@@ -137,10 +135,6 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
         do_inline = true;
     }
 
-    /* to be used when in the exit hook */
-    stdout_fd = dup(STDOUT_FILENO);
-    assert(stdout_fd);
-
     plugin_init();
 
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
diff --git a/tests/plugin/hotpages.c b/tests/plugin/hotpages.c
index 99bb4be07c..70917ea174 100644
--- a/tests/plugin/hotpages.c
+++ b/tests/plugin/hotpages.c
@@ -22,7 +22,6 @@
 
 static uint64_t page_size = 4096;
 static uint64_t page_mask;
-static int stdout_fd;
 static int limit = 50;
 static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
 
@@ -69,7 +68,7 @@ static gint cmp_access_count(gconstpointer a, gconstpointer b)
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
-    GString *report = g_string_new("Addr, RCPUs, Reads, WCPUs, Writes\n");
+    g_autoptr(GString) report = g_string_new("Addr, RCPUs, Reads, WCPUs, Writes\n");
     int i;
     GList *counts;
 
@@ -91,8 +90,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
         g_list_free(it);
     }
 
-    dprintf(stdout_fd, "%s", report->str);
-    g_string_free(report, true);
+    qemu_plugin_outs(report->str);
 }
 
 static void plugin_init(void)
@@ -154,10 +152,6 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
 {
     int i;
 
-    /* to be used when in the exit hook */
-    stdout_fd = dup(STDOUT_FILENO);
-    assert(stdout_fd);
-
     for (i = 0; i < argc; i++) {
         char *opt = argv[i];
         if (g_strcmp0(opt, "reads") == 0) {
@@ -167,7 +161,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
         } else if (g_str_has_prefix(opt, "pagesize=")) {
             page_size = g_ascii_strtoull(opt + 9, NULL, 10);
         } else {
-            dprintf(stdout_fd, "option parsing failed: %s\n", opt);
+            fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
         }
     }
diff --git a/tests/plugin/howvec.c b/tests/plugin/howvec.c
index 9ec0d25e3b..96db546b4d 100644
--- a/tests/plugin/howvec.c
+++ b/tests/plugin/howvec.c
@@ -29,7 +29,6 @@ typedef enum {
 } CountType;
 
 static int limit = 50;
-static int stdout_fd;
 static bool do_inline;
 static bool verbose;
 
@@ -163,7 +162,7 @@ static gint cmp_exec_count(gconstpointer a, gconstpointer b)
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
-    GString *report = g_string_new("Instruction Classes:\n");
+    g_autoptr(GString) report = g_string_new("Instruction Classes:\n");
     int i;
     GList *counts;
     InsnClassExecCount *class = NULL;
@@ -211,8 +210,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
         g_list_free(it);
     }
 
-    dprintf(stdout_fd, "%s", report->str);
-    g_string_free(report, true);
+    qemu_plugin_outs(report->str);
 }
 
 static void plugin_init(void)
@@ -270,11 +268,6 @@ static uint64_t * find_counter(struct qemu_plugin_insn *insn)
             icount->insn = qemu_plugin_insn_disas(insn);
             icount->class = class;
 
-            if (verbose) {
-                dprintf(stdout_fd, "adding for %s (%#08x @ %#20lx from %s)\n",
-                        icount->insn, opcode, qemu_plugin_insn_vaddr(insn),
-                        class->class);
-            }
             g_hash_table_insert(insns, GUINT_TO_POINTER(opcode),
                                 (gpointer) icount);
         }
@@ -350,10 +343,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         }
     }
 
-    /* to be used when in the exit hook */
-    stdout_fd = dup(STDOUT_FILENO);
-    assert(stdout_fd);
-
     plugin_init();
 
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
index 9cfa7d0e53..e5fd07fb64 100644
--- a/tests/plugin/insn.c
+++ b/tests/plugin/insn.c
@@ -10,10 +10,10 @@
 #include <string.h>
 #include <unistd.h>
 #include <stdio.h>
+#include <glib.h>
 
 #include <qemu-plugin.h>
 
-static int stdout_fd;
 static uint64_t insn_count;
 static bool do_inline;
 
@@ -42,7 +42,9 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
-    dprintf(stdout_fd, "insns: %" PRIu64 "\n", insn_count);
+    g_autofree gchar *out;
+    out = g_strdup_printf("insns: %" PRIu64 "\n", insn_count);
+    qemu_plugin_outs(out);
 }
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
@@ -53,10 +55,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         do_inline = true;
     }
 
-    /* to be used when in the exit hook */
-    stdout_fd = dup(STDOUT_FILENO);
-    assert(stdout_fd);
-
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index fdf4347c5e..d967388989 100644
--- a/tests/plugin/mem.c
+++ b/tests/plugin/mem.c
@@ -10,22 +10,25 @@
 #include <string.h>
 #include <unistd.h>
 #include <stdio.h>
+#include <glib.h>
 
 #include <qemu-plugin.h>
 
 static uint64_t mem_count;
 static uint64_t io_count;
-static int stdout_fd;
 static bool do_inline;
 static bool do_haddr;
 static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
-    dprintf(stdout_fd, "mem accesses: %" PRIu64 "\n", mem_count);
+    g_autoptr(GString) out = g_string_new("");
+
+    g_string_printf(out, "mem accesses: %" PRIu64 "\n", mem_count);
     if (do_haddr) {
-        dprintf(stdout_fd, "io accesses: %" PRIu64 "\n", mem_count);
+        g_string_append_printf(out, "io accesses: %" PRIu64 "\n", mem_count);
     }
+    qemu_plugin_outs(out->str);
 }
 
 static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
@@ -87,9 +90,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
             do_inline = true;
         }
     }
-    /* plugin_exit might write to stdout after stdout has been closed */
-    stdout_fd = dup(STDOUT_FILENO);
-    assert(stdout_fd);
 
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index d25fc64300..3c7421a356 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -153,6 +153,7 @@ run-%: %
 run-plugin-%:
 	$(call run-test, $@, $(QEMU) $(QEMU_OPTS) \
 		-plugin $(PLUGIN_DIR)/$(call extract-plugin,$@) \
+		-d plugin -D $*.pout \
 		 $(call strip-plugin,$<), \
 	"$* on $(TARGET_NAME)")
 else
@@ -168,6 +169,7 @@ run-plugin-%:
 	  $(QEMU) -monitor none -display none \
 		  -chardev file$(COMMA)path=$@.out$(COMMA)id=output \
 	   	  -plugin $(PLUGIN_DIR)/$(call extract-plugin,$@) \
+	    	  -d plugin -D $*.pout \
 	   	  $(QEMU_OPTS) $(call strip-plugin,$<), \
 	  "$* on $(TARGET_NAME)")
 endif
diff --git a/util/log.c b/util/log.c
index 1d1b33f7d9..1ca13059ee 100644
--- a/util/log.c
+++ b/util/log.c
@@ -273,6 +273,9 @@ const QEMULogItem qemu_log_items[] = {
     { CPU_LOG_TB_NOCHAIN, "nochain",
       "do not chain compiled TBs so that \"exec\" and \"cpu\" show\n"
       "complete traces" },
+#ifdef CONFIG_PLUGIN
+    { CPU_LOG_PLUGIN, "plugin", "output from TCG plugins\n"},
+#endif
     { 0, NULL, NULL },
 };
 
-- 
2.20.1



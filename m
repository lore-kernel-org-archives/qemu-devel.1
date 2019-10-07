Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344EDC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE6120679
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIL9b2NL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE6120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVFf-00013g-FS
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwJ-0002ZL-UV
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwH-0005AD-QT
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:47 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHUwH-00059b-G9
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:45 -0400
Received: by mail-wr1-x441.google.com with SMTP id y19so15859169wrd.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 08:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mxx40Q+nCYSDb7wZipkn3exesX1aGd6/ZVPDy+DAdhc=;
 b=UIL9b2NL23s2SNI+9tz9L7GbgG8Tf57fUBIlyg9q8/sN1e17PYGIFRXU3Am+8vdaVA
 dzI+THAdNO1PQT3m3kbgUcirkxrW4oP6gddgGAPDkAGmQMHxUbgZc+u97YI+mOjRJayY
 EHpDJd7tvzcN52b2bwLGOKmZAJf54vq4QLMPAkZFRpIqlOK9DmIbdjA7xZdwToGIGG2P
 1ZeRyyp2PyeyNCMA65MF3xypgpnbdxfcpTbGBMrrKk2xBI7v1XWotmGXiTBmch+K3/2Q
 kVh0EsfH3Y41lXI8LvDw+7ocmX+1bCNl+pDsF/pMcjgECHFT+pui+j4SF6+WnK0ihM85
 H33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mxx40Q+nCYSDb7wZipkn3exesX1aGd6/ZVPDy+DAdhc=;
 b=tmI3RthN4UYrRuFlkXA75yUvs24xoJ9CT/TuxDbLx9WVok7mKSXqKWtRCR50v2SgJS
 /Nq/4z3+vH8MZip56FCS8VcZhvKKft7POXrVUBbshPwtb8HT+8G1ej1zZy3Jga5vhvj9
 L578JsBs3LoApNAJtcOSbo8P7vHi9yDJ2n+YAxfCv2hjvmHIw5C8jMN2HryEeN3wt5Nm
 IXrGBkEhOKLzVSiRnySKsCNV8OWCwZviEMvLqv6Ao6c/ATIoKZd5c0BZ1nPaOvVdJgY0
 IB2iADvATzMaSEmzjVW++PU81bs0fyuvV8VqwYAZFjml0XB0tgTrdO/VlG0gS4UGpRsy
 +OKw==
X-Gm-Message-State: APjAAAXB58xOKli9+XD8JuaudFlDAlHSreT8Hz5gn59wEL+46DlkyPji
 FyrfuSD3RLSf5q+QS4nb4Kx34g==
X-Google-Smtp-Source: APXvYqzzaGvaMvbqwwj5Em+RQAET0e/tscyC7haADc1Xef+KnexOaAHF8N6qHTZaOv/m/ONk3idE6A==
X-Received: by 2002:adf:f7c3:: with SMTP id a3mr10423057wrq.275.1570462124367; 
 Mon, 07 Oct 2019 08:28:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g3sm31784713wro.14.2019.10.07.08.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 08:28:42 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E14831FF93;
 Mon,  7 Oct 2019 16:28:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 06/13] debug: add -d tb_stats to control TBStatistics
 collection:
Date: Mon,  7 Oct 2019 16:28:32 +0100
Message-Id: <20191007152839.30804-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191007152839.30804-1-alex.bennee@linaro.org>
References: <20191007152839.30804-1-alex.bennee@linaro.org>
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>

 -d tb_stats[[,level=(+all+jit+exec+time)][,dump_limit=<number>]]

"dump_limit" is used to limit the number of dumped TBStats in
linux-user mode.

[all+jit+exec+time] control the profilling level used
by the TBStats. Can be used as follow:

-d tb_stats
-d tb_stats,level=jit+time
-d tb_stats,dump_limit=15
...

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Message-Id: <20190829173437.5926-7-vandersonmr2@gmail.com>
[AJB: fix authorship, reword title]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
AJB:
  - reword title
  - add stubs for enabling
  - move things across to tb-stats-flags.h
---
 accel/tcg/tb-stats.c          |  5 +++++
 include/exec/gen-icount.h     |  1 +
 include/exec/tb-stats-flags.h | 29 +++++++++++++++++++++++++++++
 include/exec/tb-stats.h       | 16 +++-------------
 include/qemu/log.h            |  1 +
 stubs/Makefile.objs           |  1 +
 stubs/tb-stats.c              | 27 +++++++++++++++++++++++++++
 util/log.c                    | 35 +++++++++++++++++++++++++++++++++++
 8 files changed, 102 insertions(+), 13 deletions(-)
 create mode 100644 include/exec/tb-stats-flags.h
 create mode 100644 stubs/tb-stats.c

diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index f431159fd2..1c66e03979 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -193,3 +193,8 @@ uint32_t get_default_tbstats_flag(void)
 {
     return default_tbstats_flag;
 }
+
+void set_default_tbstats_flag(uint32_t flags)
+{
+    default_tbstats_flag = flags;
+}
diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index be006383b9..3987adfb0e 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -2,6 +2,7 @@
 #define GEN_ICOUNT_H
 
 #include "qemu/timer.h"
+#include "tb-stats-flags.h"
 
 /* Helpers for instruction counting code generation.  */
 
diff --git a/include/exec/tb-stats-flags.h b/include/exec/tb-stats-flags.h
new file mode 100644
index 0000000000..8455073048
--- /dev/null
+++ b/include/exec/tb-stats-flags.h
@@ -0,0 +1,29 @@
+/*
+ * QEMU System Emulator, Code Quality Monitor System
+ *
+ * We define the flags and control bits here to avoid complications of
+ * including TCG/CPU information in common code.
+ *
+ * Copyright (c) 2019 Vanderson M. do Rosario <vandersonmr2@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef TB_STATS_FLAGS
+#define TB_STATS_FLAGS
+
+#define TB_NOTHING    (1 << 0)
+#define TB_EXEC_STATS (1 << 1)
+#define TB_JIT_STATS  (1 << 2)
+#define TB_JIT_TIME   (1 << 3)
+
+/* TBStatistic collection controls */
+void enable_collect_tb_stats(void);
+void disable_collect_tb_stats(void);
+void pause_collect_tb_stats(void);
+bool tb_stats_collection_enabled(void);
+bool tb_stats_collection_paused(void);
+
+uint32_t get_default_tbstats_flag(void);
+void set_default_tbstats_flag(uint32_t);
+
+#endif
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index a142972960..019d316f5c 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -30,6 +30,8 @@
 #include "exec/tb-context.h"
 #include "tcg.h"
 
+#include "exec/tb-stats-flags.h"
+
 #define tb_stats_enabled(tb, JIT_STATS) \
     (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
 
@@ -108,21 +110,9 @@ bool tb_stats_cmp(const void *ap, const void *bp);
 
 void dump_jit_exec_time_info(uint64_t dev_time);
 
+void set_tbstats_flags(uint32_t flags);
 void init_tb_stats_htable_if_not(void);
 
 void dump_jit_profile_info(TCGProfile *s);
 
-#define TB_NOTHING    (1 << 0)
-#define TB_EXEC_STATS (1 << 1)
-#define TB_JIT_STATS  (1 << 2)
-#define TB_JIT_TIME   (1 << 3)
-
-void enable_collect_tb_stats(void);
-void disable_collect_tb_stats(void);
-void pause_collect_tb_stats(void);
-bool tb_stats_collection_enabled(void);
-bool tb_stats_collection_paused(void);
-
-uint32_t get_default_tbstats_flag(void);
-
 #endif
diff --git a/include/qemu/log.h b/include/qemu/log.h
index b097a6cae1..a8d1997cde 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -45,6 +45,7 @@ static inline bool qemu_log_separate(void)
 /* LOG_TRACE (1 << 15) is defined in log-for-trace.h */
 #define CPU_LOG_TB_OP_IND  (1 << 16)
 #define CPU_LOG_TB_FPU     (1 << 17)
+#define CPU_LOG_TB_STATS   (1 << 18)
 
 /* Lock output for a series of related logs.  Since this is not needed
  * for a single qemu_log / qemu_log_mask / qemu_log_mask_and_addr, we
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 9c7393b08c..1c5cd05147 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -41,3 +41,4 @@ stub-obj-y += ram-block.o
 stub-obj-y += ramfb.o
 stub-obj-y += fw_cfg.o
 stub-obj-$(CONFIG_SOFTMMU) += semihost.o
+stub-obj-$(CONFIG_TCG) += tb-stats.o
diff --git a/stubs/tb-stats.c b/stubs/tb-stats.c
new file mode 100644
index 0000000000..d212c2a1fa
--- /dev/null
+++ b/stubs/tb-stats.c
@@ -0,0 +1,27 @@
+/*
+ * TB Stats Stubs
+ *
+ * Copyright (c) 2019
+ * Written by Alex Bennée <alex.bennee@linaro.org>
+ *
+ * This code is licensed under the GNU GPL v2, or later.
+ */
+
+
+#include "qemu/osdep.h"
+#include "exec/tb-stats-flags.h"
+
+void enable_collect_tb_stats(void)
+{
+    return;
+}
+
+bool tb_stats_collection_enabled(void)
+{
+    return false;
+}
+
+void set_default_tbstats_flag(uint32_t flags)
+{
+    return;
+}
diff --git a/util/log.c b/util/log.c
index 1d1b33f7d9..86bd691967 100644
--- a/util/log.c
+++ b/util/log.c
@@ -19,17 +19,20 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/qemu-print.h"
 #include "qemu/range.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "trace/control.h"
+#include "exec/tb-stats-flags.h"
 
 static char *logfilename;
 FILE *qemu_logfile;
 int qemu_loglevel;
 static int log_append = 0;
 static GArray *debug_regions;
+int32_t max_num_hot_tbs_to_dump;
 
 /* Return the number of characters emitted.  */
 int qemu_log(const char *fmt, ...)
@@ -273,6 +276,9 @@ const QEMULogItem qemu_log_items[] = {
     { CPU_LOG_TB_NOCHAIN, "nochain",
       "do not chain compiled TBs so that \"exec\" and \"cpu\" show\n"
       "complete traces" },
+    { CPU_LOG_TB_STATS, "tb_stats[[,level=(+all+jit+exec+time)][,dump_limit=<number>]]",
+      "enable collection of TBs statistics"
+      "(and dump until given a limit if in user mode).\n" },
     { 0, NULL, NULL },
 };
 
@@ -294,6 +300,35 @@ int qemu_str_to_log_mask(const char *str)
             trace_enable_events((*tmp) + 6);
             mask |= LOG_TRACE;
 #endif
+        } else if (g_str_has_prefix(*tmp, "tb_stats")) {
+            mask |= CPU_LOG_TB_STATS;
+            set_default_tbstats_flag(TB_JIT_STATS | TB_EXEC_STATS | TB_JIT_TIME);
+            enable_collect_tb_stats();
+        } else if (tb_stats_collection_enabled() &&
+                   g_str_has_prefix(*tmp, "dump_limit=")) {
+            max_num_hot_tbs_to_dump = atoi((*tmp) + 11);
+        } else if (tb_stats_collection_enabled() &&
+                   g_str_has_prefix(*tmp, "level=")) {
+            uint32_t flags = 0;
+            char **level_parts = g_strsplit(*tmp + 6, "+", 0);
+            char **level_tmp;
+            for (level_tmp = level_parts; level_tmp && *level_tmp; level_tmp++) {
+                if (g_str_equal(*level_tmp, "jit")) {
+                    flags |= TB_JIT_STATS;
+                } else if (g_str_equal(*level_tmp, "exec")) {
+                    flags |= TB_EXEC_STATS;
+                } else if (g_str_equal(*level_tmp, "time")) {
+                    flags |= TB_JIT_TIME;
+                } else if (g_str_equal(*level_tmp, "all")) {
+                    flags |= TB_JIT_STATS | TB_EXEC_STATS | TB_JIT_TIME;
+                } else {
+                    /* FIXME: set errp */
+                    fprintf(stderr, "no option level=%s, valid options are:"
+                            "all, jit, exec or/and time\n", *level_tmp);
+                    exit(1);
+                }
+                set_default_tbstats_flag(flags);
+            }
         } else {
             for (item = qemu_log_items; item->mask != 0; item++) {
                 if (g_str_equal(*tmp, item->name)) {
-- 
2.20.1



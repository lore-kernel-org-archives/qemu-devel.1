Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EABC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E50F521726
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzAj858w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50F521726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3OPa-00020N-Nd
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 13:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3OKI-0004rM-LL
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3OKG-0000HE-LH
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:35:14 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:46395)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i3OKG-0000Gl-EF
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:35:12 -0400
Received: by mail-qk1-x742.google.com with SMTP id p13so3643278qkg.13
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 10:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ype+RhMQ6yuP+PwkChrUABRIauIUwsULdkVXVz2HWbA=;
 b=MzAj858wAguE55B1liYUQmV1UtgjtFSeYr9yLsgD4G33cfLCFVH+TK3byHcOjtlYad
 FO6B65DVLawiN18OhJuaTsRytumqFLAgqn8c7Ua4VuBwFqFI3MZuqR4KEJ0ogmxtdxtq
 zmCCIDtD66zD3x4bZzkum/S5JmNpiZovn9A8NQZ0o/Ix4LwirIoyaT31fOFVLtKTDeJn
 4+tml8HSeyDMgHu/5UTMMHxbQWhqh5ZdIaYtqm7kEGROZla90bksGtZfhZjr/HAKA7O4
 j6HERXWfxd0oeWe04XGP7ktqN4wyoFCRliEFT5i/3Gi3lR778yE1UGGzM3FBFyjsg5YP
 7A6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ype+RhMQ6yuP+PwkChrUABRIauIUwsULdkVXVz2HWbA=;
 b=JIjgbAijjJq4xAMqHfpR8dHaYBQdw0SxBan2dxzCJYUvT5NQX02yeiW+nXuqiSSMxt
 9yiMwOSnYFy8tEoqEhItTZh1SpbvcjwEAYaqRS9R6JYCuEfodp4nJRZlfXpajOgK/GOL
 UkinskWVPEoDIrPF3MSSBECnGxX6Ib5P9J89FB+1tfcF3Goqge/7uhGfhVBX04O/ErJA
 slKYybJ8DPagdOTUv32KjNHMQVak5jq7DPS7GyFJLR0aaeD6RJ6r8SwtqUD2Yub4yhC1
 V2Nwhwu6vMZQZ5XDZxJ9XLviHiWIaDaRtW5iUg2YhmIFUlfFe06SY+nBtRXmBTc/RjsW
 yd/g==
X-Gm-Message-State: APjAAAWZgLKAm8WXV3QxKL/asWbDbEiROJ8uja3tQ2F5q58CNDSTwZX8
 lRwV75hdpniFKo5zfgtor4D0DD1GTtPryg==
X-Google-Smtp-Source: APXvYqzBR1W/opy9hyPtmL8BUePw8/IqiWfrgLk/lfZxfNYSXzj1SfyqLnGMQJ0/8mG3M4Y1Zxknpg==
X-Received: by 2002:a37:e105:: with SMTP id c5mr10339900qkm.439.1567100111697; 
 Thu, 29 Aug 2019 10:35:11 -0700 (PDT)
Received: from vanderson-lmcad.gw.lmcad.ic.unicamp.br (gw.lmcad.ic.unicamp.br.
 [143.106.73.166])
 by smtp.googlemail.com with ESMTPSA id j50sm1721700qtj.30.2019.08.29.10.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 10:35:11 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 14:34:32 -0300
Message-Id: <20190829173437.5926-7-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829173437.5926-1-vandersonmr2@gmail.com>
References: <20190829173437.5926-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: [Qemu-devel] [PATCH v8 06/11] Adding -d tb_stats to control
 TBStatistics collection:
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
Cc: vandersonmr <vandersonmr2@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 include/exec/gen-icount.h     |  1 +
 include/exec/tb-stats-flags.h | 42 +++++++++++++++++++++++++++++++++++
 include/exec/tb-stats.h       | 18 +++------------
 include/qemu/log.h            |  1 +
 util/log.c                    | 35 +++++++++++++++++++++++++++++
 5 files changed, 82 insertions(+), 15 deletions(-)
 create mode 100644 include/exec/tb-stats-flags.h

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
index 0000000000..c936ac1084
--- /dev/null
+++ b/include/exec/tb-stats-flags.h
@@ -0,0 +1,42 @@
+/*
+ * QEMU System Emulator, Code Quality Monitor System
+ *
+ * Copyright (c) 2019 Vanderson M. do Rosario <vandersonmr2@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#ifndef TB_STATS_FLAGS
+#define TB_STATS_FLAGS
+
+enum TBStatsStatus {
+    TB_STATS_DISABLED = 0,
+    TB_STATS_RUNNING,
+    TB_STATS_PAUSED,
+    TB_STATS_STOPPED
+};
+
+#define TB_NOTHING    (1 << 0)
+#define TB_EXEC_STATS (1 << 1)
+#define TB_JIT_STATS  (1 << 2)
+#define TB_JIT_TIME   (1 << 3)
+
+extern int tcg_collect_tb_stats;
+extern uint32_t default_tbstats_flag;
+
+#endif
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index 0b9a6e2f72..6a53bef31b 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -30,6 +30,8 @@
 #include "exec/tb-context.h"
 #include "tcg.h"
 
+#include "exec/tb-stats-flags.h"
+
 #define tb_stats_enabled(tb, JIT_STATS) \
     (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
 
@@ -98,26 +100,12 @@ bool tb_stats_cmp(const void *ap, const void *bp);
 
 void dump_jit_exec_time_info(uint64_t dev_time);
 
+void set_tbstats_flags(uint32_t flags);
 void init_tb_stats_htable_if_not(void);
 
 void dump_jit_profile_info(TCGProfile *s);
 
 /* TBStatistic collection controls */
-enum TBStatsStatus {
-    TB_STATS_DISABLED = 0,
-    TB_STATS_RUNNING,
-    TB_STATS_PAUSED,
-    TB_STATS_STOPPED
-};
-
-#define TB_NOTHING    (1 << 0)
-#define TB_EXEC_STATS (1 << 1)
-#define TB_JIT_STATS  (1 << 2)
-#define TB_JIT_TIME   (1 << 3)
-
-extern int tcg_collect_tb_stats;
-extern uint32_t default_tbstats_flag;
-
 void enable_collect_tb_stats(void);
 void disable_collect_tb_stats(void);
 void pause_collect_tb_stats(void);
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
diff --git a/util/log.c b/util/log.c
index 29021a4584..c3805b331b 100644
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
 
 int tcg_collect_tb_stats;
 uint32_t default_tbstats_flag;
@@ -276,6 +279,9 @@ const QEMULogItem qemu_log_items[] = {
     { CPU_LOG_TB_NOCHAIN, "nochain",
       "do not chain compiled TBs so that \"exec\" and \"cpu\" show\n"
       "complete traces" },
+    { CPU_LOG_TB_STATS, "tb_stats[[,level=(+all+jit+exec+time)][,dump_limit=<number>]]",
+      "enable collection of TBs statistics"
+      "(and dump until given a limit if in user mode).\n" },
     { 0, NULL, NULL },
 };
 
@@ -297,6 +303,35 @@ int qemu_str_to_log_mask(const char *str)
             trace_enable_events((*tmp) + 6);
             mask |= LOG_TRACE;
 #endif
+        } else if (g_str_has_prefix(*tmp, "tb_stats")) {
+            mask |= CPU_LOG_TB_STATS;
+            default_tbstats_flag = TB_JIT_STATS | TB_EXEC_STATS | TB_JIT_TIME;
+            tcg_collect_tb_stats = TB_STATS_RUNNING;
+        } else if (tcg_collect_tb_stats == TB_STATS_RUNNING &&
+                g_str_has_prefix(*tmp, "dump_limit=")) {
+
+            max_num_hot_tbs_to_dump = atoi((*tmp) + 11);
+        } else if (tcg_collect_tb_stats == TB_STATS_RUNNING &&
+                g_str_has_prefix(*tmp, "level=")) {
+
+            default_tbstats_flag = 0;
+            char **level_parts = g_strsplit(*tmp + 6, "+", 0);
+            char **level_tmp;
+            for (level_tmp = level_parts; level_tmp && *level_tmp; level_tmp++) {
+                if (g_str_equal(*level_tmp, "jit")) {
+                    default_tbstats_flag |= TB_JIT_STATS;
+                } else if (g_str_equal(*level_tmp, "exec")) {
+                    default_tbstats_flag |= TB_EXEC_STATS;
+                } else if (g_str_equal(*level_tmp, "time")) {
+                    default_tbstats_flag |= TB_JIT_TIME;
+                } else if (g_str_equal(*level_tmp, "all")) {
+                    default_tbstats_flag |= TB_JIT_STATS | TB_EXEC_STATS | TB_JIT_TIME;
+                } else {
+                    fprintf(stderr, "no option level=%s, valid options are:"
+                            "all, jit, exec or/and time\n", *level_tmp);
+                    exit(1);
+                }
+            }
         } else {
             for (item = qemu_log_items; item->mask != 0; item++) {
                 if (g_str_equal(*tmp, item->name)) {
-- 
2.22.0



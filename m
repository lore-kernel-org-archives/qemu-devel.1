Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC87C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:30:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69FE722D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mL5Wy4KI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FE722D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0URJ-0000BR-3R
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i0UL0-0007aI-1b
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i0UKy-0000Co-7m
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:23:57 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:34597)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i0UKy-0000BL-3C
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:23:56 -0400
Received: by mail-qk1-x742.google.com with SMTP id m10so2540256qkk.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JOq7NinA7j4io/JpGYTf/SDNjFm2qy7T6Z2TTp844mo=;
 b=mL5Wy4KI605bz0dJP2oo0ZXeBnV1An1SqJ7NxwGFVPInJOeKB2H0DPlGn5aFRpknap
 RgXnXHbEDTNWMb8W6W+/3hO9Nn9sfIcMLiAju/4KQBPkctTE2XT/ZvlZvSRTL0Sdl8an
 J45cdwomA4Ak9BTPfewyiFLHr6PSdMDer92O6pSVAxYtJKC9vt9ImMPuNuN8+xNO5+fD
 6w1/5nnG2RuNuNOZU2PZBRbdK2xvKxY0r+HELlDjKINg0k+gO66l0byI73XnPCysSZUs
 vLeoRXIF/uK78svfVD0ITl3hnfsNNrhUCHOB3MXEwulak0BQrUGG/ReXrGB5PfLFOvSw
 6OfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JOq7NinA7j4io/JpGYTf/SDNjFm2qy7T6Z2TTp844mo=;
 b=YH4f4msLLqXOM4uiDt5Ah97gTucA3HJXxZWxxD8jQBx0Cz1xO3dbUZRrc1ttyjgdZM
 460m2I8m8kUWNeX1DJJ6KnCt7o06TgX6QLetpriIjp8tvJkFWrOLmqr/Ys7s9s+LM9sV
 l/GHamVXBqwg9iUUKmNulE7kB6CPYp6WzGiEH+DabEnX6jsXi5neAWTiJ1WyhGc/s7vi
 gNIEMGz/QFb8YjTHD3o88mAzkZGrhp/t+y64NqA6uY2J0Dr60hnjttAYWCc3SWviwpmL
 2uE/qYzG26yxm1h5OT1cXcpb7JRoiCFp3FWo4JPYmweJqH22HNaEPNeZpRmuQdVvo1Yl
 Vr+w==
X-Gm-Message-State: APjAAAUcBffNTGA/1LWHw2ItdvHGoqEFONSqqjnj4gR4KmIo94PzjkNd
 t8MboG3D063hwG4wDP6m6dFbeDyX1mqdvA==
X-Google-Smtp-Source: APXvYqyo91/BiTASwrCc+kATLlLzhfjgGOctG7yyjnF9XRQrEaUjVm72ppqU+Ei61p3YrnYCSFnZAg==
X-Received: by 2002:a05:620a:13d1:: with SMTP id
 g17mr30946997qkl.499.1566408235285; 
 Wed, 21 Aug 2019 10:23:55 -0700 (PDT)
Received: from vanderson-lmcad.gw.lmcad.ic.unicamp.br (gw.lmcad.ic.unicamp.br.
 [143.106.73.166])
 by smtp.googlemail.com with ESMTPSA id a3sm9623998qtp.10.2019.08.21.10.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:23:54 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 14:23:25 -0300
Message-Id: <20190821172329.2062-7-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821172329.2062-1-vandersonmr2@gmail.com>
References: <20190821172329.2062-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: [Qemu-devel] [PATCH v6 06/10] log: adding -d tb_stats to control
 tbstats
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, vandersonmr <vandersonmr2@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding -d tb_stats to control TBStatistics collection:

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
 accel/tcg/tb-stats.c      |  1 +
 accel/tcg/translator.c    |  1 +
 include/exec/gen-icount.h |  1 +
 include/exec/tb-stats.h   | 15 ---------------
 include/qemu-common.h     | 15 +++++++++++++++
 include/qemu/log.h        |  1 +
 tcg/tcg.c                 |  1 +
 util/log.c                | 35 +++++++++++++++++++++++++++++++++++
 8 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index e0ac254fc1..8554174360 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -3,6 +3,7 @@
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg.h"
+#include "qemu-common.h"
 
 #include "qemu/qemu-print.h"
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 834265d5be..ea7c3a9f77 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -16,6 +16,7 @@
 #include "exec/gen-icount.h"
 #include "exec/log.h"
 #include "exec/translator.h"
+#include "qemu-common.h"
 
 /* Pairs with tcg_clear_temp_count.
    To be called by #TranslatorOps.{translate_insn,tb_stop} if
diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index b3efe41894..6f54586dd6 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -2,6 +2,7 @@
 #define GEN_ICOUNT_H
 
 #include "qemu/timer.h"
+#include "qemu-common.h"
 
 /* Helpers for instruction counting code generation.  */
 
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index 0ea2639fd2..a607ceaa53 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -79,21 +79,6 @@ void init_tb_stats_htable_if_not(void);
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
-#define TB_JIT_STATS  (1 << 3)
-
-extern int tcg_collect_tb_stats;
-extern uint32_t default_tbstats_flag;
-
 void enable_collect_tb_stats(void);
 void disable_collect_tb_stats(void);
 void pause_collect_tb_stats(void);
diff --git a/include/qemu-common.h b/include/qemu-common.h
index 0235cd3b91..3930b61ec0 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -130,4 +130,19 @@ void page_size_init(void);
  * returned. */
 bool dump_in_progress(void);
 
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
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 1a306e1ec9..08f3d50199 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -35,6 +35,7 @@
 #include "qemu/host-utils.h"
 #include "qemu/qemu-print.h"
 #include "qemu/timer.h"
+#include "qemu-common.h"
 
 /* Note: the long term plan is to reduce the dependencies on the QEMU
    CPU definitions. Currently they are used for qemu_ld/st
diff --git a/util/log.c b/util/log.c
index 29021a4584..09cfb13b45 100644
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
+#include "qemu-common.h"
 
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



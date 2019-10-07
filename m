Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6418C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:41:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA8220640
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jh6uQSbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA8220640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHV8W-0004Mg-Vr
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwL-0002bb-IE
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwJ-0005Ax-9h
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:49 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46902)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHUwJ-0005AX-26
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:47 -0400
Received: by mail-wr1-x441.google.com with SMTP id o18so15792748wrv.13
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 08:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CZflwldCN50YlIobs9aZPRkYZvox2aKMETtZiJDlL04=;
 b=Jh6uQSbPiW9SkfOV7aWHBCqRVLBjouaO2LvT2ceUjv8vNEhYteiEwrPaUJepb+3iYV
 qcm4UAl6I3xVRDO8dArXqvvlL5jXbpmJQFd46BbVKin6RkKXHwn+/4BQbwwEuJjq/Jf0
 QiLpVy4o7c3a72/anHsM9aoP2rADBcFtwkIQctnndm15OoIhE3i8kxMTziMeF6MDiqOZ
 P429D8MP5ydXqPHPKm3AVeICIkJ9oI2zSTXHzKqBrbfpq+0279SArQ4u0Ffnmmd988lD
 uFkrvbaGzIKhn0GvHI/c2ZnuNQngMDT6EgH/mQqYu4xNU/xA8iLhizNFmw7z4S6KV3wM
 5YSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CZflwldCN50YlIobs9aZPRkYZvox2aKMETtZiJDlL04=;
 b=Qsz98eO57OhOEsjASGXJYa6vds9lVCnlpgWQEaOCe/1Ib5u+1MypfSv73gNORbsuvf
 b5sbQg9yzR62o0aWhKlkSpGRtYk6rWmqF+mFHUqdddfW4sInX0vnTpKDuT9dlMDoZvDs
 TBGoYjO4uigEw3zgURCFO4alOSCVgR2mdf9RqTERsLhYGlQffd97yHv4ToCtbcVdb2GD
 wX7ZFqie5uPYc2c4kmNp0E1/CKn8rS2z2gUt11zXDvqcDqmn8CCzuYWC5w8BFATPlir+
 1/MCHcdAJ3uHzOKPEpw+/9sSIgGvum1uxhoBeYB7i9NHbfOYKQDCjlYvKEH/UOtv97Sr
 pYQA==
X-Gm-Message-State: APjAAAWKnKX0Tpq88J6ONRlnU55PRF75sCmAVJ3B5kQZQeJfvj0fsi4F
 Ja6mmz7ccF+dB5avcNEOHhNebA==
X-Google-Smtp-Source: APXvYqxNY/xuntEy/GM7jl7DphQPBsJisAWe5L9KBc66XLwP7QQHCSvLhdCZs9PSJPnJuSkBxBzCvQ==
X-Received: by 2002:adf:e588:: with SMTP id l8mr8571883wrm.290.1570462125933; 
 Mon, 07 Oct 2019 08:28:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a14sm15301444wmm.44.2019.10.07.08.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 08:28:42 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0CA6C1FF96;
 Mon,  7 Oct 2019 16:28:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v9 07/13] monitor: adding tb_stats hmp command
Date: Mon,  7 Oct 2019 16:28:33 +0100
Message-Id: <20191007152839.30804-8-alex.bennee@linaro.org>
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
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>

Adding tb_stats [start|pause|stop|filter] command to hmp.
This allows controlling the collection of statistics.
It is also possible to set the level of collection:
all, jit, or exec.

tb_stats filter allow to only collect statistics for the TB
in the last_search list.

The goal of this command is to allow the dynamic exploration
of the TCG behavior and quality. Therefore, for now, a
corresponding QMP command is not worthwhile.

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Message-Id: <20190829173437.5926-8-vandersonmr2@gmail.com>
[AJB: fix authorship]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

monitor: add tb_stats [start|pause|stop|filter] command to hmp.

This allows controlling the collection of statistics.
It is also possible to set the level of collection:
all, jit, or exec.

tb_stats filter allow to only collect statistics for the TB
in the last_search list.

The goal of this command is to allow the dynamic exploration
of the TCG behavior and quality. Therefore, for now, a
corresponding QMP command is not worthwhile.

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Message-Id: <20190829173437.5926-9-vandersonmr2@gmail.com>
[AJB: fix authorship]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/tb-stats.c          | 105 ++++++++++++++++++++++++++++++++++
 hmp-commands.hx               |  17 ++++++
 include/exec/tb-stats-flags.h |   1 +
 include/exec/tb-stats.h       |  10 ++++
 monitor/misc.c                |  49 ++++++++++++++++
 vl.c                          |   6 ++
 6 files changed, 188 insertions(+)

diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 1c66e03979..dabc5150f9 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -26,6 +26,8 @@ enum TBStatsStatus {
 
 static enum TBStatsStatus tcg_collect_tb_stats;
 static uint32_t default_tbstats_flag;
+/* only accessed in safe work */
+static GList *last_search;
 
 uint64_t dev_time;
 
@@ -155,6 +157,96 @@ void dump_jit_profile_info(TCGProfile *s)
     g_free(jpi);
 }
 
+static void free_tbstats(void *p, uint32_t hash, void *userp)
+{
+    g_free(p);
+}
+
+static void clean_tbstats(void)
+{
+    /* remove all tb_stats */
+    qht_iter(&tb_ctx.tb_stats, free_tbstats, NULL);
+    qht_destroy(&tb_ctx.tb_stats);
+}
+
+void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd)
+{
+    struct TbstatsCommand *cmdinfo = icmd.host_ptr;
+    int cmd = cmdinfo->cmd;
+    uint32_t level = cmdinfo->level;
+
+    switch (cmd) {
+    case START:
+        if (tb_stats_collection_paused()) {
+            set_tbstats_flags(level);
+        } else {
+            if (tb_stats_collection_enabled()) {
+                qemu_printf("TB information already being recorded");
+                return;
+            }
+            qht_init(&tb_ctx.tb_stats, tb_stats_cmp, CODE_GEN_HTABLE_SIZE,
+                        QHT_MODE_AUTO_RESIZE);
+        }
+
+        set_default_tbstats_flag(level);
+        enable_collect_tb_stats();
+        tb_flush(cpu);
+        break;
+    case PAUSE:
+        if (!tb_stats_collection_enabled()) {
+            qemu_printf("TB information not being recorded");
+            return;
+        }
+
+        /* Continue to create TBStatistic structures but stop collecting statistics */
+        pause_collect_tb_stats();
+        set_default_tbstats_flag(TB_NOTHING);
+        set_tbstats_flags(TB_PAUSED);
+        tb_flush(cpu);
+        break;
+    case STOP:
+        if (!tb_stats_collection_enabled()) {
+            qemu_printf("TB information not being recorded");
+            return;
+        }
+
+        /* Dissalloc all TBStatistics structures and stop creating new ones */
+        disable_collect_tb_stats();
+        clean_tbstats();
+        tb_flush(cpu);
+        break;
+    case FILTER:
+        if (!tb_stats_collection_enabled()) {
+            qemu_printf("TB information not being recorded");
+            return;
+        }
+        if (!last_search) {
+            qemu_printf("no search on record! execute info tbs before filtering!");
+            return;
+        }
+
+        set_default_tbstats_flag(TB_NOTHING);
+
+        /* Set all tbstats as paused, then return only the ones from last_search */
+        pause_collect_tb_stats();
+        set_tbstats_flags(TB_PAUSED);
+
+        for (GList *iter = last_search; iter; iter = g_list_next(iter)) {
+            TBStatistics *tbs = iter->data;
+            tbs->stats_enabled = level;
+        }
+
+        tb_flush(cpu);
+
+        break;
+    default: /* INVALID */
+        g_assert_not_reached();
+        break;
+    }
+
+    g_free(cmdinfo);
+}
+
 void init_tb_stats_htable_if_not(void)
 {
     if (tb_stats_collection_enabled() && !tb_ctx.tb_stats.map) {
@@ -189,6 +281,19 @@ bool tb_stats_collection_paused(void)
     return tcg_collect_tb_stats == TB_STATS_PAUSED;
 }
 
+static void reset_tbstats_flag(void *p, uint32_t hash, void *userp)
+{
+    uint32_t flag = *((int *)userp);
+    TBStatistics *tbs = p;
+    tbs->stats_enabled = flag;
+}
+
+void set_tbstats_flags(uint32_t flag)
+{
+    /* iterate over tbstats setting their flag as TB_NOTHING */
+    qht_iter(&tb_ctx.tb_stats, reset_tbstats_flag, &flag);
+}
+
 uint32_t get_default_tbstats_flag(void)
 {
     return default_tbstats_flag;
diff --git a/hmp-commands.hx b/hmp-commands.hx
index cfcc044ce4..6cd2800378 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1886,6 +1886,23 @@ STEXI
 @findex qemu-io
 Executes a qemu-io command on the given block device.
 
+ETEXI
+#if defined(CONFIG_TCG)
+    {
+        .name       = "tb_stats",
+        .args_type  = "command:s,level:s?",
+        .params     = "command [stats_level]",
+        .help       = "Control tb statistics collection:"
+                        "tb_stats (start|pause|stop|filter) [all|jit_stats|exec_stats]",
+        .cmd        = hmp_tbstats,
+    },
+#endif
+
+STEXI
+@item tb_stats
+@findex
+Control recording tb statistics
+
 ETEXI
 
     {
diff --git a/include/exec/tb-stats-flags.h b/include/exec/tb-stats-flags.h
index 8455073048..252304d685 100644
--- a/include/exec/tb-stats-flags.h
+++ b/include/exec/tb-stats-flags.h
@@ -15,6 +15,7 @@
 #define TB_EXEC_STATS (1 << 1)
 #define TB_JIT_STATS  (1 << 2)
 #define TB_JIT_TIME   (1 << 3)
+#define TB_PAUSED     (1 << 4)
 
 /* TBStatistic collection controls */
 void enable_collect_tb_stats(void);
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index 019d316f5c..921da38c97 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -32,6 +32,9 @@
 
 #include "exec/tb-stats-flags.h"
 
+enum SortBy { SORT_BY_HOTNESS, SORT_BY_HG /* Host/Guest */, SORT_BY_SPILLS };
+enum TbstatsCmd { START, PAUSE, STOP, FILTER };
+
 #define tb_stats_enabled(tb, JIT_STATS) \
     (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
 
@@ -115,4 +118,11 @@ void init_tb_stats_htable_if_not(void);
 
 void dump_jit_profile_info(TCGProfile *s);
 
+struct TbstatsCommand {
+    enum TbstatsCmd cmd;
+    uint32_t level;
+};
+
+void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd);
+
 #endif
diff --git a/monitor/misc.c b/monitor/misc.c
index ac4ff58d96..218263d29a 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -74,6 +74,8 @@
 #include "sysemu/cpus.h"
 #include "qemu/cutils.h"
 #include "tcg/tcg.h"
+#include "exec/tb-stats.h"
+#include "qemu-common.h"
 
 #if defined(TARGET_S390X)
 #include "hw/s390x/storage-keys.h"
@@ -459,6 +461,49 @@ static void hmp_info_registers(Monitor *mon, const QDict *qdict)
 }
 
 #ifdef CONFIG_TCG
+static void hmp_tbstats(Monitor *mon, const QDict *qdict)
+{
+    if (!tcg_enabled()) {
+        error_report("TB information is only available with accel=tcg");
+        return;
+    }
+
+    char *cmd = (char *) qdict_get_try_str(qdict, "command");
+    enum TbstatsCmd icmd = -1;
+
+    if (strcmp(cmd, "start") == 0) {
+        icmd = START;
+    } else if (strcmp(cmd, "pause") == 0) {
+        icmd = PAUSE;
+    } else if (strcmp(cmd, "stop") == 0) {
+        icmd = STOP;
+    } else if (strcmp(cmd, "filter") == 0) {
+        icmd = FILTER;
+    } else {
+        error_report("invalid command!");
+        return;
+    }
+
+    char *slevel = (char *) qdict_get_try_str(qdict, "level");
+    uint32_t level = TB_EXEC_STATS | TB_JIT_STATS | TB_JIT_TIME;
+    if (slevel) {
+        if (strcmp(slevel, "jit") == 0) {
+            level = TB_JIT_STATS;
+        } else if (strcmp(slevel, "exec") == 0) {
+            level = TB_EXEC_STATS;
+        } else if (strcmp(slevel, "time") == 0) {
+            level = TB_JIT_TIME;
+        }
+    }
+
+    struct TbstatsCommand *tbscommand = g_new0(struct TbstatsCommand, 1);
+    tbscommand->cmd = icmd;
+    tbscommand->level = level;
+    async_safe_run_on_cpu(first_cpu, do_hmp_tbstats_safe,
+                          RUN_ON_CPU_HOST_PTR(tbscommand));
+
+}
+
 static void hmp_info_jit(Monitor *mon, const QDict *qdict)
 {
     if (!tcg_enabled()) {
@@ -1089,8 +1134,12 @@ static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
 
 static void hmp_info_profile(Monitor *mon, const QDict *qdict)
 {
+#ifdef CONFIG_TCG
     dump_jit_exec_time_info(dev_time);
     dev_time = 0;
+#else
+    error_report("TCG should be enabled!");
+#endif
 }
 
 /* Capture support */
diff --git a/vl.c b/vl.c
index f91bc6fb4c..781fddaf18 100644
--- a/vl.c
+++ b/vl.c
@@ -1796,11 +1796,17 @@ static bool main_loop_should_exit(void)
 
 static void main_loop(void)
 {
+#ifdef CONFIG_TCG
     uint64_t ti;
+#endif
     while (!main_loop_should_exit()) {
+#ifdef CONFIG_TCG
         ti = profile_getclock();
+#endif
         main_loop_wait(false);
+#ifdef CONFIG_TCG
         dev_time += profile_getclock() - ti;
+#endif
     }
 }
 
-- 
2.20.1



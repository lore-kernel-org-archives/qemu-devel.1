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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CB1C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10362189D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkq37QTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10362189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3OSg-0005Rx-OW
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 13:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3OKN-0004vo-Ds
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3OKJ-0000J9-0i
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:35:18 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:32815)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i3OKI-0000Ij-PQ
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:35:14 -0400
Received: by mail-qk1-x742.google.com with SMTP id w18so3735345qki.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vD3H1azDT1nF0aF1U/15SXskrW4/Xq3TLViAuCH6Ixk=;
 b=tkq37QTpco6RTHhxC+HNhvtkuuiY5pRIvPXfOTBbzYsgRg1m+DNX4cm+2Dw1JhEhV5
 09VfnXplWnXrHsQo86OByeA7l8rIOHVpxOCN7C6NiD9bm7QWbrqBJyhwGdTpeYA95XFf
 R3BbrHYTgsMCakfH93m7rdOymM/C7kxqoM4HU3m7lrMbRDWkgOUtIY7MPNNuyxHVkDYU
 z0Uco34059i1Lz+mCzYuTk7Z2TkuL3eN73r7vupdRIg5szheRKi+9lz/YlYYiHJKSEYr
 84w4H7KD8DJosFP/pO/7Ahfx5anSfsvsPnrEnD5A7I5lVC0MyWGE8xsQAnxDEhX63mdB
 8xGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vD3H1azDT1nF0aF1U/15SXskrW4/Xq3TLViAuCH6Ixk=;
 b=N21naW+jQ6Cw7MXJiH0FdXKMpcRjM7Gufx9GzuRaJJB6b0goDPQCMBHY6eb8e1MmI0
 W+00vPtImueIgw78egrg44R4J4B+k9T4dR5s8dE1PYKDNaGmtF7SGia/yWftQ3ukIe5q
 lWecC9n+gzTkocfOtY3Z+gvuThkqOaHmyRbMppLHweKXcxipC2o4MiXMxEnUolsJE+Us
 Cn4ef/RBcMDIkUkJxNExONHHYX0eIsQe0P9Hf0I/9JzXJZlKXXEcwN7hCKVwZmaCM4pB
 0EVo6831uZaTU6QFhBaFNRxEZK3cz9gIVR95kfHTwBN9EVHUCyd+sTAHtB+6e1dk5lxJ
 Z24w==
X-Gm-Message-State: APjAAAWNXblShUGmkZn+etVPLmA9VkA1u74dMC1y/XA6n5QkA0VAR2W7
 R+1+GfEqoYxUN80/jdX104XF/8abrPg47Q==
X-Google-Smtp-Source: APXvYqzmyvugOLTzbDyLwI/qfdKmWzlXXWK6M2MMurP9vQn335FmV9gtkra3UE0sIc2RdJi7ipvslw==
X-Received: by 2002:a05:620a:1518:: with SMTP id
 i24mr10922575qkk.276.1567100114010; 
 Thu, 29 Aug 2019 10:35:14 -0700 (PDT)
Received: from vanderson-lmcad.gw.lmcad.ic.unicamp.br (gw.lmcad.ic.unicamp.br.
 [143.106.73.166])
 by smtp.googlemail.com with ESMTPSA id j50sm1721700qtj.30.2019.08.29.10.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 10:35:13 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 14:34:33 -0300
Message-Id: <20190829173437.5926-8-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829173437.5926-1-vandersonmr2@gmail.com>
References: <20190829173437.5926-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: [Qemu-devel] [PATCH v8 07/11] monitor: adding tb_stats hmp command
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 accel/tcg/tb-stats.c          | 110 ++++++++++++++++++++++++++++++++++
 hmp-commands.hx               |  17 ++++++
 include/exec/tb-stats-flags.h |   1 +
 include/exec/tb-stats.h       |  11 ++++
 monitor/misc.c                |  47 +++++++++++++++
 vl.c                          |   6 ++
 6 files changed, 192 insertions(+)

diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 66abc97ad4..9959477fbb 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -32,6 +32,9 @@
 
 #include "exec/tb-stats.h"
 
+/* only accessed in safe work */
+static GList *last_search;
+
 uint64_t dev_time;
 
 struct jit_profile_info {
@@ -160,6 +163,95 @@ void dump_jit_profile_info(TCGProfile *s)
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
 
 void init_tb_stats_htable_if_not(void)
 {
@@ -195,6 +287,24 @@ bool tb_stats_collection_paused(void)
     return tcg_collect_tb_stats == TB_STATS_PAUSED;
 }
 
+static void reset_tbstats_flag(void *p, uint32_t hash, void *userp)
+{
+    uint32_t flag = *((int *)userp);
+    TBStatistics *tbs = p;
+    tbs->stats_enabled = flag;
+}
+
+void set_default_tbstats_flag(uint32_t flag)
+{
+    default_tbstats_flag = flag;
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
index c936ac1084..16b563f858 100644
--- a/include/exec/tb-stats-flags.h
+++ b/include/exec/tb-stats-flags.h
@@ -35,6 +35,7 @@ enum TBStatsStatus {
 #define TB_EXEC_STATS (1 << 1)
 #define TB_JIT_STATS  (1 << 2)
 #define TB_JIT_TIME   (1 << 3)
+#define TB_PAUSED     (1 << 4)
 
 extern int tcg_collect_tb_stats;
 extern uint32_t default_tbstats_flag;
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index 6a53bef31b..65063c52d7 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -32,6 +32,9 @@
 
 #include "exec/tb-stats-flags.h"
 
+enum SortBy { SORT_BY_HOTNESS, SORT_BY_HG /* Host/Guest */, SORT_BY_SPILLS };
+enum TbstatsCmd { START, PAUSE, STOP, FILTER };
+
 #define tb_stats_enabled(tb, JIT_STATS) \
     (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
 
@@ -105,6 +108,13 @@ void init_tb_stats_htable_if_not(void);
 
 void dump_jit_profile_info(TCGProfile *s);
 
+struct TbstatsCommand {
+    enum TbstatsCmd cmd;
+    uint32_t level;
+};
+
+void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd);
+
 /* TBStatistic collection controls */
 void enable_collect_tb_stats(void);
 void disable_collect_tb_stats(void);
@@ -112,6 +122,7 @@ void pause_collect_tb_stats(void);
 bool tb_stats_collection_enabled(void);
 bool tb_stats_collection_paused(void);
 
+void set_default_tbstats_flag(uint32_t flag);
 uint32_t get_default_tbstats_flag(void);
 
 #endif
diff --git a/monitor/misc.c b/monitor/misc.c
index ac4ff58d96..b389ca09a1 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -459,6 +459,49 @@ static void hmp_info_registers(Monitor *mon, const QDict *qdict)
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
@@ -1089,8 +1132,12 @@ static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
 
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
index 4203cc728c..dcb30eea8a 100644
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
2.22.0



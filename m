Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C768C76195
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C0A221849
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vY6O1zOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0A221849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hodnf-0002mx-Bu
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 21:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40021)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hodmY-0006kF-MH
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hodmX-0006Jk-7l
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:26 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:42422)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hodmX-0006JT-3K
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:25 -0400
Received: by mail-qk1-x741.google.com with SMTP id 201so24604925qkm.9
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 18:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sdpQWCV7Cjpv4flMehmz5yUQ3sapqz2tfzkJtrHP/nw=;
 b=vY6O1zORLccmcWX+l+NYIFZZ1BmfDB8uDywhu3lqVnpWFjMvSHnwVN0OTryQwTOQ/G
 BerpLkahUVd3hRQfS9G8Dp0JJbwEmZWWyZUj8M17SyiLx2FNSP9BGNEo1nxYKey+uwto
 gghniSiohZE0arw0Tex3gYZ+MGVxfX+r3UDY/F7qyPBPD7iteJtxxWHhuDhgv0waJR/6
 JhnCj420MlFU+duWeqKbmqo6QJZb5fLeAbY0tXX12xF1z8NsNrILBsibqoH6T6Vt/xme
 azzdtEiTA1HZsw0Tl3N152/V7XtZYAhz6a7uK16XQ5fVv9fJKBx3tU7PcKYU4t+RMBFh
 zB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sdpQWCV7Cjpv4flMehmz5yUQ3sapqz2tfzkJtrHP/nw=;
 b=hSKdGowjojoIt9nj2n7qPUOO14io5a4qqjX8AD0W1EOYvKlbhHF2Ygka9FbiOS1BId
 1gwq7zP2/O1tTR6dfmfci8BM6uxrI747UoGkl01TQFz0XlBj3NpL/eiNTJxAOR3Sv360
 NAgnqFpoAP6NARYRPubf/wG2E36QTYE+R8h6ML2MEydfVWQc4kyp0Uhs8lTma6K9ZpiG
 H2pn9FaEUiQcKl/lWCH6uLOgEABliOU+7lz2QNALCEv8JIouqUL1J4njeOvl52xerbim
 /ATdYkeieRQkawyNPZIU0u/Jft7shJRaZmTBvJekCVom1Qy/PHZMo4OMn861At14r1dh
 LvDA==
X-Gm-Message-State: APjAAAXFgBlfKgWKof7IB7kMFgsU2CJeA96AVaBuC8yFPzDOQkpWCHzd
 tYvQsBSnaD4i6Lsv+IDYIiQ5YCDJfQY=
X-Google-Smtp-Source: APXvYqyep1CXhaUdyJPKovQVOcj8L6PSxngVBC+hQwXlmTjwusB/cCR2/Ss2qRCy3NDwCxNIBgHpeQ==
X-Received: by 2002:a05:620a:232:: with SMTP id
 u18mr36157372qkm.131.1563584604239; 
 Fri, 19 Jul 2019 18:03:24 -0700 (PDT)
Received: from vanderson-lmcad.domain.name ([177.137.96.41])
 by smtp.googlemail.com with ESMTPSA id g10sm13405115qki.37.2019.07.19.18.03.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 18:03:23 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 22:02:34 -0300
Message-Id: <20190720010235.32444-7-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190720010235.32444-1-vandersonmr2@gmail.com>
References: <20190720010235.32444-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: [Qemu-devel] [PATCH v4 6/7] monitor: adding tb_stats hmp command
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding tb_stats [start|pause|stop|filter] command to hmp.
This allows controlling the collection of statistics.
It is also possible to set the level of collection:
all, jit, or exec.

The goal of this command is to allow the dynamic exploration
of the TCG behavior and quality. Therefore, for now, a
corresponding QMP command is not worthwhile.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 accel/tcg/tb-stats.c    | 107 ++++++++++++++++++++++++++++++++++++++++
 hmp-commands.hx         |  17 +++++++
 include/exec/tb-stats.h |  13 +++++
 include/qemu/log.h      |   1 +
 monitor/misc.c          |  40 +++++++++++++++
 5 files changed, 178 insertions(+)

diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 44497d4f9b..6c330e1b02 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -6,6 +6,9 @@
 
 #include "qemu/qemu-print.h"
 
+/* only accessed in safe work */
+static GList *last_search;
+
 struct jit_profile_info {
     uint64_t translations;
     uint64_t aborted;
@@ -104,4 +107,108 @@ void dump_jit_profile_info(TCGProfile *s)
     }
 }
 
+static void dessaloc_tbstats(void *p, uint32_t hash, void *userp)
+{
+    g_free(p);
+}
+
+void clean_tbstats(void)
+{
+    /* remove all tb_stats */
+    qht_iter(&tb_ctx.tb_stats, dessaloc_tbstats, NULL);
+    qht_destroy(&tb_ctx.tb_stats);
+}
+
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
+void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd)
+{
+    struct TbstatsCommand *cmdinfo = icmd.host_ptr;
+    int cmd = cmdinfo->cmd;
+    uint32_t level = cmdinfo->level;
+
+    /* for safe, always pause TB generation while running this commands */
+    mmap_lock();
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
+        tb_flush(cpu);
+        set_default_tbstats_flag(TB_NOTHING);
+        set_tbstats_flags(TB_PAUSED);
+        break;
+    case STOP:
+        if (!tb_stats_collection_enabled()) {
+            qemu_printf("TB information not being recorded");
+            return;
+        }
+
+        /* Dissalloc all TBStatistics structures and stop creating new ones */
+        disable_collect_tb_stats();
+        tb_flush(cpu);
+        clean_tbstats();
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
+        tb_flush(cpu);
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
+        break;
+    default: /* INVALID */
+        break;
+    }
+
+    mmap_unlock();
+    g_free(cmdinfo);
+}
 
diff --git a/hmp-commands.hx b/hmp-commands.hx
index bfa5681dd2..419898751e 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1885,6 +1885,23 @@ STEXI
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
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index 7d775f2c0d..d1debd3262 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -6,6 +6,9 @@
 #include "exec/tb-context.h"
 #include "tcg.h"
 
+enum SortBy { SORT_BY_HOTNESS, SORT_BY_HG /* Host/Guest */, SORT_BY_SPILLS };
+enum TbstatsCmd { START, PAUSE, STOP, FILTER };
+
 #define tb_stats_enabled(tb, JIT_STATS) \
     (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
 
@@ -60,4 +63,14 @@ bool tb_stats_cmp(const void *ap, const void *bp);
 
 void dump_jit_profile_info(TCGProfile *s);
 
+void set_tbstats_flags(uint32_t flags);
+void clean_tbstats(void);
+
+struct TbstatsCommand {
+    enum TbstatsCmd cmd;
+    uint32_t level;
+};
+
+void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd);
+
 #endif
diff --git a/include/qemu/log.h b/include/qemu/log.h
index 93642603e5..47071d72c7 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -133,6 +133,7 @@ void qemu_log_close(void);
 #define TB_NOTHING    0
 #define TB_EXEC_STATS (1 << 1)
 #define TB_JIT_STATS  (1 << 2)
+#define TB_PAUSED     (1 << 3)
 
 void enable_collect_tb_stats(void);
 void disable_collect_tb_stats(void);
diff --git a/monitor/misc.c b/monitor/misc.c
index 00338c002a..aea9b0db4f 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -459,6 +459,46 @@ static void hmp_info_registers(Monitor *mon, const QDict *qdict)
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
+    }
+
+    char *slevel = (char *) qdict_get_try_str(qdict, "level");
+    uint32_t level = TB_EXEC_STATS | TB_JIT_STATS;
+    if (slevel) {
+        if (strcmp(slevel, "jit_stats") == 0) {
+            level = TB_JIT_STATS;
+        } else if (strcmp(slevel, "exec_stats") == 0) {
+            level = TB_EXEC_STATS;
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
-- 
2.22.0



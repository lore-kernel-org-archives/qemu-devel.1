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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB74C76195
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6AFA21849
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEDvB4oq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AFA21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hodnD-0000Tu-4G
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 21:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40046)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hodmc-0006yy-AN
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hodma-0006L7-7s
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:30 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:37219)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hodma-0006Ku-3O
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:28 -0400
Received: by mail-qt1-x843.google.com with SMTP id y26so32960139qto.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 18:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jGbHahYOnfICsEzwQqgwSq7n9jZvhlLuJDCHxmfZRx4=;
 b=NEDvB4oqIoJxiISTY7DQLwKUuyXug89uLPnaz3edaaDAgktUh9uwQopIiitqWFVoyN
 W6Y6riXve0UWFUksnkiq7CG9a9c2RXoa/yWJwOP8Wa2dVxV55WhocQVLQ6SpwnPb/zvT
 vEJ9LJo+yuQ+6yyWWWvA0l3ROTBLAqwqGayWgL/LyY7kFeU/1nwRxcONRQ3hOiS8QIVA
 kaV6VrPhIUlc4frJhYmU+NB8E8yNFpZpeqY9IC90D2+VBDg82zFBJvAf22Jn7oErrR89
 mQ8N5hBw+7uijRlQjsTGjFZZHZLrTEJVTQyPonzrBEQKCZlLVuwjVS3xG+X76RIscNVD
 CafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jGbHahYOnfICsEzwQqgwSq7n9jZvhlLuJDCHxmfZRx4=;
 b=eEaL4ugcy+F4UAK4fRrKgT/Cm3huYN9f2rJSObV4o48pfXllqPK05bHOubuKF1N0xl
 I+xNgbm3XdLj5vqZ25HuRNL6Jh16y6md5s0ZZS+Y3i1fwWO1sT552mb3GjNyh8XF5fn9
 A/BbL0B9D7U/sloQxqzwNymAHFnzUSHFQo4YLxHFERDm/zMWzadWKGL0TzRSRjZ0C2TY
 bnoDF7SLw4XINeaf0kHiWA/H+J69UhuXAULWSnZMuqLPoH8yyDreZg9U5kXMi/xkzKbf
 z8EWd4pWHavnm6DPgtFxf8l2W+blbhKJnzLJ2UC3X7Ljr677VQMwLdcUWolXD7lOPQDC
 eyFA==
X-Gm-Message-State: APjAAAWfOTnneaBGlgC+voFG4tJB7D+CKzGb5jAScvELQYtCkPKBM6O7
 +guTgemLWqWqh6eqja9hkc61mvR/anA=
X-Google-Smtp-Source: APXvYqwAsSghj2yBYLO/cBnDkLwjA78SN/r4ZHuNhMsIscq5un6vsLrhMbBRwyPGk3foD5xdwr5hGg==
X-Received: by 2002:ac8:285c:: with SMTP id 28mr40780545qtr.186.1563584607194; 
 Fri, 19 Jul 2019 18:03:27 -0700 (PDT)
Received: from vanderson-lmcad.domain.name ([177.137.96.41])
 by smtp.googlemail.com with ESMTPSA id g10sm13405115qki.37.2019.07.19.18.03.24
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 18:03:26 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 22:02:35 -0300
Message-Id: <20190720010235.32444-8-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190720010235.32444-1-vandersonmr2@gmail.com>
References: <20190720010235.32444-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
Subject: [Qemu-devel] [PATCH v4 7/7] monitor: adding info tbs, tb,
 and coverset
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
Cc: vandersonmr <vandersonmr2@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding info [tbs|tb|coverset] commands to HMP.
These commands allow the exploration of TBs
generated by the TCG. Understand which one
hotter, with more guest/host instructions...
and examine their guest, host and IR code.

The goal of this command is to allow the dynamic exploration
of TCG behavior and code quality. Therefore, for now, a
corresponding QMP command is not worthwhile.

Signed-off-by: vandersonmr <vandersonmr2@gmail.com>
---
 accel/tcg/tb-stats.c         | 275 +++++++++++++++++++++++++++++++++++
 hmp-commands-info.hx         |  23 +++
 include/exec/tb-stats.h      |  37 +++++
 include/qemu/log-for-trace.h |   2 +
 include/qemu/log.h           |   1 +
 linux-user/exit.c            |   4 +
 monitor/misc.c               |  71 +++++++++
 util/log.c                   |  26 +++-
 8 files changed, 431 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 6c330e1b02..85a16cd563 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -212,3 +212,278 @@ void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd)
     g_free(cmdinfo);
 }
 
+static void collect_tb_stats(void *p, uint32_t hash, void *userp)
+{
+    last_search = g_list_prepend(last_search, p);
+}
+
+static void dump_tb_header(TBStatistics *tbs)
+{
+    unsigned g = tbs->translations.total ?
+        tbs->code.num_guest_inst / tbs->translations.total : 0;
+    unsigned ops = tbs->translations.total ?
+        tbs->code.num_tcg_ops / tbs->translations.total : 0;
+    unsigned ops_opt = tbs->translations.total ?
+        tbs->code.num_tcg_ops_opt / tbs->translations.total : 0;
+    unsigned h = tbs->translations.total ?
+        tbs->code.num_host_inst / tbs->translations.total : 0;
+    unsigned spills = tbs->translations.total ?
+        tbs->code.spills / tbs->translations.total : 0;
+
+    float guest_host_prop = g ? ((float) h / g) : 0;
+
+    qemu_log("TB%d: phys:0x"TB_PAGE_ADDR_FMT" virt:0x"TARGET_FMT_lx
+             " flags:%#08x (trans:%lu uncached:%lu exec:%lu ints: g:%u op:%u op_opt:%u h:%u h/g:%.2f spills:%d)\n",
+             tbs->display_id,
+             tbs->phys_pc, tbs->pc, tbs->flags,
+             tbs->translations.total, tbs->translations.uncached,
+             tbs->executions.total, g, ops, ops_opt, h, guest_host_prop,
+             spills);
+}
+
+static gint
+inverse_sort_tbs(gconstpointer p1, gconstpointer p2, gpointer psort_by)
+{
+    const TBStatistics *tbs1 = (TBStatistics *) p1;
+    const TBStatistics *tbs2 = (TBStatistics *) p2;
+    int sort_by = *((int *) psort_by);
+    unsigned long c1 = 0;
+    unsigned long c2 = 0;
+
+    if (likely(sort_by == SORT_BY_SPILLS)) {
+        c1 = tbs1->code.spills;
+        c2 = tbs2->code.spills;
+    } else if (likely(sort_by == SORT_BY_HOTNESS)) {
+        c1 = tbs1->executions.total;
+        c2 = tbs2->executions.total;
+    } else if (likely(sort_by == SORT_BY_HG)) {
+        if (tbs1->code.num_guest_inst == 0) {
+            return -1;
+        }
+        if (tbs2->code.num_guest_inst == 0) {
+            return 1;
+        }
+
+        float a = (float) tbs1->code.num_host_inst / tbs1->code.num_guest_inst;
+        float b = (float) tbs2->code.num_host_inst / tbs2->code.num_guest_inst;
+        c1 = a <= b ? 0 : 1;
+        c2 = a <= b ? 1 : 0;
+    }
+
+    return c1 < c2 ? 1 : c1 == c2 ? 0 : -1;
+}
+
+static void do_dump_coverset_info(int percentage)
+{
+    uint64_t total_exec_count = 0;
+    uint64_t covered_exec_count = 0;
+    unsigned coverset_size = 0;
+    int id = 1;
+    GList *i;
+
+    g_list_free(last_search);
+    last_search = NULL;
+
+    qht_iter(&tb_ctx.tb_stats, collect_tb_stats, NULL);
+
+    int sort_by = SORT_BY_HOTNESS;
+    last_search = g_list_sort_with_data(last_search, inverse_sort_tbs, &sort_by);
+
+    if (!last_search) {
+        qemu_log("No data collected yet\n");
+        return;
+    }
+
+    /* Compute total execution count for all tbs */
+    for (i = last_search; i; i = i->next) {
+        TBStatistics *tbs = (TBStatistics *) i->data;
+        total_exec_count += tbs->executions.total * tbs->code.num_guest_inst;
+    }
+
+    for (i = last_search; i; i = i->next) {
+        TBStatistics *tbs = (TBStatistics *) i->data;
+        covered_exec_count += tbs->executions.total * tbs->code.num_guest_inst;
+        tbs->display_id = id++;
+        coverset_size++;
+        dump_tb_header(tbs);
+
+        /* Iterate and display tbs until reach the percentage count cover */
+        if (((double) covered_exec_count / total_exec_count) >
+                ((double) percentage / 100)) {
+            break;
+        }
+    }
+
+    qemu_log("\n------------------------------\n");
+    qemu_log("# of TBs to reach %d%% of the total of guest insts exec: %u\t",
+                percentage, coverset_size);
+    qemu_log("Total of guest insts exec: %lu\n", total_exec_count);
+    qemu_log("\n------------------------------\n");
+
+    /* free the unused bits */
+    if (i) {
+        if (i->next) {
+            i->next->prev = NULL;
+        }
+        g_list_free(i->next);
+        i->next = NULL;
+    }
+}
+
+static void do_dump_tbs_info(int count, int sort_by)
+{
+    int id = 1;
+    GList *i;
+
+    g_list_free(last_search);
+    last_search = NULL;
+
+    qht_iter(&tb_ctx.tb_stats, collect_tb_stats, NULL);
+
+    last_search = g_list_sort_with_data(last_search, inverse_sort_tbs,
+                                        &sort_by);
+
+    if (!last_search) {
+        qemu_printf("No data collected yet!\n");
+        return;
+    }
+
+    for (i = last_search; i && count--; i = i->next) {
+        TBStatistics *tbs = (TBStatistics *) i->data;
+        tbs->display_id = id++;
+        dump_tb_header(tbs);
+    }
+
+    /* free the unused bits */
+    if (i) {
+        if (i->next) {
+            i->next->prev = NULL;
+        }
+        g_list_free(i->next);
+        i->next = NULL;
+    }
+}
+
+static void
+do_dump_coverset_info_safe(CPUState *cpu, run_on_cpu_data percentage)
+{
+    qemu_log_to_monitor(true);
+    do_dump_coverset_info(percentage.host_int);
+    qemu_log_to_monitor(false);
+}
+
+struct tbs_dump_info {
+    int count;
+    int sort_by;
+};
+
+static void do_dump_tbs_info_safe(CPUState *cpu, run_on_cpu_data tbdi)
+{
+    struct tbs_dump_info *info = tbdi.host_ptr;
+    qemu_log_to_monitor(true);
+    do_dump_tbs_info(info->count, info->sort_by);
+    qemu_log_to_monitor(false);
+    g_free(info);
+}
+
+/*
+ * When we dump_tbs_info on a live system via the HMP we want to
+ * ensure the system is quiessent before we start outputting stuff.
+ * Otherwise we could pollute the output with other logging output.
+ */
+void dump_coverset_info(int percentage, bool use_monitor)
+{
+    if (use_monitor) {
+        async_safe_run_on_cpu(first_cpu, do_dump_coverset_info_safe,
+                              RUN_ON_CPU_HOST_INT(percentage));
+    } else {
+        do_dump_coverset_info(percentage);
+    }
+}
+
+void dump_tbs_info(int count, int sort_by, bool use_monitor)
+{
+    if (use_monitor) {
+        struct tbs_dump_info *tbdi = g_new(struct tbs_dump_info, 1);
+        tbdi->count = count;
+        tbdi->sort_by = sort_by;
+        async_safe_run_on_cpu(first_cpu, do_dump_tbs_info_safe,
+                              RUN_ON_CPU_HOST_PTR(tbdi));
+    } else {
+        do_dump_tbs_info(count, sort_by);
+    }
+}
+
+static void do_tb_dump_with_statistics(TBStatistics *tbs, int log_flags)
+{
+    CPUState *cpu = current_cpu;
+    uint32_t cflags = curr_cflags() | CF_NOCACHE;
+    int old_log_flags = qemu_loglevel;
+    TranslationBlock *tb = NULL;
+
+    qemu_set_log(log_flags);
+
+    qemu_log("\n------------------------------\n");
+    dump_tb_header(tbs);
+
+    if (sigsetjmp(cpu->jmp_env, 0) == 0) {
+        mmap_lock();
+        tb = tb_gen_code(cpu, tbs->pc, tbs->cs_base, tbs->flags, cflags);
+        tb_phys_invalidate(tb, -1);
+        mmap_unlock();
+    } else {
+        /*
+         * The mmap_lock is dropped by tb_gen_code if it runs out of
+         * memory.
+         */
+        fprintf(stderr, "%s: dbg failed!\n", __func__);
+        assert_no_pages_locked();
+    }
+
+    qemu_set_log(old_log_flags);
+
+    tcg_tb_remove(tb);
+}
+
+struct tb_dump_info {
+    int id;
+    int log_flags;
+    bool use_monitor;
+};
+
+static void do_dump_tb_info_safe(CPUState *cpu, run_on_cpu_data info)
+{
+    struct tb_dump_info *tbdi = (struct tb_dump_info *) info.host_ptr;
+    GList *iter;
+
+    if (!last_search) {
+        qemu_printf("no search on record");
+        return;
+    }
+    qemu_log_to_monitor(tbdi->use_monitor);
+
+    for (iter = last_search; iter; iter = g_list_next(iter)) {
+        TBStatistics *tbs = iter->data;
+        if (tbs->display_id == tbdi->id) {
+            do_tb_dump_with_statistics(tbs, tbdi->log_flags);
+            break;
+        }
+    }
+    qemu_log_to_monitor(false);
+    g_free(tbdi);
+}
+
+void dump_tb_info(int id, int log_mask, bool use_monitor)
+{
+    struct tb_dump_info *tbdi = g_new(struct tb_dump_info, 1);
+
+    tbdi->id = id;
+    tbdi->log_flags = log_mask;
+    tbdi->use_monitor = use_monitor;
+
+    async_safe_run_on_cpu(first_cpu, do_dump_tb_info_safe,
+                          RUN_ON_CPU_HOST_PTR(tbdi));
+
+    /* tbdi free'd by do_dump_tb_info_safe */
+}
+
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index c59444c461..761c76619b 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -289,6 +289,29 @@ ETEXI
         .help       = "show dynamic compiler info",
         .cmd        = hmp_info_jit,
     },
+    {
+        .name       = "tbs",
+        .args_type  = "number:i?,sortedby:s?",
+        .params     = "[number sortedby]",
+        .help       = "show a [number] translated blocks sorted by [sortedby]"
+                      "sortedby opts: hotness hg",
+        .cmd        = hmp_info_tbs,
+    },
+    {
+        .name       = "tb",
+        .args_type  = "id:i,flags:s?",
+        .params     = "id [log1[,...] flags]",
+        .help       = "show information about one translated block by id",
+        .cmd        = hmp_info_tb,
+    },
+    {
+        .name       = "coverset",
+        .args_type  = "number:i?",
+        .params     = "[number]",
+        .help       = "show hottest translated blocks neccesary to cover"
+                      "[number]% of the execution count",
+        .cmd        = hmp_info_coverset,
+    },
 #endif
 
 STEXI
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index d1debd3262..e2ab1068c3 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -57,6 +57,9 @@ struct TBStatistics {
         unsigned long uncached;
         unsigned long spanning;
     } translations;
+
+    /* HMP information - used for referring to previous search */
+    int display_id;
 };
 
 bool tb_stats_cmp(const void *ap, const void *bp);
@@ -73,4 +76,38 @@ struct TbstatsCommand {
 
 void do_hmp_tbstats_safe(CPUState *cpu, run_on_cpu_data icmd);
 
+/**
+ * dump_coverset_info: report the hottest blocks to cover n% of execution
+ *
+ * @percentage: cover set percentage
+ * @use_monitor: redirect output to monitor
+ *
+ * Report the hottest blocks to either the log or monitor
+ */
+void dump_coverset_info(int percentage, bool use_monitor);
+
+
+/**
+ * dump_tbs_info: report the hottest blocks
+ *
+ * @count: the limit of hotblocks
+ * @sort_by: property in which the dump will be sorted
+ * @use_monitor: redirect output to monitor
+ *
+ * Report the hottest blocks to either the log or monitor
+ */
+void dump_tbs_info(int count, int sort_by, bool use_monitor);
+
+/**
+ * dump_tb_info: dump information about one TB
+ *
+ * @id: the display id of the block (from previous search)
+ * @mask: the temporary logging mask
+ * @Use_monitor: redirect output to monitor
+ *
+ * Re-run a translation of a block at addr for the purposes of debug output
+ */
+void dump_tb_info(int id, int log_mask, bool use_monitor);
+
+
 #endif
diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
index 2f0a5b080e..d65eb83037 100644
--- a/include/qemu/log-for-trace.h
+++ b/include/qemu/log-for-trace.h
@@ -21,6 +21,8 @@
 /* Private global variable, don't use */
 extern int qemu_loglevel;
 
+extern int32_t max_num_hot_tbs_to_dump;
+
 #define LOG_TRACE          (1 << 15)
 
 /* Returns true if a bit is set in the current loglevel mask */
diff --git a/include/qemu/log.h b/include/qemu/log.h
index 47071d72c7..27ba267faa 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -114,6 +114,7 @@ typedef struct QEMULogItem {
 extern const QEMULogItem qemu_log_items[];
 
 void qemu_set_log(int log_flags);
+void qemu_log_to_monitor(bool enable);
 void qemu_log_needs_buffers(void);
 void qemu_set_log_filename(const char *filename, Error **errp);
 void qemu_set_dfilter_ranges(const char *ranges, Error **errp);
diff --git a/linux-user/exit.c b/linux-user/exit.c
index bdda720553..7226104959 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -28,6 +28,10 @@ extern void __gcov_dump(void);
 
 void preexit_cleanup(CPUArchState *env, int code)
 {
+    if (tb_stats_collection_enabled()) {
+        dump_tbs_info(max_num_hot_tbs_to_dump, SORT_BY_HOTNESS, false);
+    }
+
 #ifdef TARGET_GPROF
         _mcleanup();
 #endif
diff --git a/monitor/misc.c b/monitor/misc.c
index aea9b0db4f..78ada8aa0e 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -499,6 +499,77 @@ static void hmp_tbstats(Monitor *mon, const QDict *qdict)
 
 }
 
+static void hmp_info_tbs(Monitor *mon, const QDict *qdict)
+{
+    int n;
+    const char *s = NULL;
+    if (!tcg_enabled()) {
+        error_report("TB information is only available with accel=tcg");
+        return;
+    }
+    if (!tb_ctx.tb_stats.map) {
+        error_report("no TB information recorded");
+        return;
+    }
+
+    n = qdict_get_try_int(qdict, "number", 10);
+    s = qdict_get_try_str(qdict, "sortedby");
+
+    int sortedby = 0;
+    if (s == NULL || strcmp(s, "hotness") == 0) {
+        sortedby = SORT_BY_HOTNESS;
+    } else if (strcmp(s, "hg") == 0) {
+        sortedby = SORT_BY_HG;
+    } else if (strcmp(s, "spills") == 0) {
+        sortedby = SORT_BY_SPILLS;
+    }
+
+    dump_tbs_info(n, sortedby, true);
+}
+
+static void hmp_info_tb(Monitor *mon, const QDict *qdict)
+{
+    const int id = qdict_get_int(qdict, "id");
+    const char *flags = qdict_get_try_str(qdict, "flags");
+    int mask;
+
+    if (!tcg_enabled()) {
+        error_report("TB information is only available with accel=tcg");
+        return;
+    }
+
+    mask = flags ? qemu_str_to_log_mask(flags) : CPU_LOG_TB_IN_ASM;
+
+    if (!mask) {
+        help_cmd(mon, "log");
+        return;
+    }
+
+    dump_tb_info(id, mask, true);
+}
+
+static void hmp_info_coverset(Monitor *mon, const QDict *qdict)
+{
+    int n;
+    if (!tcg_enabled()) {
+        error_report("TB information is only available with accel=tcg");
+        return;
+    }
+    if (!tb_stats_collection_enabled()) {
+        error_report("TB information not being recorded");
+        return;
+    }
+
+    n = qdict_get_try_int(qdict, "number", 90);
+
+    if (n < 0 || n > 100) {
+        error_report("Coverset percentage should be between 0 and 100");
+        return;
+    }
+
+    dump_coverset_info(n, true);
+}
+
 static void hmp_info_jit(Monitor *mon, const QDict *qdict)
 {
     if (!tcg_enabled()) {
diff --git a/util/log.c b/util/log.c
index 8109d19afb..7bfcbe3703 100644
--- a/util/log.c
+++ b/util/log.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/qemu-print.h"
 #include "qemu/range.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -31,25 +32,34 @@ int qemu_loglevel;
 static int log_append = 0;
 static GArray *debug_regions;
 int32_t max_num_hot_tbs_to_dump;
+static bool to_monitor;
 
 /* Return the number of characters emitted.  */
 int qemu_log(const char *fmt, ...)
 {
     int ret = 0;
-    if (qemu_logfile) {
-        va_list ap;
-        va_start(ap, fmt);
+    va_list ap;
+    va_start(ap, fmt);
+
+    if (to_monitor) {
+        ret = qemu_vprintf(fmt, ap);
+    } else if (qemu_logfile) {
         ret = vfprintf(qemu_logfile, fmt, ap);
-        va_end(ap);
+    }
+    va_end(ap);
 
-        /* Don't pass back error results.  */
-        if (ret < 0) {
-            ret = 0;
-        }
+    /* Don't pass back error results.  */
+    if (ret < 0) {
+        ret = 0;
     }
     return ret;
 }
 
+void qemu_log_to_monitor(bool enable)
+{
+    to_monitor = enable;
+}
+
 static bool log_uses_own_buffers;
 
 /* enable or disable low levels log */
-- 
2.22.0



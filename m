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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81327C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A5E020828
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoQEZucS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5E020828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3NiO-0006u0-6X
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 12:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3Nb9-0006XM-Na
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3Nb6-0006Qm-Ro
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:48:35 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:43373)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i3Nb6-0006QY-Mu
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:48:32 -0400
Received: by mail-qk1-x742.google.com with SMTP id m2so3512592qkd.10
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 09:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uA3SYtnZA83HptN0mbb2qEQqLyGVSp6IpiQrNn1J314=;
 b=qoQEZucSxutuLNJ7BHXHaKQ4o05+KDGgfGGBuY1AYNntXDudAXEdX36Q8fHEUEy3Mm
 c7BQruBPeAQ2hL/SkNNjjXnHmOhTdCTCx0nzdna9hJJFd+0DfSlq/PypUVi2Oc+NgXE1
 Jl2V5fPs+Oltxp9IRMacsFfT7LEcwA7y1PY3w5UGmkL5wXHCATCdmzz7V+lwVSoV2jQM
 zzr1qCAxHae9hU5u+NJrliMWdkt8762BvqnxBdiSeL+QM61BsMRIWz9CmY6hYnl2au/D
 G9iXwh6biBHtUzEpBmQJDuTZPBSFPjh85iTd0NGhwrWbA1KABnmJn5506OVJBgmLJ7XR
 01BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uA3SYtnZA83HptN0mbb2qEQqLyGVSp6IpiQrNn1J314=;
 b=moiLYnt03ivjNLaV4j8PIZu4F/xO7OsB6qRtSFV+Hta9s1RC/6hVv/MqyHRmgiqD2G
 dkLi1S2FaxQ0w3OvM4eE4A+SpJ1dRVJs2rpYykdPNiBr4JnQ4VeRmdLh7ST3iOVpTWLY
 Zn5jtkp3A7C2DCk0O9oST1nNDcbjTFczNpcgdafmrglHn5CBACj7Z9rHuwdEseW3ukNI
 GnmdPwM0GFlcVgBTZzK1q29oTnv5+bKGKnvryAK2510Ebyzo0Rz9LXL3RoHXe8zTB/Fz
 rKsa0nQEzaXjmCzQoKfQ76xnswcfrpiPiajyC7rgxv0YYpJYTLyV+5igJIprJVgoL5Fm
 cLdQ==
X-Gm-Message-State: APjAAAW1FrXZ98RzE9KfmXtikYPor7WXS8Hbt9v3cmZ/cLmRMDLuVTl9
 LwUJXahThgtht57OTjyBcQplORoIw8Uzhg==
X-Google-Smtp-Source: APXvYqy+21fV7Ks2ENGvGDwSCxK72XE/nEnBv0bSKSsH8PCpgcPbdkF91L6SQjIqe4YB2DCHEG+FmQ==
X-Received: by 2002:ae9:e313:: with SMTP id v19mr10560378qkf.22.1567097311852; 
 Thu, 29 Aug 2019 09:48:31 -0700 (PDT)
Received: from vanderson-lmcad.gw.lmcad.ic.unicamp.br (gw.lmcad.ic.unicamp.br.
 [143.106.73.166])
 by smtp.googlemail.com with ESMTPSA id g25sm1441024qkk.87.2019.08.29.09.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 09:48:31 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 13:47:53 -0300
Message-Id: <20190829164754.3906-10-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829164754.3906-1-vandersonmr2@gmail.com>
References: <20190829164754.3906-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: [Qemu-devel] [PATCH v7 09/10] monitor: adding new info cfg command
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

Adding "info cfg id depth" commands to HMP.
This command allow the exploration a TB
neighbors by dumping [and opening] a .dot
file with the TB CFG neighbors colorized
by their hotness.

The goal of this command is to allow the dynamic exploration
of TCG behavior and code quality. Therefore, for now, a
corresponding QMP command is not worthwhile.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 accel/tcg/tb-stats.c    | 164 ++++++++++++++++++++++++++++++++++++++++
 hmp-commands-info.hx    |   7 ++
 include/exec/tb-stats.h |   1 +
 monitor/misc.c          |  22 ++++++
 4 files changed, 194 insertions(+)

diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index d588c551c9..fd2344c5d1 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -679,6 +679,170 @@ void dump_tb_info(int id, int log_mask, bool use_monitor)
     /* tbdi free'd by do_dump_tb_info_safe */
 }
 
+/* TB CFG xdot/dot dump implementation */
+#define MAX_CFG_NUM_NODES 1000
+static int cfg_tb_id;
+static GHashTable *cfg_nodes;
+static uint64_t root_count;
+
+static void fputs_jump(TBStatistics *from, TBStatistics *to, FILE *dot)
+{
+    if (!from || !to) {
+        return;
+    }
+
+    int *from_id = (int *) g_hash_table_lookup(cfg_nodes, from);
+    int *to_id   = (int *) g_hash_table_lookup(cfg_nodes, to);
+
+    if (!from_id || !to_id) {
+        return;
+    }
+
+    fprintf(dot, "   node_%d -> node_%d;\n", *from_id, *to_id);
+}
+
+/* Hotness colors used in the CFG */
+#define HOT_RED1  0xFF000 /* RGB(255,0,0)     */
+#define HOT_RED2  0xFF333 /* RGB(255,51,48)   */
+#define MILD_RED  0xFF666 /* RGB(255,102,96)  */
+#define WEAK_RED1 0xFF999 /* RGB(255,153,144) */
+#define WEAK_RED2 0xFFCCC /* RGB(255,204,192) */
+
+static void fputs_tbstats(TBStatistics *tbs, FILE *dot, int log_flags)
+{
+    if (!tbs) {
+        return;
+    }
+
+    uint32_t color = MILD_RED;
+    uint64_t count = tbs->executions.normal;
+    if (count > 1.6 * root_count) {
+        color = HOT_RED1;
+    } else if (count > 1.2 * root_count) {
+        color = HOT_RED2;
+    } else if (count < 0.4 * root_count) {
+        color = WEAK_RED2;
+    } else if (count < 0.8 * root_count) {
+        color = WEAK_RED1;
+    }
+
+    GString *code_s = get_code_string(tbs, log_flags);
+
+    for (int i = 0; i < code_s->len; i++) {
+        if (code_s->str[i] == '\n') {
+            code_s->str[i] = ' ';
+            code_s = g_string_insert(code_s, i, "\\l");
+            i += 2;
+        }
+    }
+
+    fprintf(dot,
+            "   node_%d [fillcolor=\"#%xFF0000\" shape=\"record\" "
+            "label=\"TB %d\\l"
+            "-------------\\l"
+            "PC:\t0x"TARGET_FMT_lx"\\l"
+            "exec count:\t%lu\\l"
+            "\\l %s\"];\n",
+            cfg_tb_id, color, cfg_tb_id, tbs->pc,
+            tbs->executions.normal, code_s->str);
+
+    int *id = g_new(int, 1);
+    *id = cfg_tb_id;
+    g_hash_table_insert(cfg_nodes, tbs, id);
+
+    cfg_tb_id++;
+
+    g_string_free(code_s, true);
+}
+
+static void fputs_preorder_walk(TBStatistics *tbs, int depth, FILE *dot, int log_flags)
+{
+    if (tbs && depth > 0
+            && cfg_tb_id < MAX_CFG_NUM_NODES
+            && !g_hash_table_contains(cfg_nodes, tbs)) {
+
+        fputs_tbstats(tbs, dot, log_flags);
+
+        if (tbs->tb) {
+            TranslationBlock *left_tb  = NULL;
+            TranslationBlock *right_tb = NULL;
+            if (tbs->tb->jmp_dest[0]) {
+                left_tb = (TranslationBlock *) atomic_read(tbs->tb->jmp_dest);
+            }
+            if (tbs->tb->jmp_dest[1]) {
+                right_tb = (TranslationBlock *) atomic_read(tbs->tb->jmp_dest + 1);
+            }
+
+            if (left_tb) {
+                fputs_preorder_walk(left_tb->tb_stats, depth - 1, dot, log_flags);
+                fputs_jump(tbs, left_tb->tb_stats, dot);
+            }
+            if (right_tb) {
+                fputs_preorder_walk(right_tb->tb_stats, depth - 1, dot, log_flags);
+                fputs_jump(tbs, right_tb->tb_stats, dot);
+            }
+        }
+    }
+}
+
+struct PreorderInfo {
+    TBStatistics *tbs;
+    int depth;
+    int log_flags;
+};
+
+static void fputs_preorder_walk_safe(CPUState *cpu, run_on_cpu_data icmd)
+{
+    struct PreorderInfo *info = icmd.host_ptr;
+
+    GString *file_name = g_string_new(NULL);;
+    g_string_printf(file_name, "/tmp/qemu-cfg-tb-%d-%d.dot", id, info->depth);
+    FILE *dot = fopen(file_name->str, "w+");
+
+    fputs(
+            "digraph G {\n"
+            "   mclimit=1.5;\n"
+            "   rankdir=TD; ordering=out;\n"
+            "   graph[fontsize=10 fontname=\"Verdana\"];\n"
+            "   color=\"#efefef\";\n"
+            "   node[shape=box style=filled fontsize=8 fontname=\"Verdana\" fillcolor=\"#efefef\"];\n"
+            "   edge[fontsize=8 fontname=\"Verdana\"];\n"
+         , dot);
+
+    cfg_nodes = g_hash_table_new(NULL, NULL);
+    fputs_preorder_walk(info->tbs, info->depth, dot, info->log_flags);
+    g_hash_table_destroy(cfg_nodes);
+
+    fputs("}\n\0", dot);
+    fclose(dot);
+
+    qemu_log("CFG dumped: %s\n", file_name->str);
+
+    g_string_free(file_name, true);
+    g_free(info);
+}
+
+void dump_tb_cfg(int id, int depth, int log_flags)
+{
+    cfg_tb_id = 1;
+    root_count = 0;
+
+    /* do a pre-order walk in the CFG with a limited depth */
+    TBStatistics *root = get_tbstats_by_id(id);
+    if (root) {
+        root_count = root->executions.normal;
+    }
+
+    struct PreorderInfo *info = g_new(struct PreorderInfo, 1);
+    info->tbs = root;
+    info->depth = depth + 1;
+    info->log_flags = log_flags;
+    async_safe_run_on_cpu(first_cpu, fputs_preorder_walk_safe,
+            RUN_ON_CPU_HOST_PTR(info));
+}
+
+/* TBStatistic collection controls */
+
 
 void enable_collect_tb_stats(void)
 {
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index f415479011..8c96924c0b 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -305,6 +305,13 @@ ETEXI
                       "dump flags can be used to set dump code level: out_asm in_asm op",
         .cmd        = hmp_info_tb,
     },
+    {
+        .name       = "cfg",
+        .args_type  = "id:i,depth:i?,flags:s?",
+        .params     = "id [depth flags]",
+        .help       = "plot CFG around TB with the given id",
+        .cmd        = hmp_info_cfg,
+    },
     {
         .name       = "coverset",
         .args_type  = "coverage:i?",
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index 51d73e1c5f..4515db106a 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -155,6 +155,7 @@ void dump_tbs_info(int count, int sort_by, bool use_monitor);
  */
 void dump_tb_info(int id, int log_mask, bool use_monitor);
 
+void dump_tb_cfg(int id, int depth, int log_flags);
 
 /* TBStatistic collection controls */
 void enable_collect_tb_stats(void);
diff --git a/monitor/misc.c b/monitor/misc.c
index b99c018124..b3b31d7035 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -556,6 +556,28 @@ static void hmp_info_tb(Monitor *mon, const QDict *qdict)
     dump_tb_info(id, mask, true);
 }
 
+static void hmp_info_cfg(Monitor *mon, const QDict *qdict)
+{
+    const int id = qdict_get_int(qdict, "id");
+    const int depth = qdict_get_try_int(qdict, "depth", 3);
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
+        error_report("Unable to parse log flags, see 'help log'");
+        return;
+    }
+
+    dump_tb_cfg(id, depth, mask);
+}
+
 static void hmp_info_coverset(Monitor *mon, const QDict *qdict)
 {
     int coverage;
-- 
2.22.0



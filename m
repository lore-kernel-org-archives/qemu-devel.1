Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399B6C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:55:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41662084F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfmU6OeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41662084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37901 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5v8-0003yj-3i
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1hy5Mi-00011q-FT
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hy5Mg-0001uG-TP
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:19:48 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:46422)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hy5Mg-0001sw-OY
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:19:46 -0400
Received: by mail-qk1-x741.google.com with SMTP id p13so724216qkg.13
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4TBbUXS4Lp57EZ4FvONnoIYEkWhrcydGdcmd671J9as=;
 b=CfmU6OeF+sztQRmvfcdtR9aKIYOYe3tCuUxhrV7mXi2g13jwCv8gilnNXDbH6J9geA
 5RZo505e24DNQnCL4IaTWJUTwTDcspsJnM3uQpGSnMza5eFPYiTsICCE39k8ZKAjfwDx
 6hA9BTjY1UUG73xuq9YAAOnblL+wINOZQfRVEdaXvnACgwbj2rOXZ+47msGml5dmuOfv
 kOn7CJtWh9VbsU1nP2Laq2DOSYiAMVWCaAJtZn+fBy3Y9VloNEqFKa2p93hNyS/h52id
 fbQcnkvbEcOJo2Jt+3TIhpmqGU5ZIG0ep3D38Suwib7kirC4F9KeEoKF/4FYPNm068x4
 gsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4TBbUXS4Lp57EZ4FvONnoIYEkWhrcydGdcmd671J9as=;
 b=IZpqw21bnh9z3x3EFJcCOXMe5QADwaVZrrhG19fgEjWu7pGuAr7EWOAzoDxVHxzSL9
 ymnginLXP+PLlDxsNSeQ2DMmfqhPABMDsYw3KdMl2lTDrkJrKAJWmSYgFf8YwjMfu77a
 QhZFEFTB2OUYA39LTGCvyBdm4LdIm3Qohff5xpF2DoZlhQAkLCzJiBeEkAMQXNtIXHTO
 0qLeBGK+xsbN0qKYMyX9Z2hZCvjiAyVW0OcR9FuF9QGtWD+UZC4VH8P5jboQx5BRKm5c
 nXEGT7hfJgmQxW83uakwWRdWf1n/UFP71HxXHaacmI9I2yw5GjwIQfhP1tQJX8XGkRur
 yNBQ==
X-Gm-Message-State: APjAAAWbqHOpOUrCFLVykLezcI80YroLHWvKusRsjE2FGSw8pG0Ro++G
 kYZScQU/54IzsL+FMG8i2VBFvXirFM6vhA==
X-Google-Smtp-Source: APXvYqz5c5POy/LRC9qn6x17l8OS3B1Z+/Rmgtqq9EyoYY7yuTIbATx4lU57rkwnd8kFD5QQ5QAJBw==
X-Received: by 2002:a37:a744:: with SMTP id q65mr2085171qke.151.1565835585381; 
 Wed, 14 Aug 2019 19:19:45 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:121::1])
 by smtp.googlemail.com with ESMTPSA id o5sm757943qkf.10.2019.08.14.19.19.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:19:44 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 23:18:56 -0300
Message-Id: <20190815021857.19526-10-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815021857.19526-1-vandersonmr2@gmail.com>
References: <20190815021857.19526-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: [Qemu-devel] [PATCH v5 09/10] monitor: adding new info cfg command
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
 accel/tcg/tb-stats.c    | 177 ++++++++++++++++++++++++++++++++++++++++
 hmp-commands-info.hx    |   7 ++
 include/exec/tb-stats.h |   1 +
 monitor/misc.c          |  22 +++++
 4 files changed, 207 insertions(+)

diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index f5e519bdb7..5fda2bed9e 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -637,6 +637,182 @@ void dump_tb_info(int id, int log_mask, bool use_monitor)
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
+    GString *line = g_string_new(NULL);
+
+    g_string_printf(line, "   node_%d -> node_%d;\n", *from_id, *to_id);
+
+    fputs(line->str, dot);
+
+    g_string_free(line, true);
+}
+
+static void fputs_tbstats(TBStatistics *tbs, FILE *dot, int log_flags)
+{
+    if (!tbs) {
+        return;
+    }
+
+    GString *line = g_string_new(NULL);;
+
+    uint32_t color = 0xFF666;
+    uint64_t count = tbs->executions.normal;
+    if (count > 1.6 * root_count) {
+        color = 0xFF000;
+    } else if (count > 1.2 * root_count) {
+        color = 0xFF333;
+    } else if (count < 0.4 * root_count) {
+        color = 0xFFCCC;
+    } else if (count < 0.8 * root_count) {
+        color = 0xFF999;
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
+    g_string_printf(line,
+            "   node_%d [fillcolor=\"#%xFF0000\" shape=\"record\" "
+            "label=\"TB %d\\l"
+            "-------------\\l"
+            "PC:\t0x"TARGET_FMT_lx"\\l"
+            "exec count:\t%lu\\l"
+            "\\l %s\"];\n",
+            cfg_tb_id, color, cfg_tb_id, tbs->pc,
+            tbs->executions.normal, code_s->str);
+
+    fputs(line->str, dot);
+
+    int *id = g_new(int, 1);
+    *id = cfg_tb_id;
+    g_hash_table_insert(cfg_nodes, tbs, id);
+
+    cfg_tb_id++;
+
+    g_string_free(line, true);
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
+#ifdef __linux__
+    pid_t pid = fork();
+    if (pid == 0) {
+        char *args[] = {(char *) "xdot", file_name->str, NULL};
+        execvp(args[0], args);
+    }
+#endif
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
@@ -686,3 +862,4 @@ uint32_t get_default_tbstats_flag(void)
 {
     return default_tbstats_flag;
 }
+
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 6691303c59..afbc80d3b1 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -305,6 +305,13 @@ ETEXI
                       "a dump flag can be used to set dump code level: out_asm in_asm op",
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
index dc2a8155a0..d67f1966ec 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -127,6 +127,7 @@ void dump_tbs_info(int count, int sort_by, bool use_monitor);
  */
 void dump_tb_info(int id, int log_mask, bool use_monitor);
 
+void dump_tb_cfg(int id, int depth, int log_flags);
 
 /* TBStatistic collection controls */
 void enable_collect_tb_stats(void);
diff --git a/monitor/misc.c b/monitor/misc.c
index 4af70dba92..da886e805c 100644
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



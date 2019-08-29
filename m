Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221B3C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F662077B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHIkUcK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F662077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3NfS-0003O9-Ch
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 12:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3Naw-0006HT-KS
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3Nau-0006DC-Gi
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:48:22 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:39325)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i3Nau-0006Cf-9s
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:48:20 -0400
Received: by mail-qk1-x741.google.com with SMTP id 4so3544135qki.6
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0tyi9RV7v4NGuPxExoPiL2GQVSfMRvF20u4F8hRW0Eg=;
 b=bHIkUcK34JTh19m1E5IOtE2LyvRK+/QJCnDRcDMQzSxsNA9ShxW1oKElrJtJOVWgkv
 d6u8RzIH7QR1PNK2BcGO2Qjr+1lv3bgGXv1RnmHQxTrcQAenlM7Pr5U7N565070Bp3hI
 htjsnZbi75uSxH/chlommC5av8nVPvCSY3r9pbGKCwom30hojJmrTYT+kf/9fYj5H963
 1alMT2Tk5IihMLk8WHlQ3hhxzl1qNUY4HP0l92OW41VbyNOGS+2gikeXDgLUDTxVbydr
 xwIOzKqGlDgxkf05YcTtBRQO8Qv1tO9j1sLaF4NXXNs1ZMxEf7Pb9q+oSt5MjZciYZvi
 QmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0tyi9RV7v4NGuPxExoPiL2GQVSfMRvF20u4F8hRW0Eg=;
 b=gFNXbIIbcoN9TOhbjXSzPzW4FYDOLL8gxlAK8+9nlVwi30lzSf5P7rTRVRmK1isXg6
 6LLvH7r4hYfqXNTj/Cmzwb1zivrAgmkXyydCYxok3CYQosbOQt+uVGS7XrACqpoqYCPa
 CyXHt8bbaOUSJmBrs77czD3c3xvUBd20xNhOAkPEyYg5fjO3na37f8o+q4OO+rCtVHwg
 FkROLq2GSyoboX4blq9vnxsbwTackd6zSN16uNzOO8AbyXxuGPzia1GhuxxtnvvGBLiP
 nFyufkQid0BvoRjsQ8xNThH1iyC8z+fQsJI9KFM8Uu2zaiGpqSRxct+2DsjoGzHKs8xR
 ClbQ==
X-Gm-Message-State: APjAAAVJEDQvJ1b0riO/+ia+YBE8C3EWzGa0q6OBQ4huD+xIapRZcHP/
 hJVY6nnWQPapXNCun2Z/78MdxR3CnWJJfg==
X-Google-Smtp-Source: APXvYqweDc0gkopYX8h2OgsKcCZCEzF0+X6ZchM+xy3Qioct7CN6ldomValWNXl9JQxPvnW2B1Xy6Q==
X-Received: by 2002:a37:ad06:: with SMTP id f6mr3622087qkm.384.1567097299025; 
 Thu, 29 Aug 2019 09:48:19 -0700 (PDT)
Received: from vanderson-lmcad.gw.lmcad.ic.unicamp.br (gw.lmcad.ic.unicamp.br.
 [143.106.73.166])
 by smtp.googlemail.com with ESMTPSA id g25sm1441024qkk.87.2019.08.29.09.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 09:48:18 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 13:47:47 -0300
Message-Id: <20190829164754.3906-4-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829164754.3906-1-vandersonmr2@gmail.com>
References: <20190829164754.3906-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: [Qemu-devel] [PATCH v7 03/10] accel: replacing part of
 CONFIG_PROFILER with TBStats
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
 Paolo Bonzini <pbonzini@redhat.com>, vandersonmr <vandersonmr2@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We add some of the statistics collected in the TCGProfiler
into the TBStats, having the statistics not only for the whole
emulation but for each TB. Then, we removed these stats
from TCGProfiler and reconstruct the information for the
"info jit" using the sum of all TBStats statistics.

The goal is to have one unique and better way of collecting
emulation statistics. Moreover, checking dynamiclly if the
profiling is enabled showed to have an insignificant impact
on the performance:
https://wiki.qemu.org/Internships/ProjectIdeas/TCGCodeQuality#Overheads.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 accel/tcg/tb-stats.c      | 96 +++++++++++++++++++++++++++++++++++++++
 accel/tcg/translate-all.c |  8 +---
 include/exec/tb-stats.h   | 11 +++++
 tcg/tcg.c                 | 93 ++++---------------------------------
 tcg/tcg.h                 | 10 ----
 5 files changed, 119 insertions(+), 99 deletions(-)

diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 1db81d83e7..176da60e13 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -25,9 +25,105 @@
 #include "qemu/osdep.h"
 
 #include "disas/disas.h"
+#include "exec/exec-all.h"
+#include "tcg.h"
+
+#include "qemu/qemu-print.h"
 
 #include "exec/tb-stats.h"
 
+struct jit_profile_info {
+    uint64_t translations;
+    uint64_t aborted;
+    uint64_t ops;
+    unsigned ops_max;
+    uint64_t del_ops;
+    uint64_t temps;
+    unsigned temps_max;
+    uint64_t host;
+    uint64_t guest;
+    uint64_t search_data;
+};
+
+/* accumulate the statistics from all TBs */
+static void collect_jit_profile_info(void *p, uint32_t hash, void *userp)
+{
+    struct jit_profile_info *jpi = userp;
+    TBStatistics *tbs = p;
+
+    jpi->translations += tbs->translations.total;
+    jpi->ops += tbs->code.num_tcg_ops;
+    if (stat_per_translation(tbs, code.num_tcg_ops) > jpi->ops_max) {
+        jpi->ops_max = stat_per_translation(tbs, code.num_tcg_ops);
+    }
+    jpi->del_ops += tbs->code.deleted_ops;
+    jpi->temps += tbs->code.temps;
+    if (stat_per_translation(tbs, code.temps) > jpi->temps_max) {
+        jpi->temps_max = stat_per_translation(tbs, code.temps);
+    }
+    jpi->host += tbs->code.out_len;
+    jpi->guest += tbs->code.in_len;
+    jpi->search_data += tbs->code.search_out_len;
+}
+
+/* dump JIT statisticis using TCGProfile and TBStats */
+void dump_jit_profile_info(TCGProfile *s)
+{
+    if (!tb_stats_collection_enabled()) {
+        return;
+    }
+
+    struct jit_profile_info *jpi = g_new0(struct jit_profile_info, 1);
+
+    qht_iter(&tb_ctx.tb_stats, collect_jit_profile_info, jpi);
+
+    if (jpi->translations) {
+        qemu_printf("translated TBs      %" PRId64 "\n", jpi->translations);
+        qemu_printf("avg ops/TB          %0.1f max=%d\n",
+                jpi->ops / (double) jpi->translations, jpi->ops_max);
+        qemu_printf("deleted ops/TB      %0.2f\n",
+                jpi->del_ops / (double) jpi->translations);
+        qemu_printf("avg temps/TB        %0.2f max=%d\n",
+                jpi->temps / (double) jpi->translations, jpi->temps_max);
+        qemu_printf("avg host code/TB    %0.1f\n",
+                jpi->host / (double) jpi->translations);
+        qemu_printf("avg search data/TB  %0.1f\n",
+                jpi->search_data / (double) jpi->translations);
+
+        if (s) {
+            int64_t tot = s->interm_time + s->code_time;
+            qemu_printf("JIT cycles          %" PRId64 " (%0.3f s at 2.4 GHz)\n",
+                            tot, tot / 2.4e9);
+            qemu_printf("cycles/op           %0.1f\n",
+                        jpi->ops ? (double)tot / jpi->ops : 0);
+            qemu_printf("cycles/in byte      %0.1f\n",
+                        jpi->guest ? (double)tot / jpi->guest : 0);
+            qemu_printf("cycles/out byte     %0.1f\n",
+                        jpi->host ? (double)tot / jpi->host : 0);
+            qemu_printf("cycles/search byte     %0.1f\n",
+                        jpi->search_data ? (double)tot / jpi->search_data : 0);
+            if (tot == 0) {
+                tot = 1;
+            }
+            qemu_printf("  gen_interm time   %0.1f%%\n",
+                        (double)s->interm_time / tot * 100.0);
+            qemu_printf("  gen_code time     %0.1f%%\n",
+                        (double)s->code_time / tot * 100.0);
+            qemu_printf("optim./code time    %0.1f%%\n",
+                        (double)s->opt_time / (s->code_time ? s->code_time : 1)
+                        * 100.0);
+            qemu_printf("liveness/code time  %0.1f%%\n",
+                    (double)s->la_time / (s->code_time ? s->code_time : 1) * 100.0);
+            qemu_printf("cpu_restore count   %" PRId64 "\n",
+                    s->restore_count);
+            qemu_printf("  avg cycles        %0.1f\n",
+                    s->restore_count ? (double)s->restore_time / s->restore_count : 0);
+        }
+    }
+    g_free(jpi);
+}
+
+
 void init_tb_stats_htable_if_not(void)
 {
     if (tb_stats_collection_enabled() && !tb_ctx.tb_stats.map) {
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index fb2fe0fa1f..fe890f0782 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1774,8 +1774,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
  tb_overflow:
 
 #ifdef CONFIG_PROFILER
-    /* includes aborted translations because of exceptions */
-    atomic_set(&prof->tb_count1, prof->tb_count1 + 1);
     ti = profile_getclock();
 #endif
 
@@ -1823,7 +1821,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     }
 
 #ifdef CONFIG_PROFILER
-    atomic_set(&prof->tb_count, prof->tb_count + 1);
     atomic_set(&prof->interm_time, prof->interm_time + profile_getclock() - ti);
     ti = profile_getclock();
 #endif
@@ -1870,13 +1867,12 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 
 #ifdef CONFIG_PROFILER
     atomic_set(&prof->code_time, prof->code_time + profile_getclock() - ti);
-    atomic_set(&prof->code_in_len, prof->code_in_len + tb->size);
-    atomic_set(&prof->code_out_len, prof->code_out_len + gen_code_size);
-    atomic_set(&prof->search_out_len, prof->search_out_len + search_size);
 #endif
 
     if (tb_stats_enabled(tb, TB_JIT_STATS)) {
+        atomic_add(&tb->tb_stats->code.in_len, tb->size);
         atomic_add(&tb->tb_stats->code.out_len, gen_code_size);
+        atomic_add(&tb->tb_stats->code.search_out_len, search_size);
     }
 
 #ifdef DEBUG_DISAS
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index b68edd5d24..b9d5a343be 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -33,6 +33,9 @@
 #define tb_stats_enabled(tb, JIT_STATS) \
     (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
 
+#define stat_per_translation(stat, name) \
+    (stat->translations.total ? stat->name / stat->translations.total : 0)
+
 typedef struct TBStatistics TBStatistics;
 
 /*
@@ -63,7 +66,13 @@ struct TBStatistics {
         unsigned num_tcg_ops;
         unsigned num_tcg_ops_opt;
         unsigned spills;
+
+        /* CONFIG_PROFILE */
+        unsigned temps;
+        unsigned deleted_ops;
+        unsigned in_len;
         unsigned out_len;
+        unsigned search_out_len;
     } code;
 
     struct {
@@ -80,6 +89,8 @@ bool tb_stats_cmp(const void *ap, const void *bp);
 
 void init_tb_stats_htable_if_not(void);
 
+void dump_jit_profile_info(TCGProfile *s);
+
 /* TBStatistic collection controls */
 enum TBStatsStatus { TB_STATS_RUNNING, TB_STATS_PAUSED, TB_STATS_STOPPED };
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ae3e7a2217..03b11495aa 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2294,9 +2294,9 @@ void tcg_op_remove(TCGContext *s, TCGOp *op)
     QTAILQ_INSERT_TAIL(&s->free_ops, op, link);
     s->nb_ops--;
 
-#ifdef CONFIG_PROFILER
-    atomic_set(&s->prof.del_op_count, s->prof.del_op_count + 1);
-#endif
+    if (tb_stats_enabled(s->current_tb, TB_JIT_STATS)) {
+        atomic_inc(&s->current_tb->tb_stats->code.deleted_ops);
+    }
 }
 
 static TCGOp *tcg_op_alloc(TCGOpcode opc)
@@ -3913,16 +3913,6 @@ void tcg_profile_snapshot(TCGProfile *prof, bool counters, bool table)
 
         if (counters) {
             PROF_ADD(prof, orig, cpu_exec_time);
-            PROF_ADD(prof, orig, tb_count1);
-            PROF_ADD(prof, orig, tb_count);
-            PROF_ADD(prof, orig, op_count);
-            PROF_MAX(prof, orig, op_count_max);
-            PROF_ADD(prof, orig, temp_count);
-            PROF_MAX(prof, orig, temp_count_max);
-            PROF_ADD(prof, orig, del_op_count);
-            PROF_ADD(prof, orig, code_in_len);
-            PROF_ADD(prof, orig, code_out_len);
-            PROF_ADD(prof, orig, search_out_len);
             PROF_ADD(prof, orig, interm_time);
             PROF_ADD(prof, orig, code_time);
             PROF_ADD(prof, orig, la_time);
@@ -4002,26 +3992,17 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     TCGOp *op;
 
     s->current_tb = tb;
-
-#ifdef CONFIG_PROFILER
-    {
+    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
         int n = 0;
 
         QTAILQ_FOREACH(op, &s->ops, link) {
             n++;
         }
-        atomic_set(&prof->op_count, prof->op_count + n);
-        if (n > prof->op_count_max) {
-            atomic_set(&prof->op_count_max, n);
-        }
+        atomic_add(&tb->tb_stats->code.num_tcg_ops, n);
 
         n = s->nb_temps;
-        atomic_set(&prof->temp_count, prof->temp_count + n);
-        if (n > prof->temp_count_max) {
-            atomic_set(&prof->temp_count_max, n);
-        }
+        atomic_add(&tb->tb_stats->code.temps, n);
     }
-#endif
 
 #ifdef DEBUG_DISAS
     if (unlikely(qemu_loglevel_mask(CPU_LOG_TB_OP)
@@ -4228,70 +4209,16 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     return tcg_current_code_size(s);
 }
 
-#ifdef CONFIG_PROFILER
 void tcg_dump_info(void)
 {
+    TCGProfile *s = NULL;
+#ifdef CONFIG_PROFILER
     TCGProfile prof = {};
-    const TCGProfile *s;
-    int64_t tb_count;
-    int64_t tb_div_count;
-    int64_t tot;
-
     tcg_profile_snapshot_counters(&prof);
     s = &prof;
-    tb_count = s->tb_count;
-    tb_div_count = tb_count ? tb_count : 1;
-    tot = s->interm_time + s->code_time;
-
-    qemu_printf("JIT cycles          %" PRId64 " (%0.3f s at 2.4 GHz)\n",
-                tot, tot / 2.4e9);
-    qemu_printf("translated TBs      %" PRId64 " (aborted=%" PRId64
-                " %0.1f%%)\n",
-                tb_count, s->tb_count1 - tb_count,
-                (double)(s->tb_count1 - s->tb_count)
-                / (s->tb_count1 ? s->tb_count1 : 1) * 100.0);
-    qemu_printf("avg ops/TB          %0.1f max=%d\n",
-                (double)s->op_count / tb_div_count, s->op_count_max);
-    qemu_printf("deleted ops/TB      %0.2f\n",
-                (double)s->del_op_count / tb_div_count);
-    qemu_printf("avg temps/TB        %0.2f max=%d\n",
-                (double)s->temp_count / tb_div_count, s->temp_count_max);
-    qemu_printf("avg host code/TB    %0.1f\n",
-                (double)s->code_out_len / tb_div_count);
-    qemu_printf("avg search data/TB  %0.1f\n",
-                (double)s->search_out_len / tb_div_count);
-    
-    qemu_printf("cycles/op           %0.1f\n",
-                s->op_count ? (double)tot / s->op_count : 0);
-    qemu_printf("cycles/in byte      %0.1f\n",
-                s->code_in_len ? (double)tot / s->code_in_len : 0);
-    qemu_printf("cycles/out byte     %0.1f\n",
-                s->code_out_len ? (double)tot / s->code_out_len : 0);
-    qemu_printf("cycles/search byte     %0.1f\n",
-                s->search_out_len ? (double)tot / s->search_out_len : 0);
-    if (tot == 0) {
-        tot = 1;
-    }
-    qemu_printf("  gen_interm time   %0.1f%%\n",
-                (double)s->interm_time / tot * 100.0);
-    qemu_printf("  gen_code time     %0.1f%%\n",
-                (double)s->code_time / tot * 100.0);
-    qemu_printf("optim./code time    %0.1f%%\n",
-                (double)s->opt_time / (s->code_time ? s->code_time : 1)
-                * 100.0);
-    qemu_printf("liveness/code time  %0.1f%%\n",
-                (double)s->la_time / (s->code_time ? s->code_time : 1) * 100.0);
-    qemu_printf("cpu_restore count   %" PRId64 "\n",
-                s->restore_count);
-    qemu_printf("  avg cycles        %0.1f\n",
-                s->restore_count ? (double)s->restore_time / s->restore_count : 0);
-}
-#else
-void tcg_dump_info(void)
-{
-    qemu_printf("[TCG profiler not compiled]\n");
-}
 #endif
+    dump_jit_profile_info(s);
+}
 
 #ifdef ELF_HOST_MACHINE
 /* In order to use this feature, the backend needs to do three things:
diff --git a/tcg/tcg.h b/tcg/tcg.h
index b4601162f8..a8d779f7e6 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -646,16 +646,6 @@ QEMU_BUILD_BUG_ON(NB_OPS > (1 << 8));
 
 typedef struct TCGProfile {
     int64_t cpu_exec_time;
-    int64_t tb_count1;
-    int64_t tb_count;
-    int64_t op_count; /* total insn count */
-    int op_count_max; /* max insn per TB */
-    int temp_count_max;
-    int64_t temp_count;
-    int64_t del_op_count;
-    int64_t code_in_len;
-    int64_t code_out_len;
-    int64_t search_out_len;
     int64_t interm_time;
     int64_t code_time;
     int64_t la_time;
-- 
2.22.0



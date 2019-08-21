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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC7AC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:25:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AFDA22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ccl+bOR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFDA22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UMH-0000u9-2l
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i0UKq-0007Ih-P9
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i0UKp-0008VD-5Y
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:23:48 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:34597)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i0UKp-0008Ut-1W
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:23:47 -0400
Received: by mail-qk1-x743.google.com with SMTP id m10so2539819qkk.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XfHF6ZY7bWaD3BX1+22k5hUlOW5ft3uZC3pebdXlS2k=;
 b=Ccl+bOR/iQQM6EcPXQGji8b3IccKvwqyVaQyj8+d2ugAWwgO/Yi1yCygamVWk0KuL6
 szICHUeIVGeJgwidj/Uw1DH5NSzopdqe3fo8TrQpF2Cqub8s/vD1Tqb/JjoKqydzMTNW
 cVFh/XDXTQ/gW/CdTCRiiNrGkvVBdzkJE6QaPcWhJIUHYph6Os9uQ6KI6mRwiJuyngIX
 tUGAKv8wrr0NDlSLliJ+mDuU9t1zpilXXPRLD9d/YY1IAogoaBFYW0mz0QbtK0H9WIJ9
 1HBh1Xeu609WdUfwjYWVHV3A2bUFc4LOMfa99O8mOJmkfBFrAwZYVbzqpwWisL5Hg+IK
 v1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XfHF6ZY7bWaD3BX1+22k5hUlOW5ft3uZC3pebdXlS2k=;
 b=HcYSS1KAROIeDv6YqWqqqLmzczTDMVvQ/F+aRJB+wBLEQYpUCQ379OCMkXmakMSN4T
 0MOKdquJacYUtgXLd5R85gTBp+7ejaO/d+62mb2T3N/bLCsUM69toMDKqNoEAmdv08zi
 VD223Bwm8080IurhGi3DxtcndU6VGMYb4Lm2qaf4TmB6FkMRnsVCrOzJncFKFkKn6I5q
 y/YyFGlxy+GuxKCLXP3ZRj9wudcxnahtRCPpVqFGuE7NQ81hVHGaLreL61JwD2pJpCRR
 UAuiu/YGRBRFMDSNY46o5i0/FGaDiCVYAHCB8jnrlCvLPbV4zZjtXS5vu9P86RDptz/o
 Fufw==
X-Gm-Message-State: APjAAAXhsk/v+UznGGlAKhDUIwU7l3QagkanrU4dlR67BPc+VmV/LK+9
 EQYwwTfcxOcTscLQKI8VV9XFFuzeXExqFg==
X-Google-Smtp-Source: APXvYqwrKb+7bLloRTWJ6HGHk0m3ug9ZLrGu+J3pmaYXA3FT8B4W77n4jqxOLSDamWLM5+JkgrDsCw==
X-Received: by 2002:a05:620a:710:: with SMTP id
 16mr31037559qkc.382.1566408226237; 
 Wed, 21 Aug 2019 10:23:46 -0700 (PDT)
Received: from vanderson-lmcad.gw.lmcad.ic.unicamp.br (gw.lmcad.ic.unicamp.br.
 [143.106.73.166])
 by smtp.googlemail.com with ESMTPSA id a3sm9623998qtp.10.2019.08.21.10.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:23:45 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 14:23:21 -0300
Message-Id: <20190821172329.2062-3-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821172329.2062-1-vandersonmr2@gmail.com>
References: <20190821172329.2062-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
Subject: [Qemu-devel] [PATCH v6 02/10] accel: collecting TB execution count
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

If a TB has a TBS (TBStatistics) with the TB_EXEC_STATS
enabled, then we instrument the start code of this TB
to atomically count the number of times it is executed.
We count both the number of "normal" executions and atomic
executions of a TB.

The execution count of the TB is stored in its respective
TBS.

All TBStatistics are created by default with the flags from
default_tbstats_flag.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 accel/tcg/cpu-exec.c      |  4 ++++
 accel/tcg/tb-stats.c      |  5 +++++
 accel/tcg/tcg-runtime.c   |  7 +++++++
 accel/tcg/tcg-runtime.h   |  2 ++
 accel/tcg/translate-all.c |  7 +++++++
 accel/tcg/translator.c    |  1 +
 include/exec/gen-icount.h |  9 +++++++++
 include/exec/tb-stats.h   | 19 +++++++++++++++++++
 util/log.c                |  1 +
 9 files changed, 55 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 6c85c3ee1e..e54be69499 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -252,6 +252,10 @@ void cpu_exec_step_atomic(CPUState *cpu)
 
         start_exclusive();
 
+        if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
+            tb->tb_stats->executions.atomic++;
+        }
+
         /* Since we got here, we know that parallel_cpus must be true.  */
         parallel_cpus = false;
         in_exclusive_region = true;
diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 02844717cb..3489133e9e 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -37,3 +37,8 @@ bool tb_stats_collection_paused(void)
 {
     return tcg_collect_tb_stats == TB_STATS_PAUSED;
 }
+
+uint32_t get_default_tbstats_flag(void)
+{
+    return default_tbstats_flag;
+}
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 8a1e408e31..6f4aafba11 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -167,3 +167,10 @@ void HELPER(exit_atomic)(CPUArchState *env)
 {
     cpu_loop_exit_atomic(env_cpu(env), GETPC());
 }
+
+void HELPER(inc_exec_freq)(void *ptr)
+{
+    TBStatistics *stats = (TBStatistics *) ptr;
+    g_assert(stats);
+    atomic_inc(&stats->executions.normal);
+}
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 4fa61b49b4..bf0b75dbe8 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -28,6 +28,8 @@ DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, ptr, env)
 
 DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
 
+DEF_HELPER_FLAGS_1(inc_exec_freq, TCG_CALL_NO_RWG, void, ptr)
+
 #ifdef CONFIG_SOFTMMU
 
 DEF_HELPER_FLAGS_5(atomic_cmpxchgb, TCG_CALL_NO_WG,
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index b7bccacd3b..e72aeba682 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1785,6 +1785,13 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
      */
     if (tb_stats_collection_enabled()) {
         tb->tb_stats = tb_get_stats(phys_pc, pc, cs_base, flags, tb);
+
+        if (qemu_log_in_addr_range(tb->pc)) {
+            uint32_t flag = get_default_tbstats_flag();
+            if (flag & TB_EXEC_STATS) {
+                tb->tb_stats->stats_enabled |= TB_EXEC_STATS;
+            }
+        }
     } else {
         tb->tb_stats = NULL;
     }
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 9226a348a3..396a11e828 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -46,6 +46,7 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
 
     ops->init_disas_context(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
+    gen_tb_exec_count(tb);
 
     /* Reset the temp count so that we can identify leaks */
     tcg_clear_temp_count();
diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index f7669b6841..b3efe41894 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -7,6 +7,15 @@
 
 static TCGOp *icount_start_insn;
 
+static inline void gen_tb_exec_count(TranslationBlock *tb)
+{
+    if (tb_stats_enabled(tb, TB_EXEC_STATS)) {
+        TCGv_ptr ptr = tcg_const_ptr(tb->tb_stats);
+        gen_helper_inc_exec_freq(ptr);
+        tcg_temp_free_ptr(ptr);
+    }
+}
+
 static inline void gen_tb_start(TranslationBlock *tb)
 {
     TCGv_i32 count, imm;
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index cc8f8a6ce6..fdebe7831c 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -6,6 +6,9 @@
 #include "exec/tb-context.h"
 #include "tcg.h"
 
+#define tb_stats_enabled(tb, JIT_STATS) \
+    (tb && tb->tb_stats && (tb->tb_stats->stats_enabled & JIT_STATS))
+
 typedef struct TBStatistics TBStatistics;
 
 /*
@@ -22,6 +25,15 @@ struct TBStatistics {
     uint32_t     flags;
     /* cs_base isn't included in the hash but we do check for matches */
     target_ulong cs_base;
+
+    uint32_t stats_enabled;
+
+    /* Execution stats */
+    struct {
+        unsigned long normal;
+        unsigned long atomic;
+    } executions;
+
     /* current TB linked to this TBStatistics */
     TranslationBlock *tb;
 };
@@ -32,7 +44,12 @@ void init_tb_stats_htable_if_not(void);
 
 /* TBStatistic collection controls */
 enum TBStatsStatus { TB_STATS_RUNNING, TB_STATS_PAUSED, TB_STATS_STOPPED };
+
+#define TB_NOTHING    (1 << 0)
+#define TB_EXEC_STATS (1 << 1)
+
 extern int tcg_collect_tb_stats;
+extern uint32_t default_tbstats_flag;
 
 void enable_collect_tb_stats(void);
 void disable_collect_tb_stats(void);
@@ -40,4 +57,6 @@ void pause_collect_tb_stats(void);
 bool tb_stats_collection_enabled(void);
 bool tb_stats_collection_paused(void);
 
+uint32_t get_default_tbstats_flag(void);
+
 #endif
diff --git a/util/log.c b/util/log.c
index 393a17115b..29021a4584 100644
--- a/util/log.c
+++ b/util/log.c
@@ -32,6 +32,7 @@ static int log_append = 0;
 static GArray *debug_regions;
 
 int tcg_collect_tb_stats;
+uint32_t default_tbstats_flag;
 
 /* Return the number of characters emitted.  */
 int qemu_log(const char *fmt, ...)
-- 
2.22.0



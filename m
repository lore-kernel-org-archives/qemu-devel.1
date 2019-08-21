Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A91FC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA53A22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdKm/caS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA53A22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UOU-0004P2-Ic
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i0UKs-0007LF-PA
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:23:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i0UKr-00006K-Cx
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:23:50 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:42632)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i0UKr-000061-93
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:23:49 -0400
Received: by mail-qt1-x841.google.com with SMTP id t12so3958049qtp.9
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vyCq6BCHwEIzOrWmfwoglKk2AHFeiL8Hmg/UroGRXQw=;
 b=PdKm/caSdLSZ4wwLGnTxAkHWsQIyLEAbTJpCD8twu7zU8lBT20NGOfeFchLmSjkrd6
 UURZ4TrmP++7z3E4yp7f3amj01kh9AeqRGDhHUrXjzrbwrcLnWv/OikC7fsO1evgmQt7
 UM1sVmfjBup/XFfxgYxtZgO6ZydIAWk1ppiFb33GUGFH6FT6f61UXQfhfSurgfVpi9wC
 UHL4EbTBvOo1jZR2vmH4XpGFvFs0cb9SEZFWm3Ibr66ZjuSvR1mC8XmJL/SzFqnbRu1C
 fw3xZgSifPn0cIoT5f+6Zz0C9zJLHtcCEDeVTiYElhl08M+MrE0tgK4WZKajPXPSnFbj
 UsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vyCq6BCHwEIzOrWmfwoglKk2AHFeiL8Hmg/UroGRXQw=;
 b=EvJF+q/Uk0hEu0B3TcoXXQ8vvWVkzVX0rwezsCcFxvZYpG0FUVFrEeADBU5GWTV0cD
 Vnlc9wZg0h2e0K5W1B5XzXjdREr9fdLDuzLzxVfgZ/klhkdkID3HtfKrMn9rTeu3XtPy
 5TgfEtzlUAEg6z5jghP9qTUQSvOFLVMAlDmLmaT7nI7xQCk9DXAl7v+7B6Gt/H1nF1Yv
 RD2KM1vd/UESxK6KOm9rK9Vv+ilPw/ixsPlDu0W/nYWTB0BF8uTrg5HRMexWyqDDosqC
 Jh/CF8j3Nr3HExtw2PbJOhLHh0TET3ME/MOfYyjld4u/TXE6AUNaeLFNmTB4Fxrq98q8
 hKQA==
X-Gm-Message-State: APjAAAW5s2PK1MrdYDTppIqjuhp9tYeeCH+YZTMFIeFIh0XiVt2bxfAe
 8qwtgQarGgTDDZNfDQDLzgPFLhvDRqIFeg==
X-Google-Smtp-Source: APXvYqyHmc/nlclI1MiszkokjqHvlVGibBcBAvqNuG2bRmIEt4uKlz7TUGwdlyy0ytuUj5otHswU/w==
X-Received: by 2002:aed:35b4:: with SMTP id c49mr31056733qte.313.1566408228388; 
 Wed, 21 Aug 2019 10:23:48 -0700 (PDT)
Received: from vanderson-lmcad.gw.lmcad.ic.unicamp.br (gw.lmcad.ic.unicamp.br.
 [143.106.73.166])
 by smtp.googlemail.com with ESMTPSA id a3sm9623998qtp.10.2019.08.21.10.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:23:48 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 14:23:22 -0300
Message-Id: <20190821172329.2062-4-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821172329.2062-1-vandersonmr2@gmail.com>
References: <20190821172329.2062-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: [Qemu-devel] [PATCH v6 03/10] accel: collecting JIT statistics
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

If a TB has a TBS (TBStatistics) with the TB_JIT_STATS
enabled then we collect statistics of its translation
processes and code translation.

Collecting the number of host instructions seems to be
not simple as it would imply in having to modify several
target source files. So, for now, we are only collecting
the size of the host gen code.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 accel/tcg/translate-all.c | 15 ++++++++++++++-
 accel/tcg/translator.c    |  4 ++++
 include/exec/tb-stats.h   | 15 +++++++++++++++
 tcg/tcg.c                 | 23 +++++++++++++++++++++++
 tcg/tcg.h                 |  2 ++
 5 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index e72aeba682..fb2fe0fa1f 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1705,6 +1705,7 @@ static TBStatistics *tb_get_stats(tb_page_addr_t phys_pc, target_ulong pc,
          * then just make the new TB point to the older TBStatistic
          */
         g_free(new_stats);
+        ((TBStatistics *) existing_stats)->tb = current_tb;
         return existing_stats;
     } else {
         return new_stats;
@@ -1785,13 +1786,18 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
      */
     if (tb_stats_collection_enabled()) {
         tb->tb_stats = tb_get_stats(phys_pc, pc, cs_base, flags, tb);
+        uint32_t flag = get_default_tbstats_flag();
 
         if (qemu_log_in_addr_range(tb->pc)) {
-            uint32_t flag = get_default_tbstats_flag();
             if (flag & TB_EXEC_STATS) {
                 tb->tb_stats->stats_enabled |= TB_EXEC_STATS;
             }
         }
+
+        if (flag & TB_JIT_STATS) {
+            tb->tb_stats->stats_enabled |= TB_JIT_STATS;
+            atomic_inc(&tb->tb_stats->translations.total);
+        }
     } else {
         tb->tb_stats = NULL;
     }
@@ -1869,6 +1875,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     atomic_set(&prof->search_out_len, prof->search_out_len + search_size);
 #endif
 
+    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
+        atomic_add(&tb->tb_stats->code.out_len, gen_code_size);
+    }
+
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
         qemu_log_in_addr_range(tb->pc)) {
@@ -1926,6 +1936,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     phys_page2 = -1;
     if ((pc & TARGET_PAGE_MASK) != virt_page2) {
         phys_page2 = get_page_addr_code(env, virt_page2);
+        if (tb_stats_enabled(tb, TB_JIT_STATS)) {
+            atomic_inc(&tb->tb_stats->translations.spanning);
+        }
     }
     /*
      * No explicit memory barrier is required -- tb_link_page() makes the
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 396a11e828..834265d5be 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -117,6 +117,10 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
     db->tb->size = db->pc_next - db->pc_first;
     db->tb->icount = db->num_insns;
 
+    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
+        atomic_add(&db->tb->tb_stats->code.num_guest_inst, db->num_insns);
+    }
+
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(db->pc_first)) {
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
index fdebe7831c..38643f353e 100644
--- a/include/exec/tb-stats.h
+++ b/include/exec/tb-stats.h
@@ -34,6 +34,20 @@ struct TBStatistics {
         unsigned long atomic;
     } executions;
 
+    struct {
+        unsigned num_guest_inst;
+        unsigned num_tcg_ops;
+        unsigned num_tcg_ops_opt;
+        unsigned spills;
+        unsigned out_len;
+    } code;
+
+    struct {
+        unsigned long total;
+        unsigned long uncached;
+        unsigned long spanning;
+    } translations;
+
     /* current TB linked to this TBStatistics */
     TranslationBlock *tb;
 };
@@ -47,6 +61,7 @@ enum TBStatsStatus { TB_STATS_RUNNING, TB_STATS_PAUSED, TB_STATS_STOPPED };
 
 #define TB_NOTHING    (1 << 0)
 #define TB_EXEC_STATS (1 << 1)
+#define TB_JIT_STATS  (1 << 2)
 
 extern int tcg_collect_tb_stats;
 extern uint32_t default_tbstats_flag;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index be2c33c400..446e3d1708 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3126,6 +3126,11 @@ static void temp_sync(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs,
         case TEMP_VAL_REG:
             tcg_out_st(s, ts->type, ts->reg,
                        ts->mem_base->reg, ts->mem_offset);
+
+            /* Count number of spills */
+            if (tb_stats_enabled(s->current_tb, TB_JIT_STATS)) {
+                atomic_inc(&s->current_tb->tb_stats->code.spills);
+            }
             break;
 
         case TEMP_VAL_MEM:
@@ -3997,6 +4002,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     int i, num_insns;
     TCGOp *op;
 
+    s->current_tb = tb;
+
 #ifdef CONFIG_PROFILER
     {
         int n = 0;
@@ -4028,6 +4035,14 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     }
 #endif
 
+    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
+        int n = 0;
+        QTAILQ_FOREACH(op, &s->ops, link) {
+            n++;
+        }
+        atomic_add(&tb->tb_stats->code.num_tcg_ops, n);
+    }
+
 #ifdef CONFIG_DEBUG_TCG
     /* Ensure all labels referenced have been emitted.  */
     {
@@ -4094,6 +4109,14 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     }
 #endif
 
+    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
+        int n = 0;
+        QTAILQ_FOREACH(op, &s->ops, link) {
+            n++;
+        }
+        atomic_add(&tb->tb_stats->code.num_tcg_ops_opt, n);
+    }
+
     tcg_reg_alloc_start(s);
 
     s->code_buf = tb->tc.ptr;
diff --git a/tcg/tcg.h b/tcg/tcg.h
index b411e17a28..bf6f3bcba3 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -738,6 +738,8 @@ struct TCGContext {
 
     uint16_t gen_insn_end_off[TCG_MAX_INSNS];
     target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
+
+    TranslationBlock *current_tb;
 };
 
 extern TCGContext tcg_init_ctx;
-- 
2.22.0



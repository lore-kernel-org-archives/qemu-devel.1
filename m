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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4554AC32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FAEA206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsvkq52U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FAEA206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5XG-0005Kz-NV
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1hy5MT-0000gK-VU
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hy5MS-0001fG-Ia
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:19:33 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:34434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hy5MS-0001f2-E8
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:19:32 -0400
Received: by mail-qt1-x844.google.com with SMTP id q4so961697qtp.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pMPv8x3diYkvzJObvdKKYdrD97zC94XRrQ1bguEiCd4=;
 b=gsvkq52UuLBj0Cuc6zE0h+odY9SdwPikaLeTKJpopDjce70xx67aUJzUkx1i9y7e5t
 dmK5/PIQ+bBPPtGq8g5xqNQZksxFPLq/9q10YZ95W8fjX0pgbMywUCyPrFbGfRI1h8dl
 Uu1SdXhPuurMEB5wa9mrsjmaibMpzU6STKwYw/GT58aXUHjhB2fG61kABvizL39V9LVO
 AZkXjaFkJ8oZh/Ups4nBCzGPia1Q7llGCEkiZOi+aLVhbBz5ULT7gmbJKf6NPBTT0vsZ
 y7zkZGQ6dP3h5RaU/JKEqdmDybr3cPNfHQ1E6RLrg23V5YgnHuA8rHBU1ZCYcy0qrmh2
 8JcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pMPv8x3diYkvzJObvdKKYdrD97zC94XRrQ1bguEiCd4=;
 b=o7bGKoLsWfIg9GbIP7qjA0eDqE361QwkJaWU1Yw7RjmbPr9qzRiQpQmlGmR1JOIOUF
 hFDaobt0XmjjC6hIk9lttaufdxx/bMLTug98lJiG5IUkgVwmwfOel6xi5IKCPDnds/dE
 XmhwXhT0Lgz78AqEwj8yp8deGvT7DcCnZKBp6d0KIfJNGAwuUIiGYgl0RogNUNZR9HWq
 wWl4SbOnBe5nlW+BDCe2LMeumDlhCWp8IcDPw3Hi9FJdT+GRp92AOojSMzU/83ytDg88
 8v2cRA33q+Sf2GRPGxpJ8ifcitxs6zi7/gNSXmSebF5U3p8+tOCn0vVpOP4BvcMjQ2Ks
 gMSg==
X-Gm-Message-State: APjAAAWFIm+XPgCLtHXlzaPbAm7KP7uBPZvsspBbgTdKg2FiY9WICxlw
 LQJdQ8vIRlTqULdZSsTyU0F69hsrntk=
X-Google-Smtp-Source: APXvYqwvRiamSquzaj5Wmg9WV2rSG2mbnF5Q/7iQnpxzYwCccn7RlnIga5fSqNqh1Tr7JAZaZ2E06Q==
X-Received: by 2002:ac8:7182:: with SMTP id w2mr2042878qto.156.1565835571500; 
 Wed, 14 Aug 2019 19:19:31 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:121::1])
 by smtp.googlemail.com with ESMTPSA id o5sm757943qkf.10.2019.08.14.19.19.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:19:30 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 23:18:50 -0300
Message-Id: <20190815021857.19526-4-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815021857.19526-1-vandersonmr2@gmail.com>
References: <20190815021857.19526-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: [Qemu-devel] [PATCH v5 03/10] accel: collecting JIT statistics
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

If a TB has a TBS (TBStatistics) with the TB_JIT_STATS
enabled then we collect statistics of its translation
processes and code translation.

Collecting the number of host instructions seems to be
not simple as it would imply in having to modify several
target source files. So, for now, we are only collecting
the size of the host gen code.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 accel/tcg/translate-all.c | 14 ++++++++++++++
 accel/tcg/translator.c    |  4 ++++
 include/exec/tb-stats.h   | 15 +++++++++++++++
 tcg/tcg.c                 | 23 +++++++++++++++++++++++
 tcg/tcg.h                 |  2 ++
 5 files changed, 58 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index df08d183df..85c6b7b409 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1696,6 +1696,7 @@ static TBStatistics *tb_get_stats(tb_page_addr_t phys_pc, target_ulong pc,
     new_stats->cs_base = cs_base;
     new_stats->flags = flags;
     new_stats->tb = current_tb;
+    new_stats->translations.total = 1;
 
     qht_insert(&tb_ctx.tb_stats, new_stats, hash, &existing_stats);
 
@@ -1705,6 +1706,7 @@ static TBStatistics *tb_get_stats(tb_page_addr_t phys_pc, target_ulong pc,
          * then just make the new TB point to the older TBStatistic
          */
         g_free(new_stats);
+        ((TBStatistics *) existing_stats)->tb = current_tb;
         return existing_stats;
     } else {
         return new_stats;
@@ -1792,6 +1794,11 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
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
@@ -1869,6 +1876,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     atomic_set(&prof->search_out_len, prof->search_out_len + search_size);
 #endif
 
+    if (tb_stats_enabled(tb, TB_JIT_STATS)) {
+        atomic_add(&tb->tb_stats->code.out_len, gen_code_size);
+    }
+
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM) &&
         qemu_log_in_addr_range(tb->pc)) {
@@ -1926,6 +1937,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
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
index 0265050b79..3c219123c2 100644
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
 
 #define TB_NOTHING    0
 #define TB_EXEC_STATS 1
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



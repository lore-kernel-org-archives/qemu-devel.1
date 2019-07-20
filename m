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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E32C7618F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FCB321849
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uzY8Jc0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCB321849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hodnb-0002T2-9t
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 21:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39969)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hodmS-0006HP-6H
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hodmP-0006Eu-JG
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:20 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:39765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hodmP-0006Ek-FL
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:17 -0400
Received: by mail-qk1-x744.google.com with SMTP id w190so24608457qkc.6
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 18:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=48KKCGFrh7UQGCrW6PmnN6KAQZnblyqGuNDDWQvdLoQ=;
 b=uzY8Jc0YhOkU4mY7U3SMHFQws16zP8y9NfhIyas3IMRbWlkz6ihdngIZsaENK+7rEr
 VBa4VQn3/6M0T0BiB2ocw2beK9KgWBd4ijpvHb9VKviOxLnIHjHoo0HP+F3nw09E/f14
 1z41c3q2mTzHVISO781hyxxr6qB8w5UDzI6LCPOrvpAfLYXoF95uUSG8iSx3ppBLh1g3
 lyqkG+BHrwgpBEPizBMW6plnvAw/3me5Poqohs6ldytC7KPLcCub50kgvd52crr0sUQA
 h7LeNEIq6K/ke+lfYr7H+ZQ0MXiqyRNs41+sPsqbD913KiwYEInEyGSNVgkLUwVD7DJc
 Ctfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=48KKCGFrh7UQGCrW6PmnN6KAQZnblyqGuNDDWQvdLoQ=;
 b=WbvMby7te98RyfphoQjhuKrNUH5wz5KNgEe1Dm+qyxAdaoEffGXK1fxOB8NtsOpRHK
 x9sRGnJK96sfxWlUI7/gft1i5aKPXby5ZgOElF0QVDXkFb85o3GhxSQQxdUl6uf0MAIH
 CHMcQnhSPGLsA3S14Fx85L3bjQnlWsBM/M4HxdfuH3Qf9cin0JM2P62OUatq6AtEmlUG
 luIykoeW/N29hs7QSODuG59qYcsPx6R7DDMOhBqjmtfstJx+rL/qE5X+pujWUz59Nap5
 +4YDiH4s/1MwlTo+nkKyuWlXGbiG/TPYVqXbMhkdlz7dGpyzSb2kHCg7S4WSZbuSTcm6
 VD2g==
X-Gm-Message-State: APjAAAVIxYcXNT/CRu2vJOLShmF24QXzelPt427/CbG9fcKq95mKTzwL
 COR2Mwn+L0tGLqk3boSB/z1/8FHP
X-Google-Smtp-Source: APXvYqwTQvRPngzAAnSp7dRABwr1Rhoi0T6wb8qGtNBFPCjzpbg26v9QeuxQn2Asw9/VQeRi+UjbpA==
X-Received: by 2002:a37:4914:: with SMTP id w20mr36909035qka.156.1563584596752; 
 Fri, 19 Jul 2019 18:03:16 -0700 (PDT)
Received: from vanderson-lmcad.domain.name ([177.137.96.41])
 by smtp.googlemail.com with ESMTPSA id g10sm13405115qki.37.2019.07.19.18.03.15
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 18:03:16 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 22:02:30 -0300
Message-Id: <20190720010235.32444-3-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190720010235.32444-1-vandersonmr2@gmail.com>
References: <20190720010235.32444-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: [Qemu-devel] [PATCH v4 2/7] accel: collecting TB execution count
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
enabled, then we instrument the start code of the TB
to atomically count the number of times it is executed.
The execution count of the TB is stored in its respective
TBS.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 accel/tcg/tcg-runtime.c   |  7 +++++++
 accel/tcg/tcg-runtime.h   |  2 ++
 accel/tcg/translate-all.c |  8 ++++++++
 accel/tcg/translator.c    |  1 +
 include/exec/gen-icount.h |  9 +++++++++
 include/exec/tb-stats.h   | 11 +++++++++++
 include/qemu/log.h        |  6 ++++++
 util/log.c                | 11 +++++++++++
 8 files changed, 55 insertions(+)

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 8a1e408e31..f332eae334 100644
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
+    atomic_inc(&stats->executions.total);
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
index a574890a80..7497dae508 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1785,6 +1785,14 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
      */
     if (tb_stats_collection_enabled()) {
         tb->tb_stats = tb_get_stats(phys_pc, pc, cs_base, flags);
+        uint32_t flag = get_default_tbstats_flag();
+
+        if (qemu_log_in_addr_range(tb->pc)) {
+            if (flag & TB_EXEC_STATS) {
+                tb->tb_stats->stats_enabled |= TB_EXEC_STATS;
+            }
+        }
+
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
index 0913155ec3..ee1e8de0d3 100644
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
@@ -22,6 +25,14 @@ struct TBStatistics {
     uint32_t     flags;
     /* cs_base isn't included in the hash but we do check for matches */
     target_ulong cs_base;
+
+    uint32_t stats_enabled;
+
+    /* Execution stats */
+    struct {
+        unsigned long total;
+        unsigned long atomic;
+    } executions;
 };
 
 bool tb_stats_cmp(const void *ap, const void *bp);
diff --git a/include/qemu/log.h b/include/qemu/log.h
index e175d4d5d0..b213411836 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -129,10 +129,16 @@ void qemu_log_flush(void);
 /* Close the log file */
 void qemu_log_close(void);
 
+#define TB_NOTHING    0
+#define TB_EXEC_STATS (1 << 1)
+
 void enable_collect_tb_stats(void);
 void disable_collect_tb_stats(void);
 void pause_collect_tb_stats(void);
 bool tb_stats_collection_enabled(void);
 bool tb_stats_collection_paused(void);
 
+void set_default_tbstats_flag(uint32_t flag);
+uint32_t get_default_tbstats_flag(void);
+
 #endif
diff --git a/util/log.c b/util/log.c
index ab73fdc100..f81653d712 100644
--- a/util/log.c
+++ b/util/log.c
@@ -354,3 +354,14 @@ bool tb_stats_collection_paused(void)
     return tcg_collect_tb_stats == 2;
 }
 
+uint32_t default_tbstats_flag;
+
+void set_default_tbstats_flag(uint32_t flag)
+{
+    default_tbstats_flag = flag;
+}
+
+uint32_t get_default_tbstats_flag(void)
+{
+    return default_tbstats_flag;
+}
-- 
2.22.0



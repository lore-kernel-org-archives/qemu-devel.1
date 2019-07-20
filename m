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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCE7C7618F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAFAD21849
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRgTbZ8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAFAD21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hodmv-0007fi-Do
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 21:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39958)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hodmP-00068o-LY
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hodmO-0006EH-5f
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:17 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:39136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hodmO-0006Du-1H
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:16 -0400
Received: by mail-qt1-x844.google.com with SMTP id l9so32929605qtu.6
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 18:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9s93kcx9QHi1RLJvtLWRybSgOGkahFDvEpGxVZRpbGE=;
 b=YRgTbZ8hrgIkYUEc3Xrk2mV7iaEqRgzJurT+KkmGyS+hhqSlThakeG9WOGFj4eLmOk
 QrwFag4M+3DfI+cm2UPcCxD3XsWNFzGeGyQZNZQuCTL7+SlEC+RQtvIPDfhBQdV0NF4k
 8Enao9xv/jbPKSpcBjXzyOr8n53y0cgUP/TFTwdXLKiFn0psbgA+MBZjrN6aL/xwH9Vx
 iK6z2wJqAKGVH8D1SWrSVZIR/VE5+VTK+yLXHIJfrjaOzW4/vXsLBqORTjoBJhX4SMko
 ums+wXgOjq7ZJaFTK2Qpe2GSwcWl4L0R+pBtU8Kty5WGxy3o6FcoiAqNRYOcFsv7CNU7
 TkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9s93kcx9QHi1RLJvtLWRybSgOGkahFDvEpGxVZRpbGE=;
 b=Z2vpN6KpiZBTKo16NSNKWY35NiKJwKXa19CoPZQcTDYtpQ9jy49iiELrhsGRCyDMH7
 Cxj0ApIiNoN8yYN8THqOcUflPZifIEoIdwxvc0VipLlft6ieY940H2psZNNXiupx+ooc
 AQeoBOkNfGnUc4wIDCR8ZDcA7n+GWaThZJl02avNj+ShHihqFQcR7vl7tfZKMReNvX6X
 Tx+FU84OvZ0dEIIgzvBgKMVLkukiqUGKffXbVGdM9jFxHqNQC8jb0qsjvd/SXMbs5OxW
 W+KbY9+eqai3e4cwa1z6OJZCpunrVy9IdccL6UHx4JnDGiDVk6JhURCTzKMK4LA5eelw
 yxaA==
X-Gm-Message-State: APjAAAUt2L5180uywy7/IPRzJaLQ6ymE62pY+GKE8Ywap2BASeCXr5yS
 sxIUIp4vcvqCWG8UvDRf/4umEhP8
X-Google-Smtp-Source: APXvYqxoogNAjWlWYTWcqbIUNmOCKTQMUFd+Bd1djLeHlwympBxktA6JP1G86ukCLmn40xRORmIwRA==
X-Received: by 2002:a0c:92ca:: with SMTP id c10mr39805114qvc.108.1563584594884; 
 Fri, 19 Jul 2019 18:03:14 -0700 (PDT)
Received: from vanderson-lmcad.domain.name ([177.137.96.41])
 by smtp.googlemail.com with ESMTPSA id g10sm13405115qki.37.2019.07.19.18.03.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 18:03:14 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 22:02:29 -0300
Message-Id: <20190720010235.32444-2-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190720010235.32444-1-vandersonmr2@gmail.com>
References: <20190720010235.32444-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: [Qemu-devel] [PATCH v4 1/7] accel: introducing TBStatistics
 structure
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

To store statistics for each TB we created a TBStatistics structure
which is linked with the TBs. The TBStatistics can stay alive after
tb_flush and be relinked to a regenerated TB. So the statistics can
be accumulated even through flushes.

TBStatistics will be also referred to as TBS or tbstats.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 accel/tcg/translate-all.c | 57 +++++++++++++++++++++++++++++++++++++++
 include/exec/exec-all.h   | 15 +++--------
 include/exec/tb-context.h | 12 +++++++++
 include/exec/tb-hash.h    |  7 +++++
 include/exec/tb-stats.h   | 29 ++++++++++++++++++++
 include/qemu/log.h        |  6 +++++
 util/log.c                | 28 +++++++++++++++++++
 7 files changed, 143 insertions(+), 11 deletions(-)
 create mode 100644 include/exec/tb-stats.h

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5d1e08b169..a574890a80 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1118,6 +1118,23 @@ static inline void code_gen_alloc(size_t tb_size)
     }
 }
 
+/*
+ * This is the more or less the same compare, but the data persists
+ * over tb_flush. We also aggregate the various variations of cflags
+ * under one record and ignore the details of page overlap (although
+ * we can count it).
+ */
+bool tb_stats_cmp(const void *ap, const void *bp)
+{
+    const TBStatistics *a = ap;
+    const TBStatistics *b = bp;
+
+    return a->phys_pc == b->phys_pc &&
+        a->pc == b->pc &&
+        a->cs_base == b->cs_base &&
+        a->flags == b->flags;
+}
+
 static bool tb_cmp(const void *ap, const void *bp)
 {
     const TranslationBlock *a = ap;
@@ -1137,6 +1154,9 @@ static void tb_htable_init(void)
     unsigned int mode = QHT_MODE_AUTO_RESIZE;
 
     qht_init(&tb_ctx.htable, tb_cmp, CODE_GEN_HTABLE_SIZE, mode);
+    if (tb_stats_collection_enabled()) {
+        qht_init(&tb_ctx.tb_stats, tb_stats_cmp, CODE_GEN_HTABLE_SIZE, mode);
+    }
 }
 
 /* Must be called before using the QEMU cpus. 'tb_size' is the size
@@ -1666,6 +1686,32 @@ tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
     return tb;
 }
 
+static TBStatistics *tb_get_stats(tb_page_addr_t phys_pc, target_ulong pc,
+                                  target_ulong cs_base, uint32_t flags)
+{
+    TBStatistics *new_stats = g_new0(TBStatistics, 1);
+    uint32_t hash = tb_stats_hash_func(phys_pc, pc, flags);
+    void *existing_stats = NULL;
+    new_stats->phys_pc = phys_pc;
+    new_stats->pc = pc;
+    new_stats->cs_base = cs_base;
+    new_stats->flags = flags;
+
+    qht_insert(&tb_ctx.tb_stats, new_stats, hash, &existing_stats);
+
+    if (unlikely(existing_stats)) {
+        /*
+         * If there is already a TBStatistic for this TB from a previous flush
+         * then just make the new TB point to the older TBStatistic
+         */
+        g_free(new_stats);
+        return existing_stats;
+    } else {
+        return new_stats;
+    }
+}
+
+
 /* Called with mmap_lock held for user mode emulation.  */
 TranslationBlock *tb_gen_code(CPUState *cpu,
                               target_ulong pc, target_ulong cs_base,
@@ -1732,6 +1778,17 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     ti = profile_getclock();
 #endif
 
+    /*
+     * We want to fetch the stats structure before we start code
+     * generation so we can count interesting things about this
+     * generation.
+     */
+    if (tb_stats_collection_enabled()) {
+        tb->tb_stats = tb_get_stats(phys_pc, pc, cs_base, flags);
+    } else {
+        tb->tb_stats = NULL;
+    }
+
     tcg_func_start(tcg_ctx);
 
     tcg_ctx->cpu = env_cpu(env);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 16034ee651..24bd6a0a0c 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -22,21 +22,11 @@
 
 #include "exec/tb-context.h"
 #include "sysemu/cpus.h"
+#include "exec/tb-stats.h"
 
 /* allow to see translation results - the slowdown should be negligible, so we leave it */
 #define DEBUG_DISAS
 
-/* Page tracking code uses ram addresses in system mode, and virtual
-   addresses in userspace mode.  Define tb_page_addr_t to be an appropriate
-   type.  */
-#if defined(CONFIG_USER_ONLY)
-typedef abi_ulong tb_page_addr_t;
-#define TB_PAGE_ADDR_FMT TARGET_ABI_FMT_lx
-#else
-typedef ram_addr_t tb_page_addr_t;
-#define TB_PAGE_ADDR_FMT RAM_ADDR_FMT
-#endif
-
 #include "qemu/log.h"
 
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int max_insns);
@@ -403,6 +393,9 @@ struct TranslationBlock {
     uintptr_t jmp_list_head;
     uintptr_t jmp_list_next[2];
     uintptr_t jmp_dest[2];
+
+    /* Pointer to a struct where statistics from the TB is stored */
+    TBStatistics *tb_stats;
 };
 
 extern bool parallel_cpus;
diff --git a/include/exec/tb-context.h b/include/exec/tb-context.h
index feb585e0a7..3cfb62a338 100644
--- a/include/exec/tb-context.h
+++ b/include/exec/tb-context.h
@@ -23,6 +23,17 @@
 #include "qemu/thread.h"
 #include "qemu/qht.h"
 
+/* Page tracking code uses ram addresses in system mode, and virtual
+   addresses in userspace mode.  Define tb_page_addr_t to be an appropriate
+   type.  */
+#if defined(CONFIG_USER_ONLY)
+typedef abi_ulong tb_page_addr_t;
+#define TB_PAGE_ADDR_FMT TARGET_ABI_FMT_lx
+#else
+typedef ram_addr_t tb_page_addr_t;
+#define TB_PAGE_ADDR_FMT RAM_ADDR_FMT
+#endif
+
 #define CODE_GEN_HTABLE_BITS     15
 #define CODE_GEN_HTABLE_SIZE     (1 << CODE_GEN_HTABLE_BITS)
 
@@ -35,6 +46,7 @@ struct TBContext {
 
     /* statistics */
     unsigned tb_flush_count;
+    struct qht tb_stats;
 };
 
 extern TBContext tb_ctx;
diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
index 4f3a37d927..54c477fe79 100644
--- a/include/exec/tb-hash.h
+++ b/include/exec/tb-hash.h
@@ -64,4 +64,11 @@ uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc, uint32_t flags,
     return qemu_xxhash7(phys_pc, pc, flags, cf_mask, trace_vcpu_dstate);
 }
 
+static inline
+uint32_t tb_stats_hash_func(tb_page_addr_t phys_pc, target_ulong pc,
+                            uint32_t flags)
+{
+    return qemu_xxhash5(phys_pc, pc, flags);
+}
+
 #endif
diff --git a/include/exec/tb-stats.h b/include/exec/tb-stats.h
new file mode 100644
index 0000000000..0913155ec3
--- /dev/null
+++ b/include/exec/tb-stats.h
@@ -0,0 +1,29 @@
+#ifndef TB_STATS_H
+
+#define TB_STATS_H
+
+#include "exec/cpu-common.h"
+#include "exec/tb-context.h"
+#include "tcg.h"
+
+typedef struct TBStatistics TBStatistics;
+
+/*
+ * This struct stores statistics such as execution count of the
+ * TranslationBlocks. Each sets of TBs for a given phys_pc/pc/flags
+ * has its own TBStatistics which will persist over tb_flush.
+ *
+ * We include additional counters to track number of translations as
+ * well as variants for compile flags.
+ */
+struct TBStatistics {
+    tb_page_addr_t phys_pc;
+    target_ulong pc;
+    uint32_t     flags;
+    /* cs_base isn't included in the hash but we do check for matches */
+    target_ulong cs_base;
+};
+
+bool tb_stats_cmp(const void *ap, const void *bp);
+
+#endif
diff --git a/include/qemu/log.h b/include/qemu/log.h
index b097a6cae1..e175d4d5d0 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -129,4 +129,10 @@ void qemu_log_flush(void);
 /* Close the log file */
 void qemu_log_close(void);
 
+void enable_collect_tb_stats(void);
+void disable_collect_tb_stats(void);
+void pause_collect_tb_stats(void);
+bool tb_stats_collection_enabled(void);
+bool tb_stats_collection_paused(void);
+
 #endif
diff --git a/util/log.c b/util/log.c
index 1d1b33f7d9..ab73fdc100 100644
--- a/util/log.c
+++ b/util/log.c
@@ -326,3 +326,31 @@ void qemu_print_log_usage(FILE *f)
     fprintf(f, "\nUse \"-d trace:help\" to get a list of trace events.\n\n");
 #endif
 }
+
+int tcg_collect_tb_stats;
+
+void enable_collect_tb_stats(void)
+{
+    tcg_collect_tb_stats = 1;
+}
+
+void disable_collect_tb_stats(void)
+{
+    tcg_collect_tb_stats = 0;
+}
+
+void pause_collect_tb_stats(void)
+{
+    tcg_collect_tb_stats = 2;
+}
+
+bool tb_stats_collection_enabled(void)
+{
+    return tcg_collect_tb_stats;
+}
+
+bool tb_stats_collection_paused(void)
+{
+    return tcg_collect_tb_stats == 2;
+}
+
-- 
2.22.0



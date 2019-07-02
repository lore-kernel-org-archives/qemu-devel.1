Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AFEC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 21:10:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622822189E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 21:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBjVpvqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622822189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiQ2X-0003rB-Nt
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 17:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44884)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hiPuv-0007pg-IS
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 17:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hiPur-0003al-UP
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 17:02:21 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:45126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hiPul-0002Zt-Sx
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 17:02:13 -0400
Received: by mail-qt1-x843.google.com with SMTP id j19so82923qtr.12
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 14:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+Tx58DiKNf5aGUYthM3tfZM0QXYu+wSHpNcQST2QqK4=;
 b=eBjVpvqUQ3vge+puzHQQ/WEJcNL+gkkBwT55JHbsJil8v/pQ1Sc+DcadMbD7uLSkcC
 FdkUzHAvBBKjI+KkYAVlXmwH9ldvtSpEKqMbSSLNsDNtXr670NUaRQuTJk99rLTY9js9
 fVI+d1B/0w8IFjEqEFdtZXMIGCxhv32cFNiv6F1jAJp0mHzC0uOcF+O5kxx1ys1kpjaw
 mz1epIkqt58hKYU2Nnp3sNCixGDSBRouffYF1lLtSRbe4Rw3vApu9VbdBgMEb1aRTQiU
 lzY1H8pQ+KHpWYWKqSAd++cPQKCerZ9utTzPKnLs8LimWTcmLfCjnjpvwFKijcQHHWHM
 3sQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+Tx58DiKNf5aGUYthM3tfZM0QXYu+wSHpNcQST2QqK4=;
 b=rSg1H4jbroax0eu/+ZkdWiDf8WaANgF9ryM+O2HZApLPmDZizHLOjpBFiz2N42qxIj
 9eccUJg6QvSSWfe5mRWAOLdtJ5NgHBcboAigPQaSwk5WZMc7KRrjcljB8imWlqGuyMdC
 eUkSwFgJ6rrwZVhY3VqhH0fxsVnAFImjwPjp6yGGH7CDLkPFF1frxXC3HQlKvF2VBtzd
 LOBHvbI03MEO4Ka+FLIXD9OOckPB2PjLGWlgilrpZgFhx0i8WPnB88aYvS2y4lTTwY6h
 zy2aVAEoroRR5rHvn8LvvD1blUCthkwel+Z9qA3ZuG8Uyu+Yxs/mY9CV9RKro6+x/QFj
 AvxA==
X-Gm-Message-State: APjAAAWxL8Fu/SSyYRUfinlEealyfPPujGLGcxp2b6j5ih3BFBesKLDs
 Pu05Yu9olK6M6V6xKiTFOT8PYHWjyts=
X-Google-Smtp-Source: APXvYqzuh9jT/STvDOAO1IrrdOMkUiP6zcnghJ7oRbRNoSsyc/JK6qibmOiJVpCl84qv5m4XPbAHyg==
X-Received: by 2002:ac8:1ba9:: with SMTP id z38mr27579404qtj.176.1562101254329; 
 Tue, 02 Jul 2019 14:00:54 -0700 (PDT)
Received: from vanderson-lmcad.HotSpot300 ([189.61.239.22])
 by smtp.googlemail.com with ESMTPSA id
 s127sm6770979qkd.107.2019.07.02.14.00.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 14:00:53 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 18:00:15 -0300
Message-Id: <20190702210017.4275-4-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702210017.4275-1-vandersonmr2@gmail.com>
References: <20190702210017.4275-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
Subject: [Qemu-devel] [PATCH v3 4/6] util/log: introduce dump of tbstats and
 -d hot_tbs:limit
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 vandersonmr <vandersonmr2@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

add option to dump the N most hot TB blocks.
-d hot_tbs:N
and also add all tbstats dump functions.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 accel/tcg/Makefile.objs      |   1 +
 accel/tcg/tb-stats.c         | 293 +++++++++++++++++++++++++++++++++++
 include/exec/cpu-all.h       |  43 +++++
 include/qemu/log-for-trace.h |   2 +
 include/qemu/log.h           |   1 +
 linux-user/exit.c            |   3 +
 util/log.c                   |  35 ++++-
 7 files changed, 370 insertions(+), 8 deletions(-)
 create mode 100644 accel/tcg/tb-stats.c

diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index d381a02f34..59d50d2dc5 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -3,6 +3,7 @@ obj-$(CONFIG_SOFTMMU) += cputlb.o
 obj-y += tcg-runtime.o tcg-runtime-gvec.o
 obj-y += cpu-exec.o cpu-exec-common.o translate-all.o
 obj-y += translator.o
+obj-y += tb-stats.o
 
 obj-$(CONFIG_USER_ONLY) += user-exec.o
 obj-$(call lnot,$(CONFIG_SOFTMMU)) += user-exec-stub.o
diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
new file mode 100644
index 0000000000..922023f29d
--- /dev/null
+++ b/accel/tcg/tb-stats.c
@@ -0,0 +1,293 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+/* XXX: I'm not sure what includes could be safely removed */
+#define NO_CPU_IO_DEFS
+#include "cpu.h"
+#include "trace.h"
+#include "disas/disas.h"
+#include "exec/exec-all.h"
+#include "tcg.h"
+#if defined(CONFIG_USER_ONLY)
+#include "qemu.h"
+#if defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
+#include <sys/param.h>
+#if __FreeBSD_version >= 700104
+#define HAVE_KINFO_GETVMMAP
+#define sigqueue sigqueue_freebsd  /* avoid redefinition */
+#include <sys/proc.h>
+#include <machine/profile.h>
+#define _KERNEL
+#include <sys/user.h>
+#undef _KERNEL
+#undef sigqueue
+#include <libutil.h>
+#endif
+#endif
+#else
+#include "exec/ram_addr.h"
+#endif
+
+#include "qemu/qemu-print.h"
+
+
+/* only accessed in safe work */
+static GList *last_search;
+
+static void collect_tb_stats(void *p, uint32_t hash, void *userp)
+{
+    last_search = g_list_prepend(last_search, p);
+}
+
+static void dump_tb_header(TBStatistics *tbs)
+{
+    qemu_log("TB%d: phys:0x"TB_PAGE_ADDR_FMT" virt:0x"TARGET_FMT_lx
+             " flags:%#08x (trans:%lu uncached:%lu exec:%lu ints: g:%u op:%u h:%u h/g: %f)\n",
+             tbs->display_id,
+             tbs->phys_pc, tbs->pc, tbs->flags,
+             tbs->translations.total, tbs->translations.uncached,
+             tbs->executions.total,
+             tbs->code.num_guest_inst,
+             tbs->code.num_tcg_inst,
+             tbs->code.num_host_inst,
+             tbs->code.num_guest_inst ?
+                ((float) tbs->code.num_host_inst / tbs->code.num_guest_inst) :
+                0);
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
+    if (likely(sort_by == SORT_BY_HOTNESS)) {
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
+
+    return c1 < c2 ? 1 : c1 == c2 ? 0 : -1;
+}
+
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
+    /* XXX: we could pass user data to collect_tb_stats to filter */
+    qht_iter(&tb_ctx.tb_stats, collect_tb_stats, NULL);
+
+    last_search = g_list_sort_with_data(last_search, inverse_sort_tbs,
+                                        SORT_BY_HOTNESS);
+
+    /* Compute total execution count for all tbs */
+    for (i = last_search; i; i = i->next) {
+        TBStatistics *tbs = (TBStatistics *) i->data;
+        total_exec_count += tbs->executions.total;
+    }
+
+    for (i = last_search; i; i = i->next) {
+        TBStatistics *tbs = (TBStatistics *) i->data;
+        covered_exec_count += tbs->executions.total;
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
+    qemu_log("# of TBs to reach %d%% of the total exec count: %u\t",
+                percentage, coverset_size);
+    qemu_log("Total exec count: %lu\n", total_exec_count);
+    qemu_log("\n------------------------------\n");
+
+    /* free the unused bits */
+    i->next->prev = NULL;
+    g_list_free(i->next);
+    i->next = NULL;
+}
+
+
+static void do_dump_tbs_info(int count, int sort_by)
+{
+    int id = 1;
+    GList *i;
+
+    g_list_free(last_search);
+    last_search = NULL;
+
+    /* XXX: we could pass user data to collect_tb_stats to filter */
+    qht_iter(&tb_ctx.tb_stats, collect_tb_stats, NULL);
+
+    last_search = g_list_sort_with_data(last_search, inverse_sort_tbs,
+                                        &sort_by);
+
+    for (i = last_search; i && count--; i = i->next) {
+        TBStatistics *tbs = (TBStatistics *) i->data;
+        tbs->display_id = id++;
+        dump_tb_header(tbs);
+    }
+
+    /* free the unused bits */
+    if (i && i->next) {
+        i->next->prev = NULL;
+    }
+    g_list_free(i->next);
+    i->next = NULL;
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
+        }
+    }
+    qemu_log_to_monitor(false);
+    g_free(tbdi);
+}
+
+/* XXX: only from monitor? */
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
+void clean_tbstats_info(void)
+{
+/* TODO: remove all tb_stats */
+}
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 536ea58f81..c4bfad75d3 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -365,6 +365,49 @@ void dump_exec_info(void);
 void dump_opcount_info(void);
 #endif /* !CONFIG_USER_ONLY */
 
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
+#define SORT_BY_HOTNESS 0
+#define SORT_BY_HG 1
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
+/**
+ * clean_tbstats_info: remove all tb_stats information
+ *
+ */
+void clean_tbstats_info(void);
+
+
+
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
                         uint8_t *buf, target_ulong len, int is_write);
 
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
index 2fca65dd01..240b71f66a 100644
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
index bdda720553..295d3f4cad 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -28,6 +28,9 @@ extern void __gcov_dump(void);
 
 void preexit_cleanup(CPUArchState *env, int code)
 {
+    if (qemu_loglevel_mask(CPU_LOG_HOT_TBS)) {
+        dump_tbs_info(max_num_hot_tbs_to_dump, SORT_BY_HOTNESS, false);
+    }
 #ifdef TARGET_GPROF
         _mcleanup();
 #endif
diff --git a/util/log.c b/util/log.c
index 1d1b33f7d9..c0f1e9980f 100644
--- a/util/log.c
+++ b/util/log.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/qemu-print.h"
 #include "qemu/range.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -30,21 +31,26 @@ FILE *qemu_logfile;
 int qemu_loglevel;
 static int log_append = 0;
 static GArray *debug_regions;
+int32_t max_num_hot_tbs_to_dump;
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
@@ -99,6 +105,11 @@ void qemu_set_log(int log_flags)
     }
 }
 
+void qemu_log_to_monitor(bool enable)
+{
+    to_monitor = enable;
+}
+
 void qemu_log_needs_buffers(void)
 {
     log_uses_own_buffers = true;
@@ -273,6 +284,9 @@ const QEMULogItem qemu_log_items[] = {
     { CPU_LOG_TB_NOCHAIN, "nochain",
       "do not chain compiled TBs so that \"exec\" and \"cpu\" show\n"
       "complete traces" },
+    { CPU_LOG_HOT_TBS, "hot_tbs(:limit)",
+      "show TBs (until given a limit) ordered by their hotness.\n"
+      "(if no limit is given, show all)" },
     { 0, NULL, NULL },
 };
 
@@ -294,6 +308,11 @@ int qemu_str_to_log_mask(const char *str)
             trace_enable_events((*tmp) + 6);
             mask |= LOG_TRACE;
 #endif
+        } else if (g_str_has_prefix(*tmp, "hot_tbs")) {
+            if (g_str_has_prefix(*tmp, "hot_tbs:") && (*tmp)[8] != '\0') {
+                max_num_hot_tbs_to_dump = atoi((*tmp) + 8);
+            }
+            mask |= CPU_LOG_HOT_TBS;
         } else {
             for (item = qemu_log_items; item->mask != 0; item++) {
                 if (g_str_equal(*tmp, item->name)) {
-- 
2.22.0



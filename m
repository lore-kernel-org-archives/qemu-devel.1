Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3B4C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA76223E8
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA76223E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIYLv-00081s-U2
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 10:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kIYIM-00037W-D3
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:20:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:47186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kIYI8-0003mM-RG
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:20:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8545CB23D;
 Wed, 16 Sep 2020 14:20:24 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v8 01/17] cpu-timers, icount: new modules
Date: Wed, 16 Sep 2020 16:19:48 +0200
Message-Id: <20200916142004.27429-2-cfontana@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200916142004.27429-1-cfontana@suse.de>
References: <20200916142004.27429-1-cfontana@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 00:39:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Wenchao Wang <wenchao.wang@intel.com>, haxm-team@intel.com,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

refactoring of cpus.c continues with cpu timer state extraction.

cpu-timers: responsible for the softmmu cpu timers state,
            including cpu clocks and ticks.

icount: counts the TCG instructions executed. As such it is specific to
the TCG accelerator. Therefore, it is built only under CONFIG_TCG.

One complication is due to qtest, which uses an icount field to warp time
as part of qtest (qtest_clock_warp).

In order to solve this problem, provide a separate counter for qtest.

This requires fixing assumptions scattered in the code that
qtest_enabled() implies icount_enabled(), checking each specific case.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[remove redundant initialization with qemu_spice_init]
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
[fix lingering calls to icount_get]
Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 MAINTAINERS                  |   2 +
 accel/qtest.c                |   6 +-
 accel/tcg/cpu-exec.c         |  39 +-
 accel/tcg/tcg-all.c          |   7 +-
 accel/tcg/translate-all.c    |   3 +-
 dma-helpers.c                |   4 +-
 exec.c                       |   4 -
 hw/core/ptimer.c             |   8 +-
 hw/i386/x86.c                |   1 +
 include/exec/cpu-all.h       |   4 +
 include/exec/exec-all.h      |   4 +-
 include/qemu/timer.h         |  24 +-
 include/sysemu/cpu-timers.h  |  87 ++++
 include/sysemu/cpus.h        |  12 +-
 include/sysemu/qtest.h       |   2 +
 replay/replay.c              |   4 +-
 softmmu/cpu-timers.c         | 284 +++++++++++++
 softmmu/cpus.c               | 744 +----------------------------------
 softmmu/icount.c             | 492 +++++++++++++++++++++++
 softmmu/meson.build          |  10 +-
 softmmu/qtest.c              |  34 +-
 softmmu/timers-state.h       |  69 ++++
 softmmu/vl.c                 |   6 +-
 stubs/clock-warp.c           |   7 -
 stubs/cpu-get-clock.c        |   3 +-
 stubs/cpu-get-icount.c       |  16 -
 stubs/icount.c               |  45 +++
 stubs/meson.build            |   4 +-
 stubs/qemu-timer-notify-cb.c |   2 +-
 stubs/qtest.c                |   5 +
 target/alpha/translate.c     |   3 +-
 target/arm/helper.c          |   3 +-
 target/riscv/csr.c           |   4 +-
 tests/ptimer-test-stubs.c    |   5 +-
 tests/test-timed-average.c   |   2 +-
 util/main-loop.c             |  12 +-
 util/qemu-timer.c            |  10 +-
 37 files changed, 1128 insertions(+), 843 deletions(-)
 create mode 100644 include/sysemu/cpu-timers.h
 create mode 100644 softmmu/cpu-timers.c
 create mode 100644 softmmu/icount.c
 create mode 100644 softmmu/timers-state.h
 delete mode 100644 stubs/clock-warp.c
 delete mode 100644 stubs/cpu-get-icount.c
 create mode 100644 stubs/icount.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d17cad19a..dbca9e67c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2308,6 +2308,8 @@ F: softmmu/vl.c
 F: softmmu/main.c
 F: softmmu/cpus.c
 F: softmmu/cpu-throttle.c
+F: softmmu/cpu-timers.c
+F: softmmu/icount.c
 F: qapi/run-state.json
 
 Human Monitor (HMP)
diff --git a/accel/qtest.c b/accel/qtest.c
index 5b88f55921..119d0f16a4 100644
--- a/accel/qtest.c
+++ b/accel/qtest.c
@@ -19,14 +19,10 @@
 #include "sysemu/accel.h"
 #include "sysemu/qtest.h"
 #include "sysemu/cpus.h"
+#include "sysemu/cpu-timers.h"
 
 static int qtest_init_accel(MachineState *ms)
 {
-    QemuOpts *opts = qemu_opts_create(qemu_find_opts("icount"), NULL, 0,
-                                      &error_abort);
-    qemu_opt_set(opts, "shift", "0", &error_abort);
-    configure_icount(opts, &error_abort);
-    qemu_opts_del(opts);
     return 0;
 }
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 66d38f9d85..ee9d22d92c 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "trace.h"
 #include "disas/disas.h"
@@ -36,6 +37,8 @@
 #include "hw/i386/apic.h"
 #endif
 #include "sysemu/cpus.h"
+#include "exec/cpu-all.h"
+#include "sysemu/cpu-timers.h"
 #include "sysemu/replay.h"
 
 /* -icount align implementation. */
@@ -56,6 +59,9 @@ typedef struct SyncClocks {
 #define MAX_DELAY_PRINT_RATE 2000000000LL
 #define MAX_NB_PRINTS 100
 
+static int64_t max_delay;
+static int64_t max_advance;
+
 static void align_clocks(SyncClocks *sc, CPUState *cpu)
 {
     int64_t cpu_icount;
@@ -98,9 +104,9 @@ static void print_delay(const SyncClocks *sc)
             (-sc->diff_clk / (float)1000000000LL <
              (threshold_delay - THRESHOLD_REDUCE))) {
             threshold_delay = (-sc->diff_clk / 1000000000LL) + 1;
-            printf("Warning: The guest is now late by %.1f to %.1f seconds\n",
-                   threshold_delay - 1,
-                   threshold_delay);
+            qemu_printf("Warning: The guest is now late by %.1f to %.1f seconds\n",
+                        threshold_delay - 1,
+                        threshold_delay);
             nb_prints++;
             last_realtime_clock = sc->realtime_clock;
         }
@@ -614,7 +620,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
 
     /* Finally, check if we need to exit to the main loop.  */
     if (unlikely(atomic_read(&cpu->exit_request))
-        || (use_icount
+        || (icount_enabled()
             && cpu_neg(cpu)->icount_decr.u16.low + cpu->icount_extra == 0)) {
         atomic_set(&cpu->exit_request, 0);
         if (cpu->exception_index == -1) {
@@ -655,7 +661,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     }
 
     /* Instruction counter expired.  */
-    assert(use_icount);
+    assert(icount_enabled());
 #ifndef CONFIG_USER_ONLY
     /* Ensure global icount has gone forward */
     cpu_update_icount(cpu);
@@ -758,3 +764,26 @@ int cpu_exec(CPUState *cpu)
 
     return ret;
 }
+
+#ifndef CONFIG_USER_ONLY
+
+void dump_drift_info(void)
+{
+    if (!icount_enabled()) {
+        return;
+    }
+
+    qemu_printf("Host - Guest clock  %"PRIi64" ms\n",
+                (cpu_get_clock() - cpu_get_icount()) / SCALE_MS);
+    if (icount_align_option) {
+        qemu_printf("Max guest delay     %"PRIi64" ms\n",
+                    -max_delay / SCALE_MS);
+        qemu_printf("Max guest advance   %"PRIi64" ms\n",
+                    max_advance / SCALE_MS);
+    } else {
+        qemu_printf("Max guest delay     NA\n");
+        qemu_printf("Max guest advance   NA\n");
+    }
+}
+
+#endif /* !CONFIG_USER_ONLY */
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 7098ad96c3..e064065962 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -29,6 +29,7 @@
 #include "qom/object.h"
 #include "cpu.h"
 #include "sysemu/cpus.h"
+#include "sysemu/cpu-timers.h"
 #include "qemu/main-loop.h"
 #include "tcg/tcg.h"
 #include "qapi/error.h"
@@ -66,7 +67,7 @@ static void tcg_handle_interrupt(CPUState *cpu, int mask)
         qemu_cpu_kick(cpu);
     } else {
         atomic_set(&cpu_neg(cpu)->icount_decr.u16.high, -1);
-        if (use_icount &&
+        if (icount_enabled() &&
             !cpu->can_do_io
             && (mask & ~old_mask) != 0) {
             cpu_abort(cpu, "Raised interrupt while not in I/O function");
@@ -105,7 +106,7 @@ static bool check_tcg_memory_orders_compatible(void)
 
 static bool default_mttcg_enabled(void)
 {
-    if (use_icount || TCG_OVERSIZED_GUEST) {
+    if (icount_enabled() || TCG_OVERSIZED_GUEST) {
         return false;
     } else {
 #ifdef TARGET_SUPPORTS_MTTCG
@@ -147,7 +148,7 @@ static void tcg_set_thread(Object *obj, const char *value, Error **errp)
     if (strcmp(value, "multi") == 0) {
         if (TCG_OVERSIZED_GUEST) {
             error_setg(errp, "No MTTCG when guest word size > hosts");
-        } else if (use_icount) {
+        } else if (icount_enabled()) {
             error_setg(errp, "No MTTCG when icount is enabled");
         } else {
 #ifndef TARGET_SUPPORTS_MTTCG
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 2d83013633..c39ff7b047 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -57,6 +57,7 @@
 #include "qemu/main-loop.h"
 #include "exec/log.h"
 #include "sysemu/cpus.h"
+#include "sysemu/cpu-timers.h"
 #include "sysemu/tcg.h"
 
 /* #define DEBUG_TB_INVALIDATE */
@@ -369,7 +370,7 @@ static int cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
 
  found:
     if (reset_icount && (tb_cflags(tb) & CF_USE_ICOUNT)) {
-        assert(use_icount);
+        assert(icount_enabled());
         /* Reset the cycle counter to the start of the block
            and shift if to the number of actually executed instructions */
         cpu_neg(cpu)->icount_decr.u16.low += num_insns - i;
diff --git a/dma-helpers.c b/dma-helpers.c
index 41ef24a63b..03c92e0cc6 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -13,7 +13,7 @@
 #include "trace/trace-root.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
-#include "sysemu/cpus.h"
+#include "sysemu/cpu-timers.h"
 #include "qemu/range.h"
 
 /* #define DEBUG_IOMMU */
@@ -151,7 +151,7 @@ static void dma_blk_cb(void *opaque, int ret)
          * from several sectors. This code splits all SGs into several
          * groups. SGs in every group do not overlap.
          */
-        if (mem && use_icount && dbs->dir == DMA_DIRECTION_FROM_DEVICE) {
+        if (mem && icount_enabled() && dbs->dir == DMA_DIRECTION_FROM_DEVICE) {
             int i;
             for (i = 0 ; i < dbs->iov.niov ; ++i) {
                 if (ranges_overlap((intptr_t)dbs->iov.iov[i].iov_base,
diff --git a/exec.c b/exec.c
index e34b602bdf..cfe7d0e935 100644
--- a/exec.c
+++ b/exec.c
@@ -102,10 +102,6 @@ uintptr_t qemu_host_page_size;
 intptr_t qemu_host_page_mask;
 
 #if !defined(CONFIG_USER_ONLY)
-/* 0 = Do not count executed instructions.
-   1 = Precise instruction counting.
-   2 = Adaptive rate instruction counting.  */
-int use_icount;
 
 typedef struct PhysPageEntry PhysPageEntry;
 
diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index b5a54e2536..c6d2beb1da 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -7,11 +7,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "migration/vmstate.h"
 #include "qemu/host-utils.h"
 #include "sysemu/replay.h"
+#include "sysemu/cpu-timers.h"
 #include "sysemu/qtest.h"
 #include "block/aio.h"
 #include "sysemu/cpus.h"
@@ -134,7 +134,8 @@ static void ptimer_reload(ptimer_state *s, int delta_adjust)
      * on the current generation of host machines.
      */
 
-    if (s->enabled == 1 && (delta * period < 10000) && !use_icount) {
+    if (s->enabled == 1 && (delta * period < 10000) &&
+        !icount_enabled() && !qtest_enabled()) {
         period = 10000 / delta;
         period_frac = 0;
     }
@@ -217,7 +218,8 @@ uint64_t ptimer_get_count(ptimer_state *s)
             uint32_t period_frac = s->period_frac;
             uint64_t period = s->period;
 
-            if (!oneshot && (s->delta * period < 10000) && !use_icount) {
+            if (!oneshot && (s->delta * period < 10000) &&
+                !icount_enabled() && !qtest_enabled()) {
                 period = 10000 / s->delta;
                 period_frac = 0;
             }
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index c1954db152..309632c948 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -34,6 +34,7 @@
 #include "sysemu/numa.h"
 #include "sysemu/replay.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/cpu-timers.h"
 #include "trace.h"
 
 #include "hw/i386/x86.h"
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index f6439c4705..61e13b5038 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -407,8 +407,12 @@ static inline bool tlb_hit(target_ulong tlb_addr, target_ulong addr)
     return tlb_hit_page(tlb_addr, addr & TARGET_PAGE_MASK);
 }
 
+#ifdef CONFIG_TCG
+void dump_drift_info(void);
 void dump_exec_info(void);
 void dump_opcount_info(void);
+#endif /* CONFIG_TCG */
+
 #endif /* !CONFIG_USER_ONLY */
 
 /* Returns: 0 on success, -1 on error */
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 3cf88272df..e019b505a5 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -25,7 +25,7 @@
 #ifdef CONFIG_TCG
 #include "exec/cpu_ldst.h"
 #endif
-#include "sysemu/cpus.h"
+#include "sysemu/cpu-timers.h"
 
 /* allow to see translation results - the slowdown should be negligible, so we leave it */
 #define DEBUG_DISAS
@@ -497,7 +497,7 @@ static inline uint32_t tb_cflags(const TranslationBlock *tb)
 static inline uint32_t curr_cflags(void)
 {
     return (parallel_cpus ? CF_PARALLEL : 0)
-         | (use_icount ? CF_USE_ICOUNT : 0);
+         | (icount_enabled() ? CF_USE_ICOUNT : 0);
 }
 
 /* TranslationBlock invalidate API */
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 6a8b48b5a9..2f7afc1f68 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -166,8 +166,8 @@ bool qemu_clock_expired(QEMUClockType type);
  *
  * Determine whether a clock should be used for deadline
  * calculations. Some clocks, for instance vm_clock with
- * use_icount set, do not count in nanoseconds. Such clocks
- * are not used for deadline calculations, and are presumed
+ * icount_enabled() set, do not count in nanoseconds.
+ * Such clocks are not used for deadline calculations, and are presumed
  * to interrupt any poll using qemu_notify/aio_notify
  * etc.
  *
@@ -224,13 +224,6 @@ void qemu_clock_notify(QEMUClockType type);
  */
 void qemu_clock_enable(QEMUClockType type, bool enabled);
 
-/**
- * qemu_start_warp_timer:
- *
- * Starts a timer for virtual clock update
- */
-void qemu_start_warp_timer(void);
-
 /**
  * qemu_clock_run_timers:
  * @type: clock on which to operate
@@ -791,12 +784,6 @@ static inline int64_t qemu_soonest_timeout(int64_t timeout1, int64_t timeout2)
  */
 void init_clocks(QEMUTimerListNotifyCB *notify_cb);
 
-int64_t cpu_get_ticks(void);
-/* Caller must hold BQL */
-void cpu_enable_ticks(void);
-/* Caller must hold BQL */
-void cpu_disable_ticks(void);
-
 static inline int64_t get_max_clock_jump(void)
 {
     /* This should be small enough to prevent excessive interrupts from being
@@ -850,13 +837,6 @@ static inline int64_t get_clock(void)
 }
 #endif
 
-/* icount */
-int64_t cpu_get_icount_raw(void);
-int64_t cpu_get_icount(void);
-int64_t cpu_get_clock(void);
-int64_t cpu_icount_to_ns(int64_t icount);
-void    cpu_update_icount(CPUState *cpu);
-
 /*******************************************/
 /* host CPU ticks (if available) */
 
diff --git a/include/sysemu/cpu-timers.h b/include/sysemu/cpu-timers.h
new file mode 100644
index 0000000000..4b621fea51
--- /dev/null
+++ b/include/sysemu/cpu-timers.h
@@ -0,0 +1,87 @@
+/*
+ * CPU timers state API
+ *
+ * Copyright 2020 SUSE LLC
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+#ifndef SYSEMU_CPU_TIMERS_H
+#define SYSEMU_CPU_TIMERS_H
+
+#include "qemu/timer.h"
+
+/* init the whole cpu timers API, including icount, ticks, and cpu_throttle */
+void cpu_timers_init(void);
+
+/* icount - Instruction Counter API */
+
+/*
+ * icount enablement state:
+ *
+ * 0 = Disabled - Do not count executed instructions.
+ * 1 = Enabled - Fixed conversion of insn to ns via "shift" option
+ * 2 = Enabled - Runtime adaptive algorithm to compute shift
+ */
+#ifdef CONFIG_TCG
+extern int use_icount;
+#define icount_enabled() (use_icount)
+#else
+#define icount_enabled() 0
+#endif
+
+/*
+ * Update the icount with the executed instructions. Called by
+ * cpus-tcg vCPU thread so the main-loop can see time has moved forward.
+ */
+void cpu_update_icount(CPUState *cpu);
+
+/* get raw icount value */
+int64_t cpu_get_icount_raw(void);
+
+/* return the virtual CPU time in ns, based on the instruction counter. */
+int64_t cpu_get_icount(void);
+/*
+ * convert an instruction counter value to ns, based on the icount shift.
+ * This shift is set as a fixed value with the icount "shift" option
+ * (precise mode), or it is constantly approximated and corrected at
+ * runtime in adaptive mode.
+ */
+int64_t cpu_icount_to_ns(int64_t icount);
+
+/* configure the icount options, including "shift" */
+void configure_icount(QemuOpts *opts, Error **errp);
+
+/* used by tcg vcpu thread to calc icount budget */
+int64_t qemu_icount_round(int64_t count);
+
+/* if the CPUs are idle, start accounting real time to virtual clock. */
+void qemu_start_warp_timer(void);
+void qemu_account_warp_timer(void);
+
+/*
+ * CPU Ticks and Clock
+ */
+
+/* Caller must hold BQL */
+void cpu_enable_ticks(void);
+/* Caller must hold BQL */
+void cpu_disable_ticks(void);
+
+/*
+ * return the time elapsed in VM between vm_start and vm_stop.  Unless
+ * icount is active, cpu_get_ticks() uses units of the host CPU cycle
+ * counter.
+ */
+int64_t cpu_get_ticks(void);
+
+/*
+ * Returns the monotonic time elapsed in VM, i.e.,
+ * the time between vm_start and vm_stop
+ */
+int64_t cpu_get_clock(void);
+
+void qemu_timer_notify_cb(void *opaque, QEMUClockType type);
+
+#endif /* SYSEMU_CPU_TIMERS_H */
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index 3c1da6a018..149de000a0 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -4,33 +4,23 @@
 #include "qemu/timer.h"
 
 /* cpus.c */
+bool all_cpu_threads_idle(void);
 bool qemu_in_vcpu_thread(void);
 void qemu_init_cpu_loop(void);
 void resume_all_vcpus(void);
 void pause_all_vcpus(void);
 void cpu_stop_current(void);
-void cpu_ticks_init(void);
 
-void configure_icount(QemuOpts *opts, Error **errp);
-extern int use_icount;
 extern int icount_align_option;
 
-/* drift information for info jit command */
-extern int64_t max_delay;
-extern int64_t max_advance;
-void dump_drift_info(void);
-
 /* Unblock cpu */
 void qemu_cpu_kick_self(void);
-void qemu_timer_notify_cb(void *opaque, QEMUClockType type);
 
 void cpu_synchronize_all_states(void);
 void cpu_synchronize_all_post_reset(void);
 void cpu_synchronize_all_post_init(void);
 void cpu_synchronize_all_pre_loadvm(void);
 
-void qtest_clock_warp(int64_t dest);
-
 #ifndef CONFIG_USER_ONLY
 /* vl.c */
 /* *-user doesn't have configurable SMP topology */
diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index eedd3664f0..4c53537ef3 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -30,4 +30,6 @@ void qtest_server_set_send_handler(void (*send)(void *, const char *),
                                  void *opaque);
 void qtest_server_inproc_recv(void *opaque, const char *buf);
 
+int64_t qtest_get_virtual_clock(void);
+
 #endif
diff --git a/replay/replay.c b/replay/replay.c
index 83ed9e0e24..7e4a1ba78e 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -11,10 +11,10 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "sysemu/cpu-timers.h"
 #include "sysemu/replay.h"
 #include "sysemu/runstate.h"
 #include "replay-internal.h"
-#include "qemu/timer.h"
 #include "qemu/main-loop.h"
 #include "qemu/option.h"
 #include "sysemu/cpus.h"
@@ -345,7 +345,7 @@ void replay_start(void)
         error_reportf_err(replay_blockers->data, "Record/replay: ");
         exit(1);
     }
-    if (!use_icount) {
+    if (!icount_enabled()) {
         error_report("Please enable icount to use record/replay");
         exit(1);
     }
diff --git a/softmmu/cpu-timers.c b/softmmu/cpu-timers.c
new file mode 100644
index 0000000000..6c6c56090f
--- /dev/null
+++ b/softmmu/cpu-timers.c
@@ -0,0 +1,284 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/cutils.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "exec/exec-all.h"
+#include "sysemu/cpus.h"
+#include "sysemu/qtest.h"
+#include "qemu/main-loop.h"
+#include "qemu/option.h"
+#include "qemu/seqlock.h"
+#include "sysemu/replay.h"
+#include "sysemu/runstate.h"
+#include "hw/core/cpu.h"
+#include "sysemu/cpu-timers.h"
+#include "sysemu/cpu-throttle.h"
+#include "timers-state.h"
+
+/* clock and ticks */
+
+static int64_t cpu_get_ticks_locked(void)
+{
+    int64_t ticks = timers_state.cpu_ticks_offset;
+    if (timers_state.cpu_ticks_enabled) {
+        ticks += cpu_get_host_ticks();
+    }
+
+    if (timers_state.cpu_ticks_prev > ticks) {
+        /* Non increasing ticks may happen if the host uses software suspend. */
+        timers_state.cpu_ticks_offset += timers_state.cpu_ticks_prev - ticks;
+        ticks = timers_state.cpu_ticks_prev;
+    }
+
+    timers_state.cpu_ticks_prev = ticks;
+    return ticks;
+}
+
+/*
+ * return the time elapsed in VM between vm_start and vm_stop.  Unless
+ * icount is active, cpu_get_ticks() uses units of the host CPU cycle
+ * counter.
+ */
+int64_t cpu_get_ticks(void)
+{
+    int64_t ticks;
+
+    if (icount_enabled()) {
+        return cpu_get_icount();
+    }
+
+    qemu_spin_lock(&timers_state.vm_clock_lock);
+    ticks = cpu_get_ticks_locked();
+    qemu_spin_unlock(&timers_state.vm_clock_lock);
+    return ticks;
+}
+
+int64_t cpu_get_clock_locked(void)
+{
+    int64_t time;
+
+    time = timers_state.cpu_clock_offset;
+    if (timers_state.cpu_ticks_enabled) {
+        time += get_clock();
+    }
+
+    return time;
+}
+
+/*
+ * Return the monotonic time elapsed in VM, i.e.,
+ * the time between vm_start and vm_stop
+ */
+int64_t cpu_get_clock(void)
+{
+    int64_t ti;
+    unsigned start;
+
+    do {
+        start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
+        ti = cpu_get_clock_locked();
+    } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
+
+    return ti;
+}
+
+/*
+ * enable cpu_get_ticks()
+ * Caller must hold BQL which serves as mutex for vm_clock_seqlock.
+ */
+void cpu_enable_ticks(void)
+{
+    seqlock_write_lock(&timers_state.vm_clock_seqlock,
+                       &timers_state.vm_clock_lock);
+    if (!timers_state.cpu_ticks_enabled) {
+        timers_state.cpu_ticks_offset -= cpu_get_host_ticks();
+        timers_state.cpu_clock_offset -= get_clock();
+        timers_state.cpu_ticks_enabled = 1;
+    }
+    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
+                       &timers_state.vm_clock_lock);
+}
+
+/*
+ * disable cpu_get_ticks() : the clock is stopped. You must not call
+ * cpu_get_ticks() after that.
+ * Caller must hold BQL which serves as mutex for vm_clock_seqlock.
+ */
+void cpu_disable_ticks(void)
+{
+    seqlock_write_lock(&timers_state.vm_clock_seqlock,
+                       &timers_state.vm_clock_lock);
+    if (timers_state.cpu_ticks_enabled) {
+        timers_state.cpu_ticks_offset += cpu_get_host_ticks();
+        timers_state.cpu_clock_offset = cpu_get_clock_locked();
+        timers_state.cpu_ticks_enabled = 0;
+    }
+    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
+                         &timers_state.vm_clock_lock);
+}
+
+static bool icount_state_needed(void *opaque)
+{
+    return icount_enabled();
+}
+
+static bool warp_timer_state_needed(void *opaque)
+{
+    TimersState *s = opaque;
+    return s->icount_warp_timer != NULL;
+}
+
+static bool adjust_timers_state_needed(void *opaque)
+{
+    TimersState *s = opaque;
+    return s->icount_rt_timer != NULL;
+}
+
+static bool shift_state_needed(void *opaque)
+{
+    return icount_enabled() == 2;
+}
+
+/*
+ * Subsection for warp timer migration is optional, because may not be created
+ */
+static const VMStateDescription icount_vmstate_warp_timer = {
+    .name = "timer/icount/warp_timer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = warp_timer_state_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_INT64(vm_clock_warp_start, TimersState),
+        VMSTATE_TIMER_PTR(icount_warp_timer, TimersState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription icount_vmstate_adjust_timers = {
+    .name = "timer/icount/timers",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = adjust_timers_state_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_TIMER_PTR(icount_rt_timer, TimersState),
+        VMSTATE_TIMER_PTR(icount_vm_timer, TimersState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription icount_vmstate_shift = {
+    .name = "timer/icount/shift",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = shift_state_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_INT16(icount_time_shift, TimersState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+/*
+ * This is a subsection for icount migration.
+ */
+static const VMStateDescription icount_vmstate_timers = {
+    .name = "timer/icount",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = icount_state_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_INT64(qemu_icount_bias, TimersState),
+        VMSTATE_INT64(qemu_icount, TimersState),
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &icount_vmstate_warp_timer,
+        &icount_vmstate_adjust_timers,
+        &icount_vmstate_shift,
+        NULL
+    }
+};
+
+static const VMStateDescription vmstate_timers = {
+    .name = "timer",
+    .version_id = 2,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_INT64(cpu_ticks_offset, TimersState),
+        VMSTATE_UNUSED(8),
+        VMSTATE_INT64_V(cpu_clock_offset, TimersState, 2),
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &icount_vmstate_timers,
+        NULL
+    }
+};
+
+static void do_nothing(CPUState *cpu, run_on_cpu_data unused)
+{
+}
+
+void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
+{
+    if (!icount_enabled() || type != QEMU_CLOCK_VIRTUAL) {
+        qemu_notify_event();
+        return;
+    }
+
+    if (qemu_in_vcpu_thread()) {
+        /*
+         * A CPU is currently running; kick it back out to the
+         * tcg_cpu_exec() loop so it will recalculate its
+         * icount deadline immediately.
+         */
+        qemu_cpu_kick(current_cpu);
+    } else if (first_cpu) {
+        /*
+         * qemu_cpu_kick is not enough to kick a halted CPU out of
+         * qemu_tcg_wait_io_event.  async_run_on_cpu, instead,
+         * causes cpu_thread_is_idle to return false.  This way,
+         * handle_icount_deadline can run.
+         * If we have no CPUs at all for some reason, we don't
+         * need to do anything.
+         */
+        async_run_on_cpu(first_cpu, do_nothing, RUN_ON_CPU_NULL);
+    }
+}
+
+TimersState timers_state;
+
+/* initialize timers state and the cpu throttle for convenience */
+void cpu_timers_init(void)
+{
+    seqlock_init(&timers_state.vm_clock_seqlock);
+    qemu_spin_init(&timers_state.vm_clock_lock);
+    vmstate_register(NULL, 0, &vmstate_timers, &timers_state);
+
+    cpu_throttle_init();
+}
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index e3b98065c9..1ec713923f 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -58,11 +58,10 @@
 #include "hw/nmi.h"
 #include "sysemu/replay.h"
 #include "sysemu/runstate.h"
+#include "sysemu/cpu-timers.h"
 #include "hw/boards.h"
 #include "hw/hw.h"
 
-#include "sysemu/cpu-throttle.h"
-
 #ifdef CONFIG_LINUX
 
 #include <sys/prctl.h>
@@ -83,9 +82,6 @@
 
 static QemuMutex qemu_global_mutex;
 
-int64_t max_delay;
-int64_t max_advance;
-
 bool cpu_is_stopped(CPUState *cpu)
 {
     return cpu->stopped || !runstate_is_running();
@@ -116,7 +112,7 @@ static bool cpu_thread_is_idle(CPUState *cpu)
     return true;
 }
 
-static bool all_cpu_threads_idle(void)
+bool all_cpu_threads_idle(void)
 {
     CPUState *cpu;
 
@@ -128,688 +124,9 @@ static bool all_cpu_threads_idle(void)
     return true;
 }
 
-/***********************************************************/
-/* guest cycle counter */
-
-/* Protected by TimersState seqlock */
-
-static bool icount_sleep = true;
-/* Arbitrarily pick 1MIPS as the minimum allowable speed.  */
-#define MAX_ICOUNT_SHIFT 10
-
-typedef struct TimersState {
-    /* Protected by BQL.  */
-    int64_t cpu_ticks_prev;
-    int64_t cpu_ticks_offset;
-
-    /* Protect fields that can be respectively read outside the
-     * BQL, and written from multiple threads.
-     */
-    QemuSeqLock vm_clock_seqlock;
-    QemuSpin vm_clock_lock;
-
-    int16_t cpu_ticks_enabled;
-
-    /* Conversion factor from emulated instructions to virtual clock ticks.  */
-    int16_t icount_time_shift;
-
-    /* Compensate for varying guest execution speed.  */
-    int64_t qemu_icount_bias;
-
-    int64_t vm_clock_warp_start;
-    int64_t cpu_clock_offset;
-
-    /* Only written by TCG thread */
-    int64_t qemu_icount;
-
-    /* for adjusting icount */
-    QEMUTimer *icount_rt_timer;
-    QEMUTimer *icount_vm_timer;
-    QEMUTimer *icount_warp_timer;
-} TimersState;
-
-static TimersState timers_state;
 bool mttcg_enabled;
 
 
-/* The current number of executed instructions is based on what we
- * originally budgeted minus the current state of the decrementing
- * icount counters in extra/u16.low.
- */
-static int64_t cpu_get_icount_executed(CPUState *cpu)
-{
-    return (cpu->icount_budget -
-            (cpu_neg(cpu)->icount_decr.u16.low + cpu->icount_extra));
-}
-
-/*
- * Update the global shared timer_state.qemu_icount to take into
- * account executed instructions. This is done by the TCG vCPU
- * thread so the main-loop can see time has moved forward.
- */
-static void cpu_update_icount_locked(CPUState *cpu)
-{
-    int64_t executed = cpu_get_icount_executed(cpu);
-    cpu->icount_budget -= executed;
-
-    atomic_set_i64(&timers_state.qemu_icount,
-                   timers_state.qemu_icount + executed);
-}
-
-/*
- * Update the global shared timer_state.qemu_icount to take into
- * account executed instructions. This is done by the TCG vCPU
- * thread so the main-loop can see time has moved forward.
- */
-void cpu_update_icount(CPUState *cpu)
-{
-    seqlock_write_lock(&timers_state.vm_clock_seqlock,
-                       &timers_state.vm_clock_lock);
-    cpu_update_icount_locked(cpu);
-    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
-                         &timers_state.vm_clock_lock);
-}
-
-static int64_t cpu_get_icount_raw_locked(void)
-{
-    CPUState *cpu = current_cpu;
-
-    if (cpu && cpu->running) {
-        if (!cpu->can_do_io) {
-            error_report("Bad icount read");
-            exit(1);
-        }
-        /* Take into account what has run */
-        cpu_update_icount_locked(cpu);
-    }
-    /* The read is protected by the seqlock, but needs atomic64 to avoid UB */
-    return atomic_read_i64(&timers_state.qemu_icount);
-}
-
-static int64_t cpu_get_icount_locked(void)
-{
-    int64_t icount = cpu_get_icount_raw_locked();
-    return atomic_read_i64(&timers_state.qemu_icount_bias) +
-        cpu_icount_to_ns(icount);
-}
-
-int64_t cpu_get_icount_raw(void)
-{
-    int64_t icount;
-    unsigned start;
-
-    do {
-        start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
-        icount = cpu_get_icount_raw_locked();
-    } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
-
-    return icount;
-}
-
-/* Return the virtual CPU time, based on the instruction counter.  */
-int64_t cpu_get_icount(void)
-{
-    int64_t icount;
-    unsigned start;
-
-    do {
-        start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
-        icount = cpu_get_icount_locked();
-    } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
-
-    return icount;
-}
-
-int64_t cpu_icount_to_ns(int64_t icount)
-{
-    return icount << atomic_read(&timers_state.icount_time_shift);
-}
-
-static int64_t cpu_get_ticks_locked(void)
-{
-    int64_t ticks = timers_state.cpu_ticks_offset;
-    if (timers_state.cpu_ticks_enabled) {
-        ticks += cpu_get_host_ticks();
-    }
-
-    if (timers_state.cpu_ticks_prev > ticks) {
-        /* Non increasing ticks may happen if the host uses software suspend.  */
-        timers_state.cpu_ticks_offset += timers_state.cpu_ticks_prev - ticks;
-        ticks = timers_state.cpu_ticks_prev;
-    }
-
-    timers_state.cpu_ticks_prev = ticks;
-    return ticks;
-}
-
-/* return the time elapsed in VM between vm_start and vm_stop.  Unless
- * icount is active, cpu_get_ticks() uses units of the host CPU cycle
- * counter.
- */
-int64_t cpu_get_ticks(void)
-{
-    int64_t ticks;
-
-    if (use_icount) {
-        return cpu_get_icount();
-    }
-
-    qemu_spin_lock(&timers_state.vm_clock_lock);
-    ticks = cpu_get_ticks_locked();
-    qemu_spin_unlock(&timers_state.vm_clock_lock);
-    return ticks;
-}
-
-static int64_t cpu_get_clock_locked(void)
-{
-    int64_t time;
-
-    time = timers_state.cpu_clock_offset;
-    if (timers_state.cpu_ticks_enabled) {
-        time += get_clock();
-    }
-
-    return time;
-}
-
-/* Return the monotonic time elapsed in VM, i.e.,
- * the time between vm_start and vm_stop
- */
-int64_t cpu_get_clock(void)
-{
-    int64_t ti;
-    unsigned start;
-
-    do {
-        start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
-        ti = cpu_get_clock_locked();
-    } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
-
-    return ti;
-}
-
-/* enable cpu_get_ticks()
- * Caller must hold BQL which serves as mutex for vm_clock_seqlock.
- */
-void cpu_enable_ticks(void)
-{
-    seqlock_write_lock(&timers_state.vm_clock_seqlock,
-                       &timers_state.vm_clock_lock);
-    if (!timers_state.cpu_ticks_enabled) {
-        timers_state.cpu_ticks_offset -= cpu_get_host_ticks();
-        timers_state.cpu_clock_offset -= get_clock();
-        timers_state.cpu_ticks_enabled = 1;
-    }
-    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
-                       &timers_state.vm_clock_lock);
-}
-
-/* disable cpu_get_ticks() : the clock is stopped. You must not call
- * cpu_get_ticks() after that.
- * Caller must hold BQL which serves as mutex for vm_clock_seqlock.
- */
-void cpu_disable_ticks(void)
-{
-    seqlock_write_lock(&timers_state.vm_clock_seqlock,
-                       &timers_state.vm_clock_lock);
-    if (timers_state.cpu_ticks_enabled) {
-        timers_state.cpu_ticks_offset += cpu_get_host_ticks();
-        timers_state.cpu_clock_offset = cpu_get_clock_locked();
-        timers_state.cpu_ticks_enabled = 0;
-    }
-    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
-                         &timers_state.vm_clock_lock);
-}
-
-/* Correlation between real and virtual time is always going to be
-   fairly approximate, so ignore small variation.
-   When the guest is idle real and virtual time will be aligned in
-   the IO wait loop.  */
-#define ICOUNT_WOBBLE (NANOSECONDS_PER_SECOND / 10)
-
-static void icount_adjust(void)
-{
-    int64_t cur_time;
-    int64_t cur_icount;
-    int64_t delta;
-
-    /* Protected by TimersState mutex.  */
-    static int64_t last_delta;
-
-    /* If the VM is not running, then do nothing.  */
-    if (!runstate_is_running()) {
-        return;
-    }
-
-    seqlock_write_lock(&timers_state.vm_clock_seqlock,
-                       &timers_state.vm_clock_lock);
-    cur_time = REPLAY_CLOCK_LOCKED(REPLAY_CLOCK_VIRTUAL_RT,
-                                   cpu_get_clock_locked());
-    cur_icount = cpu_get_icount_locked();
-
-    delta = cur_icount - cur_time;
-    /* FIXME: This is a very crude algorithm, somewhat prone to oscillation.  */
-    if (delta > 0
-        && last_delta + ICOUNT_WOBBLE < delta * 2
-        && timers_state.icount_time_shift > 0) {
-        /* The guest is getting too far ahead.  Slow time down.  */
-        atomic_set(&timers_state.icount_time_shift,
-                   timers_state.icount_time_shift - 1);
-    }
-    if (delta < 0
-        && last_delta - ICOUNT_WOBBLE > delta * 2
-        && timers_state.icount_time_shift < MAX_ICOUNT_SHIFT) {
-        /* The guest is getting too far behind.  Speed time up.  */
-        atomic_set(&timers_state.icount_time_shift,
-                   timers_state.icount_time_shift + 1);
-    }
-    last_delta = delta;
-    atomic_set_i64(&timers_state.qemu_icount_bias,
-                   cur_icount - (timers_state.qemu_icount
-                                 << timers_state.icount_time_shift));
-    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
-                         &timers_state.vm_clock_lock);
-}
-
-static void icount_adjust_rt(void *opaque)
-{
-    timer_mod(timers_state.icount_rt_timer,
-              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) + 1000);
-    icount_adjust();
-}
-
-static void icount_adjust_vm(void *opaque)
-{
-    timer_mod(timers_state.icount_vm_timer,
-                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-                   NANOSECONDS_PER_SECOND / 10);
-    icount_adjust();
-}
-
-static int64_t qemu_icount_round(int64_t count)
-{
-    int shift = atomic_read(&timers_state.icount_time_shift);
-    return (count + (1 << shift) - 1) >> shift;
-}
-
-static void icount_warp_rt(void)
-{
-    unsigned seq;
-    int64_t warp_start;
-
-    /* The icount_warp_timer is rescheduled soon after vm_clock_warp_start
-     * changes from -1 to another value, so the race here is okay.
-     */
-    do {
-        seq = seqlock_read_begin(&timers_state.vm_clock_seqlock);
-        warp_start = timers_state.vm_clock_warp_start;
-    } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, seq));
-
-    if (warp_start == -1) {
-        return;
-    }
-
-    seqlock_write_lock(&timers_state.vm_clock_seqlock,
-                       &timers_state.vm_clock_lock);
-    if (runstate_is_running()) {
-        int64_t clock = REPLAY_CLOCK_LOCKED(REPLAY_CLOCK_VIRTUAL_RT,
-                                            cpu_get_clock_locked());
-        int64_t warp_delta;
-
-        warp_delta = clock - timers_state.vm_clock_warp_start;
-        if (use_icount == 2) {
-            /*
-             * In adaptive mode, do not let QEMU_CLOCK_VIRTUAL run too
-             * far ahead of real time.
-             */
-            int64_t cur_icount = cpu_get_icount_locked();
-            int64_t delta = clock - cur_icount;
-            warp_delta = MIN(warp_delta, delta);
-        }
-        atomic_set_i64(&timers_state.qemu_icount_bias,
-                       timers_state.qemu_icount_bias + warp_delta);
-    }
-    timers_state.vm_clock_warp_start = -1;
-    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
-                       &timers_state.vm_clock_lock);
-
-    if (qemu_clock_expired(QEMU_CLOCK_VIRTUAL)) {
-        qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
-    }
-}
-
-static void icount_timer_cb(void *opaque)
-{
-    /* No need for a checkpoint because the timer already synchronizes
-     * with CHECKPOINT_CLOCK_VIRTUAL_RT.
-     */
-    icount_warp_rt();
-}
-
-void qtest_clock_warp(int64_t dest)
-{
-    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    AioContext *aio_context;
-    assert(qtest_enabled());
-    aio_context = qemu_get_aio_context();
-    while (clock < dest) {
-        int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
-                                                      QEMU_TIMER_ATTR_ALL);
-        int64_t warp = qemu_soonest_timeout(dest - clock, deadline);
-
-        seqlock_write_lock(&timers_state.vm_clock_seqlock,
-                           &timers_state.vm_clock_lock);
-        atomic_set_i64(&timers_state.qemu_icount_bias,
-                       timers_state.qemu_icount_bias + warp);
-        seqlock_write_unlock(&timers_state.vm_clock_seqlock,
-                             &timers_state.vm_clock_lock);
-
-        qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
-        timerlist_run_timers(aio_context->tlg.tl[QEMU_CLOCK_VIRTUAL]);
-        clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    }
-    qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
-}
-
-void qemu_start_warp_timer(void)
-{
-    int64_t clock;
-    int64_t deadline;
-
-    if (!use_icount) {
-        return;
-    }
-
-    /* Nothing to do if the VM is stopped: QEMU_CLOCK_VIRTUAL timers
-     * do not fire, so computing the deadline does not make sense.
-     */
-    if (!runstate_is_running()) {
-        return;
-    }
-
-    if (replay_mode != REPLAY_MODE_PLAY) {
-        if (!all_cpu_threads_idle()) {
-            return;
-        }
-
-        if (qtest_enabled()) {
-            /* When testing, qtest commands advance icount.  */
-            return;
-        }
-
-        replay_checkpoint(CHECKPOINT_CLOCK_WARP_START);
-    } else {
-        /* warp clock deterministically in record/replay mode */
-        if (!replay_checkpoint(CHECKPOINT_CLOCK_WARP_START)) {
-            /* vCPU is sleeping and warp can't be started.
-               It is probably a race condition: notification sent
-               to vCPU was processed in advance and vCPU went to sleep.
-               Therefore we have to wake it up for doing someting. */
-            if (replay_has_checkpoint()) {
-                qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
-            }
-            return;
-        }
-    }
-
-    /* We want to use the earliest deadline from ALL vm_clocks */
-    clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT);
-    deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
-                                          ~QEMU_TIMER_ATTR_EXTERNAL);
-    if (deadline < 0) {
-        static bool notified;
-        if (!icount_sleep && !notified) {
-            warn_report("icount sleep disabled and no active timers");
-            notified = true;
-        }
-        return;
-    }
-
-    if (deadline > 0) {
-        /*
-         * Ensure QEMU_CLOCK_VIRTUAL proceeds even when the virtual CPU goes to
-         * sleep.  Otherwise, the CPU might be waiting for a future timer
-         * interrupt to wake it up, but the interrupt never comes because
-         * the vCPU isn't running any insns and thus doesn't advance the
-         * QEMU_CLOCK_VIRTUAL.
-         */
-        if (!icount_sleep) {
-            /*
-             * We never let VCPUs sleep in no sleep icount mode.
-             * If there is a pending QEMU_CLOCK_VIRTUAL timer we just advance
-             * to the next QEMU_CLOCK_VIRTUAL event and notify it.
-             * It is useful when we want a deterministic execution time,
-             * isolated from host latencies.
-             */
-            seqlock_write_lock(&timers_state.vm_clock_seqlock,
-                               &timers_state.vm_clock_lock);
-            atomic_set_i64(&timers_state.qemu_icount_bias,
-                           timers_state.qemu_icount_bias + deadline);
-            seqlock_write_unlock(&timers_state.vm_clock_seqlock,
-                                 &timers_state.vm_clock_lock);
-            qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
-        } else {
-            /*
-             * We do stop VCPUs and only advance QEMU_CLOCK_VIRTUAL after some
-             * "real" time, (related to the time left until the next event) has
-             * passed. The QEMU_CLOCK_VIRTUAL_RT clock will do this.
-             * This avoids that the warps are visible externally; for example,
-             * you will not be sending network packets continuously instead of
-             * every 100ms.
-             */
-            seqlock_write_lock(&timers_state.vm_clock_seqlock,
-                               &timers_state.vm_clock_lock);
-            if (timers_state.vm_clock_warp_start == -1
-                || timers_state.vm_clock_warp_start > clock) {
-                timers_state.vm_clock_warp_start = clock;
-            }
-            seqlock_write_unlock(&timers_state.vm_clock_seqlock,
-                                 &timers_state.vm_clock_lock);
-            timer_mod_anticipate(timers_state.icount_warp_timer,
-                                 clock + deadline);
-        }
-    } else if (deadline == 0) {
-        qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
-    }
-}
-
-static void qemu_account_warp_timer(void)
-{
-    if (!use_icount || !icount_sleep) {
-        return;
-    }
-
-    /* Nothing to do if the VM is stopped: QEMU_CLOCK_VIRTUAL timers
-     * do not fire, so computing the deadline does not make sense.
-     */
-    if (!runstate_is_running()) {
-        return;
-    }
-
-    /* warp clock deterministically in record/replay mode */
-    if (!replay_checkpoint(CHECKPOINT_CLOCK_WARP_ACCOUNT)) {
-        return;
-    }
-
-    timer_del(timers_state.icount_warp_timer);
-    icount_warp_rt();
-}
-
-static bool icount_state_needed(void *opaque)
-{
-    return use_icount;
-}
-
-static bool warp_timer_state_needed(void *opaque)
-{
-    TimersState *s = opaque;
-    return s->icount_warp_timer != NULL;
-}
-
-static bool adjust_timers_state_needed(void *opaque)
-{
-    TimersState *s = opaque;
-    return s->icount_rt_timer != NULL;
-}
-
-static bool shift_state_needed(void *opaque)
-{
-    return use_icount == 2;
-}
-
-/*
- * Subsection for warp timer migration is optional, because may not be created
- */
-static const VMStateDescription icount_vmstate_warp_timer = {
-    .name = "timer/icount/warp_timer",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .needed = warp_timer_state_needed,
-    .fields = (VMStateField[]) {
-        VMSTATE_INT64(vm_clock_warp_start, TimersState),
-        VMSTATE_TIMER_PTR(icount_warp_timer, TimersState),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static const VMStateDescription icount_vmstate_adjust_timers = {
-    .name = "timer/icount/timers",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .needed = adjust_timers_state_needed,
-    .fields = (VMStateField[]) {
-        VMSTATE_TIMER_PTR(icount_rt_timer, TimersState),
-        VMSTATE_TIMER_PTR(icount_vm_timer, TimersState),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static const VMStateDescription icount_vmstate_shift = {
-    .name = "timer/icount/shift",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .needed = shift_state_needed,
-    .fields = (VMStateField[]) {
-        VMSTATE_INT16(icount_time_shift, TimersState),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-/*
- * This is a subsection for icount migration.
- */
-static const VMStateDescription icount_vmstate_timers = {
-    .name = "timer/icount",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .needed = icount_state_needed,
-    .fields = (VMStateField[]) {
-        VMSTATE_INT64(qemu_icount_bias, TimersState),
-        VMSTATE_INT64(qemu_icount, TimersState),
-        VMSTATE_END_OF_LIST()
-    },
-    .subsections = (const VMStateDescription*[]) {
-        &icount_vmstate_warp_timer,
-        &icount_vmstate_adjust_timers,
-        &icount_vmstate_shift,
-        NULL
-    }
-};
-
-static const VMStateDescription vmstate_timers = {
-    .name = "timer",
-    .version_id = 2,
-    .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
-        VMSTATE_INT64(cpu_ticks_offset, TimersState),
-        VMSTATE_UNUSED(8),
-        VMSTATE_INT64_V(cpu_clock_offset, TimersState, 2),
-        VMSTATE_END_OF_LIST()
-    },
-    .subsections = (const VMStateDescription*[]) {
-        &icount_vmstate_timers,
-        NULL
-    }
-};
-
-void cpu_ticks_init(void)
-{
-    seqlock_init(&timers_state.vm_clock_seqlock);
-    qemu_spin_init(&timers_state.vm_clock_lock);
-    vmstate_register(NULL, 0, &vmstate_timers, &timers_state);
-    cpu_throttle_init();
-}
-
-void configure_icount(QemuOpts *opts, Error **errp)
-{
-    const char *option = qemu_opt_get(opts, "shift");
-    bool sleep = qemu_opt_get_bool(opts, "sleep", true);
-    bool align = qemu_opt_get_bool(opts, "align", false);
-    long time_shift = -1;
-
-    if (!option) {
-        if (qemu_opt_get(opts, "align") != NULL) {
-            error_setg(errp, "Please specify shift option when using align");
-        }
-        return;
-    }
-
-    if (align && !sleep) {
-        error_setg(errp, "align=on and sleep=off are incompatible");
-        return;
-    }
-
-    if (strcmp(option, "auto") != 0) {
-        if (qemu_strtol(option, NULL, 0, &time_shift) < 0
-            || time_shift < 0 || time_shift > MAX_ICOUNT_SHIFT) {
-            error_setg(errp, "icount: Invalid shift value");
-            return;
-        }
-    } else if (icount_align_option) {
-        error_setg(errp, "shift=auto and align=on are incompatible");
-        return;
-    } else if (!icount_sleep) {
-        error_setg(errp, "shift=auto and sleep=off are incompatible");
-        return;
-    }
-
-    icount_sleep = sleep;
-    if (icount_sleep) {
-        timers_state.icount_warp_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
-                                         icount_timer_cb, NULL);
-    }
-
-    icount_align_option = align;
-
-    if (time_shift >= 0) {
-        timers_state.icount_time_shift = time_shift;
-        use_icount = 1;
-        return;
-    }
-
-    use_icount = 2;
-
-    /* 125MIPS seems a reasonable initial guess at the guest speed.
-       It will be corrected fairly quickly anyway.  */
-    timers_state.icount_time_shift = 3;
-
-    /* Have both realtime and virtual time triggers for speed adjustment.
-       The realtime trigger catches emulated time passing too slowly,
-       the virtual time trigger catches emulated time passing too fast.
-       Realtime triggers occur even when idle, so use them less frequently
-       than VM triggers.  */
-    timers_state.vm_clock_warp_start = -1;
-    timers_state.icount_rt_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL_RT,
-                                   icount_adjust_rt, NULL);
-    timer_mod(timers_state.icount_rt_timer,
-                   qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) + 1000);
-    timers_state.icount_vm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                        icount_adjust_vm, NULL);
-    timer_mod(timers_state.icount_vm_timer,
-                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-                   NANOSECONDS_PER_SECOND / 10);
-}
-
 /***********************************************************/
 /* TCG vCPU kick timer
  *
@@ -854,35 +171,6 @@ static void qemu_cpu_kick_rr_cpus(void)
     };
 }
 
-static void do_nothing(CPUState *cpu, run_on_cpu_data unused)
-{
-}
-
-void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
-{
-    if (!use_icount || type != QEMU_CLOCK_VIRTUAL) {
-        qemu_notify_event();
-        return;
-    }
-
-    if (qemu_in_vcpu_thread()) {
-        /* A CPU is currently running; kick it back out to the
-         * tcg_cpu_exec() loop so it will recalculate its
-         * icount deadline immediately.
-         */
-        qemu_cpu_kick(current_cpu);
-    } else if (first_cpu) {
-        /* qemu_cpu_kick is not enough to kick a halted CPU out of
-         * qemu_tcg_wait_io_event.  async_run_on_cpu, instead,
-         * causes cpu_thread_is_idle to return false.  This way,
-         * handle_icount_deadline can run.
-         * If we have no CPUs at all for some reason, we don't
-         * need to do anything.
-         */
-        async_run_on_cpu(first_cpu, do_nothing, RUN_ON_CPU_NULL);
-    }
-}
-
 static void kick_tcg_thread(void *opaque)
 {
     timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
@@ -1288,7 +576,7 @@ static void notify_aio_contexts(void)
 static void handle_icount_deadline(void)
 {
     assert(qemu_in_vcpu_thread());
-    if (use_icount) {
+    if (icount_enabled()) {
         int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
                                                       QEMU_TIMER_ATTR_ALL);
 
@@ -1300,7 +588,7 @@ static void handle_icount_deadline(void)
 
 static void prepare_icount_for_run(CPUState *cpu)
 {
-    if (use_icount) {
+    if (icount_enabled()) {
         int insns_left;
 
         /* These should always be cleared by process_icount_data after
@@ -1325,7 +613,7 @@ static void prepare_icount_for_run(CPUState *cpu)
 
 static void process_icount_data(CPUState *cpu)
 {
-    if (use_icount) {
+    if (icount_enabled()) {
         /* Account for executed instructions */
         cpu_update_icount(cpu);
 
@@ -1486,7 +774,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             atomic_mb_set(&cpu->exit_request, 0);
         }
 
-        if (use_icount && all_cpu_threads_idle()) {
+        if (icount_enabled() && all_cpu_threads_idle()) {
             /*
              * When all cpus are sleeping (e.g in WFI), to avoid a deadlock
              * in the main_loop, wake it up in order to start the warp timer.
@@ -1639,7 +927,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
     CPUState *cpu = arg;
 
     assert(tcg_enabled());
-    g_assert(!use_icount);
+    g_assert(!icount_enabled());
 
     rcu_register_thread();
     tcg_register_thread();
@@ -2227,21 +1515,3 @@ void qmp_inject_nmi(Error **errp)
     nmi_monitor_handle(monitor_get_cpu_index(), errp);
 }
 
-void dump_drift_info(void)
-{
-    if (!use_icount) {
-        return;
-    }
-
-    qemu_printf("Host - Guest clock  %"PRIi64" ms\n",
-                (cpu_get_clock() - cpu_get_icount())/SCALE_MS);
-    if (icount_align_option) {
-        qemu_printf("Max guest delay     %"PRIi64" ms\n",
-                    -max_delay / SCALE_MS);
-        qemu_printf("Max guest advance   %"PRIi64" ms\n",
-                    max_advance / SCALE_MS);
-    } else {
-        qemu_printf("Max guest delay     NA\n");
-        qemu_printf("Max guest advance   NA\n");
-    }
-}
diff --git a/softmmu/icount.c b/softmmu/icount.c
new file mode 100644
index 0000000000..4e26bf445d
--- /dev/null
+++ b/softmmu/icount.c
@@ -0,0 +1,492 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/cutils.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "exec/exec-all.h"
+#include "sysemu/cpus.h"
+#include "sysemu/qtest.h"
+#include "qemu/main-loop.h"
+#include "qemu/option.h"
+#include "qemu/seqlock.h"
+#include "sysemu/replay.h"
+#include "sysemu/runstate.h"
+#include "hw/core/cpu.h"
+#include "sysemu/cpu-timers.h"
+#include "sysemu/cpu-throttle.h"
+#include "timers-state.h"
+
+/*
+ * ICOUNT: Instruction Counter
+ *
+ * this module is split off from cpu-timers because the icount part
+ * is TCG-specific, and does not need to be built for other accels.
+ */
+static bool icount_sleep = true;
+/* Arbitrarily pick 1MIPS as the minimum allowable speed.  */
+#define MAX_ICOUNT_SHIFT 10
+
+/*
+ * 0 = Do not count executed instructions.
+ * 1 = Fixed conversion of insn to ns via "shift" option
+ * 2 = Runtime adaptive algorithm to compute shift
+ */
+int use_icount;
+
+static void icount_enable_precise(void)
+{
+    use_icount = 1;
+}
+
+static void icount_enable_adaptive(void)
+{
+    use_icount = 2;
+}
+
+/*
+ * The current number of executed instructions is based on what we
+ * originally budgeted minus the current state of the decrementing
+ * icount counters in extra/u16.low.
+ */
+static int64_t cpu_get_icount_executed(CPUState *cpu)
+{
+    return (cpu->icount_budget -
+            (cpu_neg(cpu)->icount_decr.u16.low + cpu->icount_extra));
+}
+
+/*
+ * Update the global shared timer_state.qemu_icount to take into
+ * account executed instructions. This is done by the TCG vCPU
+ * thread so the main-loop can see time has moved forward.
+ */
+static void cpu_update_icount_locked(CPUState *cpu)
+{
+    int64_t executed = cpu_get_icount_executed(cpu);
+    cpu->icount_budget -= executed;
+
+    atomic_set_i64(&timers_state.qemu_icount,
+                   timers_state.qemu_icount + executed);
+}
+
+/*
+ * Update the global shared timer_state.qemu_icount to take into
+ * account executed instructions. This is done by the TCG vCPU
+ * thread so the main-loop can see time has moved forward.
+ */
+void cpu_update_icount(CPUState *cpu)
+{
+    seqlock_write_lock(&timers_state.vm_clock_seqlock,
+                       &timers_state.vm_clock_lock);
+    cpu_update_icount_locked(cpu);
+    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
+                         &timers_state.vm_clock_lock);
+}
+
+static int64_t cpu_get_icount_raw_locked(void)
+{
+    CPUState *cpu = current_cpu;
+
+    if (cpu && cpu->running) {
+        if (!cpu->can_do_io) {
+            error_report("Bad icount read");
+            exit(1);
+        }
+        /* Take into account what has run */
+        cpu_update_icount_locked(cpu);
+    }
+    /* The read is protected by the seqlock, but needs atomic64 to avoid UB */
+    return atomic_read_i64(&timers_state.qemu_icount);
+}
+
+static int64_t cpu_get_icount_locked(void)
+{
+    int64_t icount = cpu_get_icount_raw_locked();
+    return atomic_read_i64(&timers_state.qemu_icount_bias) +
+        cpu_icount_to_ns(icount);
+}
+
+int64_t cpu_get_icount_raw(void)
+{
+    int64_t icount;
+    unsigned start;
+
+    do {
+        start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
+        icount = cpu_get_icount_raw_locked();
+    } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
+
+    return icount;
+}
+
+/* Return the virtual CPU time, based on the instruction counter.  */
+int64_t cpu_get_icount(void)
+{
+    int64_t icount;
+    unsigned start;
+
+    do {
+        start = seqlock_read_begin(&timers_state.vm_clock_seqlock);
+        icount = cpu_get_icount_locked();
+    } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, start));
+
+    return icount;
+}
+
+int64_t cpu_icount_to_ns(int64_t icount)
+{
+    return icount << atomic_read(&timers_state.icount_time_shift);
+}
+
+/*
+ * Correlation between real and virtual time is always going to be
+ * fairly approximate, so ignore small variation.
+ * When the guest is idle real and virtual time will be aligned in
+ * the IO wait loop.
+ */
+#define ICOUNT_WOBBLE (NANOSECONDS_PER_SECOND / 10)
+
+static void icount_adjust(void)
+{
+    int64_t cur_time;
+    int64_t cur_icount;
+    int64_t delta;
+
+    /* Protected by TimersState mutex.  */
+    static int64_t last_delta;
+
+    /* If the VM is not running, then do nothing.  */
+    if (!runstate_is_running()) {
+        return;
+    }
+
+    seqlock_write_lock(&timers_state.vm_clock_seqlock,
+                       &timers_state.vm_clock_lock);
+    cur_time = REPLAY_CLOCK_LOCKED(REPLAY_CLOCK_VIRTUAL_RT,
+                                   cpu_get_clock_locked());
+    cur_icount = cpu_get_icount_locked();
+
+    delta = cur_icount - cur_time;
+    /* FIXME: This is a very crude algorithm, somewhat prone to oscillation.  */
+    if (delta > 0
+        && last_delta + ICOUNT_WOBBLE < delta * 2
+        && timers_state.icount_time_shift > 0) {
+        /* The guest is getting too far ahead.  Slow time down.  */
+        atomic_set(&timers_state.icount_time_shift,
+                   timers_state.icount_time_shift - 1);
+    }
+    if (delta < 0
+        && last_delta - ICOUNT_WOBBLE > delta * 2
+        && timers_state.icount_time_shift < MAX_ICOUNT_SHIFT) {
+        /* The guest is getting too far behind.  Speed time up.  */
+        atomic_set(&timers_state.icount_time_shift,
+                   timers_state.icount_time_shift + 1);
+    }
+    last_delta = delta;
+    atomic_set_i64(&timers_state.qemu_icount_bias,
+                   cur_icount - (timers_state.qemu_icount
+                                 << timers_state.icount_time_shift));
+    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
+                         &timers_state.vm_clock_lock);
+}
+
+static void icount_adjust_rt(void *opaque)
+{
+    timer_mod(timers_state.icount_rt_timer,
+              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) + 1000);
+    icount_adjust();
+}
+
+static void icount_adjust_vm(void *opaque)
+{
+    timer_mod(timers_state.icount_vm_timer,
+                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                   NANOSECONDS_PER_SECOND / 10);
+    icount_adjust();
+}
+
+int64_t qemu_icount_round(int64_t count)
+{
+    int shift = atomic_read(&timers_state.icount_time_shift);
+    return (count + (1 << shift) - 1) >> shift;
+}
+
+static void icount_warp_rt(void)
+{
+    unsigned seq;
+    int64_t warp_start;
+
+    /*
+     * The icount_warp_timer is rescheduled soon after vm_clock_warp_start
+     * changes from -1 to another value, so the race here is okay.
+     */
+    do {
+        seq = seqlock_read_begin(&timers_state.vm_clock_seqlock);
+        warp_start = timers_state.vm_clock_warp_start;
+    } while (seqlock_read_retry(&timers_state.vm_clock_seqlock, seq));
+
+    if (warp_start == -1) {
+        return;
+    }
+
+    seqlock_write_lock(&timers_state.vm_clock_seqlock,
+                       &timers_state.vm_clock_lock);
+    if (runstate_is_running()) {
+        int64_t clock = REPLAY_CLOCK_LOCKED(REPLAY_CLOCK_VIRTUAL_RT,
+                                            cpu_get_clock_locked());
+        int64_t warp_delta;
+
+        warp_delta = clock - timers_state.vm_clock_warp_start;
+        if (icount_enabled() == 2) {
+            /*
+             * In adaptive mode, do not let QEMU_CLOCK_VIRTUAL run too
+             * far ahead of real time.
+             */
+            int64_t cur_icount = cpu_get_icount_locked();
+            int64_t delta = clock - cur_icount;
+            warp_delta = MIN(warp_delta, delta);
+        }
+        atomic_set_i64(&timers_state.qemu_icount_bias,
+                       timers_state.qemu_icount_bias + warp_delta);
+    }
+    timers_state.vm_clock_warp_start = -1;
+    seqlock_write_unlock(&timers_state.vm_clock_seqlock,
+                       &timers_state.vm_clock_lock);
+
+    if (qemu_clock_expired(QEMU_CLOCK_VIRTUAL)) {
+        qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
+    }
+}
+
+static void icount_timer_cb(void *opaque)
+{
+    /*
+     * No need for a checkpoint because the timer already synchronizes
+     * with CHECKPOINT_CLOCK_VIRTUAL_RT.
+     */
+    icount_warp_rt();
+}
+
+void qemu_start_warp_timer(void)
+{
+    int64_t clock;
+    int64_t deadline;
+
+    assert(icount_enabled());
+
+    /*
+     * Nothing to do if the VM is stopped: QEMU_CLOCK_VIRTUAL timers
+     * do not fire, so computing the deadline does not make sense.
+     */
+    if (!runstate_is_running()) {
+        return;
+    }
+
+    if (replay_mode != REPLAY_MODE_PLAY) {
+        if (!all_cpu_threads_idle()) {
+            return;
+        }
+
+        if (qtest_enabled()) {
+            /* When testing, qtest commands advance icount.  */
+            return;
+        }
+
+        replay_checkpoint(CHECKPOINT_CLOCK_WARP_START);
+    } else {
+        /* warp clock deterministically in record/replay mode */
+        if (!replay_checkpoint(CHECKPOINT_CLOCK_WARP_START)) {
+            /*
+             * vCPU is sleeping and warp can't be started.
+             * It is probably a race condition: notification sent
+             * to vCPU was processed in advance and vCPU went to sleep.
+             * Therefore we have to wake it up for doing someting.
+             */
+            if (replay_has_checkpoint()) {
+                qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
+            }
+            return;
+        }
+    }
+
+    /* We want to use the earliest deadline from ALL vm_clocks */
+    clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT);
+    deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
+                                          ~QEMU_TIMER_ATTR_EXTERNAL);
+    if (deadline < 0) {
+        static bool notified;
+        if (!icount_sleep && !notified) {
+            warn_report("icount sleep disabled and no active timers");
+            notified = true;
+        }
+        return;
+    }
+
+    if (deadline > 0) {
+        /*
+         * Ensure QEMU_CLOCK_VIRTUAL proceeds even when the virtual CPU goes to
+         * sleep.  Otherwise, the CPU might be waiting for a future timer
+         * interrupt to wake it up, but the interrupt never comes because
+         * the vCPU isn't running any insns and thus doesn't advance the
+         * QEMU_CLOCK_VIRTUAL.
+         */
+        if (!icount_sleep) {
+            /*
+             * We never let VCPUs sleep in no sleep icount mode.
+             * If there is a pending QEMU_CLOCK_VIRTUAL timer we just advance
+             * to the next QEMU_CLOCK_VIRTUAL event and notify it.
+             * It is useful when we want a deterministic execution time,
+             * isolated from host latencies.
+             */
+            seqlock_write_lock(&timers_state.vm_clock_seqlock,
+                               &timers_state.vm_clock_lock);
+            atomic_set_i64(&timers_state.qemu_icount_bias,
+                           timers_state.qemu_icount_bias + deadline);
+            seqlock_write_unlock(&timers_state.vm_clock_seqlock,
+                                 &timers_state.vm_clock_lock);
+            qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
+        } else {
+            /*
+             * We do stop VCPUs and only advance QEMU_CLOCK_VIRTUAL after some
+             * "real" time, (related to the time left until the next event) has
+             * passed. The QEMU_CLOCK_VIRTUAL_RT clock will do this.
+             * This avoids that the warps are visible externally; for example,
+             * you will not be sending network packets continuously instead of
+             * every 100ms.
+             */
+            seqlock_write_lock(&timers_state.vm_clock_seqlock,
+                               &timers_state.vm_clock_lock);
+            if (timers_state.vm_clock_warp_start == -1
+                || timers_state.vm_clock_warp_start > clock) {
+                timers_state.vm_clock_warp_start = clock;
+            }
+            seqlock_write_unlock(&timers_state.vm_clock_seqlock,
+                                 &timers_state.vm_clock_lock);
+            timer_mod_anticipate(timers_state.icount_warp_timer,
+                                 clock + deadline);
+        }
+    } else if (deadline == 0) {
+        qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
+    }
+}
+
+void qemu_account_warp_timer(void)
+{
+    if (!icount_enabled() || !icount_sleep) {
+        return;
+    }
+
+    /*
+     * Nothing to do if the VM is stopped: QEMU_CLOCK_VIRTUAL timers
+     * do not fire, so computing the deadline does not make sense.
+     */
+    if (!runstate_is_running()) {
+        return;
+    }
+
+    /* warp clock deterministically in record/replay mode */
+    if (!replay_checkpoint(CHECKPOINT_CLOCK_WARP_ACCOUNT)) {
+        return;
+    }
+
+    timer_del(timers_state.icount_warp_timer);
+    icount_warp_rt();
+}
+
+void configure_icount(QemuOpts *opts, Error **errp)
+{
+    const char *option = qemu_opt_get(opts, "shift");
+    bool sleep = qemu_opt_get_bool(opts, "sleep", true);
+    bool align = qemu_opt_get_bool(opts, "align", false);
+    long time_shift = -1;
+
+    if (!option) {
+        if (qemu_opt_get(opts, "align") != NULL) {
+            error_setg(errp, "Please specify shift option when using align");
+        }
+        return;
+    }
+
+    if (align && !sleep) {
+        error_setg(errp, "align=on and sleep=off are incompatible");
+        return;
+    }
+
+    if (strcmp(option, "auto") != 0) {
+        if (qemu_strtol(option, NULL, 0, &time_shift) < 0
+            || time_shift < 0 || time_shift > MAX_ICOUNT_SHIFT) {
+            error_setg(errp, "icount: Invalid shift value");
+            return;
+        }
+    } else if (icount_align_option) {
+        error_setg(errp, "shift=auto and align=on are incompatible");
+        return;
+    } else if (!icount_sleep) {
+        error_setg(errp, "shift=auto and sleep=off are incompatible");
+        return;
+    }
+
+    icount_sleep = sleep;
+    if (icount_sleep) {
+        timers_state.icount_warp_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
+                                         icount_timer_cb, NULL);
+    }
+
+    icount_align_option = align;
+
+    if (time_shift >= 0) {
+        timers_state.icount_time_shift = time_shift;
+        icount_enable_precise();
+        return;
+    }
+
+    icount_enable_adaptive();
+
+    /*
+     * 125MIPS seems a reasonable initial guess at the guest speed.
+     * It will be corrected fairly quickly anyway.
+     */
+    timers_state.icount_time_shift = 3;
+
+    /*
+     * Have both realtime and virtual time triggers for speed adjustment.
+     * The realtime trigger catches emulated time passing too slowly,
+     * the virtual time trigger catches emulated time passing too fast.
+     * Realtime triggers occur even when idle, so use them less frequently
+     * than VM triggers.
+     */
+    timers_state.vm_clock_warp_start = -1;
+    timers_state.icount_rt_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL_RT,
+                                   icount_adjust_rt, NULL);
+    timer_mod(timers_state.icount_rt_timer,
+                   qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) + 1000);
+    timers_state.icount_vm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                        icount_adjust_vm, NULL);
+    timer_mod(timers_state.icount_vm_timer,
+                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                   NANOSECONDS_PER_SECOND / 10);
+}
diff --git a/softmmu/meson.build b/softmmu/meson.build
index 95d38df259..36c96e7b15 100644
--- a/softmmu/meson.build
+++ b/softmmu/meson.build
@@ -1,4 +1,4 @@
-specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files(
+specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: [files(
   'arch_init.c',
   'balloon.c',
   'cpus.c',
@@ -7,4 +7,10 @@ specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files(
   'memory.c',
   'memory_mapping.c',
   'qtest.c',
-  'vl.c'))
+  'vl.c',
+  'cpu-timers.c',
+)])
+
+specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_TCG'], if_true: [files(
+  'icount.c'
+)])
diff --git a/softmmu/qtest.c b/softmmu/qtest.c
index 4e439caec7..8f70658481 100644
--- a/softmmu/qtest.c
+++ b/softmmu/qtest.c
@@ -21,7 +21,7 @@
 #include "exec/memory.h"
 #include "hw/irq.h"
 #include "sysemu/accel.h"
-#include "sysemu/cpus.h"
+#include "sysemu/cpu-timers.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/error-report.h"
@@ -273,6 +273,38 @@ static void qtest_irq_handler(void *opaque, int n, int level)
     }
 }
 
+static int64_t qtest_clock_counter;
+
+int64_t qtest_get_virtual_clock(void)
+{
+    return atomic_read_i64(&qtest_clock_counter);
+}
+
+static void qtest_set_virtual_clock(int64_t count)
+{
+    atomic_set_i64(&qtest_clock_counter, count);
+}
+
+static void qtest_clock_warp(int64_t dest)
+{
+    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    AioContext *aio_context;
+    assert(qtest_enabled());
+    aio_context = qemu_get_aio_context();
+    while (clock < dest) {
+        int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
+                                                      QEMU_TIMER_ATTR_ALL);
+        int64_t warp = qemu_soonest_timeout(dest - clock, deadline);
+
+        qtest_set_virtual_clock(qtest_get_virtual_clock() + warp);
+
+        qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
+        timerlist_run_timers(aio_context->tlg.tl[QEMU_CLOCK_VIRTUAL]);
+        clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    }
+    qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
+}
+
 static void qtest_process_command(CharBackend *chr, gchar **words)
 {
     const gchar *command;
diff --git a/softmmu/timers-state.h b/softmmu/timers-state.h
new file mode 100644
index 0000000000..db4e60f18f
--- /dev/null
+++ b/softmmu/timers-state.h
@@ -0,0 +1,69 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef TIMERS_STATE_H
+#define TIMERS_STATE_H
+
+/* timers state, for sharing between icount and cpu-timers */
+
+typedef struct TimersState {
+    /* Protected by BQL.  */
+    int64_t cpu_ticks_prev;
+    int64_t cpu_ticks_offset;
+
+    /*
+     * Protect fields that can be respectively read outside the
+     * BQL, and written from multiple threads.
+     */
+    QemuSeqLock vm_clock_seqlock;
+    QemuSpin vm_clock_lock;
+
+    int16_t cpu_ticks_enabled;
+
+    /* Conversion factor from emulated instructions to virtual clock ticks.  */
+    int16_t icount_time_shift;
+
+    /* Compensate for varying guest execution speed.  */
+    int64_t qemu_icount_bias;
+
+    int64_t vm_clock_warp_start;
+    int64_t cpu_clock_offset;
+
+    /* Only written by TCG thread */
+    int64_t qemu_icount;
+
+    /* for adjusting icount */
+    QEMUTimer *icount_rt_timer;
+    QEMUTimer *icount_vm_timer;
+    QEMUTimer *icount_warp_timer;
+} TimersState;
+
+extern TimersState timers_state;
+
+/*
+ * icount needs this internal from cpu-timers when adjusting the icount shift.
+ */
+int64_t cpu_get_clock_locked(void);
+
+#endif /* TIMERS_STATE_H */
diff --git a/softmmu/vl.c b/softmmu/vl.c
index f7b103467c..23a9c60bc3 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -74,6 +74,7 @@
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
 #include "sysemu/cpus.h"
+#include "sysemu/cpu-timers.h"
 #include "migration/colo.h"
 #include "migration/postcopy-ram.h"
 #include "sysemu/kvm.h"
@@ -2802,7 +2803,7 @@ static void configure_accelerators(const char *progname)
         error_report("falling back to %s", ac->name);
     }
 
-    if (use_icount && !(tcg_enabled() || qtest_enabled())) {
+    if (icount_enabled() && !tcg_enabled()) {
         error_report("-icount is not allowed with hardware virtualization");
         exit(1);
     }
@@ -4237,7 +4238,8 @@ void qemu_init(int argc, char **argv, char **envp)
         semihosting_arg_fallback(kernel_filename, kernel_cmdline);
     }
 
-    cpu_ticks_init();
+    /* initialize cpu timers and VCPU throttle modules */
+    cpu_timers_init();
 
     if (default_net) {
         QemuOptsList *net = qemu_find_opts("net");
diff --git a/stubs/clock-warp.c b/stubs/clock-warp.c
deleted file mode 100644
index b53e5dd94c..0000000000
--- a/stubs/clock-warp.c
+++ /dev/null
@@ -1,7 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu/timer.h"
-
-void qemu_start_warp_timer(void)
-{
-}
-
diff --git a/stubs/cpu-get-clock.c b/stubs/cpu-get-clock.c
index 5a92810e87..9e92404816 100644
--- a/stubs/cpu-get-clock.c
+++ b/stubs/cpu-get-clock.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
-#include "qemu/timer.h"
+#include "sysemu/cpu-timers.h"
+#include "qemu/main-loop.h"
 
 int64_t cpu_get_clock(void)
 {
diff --git a/stubs/cpu-get-icount.c b/stubs/cpu-get-icount.c
deleted file mode 100644
index 4001613240..0000000000
--- a/stubs/cpu-get-icount.c
+++ /dev/null
@@ -1,16 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu/timer.h"
-#include "sysemu/cpus.h"
-#include "qemu/main-loop.h"
-
-int use_icount;
-
-int64_t cpu_get_icount(void)
-{
-    abort();
-}
-
-int64_t cpu_get_icount_raw(void)
-{
-    abort();
-}
diff --git a/stubs/icount.c b/stubs/icount.c
new file mode 100644
index 0000000000..61e28cbaf9
--- /dev/null
+++ b/stubs/icount.c
@@ -0,0 +1,45 @@
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "sysemu/cpu-timers.h"
+
+/* icount - Instruction Counter API */
+
+int use_icount;
+
+void cpu_update_icount(CPUState *cpu)
+{
+    abort();
+}
+void configure_icount(QemuOpts *opts, Error **errp)
+{
+    /* signal error */
+    error_setg(errp, "cannot configure icount, TCG support not available");
+}
+int64_t cpu_get_icount_raw(void)
+{
+    abort();
+    return 0;
+}
+int64_t cpu_get_icount(void)
+{
+    abort();
+    return 0;
+}
+int64_t cpu_icount_to_ns(int64_t icount)
+{
+    abort();
+    return 0;
+}
+int64_t qemu_icount_round(int64_t count)
+{
+    abort();
+    return 0;
+}
+void qemu_start_warp_timer(void)
+{
+    abort();
+}
+void qemu_account_warp_timer(void)
+{
+    abort();
+}
diff --git a/stubs/meson.build b/stubs/meson.build
index e0b322bc28..e64ce02ea2 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -3,10 +3,10 @@ stub_ss.add(files('bdrv-next-monitor-owned.c'))
 stub_ss.add(files('blk-commit-all.c'))
 stub_ss.add(files('blockdev-close-all-bdrv-states.c'))
 stub_ss.add(files('change-state-handler.c'))
-stub_ss.add(files('clock-warp.c'))
 stub_ss.add(files('cmos.c'))
 stub_ss.add(files('cpu-get-clock.c'))
-stub_ss.add(files('cpu-get-icount.c'))
+stub_ss.add(files('qemu-timer-notify-cb.c'))
+stub_ss.add(files('icount.c'))
 stub_ss.add(files('dump.c'))
 stub_ss.add(files('error-printf.c'))
 stub_ss.add(files('fdset.c'))
diff --git a/stubs/qemu-timer-notify-cb.c b/stubs/qemu-timer-notify-cb.c
index 054b408b1c..845e46f8e0 100644
--- a/stubs/qemu-timer-notify-cb.c
+++ b/stubs/qemu-timer-notify-cb.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "sysemu/cpus.h"
+#include "sysemu/cpu-timers.h"
 #include "qemu/main-loop.h"
 
 void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
diff --git a/stubs/qtest.c b/stubs/qtest.c
index 891eb954fb..4666a49d7d 100644
--- a/stubs/qtest.c
+++ b/stubs/qtest.c
@@ -18,3 +18,8 @@ bool qtest_driver(void)
 {
     return false;
 }
+
+int64_t qtest_get_virtual_clock(void)
+{
+    return 0;
+}
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 8870284f57..36be602179 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "sysemu/cpus.h"
+#include "sysemu/cpu-timers.h"
 #include "disas/disas.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
@@ -1329,7 +1330,7 @@ static DisasJumpType gen_mfpr(DisasContext *ctx, TCGv va, int regno)
     case 249: /* VMTIME */
         helper = gen_helper_get_vmtime;
     do_helper:
-        if (use_icount) {
+        if (icount_enabled()) {
             gen_io_start();
             helper(va);
             return DISAS_PC_STALE;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 88bd9dd35d..dd5a28f1c7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -24,6 +24,7 @@
 #include "hw/irq.h"
 #include "hw/semihosting/semihost.h"
 #include "sysemu/cpus.h"
+#include "sysemu/cpu-timers.h"
 #include "sysemu/kvm.h"
 #include "sysemu/tcg.h"
 #include "qemu/range.h"
@@ -1206,7 +1207,7 @@ static int64_t cycles_ns_per(uint64_t cycles)
 
 static bool instructions_supported(CPUARMState *env)
 {
-    return use_icount == 1 /* Precise instruction counting */;
+    return icount_enabled() == 1; /* Precise instruction counting */
 }
 
 static uint64_t instructions_get_count(CPUARMState *env)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 26ae347b4a..e51ed7b9ca 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -299,7 +299,7 @@ static int write_vstart(CPURISCVState *env, int csrno, target_ulong val)
 static int read_instret(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (use_icount) {
+    if (icount_enabled()) {
         *val = cpu_get_icount();
     } else {
         *val = cpu_get_host_ticks();
@@ -314,7 +314,7 @@ static int read_instret(CPURISCVState *env, int csrno, target_ulong *val)
 static int read_instreth(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (use_icount) {
+    if (icount_enabled()) {
         *val = cpu_get_icount() >> 32;
     } else {
         *val = cpu_get_host_ticks() >> 32;
diff --git a/tests/ptimer-test-stubs.c b/tests/ptimer-test-stubs.c
index ed393d9082..e935a1395e 100644
--- a/tests/ptimer-test-stubs.c
+++ b/tests/ptimer-test-stubs.c
@@ -12,6 +12,7 @@
 #include "qemu/main-loop.h"
 #include "sysemu/replay.h"
 #include "migration/vmstate.h"
+#include "sysemu/cpu-timers.h"
 
 #include "ptimer-test.h"
 
@@ -30,8 +31,8 @@ QEMUTimerListGroup main_loop_tlg;
 
 int64_t ptimer_test_time_ns;
 
-/* Do not artificially limit period - see hw/core/ptimer.c.  */
-int use_icount = 1;
+/* under qtest_enabled(), will not artificially limit period - see hw/core/ptimer.c. */
+int use_icount;
 bool qtest_allowed;
 
 void timer_init_full(QEMUTimer *ts,
diff --git a/tests/test-timed-average.c b/tests/test-timed-average.c
index e2bcf5fe13..82c92500df 100644
--- a/tests/test-timed-average.c
+++ b/tests/test-timed-average.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-
+#include "sysemu/cpu-timers.h"
 #include "qemu/timed-average.h"
 
 /* This is the clock for QEMU_CLOCK_VIRTUAL */
diff --git a/util/main-loop.c b/util/main-loop.c
index 217c8d6056..0c5fe0107e 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -27,7 +27,7 @@
 #include "qemu/cutils.h"
 #include "qemu/timer.h"
 #include "sysemu/qtest.h"
-#include "sysemu/cpus.h"
+#include "sysemu/cpu-timers.h"
 #include "sysemu/replay.h"
 #include "qemu/main-loop.h"
 #include "block/aio.h"
@@ -521,9 +521,13 @@ void main_loop_wait(int nonblocking)
     mlpoll.state = ret < 0 ? MAIN_LOOP_POLL_ERR : MAIN_LOOP_POLL_OK;
     notifier_list_notify(&main_loop_poll_notifiers, &mlpoll);
 
-    /* CPU thread can infinitely wait for event after
-       missing the warp */
-    qemu_start_warp_timer();
+    if (icount_enabled()) {
+        /*
+         * CPU thread can infinitely wait for event after
+         * missing the warp
+         */
+        qemu_start_warp_timer();
+    }
     qemu_clock_run_all_timers();
 }
 
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 878d80fd5e..aeb6b613b8 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -26,8 +26,10 @@
 #include "qemu/main-loop.h"
 #include "qemu/timer.h"
 #include "qemu/lockable.h"
+#include "sysemu/cpu-timers.h"
 #include "sysemu/replay.h"
 #include "sysemu/cpus.h"
+#include "sysemu/qtest.h"
 
 #ifdef CONFIG_POSIX
 #include <pthread.h>
@@ -134,7 +136,7 @@ static void qemu_clock_init(QEMUClockType type, QEMUTimerListNotifyCB *notify_cb
 
 bool qemu_clock_use_for_deadline(QEMUClockType type)
 {
-    return !(use_icount && (type == QEMU_CLOCK_VIRTUAL));
+    return !(icount_enabled() && (type == QEMU_CLOCK_VIRTUAL));
 }
 
 void qemu_clock_notify(QEMUClockType type)
@@ -416,7 +418,7 @@ static bool timer_mod_ns_locked(QEMUTimerList *timer_list,
 static void timerlist_rearm(QEMUTimerList *timer_list)
 {
     /* Interrupt execution to force deadline recalculation.  */
-    if (timer_list->clock->type == QEMU_CLOCK_VIRTUAL) {
+    if (icount_enabled() && timer_list->clock->type == QEMU_CLOCK_VIRTUAL) {
         qemu_start_warp_timer();
     }
     timerlist_notify(timer_list);
@@ -633,8 +635,10 @@ int64_t qemu_clock_get_ns(QEMUClockType type)
         return get_clock();
     default:
     case QEMU_CLOCK_VIRTUAL:
-        if (use_icount) {
+        if (icount_enabled()) {
             return cpu_get_icount();
+        } else if (qtest_enabled()) { /* for qtest_clock_warp */
+            return qtest_get_virtual_clock();
         } else {
             return cpu_get_clock();
         }
-- 
2.26.2



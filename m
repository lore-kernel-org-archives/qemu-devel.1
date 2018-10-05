Received: from eggs.gnu.org ([2001:4830:134:3::10]:60113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SSH-0005zr-85
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SSC-0004eT-5Y
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:55:53 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:44972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SSB-0004eL-SF
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:55:48 -0400
Received: by mail-wr1-x42b.google.com with SMTP id 63-v6so14046135wra.11
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:55:47 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:49:10 +0100
Message-Id: <20181005154910.3099-22-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH  21/21] plugin: add tlbflush stats plugin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

This plugin attempts to give an idea of how long it take QEMU to
process the various types of TLB flush operation. Although this is
generally of interest to QEMU developers the plugin is only using the
trace point information to work this out. For example launching a
system emulation with -plugin file=./trace/plugins/tlbflush.so allows
the following to be reported on the monitor:

  (qemu) info trace-plugins
  ./trace/plugins/tlbflush.so: tlbflush report:
  cpu 0 101244 self events: avg time 103, max 18313
  cpu 0 2 async events: avg time 14076146, max 27536460
  cpu 0 122328 synced events: avg time 5441, max 29080526
  cpu 0 162671 work events: avg time 5380, max 47305
  cpu 1 101742 self events: avg time 110, max 29708
  cpu 1 2 async events: avg time 14112140, max 27573506
  cpu 1 122669 synced events: avg time 5762, max 1175419
  cpu 1 163401 work events: avg time 5427, max 942563
  cpu 2 116726 self events: avg time 107, max 18277
  cpu 2 2 async events: avg time 14126146, max 27615150
  cpu 2 120119 synced events: avg time 6318, max 928542
  cpu 2 177175 work events: avg time 5772, max 699626
  cpu 3 94551 self events: avg time 107, max 23313
  cpu 3 1 async events: avg time 27947822, max 27947822
  cpu 3 123203 synced events: avg time 7877, max 3913260
  cpu 3 156481 work events: avg time 5126, max 54107

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 trace/plugins/tlbflush/tlbflush.c | 283 ++++++++++++++++++++++++++++++
 1 file changed, 283 insertions(+)
 create mode 100644 trace/plugins/tlbflush/tlbflush.c

diff --git a/trace/plugins/tlbflush/tlbflush.c b/trace/plugins/tlbflush/tlbflush.c
new file mode 100644
index 0000000000..0e6ab82978
--- /dev/null
+++ b/trace/plugins/tlbflush/tlbflush.c
@@ -0,0 +1,283 @@
+/*
+ * Execution Hotblocks Plugin
+ *
+ * Copyright (c) 2018
+ * Written by Alex Bennée <alex.bennee@linaro.org>
+ *
+ * This code is licensed under the GNU GPL v2.
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <glib.h>
+#include <time.h>
+#include <inttypes.h>
+#include "plugins.h"
+
+#define MAX_CPU  16
+
+#ifndef __ATOMIC_RELAXED
+#error "this plugin relies on atomics"
+#endif
+
+/*
+ * We are not going to try and track coalesced requests so the
+ * measurement will start from the point of the first request and be
+ * cleared from the first work complete.
+ */
+
+typedef enum FlushType { SELF, ASYNC, SYNCED } FlushType;
+
+typedef struct {
+    unsigned long count;
+    unsigned long total;
+    unsigned long max;
+} EventCounts;
+
+typedef struct {
+    struct timespec start;
+    FlushType type;
+
+    EventCounts self;
+    EventCounts async;
+    EventCounts synced;
+    EventCounts work;
+} TLBStats;
+
+static TLBStats stats[MAX_CPU];
+
+bool plugin_init(const char *args)
+{
+    return true;
+}
+
+static void add_stats(GString *report, int cpu, char *name, EventCounts *event)
+{
+    if (event->count) {
+        g_string_append_printf(report,
+                               "cpu %d %ld %s events: avg time %lu, max %lu\n",
+                               cpu, event->count, name,
+                               event->total / event->count, event->max);
+    }
+}
+
+char *plugin_status(void)
+{
+    GString *report = g_string_new("tlbflush report:\n");
+    char *r;
+    int i;
+
+    for (i = 0; i < MAX_CPU; i++) {
+        TLBStats *cpu_stats = &stats[i];
+
+        add_stats(report, i, "self", &cpu_stats->self);
+        add_stats(report, i, "async", &cpu_stats->async);
+        add_stats(report, i, "synced", &cpu_stats->synced);
+        add_stats(report, i, "work", &cpu_stats->work);
+    }
+
+    r = report->str;
+    g_string_free(report, FALSE);
+    return r;
+}
+
+
+/*
+ * Maybe start an event. This is imprecise as we don't catch all
+ * events. We will skip events when:
+ *   - we already started for an event that hasn't completed
+ *   - events that happen to start when tv_nsec == 0
+ */
+static bool maybe_start_timer(TLBStats *cpu, struct timespec now)
+{
+    struct timespec zero = { 0, 0 };
+    bool started;
+
+    started = __atomic_compare_exchange_n(&cpu->start.tv_nsec,
+                                          &zero.tv_nsec,
+                                          now.tv_nsec, false,
+                                          __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST);
+    if (started) {
+        __atomic_store_n(&cpu->start.tv_sec, now.tv_sec, __ATOMIC_SEQ_CST);
+    }
+
+    return started;
+}
+
+bool tlb_flush_self(int line, int vcpu)
+{
+    struct timespec current;
+    TLBStats *this = &stats[vcpu];
+
+    clock_gettime(CLOCK_MONOTONIC, &current);
+
+    if (maybe_start_timer(this, current)) {
+        this->type = SELF;
+    }
+
+    return false;
+}
+
+static void start_one_cpu(TLBStats *cpu, FlushType type, struct timespec now)
+{
+    if (maybe_start_timer(cpu, now)) {
+        cpu->type = type;
+    }
+}
+
+bool tlb_flush_async_schedule(int line, int from, int to)
+{
+    struct timespec current;
+    TLBStats *this;
+
+    clock_gettime(CLOCK_MONOTONIC, &current);
+
+    if (to < 0) {
+        int i;
+        for (i = 0; i < MAX_CPU; i++) {
+            if (i != from) {
+                this = &stats[i];
+                start_one_cpu(this, ASYNC, current);
+            }
+        }
+    } else {
+        this = &stats[to];
+        start_one_cpu(this, ASYNC, current);
+    }
+}
+
+bool tlb_flush_synced_schedule(int line, int from, int to)
+{
+    struct timespec current;
+    TLBStats *this;
+
+    clock_gettime(CLOCK_MONOTONIC, &current);
+
+    if (to < 0) {
+        int i;
+        for (i = 0; i < MAX_CPU; i++) {
+            if (i != from) {
+                this = &stats[i];
+                start_one_cpu(this, SYNCED, current);
+            }
+        }
+    } else {
+        this = &stats[to];
+        start_one_cpu(this, SYNCED, current);
+    }
+}
+
+
+static EventCounts *get_counts(FlushType type, TLBStats *stats)
+{
+    switch (type) {
+    case SELF:
+        return &stats->self;
+    case ASYNC:
+        return &stats->async;
+    case SYNCED:
+        return &stats->synced;
+    }
+}
+
+/* return elapsed ns */
+static unsigned long get_elapsed(struct timespec start, struct timespec end)
+{
+    struct timespec temp;
+
+    if ((end.tv_nsec - start.tv_nsec) < 0) {
+        temp.tv_sec = end.tv_sec - start.tv_sec - 1;
+        temp.tv_nsec = 1000000000 + end.tv_nsec - start.tv_nsec;
+    } else {
+        temp.tv_sec = end.tv_sec - start.tv_sec;
+        temp.tv_nsec = end.tv_nsec - start.tv_nsec;
+    }
+
+    return (temp.tv_sec * 1000000000) + temp.tv_nsec;
+}
+
+/* Record the duration of a single event based on when it started */
+static struct timespec record_event(struct timespec start, EventCounts *event)
+{
+    struct timespec current;
+    unsigned long elapsed ;
+
+    clock_gettime(CLOCK_MONOTONIC, &current);
+    elapsed = get_elapsed(start, current);
+    event->count++;
+    event->total += elapsed;
+    if (elapsed > event->max) {
+        event->max = elapsed;
+    }
+
+    return current;
+}
+
+/* Update the timer for work. As we are re-reading in the same thread
+ * we don't need to be totally sequential - it doesn't matter if the
+ * outer thread reads this or zero.
+ */
+static void update_timer(TLBStats *cpu, struct timespec new_time)
+{
+    /* we are using 0 to indicate no current event */
+    if (new_time.tv_nsec == 0) {
+        new_time.tv_nsec = 1;
+    }
+    __atomic_store_n(&cpu->start.tv_sec, new_time.tv_sec, __ATOMIC_RELAXED);
+    __atomic_store_n(&cpu->start.tv_nsec, new_time.tv_nsec, __ATOMIC_RELAXED);
+}
+
+/* ??? Maybe we should drop the start of work trace points but create
+ * a new one for processing and queued work ??? */
+
+bool tlb_flush_all_work(int vcpu)
+{
+    struct timespec start;
+    TLBStats *this = &stats[vcpu];
+
+    start.tv_nsec = __atomic_load_n(&this->start.tv_nsec, __ATOMIC_SEQ_CST);
+    start.tv_sec = __atomic_load_n(&this->start.tv_sec, __ATOMIC_SEQ_CST);
+
+    if (start.tv_nsec) {
+        EventCounts *event = get_counts(this->type, this);
+        struct timespec start_work = record_event(start, event);
+        update_timer(this, start_work);
+    }
+
+    return false;
+}
+
+bool tlb_flush_work(int line, int vcpu, unsigned long data)
+{
+    struct timespec start;
+    TLBStats *this = &stats[vcpu];
+
+    start.tv_nsec = __atomic_load_n(&this->start.tv_nsec, __ATOMIC_SEQ_CST);
+    start.tv_sec = __atomic_load_n(&this->start.tv_sec, __ATOMIC_SEQ_CST);
+
+    if (start.tv_nsec) {
+        EventCounts *event = get_counts(this->type, this);
+        struct timespec start_work = record_event(start, event);
+        update_timer(this, start_work);
+    }
+
+    return false;
+}
+
+bool tlb_flush_work_complete(int line, int vcpu)
+{
+    struct timespec start;
+    TLBStats *this = &stats[vcpu];
+
+    start.tv_sec = __atomic_load_n(&this->start.tv_sec, __ATOMIC_RELAXED);
+    start.tv_nsec = __atomic_load_n(&this->start.tv_nsec, __ATOMIC_RELAXED);
+
+    if (start.tv_nsec) {
+        EventCounts *event = &this->work;
+        record_event(start, event);
+        /* reset for next event */
+        __atomic_store_n(&this->start.tv_nsec, 0, __ATOMIC_SEQ_CST);
+    }
+
+    return false;
+}
-- 
2.17.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cpG32-0002jk-Kq
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 11:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cpG2z-0000Mg-Pb
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 11:13:40 -0400
Received: from mailout4.w1.samsung.com ([210.118.77.14]:57687)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1cpG2z-0000Jv-Gh
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 11:13:37 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout4.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0ON000EPONML7160@mailout4.w1.samsung.com> for
	qemu-devel@nongnu.org; Sat, 18 Mar 2017 15:13:33 +0000 (GMT)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Sat, 18 Mar 2017 18:13:23 +0300
Message-id: <1489850003-5652-3-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1489850003-5652-1-git-send-email-a.perevalov@samsung.com>
References: <1489850003-5652-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170318151332eucas1p2e375c85a501455f59d6f132da36ae844@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH 2/2] migration: calculate downtime on dst side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: i.maximets@samsung.com, a.perevalov@samsung.com

This patch provides downtime calculation per vCPU,
as a summary and as a overlapped value for all vCPUs.

This approach just keeps tree with page fault addr as a key,
and t1-t2 interval of pagefault time and page copy time, with
affected vCPU bit mask.
For more implementation details please see comment to
get_postcopy_total_downtime function.

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 include/migration/migration.h |  11 ++
 migration/migration.c         | 238 +++++++++++++++++++++++++++++++++++++++++-
 migration/postcopy-ram.c      |  61 ++++++++++-
 migration/savevm.c            |   2 +
 migration/trace-events        |  10 +-
 5 files changed, 318 insertions(+), 4 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 5720c88..8f9af77 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -123,10 +123,21 @@ struct MigrationIncomingState {
 
     /* See savevm.c */
     LoadStateEntry_Head loadvm_handlers;
+
+    /*
+     *  Tree for keeping postcopy downtime,
+     *  necessary to calculate correct downtime, during multiple
+     *  vm suspends, it keeps host page address as a key and
+     *  DowntimeDuration as a data
+     */
+    GTree *postcopy_downtime;
 };
 
 MigrationIncomingState *migration_incoming_get_current(void);
 void migration_incoming_state_destroy(void);
+void mark_postcopy_downtime_begin(uint64_t addr, int cpu);
+void mark_postcopy_downtime_end(uint64_t addr);
+int64_t get_postcopy_total_downtime(void);
 
 /*
  * An outstanding page request, on the source, having been received
diff --git a/migration/migration.c b/migration/migration.c
index 54060f7..57d71e1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -77,6 +77,12 @@ static NotifierList migration_state_notifiers =
 
 static bool deferred_incoming;
 
+typedef struct {
+    int64_t begin;
+    int64_t end;
+    uint64_t cpus;
+} DowntimeDuration;
+
 /*
  * Current state of incoming postcopy; note this is not part of
  * MigrationIncomingState since it's state is used during cleanup
@@ -117,6 +123,21 @@ MigrationState *migrate_get_current(void)
     return &current_migration;
 }
 
+static gint addr_compare(gconstpointer a, gconstpointer b,
+                                 gpointer user_data G_GNUC_UNUSED)
+{
+    if (a == b)
+        return 0;
+    else if (a > b)
+        return 1;
+    return -1;
+}
+
+static void destroy_downtime_duration(gpointer data)
+{
+    free(data);
+}
+
 MigrationIncomingState *migration_incoming_get_current(void)
 {
     static bool once;
@@ -128,6 +149,9 @@ MigrationIncomingState *migration_incoming_get_current(void)
         QLIST_INIT(&mis_current.loadvm_handlers);
         qemu_mutex_init(&mis_current.rp_mutex);
         qemu_event_init(&mis_current.main_thread_load_event, false);
+        mis_current.postcopy_downtime = g_tree_new_full(addr_compare,
+                                             NULL, NULL,
+                                             destroy_downtime_duration);
         once = true;
     }
     return &mis_current;
@@ -138,10 +162,13 @@ void migration_incoming_state_destroy(void)
     struct MigrationIncomingState *mis = migration_incoming_get_current();
 
     qemu_event_destroy(&mis->main_thread_load_event);
+    if (mis->postcopy_downtime) {
+        g_tree_destroy(mis->postcopy_downtime);
+        mis->postcopy_downtime = NULL;
+    }
     loadvm_free_handlers(mis);
 }
 
-
 typedef struct {
     bool optional;
     uint32_t size;
@@ -1119,7 +1146,6 @@ MigrationState *migrate_init(const MigrationParams *params)
     s->last_req_rb = NULL;
     error_free(s->error);
     s->error = NULL;
-
     migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
 
     QSIMPLEQ_INIT(&s->src_page_requests);
@@ -2109,3 +2135,211 @@ PostcopyState postcopy_state_set(PostcopyState new_state)
     return atomic_xchg(&incoming_postcopy_state, new_state);
 }
 
+void mark_postcopy_downtime_begin(uint64_t addr, int cpu)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    DowntimeDuration *dd;
+    if (!mis || !mis->postcopy_downtime) {
+        error_report("Migration incoming state should exists mis %p", mis);
+        return;
+    }
+
+    dd = g_tree_lookup(mis->postcopy_downtime, (gpointer)addr); /* !!! cast */
+    if (!dd) {
+        dd = (DowntimeDuration *)g_malloc0(sizeof(DowntimeDuration));
+        g_tree_insert(mis->postcopy_downtime, (gpointer)addr, (gpointer)dd);
+    }
+
+    if (cpu < 0)
+        /* assume in this situation all vCPUs are sleeping */
+        dd->cpus = ~0u;
+    else
+        set_bit(cpu, &dd->cpus);
+
+    /*
+     *  overwrite previously set dd->begin, if that page already was
+     *     faulted on another cpu
+     */
+    dd->begin = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    trace_mark_postcopy_downtime_begin(addr, dd, dd->begin, cpu);
+}
+
+void mark_postcopy_downtime_end(uint64_t addr)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    DowntimeDuration *dd;
+    if (!mis || !mis->postcopy_downtime) {
+        error_report("Migration incoming state should exists mis %p", mis);
+        return;
+    }
+
+    dd = g_tree_lookup(mis->postcopy_downtime, (gpointer)addr);
+    if (!dd) {
+        /* error_report("Could not populate downtime duration completion time \n\
+                        There is no downtime duration for 0x%"PRIx64, addr); */
+        return;
+    }
+
+    dd->end = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    trace_mark_postcopy_downtime_end(addr, dd, dd->end);
+}
+
+typedef struct {
+    int64_t tp; /* point in time */
+    bool is_end;
+    int64_t cpus; /* cpus bit mask */
+} OverlapDowntime;
+
+static gboolean populate_downtime_points(gpointer key, gpointer value,
+                                        gpointer data)
+{
+    DowntimeDuration *dd = (DowntimeDuration *)value;
+    GPtrArray *interval = (GPtrArray *)data;
+    OverlapDowntime *od_begin = g_malloc0(sizeof(OverlapDowntime));
+    OverlapDowntime *od_end = g_malloc0(sizeof(OverlapDowntime));
+
+    od_begin->tp = dd->begin;
+    od_begin->is_end = false;
+    od_begin->cpus = dd->cpus;
+    g_ptr_array_add(interval, od_begin);
+
+    od_end->tp = dd->end;
+    od_end->is_end = true;
+    od_end->cpus = dd->cpus;
+    g_ptr_array_add(interval, od_end);
+
+    if (dd->end && dd->begin)
+        trace_sumup_downtime_duration(dd->end - dd->begin, (uint64_t)key, dd->cpus);
+    return FALSE;
+}
+
+static gboolean calculate_per_cpu(gpointer key, gpointer value,
+                                  gpointer data)
+{
+    int *downtime_cpu = (int *)data;
+    DowntimeDuration *dd = (DowntimeDuration *)value;
+    int cpu_iter;
+    for (cpu_iter = 0; cpu_iter < smp_cpus; cpu_iter++) {
+        if (test_bit(cpu_iter, &dd->cpus) && dd->end && dd->begin)
+            downtime_cpu[cpu_iter] += dd->end - dd->begin;
+    }
+    return FALSE;
+}
+
+static gint compare_downtime(gconstpointer a, gconstpointer b)
+{
+    DowntimeDuration *dda = (DowntimeDuration *)a;
+    DowntimeDuration *ddb = (DowntimeDuration *)b;
+    return dda->begin - ddb->begin;
+}
+
+static uint64_t get_sufficient_smp_cpus(void)
+{
+    int i;
+    static uint64_t sufficient_cpus;
+    for (i = 0; i < smp_cpus; i++)
+    {
+	set_bit(i, &sufficient_cpus);
+    }
+    return sufficient_cpus;
+}
+
+/*
+ * This function calculates downtime per cpu and trace it
+ *
+ *  Also it calculates total downtime as an interval's overlap,
+ *  for many vCPU.
+ *
+ *  The approach is following:
+ *  Initially intervals are represented in tree where key is
+ *  pagefault address, and values:
+ *   begin - page fault time
+ *   end   - page load time
+ *   cpus  - bit mask shows affected cpus
+ *
+ *  To calculate overlap on all cpus, intervals converted into
+ *  array of points in time (downtime_points), the size of
+ *  array is 2 * number of nodes in tree of intervals (2 array
+ *  elements per one in element of interval).
+ *  Each element is marked as end (E) or as start (S) of interval.
+ *  The overlap downtime will be calculated for SE, only in case
+ *  there is sequence S(0..N)E(M) for every vCPU.
+ *
+ * As example we have 3 CPU
+ *
+ *      S1        E1           S1               E1
+ * -----***********------------xxx***************------------------------> CPU1
+ *
+ *             S2                E2
+ * ------------****************xxx---------------------------------------> CPU2
+ *
+ *                         S3            E3
+ * ------------------------****xxx********-------------------------------> CPU3
+ *
+ * We have sequence S1,S2,E1,S3,S1,E2,E3,E1
+ * S2,E1 - doesn't match condition due to sequence S1,S2,E1 doesn't include CPU3,
+ * S3,S1,E2 - sequenece includes all CPUs, in this case overlap will be S1,E2
+ *
+ */
+int64_t get_postcopy_total_downtime(void)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    int64_t total_downtime = 0; /* for total overlapped downtime */
+    const int intervals = g_tree_nnodes(mis->postcopy_downtime);
+    const int points = 2 * intervals;
+    uint64_t sufficient_smp_cpus = get_sufficient_smp_cpus();
+    int point_iter, start_point_iter;
+    GPtrArray *downtime_points = g_ptr_array_sized_new(points);
+    /* for summary downtime per cpu */
+    int *downtime_cpu = g_malloc0(smp_cpus * sizeof(int));
+    if (!mis || !mis->postcopy_downtime) {
+        error_report("Migration incoming state should exists, mis %p", mis);
+        return -1;
+    }
+
+    /* make downtime points S/E from interval */
+    g_tree_foreach(mis->postcopy_downtime, populate_downtime_points,
+                   downtime_points);
+    g_tree_foreach(mis->postcopy_downtime, calculate_per_cpu, downtime_cpu);
+
+    /* just for RFC patch */
+    for (point_iter = 0; point_iter < smp_cpus; point_iter++)
+    {
+        trace_downtime_per_cpu(point_iter, downtime_cpu[point_iter]);
+    }
+
+    g_ptr_array_sort(downtime_points, compare_downtime);
+
+    for (point_iter = 1; point_iter < points; point_iter++) {
+        OverlapDowntime *od = g_ptr_array_index(downtime_points, point_iter);
+        uint64_t cur_cpus = od->cpus;
+        int smp_cpus_i = smp_cpus;
+        OverlapDowntime *prev_od = g_ptr_array_index(downtime_points,
+                                                     point_iter - 1);
+        /* we need sequence SE */
+        if (!od->is_end || prev_od->is_end)
+            continue;
+
+        for (start_point_iter = point_iter - 1;
+             start_point_iter >= 0 && smp_cpus_i;
+             start_point_iter--, smp_cpus_i--) {
+            OverlapDowntime *t_od = g_ptr_array_index(downtime_points,
+                                                      start_point_iter);
+            /* should be S */
+            if (t_od->is_end)
+                break;
+
+            cur_cpus |= t_od->cpus;
+            if (sufficient_smp_cpus & cur_cpus) {
+                total_downtime += od->tp - prev_od->tp;
+                /* situation when one S point represents all vCPU is possible */
+                break;
+            }
+        }
+    }
+    trace_get_postcopy_total_downtime(g_tree_nnodes(mis->postcopy_downtime),
+        total_downtime);
+
+    g_ptr_array_free(downtime_points, TRUE);
+    return total_downtime;
+}
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index dc80dbb..3bd9db0 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -23,6 +23,7 @@
 #include "migration/postcopy-ram.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/balloon.h"
+#include <sys/param.h>
 #include "qemu/error-report.h"
 #include "trace.h"
 
@@ -404,6 +405,60 @@ static int ram_block_enable_notify(const char *block_name, void *host_addr,
     return 0;
 }
 
+#define PROC_LEN 1024
+static void trace_for_thread(const char *msg, pid_t thread_id)
+{
+    const char *status_file_frmt = "/proc/%d/status";
+    char status_file_path[MAXPATHLEN];
+    char proc_name[PROC_LEN];
+    char proc_status[PROC_LEN];
+    char *line = NULL;
+    FILE *f;
+    ssize_t read;
+    size_t len;
+
+    sprintf(status_file_path, status_file_frmt, thread_id);
+    f = fopen(status_file_path, "r");
+    if (!f) {
+        error_report("can't open %s", status_file_path);
+        return;
+    }
+
+    memset(proc_name, 0, sizeof(proc_name));
+    memset(proc_status, 0, sizeof(proc_status));
+
+    while ((read = getline(&line, &len, f)) != -1) {
+        if (strstr(line, "Name"))
+            strncpy(proc_name, line, sizeof(proc_name));
+        if (strstr(line, "State"))
+            strncpy(proc_status, line, sizeof(proc_status));
+    }
+
+    free(line);
+    trace_vcpu_thread_status(msg, thread_id, proc_name, proc_status);
+}
+
+static int defined_mem_fault_cpu_index(pid_t pid)
+{
+    CPUState *cpu_iter;
+
+    CPU_FOREACH(cpu_iter) {
+        if (cpu_iter->thread_id == pid)
+           return cpu_iter->cpu_index;
+    }
+    trace_for_thread("can't find cpu_index for thread id", pid);
+    return -1;
+}
+
+static void trace_cpu_state(void)
+{
+    CPUState *cpu_iter;
+    CPU_FOREACH(cpu_iter) {
+        trace_for_thread("vCPU", cpu_iter->thread_id);
+        trace_postcopy_vcpu_running(cpu_iter->cpu_index, cpu_iter->running);
+    }
+}
+
 /*
  * Handle faults detected by the USERFAULT markings
  */
@@ -445,6 +500,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
         }
 
         ret = read(mis->userfault_fd, &msg, sizeof(msg));
+        trace_cpu_state();
         if (ret != sizeof(msg)) {
             if (errno == EAGAIN) {
                 /*
@@ -481,8 +537,10 @@ static void *postcopy_ram_fault_thread(void *opaque)
         rb_offset &= ~(qemu_ram_pagesize(rb) - 1);
         trace_postcopy_ram_fault_thread_request(msg.arg.pagefault.address,
                                                 qemu_ram_get_idstr(rb),
-                                                rb_offset);
+                                                rb_offset, msg.arg.pagefault.pid);
 
+	mark_postcopy_downtime_begin(msg.arg.pagefault.address,
+		defined_mem_fault_cpu_index(msg.arg.pagefault.pid));
         /*
          * Send the request to the source - we want to request one
          * of our host page sizes (which is >= TPS)
@@ -577,6 +635,7 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
 
         return -e;
     }
+    mark_postcopy_downtime_end((uint64_t)host);
 
     trace_postcopy_place_page(host);
     return 0;
diff --git a/migration/savevm.c b/migration/savevm.c
index 3b19a4a..e12c0a2 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1630,6 +1630,7 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 
     if (autostart) {
         /* Hold onto your hats, starting the CPU */
+	trace_loadvm_postcopy_vm_start(get_postcopy_total_downtime());
         vm_start();
     } else {
         /* leave it paused and let management decide when to start the CPU */
@@ -1930,6 +1931,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis)
         return -EINVAL;
     }
 
+    trace_loadvm_postcopy_vm_start(get_postcopy_total_downtime());
     return 0;
 }
 
diff --git a/migration/trace-events b/migration/trace-events
index 7372ce2..8a21684 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -44,6 +44,7 @@ vmstate_subsection_save_loop(const char *name, const char *sub) "%s/%s"
 vmstate_subsection_save_top(const char *idstr) "%s"
 vmstate_load(const char *idstr, const char *vmsd_name) "%s, %s"
 qemu_announce_self_iter(const char *mac) "%s"
+loadvm_postcopy_vm_start(int64_t downtime) "%"PRId64
 
 # migration/vmstate.c
 vmstate_load_field_error(const char *field, int ret) "field \"%s\" load failed, ret = %d"
@@ -110,6 +111,11 @@ process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
 process_incoming_migration_co_postcopy_end_main(void) ""
 migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
 migration_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname)  "ioc=%p ioctype=%s hostname=%s"
+mark_postcopy_downtime_begin(uint64_t addr, void *dd, int64_t time, int cpu) "addr 0x%" PRIx64 " dd %p time %" PRId64 " cpu %d"
+mark_postcopy_downtime_end(uint64_t addr, void *dd, int64_t time) "addr 0x%" PRIx64 " dd %p time %" PRId64
+get_postcopy_total_downtime(int num, int64_t total) "faults %d, total downtime %" PRId64
+sumup_downtime_duration(int64_t downtime, uint64_t addr, int cpubit) "downtime %" PRId64 " addr 0x%" PRIx64 "cpus %d"
+downtime_per_cpu(int cpu_index, int downtime) "downtime cpu[%d]=%d"
 
 # migration/rdma.c
 qemu_rdma_accept_incoming_migration(void) ""
@@ -186,7 +192,7 @@ postcopy_ram_enable_notify(void) ""
 postcopy_ram_fault_thread_entry(void) ""
 postcopy_ram_fault_thread_exit(void) ""
 postcopy_ram_fault_thread_quit(void) ""
-postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset) "Request for HVA=%" PRIx64 " rb=%s offset=%zx"
+postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset, int pid) "Request for HVA=%" PRIx64 " rb=%s offset=%zx %d"
 postcopy_ram_incoming_cleanup_closeuf(void) ""
 postcopy_ram_incoming_cleanup_entry(void) ""
 postcopy_ram_incoming_cleanup_exit(void) ""
@@ -195,6 +201,8 @@ save_xbzrle_page_skipping(void) ""
 save_xbzrle_page_overflow(void) ""
 ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
 ram_load_complete(int ret, uint64_t seq_iter) "exit_code %d seq iteration %" PRIu64
+vcpu_thread_status(const char *msg, int tpid, char *name, char *status) "%s host_tid %d %s %s"
+postcopy_vcpu_running(int cpu_index, int is_running) "cpu %d running %d"
 
 # migration/exec.c
 migration_exec_outgoing(const char *cmd) "cmd=%s"
-- 
1.8.3.1

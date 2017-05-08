Received: from eggs.gnu.org ([2001:4830:134:3::10]:52503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d7cAW-00073R-LE
	for qemu-devel@nongnu.org; Mon, 08 May 2017 02:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d7cAT-0003l4-FY
	for qemu-devel@nongnu.org; Mon, 08 May 2017 02:29:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d7cAT-0003kj-5Z
	for qemu-devel@nongnu.org; Mon, 08 May 2017 02:29:13 -0400
Date: Mon, 8 May 2017 14:29:06 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170508062906.GC2820@pxdev.xzpeter.org>
References: <1493362658-8179-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170428065755eucas1p2ff9aa17eaa294e741d8c65f8d58a71fb@eucas1p2.samsung.com>
	<1493362658-8179-6-git-send-email-a.perevalov@samsung.com>
	<20170428100012.GB22801@pxdev.xzpeter.org>
	<d018d4a6-4b50-3f36-fe69-e232b63bebf0@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d018d4a6-4b50-3f36-fe69-e232b63bebf0@samsung.com>
Subject: Re: [Qemu-devel] [PATCH RESEND V3 5/6] migration: calculate
 downtime on dst side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, i.maximets@samsung.com, f4bug@amsat.org

On Fri, Apr 28, 2017 at 02:11:19PM +0300, Alexey Perevalov wrote:
> On 04/28/2017 01:00 PM, Peter Xu wrote:
> >On Fri, Apr 28, 2017 at 09:57:37AM +0300, Alexey Perevalov wrote:
> >>This patch provides downtime calculation per vCPU,
> >>as a summary and as a overlapped value for all vCPUs.
> >>
> >>This approach was suggested by Peter Xu, as an improvements of
> >>previous approch where QEMU kept tree with faulted page address and cpus bitmask
> >>in it. Now QEMU is keeping array with faulted page address as value and vCPU
> >>as index. It helps to find proper vCPU at UFFD_COPY time. Also it keeps
> >>list for downtime per vCPU (could be traced with page_fault_addr)
> >>
> >>For more details see comments for get_postcopy_total_downtime
> >>implementation.
> >>
> >>Downtime will not calculated if postcopy_downtime field of
> >>MigrationIncomingState wasn't initialized.
> >>
> >>Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> >>---
> >>  include/migration/migration.h |   3 ++
> >>  migration/migration.c         | 103 ++++++++++++++++++++++++++++++++++++++++++
> >>  migration/postcopy-ram.c      |  20 +++++++-
> >>  migration/trace-events        |   6 ++-
> >>  4 files changed, 130 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/include/migration/migration.h b/include/migration/migration.h
> >>index e8fb68f..a22f9ce 100644
> >>--- a/include/migration/migration.h
> >>+++ b/include/migration/migration.h
> >>@@ -139,6 +139,9 @@ void migration_incoming_state_destroy(void);
> >>   * Functions to work with downtime context
> >>   */
> >>  struct DowntimeContext *downtime_context_new(void);
> >>+void mark_postcopy_downtime_begin(uint64_t addr, int cpu);
> >>+void mark_postcopy_downtime_end(uint64_t addr);
> >>+uint64_t get_postcopy_total_downtime(void);
> >>  struct MigrationState
> >>  {
> >>diff --git a/migration/migration.c b/migration/migration.c
> >>index ec76e5c..2c6f150 100644
> >>--- a/migration/migration.c
> >>+++ b/migration/migration.c
> >>@@ -2150,3 +2150,106 @@ PostcopyState postcopy_state_set(PostcopyState new_state)
> >>      return atomic_xchg(&incoming_postcopy_state, new_state);
> >>  }
> >>+void mark_postcopy_downtime_begin(uint64_t addr, int cpu)
> >>+{
> >>+    MigrationIncomingState *mis = migration_incoming_get_current();
> >>+    DowntimeContext *dc;
> >>+    if (!mis->downtime_ctx || cpu < 0) {
> >>+        return;
> >>+    }
> >>+    dc = mis->downtime_ctx;
> >>+    dc->vcpu_addr[cpu] = addr;
> >>+    dc->last_begin = dc->page_fault_vcpu_time[cpu] =
> >>+        qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> >>+
> >>+    trace_mark_postcopy_downtime_begin(addr, dc, dc->page_fault_vcpu_time[cpu],
> >>+            cpu);
> >>+}
> >>+
> >>+void mark_postcopy_downtime_end(uint64_t addr)
> >>+{
> >>+    MigrationIncomingState *mis = migration_incoming_get_current();
> >>+    DowntimeContext *dc;
> >>+    int i;
> >>+    bool all_vcpu_down = true;
> >>+    int64_t now;
> >>+
> >>+    if (!mis->downtime_ctx) {
> >>+        return;
> >>+    }
> >>+    dc = mis->downtime_ctx;
> >>+    now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> >>+
> >>+    /* check all vCPU down,
> >>+     * QEMU has bitmap.h, but even with bitmap_and
> >>+     * will be a cycle */
> >>+    for (i = 0; i < smp_cpus; i++) {
> >>+        if (dc->vcpu_addr[i]) {
> >>+            continue;
> >>+        }
> >>+        all_vcpu_down = false;
> >>+        break;
> >>+    }
> >>+
> >>+    if (all_vcpu_down) {
> >>+        dc->total_downtime += now - dc->last_begin;
> >Shall we do this accouting only if we are sure the copied page address
> >is one of the page faulted addresses? Can it be some other page? I
> >don't know. But since we have the loop below to make sure of it, why
> >not?
> no, the downtime implies since page fault till the
> page will be copied.
> Yes another pages could be copied as well as pagefaulted,
> and they are copied due to prefetching, but it's not a downtime.

Not sure I got the point... Do you mean that when reach here, then
this page address is definitely one of the faulted addresses? I am not
100% sure of this, but if you are sure, I am okay with it.

> 
> >A nitpick on perf: when there are lots of vcpus, the algo might be
> >slow since we have several places that loops over the smp_vcpus. But
> >this can be totally future work on top, and current way is good enough
> >at least for me.
> 
> >(for the nit: maybe add a hash, key=thread_id, value=cpu_index, then
> >  get_mem_fault_cpu_index() can be faster using the hash; meanwhile
> >  keep a counter A of page faulted vcpus, use atomic ops with it, then
> >  here all_vcpu_down can be checked by A == smp_vcpus)
> just binary search in get_mem_fault_cpu_index will be nice too )
> also, it's good idea to keep all_vcpu_down in PostcopyDowntimeContext.
> 
> >
> >Thanks,
> >
> >>+    }
> >>+
> >>+    /* lookup cpu, to clear it */
> >>+    for (i = 0; i < smp_cpus; i++) {
> >>+        uint64_t vcpu_downtime;
> >>+
> >>+        if (dc->vcpu_addr[i] != addr) {
> >>+            continue;
> >>+        }
> >>+
> >>+        vcpu_downtime = now - dc->page_fault_vcpu_time[i];
> >>+
> >>+        dc->vcpu_addr[i] = 0;
> >>+        dc->vcpu_downtime[i] += vcpu_downtime;
> >>+    }
> >>+
> >>+    trace_mark_postcopy_downtime_end(addr, dc, dc->total_downtime);
> >>+}
> >>+
> >>+/*
> >>+ * This function just provide calculated before downtime per cpu and trace it.
> >>+ * Total downtime is calculated in mark_postcopy_downtime_end.
> >>+ *
> >>+ *
> >>+ * Assume we have 3 CPU
> >>+ *
> >>+ *      S1        E1           S1               E1
> >>+ * -----***********------------xxx***************------------------------> CPU1
> >>+ *
> >>+ *             S2                E2
> >>+ * ------------****************xxx---------------------------------------> CPU2
> >>+ *
> >>+ *                         S3            E3
> >>+ * ------------------------****xxx********-------------------------------> CPU3
> >>+ *
> >>+ * We have sequence S1,S2,E1,S3,S1,E2,E3,E1
> >>+ * S2,E1 - doesn't match condition due to sequence S1,S2,E1 doesn't include CPU3
> >>+ * S3,S1,E2 - sequence includes all CPUs, in this case overlap will be S1,E2 -
> >>+ *            it's a part of total downtime.
> >>+ * S1 - here is last_begin
> >>+ * Legend of the picture is following:
> >>+ *              * - means downtime per vCPU
> >>+ *              x - means overlapped downtime (total downtime)
> >>+ */
> >>+uint64_t get_postcopy_total_downtime(void)
> >>+{
> >>+    MigrationIncomingState *mis = migration_incoming_get_current();
> >>+
> >>+    if (!mis->downtime_ctx) {
> >>+        return 0;
> >>+    }
> >>+
> >>+    if (trace_event_get_state(TRACE_DOWNTIME_PER_CPU)) {
> >>+        int i;
> >>+        for (i = 0; i < smp_cpus; i++) {
> >>+            trace_downtime_per_cpu(i, mis->downtime_ctx->vcpu_downtime[i]);
> >>+        }
> >>+    }
> >>+    return mis->downtime_ctx->total_downtime;
> >>+}
> >>diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> >>index f3688f5..cf2b935 100644
> >>--- a/migration/postcopy-ram.c
> >>+++ b/migration/postcopy-ram.c
> >>@@ -23,6 +23,7 @@
> >>  #include "migration/postcopy-ram.h"
> >>  #include "sysemu/sysemu.h"
> >>  #include "sysemu/balloon.h"
> >>+#include <sys/param.h>
> >>  #include "qemu/error-report.h"
> >>  #include "trace.h"
> >>@@ -468,6 +469,19 @@ static int ram_block_enable_notify(const char *block_name, void *host_addr,
> >>      return 0;
> >>  }
> >>+static int get_mem_fault_cpu_index(uint32_t pid)
> >>+{
> >>+    CPUState *cpu_iter;
> >>+
> >>+    CPU_FOREACH(cpu_iter) {
> >>+        if (cpu_iter->thread_id == pid) {
> >>+            return cpu_iter->cpu_index;
> >>+        }
> >>+    }
> >>+    trace_get_mem_fault_cpu_index(pid);
> >>+    return -1;
> >>+}
> >>+
> >>  /*
> >>   * Handle faults detected by the USERFAULT markings
> >>   */
> >>@@ -545,8 +559,11 @@ static void *postcopy_ram_fault_thread(void *opaque)
> >>          rb_offset &= ~(qemu_ram_pagesize(rb) - 1);
> >>          trace_postcopy_ram_fault_thread_request(msg.arg.pagefault.address,
> >>                                                  qemu_ram_get_idstr(rb),
> >>-                                                rb_offset);
> >>+                                                rb_offset,
> >>+                                                msg.arg.pagefault.feat.ptid);
> >>+        mark_postcopy_downtime_begin((uintptr_t)(msg.arg.pagefault.address),
> >>+                         get_mem_fault_cpu_index(msg.arg.pagefault.feat.ptid));
> >>          /*
> >>           * Send the request to the source - we want to request one
> >>           * of our host page sizes (which is >= TPS)
> >>@@ -641,6 +658,7 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
> >>          return -e;
> >>      }
> >>+    mark_postcopy_downtime_end((uint64_t)host);
> >>      trace_postcopy_place_page(host);
> >>      return 0;
> >>diff --git a/migration/trace-events b/migration/trace-events
> >>index b8f01a2..d338810 100644
> >>--- a/migration/trace-events
> >>+++ b/migration/trace-events
> >>@@ -110,6 +110,9 @@ process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
> >>  process_incoming_migration_co_postcopy_end_main(void) ""
> >>  migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
> >>  migration_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname)  "ioc=%p ioctype=%s hostname=%s"
> >>+mark_postcopy_downtime_begin(uint64_t addr, void *dd, int64_t time, int cpu) "addr 0x%" PRIx64 " dd %p time %" PRId64 " cpu %d"
> >>+mark_postcopy_downtime_end(uint64_t addr, void *dd, int64_t time) "addr 0x%" PRIx64 " dd %p time %" PRId64
> >>+downtime_per_cpu(int cpu_index, int64_t downtime) "downtime cpu[%d]=%" PRId64
> >>  # migration/rdma.c
> >>  qemu_rdma_accept_incoming_migration(void) ""
> >>@@ -186,7 +189,7 @@ postcopy_ram_enable_notify(void) ""
> >>  postcopy_ram_fault_thread_entry(void) ""
> >>  postcopy_ram_fault_thread_exit(void) ""
> >>  postcopy_ram_fault_thread_quit(void) ""
> >>-postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset) "Request for HVA=%" PRIx64 " rb=%s offset=%zx"
> >>+postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset, uint32_t pid) "Request for HVA=%" PRIx64 " rb=%s offset=%zx %u"
> >>  postcopy_ram_incoming_cleanup_closeuf(void) ""
> >>  postcopy_ram_incoming_cleanup_entry(void) ""
> >>  postcopy_ram_incoming_cleanup_exit(void) ""
> >>@@ -195,6 +198,7 @@ save_xbzrle_page_skipping(void) ""
> >>  save_xbzrle_page_overflow(void) ""
> >>  ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
> >>  ram_load_complete(int ret, uint64_t seq_iter) "exit_code %d seq iteration %" PRIu64
> >>+get_mem_fault_cpu_index(uint32_t pid) "pid %u is not vCPU"
> >>  # migration/exec.c
> >>  migration_exec_outgoing(const char *cmd) "cmd=%s"
> >>-- 
> >>1.9.1
> >>
> 
> 
> -- 
> Best regards,
> Alexey Perevalov

-- 
Peter Xu

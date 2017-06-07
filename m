Received: from eggs.gnu.org ([2001:4830:134:3::10]:54651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIVVk-00049S-Oo
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIVVh-0000ug-Ha
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:36:12 -0400
Received: from mailout4.w1.samsung.com ([210.118.77.14]:17202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dIVVh-0000tj-Ay
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:36:09 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout4.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OR600LAL2G7JG60@mailout4.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:36:07 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Wed, 07 Jun 2017 10:35:29 +0300
Message-id: <1496820931-27416-10-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1496820931-27416-1-git-send-email-a.perevalov@samsung.com>
References: <1496820931-27416-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170607073606eucas1p15855edc9776f50d47eb18b1d4ba3263e@eucas1p1.samsung.com>
Subject: [Qemu-devel] [[PATCH V7] 09/11] migration: calculate vCPU blocktime
 on dst side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, dgilbert@redhat.com, i.maximets@samsung.com, peterx@redhat.com

This patch provides blocktime calculation per vCPU,
as a summary and as a overlapped value for all vCPUs.

This approach was suggested by Peter Xu, as an improvements of
previous approch where QEMU kept tree with faulted page address and cpus bitmask
in it. Now QEMU is keeping array with faulted page address as value and vCPU
as index. It helps to find proper vCPU at UFFD_COPY time. Also it keeps
list for blocktime per vCPU (could be traced with page_fault_addr)

Blocktime will not calculated if postcopy_blocktime field of
MigrationIncomingState wasn't initialized.

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 migration/postcopy-ram.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++-
 migration/trace-events   |   5 +-
 2 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 62a272a..0ad9f9f 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -27,6 +27,7 @@
 #include "ram.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/balloon.h"
+#include <sys/param.h>
 #include "qemu/error-report.h"
 #include "trace.h"
 
@@ -561,6 +562,133 @@ static int ram_block_enable_notify(const char *block_name, void *host_addr,
     return 0;
 }
 
+static int get_mem_fault_cpu_index(uint32_t pid)
+{
+    CPUState *cpu_iter;
+
+    CPU_FOREACH(cpu_iter) {
+        if (cpu_iter->thread_id == pid) {
+            return cpu_iter->cpu_index;
+        }
+    }
+    trace_get_mem_fault_cpu_index(pid);
+    return -1;
+}
+
+/*
+ * This function is being called when pagefault occurs. It
+ * tracks down vCPU blocking time.
+ *
+ * @addr: faulted host virtual address
+ * @ptid: faulted process thread id
+ * @rb: ramblock appropriate to addr
+ */
+static void mark_postcopy_blocktime_begin(uint64_t addr, uint32_t ptid,
+                                          RAMBlock *rb)
+{
+    int cpu;
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
+    int64_t now_ms;
+
+    if (!dc || ptid == 0) {
+        return;
+    }
+    cpu = get_mem_fault_cpu_index(ptid);
+    if (cpu < 0) {
+        return;
+    }
+
+    now_ms = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    if (dc->vcpu_addr[cpu] == 0) {
+        atomic_inc(&dc->smp_cpus_down);
+    }
+
+    atomic_xchg__nocheck(&dc->vcpu_addr[cpu], addr);
+    atomic_xchg__nocheck(&dc->last_begin, now_ms);
+    atomic_xchg__nocheck(&dc->page_fault_vcpu_time[cpu], now_ms);
+
+    if (test_copiedmap_by_addr(addr, rb)) {
+        atomic_xchg__nocheck(&dc->vcpu_addr[cpu], 0);
+        atomic_xchg__nocheck(&dc->page_fault_vcpu_time[cpu], 0);
+        atomic_sub(&dc->smp_cpus_down, 1);
+    }
+    trace_mark_postcopy_blocktime_begin(addr, dc, dc->page_fault_vcpu_time[cpu],
+                                        cpu);
+}
+
+/*
+ *  This function just provide calculated blocktime per cpu and trace it.
+ *  Total blocktime is calculated in mark_postcopy_blocktime_end.
+ *
+ *
+ * Assume we have 3 CPU
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
+ * S2,E1 - doesn't match condition due to sequence S1,S2,E1 doesn't include CPU3
+ * S3,S1,E2 - sequence includes all CPUs, in this case overlap will be S1,E2 -
+ *            it's a part of total blocktime.
+ * S1 - here is last_begin
+ * Legend of the picture is following:
+ *              * - means blocktime per vCPU
+ *              x - means overlapped blocktime (total blocktime)
+ *
+ * @addr: host virtual address
+ */
+static void mark_postcopy_blocktime_end(uint64_t addr)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
+    int i, affected_cpu = 0;
+    int64_t now_ms;
+    bool vcpu_total_blocktime = false;
+
+    if (!dc) {
+        return;
+    }
+
+    now_ms = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+
+    /* lookup cpu, to clear it,
+     * that algorithm looks straighforward, but it's not
+     * optimal, more optimal algorithm is keeping tree or hash
+     * where key is address value is a list of  */
+    for (i = 0; i < smp_cpus; i++) {
+        uint64_t vcpu_blocktime = 0;
+        if (atomic_fetch_add(&dc->vcpu_addr[i], 0) != addr) {
+            continue;
+        }
+        atomic_xchg__nocheck(&dc->vcpu_addr[i], 0);
+        vcpu_blocktime = now_ms -
+            atomic_fetch_add(&dc->page_fault_vcpu_time[i], 0);
+        affected_cpu += 1;
+        /* we need to know is that mark_postcopy_end was due to
+         * faulted page, another possible case it's prefetched
+         * page and in that case we shouldn't be here */
+        if (!vcpu_total_blocktime &&
+            atomic_fetch_add(&dc->smp_cpus_down, 0) == smp_cpus) {
+            vcpu_total_blocktime = true;
+        }
+        /* continue cycle, due to one page could affect several vCPUs */
+        dc->vcpu_blocktime[i] += vcpu_blocktime;
+    }
+
+    atomic_sub(&dc->smp_cpus_down, affected_cpu);
+    if (vcpu_total_blocktime) {
+        dc->total_blocktime += now_ms - atomic_fetch_add(&dc->last_begin, 0);
+    }
+    trace_mark_postcopy_blocktime_end(addr, dc, dc->total_blocktime);
+}
+
 /*
  * Handle faults detected by the USERFAULT markings
  */
@@ -638,8 +766,11 @@ static void *postcopy_ram_fault_thread(void *opaque)
         rb_offset &= ~(qemu_ram_pagesize(rb) - 1);
         trace_postcopy_ram_fault_thread_request(msg.arg.pagefault.address,
                                                 qemu_ram_get_idstr(rb),
-                                                rb_offset);
+                                                rb_offset,
+                                                msg.arg.pagefault.feat.ptid);
 
+        mark_postcopy_blocktime_begin((uintptr_t)(msg.arg.pagefault.address),
+                                      msg.arg.pagefault.feat.ptid, rb);
         /*
          * Send the request to the source - we want to request one
          * of our host page sizes (which is >= TPS)
@@ -723,6 +854,12 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
     copy_struct.len = pagesize;
     copy_struct.mode = 0;
 
+    /* copied page isn't feature of blocktime calculation,
+     * it's more general entity, so keep it here,
+     * but gup betwean two following operation could be high,
+     * and in this case blocktime for such small interval will be lost */
+    set_copiedmap_by_addr((uint64_t)(uintptr_t)host, rb);
+    mark_postcopy_blocktime_end((uint64_t)(uintptr_t)host);
     /* copy also acks to the kernel waking the stalled thread up
      * TODO: We can inhibit that ack and only do it if it was requested
      * which would be slightly cheaper, but we'd have to be careful
diff --git a/migration/trace-events b/migration/trace-events
index 5b8ccf3..7bdadbb 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -112,6 +112,8 @@ process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
 process_incoming_migration_co_postcopy_end_main(void) ""
 migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
 migration_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname)  "ioc=%p ioctype=%s hostname=%s"
+mark_postcopy_blocktime_begin(uint64_t addr, void *dd, int64_t time, int cpu) "addr 0x%" PRIx64 " dd %p time %" PRId64 " cpu %d"
+mark_postcopy_blocktime_end(uint64_t addr, void *dd, int64_t time) "addr 0x%" PRIx64 " dd %p time %" PRId64
 
 # migration/rdma.c
 qemu_rdma_accept_incoming_migration(void) ""
@@ -188,7 +190,7 @@ postcopy_ram_enable_notify(void) ""
 postcopy_ram_fault_thread_entry(void) ""
 postcopy_ram_fault_thread_exit(void) ""
 postcopy_ram_fault_thread_quit(void) ""
-postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset) "Request for HVA=%" PRIx64 " rb=%s offset=%zx"
+postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset, uint32_t pid) "Request for HVA=%" PRIx64 " rb=%s offset=%zx %u"
 postcopy_ram_incoming_cleanup_closeuf(void) ""
 postcopy_ram_incoming_cleanup_entry(void) ""
 postcopy_ram_incoming_cleanup_exit(void) ""
@@ -197,6 +199,7 @@ save_xbzrle_page_skipping(void) ""
 save_xbzrle_page_overflow(void) ""
 ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
 ram_load_complete(int ret, uint64_t seq_iter) "exit_code %d seq iteration %" PRIu64
+get_mem_fault_cpu_index(uint32_t pid) "pid %u is not vCPU"
 
 # migration/exec.c
 migration_exec_outgoing(const char *cmd) "cmd=%s"
-- 
1.9.1

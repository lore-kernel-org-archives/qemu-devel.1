Received: from eggs.gnu.org ([2001:4830:134:3::10]:34711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWfVn-0007IS-T4
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:39:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWfVk-0007Bq-NF
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:39:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWfVk-0007B7-E5
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:39:00 -0500
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  3 Jan 2018 10:38:29 +0100
Message-Id: <20180103093834.20879-10-quintela@redhat.com>
In-Reply-To: <20180103093834.20879-1-quintela@redhat.com>
References: <20180103093834.20879-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 09/14] migration: calculate vCPU blocktime on
 dst side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Alexey Perevalov <a.perevalov@samsung.com>

From: Alexey Perevalov <a.perevalov@samsung.com>

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
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/postcopy-ram.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++-
 migration/trace-events   |   5 +-
 2 files changed, 146 insertions(+), 2 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index c18ec5aa18..6bf24e9596 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -553,6 +553,142 @@ static int ram_block_enable_notify(const char *block_name, void *host_addr,
     return 0;
 }
 
+static int get_mem_fault_cpu_index(uint32_t pid)
+{
+    CPUState *cpu_iter;
+
+    CPU_FOREACH(cpu_iter) {
+        if (cpu_iter->thread_id == pid) {
+            trace_get_mem_fault_cpu_index(cpu_iter->cpu_index, pid);
+            return cpu_iter->cpu_index;
+        }
+    }
+    trace_get_mem_fault_cpu_index(-1, pid);
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
+    int cpu, already_received;
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
+    atomic_xchg__nocheck(&dc->last_begin, now_ms);
+    atomic_xchg__nocheck(&dc->page_fault_vcpu_time[cpu], now_ms);
+    atomic_xchg__nocheck(&dc->vcpu_addr[cpu], addr);
+
+    /* check it here, not at the begining of the function,
+     * due to, check could accur early than bitmap_set in
+     * qemu_ufd_copy_ioctl */
+    already_received = ramblock_recv_bitmap_test(rb, (void *)addr);
+    if (already_received) {
+        atomic_xchg__nocheck(&dc->vcpu_addr[cpu], 0);
+        atomic_xchg__nocheck(&dc->page_fault_vcpu_time[cpu], 0);
+        atomic_dec(&dc->smp_cpus_down);
+    }
+    trace_mark_postcopy_blocktime_begin(addr, dc, dc->page_fault_vcpu_time[cpu],
+                                        cpu, already_received);
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
+    int64_t read_vcpu_time;
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
+
+        read_vcpu_time = atomic_fetch_add(&dc->page_fault_vcpu_time[i], 0);
+        if (atomic_fetch_add(&dc->vcpu_addr[i], 0) != addr ||
+            read_vcpu_time == 0) {
+            continue;
+        }
+        atomic_xchg__nocheck(&dc->vcpu_addr[i], 0);
+        vcpu_blocktime = now_ms - read_vcpu_time;
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
+    trace_mark_postcopy_blocktime_end(addr, dc, dc->total_blocktime,
+                                      affected_cpu);
+}
+
 /*
  * Handle faults detected by the USERFAULT markings
  */
@@ -630,8 +766,11 @@ static void *postcopy_ram_fault_thread(void *opaque)
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
@@ -721,6 +860,8 @@ static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
     if (!ret) {
         ramblock_recv_bitmap_set_range(rb, host_addr,
                                        pagesize / qemu_target_page_size());
+        mark_postcopy_blocktime_end((uint64_t)(uintptr_t)host_addr);
+
     }
     return ret;
 }
diff --git a/migration/trace-events b/migration/trace-events
index 6f29fcc686..462d15717d 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -115,6 +115,8 @@ process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
 process_incoming_migration_co_postcopy_end_main(void) ""
 migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
 migration_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname)  "ioc=%p ioctype=%s hostname=%s"
+mark_postcopy_blocktime_begin(uint64_t addr, void *dd, int64_t time, int cpu, int received) "addr: 0x%" PRIx64 ", dd: %p, time: %" PRId64 ", cpu: %d, already_received: %d"
+mark_postcopy_blocktime_end(uint64_t addr, void *dd, int64_t time, int affected_cpu) "addr: 0x%" PRIx64 ", dd: %p, time: %" PRId64 ", affected_cpu: %d"
 
 # migration/rdma.c
 qemu_rdma_accept_incoming_migration(void) ""
@@ -191,7 +193,7 @@ postcopy_ram_enable_notify(void) ""
 postcopy_ram_fault_thread_entry(void) ""
 postcopy_ram_fault_thread_exit(void) ""
 postcopy_ram_fault_thread_quit(void) ""
-postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset) "Request for HVA=0x%" PRIx64 " rb=%s offset=0x%zx"
+postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset, uint32_t pid) "Request for HVA=0x%" PRIx64 " rb=%s offset=0x%zx pid=%u"
 postcopy_ram_incoming_cleanup_closeuf(void) ""
 postcopy_ram_incoming_cleanup_entry(void) ""
 postcopy_ram_incoming_cleanup_exit(void) ""
@@ -200,6 +202,7 @@ save_xbzrle_page_skipping(void) ""
 save_xbzrle_page_overflow(void) ""
 ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
 ram_load_complete(int ret, uint64_t seq_iter) "exit_code %d seq iteration %" PRIu64
+get_mem_fault_cpu_index(int cpu, uint32_t pid) "cpu: %d, pid: %u"
 
 # migration/exec.c
 migration_exec_outgoing(const char *cmd) "cmd=%s"
-- 
2.14.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ek6Br-0006Sx-Va
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ek6Bo-0006IG-T5
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:45:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35670 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ek6Bo-0006HT-Nq
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:45:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E5CAE48959
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 10:45:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  9 Feb 2018 11:45:45 +0100
Message-Id: <20180209104546.29401-4-pbonzini@redhat.com>
In-Reply-To: <20180209104546.29401-1-pbonzini@redhat.com>
References: <20180209104546.29401-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] memory: introduce
 memory_global_after_dirty_log_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

There is a race between TCG and accesses to the dirty log:

      vCPU thread                  reader thread
      -----------------------      -----------------------
      TLB check -> slow path
        notdirty_mem_write
          write to RAM
          set dirty flag
                                   clear dirty flag
      TLB check -> fast path
                                   read memory
        write to RAM

Fortunately, in order to fix it, no change is required to the
vCPU thread.  However, the reader thread must delay the read after
the vCPU thread has finished the write.  This can be approximated
conservatively by run_on_cpu, which waits for the end of the current
translation block.

A similar technique is used by KVM, which has to do a synchronous TLB
flush after doing a test-and-clear of the dirty-page flags.

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c                | 31 +++++++++++++++++++++++++++++++
 include/exec/memory.h | 12 ++++++++++++
 memory.c              | 10 +++++++++-
 migration/ram.c       |  1 +
 4 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index e8d7b335b6..edfbf4f3a6 100644
--- a/exec.c
+++ b/exec.c
@@ -205,6 +205,7 @@ typedef struct subpage_t {
 
 static void io_mem_init(void);
 static void memory_map_init(void);
+static void tcg_log_global_after_sync(MemoryListener *listener);
 static void tcg_commit(MemoryListener *listener);
 
 static MemoryRegion io_mem_watch;
@@ -743,6 +744,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
     newas->cpu = cpu;
     newas->as = as;
     if (tcg_enabled()) {
+        newas->tcg_as_listener.log_global_after_sync = tcg_log_global_after_sync;
         newas->tcg_as_listener.commit = tcg_commit;
         memory_listener_register(&newas->tcg_as_listener, as);
     }
@@ -2841,6 +2843,35 @@ void address_space_dispatch_free(AddressSpaceDispatch *d)
     g_free(d);
 }
 
+static void do_nothing(CPUState *cpu, run_on_cpu_data d)
+{
+}
+
+static void tcg_log_global_after_sync(MemoryListener *listener)
+{
+    CPUAddressSpace *cpuas;
+
+    /* Wait for the CPU to end the current TB.  This avoids the following
+     * incorrect race:
+     *
+     *      vCPU                         migration
+     *      ----------------------       -------------------------
+     *      TLB check -> slow path
+     *        notdirty_mem_write
+     *          write to RAM
+     *          mark dirty
+     *                                   clear dirty flag
+     *      TLB check -> fast path
+     *                                   read memory
+     *        write to RAM
+     *
+     * by pushing the migration thread's memory read after the vCPU thread has
+     * written the memory.
+     */
+    cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
+    run_on_cpu(cpuas->cpu, do_nothing, RUN_ON_CPU_NULL);
+}
+
 static void tcg_commit(MemoryListener *listener)
 {
     CPUAddressSpace *cpuas;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index fff9b1d871..9ff97f2574 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -293,6 +293,7 @@ struct MemoryListener {
     void (*log_sync)(MemoryListener *listener, MemoryRegionSection *section);
     void (*log_global_start)(MemoryListener *listener);
     void (*log_global_stop)(MemoryListener *listener);
+    void (*log_global_after_sync)(MemoryListener *listener);
     void (*eventfd_add)(MemoryListener *listener, MemoryRegionSection *section,
                         bool match_data, uint64_t data, EventNotifier *e);
     void (*eventfd_del)(MemoryListener *listener, MemoryRegionSection *section,
@@ -1456,6 +1457,17 @@ MemoryRegionSection memory_region_find(MemoryRegion *mr,
  */
 void memory_global_dirty_log_sync(void);
 
+/**
+ * memory_global_dirty_log_sync: synchronize the dirty log for all memory
+ *
+ * Synchronizes the vCPUs with a thread that is reading the dirty bitmap.
+ * This function must be called after the dirty log bitmap is cleared, and
+ * before dirty guest memory pages are read.  If you are using
+ * #DirtyBitmapSnapshot, memory_region_snapshot_and_clear_dirty() takes
+ * care of doing this.
+ */
+void memory_global_after_dirty_log_sync(void);
+
 /**
  * memory_region_transaction_begin: Start a transaction.
  *
diff --git a/memory.c b/memory.c
index 8ed809c62b..74917a19eb 100644
--- a/memory.c
+++ b/memory.c
@@ -2004,10 +2004,13 @@ DirtyBitmapSnapshot *memory_region_snapshot_and_clear_dirty(MemoryRegion *mr,
                                                             hwaddr size,
                                                             unsigned client)
 {
+    DirtyBitmapSnapshot *snapshot;
     assert(mr->ram_block);
     memory_region_sync_dirty_bitmap(mr);
-    return cpu_physical_memory_snapshot_and_clear_dirty(
+    snapshot = cpu_physical_memory_snapshot_and_clear_dirty(
                 memory_region_get_ram_addr(mr) + addr, size, client);
+    memory_global_after_dirty_log_sync();
+    return snapshot;
 }
 
 bool memory_region_snapshot_get_dirty(MemoryRegion *mr, DirtyBitmapSnapshot *snap,
@@ -2528,6 +2531,11 @@ void memory_global_dirty_log_sync(void)
     }
 }
 
+void memory_global_after_dirty_log_sync(void)
+{
+    MEMORY_LISTENER_CALL_GLOBAL(log_global_after_sync, Forward);
+}
+
 static VMChangeStateEntry *vmstate_change;
 
 void memory_global_dirty_log_start(void)
diff --git a/migration/ram.c b/migration/ram.c
index 5a109efeda..3cb92e193e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -848,6 +848,7 @@ static void migration_bitmap_sync(RAMState *rs)
     rcu_read_unlock();
     qemu_mutex_unlock(&rs->bitmap_mutex);
 
+    memory_global_after_dirty_log_sync();
     trace_migration_bitmap_sync_end(rs->num_dirty_pages_period);
 
     end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-- 
2.14.3

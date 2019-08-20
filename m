Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F706C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:12:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545D9214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545D9214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyJq-0001wN-BP
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8T-0005g1-Pf
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8Q-0003Go-38
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy8P-0003Ek-PB
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6CD0B65F23
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 07:00:47 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DB7912D9B4
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 07:00:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:34 +0200
Message-Id: <1566284395-30287-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 20 Aug 2019 07:00:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 15/36] memory: fix race between TCG and accesses
 to dirty bitmap
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
index 3e78de3..ae68f72 100644
--- a/exec.c
+++ b/exec.c
@@ -198,6 +198,7 @@ typedef struct subpage_t {
 
 static void io_mem_init(void);
 static void memory_map_init(void);
+static void tcg_log_global_after_sync(MemoryListener *listener);
 static void tcg_commit(MemoryListener *listener);
 
 static MemoryRegion io_mem_watch;
@@ -906,6 +907,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
     newas->cpu = cpu;
     newas->as = as;
     if (tcg_enabled()) {
+        newas->tcg_as_listener.log_global_after_sync = tcg_log_global_after_sync;
         newas->tcg_as_listener.commit = tcg_commit;
         memory_listener_register(&newas->tcg_as_listener, as);
     }
@@ -3143,6 +3145,35 @@ void address_space_dispatch_free(AddressSpaceDispatch *d)
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
index bb0961d..b6bcf31 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -419,6 +419,7 @@ struct MemoryListener {
     void (*log_clear)(MemoryListener *listener, MemoryRegionSection *section);
     void (*log_global_start)(MemoryListener *listener);
     void (*log_global_stop)(MemoryListener *listener);
+    void (*log_global_after_sync)(MemoryListener *listener);
     void (*eventfd_add)(MemoryListener *listener, MemoryRegionSection *section,
                         bool match_data, uint64_t data, EventNotifier *e);
     void (*eventfd_del)(MemoryListener *listener, MemoryRegionSection *section,
@@ -1682,6 +1683,17 @@ MemoryRegionSection memory_region_find(MemoryRegion *mr,
 void memory_global_dirty_log_sync(void);
 
 /**
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
+/**
  * memory_region_transaction_begin: Start a transaction.
  *
  * During a transaction, changes will be accumulated and made visible
diff --git a/memory.c b/memory.c
index e42d63a..edd0c13 100644
--- a/memory.c
+++ b/memory.c
@@ -2127,9 +2127,12 @@ DirtyBitmapSnapshot *memory_region_snapshot_and_clear_dirty(MemoryRegion *mr,
                                                             hwaddr size,
                                                             unsigned client)
 {
+    DirtyBitmapSnapshot *snapshot;
     assert(mr->ram_block);
     memory_region_sync_dirty_bitmap(mr);
-    return cpu_physical_memory_snapshot_and_clear_dirty(mr, addr, size, client);
+    snapshot = cpu_physical_memory_snapshot_and_clear_dirty(mr, addr, size, client);
+    memory_global_after_dirty_log_sync();
+    return snapshot;
 }
 
 bool memory_region_snapshot_get_dirty(MemoryRegion *mr, DirtyBitmapSnapshot *snap,
@@ -2620,6 +2623,11 @@ void memory_global_dirty_log_sync(void)
     memory_region_sync_dirty_bitmap(NULL);
 }
 
+void memory_global_after_dirty_log_sync(void)
+{
+    MEMORY_LISTENER_CALL_GLOBAL(log_global_after_sync, Forward);
+}
+
 static VMChangeStateEntry *vmstate_change;
 
 void memory_global_dirty_log_start(void)
diff --git a/migration/ram.c b/migration/ram.c
index 889148d..4e3a6ae 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1847,6 +1847,7 @@ static void migration_bitmap_sync(RAMState *rs)
     rcu_read_unlock();
     qemu_mutex_unlock(&rs->bitmap_mutex);
 
+    memory_global_after_dirty_log_sync();
     trace_migration_bitmap_sync_end(rs->num_dirty_pages_period);
 
     end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-- 
1.8.3.1




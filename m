Received: from eggs.gnu.org ([2001:4830:134:3::10]:53440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1chKbw-0000wn-Hc
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:28:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1chKbv-0007xk-ES
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:28:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1chKbv-0007xK-96
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:28:55 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76257C04BD37
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 18:28:55 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 24 Feb 2017 18:28:34 +0000
Message-Id: <20170224182844.32452-7-dgilbert@redhat.com>
In-Reply-To: <20170224182844.32452-1-dgilbert@redhat.com>
References: <20170224182844.32452-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v3 06/16] postcopy: Record largest page size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Record the largest page size in use; we'll need it soon for allocating
temporary buffers.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
---
 exec.c                        | 13 +++++++++++++
 include/exec/cpu-common.h     |  1 +
 include/migration/migration.h |  1 +
 migration/migration.c         |  1 +
 4 files changed, 16 insertions(+)

diff --git a/exec.c b/exec.c
index ec3a11f..099794a 100644
--- a/exec.c
+++ b/exec.c
@@ -1524,6 +1524,19 @@ size_t qemu_ram_pagesize(RAMBlock *rb)
     return rb->page_size;
 }
 
+/* Returns the largest size of page in use */
+size_t qemu_ram_pagesize_largest(void)
+{
+    RAMBlock *block;
+    size_t largest = 0;
+
+    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+        largest = MAX(largest, qemu_ram_pagesize(block));
+    }
+
+    return largest;
+}
+
 static int memory_try_enable_merging(void *addr, size_t len)
 {
     if (!machine_mem_merge(current_machine)) {
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 1350c2e..8c305aa 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -64,6 +64,7 @@ void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *dev);
 void qemu_ram_unset_idstr(RAMBlock *block);
 const char *qemu_ram_get_idstr(RAMBlock *rb);
 size_t qemu_ram_pagesize(RAMBlock *block);
+size_t qemu_ram_pagesize_largest(void);
 
 void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
                             int len, int is_write);
diff --git a/include/migration/migration.h b/include/migration/migration.h
index aafa68f..e8e2a7f 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -92,6 +92,7 @@ struct MigrationIncomingState {
      */
     QemuEvent main_thread_load_event;
 
+    size_t         largest_page_size;
     bool           have_fault_thread;
     QemuThread     fault_thread;
     QemuSemaphore  fault_thread_sem;
diff --git a/migration/migration.c b/migration/migration.c
index c6ae69d..869697e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -383,6 +383,7 @@ static void process_incoming_migration_co(void *opaque)
     int ret;
 
     mis->from_src_file = f;
+    mis->largest_page_size = qemu_ram_pagesize_largest();
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
     migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
                       MIGRATION_STATUS_ACTIVE);
-- 
2.9.3

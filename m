Received: from eggs.gnu.org ([2001:4830:134:3::10]:36365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@hotmail.com>) id 1evv5m-0000PL-0D
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@hotmail.com>) id 1evv5l-0006R5-2O
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:20:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:28906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@hotmail.com>)
	id 1evv5k-0006Hx-QT
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:20:33 -0400
From: junyan.he@hotmail.com
Date: Wed, 14 Mar 2018 09:20:13 +0800
Message-Id: <1520990418-28258-6-git-send-email-junyan.he@hotmail.com>
In-Reply-To: <1520990418-28258-1-git-send-email-junyan.he@hotmail.com>
References: <1520990418-28258-1-git-send-email-junyan.he@hotmail.com>
Subject: [Qemu-devel] [PATCH 05/10] RFC: Add memory region snapshot bitmap
 get function.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, quintela@redhat.com, rth@twiddle.net, dgilbert@redhat.com, famz@redhat.com, Junyan He <junyan.he@intel.com>

From: Junyan He <junyan.he@intel.com>

We need to get the bitmap content of the snapshot when enable dirty
log trace for nvdimm.

Signed-off-by: Junyan He <junyan.he@intel.com>
---
 exec.c                  | 7 +++++++
 include/exec/memory.h   | 9 +++++++++
 include/exec/ram_addr.h | 2 ++
 memory.c                | 7 +++++++
 4 files changed, 25 insertions(+)

diff --git a/exec.c b/exec.c
index a9181e6..3d2bf0d 100644
--- a/exec.c
+++ b/exec.c
@@ -1235,6 +1235,13 @@ bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
     return false;
 }
 
+unsigned long *cpu_physical_memory_snapshot_get_dirty_bitmap
+     (DirtyBitmapSnapshot *snap)
+{
+    assert(snap);
+    return snap->dirty;
+}
+
 /* Called from RCU critical section */
 hwaddr memory_region_section_get_iotlb(CPUState *cpu,
                                        MemoryRegionSection *section,
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 31eae0a..f742995 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1179,6 +1179,15 @@ bool memory_region_snapshot_get_dirty(MemoryRegion *mr,
                                       hwaddr addr, hwaddr size);
 
 /**
+ * memory_region_snapshot_get_dirty_bitmap: Get the dirty bitmap data of
+ * snapshot.
+ *
+ * @snap: the dirty bitmap snapshot
+ */
+unsigned long *memory_region_snapshot_get_dirty_bitmap
+     (DirtyBitmapSnapshot *snap);
+
+/**
  * memory_region_reset_dirty: Mark a range of pages as clean, for a specified
  *                            client.
  *
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index cf2446a..ce366c1 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -371,6 +371,8 @@ DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
 bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
                                             ram_addr_t start,
                                             ram_addr_t length);
+unsigned long *cpu_physical_memory_snapshot_get_dirty_bitmap
+    (DirtyBitmapSnapshot *snap);
 
 static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
                                                          ram_addr_t length)
diff --git a/memory.c b/memory.c
index 4a8a2fe..68f17f0 100644
--- a/memory.c
+++ b/memory.c
@@ -1991,6 +1991,13 @@ DirtyBitmapSnapshot *memory_region_snapshot_and_clear_dirty(MemoryRegion *mr,
                 memory_region_get_ram_addr(mr) + addr, size, client);
 }
 
+unsigned long *memory_region_snapshot_get_dirty_bitmap
+     (DirtyBitmapSnapshot *snap)
+{
+    assert(snap);
+    return cpu_physical_memory_snapshot_get_dirty_bitmap(snap);
+}
+
 bool memory_region_snapshot_get_dirty(MemoryRegion *mr, DirtyBitmapSnapshot *snap,
                                       hwaddr addr, hwaddr size)
 {
-- 
2.7.4

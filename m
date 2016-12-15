Received: from eggs.gnu.org ([2001:4830:134:3::10]:42764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC2-0003SM-IS
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBz-0001Ob-G8
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBz-0001Nz-6t
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:39 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0jnBL130293
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:38 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdku12vr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:37 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:37 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:34 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-41-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 40/67] memory: Replace skip_dump flag with
 "ram_device"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

From: Alex Williamson <alex.williamson@redhat.com>

Setting skip_dump on a MemoryRegion allows us to modify one specific
code path, but the restriction we're trying to address encompasses
more than that.  If we have a RAM MemoryRegion backed by a physical
device, it not only restricts our ability to dump that region, but
also affects how we should manipulate it.  Here we recognize that
MemoryRegions do not change to sometimes allow dumps and other times
not, so we replace setting the skip_dump flag with a new initializer
so that we know exactly the type of region to which we're applying
this behavior.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 21e00fa55f3fdfcbb20da7c6876c91ef3609b387)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/vfio/common.c      |  9 ++++-----
 hw/vfio/spapr.c       |  2 +-
 include/exec/memory.h | 41 ++++++++++++++++++++++++++++-------------
 memory.c              | 13 +++++++++----
 memory_mapping.c      |  2 +-
 5 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b313e7c..b818723 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -723,12 +723,11 @@ int vfio_region_mmap(VFIORegion *region)
 
         name = g_strdup_printf("%s mmaps[%d]",
                                memory_region_name(region->mem), i);
-        memory_region_init_ram_ptr(&region->mmaps[i].mem,
-                                   memory_region_owner(region->mem),
-                                   name, region->mmaps[i].size,
-                                   region->mmaps[i].mmap);
+        memory_region_init_ram_device_ptr(&region->mmaps[i].mem,
+                                          memory_region_owner(region->mem),
+                                          name, region->mmaps[i].size,
+                                          region->mmaps[i].mmap);
         g_free(name);
-        memory_region_set_skip_dump(&region->mmaps[i].mem);
         memory_region_add_subregion(region->mem, region->mmaps[i].offset,
                                     &region->mmaps[i].mem);
 
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 7443d34..4409bcc 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -25,7 +25,7 @@ static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
     }
 
     return !memory_region_is_ram(section->mr) ||
-            memory_region_is_skip_dump(section->mr);
+            memory_region_is_ram_device(section->mr);
 }
 
 static void *vfio_prereg_gpa_to_vaddr(MemoryRegionSection *section, hwaddr gpa)
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 3e4d416..4d2aa63 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -188,7 +188,7 @@ struct MemoryRegion {
     void (*destructor)(MemoryRegion *mr);
     uint64_t align;
     bool terminates;
-    bool skip_dump;
+    bool ram_device;
     bool enabled;
     bool warning_printed; /* For reservations */
     uint8_t vga_logging_count;
@@ -426,6 +426,30 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
                                 void *ptr);
 
 /**
+ * memory_region_init_ram_device_ptr:  Initialize RAM device memory region from
+ *                                     a user-provided pointer.
+ *
+ * A RAM device represents a mapping to a physical device, such as to a PCI
+ * MMIO BAR of an vfio-pci assigned device.  The memory region may be mapped
+ * into the VM address space and access to the region will modify memory
+ * directly.  However, the memory region should not be included in a memory
+ * dump (device may not be enabled/mapped at the time of the dump), and
+ * operations incompatible with manipulating MMIO should be avoided.  Replaces
+ * skip_dump flag.
+ *
+ * @mr: the #MemoryRegion to be initialized.
+ * @owner: the object that tracks the region's reference count
+ * @name: the name of the region.
+ * @size: size of the region.
+ * @ptr: memory to be mapped; must contain at least @size bytes.
+ */
+void memory_region_init_ram_device_ptr(MemoryRegion *mr,
+                                       struct Object *owner,
+                                       const char *name,
+                                       uint64_t size,
+                                       void *ptr);
+
+/**
  * memory_region_init_alias: Initialize a memory region that aliases all or a
  *                           part of another memory region.
  *
@@ -551,22 +575,13 @@ static inline bool memory_region_is_ram(MemoryRegion *mr)
 }
 
 /**
- * memory_region_is_skip_dump: check whether a memory region should not be
- *                             dumped
- *
- * Returns %true is a memory region should not be dumped(e.g. VFIO BAR MMAP).
+ * memory_region_is_ram_device: check whether a memory region is a ram device
  *
- * @mr: the memory region being queried
- */
-bool memory_region_is_skip_dump(MemoryRegion *mr);
-
-/**
- * memory_region_set_skip_dump: Set skip_dump flag, dump will ignore this memory
- *                              region
+ * Returns %true is a memory region is a device backed ram region
  *
  * @mr: the memory region being queried
  */
-void memory_region_set_skip_dump(MemoryRegion *mr);
+bool memory_region_is_ram_device(MemoryRegion *mr);
 
 /**
  * memory_region_is_romd: check whether a memory region is in ROMD mode
diff --git a/memory.c b/memory.c
index 0eb6895..94c55ae 100644
--- a/memory.c
+++ b/memory.c
@@ -1359,9 +1359,14 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
     mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_fatal);
 }
 
-void memory_region_set_skip_dump(MemoryRegion *mr)
+void memory_region_init_ram_device_ptr(MemoryRegion *mr,
+                                       Object *owner,
+                                       const char *name,
+                                       uint64_t size,
+                                       void *ptr)
 {
-    mr->skip_dump = true;
+    memory_region_init_ram_ptr(mr, owner, name, size, ptr);
+    mr->ram_device = true;
 }
 
 void memory_region_init_alias(MemoryRegion *mr,
@@ -1494,9 +1499,9 @@ const char *memory_region_name(const MemoryRegion *mr)
     return mr->name;
 }
 
-bool memory_region_is_skip_dump(MemoryRegion *mr)
+bool memory_region_is_ram_device(MemoryRegion *mr)
 {
-    return mr->skip_dump;
+    return mr->ram_device;
 }
 
 uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
diff --git a/memory_mapping.c b/memory_mapping.c
index e3e0d95..6a39d71 100644
--- a/memory_mapping.c
+++ b/memory_mapping.c
@@ -206,7 +206,7 @@ static void guest_phys_blocks_region_add(MemoryListener *listener,
 
     /* we only care about RAM */
     if (!memory_region_is_ram(section->mr) ||
-        memory_region_is_skip_dump(section->mr)) {
+        memory_region_is_ram_device(section->mr)) {
         return;
     }
 
-- 
1.9.1

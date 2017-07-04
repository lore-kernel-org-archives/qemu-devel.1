Received: from eggs.gnu.org ([2001:4830:134:3::10]:42017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dSRE0-0001PO-Kx
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 13:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dSRDz-0005Yv-Ig
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 13:02:56 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dSRDz-0005KD-9y
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 13:02:55 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  4 Jul 2017 18:02:42 +0100
Message-Id: <1499187763-8211-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1499187763-8211-1-git-send-email-peter.maydell@linaro.org>
References: <1499187763-8211-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/3] memory.h: Add new utility function
 memory_region_allocate_aux_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Add a new utility function memory_region_allocate_aux_memory()
for board code to use to create auxiliary memory regions (such
as display RAM  or static RAMs). This parallels the existing
memory_region_allocate_system_memory() and wraps up the very
common sequence of:
   memory_region_init_ram(sram, NULL, "sram", 0x10000, &error_fatal);
   vmstate_register_ram_global(sram);

Although this is the parallel function to the existing
memory_region_allocate_system_memory(), we don't put it in
boards.h/numa.c with it because this function is useful for
devices, not just boards, and it has nothing to do with NUMA.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memory.h | 23 +++++++++++++++++++++++
 include/hw/boards.h   |  3 ++-
 memory.c              |  8 ++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 8503685..77fc777 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -412,6 +412,12 @@ void memory_region_init_io(MemoryRegion *mr,
  *        must be unique within any device
  * @size: size of the region.
  * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Note that it is the caller's responsibility to ensure that the contents
+ * of the RAM are migrated (by calling vmstate_register_ram_global(), or
+ * otherwise). The utility function memory_region_allocate_aux_memory()
+ * may be used to combine the "initialize MR" and "register contents for
+ * migration" steps.
  */
 void memory_region_init_ram(MemoryRegion *mr,
                             struct Object *owner,
@@ -631,6 +637,23 @@ void memory_region_init_iommu(MemoryRegion *mr,
                               uint64_t size);
 
 /**
+ * memory_region_allocate_aux_memory - Allocate auxiliary (non-main) memory
+ * @mr: the #MemoryRegion to be initialized
+ * @owner: the object that tracks the region's reference count
+ * @name: name of the memory region
+ * @ram_size: size of the region in bytes
+ *
+ * This function allocates RAM for a board model or device, and
+ * arranges for it to be migrated (by calling vmstate_register_ram_global()).
+ * Board models should call memory_region_allocate_system_memory()
+ * exactly once to allocate the memory for the primary or largest RAM
+ * area on the board, and then can use this function for smaller
+ * pieces of memory such as display RAM or static RAMs.
+ */
+void memory_region_allocate_aux_memory(MemoryRegion *mr, Object *owner,
+                                       const char *name, uint64_t ram_size);
+
+/**
  * memory_region_owner: get a memory region's owner.
  *
  * @mr: the memory region being queried.
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 1bc5389..a127a97 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -35,7 +35,8 @@
  *
  * Smaller pieces of memory (display RAM, static RAMs, etc) don't need
  * to be backed via the -mem-path memory backend and can simply
- * be created via memory_region_init_ram().
+ * be created via memory_region_allocate_aux_memory() or
+ * memory_region_init_ram().
  */
 void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
                                           const char *name,
diff --git a/memory.c b/memory.c
index 1044bba..25ac7d7 100644
--- a/memory.c
+++ b/memory.c
@@ -32,6 +32,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/misc/mmio_interface.h"
 #include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
 
 //#define DEBUG_UNASSIGNED
 
@@ -2817,6 +2818,13 @@ void mtree_info(fprintf_function mon_printf, void *f, bool flatview)
     }
 }
 
+void memory_region_allocate_aux_memory(MemoryRegion *mr, Object *owner,
+                                       const char *name, uint64_t ram_size)
+{
+    memory_region_init_ram(mr, owner, name, ram_size, &error_fatal);
+    vmstate_register_ram_global(mr);
+}
+
 static const TypeInfo memory_region_info = {
     .parent             = TYPE_OBJECT,
     .name               = TYPE_MEMORY_REGION,
-- 
2.7.4

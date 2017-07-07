Received: from eggs.gnu.org ([2001:4830:134:3::10]:54501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dTUTW-0005v7-Bp
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dTUTU-000453-TT
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:18 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dTUTU-00040L-KK
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:16 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jul 2017 15:42:51 +0100
Message-Id: <1499438577-7674-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
References: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 05/11] memory.h: Add memory_region_init_{ram,
 rom, rom_device}() handling migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Add new utility functions which both initialize a RAM
MemoryRegion and arrange for its contents to be migrated;
we give thes the memory_region_init_ram(), memory_region_init_rom()
and memory_region_init_rom_device() names that we just freed up
by renaming the old implementations to _nomigrate().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memory.h | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/boards.h   |  3 +-
 memory.c              | 76 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+), 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index d1c6443..b49b81d 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -658,6 +658,94 @@ void memory_region_init_iommu(MemoryRegion *mr,
                               uint64_t size);
 
 /**
+ * memory_region_init_ram - Initialize RAM memory region.  Accesses into the
+ *                          region will modify memory directly.
+ *
+ * @mr: the #MemoryRegion to be initialized
+ * @owner: the object that tracks the region's reference count (must be
+ *         TYPE_DEVICE or a subclass of TYPE_DEVICE, or NULL)
+ * @name: name of the memory region
+ * @size: size of the region in bytes
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * This function allocates RAM for a board model or device, and
+ * arranges for it to be migrated (by calling vmstate_register_ram()
+ * if @owner is a DeviceState, or vmstate_register_ram_global() if
+ * @owner is NULL).
+ *
+ * TODO: Currently we restrict @owner to being either NULL (for
+ * global RAM regions with no owner) or devices, so that we can
+ * give the RAM block a unique name for migration purposes.
+ * We should lift this restriction and allow arbitrary Objects.
+ * If you pass a non-NULL non-device @owner then we will assert.
+ */
+void memory_region_init_ram(MemoryRegion *mr,
+                            struct Object *owner,
+                            const char *name,
+                            uint64_t size,
+                            Error **errp);
+
+/**
+ * memory_region_init_rom: Initialize a ROM memory region.
+ *
+ * This has the same effect as calling memory_region_init_ram()
+ * and then marking the resulting region read-only with
+ * memory_region_set_readonly(). This includes arranging for the
+ * contents to be migrated.
+ *
+ * TODO: Currently we restrict @owner to being either NULL (for
+ * global RAM regions with no owner) or devices, so that we can
+ * give the RAM block a unique name for migration purposes.
+ * We should lift this restriction and allow arbitrary Objects.
+ * If you pass a non-NULL non-device @owner then we will assert.
+ *
+ * @mr: the #MemoryRegion to be initialized.
+ * @owner: the object that tracks the region's reference count
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
+ * @size: size of the region.
+ * @errp: pointer to Error*, to store an error if it happens.
+ */
+void memory_region_init_rom(MemoryRegion *mr,
+                            struct Object *owner,
+                            const char *name,
+                            uint64_t size,
+                            Error **errp);
+
+/**
+ * memory_region_init_rom_device:  Initialize a ROM memory region.
+ *                                 Writes are handled via callbacks.
+ *
+ * This function initializes a memory region backed by RAM for reads
+ * and callbacks for writes, and arranges for the RAM backing to
+ * be migrated (by calling vmstate_register_ram()
+ * if @owner is a DeviceState, or vmstate_register_ram_global() if
+ * @owner is NULL).
+ *
+ * TODO: Currently we restrict @owner to being either NULL (for
+ * global RAM regions with no owner) or devices, so that we can
+ * give the RAM block a unique name for migration purposes.
+ * We should lift this restriction and allow arbitrary Objects.
+ * If you pass a non-NULL non-device @owner then we will assert.
+ *
+ * @mr: the #MemoryRegion to be initialized.
+ * @owner: the object that tracks the region's reference count
+ * @ops: callbacks for write access handling (must not be NULL).
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
+ * @size: size of the region.
+ * @errp: pointer to Error*, to store an error if it happens.
+ */
+void memory_region_init_rom_device(MemoryRegion *mr,
+                                   struct Object *owner,
+                                   const MemoryRegionOps *ops,
+                                   void *opaque,
+                                   const char *name,
+                                   uint64_t size,
+                                   Error **errp);
+
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
index 5653d3c..17bca58 100644
--- a/memory.c
+++ b/memory.c
@@ -32,6 +32,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/misc/mmio_interface.h"
 #include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
 
 //#define DEBUG_UNASSIGNED
 
@@ -2817,6 +2818,81 @@ void mtree_info(fprintf_function mon_printf, void *f, bool flatview)
     }
 }
 
+void memory_region_init_ram(MemoryRegion *mr,
+                            struct Object *owner,
+                            const char *name,
+                            uint64_t size,
+                            Error **errp)
+{
+    DeviceState *owner_dev;
+    Error *err = NULL;
+
+    memory_region_init_ram_nomigrate(mr, owner, name, size, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    /* This will assert if owner is neither NULL nor a DeviceState.
+     * We only want the owner here for the purposes of defining a
+     * unique name for migration. TODO: Ideally we should implement
+     * a naming scheme for Objects which are not DeviceStates, in
+     * which case we can relax this restriction.
+     */
+    owner_dev = DEVICE(owner);
+    vmstate_register_ram(mr, owner_dev);
+}
+
+void memory_region_init_rom(MemoryRegion *mr,
+                            struct Object *owner,
+                            const char *name,
+                            uint64_t size,
+                            Error **errp)
+{
+    DeviceState *owner_dev;
+    Error *err = NULL;
+
+    memory_region_init_rom_nomigrate(mr, owner, name, size, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    /* This will assert if owner is neither NULL nor a DeviceState.
+     * We only want the owner here for the purposes of defining a
+     * unique name for migration. TODO: Ideally we should implement
+     * a naming scheme for Objects which are not DeviceStates, in
+     * which case we can relax this restriction.
+     */
+    owner_dev = DEVICE(owner);
+    vmstate_register_ram(mr, owner_dev);
+}
+
+void memory_region_init_rom_device(MemoryRegion *mr,
+                                   struct Object *owner,
+                                   const MemoryRegionOps *ops,
+                                   void *opaque,
+                                   const char *name,
+                                   uint64_t size,
+                                   Error **errp)
+{
+    DeviceState *owner_dev;
+    Error *err = NULL;
+
+    memory_region_init_rom_device_nomigrate(mr, owner, ops, opaque,
+                                            name, size, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    /* This will assert if owner is neither NULL nor a DeviceState.
+     * We only want the owner here for the purposes of defining a
+     * unique name for migration. TODO: Ideally we should implement
+     * a naming scheme for Objects which are not DeviceStates, in
+     * which case we can relax this restriction.
+     */
+    owner_dev = DEVICE(owner);
+    vmstate_register_ram(mr, owner_dev);
+}
+
 static const TypeInfo memory_region_info = {
     .parent             = TYPE_OBJECT,
     .name               = TYPE_MEMORY_REGION,
-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clzyE-0008Ua-VH
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 10:27:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1clzyB-0002Bw-P0
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 10:27:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1clzyB-0002Bs-GE
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 10:27:11 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  9 Mar 2017 15:27:08 +0000
Message-Id: <20170309152708.30635-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2] memory_region: Fix name comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The 'name' parameter to memory_region_init_* had been marked as debug
only, however vmstate_region_ram uses it as a parameter to
qemu_ram_set_idstr to set RAMBlock names and these form part of the
migration stream.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
v2
  Reword to state uniqueness
  Only change RAM related calls
  Diff with -U7 so you can see the function names with each comment

 include/exec/memory.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 6911023..6a3d7d5 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -303,15 +303,16 @@ struct MemoryRegionSection {
  * memory_region_init: Initialize a memory region
  *
  * The region typically acts as a container for other memory regions.  Use
  * memory_region_add_subregion() to add subregions.
  *
  * @mr: the #MemoryRegion to be initialized
  * @owner: the object that tracks the region's reference count
- * @name: used for debugging; not visible to the user or ABI
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
  * @size: size of the region; any subregions beyond this size will be clipped
  */
 void memory_region_init(MemoryRegion *mr,
                         struct Object *owner,
                         const char *name,
                         uint64_t size);
 
@@ -367,15 +368,16 @@ void memory_region_init_io(MemoryRegion *mr,
 
 /**
  * memory_region_init_ram:  Initialize RAM memory region.  Accesses into the
  *                          region will modify memory directly.
  *
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
- * @name: the name of the region.
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
  * @size: size of the region.
  * @errp: pointer to Error*, to store an error if it happens.
  */
 void memory_region_init_ram(MemoryRegion *mr,
                             struct Object *owner,
                             const char *name,
                             uint64_t size,
@@ -386,15 +388,16 @@ void memory_region_init_ram(MemoryRegion *mr,
  *                                     RAM.  Accesses into the region will
  *                                     modify memory directly.  Only an initial
  *                                     portion of this RAM is actually used.
  *                                     The used size can change across reboots.
  *
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
- * @name: the name of the region.
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
  * @size: used size of the region.
  * @max_size: max size of the region.
  * @resized: callback to notify owner about used size change.
  * @errp: pointer to Error*, to store an error if it happens.
  */
 void memory_region_init_resizeable_ram(MemoryRegion *mr,
                                        struct Object *owner,
@@ -408,15 +411,16 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
 #ifdef __linux__
 /**
  * memory_region_init_ram_from_file:  Initialize RAM memory region with a
  *                                    mmap-ed backend.
  *
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
- * @name: the name of the region.
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
  * @size: size of the region.
  * @share: %true if memory must be mmaped with the MAP_SHARED flag
  * @path: the path in which to allocate the RAM.
  * @errp: pointer to Error*, to store an error if it happens.
  */
 void memory_region_init_ram_from_file(MemoryRegion *mr,
                                       struct Object *owner,
@@ -430,15 +434,16 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
 /**
  * memory_region_init_ram_ptr:  Initialize RAM memory region from a
  *                              user-provided pointer.  Accesses into the
  *                              region will modify memory directly.
  *
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
- * @name: the name of the region.
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
  * @size: size of the region.
  * @ptr: memory to be mapped; must contain at least @size bytes.
  */
 void memory_region_init_ram_ptr(MemoryRegion *mr,
                                 struct Object *owner,
                                 const char *name,
                                 uint64_t size,
@@ -492,15 +497,16 @@ void memory_region_init_alias(MemoryRegion *mr,
  *
  * This has the same effect as calling memory_region_init_ram()
  * and then marking the resulting region read-only with
  * memory_region_set_readonly().
  *
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
- * @name: the name of the region.
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
  * @size: size of the region.
  * @errp: pointer to Error*, to store an error if it happens.
  */
 void memory_region_init_rom(MemoryRegion *mr,
                             struct Object *owner,
                             const char *name,
                             uint64_t size,
@@ -509,15 +515,16 @@ void memory_region_init_rom(MemoryRegion *mr,
 /**
  * memory_region_init_rom_device:  Initialize a ROM memory region.  Writes are
  *                                 handled via callbacks.
  *
  * @mr: the #MemoryRegion to be initialized.
  * @owner: the object that tracks the region's reference count
  * @ops: callbacks for write access handling (must not be NULL).
- * @name: the name of the region.
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
  * @size: size of the region.
  * @errp: pointer to Error*, to store an error if it happens.
  */
 void memory_region_init_rom_device(MemoryRegion *mr,
                                    struct Object *owner,
                                    const MemoryRegionOps *ops,
                                    void *opaque,
-- 
2.9.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ctZUT-0000m8-2F
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ctZUP-0006AE-7l
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:47:49 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 30 Mar 2017 23:47:03 +1100
Message-Id: <20170330124707.28142-2-aik@ozlabs.ru>
In-Reply-To: <20170330124707.28142-1-aik@ozlabs.ru>
References: <20170330124707.28142-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [RFC PATCH qemu 1/5] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/exec/memory.h         |  50 ++++++++++++++++----
 include/hw/ppc/spapr.h        |   3 +-
 include/hw/vfio/vfio-common.h |   2 +-
 include/qemu/typedefs.h       |   1 +
 exec.c                        |  16 +++++--
 hw/ppc/spapr_iommu.c          |  20 ++++----
 hw/vfio/common.c              |  12 +++--
 hw/vfio/spapr.c               |   3 +-
 memory.c                      | 106 ++++++++++++++++++++++++++++--------------
 9 files changed, 148 insertions(+), 65 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e39256ad03..479d8fbfe2 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -37,6 +37,10 @@
 #define MEMORY_REGION(obj) \
         OBJECT_CHECK(MemoryRegion, (obj), TYPE_MEMORY_REGION)
 
+#define TYPE_IOMMU_MEMORY_REGION "qemu:iommu-memory-region"
+#define IOMMU_MEMORY_REGION(obj) \
+        OBJECT_CHECK(IOMMUMemoryRegion, (obj), TYPE_IOMMU_MEMORY_REGION)
+
 typedef struct MemoryRegionOps MemoryRegionOps;
 typedef struct MemoryRegionMmio MemoryRegionMmio;
 
@@ -167,11 +171,12 @@ typedef struct MemoryRegionIOMMUOps MemoryRegionIOMMUOps;
 
 struct MemoryRegionIOMMUOps {
     /* Return a TLB entry that contains a given address. */
-    IOMMUTLBEntry (*translate)(MemoryRegion *iommu, hwaddr addr, bool is_write);
+    IOMMUTLBEntry (*translate)(IOMMUMemoryRegion *iommu, hwaddr addr,
+                               bool is_write);
     /* Returns minimum supported page size */
-    uint64_t (*get_min_page_size)(MemoryRegion *iommu);
+    uint64_t (*get_min_page_size)(IOMMUMemoryRegion *iommu);
     /* Called when IOMMU Notifier flag changed */
-    void (*notify_flag_changed)(MemoryRegion *iommu,
+    void (*notify_flag_changed)(IOMMUMemoryRegion *iommu,
                                 IOMMUNotifierFlag old_flags,
                                 IOMMUNotifierFlag new_flags);
 };
@@ -195,7 +200,6 @@ struct MemoryRegion {
     uint8_t dirty_log_mask;
     RAMBlock *ram_block;
     Object *owner;
-    const MemoryRegionIOMMUOps *iommu_ops;
 
     const MemoryRegionOps *ops;
     void *opaque;
@@ -218,6 +222,12 @@ struct MemoryRegion {
     const char *name;
     unsigned ioeventfd_nb;
     MemoryRegionIoeventfd *ioeventfds;
+};
+
+struct IOMMUMemoryRegion {
+    MemoryRegion parent_obj;
+
+    const MemoryRegionIOMMUOps *iommu_ops;
     QLIST_HEAD(, IOMMUNotifier) iommu_notify;
     IOMMUNotifierFlag iommu_notify_flags;
 };
@@ -555,19 +565,39 @@ static inline void memory_region_init_reservation(MemoryRegion *mr,
 }
 
 /**
+ * memory_region_init_iommu_type: Initialize a memory region of a custom type
+ * that translates addresses
+ *
+ * An IOMMU region translates addresses and forwards accesses to a target
+ * memory region.
+ *
+ * @typename: QOM class name
+ * @mr: the #IOMMUMemoryRegion to be initialized
+ * @owner: the object that tracks the region's reference count
+ * @ops: a function that translates addresses into the @target region
+ * @name: used for debugging; not visible to the user or ABI
+ * @size: size of the region.
+ */
+void memory_region_init_iommu_type(const char *mrtypename,
+                                   IOMMUMemoryRegion *iommumr,
+                                   Object *owner,
+                                   const MemoryRegionIOMMUOps *ops,
+                                   const char *name,
+                                   uint64_t size);
+/**
  * memory_region_init_iommu: Initialize a memory region that translates
  * addresses
  *
  * An IOMMU region translates addresses and forwards accesses to a target
  * memory region.
  *
- * @mr: the #MemoryRegion to be initialized
+ * @mr: the #IOMMUMemoryRegion to be initialized
  * @owner: the object that tracks the region's reference count
  * @ops: a function that translates addresses into the @target region
  * @name: used for debugging; not visible to the user or ABI
  * @size: size of the region.
  */
-void memory_region_init_iommu(MemoryRegion *mr,
+void memory_region_init_iommu(IOMMUMemoryRegion *iommumr,
                               struct Object *owner,
                               const MemoryRegionIOMMUOps *ops,
                               const char *name,
@@ -633,7 +663,7 @@ static inline bool memory_region_is_iommu(MemoryRegion *mr)
     if (mr->alias) {
         return memory_region_is_iommu(mr->alias);
     }
-    return mr->iommu_ops;
+    return object_dynamic_cast(OBJECT(mr), TYPE_IOMMU_MEMORY_REGION) != NULL;
 }
 
 
@@ -645,7 +675,7 @@ static inline bool memory_region_is_iommu(MemoryRegion *mr)
  *
  * @mr: the memory region being queried
  */
-uint64_t memory_region_iommu_get_min_page_size(MemoryRegion *mr);
+uint64_t memory_region_iommu_get_min_page_size(IOMMUMemoryRegion *mr);
 
 /**
  * memory_region_notify_iommu: notify a change in an IOMMU translation entry.
@@ -664,7 +694,7 @@ uint64_t memory_region_iommu_get_min_page_size(MemoryRegion *mr);
  *         replaces all old entries for the same virtual I/O address range.
  *         Deleted entries have .@perm == 0.
  */
-void memory_region_notify_iommu(MemoryRegion *mr,
+void memory_region_notify_iommu(IOMMUMemoryRegion *mr,
                                 IOMMUTLBEntry entry);
 
 /**
@@ -689,7 +719,7 @@ void memory_region_register_iommu_notifier(MemoryRegion *mr,
  * @is_write: Whether to treat the replay as a translate "write"
  *     through the iommu
  */
-void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
+void memory_region_iommu_replay(IOMMUMemoryRegion *mr, IOMMUNotifier *n,
                                 bool is_write);
 
 /**
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index e27de64d31..6997ed7e98 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -590,7 +590,8 @@ struct sPAPRTCETable {
     bool bypass;
     bool need_vfio;
     int fd;
-    MemoryRegion root, iommu;
+    MemoryRegion root;
+    IOMMUMemoryRegion iommu;
     struct VIOsPAPRDevice *vdev; /* for @bypass migration compatibility only */
     QLIST_ENTRY(sPAPRTCETable) list;
 };
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c582de18c9..7a4135ae6f 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -94,7 +94,7 @@ typedef struct VFIOContainer {
 
 typedef struct VFIOGuestIOMMU {
     VFIOContainer *container;
-    MemoryRegion *iommu;
+    IOMMUMemoryRegion *iommu;
     hwaddr iommu_offset;
     IOMMUNotifier n;
     QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index e95f28cfec..b45f71ec11 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -45,6 +45,7 @@ typedef struct MachineState MachineState;
 typedef struct MemoryListener MemoryListener;
 typedef struct MemoryMappingList MemoryMappingList;
 typedef struct MemoryRegion MemoryRegion;
+typedef struct IOMMUMemoryRegion IOMMUMemoryRegion;
 typedef struct MemoryRegionCache MemoryRegionCache;
 typedef struct MemoryRegionSection MemoryRegionSection;
 typedef struct MigrationIncomingState MigrationIncomingState;
diff --git a/exec.c b/exec.c
index e57a8a2178..3b47dad1f8 100644
--- a/exec.c
+++ b/exec.c
@@ -463,6 +463,7 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
     IOMMUTLBEntry iotlb = {0};
     MemoryRegionSection *section;
     MemoryRegion *mr;
+    IOMMUMemoryRegion *iommumr;
 
     for (;;) {
         AddressSpaceDispatch *d = atomic_rcu_read(&as->dispatch);
@@ -471,11 +472,13 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
                + section->offset_within_region;
         mr = section->mr;
 
-        if (!mr->iommu_ops) {
+        if (!memory_region_is_iommu(mr)) {
             break;
         }
 
-        iotlb = mr->iommu_ops->translate(mr, addr, is_write);
+        iommumr = IOMMU_MEMORY_REGION(mr);
+
+        iotlb = iommumr->iommu_ops->translate(iommumr, addr, is_write);
         if (!(iotlb.perm & (1 << is_write))) {
             iotlb.target_as = NULL;
             break;
@@ -497,17 +500,20 @@ MemoryRegion *address_space_translate(AddressSpace *as, hwaddr addr,
     IOMMUTLBEntry iotlb;
     MemoryRegionSection *section;
     MemoryRegion *mr;
+    IOMMUMemoryRegion *iommumr;
 
     for (;;) {
         AddressSpaceDispatch *d = atomic_rcu_read(&as->dispatch);
         section = address_space_translate_internal(d, addr, &addr, plen, true);
         mr = section->mr;
 
-        if (!mr->iommu_ops) {
+        if (!memory_region_is_iommu(mr)) {
             break;
         }
 
-        iotlb = mr->iommu_ops->translate(mr, addr, is_write);
+        iommumr = IOMMU_MEMORY_REGION(mr);
+
+        iotlb = iommumr->iommu_ops->translate(iommumr, addr, is_write);
         addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
                 | (addr & iotlb.addr_mask));
         *plen = MIN(*plen, (addr | iotlb.addr_mask) - addr + 1);
@@ -538,7 +544,7 @@ address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
 
     section = address_space_translate_internal(d, addr, xlat, plen, false);
 
-    assert(!section->mr->iommu_ops);
+    assert(!memory_region_is_iommu(section->mr));
     return section;
 }
 #endif
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 9e30e148d6..5051110b9d 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -110,7 +110,8 @@ static void spapr_tce_free_table(uint64_t *table, int fd, uint32_t nb_table)
 }
 
 /* Called from RCU critical section */
-static IOMMUTLBEntry spapr_tce_translate_iommu(MemoryRegion *iommu, hwaddr addr,
+static IOMMUTLBEntry spapr_tce_translate_iommu(IOMMUMemoryRegion *iommu,
+                                               hwaddr addr,
                                                bool is_write)
 {
     sPAPRTCETable *tcet = container_of(iommu, sPAPRTCETable, iommu);
@@ -150,14 +151,14 @@ static void spapr_tce_table_pre_save(void *opaque)
                                tcet->bus_offset, tcet->page_shift);
 }
 
-static uint64_t spapr_tce_get_min_page_size(MemoryRegion *iommu)
+static uint64_t spapr_tce_get_min_page_size(IOMMUMemoryRegion *iommu)
 {
     sPAPRTCETable *tcet = container_of(iommu, sPAPRTCETable, iommu);
 
     return 1ULL << tcet->page_shift;
 }
 
-static void spapr_tce_notify_flag_changed(MemoryRegion *iommu,
+static void spapr_tce_notify_flag_changed(IOMMUMemoryRegion *iommu,
                                           IOMMUNotifierFlag old,
                                           IOMMUNotifierFlag new)
 {
@@ -265,7 +266,9 @@ static int spapr_tce_table_realize(DeviceState *dev)
     memory_region_init(&tcet->root, tcetobj, tmp, UINT64_MAX);
 
     snprintf(tmp, sizeof(tmp), "tce-iommu-%x", tcet->liobn);
-    memory_region_init_iommu(&tcet->iommu, tcetobj, &spapr_iommu_ops, tmp, 0);
+    memory_region_init_iommu_type(TYPE_IOMMU_MEMORY_REGION,
+                                  &tcet->iommu, tcetobj, &spapr_iommu_ops,
+                                  tmp, 0);
 
     QLIST_INSERT_HEAD(&spapr_tce_tables, tcet, list);
 
@@ -341,9 +344,10 @@ void spapr_tce_table_enable(sPAPRTCETable *tcet,
                                         &tcet->fd,
                                         tcet->need_vfio);
 
-    memory_region_set_size(&tcet->iommu,
+    memory_region_set_size(MEMORY_REGION(&tcet->iommu),
                            (uint64_t)tcet->nb_table << tcet->page_shift);
-    memory_region_add_subregion(&tcet->root, tcet->bus_offset, &tcet->iommu);
+    memory_region_add_subregion(&tcet->root, tcet->bus_offset,
+                                MEMORY_REGION(&tcet->iommu));
 }
 
 void spapr_tce_table_disable(sPAPRTCETable *tcet)
@@ -352,8 +356,8 @@ void spapr_tce_table_disable(sPAPRTCETable *tcet)
         return;
     }
 
-    memory_region_del_subregion(&tcet->root, &tcet->iommu);
-    memory_region_set_size(&tcet->iommu, 0);
+    memory_region_del_subregion(&tcet->root, MEMORY_REGION(&tcet->iommu));
+    memory_region_set_size(MEMORY_REGION(&tcet->iommu), 0);
 
     spapr_tce_free_table(tcet->table, tcet->fd, tcet->nb_table);
     tcet->fd = -1;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f3ba9b9007..ab95db689c 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -465,6 +465,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
 
     if (memory_region_is_iommu(section->mr)) {
         VFIOGuestIOMMU *giommu;
+        IOMMUMemoryRegion *iommumr = IOMMU_MEMORY_REGION(section->mr);
 
         trace_vfio_listener_region_add_iommu(iova, end);
         /*
@@ -474,7 +475,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
          * device emulation the VFIO iommu handles to use).
          */
         giommu = g_malloc0(sizeof(*giommu));
-        giommu->iommu = section->mr;
+        giommu->iommu = iommumr;
         giommu->iommu_offset = section->offset_within_address_space -
                                section->offset_within_region;
         giommu->container = container;
@@ -482,7 +483,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
         giommu->n.notifier_flags = IOMMU_NOTIFIER_ALL;
         QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
 
-        memory_region_register_iommu_notifier(giommu->iommu, &giommu->n);
+        memory_region_register_iommu_notifier(section->mr, &giommu->n);
         memory_region_iommu_replay(giommu->iommu, &giommu->n, false);
 
         return;
@@ -550,8 +551,8 @@ static void vfio_listener_region_del(MemoryListener *listener,
         VFIOGuestIOMMU *giommu;
 
         QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
-            if (giommu->iommu == section->mr) {
-                memory_region_unregister_iommu_notifier(giommu->iommu,
+            if (MEMORY_REGION(giommu->iommu) == section->mr) {
+                memory_region_unregister_iommu_notifier(section->mr,
                                                         &giommu->n);
                 QLIST_REMOVE(giommu, giommu_next);
                 g_free(giommu);
@@ -1141,7 +1142,8 @@ static void vfio_disconnect_container(VFIOGroup *group)
         QLIST_REMOVE(container, next);
 
         QLIST_FOREACH_SAFE(giommu, &container->giommu_list, giommu_next, tmp) {
-            memory_region_unregister_iommu_notifier(giommu->iommu, &giommu->n);
+            memory_region_unregister_iommu_notifier(
+                    MEMORY_REGION(giommu->iommu), &giommu->n);
             QLIST_REMOVE(giommu, giommu_next);
             g_free(giommu);
         }
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 4409bcc0d7..551870d46b 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -143,7 +143,8 @@ int vfio_spapr_create_window(VFIOContainer *container,
                              hwaddr *pgsize)
 {
     int ret;
-    unsigned pagesize = memory_region_iommu_get_min_page_size(section->mr);
+    IOMMUMemoryRegion *iommumr = IOMMU_MEMORY_REGION(section->mr);
+    unsigned pagesize = memory_region_iommu_get_min_page_size(iommumr);
     unsigned entries, pages;
     struct vfio_iommu_spapr_tce_create create = { .argsz = sizeof(create) };
 
diff --git a/memory.c b/memory.c
index 4c95aaf39c..036abd78dc 100644
--- a/memory.c
+++ b/memory.c
@@ -975,12 +975,11 @@ static char *memory_region_escape_name(const char *name)
     return escaped;
 }
 
-void memory_region_init(MemoryRegion *mr,
-                        Object *owner,
-                        const char *name,
-                        uint64_t size)
+static void memory_region_do_init(MemoryRegion *mr,
+                                  Object *owner,
+                                  const char *name,
+                                  uint64_t size)
 {
-    object_initialize(mr, sizeof(*mr), TYPE_MEMORY_REGION);
     mr->size = int128_make64(size);
     if (size == UINT64_MAX) {
         mr->size = int128_2_64();
@@ -1004,6 +1003,15 @@ void memory_region_init(MemoryRegion *mr,
     }
 }
 
+void memory_region_init(MemoryRegion *mr,
+                        Object *owner,
+                        const char *name,
+                        uint64_t size)
+{
+    object_initialize(mr, sizeof(*mr), TYPE_MEMORY_REGION);
+    memory_region_do_init(mr, owner, name, size);
+}
+
 static void memory_region_get_addr(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
@@ -1473,17 +1481,33 @@ void memory_region_init_rom_device(MemoryRegion *mr,
     mr->ram_block = qemu_ram_alloc(size, mr, errp);
 }
 
-void memory_region_init_iommu(MemoryRegion *mr,
-                              Object *owner,
-                              const MemoryRegionIOMMUOps *ops,
-                              const char *name,
-                              uint64_t size)
+void memory_region_init_iommu_type(const char *mrtypename,
+                                   IOMMUMemoryRegion *iommumr,
+                                   Object *owner,
+                                   const MemoryRegionIOMMUOps *ops,
+                                   const char *name,
+                                   uint64_t size)
 {
-    memory_region_init(mr, owner, name, size);
-    mr->iommu_ops = ops,
+    struct MemoryRegion *mr;
+    size_t instance_size = object_type_get_instance_size(mrtypename);
+
+    object_initialize(iommumr, instance_size, mrtypename);
+    mr = MEMORY_REGION(iommumr);
+    memory_region_do_init(mr, owner, name, size);
+    iommumr->iommu_ops = ops,
     mr->terminates = true;  /* then re-forwards */
-    QLIST_INIT(&mr->iommu_notify);
-    mr->iommu_notify_flags = IOMMU_NOTIFIER_NONE;
+    QLIST_INIT(&iommumr->iommu_notify);
+    iommumr->iommu_notify_flags = IOMMU_NOTIFIER_NONE;
+}
+
+void memory_region_init_iommu(IOMMUMemoryRegion *iommumr,
+                              Object *owner,
+                              const MemoryRegionIOMMUOps *ops,
+                              const char *name,
+                              uint64_t size)
+{
+    memory_region_init_iommu_type(TYPE_IOMMU_MEMORY_REGION, iommumr,
+                                  owner, ops, name, size);
 }
 
 static void memory_region_finalize(Object *obj)
@@ -1578,57 +1602,61 @@ bool memory_region_is_logging(MemoryRegion *mr, uint8_t client)
     return memory_region_get_dirty_log_mask(mr) & (1 << client);
 }
 
-static void memory_region_update_iommu_notify_flags(MemoryRegion *mr)
+static void memory_region_update_iommu_notify_flags(IOMMUMemoryRegion *iommumr)
 {
     IOMMUNotifierFlag flags = IOMMU_NOTIFIER_NONE;
     IOMMUNotifier *iommu_notifier;
 
-    QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
+    QLIST_FOREACH(iommu_notifier, &iommumr->iommu_notify, node) {
         flags |= iommu_notifier->notifier_flags;
     }
 
-    if (flags != mr->iommu_notify_flags &&
-        mr->iommu_ops->notify_flag_changed) {
-        mr->iommu_ops->notify_flag_changed(mr, mr->iommu_notify_flags,
-                                           flags);
+    if (flags != iommumr->iommu_notify_flags &&
+        iommumr->iommu_ops->notify_flag_changed) {
+        iommumr->iommu_ops->notify_flag_changed(iommumr,
+                                                iommumr->iommu_notify_flags,
+                                                flags);
     }
 
-    mr->iommu_notify_flags = flags;
+    iommumr->iommu_notify_flags = flags;
 }
 
 void memory_region_register_iommu_notifier(MemoryRegion *mr,
                                            IOMMUNotifier *n)
 {
+    IOMMUMemoryRegion *iommumr;
+
     if (mr->alias) {
         memory_region_register_iommu_notifier(mr->alias, n);
         return;
     }
 
     /* We need to register for at least one bitfield */
+    iommumr = IOMMU_MEMORY_REGION(mr);
     assert(n->notifier_flags != IOMMU_NOTIFIER_NONE);
-    QLIST_INSERT_HEAD(&mr->iommu_notify, n, node);
-    memory_region_update_iommu_notify_flags(mr);
+    QLIST_INSERT_HEAD(&iommumr->iommu_notify, n, node);
+    memory_region_update_iommu_notify_flags(iommumr);
 }
 
-uint64_t memory_region_iommu_get_min_page_size(MemoryRegion *mr)
+uint64_t memory_region_iommu_get_min_page_size(IOMMUMemoryRegion *iommumr)
 {
-    assert(memory_region_is_iommu(mr));
-    if (mr->iommu_ops && mr->iommu_ops->get_min_page_size) {
-        return mr->iommu_ops->get_min_page_size(mr);
+    if (iommumr->iommu_ops && iommumr->iommu_ops->get_min_page_size) {
+        return iommumr->iommu_ops->get_min_page_size(iommumr);
     }
     return TARGET_PAGE_SIZE;
 }
 
-void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
+void memory_region_iommu_replay(IOMMUMemoryRegion *iommumr, IOMMUNotifier *n,
                                 bool is_write)
 {
+    MemoryRegion *mr = MEMORY_REGION(iommumr);
     hwaddr addr, granularity;
     IOMMUTLBEntry iotlb;
 
-    granularity = memory_region_iommu_get_min_page_size(mr);
+    granularity = memory_region_iommu_get_min_page_size(iommumr);
 
     for (addr = 0; addr < memory_region_size(mr); addr += granularity) {
-        iotlb = mr->iommu_ops->translate(mr, addr, is_write);
+        iotlb = iommumr->iommu_ops->translate(iommumr, addr, is_write);
         if (iotlb.perm != IOMMU_NONE) {
             n->notify(n, &iotlb);
         }
@@ -1644,21 +1672,24 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
 void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
                                              IOMMUNotifier *n)
 {
+    IOMMUMemoryRegion *iommumr;
+
     if (mr->alias) {
         memory_region_unregister_iommu_notifier(mr->alias, n);
         return;
     }
     QLIST_REMOVE(n, node);
-    memory_region_update_iommu_notify_flags(mr);
+    iommumr = IOMMU_MEMORY_REGION(mr);
+    memory_region_update_iommu_notify_flags(iommumr);
 }
 
-void memory_region_notify_iommu(MemoryRegion *mr,
+void memory_region_notify_iommu(IOMMUMemoryRegion *iommumr,
                                 IOMMUTLBEntry entry)
 {
     IOMMUNotifier *iommu_notifier;
     IOMMUNotifierFlag request_flags;
 
-    assert(memory_region_is_iommu(mr));
+    assert(memory_region_is_iommu(MEMORY_REGION(iommumr)));
 
     if (entry.perm & IOMMU_RW) {
         request_flags = IOMMU_NOTIFIER_MAP;
@@ -1666,7 +1697,7 @@ void memory_region_notify_iommu(MemoryRegion *mr,
         request_flags = IOMMU_NOTIFIER_UNMAP;
     }
 
-    QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
+    QLIST_FOREACH(iommu_notifier, &iommumr->iommu_notify, node) {
         if (iommu_notifier->notifier_flags & request_flags) {
             iommu_notifier->notify(iommu_notifier, &entry);
         }
@@ -2660,9 +2691,16 @@ static const TypeInfo memory_region_info = {
     .instance_finalize  = memory_region_finalize,
 };
 
+static const TypeInfo iommu_memory_region_info = {
+    .parent             = TYPE_MEMORY_REGION,
+    .name               = TYPE_IOMMU_MEMORY_REGION,
+    .instance_size      = sizeof(IOMMUMemoryRegion),
+};
+
 static void memory_register_types(void)
 {
     type_register_static(&memory_region_info);
+    type_register_static(&iommu_memory_region_info);
 }
 
 type_init(memory_register_types)
-- 
2.11.0

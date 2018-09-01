Received: from eggs.gnu.org ([2001:4830:134:3::10]:54953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fw6qM-0005sK-FV
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 10:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fw6oq-0005mP-3v
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 10:24:09 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Sat,  1 Sep 2018 16:23:02 +0200
Message-Id: <20180901142312.11662-11-eric.auger@redhat.com>
In-Reply-To: <20180901142312.11662-1-eric.auger@redhat.com>
References: <20180901142312.11662-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 10/20] memory: Add IOMMUConfigNotifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: alex.williamson@redhat.com, mst@redhat.com, cdall@kernel.org, jean-philippe.brucker@arm.com, peterx@redhat.com, yi.l.liu@intel.com

With this patch, an IOMMUNotifier can now be either
an IOTLB notifier or a config notifier. A config notifier
is supposed to be called on guest translation config change.
This gives host a chance to update the physical IOMMU
configuration so that is consistent with the guest view.

The notifier is passed an iommu_guest_stage_config struct.

We introduce the associated helpers, iommu_config_notifier_init,
memory_region_config_notify_iommu

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/common.c      | 14 ++++++++----
 include/exec/memory.h | 52 +++++++++++++++++++++++++++++++++++++++++--
 memory.c              | 32 ++++++++++++++++++++++++--
 3 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b6673fcf49..7bd3cc250d 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -624,10 +624,16 @@ static void vfio_listener_region_del(MemoryListener *listener,
         VFIOGuestIOMMU *giommu;
 
         QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
-            if (MEMORY_REGION(giommu->iommu) == section->mr &&
-                giommu->n.iotlb_notifier.start == section->offset_within_region) {
-                memory_region_unregister_iommu_notifier(section->mr,
-                                                        &giommu->n);
+            if (MEMORY_REGION(giommu->iommu) == section->mr) {
+                if (is_iommu_iotlb_notifier(&giommu->n) &&
+                    giommu->n.iotlb_notifier.start ==
+                        section->offset_within_region) {
+                    memory_region_unregister_iommu_notifier(section->mr,
+                                                            &giommu->n);
+                } else if (is_iommu_config_notifier(&giommu->n)) {
+                    memory_region_unregister_iommu_notifier(section->mr,
+                                                            &giommu->n);
+                }
                 QLIST_REMOVE(giommu, giommu_next);
                 g_free(giommu);
                 break;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 5ef9bf6d21..e89fd95fc5 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -84,13 +84,23 @@ typedef enum {
     IOMMU_NOTIFIER_UNMAP = 0x1,
     /* Notify entry changes (newly created entries) */
     IOMMU_NOTIFIER_MAP = 0x2,
+    /* Notify stage 1 config changes */
+    IOMMU_NOTIFIER_S1_CFG = 0x4,
 } IOMMUNotifierFlag;
 
 #define IOMMU_NOTIFIER_IOTLB_ALL (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP)
+#define IOMMU_NOTIFIER_CONFIG_ALL (IOMMU_NOTIFIER_S1_CFG)
+
+typedef enum {
+    IOMMU_ARM_SMMUV3 = 0x1,
+} IOMMUStage1ConfigType;
 
 struct IOMMUNotifier;
+struct iommu_guest_stage_config;
 typedef void (*IOMMUNotify)(struct IOMMUNotifier *notifier,
                             IOMMUTLBEntry *data);
+typedef void (*IOMMUConfigNotify)(struct IOMMUNotifier *notifier,
+                                  struct iommu_guest_stage_config *cfg);
 
 typedef struct IOMMUIOLTBNotifier {
     IOMMUNotify notify;
@@ -99,9 +109,16 @@ typedef struct IOMMUIOLTBNotifier {
     hwaddr end;
 } IOMMUIOLTBNotifier;
 
+typedef struct IOMMUConfigNotifier {
+    IOMMUConfigNotify notify;
+} IOMMUConfigNotifier;
+
 struct IOMMUNotifier {
     IOMMUNotifierFlag notifier_flags;
-    IOMMUIOLTBNotifier iotlb_notifier;
+    union {
+        IOMMUIOLTBNotifier iotlb_notifier;
+        IOMMUConfigNotifier config_notifier;
+    };
     int iommu_idx;
     QLIST_ENTRY(IOMMUNotifier) node;
 };
@@ -143,6 +160,15 @@ static inline void iommu_iotlb_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
     n->iommu_idx = iommu_idx;
 }
 
+static inline void iommu_config_notifier_init(IOMMUNotifier *n,
+                                              IOMMUConfigNotify fn,
+                                              int iommu_idx)
+{
+    n->notifier_flags = IOMMU_NOTIFIER_S1_CFG;
+    n->iommu_idx = iommu_idx;
+    n->config_notifier.notify = fn;
+}
+
 /*
  * Memory region callbacks
  */
@@ -639,6 +665,17 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
                                                        uint64_t length,
                                                        void *host),
                                        Error **errp);
+
+static inline bool is_iommu_iotlb_notifier(IOMMUNotifier *n)
+{
+    return n->notifier_flags & IOMMU_NOTIFIER_IOTLB_ALL;
+}
+
+static inline bool is_iommu_config_notifier(IOMMUNotifier *n)
+{
+    return n->notifier_flags & IOMMU_NOTIFIER_CONFIG_ALL;
+}
+
 #ifdef __linux__
 
 /**
@@ -1045,6 +1082,17 @@ void memory_region_iotlb_notify_iommu(IOMMUMemoryRegion *iommu_mr,
                                       int iommu_idx,
                                       IOMMUTLBEntry entry);
 
+/**
+ * memory_region_config_notify_iommu: notify a change in a translation
+ * configuration structure.
+ * @iommu_mr: the memory region that was changed
+ * @iommu_idx: the IOMMU index for the translation table which has changed
+ * @config: new guest config
+ */
+void memory_region_config_notify_iommu(IOMMUMemoryRegion *iommu_mr,
+                                       int iommu_idx,
+                                       struct iommu_guest_stage_config *config);
+
 /**
  * memory_region_iotlb_notify_one: notify a change in an IOMMU translation
  *                                 entry to a single notifier
@@ -1062,7 +1110,7 @@ void memory_region_iotlb_notify_one(IOMMUNotifier *notifier,
 
 /**
  * memory_region_register_iommu_notifier: register a notifier for changes to
- * IOMMU translation entries.
+ * IOMMU translation entries or translation config settings.
  *
  * @mr: the memory region to observe
  * @n: the IOMMUNotifier to be added; the notify callback receives a
diff --git a/memory.c b/memory.c
index 8ee5cbdbad..ea2a09b0dd 100644
--- a/memory.c
+++ b/memory.c
@@ -49,6 +49,8 @@ static GHashTable *flat_views;
 
 typedef struct AddrRange AddrRange;
 
+struct iommu_guest_stage_config;
+
 /*
  * Note that signed integers are needed for negative offsetting in aliases
  * (large MemoryRegion::alias_offset).
@@ -1800,7 +1802,9 @@ void memory_region_register_iommu_notifier(MemoryRegion *mr,
     /* We need to register for at least one bitfield */
     iommu_mr = IOMMU_MEMORY_REGION(mr);
     assert(n->notifier_flags != IOMMU_NOTIFIER_NONE);
-    assert(n->iotlb_notifier.start <= n->iotlb_notifier.end);
+    if (is_iommu_iotlb_notifier(n)) {
+        assert(n->iotlb_notifier.start <= n->iotlb_notifier.end);
+    }
     assert(n->iommu_idx >= 0 &&
            n->iommu_idx < memory_region_iommu_num_indexes(iommu_mr));
 
@@ -1870,6 +1874,13 @@ void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
     memory_region_update_iommu_notify_flags(iommu_mr);
 }
 
+static void
+memory_region_config_notify_one(IOMMUNotifier *notifier,
+                                struct iommu_guest_stage_config *cfg)
+{
+    notifier->config_notifier.notify(notifier, cfg);
+}
+
 void memory_region_iotlb_notify_one(IOMMUNotifier *notifier,
                                     IOMMUTLBEntry *entry)
 {
@@ -1904,12 +1915,29 @@ void memory_region_iotlb_notify_iommu(IOMMUMemoryRegion *iommu_mr,
     assert(memory_region_is_iommu(MEMORY_REGION(iommu_mr)));
 
     IOMMU_NOTIFIER_FOREACH(iommu_notifier, iommu_mr) {
-        if (iommu_notifier->iommu_idx == iommu_idx) {
+        if (iommu_notifier->iommu_idx == iommu_idx &&
+            is_iommu_iotlb_notifier(iommu_notifier)) {
             memory_region_iotlb_notify_one(iommu_notifier, &entry);
         }
     }
 }
 
+void memory_region_config_notify_iommu(IOMMUMemoryRegion *iommu_mr,
+                                       int iommu_idx,
+                                       struct iommu_guest_stage_config *config)
+{
+    IOMMUNotifier *iommu_notifier;
+
+    assert(memory_region_is_iommu(MEMORY_REGION(iommu_mr)));
+
+    IOMMU_NOTIFIER_FOREACH(iommu_notifier, iommu_mr) {
+        if (iommu_notifier->iommu_idx == iommu_idx &&
+            is_iommu_config_notifier(iommu_notifier)) {
+            memory_region_config_notify_one(iommu_notifier, config);
+        }
+    }
+}
+
 int memory_region_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
                                  enum IOMMUMemoryRegionAttr attr,
                                  void *data)
-- 
2.17.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpfe-0006N5-Qp
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpfd-0003oc-SN
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:23:54 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  1 Sep 2017 19:21:16 +0200
Message-Id: <1504286483-23327-14-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v7 13/20] hw/arm/smmuv3: Implement IOMMU memory
 region replay callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com, alex.williamson@redhat.com
Cc: drjones@redhat.com, christoffer.dall@linaro.org, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mohun106@gmail.com, tcain@qti.qualcomm.com, bharat.bhushan@nxp.com, tn@semihalf.com, mst@redhat.com, will.deacon@arm.com, jean-philippe.brucker@arm.com, robin.murphy@arm.com, peterx@redhat.com, edgar.iglesias@gmail.com, wtownsen@redhat.com

memory_region_iommu_replay() is used for VFIO integration.

However its default implementation is not adapted to SMMUv3
IOMMU memory region. Indeed the input address range is too
huge and its execution is too slow as it calls the translate()
callback on each granule.

Let's implement the replay callback which hierarchically walk
over the page table structure and notify only the segments
that are populated with valid entries.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3.c     | 36 ++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events |  1 +
 2 files changed, 37 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 8e7d10d..c43bd93 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -657,6 +657,41 @@ static int smmuv3_notify_entry(IOMMUTLBEntry *entry, void *private)
     return 0;
 }
 
+/* Unmap the whole notifier's range */
+static void smmuv3_unmap_notifier_range(IOMMUNotifier *n)
+{
+    IOMMUTLBEntry entry;
+    hwaddr size = n->end - n->start + 1;
+
+    entry.target_as = &address_space_memory;
+    entry.iova = n->start & ~(size - 1);
+    entry.perm = IOMMU_NONE;
+    entry.addr_mask = size - 1;
+
+    memory_region_notify_one(n, &entry);
+}
+
+static void smmuv3_replay(IOMMUMemoryRegion *mr, IOMMUNotifier *n)
+{
+    SMMUTransCfg cfg = {};
+    int ret;
+
+    trace_smmuv3_replay(mr->parent_obj.name, n, n->start, n->end);
+    smmuv3_unmap_notifier_range(n);
+
+    ret = smmuv3_decode_config(mr, &cfg);
+    if (ret) {
+        error_report("%s error decoding the configuration for iommu mr=%s",
+                     __func__, mr->parent_obj.name);
+    }
+
+    if (cfg.disabled || cfg.bypassed) {
+        return;
+    }
+    /* walk the page tables and replay valid entries */
+    smmu_page_walk(&cfg, 0, (1ULL << (64 - cfg.tsz)) - 1, false,
+                   smmuv3_notify_entry, n);
+}
 static void smmuv3_notify_iova_range(IOMMUMemoryRegion *mr, IOMMUNotifier *n,
                                      uint64_t iova, size_t size)
 {
@@ -1095,6 +1130,7 @@ static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
 
     imrc->translate = smmuv3_translate;
     imrc->notify_flag_changed = smmuv3_notify_flag_changed;
+    imrc->replay = smmuv3_replay;
 }
 
 static const TypeInfo smmuv3_type_info = {
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 4ac264d..15f84d6 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -46,5 +46,6 @@ smmuv3_cfg_stage(int s, uint32_t oas, uint32_t tsz, uint64_t ttbr, bool aa64, ui
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
 smmuv3_replay_mr(const char *name) "iommu mr=%s"
+smmuv3_replay(const char *name, void *n, hwaddr start, hwaddr end) "iommu mr=%s notifier=%p [0x%"PRIx64",0x%"PRIx64"]"
 smmuv3_notify_entry(hwaddr iova, hwaddr pa, hwaddr mask, int perm) "iova=0x%"PRIx64" pa=0x%" PRIx64" mask=0x%"PRIx64" perm=%d"
 smmuv3_notify_iova_range(const char *name, uint64_t iova, size_t size, void *n) "iommu mr=%s iova=0x%"PRIx64" size=0x%lx n=%p"
-- 
2.5.5

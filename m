Received: from eggs.gnu.org ([209.51.188.92]:34096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eB-0004DV-OY
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9e7-0006Pp-CZ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:54 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:55625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9e4-00068o-1P
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:00:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id o25so147888wmf.5
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.33
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 17:59:49 +0100
Message-Id: <20190429170030.11323-2-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/42] hw/arm/smmuv3: Remove SMMUNotifierNode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

The SMMUNotifierNode struct is not necessary and brings extra
complexity so let's remove it. We now directly track the SMMUDevices
which have registered IOMMU MR notifiers.

This is inspired from the same transformation on intel-iommu
done in commit b4a4ba0d68f50f218ee3957b6638dbee32a5eeef
("intel-iommu: remove IntelIOMMUNotifierNode")

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-id: 20190409160219.19026-1-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/smmu-common.h |  8 ++------
 hw/arm/smmu-common.c         |  6 +++---
 hw/arm/smmuv3.c              | 28 +++++++---------------------
 3 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index b07cadd0ef9..2c7fbf42025 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -80,13 +80,9 @@ typedef struct SMMUDevice {
     AddressSpace       as;
     uint32_t           cfg_cache_hits;
     uint32_t           cfg_cache_misses;
+    QLIST_ENTRY(SMMUDevice) next;
 } SMMUDevice;
 
-typedef struct SMMUNotifierNode {
-    SMMUDevice *sdev;
-    QLIST_ENTRY(SMMUNotifierNode) next;
-} SMMUNotifierNode;
-
 typedef struct SMMUPciBus {
     PCIBus       *bus;
     SMMUDevice   *pbdev[0]; /* Parent array is sparse, so dynamically alloc */
@@ -108,7 +104,7 @@ typedef struct SMMUState {
     GHashTable *iotlb;
     SMMUPciBus *smmu_pcibus_by_bus_num[SMMU_PCI_BUS_MAX];
     PCIBus *pci_bus;
-    QLIST_HEAD(, SMMUNotifierNode) notifiers_list;
+    QLIST_HEAD(, SMMUDevice) devices_with_notifiers;
     uint8_t bus_num;
     PCIBus *primary_bus;
 } SMMUState;
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index bbf4b8721a3..e94be6db6c1 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -412,10 +412,10 @@ inline void smmu_inv_notifiers_mr(IOMMUMemoryRegion *mr)
 /* Unmap all notifiers of all mr's */
 void smmu_inv_notifiers_all(SMMUState *s)
 {
-    SMMUNotifierNode *node;
+    SMMUDevice *sdev;
 
-    QLIST_FOREACH(node, &s->notifiers_list, next) {
-        smmu_inv_notifiers_mr(&node->sdev->iommu);
+    QLIST_FOREACH(sdev, &s->devices_with_notifiers, next) {
+        smmu_inv_notifiers_mr(&sdev->iommu);
     }
 }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 8c4e99fecc6..fd8ec7860ee 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -828,10 +828,10 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
 /* invalidate an asid/iova tuple in all mr's */
 static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, dma_addr_t iova)
 {
-    SMMUNotifierNode *node;
+    SMMUDevice *sdev;
 
-    QLIST_FOREACH(node, &s->notifiers_list, next) {
-        IOMMUMemoryRegion *mr = &node->sdev->iommu;
+    QLIST_FOREACH(sdev, &s->devices_with_notifiers, next) {
+        IOMMUMemoryRegion *mr = &sdev->iommu;
         IOMMUNotifier *n;
 
         trace_smmuv3_inv_notifiers_iova(mr->parent_obj.name, asid, iova);
@@ -1472,8 +1472,6 @@ static void smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
     SMMUDevice *sdev = container_of(iommu, SMMUDevice, iommu);
     SMMUv3State *s3 = sdev->smmu;
     SMMUState *s = &(s3->smmu_state);
-    SMMUNotifierNode *node = NULL;
-    SMMUNotifierNode *next_node = NULL;
 
     if (new & IOMMU_NOTIFIER_MAP) {
         int bus_num = pci_bus_num(sdev->bus);
@@ -1485,22 +1483,10 @@ static void smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
 
     if (old == IOMMU_NOTIFIER_NONE) {
         trace_smmuv3_notify_flag_add(iommu->parent_obj.name);
-        node = g_malloc0(sizeof(*node));
-        node->sdev = sdev;
-        QLIST_INSERT_HEAD(&s->notifiers_list, node, next);
-        return;
-    }
-
-    /* update notifier node with new flags */
-    QLIST_FOREACH_SAFE(node, &s->notifiers_list, next, next_node) {
-        if (node->sdev == sdev) {
-            if (new == IOMMU_NOTIFIER_NONE) {
-                trace_smmuv3_notify_flag_del(iommu->parent_obj.name);
-                QLIST_REMOVE(node, next);
-                g_free(node);
-            }
-            return;
-        }
+        QLIST_INSERT_HEAD(&s->devices_with_notifiers, sdev, next);
+    } else if (new == IOMMU_NOTIFIER_NONE) {
+        trace_smmuv3_notify_flag_del(iommu->parent_obj.name);
+        QLIST_REMOVE(sdev, next);
     }
 }
 
-- 
2.20.1

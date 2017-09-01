Received: from eggs.gnu.org ([2001:4830:134:3::10]:37439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpfa-0006IP-Dq
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dnpfV-0003hX-1X
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 13:23:50 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  1 Sep 2017 19:21:15 +0200
Message-Id: <1504286483-23327-13-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v7 12/20] hw/arm/smmuv3: Implement data
 structure and TLB invalidation notifications
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

When the guest invalidates data structure (STE, CD) or TLB
we need to notify the IOMMU region notifiers. This allows
vhost integration and also prepares for VFIO integration.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v6 -> v7:
- move SMMU_CMD_TLBI_NH_VA_AM in a separate patch
- rationalize names and add some comments
- fix devfn computation in smmuv3_replay_sid
- direcly use smmuv3_notify_iova_range
- move smmuv3_replay (used for VFIO) in a separate patch

v5 -> v6:
- use IOMMUMemoryRegion
- handle implementation defined SMMU_CMD_TLBI_NH_VA_AM cmd
  (goes along with TLBI_ON_MAP FW quirk)
- replay systematically unmap the whole range first
- smmuv3_map_hook does not unmap anymore and the unmap is done
  before the replay
- add and use smmuv3_context_device_invalidate instead of
  blindly replaying everything
---
 hw/arm/smmuv3.c     | 137 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/arm/trace-events |   5 ++
 2 files changed, 138 insertions(+), 4 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 20fbce6..8e7d10d 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -25,6 +25,7 @@
 #include "exec/address-spaces.h"
 #include "trace.h"
 #include "qemu/error-report.h"
+#include "exec/target_page.h"
 
 #include "hw/arm/smmuv3.h"
 #include "smmuv3-internal.h"
@@ -648,6 +649,123 @@ out:
     return entry;
 }
 
+static int smmuv3_notify_entry(IOMMUTLBEntry *entry, void *private)
+{
+    trace_smmuv3_notify_entry(entry->iova, entry->translated_addr,
+                              entry->addr_mask, entry->perm);
+    memory_region_notify_one((IOMMUNotifier *)private, entry);
+    return 0;
+}
+
+static void smmuv3_notify_iova_range(IOMMUMemoryRegion *mr, IOMMUNotifier *n,
+                                     uint64_t iova, size_t size)
+{
+    SMMUTransCfg cfg = {};
+    IOMMUTLBEntry entry;
+    int ret;
+
+    trace_smmuv3_notify_iova_range(mr->parent_obj.name, iova, size, n);
+    ret = smmuv3_decode_config(mr, &cfg);
+    if (ret) {
+        error_report("%s error decoding the configuration for iommu mr=%s",
+                     __func__, mr->parent_obj.name);
+    }
+
+    if (cfg.disabled || cfg.bypassed) {
+        return;
+    }
+
+    /* first unmap */
+    entry.target_as = &address_space_memory;
+    entry.iova = iova & ~(size - 1);
+    entry.addr_mask = size - 1;
+    entry.perm = IOMMU_NONE;
+
+    memory_region_notify_one(n, &entry);
+
+    /* then figure out if a new mapping needs to be applied */
+    smmu_page_walk(&cfg, iova, iova + entry.addr_mask , false,
+                   smmuv3_notify_entry, n);
+}
+
+static void smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
+                                       IOMMUNotifierFlag old,
+                                       IOMMUNotifierFlag new)
+{
+    SMMUDevice *sdev = container_of(iommu, SMMUDevice, iommu);
+    SMMUV3State *s3 = sdev->smmu;
+    SMMUState *s = &(s3->smmu_state);
+    SMMUNotifierNode *node = NULL;
+    SMMUNotifierNode *next_node = NULL;
+
+    if (old == IOMMU_NOTIFIER_NONE) {
+        trace_smmuv3_notify_flag_add(iommu->parent_obj.name);
+        node = g_malloc0(sizeof(*node));
+        node->sdev = sdev;
+        QLIST_INSERT_HEAD(&s->notifiers_list, node, next);
+        return;
+    }
+
+    /* update notifier node with new flags */
+    QLIST_FOREACH_SAFE(node, &s->notifiers_list, next, next_node) {
+        if (node->sdev == sdev) {
+            if (new == IOMMU_NOTIFIER_NONE) {
+                trace_smmuv3_notify_flag_del(iommu->parent_obj.name);
+                QLIST_REMOVE(node, next);
+                g_free(node);
+            }
+            return;
+        }
+    }
+}
+/*
+ * Replay all iommu memory regions attached to the smmu
+ */
+static void smmuv3_replay_all(SMMUState *s)
+{
+    SMMUNotifierNode *node;
+
+    QLIST_FOREACH(node, &s->notifiers_list, next) {
+        trace_smmuv3_replay_mr(node->sdev->iommu.parent_obj.name);
+        memory_region_iommu_replay_all(&node->sdev->iommu);
+    }
+}
+
+/*
+ * Replay the iommu memory region corresponding to a given streamid
+ */
+static void smmuv3_replay_sid(SMMUState *s, uint16_t sid)
+{
+    uint8_t bus_n, devfn;
+    SMMUPciBus *smmu_bus;
+    SMMUDevice *smmu;
+
+    bus_n = PCI_BUS_NUM(sid);
+    smmu_bus = smmu_find_as_from_bus_num(s, bus_n);
+    if (smmu_bus) {
+        devfn = sid & 0xFF;
+        smmu = smmu_bus->pbdev[devfn];
+        if (smmu) {
+            trace_smmuv3_replay_mr(smmu->iommu.parent_obj.name);
+            memory_region_iommu_replay_all(&smmu->iommu);
+        }
+    }
+}
+
+static void smmuv3_replay_iova_range(SMMUState *s, uint64_t iova, size_t size)
+{
+    SMMUNotifierNode *node;
+
+    QLIST_FOREACH(node, &s->notifiers_list, next) {
+        IOMMUMemoryRegion *mr = &node->sdev->iommu;
+        IOMMUNotifier *n;
+
+        IOMMU_NOTIFIER_FOREACH(n, mr) {
+            smmuv3_notify_iova_range(mr, n, iova, size);
+        }
+    }
+}
+
 static int smmuv3_cmdq_consume(SMMUV3State *s)
 {
     SMMUCmdError cmd_error = SMMU_CERROR_NONE;
@@ -687,24 +805,32 @@ static int smmuv3_cmdq_consume(SMMUV3State *s)
              uint32_t streamid = cmd.word[1];
 
              trace_smmuv3_cmdq_cfgi_ste(streamid);
+             smmuv3_replay_sid(&s->smmu_state, streamid);
             break;
         }
         case SMMU_CMD_CFGI_STE_RANGE: /* same as SMMU_CMD_CFGI_ALL */
         {
-            uint32_t start = cmd.word[1], range, end;
+            uint32_t start = cmd.word[1], range, end, i;
 
             range = extract32(cmd.word[2], 0, 5);
             end = start + (1 << (range + 1)) - 1;
             trace_smmuv3_cmdq_cfgi_ste_range(start, end);
+            for (i = start; i <= end; i++) {
+                smmuv3_replay_sid(&s->smmu_state, i);
+            }
             break;
         }
         case SMMU_CMD_CFGI_CD:
         case SMMU_CMD_CFGI_CD_ALL:
-            trace_smmuv3_unhandled_cmd(type);
+        {
+            uint32_t streamid = cmd.word[1];
+
+            smmuv3_replay_sid(&s->smmu_state, streamid);
             break;
+        }
         case SMMU_CMD_TLBI_NH_ALL:
         case SMMU_CMD_TLBI_NH_ASID:
-            trace_smmuv3_unhandled_cmd(type);
+            smmuv3_replay_all(&s->smmu_state);
             break;
         case SMMU_CMD_TLBI_NH_VA:
         {
@@ -713,8 +839,10 @@ static int smmuv3_cmdq_consume(SMMUV3State *s)
             uint64_t low = extract32(cmd.word[2], 12, 20);
             uint64_t high = cmd.word[3];
             uint64_t addr = high << 32 | (low << 12);
+            size_t size = qemu_target_page_size();
 
             trace_smmuv3_cmdq_tlbi_nh_va(asid, vmid, addr);
+            smmuv3_replay_iova_range(&s->smmu_state, addr, size);
             break;
         }
         case SMMU_CMD_TLBI_NH_VAA:
@@ -727,7 +855,7 @@ static int smmuv3_cmdq_consume(SMMUV3State *s)
         case SMMU_CMD_TLBI_S12_VMALL:
         case SMMU_CMD_TLBI_S2_IPA:
         case SMMU_CMD_TLBI_NSNH_ALL:
-            trace_smmuv3_unhandled_cmd(type);
+            smmuv3_replay_all(&s->smmu_state);
             break;
         case SMMU_CMD_ATC_INV:
         case SMMU_CMD_PRI_RESP:
@@ -966,6 +1094,7 @@ static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
     imrc->translate = smmuv3_translate;
+    imrc->notify_flag_changed = smmuv3_notify_flag_changed;
 }
 
 static const TypeInfo smmuv3_type_info = {
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index e643fc3..4ac264d 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -43,3 +43,8 @@ smmuv3_translate_in(uint16_t sid, int pci_bus_num, hwaddr strtab_base) "SID:0x%x
 smmuv3_get_cd(hwaddr addr) "CD addr: 0x%"PRIx64
 smmuv3_translate(const char *n, uint16_t sid, hwaddr iova, hwaddr translated, int perm, int ret) "%s sid=%d iova=0x%"PRIx64" translated=0x%"PRIx64" perm=0x%x (%d)"
 smmuv3_cfg_stage(int s, uint32_t oas, uint32_t tsz, uint64_t ttbr, bool aa64, uint32_t granule_sz, int initial_level) "TransCFG stage:%d oas:%d tsz:%d ttbr:0x%"PRIx64"  aa64:%d granule_sz:%d, initial_level = %d"
+smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
+smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
+smmuv3_replay_mr(const char *name) "iommu mr=%s"
+smmuv3_notify_entry(hwaddr iova, hwaddr pa, hwaddr mask, int perm) "iova=0x%"PRIx64" pa=0x%" PRIx64" mask=0x%"PRIx64" perm=%d"
+smmuv3_notify_iova_range(const char *name, uint64_t iova, size_t size, void *n) "iommu mr=%s iova=0x%"PRIx64" size=0x%lx n=%p"
-- 
2.5.5

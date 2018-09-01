Received: from eggs.gnu.org ([2001:4830:134:3::10]:55115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fw6qH-0006KD-Ij
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 10:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fw6os-0005o7-5s
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 10:24:11 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Sat,  1 Sep 2018 16:23:05 +0200
Message-Id: <20180901142312.11662-14-eric.auger@redhat.com>
In-Reply-To: <20180901142312.11662-1-eric.auger@redhat.com>
References: <20180901142312.11662-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 13/20] hw/arm/smmuv3: Notify on config changes
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

In case IOMMU config notifiers are attached to the
IOMMU memory region, we execute them, passing as argument
the iommu_guest_stage_config struct updated with the new
viommu translation config. Config notifiers are called on
STE and CD changes. At physical level, they translate into
CMD_CFGI_STE_* and CMD_CFGI_CD_* commands.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3.c | 71 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ff92f802bd..a31df03d47 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -16,6 +16,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "linux/iommu.h"
+
 #include "qemu/osdep.h"
 #include "hw/boards.h"
 #include "sysemu/sysemu.h"
@@ -843,6 +845,47 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, dma_addr_t iova)
     }
 }
 
+static void smmuv3_notify_config_change(SMMUState *bs, uint32_t sid)
+{
+    IOMMUMemoryRegion *mr = smmu_iommu_mr(bs, sid);
+    SMMUEventInfo event = {.type = SMMU_EVT_NONE, .sid = sid};
+    SMMUTransCfg *cfg;
+    SMMUDevice *sdev;
+
+    if (!mr) {
+        return;
+    }
+
+    sdev = container_of(mr, SMMUDevice, iommu);
+
+    /* flush QEMU config cache */
+    smmuv3_flush_config(sdev);
+
+    if (mr->iommu_notify_flags & IOMMU_NOTIFIER_S1_CFG) {
+        /* force a guest RAM config structure decoding */
+        cfg = smmuv3_get_config(sdev, &event);
+
+        if (cfg) {
+            struct iommu_guest_stage_config *kcfg =
+                 g_new0(struct iommu_guest_stage_config, 1);
+
+            kcfg->flags = SMMUV3_S1_CFG;
+            kcfg->smmu_s1.flags = cfg->disabled ? IOMMU_SMMU_S1_DISABLED : 0 |
+                                  cfg->bypassed ? IOMMU_SMMU_S1_BYPASSED : 0 |
+                                  cfg->aborted  ? IOMMU_SMMU_S1_ABORTED : 0;
+            kcfg->smmu_s1.cdptr_dma = cfg->s1ctxptr;
+            kcfg->smmu_s1.asid_bits = 16;
+
+            memory_region_config_notify_iommu(mr, 0, kcfg);
+            g_free(kcfg);
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s error decoding the configuration for iommu mr=%s\n",
+                         __func__, mr->parent_obj.name);
+        }
+    }
+}
+
 static int smmuv3_cmdq_consume(SMMUv3State *s)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -893,22 +936,14 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         case SMMU_CMD_CFGI_STE:
         {
             uint32_t sid = CMD_SID(&cmd);
-            IOMMUMemoryRegion *mr = smmu_iommu_mr(bs, sid);
-            SMMUDevice *sdev;
 
             if (CMD_SSEC(&cmd)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
 
-            if (!mr) {
-                break;
-            }
-
             trace_smmuv3_cmdq_cfgi_ste(sid);
-            sdev = container_of(mr, SMMUDevice, iommu);
-            smmuv3_flush_config(sdev);
-
+            smmuv3_notify_config_change(bs, sid);
             break;
         }
         case SMMU_CMD_CFGI_STE_RANGE: /* same as SMMU_CMD_CFGI_ALL */
@@ -925,14 +960,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             trace_smmuv3_cmdq_cfgi_ste_range(start, end);
 
             for (i = start; i <= end; i++) {
-                IOMMUMemoryRegion *mr = smmu_iommu_mr(bs, i);
-                SMMUDevice *sdev;
-
-                if (!mr) {
-                    continue;
-                }
-                sdev = container_of(mr, SMMUDevice, iommu);
-                smmuv3_flush_config(sdev);
+                smmuv3_notify_config_change(bs, i);
             }
             break;
         }
@@ -940,21 +968,14 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         case SMMU_CMD_CFGI_CD_ALL:
         {
             uint32_t sid = CMD_SID(&cmd);
-            IOMMUMemoryRegion *mr = smmu_iommu_mr(bs, sid);
-            SMMUDevice *sdev;
 
             if (CMD_SSEC(&cmd)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
 
-            if (!mr) {
-                break;
-            }
-
             trace_smmuv3_cmdq_cfgi_cd(sid);
-            sdev = container_of(mr, SMMUDevice, iommu);
-            smmuv3_flush_config(sdev);
+            smmuv3_notify_config_change(bs, sid);
             break;
         }
         case SMMU_CMD_TLBI_NH_ASID:
-- 
2.17.1

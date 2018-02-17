Received: from eggs.gnu.org ([2001:4830:134:3::10]:45314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1en7Wa-0003ld-I8
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:47:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1en7WZ-0003X3-0j
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:47:52 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Sat, 17 Feb 2018 19:46:56 +0100
Message-Id: <1518893216-9983-15-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v9 14/14] hw/arm/virt: Handle iommu in 2.12
 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com, alex.williamson@redhat.com
Cc: tn@semihalf.com, mst@redhat.com, christoffer.dall@linaro.org, bharat.bhushan@nxp.com, jean-philippe.brucker@arm.com, edgar.iglesias@gmail.com, linuc.decode@gmail.com, peterx@redhat.com

The new machine type exposes a new "iommu" virt machine option.
The SMMUv3 IOMMU is instantiated using -machine virt,iommu=smmuv3.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v7 -> v8:
- Revert to machine option, now dubbed "iommu", preparing for virtio
  instantiation.

v5 -> v6: machine 2_11

Another alternative would be to use the -device option as
done on x86. As the smmu is a sysbus device, we would need to
use the platform bus framework.
---
 hw/arm/virt.c         | 45 +++++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h |  1 +
 2 files changed, 46 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e9dca0d..607c7e1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1547,6 +1547,34 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
     }
 }
 
+static char *virt_get_iommu(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    switch (vms->iommu) {
+    case VIRT_IOMMU_NONE:
+        return g_strdup("none");
+    case VIRT_IOMMU_SMMUV3:
+        return g_strdup("smmuv3");
+    default:
+        return g_strdup("none");
+    }
+}
+
+static void virt_set_iommu(Object *obj, const char *value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    if (!strcmp(value, "smmuv3")) {
+        vms->iommu = VIRT_IOMMU_SMMUV3;
+    } else if (!strcmp(value, "none")) {
+        vms->iommu = VIRT_IOMMU_NONE;
+    } else {
+        error_setg(errp, "Invalid iommu value");
+        error_append_hint(errp, "Valid value are none, smmuv3\n");
+    }
+}
+
 static CpuInstanceProperties
 virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
 {
@@ -1679,6 +1707,19 @@ static void virt_2_12_instance_init(Object *obj)
                                         NULL);
     }
 
+    if (vmc->no_iommu) {
+        vms->iommu = VIRT_IOMMU_NONE;
+    } else {
+        /* Default disallows smmu instantiation */
+        vms->iommu = VIRT_IOMMU_NONE;
+        object_property_add_str(obj, "iommu", virt_get_iommu,
+                                 virt_set_iommu, NULL);
+        object_property_set_description(obj, "iommu",
+                                        "Set the IOMMU model among "
+                                        "none, smmuv3 (default none)",
+                                        NULL);
+    }
+
     vms->memmap = a15memmap;
     vms->irqmap = a15irqmap;
 }
@@ -1698,8 +1739,12 @@ static void virt_2_11_instance_init(Object *obj)
 
 static void virt_machine_2_11_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_2_12_options(mc);
     SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_11);
+
+    vmc->no_iommu = true;
 }
 DEFINE_VIRT_MACHINE(2, 11)
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 13d3724..3a92fc3 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -92,6 +92,7 @@ typedef struct {
     bool disallow_affinity_adjustment;
     bool no_its;
     bool no_pmu;
+    bool no_iommu;
     bool claim_edge_triggered_timers;
 } VirtMachineClass;
 
-- 
2.5.5

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fBLEC-0000xQ-F1
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fBLEB-0006AI-GB
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:17:00 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 25 Apr 2018 16:15:59 +0200
Message-Id: <1524665762-31355-15-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1524665762-31355-1-git-send-email-eric.auger@redhat.com>
References: <1524665762-31355-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v12 14/17] hw/arm/virt: Introduce the iommu
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, prem.mallappa@gmail.com
Cc: alex.williamson@redhat.com, tn@semihalf.com, mst@redhat.com, cdall@kernel.org, bharat.bhushan@nxp.com, jean-philippe.brucker@arm.com, linuc.decode@gmail.com, peterx@redhat.com, jintack@cs.columbia.edu

ARM virt machine now exposes a new "iommu" option.
The SMMUv3 IOMMU is instantiated using -machine virt,iommu=smmuv3.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

---
v11 -> v12:
- change the property description
- add Peter's R-b

v9 -> v10:
- remove no_iommu

v7 -> v8:
- Revert to machine option, now dubbed "iommu", preparing for virtio
  instantiation.

v5 -> v6: machine 2_11
---
 hw/arm/virt.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1799702..c6e77b5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1560,6 +1560,34 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
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
+        g_assert_not_reached();
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
+        error_append_hint(errp, "Valid values are none, smmuv3.\n");
+    }
+}
+
 static CpuInstanceProperties
 virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
 {
@@ -1692,6 +1720,14 @@ static void virt_2_12_instance_init(Object *obj)
                                         NULL);
     }
 
+    /* Default disallows iommu instantiation */
+    vms->iommu = VIRT_IOMMU_NONE;
+    object_property_add_str(obj, "iommu", virt_get_iommu, virt_set_iommu, NULL);
+    object_property_set_description(obj, "iommu",
+                                    "Set the IOMMU type. "
+                                    "Valid values are none and smmuv3",
+                                    NULL);
+
     vms->memmap = a15memmap;
     vms->irqmap = a15irqmap;
 }
-- 
2.5.5

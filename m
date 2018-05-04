Received: from eggs.gnu.org ([2001:4830:134:3::10]:51992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJM-0005rh-MW
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJL-0000qQ-Pz
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:16:00 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fEeJL-0000pT-IP
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:59 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJK-0003AD-MT
	for qemu-devel@nongnu.org; Fri, 04 May 2018 18:15:58 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  4 May 2018 18:15:40 +0100
Message-Id: <20180504171540.25813-25-peter.maydell@linaro.org>
In-Reply-To: <20180504171540.25813-1-peter.maydell@linaro.org>
References: <20180504171540.25813-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 24/24] hw/arm/virt: Introduce the iommu option
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

ARM virt machine now exposes a new "iommu" option.
The SMMUv3 IOMMU is instantiated using -machine virt,iommu=smmuv3.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1524665762-31355-15-git-send-email-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b085f0b9b4..11b9f599ca 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1561,6 +1561,34 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
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
@@ -1693,6 +1721,14 @@ static void virt_2_12_instance_init(Object *obj)
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
2.17.0

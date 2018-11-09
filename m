Received: from eggs.gnu.org ([2001:4830:134:3::10]:46454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gL50y-0007Op-Ne
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:31:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gL50t-00051p-J1
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:31:52 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  9 Nov 2018 12:29:57 +0100
Message-Id: <20181109112957.10067-19-eric.auger@redhat.com>
In-Reply-To: <20181109112957.10067-1-eric.auger@redhat.com>
References: <20181109112957.10067-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v8 18/18] hw/arm/virt: Allow virtio-iommu
 instantiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com, jean-philippe.brucker@arm.com
Cc: kevin.tian@intel.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com

The virtio-iommu now can be instantiated by adding the virt
machine option "-M virt,iommu=virtio"

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f2994c4359..d2080a1ba9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1710,6 +1710,8 @@ static char *virt_get_iommu(Object *obj, Error **errp)
         return g_strdup("none");
     case VIRT_IOMMU_SMMUV3:
         return g_strdup("smmuv3");
+    case VIRT_IOMMU_VIRTIO:
+        return g_strdup("virtio");
     default:
         g_assert_not_reached();
     }
@@ -1721,11 +1723,13 @@ static void virt_set_iommu(Object *obj, const char *value, Error **errp)
 
     if (!strcmp(value, "smmuv3")) {
         vms->iommu = VIRT_IOMMU_SMMUV3;
+    } else if (!strcmp(value, "virtio")) {
+        vms->iommu = VIRT_IOMMU_VIRTIO;
     } else if (!strcmp(value, "none")) {
         vms->iommu = VIRT_IOMMU_NONE;
     } else {
         error_setg(errp, "Invalid iommu value");
-        error_append_hint(errp, "Valid values are none, smmuv3.\n");
+        error_append_hint(errp, "Valid values are none, smmuv3, virtio.\n");
     }
 }
 
@@ -1901,7 +1905,7 @@ static void virt_3_1_instance_init(Object *obj)
     object_property_add_str(obj, "iommu", virt_get_iommu, virt_set_iommu, NULL);
     object_property_set_description(obj, "iommu",
                                     "Set the IOMMU type. "
-                                    "Valid values are none and smmuv3",
+                                    "Valid values are none, smmuv3, virtio",
                                     NULL);
 
     vms->memmap = a15memmap;
-- 
2.17.2

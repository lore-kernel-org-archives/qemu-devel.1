Received: from eggs.gnu.org ([2001:4830:134:3::10]:58819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fmluv-0006pe-JD
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 16:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fmluu-0007C5-IC
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 16:15:49 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  6 Aug 2018 22:14:44 +0200
Message-Id: <1533586484-5737-17-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1533586484-5737-1-git-send-email-eric.auger@redhat.com>
References: <1533586484-5737-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v7 16/16] hw/arm/virt: Allow virtio-iommu
 instantiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, kevin.tian@intel.com, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com, linuc.decode@gmail.com

The virtio-iommu now can be instantiated by adding the virt
machine option "-M virt,iommu=virtio"

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index dd3cc71..25f7c21 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1679,6 +1679,8 @@ static char *virt_get_iommu(Object *obj, Error **errp)
         return g_strdup("none");
     case VIRT_IOMMU_SMMUV3:
         return g_strdup("smmuv3");
+    case VIRT_IOMMU_VIRTIO:
+        return g_strdup("virtio");
     default:
         g_assert_not_reached();
     }
@@ -1690,11 +1692,13 @@ static void virt_set_iommu(Object *obj, const char *value, Error **errp)
 
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
 
@@ -1872,7 +1876,7 @@ static void virt_3_0_instance_init(Object *obj)
     object_property_add_str(obj, "iommu", virt_get_iommu, virt_set_iommu, NULL);
     object_property_set_description(obj, "iommu",
                                     "Set the IOMMU type. "
-                                    "Valid values are none and smmuv3",
+                                    "Valid values are none, smmuv3, virtio",
                                     NULL);
 
     vms->memmap = a15memmap;
-- 
2.5.5

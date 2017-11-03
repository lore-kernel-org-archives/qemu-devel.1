Received: from eggs.gnu.org ([2001:4830:134:3::10]:41395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eAavj-0007sR-11
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:18:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eAavi-0004VT-6n
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:18:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:37808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eAavh-0004Mu-Uy
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:18:34 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Fri,  3 Nov 2017 20:01:56 +0800
Message-Id: <1509710516-21084-7-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1509710516-21084-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1509710516-21084-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [RESEND PATCH 6/6] vfio/pci: register
 vfio_iommu_bind_pasidtbl_notify notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au, pbonzini@redhat.com, alex.williamson@redhat.com
Cc: tianyu.lan@intel.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

This is an example to show the usage of IOMMUObject based notifier.

For passthru devices, if there is a vIOMMU exposed to guest, guest
would issue iommu operation on the devices. And the iommu operations
needs to be propagated to host iommu driver.

In future, the IOMMUObject notifiers may include:
* notifier for guest pasid table binding
* notifier for guest iommu tlb invalidation
Both of the two notifiers would be include in future virt-SVM patchset.

In virt-SVM patchset, this notifier would be fulfilled.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/vfio/pci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5b77c7e..3ed521e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2637,6 +2637,14 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
+static void vfio_iommu_bind_pasidtbl_notify(IOMMUNotifier *n,
+                                            IOMMUEventData *event_data)
+{
+/*  Sample code, would be detailed in coming virt-SVM patchset.
+    VFIOGuestIOMMUObject *giommu = container_of(n, VFIOGuestIOMMUObject, n);
+    VFIOContainer *container = giommu->container;
+*/
+}
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
@@ -2889,6 +2897,12 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         QLIST_INSERT_HEAD(&group->container->giommu_object_list,
                           giommu,
                           giommu_next);
+        /* Register vfio_iommu_bind_pasidtbl_notify with event flag
+           IOMMU_EVENT_BIND_PASIDT */
+        iommu_notifier_register(iommu,
+                                &giommu->n,
+                                vfio_iommu_bind_pasidtbl_notify,
+                                IOMMU_EVENT_BIND_PASIDT);
     }
 
     return;
-- 
1.9.1

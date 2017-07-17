Received: from eggs.gnu.org ([2001:4830:134:3::10]:39079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dXCng-0007wV-GZ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 16:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dXCnd-0006t2-ME
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 16:39:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dXCnd-0006sj-Ch
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 16:39:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EB1F4E047
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 20:39:24 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 17 Jul 2017 14:39:21 -0600
Message-ID: <20170717203910.15922.38640.stgit@gimli.home>
In-Reply-To: <20170717203658.15922.21967.stgit@gimli.home>
References: <20170717203658.15922.21967.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 1/1] vfio-pci,
 ppc64/spapr: Reorder group-to-container attaching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alexey Kardashevskiy <aik@ozlabs.ru>

At the moment VFIO PCI device initialization works as follows:
vfio_realize
	vfio_get_group
		vfio_connect_container
			register memory listeners (1)
			update QEMU groups lists
		vfio_kvm_device_add_group

Then (example for pseries) the machine reset hook triggers region_add()
for all regions where listeners from (1) are listening:

ppc_spapr_reset
	spapr_phb_reset
		spapr_tce_table_enable
			memory_region_add_subregion
				vfio_listener_region_add
					vfio_spapr_create_window

This scheme works fine until we need to handle VFIO PCI device hotplug
and we want to enable PPC64/sPAPR in-kernel TCE acceleration on,
i.e. after PCI hotplug we need a place to call
ioctl(vfio_kvm_device_fd, KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE).
Since the ioctl needs a LIOBN fd (from sPAPRTCETable) and a IOMMU group fd
(from VFIOGroup), vfio_listener_region_add() seems to be the only place
for this ioctl().

However this only works during boot time because the machine reset
happens strictly after all devices are finalized. When hotplug happens,
vfio_listener_region_add() is called when a memory listener is registered
but when this happens:
1. new group is not added to the container->group_list yet;
2. VFIO KVM device is unaware of the new IOMMU group.

This moves bits around to have all necessary VFIO infrastructure
in place for both initial startup and hotplug cases.

[aw: ie, register vfio groups with kvm prior to memory listener
registration such that kvm-vfio pseudo device ioctls are available
during the region_add callback]

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/common.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index c1bb6d429a4e..7b2924c0ef19 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1109,6 +1109,14 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         goto free_container_exit;
     }
 
+    vfio_kvm_device_add_group(group);
+
+    QLIST_INIT(&container->group_list);
+    QLIST_INSERT_HEAD(&space->containers, container, next);
+
+    group->container = container;
+    QLIST_INSERT_HEAD(&container->group_list, group, container_next);
+
     container->listener = vfio_memory_listener;
 
     memory_listener_register(&container->listener, container->space->as);
@@ -1122,14 +1130,11 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 
     container->initialized = true;
 
-    QLIST_INIT(&container->group_list);
-    QLIST_INSERT_HEAD(&space->containers, container, next);
-
-    group->container = container;
-    QLIST_INSERT_HEAD(&container->group_list, group, container_next);
-
     return 0;
 listener_release_exit:
+    QLIST_REMOVE(group, container_next);
+    QLIST_REMOVE(container, next);
+    vfio_kvm_device_del_group(group);
     vfio_listener_release(container);
 
 free_container_exit:
@@ -1234,8 +1239,6 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
 
     QLIST_INSERT_HEAD(&vfio_group_list, group, next);
 
-    vfio_kvm_device_add_group(group);
-
     return group;
 
 close_fd_exit:

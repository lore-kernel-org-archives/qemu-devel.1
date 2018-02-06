Received: from eggs.gnu.org ([2001:4830:134:3::10]:50430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ejxSJ-0007Ng-Hm
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 20:26:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ejxSG-0006MH-6C
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 20:26:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37992
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ejxSG-0006LT-1D
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 20:26:20 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w191NnVg140159
	for <qemu-devel@nongnu.org>; Thu, 8 Feb 2018 20:26:18 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g11ju0u4u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 20:26:18 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 8 Feb 2018 18:26:17 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:31 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-11-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 10/54] vfio: Fix vfio-kvm group registration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Alex Williamson <alex.williamson@redhat.com>

From: Alex Williamson <alex.williamson@redhat.com>

Commit 8c37faa475f3 ("vfio-pci, ppc64/spapr: Reorder group-to-container
attaching") moved registration of groups with the vfio-kvm device from
vfio_get_group() to vfio_connect_container(), but it missed the case
where a group is attached to an existing container and takes an early
exit.  Perhaps this is a less common case on ppc64/spapr, but on x86
(without viommu) all groups are connected to the same container and
thus only the first group gets registered with the vfio-kvm device.
This becomes a problem if we then hot-unplug the devices associated
with that first group and we end up with KVM being misinformed about
any vfio connections that might remain.  Fix by including the call to
vfio_kvm_device_add_group() in this early exit path.

Fixes: 8c37faa475f3 ("vfio-pci, ppc64/spapr: Reorder group-to-container attaching")
Cc: qemu-stable@nongnu.org # qemu-2.10+
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
(cherry picked from commit 2016986aedb6ea2839662eb5f60630f3e231bd1a)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/vfio/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7b2924c0ef..7007878e34 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -968,6 +968,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
             group->container = container;
             QLIST_INSERT_HEAD(&container->group_list, group, container_next);
+            vfio_kvm_device_add_group(group);
             return 0;
         }
     }
-- 
2.11.0

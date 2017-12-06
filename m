Received: from eggs.gnu.org ([2001:4830:134:3::10]:33913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eMd6z-0004Re-4y
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 12:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eMd6w-0001bS-0h
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 12:03:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eMd6v-0001ae-Po
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 12:03:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBC47356EC
	for <qemu-devel@nongnu.org>; Wed,  6 Dec 2017 17:03:52 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 06 Dec 2017 10:03:49 -0700
Message-ID: <20171206170259.24842.81054.stgit@gimli.home>
In-Reply-To: <20171206170019.24842.47488.stgit@gimli.home>
References: <20171206170019.24842.47488.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL for-2.11 1/1] vfio: Fix vfio-kvm group
 registration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
---
 hw/vfio/common.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7b2924c0ef19..7007878e345e 100644
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

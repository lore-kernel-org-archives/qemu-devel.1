Received: from eggs.gnu.org ([2001:4830:134:3::10]:53598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ecSG3-000065-It
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:42:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ecSG2-0004JW-Rk
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:42:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ecSG2-0004HV-M7
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:42:42 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 19 Jan 2018 16:42:19 +0800
Message-Id: <20180119084219.31187-3-peterx@redhat.com>
In-Reply-To: <20180119084219.31187-1-peterx@redhat.com>
References: <20180119084219.31187-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 2/2] vfio: listener unregister before unset
 container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, peterx@redhat.com, Alex Williamson <alex.williamson@redhat.com>

After previous patch, listener unregister will need the container to be
alive.  Let's move this unregister phase to be before unset container,
since that operation will free the backend container in kernel, then
we'll get these after previous patch:

qemu-system-x86_64: VFIO_UNMAP_DMA: -22
qemu-system-x86_64: vfio_dma_unmap(0x559bf53a4590, 0x0, 0xa0000) = -22 (Invalid argument)

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/common.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b77be3a8b3..76cf28d462 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1161,19 +1161,27 @@ static void vfio_disconnect_container(VFIOGroup *group)
 {
     VFIOContainer *container = group->container;
 
+    QLIST_REMOVE(group, container_next);
+    group->container = NULL;
+
+    /*
+     * Explicitly release the listener first before unset container,
+     * since unset may destroy the backend container if it's the last
+     * group.
+     */
+    if (QLIST_EMPTY(&container->group_list)) {
+        vfio_listener_release(container);
+    }
+
     if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER, &container->fd)) {
         error_report("vfio: error disconnecting group %d from container",
                      group->groupid);
     }
 
-    QLIST_REMOVE(group, container_next);
-    group->container = NULL;
-
     if (QLIST_EMPTY(&container->group_list)) {
         VFIOAddressSpace *space = container->space;
         VFIOGuestIOMMU *giommu, *tmp;
 
-        vfio_listener_release(container);
         QLIST_REMOVE(container, next);
 
         QLIST_FOREACH_SAFE(giommu, &container->giommu_list, giommu_next, tmp) {
-- 
2.14.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSM-0004XJ-Bm
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSL-00052L-FW
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:34 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:51311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSL-00051w-8l
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:33 -0500
Received: by mail-wm0-x242.google.com with SMTP id r71so28444914wmd.1
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:33 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:37 +0100
Message-Id: <1517858941-5538-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 23/47] vfio: listener unregister before unset
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
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

After next patch, listener unregister will need the container to be
alive.  Let's move this unregister phase to be before unset container,
since that operation will free the backend container in kernel,
otherwise we'll get these after next patch:

qemu-system-x86_64: VFIO_UNMAP_DMA: -22
qemu-system-x86_64: vfio_dma_unmap(0x559bf53a4590, 0x0, 0xa0000) = -22 (Invalid argument)

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180122060244.29368-4-peterx@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/vfio/common.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b77be3a..76cf28d 100644
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
1.8.3.1

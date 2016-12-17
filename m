Received: from eggs.gnu.org ([2001:4830:134:3::10]:53366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUg-0007qx-Ax
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUf-0008EC-CP
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:21540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cICUe-0007ss-Sf
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:33 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Sat, 17 Dec 2016 18:43:30 +0800
Message-Id: <1481971427-11094-21-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
References: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1 20/37] vhost-pci-slave/msg:
 VHOST_USER_SET_VRING_KICK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com, mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: Wei Wang <wei.w.wang@intel.com>

Update the kickfd to the head node in the list.

This version of vhost-pci expects the driver to use polling to receive
packets. So, other than storing the kickfd, we don't do anything more.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost-pci-slave.c         | 19 +++++++++++++++++++
 include/hw/virtio/vhost-pci-slave.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index a55861a..dff1c88 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -11,6 +11,7 @@
  */
 
 #include <qemu/osdep.h>
+#include <qemu/sockets.h>
 
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -223,6 +224,13 @@ static void vp_slave_set_vring_addr(VhostUserMsg *msg)
            sizeof(struct vhost_vring_addr));
 }
 
+static void vp_slave_set_vring_kick(int fd)
+{
+    PeerVqNode *pvq_node = QLIST_FIRST(&vp_slave->pvq_list);
+    if (!pvq_node)
+        pvq_node->kickfd = fd;
+}
+
 static int vp_slave_can_read(void *opaque)
 {
     return VHOST_USER_HDR_SIZE;
@@ -295,6 +303,17 @@ static void vp_slave_read(void *opaque, const uint8_t *buf, int size)
     case VHOST_USER_SET_VRING_ADDR:
         vp_slave_set_vring_addr(&msg);
         break;
+    case VHOST_USER_SET_VRING_KICK:
+        /* consume the fd */
+        qemu_chr_fe_get_msgfds(chr_be, fds, 1);
+        vp_slave_set_vring_kick(fds[0]);
+        /*
+         * This is a non-blocking eventfd.
+         * The receive function forces it to be blocking,
+         * so revert it back to non-blocking.
+         */
+        qemu_set_nonblock(fds[0]);
+        break;
     default:
         error_report("vhost-pci-slave does not support msg request = %d",
                      msg.request);
diff --git a/include/hw/virtio/vhost-pci-slave.h b/include/hw/virtio/vhost-pci-slave.h
index 439198d..4b6b213 100644
--- a/include/hw/virtio/vhost-pci-slave.h
+++ b/include/hw/virtio/vhost-pci-slave.h
@@ -10,6 +10,7 @@
 typedef struct PeerVqNode {
     uint16_t last_avail_idx;
     uint32_t vring_num;
+    int kickfd;
     struct vhost_vring_addr addr;
     QLIST_ENTRY(PeerVqNode) node;
 } PeerVqNode;
-- 
2.7.4

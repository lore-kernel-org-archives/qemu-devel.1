Received: from eggs.gnu.org ([2001:4830:134:3::10]:44960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968x-0005oK-70
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968v-00020Q-OI
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:62480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d968v-0001je-Cc
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:45 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 12 May 2017 16:35:44 +0800
Message-Id: <1494578148-102868-13-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v2 12/16] vhost-user: handling
 VHOST_USER_SET_FEATURES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com, marcandre.lureau@gmail.com, mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>

If the featuer bits sent by the slave are not equal to the ones that
were sent by the master, perform a reset of the master device.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/vhost_net.c       |  2 ++
 hw/virtio/vhost-user.c   | 24 ++++++++++++++++++++++++
 hw/virtio/virtio-pci.c   | 20 ++++++++++++++++++++
 hw/virtio/virtio-pci.h   |  2 ++
 include/net/vhost-user.h | 14 ++++++++++++++
 net/vhost-user.c         | 14 +++++---------
 6 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 0a5278d..7609083 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -352,6 +352,8 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
         }
     }
 
+    vhost_user_set_master_dev(ncs[0].peer, dev);
+
     return 0;
 
 err_start:
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 5d55ea1..1a34048 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -12,6 +12,7 @@
 #include "qapi/error.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-backend.h"
+#include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/vhost-user.h"
 #include "hw/virtio/virtio-net.h"
 #include "net/vhost-user.h"
@@ -75,6 +76,26 @@ fail:
     return -1;
 }
 
+static void handle_slave_acked_features(const char *name, VhostUserMsg *msg)
+{
+    CharBackend *chr_be = net_name_to_chr_be(name);
+    VhostUserState *s = container_of(chr_be, VhostUserState, chr);
+    VirtIODevice *vdev = s->vdev;
+    uint64_t master_features, slave_features;
+
+    master_features = vhost_net_get_acked_features(s->vhost_net) &
+                      ~(1 << VHOST_USER_F_PROTOCOL_FEATURES);
+    slave_features = msg->payload.u64;
+
+    /*
+     * It is a rare case: vhost-pci driver only accepted a subset of the
+     * feature bits. In this case, reset the virtio device.
+     */
+    if (master_features != slave_features) {
+        master_reset_virtio_net(vdev);
+    }
+}
+
 int vhost_user_can_read(void *opaque)
 {
     return VHOST_USER_HDR_SIZE;
@@ -109,6 +130,9 @@ void vhost_user_asyn_read(void *opaque, const uint8_t *buf, int size)
     }
 
     switch (msg.request) {
+    case VHOST_USER_SET_FEATURES:
+        handle_slave_acked_features(name, &msg);
+        break;
     default:
         error_report("%s: does not support msg %d", __func__, msg.request);
         break;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 3f1a198..0677496 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -37,6 +37,7 @@
 #include "qemu/range.h"
 #include "hw/virtio/virtio-bus.h"
 #include "qapi/visitor.h"
+#include "monitor/qdev.h"
 
 #define VIRTIO_PCI_REGION_SIZE(dev)     VIRTIO_PCI_CONFIG_OFF(msix_present(dev))
 
@@ -2327,6 +2328,25 @@ static const TypeInfo virtio_serial_pci_info = {
 
 /* virtio-net-pci */
 
+void master_reset_virtio_net(VirtIODevice *vdev)
+{
+    VirtIONet *net = VIRTIO_NET(vdev);
+    VirtIONetPCI *net_pci = container_of(net, VirtIONetPCI, vdev);
+    VirtIOPCIProxy *proxy = &net_pci->parent_obj;
+    DeviceState *qdev = DEVICE(proxy);
+    DeviceState *qdev_new;
+    Error *err = NULL;
+
+    virtio_pci_reset(qdev);
+    qdev_unplug(qdev, &err);
+    qdev->realized = false;
+    qdev_new = qdev_device_add(qdev->opts, &err);
+    if (!qdev_new) {
+        qemu_opts_del(qdev->opts);
+    }
+    object_unref(OBJECT(qdev));
+}
+
 static Property virtio_net_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 6ffacd9..fa8a671 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -399,4 +399,6 @@ struct VirtIOCryptoPCI {
 /* Virtio ABI version, if we increment this, we break the guest driver. */
 #define VIRTIO_PCI_ABI_VERSION          0
 
+void master_reset_virtio_net(VirtIODevice *vdev);
+
 #endif
diff --git a/include/net/vhost-user.h b/include/net/vhost-user.h
index 1bb5f1a..4cd14c9 100644
--- a/include/net/vhost-user.h
+++ b/include/net/vhost-user.h
@@ -12,6 +12,18 @@
 #define NET_VHOST_USER_H
 
 #include "sysemu/char.h"
+#include "net/vhost_net.h"
+
+typedef struct VhostUserState {
+    NetClientState nc;
+    CharBackend chr; /* only queue index 0 */
+    VHostNetState *vhost_net;
+    guint watch;
+    uint64_t acked_features;
+    bool started;
+    /* Pointer to the master device */
+    VirtIODevice *vdev;
+} VhostUserState;
 
 struct vhost_net;
 struct vhost_net *vhost_user_get_vhost_net(NetClientState *nc);
@@ -19,4 +31,6 @@ uint64_t vhost_user_get_acked_features(NetClientState *nc);
 
 CharBackend *net_name_to_chr_be(const char *name);
 
+void vhost_user_set_master_dev(NetClientState *nc, VirtIODevice *vdev);
+
 #endif /* VHOST_USER_H */
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 91ee146..7c7707a 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -10,7 +10,6 @@
 
 #include "qemu/osdep.h"
 #include "clients.h"
-#include "net/vhost_net.h"
 #include "net/vhost-user.h"
 #include "hw/virtio/vhost-user.h"
 #include "qemu/config-file.h"
@@ -18,14 +17,11 @@
 #include "qmp-commands.h"
 #include "trace.h"
 
-typedef struct VhostUserState {
-    NetClientState nc;
-    CharBackend chr; /* only queue index 0 */
-    VHostNetState *vhost_net;
-    guint watch;
-    uint64_t acked_features;
-    bool started;
-} VhostUserState;
+void vhost_user_set_master_dev(NetClientState *nc, VirtIODevice *vdev)
+{
+    VhostUserState *s = DO_UPCAST(VhostUserState, nc, nc);
+    s->vdev = vdev;
+}
 
 VHostNetState *vhost_user_get_vhost_net(NetClientState *nc)
 {
-- 
2.7.4

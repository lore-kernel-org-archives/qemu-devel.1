Received: from eggs.gnu.org ([2001:4830:134:3::10]:54086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr0q-0005FR-5o
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr0m-0004x5-A5
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:33815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIr0m-0004Vl-1L
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:24 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 13:59:11 +0800
Message-Id: <1482127152-84732-37-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [RESEND Patch v1 36/37] vhost-user/msg: handling
 VHOST_USER_SET_FEATURES
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

If the featuer bits sent by the slave are not equal to the ones that
were sent by the master, perform a reset of the master device.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/vhost_net.c       |  2 ++
 hw/virtio/vhost-user.c   | 20 ++++++++++++++++++++
 hw/virtio/virtio-pci.c   | 20 ++++++++++++++++++++
 hw/virtio/virtio-pci.h   |  2 ++
 include/net/vhost-user.h | 14 ++++++++++++++
 net/vhost-user.c         | 14 +++++---------
 6 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 8256018..e8a2d4f 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -349,6 +349,8 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
         }
     }
 
+    vhost_user_set_master_dev(ncs[0].peer, dev);
+
     return 0;
 
 err_start:
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index e9242a9..990275f 100644
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
@@ -75,6 +76,22 @@ fail:
     return -1;
 }
 
+static void handle_slave_acked_features(const char *name, VhostUserMsg *msg)
+{
+    CharBackend *chr_be = net_name_to_chr_be(name);
+    VhostUserState *s = container_of(chr_be, VhostUserState, chr);
+    VirtIODevice *vdev = s->vdev;
+    uint64_t master_features, slave_features;
+
+    master_features = vhost_net_get_acked_features(s->vhost_net)
+                      & ~(1 << VHOST_USER_F_PROTOCOL_FEATURES);
+    slave_features = msg->payload.u64;
+
+    if (master_features != slave_features) {
+        master_reset_virtio_net(vdev);
+    }
+}
+
 int vhost_user_can_read(void *opaque)
 {
     return VHOST_USER_HDR_SIZE;
@@ -109,6 +126,9 @@ void vhost_user_asyn_read(void *opaque, const uint8_t *buf, int size)
     }
 
     switch (msg.request) {
+    case VHOST_USER_SET_FEATURES:
+        handle_slave_acked_features(name, &msg);
+        break;
     default:
         error_report("vhost-user master does not support msg request = %d",
                      msg.request);
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 20cbefc..82b2920 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -38,6 +38,7 @@
 #include "qemu/range.h"
 #include "hw/virtio/virtio-bus.h"
 #include "qapi/visitor.h"
+#include "monitor/qdev.h"
 
 #define VIRTIO_PCI_REGION_SIZE(dev)     VIRTIO_PCI_CONFIG_OFF(msix_present(dev))
 
@@ -2257,6 +2258,25 @@ static const TypeInfo virtio_serial_pci_info = {
 
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
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, false),
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 0b4b04f..c41c621 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -383,4 +383,6 @@ struct VirtIOCryptoPCI {
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
index 72010c2..5b31224 100644
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

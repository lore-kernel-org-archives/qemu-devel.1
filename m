Received: from eggs.gnu.org ([2001:4830:134:3::10]:44985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968y-0005pj-Qy
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968x-00022D-Dm
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:62480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d968x-0001je-33
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:47 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 12 May 2017 16:35:45 +0800
Message-Id: <1494578148-102868-14-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v2 13/16] vhost-pci-slave: add "reset_virtio"
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

After the vhost-pci-net device being hotplugged to the VM, the device
uses the features bits that have been negotiated with the remote virtio
device to negotiate with the driver. If the driver accepts a subset of
the feature bits, it implies that the vhost-pci-net can only suppoort
a subset of the features supported by the remote virtio device. In this
case, the remote virtio_device will be reset, and re-start the vhost-user
protocol.

Add the "reset_virtio" field as an indicator to the slave in this case.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/vhost-pci-net.c              | 11 +++++++++++
 hw/virtio/vhost-pci-slave.c         | 15 +++++++++++++--
 include/hw/virtio/vhost-pci-slave.h |  1 +
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/hw/net/vhost-pci-net.c b/hw/net/vhost-pci-net.c
index 1379204..a2dca50 100644
--- a/hw/net/vhost-pci-net.c
+++ b/hw/net/vhost-pci-net.c
@@ -189,8 +189,19 @@ static void vpnet_set_features(VirtIODevice *vdev, uint64_t features)
      */
     static bool need_send;
     int ret;
+    VhostPCIDev *vp_dev = get_vhost_pci_dev();
 
     if (need_send) {
+        /*
+         * If the remote negotiated feature bits are not equal to the
+         * feature bits that have been negotiated between the device and
+         * driver, the remote virtio device needs a reset. Set reset_virtio
+         * to indicate to the slave about this case.
+         */
+        if (vp_dev->feature_bits != features) {
+            vp_dev->feature_bits = features;
+            vp_dev->reset_virtio = 1;
+        }
         need_send = 0;
         ret = vp_slave_send_feature_bits(features);
         if (ret < 0) {
diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index 6cc9c21..a7d3c8d 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -171,8 +171,15 @@ static void vp_slave_set_device_type(VhostUserMsg *msg)
 
     switch (vp_dev->dev_type) {
     case VIRTIO_ID_NET:
-        vp_dev->feature_bits |= VHOST_PCI_FEATURE_BITS |
-                                VHOST_PCI_NET_FEATURE_BITS;
+        /*
+         * The setting of reset_virtio implies that the feature_bits has been
+         * remotely negotiated. So, skip adding the supported features to
+         * feature_bits in this case.
+         */
+        if (!vp_dev->reset_virtio) {
+            vp_dev->feature_bits |= VHOST_PCI_FEATURE_BITS |
+                                    VHOST_PCI_NET_FEATURE_BITS;
+        }
         break;
     default:
         error_report("%s: device type %d is not supported",
@@ -400,6 +407,9 @@ static int vp_slave_set_vhost_pci(VhostUserMsg *msg)
 
     switch (cmd) {
     case VHOST_USER_SET_VHOST_PCI_START:
+        if (vp_dev->reset_virtio) {
+            vp_dev->reset_virtio = 0;
+        }
         ret = vp_slave_device_create(vp_dev->dev_type);
         if (ret < 0) {
             return ret;
@@ -585,6 +595,7 @@ static void vp_dev_init(VhostPCIDev *vp_dev)
     vp_dev->vdev = NULL;
     QLIST_INIT(&vp_dev->remoteq_list);
     vp_dev->remoteq_num = 0;
+    vp_dev->reset_virtio = 0;
 }
 
 int vhost_pci_slave_init(QemuOpts *opts)
diff --git a/include/hw/virtio/vhost-pci-slave.h b/include/hw/virtio/vhost-pci-slave.h
index ab21e70..594917f 100644
--- a/include/hw/virtio/vhost-pci-slave.h
+++ b/include/hw/virtio/vhost-pci-slave.h
@@ -29,6 +29,7 @@ typedef struct RemoteMem {
 typedef struct VhostPCIDev {
     /* Ponnter to the slave device */
     VirtIODevice *vdev;
+    bool reset_virtio;
     uint16_t dev_type;
     uint64_t feature_bits;
     /* Records the end (offset to the BAR) of the last mapped region */
-- 
2.7.4

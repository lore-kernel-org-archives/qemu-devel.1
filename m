Received: from eggs.gnu.org ([2001:4830:134:3::10]:54035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr0j-0004CQ-Mq
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr0i-0004uq-Qq
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:33815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIr0i-0004Vl-JH
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:01:20 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 13:59:09 +0800
Message-Id: <1482127152-84732-35-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [RESEND Patch v1 34/37] vhost-pci-slave: add
 "peer_reset"
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

Setting "peer_reset" flags that the peer device is about to be reset.
This happens when the slave side device driver only accepts a subset
of the feature bits offered by the peer device.

The peer device is expected to have a second run of the vhost-user
protocol for the re-setup.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/vhost-pci-net.c              |  4 ++++
 hw/virtio/vhost-pci-slave.c         | 20 ++++++++++++++++++--
 include/hw/virtio/vhost-pci-slave.h |  1 +
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/hw/net/vhost-pci-net.c b/hw/net/vhost-pci-net.c
index 8e30281..3289f4d 100644
--- a/hw/net/vhost-pci-net.c
+++ b/hw/net/vhost-pci-net.c
@@ -144,6 +144,10 @@ static void vpnet_set_features(VirtIODevice *vdev, uint64_t features)
     int ret;
 
     if (need_send) {
+        if (vp_slave->feature_bits != features) {
+            vp_slave->feature_bits = features;
+            vp_slave->peer_reset = 1;
+        }
         need_send = 0;
         ret = vp_slave_send_feature_bits(features);
         if (ret < 0) {
diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index a966885..568e258 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -38,6 +38,15 @@ static void vp_slave_cleanup(void)
         return;
     }
 
+    /*
+     * if this cleanup is not invoked due to peer reset, re-initialize
+     * the feature bits, so that the slave can work with a new master
+     */
+    if (!vp_slave->peer_reset) {
+        vp_slave->feature_bits =
+                1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
+    }
+
     nregions = vp_slave->pmem_msg.nregions;
     for (i = 0; i < nregions; i++) {
         ret = munmap(vp_slave->mr_map_base[i], vp_slave->mr_map_size[i]);
@@ -167,8 +176,11 @@ static void vp_slave_set_device_type(VhostUserMsg *msg)
 
     switch (vp_slave->dev_type) {
     case VIRTIO_ID_NET:
-        vp_slave->feature_bits |= (VHOST_PCI_FEATURE_BITS
-                                   | VHOST_PCI_NET_FEATURE_BITS);
+        /* Don't initialize the feature bits if they have been negotiated */
+        if (!vp_slave->peer_reset) {
+            vp_slave->feature_bits |= (VHOST_PCI_FEATURE_BITS
+                                       | VHOST_PCI_NET_FEATURE_BITS);
+        }
         break;
     default:
         error_report("device type %d is not supported", vp_slave->dev_type);
@@ -359,6 +371,9 @@ static int vp_slave_set_vhost_pci(CharBackend *chr_be, VhostUserMsg *msg)
 
     switch (cmd) {
     case VHOST_USER_SET_VHOST_PCI_start:
+        if (vp_slave->peer_reset) {
+            vp_slave->peer_reset = 0;
+        }
         ret = vp_slave_device_create(vp_slave->dev_type);
         if (ret < 0) {
             return ret;
@@ -534,6 +549,7 @@ int vhost_pci_slave_init(QemuOpts *opts)
     vp_slave->sub_mr = NULL;
     QLIST_INIT(&vp_slave->pvq_list);
     vp_slave->pvq_num = 0;
+    vp_slave->peer_reset = 0;
     qemu_chr_fe_init(&vp_slave->chr_be, chr, &error_abort);
     qemu_chr_fe_set_handlers(&vp_slave->chr_be, vp_slave_can_read,
                              vp_slave_read, vp_slave_event,
diff --git a/include/hw/virtio/vhost-pci-slave.h b/include/hw/virtio/vhost-pci-slave.h
index e60580a..dd78ed4 100644
--- a/include/hw/virtio/vhost-pci-slave.h
+++ b/include/hw/virtio/vhost-pci-slave.h
@@ -21,6 +21,7 @@ typedef struct VhostPCISlave {
     CharBackend chr_be;
     /* Ponnter to the slave device */
     VirtIODevice *vdev;
+    bool peer_reset;
     uint16_t dev_type;
     uint64_t feature_bits;
     /* hotplugged memory should be mapped following the offset */
-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968t-0005k6-1H
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968s-0001yU-6g
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:62480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d968r-0001je-UQ
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:42 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 12 May 2017 16:35:42 +0800
Message-Id: <1494578148-102868-11-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v2 10/16] vhost-pci-net: send the negotiated
 feature bits to the master
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

The slave device actively sends the negotiated feature bits to
the master.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/vhost-pci-net.c              | 18 ++++++++++++++++++
 hw/virtio/vhost-pci-slave.c         | 22 ++++++++++++++++++++++
 include/hw/virtio/vhost-pci-slave.h |  2 ++
 3 files changed, 42 insertions(+)

diff --git a/hw/net/vhost-pci-net.c b/hw/net/vhost-pci-net.c
index 0235511..1379204 100644
--- a/hw/net/vhost-pci-net.c
+++ b/hw/net/vhost-pci-net.c
@@ -181,6 +181,24 @@ static uint64_t vpnet_get_features(VirtIODevice *vdev, uint64_t features,
 
 static void vpnet_set_features(VirtIODevice *vdev, uint64_t features)
 {
+    /*
+     * The implementation split the write of the 64-bit "features" into 2
+     * 32-bit writes, so the function is called twice. need_send is used to
+     * detect the second write which finishes the write of "features", and
+     * need to send to the remote device.
+     */
+    static bool need_send;
+    int ret;
+
+    if (need_send) {
+        need_send = 0;
+        ret = vp_slave_send_feature_bits(features);
+        if (ret < 0) {
+            error_report("%s failed to send feature bits", __func__);
+        }
+    } else {
+        need_send = 1;
+    }
 }
 
 static void vpnet_get_config(VirtIODevice *vdev, uint8_t *config)
diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index ab1d06b..6cc9c21 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -122,6 +122,28 @@ static void vp_slave_set_features(VhostUserMsg *msg)
                            ~(1 << VHOST_USER_F_PROTOCOL_FEATURES);
 }
 
+static int vp_slave_send_u64(int request, uint64_t u64)
+{
+    VhostUserMsg msg = {
+        .request = request,
+        .flags = VHOST_USER_VERSION,
+        .payload.u64 = u64,
+        .size = sizeof(msg.payload.u64),
+    };
+
+    if (vp_slave_write(&vp_slave->chr_be, &msg) < 0) {
+        error_report("%s: failed to send", __func__);
+        return -1;
+    }
+
+    return 0;
+}
+
+int vp_slave_send_feature_bits(uint64_t features)
+{
+    return vp_slave_send_u64(VHOST_USER_SET_FEATURES, features);
+}
+
 static void vp_slave_event(void *opaque, int event)
 {
     switch (event) {
diff --git a/include/hw/virtio/vhost-pci-slave.h b/include/hw/virtio/vhost-pci-slave.h
index b5bf02a..ab21e70 100644
--- a/include/hw/virtio/vhost-pci-slave.h
+++ b/include/hw/virtio/vhost-pci-slave.h
@@ -56,6 +56,8 @@ extern int vhost_pci_slave_init(QemuOpts *opts);
 
 extern int vhost_pci_slave_cleanup(void);
 
+extern int vp_slave_send_feature_bits(uint64_t features);
+
 VhostPCIDev *get_vhost_pci_dev(void);
 
 #endif
-- 
2.7.4

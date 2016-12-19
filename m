Received: from eggs.gnu.org ([2001:4830:134:3::10]:53630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr03-0002vJ-9U
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cIr00-0004aR-0o
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:33815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cIqzz-0004Vl-Mf
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 01:00:35 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Mon, 19 Dec 2016 13:58:43 +0800
Message-Id: <1482127152-84732-9-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
References: <1482127152-84732-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [RESEND Patch v1 08/37] vhost-pci-slave/msg:
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

Store the feature bits that have been negotiated between the master device
and driver. The feature bits will be negotiated with the slave driver.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost-pci-slave.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index 448b76c..68ab4ec 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -45,6 +45,13 @@ static int vp_slave_get_features(CharBackend *chr_be, VhostUserMsg *msg)
     return vp_slave_write(chr_be, msg);
 }
 
+static void vp_slave_set_features(VhostUserMsg *msg)
+{
+   /* Clear the protocol feature bit, which is useless for the device */
+    vp_slave->feature_bits = msg->payload.u64
+                             & ~(1 << VHOST_USER_F_PROTOCOL_FEATURES);
+}
+
 static void vp_slave_event(void *opaque, int event)
 {
     switch (event) {
@@ -95,6 +102,9 @@ static void vp_slave_read(void *opaque, const uint8_t *buf, int size)
             goto err_handling;
         }
         break;
+    case VHOST_USER_SET_FEATURES:
+        vp_slave_set_features(&msg);
+        break;
     default:
         error_report("vhost-pci-slave does not support msg request = %d",
                      msg.request);
-- 
2.7.4

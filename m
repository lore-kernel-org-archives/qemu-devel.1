Received: from eggs.gnu.org ([2001:4830:134:3::10]:53267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUU-0007WR-2E
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUS-00088c-OH
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:22 -0500
Received: from mga05.intel.com ([192.55.52.43]:21540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cICUS-0007ss-FK
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:20 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Sat, 17 Dec 2016 18:43:23 +0800
Message-Id: <1481971427-11094-14-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
References: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1 13/37] vhost-pci-slave/msg:
 VHOST_USER_GET_QUEUE_NUM
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

Send the max supported queue num according to the device type back to
the master.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost-pci-slave.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/virtio/vhost-pci-slave.c b/hw/virtio/vhost-pci-slave.c
index 9b00be4..8e5ecf8 100644
--- a/hw/virtio/vhost-pci-slave.c
+++ b/hw/virtio/vhost-pci-slave.c
@@ -90,6 +90,23 @@ static void vp_slave_set_device_type(VhostUserMsg *msg)
     }
 }
 
+static int vp_slave_get_queue_num(CharBackend *chr_be, VhostUserMsg *msg)
+{
+    switch (vp_slave->dev_type) {
+    case VIRTIO_ID_NET:
+        msg->payload.u64 = VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX;
+        break;
+    default:
+        error_report("GET_QUEUE_NUM: device type %d is not supported",
+                     vp_slave->dev_type);
+        return -1;
+    }
+    msg->size = sizeof(msg->payload.u64);
+    msg->flags |= VHOST_USER_REPLY_MASK;
+
+    return vp_slave_write(chr_be, msg);
+}
+
 static int vp_slave_can_read(void *opaque)
 {
     return VHOST_USER_HDR_SIZE;
@@ -141,6 +158,11 @@ static void vp_slave_read(void *opaque, const uint8_t *buf, int size)
     case VHOST_USER_SET_DEVICE_ID:
         vp_slave_set_device_type(&msg);
         break;
+    case VHOST_USER_GET_QUEUE_NUM:
+        ret = vp_slave_get_queue_num(chr_be, &msg);
+        if (ret < 0)
+            goto err_handling;
+        break;
     default:
         error_report("vhost-pci-slave does not support msg request = %d",
                      msg.request);
-- 
2.7.4

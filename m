Received: from eggs.gnu.org ([2001:4830:134:3::10]:35222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxFZ-0006LM-W3
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxFX-00041k-Mj
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:11:53 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:39332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxFX-00040s-HI
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:11:51 -0500
Received: by mail-wm0-x244.google.com with SMTP id i11so11014852wmf.4
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:11:51 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:11:44 +0100
Message-Id: <1515755504-21341-2-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio/vhost: do not take address of packed
 members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

The address of a packed member is not packed, which may cause accesses
to unaligned pointers.  Avoid this by reading the packed value before
passing it to another function.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/virtio-serial-bus.c | 6 +++---
 hw/virtio/vhost-user.c      | 7 +++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 9470bd7..2d236b3 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -664,9 +664,9 @@ static void virtio_serial_save_device(VirtIODevice *vdev, QEMUFile *f)
 
     /* The config space (ignored on the far end in current versions) */
     get_config(vdev, (uint8_t *)&config);
-    qemu_put_be16s(f, &config.cols);
-    qemu_put_be16s(f, &config.rows);
-    qemu_put_be32s(f, &config.max_nr_ports);
+    qemu_put_be16(f, config.cols);
+    qemu_put_be16(f, config.rows);
+    qemu_put_be32(f, config.max_nr_ports);
 
     /* The ports map */
     max_nr_ports = s->serial.max_virtserial_ports;
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 093675e..3c17207 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -638,8 +638,11 @@ static void slave_read(void *opaque)
 
     switch (msg.request) {
     case VHOST_USER_SLAVE_IOTLB_MSG:
-        ret = vhost_backend_handle_iotlb_msg(dev, &msg.payload.iotlb);
-        break;
+        {
+            struct vhost_iotlb_msg iotlb = msg.payload.iotlb;
+            ret = vhost_backend_handle_iotlb_msg(dev, &iotlb);
+            break;
+        }
     default:
         error_report("Received unexpected msg type.");
         ret = -EINVAL;
-- 
1.8.3.1

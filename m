Received: from eggs.gnu.org ([2001:4830:134:3::10]:47543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1duHJp-0003x6-Uj
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1duHJk-0000OH-U8
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:08:01 -0400
Received: from mail-eopbgr00128.outbound.protection.outlook.com
	([40.107.0.128]:19886
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbutsykin@virtuozzo.com>)
	id 1duHJk-0000NF-3O
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:07:56 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Tue, 19 Sep 2017 15:07:33 +0300
Message-Id: <20170919120733.22020-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] virtio-serial: add enable_backend callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbutsykin@virtuozzo.com, amit@kernel.org, mst@redhat.com, pbonzini@redhat.com, den@openvz.org

We should guarantee that RAM will not be modified while VM has a stopped
state, otherwise it can lead to negative consequences during post-copy
migration. In RUN_STATE_FINISH_MIGRATE step, it's expected that RAM on
source side will not be modified as this could lead to non-consistent vm state
on the destination side. Also RAM access during postcopy-ram migration with
enabled release-ram capability can lead to sad consequences.

Let's add enable_backend() callback to avoid undesirable virtioqueue changes
in the guest memory.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
Changes from v1:
- rebase on master a9158a5cba

 hw/char/virtio-console.c          | 21 +++++++++++++++++++++
 hw/char/virtio-serial-bus.c       |  7 +++++++
 include/hw/virtio/virtio-serial.h |  3 +++
 3 files changed, 31 insertions(+)

diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 198b2a89c0..172c72d06c 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -187,6 +187,26 @@ static int chr_be_change(void *opaque)
     return 0;
 }
 
+static void virtconsole_enable_backend(VirtIOSerialPort *port, bool enable)
+{
+    VirtConsole *vcon = VIRTIO_CONSOLE(port);
+
+    if (!qemu_chr_fe_backend_connected(&vcon->chr)) {
+        return;
+    }
+
+    if (enable) {
+        VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_GET_CLASS(port);
+
+        qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
+                                 k->is_console ? NULL : chr_event,
+                                 chr_be_change, vcon, NULL, false);
+    } else {
+        qemu_chr_fe_set_handlers(&vcon->chr, NULL, NULL, NULL,
+                                 NULL, NULL, NULL, false);
+    }
+}
+
 static void virtconsole_realize(DeviceState *dev, Error **errp)
 {
     VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(dev);
@@ -258,6 +278,7 @@ static void virtserialport_class_init(ObjectClass *klass, void *data)
     k->unrealize = virtconsole_unrealize;
     k->have_data = flush_buf;
     k->set_guest_connected = set_guest_connected;
+    k->enable_backend = virtconsole_enable_backend;
     k->guest_writable = guest_writable;
     dc->props = virtserialport_properties;
 }
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 17a1bb008a..9470bd7be7 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -637,6 +637,13 @@ static void set_status(VirtIODevice *vdev, uint8_t status)
     if (!(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
         guest_reset(vser);
     }
+
+    QTAILQ_FOREACH(port, &vser->ports, next) {
+        VirtIOSerialPortClass *vsc = VIRTIO_SERIAL_PORT_GET_CLASS(port);
+        if (vsc->enable_backend) {
+            vsc->enable_backend(port, vdev->vm_running);
+        }
+    }
 }
 
 static void vser_reset(VirtIODevice *vdev)
diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio-serial.h
index b19c44727f..12657a9f39 100644
--- a/include/hw/virtio/virtio-serial.h
+++ b/include/hw/virtio/virtio-serial.h
@@ -58,6 +58,9 @@ typedef struct VirtIOSerialPortClass {
         /* Guest opened/closed device. */
     void (*set_guest_connected)(VirtIOSerialPort *port, int guest_connected);
 
+    /* Enable/disable backend for virtio serial port */
+    void (*enable_backend)(VirtIOSerialPort *port, bool enable);
+
         /* Guest is now ready to accept data (virtqueues set up). */
     void (*guest_ready)(VirtIOSerialPort *port);
 
-- 
2.14.1

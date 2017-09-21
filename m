Received: from eggs.gnu.org ([2001:4830:134:3::10]:37145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiA-0004YL-Pj
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAi8-0003pE-GH
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:50 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAi8-0003lh-9W
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:48 -0400
Received: by mail-wm0-x242.google.com with SMTP id e64so6456409wmi.2
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:16:46 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:09 +0200
Message-Id: <1506035800-30509-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/32] virtio-serial: add enable_backend callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Butsykin <pbutsykin@virtuozzo.com>

From: Pavel Butsykin <pbutsykin@virtuozzo.com>

We should guarantee that RAM will not be modified while VM has a stopped
state, otherwise it can lead to negative consequences during post-copy
migration. In RUN_STATE_FINISH_MIGRATE step, it's expected that RAM on
source side will not be modified as this could lead to non-consistent vm state
on the destination side. Also RAM access during postcopy-ram migration with
enabled release-ram capability can lead to sad consequences.

Let's add enable_backend() callback to avoid undesirable virtioqueue changes
in the guest memory.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-Id: <20170919120733.22020-1-pbutsykin@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/virtio-console.c          | 21 +++++++++++++++++++++
 hw/char/virtio-serial-bus.c       |  7 +++++++
 include/hw/virtio/virtio-serial.h |  3 +++
 3 files changed, 31 insertions(+)

diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 198b2a8..172c72d 100644
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
index 17a1bb0..9470bd7 100644
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
index b19c447..12657a9 100644
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
1.8.3.1

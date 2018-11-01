Received: from eggs.gnu.org ([2001:4830:134:3::10]:55770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gIEdd-0005Rm-EN
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:12:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gIEdZ-0005tS-Fo
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:12:01 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:40518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gIEdZ-0005su-6q
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:11:57 -0400
Received: by mail-lf1-x142.google.com with SMTP id n3-v6so14449151lfe.7
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 08:11:57 -0700 (PDT)
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Thu,  1 Nov 2018 21:11:42 +0600
Message-Id: <49e9640f3fc040a9c9ab40f93935a6572b34bdff.1541085026.git.artem.k.pisarenko@gmail.com>
Subject: [Qemu-devel] [PATCH] virtserialport/virtconsole: fix messy
 opening/closing port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Artem Pisarenko <artem.k.pisarenko@gmail.com>

This fixes wrong interfacing between virtio serial port and bus
models, and corresponding chardev backends, caused extra and incorrect
activity during guest boot process (when virtserialport device used).

Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
---

Notes:
    Although this doesn't trigger any issue/bug (known to me), this may prevent them in future.
    Also this patch optimizes emulation performance by avoiding extra activity and fixes a case, when serial port wasn't closed if backend closed while being disabled (even worse - serial port will open again!).

 hw/char/virtio-console.c          | 24 ++++++++++++++++++++----
 hw/char/virtio-serial-bus.c       |  8 +++++++-
 include/hw/virtio/virtio-serial.h |  8 ++++++++
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 2cbe1d4..634e9bf 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -25,6 +25,7 @@
 typedef struct VirtConsole {
     VirtIOSerialPort parent_obj;
 
+    bool backend_active;
     CharBackend chr;
     guint watch;
 } VirtConsole;
@@ -149,6 +150,11 @@ static void chr_event(void *opaque, int event)
     VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(vcon);
 
     trace_virtio_console_chr_event(port->id, event);
+
+    if (!vcon->backend_active) {
+        return;
+    }
+
     switch (event) {
     case CHR_EVENT_OPENED:
         virtio_serial_open(port);
@@ -187,17 +193,24 @@ static int chr_be_change(void *opaque)
     return 0;
 }
 
+static bool virtconsole_is_backend_enabled(VirtIOSerialPort *port)
+{
+    VirtConsole *vcon = VIRTIO_CONSOLE(port);
+
+    return vcon->backend_active;
+}
+
 static void virtconsole_enable_backend(VirtIOSerialPort *port, bool enable)
 {
     VirtConsole *vcon = VIRTIO_CONSOLE(port);
 
-    if (!qemu_chr_fe_backend_connected(&vcon->chr)) {
-        return;
-    }
-
     if (enable) {
         VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_GET_CLASS(port);
 
+        if (!k->is_console && virtio_serial_is_opened(port)
+            && !qemu_chr_fe_backend_open(&vcon->chr)) {
+            virtio_serial_close(port);
+        }
         qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
                                  k->is_console ? NULL : chr_event,
                                  chr_be_change, vcon, NULL, false);
@@ -205,6 +218,7 @@ static void virtconsole_enable_backend(VirtIOSerialPort *port, bool enable)
         qemu_chr_fe_set_handlers(&vcon->chr, NULL, NULL, NULL,
                                  NULL, NULL, NULL, false);
     }
+    vcon->backend_active = enable;
 }
 
 static void virtconsole_realize(DeviceState *dev, Error **errp)
@@ -220,6 +234,7 @@ static void virtconsole_realize(DeviceState *dev, Error **errp)
     }
 
     if (qemu_chr_fe_backend_connected(&vcon->chr)) {
+        vcon->backend_active = true;
         /*
          * For consoles we don't block guest data transfer just
          * because nothing is connected - we'll just let it go
@@ -278,6 +293,7 @@ static void virtserialport_class_init(ObjectClass *klass, void *data)
     k->unrealize = virtconsole_unrealize;
     k->have_data = flush_buf;
     k->set_guest_connected = set_guest_connected;
+    k->is_backend_enabled = virtconsole_is_backend_enabled;
     k->enable_backend = virtconsole_enable_backend;
     k->guest_writable = guest_writable;
     dc->props = virtserialport_properties;
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 04e3ebe..d23d99d 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -258,6 +258,11 @@ static size_t send_control_event(VirtIOSerial *vser, uint32_t port_id,
 }
 
 /* Functions for use inside qemu to open and read from/write to ports */
+bool virtio_serial_is_opened(VirtIOSerialPort *port)
+{
+    return port->host_connected;
+}
+
 int virtio_serial_open(VirtIOSerialPort *port)
 {
     /* Don't allow opening an already-open port */
@@ -643,7 +648,8 @@ static void set_status(VirtIODevice *vdev, uint8_t status)
 
     QTAILQ_FOREACH(port, &vser->ports, next) {
         VirtIOSerialPortClass *vsc = VIRTIO_SERIAL_PORT_GET_CLASS(port);
-        if (vsc->enable_backend) {
+        if (vsc->is_backend_enabled && vsc->enable_backend
+            && (vsc->is_backend_enabled(port) != vdev->vm_running)) {
             vsc->enable_backend(port, vdev->vm_running);
         }
     }
diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio-serial.h
index 12657a9..4b72562 100644
--- a/include/hw/virtio/virtio-serial.h
+++ b/include/hw/virtio/virtio-serial.h
@@ -58,6 +58,8 @@ typedef struct VirtIOSerialPortClass {
         /* Guest opened/closed device. */
     void (*set_guest_connected)(VirtIOSerialPort *port, int guest_connected);
 
+    /* Is backend currently enabled for virtio serial port */
+    bool (*is_backend_enabled)(VirtIOSerialPort *port);
     /* Enable/disable backend for virtio serial port */
     void (*enable_backend)(VirtIOSerialPort *port, bool enable);
 
@@ -194,6 +196,12 @@ struct VirtIOSerial {
 /* Interface to the virtio-serial bus */
 
 /*
+ * Checks status of connection to the port
+ *   Returns true if connected, false otherwise.
+ */
+bool virtio_serial_is_opened(VirtIOSerialPort *port);
+
+/*
  * Open a connection to the port
  *   Returns 0 on success (always).
  */
-- 
2.7.4

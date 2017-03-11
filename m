Received: from eggs.gnu.org ([2001:4830:134:3::10]:58924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmh0C-0002cD-Sc
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmh0B-0002lW-Kl
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:24:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cmh0B-0002lI-CY
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:24:07 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 11 Mar 2017 17:22:52 +0400
Message-Id: <20170311132256.22951-18-marcandre.lureau@redhat.com>
In-Reply-To: <20170311132256.22951-1-marcandre.lureau@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 17/21] virtio-channel: parse qga stream for
 VMDUMP_INFO event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anderson@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

On virtio channel "org.qemu.guest_agent.0", parse the json stream until
the VMDUMP_INFO is received and retrieve the dump details.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/dump-info.h | 15 +++++++++++++
 dump.c                     |  3 +++
 hw/char/virtio-console.c   | 53 ++++++++++++++++++++++++++++++++++++++++=
++++++
 3 files changed, 71 insertions(+)
 create mode 100644 include/sysemu/dump-info.h

diff --git a/include/sysemu/dump-info.h b/include/sysemu/dump-info.h
new file mode 100644
index 0000000000..fb1ddff9af
--- /dev/null
+++ b/include/sysemu/dump-info.h
@@ -0,0 +1,15 @@
+#ifndef DUMP_INFO_H
+#define DUMP_INFO_H
+
+typedef struct DumpInfo {
+    bool received;
+    bool has_phys_base;
+    uint64_t phys_base;
+    bool has_text;
+    uint64_t text;
+    char *vmcoreinfo;
+} DumpInfo;
+
+extern DumpInfo dump_info;
+
+#endif /* DUMP_INFO_H */
diff --git a/dump.c b/dump.c
index f7b80d856b..68b406459e 100644
--- a/dump.c
+++ b/dump.c
@@ -20,6 +20,7 @@
 #include "monitor/monitor.h"
 #include "sysemu/kvm.h"
 #include "sysemu/dump.h"
+#include "sysemu/dump-info.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/memory_mapping.h"
 #include "sysemu/cpus.h"
@@ -38,6 +39,8 @@
 #define ELF_MACHINE_UNAME "Unknown"
 #endif
=20
+DumpInfo dump_info =3D { 0, };
+
 uint16_t cpu_to_dump16(DumpState *s, uint16_t val)
 {
     if (s->dump_info.d_endian =3D=3D ELFDATA2LSB) {
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 798d9b69fd..796b7c85aa 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -16,6 +16,9 @@
 #include "trace.h"
 #include "hw/virtio/virtio-serial.h"
 #include "qapi-event.h"
+#include "qapi/qmp/json-streamer.h"
+#include "qapi/qmp/json-parser.h"
+#include "sysemu/dump-info.h"
=20
 #define TYPE_VIRTIO_CONSOLE_SERIAL_PORT "virtserialport"
 #define VIRTIO_CONSOLE(obj) \
@@ -26,6 +29,7 @@ typedef struct VirtConsole {
=20
     CharBackend chr;
     guint watch;
+    JSONMessageParser parser;
 } VirtConsole;
=20
 /*
@@ -49,6 +53,11 @@ static ssize_t flush_buf(VirtIOSerialPort *port,
     VirtConsole *vcon =3D VIRTIO_CONSOLE(port);
     ssize_t ret;
=20
+    if (vcon->parser.emit &&
+        !dump_info.received) {
+        json_message_parser_feed(&vcon->parser, (const char *)buf, len);
+    }
+
     if (!qemu_chr_fe_get_driver(&vcon->chr)) {
         /* If there's no backend, we can just say we consumed all data. =
*/
         return len;
@@ -108,6 +117,11 @@ static void set_guest_connected(VirtIOSerialPort *po=
rt, int guest_connected)
     DeviceState *dev =3D DEVICE(port);
     VirtIOSerialPortClass *k =3D VIRTIO_SERIAL_PORT_GET_CLASS(port);
=20
+    if (guest_connected && !port->guest_connected) {
+        g_free(dump_info.vmcoreinfo);
+        memset(&dump_info, 0, sizeof(dump_info));
+    }
+
     if (!k->is_console) {
         qemu_chr_fe_set_open(&vcon->chr, guest_connected);
     }
@@ -163,6 +177,37 @@ static void chr_event(void *opaque, int event)
     }
 }
=20
+
+static void qga_message(JSONMessageParser *parser, GQueue *tokens)
+{
+    /* VirtConsole *vcon =3D container_of(parser, VirtConsole, parser); =
*/
+    QObject *obj;
+    QDict *msg, *data;
+    const char *event;
+
+    obj =3D json_parser_parse(tokens, NULL);
+    msg =3D qobject_to_qdict(obj);
+    if (!msg) {
+        error_report("JSON parsing failed");
+        return;
+    }
+
+    event =3D qdict_get_try_str(msg, "event");
+    data =3D qdict_get_qdict(msg, "data");
+    if (event && g_str_equal(event, "VMDUMP_INFO") && data) {
+        dump_info.received =3D true;
+        if (qdict_haskey(data, "phys-base")) {
+            dump_info.has_phys_base =3D true;
+            dump_info.phys_base =3D qdict_get_try_uint(data, "phys-base"=
, 0);
+        }
+        if (qdict_haskey(data, "text")) {
+            dump_info.has_text =3D true;
+            dump_info.text =3D qdict_get_try_uint(data, "text", 0);
+        }
+        dump_info.vmcoreinfo =3D g_strdup(qdict_get_try_str(data, "vmcor=
einfo"));
+    }
+}
+
 static void virtconsole_realize(DeviceState *dev, Error **errp)
 {
     VirtIOSerialPort *port =3D VIRTIO_SERIAL_PORT(dev);
@@ -195,6 +240,10 @@ static void virtconsole_realize(DeviceState *dev, Er=
ror **errp)
                                      chr_event, vcon, NULL, false);
         }
     }
+
+    if (port->name && g_str_equal(port->name, "org.qemu.guest_agent.0"))=
 {
+        json_message_parser_init(&vcon->parser, qga_message);
+    }
 }
=20
 static void virtconsole_unrealize(DeviceState *dev, Error **errp)
@@ -204,6 +253,10 @@ static void virtconsole_unrealize(DeviceState *dev, =
Error **errp)
     if (vcon->watch) {
         g_source_remove(vcon->watch);
     }
+
+    if (vcon->parser.emit) {
+        json_message_parser_destroy(&vcon->parser);
+    }
 }
=20
 static void virtconsole_class_init(ObjectClass *klass, void *data)
--=20
2.12.0.191.gc5d8de91d

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6ra-0005ih-U3
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:47:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rR-0004ND-Ah
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:51 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6rQ-0004Mo-LA
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:41 -0500
Received: by mail-wm0-x242.google.com with SMTP id r144so58442519wme.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:40 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:48 +0100
Message-Id: <1485524749-118532-41-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 40/41] chardev: qom-ify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Turn Chardev into Object.

qemu_chr_alloc() is replaced by the qemu_chardev_new() constructor. It
will call qemu_char_open() to open/intialize the chardev with the
ChardevCommon *backend settings.

The CharDriver::create() callback is turned into a ChardevClass::open()
which is called from the newly introduced qemu_chardev_open().

"chardev-gdb" and "chardev-hci" are internal chardev and aren't
creatable directly with -chardev. Use a new internal flag to disable
them. We may want to use TYPE_USER_CREATABLE interface instead, or
perhaps allow -chardev usage.

Although in general we keep typename and macros private, unless the type
is being used by some other file, in this patch, all types and common
helper macros for qemu-char.c are in char.h. This is to help transition
now (some types must be declared early, while some aren't shared) and
when splitting in several units. This is to be improved later.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/baum.c       |   66 +--
 backends/msmouse.c    |   57 ++-
 backends/testdev.c    |   34 +-
 gdbstub.c             |   39 +-
 hw/bt/hci-csr.c       |   55 +-
 include/sysemu/char.h |  107 ++--
 include/ui/console.h  |    2 +
 monitor.c             |    2 +-
 qemu-char.c           | 1327 ++++++++++++++++++++++++++-----------------------
 spice-qemu-char.c     |  142 +++---
 ui/console.c          |   62 ++-
 ui/gtk.c              |   51 +-
 vl.c                  |    2 +
 13 files changed, 1073 insertions(+), 873 deletions(-)

diff --git a/backends/baum.c b/backends/baum.c
index 8842936..0f418ed 100644
--- a/backends/baum.c
+++ b/backends/baum.c
@@ -100,6 +100,9 @@ typedef struct {
     QEMUTimer *cellCount_timer;
 } BaumChardev;
 
+#define TYPE_CHARDEV_BRAILLE "chardev-braille"
+#define BAUM_CHARDEV(obj) OBJECT_CHECK(BaumChardev, (obj), TYPE_CHARDEV_BRAILLE)
+
 /* Let's assume NABCC by default */
 enum way {
     DOTS2ASCII,
@@ -255,7 +258,7 @@ static int baum_deferred_init(BaumChardev *baum)
 /* The serial port can receive more of our data */
 static void baum_chr_accept_input(struct Chardev *chr)
 {
-    BaumChardev *baum = (BaumChardev *)chr;
+    BaumChardev *baum = BAUM_CHARDEV(chr);
     int room, first;
 
     if (!baum->out_buf_used)
@@ -281,7 +284,7 @@ static void baum_chr_accept_input(struct Chardev *chr)
 /* We want to send a packet */
 static void baum_write_packet(BaumChardev *baum, const uint8_t *buf, int len)
 {
-    Chardev *chr = (Chardev *)baum;
+    Chardev *chr = CHARDEV(baum);
     uint8_t io_buf[1 + 2 * len], *cur = io_buf;
     int room;
     *cur++ = ESC;
@@ -322,7 +325,7 @@ static void baum_write_packet(BaumChardev *baum, const uint8_t *buf, int len)
 /* Called when the other end seems to have a wrong idea of our display size */
 static void baum_cellCount_timer_cb(void *opaque)
 {
-    BaumChardev *baum = opaque;
+    BaumChardev *baum = BAUM_CHARDEV(opaque);
     uint8_t cell_count[] = { BAUM_RSP_CellCount, baum->x * baum->y };
     DPRINTF("Timeout waiting for DisplayData, sending cell count\n");
     baum_write_packet(baum, cell_count, sizeof(cell_count));
@@ -472,7 +475,7 @@ static int baum_eat_packet(BaumChardev *baum, const uint8_t *buf, int len)
 /* The other end is writing some data.  Store it and try to interpret */
 static int baum_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    BaumChardev *baum = (BaumChardev *)chr;
+    BaumChardev *baum = BAUM_CHARDEV(chr);
     int tocopy, cur, eaten, orig_len = len;
 
     if (!len)
@@ -529,7 +532,7 @@ static void baum_send_key2(BaumChardev *baum, uint8_t type, uint8_t value,
 /* We got some data on the BrlAPI socket */
 static void baum_chr_read(void *opaque)
 {
-    BaumChardev *baum = opaque;
+    BaumChardev *baum = BAUM_CHARDEV(opaque);
     brlapi_keyCode_t code;
     int ret;
     if (!baum->brlapi)
@@ -613,9 +616,9 @@ static void baum_chr_read(void *opaque)
     }
 }
 
-static void baum_chr_free(struct Chardev *chr)
+static void baum_chr_free(Chardev *chr)
 {
-    BaumChardev *baum = (BaumChardev *)chr;
+    BaumChardev *baum = BAUM_CHARDEV(chr);
 
     timer_free(baum->cellCount_timer);
     if (baum->brlapi) {
@@ -624,24 +627,14 @@ static void baum_chr_free(struct Chardev *chr)
     }
 }
 
-static Chardev *baum_chr_init(const CharDriver *driver,
-                              const char *id,
-                              ChardevBackend *backend,
-                              ChardevReturn *ret,
-                              bool *be_opened,
-                              Error **errp)
+static void baum_chr_open(Chardev *chr,
+                          ChardevBackend *backend,
+                          bool *be_opened,
+                          Error **errp)
 {
-    ChardevCommon *common = backend->u.braille.data;
-    BaumChardev *baum;
-    Chardev *chr;
+    BaumChardev *baum = BAUM_CHARDEV(chr);
     brlapi_handle_t *handle;
 
-    chr = qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        return NULL;
-    }
-    baum = (BaumChardev *)chr;
-
     handle = g_malloc0(brlapi_getHandleSize());
     baum->brlapi = handle;
 
@@ -649,34 +642,41 @@ static Chardev *baum_chr_init(const CharDriver *driver,
     if (baum->brlapi_fd == -1) {
         error_setg(errp, "brlapi__openConnection: %s",
                    brlapi_strerror(brlapi_error_location()));
-        goto fail_handle;
+        g_free(handle);
+        return;
     }
     baum->deferred_init = 0;
 
     baum->cellCount_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, baum_cellCount_timer_cb, baum);
 
     qemu_set_fd_handler(baum->brlapi_fd, baum_chr_read, NULL, baum);
+}
 
-    return chr;
+static void char_braille_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
 
-fail_handle:
-    g_free(handle);
-    g_free(chr);
-    return NULL;
+    cc->open = baum_chr_open;
+    cc->chr_write = baum_chr_write;
+    cc->chr_accept_input = baum_chr_accept_input;
+    cc->chr_free = baum_chr_free;
 }
 
+static const TypeInfo char_braille_type_info = {
+    .name = TYPE_CHARDEV_BRAILLE,
+    .parent = TYPE_CHARDEV,
+    .instance_size = sizeof(BaumChardev),
+    .class_init = char_braille_class_init,
+};
+
 static void register_types(void)
 {
     static const CharDriver driver = {
-        .instance_size = sizeof(BaumChardev),
         .kind = CHARDEV_BACKEND_KIND_BRAILLE,
-        .create = baum_chr_init,
-        .chr_write = baum_chr_write,
-        .chr_accept_input = baum_chr_accept_input,
-        .chr_free = baum_chr_free,
     };
 
     register_char_driver(&driver);
+    type_register_static(&char_braille_type_info);
 }
 
 type_init(register_types);
diff --git a/backends/msmouse.c b/backends/msmouse.c
index 4e474da..936a547 100644
--- a/backends/msmouse.c
+++ b/backends/msmouse.c
@@ -41,9 +41,13 @@ typedef struct {
     int outlen;
 } MouseChardev;
 
+#define TYPE_CHARDEV_MSMOUSE "chardev-msmouse"
+#define MOUSE_CHARDEV(obj)                                      \
+    OBJECT_CHECK(MouseChardev, (obj), TYPE_CHARDEV_MSMOUSE)
+
 static void msmouse_chr_accept_input(Chardev *chr)
 {
-    MouseChardev *mouse = (MouseChardev *)chr;
+    MouseChardev *mouse = MOUSE_CHARDEV(chr);
     int len;
 
     len = qemu_chr_be_can_write(chr);
@@ -98,7 +102,7 @@ static void msmouse_queue_event(MouseChardev *mouse)
 static void msmouse_input_event(DeviceState *dev, QemuConsole *src,
                                 InputEvent *evt)
 {
-    MouseChardev *mouse = (MouseChardev *)dev;
+    MouseChardev *mouse = MOUSE_CHARDEV(dev);
     InputMoveEvent *move;
     InputBtnEvent *btn;
 
@@ -122,8 +126,8 @@ static void msmouse_input_event(DeviceState *dev, QemuConsole *src,
 
 static void msmouse_input_sync(DeviceState *dev)
 {
-    MouseChardev *mouse = (MouseChardev *)dev;
-    Chardev *chr = (Chardev *)dev;
+    MouseChardev *mouse = MOUSE_CHARDEV(dev);
+    Chardev *chr = CHARDEV(dev);
 
     msmouse_queue_event(mouse);
     msmouse_chr_accept_input(chr);
@@ -137,7 +141,7 @@ static int msmouse_chr_write(struct Chardev *s, const uint8_t *buf, int len)
 
 static void msmouse_chr_free(struct Chardev *chr)
 {
-    MouseChardev *mouse = (MouseChardev *)chr;
+    MouseChardev *mouse = MOUSE_CHARDEV(chr);
 
     qemu_input_handler_unregister(mouse->hs);
 }
@@ -149,42 +153,43 @@ static QemuInputHandler msmouse_handler = {
     .sync  = msmouse_input_sync,
 };
 
-static Chardev *qemu_chr_open_msmouse(const CharDriver *driver,
-                                      const char *id,
-                                      ChardevBackend *backend,
-                                      ChardevReturn *ret,
-                                      bool *be_opened,
-                                      Error **errp)
+static void msmouse_chr_open(Chardev *chr,
+                             ChardevBackend *backend,
+                             bool *be_opened,
+                             Error **errp)
 {
-    ChardevCommon *common = backend->u.msmouse.data;
-    MouseChardev *mouse;
-    Chardev *chr;
+    MouseChardev *mouse = MOUSE_CHARDEV(chr);
 
-    chr = qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        return NULL;
-    }
     *be_opened = false;
-
-    mouse = (MouseChardev *)chr;
     mouse->hs = qemu_input_handler_register((DeviceState *)mouse,
                                             &msmouse_handler);
+}
 
+static void char_msmouse_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    return chr;
+    cc->open = msmouse_chr_open;
+    cc->chr_write = msmouse_chr_write;
+    cc->chr_accept_input = msmouse_chr_accept_input;
+    cc->chr_free = msmouse_chr_free;
 }
 
+static const TypeInfo char_msmouse_type_info = {
+    .name = TYPE_CHARDEV_MSMOUSE,
+    .parent = TYPE_CHARDEV,
+    .instance_size = sizeof(MouseChardev),
+    .class_init = char_msmouse_class_init,
+};
+
 static void register_types(void)
 {
     static const CharDriver driver = {
-        .instance_size = sizeof(MouseChardev),
         .kind = CHARDEV_BACKEND_KIND_MSMOUSE,
-        .create = qemu_chr_open_msmouse,
-        .chr_write = msmouse_chr_write,
-        .chr_accept_input = msmouse_chr_accept_input,
-        .chr_free = msmouse_chr_free,
     };
+
     register_char_driver(&driver);
+    type_register_static(&char_msmouse_type_info);
 }
 
 type_init(register_types);
diff --git a/backends/testdev.c b/backends/testdev.c
index 268b380..ea15143 100644
--- a/backends/testdev.c
+++ b/backends/testdev.c
@@ -36,6 +36,10 @@ typedef struct {
     int in_buf_used;
 } TestdevChardev;
 
+#define TYPE_CHARDEV_TESTDEV "chardev-testdev"
+#define TESTDEV_CHARDEV(obj)                                    \
+    OBJECT_CHECK(TestdevChardev, (obj), TYPE_CHARDEV_TESTDEV)
+
 /* Try to interpret a whole incoming packet */
 static int testdev_eat_packet(TestdevChardev *testdev)
 {
@@ -78,9 +82,9 @@ static int testdev_eat_packet(TestdevChardev *testdev)
 }
 
 /* The other end is writing some data.  Store it and try to interpret */
-static int testdev_write(Chardev *chr, const uint8_t *buf, int len)
+static int testdev_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    TestdevChardev *testdev = (TestdevChardev *)chr;
+    TestdevChardev *testdev = TESTDEV_CHARDEV(chr);
     int tocopy, eaten, orig_len = len;
 
     while (len) {
@@ -103,30 +107,28 @@ static int testdev_write(Chardev *chr, const uint8_t *buf, int len)
     return orig_len;
 }
 
-static Chardev *chr_testdev_init(const CharDriver *driver,
-                                 const char *id,
-                                 ChardevBackend *backend,
-                                 ChardevReturn *ret,
-                                 bool *be_opened,
-                                 Error **errp)
+static void char_testdev_class_init(ObjectClass *oc, void *data)
 {
-    TestdevChardev *testdev = g_new0(TestdevChardev, 1);;
-    Chardev *chr = (Chardev *)testdev;
-
-    chr->driver = driver;
+    ChardevClass *cc = CHARDEV_CLASS(oc);
 
-    return chr;
+    cc->chr_write = testdev_chr_write;
 }
 
+static const TypeInfo char_testdev_type_info = {
+    .name = TYPE_CHARDEV_TESTDEV,
+    .parent = TYPE_CHARDEV,
+    .instance_size = sizeof(TestdevChardev),
+    .class_init = char_testdev_class_init,
+};
+
 static void register_types(void)
 {
     static const CharDriver driver = {
-        .instance_size = sizeof(TestdevChardev),
         .kind = CHARDEV_BACKEND_KIND_TESTDEV,
-        .create = chr_testdev_init,
-        .chr_write = testdev_write,
     };
+
     register_char_driver(&driver);
+    type_register_static(&char_testdev_type_info);
 }
 
 type_init(register_types);
diff --git a/gdbstub.c b/gdbstub.c
index 396f892..1d5d2e2 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1724,18 +1724,35 @@ static void gdb_sigterm_handler(int signal)
 }
 #endif
 
+static void gdb_monitor_open(Chardev *chr, ChardevBackend *backend,
+                             bool *be_opened, Error **errp)
+{
+    *be_opened = false;
+}
+
+static void char_gdb_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->internal = true;
+    cc->open = gdb_monitor_open;
+    cc->chr_write = gdb_monitor_write;
+}
+
+#define TYPE_CHARDEV_GDB "chardev-gdb"
+
+static const TypeInfo char_gdb_type_info = {
+    .name = TYPE_CHARDEV_GDB,
+    .parent = TYPE_CHARDEV,
+    .class_init = char_gdb_class_init,
+};
+
 int gdbserver_start(const char *device)
 {
     GDBState *s;
     char gdbstub_device_name[128];
     Chardev *chr = NULL;
     Chardev *mon_chr;
-    ChardevCommon common = { 0 };
-    static const CharDriver driver = {
-        .instance_size = sizeof(Chardev),
-        .kind = -1,
-        .chr_write = gdb_monitor_write,
-    };
 
     if (!device)
         return -1;
@@ -1768,7 +1785,8 @@ int gdbserver_start(const char *device)
         qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
 
         /* Initialize a monitor terminal for gdb */
-        mon_chr = qemu_chr_alloc(&driver, &common, &error_abort);
+        mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
+                                   NULL, &error_abort);
         monitor_init(mon_chr, 0);
     } else {
         if (qemu_chr_fe_get_driver(&s->chr)) {
@@ -1791,4 +1809,11 @@ int gdbserver_start(const char *device)
 
     return 0;
 }
+
+static void register_types(void)
+{
+    type_register_static(&char_gdb_type_info);
+}
+
+type_init(register_types);
 #endif
diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
index 153ed2f..3c19384 100644
--- a/hw/bt/hci-csr.c
+++ b/hw/bt/hci-csr.c
@@ -55,6 +55,9 @@ struct csrhci_s {
     struct HCIInfo *hci;
 };
 
+#define TYPE_CHARDEV_HCI "chardev-hci"
+#define HCI_CHARDEV(obj) OBJECT_CHECK(struct csrhci_s, (obj), TYPE_CHARDEV_HCI)
+
 /* H4+ packet types */
 enum {
     H4_CMD_PKT   = 1,
@@ -462,23 +465,12 @@ qemu_irq *csrhci_pins_get(Chardev *chr)
     return s->pins;
 }
 
-Chardev *uart_hci_init(void)
+static void csrhci_open(Chardev *chr,
+                        ChardevBackend *backend,
+                        bool *be_opened,
+                        Error **errp)
 {
-    static const CharDriver hci_driver = {
-        .instance_size = sizeof(struct csrhci_s),
-        .kind = -1,
-        .chr_write = csrhci_write,
-        .chr_ioctl = csrhci_ioctl,
-    };
-    Error *err = NULL;
-    ChardevCommon common = { 0, };
-    Chardev *chr = qemu_chr_alloc(&hci_driver, &common, &err);
-    struct csrhci_s *s = (struct csrhci_s *)chr;
-
-    if (err) {
-        error_report_err(err);
-        return NULL;
-    }
+    struct csrhci_s *s = HCI_CHARDEV(chr);
 
     s->hci = qemu_next_hci();
     s->hci->opaque = s;
@@ -488,6 +480,35 @@ Chardev *uart_hci_init(void)
     s->out_tm = timer_new_ns(QEMU_CLOCK_VIRTUAL, csrhci_out_tick, s);
     s->pins = qemu_allocate_irqs(csrhci_pins, s, __csrhci_pins);
     csrhci_reset(s);
+    *be_opened = false;
+}
+
+static void char_hci_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->internal = true;
+    cc->open = csrhci_open;
+    cc->chr_write = csrhci_write;
+    cc->chr_ioctl = csrhci_ioctl;
+}
+
+static const TypeInfo char_hci_type_info = {
+    .name = TYPE_CHARDEV_HCI,
+    .parent = TYPE_CHARDEV,
+    .instance_size = sizeof(struct csrhci_s),
+    .class_init = char_hci_class_init,
+};
 
-    return chr;
+Chardev *uart_hci_init(void)
+{
+    return qemu_chardev_new(NULL, TYPE_CHARDEV_HCI,
+                            NULL, &error_abort);
 }
+
+static void register_types(void)
+{
+    type_register_static(&char_hci_type_info);
+}
+
+type_init(register_types);
diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index baa9e8f..da0e7dd 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -10,6 +10,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qemu/main-loop.h"
 #include "qemu/bitmap.h"
+#include "qom/object.h"
 
 /* character device */
 
@@ -90,7 +91,8 @@ typedef struct CharBackend {
 typedef struct CharDriver CharDriver;
 
 struct Chardev {
-    const CharDriver *driver;
+    Object parent_obj;
+
     QemuMutex chr_write_lock;
     CharBackend *be;
     char *label;
@@ -103,18 +105,6 @@ struct Chardev {
 };
 
 /**
- * qemu_chr_alloc:
- * @backend: the common backend config
- * @errp: pointer to a NULL-initialized error object
- *
- * Allocate and initialize a new Chardev.
- *
- * Returns: a newly allocated Chardev, or NULL on error.
- */
-Chardev *qemu_chr_alloc(const CharDriver *driver,
-                        ChardevCommon *backend, Error **errp);
-
-/**
  * @qemu_chr_new_from_opts:
  *
  * Create a new character backend from a QemuOpts list.
@@ -455,54 +445,73 @@ void qemu_chr_fe_accept_input(CharBackend *be);
 int qemu_chr_add_client(Chardev *s, int fd);
 Chardev *qemu_chr_find(const char *name);
 
-/**
- * @qemu_chr_get_kind:
- *
- * Returns the kind of char backend, or -1 if unspecified.
- */
-ChardevBackendKind qemu_chr_get_kind(const Chardev *chr);
-
-static inline bool qemu_chr_is_ringbuf(const Chardev *chr)
-{
-    return qemu_chr_get_kind(chr) == CHARDEV_BACKEND_KIND_RINGBUF ||
-        qemu_chr_get_kind(chr) == CHARDEV_BACKEND_KIND_MEMORY;
-}
-
 bool qemu_chr_has_feature(Chardev *chr,
                           CharDriverFeature feature);
 void qemu_chr_set_feature(Chardev *chr,
                           CharDriverFeature feature);
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename);
 
+#define TYPE_CHARDEV "chardev"
+#define CHARDEV(obj) OBJECT_CHECK(Chardev, (obj), TYPE_CHARDEV)
+#define CHARDEV_CLASS(klass) \
+    OBJECT_CLASS_CHECK(ChardevClass, (klass), TYPE_CHARDEV)
+#define CHARDEV_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(ChardevClass, (obj), TYPE_CHARDEV)
+
+#define TYPE_CHARDEV_NULL "chardev-null"
+#define TYPE_CHARDEV_MUX "chardev-mux"
+#define TYPE_CHARDEV_RINGBUF "chardev-ringbuf"
+#define TYPE_CHARDEV_PTY "chardev-pty"
+#define TYPE_CHARDEV_CONSOLE "chardev-console"
+#define TYPE_CHARDEV_STDIO "chardev-stdio"
+#define TYPE_CHARDEV_PIPE "chardev-pipe"
+#define TYPE_CHARDEV_MEMORY "chardev-memory"
+#define TYPE_CHARDEV_PARALLEL "chardev-parallel"
+#define TYPE_CHARDEV_FILE "chardev-file"
+#define TYPE_CHARDEV_SERIAL "chardev-serial"
+#define TYPE_CHARDEV_SOCKET "chardev-socket"
+#define TYPE_CHARDEV_UDP "chardev-udp"
+
+#define CHARDEV_IS_MUX(chr) \
+    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX)
+#define CHARDEV_IS_RINGBUF(chr) \
+    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_RINGBUF)
+#define CHARDEV_IS_PTY(chr) \
+    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_PTY)
+
+typedef struct ChardevClass {
+    ObjectClass parent_class;
+
+    bool internal; /* TODO: eventually use TYPE_USER_CREATABLE */
+
+    void (*open)(Chardev *chr, ChardevBackend *backend,
+                 bool *be_opened, Error **errp);
+
+    int (*chr_write)(Chardev *s, const uint8_t *buf, int len);
+    int (*chr_sync_read)(Chardev *s, const uint8_t *buf, int len);
+    GSource *(*chr_add_watch)(Chardev *s, GIOCondition cond);
+    void (*chr_update_read_handler)(Chardev *s, GMainContext *context);
+    int (*chr_ioctl)(Chardev *s, int cmd, void *arg);
+    int (*get_msgfds)(Chardev *s, int* fds, int num);
+    int (*set_msgfds)(Chardev *s, int *fds, int num);
+    int (*chr_add_client)(Chardev *chr, int fd);
+    int (*chr_wait_connected)(Chardev *chr, Error **errp);
+    void (*chr_free)(Chardev *chr);
+    void (*chr_disconnect)(Chardev *chr);
+    void (*chr_accept_input)(Chardev *chr);
+    void (*chr_set_echo)(Chardev *chr, bool echo);
+    void (*chr_set_fe_open)(Chardev *chr, int fe_open);
+} ChardevClass;
+
 struct CharDriver {
     ChardevBackendKind kind;
     const char *alias;
     void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp);
-    Chardev *(*create)(const CharDriver *driver,
-                       const char *id,
-                       ChardevBackend *backend,
-                       ChardevReturn *ret, bool *be_opened,
-                       Error **errp);
-    size_t instance_size;
-
-    int (*chr_write)(struct Chardev *s, const uint8_t *buf, int len);
-    int (*chr_sync_read)(struct Chardev *s,
-                         const uint8_t *buf, int len);
-    GSource *(*chr_add_watch)(struct Chardev *s, GIOCondition cond);
-    void (*chr_update_read_handler)(struct Chardev *s,
-                                    GMainContext *context);
-    int (*chr_ioctl)(struct Chardev *s, int cmd, void *arg);
-    int (*get_msgfds)(struct Chardev *s, int* fds, int num);
-    int (*set_msgfds)(struct Chardev *s, int *fds, int num);
-    int (*chr_add_client)(struct Chardev *chr, int fd);
-    int (*chr_wait_connected)(struct Chardev *chr, Error **errp);
-    void (*chr_free)(struct Chardev *chr);
-    void (*chr_disconnect)(struct Chardev *chr);
-    void (*chr_accept_input)(struct Chardev *chr);
-    void (*chr_set_echo)(struct Chardev *chr, bool echo);
-    void (*chr_set_fe_open)(struct Chardev *chr, int fe_open);
 };
 
+Chardev *qemu_chardev_new(const char *id, const char *typename,
+                          ChardevBackend *backend, Error **errp);
+
 void register_char_driver(const CharDriver *driver);
 
 extern int term_escape_char;
diff --git a/include/ui/console.h b/include/ui/console.h
index b59e7b8..af6350e 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -383,6 +383,8 @@ void graphic_hw_invalidate(QemuConsole *con);
 void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata);
 void graphic_hw_gl_block(QemuConsole *con, bool block);
 
+void qemu_console_early_init(void);
+
 QemuConsole *qemu_console_lookup_by_index(unsigned int index);
 QemuConsole *qemu_console_lookup_by_device(DeviceState *dev, uint32_t head);
 QemuConsole *qemu_console_lookup_by_device_name(const char *device_id,
diff --git a/monitor.c b/monitor.c
index 065f659..25a480a 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3196,7 +3196,7 @@ static void ringbuf_completion(ReadLineState *rs, const char *str)
 
         if (!strncmp(chr_info->label, str, len)) {
             Chardev *chr = qemu_chr_find(chr_info->label);
-            if (chr && qemu_chr_is_ringbuf(chr)) {
+            if (chr && CHARDEV_IS_RINGBUF(chr)) {
                 readline_add_completion(rs, chr_info->label);
             }
         }
diff --git a/qemu-char.c b/qemu-char.c
index 113c4a8..6b4a299 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -160,43 +160,6 @@ static char *sockaddr_to_str(struct sockaddr_storage *ss, socklen_t ss_len,
 static QTAILQ_HEAD(ChardevHead, Chardev) chardevs =
     QTAILQ_HEAD_INITIALIZER(chardevs);
 
-static void qemu_chr_free_common(Chardev *chr);
-
-Chardev *qemu_chr_alloc(const CharDriver *driver,
-                                ChardevCommon *backend, Error **errp)
-{
-    Chardev *chr;
-
-    assert(driver);
-    assert(driver->chr_write);
-    assert(driver->instance_size >= sizeof(Chardev));
-
-    chr = g_malloc0(driver->instance_size);
-    qemu_mutex_init(&chr->chr_write_lock);
-    if (backend->has_logfile) {
-        int flags = O_WRONLY | O_CREAT;
-        if (backend->has_logappend &&
-            backend->logappend) {
-            flags |= O_APPEND;
-        } else {
-            flags |= O_TRUNC;
-        }
-        chr->logfd = qemu_open(backend->logfile, flags, 0666);
-        if (chr->logfd < 0) {
-            error_setg_errno(errp, errno,
-                             "Unable to open logfile %s",
-                             backend->logfile);
-            g_free(chr);
-            return NULL;
-        }
-    } else {
-        chr->logfd = -1;
-    }
-    chr->driver = driver;
-
-    return chr;
-}
-
 void qemu_chr_be_event(Chardev *s, int event)
 {
     CharBackend *be = s->be;
@@ -254,13 +217,14 @@ static void qemu_chr_fe_write_log(Chardev *s,
 static int qemu_chr_fe_write_buffer(Chardev *s,
                                     const uint8_t *buf, int len, int *offset)
 {
+    ChardevClass *cc = CHARDEV_GET_CLASS(s);
     int res = 0;
     *offset = 0;
 
     qemu_mutex_lock(&s->chr_write_lock);
     while (*offset < len) {
     retry:
-        res = s->driver->chr_write(s, buf + *offset, len - *offset);
+        res = cc->chr_write(s, buf + *offset, len - *offset);
         if (res < 0 && errno == EAGAIN) {
             g_usleep(100);
             goto retry;
@@ -288,6 +252,7 @@ static bool qemu_chr_replay(Chardev *chr)
 int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
 {
     Chardev *s = be->chr;
+    ChardevClass *cc;
     int ret;
 
     if (!s) {
@@ -302,8 +267,9 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
         return ret;
     }
 
+    cc = CHARDEV_GET_CLASS(s);
     qemu_mutex_lock(&s->chr_write_lock);
-    ret = s->driver->chr_write(s, buf, len);
+    ret = cc->chr_write(s, buf, len);
 
     if (ret > 0) {
         qemu_chr_fe_write_log(s, buf, ret);
@@ -359,7 +325,7 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
     int offset = 0, counter = 10;
     int res;
 
-    if (!s || !s->driver->chr_sync_read) {
+    if (!s || !CHARDEV_GET_CLASS(s)->chr_sync_read) {
         return 0;
     }
 
@@ -369,7 +335,8 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
 
     while (offset < len) {
     retry:
-        res = s->driver->chr_sync_read(s, buf + offset, len - offset);
+        res = CHARDEV_GET_CLASS(s)->chr_sync_read(s, buf + offset,
+                                                  len - offset);
         if (res == -1 && errno == EAGAIN) {
             g_usleep(100);
             goto retry;
@@ -404,10 +371,10 @@ int qemu_chr_fe_ioctl(CharBackend *be, int cmd, void *arg)
     Chardev *s = be->chr;
     int res;
 
-    if (!s || !s->driver->chr_ioctl || qemu_chr_replay(s)) {
+    if (!s || !CHARDEV_GET_CLASS(s)->chr_ioctl || qemu_chr_replay(s)) {
         res = -ENOTSUP;
     } else {
-        res = s->driver->chr_ioctl(s, cmd, arg);
+        res = CHARDEV_GET_CLASS(s)->chr_ioctl(s, cmd, arg);
     }
 
     return res;
@@ -466,7 +433,8 @@ int qemu_chr_fe_get_msgfds(CharBackend *be, int *fds, int len)
         return -1;
     }
 
-    return s->driver->get_msgfds ? s->driver->get_msgfds(s, fds, len) : -1;
+    return CHARDEV_GET_CLASS(s)->get_msgfds ?
+        CHARDEV_GET_CLASS(s)->get_msgfds(s, fds, len) : -1;
 }
 
 int qemu_chr_fe_set_msgfds(CharBackend *be, int *fds, int num)
@@ -477,12 +445,14 @@ int qemu_chr_fe_set_msgfds(CharBackend *be, int *fds, int num)
         return -1;
     }
 
-    return s->driver->set_msgfds ? s->driver->set_msgfds(s, fds, num) : -1;
+    return CHARDEV_GET_CLASS(s)->set_msgfds ?
+        CHARDEV_GET_CLASS(s)->set_msgfds(s, fds, num) : -1;
 }
 
 int qemu_chr_add_client(Chardev *s, int fd)
 {
-    return s->driver->chr_add_client ? s->driver->chr_add_client(s, fd) : -1;
+    return CHARDEV_GET_CLASS(s)->chr_add_client ?
+        CHARDEV_GET_CLASS(s)->chr_add_client(s, fd) : -1;
 }
 
 void qemu_chr_fe_accept_input(CharBackend *be)
@@ -493,8 +463,8 @@ void qemu_chr_fe_accept_input(CharBackend *be)
         return;
     }
 
-    if (s->driver->chr_accept_input) {
-        s->driver->chr_accept_input(s);
+    if (CHARDEV_GET_CLASS(s)->chr_accept_input) {
+        CHARDEV_GET_CLASS(s)->chr_accept_input(s);
     }
     qemu_notify_event();
 }
@@ -515,34 +485,98 @@ static void remove_fd_in_watch(Chardev *chr);
 static void mux_chr_set_handlers(Chardev *chr, GMainContext *context);
 static void mux_set_focus(Chardev *chr, int focus);
 
-static int null_chr_write(Chardev *chr, const uint8_t *buf, int len)
+static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
+                           bool *be_opened, Error **errp)
 {
-    return len;
+    ChardevClass *cc = CHARDEV_GET_CLASS(chr);
+    /* Any ChardevCommon member would work */
+    ChardevCommon *common = backend ? backend->u.null.data : NULL;
+
+    if (common && common->has_logfile) {
+        int flags = O_WRONLY | O_CREAT;
+        if (common->has_logappend &&
+            common->logappend) {
+            flags |= O_APPEND;
+        } else {
+            flags |= O_TRUNC;
+        }
+        chr->logfd = qemu_open(common->logfile, flags, 0666);
+        if (chr->logfd < 0) {
+            error_setg_errno(errp, errno,
+                             "Unable to open logfile %s",
+                             common->logfile);
+            return;
+        }
+    }
+
+    if (cc->open) {
+        cc->open(chr, backend, be_opened, errp);
+    }
 }
 
-static Chardev *qemu_chr_open_null(const CharDriver *driver,
-                                   const char *id,
-                                   ChardevBackend *backend,
-                                   ChardevReturn *ret,
-                                   bool *be_opened,
-                                   Error **errp)
+static void char_init(Object *obj)
 {
-    Chardev *chr;
-    ChardevCommon *common = backend->u.null.data;
+    Chardev *chr = CHARDEV(obj);
 
-    chr = qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        return NULL;
+    chr->logfd = -1;
+    qemu_mutex_init(&chr->chr_write_lock);
+}
+
+static void char_finalize(Object *obj)
+{
+    Chardev *chr = CHARDEV(obj);
+
+    if (chr->be) {
+        chr->be->chr = NULL;
+    }
+    g_free(chr->filename);
+    g_free(chr->label);
+    if (chr->logfd != -1) {
+        close(chr->logfd);
     }
+    qemu_mutex_destroy(&chr->chr_write_lock);
+}
+
+static const TypeInfo char_type_info = {
+    .name = TYPE_CHARDEV,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(Chardev),
+    .instance_init = char_init,
+    .instance_finalize = char_finalize,
+    .abstract = true,
+    .class_size = sizeof(ChardevClass),
+};
+
+static int null_chr_write(Chardev *chr, const uint8_t *buf, int len)
+{
+    return len;
+}
+
+static void null_chr_open(Chardev *chr,
+                          ChardevBackend *backend,
+                          bool *be_opened,
+                          Error **errp)
+{
     *be_opened = false;
-    return chr;
 }
 
 static const CharDriver null_driver = {
-    .instance_size = sizeof(Chardev),
     .kind = CHARDEV_BACKEND_KIND_NULL,
-    .create = qemu_chr_open_null,
-    .chr_write = null_chr_write,
+};
+
+static void char_null_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->open = null_chr_open;
+    cc->chr_write = null_chr_write;
+}
+
+static const TypeInfo char_null_type_info = {
+    .name = TYPE_CHARDEV_NULL,
+    .parent = TYPE_CHARDEV,
+    .instance_size = sizeof(Chardev),
+    .class_init = char_null_class_init,
 };
 
 /* MUX driver for serial I/O splitting */
@@ -570,10 +604,12 @@ struct MuxChardev {
     int64_t timestamps_start;
 };
 
+#define MUX_CHARDEV(obj) OBJECT_CHECK(MuxChardev, (obj), TYPE_CHARDEV_MUX)
+
 /* Called with chr_write_lock held.  */
 static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    MuxChardev *d = (MuxChardev *)chr;
+    MuxChardev *d = MUX_CHARDEV(chr);
     int ret;
     if (!d->timestamps) {
         ret = qemu_chr_fe_write(&d->chr, buf, len);
@@ -707,7 +743,7 @@ static int mux_proc_byte(Chardev *chr, MuxChardev *d, int ch)
 
 static void mux_chr_accept_input(Chardev *chr)
 {
-    MuxChardev *d = (MuxChardev *)chr;
+    MuxChardev *d = MUX_CHARDEV(chr);
     int m = d->focus;
     CharBackend *be = d->backends[m];
 
@@ -720,7 +756,7 @@ static void mux_chr_accept_input(Chardev *chr)
 
 static int mux_chr_can_read(void *opaque)
 {
-    MuxChardev *d = opaque;
+    MuxChardev *d = MUX_CHARDEV(opaque);
     int m = d->focus;
     CharBackend *be = d->backends[m];
 
@@ -737,8 +773,8 @@ static int mux_chr_can_read(void *opaque)
 
 static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
 {
-    Chardev *chr = opaque;
-    MuxChardev *d = opaque;
+    Chardev *chr = CHARDEV(opaque);
+    MuxChardev *d = MUX_CHARDEV(opaque);
     int m = d->focus;
     CharBackend *be = d->backends[m];
     int i;
@@ -760,7 +796,7 @@ static bool muxes_realized;
 
 static void mux_chr_event(void *opaque, int event)
 {
-    MuxChardev *d = opaque;
+    MuxChardev *d = MUX_CHARDEV(opaque);
     int i;
 
     if (!muxes_realized) {
@@ -789,8 +825,8 @@ static void muxes_realize_done(Notifier *notifier, void *unused)
     Chardev *chr;
 
     QTAILQ_FOREACH(chr, &chardevs, next) {
-        if (qemu_chr_get_kind(chr) == CHARDEV_BACKEND_KIND_MUX) {
-            MuxChardev *d = (MuxChardev *)chr;
+        if (CHARDEV_IS_MUX(chr)) {
+            MuxChardev *d = MUX_CHARDEV(chr);
             int i;
 
             /* send OPENED to all already-attached FEs */
@@ -812,19 +848,20 @@ static Notifier muxes_realize_notify = {
 
 static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
 {
-    MuxChardev *d = (MuxChardev *)s;
+    MuxChardev *d = MUX_CHARDEV(s);
     Chardev *chr = qemu_chr_fe_get_driver(&d->chr);
+    ChardevClass *cc = CHARDEV_GET_CLASS(chr);
 
-    if (!chr->driver->chr_add_watch) {
+    if (!cc->chr_add_watch) {
         return NULL;
     }
 
-    return chr->driver->chr_add_watch(chr, cond);
+    return cc->chr_add_watch(chr, cond);
 }
 
 static void mux_chr_free(struct Chardev *chr)
 {
-    MuxChardev *d = (MuxChardev *)chr;
+    MuxChardev *d = MUX_CHARDEV(chr);
     int i;
 
     for (i = 0; i < d->mux_cnt; i++) {
@@ -838,7 +875,7 @@ static void mux_chr_free(struct Chardev *chr)
 
 static void mux_chr_set_handlers(Chardev *chr, GMainContext *context)
 {
-    MuxChardev *d = (MuxChardev *)chr;
+    MuxChardev *d = MUX_CHARDEV(chr);
 
     /* Fix up the real driver with mux routines */
     qemu_chr_fe_set_handlers(&d->chr,
@@ -851,7 +888,7 @@ static void mux_chr_set_handlers(Chardev *chr, GMainContext *context)
 
 static void mux_set_focus(Chardev *chr, int focus)
 {
-    MuxChardev *d = (MuxChardev *)chr;
+    MuxChardev *d = MUX_CHARDEV(chr);
 
     assert(focus >= 0);
     assert(focus < d->mux_cnt);
@@ -865,40 +902,27 @@ static void mux_set_focus(Chardev *chr, int focus)
     mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
 }
 
-static Chardev *qemu_chr_open_mux(const CharDriver *driver,
-                                  const char *id,
-                                  ChardevBackend *backend,
-                                  ChardevReturn *ret,
-                                  bool *be_opened,
-                                  Error **errp)
+static void qemu_chr_open_mux(Chardev *chr,
+                              ChardevBackend *backend,
+                              bool *be_opened,
+                              Error **errp)
 {
     ChardevMux *mux = backend->u.mux.data;
-    Chardev *chr, *drv;
-    MuxChardev *d;
-    ChardevCommon *common = qapi_ChardevMux_base(mux);
+    Chardev *drv;
+    MuxChardev *d = MUX_CHARDEV(chr);
 
     drv = qemu_chr_find(mux->chardev);
     if (drv == NULL) {
         error_setg(errp, "mux: base chardev %s not found", mux->chardev);
-        return NULL;
+        return;
     }
 
-    chr = qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        return NULL;
-    }
-    d = (MuxChardev *)chr;
     d->focus = -1;
     /* only default to opened state if we've realized the initial
      * set of muxes
      */
     *be_opened = muxes_realized;
-    if (!qemu_chr_fe_init(&d->chr, drv, errp)) {
-        qemu_chr_free(chr);
-        return NULL;
-    }
-
-    return chr;
+    qemu_chr_fe_init(&d->chr, drv, errp);
 }
 
 Chardev *qemu_chr_fe_get_driver(CharBackend *be)
@@ -910,8 +934,8 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
 {
     int tag = 0;
 
-    if (qemu_chr_get_kind(s) == CHARDEV_BACKEND_KIND_MUX) {
-        MuxChardev *d = (MuxChardev *)s;
+    if (CHARDEV_IS_MUX(s)) {
+        MuxChardev *d = MUX_CHARDEV(s);
 
         if (d->mux_cnt >= MAX_MUX) {
             goto unavailable;
@@ -937,8 +961,8 @@ unavailable:
 
 static bool qemu_chr_is_busy(Chardev *s)
 {
-    if (qemu_chr_get_kind(s) == CHARDEV_BACKEND_KIND_MUX) {
-        MuxChardev *d = (MuxChardev *)s;
+    if (CHARDEV_IS_MUX(s)) {
+        MuxChardev *d = MUX_CHARDEV(s);
         return d->mux_cnt >= 0;
     } else {
         return s->be != NULL;
@@ -954,8 +978,8 @@ void qemu_chr_fe_deinit(CharBackend *b)
         if (b->chr->be == b) {
             b->chr->be = NULL;
         }
-        if (qemu_chr_get_kind(b->chr) == CHARDEV_BACKEND_KIND_MUX) {
-            MuxChardev *d = (MuxChardev *)b->chr;
+        if (CHARDEV_IS_MUX(b->chr)) {
+            MuxChardev *d = MUX_CHARDEV(b->chr);
             d->backends[b->tag] = NULL;
         }
         b->chr = NULL;
@@ -971,6 +995,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
                               bool set_open)
 {
     Chardev *s;
+    ChardevClass *cc;
     int fe_open;
 
     s = b->chr;
@@ -978,6 +1003,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
         return;
     }
 
+    cc = CHARDEV_GET_CLASS(s);
     if (!opaque && !fd_can_read && !fd_read && !fd_event) {
         fe_open = 0;
         remove_fd_in_watch(s);
@@ -988,8 +1014,8 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
     b->chr_read = fd_read;
     b->chr_event = fd_event;
     b->opaque = opaque;
-    if (s->driver->chr_update_read_handler) {
-        s->driver->chr_update_read_handler(s, context);
+    if (cc->chr_update_read_handler) {
+        cc->chr_update_read_handler(s, context);
     }
 
     if (set_open) {
@@ -1005,7 +1031,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
         }
     }
 
-    if (qemu_chr_get_kind(s) == CHARDEV_BACKEND_KIND_MUX) {
+    if (CHARDEV_IS_MUX(s)) {
         mux_chr_set_handlers(s, context);
     }
 }
@@ -1016,7 +1042,7 @@ void qemu_chr_fe_take_focus(CharBackend *b)
         return;
     }
 
-    if (qemu_chr_get_kind(b->chr) == CHARDEV_BACKEND_KIND_MUX) {
+    if (CHARDEV_IS_MUX(b->chr)) {
         mux_set_focus(b->chr, b->tag);
     }
 }
@@ -1193,7 +1219,6 @@ static int io_channel_send(QIOChannel *ioc, const void *buf, size_t len)
     return io_channel_send_full(ioc, buf, len, NULL, 0);
 }
 
-
 typedef struct FDChardev {
     Chardev parent;
     Chardev *chr;
@@ -1201,18 +1226,21 @@ typedef struct FDChardev {
     int max_size;
 } FDChardev;
 
+#define TYPE_CHARDEV_FD "chardev-fd"
+#define FD_CHARDEV(obj) OBJECT_CHECK(FDChardev, (obj), TYPE_CHARDEV_FD)
+
 /* Called with chr_write_lock held.  */
 static int fd_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    FDChardev *s = (FDChardev *)chr;
+    FDChardev *s = FD_CHARDEV(chr);
 
     return io_channel_send(s->ioc_out, buf, len);
 }
 
 static gboolean fd_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
-    Chardev *chr = opaque;
-    FDChardev *s = opaque;
+    Chardev *chr = CHARDEV(opaque);
+    FDChardev *s = FD_CHARDEV(opaque);
     int len;
     uint8_t buf[READ_BUF_LEN];
     ssize_t ret;
@@ -1241,8 +1269,8 @@ static gboolean fd_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 
 static int fd_chr_read_poll(void *opaque)
 {
-    Chardev *chr = opaque;
-    FDChardev *s = opaque;
+    Chardev *chr = CHARDEV(opaque);
+    FDChardev *s = FD_CHARDEV(opaque);
 
     s->max_size = qemu_chr_be_can_write(chr);
     return s->max_size;
@@ -1250,14 +1278,14 @@ static int fd_chr_read_poll(void *opaque)
 
 static GSource *fd_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    FDChardev *s = (FDChardev *)chr;
+    FDChardev *s = FD_CHARDEV(chr);
     return qio_channel_create_watch(s->ioc_out, cond);
 }
 
 static void fd_chr_update_read_handler(Chardev *chr,
                                        GMainContext *context)
 {
-    FDChardev *s = (FDChardev *)chr;
+    FDChardev *s = FD_CHARDEV(chr);
 
     remove_fd_in_watch(chr);
     if (s->ioc_in) {
@@ -1270,7 +1298,7 @@ static void fd_chr_update_read_handler(Chardev *chr,
 
 static void fd_chr_free(struct Chardev *chr)
 {
-    FDChardev *s = (FDChardev *)chr;
+    FDChardev *s = FD_CHARDEV(chr);
 
     remove_fd_in_watch(chr);
     if (s->ioc_in) {
@@ -1284,19 +1312,12 @@ static void fd_chr_free(struct Chardev *chr)
 }
 
 /* open a character device to a unix fd */
-static Chardev *qemu_chr_open_fd(const CharDriver *driver,
-                                 int fd_in, int fd_out,
-                                 ChardevCommon *backend, Error **errp)
+static void qemu_chr_open_fd(Chardev *chr,
+                             int fd_in, int fd_out)
 {
-    Chardev *chr;
-    FDChardev *s;
+    FDChardev *s = FD_CHARDEV(chr);
     char *name;
 
-    chr = qemu_chr_alloc(driver, backend, errp);
-    if (!chr) {
-        return NULL;
-    }
-    s = (FDChardev *)chr;
     s->ioc_in = QIO_CHANNEL(qio_channel_file_new_fd(fd_in));
     name = g_strdup_printf("chardev-file-in-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(s->ioc_in), name);
@@ -1307,24 +1328,36 @@ static Chardev *qemu_chr_open_fd(const CharDriver *driver,
     g_free(name);
     qemu_set_nonblock(fd_out);
     s->chr = chr;
+}
 
-    return chr;
+static void char_fd_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->chr_add_watch = fd_chr_add_watch;
+    cc->chr_write = fd_chr_write;
+    cc->chr_update_read_handler = fd_chr_update_read_handler;
+    cc->chr_free = fd_chr_free;
 }
 
-static Chardev *qemu_chr_open_pipe(const CharDriver *driver,
-                                   const char *id,
-                                   ChardevBackend *backend,
-                                   ChardevReturn *ret,
-                                   bool *be_opened,
-                                   Error **errp)
+static const TypeInfo char_fd_type_info = {
+    .name = TYPE_CHARDEV_FD,
+    .parent = TYPE_CHARDEV,
+    .instance_size = sizeof(FDChardev),
+    .class_init = char_fd_class_init,
+    .abstract = true,
+};
+
+static void qemu_chr_open_pipe(Chardev *chr,
+                               ChardevBackend *backend,
+                               bool *be_opened,
+                               Error **errp)
 {
     ChardevHostdev *opts = backend->u.pipe.data;
     int fd_in, fd_out;
     char *filename_in;
     char *filename_out;
     const char *filename = opts->device;
-    ChardevCommon *common = qapi_ChardevHostdev_base(opts);
-
 
     filename_in = g_strdup_printf("%s.in", filename);
     filename_out = g_strdup_printf("%s.out", filename);
@@ -1340,10 +1373,10 @@ static Chardev *qemu_chr_open_pipe(const CharDriver *driver,
         TFR(fd_in = fd_out = qemu_open(filename, O_RDWR | O_BINARY));
         if (fd_in < 0) {
             error_setg_file_open(errp, errno, filename);
-            return NULL;
+            return;
         }
     }
-    return qemu_chr_open_fd(driver, fd_in, fd_out, common, errp);
+    qemu_chr_open_fd(chr, fd_in, fd_out);
 }
 
 /* init terminal so that we can grab keys */
@@ -1395,26 +1428,22 @@ static void qemu_chr_free_stdio(struct Chardev *chr)
     fd_chr_free(chr);
 }
 
-static Chardev *qemu_chr_open_stdio(const CharDriver *driver,
-                                    const char *id,
-                                    ChardevBackend *backend,
-                                    ChardevReturn *ret,
-                                    bool *be_opened,
-                                    Error **errp)
+static void qemu_chr_open_stdio(Chardev *chr,
+                                ChardevBackend *backend,
+                                bool *be_opened,
+                                Error **errp)
 {
     ChardevStdio *opts = backend->u.stdio.data;
-    Chardev *chr;
     struct sigaction act;
-    ChardevCommon *common = qapi_ChardevStdio_base(opts);
 
     if (is_daemonized()) {
         error_setg(errp, "cannot use stdio with -daemonize");
-        return NULL;
+        return;
     }
 
     if (stdio_in_use) {
         error_setg(errp, "cannot use stdio by multiple character devices");
-        return NULL;
+        return;
     }
 
     stdio_in_use = true;
@@ -1427,16 +1456,12 @@ static Chardev *qemu_chr_open_stdio(const CharDriver *driver,
     act.sa_handler = term_stdio_handler;
     sigaction(SIGCONT, &act, NULL);
 
-    chr = qemu_chr_open_fd(driver, 0, 1, common, errp);
-    if (!chr) {
-        return NULL;
-    }
+    qemu_chr_open_fd(chr, 0, 1);
+
     if (opts->has_signal) {
         stdio_allow_signal = opts->signal;
     }
     qemu_chr_set_echo_stdio(chr, false);
-
-    return chr;
 }
 
 #if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__) \
@@ -1457,13 +1482,15 @@ typedef struct {
     guint open_tag;
 } PtyChardev;
 
+#define PTY_CHARDEV(obj) OBJECT_CHECK(PtyChardev, (obj), TYPE_CHARDEV_PTY)
+
 static void pty_chr_update_read_handler_locked(Chardev *chr);
 static void pty_chr_state(Chardev *chr, int connected);
 
 static gboolean pty_chr_timer(gpointer opaque)
 {
-    struct Chardev *chr = opaque;
-    PtyChardev *s = opaque;
+    struct Chardev *chr = CHARDEV(opaque);
+    PtyChardev *s = PTY_CHARDEV(opaque);
 
     qemu_mutex_lock(&chr->chr_write_lock);
     s->timer_tag = 0;
@@ -1479,7 +1506,7 @@ static gboolean pty_chr_timer(gpointer opaque)
 /* Called with chr_write_lock held.  */
 static void pty_chr_rearm_timer(Chardev *chr, int ms)
 {
-    PtyChardev *s = (PtyChardev *)chr;
+    PtyChardev *s = PTY_CHARDEV(chr);
     char *name;
 
     if (s->timer_tag) {
@@ -1501,7 +1528,7 @@ static void pty_chr_rearm_timer(Chardev *chr, int ms)
 /* Called with chr_write_lock held.  */
 static void pty_chr_update_read_handler_locked(Chardev *chr)
 {
-    PtyChardev *s = (PtyChardev *)chr;
+    PtyChardev *s = PTY_CHARDEV(chr);
     GPollFD pfd;
     int rc;
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(s->ioc);
@@ -1530,9 +1557,9 @@ static void pty_chr_update_read_handler(Chardev *chr,
 }
 
 /* Called with chr_write_lock held.  */
-static int pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
+static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    PtyChardev *s = (PtyChardev *)chr;
+    PtyChardev *s = PTY_CHARDEV(chr);
 
     if (!s->connected) {
         /* guest sends data, check for (re-)connect */
@@ -1546,7 +1573,7 @@ static int pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
 
 static GSource *pty_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    PtyChardev *s = (PtyChardev *)chr;
+    PtyChardev *s = PTY_CHARDEV(chr);
     if (!s->connected) {
         return NULL;
     }
@@ -1555,8 +1582,8 @@ static GSource *pty_chr_add_watch(Chardev *chr, GIOCondition cond)
 
 static int pty_chr_read_poll(void *opaque)
 {
-    Chardev *chr = opaque;
-    PtyChardev *s = opaque;
+    Chardev *chr = CHARDEV(opaque);
+    PtyChardev *s = PTY_CHARDEV(opaque);
 
     s->read_bytes = qemu_chr_be_can_write(chr);
     return s->read_bytes;
@@ -1564,8 +1591,8 @@ static int pty_chr_read_poll(void *opaque)
 
 static gboolean pty_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
-    Chardev *chr = opaque;
-    PtyChardev *s = opaque;
+    Chardev *chr = CHARDEV(opaque);
+    PtyChardev *s = PTY_CHARDEV(opaque);
     gsize len;
     uint8_t buf[READ_BUF_LEN];
     ssize_t ret;
@@ -1589,8 +1616,8 @@ static gboolean pty_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 
 static gboolean qemu_chr_be_generic_open_func(gpointer opaque)
 {
-    Chardev *chr = opaque;
-    PtyChardev *s = opaque;
+    Chardev *chr = CHARDEV(opaque);
+    PtyChardev *s = PTY_CHARDEV(opaque);
 
     s->open_tag = 0;
     qemu_chr_be_generic_open(chr);
@@ -1600,7 +1627,7 @@ static gboolean qemu_chr_be_generic_open_func(gpointer opaque)
 /* Called with chr_write_lock held.  */
 static void pty_chr_state(Chardev *chr, int connected)
 {
-    PtyChardev *s = (PtyChardev *)chr;
+    PtyChardev *s = PTY_CHARDEV(chr);
 
     if (!connected) {
         if (s->open_tag) {
@@ -1634,7 +1661,7 @@ static void pty_chr_state(Chardev *chr, int connected)
 
 static void pty_chr_free(struct Chardev *chr)
 {
-    PtyChardev *s = (PtyChardev *)chr;
+    PtyChardev *s = PTY_CHARDEV(chr);
 
     qemu_mutex_lock(&chr->chr_write_lock);
     pty_chr_state(chr, 0);
@@ -1647,61 +1674,58 @@ static void pty_chr_free(struct Chardev *chr)
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
 
-static Chardev *qemu_chr_open_pty(const CharDriver *driver,
-                                  const char *id,
-                                  ChardevBackend *backend,
-                                  ChardevReturn *ret,
-                                  bool *be_opened,
-                                  Error **errp)
+static void char_pty_open(Chardev *chr,
+                          ChardevBackend *backend,
+                          bool *be_opened,
+                          Error **errp)
 {
-    Chardev *chr;
     PtyChardev *s;
     int master_fd, slave_fd;
     char pty_name[PATH_MAX];
-    ChardevCommon *common = backend->u.pty.data;
     char *name;
 
     master_fd = qemu_openpty_raw(&slave_fd, pty_name);
     if (master_fd < 0) {
         error_setg_errno(errp, errno, "Failed to create PTY");
-        return NULL;
+        return;
     }
 
     close(slave_fd);
     qemu_set_nonblock(master_fd);
 
-    chr = qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        close(master_fd);
-        return NULL;
-    }
-
     chr->filename = g_strdup_printf("pty:%s", pty_name);
-    ret->pty = g_strdup(pty_name);
-    ret->has_pty = true;
-
     error_report("char device redirected to %s (label %s)",
-                 pty_name, id);
+                 pty_name, chr->label);
 
-    s = (PtyChardev *)chr;
+    s = PTY_CHARDEV(chr);
     s->ioc = QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
     name = g_strdup_printf("chardev-pty-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(s->ioc), name);
     g_free(name);
     s->timer_tag = 0;
     *be_opened = false;
-
-    return chr;
 }
 
 static const CharDriver pty_driver = {
-    .instance_size = sizeof(PtyChardev),
     .kind = CHARDEV_BACKEND_KIND_PTY,
-    .create = qemu_chr_open_pty,
-    .chr_write = pty_chr_write,
-    .chr_update_read_handler = pty_chr_update_read_handler,
-    .chr_add_watch = pty_chr_add_watch,
-    .chr_free = pty_chr_free,
+};
+
+static void char_pty_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->open = char_pty_open;
+    cc->chr_write = char_pty_chr_write;
+    cc->chr_update_read_handler = pty_chr_update_read_handler;
+    cc->chr_add_watch = pty_chr_add_watch;
+    cc->chr_free = pty_chr_free;
+}
+
+static const TypeInfo char_pty_type_info = {
+    .name = TYPE_CHARDEV_PTY,
+    .parent = TYPE_CHARDEV,
+    .instance_size = sizeof(PtyChardev),
+    .class_init = char_pty_class_init,
 };
 
 static void tty_serial_init(int fd, int speed,
@@ -1821,7 +1845,7 @@ static void tty_serial_init(int fd, int speed,
 
 static int tty_serial_ioctl(Chardev *chr, int cmd, void *arg)
 {
-    FDChardev *s = (FDChardev *)chr;
+    FDChardev *s = FD_CHARDEV(chr);
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(s->ioc_in);
 
     switch(cmd) {
@@ -1905,6 +1929,9 @@ typedef struct {
     int mode;
 } ParallelChardev;
 
+#define PARALLEL_CHARDEV(obj) \
+    OBJECT_CHECK(ParallelChardev, (obj), TYPE_CHARDEV_PARALLEL)
+
 static int pp_hw_mode(ParallelChardev *s, uint16_t mode)
 {
     if (s->mode != mode) {
@@ -1918,7 +1945,7 @@ static int pp_hw_mode(ParallelChardev *s, uint16_t mode)
 
 static int pp_ioctl(Chardev *chr, int cmd, void *arg)
 {
-    ParallelChardev *drv = (ParallelChardev *)chr;
+    ParallelChardev *drv = PARALLEL_CHARDEV(chr);
     int fd = drv->fd;
     uint8_t b;
 
@@ -1999,7 +2026,7 @@ static int pp_ioctl(Chardev *chr, int cmd, void *arg)
 
 static void pp_free(Chardev *chr)
 {
-    ParallelChardev *drv = (ParallelChardev *)chr;
+    ParallelChardev *drv = PARALLEL_CHARDEV(chr);
     int fd = drv->fd;
 
     pp_hw_mode(drv, IEEE1284_MODE_COMPAT);
@@ -2008,31 +2035,21 @@ static void pp_free(Chardev *chr)
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
 
-static Chardev *qemu_chr_open_pp_fd(const CharDriver *driver,
-                                    int fd,
-                                    ChardevCommon *backend,
-                                    bool *be_opened,
-                                    Error **errp)
+static void qemu_chr_open_pp_fd(Chardev *chr,
+                                int fd,
+                                bool *be_opened,
+                                Error **errp)
 {
-    Chardev *chr;
-    ParallelChardev *drv;
+    ParallelChardev *drv = PARALLEL_CHARDEV(chr);
 
     if (ioctl(fd, PPCLAIM) < 0) {
         error_setg_errno(errp, errno, "not a parallel port");
         close(fd);
-        return NULL;
-    }
-
-    chr = qemu_chr_alloc(driver, backend, errp);
-    if (!chr) {
-        return NULL;
+        return;
     }
 
-    drv = (ParallelChardev *)chr;
     drv->fd = fd;
     drv->mode = IEEE1284_MODE_COMPAT;
-
-    return chr;
 }
 #endif /* __linux__ */
 
@@ -2045,9 +2062,12 @@ typedef struct {
     int fd;
 } ParallelChardev;
 
+#define PARALLEL_CHARDEV(obj)                                   \
+    OBJECT_CHECK(ParallelChardev, (obj), TYPE_CHARDEV_PARALLEL)
+
 static int pp_ioctl(Chardev *chr, int cmd, void *arg)
 {
-    ParallelChardev *drv = (ParallelChardev *)chr;
+    ParallelChardev *drv = PARALLEL_CHARDEV(chr);
     uint8_t b;
 
     switch (cmd) {
@@ -2087,23 +2107,14 @@ static int pp_ioctl(Chardev *chr, int cmd, void *arg)
     return 0;
 }
 
-static Chardev *qemu_chr_open_pp_fd(const CharDriver *driver,
-                                    int fd,
-                                    ChardevCommon *backend,
-                                    bool *be_opened,
-                                    Error **errp)
+static void qemu_chr_open_pp_fd(Chardev *chr,
+                                int fd,
+                                bool *be_opened,
+                                Error **errp)
 {
-    Chardev *chr;
-    ParallelChardev *drv;
-
-    chr = qemu_chr_alloc(driver, backend, errp);
-    if (!chr) {
-        return NULL;
-    }
-    drv = (ParallelChardev *)chr;
+    ParallelChardev *drv = PARALLEL_CHARDEV(chr);
     drv->fd = fd;
     *be_opened = false;
-    return chr;
 }
 #endif
 
@@ -2123,6 +2134,9 @@ typedef struct {
     OVERLAPPED osend;
 } WinChardev;
 
+#define TYPE_CHARDEV_WIN "chardev-win"
+#define WIN_CHARDEV(obj) OBJECT_CHECK(WinChardev, (obj), TYPE_CHARDEV_WIN)
+
 typedef struct {
     Chardev parent;
     HANDLE  hStdIn;
@@ -2132,6 +2146,10 @@ typedef struct {
     uint8_t win_stdio_buf;
 } WinStdioChardev;
 
+#define TYPE_CHARDEV_WIN_STDIO "chardev-win-stdio"
+#define WIN_STDIO_CHARDEV(obj)                                  \
+    OBJECT_CHECK(WinStdioChardev, (obj), TYPE_CHARDEV_WIN_STDIO)
+
 #define NSENDBUF 2048
 #define NRECVBUF 2048
 #define MAXCONNECT 1
@@ -2142,7 +2160,7 @@ static int win_chr_pipe_poll(void *opaque);
 
 static void win_chr_free(Chardev *chr)
 {
-    WinChardev *s = (WinChardev *)chr;
+    WinChardev *s = WIN_CHARDEV(chr);
 
     if (s->hsend) {
         CloseHandle(s->hsend);
@@ -2166,7 +2184,7 @@ static void win_chr_free(Chardev *chr)
 
 static int win_chr_init(Chardev *chr, const char *filename, Error **errp)
 {
-    WinChardev *s = (WinChardev *)chr;
+    WinChardev *s = WIN_CHARDEV(chr);
     COMMCONFIG comcfg;
     COMMTIMEOUTS cto = { 0, 0, 0, 0, 0};
     COMSTAT comstat;
@@ -2234,7 +2252,7 @@ static int win_chr_init(Chardev *chr, const char *filename, Error **errp)
 /* Called with chr_write_lock held.  */
 static int win_chr_write(Chardev *chr, const uint8_t *buf, int len1)
 {
-    WinChardev *s = (WinChardev *)chr;
+    WinChardev *s = WIN_CHARDEV(chr);
     DWORD len, ret, size, err;
 
     len = len1;
@@ -2268,7 +2286,7 @@ static int win_chr_write(Chardev *chr, const uint8_t *buf, int len1)
 
 static int win_chr_read_poll(Chardev *chr)
 {
-    WinChardev *s = (WinChardev *)chr;
+    WinChardev *s = WIN_CHARDEV(chr);
 
     s->max_size = qemu_chr_be_can_write(chr);
     return s->max_size;
@@ -2276,7 +2294,8 @@ static int win_chr_read_poll(Chardev *chr)
 
 static void win_chr_readfile(Chardev *chr)
 {
-    WinChardev *s = (WinChardev *)chr;
+    WinChardev *s = WIN_CHARDEV(chr);
+
     int ret, err;
     uint8_t buf[READ_BUF_LEN];
     DWORD size;
@@ -2298,7 +2317,7 @@ static void win_chr_readfile(Chardev *chr)
 
 static void win_chr_read(Chardev *chr)
 {
-    WinChardev *s = (WinChardev *)chr;
+    WinChardev *s = WIN_CHARDEV(chr);
 
     if (s->len > s->max_size)
         s->len = s->max_size;
@@ -2310,8 +2329,8 @@ static void win_chr_read(Chardev *chr)
 
 static int win_chr_poll(void *opaque)
 {
-    Chardev *chr = opaque;
-    WinChardev *s = opaque;
+    Chardev *chr = CHARDEV(opaque);
+    WinChardev *s = WIN_CHARDEV(opaque);
     COMSTAT status;
     DWORD comerr;
 
@@ -2327,8 +2346,8 @@ static int win_chr_poll(void *opaque)
 
 static int win_chr_pipe_poll(void *opaque)
 {
-    Chardev *chr = opaque;
-    WinChardev *s = opaque;
+    Chardev *chr = CHARDEV(opaque);
+    WinChardev *s = WIN_CHARDEV(opaque);
     DWORD size;
 
     PeekNamedPipe(s->hcom, NULL, 0, NULL, &size, NULL);
@@ -2344,7 +2363,7 @@ static int win_chr_pipe_poll(void *opaque)
 static int win_chr_pipe_init(Chardev *chr, const char *filename,
                              Error **errp)
 {
-    WinChardev *s = (WinChardev *)chr;
+    WinChardev *s = WIN_CHARDEV(chr);
     OVERLAPPED ov;
     int ret;
     DWORD size;
@@ -2406,65 +2425,66 @@ static int win_chr_pipe_init(Chardev *chr, const char *filename,
 }
 
 
-static Chardev *qemu_chr_open_pipe(const CharDriver *driver,
-                                   const char *id,
-                                   ChardevBackend *backend,
-                                   ChardevReturn *ret,
-                                   bool *be_opened,
-                                   Error **errp)
+static void qemu_chr_open_pipe(Chardev *chr,
+                               ChardevBackend *backend,
+                               bool *be_opened,
+                               Error **errp)
 {
     ChardevHostdev *opts = backend->u.pipe.data;
     const char *filename = opts->device;
-    Chardev *chr;
-    ChardevCommon *common = qapi_ChardevHostdev_base(opts);
-
-    chr = qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        return NULL;
-    }
 
     if (win_chr_pipe_init(chr, filename, errp) < 0) {
-        qemu_chr_free_common(chr);
-        return NULL;
+        return;
     }
-    return chr;
 }
 
-static Chardev *qemu_chr_open_win_file(const CharDriver *driver,
-                                       HANDLE fd_out,
-                                       ChardevCommon *backend,
-                                       Error **errp)
+static void qemu_chr_open_win_file(Chardev *chr, HANDLE fd_out)
 {
-    Chardev *chr;
-    WinChardev *s;
+    WinChardev *s = WIN_CHARDEV(chr);
 
-    chr = qemu_chr_alloc(driver, backend, errp);
-    if (!chr) {
-        return NULL;
-    }
-    s = (WinChardev *)chr;
     s->hcom = fd_out;
-    return chr;
 }
 
-static Chardev *qemu_chr_open_win_con(const CharDriver *driver,
-                                      const char *id,
-                                      ChardevBackend *backend,
-                                      ChardevReturn *ret,
-                                      bool *be_opened,
-                                      Error **errp)
+static void char_win_class_init(ObjectClass *oc, void *data)
 {
-    ChardevCommon *common = backend->u.console.data;
-    return qemu_chr_open_win_file(driver,
-                                  GetStdHandle(STD_OUTPUT_HANDLE),
-                                  common, errp);
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->chr_write = win_chr_write;
+    cc->chr_free = win_chr_free;
 }
 
-static const CharDriver console_driver = {
+static const TypeInfo char_win_type_info = {
+    .name = TYPE_CHARDEV_WIN,
+    .parent = TYPE_CHARDEV,
     .instance_size = sizeof(WinChardev),
+    .class_init = char_win_class_init,
+    .abstract = true,
+};
+
+static void qemu_chr_open_win_con(Chardev *chr,
+                                  ChardevBackend *backend,
+                                  bool *be_opened,
+                                  Error **errp)
+{
+    qemu_chr_open_win_file(chr, GetStdHandle(STD_OUTPUT_HANDLE));
+}
+
+static const CharDriver console_driver = {
     .kind = CHARDEV_BACKEND_KIND_CONSOLE,
-    .create = qemu_chr_open_win_con,
-    .chr_write = win_chr_write,
+};
+
+static void char_console_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->open = qemu_chr_open_win_con;
+    cc->chr_free = NULL;
+}
+
+static const TypeInfo char_console_type_info = {
+    .name = TYPE_CHARDEV_CONSOLE,
+    .parent = TYPE_CHARDEV_WIN,
+    .class_init = char_console_class_init,
 };
 
 static int win_stdio_write(Chardev *chr, const uint8_t *buf, int len)
@@ -2488,8 +2508,8 @@ static int win_stdio_write(Chardev *chr, const uint8_t *buf, int len)
 
 static void win_stdio_wait_func(void *opaque)
 {
-    Chardev   *chr   = opaque;
-    WinStdioChardev *stdio = opaque;
+    Chardev *chr = CHARDEV(opaque);
+    WinStdioChardev *stdio = WIN_STDIO_CHARDEV(opaque);
     INPUT_RECORD       buf[4];
     int                ret;
     DWORD              dwSize;
@@ -2522,7 +2542,7 @@ static void win_stdio_wait_func(void *opaque)
 
 static DWORD WINAPI win_stdio_thread(LPVOID param)
 {
-    WinStdioChardev *stdio = param;
+    WinStdioChardev *stdio = WIN_STDIO_CHARDEV(param);
     int                ret;
     DWORD              dwSize;
 
@@ -2560,8 +2580,8 @@ static DWORD WINAPI win_stdio_thread(LPVOID param)
 
 static void win_stdio_thread_wait_func(void *opaque)
 {
-    Chardev   *chr   = opaque;
-    WinStdioChardev *stdio = opaque;
+    Chardev *chr = CHARDEV(opaque);
+    WinStdioChardev *stdio = WIN_STDIO_CHARDEV(opaque);
 
     if (qemu_chr_be_can_write(chr)) {
         qemu_chr_be_write(chr, &stdio->win_stdio_buf, 1);
@@ -2572,7 +2592,7 @@ static void win_stdio_thread_wait_func(void *opaque)
 
 static void qemu_chr_set_echo_win_stdio(Chardev *chr, bool echo)
 {
-    WinStdioChardev *stdio  = (WinStdioChardev *)chr;
+    WinStdioChardev *stdio = WIN_STDIO_CHARDEV(chr);
     DWORD              dwMode = 0;
 
     GetConsoleMode(stdio->hStdIn, &dwMode);
@@ -2586,7 +2606,7 @@ static void qemu_chr_set_echo_win_stdio(Chardev *chr, bool echo)
 
 static void win_stdio_free(Chardev *chr)
 {
-    WinStdioChardev *stdio = (WinStdioChardev *)chr;
+    WinStdioChardev *stdio = WIN_STDIO_CHARDEV(chr);
 
     if (stdio->hInputReadyEvent != INVALID_HANDLE_VALUE) {
         CloseHandle(stdio->hInputReadyEvent);
@@ -2599,29 +2619,26 @@ static void win_stdio_free(Chardev *chr)
     }
 }
 
-static Chardev *qemu_chr_open_stdio(const CharDriver *driver,
-                                    const char *id,
-                                    ChardevBackend *backend,
-                                    ChardevReturn *ret,
-                                    bool *be_opened,
-                                    Error **errp)
+static const TypeInfo char_win_stdio_type_info = {
+    .name = TYPE_CHARDEV_WIN_STDIO,
+    .parent = TYPE_CHARDEV,
+    .instance_size = sizeof(WinStdioChardev),
+    .abstract = true,
+};
+
+static void qemu_chr_open_stdio(Chardev *chr,
+                                ChardevBackend *backend,
+                                bool *be_opened,
+                                Error **errp)
 {
-    Chardev   *chr;
-    WinStdioChardev *stdio;
+    WinStdioChardev *stdio = WIN_STDIO_CHARDEV(chr);
     DWORD              dwMode;
     int                is_console = 0;
-    ChardevCommon *common = qapi_ChardevStdio_base(backend->u.stdio.data);
-
-    chr = qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        return NULL;
-    }
-    stdio = (WinStdioChardev *)chr;
 
     stdio->hStdIn = GetStdHandle(STD_INPUT_HANDLE);
     if (stdio->hStdIn == INVALID_HANDLE_VALUE) {
         error_setg(errp, "cannot open stdio: invalid handle");
-        return NULL;
+        return;
     }
 
     is_console = GetConsoleMode(stdio->hStdIn, &dwMode) != 0;
@@ -2668,7 +2685,7 @@ static Chardev *qemu_chr_open_stdio(const CharDriver *driver,
 
     qemu_chr_set_echo_win_stdio(chr, false);
 
-    return chr;
+    return;
 
 err3:
     qemu_del_wait_object(stdio->hInputReadyEvent, NULL, NULL);
@@ -2677,7 +2694,6 @@ err2:
     CloseHandle(stdio->hInputDoneEvent);
 err1:
     qemu_del_wait_object(stdio->hStdIn, NULL, NULL);
-    return NULL;
 }
 #endif /* !_WIN32 */
 
@@ -2693,10 +2709,12 @@ typedef struct {
     int max_size;
 } UdpChardev;
 
+#define UDP_CHARDEV(obj) OBJECT_CHECK(UdpChardev, (obj), TYPE_CHARDEV_UDP)
+
 /* Called with chr_write_lock held.  */
 static int udp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    UdpChardev *s = (UdpChardev *)chr;
+    UdpChardev *s = UDP_CHARDEV(chr);
 
     return qio_channel_write(
         s->ioc, (const char *)buf, len, NULL);
@@ -2704,8 +2722,8 @@ static int udp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 
 static int udp_chr_read_poll(void *opaque)
 {
-    Chardev *chr = opaque;
-    UdpChardev *s = opaque;
+    Chardev *chr = CHARDEV(opaque);
+    UdpChardev *s = UDP_CHARDEV(opaque);
 
     s->max_size = qemu_chr_be_can_write(chr);
 
@@ -2722,8 +2740,8 @@ static int udp_chr_read_poll(void *opaque)
 
 static gboolean udp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
-    Chardev *chr = opaque;
-    UdpChardev *s = opaque;
+    Chardev *chr = CHARDEV(opaque);
+    UdpChardev *s = UDP_CHARDEV(opaque);
     ssize_t ret;
 
     if (s->max_size == 0) {
@@ -2750,7 +2768,7 @@ static gboolean udp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 static void udp_chr_update_read_handler(Chardev *chr,
                                         GMainContext *context)
 {
-    UdpChardev *s = (UdpChardev *)chr;
+    UdpChardev *s = UDP_CHARDEV(chr);
 
     remove_fd_in_watch(chr);
     if (s->ioc) {
@@ -2763,7 +2781,7 @@ static void udp_chr_update_read_handler(Chardev *chr,
 
 static void udp_chr_free(Chardev *chr)
 {
-    UdpChardev *s = (UdpChardev *)chr;
+    UdpChardev *s = UDP_CHARDEV(chr);
 
     remove_fd_in_watch(chr);
     if (s->ioc) {
@@ -2801,11 +2819,14 @@ typedef struct {
     bool connect_err_reported;
 } SocketChardev;
 
+#define SOCKET_CHARDEV(obj)                                     \
+    OBJECT_CHECK(SocketChardev, (obj), TYPE_CHARDEV_SOCKET)
+
 static gboolean socket_reconnect_timeout(gpointer opaque);
 
 static void qemu_chr_socket_restart_timer(Chardev *chr)
 {
-    SocketChardev *s = (SocketChardev *)chr;
+    SocketChardev *s = SOCKET_CHARDEV(chr);
     char *name;
 
     assert(s->connected == 0);
@@ -2819,7 +2840,7 @@ static void qemu_chr_socket_restart_timer(Chardev *chr)
 static void check_report_connect_error(Chardev *chr,
                                        Error *err)
 {
-    SocketChardev *s = (SocketChardev *)chr;
+    SocketChardev *s = SOCKET_CHARDEV(chr);
 
     if (!s->connect_err_reported) {
         error_report("Unable to connect character device %s: %s",
@@ -2836,7 +2857,7 @@ static gboolean tcp_chr_accept(QIOChannel *chan,
 /* Called with chr_write_lock held.  */
 static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    SocketChardev *s = (SocketChardev *)chr;
+    SocketChardev *s = SOCKET_CHARDEV(chr);
 
     if (s->connected) {
         int ret =  io_channel_send_full(s->ioc, buf, len,
@@ -2859,8 +2880,8 @@ static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 
 static int tcp_chr_read_poll(void *opaque)
 {
-    Chardev *chr = opaque;
-    SocketChardev *s = opaque;
+    Chardev *chr = CHARDEV(opaque);
+    SocketChardev *s = SOCKET_CHARDEV(opaque);
     if (!s->connected)
         return 0;
     s->max_size = qemu_chr_be_can_write(chr);
@@ -2919,7 +2940,7 @@ static void tcp_chr_process_IAC_bytes(Chardev *chr,
 
 static int tcp_get_msgfds(Chardev *chr, int *fds, int num)
 {
-    SocketChardev *s = (SocketChardev *)chr;
+    SocketChardev *s = SOCKET_CHARDEV(chr);
 
     int to_copy = (s->read_msgfds_num < num) ? s->read_msgfds_num : num;
 
@@ -2945,7 +2966,7 @@ static int tcp_get_msgfds(Chardev *chr, int *fds, int num)
 
 static int tcp_set_msgfds(Chardev *chr, int *fds, int num)
 {
-    SocketChardev *s = (SocketChardev *)chr;
+    SocketChardev *s = SOCKET_CHARDEV(chr);
 
     /* clear old pending fd array */
     g_free(s->write_msgfds);
@@ -2970,7 +2991,7 @@ static int tcp_set_msgfds(Chardev *chr, int *fds, int num)
 
 static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
 {
-    SocketChardev *s = (SocketChardev *)chr;
+    SocketChardev *s = SOCKET_CHARDEV(chr);
     struct iovec iov = { .iov_base = buf, .iov_len = len };
     int ret;
     size_t i;
@@ -3027,13 +3048,13 @@ static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
 
 static GSource *tcp_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    SocketChardev *s = (SocketChardev *)chr;
+    SocketChardev *s = SOCKET_CHARDEV(chr);
     return qio_channel_create_watch(s->ioc, cond);
 }
 
 static void tcp_chr_free_connection(Chardev *chr)
 {
-    SocketChardev *s = (SocketChardev *)chr;
+    SocketChardev *s = SOCKET_CHARDEV(chr);
     int i;
 
     if (!s->connected) {
@@ -3062,7 +3083,7 @@ static void tcp_chr_free_connection(Chardev *chr)
 
 static void tcp_chr_disconnect(Chardev *chr)
 {
-    SocketChardev *s = (SocketChardev *)chr;
+    SocketChardev *s = SOCKET_CHARDEV(chr);
 
     if (!s->connected) {
         return;
@@ -3084,8 +3105,8 @@ static void tcp_chr_disconnect(Chardev *chr)
 
 static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
-    Chardev *chr = opaque;
-    SocketChardev *s = opaque;
+    Chardev *chr = CHARDEV(opaque);
+    SocketChardev *s = SOCKET_CHARDEV(opaque);
     uint8_t buf[READ_BUF_LEN];
     int len, size;
 
@@ -3111,7 +3132,7 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 
 static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
 {
-    SocketChardev *s = (SocketChardev *)chr;
+    SocketChardev *s = SOCKET_CHARDEV(chr);
     int size;
 
     if (!s->connected) {
@@ -3129,8 +3150,8 @@ static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
 
 static void tcp_chr_connect(void *opaque)
 {
-    Chardev *chr = opaque;
-    SocketChardev *s = opaque;
+    Chardev *chr = CHARDEV(opaque);
+    SocketChardev *s = SOCKET_CHARDEV(opaque);
 
     g_free(chr->filename);
     chr->filename = sockaddr_to_str(
@@ -3151,7 +3172,7 @@ static void tcp_chr_connect(void *opaque)
 static void tcp_chr_update_read_handler(Chardev *chr,
                                         GMainContext *context)
 {
-    SocketChardev *s = (SocketChardev *)chr;
+    SocketChardev *s = SOCKET_CHARDEV(chr);
 
     if (!s->connected) {
         return;
@@ -3202,7 +3223,7 @@ static gboolean tcp_chr_telnet_init_io(QIOChannel *ioc,
 
 static void tcp_chr_telnet_init(Chardev *chr)
 {
-    SocketChardev *s = (SocketChardev *)chr;
+    SocketChardev *s = SOCKET_CHARDEV(chr);
     TCPCharDriverTelnetInit *init =
         g_new0(TCPCharDriverTelnetInit, 1);
     size_t n = 0;
@@ -3253,7 +3274,7 @@ static void tcp_chr_tls_handshake(QIOTask *task,
 
 static void tcp_chr_tls_init(Chardev *chr)
 {
-    SocketChardev *s = (SocketChardev *)chr;
+    SocketChardev *s = SOCKET_CHARDEV(chr);
     QIOChannelTLS *tioc;
     Error *err = NULL;
     gchar *name;
@@ -3292,7 +3313,7 @@ static void tcp_chr_tls_init(Chardev *chr)
 static void tcp_chr_set_client_ioc_name(Chardev *chr,
                                         QIOChannelSocket *sioc)
 {
-    SocketChardev *s = (SocketChardev *)chr;
+    SocketChardev *s = SOCKET_CHARDEV(chr);
     char *name;
     name = g_strdup_printf("chardev-tcp-%s-%s",
                            s->is_listen ? "server" : "client",
@@ -3304,7 +3325,7 @@ static void tcp_chr_set_client_ioc_name(Chardev *chr,
 
 static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
 {
-    SocketChardev *s = (SocketChardev *)chr;
+    SocketChardev *s = SOCKET_CHARDEV(chr);
 
     if (s->ioc != NULL) {
 	return -1;
@@ -3358,7 +3379,7 @@ static gboolean tcp_chr_accept(QIOChannel *channel,
                                GIOCondition cond,
                                void *opaque)
 {
-    Chardev *chr = opaque;
+    Chardev *chr = CHARDEV(opaque);
     QIOChannelSocket *sioc;
 
     sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(channel),
@@ -3376,7 +3397,7 @@ static gboolean tcp_chr_accept(QIOChannel *channel,
 
 static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
 {
-    SocketChardev *s = (SocketChardev *)chr;
+    SocketChardev *s = SOCKET_CHARDEV(chr);
     QIOChannelSocket *sioc;
 
     /* It can't wait on s->connected, since it is set asynchronously
@@ -3405,8 +3426,10 @@ static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
 
 static int qemu_chr_wait_connected(Chardev *chr, Error **errp)
 {
-    if (chr->driver->chr_wait_connected) {
-        return chr->driver->chr_wait_connected(chr, errp);
+    ChardevClass *cc = CHARDEV_GET_CLASS(chr);
+
+    if (cc->chr_wait_connected) {
+        return cc->chr_wait_connected(chr, errp);
     }
 
     return 0;
@@ -3424,7 +3447,7 @@ int qemu_chr_fe_wait_connected(CharBackend *be, Error **errp)
 
 static void tcp_chr_free(Chardev *chr)
 {
-    SocketChardev *s = (SocketChardev *)chr;
+    SocketChardev *s = SOCKET_CHARDEV(chr);
 
     tcp_chr_free_connection(chr);
 
@@ -3451,8 +3474,8 @@ static void tcp_chr_free(Chardev *chr)
 static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
 {
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(qio_task_get_source(task));
-    Chardev *chr = opaque;
-    SocketChardev *s = (SocketChardev *)chr;
+    Chardev *chr = CHARDEV(opaque);
+    SocketChardev *s = SOCKET_CHARDEV(chr);
     Error *err = NULL;
 
     if (qio_task_propagate_error(task, &err)) {
@@ -3480,9 +3503,12 @@ typedef struct {
     uint8_t *cbuf;
 } RingBufChardev;
 
+#define RINGBUF_CHARDEV(obj)                                    \
+    OBJECT_CHECK(RingBufChardev, (obj), TYPE_CHARDEV_RINGBUF)
+
 static size_t ringbuf_count(const Chardev *chr)
 {
-    const RingBufChardev *d = (RingBufChardev *)chr;
+    const RingBufChardev *d = RINGBUF_CHARDEV(chr);
 
     return d->prod - d->cons;
 }
@@ -3490,7 +3516,7 @@ static size_t ringbuf_count(const Chardev *chr)
 /* Called with chr_write_lock held.  */
 static int ringbuf_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    RingBufChardev *d = (RingBufChardev *)chr;
+    RingBufChardev *d = RINGBUF_CHARDEV(chr);
     int i;
 
     if (!buf || (len < 0)) {
@@ -3509,7 +3535,7 @@ static int ringbuf_chr_write(Chardev *chr, const uint8_t *buf, int len)
 
 static int ringbuf_chr_read(Chardev *chr, uint8_t *buf, int len)
 {
-    RingBufChardev *d = (RingBufChardev *)chr;
+    RingBufChardev *d = RINGBUF_CHARDEV(chr);
     int i;
 
     qemu_mutex_lock(&chr->chr_write_lock);
@@ -3523,51 +3549,30 @@ static int ringbuf_chr_read(Chardev *chr, uint8_t *buf, int len)
 
 static void ringbuf_chr_free(struct Chardev *chr)
 {
-    RingBufChardev *d = (RingBufChardev *)chr;
+    RingBufChardev *d = RINGBUF_CHARDEV(chr);
 
     g_free(d->cbuf);
 }
 
-static Chardev *qemu_chr_open_ringbuf(const CharDriver *driver,
-                                      const char *id,
-                                      ChardevBackend *backend,
-                                      ChardevReturn *ret,
-                                      bool *be_opened,
-                                      Error **errp)
+static void qemu_chr_open_ringbuf(Chardev *chr,
+                                  ChardevBackend *backend,
+                                  bool *be_opened,
+                                  Error **errp)
 {
     ChardevRingbuf *opts = backend->u.ringbuf.data;
-    ChardevCommon *common = qapi_ChardevRingbuf_base(opts);
-    Chardev *chr;
-    RingBufChardev *d;
-
-    chr = qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        return NULL;
-    }
-    d = (RingBufChardev *)chr;
+    RingBufChardev *d = RINGBUF_CHARDEV(chr);
 
     d->size = opts->has_size ? opts->size : 65536;
 
     /* The size must be power of 2 */
     if (d->size & (d->size - 1)) {
         error_setg(errp, "size of ringbuf chardev must be power of two");
-        goto fail;
+        return;
     }
 
     d->prod = 0;
     d->cons = 0;
     d->cbuf = g_malloc0(d->size);
-
-    return chr;
-
-fail:
-    qemu_chr_free_common(chr);
-    return NULL;
-}
-
-ChardevBackendKind qemu_chr_get_kind(const Chardev *chr)
-{
-    return chr->driver->kind;
 }
 
 void qmp_ringbuf_write(const char *device, const char *data,
@@ -3585,7 +3590,7 @@ void qmp_ringbuf_write(const char *device, const char *data,
         return;
     }
 
-    if (!qemu_chr_is_ringbuf(chr)) {
+    if (!CHARDEV_IS_RINGBUF(chr)) {
         error_setg(errp,"%s is not a ringbuf device", device);
         return;
     }
@@ -3629,7 +3634,7 @@ char *qmp_ringbuf_read(const char *device, int64_t size,
         return NULL;
     }
 
-    if (!qemu_chr_is_ringbuf(chr)) {
+    if (!CHARDEV_IS_RINGBUF(chr)) {
         error_setg(errp,"%s is not a ringbuf device", device);
         return NULL;
     }
@@ -3849,20 +3854,31 @@ static void qemu_chr_parse_stdio(QemuOpts *opts, ChardevBackend *backend,
 static const CharDriver stdio_driver = {
     .kind = CHARDEV_BACKEND_KIND_STDIO,
     .parse = qemu_chr_parse_stdio,
-    .create = qemu_chr_open_stdio,
+};
+
+static void char_stdio_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->open = qemu_chr_open_stdio;
 #ifdef _WIN32
-    sizeof(WinStdioChardev),
-    .chr_write = win_stdio_write,
-    .chr_set_echo = qemu_chr_set_echo_win_stdio,
-    .chr_free = win_stdio_free,
+    cc->chr_write = win_stdio_write;
+    cc->chr_set_echo = qemu_chr_set_echo_win_stdio;
+    cc->chr_free = win_stdio_free;
 #else
-    sizeof(FDChardev),
-    .chr_add_watch = fd_chr_add_watch,
-    .chr_write = fd_chr_write,
-    .chr_update_read_handler = fd_chr_update_read_handler,
-    .chr_set_echo = qemu_chr_set_echo_stdio,
-    .chr_free = qemu_chr_free_stdio,
+    cc->chr_set_echo = qemu_chr_set_echo_stdio;
+    cc->chr_free = qemu_chr_free_stdio;
 #endif
+}
+
+static const TypeInfo char_stdio_type_info = {
+    .name = TYPE_CHARDEV_STDIO,
+#ifdef _WIN32
+    .parent = TYPE_CHARDEV_WIN_STDIO,
+#else
+    .parent = TYPE_CHARDEV_FD,
+#endif
+    .class_init = char_stdio_class_init,
 };
 
 #ifdef HAVE_CHARDEV_SERIAL
@@ -3917,18 +3933,23 @@ static void qemu_chr_parse_pipe(QemuOpts *opts, ChardevBackend *backend,
 static const CharDriver pipe_driver = {
     .kind = CHARDEV_BACKEND_KIND_PIPE,
     .parse = qemu_chr_parse_pipe,
-    .create = qemu_chr_open_pipe,
+};
+
+static void char_pipe_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->open = qemu_chr_open_pipe;
+}
+
+static const TypeInfo char_pipe_type_info = {
+    .name = TYPE_CHARDEV_PIPE,
 #ifdef _WIN32
-    sizeof(WinChardev),
-    .chr_write = win_chr_write,
-    .chr_free = win_chr_free,
+    .parent = TYPE_CHARDEV_WIN,
 #else
-    sizeof(FDChardev),
-    .chr_add_watch = fd_chr_add_watch,
-    .chr_write = fd_chr_write,
-    .chr_update_read_handler = fd_chr_update_read_handler,
-    .chr_free = fd_chr_free,
+    .parent = TYPE_CHARDEV_FD,
 #endif
+    .class_init = char_pipe_class_init,
 };
 
 static void qemu_chr_parse_ringbuf(QemuOpts *opts, ChardevBackend *backend,
@@ -3948,22 +3969,35 @@ static void qemu_chr_parse_ringbuf(QemuOpts *opts, ChardevBackend *backend,
 }
 
 static const CharDriver ringbuf_driver = {
-    .instance_size = sizeof(RingBufChardev),
     .kind = CHARDEV_BACKEND_KIND_RINGBUF,
     .parse = qemu_chr_parse_ringbuf,
-    .create = qemu_chr_open_ringbuf,
-    .chr_write = ringbuf_chr_write,
-    .chr_free = ringbuf_chr_free,
+};
+
+static void char_ringbuf_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->open = qemu_chr_open_ringbuf;
+    cc->chr_write = ringbuf_chr_write;
+    cc->chr_free = ringbuf_chr_free;
+}
+
+static const TypeInfo char_ringbuf_type_info = {
+    .name = TYPE_CHARDEV_RINGBUF,
+    .parent = TYPE_CHARDEV,
+    .class_init = char_ringbuf_class_init,
+    .instance_size = sizeof(RingBufChardev),
 };
 
 /* Bug-compatibility: */
 static const CharDriver memory_driver = {
-    .instance_size = sizeof(RingBufChardev),
     .kind = CHARDEV_BACKEND_KIND_MEMORY,
     .parse = qemu_chr_parse_ringbuf,
-    .create = qemu_chr_open_ringbuf,
-    .chr_write = ringbuf_chr_write,
-    .chr_free = ringbuf_chr_free,
+};
+
+static const TypeInfo char_memory_type_info = {
+    .name = TYPE_CHARDEV_MEMORY,
+    .parent = TYPE_CHARDEV_RINGBUF,
 };
 
 static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
@@ -3982,14 +4016,26 @@ static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
 }
 
 static const CharDriver mux_driver = {
-    .instance_size = sizeof(MuxChardev),
     .kind = CHARDEV_BACKEND_KIND_MUX,
     .parse = qemu_chr_parse_mux,
-    .create = qemu_chr_open_mux,
-    .chr_free = mux_chr_free,
-    .chr_write = mux_chr_write,
-    .chr_accept_input = mux_chr_accept_input,
-    .chr_add_watch = mux_chr_add_watch,
+};
+
+static void char_mux_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->open = qemu_chr_open_mux;
+    cc->chr_free = mux_chr_free;
+    cc->chr_write = mux_chr_write;
+    cc->chr_accept_input = mux_chr_accept_input;
+    cc->chr_add_watch = mux_chr_add_watch;
+}
+
+static const TypeInfo char_mux_type_info = {
+    .name = TYPE_CHARDEV_MUX,
+    .parent = TYPE_CHARDEV,
+    .class_init = char_mux_class_init,
+    .instance_size = sizeof(MuxChardev),
 };
 
 static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
@@ -4269,7 +4315,7 @@ Chardev *qemu_chr_new(const char *label, const char *filename)
         if (replay_mode != REPLAY_MODE_NONE) {
             qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
         }
-        if (qemu_chr_replay(chr) && chr->driver->chr_ioctl) {
+        if (qemu_chr_replay(chr) && CHARDEV_GET_CLASS(chr)->chr_ioctl) {
             error_report("Replay: ioctl is not supported "
                          "for serial devices yet");
         }
@@ -4282,8 +4328,8 @@ void qemu_chr_fe_set_echo(CharBackend *be, bool echo)
 {
     Chardev *chr = be->chr;
 
-    if (chr && chr->driver->chr_set_echo) {
-        chr->driver->chr_set_echo(chr, echo);
+    if (chr && CHARDEV_GET_CLASS(chr)->chr_set_echo) {
+        CHARDEV_GET_CLASS(chr)->chr_set_echo(chr, echo);
     }
 }
 
@@ -4299,8 +4345,8 @@ void qemu_chr_fe_set_open(CharBackend *be, int fe_open)
         return;
     }
     be->fe_open = fe_open;
-    if (chr->driver->chr_set_fe_open) {
-        chr->driver->chr_set_fe_open(chr, fe_open);
+    if (CHARDEV_GET_CLASS(chr)->chr_set_fe_open) {
+        CHARDEV_GET_CLASS(chr)->chr_set_fe_open(chr, fe_open);
     }
 }
 
@@ -4311,11 +4357,11 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
     GSource *src;
     guint tag;
 
-    if (!s || s->driver->chr_add_watch == NULL) {
+    if (!s || CHARDEV_GET_CLASS(s)->chr_add_watch == NULL) {
         return 0;
     }
 
-    src = s->driver->chr_add_watch(s, cond);
+    src = CHARDEV_GET_CLASS(s)->chr_add_watch(s, cond);
     if (!src) {
         return 0;
     }
@@ -4331,31 +4377,17 @@ void qemu_chr_fe_disconnect(CharBackend *be)
 {
     Chardev *chr = be->chr;
 
-    if (chr && chr->driver->chr_disconnect) {
-        chr->driver->chr_disconnect(chr);
+    if (chr && CHARDEV_GET_CLASS(chr)->chr_disconnect) {
+        CHARDEV_GET_CLASS(chr)->chr_disconnect(chr);
     }
 }
 
-static void qemu_chr_free_common(Chardev *chr)
-{
-    if (chr->be) {
-        chr->be->chr = NULL;
-    }
-    g_free(chr->filename);
-    g_free(chr->label);
-    if (chr->logfd != -1) {
-        close(chr->logfd);
-    }
-    qemu_mutex_destroy(&chr->chr_write_lock);
-    g_free(chr);
-}
-
 void qemu_chr_free(Chardev *chr)
 {
-    if (chr->driver->chr_free) {
-        chr->driver->chr_free(chr);
+    if (CHARDEV_GET_CLASS(chr)->chr_free) {
+        CHARDEV_GET_CLASS(chr)->chr_free(chr);
     }
-    qemu_chr_free_common(chr);
+    object_unref(OBJECT(chr));
 }
 
 void qemu_chr_delete(Chardev *chr)
@@ -4523,22 +4555,19 @@ QemuOptsList qemu_chardev_opts = {
 
 #ifdef _WIN32
 
-static Chardev *qmp_chardev_open_file(const CharDriver *driver,
-                                      const char *id,
-                                      ChardevBackend *backend,
-                                      ChardevReturn *ret,
-                                      bool *be_opened,
-                                      Error **errp)
+static void qmp_chardev_open_file(Chardev *chr,
+                                  ChardevBackend *backend,
+                                  bool *be_opened,
+                                  Error **errp)
 {
     ChardevFile *file = backend->u.file.data;
-    ChardevCommon *common = qapi_ChardevFile_base(file);
     HANDLE out;
     DWORD accessmode;
     DWORD flags;
 
     if (file->has_in) {
         error_setg(errp, "input file not supported");
-        return NULL;
+        return;
     }
 
     if (file->has_append && file->append) {
@@ -4555,33 +4584,20 @@ static Chardev *qmp_chardev_open_file(const CharDriver *driver,
                      FILE_ATTRIBUTE_NORMAL, NULL);
     if (out == INVALID_HANDLE_VALUE) {
         error_setg(errp, "open %s failed", file->out);
-        return NULL;
+        return;
     }
-    return qemu_chr_open_win_file(driver, out, common, errp);
+
+    qemu_chr_open_win_file(chr, out);
 }
 
-static Chardev *qmp_chardev_open_serial(const CharDriver *driver,
-                                        const char *id,
-                                        ChardevBackend *backend,
-                                        ChardevReturn *ret,
-                                        bool *be_opened,
-                                        Error **errp)
+static void qmp_chardev_open_serial(Chardev *chr,
+                                    ChardevBackend *backend,
+                                    bool *be_opened,
+                                    Error **errp)
 {
     ChardevHostdev *serial = backend->u.serial.data;
-    ChardevCommon *common = qapi_ChardevHostdev_base(serial);
-    Chardev *chr;
 
-    chr = qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        return NULL;
-    }
-
-    if (win_chr_init(chr, serial->device, errp) < 0) {
-        qemu_chr_free_common(chr);
-        return NULL;
-    }
-
-    return chr;
+    win_chr_init(chr, serial->device, errp);
 }
 
 #else /* WIN32 */
@@ -4598,15 +4614,12 @@ static int qmp_chardev_open_file_source(char *src, int flags,
     return fd;
 }
 
-static Chardev *qmp_chardev_open_file(const CharDriver *driver,
-                                      const char *id,
-                                      ChardevBackend *backend,
-                                      ChardevReturn *ret,
-                                      bool *be_opened,
-                                      Error **errp)
+static void qmp_chardev_open_file(Chardev *chr,
+                                  ChardevBackend *backend,
+                                  bool *be_opened,
+                                  Error **errp)
 {
     ChardevFile *file = backend->u.file.data;
-    ChardevCommon *common = qapi_ChardevFile_base(file);
     int flags, in = -1, out;
 
     flags = O_WRONLY | O_CREAT | O_BINARY;
@@ -4618,7 +4631,7 @@ static Chardev *qmp_chardev_open_file(const CharDriver *driver,
 
     out = qmp_chardev_open_file_source(file->out, flags, errp);
     if (out < 0) {
-        return NULL;
+        return;
     }
 
     if (file->has_in) {
@@ -4626,70 +4639,76 @@ static Chardev *qmp_chardev_open_file(const CharDriver *driver,
         in = qmp_chardev_open_file_source(file->in, flags, errp);
         if (in < 0) {
             qemu_close(out);
-            return NULL;
+            return;
         }
     }
 
-    return qemu_chr_open_fd(driver, in, out, common, errp);
+    qemu_chr_open_fd(chr, in, out);
 }
 
 #ifdef HAVE_CHARDEV_SERIAL
-static Chardev *qmp_chardev_open_serial(const CharDriver *driver,
-                                        const char *id,
-                                        ChardevBackend *backend,
-                                        ChardevReturn *ret,
-                                        bool *be_opened,
-                                        Error **errp)
+static void qmp_chardev_open_serial(Chardev *chr,
+                                    ChardevBackend *backend,
+                                    bool *be_opened,
+                                    Error **errp)
 {
     ChardevHostdev *serial = backend->u.serial.data;
-    ChardevCommon *common = qapi_ChardevHostdev_base(serial);
     int fd;
 
     fd = qmp_chardev_open_file_source(serial->device, O_RDWR, errp);
     if (fd < 0) {
-        return NULL;
+        return;
     }
     qemu_set_nonblock(fd);
     tty_serial_init(fd, 115200, 'N', 8, 1);
 
-    return qemu_chr_open_fd(driver, fd, fd, common, errp);
+    qemu_chr_open_fd(chr, fd, fd);
 }
 #endif
 
 #ifdef HAVE_CHARDEV_PARPORT
-static Chardev *qmp_chardev_open_parallel(const CharDriver *driver,
-                                          const char *id,
-                                          ChardevBackend *backend,
-                                          ChardevReturn *ret,
-                                          bool *be_opened,
-                                          Error **errp)
+static void qmp_chardev_open_parallel(Chardev *chr,
+                                      ChardevBackend *backend,
+                                      bool *be_opened,
+                                      Error **errp)
 {
     ChardevHostdev *parallel = backend->u.parallel.data;
-    ChardevCommon *common = qapi_ChardevHostdev_base(parallel);
     int fd;
 
     fd = qmp_chardev_open_file_source(parallel->device, O_RDWR, errp);
     if (fd < 0) {
-        return NULL;
+        return;
     }
-    return qemu_chr_open_pp_fd(driver, fd, common, be_opened, errp);
+    qemu_chr_open_pp_fd(chr, fd, be_opened, errp);
 }
 
 static const CharDriver parallel_driver = {
-    .instance_size = sizeof(ParallelChardev),
     .kind = CHARDEV_BACKEND_KIND_PARALLEL,
     .alias = "parport",
     .parse = qemu_chr_parse_parallel,
-    .create = qmp_chardev_open_parallel,
+};
+
+static void char_parallel_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->open = qmp_chardev_open_parallel;
 #if defined(__linux__)
-    .chr_write = null_chr_write,
-    .chr_ioctl = pp_ioctl,
-    .chr_free = pp_free,
+    cc->chr_write = null_chr_write;
+    cc->chr_ioctl = pp_ioctl;
+    cc->chr_free = pp_free;
 #elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__) || defined(__DragonFly__)
-    .chr_write = null_chr_write,
-    .chr_ioctl = pp_ioctl,
     /* FIXME: no chr_free */
+    cc->chr_write = null_chr_write;
+    cc->chr_ioctl = pp_ioctl;
 #endif
+}
+
+static const TypeInfo char_parallel_type_info = {
+    .name = TYPE_CHARDEV_PARALLEL,
+    .parent = TYPE_CHARDEV,
+    .instance_size = sizeof(ParallelChardev),
+    .class_init = char_parallel_class_init,
 };
 #endif
 
@@ -4698,45 +4717,63 @@ static const CharDriver parallel_driver = {
 static const CharDriver file_driver = {
     .kind = CHARDEV_BACKEND_KIND_FILE,
     .parse = qemu_chr_parse_file_out,
-    .create = qmp_chardev_open_file,
+};
+
+static void char_file_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->open = qmp_chardev_open_file;
 #ifdef _WIN32
-    sizeof(WinChardev),
-    .chr_write = win_chr_write,
     /* FIXME: no chr_free */
+    cc->chr_free = NULL;
+#endif
+}
+
+static const TypeInfo char_file_type_info = {
+    .name = TYPE_CHARDEV_FILE,
+#ifdef _WIN32
+    .parent = TYPE_CHARDEV_WIN,
 #else
-    sizeof(FDChardev),
-    .chr_add_watch = fd_chr_add_watch,
-    .chr_write = fd_chr_write,
-    .chr_update_read_handler = fd_chr_update_read_handler,
-    .chr_free = fd_chr_free,
+    .parent = TYPE_CHARDEV_FD,
 #endif
+    .class_init = char_file_class_init,
 };
 
 #ifdef HAVE_CHARDEV_SERIAL
+
 static const CharDriver serial_driver = {
     .kind = CHARDEV_BACKEND_KIND_SERIAL,
     .alias = "tty",
     .parse = qemu_chr_parse_serial,
-    .create = qmp_chardev_open_serial,
+};
+
+static void char_serial_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->open = qmp_chardev_open_serial;
+#ifndef _WIN32
+    cc->chr_ioctl = tty_serial_ioctl;
+    cc->chr_free = qemu_chr_free_tty;
+#endif
+}
+
+static const TypeInfo char_serial_type_info = {
+    .name = TYPE_CHARDEV_SERIAL,
 #ifdef _WIN32
-    sizeof(WinChardev),
-    .chr_write = win_chr_write,
-    .chr_free = win_chr_free,
+    .parent = TYPE_CHARDEV_WIN,
 #else
-    sizeof(FDChardev),
-    .chr_add_watch = fd_chr_add_watch,
-    .chr_write = fd_chr_write,
-    .chr_update_read_handler = fd_chr_update_read_handler,
-    .chr_ioctl = tty_serial_ioctl,
-    .chr_free = qemu_chr_free_tty,
+    .parent = TYPE_CHARDEV_FD,
 #endif
+    .class_init = char_serial_class_init,
 };
 #endif
 
 static gboolean socket_reconnect_timeout(gpointer opaque)
 {
-    Chardev *chr = opaque;
-    SocketChardev *s = opaque;
+    Chardev *chr = CHARDEV(opaque);
+    SocketChardev *s = SOCKET_CHARDEV(opaque);
     QIOChannelSocket *sioc;
 
     s->reconnect_timer = 0;
@@ -4754,15 +4791,12 @@ static gboolean socket_reconnect_timeout(gpointer opaque)
     return false;
 }
 
-static Chardev *qmp_chardev_open_socket(const CharDriver *driver,
-                                        const char *id,
-                                        ChardevBackend *backend,
-                                        ChardevReturn *ret,
-                                        bool *be_opened,
-                                        Error **errp)
+static void qmp_chardev_open_socket(Chardev *chr,
+                                    ChardevBackend *backend,
+                                    bool *be_opened,
+                                    Error **errp)
 {
-    Chardev *chr;
-    SocketChardev *s;
+    SocketChardev *s = SOCKET_CHARDEV(chr);
     ChardevSocket *sock = backend->u.socket.data;
     SocketAddress *addr = sock->addr;
     bool do_nodelay     = sock->has_nodelay ? sock->nodelay : false;
@@ -4770,15 +4804,8 @@ static Chardev *qmp_chardev_open_socket(const CharDriver *driver,
     bool is_telnet      = sock->has_telnet  ? sock->telnet  : false;
     bool is_waitconnect = sock->has_wait    ? sock->wait    : false;
     int64_t reconnect   = sock->has_reconnect ? sock->reconnect : 0;
-    ChardevCommon *common = qapi_ChardevSocket_base(sock);
     QIOChannelSocket *sioc = NULL;
 
-    chr = qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        return NULL;
-    }
-    s = (SocketChardev *)chr;
-
     s->is_unix = addr->type == SOCKET_ADDRESS_KIND_UNIX;
     s->is_listen = is_listen;
     s->is_telnet = is_telnet;
@@ -4870,82 +4897,92 @@ static Chardev *qmp_chardev_open_socket(const CharDriver *driver,
         }
     }
 
-    return chr;
+    return;
 
- error:
+error:
     if (sioc) {
         object_unref(OBJECT(sioc));
     }
     if (s->tls_creds) {
         object_unref(OBJECT(s->tls_creds));
     }
-    qemu_chr_free_common(chr);
-    return NULL;
 }
 
 static const CharDriver socket_driver = {
-    .instance_size = sizeof(SocketChardev),
     .kind = CHARDEV_BACKEND_KIND_SOCKET,
     .parse = qemu_chr_parse_socket,
-    .create = qmp_chardev_open_socket,
-    .chr_wait_connected = tcp_chr_wait_connected,
-    .chr_write = tcp_chr_write,
-    .chr_sync_read = tcp_chr_sync_read,
-    .chr_disconnect = tcp_chr_disconnect,
-    .get_msgfds = tcp_get_msgfds,
-    .set_msgfds = tcp_set_msgfds,
-    .chr_add_client = tcp_chr_add_client,
-    .chr_add_watch = tcp_chr_add_watch,
-    .chr_update_read_handler = tcp_chr_update_read_handler,
-    .chr_free = tcp_chr_free,
 };
 
-static Chardev *qmp_chardev_open_udp(const CharDriver *driver,
-                                     const char *id,
-                                     ChardevBackend *backend,
-                                     ChardevReturn *ret,
-                                     bool *be_opened,
-                                     Error **errp)
+static void char_socket_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->open = qmp_chardev_open_socket;
+    cc->chr_wait_connected = tcp_chr_wait_connected;
+    cc->chr_write = tcp_chr_write;
+    cc->chr_sync_read = tcp_chr_sync_read;
+    cc->chr_disconnect = tcp_chr_disconnect;
+    cc->get_msgfds = tcp_get_msgfds;
+    cc->set_msgfds = tcp_set_msgfds;
+    cc->chr_add_client = tcp_chr_add_client;
+    cc->chr_add_watch = tcp_chr_add_watch;
+    cc->chr_update_read_handler = tcp_chr_update_read_handler;
+    cc->chr_free = tcp_chr_free;
+}
+
+static const TypeInfo char_socket_type_info = {
+    .name = TYPE_CHARDEV_SOCKET,
+    .parent = TYPE_CHARDEV,
+    .instance_size = sizeof(SocketChardev),
+    .class_init = char_socket_class_init,
+};
+
+static void qmp_chardev_open_udp(Chardev *chr,
+                                 ChardevBackend *backend,
+                                 bool *be_opened,
+                                 Error **errp)
 {
     ChardevUdp *udp = backend->u.udp.data;
-    ChardevCommon *common = qapi_ChardevUdp_base(udp);
     QIOChannelSocket *sioc = qio_channel_socket_new();
     char *name;
-    Chardev *chr;
-    UdpChardev *s;
+    UdpChardev *s = UDP_CHARDEV(chr);
 
     if (qio_channel_socket_dgram_sync(sioc,
                                       udp->local, udp->remote,
                                       errp) < 0) {
         object_unref(OBJECT(sioc));
-        return NULL;
-    }
-
-    chr = qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        return NULL;
+        return;
     }
 
     name = g_strdup_printf("chardev-udp-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(sioc), name);
     g_free(name);
 
-    s = (UdpChardev *)chr;
     s->ioc = QIO_CHANNEL(sioc);
     /* be isn't opened until we get a connection */
     *be_opened = false;
-
-    return chr;
 }
 
 static const CharDriver udp_driver = {
-    .instance_size = sizeof(UdpChardev),
     .kind = CHARDEV_BACKEND_KIND_UDP,
     .parse = qemu_chr_parse_udp,
-    .create = qmp_chardev_open_udp,
-    .chr_write = udp_chr_write,
-    .chr_update_read_handler = udp_chr_update_read_handler,
-    .chr_free = udp_chr_free,
+};
+
+static void char_udp_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->open = qmp_chardev_open_udp;
+    cc->chr_write = udp_chr_write;
+    cc->chr_update_read_handler = udp_chr_update_read_handler;
+    cc->chr_free = udp_chr_free;
+}
+
+static const TypeInfo char_udp_type_info = {
+    .name = TYPE_CHARDEV_UDP,
+    .parent = TYPE_CHARDEV,
+    .instance_size = sizeof(UdpChardev),
+    .class_init = char_udp_class_init,
 };
 
 bool qemu_chr_has_feature(Chardev *chr,
@@ -4960,47 +4997,96 @@ void qemu_chr_set_feature(Chardev *chr,
     return set_bit(feature, chr->features);
 }
 
-ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend,
-                               Error **errp)
+static const ChardevClass *char_get_class(const char *driver, Error **errp)
+{
+    ObjectClass *oc;
+    const ChardevClass *cc;
+    char *typename = g_strdup_printf("chardev-%s", driver);
+
+    oc = object_class_by_name(typename);
+    g_free(typename);
+
+    if (!object_class_dynamic_cast(oc, TYPE_CHARDEV)) {
+        error_setg(errp, "'%s' is not a valid char driver name", driver);
+        return NULL;
+    }
+
+    if (object_class_is_abstract(oc)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
+                   "abstract device type");
+        return NULL;
+    }
+
+    cc = CHARDEV_CLASS(oc);
+    if (cc->internal) {
+        error_setg(errp, "'%s' is not a valid char driver name", driver);
+        return NULL;
+    }
+
+    return cc;
+}
+
+Chardev *qemu_chardev_new(const char *id, const char *typename,
+                          ChardevBackend *backend, Error **errp)
 {
-    ChardevReturn *ret = g_new0(ChardevReturn, 1);
     Chardev *chr = NULL;
-    const CharDriver *cd;
     Error *local_err = NULL;
     bool be_opened = true;
 
-    chr = qemu_chr_find(id);
-    if (chr) {
-        error_setg(errp, "Chardev '%s' already exists", id);
-        goto out_error;
-    }
+    assert(g_str_has_prefix(typename, "chardev-"));
 
-    cd = (int)backend->type >= 0 && backend->type < ARRAY_SIZE(backends) ?
-        backends[backend->type] : NULL;
-    if (cd == NULL) {
-        error_setg(errp, "chardev backend not available");
-        goto out_error;
-    }
+    chr = CHARDEV(object_new(typename));
+    chr->label = g_strdup(id);
 
-    chr = cd->create(cd, id, backend, ret, &be_opened, &local_err);
+    qemu_char_open(chr, backend, &be_opened, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        goto out_error;
+        object_unref(OBJECT(chr));
+        return NULL;
     }
 
-    chr->label = g_strdup(id);
     if (!chr->filename) {
-        chr->filename = g_strdup(ChardevBackendKind_lookup[backend->type]);
+        chr->filename = g_strdup(typename + 8);
     }
     if (be_opened) {
         qemu_chr_be_event(chr, CHR_EVENT_OPENED);
     }
+
+    return chr;
+}
+
+ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend,
+                               Error **errp)
+{
+    const ChardevClass *cc;
+    ChardevReturn *ret;
+    Chardev *chr;
+
+    chr = qemu_chr_find(id);
+    if (chr) {
+        error_setg(errp, "Chardev '%s' already exists", id);
+        return NULL;
+    }
+
+    cc = char_get_class(ChardevBackendKind_lookup[backend->type], errp);
+    if (!cc) {
+        return NULL;
+    }
+
+    chr = qemu_chardev_new(id, object_class_get_name(OBJECT_CLASS(cc)),
+                           backend, errp);
+    if (!chr) {
+        return NULL;
+    }
+
+    ret = g_new0(ChardevReturn, 1);
+    if (CHARDEV_IS_PTY(chr)) {
+        ret->pty = g_strdup(chr->filename + 4);
+        ret->has_pty = true;
+    }
+
     QTAILQ_INSERT_TAIL(&chardevs, chr, next);
     return ret;
-
-out_error:
-    g_free(ret);
-    return NULL;
 }
 
 void qmp_chardev_remove(const char *id, Error **errp)
@@ -5035,33 +5121,44 @@ void qemu_chr_cleanup(void)
 
 static void register_types(void)
 {
-    static const CharDriver *drivers[] = {
-        &null_driver,
-        &socket_driver,
-        &udp_driver,
-        &ringbuf_driver,
-        &file_driver,
-        &stdio_driver,
+    static const struct {
+        const CharDriver *driver;
+        const TypeInfo *type;
+    } chardevs[] = {
+        { &null_driver, &char_null_type_info },
+        { &socket_driver, &char_socket_type_info },
+        { &udp_driver, &char_udp_type_info },
+        { &ringbuf_driver, &char_ringbuf_type_info },
+        { &file_driver, &char_file_type_info },
+        { &stdio_driver, &char_stdio_type_info },
 #ifdef HAVE_CHARDEV_SERIAL
-        &serial_driver,
+        { &serial_driver, &char_serial_type_info },
 #endif
 #ifdef HAVE_CHARDEV_PARPORT
-        &parallel_driver,
+        { &parallel_driver, &char_parallel_type_info },
 #endif
 #ifdef HAVE_CHARDEV_PTY
-        &pty_driver,
+        { &pty_driver, &char_pty_type_info },
 #endif
 #ifdef _WIN32
-        &console_driver,
+        { &console_driver, &char_console_type_info },
 #endif
-        &pipe_driver,
-        &mux_driver,
-        &memory_driver
+        { &pipe_driver, &char_pipe_type_info },
+        { &mux_driver, &char_mux_type_info },
+        { &memory_driver, &char_memory_type_info }
     };
     int i;
 
-    for (i = 0; i < ARRAY_SIZE(drivers); i++) {
-        register_char_driver(drivers[i]);
+    type_register_static(&char_type_info);
+#ifndef _WIN32
+    type_register_static(&char_fd_type_info);
+#else
+    type_register_static(&char_win_type_info);
+    type_register_static(&char_win_stdio_type_info);
+#endif
+    for (i = 0; i < ARRAY_SIZE(chardevs); i++) {
+        type_register_static(chardevs[i].type);
+        register_char_driver(chardevs[i].driver);
     }
 
     /* this must be done after machine init, since we register FEs with muxes
diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index 5e5897b..dd97c17 100644
--- a/spice-qemu-char.c
+++ b/spice-qemu-char.c
@@ -18,6 +18,12 @@ typedef struct SpiceChardev {
     QLIST_ENTRY(SpiceChardev) next;
 } SpiceChardev;
 
+#define TYPE_CHARDEV_SPICE "chardev-spice"
+#define TYPE_CHARDEV_SPICEVMC "chardev-spicevmc"
+#define TYPE_CHARDEV_SPICEPORT "chardev-spiceport"
+
+#define SPICE_CHARDEV(obj) OBJECT_CHECK(SpiceChardev, (obj), TYPE_CHARDEV_SPICE)
+
 typedef struct SpiceCharSource {
     GSource               source;
     SpiceChardev       *scd;
@@ -29,7 +35,7 @@ static QLIST_HEAD(, SpiceChardev) spice_chars =
 static int vmc_write(SpiceCharDeviceInstance *sin, const uint8_t *buf, int len)
 {
     SpiceChardev *scd = container_of(sin, SpiceChardev, sin);
-    Chardev *chr = (Chardev *)scd;
+    Chardev *chr = CHARDEV(scd);
     ssize_t out = 0;
     ssize_t last_out;
     uint8_t* p = (uint8_t*)buf;
@@ -73,7 +79,7 @@ static int vmc_read(SpiceCharDeviceInstance *sin, uint8_t *buf, int len)
 static void vmc_event(SpiceCharDeviceInstance *sin, uint8_t event)
 {
     SpiceChardev *scd = container_of(sin, SpiceChardev, sin);
-    Chardev *chr = (Chardev *)scd;
+    Chardev *chr = CHARDEV(scd);
     int chr_event;
 
     switch (event) {
@@ -92,7 +98,7 @@ static void vmc_event(SpiceCharDeviceInstance *sin, uint8_t event)
 static void vmc_state(SpiceCharDeviceInstance *sin, int connected)
 {
     SpiceChardev *scd = container_of(sin, SpiceChardev, sin);
-    Chardev *chr = (Chardev *)scd;
+    Chardev *chr = CHARDEV(scd);
 
     if ((chr->be_open && connected) ||
         (!chr->be_open && !connected)) {
@@ -173,7 +179,7 @@ static GSourceFuncs SpiceCharSourceFuncs = {
 
 static GSource *spice_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    SpiceChardev *scd = (SpiceChardev *)chr;
+    SpiceChardev *scd = SPICE_CHARDEV(chr);
     SpiceCharSource *src;
 
     assert(cond & G_IO_OUT);
@@ -187,7 +193,7 @@ static GSource *spice_chr_add_watch(Chardev *chr, GIOCondition cond)
 
 static int spice_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    SpiceChardev *s = (SpiceChardev *)chr;
+    SpiceChardev *s = SPICE_CHARDEV(chr);
     int read_bytes;
 
     assert(s->datalen == 0);
@@ -206,7 +212,7 @@ static int spice_chr_write(Chardev *chr, const uint8_t *buf, int len)
 
 static void spice_chr_free(struct Chardev *chr)
 {
-    SpiceChardev *s = (SpiceChardev *)chr;
+    SpiceChardev *s = SPICE_CHARDEV(chr);
 
     vmc_unregister_interface(s);
     QLIST_REMOVE(s, next);
@@ -219,7 +225,7 @@ static void spice_chr_free(struct Chardev *chr)
 
 static void spice_vmc_set_fe_open(struct Chardev *chr, int fe_open)
 {
-    SpiceChardev *s = (SpiceChardev *)chr;
+    SpiceChardev *s = SPICE_CHARDEV(chr);
     if (fe_open) {
         vmc_register_interface(s);
     } else {
@@ -230,7 +236,7 @@ static void spice_vmc_set_fe_open(struct Chardev *chr, int fe_open)
 static void spice_port_set_fe_open(struct Chardev *chr, int fe_open)
 {
 #if SPICE_SERVER_VERSION >= 0x000c02
-    SpiceChardev *s = (SpiceChardev *)chr;
+    SpiceChardev *s = SPICE_CHARDEV(chr);
 
     if (fe_open) {
         spice_server_port_event(&s->sin, SPICE_PORT_EVENT_OPENED);
@@ -242,43 +248,29 @@ static void spice_port_set_fe_open(struct Chardev *chr, int fe_open)
 
 static void spice_chr_accept_input(struct Chardev *chr)
 {
-    SpiceChardev *s = (SpiceChardev *)chr;
+    SpiceChardev *s = SPICE_CHARDEV(chr);
 
     spice_server_char_device_wakeup(&s->sin);
 }
 
-static Chardev *chr_open(const CharDriver *driver,
-                                 const char *subtype,
-                                 ChardevCommon *backend,
-                                 Error **errp)
+static void chr_open(Chardev *chr, const char *subtype)
 {
-    Chardev *chr;
-    SpiceChardev *s;
+    SpiceChardev *s = SPICE_CHARDEV(chr);
 
-    chr = qemu_chr_alloc(driver, backend, errp);
-    if (!chr) {
-        return NULL;
-    }
-    s = (SpiceChardev *)chr;
     s->active = false;
     s->sin.subtype = g_strdup(subtype);
 
     QLIST_INSERT_HEAD(&spice_chars, s, next);
-
-    return chr;
 }
 
-static Chardev *qemu_chr_open_spice_vmc(const CharDriver *driver,
-                                                const char *id,
-                                                ChardevBackend *backend,
-                                                ChardevReturn *ret,
-                                                bool *be_opened,
-                                                Error **errp)
+static void qemu_chr_open_spice_vmc(Chardev *chr,
+                                    ChardevBackend *backend,
+                                    bool *be_opened,
+                                    Error **errp)
 {
     ChardevSpiceChannel *spicevmc = backend->u.spicevmc.data;
     const char *type = spicevmc->type;
     const char **psubtype = spice_server_char_device_recognized_subtypes();
-    ChardevCommon *common = qapi_ChardevSpiceChannel_base(spicevmc);
 
     for (; *psubtype != NULL; ++psubtype) {
         if (strcmp(type, *psubtype) == 0) {
@@ -294,41 +286,33 @@ static Chardev *qemu_chr_open_spice_vmc(const CharDriver *driver,
                           subtypes);
 
         g_free(subtypes);
-        return NULL;
+        return;
     }
 
     *be_opened = false;
-    return chr_open(driver, type, common, errp);
+    chr_open(chr, type);
 }
 
 #if SPICE_SERVER_VERSION >= 0x000c02
-static Chardev *qemu_chr_open_spice_port(const CharDriver *driver,
-                                                 const char *id,
-                                                 ChardevBackend *backend,
-                                                 ChardevReturn *ret,
-                                                 bool *be_opened,
-                                                 Error **errp)
+static void qemu_chr_open_spice_port(Chardev *chr,
+                                     ChardevBackend *backend,
+                                     bool *be_opened,
+                                     Error **errp)
 {
     ChardevSpicePort *spiceport = backend->u.spiceport.data;
     const char *name = spiceport->fqdn;
-    ChardevCommon *common = qapi_ChardevSpicePort_base(spiceport);
-    Chardev *chr;
     SpiceChardev *s;
 
     if (name == NULL) {
         error_setg(errp, "missing name parameter");
-        return NULL;
+        return;
     }
 
-    chr = chr_open(driver, "port", common, errp);
-    if (!chr) {
-        return NULL;
-    }
+    chr_open(chr, "port");
+
     *be_opened = false;
-    s = (SpiceChardev *)chr;
+    s = SPICE_CHARDEV(chr);
     s->sin.portname = g_strdup(name);
-
-    return chr;
 }
 
 void qemu_spice_register_ports(void)
@@ -374,32 +358,68 @@ static void qemu_chr_parse_spice_port(QemuOpts *opts, ChardevBackend *backend,
     spiceport->fqdn = g_strdup(name);
 }
 
+static void char_spice_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->chr_write = spice_chr_write;
+    cc->chr_add_watch = spice_chr_add_watch;
+    cc->chr_accept_input = spice_chr_accept_input;
+    cc->chr_free = spice_chr_free;
+}
+
+static const TypeInfo char_spice_type_info = {
+    .name = TYPE_CHARDEV_SPICE,
+    .parent = TYPE_CHARDEV,
+    .instance_size = sizeof(SpiceChardev),
+    .class_init = char_spice_class_init,
+    .abstract = true,
+};
+
+static void char_spicevmc_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->open = qemu_chr_open_spice_vmc;
+    cc->chr_set_fe_open = spice_vmc_set_fe_open;
+}
+
+static const TypeInfo char_spicevmc_type_info = {
+    .name = TYPE_CHARDEV_SPICEVMC,
+    .parent = TYPE_CHARDEV_SPICE,
+    .class_init = char_spicevmc_class_init,
+};
+
+static void char_spiceport_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->open = qemu_chr_open_spice_port;
+    cc->chr_set_fe_open = spice_port_set_fe_open;
+}
+
+static const TypeInfo char_spiceport_type_info = {
+    .name = TYPE_CHARDEV_SPICEPORT,
+    .parent = TYPE_CHARDEV_SPICE,
+    .class_init = char_spiceport_class_init,
+};
+
 static void register_types(void)
 {
     static const CharDriver vmc_driver = {
-        .instance_size = sizeof(SpiceChardev),
         .kind = CHARDEV_BACKEND_KIND_SPICEVMC,
         .parse = qemu_chr_parse_spice_vmc,
-        .create = qemu_chr_open_spice_vmc,
-        .chr_write = spice_chr_write,
-        .chr_add_watch = spice_chr_add_watch,
-        .chr_set_fe_open = spice_vmc_set_fe_open,
-        .chr_accept_input = spice_chr_accept_input,
-        .chr_free = spice_chr_free,
     };
     static const CharDriver port_driver = {
-        .instance_size = sizeof(SpiceChardev),
         .kind = CHARDEV_BACKEND_KIND_SPICEPORT,
         .parse = qemu_chr_parse_spice_port,
-        .create = qemu_chr_open_spice_port,
-        .chr_write = spice_chr_write,
-        .chr_add_watch = spice_chr_add_watch,
-        .chr_set_fe_open = spice_port_set_fe_open,
-        .chr_accept_input = spice_chr_accept_input,
-        .chr_free = spice_chr_free,
     };
     register_char_driver(&vmc_driver);
     register_char_driver(&port_driver);
+
+    type_register_static(&char_spice_type_info);
+    type_register_static(&char_spicevmc_type_info);
+    type_register_static(&char_spiceport_type_info);
 }
 
 type_init(register_types);
diff --git a/ui/console.c b/ui/console.c
index c8ee164..fe03a66 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1051,9 +1051,12 @@ typedef struct VCChardev {
     QemuConsole *console;
 } VCChardev;
 
+#define TYPE_CHARDEV_VC "chardev-vc"
+#define VC_CHARDEV(obj) OBJECT_CHECK(VCChardev, (obj), TYPE_CHARDEV_VC)
+
 static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    VCChardev *drv = (VCChardev *)chr;
+    VCChardev *drv = VC_CHARDEV(chr);
     QemuConsole *s = drv->console;
     int i;
 
@@ -1964,7 +1967,7 @@ int qemu_console_get_height(QemuConsole *con, int fallback)
 
 static void vc_chr_set_echo(Chardev *chr, bool echo)
 {
-    VCChardev *drv = (VCChardev *)chr;
+    VCChardev *drv = VC_CHARDEV(chr);
     QemuConsole *s = drv->console;
 
     s->echo = echo;
@@ -2005,7 +2008,7 @@ static const GraphicHwOps text_console_ops = {
 
 static void text_console_do_init(Chardev *chr, DisplayState *ds)
 {
-    VCChardev *drv = (VCChardev *)chr;
+    VCChardev *drv = VC_CHARDEV(chr);
     QemuConsole *s = drv->console;
     int g_width = 80 * FONT_WIDTH;
     int g_height = 24 * FONT_HEIGHT;
@@ -2058,24 +2061,17 @@ static void text_console_do_init(Chardev *chr, DisplayState *ds)
 
 static const CharDriver vc_driver;
 
-static Chardev *vc_chr_init(const CharDriver *driver,
-                            const char *id, ChardevBackend *backend,
-                            ChardevReturn *ret, bool *be_opened,
-                            Error **errp)
+static void vc_chr_open(Chardev *chr,
+                        ChardevBackend *backend,
+                        bool *be_opened,
+                        Error **errp)
 {
     ChardevVC *vc = backend->u.vc.data;
-    ChardevCommon *common = qapi_ChardevVC_base(vc);
-    Chardev *chr;
-    VCChardev *drv;
+    VCChardev *drv = VC_CHARDEV(chr);
     QemuConsole *s;
     unsigned width = 0;
     unsigned height = 0;
 
-    chr = qemu_chr_alloc(&vc_driver, common, errp);
-    if (!chr) {
-        return NULL;
-    }
-
     if (vc->has_width) {
         width = vc->width;
     } else if (vc->has_cols) {
@@ -2097,13 +2093,11 @@ static Chardev *vc_chr_init(const CharDriver *driver,
     }
 
     if (!s) {
-        g_free(chr);
         error_setg(errp, "cannot create text console");
-        return NULL;
+        return;
     }
 
     s->chr = chr;
-    drv = (VCChardev *)chr;
     drv->console = s;
 
     if (display_state) {
@@ -2114,8 +2108,6 @@ static Chardev *vc_chr_init(const CharDriver *driver,
      * stage, so defer OPENED events until they are fully initialized
      */
     *be_opened = false;
-
-    return chr;
 }
 
 void qemu_console_resize(QemuConsole *s, int width, int height)
@@ -2193,19 +2185,39 @@ static const TypeInfo qemu_console_info = {
     .class_size = sizeof(QemuConsoleClass),
 };
 
-static const CharDriver vc_driver = {
+static void char_vc_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->open = vc_chr_open;
+    cc->chr_write = vc_chr_write;
+    cc->chr_set_echo = vc_chr_set_echo;
+}
+
+static const TypeInfo char_vc_type_info = {
+    .name = TYPE_CHARDEV_VC,
+    .parent = TYPE_CHARDEV,
     .instance_size = sizeof(VCChardev),
+    .class_init = char_vc_class_init,
+};
+
+void qemu_console_early_init(void)
+{
+    /* set the default vc driver */
+    if (!object_class_by_name(TYPE_CHARDEV_VC)) {
+        type_register(&char_vc_type_info);
+        register_char_driver(&vc_driver);
+    }
+}
+
+static const CharDriver vc_driver = {
     .kind = CHARDEV_BACKEND_KIND_VC,
     .parse = qemu_chr_parse_vc,
-    .create = vc_chr_init,
-    .chr_write = vc_chr_write,
-    .chr_set_echo = vc_chr_set_echo,
 };
 
 static void register_types(void)
 {
     type_register_static(&qemu_console_info);
-    register_char_driver(&vc_driver);
 }
 
 type_init(register_types);
diff --git a/ui/gtk.c b/ui/gtk.c
index 04df0ad..bdd831c 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -187,6 +187,9 @@ typedef struct VCChardev {
     bool echo;
 } VCChardev;
 
+#define TYPE_CHARDEV_VC "chardev-vc"
+#define VC_CHARDEV(obj) OBJECT_CHECK(VCChardev, (obj), TYPE_CHARDEV_VC)
+
 static void gd_grab_pointer(VirtualConsole *vc, const char *reason);
 static void gd_ungrab_pointer(GtkDisplayState *s);
 static void gd_grab_keyboard(VirtualConsole *vc, const char *reason);
@@ -1691,7 +1694,7 @@ static void gd_vc_adjustment_changed(GtkAdjustment *adjustment, void *opaque)
 
 static int gd_vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    VCChardev *vcd = (VCChardev *)chr;
+    VCChardev *vcd = VC_CHARDEV(chr);
     VirtualConsole *vc = vcd->console;
 
     vte_terminal_feed(VTE_TERMINAL(vc->vte.terminal), (const char *)buf, len);
@@ -1700,7 +1703,7 @@ static int gd_vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
 
 static void gd_vc_chr_set_echo(Chardev *chr, bool echo)
 {
-    VCChardev *vcd = (VCChardev *)chr;
+    VCChardev *vcd = VC_CHARDEV(chr);
     VirtualConsole *vc = vcd->console;
 
     if (vc) {
@@ -1714,23 +1717,14 @@ static int nb_vcs;
 static Chardev *vcs[MAX_VCS];
 static const CharDriver gd_vc_driver;
 
-static Chardev *vc_init(const CharDriver *driver,
-                        const char *id, ChardevBackend *backend,
-                        ChardevReturn *ret, bool *be_opened,
-                        Error **errp)
+static void gd_vc_open(Chardev *chr,
+                       ChardevBackend *backend,
+                       bool *be_opened,
+                       Error **errp)
 {
-    ChardevVC *vc = backend->u.vc.data;
-    ChardevCommon *common = qapi_ChardevVC_base(vc);
-    Chardev *chr;
-
     if (nb_vcs == MAX_VCS) {
         error_setg(errp, "Maximum number of consoles reached");
-        return NULL;
-    }
-
-    chr = qemu_chr_alloc(&gd_vc_driver, common, errp);
-    if (!chr) {
-        return NULL;
+        return;
     }
 
     vcs[nb_vcs++] = chr;
@@ -1739,16 +1733,27 @@ static Chardev *vc_init(const CharDriver *driver,
      * stage, so defer OPENED events until they are fully initialized
      */
     *be_opened = false;
+}
 
-    return chr;
+static void char_gd_vc_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->open = gd_vc_open;
+    cc->chr_write = gd_vc_chr_write;
+    cc->chr_set_echo = gd_vc_chr_set_echo;
 }
 
-static const CharDriver gd_vc_driver = {
+static const TypeInfo char_gd_vc_type_info = {
+    .name = TYPE_CHARDEV_VC,
+    .parent = TYPE_CHARDEV,
     .instance_size = sizeof(VCChardev),
+    .class_init = char_gd_vc_class_init,
+};
+
+static const CharDriver gd_vc_driver = {
     .kind = CHARDEV_BACKEND_KIND_VC,
-    .parse = qemu_chr_parse_vc, .create = vc_init,
-    .chr_write = gd_vc_chr_write,
-    .chr_set_echo = gd_vc_chr_set_echo,
+    .parse = qemu_chr_parse_vc,
 };
 
 static gboolean gd_vc_in(VteTerminal *terminal, gchar *text, guint size,
@@ -1786,7 +1791,7 @@ static GSList *gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
     GtkWidget *box;
     GtkWidget *scrollbar;
     GtkAdjustment *vadjustment;
-    VCChardev *vcd = (VCChardev *)chr;
+    VCChardev *vcd = VC_CHARDEV(chr);
 
     vc->s = s;
     vc->vte.echo = vcd->echo;
@@ -2347,7 +2352,7 @@ void early_gtk_display_init(int opengl)
     }
 
 #if defined(CONFIG_VTE)
-    /* overwrite the console.c vc driver */
+    type_register(&char_gd_vc_type_info);
     register_char_driver(&gd_vc_driver);
 #endif
 }
diff --git a/vl.c b/vl.c
index 41be59f..f788275 100644
--- a/vl.c
+++ b/vl.c
@@ -4238,6 +4238,8 @@ int main(int argc, char **argv, char **envp)
         sdl_display_early_init(request_opengl);
     }
 
+    qemu_console_early_init();
+
     if (request_opengl == 1 && display_opengl == 0) {
 #if defined(CONFIG_OPENGL)
         error_report("OpenGL is not supported by the display");
-- 
1.8.3.1

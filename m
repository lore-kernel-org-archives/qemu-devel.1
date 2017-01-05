Received: from eggs.gnu.org ([2001:4830:134:3::10]:53972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cPBIx-0007oM-Bz
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:54:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cPBIn-0002vd-HC
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:54:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cPBIm-0002v9-UI
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:54:09 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0489BC0567B3
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 16:54:09 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  5 Jan 2017 17:53:29 +0100
Message-Id: <20170105165329.17227-21-marcandre.lureau@redhat.com>
In-Reply-To: <20170105165329.17227-1-marcandre.lureau@redhat.com>
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 20/20] chardev: qom-ify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/char.h |  107 ++--
 include/ui/console.h  |    2 +
 backends/baum.c       |   66 +--
 backends/msmouse.c    |   57 ++-
 backends/testdev.c    |   34 +-
 gdbstub.c             |   39 +-
 hw/bt/hci-csr.c       |   55 +-
 monitor.c             |    2 +-
 qemu-char.c           | 1327 ++++++++++++++++++++++++++-----------------=
------
 spice-qemu-char.c     |  142 +++---
 ui/console.c          |   62 ++-
 ui/gtk.c              |   51 +-
 vl.c                  |    2 +
 13 files changed, 1073 insertions(+), 873 deletions(-)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 3de9283491..fb1ca69bff 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -10,6 +10,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qemu/main-loop.h"
 #include "qemu/bitmap.h"
+#include "qom/object.h"
=20
 /* character device */
=20
@@ -90,7 +91,8 @@ typedef struct CharBackend {
 typedef struct CharDriver CharDriver;
=20
 struct Chardev {
-    const CharDriver *driver;
+    Object parent_obj;
+
     QemuMutex chr_write_lock;
     CharBackend *be;
     char *label;
@@ -102,18 +104,6 @@ struct Chardev {
     QTAILQ_ENTRY(Chardev) next;
 };
=20
-/**
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
 /**
  * @qemu_chr_new_from_opts:
  *
@@ -455,54 +445,73 @@ void qemu_chr_fe_accept_input(CharBackend *be);
 int qemu_chr_add_client(Chardev *s, int fd);
 Chardev *qemu_chr_find(const char *name);
=20
-/**
- * @qemu_chr_get_kind:
- *
- * Returns the kind of char backend, or -1 if unspecified.
- */
-ChardevBackendKind qemu_chr_get_kind(const Chardev *chr);
-
-static inline bool qemu_chr_is_ringbuf(const Chardev *chr)
-{
-    return qemu_chr_get_kind(chr) =3D=3D CHARDEV_BACKEND_KIND_RINGBUF ||
-        qemu_chr_get_kind(chr) =3D=3D CHARDEV_BACKEND_KIND_MEMORY;
-}
-
 bool qemu_chr_has_feature(Chardev *chr,
                           CharDriverFeature feature);
 void qemu_chr_set_feature(Chardev *chr,
                           CharDriverFeature feature);
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename)=
;
=20
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
     const char *alias;
     ChardevBackendKind kind;
     void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp)=
;
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
=20
+Chardev *qemu_chardev_new(const char *id, const char *typename,
+                          ChardevBackend *backend, Error **errp);
+
 void register_char_driver(const CharDriver *driver);
=20
 extern int term_escape_char;
diff --git a/include/ui/console.h b/include/ui/console.h
index 7fb351f72e..ebd757c244 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -380,6 +380,8 @@ void graphic_hw_invalidate(QemuConsole *con);
 void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata);
 void graphic_hw_gl_block(QemuConsole *con, bool block);
=20
+void qemu_console_early_init(void);
+
 QemuConsole *qemu_console_lookup_by_index(unsigned int index);
 QemuConsole *qemu_console_lookup_by_device(DeviceState *dev, uint32_t he=
ad);
 QemuConsole *qemu_console_lookup_by_device_name(const char *device_id,
diff --git a/backends/baum.c b/backends/baum.c
index 8842936417..0f418ed358 100644
--- a/backends/baum.c
+++ b/backends/baum.c
@@ -100,6 +100,9 @@ typedef struct {
     QEMUTimer *cellCount_timer;
 } BaumChardev;
=20
+#define TYPE_CHARDEV_BRAILLE "chardev-braille"
+#define BAUM_CHARDEV(obj) OBJECT_CHECK(BaumChardev, (obj), TYPE_CHARDEV_=
BRAILLE)
+
 /* Let's assume NABCC by default */
 enum way {
     DOTS2ASCII,
@@ -255,7 +258,7 @@ static int baum_deferred_init(BaumChardev *baum)
 /* The serial port can receive more of our data */
 static void baum_chr_accept_input(struct Chardev *chr)
 {
-    BaumChardev *baum =3D (BaumChardev *)chr;
+    BaumChardev *baum =3D BAUM_CHARDEV(chr);
     int room, first;
=20
     if (!baum->out_buf_used)
@@ -281,7 +284,7 @@ static void baum_chr_accept_input(struct Chardev *chr=
)
 /* We want to send a packet */
 static void baum_write_packet(BaumChardev *baum, const uint8_t *buf, int=
 len)
 {
-    Chardev *chr =3D (Chardev *)baum;
+    Chardev *chr =3D CHARDEV(baum);
     uint8_t io_buf[1 + 2 * len], *cur =3D io_buf;
     int room;
     *cur++ =3D ESC;
@@ -322,7 +325,7 @@ static void baum_write_packet(BaumChardev *baum, cons=
t uint8_t *buf, int len)
 /* Called when the other end seems to have a wrong idea of our display s=
ize */
 static void baum_cellCount_timer_cb(void *opaque)
 {
-    BaumChardev *baum =3D opaque;
+    BaumChardev *baum =3D BAUM_CHARDEV(opaque);
     uint8_t cell_count[] =3D { BAUM_RSP_CellCount, baum->x * baum->y };
     DPRINTF("Timeout waiting for DisplayData, sending cell count\n");
     baum_write_packet(baum, cell_count, sizeof(cell_count));
@@ -472,7 +475,7 @@ static int baum_eat_packet(BaumChardev *baum, const u=
int8_t *buf, int len)
 /* The other end is writing some data.  Store it and try to interpret */
 static int baum_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    BaumChardev *baum =3D (BaumChardev *)chr;
+    BaumChardev *baum =3D BAUM_CHARDEV(chr);
     int tocopy, cur, eaten, orig_len =3D len;
=20
     if (!len)
@@ -529,7 +532,7 @@ static void baum_send_key2(BaumChardev *baum, uint8_t=
 type, uint8_t value,
 /* We got some data on the BrlAPI socket */
 static void baum_chr_read(void *opaque)
 {
-    BaumChardev *baum =3D opaque;
+    BaumChardev *baum =3D BAUM_CHARDEV(opaque);
     brlapi_keyCode_t code;
     int ret;
     if (!baum->brlapi)
@@ -613,9 +616,9 @@ static void baum_chr_read(void *opaque)
     }
 }
=20
-static void baum_chr_free(struct Chardev *chr)
+static void baum_chr_free(Chardev *chr)
 {
-    BaumChardev *baum =3D (BaumChardev *)chr;
+    BaumChardev *baum =3D BAUM_CHARDEV(chr);
=20
     timer_free(baum->cellCount_timer);
     if (baum->brlapi) {
@@ -624,24 +627,14 @@ static void baum_chr_free(struct Chardev *chr)
     }
 }
=20
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
-    ChardevCommon *common =3D backend->u.braille.data;
-    BaumChardev *baum;
-    Chardev *chr;
+    BaumChardev *baum =3D BAUM_CHARDEV(chr);
     brlapi_handle_t *handle;
=20
-    chr =3D qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        return NULL;
-    }
-    baum =3D (BaumChardev *)chr;
-
     handle =3D g_malloc0(brlapi_getHandleSize());
     baum->brlapi =3D handle;
=20
@@ -649,34 +642,41 @@ static Chardev *baum_chr_init(const CharDriver *dri=
ver,
     if (baum->brlapi_fd =3D=3D -1) {
         error_setg(errp, "brlapi__openConnection: %s",
                    brlapi_strerror(brlapi_error_location()));
-        goto fail_handle;
+        g_free(handle);
+        return;
     }
     baum->deferred_init =3D 0;
=20
     baum->cellCount_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, baum_cell=
Count_timer_cb, baum);
=20
     qemu_set_fd_handler(baum->brlapi_fd, baum_chr_read, NULL, baum);
+}
=20
-    return chr;
+static void char_braille_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-fail_handle:
-    g_free(handle);
-    g_free(chr);
-    return NULL;
+    cc->open =3D baum_chr_open;
+    cc->chr_write =3D baum_chr_write;
+    cc->chr_accept_input =3D baum_chr_accept_input;
+    cc->chr_free =3D baum_chr_free;
 }
=20
+static const TypeInfo char_braille_type_info =3D {
+    .name =3D TYPE_CHARDEV_BRAILLE,
+    .parent =3D TYPE_CHARDEV,
+    .instance_size =3D sizeof(BaumChardev),
+    .class_init =3D char_braille_class_init,
+};
+
 static void register_types(void)
 {
     static const CharDriver driver =3D {
-        .instance_size =3D sizeof(BaumChardev),
         .kind =3D CHARDEV_BACKEND_KIND_BRAILLE,
-        .create =3D baum_chr_init,
-        .chr_write =3D baum_chr_write,
-        .chr_accept_input =3D baum_chr_accept_input,
-        .chr_free =3D baum_chr_free,
     };
=20
     register_char_driver(&driver);
+    type_register_static(&char_braille_type_info);
 }
=20
 type_init(register_types);
diff --git a/backends/msmouse.c b/backends/msmouse.c
index 4e474da4c3..936a5476d5 100644
--- a/backends/msmouse.c
+++ b/backends/msmouse.c
@@ -41,9 +41,13 @@ typedef struct {
     int outlen;
 } MouseChardev;
=20
+#define TYPE_CHARDEV_MSMOUSE "chardev-msmouse"
+#define MOUSE_CHARDEV(obj)                                      \
+    OBJECT_CHECK(MouseChardev, (obj), TYPE_CHARDEV_MSMOUSE)
+
 static void msmouse_chr_accept_input(Chardev *chr)
 {
-    MouseChardev *mouse =3D (MouseChardev *)chr;
+    MouseChardev *mouse =3D MOUSE_CHARDEV(chr);
     int len;
=20
     len =3D qemu_chr_be_can_write(chr);
@@ -98,7 +102,7 @@ static void msmouse_queue_event(MouseChardev *mouse)
 static void msmouse_input_event(DeviceState *dev, QemuConsole *src,
                                 InputEvent *evt)
 {
-    MouseChardev *mouse =3D (MouseChardev *)dev;
+    MouseChardev *mouse =3D MOUSE_CHARDEV(dev);
     InputMoveEvent *move;
     InputBtnEvent *btn;
=20
@@ -122,8 +126,8 @@ static void msmouse_input_event(DeviceState *dev, Qem=
uConsole *src,
=20
 static void msmouse_input_sync(DeviceState *dev)
 {
-    MouseChardev *mouse =3D (MouseChardev *)dev;
-    Chardev *chr =3D (Chardev *)dev;
+    MouseChardev *mouse =3D MOUSE_CHARDEV(dev);
+    Chardev *chr =3D CHARDEV(dev);
=20
     msmouse_queue_event(mouse);
     msmouse_chr_accept_input(chr);
@@ -137,7 +141,7 @@ static int msmouse_chr_write(struct Chardev *s, const=
 uint8_t *buf, int len)
=20
 static void msmouse_chr_free(struct Chardev *chr)
 {
-    MouseChardev *mouse =3D (MouseChardev *)chr;
+    MouseChardev *mouse =3D MOUSE_CHARDEV(chr);
=20
     qemu_input_handler_unregister(mouse->hs);
 }
@@ -149,42 +153,43 @@ static QemuInputHandler msmouse_handler =3D {
     .sync  =3D msmouse_input_sync,
 };
=20
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
-    ChardevCommon *common =3D backend->u.msmouse.data;
-    MouseChardev *mouse;
-    Chardev *chr;
+    MouseChardev *mouse =3D MOUSE_CHARDEV(chr);
=20
-    chr =3D qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        return NULL;
-    }
     *be_opened =3D false;
-
-    mouse =3D (MouseChardev *)chr;
     mouse->hs =3D qemu_input_handler_register((DeviceState *)mouse,
                                             &msmouse_handler);
+}
=20
+static void char_msmouse_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    return chr;
+    cc->open =3D msmouse_chr_open;
+    cc->chr_write =3D msmouse_chr_write;
+    cc->chr_accept_input =3D msmouse_chr_accept_input;
+    cc->chr_free =3D msmouse_chr_free;
 }
=20
+static const TypeInfo char_msmouse_type_info =3D {
+    .name =3D TYPE_CHARDEV_MSMOUSE,
+    .parent =3D TYPE_CHARDEV,
+    .instance_size =3D sizeof(MouseChardev),
+    .class_init =3D char_msmouse_class_init,
+};
+
 static void register_types(void)
 {
     static const CharDriver driver =3D {
-        .instance_size =3D sizeof(MouseChardev),
         .kind =3D CHARDEV_BACKEND_KIND_MSMOUSE,
-        .create =3D qemu_chr_open_msmouse,
-        .chr_write =3D msmouse_chr_write,
-        .chr_accept_input =3D msmouse_chr_accept_input,
-        .chr_free =3D msmouse_chr_free,
     };
+
     register_char_driver(&driver);
+    type_register_static(&char_msmouse_type_info);
 }
=20
 type_init(register_types);
diff --git a/backends/testdev.c b/backends/testdev.c
index 268b380cf3..ea15143713 100644
--- a/backends/testdev.c
+++ b/backends/testdev.c
@@ -36,6 +36,10 @@ typedef struct {
     int in_buf_used;
 } TestdevChardev;
=20
+#define TYPE_CHARDEV_TESTDEV "chardev-testdev"
+#define TESTDEV_CHARDEV(obj)                                    \
+    OBJECT_CHECK(TestdevChardev, (obj), TYPE_CHARDEV_TESTDEV)
+
 /* Try to interpret a whole incoming packet */
 static int testdev_eat_packet(TestdevChardev *testdev)
 {
@@ -78,9 +82,9 @@ static int testdev_eat_packet(TestdevChardev *testdev)
 }
=20
 /* The other end is writing some data.  Store it and try to interpret */
-static int testdev_write(Chardev *chr, const uint8_t *buf, int len)
+static int testdev_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    TestdevChardev *testdev =3D (TestdevChardev *)chr;
+    TestdevChardev *testdev =3D TESTDEV_CHARDEV(chr);
     int tocopy, eaten, orig_len =3D len;
=20
     while (len) {
@@ -103,30 +107,28 @@ static int testdev_write(Chardev *chr, const uint8_=
t *buf, int len)
     return orig_len;
 }
=20
-static Chardev *chr_testdev_init(const CharDriver *driver,
-                                 const char *id,
-                                 ChardevBackend *backend,
-                                 ChardevReturn *ret,
-                                 bool *be_opened,
-                                 Error **errp)
+static void char_testdev_class_init(ObjectClass *oc, void *data)
 {
-    TestdevChardev *testdev =3D g_new0(TestdevChardev, 1);;
-    Chardev *chr =3D (Chardev *)testdev;
-
-    chr->driver =3D driver;
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
-    return chr;
+    cc->chr_write =3D testdev_chr_write;
 }
=20
+static const TypeInfo char_testdev_type_info =3D {
+    .name =3D TYPE_CHARDEV_TESTDEV,
+    .parent =3D TYPE_CHARDEV,
+    .instance_size =3D sizeof(TestdevChardev),
+    .class_init =3D char_testdev_class_init,
+};
+
 static void register_types(void)
 {
     static const CharDriver driver =3D {
-        .instance_size =3D sizeof(TestdevChardev),
         .kind =3D CHARDEV_BACKEND_KIND_TESTDEV,
-        .create =3D chr_testdev_init,
-        .chr_write =3D testdev_write,
     };
+
     register_char_driver(&driver);
+    type_register_static(&char_testdev_type_info);
 }
=20
 type_init(register_types);
diff --git a/gdbstub.c b/gdbstub.c
index 22fa291bc9..25694c3daf 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1723,18 +1723,35 @@ static void gdb_sigterm_handler(int signal)
 }
 #endif
=20
+static void gdb_monitor_open(Chardev *chr, ChardevBackend *backend,
+                             bool *be_opened, Error **errp)
+{
+    *be_opened =3D false;
+}
+
+static void char_gdb_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->internal =3D true;
+    cc->open =3D gdb_monitor_open;
+    cc->chr_write =3D gdb_monitor_write;
+}
+
+#define TYPE_CHARDEV_GDB "chardev-gdb"
+
+static const TypeInfo char_gdb_type_info =3D {
+    .name =3D TYPE_CHARDEV_GDB,
+    .parent =3D TYPE_CHARDEV,
+    .class_init =3D char_gdb_class_init,
+};
+
 int gdbserver_start(const char *device)
 {
     GDBState *s;
     char gdbstub_device_name[128];
     Chardev *chr =3D NULL;
     Chardev *mon_chr;
-    ChardevCommon common =3D { 0 };
-    static const CharDriver driver =3D {
-        .instance_size =3D sizeof(Chardev),
-        .kind =3D -1,
-        .chr_write =3D gdb_monitor_write
-    };
=20
     if (!device)
         return -1;
@@ -1767,7 +1784,8 @@ int gdbserver_start(const char *device)
         qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
=20
         /* Initialize a monitor terminal for gdb */
-        mon_chr =3D qemu_chr_alloc(&driver, &common, &error_abort);
+        mon_chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
+                                   NULL, &error_abort);
         monitor_init(mon_chr, 0);
     } else {
         if (qemu_chr_fe_get_driver(&s->chr)) {
@@ -1790,4 +1808,11 @@ int gdbserver_start(const char *device)
=20
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
index 153ed2f1ba..3c193848fc 100644
--- a/hw/bt/hci-csr.c
+++ b/hw/bt/hci-csr.c
@@ -55,6 +55,9 @@ struct csrhci_s {
     struct HCIInfo *hci;
 };
=20
+#define TYPE_CHARDEV_HCI "chardev-hci"
+#define HCI_CHARDEV(obj) OBJECT_CHECK(struct csrhci_s, (obj), TYPE_CHARD=
EV_HCI)
+
 /* H4+ packet types */
 enum {
     H4_CMD_PKT   =3D 1,
@@ -462,23 +465,12 @@ qemu_irq *csrhci_pins_get(Chardev *chr)
     return s->pins;
 }
=20
-Chardev *uart_hci_init(void)
+static void csrhci_open(Chardev *chr,
+                        ChardevBackend *backend,
+                        bool *be_opened,
+                        Error **errp)
 {
-    static const CharDriver hci_driver =3D {
-        .instance_size =3D sizeof(struct csrhci_s),
-        .kind =3D -1,
-        .chr_write =3D csrhci_write,
-        .chr_ioctl =3D csrhci_ioctl,
-    };
-    Error *err =3D NULL;
-    ChardevCommon common =3D { 0, };
-    Chardev *chr =3D qemu_chr_alloc(&hci_driver, &common, &err);
-    struct csrhci_s *s =3D (struct csrhci_s *)chr;
-
-    if (err) {
-        error_report_err(err);
-        return NULL;
-    }
+    struct csrhci_s *s =3D HCI_CHARDEV(chr);
=20
     s->hci =3D qemu_next_hci();
     s->hci->opaque =3D s;
@@ -488,6 +480,35 @@ Chardev *uart_hci_init(void)
     s->out_tm =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, csrhci_out_tick, s);
     s->pins =3D qemu_allocate_irqs(csrhci_pins, s, __csrhci_pins);
     csrhci_reset(s);
+    *be_opened =3D false;
+}
+
+static void char_hci_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->internal =3D true;
+    cc->open =3D csrhci_open;
+    cc->chr_write =3D csrhci_write;
+    cc->chr_ioctl =3D csrhci_ioctl;
+}
+
+static const TypeInfo char_hci_type_info =3D {
+    .name =3D TYPE_CHARDEV_HCI,
+    .parent =3D TYPE_CHARDEV,
+    .instance_size =3D sizeof(struct csrhci_s),
+    .class_init =3D char_hci_class_init,
+};
=20
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
diff --git a/monitor.c b/monitor.c
index a82f547488..90ca4d737a 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3194,7 +3194,7 @@ static void ringbuf_completion(ReadLineState *rs, c=
onst char *str)
=20
         if (!strncmp(chr_info->label, str, len)) {
             Chardev *chr =3D qemu_chr_find(chr_info->label);
-            if (chr && qemu_chr_is_ringbuf(chr)) {
+            if (chr && CHARDEV_IS_RINGBUF(chr)) {
                 readline_add_completion(rs, chr_info->label);
             }
         }
diff --git a/qemu-char.c b/qemu-char.c
index 284dd2f979..aed9b4c6b3 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -160,43 +160,6 @@ static char *sockaddr_to_str(struct sockaddr_storage=
 *ss, socklen_t ss_len,
 static QTAILQ_HEAD(ChardevHead, Chardev) chardevs =3D
     QTAILQ_HEAD_INITIALIZER(chardevs);
=20
-static void qemu_chr_free_common(Chardev *chr);
-
-Chardev *qemu_chr_alloc(const CharDriver *driver,
-                                ChardevCommon *backend, Error **errp)
-{
-    Chardev *chr;
-
-    assert(driver);
-    assert(driver->chr_write);
-    assert(driver->instance_size >=3D sizeof(Chardev));
-
-    chr =3D g_malloc0(driver->instance_size);
-    qemu_mutex_init(&chr->chr_write_lock);
-    if (backend->has_logfile) {
-        int flags =3D O_WRONLY | O_CREAT;
-        if (backend->has_logappend &&
-            backend->logappend) {
-            flags |=3D O_APPEND;
-        } else {
-            flags |=3D O_TRUNC;
-        }
-        chr->logfd =3D qemu_open(backend->logfile, flags, 0666);
-        if (chr->logfd < 0) {
-            error_setg_errno(errp, errno,
-                             "Unable to open logfile %s",
-                             backend->logfile);
-            g_free(chr);
-            return NULL;
-        }
-    } else {
-        chr->logfd =3D -1;
-    }
-    chr->driver =3D driver;
-
-    return chr;
-}
-
 void qemu_chr_be_event(Chardev *s, int event)
 {
     CharBackend *be =3D s->be;
@@ -254,13 +217,14 @@ static void qemu_chr_fe_write_log(Chardev *s,
 static int qemu_chr_fe_write_buffer(Chardev *s,
                                     const uint8_t *buf, int len, int *of=
fset)
 {
+    ChardevClass *cc =3D CHARDEV_GET_CLASS(s);
     int res =3D 0;
     *offset =3D 0;
=20
     qemu_mutex_lock(&s->chr_write_lock);
     while (*offset < len) {
     retry:
-        res =3D s->driver->chr_write(s, buf + *offset, len - *offset);
+        res =3D cc->chr_write(s, buf + *offset, len - *offset);
         if (res < 0 && errno =3D=3D EAGAIN) {
             g_usleep(100);
             goto retry;
@@ -288,6 +252,7 @@ static bool qemu_chr_replay(Chardev *chr)
 int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
 {
     Chardev *s =3D be->chr;
+    ChardevClass *cc;
     int ret;
=20
     if (!s) {
@@ -302,8 +267,9 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t =
*buf, int len)
         return ret;
     }
=20
+    cc =3D CHARDEV_GET_CLASS(s);
     qemu_mutex_lock(&s->chr_write_lock);
-    ret =3D s->driver->chr_write(s, buf, len);
+    ret =3D cc->chr_write(s, buf, len);
=20
     if (ret > 0) {
         qemu_chr_fe_write_log(s, buf, ret);
@@ -359,7 +325,7 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *bu=
f, int len)
     int offset =3D 0, counter =3D 10;
     int res;
=20
-    if (!s || !s->driver->chr_sync_read) {
+    if (!s || !CHARDEV_GET_CLASS(s)->chr_sync_read) {
         return 0;
     }
=20
@@ -369,7 +335,8 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *bu=
f, int len)
=20
     while (offset < len) {
     retry:
-        res =3D s->driver->chr_sync_read(s, buf + offset, len - offset);
+        res =3D CHARDEV_GET_CLASS(s)->chr_sync_read(s, buf + offset,
+                                                  len - offset);
         if (res =3D=3D -1 && errno =3D=3D EAGAIN) {
             g_usleep(100);
             goto retry;
@@ -404,10 +371,10 @@ int qemu_chr_fe_ioctl(CharBackend *be, int cmd, voi=
d *arg)
     Chardev *s =3D be->chr;
     int res;
=20
-    if (!s || !s->driver->chr_ioctl || qemu_chr_replay(s)) {
+    if (!s || !CHARDEV_GET_CLASS(s)->chr_ioctl || qemu_chr_replay(s)) {
         res =3D -ENOTSUP;
     } else {
-        res =3D s->driver->chr_ioctl(s, cmd, arg);
+        res =3D CHARDEV_GET_CLASS(s)->chr_ioctl(s, cmd, arg);
     }
=20
     return res;
@@ -466,7 +433,8 @@ int qemu_chr_fe_get_msgfds(CharBackend *be, int *fds,=
 int len)
         return -1;
     }
=20
-    return s->driver->get_msgfds ? s->driver->get_msgfds(s, fds, len) : =
-1;
+    return CHARDEV_GET_CLASS(s)->get_msgfds ?
+        CHARDEV_GET_CLASS(s)->get_msgfds(s, fds, len) : -1;
 }
=20
 int qemu_chr_fe_set_msgfds(CharBackend *be, int *fds, int num)
@@ -477,12 +445,14 @@ int qemu_chr_fe_set_msgfds(CharBackend *be, int *fd=
s, int num)
         return -1;
     }
=20
-    return s->driver->set_msgfds ? s->driver->set_msgfds(s, fds, num) : =
-1;
+    return CHARDEV_GET_CLASS(s)->set_msgfds ?
+        CHARDEV_GET_CLASS(s)->set_msgfds(s, fds, num) : -1;
 }
=20
 int qemu_chr_add_client(Chardev *s, int fd)
 {
-    return s->driver->chr_add_client ? s->driver->chr_add_client(s, fd) =
: -1;
+    return CHARDEV_GET_CLASS(s)->chr_add_client ?
+        CHARDEV_GET_CLASS(s)->chr_add_client(s, fd) : -1;
 }
=20
 void qemu_chr_fe_accept_input(CharBackend *be)
@@ -493,8 +463,8 @@ void qemu_chr_fe_accept_input(CharBackend *be)
         return;
     }
=20
-    if (s->driver->chr_accept_input) {
-        s->driver->chr_accept_input(s);
+    if (CHARDEV_GET_CLASS(s)->chr_accept_input) {
+        CHARDEV_GET_CLASS(s)->chr_accept_input(s);
     }
     qemu_notify_event();
 }
@@ -515,34 +485,98 @@ static void remove_fd_in_watch(Chardev *chr);
 static void mux_chr_set_handlers(Chardev *chr, GMainContext *context);
 static void mux_set_focus(MuxChardev *d, int focus);
=20
-static int null_chr_write(Chardev *chr, const uint8_t *buf, int len)
+static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
+                           bool *be_opened, Error **errp)
 {
-    return len;
+    ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
+    /* Any ChardevCommon member would work */
+    ChardevCommon *common =3D backend ? backend->u.null.data : NULL;
+
+    if (common && common->has_logfile) {
+        int flags =3D O_WRONLY | O_CREAT;
+        if (common->has_logappend &&
+            common->logappend) {
+            flags |=3D O_APPEND;
+        } else {
+            flags |=3D O_TRUNC;
+        }
+        chr->logfd =3D qemu_open(common->logfile, flags, 0666);
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
=20
-static Chardev *qemu_chr_open_null(const CharDriver *driver,
-                                   const char *id,
-                                   ChardevBackend *backend,
-                                   ChardevReturn *ret,
-                                   bool *be_opened,
-                                   Error **errp)
+static void char_init(Object *obj)
 {
-    Chardev *chr;
-    ChardevCommon *common =3D backend->u.null.data;
+    Chardev *chr =3D CHARDEV(obj);
=20
-    chr =3D qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        return NULL;
+    chr->logfd =3D -1;
+    qemu_mutex_init(&chr->chr_write_lock);
+}
+
+static void char_finalize(Object *obj)
+{
+    Chardev *chr =3D CHARDEV(obj);
+
+    if (chr->be) {
+        chr->be->chr =3D NULL;
+    }
+    g_free(chr->filename);
+    g_free(chr->label);
+    if (chr->logfd !=3D -1) {
+        close(chr->logfd);
     }
+    qemu_mutex_destroy(&chr->chr_write_lock);
+}
+
+static const TypeInfo char_type_info =3D {
+    .name =3D TYPE_CHARDEV,
+    .parent =3D TYPE_OBJECT,
+    .instance_size =3D sizeof(Chardev),
+    .instance_init =3D char_init,
+    .instance_finalize =3D char_finalize,
+    .abstract =3D true,
+    .class_size =3D sizeof(ChardevClass),
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
     *be_opened =3D false;
-    return chr;
 }
=20
 static const CharDriver null_driver =3D {
-    .instance_size =3D sizeof(Chardev),
     .kind =3D CHARDEV_BACKEND_KIND_NULL,
-    .create =3D qemu_chr_open_null,
-    .chr_write =3D null_chr_write,
+};
+
+static void char_null_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->open =3D null_chr_open;
+    cc->chr_write =3D null_chr_write;
+}
+
+static const TypeInfo char_null_type_info =3D {
+    .name =3D TYPE_CHARDEV_NULL,
+    .parent =3D TYPE_CHARDEV,
+    .instance_size =3D sizeof(Chardev),
+    .class_init =3D char_null_class_init,
 };
=20
 /* MUX driver for serial I/O splitting */
@@ -570,10 +604,12 @@ struct MuxChardev {
     int64_t timestamps_start;
 };
=20
+#define MUX_CHARDEV(obj) OBJECT_CHECK(MuxChardev, (obj), TYPE_CHARDEV_MU=
X)
+
 /* Called with chr_write_lock held.  */
 static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    MuxChardev *d =3D (MuxChardev *)chr;
+    MuxChardev *d =3D MUX_CHARDEV(chr);
     int ret;
     if (!d->timestamps) {
         ret =3D qemu_chr_fe_write(&d->chr, buf, len);
@@ -707,7 +743,7 @@ static int mux_proc_byte(Chardev *chr, MuxChardev *d,=
 int ch)
=20
 static void mux_chr_accept_input(Chardev *chr)
 {
-    MuxChardev *d =3D (MuxChardev *)chr;
+    MuxChardev *d =3D MUX_CHARDEV(chr);
     int m =3D d->focus;
     CharBackend *be =3D d->backends[m];
=20
@@ -720,7 +756,7 @@ static void mux_chr_accept_input(Chardev *chr)
=20
 static int mux_chr_can_read(void *opaque)
 {
-    MuxChardev *d =3D opaque;
+    MuxChardev *d =3D MUX_CHARDEV(opaque);
     int m =3D d->focus;
     CharBackend *be =3D d->backends[m];
=20
@@ -737,8 +773,8 @@ static int mux_chr_can_read(void *opaque)
=20
 static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
 {
-    Chardev *chr =3D opaque;
-    MuxChardev *d =3D opaque;
+    Chardev *chr =3D CHARDEV(opaque);
+    MuxChardev *d =3D MUX_CHARDEV(opaque);
     int m =3D d->focus;
     CharBackend *be =3D d->backends[m];
     int i;
@@ -760,7 +796,7 @@ static bool muxes_realized;
=20
 static void mux_chr_event(void *opaque, int event)
 {
-    MuxChardev *d =3D opaque;
+    MuxChardev *d =3D MUX_CHARDEV(opaque);
     int i;
=20
     if (!muxes_realized) {
@@ -789,8 +825,8 @@ static void muxes_realize_done(Notifier *notifier, vo=
id *unused)
     Chardev *chr;
=20
     QTAILQ_FOREACH(chr, &chardevs, next) {
-        if (qemu_chr_get_kind(chr) =3D=3D CHARDEV_BACKEND_KIND_MUX) {
-            MuxChardev *d =3D (MuxChardev *)chr;
+        if (CHARDEV_IS_MUX(chr)) {
+            MuxChardev *d =3D MUX_CHARDEV(chr);
             int i;
=20
             /* send OPENED to all already-attached FEs */
@@ -812,19 +848,20 @@ static Notifier muxes_realize_notify =3D {
=20
 static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
 {
-    MuxChardev *d =3D (MuxChardev *)s;
+    MuxChardev *d =3D MUX_CHARDEV(s);
     Chardev *chr =3D qemu_chr_fe_get_driver(&d->chr);
+    ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
=20
-    if (!chr->driver->chr_add_watch) {
+    if (!cc->chr_add_watch) {
         return NULL;
     }
=20
-    return chr->driver->chr_add_watch(chr, cond);
+    return cc->chr_add_watch(chr, cond);
 }
=20
 static void mux_chr_free(struct Chardev *chr)
 {
-    MuxChardev *d =3D (MuxChardev *)chr;
+    MuxChardev *d =3D MUX_CHARDEV(chr);
     int i;
=20
     for (i =3D 0; i < d->mux_cnt; i++) {
@@ -838,7 +875,7 @@ static void mux_chr_free(struct Chardev *chr)
=20
 static void mux_chr_set_handlers(Chardev *chr, GMainContext *context)
 {
-    MuxChardev *d =3D (MuxChardev *)chr;
+    MuxChardev *d =3D MUX_CHARDEV(chr);
=20
     /* Fix up the real driver with mux routines */
     qemu_chr_fe_set_handlers(&d->chr,
@@ -862,40 +899,27 @@ static void mux_set_focus(MuxChardev *d, int focus)
     mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
 }
=20
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
     ChardevMux *mux =3D backend->u.mux.data;
-    Chardev *chr, *drv;
-    MuxChardev *d;
-    ChardevCommon *common =3D qapi_ChardevMux_base(mux);
+    Chardev *drv;
+    MuxChardev *d =3D MUX_CHARDEV(chr);
=20
     drv =3D qemu_chr_find(mux->chardev);
     if (drv =3D=3D NULL) {
         error_setg(errp, "mux: base chardev %s not found", mux->chardev)=
;
-        return NULL;
+        return;
     }
=20
-    chr =3D qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        return NULL;
-    }
-    d =3D (MuxChardev *)chr;
     d->focus =3D -1;
     /* only default to opened state if we've realized the initial
      * set of muxes
      */
     *be_opened =3D muxes_realized;
-    if (!qemu_chr_fe_init(&d->chr, drv, errp)) {
-        qemu_chr_free(chr);
-        return NULL;
-    }
-
-    return chr;
+    qemu_chr_fe_init(&d->chr, drv, errp);
 }
=20
 Chardev *qemu_chr_fe_get_driver(CharBackend *be)
@@ -907,8 +931,8 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Err=
or **errp)
 {
     int tag =3D 0;
=20
-    if (qemu_chr_get_kind(s) =3D=3D CHARDEV_BACKEND_KIND_MUX) {
-        MuxChardev *d =3D (MuxChardev *)s;
+    if (CHARDEV_IS_MUX(s)) {
+        MuxChardev *d =3D MUX_CHARDEV(s);
=20
         if (d->mux_cnt >=3D MAX_MUX) {
             goto unavailable;
@@ -934,8 +958,8 @@ unavailable:
=20
 static bool qemu_chr_is_busy(Chardev *s)
 {
-    if (qemu_chr_get_kind(s) =3D=3D CHARDEV_BACKEND_KIND_MUX) {
-        MuxChardev *d =3D (MuxChardev *)s;
+    if (CHARDEV_IS_MUX(s)) {
+        MuxChardev *d =3D MUX_CHARDEV(s);
         return d->mux_cnt >=3D 0;
     } else {
         return s->be !=3D NULL;
@@ -949,8 +973,8 @@ void qemu_chr_fe_deinit(CharBackend *b)
     if (b->chr) {
         qemu_chr_fe_set_handlers(b, NULL, NULL, NULL, NULL, NULL, true);
         b->chr->be =3D NULL;
-        if (qemu_chr_get_kind(b->chr) =3D=3D CHARDEV_BACKEND_KIND_MUX) {
-            MuxChardev *d =3D (MuxChardev *)b->chr;
+        if (CHARDEV_IS_MUX(b->chr)) {
+            MuxChardev *d =3D MUX_CHARDEV(b->chr);
             d->backends[b->tag] =3D NULL;
         }
         b->chr =3D NULL;
@@ -966,6 +990,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
                               bool set_open)
 {
     Chardev *s;
+    ChardevClass *cc;
     int fe_open;
=20
     s =3D b->chr;
@@ -973,6 +998,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
         return;
     }
=20
+    cc =3D CHARDEV_GET_CLASS(s);
     if (!opaque && !fd_can_read && !fd_read && !fd_event) {
         fe_open =3D 0;
         remove_fd_in_watch(s);
@@ -983,8 +1009,8 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
     b->chr_read =3D fd_read;
     b->chr_event =3D fd_event;
     b->opaque =3D opaque;
-    if (s->driver->chr_update_read_handler) {
-        s->driver->chr_update_read_handler(s, context);
+    if (cc->chr_update_read_handler) {
+        cc->chr_update_read_handler(s, context);
     }
=20
     if (set_open) {
@@ -1000,7 +1026,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
         }
     }
=20
-    if (qemu_chr_get_kind(s) =3D=3D CHARDEV_BACKEND_KIND_MUX) {
+    if (CHARDEV_IS_MUX(s)) {
         mux_chr_set_handlers(s, context);
     }
 }
@@ -1011,8 +1037,8 @@ void qemu_chr_fe_take_focus(CharBackend *b)
         return;
     }
=20
-    if (qemu_chr_get_kind(b->chr) =3D=3D CHARDEV_BACKEND_KIND_MUX) {
-        mux_set_focus((MuxChardev *)b->chr, b->tag);
+    if (CHARDEV_IS_MUX(b->chr)) {
+        mux_set_focus(MUX_CHARDEV(b->chr), b->tag);
     }
 }
=20
@@ -1188,7 +1214,6 @@ static int io_channel_send(QIOChannel *ioc, const v=
oid *buf, size_t len)
     return io_channel_send_full(ioc, buf, len, NULL, 0);
 }
=20
-
 typedef struct FDChardev {
     Chardev parent;
     Chardev *chr;
@@ -1196,18 +1221,21 @@ typedef struct FDChardev {
     int max_size;
 } FDChardev;
=20
+#define TYPE_CHARDEV_FD "chardev-fd"
+#define FD_CHARDEV(obj) OBJECT_CHECK(FDChardev, (obj), TYPE_CHARDEV_FD)
+
 /* Called with chr_write_lock held.  */
 static int fd_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    FDChardev *s =3D (FDChardev *)chr;
+    FDChardev *s =3D FD_CHARDEV(chr);
=20
     return io_channel_send(s->ioc_out, buf, len);
 }
=20
 static gboolean fd_chr_read(QIOChannel *chan, GIOCondition cond, void *o=
paque)
 {
-    Chardev *chr =3D opaque;
-    FDChardev *s =3D opaque;
+    Chardev *chr =3D CHARDEV(opaque);
+    FDChardev *s =3D FD_CHARDEV(opaque);
     int len;
     uint8_t buf[READ_BUF_LEN];
     ssize_t ret;
@@ -1236,8 +1264,8 @@ static gboolean fd_chr_read(QIOChannel *chan, GIOCo=
ndition cond, void *opaque)
=20
 static int fd_chr_read_poll(void *opaque)
 {
-    Chardev *chr =3D opaque;
-    FDChardev *s =3D opaque;
+    Chardev *chr =3D CHARDEV(opaque);
+    FDChardev *s =3D FD_CHARDEV(opaque);
=20
     s->max_size =3D qemu_chr_be_can_write(chr);
     return s->max_size;
@@ -1245,14 +1273,14 @@ static int fd_chr_read_poll(void *opaque)
=20
 static GSource *fd_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    FDChardev *s =3D (FDChardev *)chr;
+    FDChardev *s =3D FD_CHARDEV(chr);
     return qio_channel_create_watch(s->ioc_out, cond);
 }
=20
 static void fd_chr_update_read_handler(Chardev *chr,
                                        GMainContext *context)
 {
-    FDChardev *s =3D (FDChardev *)chr;
+    FDChardev *s =3D FD_CHARDEV(chr);
=20
     remove_fd_in_watch(chr);
     if (s->ioc_in) {
@@ -1265,7 +1293,7 @@ static void fd_chr_update_read_handler(Chardev *chr=
,
=20
 static void fd_chr_free(struct Chardev *chr)
 {
-    FDChardev *s =3D (FDChardev *)chr;
+    FDChardev *s =3D FD_CHARDEV(chr);
=20
     remove_fd_in_watch(chr);
     if (s->ioc_in) {
@@ -1279,19 +1307,12 @@ static void fd_chr_free(struct Chardev *chr)
 }
=20
 /* open a character device to a unix fd */
-static Chardev *qemu_chr_open_fd(const CharDriver *driver,
-                                 int fd_in, int fd_out,
-                                 ChardevCommon *backend, Error **errp)
+static void qemu_chr_open_fd(Chardev *chr,
+                             int fd_in, int fd_out)
 {
-    Chardev *chr;
-    FDChardev *s;
+    FDChardev *s =3D FD_CHARDEV(chr);
     char *name;
=20
-    chr =3D qemu_chr_alloc(driver, backend, errp);
-    if (!chr) {
-        return NULL;
-    }
-    s =3D (FDChardev *)chr;
     s->ioc_in =3D QIO_CHANNEL(qio_channel_file_new_fd(fd_in));
     name =3D g_strdup_printf("chardev-file-in-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(s->ioc_in), name);
@@ -1302,24 +1323,36 @@ static Chardev *qemu_chr_open_fd(const CharDriver=
 *driver,
     g_free(name);
     qemu_set_nonblock(fd_out);
     s->chr =3D chr;
+}
=20
-    return chr;
+static void char_fd_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->chr_add_watch =3D fd_chr_add_watch;
+    cc->chr_write =3D fd_chr_write;
+    cc->chr_update_read_handler =3D fd_chr_update_read_handler;
+    cc->chr_free =3D fd_chr_free;
 }
=20
-static Chardev *qemu_chr_open_pipe(const CharDriver *driver,
-                                   const char *id,
-                                   ChardevBackend *backend,
-                                   ChardevReturn *ret,
-                                   bool *be_opened,
-                                   Error **errp)
+static const TypeInfo char_fd_type_info =3D {
+    .name =3D TYPE_CHARDEV_FD,
+    .parent =3D TYPE_CHARDEV,
+    .instance_size =3D sizeof(FDChardev),
+    .class_init =3D char_fd_class_init,
+    .abstract =3D true,
+};
+
+static void qemu_chr_open_pipe(Chardev *chr,
+                               ChardevBackend *backend,
+                               bool *be_opened,
+                               Error **errp)
 {
     ChardevHostdev *opts =3D backend->u.pipe.data;
     int fd_in, fd_out;
     char *filename_in;
     char *filename_out;
     const char *filename =3D opts->device;
-    ChardevCommon *common =3D qapi_ChardevHostdev_base(opts);
-
=20
     filename_in =3D g_strdup_printf("%s.in", filename);
     filename_out =3D g_strdup_printf("%s.out", filename);
@@ -1335,10 +1368,10 @@ static Chardev *qemu_chr_open_pipe(const CharDriv=
er *driver,
         TFR(fd_in =3D fd_out =3D qemu_open(filename, O_RDWR | O_BINARY))=
;
         if (fd_in < 0) {
             error_setg_file_open(errp, errno, filename);
-            return NULL;
+            return;
         }
     }
-    return qemu_chr_open_fd(driver, fd_in, fd_out, common, errp);
+    qemu_chr_open_fd(chr, fd_in, fd_out);
 }
=20
 /* init terminal so that we can grab keys */
@@ -1390,26 +1423,22 @@ static void qemu_chr_free_stdio(struct Chardev *c=
hr)
     fd_chr_free(chr);
 }
=20
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
     ChardevStdio *opts =3D backend->u.stdio.data;
-    Chardev *chr;
     struct sigaction act;
-    ChardevCommon *common =3D qapi_ChardevStdio_base(opts);
=20
     if (is_daemonized()) {
         error_setg(errp, "cannot use stdio with -daemonize");
-        return NULL;
+        return;
     }
=20
     if (stdio_in_use) {
         error_setg(errp, "cannot use stdio by multiple character devices=
");
-        return NULL;
+        return;
     }
=20
     stdio_in_use =3D true;
@@ -1422,16 +1451,12 @@ static Chardev *qemu_chr_open_stdio(const CharDri=
ver *driver,
     act.sa_handler =3D term_stdio_handler;
     sigaction(SIGCONT, &act, NULL);
=20
-    chr =3D qemu_chr_open_fd(driver, 0, 1, common, errp);
-    if (!chr) {
-        return NULL;
-    }
+    qemu_chr_open_fd(chr, 0, 1);
+
     if (opts->has_signal) {
         stdio_allow_signal =3D opts->signal;
     }
     qemu_chr_set_echo_stdio(chr, false);
-
-    return chr;
 }
=20
 #if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__) \
@@ -1452,13 +1477,15 @@ typedef struct {
     guint open_tag;
 } PtyChardev;
=20
+#define PTY_CHARDEV(obj) OBJECT_CHECK(PtyChardev, (obj), TYPE_CHARDEV_PT=
Y)
+
 static void pty_chr_update_read_handler_locked(Chardev *chr);
 static void pty_chr_state(Chardev *chr, int connected);
=20
 static gboolean pty_chr_timer(gpointer opaque)
 {
-    struct Chardev *chr =3D opaque;
-    PtyChardev *s =3D opaque;
+    struct Chardev *chr =3D CHARDEV(opaque);
+    PtyChardev *s =3D PTY_CHARDEV(opaque);
=20
     qemu_mutex_lock(&chr->chr_write_lock);
     s->timer_tag =3D 0;
@@ -1474,7 +1501,7 @@ static gboolean pty_chr_timer(gpointer opaque)
 /* Called with chr_write_lock held.  */
 static void pty_chr_rearm_timer(Chardev *chr, int ms)
 {
-    PtyChardev *s =3D (PtyChardev *)chr;
+    PtyChardev *s =3D PTY_CHARDEV(chr);
     char *name;
=20
     if (s->timer_tag) {
@@ -1496,7 +1523,7 @@ static void pty_chr_rearm_timer(Chardev *chr, int m=
s)
 /* Called with chr_write_lock held.  */
 static void pty_chr_update_read_handler_locked(Chardev *chr)
 {
-    PtyChardev *s =3D (PtyChardev *)chr;
+    PtyChardev *s =3D PTY_CHARDEV(chr);
     GPollFD pfd;
     int rc;
     QIOChannelFile *fioc =3D QIO_CHANNEL_FILE(s->ioc);
@@ -1525,9 +1552,9 @@ static void pty_chr_update_read_handler(Chardev *ch=
r,
 }
=20
 /* Called with chr_write_lock held.  */
-static int pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
+static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    PtyChardev *s =3D (PtyChardev *)chr;
+    PtyChardev *s =3D PTY_CHARDEV(chr);
=20
     if (!s->connected) {
         /* guest sends data, check for (re-)connect */
@@ -1541,7 +1568,7 @@ static int pty_chr_write(Chardev *chr, const uint8_=
t *buf, int len)
=20
 static GSource *pty_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    PtyChardev *s =3D (PtyChardev *)chr;
+    PtyChardev *s =3D PTY_CHARDEV(chr);
     if (!s->connected) {
         return NULL;
     }
@@ -1550,8 +1577,8 @@ static GSource *pty_chr_add_watch(Chardev *chr, GIO=
Condition cond)
=20
 static int pty_chr_read_poll(void *opaque)
 {
-    Chardev *chr =3D opaque;
-    PtyChardev *s =3D opaque;
+    Chardev *chr =3D CHARDEV(opaque);
+    PtyChardev *s =3D PTY_CHARDEV(opaque);
=20
     s->read_bytes =3D qemu_chr_be_can_write(chr);
     return s->read_bytes;
@@ -1559,8 +1586,8 @@ static int pty_chr_read_poll(void *opaque)
=20
 static gboolean pty_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
 {
-    Chardev *chr =3D opaque;
-    PtyChardev *s =3D opaque;
+    Chardev *chr =3D CHARDEV(opaque);
+    PtyChardev *s =3D PTY_CHARDEV(opaque);
     gsize len;
     uint8_t buf[READ_BUF_LEN];
     ssize_t ret;
@@ -1584,8 +1611,8 @@ static gboolean pty_chr_read(QIOChannel *chan, GIOC=
ondition cond, void *opaque)
=20
 static gboolean qemu_chr_be_generic_open_func(gpointer opaque)
 {
-    Chardev *chr =3D opaque;
-    PtyChardev *s =3D opaque;
+    Chardev *chr =3D CHARDEV(opaque);
+    PtyChardev *s =3D PTY_CHARDEV(opaque);
=20
     s->open_tag =3D 0;
     qemu_chr_be_generic_open(chr);
@@ -1595,7 +1622,7 @@ static gboolean qemu_chr_be_generic_open_func(gpoin=
ter opaque)
 /* Called with chr_write_lock held.  */
 static void pty_chr_state(Chardev *chr, int connected)
 {
-    PtyChardev *s =3D (PtyChardev *)chr;
+    PtyChardev *s =3D PTY_CHARDEV(chr);
=20
     if (!connected) {
         if (s->open_tag) {
@@ -1629,7 +1656,7 @@ static void pty_chr_state(Chardev *chr, int connect=
ed)
=20
 static void pty_chr_free(struct Chardev *chr)
 {
-    PtyChardev *s =3D (PtyChardev *)chr;
+    PtyChardev *s =3D PTY_CHARDEV(chr);
=20
     qemu_mutex_lock(&chr->chr_write_lock);
     pty_chr_state(chr, 0);
@@ -1642,61 +1669,58 @@ static void pty_chr_free(struct Chardev *chr)
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
=20
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
-    ChardevCommon *common =3D backend->u.pty.data;
     char *name;
=20
     master_fd =3D qemu_openpty_raw(&slave_fd, pty_name);
     if (master_fd < 0) {
         error_setg_errno(errp, errno, "Failed to create PTY");
-        return NULL;
+        return;
     }
=20
     close(slave_fd);
     qemu_set_nonblock(master_fd);
=20
-    chr =3D qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        close(master_fd);
-        return NULL;
-    }
-
     chr->filename =3D g_strdup_printf("pty:%s", pty_name);
-    ret->pty =3D g_strdup(pty_name);
-    ret->has_pty =3D true;
-
     error_report("char device redirected to %s (label %s)",
-                 pty_name, id);
+                 pty_name, chr->label);
=20
-    s =3D (PtyChardev *)chr;
+    s =3D PTY_CHARDEV(chr);
     s->ioc =3D QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
     name =3D g_strdup_printf("chardev-pty-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(s->ioc), name);
     g_free(name);
     s->timer_tag =3D 0;
     *be_opened =3D false;
-
-    return chr;
 }
=20
 static const CharDriver pty_driver =3D {
-    .instance_size =3D sizeof(PtyChardev),
     .kind =3D CHARDEV_BACKEND_KIND_PTY,
-    .create =3D qemu_chr_open_pty,
-    .chr_write =3D pty_chr_write,
-    .chr_update_read_handler =3D pty_chr_update_read_handler,
-    .chr_add_watch =3D pty_chr_add_watch,
-    .chr_free =3D pty_chr_free,
+};
+
+static void char_pty_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->open =3D char_pty_open;
+    cc->chr_write =3D char_pty_chr_write;
+    cc->chr_update_read_handler =3D pty_chr_update_read_handler;
+    cc->chr_add_watch =3D pty_chr_add_watch;
+    cc->chr_free =3D pty_chr_free;
+}
+
+static const TypeInfo char_pty_type_info =3D {
+    .name =3D TYPE_CHARDEV_PTY,
+    .parent =3D TYPE_CHARDEV,
+    .instance_size =3D sizeof(PtyChardev),
+    .class_init =3D char_pty_class_init,
 };
=20
 static void tty_serial_init(int fd, int speed,
@@ -1816,7 +1840,7 @@ static void tty_serial_init(int fd, int speed,
=20
 static int tty_serial_ioctl(Chardev *chr, int cmd, void *arg)
 {
-    FDChardev *s =3D (FDChardev *)chr;
+    FDChardev *s =3D FD_CHARDEV(chr);
     QIOChannelFile *fioc =3D QIO_CHANNEL_FILE(s->ioc_in);
=20
     switch(cmd) {
@@ -1900,6 +1924,9 @@ typedef struct {
     int mode;
 } ParallelChardev;
=20
+#define PARALLEL_CHARDEV(obj) \
+    OBJECT_CHECK(ParallelChardev, (obj), TYPE_CHARDEV_PARALLEL)
+
 static int pp_hw_mode(ParallelChardev *s, uint16_t mode)
 {
     if (s->mode !=3D mode) {
@@ -1913,7 +1940,7 @@ static int pp_hw_mode(ParallelChardev *s, uint16_t =
mode)
=20
 static int pp_ioctl(Chardev *chr, int cmd, void *arg)
 {
-    ParallelChardev *drv =3D (ParallelChardev *)chr;
+    ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
     int fd =3D drv->fd;
     uint8_t b;
=20
@@ -1994,7 +2021,7 @@ static int pp_ioctl(Chardev *chr, int cmd, void *ar=
g)
=20
 static void pp_free(Chardev *chr)
 {
-    ParallelChardev *drv =3D (ParallelChardev *)chr;
+    ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
     int fd =3D drv->fd;
=20
     pp_hw_mode(drv, IEEE1284_MODE_COMPAT);
@@ -2003,31 +2030,21 @@ static void pp_free(Chardev *chr)
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
=20
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
+    ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
=20
     if (ioctl(fd, PPCLAIM) < 0) {
         error_setg_errno(errp, errno, "not a parallel port");
         close(fd);
-        return NULL;
-    }
-
-    chr =3D qemu_chr_alloc(driver, backend, errp);
-    if (!chr) {
-        return NULL;
+        return;
     }
=20
-    drv =3D (ParallelChardev *)chr;
     drv->fd =3D fd;
     drv->mode =3D IEEE1284_MODE_COMPAT;
-
-    return chr;
 }
 #endif /* __linux__ */
=20
@@ -2040,9 +2057,12 @@ typedef struct {
     int fd;
 } ParallelChardev;
=20
+#define PARALLEL_CHARDEV(obj)                                   \
+    OBJECT_CHECK(ParallelChardev, (obj), TYPE_CHARDEV_PARALLEL)
+
 static int pp_ioctl(Chardev *chr, int cmd, void *arg)
 {
-    ParallelChardev *drv =3D (ParallelChardev *)chr;
+    ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
     uint8_t b;
=20
     switch (cmd) {
@@ -2082,23 +2102,14 @@ static int pp_ioctl(Chardev *chr, int cmd, void *=
arg)
     return 0;
 }
=20
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
-    chr =3D qemu_chr_alloc(driver, backend, errp);
-    if (!chr) {
-        return NULL;
-    }
-    drv =3D (ParallelChardev *)chr;
+    ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
     drv->fd =3D fd;
     *be_opened =3D false;
-    return chr;
 }
 #endif
=20
@@ -2118,6 +2129,9 @@ typedef struct {
     OVERLAPPED osend;
 } WinChardev;
=20
+#define TYPE_CHARDEV_WIN "chardev-win"
+#define WIN_CHARDEV(obj) OBJECT_CHECK(WinChardev, (obj), TYPE_CHARDEV_WI=
N)
+
 typedef struct {
     Chardev parent;
     HANDLE  hStdIn;
@@ -2127,6 +2141,10 @@ typedef struct {
     uint8_t win_stdio_buf;
 } WinStdioChardev;
=20
+#define TYPE_CHARDEV_WIN_STDIO "chardev-win-stdio"
+#define WIN_STDIO_CHARDEV(obj)                                  \
+    OBJECT_CHECK(WinStdioChardev, (obj), TYPE_CHARDEV_WIN_STDIO)
+
 #define NSENDBUF 2048
 #define NRECVBUF 2048
 #define MAXCONNECT 1
@@ -2137,7 +2155,7 @@ static int win_chr_pipe_poll(void *opaque);
=20
 static void win_chr_free(Chardev *chr)
 {
-    WinChardev *s =3D (WinChardev *)chr;
+    WinChardev *s =3D WIN_CHARDEV(chr);
=20
     if (s->hsend) {
         CloseHandle(s->hsend);
@@ -2161,7 +2179,7 @@ static void win_chr_free(Chardev *chr)
=20
 static int win_chr_init(Chardev *chr, const char *filename, Error **errp=
)
 {
-    WinChardev *s =3D (WinChardev *)chr;
+    WinChardev *s =3D WIN_CHARDEV(chr);
     COMMCONFIG comcfg;
     COMMTIMEOUTS cto =3D { 0, 0, 0, 0, 0};
     COMSTAT comstat;
@@ -2229,7 +2247,7 @@ static int win_chr_init(Chardev *chr, const char *f=
ilename, Error **errp)
 /* Called with chr_write_lock held.  */
 static int win_chr_write(Chardev *chr, const uint8_t *buf, int len1)
 {
-    WinChardev *s =3D (WinChardev *)chr;
+    WinChardev *s =3D WIN_CHARDEV(chr);
     DWORD len, ret, size, err;
=20
     len =3D len1;
@@ -2263,7 +2281,7 @@ static int win_chr_write(Chardev *chr, const uint8_=
t *buf, int len1)
=20
 static int win_chr_read_poll(Chardev *chr)
 {
-    WinChardev *s =3D (WinChardev *)chr;
+    WinChardev *s =3D WIN_CHARDEV(chr);
=20
     s->max_size =3D qemu_chr_be_can_write(chr);
     return s->max_size;
@@ -2271,7 +2289,8 @@ static int win_chr_read_poll(Chardev *chr)
=20
 static void win_chr_readfile(Chardev *chr)
 {
-    WinChardev *s =3D (WinChardev *)chr;
+    WinChardev *s =3D WIN_CHARDEV(chr);
+
     int ret, err;
     uint8_t buf[READ_BUF_LEN];
     DWORD size;
@@ -2293,7 +2312,7 @@ static void win_chr_readfile(Chardev *chr)
=20
 static void win_chr_read(Chardev *chr)
 {
-    WinChardev *s =3D (WinChardev *)chr;
+    WinChardev *s =3D WIN_CHARDEV(chr);
=20
     if (s->len > s->max_size)
         s->len =3D s->max_size;
@@ -2305,8 +2324,8 @@ static void win_chr_read(Chardev *chr)
=20
 static int win_chr_poll(void *opaque)
 {
-    Chardev *chr =3D opaque;
-    WinChardev *s =3D opaque;
+    Chardev *chr =3D CHARDEV(opaque);
+    WinChardev *s =3D WIN_CHARDEV(opaque);
     COMSTAT status;
     DWORD comerr;
=20
@@ -2322,8 +2341,8 @@ static int win_chr_poll(void *opaque)
=20
 static int win_chr_pipe_poll(void *opaque)
 {
-    Chardev *chr =3D opaque;
-    WinChardev *s =3D opaque;
+    Chardev *chr =3D CHARDEV(opaque);
+    WinChardev *s =3D WIN_CHARDEV(opaque);
     DWORD size;
=20
     PeekNamedPipe(s->hcom, NULL, 0, NULL, &size, NULL);
@@ -2339,7 +2358,7 @@ static int win_chr_pipe_poll(void *opaque)
 static int win_chr_pipe_init(Chardev *chr, const char *filename,
                              Error **errp)
 {
-    WinChardev *s =3D (WinChardev *)chr;
+    WinChardev *s =3D WIN_CHARDEV(chr);
     OVERLAPPED ov;
     int ret;
     DWORD size;
@@ -2401,65 +2420,66 @@ static int win_chr_pipe_init(Chardev *chr, const =
char *filename,
 }
=20
=20
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
     ChardevHostdev *opts =3D backend->u.pipe.data;
     const char *filename =3D opts->device;
-    Chardev *chr;
-    ChardevCommon *common =3D qapi_ChardevHostdev_base(opts);
-
-    chr =3D qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        return NULL;
-    }
=20
     if (win_chr_pipe_init(chr, filename, errp) < 0) {
-        qemu_chr_free_common(chr);
-        return NULL;
+        return;
     }
-    return chr;
 }
=20
-static Chardev *qemu_chr_open_win_file(const CharDriver *driver,
-                                       HANDLE fd_out,
-                                       ChardevCommon *backend,
-                                       Error **errp)
+static void qemu_chr_open_win_file(Chardev *chr, HANDLE fd_out)
 {
-    Chardev *chr;
-    WinChardev *s;
+    WinChardev *s =3D WIN_CHARDEV(chr);
=20
-    chr =3D qemu_chr_alloc(driver, backend, errp);
-    if (!chr) {
-        return NULL;
-    }
-    s =3D (WinChardev *)chr;
     s->hcom =3D fd_out;
-    return chr;
 }
=20
-static Chardev *qemu_chr_open_win_con(const CharDriver *driver,
-                                      const char *id,
-                                      ChardevBackend *backend,
-                                      ChardevReturn *ret,
-                                      bool *be_opened,
-                                      Error **errp)
+static void char_win_class_init(ObjectClass *oc, void *data)
 {
-    ChardevCommon *common =3D backend->u.console.data;
-    return qemu_chr_open_win_file(driver,
-                                  GetStdHandle(STD_OUTPUT_HANDLE),
-                                  common, errp);
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->chr_write =3D win_chr_write;
+    cc->chr_free =3D win_chr_free;
 }
=20
-static const CharDriver console_driver =3D {
+static const TypeInfo char_win_type_info =3D {
+    .name =3D TYPE_CHARDEV_WIN,
+    .parent =3D TYPE_CHARDEV,
     .instance_size =3D sizeof(WinChardev),
+    .class_init =3D char_win_class_init,
+    .abstract =3D true,
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
+static const CharDriver console_driver =3D {
     .kind =3D CHARDEV_BACKEND_KIND_CONSOLE,
-    .create =3D qemu_chr_open_win_con,
-    .chr_write =3D win_chr_write,
+};
+
+static void char_console_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->open =3D qemu_chr_open_win_con;
+    cc->chr_free =3D NULL;
+}
+
+static const TypeInfo char_console_type_info =3D {
+    .name =3D TYPE_CHARDEV_CONSOLE,
+    .parent =3D TYPE_CHARDEV_WIN,
+    .class_init =3D char_console_class_init,
 };
=20
 static int win_stdio_write(Chardev *chr, const uint8_t *buf, int len)
@@ -2483,8 +2503,8 @@ static int win_stdio_write(Chardev *chr, const uint=
8_t *buf, int len)
=20
 static void win_stdio_wait_func(void *opaque)
 {
-    Chardev   *chr   =3D opaque;
-    WinStdioChardev *stdio =3D opaque;
+    Chardev *chr =3D CHARDEV(opaque);
+    WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(opaque);
     INPUT_RECORD       buf[4];
     int                ret;
     DWORD              dwSize;
@@ -2517,7 +2537,7 @@ static void win_stdio_wait_func(void *opaque)
=20
 static DWORD WINAPI win_stdio_thread(LPVOID param)
 {
-    WinStdioChardev *stdio =3D param;
+    WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(param);
     int                ret;
     DWORD              dwSize;
=20
@@ -2555,8 +2575,8 @@ static DWORD WINAPI win_stdio_thread(LPVOID param)
=20
 static void win_stdio_thread_wait_func(void *opaque)
 {
-    Chardev   *chr   =3D opaque;
-    WinStdioChardev *stdio =3D opaque;
+    Chardev *chr =3D CHARDEV(opaque);
+    WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(opaque);
=20
     if (qemu_chr_be_can_write(chr)) {
         qemu_chr_be_write(chr, &stdio->win_stdio_buf, 1);
@@ -2567,7 +2587,7 @@ static void win_stdio_thread_wait_func(void *opaque=
)
=20
 static void qemu_chr_set_echo_win_stdio(Chardev *chr, bool echo)
 {
-    WinStdioChardev *stdio  =3D (WinStdioChardev *)chr;
+    WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(chr);
     DWORD              dwMode =3D 0;
=20
     GetConsoleMode(stdio->hStdIn, &dwMode);
@@ -2581,7 +2601,7 @@ static void qemu_chr_set_echo_win_stdio(Chardev *ch=
r, bool echo)
=20
 static void win_stdio_free(Chardev *chr)
 {
-    WinStdioChardev *stdio =3D (WinStdioChardev *)chr;
+    WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(chr);
=20
     if (stdio->hInputReadyEvent !=3D INVALID_HANDLE_VALUE) {
         CloseHandle(stdio->hInputReadyEvent);
@@ -2594,29 +2614,26 @@ static void win_stdio_free(Chardev *chr)
     }
 }
=20
-static Chardev *qemu_chr_open_stdio(const CharDriver *driver,
-                                    const char *id,
-                                    ChardevBackend *backend,
-                                    ChardevReturn *ret,
-                                    bool *be_opened,
-                                    Error **errp)
+static const TypeInfo char_win_stdio_type_info =3D {
+    .name =3D TYPE_CHARDEV_WIN_STDIO,
+    .parent =3D TYPE_CHARDEV,
+    .instance_size =3D sizeof(WinStdioChardev),
+    .abstract =3D true,
+};
+
+static void qemu_chr_open_stdio(Chardev *chr,
+                                ChardevBackend *backend,
+                                bool *be_opened,
+                                Error **errp)
 {
-    Chardev   *chr;
-    WinStdioChardev *stdio;
+    WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(chr);
     DWORD              dwMode;
     int                is_console =3D 0;
-    ChardevCommon *common =3D qapi_ChardevStdio_base(backend->u.stdio.da=
ta);
-
-    chr   =3D qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        return NULL;
-    }
-    stdio =3D (WinStdioChardev *)chr;
=20
     stdio->hStdIn =3D GetStdHandle(STD_INPUT_HANDLE);
     if (stdio->hStdIn =3D=3D INVALID_HANDLE_VALUE) {
         error_setg(errp, "cannot open stdio: invalid handle");
-        return NULL;
+        return;
     }
=20
     is_console =3D GetConsoleMode(stdio->hStdIn, &dwMode) !=3D 0;
@@ -2663,7 +2680,7 @@ static Chardev *qemu_chr_open_stdio(const CharDrive=
r *driver,
=20
     qemu_chr_set_echo_win_stdio(chr, false);
=20
-    return chr;
+    return;
=20
 err3:
     qemu_del_wait_object(stdio->hInputReadyEvent, NULL, NULL);
@@ -2672,7 +2689,6 @@ err2:
     CloseHandle(stdio->hInputDoneEvent);
 err1:
     qemu_del_wait_object(stdio->hStdIn, NULL, NULL);
-    return NULL;
 }
 #endif /* !_WIN32 */
=20
@@ -2688,10 +2704,12 @@ typedef struct {
     int max_size;
 } UdpChardev;
=20
+#define UDP_CHARDEV(obj) OBJECT_CHECK(UdpChardev, (obj), TYPE_CHARDEV_UD=
P)
+
 /* Called with chr_write_lock held.  */
 static int udp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    UdpChardev *s =3D (UdpChardev *)chr;
+    UdpChardev *s =3D UDP_CHARDEV(chr);
=20
     return qio_channel_write(
         s->ioc, (const char *)buf, len, NULL);
@@ -2699,8 +2717,8 @@ static int udp_chr_write(Chardev *chr, const uint8_=
t *buf, int len)
=20
 static int udp_chr_read_poll(void *opaque)
 {
-    Chardev *chr =3D opaque;
-    UdpChardev *s =3D opaque;
+    Chardev *chr =3D CHARDEV(opaque);
+    UdpChardev *s =3D UDP_CHARDEV(opaque);
=20
     s->max_size =3D qemu_chr_be_can_write(chr);
=20
@@ -2717,8 +2735,8 @@ static int udp_chr_read_poll(void *opaque)
=20
 static gboolean udp_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
 {
-    Chardev *chr =3D opaque;
-    UdpChardev *s =3D opaque;
+    Chardev *chr =3D CHARDEV(opaque);
+    UdpChardev *s =3D UDP_CHARDEV(opaque);
     ssize_t ret;
=20
     if (s->max_size =3D=3D 0) {
@@ -2745,7 +2763,7 @@ static gboolean udp_chr_read(QIOChannel *chan, GIOC=
ondition cond, void *opaque)
 static void udp_chr_update_read_handler(Chardev *chr,
                                         GMainContext *context)
 {
-    UdpChardev *s =3D (UdpChardev *)chr;
+    UdpChardev *s =3D UDP_CHARDEV(chr);
=20
     remove_fd_in_watch(chr);
     if (s->ioc) {
@@ -2758,7 +2776,7 @@ static void udp_chr_update_read_handler(Chardev *ch=
r,
=20
 static void udp_chr_free(Chardev *chr)
 {
-    UdpChardev *s =3D (UdpChardev *)chr;
+    UdpChardev *s =3D UDP_CHARDEV(chr);
=20
     remove_fd_in_watch(chr);
     if (s->ioc) {
@@ -2796,11 +2814,14 @@ typedef struct {
     bool connect_err_reported;
 } SocketChardev;
=20
+#define SOCKET_CHARDEV(obj)                                     \
+    OBJECT_CHECK(SocketChardev, (obj), TYPE_CHARDEV_SOCKET)
+
 static gboolean socket_reconnect_timeout(gpointer opaque);
=20
 static void qemu_chr_socket_restart_timer(Chardev *chr)
 {
-    SocketChardev *s =3D (SocketChardev *)chr;
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
     char *name;
=20
     assert(s->connected =3D=3D 0);
@@ -2814,7 +2835,7 @@ static void qemu_chr_socket_restart_timer(Chardev *=
chr)
 static void check_report_connect_error(Chardev *chr,
                                        Error *err)
 {
-    SocketChardev *s =3D (SocketChardev *)chr;
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
=20
     if (!s->connect_err_reported) {
         error_report("Unable to connect character device %s: %s",
@@ -2831,7 +2852,7 @@ static gboolean tcp_chr_accept(QIOChannel *chan,
 /* Called with chr_write_lock held.  */
 static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    SocketChardev *s =3D (SocketChardev *)chr;
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
=20
     if (s->connected) {
         int ret =3D  io_channel_send_full(s->ioc, buf, len,
@@ -2854,8 +2875,8 @@ static int tcp_chr_write(Chardev *chr, const uint8_=
t *buf, int len)
=20
 static int tcp_chr_read_poll(void *opaque)
 {
-    Chardev *chr =3D opaque;
-    SocketChardev *s =3D opaque;
+    Chardev *chr =3D CHARDEV(opaque);
+    SocketChardev *s =3D SOCKET_CHARDEV(opaque);
     if (!s->connected)
         return 0;
     s->max_size =3D qemu_chr_be_can_write(chr);
@@ -2914,7 +2935,7 @@ static void tcp_chr_process_IAC_bytes(Chardev *chr,
=20
 static int tcp_get_msgfds(Chardev *chr, int *fds, int num)
 {
-    SocketChardev *s =3D (SocketChardev *)chr;
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
=20
     int to_copy =3D (s->read_msgfds_num < num) ? s->read_msgfds_num : nu=
m;
=20
@@ -2940,7 +2961,7 @@ static int tcp_get_msgfds(Chardev *chr, int *fds, i=
nt num)
=20
 static int tcp_set_msgfds(Chardev *chr, int *fds, int num)
 {
-    SocketChardev *s =3D (SocketChardev *)chr;
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
=20
     /* clear old pending fd array */
     g_free(s->write_msgfds);
@@ -2965,7 +2986,7 @@ static int tcp_set_msgfds(Chardev *chr, int *fds, i=
nt num)
=20
 static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
 {
-    SocketChardev *s =3D (SocketChardev *)chr;
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
     struct iovec iov =3D { .iov_base =3D buf, .iov_len =3D len };
     int ret;
     size_t i;
@@ -3022,13 +3043,13 @@ static ssize_t tcp_chr_recv(Chardev *chr, char *b=
uf, size_t len)
=20
 static GSource *tcp_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    SocketChardev *s =3D (SocketChardev *)chr;
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
     return qio_channel_create_watch(s->ioc, cond);
 }
=20
 static void tcp_chr_free_connection(Chardev *chr)
 {
-    SocketChardev *s =3D (SocketChardev *)chr;
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
     int i;
=20
     if (!s->connected) {
@@ -3057,7 +3078,7 @@ static void tcp_chr_free_connection(Chardev *chr)
=20
 static void tcp_chr_disconnect(Chardev *chr)
 {
-    SocketChardev *s =3D (SocketChardev *)chr;
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
=20
     if (!s->connected) {
         return;
@@ -3079,8 +3100,8 @@ static void tcp_chr_disconnect(Chardev *chr)
=20
 static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
 {
-    Chardev *chr =3D opaque;
-    SocketChardev *s =3D opaque;
+    Chardev *chr =3D CHARDEV(opaque);
+    SocketChardev *s =3D SOCKET_CHARDEV(opaque);
     uint8_t buf[READ_BUF_LEN];
     int len, size;
=20
@@ -3106,7 +3127,7 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOC=
ondition cond, void *opaque)
=20
 static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
 {
-    SocketChardev *s =3D (SocketChardev *)chr;
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
     int size;
=20
     if (!s->connected) {
@@ -3124,8 +3145,8 @@ static int tcp_chr_sync_read(Chardev *chr, const ui=
nt8_t *buf, int len)
=20
 static void tcp_chr_connect(void *opaque)
 {
-    Chardev *chr =3D opaque;
-    SocketChardev *s =3D opaque;
+    Chardev *chr =3D CHARDEV(opaque);
+    SocketChardev *s =3D SOCKET_CHARDEV(opaque);
=20
     g_free(chr->filename);
     chr->filename =3D sockaddr_to_str(
@@ -3146,7 +3167,7 @@ static void tcp_chr_connect(void *opaque)
 static void tcp_chr_update_read_handler(Chardev *chr,
                                         GMainContext *context)
 {
-    SocketChardev *s =3D (SocketChardev *)chr;
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
=20
     if (!s->connected) {
         return;
@@ -3197,7 +3218,7 @@ static gboolean tcp_chr_telnet_init_io(QIOChannel *=
ioc,
=20
 static void tcp_chr_telnet_init(Chardev *chr)
 {
-    SocketChardev *s =3D (SocketChardev *)chr;
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
     TCPCharDriverTelnetInit *init =3D
         g_new0(TCPCharDriverTelnetInit, 1);
     size_t n =3D 0;
@@ -3249,7 +3270,7 @@ static void tcp_chr_tls_handshake(Object *source,
=20
 static void tcp_chr_tls_init(Chardev *chr)
 {
-    SocketChardev *s =3D (SocketChardev *)chr;
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
     QIOChannelTLS *tioc;
     Error *err =3D NULL;
     gchar *name;
@@ -3288,7 +3309,7 @@ static void tcp_chr_tls_init(Chardev *chr)
 static void tcp_chr_set_client_ioc_name(Chardev *chr,
                                         QIOChannelSocket *sioc)
 {
-    SocketChardev *s =3D (SocketChardev *)chr;
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
     char *name;
     name =3D g_strdup_printf("chardev-tcp-%s-%s",
                            s->is_listen ? "server" : "client",
@@ -3300,7 +3321,7 @@ static void tcp_chr_set_client_ioc_name(Chardev *ch=
r,
=20
 static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
 {
-    SocketChardev *s =3D (SocketChardev *)chr;
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
=20
     if (s->ioc !=3D NULL) {
 	return -1;
@@ -3354,7 +3375,7 @@ static gboolean tcp_chr_accept(QIOChannel *channel,
                                GIOCondition cond,
                                void *opaque)
 {
-    Chardev *chr =3D opaque;
+    Chardev *chr =3D CHARDEV(opaque);
     QIOChannelSocket *sioc;
=20
     sioc =3D qio_channel_socket_accept(QIO_CHANNEL_SOCKET(channel),
@@ -3372,7 +3393,7 @@ static gboolean tcp_chr_accept(QIOChannel *channel,
=20
 static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
 {
-    SocketChardev *s =3D (SocketChardev *)chr;
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
     QIOChannelSocket *sioc;
=20
     /* It can't wait on s->connected, since it is set asynchronously
@@ -3401,8 +3422,10 @@ static int tcp_chr_wait_connected(Chardev *chr, Er=
ror **errp)
=20
 static int qemu_chr_wait_connected(Chardev *chr, Error **errp)
 {
-    if (chr->driver->chr_wait_connected) {
-        return chr->driver->chr_wait_connected(chr, errp);
+    ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
+
+    if (cc->chr_wait_connected) {
+        return cc->chr_wait_connected(chr, errp);
     }
=20
     return 0;
@@ -3420,7 +3443,7 @@ int qemu_chr_fe_wait_connected(CharBackend *be, Err=
or **errp)
=20
 static void tcp_chr_free(Chardev *chr)
 {
-    SocketChardev *s =3D (SocketChardev *)chr;
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
=20
     tcp_chr_free_connection(chr);
=20
@@ -3447,8 +3470,8 @@ static void tcp_chr_free(Chardev *chr)
 static void qemu_chr_socket_connected(Object *src, Error *err, void *opa=
que)
 {
     QIOChannelSocket *sioc =3D QIO_CHANNEL_SOCKET(src);
-    Chardev *chr =3D opaque;
-    SocketChardev *s =3D (SocketChardev *)chr;
+    Chardev *chr =3D CHARDEV(opaque);
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
=20
     if (err) {
         check_report_connect_error(chr, err);
@@ -3473,9 +3496,12 @@ typedef struct {
     uint8_t *cbuf;
 } RingBufChardev;
=20
+#define RINGBUF_CHARDEV(obj)                                    \
+    OBJECT_CHECK(RingBufChardev, (obj), TYPE_CHARDEV_RINGBUF)
+
 static size_t ringbuf_count(const Chardev *chr)
 {
-    const RingBufChardev *d =3D (RingBufChardev *)chr;
+    const RingBufChardev *d =3D RINGBUF_CHARDEV(chr);
=20
     return d->prod - d->cons;
 }
@@ -3483,7 +3509,7 @@ static size_t ringbuf_count(const Chardev *chr)
 /* Called with chr_write_lock held.  */
 static int ringbuf_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    RingBufChardev *d =3D (RingBufChardev *)chr;
+    RingBufChardev *d =3D RINGBUF_CHARDEV(chr);
     int i;
=20
     if (!buf || (len < 0)) {
@@ -3502,7 +3528,7 @@ static int ringbuf_chr_write(Chardev *chr, const ui=
nt8_t *buf, int len)
=20
 static int ringbuf_chr_read(Chardev *chr, uint8_t *buf, int len)
 {
-    RingBufChardev *d =3D (RingBufChardev *)chr;
+    RingBufChardev *d =3D RINGBUF_CHARDEV(chr);
     int i;
=20
     qemu_mutex_lock(&chr->chr_write_lock);
@@ -3516,51 +3542,30 @@ static int ringbuf_chr_read(Chardev *chr, uint8_t=
 *buf, int len)
=20
 static void ringbuf_chr_free(struct Chardev *chr)
 {
-    RingBufChardev *d =3D (RingBufChardev *)chr;
+    RingBufChardev *d =3D RINGBUF_CHARDEV(chr);
=20
     g_free(d->cbuf);
 }
=20
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
     ChardevRingbuf *opts =3D backend->u.ringbuf.data;
-    ChardevCommon *common =3D qapi_ChardevRingbuf_base(opts);
-    Chardev *chr;
-    RingBufChardev *d;
-
-    chr =3D qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        return NULL;
-    }
-    d =3D (RingBufChardev *)chr;
+    RingBufChardev *d =3D RINGBUF_CHARDEV(chr);
=20
     d->size =3D opts->has_size ? opts->size : 65536;
=20
     /* The size must be power of 2 */
     if (d->size & (d->size - 1)) {
         error_setg(errp, "size of ringbuf chardev must be power of two")=
;
-        goto fail;
+        return;
     }
=20
     d->prod =3D 0;
     d->cons =3D 0;
     d->cbuf =3D g_malloc0(d->size);
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
=20
 void qmp_ringbuf_write(const char *device, const char *data,
@@ -3578,7 +3583,7 @@ void qmp_ringbuf_write(const char *device, const ch=
ar *data,
         return;
     }
=20
-    if (!qemu_chr_is_ringbuf(chr)) {
+    if (!CHARDEV_IS_RINGBUF(chr)) {
         error_setg(errp,"%s is not a ringbuf device", device);
         return;
     }
@@ -3622,7 +3627,7 @@ char *qmp_ringbuf_read(const char *device, int64_t =
size,
         return NULL;
     }
=20
-    if (!qemu_chr_is_ringbuf(chr)) {
+    if (!CHARDEV_IS_RINGBUF(chr)) {
         error_setg(errp,"%s is not a ringbuf device", device);
         return NULL;
     }
@@ -3842,20 +3847,31 @@ static void qemu_chr_parse_stdio(QemuOpts *opts, =
ChardevBackend *backend,
 static const CharDriver stdio_driver =3D {
     .kind =3D CHARDEV_BACKEND_KIND_STDIO,
     .parse =3D qemu_chr_parse_stdio,
-    .create =3D qemu_chr_open_stdio,
+};
+
+static void char_stdio_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->open =3D qemu_chr_open_stdio;
 #ifdef _WIN32
-    sizeof(WinStdioChardev),
-    .chr_write =3D win_stdio_write,
-    .chr_set_echo =3D qemu_chr_set_echo_win_stdio,
-    .chr_free =3D win_stdio_free,
+    cc->chr_write =3D win_stdio_write;
+    cc->chr_set_echo =3D qemu_chr_set_echo_win_stdio;
+    cc->chr_free =3D win_stdio_free;
 #else
-    sizeof(FDChardev),
-    .chr_add_watch =3D fd_chr_add_watch,
-    .chr_write =3D fd_chr_write,
-    .chr_update_read_handler =3D fd_chr_update_read_handler,
-    .chr_set_echo =3D qemu_chr_set_echo_stdio,
-    .chr_free =3D qemu_chr_free_stdio,
+    cc->chr_set_echo =3D qemu_chr_set_echo_stdio;
+    cc->chr_free =3D qemu_chr_free_stdio;
 #endif
+}
+
+static const TypeInfo char_stdio_type_info =3D {
+    .name =3D TYPE_CHARDEV_STDIO,
+#ifdef _WIN32
+    .parent =3D TYPE_CHARDEV_WIN_STDIO,
+#else
+    .parent =3D TYPE_CHARDEV_FD,
+#endif
+    .class_init =3D char_stdio_class_init,
 };
=20
 #ifdef HAVE_CHARDEV_SERIAL
@@ -3910,18 +3926,23 @@ static void qemu_chr_parse_pipe(QemuOpts *opts, C=
hardevBackend *backend,
 static const CharDriver pipe_driver =3D {
     .kind =3D CHARDEV_BACKEND_KIND_PIPE,
     .parse =3D qemu_chr_parse_pipe,
-    .create =3D qemu_chr_open_pipe,
+};
+
+static void char_pipe_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->open =3D qemu_chr_open_pipe;
+}
+
+static const TypeInfo char_pipe_type_info =3D {
+    .name =3D TYPE_CHARDEV_PIPE,
 #ifdef _WIN32
-    sizeof(WinChardev),
-    .chr_write =3D win_chr_write,
-    .chr_free =3D win_chr_free,
+    .parent =3D TYPE_CHARDEV_WIN,
 #else
-    sizeof(FDChardev),
-    .chr_add_watch =3D fd_chr_add_watch,
-    .chr_write =3D fd_chr_write,
-    .chr_update_read_handler =3D fd_chr_update_read_handler,
-    .chr_free =3D fd_chr_free,
+    .parent =3D TYPE_CHARDEV_FD,
 #endif
+    .class_init =3D char_pipe_class_init,
 };
=20
 static void qemu_chr_parse_ringbuf(QemuOpts *opts, ChardevBackend *backe=
nd,
@@ -3941,22 +3962,35 @@ static void qemu_chr_parse_ringbuf(QemuOpts *opts=
, ChardevBackend *backend,
 }
=20
 static const CharDriver ringbuf_driver =3D {
-    .instance_size =3D sizeof(RingBufChardev),
     .kind =3D CHARDEV_BACKEND_KIND_RINGBUF,
     .parse =3D qemu_chr_parse_ringbuf,
-    .create =3D qemu_chr_open_ringbuf,
-    .chr_write =3D ringbuf_chr_write,
-    .chr_free =3D ringbuf_chr_free,
+};
+
+static void char_ringbuf_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->open =3D qemu_chr_open_ringbuf;
+    cc->chr_write =3D ringbuf_chr_write;
+    cc->chr_free =3D ringbuf_chr_free;
+}
+
+static const TypeInfo char_ringbuf_type_info =3D {
+    .name =3D TYPE_CHARDEV_RINGBUF,
+    .parent =3D TYPE_CHARDEV,
+    .class_init =3D char_ringbuf_class_init,
+    .instance_size =3D sizeof(RingBufChardev),
 };
=20
 /* Bug-compatibility: */
 static const CharDriver memory_driver =3D {
-    .instance_size =3D sizeof(RingBufChardev),
     .kind =3D CHARDEV_BACKEND_KIND_MEMORY,
     .parse =3D qemu_chr_parse_ringbuf,
-    .create =3D qemu_chr_open_ringbuf,
-    .chr_write =3D ringbuf_chr_write,
-    .chr_free =3D ringbuf_chr_free,
+};
+
+static const TypeInfo char_memory_type_info =3D {
+    .name =3D TYPE_CHARDEV_MEMORY,
+    .parent =3D TYPE_CHARDEV_RINGBUF,
 };
=20
 static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
@@ -3975,14 +4009,26 @@ static void qemu_chr_parse_mux(QemuOpts *opts, Ch=
ardevBackend *backend,
 }
=20
 static const CharDriver mux_driver =3D {
-    .instance_size =3D sizeof(MuxChardev),
     .kind =3D CHARDEV_BACKEND_KIND_MUX,
     .parse =3D qemu_chr_parse_mux,
-    .create =3D qemu_chr_open_mux,
-    .chr_free =3D mux_chr_free,
-    .chr_write =3D mux_chr_write,
-    .chr_accept_input =3D mux_chr_accept_input,
-    .chr_add_watch =3D mux_chr_add_watch,
+};
+
+static void char_mux_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->open =3D qemu_chr_open_mux;
+    cc->chr_free =3D mux_chr_free;
+    cc->chr_write =3D mux_chr_write;
+    cc->chr_accept_input =3D mux_chr_accept_input;
+    cc->chr_add_watch =3D mux_chr_add_watch;
+}
+
+static const TypeInfo char_mux_type_info =3D {
+    .name =3D TYPE_CHARDEV_MUX,
+    .parent =3D TYPE_CHARDEV,
+    .class_init =3D char_mux_class_init,
+    .instance_size =3D sizeof(MuxChardev),
 };
=20
 static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backen=
d,
@@ -4264,7 +4310,7 @@ Chardev *qemu_chr_new(const char *label, const char=
 *filename)
         if (replay_mode !=3D REPLAY_MODE_NONE) {
             qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
         }
-        if (qemu_chr_replay(chr) && chr->driver->chr_ioctl) {
+        if (qemu_chr_replay(chr) && CHARDEV_GET_CLASS(chr)->chr_ioctl) {
             error_report("Replay: ioctl is not supported "
                          "for serial devices yet");
         }
@@ -4277,8 +4323,8 @@ void qemu_chr_fe_set_echo(CharBackend *be, bool ech=
o)
 {
     Chardev *chr =3D be->chr;
=20
-    if (chr && chr->driver->chr_set_echo) {
-        chr->driver->chr_set_echo(chr, echo);
+    if (chr && CHARDEV_GET_CLASS(chr)->chr_set_echo) {
+        CHARDEV_GET_CLASS(chr)->chr_set_echo(chr, echo);
     }
 }
=20
@@ -4294,8 +4340,8 @@ void qemu_chr_fe_set_open(CharBackend *be, int fe_o=
pen)
         return;
     }
     be->fe_open =3D fe_open;
-    if (chr->driver->chr_set_fe_open) {
-        chr->driver->chr_set_fe_open(chr, fe_open);
+    if (CHARDEV_GET_CLASS(chr)->chr_set_fe_open) {
+        CHARDEV_GET_CLASS(chr)->chr_set_fe_open(chr, fe_open);
     }
 }
=20
@@ -4306,11 +4352,11 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOC=
ondition cond,
     GSource *src;
     guint tag;
=20
-    if (!s || s->driver->chr_add_watch =3D=3D NULL) {
+    if (!s || CHARDEV_GET_CLASS(s)->chr_add_watch =3D=3D NULL) {
         return 0;
     }
=20
-    src =3D s->driver->chr_add_watch(s, cond);
+    src =3D CHARDEV_GET_CLASS(s)->chr_add_watch(s, cond);
     if (!src) {
         return 0;
     }
@@ -4326,31 +4372,17 @@ void qemu_chr_fe_disconnect(CharBackend *be)
 {
     Chardev *chr =3D be->chr;
=20
-    if (chr && chr->driver->chr_disconnect) {
-        chr->driver->chr_disconnect(chr);
-    }
-}
-
-static void qemu_chr_free_common(Chardev *chr)
-{
-    if (chr->be) {
-        chr->be->chr =3D NULL;
+    if (chr && CHARDEV_GET_CLASS(chr)->chr_disconnect) {
+        CHARDEV_GET_CLASS(chr)->chr_disconnect(chr);
     }
-    g_free(chr->filename);
-    g_free(chr->label);
-    if (chr->logfd !=3D -1) {
-        close(chr->logfd);
-    }
-    qemu_mutex_destroy(&chr->chr_write_lock);
-    g_free(chr);
 }
=20
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
=20
 void qemu_chr_delete(Chardev *chr)
@@ -4520,22 +4552,19 @@ QemuOptsList qemu_chardev_opts =3D {
=20
 #ifdef _WIN32
=20
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
     ChardevFile *file =3D backend->u.file.data;
-    ChardevCommon *common =3D qapi_ChardevFile_base(file);
     HANDLE out;
     DWORD accessmode;
     DWORD flags;
=20
     if (file->has_in) {
         error_setg(errp, "input file not supported");
-        return NULL;
+        return;
     }
=20
     if (file->has_append && file->append) {
@@ -4552,33 +4581,20 @@ static Chardev *qmp_chardev_open_file(const CharD=
river *driver,
                      FILE_ATTRIBUTE_NORMAL, NULL);
     if (out =3D=3D INVALID_HANDLE_VALUE) {
         error_setg(errp, "open %s failed", file->out);
-        return NULL;
+        return;
     }
-    return qemu_chr_open_win_file(driver, out, common, errp);
+
+    qemu_chr_open_win_file(chr, out);
 }
=20
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
     ChardevHostdev *serial =3D backend->u.serial.data;
-    ChardevCommon *common =3D qapi_ChardevHostdev_base(serial);
-    Chardev *chr;
-
-    chr =3D qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        return NULL;
-    }
-
-    if (win_chr_init(chr, serial->device, errp) < 0) {
-        qemu_chr_free_common(chr);
-        return NULL;
-    }
=20
-    return chr;
+    win_chr_init(chr, serial->device, errp);
 }
=20
 #else /* WIN32 */
@@ -4595,15 +4611,12 @@ static int qmp_chardev_open_file_source(char *src=
, int flags,
     return fd;
 }
=20
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
     ChardevFile *file =3D backend->u.file.data;
-    ChardevCommon *common =3D qapi_ChardevFile_base(file);
     int flags, in =3D -1, out;
=20
     flags =3D O_WRONLY | O_CREAT | O_BINARY;
@@ -4615,7 +4628,7 @@ static Chardev *qmp_chardev_open_file(const CharDri=
ver *driver,
=20
     out =3D qmp_chardev_open_file_source(file->out, flags, errp);
     if (out < 0) {
-        return NULL;
+        return;
     }
=20
     if (file->has_in) {
@@ -4623,70 +4636,76 @@ static Chardev *qmp_chardev_open_file(const CharD=
river *driver,
         in =3D qmp_chardev_open_file_source(file->in, flags, errp);
         if (in < 0) {
             qemu_close(out);
-            return NULL;
+            return;
         }
     }
=20
-    return qemu_chr_open_fd(driver, in, out, common, errp);
+    qemu_chr_open_fd(chr, in, out);
 }
=20
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
     ChardevHostdev *serial =3D backend->u.serial.data;
-    ChardevCommon *common =3D qapi_ChardevHostdev_base(serial);
     int fd;
=20
     fd =3D qmp_chardev_open_file_source(serial->device, O_RDWR, errp);
     if (fd < 0) {
-        return NULL;
+        return;
     }
     qemu_set_nonblock(fd);
     tty_serial_init(fd, 115200, 'N', 8, 1);
=20
-    return qemu_chr_open_fd(driver, fd, fd, common, errp);
+    qemu_chr_open_fd(chr, fd, fd);
 }
 #endif
=20
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
     ChardevHostdev *parallel =3D backend->u.parallel.data;
-    ChardevCommon *common =3D qapi_ChardevHostdev_base(parallel);
     int fd;
=20
     fd =3D qmp_chardev_open_file_source(parallel->device, O_RDWR, errp);
     if (fd < 0) {
-        return NULL;
+        return;
     }
-    return qemu_chr_open_pp_fd(driver, fd, common, be_opened, errp);
+    qemu_chr_open_pp_fd(chr, fd, be_opened, errp);
 }
=20
 static const CharDriver parallel_driver =3D {
-    .instance_size =3D sizeof(ParallelChardev),
     .kind =3D CHARDEV_BACKEND_KIND_PARALLEL,
     .alias =3D "parport",
     .parse =3D qemu_chr_parse_parallel,
-    .create =3D qmp_chardev_open_parallel,
+};
+
+static void char_parallel_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->open =3D qmp_chardev_open_parallel;
 #if defined(__linux__)
-    .chr_write =3D null_chr_write,
-    .chr_ioctl =3D pp_ioctl,
-    .chr_free =3D pp_free,
+    cc->chr_write =3D null_chr_write;
+    cc->chr_ioctl =3D pp_ioctl;
+    cc->chr_free =3D pp_free;
 #elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__) || defined(__D=
ragonFly__)
-    .chr_write =3D null_chr_write,
-    .chr_ioctl =3D pp_ioctl,
     /* FIXME: no chr_free */
+    cc->chr_write =3D null_chr_write;
+    cc->chr_ioctl =3D pp_ioctl;
 #endif
+}
+
+static const TypeInfo char_parallel_type_info =3D {
+    .name =3D TYPE_CHARDEV_PARALLEL,
+    .parent =3D TYPE_CHARDEV,
+    .instance_size =3D sizeof(ParallelChardev),
+    .class_init =3D char_parallel_class_init,
 };
 #endif
=20
@@ -4695,45 +4714,63 @@ static const CharDriver parallel_driver =3D {
 static const CharDriver file_driver =3D {
     .kind =3D CHARDEV_BACKEND_KIND_FILE,
     .parse =3D qemu_chr_parse_file_out,
-    .create =3D qmp_chardev_open_file,
+};
+
+static void char_file_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->open =3D qmp_chardev_open_file;
 #ifdef _WIN32
-    sizeof(WinChardev),
-    .chr_write =3D win_chr_write,
     /* FIXME: no chr_free */
+    cc->chr_free =3D NULL;
+#endif
+}
+
+static const TypeInfo char_file_type_info =3D {
+    .name =3D TYPE_CHARDEV_FILE,
+#ifdef _WIN32
+    .parent =3D TYPE_CHARDEV_WIN,
 #else
-    sizeof(FDChardev),
-    .chr_add_watch =3D fd_chr_add_watch,
-    .chr_write =3D fd_chr_write,
-    .chr_update_read_handler =3D fd_chr_update_read_handler,
-    .chr_free =3D fd_chr_free,
+    .parent =3D TYPE_CHARDEV_FD,
 #endif
+    .class_init =3D char_file_class_init,
 };
=20
 #ifdef HAVE_CHARDEV_SERIAL
+
 static const CharDriver serial_driver =3D {
     .kind =3D CHARDEV_BACKEND_KIND_SERIAL,
     .alias =3D "tty",
     .parse =3D qemu_chr_parse_serial,
-    .create =3D qmp_chardev_open_serial,
+};
+
+static void char_serial_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->open =3D qmp_chardev_open_serial;
+#ifndef _WIN32
+    cc->chr_ioctl =3D tty_serial_ioctl;
+    cc->chr_free =3D qemu_chr_free_tty;
+#endif
+}
+
+static const TypeInfo char_serial_type_info =3D {
+    .name =3D TYPE_CHARDEV_SERIAL,
 #ifdef _WIN32
-    sizeof(WinChardev),
-    .chr_write =3D win_chr_write,
-    .chr_free =3D win_chr_free,
+    .parent =3D TYPE_CHARDEV_WIN,
 #else
-    sizeof(FDChardev),
-    .chr_add_watch =3D fd_chr_add_watch,
-    .chr_write =3D fd_chr_write,
-    .chr_update_read_handler =3D fd_chr_update_read_handler,
-    .chr_ioctl =3D tty_serial_ioctl,
-    .chr_free =3D qemu_chr_free_tty,
+    .parent =3D TYPE_CHARDEV_FD,
 #endif
+    .class_init =3D char_serial_class_init,
 };
 #endif
=20
 static gboolean socket_reconnect_timeout(gpointer opaque)
 {
-    Chardev *chr =3D opaque;
-    SocketChardev *s =3D opaque;
+    Chardev *chr =3D CHARDEV(opaque);
+    SocketChardev *s =3D SOCKET_CHARDEV(opaque);
     QIOChannelSocket *sioc;
=20
     s->reconnect_timer =3D 0;
@@ -4751,15 +4788,12 @@ static gboolean socket_reconnect_timeout(gpointer=
 opaque)
     return false;
 }
=20
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
+    SocketChardev *s =3D SOCKET_CHARDEV(chr);
     ChardevSocket *sock =3D backend->u.socket.data;
     SocketAddress *addr =3D sock->addr;
     bool do_nodelay     =3D sock->has_nodelay ? sock->nodelay : false;
@@ -4767,15 +4801,8 @@ static Chardev *qmp_chardev_open_socket(const Char=
Driver *driver,
     bool is_telnet      =3D sock->has_telnet  ? sock->telnet  : false;
     bool is_waitconnect =3D sock->has_wait    ? sock->wait    : false;
     int64_t reconnect   =3D sock->has_reconnect ? sock->reconnect : 0;
-    ChardevCommon *common =3D qapi_ChardevSocket_base(sock);
     QIOChannelSocket *sioc =3D NULL;
=20
-    chr =3D qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        return NULL;
-    }
-    s =3D (SocketChardev *)chr;
-
     s->is_unix =3D addr->type =3D=3D SOCKET_ADDRESS_KIND_UNIX;
     s->is_listen =3D is_listen;
     s->is_telnet =3D is_telnet;
@@ -4867,82 +4894,92 @@ static Chardev *qmp_chardev_open_socket(const Cha=
rDriver *driver,
         }
     }
=20
-    return chr;
+    return;
=20
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
=20
 static const CharDriver socket_driver =3D {
-    .instance_size =3D sizeof(SocketChardev),
     .kind =3D CHARDEV_BACKEND_KIND_SOCKET,
     .parse =3D qemu_chr_parse_socket,
-    .create =3D qmp_chardev_open_socket,
-    .chr_wait_connected =3D tcp_chr_wait_connected,
-    .chr_write =3D tcp_chr_write,
-    .chr_sync_read =3D tcp_chr_sync_read,
-    .chr_disconnect =3D tcp_chr_disconnect,
-    .get_msgfds =3D tcp_get_msgfds,
-    .set_msgfds =3D tcp_set_msgfds,
-    .chr_add_client =3D tcp_chr_add_client,
-    .chr_add_watch =3D tcp_chr_add_watch,
-    .chr_update_read_handler =3D tcp_chr_update_read_handler,
-    .chr_free =3D tcp_chr_free,
 };
=20
-static Chardev *qmp_chardev_open_udp(const CharDriver *driver,
-                                     const char *id,
-                                     ChardevBackend *backend,
-                                     ChardevReturn *ret,
-                                     bool *be_opened,
-                                     Error **errp)
+static void char_socket_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->open =3D qmp_chardev_open_socket;
+    cc->chr_wait_connected =3D tcp_chr_wait_connected;
+    cc->chr_write =3D tcp_chr_write;
+    cc->chr_sync_read =3D tcp_chr_sync_read;
+    cc->chr_disconnect =3D tcp_chr_disconnect;
+    cc->get_msgfds =3D tcp_get_msgfds;
+    cc->set_msgfds =3D tcp_set_msgfds;
+    cc->chr_add_client =3D tcp_chr_add_client;
+    cc->chr_add_watch =3D tcp_chr_add_watch;
+    cc->chr_update_read_handler =3D tcp_chr_update_read_handler;
+    cc->chr_free =3D tcp_chr_free;
+}
+
+static const TypeInfo char_socket_type_info =3D {
+    .name =3D TYPE_CHARDEV_SOCKET,
+    .parent =3D TYPE_CHARDEV,
+    .instance_size =3D sizeof(SocketChardev),
+    .class_init =3D char_socket_class_init,
+};
+
+static void qmp_chardev_open_udp(Chardev *chr,
+                                 ChardevBackend *backend,
+                                 bool *be_opened,
+                                 Error **errp)
 {
     ChardevUdp *udp =3D backend->u.udp.data;
-    ChardevCommon *common =3D qapi_ChardevUdp_base(udp);
     QIOChannelSocket *sioc =3D qio_channel_socket_new();
     char *name;
-    Chardev *chr;
-    UdpChardev *s;
+    UdpChardev *s =3D UDP_CHARDEV(chr);
=20
     if (qio_channel_socket_dgram_sync(sioc,
                                       udp->local, udp->remote,
                                       errp) < 0) {
         object_unref(OBJECT(sioc));
-        return NULL;
-    }
-
-    chr =3D qemu_chr_alloc(driver, common, errp);
-    if (!chr) {
-        return NULL;
+        return;
     }
=20
     name =3D g_strdup_printf("chardev-udp-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(sioc), name);
     g_free(name);
=20
-    s =3D (UdpChardev *)chr;
     s->ioc =3D QIO_CHANNEL(sioc);
     /* be isn't opened until we get a connection */
     *be_opened =3D false;
-
-    return chr;
 }
=20
 static const CharDriver udp_driver =3D {
-    .instance_size =3D sizeof(UdpChardev),
     .kind =3D CHARDEV_BACKEND_KIND_UDP,
     .parse =3D qemu_chr_parse_udp,
-    .create =3D qmp_chardev_open_udp,
-    .chr_write =3D udp_chr_write,
-    .chr_update_read_handler =3D udp_chr_update_read_handler,
-    .chr_free =3D udp_chr_free,
+};
+
+static void char_udp_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->open =3D qmp_chardev_open_udp;
+    cc->chr_write =3D udp_chr_write;
+    cc->chr_update_read_handler =3D udp_chr_update_read_handler;
+    cc->chr_free =3D udp_chr_free;
+}
+
+static const TypeInfo char_udp_type_info =3D {
+    .name =3D TYPE_CHARDEV_UDP,
+    .parent =3D TYPE_CHARDEV,
+    .instance_size =3D sizeof(UdpChardev),
+    .class_init =3D char_udp_class_init,
 };
=20
 bool qemu_chr_has_feature(Chardev *chr,
@@ -4957,47 +4994,96 @@ void qemu_chr_set_feature(Chardev *chr,
     return set_bit(feature, chr->features);
 }
=20
-ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend,
-                               Error **errp)
+static const ChardevClass *char_get_class(const char *driver, Error **er=
rp)
+{
+    ObjectClass *oc;
+    const ChardevClass *cc;
+    char *typename =3D g_strdup_printf("chardev-%s", driver);
+
+    oc =3D object_class_by_name(typename);
+    g_free(typename);
+
+    if (!object_class_dynamic_cast(oc, TYPE_CHARDEV)) {
+        error_setg(errp, "'%s' is not a valid char driver name", driver)=
;
+        return NULL;
+    }
+
+    if (object_class_is_abstract(oc)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
+                   "abstract device type");
+        return NULL;
+    }
+
+    cc =3D CHARDEV_CLASS(oc);
+    if (cc->internal) {
+        error_setg(errp, "'%s' is not a valid char driver name", driver)=
;
+        return NULL;
+    }
+
+    return cc;
+}
+
+Chardev *qemu_chardev_new(const char *id, const char *typename,
+                          ChardevBackend *backend, Error **errp)
 {
-    ChardevReturn *ret =3D g_new0(ChardevReturn, 1);
     Chardev *chr =3D NULL;
-    const CharDriver *cd;
     Error *local_err =3D NULL;
     bool be_opened =3D true;
=20
-    chr =3D qemu_chr_find(id);
-    if (chr) {
-        error_setg(errp, "Chardev '%s' already exists", id);
-        goto out_error;
-    }
+    assert(g_str_has_prefix(typename, "chardev-"));
=20
-    cd =3D (int)backend->type >=3D 0 && backend->type < ARRAY_SIZE(backe=
nds) ?
-        backends[backend->type] : NULL;
-    if (cd =3D=3D NULL) {
-        error_setg(errp, "chardev backend not available");
-        goto out_error;
-    }
+    chr =3D CHARDEV(object_new(typename));
+    chr->label =3D g_strdup(id);
=20
-    chr =3D cd->create(cd, id, backend, ret, &be_opened, &local_err);
+    qemu_char_open(chr, backend, &be_opened, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        goto out_error;
+        object_unref(OBJECT(chr));
+        return NULL;
     }
=20
-    chr->label =3D g_strdup(id);
     if (!chr->filename) {
-        chr->filename =3D g_strdup(ChardevBackendKind_lookup[backend->ty=
pe]);
+        chr->filename =3D g_strdup(typename + 8);
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
+    chr =3D qemu_chr_find(id);
+    if (chr) {
+        error_setg(errp, "Chardev '%s' already exists", id);
+        return NULL;
+    }
+
+    cc =3D char_get_class(ChardevBackendKind_lookup[backend->type], errp=
);
+    if (!cc) {
+        return NULL;
+    }
+
+    chr =3D qemu_chardev_new(id, object_class_get_name(OBJECT_CLASS(cc))=
,
+                           backend, errp);
+    if (!chr) {
+        return NULL;
+    }
+
+    ret =3D g_new0(ChardevReturn, 1);
+    if (CHARDEV_IS_PTY(chr)) {
+        ret->pty =3D g_strdup(chr->filename + 4);
+        ret->has_pty =3D true;
+    }
+
     QTAILQ_INSERT_TAIL(&chardevs, chr, next);
     return ret;
-
-out_error:
-    g_free(ret);
-    return NULL;
 }
=20
 void qmp_chardev_remove(const char *id, Error **errp)
@@ -5032,33 +5118,44 @@ void qemu_chr_cleanup(void)
=20
 static void register_types(void)
 {
-    static const CharDriver *drivers[] =3D {
-        &null_driver,
-        &socket_driver,
-        &udp_driver,
-        &ringbuf_driver,
-        &file_driver,
-        &stdio_driver,
+    static const struct {
+        const CharDriver *driver;
+        const TypeInfo *type;
+    } chardevs[] =3D {
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
=20
-    for (i =3D 0; i < ARRAY_SIZE(drivers); i++) {
-        register_char_driver(drivers[i]);
+    type_register_static(&char_type_info);
+#ifndef _WIN32
+    type_register_static(&char_fd_type_info);
+#else
+    type_register_static(&char_win_type_info);
+    type_register_static(&char_win_stdio_type_info);
+#endif
+    for (i =3D 0; i < ARRAY_SIZE(chardevs); i++) {
+        type_register_static(chardevs[i].type);
+        register_char_driver(chardevs[i].driver);
     }
=20
     /* this must be done after machine init, since we register FEs with =
muxes
diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index 5e5897b189..dd97c17fca 100644
--- a/spice-qemu-char.c
+++ b/spice-qemu-char.c
@@ -18,6 +18,12 @@ typedef struct SpiceChardev {
     QLIST_ENTRY(SpiceChardev) next;
 } SpiceChardev;
=20
+#define TYPE_CHARDEV_SPICE "chardev-spice"
+#define TYPE_CHARDEV_SPICEVMC "chardev-spicevmc"
+#define TYPE_CHARDEV_SPICEPORT "chardev-spiceport"
+
+#define SPICE_CHARDEV(obj) OBJECT_CHECK(SpiceChardev, (obj), TYPE_CHARDE=
V_SPICE)
+
 typedef struct SpiceCharSource {
     GSource               source;
     SpiceChardev       *scd;
@@ -29,7 +35,7 @@ static QLIST_HEAD(, SpiceChardev) spice_chars =3D
 static int vmc_write(SpiceCharDeviceInstance *sin, const uint8_t *buf, i=
nt len)
 {
     SpiceChardev *scd =3D container_of(sin, SpiceChardev, sin);
-    Chardev *chr =3D (Chardev *)scd;
+    Chardev *chr =3D CHARDEV(scd);
     ssize_t out =3D 0;
     ssize_t last_out;
     uint8_t* p =3D (uint8_t*)buf;
@@ -73,7 +79,7 @@ static int vmc_read(SpiceCharDeviceInstance *sin, uint8=
_t *buf, int len)
 static void vmc_event(SpiceCharDeviceInstance *sin, uint8_t event)
 {
     SpiceChardev *scd =3D container_of(sin, SpiceChardev, sin);
-    Chardev *chr =3D (Chardev *)scd;
+    Chardev *chr =3D CHARDEV(scd);
     int chr_event;
=20
     switch (event) {
@@ -92,7 +98,7 @@ static void vmc_event(SpiceCharDeviceInstance *sin, uin=
t8_t event)
 static void vmc_state(SpiceCharDeviceInstance *sin, int connected)
 {
     SpiceChardev *scd =3D container_of(sin, SpiceChardev, sin);
-    Chardev *chr =3D (Chardev *)scd;
+    Chardev *chr =3D CHARDEV(scd);
=20
     if ((chr->be_open && connected) ||
         (!chr->be_open && !connected)) {
@@ -173,7 +179,7 @@ static GSourceFuncs SpiceCharSourceFuncs =3D {
=20
 static GSource *spice_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    SpiceChardev *scd =3D (SpiceChardev *)chr;
+    SpiceChardev *scd =3D SPICE_CHARDEV(chr);
     SpiceCharSource *src;
=20
     assert(cond & G_IO_OUT);
@@ -187,7 +193,7 @@ static GSource *spice_chr_add_watch(Chardev *chr, GIO=
Condition cond)
=20
 static int spice_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    SpiceChardev *s =3D (SpiceChardev *)chr;
+    SpiceChardev *s =3D SPICE_CHARDEV(chr);
     int read_bytes;
=20
     assert(s->datalen =3D=3D 0);
@@ -206,7 +212,7 @@ static int spice_chr_write(Chardev *chr, const uint8_=
t *buf, int len)
=20
 static void spice_chr_free(struct Chardev *chr)
 {
-    SpiceChardev *s =3D (SpiceChardev *)chr;
+    SpiceChardev *s =3D SPICE_CHARDEV(chr);
=20
     vmc_unregister_interface(s);
     QLIST_REMOVE(s, next);
@@ -219,7 +225,7 @@ static void spice_chr_free(struct Chardev *chr)
=20
 static void spice_vmc_set_fe_open(struct Chardev *chr, int fe_open)
 {
-    SpiceChardev *s =3D (SpiceChardev *)chr;
+    SpiceChardev *s =3D SPICE_CHARDEV(chr);
     if (fe_open) {
         vmc_register_interface(s);
     } else {
@@ -230,7 +236,7 @@ static void spice_vmc_set_fe_open(struct Chardev *chr=
, int fe_open)
 static void spice_port_set_fe_open(struct Chardev *chr, int fe_open)
 {
 #if SPICE_SERVER_VERSION >=3D 0x000c02
-    SpiceChardev *s =3D (SpiceChardev *)chr;
+    SpiceChardev *s =3D SPICE_CHARDEV(chr);
=20
     if (fe_open) {
         spice_server_port_event(&s->sin, SPICE_PORT_EVENT_OPENED);
@@ -242,43 +248,29 @@ static void spice_port_set_fe_open(struct Chardev *=
chr, int fe_open)
=20
 static void spice_chr_accept_input(struct Chardev *chr)
 {
-    SpiceChardev *s =3D (SpiceChardev *)chr;
+    SpiceChardev *s =3D SPICE_CHARDEV(chr);
=20
     spice_server_char_device_wakeup(&s->sin);
 }
=20
-static Chardev *chr_open(const CharDriver *driver,
-                                 const char *subtype,
-                                 ChardevCommon *backend,
-                                 Error **errp)
+static void chr_open(Chardev *chr, const char *subtype)
 {
-    Chardev *chr;
-    SpiceChardev *s;
+    SpiceChardev *s =3D SPICE_CHARDEV(chr);
=20
-    chr =3D qemu_chr_alloc(driver, backend, errp);
-    if (!chr) {
-        return NULL;
-    }
-    s =3D (SpiceChardev *)chr;
     s->active =3D false;
     s->sin.subtype =3D g_strdup(subtype);
=20
     QLIST_INSERT_HEAD(&spice_chars, s, next);
-
-    return chr;
 }
=20
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
     ChardevSpiceChannel *spicevmc =3D backend->u.spicevmc.data;
     const char *type =3D spicevmc->type;
     const char **psubtype =3D spice_server_char_device_recognized_subtyp=
es();
-    ChardevCommon *common =3D qapi_ChardevSpiceChannel_base(spicevmc);
=20
     for (; *psubtype !=3D NULL; ++psubtype) {
         if (strcmp(type, *psubtype) =3D=3D 0) {
@@ -294,41 +286,33 @@ static Chardev *qemu_chr_open_spice_vmc(const CharD=
river *driver,
                           subtypes);
=20
         g_free(subtypes);
-        return NULL;
+        return;
     }
=20
     *be_opened =3D false;
-    return chr_open(driver, type, common, errp);
+    chr_open(chr, type);
 }
=20
 #if SPICE_SERVER_VERSION >=3D 0x000c02
-static Chardev *qemu_chr_open_spice_port(const CharDriver *driver,
-                                                 const char *id,
-                                                 ChardevBackend *backend=
,
-                                                 ChardevReturn *ret,
-                                                 bool *be_opened,
-                                                 Error **errp)
+static void qemu_chr_open_spice_port(Chardev *chr,
+                                     ChardevBackend *backend,
+                                     bool *be_opened,
+                                     Error **errp)
 {
     ChardevSpicePort *spiceport =3D backend->u.spiceport.data;
     const char *name =3D spiceport->fqdn;
-    ChardevCommon *common =3D qapi_ChardevSpicePort_base(spiceport);
-    Chardev *chr;
     SpiceChardev *s;
=20
     if (name =3D=3D NULL) {
         error_setg(errp, "missing name parameter");
-        return NULL;
+        return;
     }
=20
-    chr =3D chr_open(driver, "port", common, errp);
-    if (!chr) {
-        return NULL;
-    }
+    chr_open(chr, "port");
+
     *be_opened =3D false;
-    s =3D (SpiceChardev *)chr;
+    s =3D SPICE_CHARDEV(chr);
     s->sin.portname =3D g_strdup(name);
-
-    return chr;
 }
=20
 void qemu_spice_register_ports(void)
@@ -374,32 +358,68 @@ static void qemu_chr_parse_spice_port(QemuOpts *opt=
s, ChardevBackend *backend,
     spiceport->fqdn =3D g_strdup(name);
 }
=20
+static void char_spice_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->chr_write =3D spice_chr_write;
+    cc->chr_add_watch =3D spice_chr_add_watch;
+    cc->chr_accept_input =3D spice_chr_accept_input;
+    cc->chr_free =3D spice_chr_free;
+}
+
+static const TypeInfo char_spice_type_info =3D {
+    .name =3D TYPE_CHARDEV_SPICE,
+    .parent =3D TYPE_CHARDEV,
+    .instance_size =3D sizeof(SpiceChardev),
+    .class_init =3D char_spice_class_init,
+    .abstract =3D true,
+};
+
+static void char_spicevmc_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->open =3D qemu_chr_open_spice_vmc;
+    cc->chr_set_fe_open =3D spice_vmc_set_fe_open;
+}
+
+static const TypeInfo char_spicevmc_type_info =3D {
+    .name =3D TYPE_CHARDEV_SPICEVMC,
+    .parent =3D TYPE_CHARDEV_SPICE,
+    .class_init =3D char_spicevmc_class_init,
+};
+
+static void char_spiceport_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->open =3D qemu_chr_open_spice_port;
+    cc->chr_set_fe_open =3D spice_port_set_fe_open;
+}
+
+static const TypeInfo char_spiceport_type_info =3D {
+    .name =3D TYPE_CHARDEV_SPICEPORT,
+    .parent =3D TYPE_CHARDEV_SPICE,
+    .class_init =3D char_spiceport_class_init,
+};
+
 static void register_types(void)
 {
     static const CharDriver vmc_driver =3D {
-        .instance_size =3D sizeof(SpiceChardev),
         .kind =3D CHARDEV_BACKEND_KIND_SPICEVMC,
         .parse =3D qemu_chr_parse_spice_vmc,
-        .create =3D qemu_chr_open_spice_vmc,
-        .chr_write =3D spice_chr_write,
-        .chr_add_watch =3D spice_chr_add_watch,
-        .chr_set_fe_open =3D spice_vmc_set_fe_open,
-        .chr_accept_input =3D spice_chr_accept_input,
-        .chr_free =3D spice_chr_free,
     };
     static const CharDriver port_driver =3D {
-        .instance_size =3D sizeof(SpiceChardev),
         .kind =3D CHARDEV_BACKEND_KIND_SPICEPORT,
         .parse =3D qemu_chr_parse_spice_port,
-        .create =3D qemu_chr_open_spice_port,
-        .chr_write =3D spice_chr_write,
-        .chr_add_watch =3D spice_chr_add_watch,
-        .chr_set_fe_open =3D spice_port_set_fe_open,
-        .chr_accept_input =3D spice_chr_accept_input,
-        .chr_free =3D spice_chr_free,
     };
     register_char_driver(&vmc_driver);
     register_char_driver(&port_driver);
+
+    type_register_static(&char_spice_type_info);
+    type_register_static(&char_spicevmc_type_info);
+    type_register_static(&char_spiceport_type_info);
 }
=20
 type_init(register_types);
diff --git a/ui/console.c b/ui/console.c
index c8ee164ffe..fe03a666f7 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1051,9 +1051,12 @@ typedef struct VCChardev {
     QemuConsole *console;
 } VCChardev;
=20
+#define TYPE_CHARDEV_VC "chardev-vc"
+#define VC_CHARDEV(obj) OBJECT_CHECK(VCChardev, (obj), TYPE_CHARDEV_VC)
+
 static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    VCChardev *drv =3D (VCChardev *)chr;
+    VCChardev *drv =3D VC_CHARDEV(chr);
     QemuConsole *s =3D drv->console;
     int i;
=20
@@ -1964,7 +1967,7 @@ int qemu_console_get_height(QemuConsole *con, int f=
allback)
=20
 static void vc_chr_set_echo(Chardev *chr, bool echo)
 {
-    VCChardev *drv =3D (VCChardev *)chr;
+    VCChardev *drv =3D VC_CHARDEV(chr);
     QemuConsole *s =3D drv->console;
=20
     s->echo =3D echo;
@@ -2005,7 +2008,7 @@ static const GraphicHwOps text_console_ops =3D {
=20
 static void text_console_do_init(Chardev *chr, DisplayState *ds)
 {
-    VCChardev *drv =3D (VCChardev *)chr;
+    VCChardev *drv =3D VC_CHARDEV(chr);
     QemuConsole *s =3D drv->console;
     int g_width =3D 80 * FONT_WIDTH;
     int g_height =3D 24 * FONT_HEIGHT;
@@ -2058,24 +2061,17 @@ static void text_console_do_init(Chardev *chr, Di=
splayState *ds)
=20
 static const CharDriver vc_driver;
=20
-static Chardev *vc_chr_init(const CharDriver *driver,
-                            const char *id, ChardevBackend *backend,
-                            ChardevReturn *ret, bool *be_opened,
-                            Error **errp)
+static void vc_chr_open(Chardev *chr,
+                        ChardevBackend *backend,
+                        bool *be_opened,
+                        Error **errp)
 {
     ChardevVC *vc =3D backend->u.vc.data;
-    ChardevCommon *common =3D qapi_ChardevVC_base(vc);
-    Chardev *chr;
-    VCChardev *drv;
+    VCChardev *drv =3D VC_CHARDEV(chr);
     QemuConsole *s;
     unsigned width =3D 0;
     unsigned height =3D 0;
=20
-    chr =3D qemu_chr_alloc(&vc_driver, common, errp);
-    if (!chr) {
-        return NULL;
-    }
-
     if (vc->has_width) {
         width =3D vc->width;
     } else if (vc->has_cols) {
@@ -2097,13 +2093,11 @@ static Chardev *vc_chr_init(const CharDriver *dri=
ver,
     }
=20
     if (!s) {
-        g_free(chr);
         error_setg(errp, "cannot create text console");
-        return NULL;
+        return;
     }
=20
     s->chr =3D chr;
-    drv =3D (VCChardev *)chr;
     drv->console =3D s;
=20
     if (display_state) {
@@ -2114,8 +2108,6 @@ static Chardev *vc_chr_init(const CharDriver *drive=
r,
      * stage, so defer OPENED events until they are fully initialized
      */
     *be_opened =3D false;
-
-    return chr;
 }
=20
 void qemu_console_resize(QemuConsole *s, int width, int height)
@@ -2193,19 +2185,39 @@ static const TypeInfo qemu_console_info =3D {
     .class_size =3D sizeof(QemuConsoleClass),
 };
=20
-static const CharDriver vc_driver =3D {
+static void char_vc_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->open =3D vc_chr_open;
+    cc->chr_write =3D vc_chr_write;
+    cc->chr_set_echo =3D vc_chr_set_echo;
+}
+
+static const TypeInfo char_vc_type_info =3D {
+    .name =3D TYPE_CHARDEV_VC,
+    .parent =3D TYPE_CHARDEV,
     .instance_size =3D sizeof(VCChardev),
+    .class_init =3D char_vc_class_init,
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
+static const CharDriver vc_driver =3D {
     .kind =3D CHARDEV_BACKEND_KIND_VC,
     .parse =3D qemu_chr_parse_vc,
-    .create =3D vc_chr_init,
-    .chr_write =3D vc_chr_write,
-    .chr_set_echo =3D vc_chr_set_echo,
 };
=20
 static void register_types(void)
 {
     type_register_static(&qemu_console_info);
-    register_char_driver(&vc_driver);
 }
=20
 type_init(register_types);
diff --git a/ui/gtk.c b/ui/gtk.c
index 04df0ad6af..bdd831c268 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -187,6 +187,9 @@ typedef struct VCChardev {
     bool echo;
 } VCChardev;
=20
+#define TYPE_CHARDEV_VC "chardev-vc"
+#define VC_CHARDEV(obj) OBJECT_CHECK(VCChardev, (obj), TYPE_CHARDEV_VC)
+
 static void gd_grab_pointer(VirtualConsole *vc, const char *reason);
 static void gd_ungrab_pointer(GtkDisplayState *s);
 static void gd_grab_keyboard(VirtualConsole *vc, const char *reason);
@@ -1691,7 +1694,7 @@ static void gd_vc_adjustment_changed(GtkAdjustment =
*adjustment, void *opaque)
=20
 static int gd_vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    VCChardev *vcd =3D (VCChardev *)chr;
+    VCChardev *vcd =3D VC_CHARDEV(chr);
     VirtualConsole *vc =3D vcd->console;
=20
     vte_terminal_feed(VTE_TERMINAL(vc->vte.terminal), (const char *)buf,=
 len);
@@ -1700,7 +1703,7 @@ static int gd_vc_chr_write(Chardev *chr, const uint=
8_t *buf, int len)
=20
 static void gd_vc_chr_set_echo(Chardev *chr, bool echo)
 {
-    VCChardev *vcd =3D (VCChardev *)chr;
+    VCChardev *vcd =3D VC_CHARDEV(chr);
     VirtualConsole *vc =3D vcd->console;
=20
     if (vc) {
@@ -1714,23 +1717,14 @@ static int nb_vcs;
 static Chardev *vcs[MAX_VCS];
 static const CharDriver gd_vc_driver;
=20
-static Chardev *vc_init(const CharDriver *driver,
-                        const char *id, ChardevBackend *backend,
-                        ChardevReturn *ret, bool *be_opened,
-                        Error **errp)
+static void gd_vc_open(Chardev *chr,
+                       ChardevBackend *backend,
+                       bool *be_opened,
+                       Error **errp)
 {
-    ChardevVC *vc =3D backend->u.vc.data;
-    ChardevCommon *common =3D qapi_ChardevVC_base(vc);
-    Chardev *chr;
-
     if (nb_vcs =3D=3D MAX_VCS) {
         error_setg(errp, "Maximum number of consoles reached");
-        return NULL;
-    }
-
-    chr =3D qemu_chr_alloc(&gd_vc_driver, common, errp);
-    if (!chr) {
-        return NULL;
+        return;
     }
=20
     vcs[nb_vcs++] =3D chr;
@@ -1739,16 +1733,27 @@ static Chardev *vc_init(const CharDriver *driver,
      * stage, so defer OPENED events until they are fully initialized
      */
     *be_opened =3D false;
+}
=20
-    return chr;
+static void char_gd_vc_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->open =3D gd_vc_open;
+    cc->chr_write =3D gd_vc_chr_write;
+    cc->chr_set_echo =3D gd_vc_chr_set_echo;
 }
=20
-static const CharDriver gd_vc_driver =3D {
+static const TypeInfo char_gd_vc_type_info =3D {
+    .name =3D TYPE_CHARDEV_VC,
+    .parent =3D TYPE_CHARDEV,
     .instance_size =3D sizeof(VCChardev),
+    .class_init =3D char_gd_vc_class_init,
+};
+
+static const CharDriver gd_vc_driver =3D {
     .kind =3D CHARDEV_BACKEND_KIND_VC,
-    .parse =3D qemu_chr_parse_vc, .create =3D vc_init,
-    .chr_write =3D gd_vc_chr_write,
-    .chr_set_echo =3D gd_vc_chr_set_echo,
+    .parse =3D qemu_chr_parse_vc,
 };
=20
 static gboolean gd_vc_in(VteTerminal *terminal, gchar *text, guint size,
@@ -1786,7 +1791,7 @@ static GSList *gd_vc_vte_init(GtkDisplayState *s, V=
irtualConsole *vc,
     GtkWidget *box;
     GtkWidget *scrollbar;
     GtkAdjustment *vadjustment;
-    VCChardev *vcd =3D (VCChardev *)chr;
+    VCChardev *vcd =3D VC_CHARDEV(chr);
=20
     vc->s =3D s;
     vc->vte.echo =3D vcd->echo;
@@ -2347,7 +2352,7 @@ void early_gtk_display_init(int opengl)
     }
=20
 #if defined(CONFIG_VTE)
-    /* overwrite the console.c vc driver */
+    type_register(&char_gd_vc_type_info);
     register_char_driver(&gd_vc_driver);
 #endif
 }
diff --git a/vl.c b/vl.c
index 8296f8da49..144a472990 100644
--- a/vl.c
+++ b/vl.c
@@ -4315,6 +4315,8 @@ int main(int argc, char **argv, char **envp)
         sdl_display_early_init(request_opengl);
     }
=20
+    qemu_console_early_init();
+
     if (request_opengl =3D=3D 1 && display_opengl =3D=3D 0) {
 #if defined(CONFIG_OPENGL)
         error_report("OpenGL is not supported by the display");
--=20
2.11.0

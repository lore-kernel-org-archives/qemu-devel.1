Received: from eggs.gnu.org ([2001:4830:134:3::10]:47374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cR0XJ-0005KO-AU
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cR0XD-0007qV-KS
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cR0XD-0007py-3x
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:35 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32D7561BB3
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 17:48:35 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Jan 2017 18:48:01 +0100
Message-Id: <20170110174810.17748-12-marcandre.lureau@redhat.com>
In-Reply-To: <20170110174810.17748-1-marcandre.lureau@redhat.com>
References: <20170110174810.17748-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 11/20] char: allocate CharDriverState as a
 single object
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

Use a single allocation for CharDriverState, this avoids extra
allocations & pointers, and is a step towards more object-oriented
CharDriver.

Gtk console is a bit peculiar, gd_vc_chr_set_echo() used to have a
temporary VirtualConsole to save the echo bit. Instead now, we consider
whether vcd->console is set or not, and restore the echo bit saved in
VCDriverState when calling gd_vc_vte_init().

The casts added are temporary, they are replaced with QOM type-safe
macros in a later patch in this series.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/sysemu/char.h |   2 +-
 backends/baum.c       |  23 ++---
 backends/msmouse.c    |  16 +--
 backends/testdev.c    |  22 ++--
 gdbstub.c             |   1 +
 hw/bt/hci-csr.c       |  10 +-
 qemu-char.c           | 280 ++++++++++++++++++++++++++------------------=
------
 spice-qemu-char.c     |  39 +++----
 ui/console.c          |  21 ++--
 ui/gtk.c              |  30 ++++--
 10 files changed, 230 insertions(+), 214 deletions(-)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index b0b4231d4c..8bb94e5d6e 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -93,7 +93,6 @@ struct CharDriverState {
     const CharDriver *driver;
     QemuMutex chr_write_lock;
     CharBackend *be;
-    void *opaque;
     char *label;
     char *filename;
     int logfd;
@@ -484,6 +483,7 @@ struct CharDriver {
                                ChardevBackend *backend,
                                ChardevReturn *ret, bool *be_opened,
                                Error **errp);
+    size_t instance_size;
=20
     int (*chr_write)(struct CharDriverState *s, const uint8_t *buf, int =
len);
     int (*chr_sync_read)(struct CharDriverState *s,
diff --git a/backends/baum.c b/backends/baum.c
index 109469e8f7..4b48cf02b9 100644
--- a/backends/baum.c
+++ b/backends/baum.c
@@ -85,7 +85,7 @@
 #define BUF_SIZE 256
=20
 typedef struct {
-    CharDriverState *chr;
+    CharDriverState parent;
=20
     brlapi_handle_t *brlapi;
     int brlapi_fd;
@@ -255,7 +255,7 @@ static int baum_deferred_init(BaumDriverState *baum)
 /* The serial port can receive more of our data */
 static void baum_accept_input(struct CharDriverState *chr)
 {
-    BaumDriverState *baum =3D chr->opaque;
+    BaumDriverState *baum =3D (BaumDriverState *)chr;
     int room, first;
=20
     if (!baum->out_buf_used)
@@ -281,22 +281,23 @@ static void baum_accept_input(struct CharDriverStat=
e *chr)
 /* We want to send a packet */
 static void baum_write_packet(BaumDriverState *baum, const uint8_t *buf,=
 int len)
 {
+    CharDriverState *chr =3D (CharDriverState *)baum;
     uint8_t io_buf[1 + 2 * len], *cur =3D io_buf;
     int room;
     *cur++ =3D ESC;
     while (len--)
         if ((*cur++ =3D *buf++) =3D=3D ESC)
             *cur++ =3D ESC;
-    room =3D qemu_chr_be_can_write(baum->chr);
+    room =3D qemu_chr_be_can_write(chr);
     len =3D cur - io_buf;
     if (len <=3D room) {
         /* Fits */
-        qemu_chr_be_write(baum->chr, io_buf, len);
+        qemu_chr_be_write(chr, io_buf, len);
     } else {
         int first;
         uint8_t out;
         /* Can't fit all, send what can be, and store the rest. */
-        qemu_chr_be_write(baum->chr, io_buf, room);
+        qemu_chr_be_write(chr, io_buf, room);
         len -=3D room;
         cur =3D io_buf + room;
         if (len > BUF_SIZE - baum->out_buf_used) {
@@ -471,7 +472,7 @@ static int baum_eat_packet(BaumDriverState *baum, con=
st uint8_t *buf, int len)
 /* The other end is writing some data.  Store it and try to interpret */
 static int baum_write(CharDriverState *chr, const uint8_t *buf, int len)
 {
-    BaumDriverState *baum =3D chr->opaque;
+    BaumDriverState *baum =3D (BaumDriverState *)chr;
     int tocopy, cur, eaten, orig_len =3D len;
=20
     if (!len)
@@ -612,14 +613,13 @@ static void baum_chr_read(void *opaque)
=20
 static void baum_free(struct CharDriverState *chr)
 {
-    BaumDriverState *baum =3D chr->opaque;
+    BaumDriverState *baum =3D (BaumDriverState *)chr;
=20
     timer_free(baum->cellCount_timer);
     if (baum->brlapi) {
         brlapi__closeConnection(baum->brlapi);
         g_free(baum->brlapi);
     }
-    g_free(baum);
 }
=20
 static CharDriverState *chr_baum_init(const CharDriver *driver,
@@ -638,10 +638,7 @@ static CharDriverState *chr_baum_init(const CharDriv=
er *driver,
     if (!chr) {
         return NULL;
     }
-    baum =3D g_malloc0(sizeof(BaumDriverState));
-    baum->chr =3D chr;
-
-    chr->opaque =3D baum;
+    baum =3D (BaumDriverState *)chr;
=20
     handle =3D g_malloc0(brlapi_getHandleSize());
     baum->brlapi =3D handle;
@@ -663,13 +660,13 @@ static CharDriverState *chr_baum_init(const CharDri=
ver *driver,
 fail_handle:
     g_free(handle);
     g_free(chr);
-    g_free(baum);
     return NULL;
 }
=20
 static void register_types(void)
 {
     static const CharDriver driver =3D {
+        .instance_size =3D sizeof(BaumDriverState),
         .kind =3D CHARDEV_BACKEND_KIND_BRAILLE,
         .create =3D chr_baum_init,
         .chr_write =3D baum_write,
diff --git a/backends/msmouse.c b/backends/msmouse.c
index 2c238ba1b3..30087b358f 100644
--- a/backends/msmouse.c
+++ b/backends/msmouse.c
@@ -31,7 +31,8 @@
 #define MSMOUSE_HI2(n) (((n) & 0xc0) >> 6)
=20
 typedef struct {
-    CharDriverState *chr;
+    CharDriverState parent;
+
     QemuInputHandlerState *hs;
     int axis[INPUT_AXIS__MAX];
     bool btns[INPUT_BUTTON__MAX];
@@ -42,7 +43,7 @@ typedef struct {
=20
 static void msmouse_chr_accept_input(CharDriverState *chr)
 {
-    MouseState *mouse =3D chr->opaque;
+    MouseState *mouse =3D (MouseState *)chr;
     int len;
=20
     len =3D qemu_chr_be_can_write(chr);
@@ -122,9 +123,10 @@ static void msmouse_input_event(DeviceState *dev, Qe=
muConsole *src,
 static void msmouse_input_sync(DeviceState *dev)
 {
     MouseState *mouse =3D (MouseState *)dev;
+    CharDriverState *chr =3D (CharDriverState *)dev;
=20
     msmouse_queue_event(mouse);
-    msmouse_chr_accept_input(mouse->chr);
+    msmouse_chr_accept_input(chr);
 }
=20
 static int msmouse_chr_write (struct CharDriverState *s, const uint8_t *=
buf, int len)
@@ -135,10 +137,9 @@ static int msmouse_chr_write (struct CharDriverState=
 *s, const uint8_t *buf, int
=20
 static void msmouse_chr_free(struct CharDriverState *chr)
 {
-    MouseState *mouse =3D chr->opaque;
+    MouseState *mouse =3D (MouseState *)chr;
=20
     qemu_input_handler_unregister(mouse->hs);
-    g_free(mouse);
 }
=20
 static QemuInputHandler msmouse_handler =3D {
@@ -165,12 +166,10 @@ static CharDriverState *qemu_chr_open_msmouse(const=
 CharDriver *driver,
     }
     *be_opened =3D false;
=20
-    mouse =3D g_new0(MouseState, 1);
+    mouse =3D (MouseState *)chr;
     mouse->hs =3D qemu_input_handler_register((DeviceState *)mouse,
                                             &msmouse_handler);
=20
-    mouse->chr =3D chr;
-    chr->opaque =3D mouse;
=20
     return chr;
 }
@@ -178,6 +177,7 @@ static CharDriverState *qemu_chr_open_msmouse(const C=
harDriver *driver,
 static void register_types(void)
 {
     static const CharDriver driver =3D {
+        .instance_size =3D sizeof(MouseState),
         .kind =3D CHARDEV_BACKEND_KIND_MSMOUSE,
         .create =3D qemu_chr_open_msmouse,
         .chr_write =3D msmouse_chr_write,
diff --git a/backends/testdev.c b/backends/testdev.c
index 233969391b..dfa4fe14a1 100644
--- a/backends/testdev.c
+++ b/backends/testdev.c
@@ -30,7 +30,8 @@
 #define BUF_SIZE 32
=20
 typedef struct {
-    CharDriverState *chr;
+    CharDriverState parent;
+
     uint8_t in_buf[32];
     int in_buf_used;
 } TestdevCharState;
@@ -79,7 +80,7 @@ static int testdev_eat_packet(TestdevCharState *testdev=
)
 /* The other end is writing some data.  Store it and try to interpret */
 static int testdev_write(CharDriverState *chr, const uint8_t *buf, int l=
en)
 {
-    TestdevCharState *testdev =3D chr->opaque;
+    TestdevCharState *testdev =3D (TestdevCharState *)chr;
     int tocopy, eaten, orig_len =3D len;
=20
     while (len) {
@@ -102,13 +103,6 @@ static int testdev_write(CharDriverState *chr, const=
 uint8_t *buf, int len)
     return orig_len;
 }
=20
-static void testdev_free(struct CharDriverState *chr)
-{
-    TestdevCharState *testdev =3D chr->opaque;
-
-    g_free(testdev);
-}
-
 static CharDriverState *chr_testdev_init(const CharDriver *driver,
                                          const char *id,
                                          ChardevBackend *backend,
@@ -116,14 +110,10 @@ static CharDriverState *chr_testdev_init(const Char=
Driver *driver,
                                          bool *be_opened,
                                          Error **errp)
 {
-    TestdevCharState *testdev;
-    CharDriverState *chr;
-
-    testdev =3D g_new0(TestdevCharState, 1);
-    testdev->chr =3D chr =3D g_new0(CharDriverState, 1);
+    TestdevCharState *testdev =3D g_new0(TestdevCharState, 1);;
+    CharDriverState *chr =3D (CharDriverState *)testdev;
=20
     chr->driver =3D driver;
-    chr->opaque =3D testdev;
=20
     return chr;
 }
@@ -131,10 +121,10 @@ static CharDriverState *chr_testdev_init(const Char=
Driver *driver,
 static void register_types(void)
 {
     static const CharDriver driver =3D {
+        .instance_size =3D sizeof(TestdevCharState),
         .kind =3D CHARDEV_BACKEND_KIND_TESTDEV,
         .create =3D chr_testdev_init,
         .chr_write =3D testdev_write,
-        .chr_free =3D testdev_free,
     };
     register_char_driver(&driver);
 }
diff --git a/gdbstub.c b/gdbstub.c
index 96363b36c8..7f136834ed 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1731,6 +1731,7 @@ int gdbserver_start(const char *device)
     CharDriverState *mon_chr;
     ChardevCommon common =3D { 0 };
     static const CharDriver driver =3D {
+        .instance_size =3D sizeof(CharDriverState),
         .kind =3D -1,
         .chr_write =3D gdb_monitor_write,
     };
diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
index 9c3fb3c8f9..bf2deb0497 100644
--- a/hw/bt/hci-csr.c
+++ b/hw/bt/hci-csr.c
@@ -28,11 +28,11 @@
 #include "hw/bt.h"
=20
 struct csrhci_s {
+    CharDriverState chr;
     int enable;
     qemu_irq *pins;
     int pin_state;
     int modem_state;
-    CharDriverState chr;
 #define FIFO_LEN	4096
     int out_start;
     int out_len;
@@ -314,7 +314,7 @@ static void csrhci_ready_for_next_inpkt(struct csrhci=
_s *s)
 static int csrhci_write(struct CharDriverState *chr,
                 const uint8_t *buf, int len)
 {
-    struct csrhci_s *s =3D (struct csrhci_s *) chr->opaque;
+    struct csrhci_s *s =3D (struct csrhci_s *)chr;
     int total =3D 0;
=20
     if (!s->enable)
@@ -387,7 +387,7 @@ static void csrhci_out_hci_packet_acl(void *opaque,
 static int csrhci_ioctl(struct CharDriverState *chr, int cmd, void *arg)
 {
     QEMUSerialSetParams *ssp;
-    struct csrhci_s *s =3D (struct csrhci_s *) chr->opaque;
+    struct csrhci_s *s =3D (struct csrhci_s *) chr;
     int prev_state =3D s->modem_state;
=20
     switch (cmd) {
@@ -455,7 +455,7 @@ static void csrhci_pins(void *opaque, int line, int l=
evel)
=20
 qemu_irq *csrhci_pins_get(CharDriverState *chr)
 {
-    struct csrhci_s *s =3D (struct csrhci_s *) chr->opaque;
+    struct csrhci_s *s =3D (struct csrhci_s *) chr;
=20
     return s->pins;
 }
@@ -463,6 +463,7 @@ qemu_irq *csrhci_pins_get(CharDriverState *chr)
 CharDriverState *uart_hci_init(void)
 {
     static const CharDriver hci_driver =3D {
+        .instance_size =3D sizeof(struct csrhci_s),
         .kind =3D -1,
         .chr_write =3D csrhci_write,
         .chr_ioctl =3D csrhci_ioctl,
@@ -470,7 +471,6 @@ CharDriverState *uart_hci_init(void)
     struct csrhci_s *s =3D (struct csrhci_s *)
             g_malloc0(sizeof(struct csrhci_s));
=20
-    s->chr.opaque =3D s;
     s->chr.driver =3D &hci_driver;
=20
     s->hci =3D qemu_next_hci();
diff --git a/qemu-char.c b/qemu-char.c
index 0976d94c1f..7a93a8267c 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -165,12 +165,14 @@ static void qemu_chr_free_common(CharDriverState *c=
hr);
 CharDriverState *qemu_chr_alloc(const CharDriver *driver,
                                 ChardevCommon *backend, Error **errp)
 {
-    CharDriverState *chr =3D g_malloc0(sizeof(CharDriverState));
-    qemu_mutex_init(&chr->chr_write_lock);
+    CharDriverState *chr;
=20
     assert(driver);
     assert(driver->chr_write);
+    assert(driver->instance_size >=3D sizeof(CharDriverState));
=20
+    chr =3D g_malloc0(driver->instance_size);
+    qemu_mutex_init(&chr->chr_write_lock);
     if (backend->has_logfile) {
         int flags =3D O_WRONLY | O_CREAT;
         if (backend->has_logappend &&
@@ -536,6 +538,7 @@ static CharDriverState *qemu_chr_open_null(const Char=
Driver *driver,
 }
=20
 static const CharDriver null_driver =3D {
+    .instance_size =3D sizeof(CharDriverState),
     .kind =3D CHARDEV_BACKEND_KIND_NULL,
     .create =3D qemu_chr_open_null,
     .chr_write =3D null_chr_write,
@@ -546,6 +549,7 @@ static const CharDriver null_driver =3D {
 #define MUX_BUFFER_SIZE 32	/* Must be a power of 2.  */
 #define MUX_BUFFER_MASK (MUX_BUFFER_SIZE - 1)
 struct MuxDriver {
+    CharDriverState parent;
     CharBackend *backends[MAX_MUX];
     CharBackend chr;
     int focus;
@@ -568,7 +572,7 @@ struct MuxDriver {
 /* Called with chr_write_lock held.  */
 static int mux_chr_write(CharDriverState *chr, const uint8_t *buf, int l=
en)
 {
-    MuxDriver *d =3D chr->opaque;
+    MuxDriver *d =3D (MuxDriver *)chr;
     int ret;
     if (!d->timestamps) {
         ret =3D qemu_chr_fe_write(&d->chr, buf, len);
@@ -702,7 +706,7 @@ static int mux_proc_byte(CharDriverState *chr, MuxDri=
ver *d, int ch)
=20
 static void mux_chr_accept_input(CharDriverState *chr)
 {
-    MuxDriver *d =3D chr->opaque;
+    MuxDriver *d =3D (MuxDriver *)chr;
     int m =3D d->focus;
     CharBackend *be =3D d->backends[m];
=20
@@ -715,8 +719,7 @@ static void mux_chr_accept_input(CharDriverState *chr=
)
=20
 static int mux_chr_can_read(void *opaque)
 {
-    CharDriverState *chr =3D opaque;
-    MuxDriver *d =3D chr->opaque;
+    MuxDriver *d =3D opaque;
     int m =3D d->focus;
     CharBackend *be =3D d->backends[m];
=20
@@ -734,7 +737,7 @@ static int mux_chr_can_read(void *opaque)
 static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
 {
     CharDriverState *chr =3D opaque;
-    MuxDriver *d =3D chr->opaque;
+    MuxDriver *d =3D opaque;
     int m =3D d->focus;
     CharBackend *be =3D d->backends[m];
     int i;
@@ -756,8 +759,7 @@ static bool muxes_realized;
=20
 static void mux_chr_event(void *opaque, int event)
 {
-    CharDriverState *chr =3D opaque;
-    MuxDriver *d =3D chr->opaque;
+    MuxDriver *d =3D opaque;
     int i;
=20
     if (!muxes_realized) {
@@ -787,7 +789,7 @@ static void muxes_realize_done(Notifier *notifier, vo=
id *unused)
=20
     QTAILQ_FOREACH(chr, &chardevs, next) {
         if (qemu_chr_get_kind(chr) =3D=3D CHARDEV_BACKEND_KIND_MUX) {
-            MuxDriver *d =3D chr->opaque;
+            MuxDriver *d =3D (MuxDriver *)chr;
             int i;
=20
             /* send OPENED to all already-attached FEs */
@@ -809,7 +811,7 @@ static Notifier muxes_realize_notify =3D {
=20
 static GSource *mux_chr_add_watch(CharDriverState *s, GIOCondition cond)
 {
-    MuxDriver *d =3D s->opaque;
+    MuxDriver *d =3D (MuxDriver *)s;
     CharDriverState *chr =3D qemu_chr_fe_get_driver(&d->chr);
=20
     if (!chr->driver->chr_add_watch) {
@@ -821,7 +823,7 @@ static GSource *mux_chr_add_watch(CharDriverState *s,=
 GIOCondition cond)
=20
 static void mux_chr_free(struct CharDriverState *chr)
 {
-    MuxDriver *d =3D chr->opaque;
+    MuxDriver *d =3D (MuxDriver *)chr;
     int i;
=20
     for (i =3D 0; i < d->mux_cnt; i++) {
@@ -831,12 +833,11 @@ static void mux_chr_free(struct CharDriverState *ch=
r)
         }
     }
     qemu_chr_fe_deinit(&d->chr);
-    g_free(d);
 }
=20
 static void mux_chr_set_handlers(CharDriverState *chr, GMainContext *con=
text)
 {
-    MuxDriver *d =3D chr->opaque;
+    MuxDriver *d =3D (MuxDriver *)chr;
=20
     /* Fix up the real driver with mux routines */
     qemu_chr_fe_set_handlers(&d->chr,
@@ -849,7 +850,7 @@ static void mux_chr_set_handlers(CharDriverState *chr=
, GMainContext *context)
=20
 static void mux_set_focus(CharDriverState *chr, int focus)
 {
-    MuxDriver *d =3D chr->opaque;
+    MuxDriver *d =3D (MuxDriver *)chr;
=20
     assert(focus >=3D 0);
     assert(focus < d->mux_cnt);
@@ -885,9 +886,7 @@ static CharDriverState *qemu_chr_open_mux(const CharD=
river *driver,
     if (!chr) {
         return NULL;
     }
-    d =3D g_new0(MuxDriver, 1);
-
-    chr->opaque =3D d;
+    d =3D (MuxDriver *)chr;
     d->focus =3D -1;
     /* only default to opened state if we've realized the initial
      * set of muxes
@@ -911,7 +910,7 @@ bool qemu_chr_fe_init(CharBackend *b, CharDriverState=
 *s, Error **errp)
     int tag =3D 0;
=20
     if (qemu_chr_get_kind(s) =3D=3D CHARDEV_BACKEND_KIND_MUX) {
-        MuxDriver *d =3D s->opaque;
+        MuxDriver *d =3D (MuxDriver *)s;
=20
         if (d->mux_cnt >=3D MAX_MUX) {
             goto unavailable;
@@ -938,7 +937,7 @@ unavailable:
 static bool qemu_chr_is_busy(CharDriverState *s)
 {
     if (qemu_chr_get_kind(s) =3D=3D CHARDEV_BACKEND_KIND_MUX) {
-        MuxDriver *d =3D s->opaque;
+        MuxDriver *d =3D (MuxDriver *)s;
         return d->mux_cnt >=3D 0;
     } else {
         return s->be !=3D NULL;
@@ -955,7 +954,7 @@ void qemu_chr_fe_deinit(CharBackend *b)
             b->chr->be =3D NULL;
         }
         if (qemu_chr_get_kind(b->chr) =3D=3D CHARDEV_BACKEND_KIND_MUX) {
-            MuxDriver *d =3D b->chr->opaque;
+            MuxDriver *d =3D (MuxDriver *)b->chr;
             d->backends[b->tag] =3D NULL;
         }
         b->chr =3D NULL;
@@ -1195,6 +1194,7 @@ static int io_channel_send(QIOChannel *ioc, const v=
oid *buf, size_t len)
=20
=20
 typedef struct FDCharDriver {
+    CharDriverState parent;
     CharDriverState *chr;
     QIOChannel *ioc_in, *ioc_out;
     int max_size;
@@ -1203,15 +1203,15 @@ typedef struct FDCharDriver {
 /* Called with chr_write_lock held.  */
 static int fd_chr_write(CharDriverState *chr, const uint8_t *buf, int le=
n)
 {
-    FDCharDriver *s =3D chr->opaque;
-   =20
+    FDCharDriver *s =3D (FDCharDriver *)chr;
+
     return io_channel_send(s->ioc_out, buf, len);
 }
=20
 static gboolean fd_chr_read(QIOChannel *chan, GIOCondition cond, void *o=
paque)
 {
     CharDriverState *chr =3D opaque;
-    FDCharDriver *s =3D chr->opaque;
+    FDCharDriver *s =3D opaque;
     int len;
     uint8_t buf[READ_BUF_LEN];
     ssize_t ret;
@@ -1241,7 +1241,7 @@ static gboolean fd_chr_read(QIOChannel *chan, GIOCo=
ndition cond, void *opaque)
 static int fd_chr_read_poll(void *opaque)
 {
     CharDriverState *chr =3D opaque;
-    FDCharDriver *s =3D chr->opaque;
+    FDCharDriver *s =3D opaque;
=20
     s->max_size =3D qemu_chr_be_can_write(chr);
     return s->max_size;
@@ -1249,14 +1249,14 @@ static int fd_chr_read_poll(void *opaque)
=20
 static GSource *fd_chr_add_watch(CharDriverState *chr, GIOCondition cond=
)
 {
-    FDCharDriver *s =3D chr->opaque;
+    FDCharDriver *s =3D (FDCharDriver *)chr;
     return qio_channel_create_watch(s->ioc_out, cond);
 }
=20
 static void fd_chr_update_read_handler(CharDriverState *chr,
                                        GMainContext *context)
 {
-    FDCharDriver *s =3D chr->opaque;
+    FDCharDriver *s =3D (FDCharDriver *)chr;
=20
     remove_fd_in_watch(chr);
     if (s->ioc_in) {
@@ -1269,7 +1269,7 @@ static void fd_chr_update_read_handler(CharDriverSt=
ate *chr,
=20
 static void fd_chr_free(struct CharDriverState *chr)
 {
-    FDCharDriver *s =3D chr->opaque;
+    FDCharDriver *s =3D (FDCharDriver *)chr;
=20
     remove_fd_in_watch(chr);
     if (s->ioc_in) {
@@ -1279,7 +1279,6 @@ static void fd_chr_free(struct CharDriverState *chr=
)
         object_unref(OBJECT(s->ioc_out));
     }
=20
-    g_free(s);
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
=20
@@ -1296,7 +1295,7 @@ static CharDriverState *qemu_chr_open_fd(const Char=
Driver *driver,
     if (!chr) {
         return NULL;
     }
-    s =3D g_new0(FDCharDriver, 1);
+    s =3D (FDCharDriver *)chr;
     s->ioc_in =3D QIO_CHANNEL(qio_channel_file_new_fd(fd_in));
     name =3D g_strdup_printf("chardev-file-in-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(s->ioc_in), name);
@@ -1307,7 +1306,6 @@ static CharDriverState *qemu_chr_open_fd(const Char=
Driver *driver,
     g_free(name);
     qemu_set_nonblock(fd_out);
     s->chr =3D chr;
-    chr->opaque =3D s;
=20
     return chr;
 }
@@ -1448,6 +1446,7 @@ static CharDriverState *qemu_chr_open_stdio(const C=
harDriver *driver,
 #define HAVE_CHARDEV_PTY 1
=20
 typedef struct {
+    CharDriverState parent;
     QIOChannel *ioc;
     int read_bytes;
=20
@@ -1463,7 +1462,7 @@ static void pty_chr_state(CharDriverState *chr, int=
 connected);
 static gboolean pty_chr_timer(gpointer opaque)
 {
     struct CharDriverState *chr =3D opaque;
-    PtyCharDriver *s =3D chr->opaque;
+    PtyCharDriver *s =3D opaque;
=20
     qemu_mutex_lock(&chr->chr_write_lock);
     s->timer_tag =3D 0;
@@ -1479,7 +1478,7 @@ static gboolean pty_chr_timer(gpointer opaque)
 /* Called with chr_write_lock held.  */
 static void pty_chr_rearm_timer(CharDriverState *chr, int ms)
 {
-    PtyCharDriver *s =3D chr->opaque;
+    PtyCharDriver *s =3D (PtyCharDriver *)chr;
     char *name;
=20
     if (s->timer_tag) {
@@ -1501,7 +1500,7 @@ static void pty_chr_rearm_timer(CharDriverState *ch=
r, int ms)
 /* Called with chr_write_lock held.  */
 static void pty_chr_update_read_handler_locked(CharDriverState *chr)
 {
-    PtyCharDriver *s =3D chr->opaque;
+    PtyCharDriver *s =3D (PtyCharDriver *)chr;
     GPollFD pfd;
     int rc;
     QIOChannelFile *fioc =3D QIO_CHANNEL_FILE(s->ioc);
@@ -1532,7 +1531,7 @@ static void pty_chr_update_read_handler(CharDriverS=
tate *chr,
 /* Called with chr_write_lock held.  */
 static int pty_chr_write(CharDriverState *chr, const uint8_t *buf, int l=
en)
 {
-    PtyCharDriver *s =3D chr->opaque;
+    PtyCharDriver *s =3D (PtyCharDriver *)chr;
=20
     if (!s->connected) {
         /* guest sends data, check for (re-)connect */
@@ -1546,7 +1545,7 @@ static int pty_chr_write(CharDriverState *chr, cons=
t uint8_t *buf, int len)
=20
 static GSource *pty_chr_add_watch(CharDriverState *chr, GIOCondition con=
d)
 {
-    PtyCharDriver *s =3D chr->opaque;
+    PtyCharDriver *s =3D (PtyCharDriver *)chr;
     if (!s->connected) {
         return NULL;
     }
@@ -1556,7 +1555,7 @@ static GSource *pty_chr_add_watch(CharDriverState *=
chr, GIOCondition cond)
 static int pty_chr_read_poll(void *opaque)
 {
     CharDriverState *chr =3D opaque;
-    PtyCharDriver *s =3D chr->opaque;
+    PtyCharDriver *s =3D opaque;
=20
     s->read_bytes =3D qemu_chr_be_can_write(chr);
     return s->read_bytes;
@@ -1565,7 +1564,7 @@ static int pty_chr_read_poll(void *opaque)
 static gboolean pty_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
 {
     CharDriverState *chr =3D opaque;
-    PtyCharDriver *s =3D chr->opaque;
+    PtyCharDriver *s =3D opaque;
     gsize len;
     uint8_t buf[READ_BUF_LEN];
     ssize_t ret;
@@ -1590,7 +1589,7 @@ static gboolean pty_chr_read(QIOChannel *chan, GIOC=
ondition cond, void *opaque)
 static gboolean qemu_chr_be_generic_open_func(gpointer opaque)
 {
     CharDriverState *chr =3D opaque;
-    PtyCharDriver *s =3D chr->opaque;
+    PtyCharDriver *s =3D opaque;
=20
     s->open_tag =3D 0;
     qemu_chr_be_generic_open(chr);
@@ -1600,7 +1599,7 @@ static gboolean qemu_chr_be_generic_open_func(gpoin=
ter opaque)
 /* Called with chr_write_lock held.  */
 static void pty_chr_state(CharDriverState *chr, int connected)
 {
-    PtyCharDriver *s =3D chr->opaque;
+    PtyCharDriver *s =3D (PtyCharDriver *)chr;
=20
     if (!connected) {
         if (s->open_tag) {
@@ -1634,7 +1633,7 @@ static void pty_chr_state(CharDriverState *chr, int=
 connected)
=20
 static void pty_chr_free(struct CharDriverState *chr)
 {
-    PtyCharDriver *s =3D chr->opaque;
+    PtyCharDriver *s =3D (PtyCharDriver *)chr;
=20
     qemu_mutex_lock(&chr->chr_write_lock);
     pty_chr_state(chr, 0);
@@ -1644,7 +1643,6 @@ static void pty_chr_free(struct CharDriverState *ch=
r)
         s->timer_tag =3D 0;
     }
     qemu_mutex_unlock(&chr->chr_write_lock);
-    g_free(s);
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
=20
@@ -1684,20 +1682,19 @@ static CharDriverState *qemu_chr_open_pty(const C=
harDriver *driver,
     fprintf(stderr, "char device redirected to %s (label %s)\n",
             pty_name, id);
=20
-    s =3D g_new0(PtyCharDriver, 1);
-    chr->opaque =3D s;
-    *be_opened =3D false;
-
+    s =3D (PtyCharDriver *)chr;
     s->ioc =3D QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
     name =3D g_strdup_printf("chardev-pty-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(s->ioc), name);
     g_free(name);
     s->timer_tag =3D 0;
+    *be_opened =3D false;
=20
     return chr;
 }
=20
 static const CharDriver pty_driver =3D {
+    .instance_size =3D sizeof(PtyCharDriver),
     .kind =3D CHARDEV_BACKEND_KIND_PTY,
     .create =3D qemu_chr_open_pty,
     .chr_write =3D pty_chr_write,
@@ -1823,7 +1820,7 @@ static void tty_serial_init(int fd, int speed,
=20
 static int tty_serial_ioctl(CharDriverState *chr, int cmd, void *arg)
 {
-    FDCharDriver *s =3D chr->opaque;
+    FDCharDriver *s =3D (FDCharDriver *)chr;
     QIOChannelFile *fioc =3D QIO_CHANNEL_FILE(s->ioc_in);
=20
     switch(cmd) {
@@ -1902,6 +1899,7 @@ static void qemu_chr_free_tty(CharDriverState *chr)
 #define HAVE_CHARDEV_PARPORT 1
=20
 typedef struct {
+    CharDriverState parent;
     int fd;
     int mode;
 } ParallelCharDriver;
@@ -1919,7 +1917,7 @@ static int pp_hw_mode(ParallelCharDriver *s, uint16=
_t mode)
=20
 static int pp_ioctl(CharDriverState *chr, int cmd, void *arg)
 {
-    ParallelCharDriver *drv =3D chr->opaque;
+    ParallelCharDriver *drv =3D (ParallelCharDriver *)chr;
     int fd =3D drv->fd;
     uint8_t b;
=20
@@ -2000,13 +1998,12 @@ static int pp_ioctl(CharDriverState *chr, int cmd=
, void *arg)
=20
 static void pp_free(CharDriverState *chr)
 {
-    ParallelCharDriver *drv =3D chr->opaque;
+    ParallelCharDriver *drv =3D (ParallelCharDriver *)chr;
     int fd =3D drv->fd;
=20
     pp_hw_mode(drv, IEEE1284_MODE_COMPAT);
     ioctl(fd, PPRELEASE);
     close(fd);
-    g_free(drv);
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
=20
@@ -2030,9 +2027,7 @@ static CharDriverState *qemu_chr_open_pp_fd(const C=
harDriver *driver,
         return NULL;
     }
=20
-    drv =3D g_new0(ParallelCharDriver, 1);
-    chr->opaque =3D drv;
-
+    drv =3D (ParallelCharDriver *)chr;
     drv->fd =3D fd;
     drv->mode =3D IEEE1284_MODE_COMPAT;
=20
@@ -2044,35 +2039,45 @@ static CharDriverState *qemu_chr_open_pp_fd(const=
 CharDriver *driver,
=20
 #define HAVE_CHARDEV_PARPORT 1
=20
+typedef struct {
+    CharDriverState parent;
+    int fd;
+} ParallelCharDriver;
+
 static int pp_ioctl(CharDriverState *chr, int cmd, void *arg)
 {
-    int fd =3D (int)(intptr_t)chr->opaque;
+    ParallelCharDriver *drv =3D (ParallelCharDriver *)chr;
     uint8_t b;
=20
-    switch(cmd) {
+    switch (cmd) {
     case CHR_IOCTL_PP_READ_DATA:
-        if (ioctl(fd, PPIGDATA, &b) < 0)
+        if (ioctl(drv->fd, PPIGDATA, &b) < 0) {
             return -ENOTSUP;
+        }
         *(uint8_t *)arg =3D b;
         break;
     case CHR_IOCTL_PP_WRITE_DATA:
         b =3D *(uint8_t *)arg;
-        if (ioctl(fd, PPISDATA, &b) < 0)
+        if (ioctl(drv->fd, PPISDATA, &b) < 0) {
             return -ENOTSUP;
+        }
         break;
     case CHR_IOCTL_PP_READ_CONTROL:
-        if (ioctl(fd, PPIGCTRL, &b) < 0)
+        if (ioctl(drv->fd, PPIGCTRL, &b) < 0) {
             return -ENOTSUP;
+        }
         *(uint8_t *)arg =3D b;
         break;
     case CHR_IOCTL_PP_WRITE_CONTROL:
         b =3D *(uint8_t *)arg;
-        if (ioctl(fd, PPISCTRL, &b) < 0)
+        if (ioctl(drv->fd, PPISCTRL, &b) < 0) {
             return -ENOTSUP;
+        }
         break;
     case CHR_IOCTL_PP_READ_STATUS:
-        if (ioctl(fd, PPIGSTATUS, &b) < 0)
+        if (ioctl(drv->fd, PPIGSTATUS, &b) < 0) {
             return -ENOTSUP;
+        }
         *(uint8_t *)arg =3D b;
         break;
     default:
@@ -2088,12 +2093,14 @@ static CharDriverState *qemu_chr_open_pp_fd(const=
 CharDriver *driver,
                                             Error **errp)
 {
     CharDriverState *chr;
+    ParallelCharDriver *drv;
=20
     chr =3D qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
-    chr->opaque =3D (void *)(intptr_t)fd;
+    drv =3D (ParallelCharDriver *)chr;
+    drv->fd =3D fd;
     *be_opened =3D false;
     return chr;
 }
@@ -2104,6 +2111,7 @@ static CharDriverState *qemu_chr_open_pp_fd(const C=
harDriver *driver,
 #define HAVE_CHARDEV_SERIAL 1
=20
 typedef struct {
+    CharDriverState parent;
     int max_size;
     HANDLE hcom, hrecv, hsend;
     OVERLAPPED orecv;
@@ -2115,6 +2123,7 @@ typedef struct {
 } WinCharState;
=20
 typedef struct {
+    CharDriverState parent;
     HANDLE  hStdIn;
     HANDLE  hInputReadyEvent;
     HANDLE  hInputDoneEvent;
@@ -2132,7 +2141,7 @@ static int win_chr_pipe_poll(void *opaque);
=20
 static void win_chr_free(CharDriverState *chr)
 {
-    WinCharState *s =3D chr->opaque;
+    WinCharState *s =3D (WinCharState *)chr;
=20
     if (s->hsend) {
         CloseHandle(s->hsend);
@@ -2156,7 +2165,7 @@ static void win_chr_free(CharDriverState *chr)
=20
 static int win_chr_init(CharDriverState *chr, const char *filename, Erro=
r **errp)
 {
-    WinCharState *s =3D chr->opaque;
+    WinCharState *s =3D (WinCharState *)chr;
     COMMCONFIG comcfg;
     COMMTIMEOUTS cto =3D { 0, 0, 0, 0, 0};
     COMSTAT comstat;
@@ -2224,7 +2233,7 @@ static int win_chr_init(CharDriverState *chr, const=
 char *filename, Error **errp
 /* Called with chr_write_lock held.  */
 static int win_chr_write(CharDriverState *chr, const uint8_t *buf, int l=
en1)
 {
-    WinCharState *s =3D chr->opaque;
+    WinCharState *s =3D (WinCharState *)chr;
     DWORD len, ret, size, err;
=20
     len =3D len1;
@@ -2258,7 +2267,7 @@ static int win_chr_write(CharDriverState *chr, cons=
t uint8_t *buf, int len1)
=20
 static int win_chr_read_poll(CharDriverState *chr)
 {
-    WinCharState *s =3D chr->opaque;
+    WinCharState *s =3D (WinCharState *)chr;
=20
     s->max_size =3D qemu_chr_be_can_write(chr);
     return s->max_size;
@@ -2266,7 +2275,7 @@ static int win_chr_read_poll(CharDriverState *chr)
=20
 static void win_chr_readfile(CharDriverState *chr)
 {
-    WinCharState *s =3D chr->opaque;
+    WinCharState *s =3D (WinCharState *)chr;
     int ret, err;
     uint8_t buf[READ_BUF_LEN];
     DWORD size;
@@ -2288,7 +2297,7 @@ static void win_chr_readfile(CharDriverState *chr)
=20
 static void win_chr_read(CharDriverState *chr)
 {
-    WinCharState *s =3D chr->opaque;
+    WinCharState *s =3D (WinCharState *)chr;
=20
     if (s->len > s->max_size)
         s->len =3D s->max_size;
@@ -2301,7 +2310,7 @@ static void win_chr_read(CharDriverState *chr)
 static int win_chr_poll(void *opaque)
 {
     CharDriverState *chr =3D opaque;
-    WinCharState *s =3D chr->opaque;
+    WinCharState *s =3D opaque;
     COMSTAT status;
     DWORD comerr;
=20
@@ -2318,7 +2327,7 @@ static int win_chr_poll(void *opaque)
 static int win_chr_pipe_poll(void *opaque)
 {
     CharDriverState *chr =3D opaque;
-    WinCharState *s =3D chr->opaque;
+    WinCharState *s =3D opaque;
     DWORD size;
=20
     PeekNamedPipe(s->hcom, NULL, 0, NULL, &size, NULL);
@@ -2334,7 +2343,7 @@ static int win_chr_pipe_poll(void *opaque)
 static int win_chr_pipe_init(CharDriverState *chr, const char *filename,
                              Error **errp)
 {
-    WinCharState *s =3D chr->opaque;
+    WinCharState *s =3D (WinCharState *)chr;
     OVERLAPPED ov;
     int ret;
     DWORD size;
@@ -2406,18 +2415,14 @@ static CharDriverState *qemu_chr_open_pipe(const =
CharDriver *driver,
     ChardevHostdev *opts =3D backend->u.pipe.data;
     const char *filename =3D opts->device;
     CharDriverState *chr;
-    WinCharState *s;
     ChardevCommon *common =3D qapi_ChardevHostdev_base(opts);
=20
     chr =3D qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
-    s =3D g_new0(WinCharState, 1);
-    chr->opaque =3D s;
=20
     if (win_chr_pipe_init(chr, filename, errp) < 0) {
-        g_free(s);
         qemu_chr_free_common(chr);
         return NULL;
     }
@@ -2436,9 +2441,8 @@ static CharDriverState *qemu_chr_open_win_file(cons=
t CharDriver *driver,
     if (!chr) {
         return NULL;
     }
-    s =3D g_new0(WinCharState, 1);
+    s =3D (WinCharState *)chr;
     s->hcom =3D fd_out;
-    chr->opaque =3D s;
     return chr;
 }
=20
@@ -2456,6 +2460,7 @@ static CharDriverState *qemu_chr_open_win_con(const=
 CharDriver *driver,
 }
=20
 static const CharDriver console_driver =3D {
+    .instance_size =3D sizeof(WinCharState),
     .kind =3D CHARDEV_BACKEND_KIND_CONSOLE,
     .create =3D qemu_chr_open_win_con,
     .chr_write =3D win_chr_write,
@@ -2483,7 +2488,7 @@ static int win_stdio_write(CharDriverState *chr, co=
nst uint8_t *buf, int len)
 static void win_stdio_wait_func(void *opaque)
 {
     CharDriverState   *chr   =3D opaque;
-    WinStdioCharState *stdio =3D chr->opaque;
+    WinStdioCharState *stdio =3D opaque;
     INPUT_RECORD       buf[4];
     int                ret;
     DWORD              dwSize;
@@ -2516,8 +2521,7 @@ static void win_stdio_wait_func(void *opaque)
=20
 static DWORD WINAPI win_stdio_thread(LPVOID param)
 {
-    CharDriverState   *chr   =3D param;
-    WinStdioCharState *stdio =3D chr->opaque;
+    WinStdioCharState *stdio =3D param;
     int                ret;
     DWORD              dwSize;
=20
@@ -2556,7 +2560,7 @@ static DWORD WINAPI win_stdio_thread(LPVOID param)
 static void win_stdio_thread_wait_func(void *opaque)
 {
     CharDriverState   *chr   =3D opaque;
-    WinStdioCharState *stdio =3D chr->opaque;
+    WinStdioCharState *stdio =3D opaque;
=20
     if (qemu_chr_be_can_write(chr)) {
         qemu_chr_be_write(chr, &stdio->win_stdio_buf, 1);
@@ -2567,7 +2571,7 @@ static void win_stdio_thread_wait_func(void *opaque=
)
=20
 static void qemu_chr_set_echo_win_stdio(CharDriverState *chr, bool echo)
 {
-    WinStdioCharState *stdio  =3D chr->opaque;
+    WinStdioCharState *stdio  =3D (WinStdioCharState *)chr;
     DWORD              dwMode =3D 0;
=20
     GetConsoleMode(stdio->hStdIn, &dwMode);
@@ -2581,7 +2585,7 @@ static void qemu_chr_set_echo_win_stdio(CharDriverS=
tate *chr, bool echo)
=20
 static void win_stdio_free(CharDriverState *chr)
 {
-    WinStdioCharState *stdio =3D chr->opaque;
+    WinStdioCharState *stdio =3D (WinStdioCharState *)chr;
=20
     if (stdio->hInputReadyEvent !=3D INVALID_HANDLE_VALUE) {
         CloseHandle(stdio->hInputReadyEvent);
@@ -2592,8 +2596,6 @@ static void win_stdio_free(CharDriverState *chr)
     if (stdio->hInputThread !=3D INVALID_HANDLE_VALUE) {
         TerminateThread(stdio->hInputThread, 0);
     }
-
-    g_free(chr->opaque);
 }
=20
 static CharDriverState *qemu_chr_open_stdio(const CharDriver *driver,
@@ -2613,7 +2615,7 @@ static CharDriverState *qemu_chr_open_stdio(const C=
harDriver *driver,
     if (!chr) {
         return NULL;
     }
-    stdio =3D g_new0(WinStdioCharState, 1);
+    stdio =3D (WinStdioCharState *)chr;
=20
     stdio->hStdIn =3D GetStdHandle(STD_INPUT_HANDLE);
     if (stdio->hStdIn =3D=3D INVALID_HANDLE_VALUE) {
@@ -2623,8 +2625,6 @@ static CharDriverState *qemu_chr_open_stdio(const C=
harDriver *driver,
=20
     is_console =3D GetConsoleMode(stdio->hStdIn, &dwMode) !=3D 0;
=20
-    chr->opaque    =3D stdio;
-
     if (is_console) {
         if (qemu_add_wait_object(stdio->hStdIn,
                                  win_stdio_wait_func, chr)) {
@@ -2684,6 +2684,7 @@ err1:
 /* UDP Net console */
=20
 typedef struct {
+    CharDriverState parent;
     QIOChannel *ioc;
     uint8_t buf[READ_BUF_LEN];
     int bufcnt;
@@ -2694,7 +2695,7 @@ typedef struct {
 /* Called with chr_write_lock held.  */
 static int udp_chr_write(CharDriverState *chr, const uint8_t *buf, int l=
en)
 {
-    NetCharDriver *s =3D chr->opaque;
+    NetCharDriver *s =3D (NetCharDriver *)chr;
=20
     return qio_channel_write(
         s->ioc, (const char *)buf, len, NULL);
@@ -2703,7 +2704,7 @@ static int udp_chr_write(CharDriverState *chr, cons=
t uint8_t *buf, int len)
 static int udp_chr_read_poll(void *opaque)
 {
     CharDriverState *chr =3D opaque;
-    NetCharDriver *s =3D chr->opaque;
+    NetCharDriver *s =3D opaque;
=20
     s->max_size =3D qemu_chr_be_can_write(chr);
=20
@@ -2721,7 +2722,7 @@ static int udp_chr_read_poll(void *opaque)
 static gboolean udp_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
 {
     CharDriverState *chr =3D opaque;
-    NetCharDriver *s =3D chr->opaque;
+    NetCharDriver *s =3D opaque;
     ssize_t ret;
=20
     if (s->max_size =3D=3D 0) {
@@ -2748,7 +2749,7 @@ static gboolean udp_chr_read(QIOChannel *chan, GIOC=
ondition cond, void *opaque)
 static void udp_chr_update_read_handler(CharDriverState *chr,
                                         GMainContext *context)
 {
-    NetCharDriver *s =3D chr->opaque;
+    NetCharDriver *s =3D (NetCharDriver *)chr;
=20
     remove_fd_in_watch(chr);
     if (s->ioc) {
@@ -2761,13 +2762,12 @@ static void udp_chr_update_read_handler(CharDrive=
rState *chr,
=20
 static void udp_chr_free(CharDriverState *chr)
 {
-    NetCharDriver *s =3D chr->opaque;
+    NetCharDriver *s =3D (NetCharDriver *)chr;
=20
     remove_fd_in_watch(chr);
     if (s->ioc) {
         object_unref(OBJECT(s->ioc));
     }
-    g_free(s);
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
=20
@@ -2775,6 +2775,7 @@ static void udp_chr_free(CharDriverState *chr)
 /* TCP Net console */
=20
 typedef struct {
+    CharDriverState parent;
     QIOChannel *ioc; /* Client I/O channel */
     QIOChannelSocket *sioc; /* Client master channel */
     QIOChannelSocket *listen_ioc;
@@ -2803,8 +2804,9 @@ static gboolean socket_reconnect_timeout(gpointer o=
paque);
=20
 static void qemu_chr_socket_restart_timer(CharDriverState *chr)
 {
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D (TCPCharDriver *)chr;
     char *name;
+
     assert(s->connected =3D=3D 0);
     s->reconnect_timer =3D g_timeout_add_seconds(s->reconnect_time,
                                                socket_reconnect_timeout,=
 chr);
@@ -2816,7 +2818,7 @@ static void qemu_chr_socket_restart_timer(CharDrive=
rState *chr)
 static void check_report_connect_error(CharDriverState *chr,
                                        Error *err)
 {
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D (TCPCharDriver *)chr;
=20
     if (!s->connect_err_reported) {
         error_report("Unable to connect character device %s: %s",
@@ -2833,7 +2835,8 @@ static gboolean tcp_chr_accept(QIOChannel *chan,
 /* Called with chr_write_lock held.  */
 static int tcp_chr_write(CharDriverState *chr, const uint8_t *buf, int l=
en)
 {
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D (TCPCharDriver *)chr;
+
     if (s->connected) {
         int ret =3D  io_channel_send_full(s->ioc, buf, len,
                                         s->write_msgfds,
@@ -2856,7 +2859,7 @@ static int tcp_chr_write(CharDriverState *chr, cons=
t uint8_t *buf, int len)
 static int tcp_chr_read_poll(void *opaque)
 {
     CharDriverState *chr =3D opaque;
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D opaque;
     if (!s->connected)
         return 0;
     s->max_size =3D qemu_chr_be_can_write(chr);
@@ -2915,7 +2918,8 @@ static void tcp_chr_process_IAC_bytes(CharDriverSta=
te *chr,
=20
 static int tcp_get_msgfds(CharDriverState *chr, int *fds, int num)
 {
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D (TCPCharDriver *)chr;
+
     int to_copy =3D (s->read_msgfds_num < num) ? s->read_msgfds_num : nu=
m;
=20
     assert(num <=3D TCP_MAX_FDS);
@@ -2940,7 +2944,7 @@ static int tcp_get_msgfds(CharDriverState *chr, int=
 *fds, int num)
=20
 static int tcp_set_msgfds(CharDriverState *chr, int *fds, int num)
 {
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D (TCPCharDriver *)chr;
=20
     /* clear old pending fd array */
     g_free(s->write_msgfds);
@@ -2965,7 +2969,7 @@ static int tcp_set_msgfds(CharDriverState *chr, int=
 *fds, int num)
=20
 static ssize_t tcp_chr_recv(CharDriverState *chr, char *buf, size_t len)
 {
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D (TCPCharDriver *)chr;
     struct iovec iov =3D { .iov_base =3D buf, .iov_len =3D len };
     int ret;
     size_t i;
@@ -3022,13 +3026,13 @@ static ssize_t tcp_chr_recv(CharDriverState *chr,=
 char *buf, size_t len)
=20
 static GSource *tcp_chr_add_watch(CharDriverState *chr, GIOCondition con=
d)
 {
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D (TCPCharDriver *)chr;
     return qio_channel_create_watch(s->ioc, cond);
 }
=20
 static void tcp_chr_free_connection(CharDriverState *chr)
 {
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D (TCPCharDriver *)chr;
     int i;
=20
     if (!s->connected) {
@@ -3057,7 +3061,7 @@ static void tcp_chr_free_connection(CharDriverState=
 *chr)
=20
 static void tcp_chr_disconnect(CharDriverState *chr)
 {
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D (TCPCharDriver *)chr;
=20
     if (!s->connected) {
         return;
@@ -3080,7 +3084,7 @@ static void tcp_chr_disconnect(CharDriverState *chr=
)
 static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
 {
     CharDriverState *chr =3D opaque;
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D opaque;
     uint8_t buf[READ_BUF_LEN];
     int len, size;
=20
@@ -3106,7 +3110,7 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOC=
ondition cond, void *opaque)
=20
 static int tcp_chr_sync_read(CharDriverState *chr, const uint8_t *buf, i=
nt len)
 {
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D (TCPCharDriver *)chr;
     int size;
=20
     if (!s->connected) {
@@ -3125,7 +3129,7 @@ static int tcp_chr_sync_read(CharDriverState *chr, =
const uint8_t *buf, int len)
 static void tcp_chr_connect(void *opaque)
 {
     CharDriverState *chr =3D opaque;
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D opaque;
=20
     g_free(chr->filename);
     chr->filename =3D sockaddr_to_str(
@@ -3146,7 +3150,7 @@ static void tcp_chr_connect(void *opaque)
 static void tcp_chr_update_read_handler(CharDriverState *chr,
                                         GMainContext *context)
 {
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D (TCPCharDriver *)chr;
=20
     if (!s->connected) {
         return;
@@ -3197,7 +3201,7 @@ static gboolean tcp_chr_telnet_init_io(QIOChannel *=
ioc,
=20
 static void tcp_chr_telnet_init(CharDriverState *chr)
 {
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D (TCPCharDriver *)chr;
     TCPCharDriverTelnetInit *init =3D
         g_new0(TCPCharDriverTelnetInit, 1);
     size_t n =3D 0;
@@ -3233,7 +3237,7 @@ static void tcp_chr_tls_handshake(Object *source,
                                   gpointer user_data)
 {
     CharDriverState *chr =3D user_data;
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D user_data;
=20
     if (err) {
         tcp_chr_disconnect(chr);
@@ -3249,7 +3253,7 @@ static void tcp_chr_tls_handshake(Object *source,
=20
 static void tcp_chr_tls_init(CharDriverState *chr)
 {
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D (TCPCharDriver *)chr;
     QIOChannelTLS *tioc;
     Error *err =3D NULL;
     gchar *name;
@@ -3288,7 +3292,7 @@ static void tcp_chr_tls_init(CharDriverState *chr)
 static void tcp_chr_set_client_ioc_name(CharDriverState *chr,
                                         QIOChannelSocket *sioc)
 {
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D (TCPCharDriver *)chr;
     char *name;
     name =3D g_strdup_printf("chardev-tcp-%s-%s",
                            s->is_listen ? "server" : "client",
@@ -3300,7 +3304,8 @@ static void tcp_chr_set_client_ioc_name(CharDriverS=
tate *chr,
=20
 static int tcp_chr_new_client(CharDriverState *chr, QIOChannelSocket *si=
oc)
 {
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D (TCPCharDriver *)chr;
+
     if (s->ioc !=3D NULL) {
 	return -1;
     }
@@ -3371,7 +3376,7 @@ static gboolean tcp_chr_accept(QIOChannel *channel,
=20
 static int tcp_chr_wait_connected(CharDriverState *chr, Error **errp)
 {
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D (TCPCharDriver *)chr;
     QIOChannelSocket *sioc;
=20
     /* It can't wait on s->connected, since it is set asynchronously
@@ -3419,7 +3424,7 @@ int qemu_chr_fe_wait_connected(CharBackend *be, Err=
or **errp)
=20
 static void tcp_chr_free(CharDriverState *chr)
 {
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D (TCPCharDriver *)chr;
=20
     tcp_chr_free_connection(chr);
=20
@@ -3438,7 +3443,7 @@ static void tcp_chr_free(CharDriverState *chr)
     if (s->tls_creds) {
         object_unref(OBJECT(s->tls_creds));
     }
-    g_free(s);
+
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
=20
@@ -3447,7 +3452,7 @@ static void qemu_chr_socket_connected(Object *src, =
Error *err, void *opaque)
 {
     QIOChannelSocket *sioc =3D QIO_CHANNEL_SOCKET(src);
     CharDriverState *chr =3D opaque;
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D (TCPCharDriver *)chr;
=20
     if (err) {
         check_report_connect_error(chr, err);
@@ -3465,6 +3470,7 @@ static void qemu_chr_socket_connected(Object *src, =
Error *err, void *opaque)
 /* Ring buffer chardev */
=20
 typedef struct {
+    CharDriverState parent;
     size_t size;
     size_t prod;
     size_t cons;
@@ -3473,7 +3479,7 @@ typedef struct {
=20
 static size_t ringbuf_count(const CharDriverState *chr)
 {
-    const RingBufCharDriver *d =3D chr->opaque;
+    const RingBufCharDriver *d =3D (RingBufCharDriver *)chr;
=20
     return d->prod - d->cons;
 }
@@ -3481,7 +3487,7 @@ static size_t ringbuf_count(const CharDriverState *=
chr)
 /* Called with chr_write_lock held.  */
 static int ringbuf_chr_write(CharDriverState *chr, const uint8_t *buf, i=
nt len)
 {
-    RingBufCharDriver *d =3D chr->opaque;
+    RingBufCharDriver *d =3D (RingBufCharDriver *)chr;
     int i;
=20
     if (!buf || (len < 0)) {
@@ -3500,7 +3506,7 @@ static int ringbuf_chr_write(CharDriverState *chr, =
const uint8_t *buf, int len)
=20
 static int ringbuf_chr_read(CharDriverState *chr, uint8_t *buf, int len)
 {
-    RingBufCharDriver *d =3D chr->opaque;
+    RingBufCharDriver *d =3D (RingBufCharDriver *)chr;
     int i;
=20
     qemu_mutex_lock(&chr->chr_write_lock);
@@ -3514,11 +3520,9 @@ static int ringbuf_chr_read(CharDriverState *chr, =
uint8_t *buf, int len)
=20
 static void ringbuf_chr_free(struct CharDriverState *chr)
 {
-    RingBufCharDriver *d =3D chr->opaque;
+    RingBufCharDriver *d =3D (RingBufCharDriver *)chr;
=20
     g_free(d->cbuf);
-    g_free(d);
-    chr->opaque =3D NULL;
 }
=20
 static CharDriverState *qemu_chr_open_ringbuf(const CharDriver *driver,
@@ -3537,7 +3541,7 @@ static CharDriverState *qemu_chr_open_ringbuf(const=
 CharDriver *driver,
     if (!chr) {
         return NULL;
     }
-    d =3D g_malloc(sizeof(*d));
+    d =3D (RingBufCharDriver *)chr;
=20
     d->size =3D opts->has_size ? opts->size : 65536;
=20
@@ -3551,12 +3555,9 @@ static CharDriverState *qemu_chr_open_ringbuf(cons=
t CharDriver *driver,
     d->cons =3D 0;
     d->cbuf =3D g_malloc0(d->size);
=20
-    chr->opaque =3D d;
-
     return chr;
=20
 fail:
-    g_free(d);
     qemu_chr_free_common(chr);
     return NULL;
 }
@@ -3847,10 +3848,12 @@ static const CharDriver stdio_driver =3D {
     .parse =3D qemu_chr_parse_stdio,
     .create =3D qemu_chr_open_stdio,
 #ifdef _WIN32
+    sizeof(WinStdioCharState),
     .chr_write =3D win_stdio_write,
     .chr_set_echo =3D qemu_chr_set_echo_win_stdio,
     .chr_free =3D win_stdio_free,
 #else
+    sizeof(FDCharDriver),
     .chr_add_watch =3D fd_chr_add_watch,
     .chr_write =3D fd_chr_write,
     .chr_update_read_handler =3D fd_chr_update_read_handler,
@@ -3913,9 +3916,11 @@ static const CharDriver pipe_driver =3D {
     .parse =3D qemu_chr_parse_pipe,
     .create =3D qemu_chr_open_pipe,
 #ifdef _WIN32
+    sizeof(WinCharState),
     .chr_write =3D win_chr_write,
     .chr_free =3D win_chr_free,
 #else
+    sizeof(FDCharDriver),
     .chr_add_watch =3D fd_chr_add_watch,
     .chr_write =3D fd_chr_write,
     .chr_update_read_handler =3D fd_chr_update_read_handler,
@@ -3940,6 +3945,7 @@ static void qemu_chr_parse_ringbuf(QemuOpts *opts, =
ChardevBackend *backend,
 }
=20
 static const CharDriver ringbuf_driver =3D {
+    .instance_size =3D sizeof(RingBufCharDriver),
     .kind =3D CHARDEV_BACKEND_KIND_RINGBUF,
     .parse =3D qemu_chr_parse_ringbuf,
     .create =3D qemu_chr_open_ringbuf,
@@ -3949,6 +3955,7 @@ static const CharDriver ringbuf_driver =3D {
=20
 /* Bug-compatibility: */
 static const CharDriver memory_driver =3D {
+    .instance_size =3D sizeof(RingBufCharDriver),
     .kind =3D CHARDEV_BACKEND_KIND_MEMORY,
     .parse =3D qemu_chr_parse_ringbuf,
     .create =3D qemu_chr_open_ringbuf,
@@ -3972,6 +3979,7 @@ static void qemu_chr_parse_mux(QemuOpts *opts, Char=
devBackend *backend,
 }
=20
 static const CharDriver mux_driver =3D {
+    .instance_size =3D sizeof(MuxDriver),
     .kind =3D CHARDEV_BACKEND_KIND_MUX,
     .parse =3D qemu_chr_parse_mux,
     .create =3D qemu_chr_open_mux,
@@ -4556,17 +4564,13 @@ static CharDriverState *qmp_chardev_open_serial(c=
onst CharDriver *driver,
     ChardevHostdev *serial =3D backend->u.serial.data;
     ChardevCommon *common =3D qapi_ChardevHostdev_base(serial);
     CharDriverState *chr;
-    WinCharState *s;
=20
     chr =3D qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
=20
-    s =3D g_new0(WinCharState, 1);
-    chr->opaque =3D s;
     if (win_chr_init(chr, serial->device, errp) < 0) {
-        g_free(s);
         qemu_chr_free_common(chr);
         return NULL;
     }
@@ -4666,6 +4670,7 @@ static CharDriverState *qmp_chardev_open_parallel(c=
onst CharDriver *driver,
 }
=20
 static const CharDriver parallel_driver =3D {
+    .instance_size =3D sizeof(ParallelCharDriver),
     .kind =3D CHARDEV_BACKEND_KIND_PARALLEL,
     .alias =3D "parport",
     .parse =3D qemu_chr_parse_parallel,
@@ -4689,9 +4694,11 @@ static const CharDriver file_driver =3D {
     .parse =3D qemu_chr_parse_file_out,
     .create =3D qmp_chardev_open_file,
 #ifdef _WIN32
+    sizeof(WinCharState),
     .chr_write =3D win_chr_write,
     /* FIXME: no chr_free */
 #else
+    sizeof(FDCharDriver),
     .chr_add_watch =3D fd_chr_add_watch,
     .chr_write =3D fd_chr_write,
     .chr_update_read_handler =3D fd_chr_update_read_handler,
@@ -4706,9 +4713,11 @@ static const CharDriver serial_driver =3D {
     .parse =3D qemu_chr_parse_serial,
     .create =3D qmp_chardev_open_serial,
 #ifdef _WIN32
+    sizeof(WinCharState),
     .chr_write =3D win_chr_write,
     .chr_free =3D win_chr_free,
 #else
+    sizeof(FDCharDriver),
     .chr_add_watch =3D fd_chr_add_watch,
     .chr_write =3D fd_chr_write,
     .chr_update_read_handler =3D fd_chr_update_read_handler,
@@ -4721,7 +4730,7 @@ static const CharDriver serial_driver =3D {
 static gboolean socket_reconnect_timeout(gpointer opaque)
 {
     CharDriverState *chr =3D opaque;
-    TCPCharDriver *s =3D chr->opaque;
+    TCPCharDriver *s =3D opaque;
     QIOChannelSocket *sioc;
=20
     s->reconnect_timer =3D 0;
@@ -4762,7 +4771,7 @@ static CharDriverState *qmp_chardev_open_socket(con=
st CharDriver *driver,
     if (!chr) {
         return NULL;
     }
-    s =3D g_new0(TCPCharDriver, 1);
+    s =3D (TCPCharDriver *)chr;
=20
     s->is_unix =3D addr->type =3D=3D SOCKET_ADDRESS_KIND_UNIX;
     s->is_listen =3D is_listen;
@@ -4808,7 +4817,6 @@ static CharDriverState *qmp_chardev_open_socket(con=
st CharDriver *driver,
         qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
     }
=20
-    chr->opaque =3D s;
     /* be isn't opened until we get a connection */
     *be_opened =3D false;
=20
@@ -4865,12 +4873,12 @@ static CharDriverState *qmp_chardev_open_socket(c=
onst CharDriver *driver,
     if (s->tls_creds) {
         object_unref(OBJECT(s->tls_creds));
     }
-    g_free(s);
     qemu_chr_free_common(chr);
     return NULL;
 }
=20
 static const CharDriver socket_driver =3D {
+    .instance_size =3D sizeof(TCPCharDriver),
     .kind =3D CHARDEV_BACKEND_KIND_SOCKET,
     .parse =3D qemu_chr_parse_socket,
     .create =3D qmp_chardev_open_socket,
@@ -4916,9 +4924,8 @@ static CharDriverState *qmp_chardev_open_udp(const =
CharDriver *driver,
     qio_channel_set_name(QIO_CHANNEL(sioc), name);
     g_free(name);
=20
-    s =3D g_new0(NetCharDriver, 1);
+    s =3D (NetCharDriver *)chr;
     s->ioc =3D QIO_CHANNEL(sioc);
-    chr->opaque =3D s;
     /* be isn't opened until we get a connection */
     *be_opened =3D false;
=20
@@ -4926,6 +4933,7 @@ static CharDriverState *qmp_chardev_open_udp(const =
CharDriver *driver,
 }
=20
 static const CharDriver udp_driver =3D {
+    .instance_size =3D sizeof(NetCharDriver),
     .kind =3D CHARDEV_BACKEND_KIND_UDP,
     .parse =3D qemu_chr_parse_udp,
     .create =3D qmp_chardev_open_udp,
diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index c7eb306f34..1aed45157b 100644
--- a/spice-qemu-char.c
+++ b/spice-qemu-char.c
@@ -7,7 +7,8 @@
=20
=20
 typedef struct SpiceCharDriver {
-    CharDriverState*      chr;
+    CharDriverState       parent;
+
     SpiceCharDeviceInstance     sin;
     bool                  active;
     bool                  blocked;
@@ -27,17 +28,18 @@ static QLIST_HEAD(, SpiceCharDriver) spice_chars =3D
 static int vmc_write(SpiceCharDeviceInstance *sin, const uint8_t *buf, i=
nt len)
 {
     SpiceCharDriver *scd =3D container_of(sin, SpiceCharDriver, sin);
+    CharDriverState *chr =3D (CharDriverState *)scd;
     ssize_t out =3D 0;
     ssize_t last_out;
     uint8_t* p =3D (uint8_t*)buf;
=20
     while (len > 0) {
-        int can_write =3D qemu_chr_be_can_write(scd->chr);
+        int can_write =3D qemu_chr_be_can_write(chr);
         last_out =3D MIN(len, can_write);
         if (last_out <=3D 0) {
             break;
         }
-        qemu_chr_be_write(scd->chr, p, last_out);
+        qemu_chr_be_write(chr, p, last_out);
         out +=3D last_out;
         len -=3D last_out;
         p +=3D last_out;
@@ -70,6 +72,7 @@ static int vmc_read(SpiceCharDeviceInstance *sin, uint8=
_t *buf, int len)
 static void vmc_event(SpiceCharDeviceInstance *sin, uint8_t event)
 {
     SpiceCharDriver *scd =3D container_of(sin, SpiceCharDriver, sin);
+    CharDriverState *chr =3D (CharDriverState *)scd;
     int chr_event;
=20
     switch (event) {
@@ -81,20 +84,21 @@ static void vmc_event(SpiceCharDeviceInstance *sin, u=
int8_t event)
     }
=20
     trace_spice_vmc_event(chr_event);
-    qemu_chr_be_event(scd->chr, chr_event);
+    qemu_chr_be_event(chr, chr_event);
 }
 #endif
=20
 static void vmc_state(SpiceCharDeviceInstance *sin, int connected)
 {
     SpiceCharDriver *scd =3D container_of(sin, SpiceCharDriver, sin);
+    CharDriverState *chr =3D (CharDriverState *)scd;
=20
-    if ((scd->chr->be_open && connected) ||
-        (!scd->chr->be_open && !connected)) {
+    if ((chr->be_open && connected) ||
+        (!chr->be_open && !connected)) {
         return;
     }
=20
-    qemu_chr_be_event(scd->chr,
+    qemu_chr_be_event(chr,
                       connected ? CHR_EVENT_OPENED : CHR_EVENT_CLOSED);
 }
=20
@@ -168,7 +172,7 @@ static GSourceFuncs SpiceCharSourceFuncs =3D {
=20
 static GSource *spice_chr_add_watch(CharDriverState *chr, GIOCondition c=
ond)
 {
-    SpiceCharDriver *scd =3D chr->opaque;
+    SpiceCharDriver *scd =3D (SpiceCharDriver *)chr;
     SpiceCharSource *src;
=20
     assert(cond & G_IO_OUT);
@@ -182,7 +186,7 @@ static GSource *spice_chr_add_watch(CharDriverState *=
chr, GIOCondition cond)
=20
 static int spice_chr_write(CharDriverState *chr, const uint8_t *buf, int=
 len)
 {
-    SpiceCharDriver *s =3D chr->opaque;
+    SpiceCharDriver *s =3D (SpiceCharDriver *)chr;
     int read_bytes;
=20
     assert(s->datalen =3D=3D 0);
@@ -201,7 +205,7 @@ static int spice_chr_write(CharDriverState *chr, cons=
t uint8_t *buf, int len)
=20
 static void spice_chr_free(struct CharDriverState *chr)
 {
-    SpiceCharDriver *s =3D chr->opaque;
+    SpiceCharDriver *s =3D (SpiceCharDriver *)chr;
=20
     vmc_unregister_interface(s);
     QLIST_REMOVE(s, next);
@@ -210,12 +214,11 @@ static void spice_chr_free(struct CharDriverState *=
chr)
 #if SPICE_SERVER_VERSION >=3D 0x000c02
     g_free((char *)s->sin.portname);
 #endif
-    g_free(s);
 }
=20
 static void spice_vmc_set_fe_open(struct CharDriverState *chr, int fe_op=
en)
 {
-    SpiceCharDriver *s =3D chr->opaque;
+    SpiceCharDriver *s =3D (SpiceCharDriver *)chr;
     if (fe_open) {
         vmc_register_interface(s);
     } else {
@@ -226,7 +229,7 @@ static void spice_vmc_set_fe_open(struct CharDriverSt=
ate *chr, int fe_open)
 static void spice_port_set_fe_open(struct CharDriverState *chr, int fe_o=
pen)
 {
 #if SPICE_SERVER_VERSION >=3D 0x000c02
-    SpiceCharDriver *s =3D chr->opaque;
+    SpiceCharDriver *s =3D (SpiceCharDriver *)chr;
=20
     if (fe_open) {
         spice_server_port_event(&s->sin, SPICE_PORT_EVENT_OPENED);
@@ -255,7 +258,7 @@ static void print_allowed_subtypes(void)
=20
 static void spice_chr_accept_input(struct CharDriverState *chr)
 {
-    SpiceCharDriver *s =3D chr->opaque;
+    SpiceCharDriver *s =3D (SpiceCharDriver *)chr;
=20
     spice_server_char_device_wakeup(&s->sin);
 }
@@ -272,11 +275,9 @@ static CharDriverState *chr_open(const CharDriver *d=
river,
     if (!chr) {
         return NULL;
     }
-    s =3D g_malloc0(sizeof(SpiceCharDriver));
-    s->chr =3D chr;
+    s =3D (SpiceCharDriver *)chr;
     s->active =3D false;
     s->sin.subtype =3D g_strdup(subtype);
-    chr->opaque =3D s;
=20
     QLIST_INSERT_HEAD(&spice_chars, s, next);
=20
@@ -334,7 +335,7 @@ static CharDriverState *qemu_chr_open_spice_port(cons=
t CharDriver *driver,
         return NULL;
     }
     *be_opened =3D false;
-    s =3D chr->opaque;
+    s =3D (SpiceCharDriver *)chr;
     s->sin.portname =3D g_strdup(name);
=20
     return chr;
@@ -386,6 +387,7 @@ static void qemu_chr_parse_spice_port(QemuOpts *opts,=
 ChardevBackend *backend,
 static void register_types(void)
 {
     static const CharDriver vmc_driver =3D {
+        .instance_size =3D sizeof(SpiceCharDriver),
         .kind =3D CHARDEV_BACKEND_KIND_SPICEVMC,
         .parse =3D qemu_chr_parse_spice_vmc,
         .create =3D qemu_chr_open_spice_vmc,
@@ -396,6 +398,7 @@ static void register_types(void)
         .chr_free =3D spice_chr_free,
     };
     static const CharDriver port_driver =3D {
+        .instance_size =3D sizeof(SpiceCharDriver),
         .kind =3D CHARDEV_BACKEND_KIND_SPICEPORT,
         .parse =3D qemu_chr_parse_spice_port,
         .create =3D qemu_chr_open_spice_port,
diff --git a/ui/console.c b/ui/console.c
index f48ba26d2a..495d5a2121 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1046,9 +1046,15 @@ void console_select(unsigned int index)
     }
 }
=20
+typedef struct VCDriverState {
+    CharDriverState parent;
+    QemuConsole *console;
+} VCDriverState;
+
 static int console_puts(CharDriverState *chr, const uint8_t *buf, int le=
n)
 {
-    QemuConsole *s =3D chr->opaque;
+    VCDriverState *drv =3D (VCDriverState *)chr;
+    QemuConsole *s =3D drv->console;
     int i;
=20
     if (!s->ds) {
@@ -1958,7 +1964,8 @@ int qemu_console_get_height(QemuConsole *con, int f=
allback)
=20
 static void text_console_set_echo(CharDriverState *chr, bool echo)
 {
-    QemuConsole *s =3D chr->opaque;
+    VCDriverState *drv =3D (VCDriverState *)chr;
+    QemuConsole *s =3D drv->console;
=20
     s->echo =3D echo;
 }
@@ -1998,12 +2005,11 @@ static const GraphicHwOps text_console_ops =3D {
=20
 static void text_console_do_init(CharDriverState *chr, DisplayState *ds)
 {
-    QemuConsole *s;
+    VCDriverState *drv =3D (VCDriverState *)chr;
+    QemuConsole *s =3D drv->console;
     int g_width =3D 80 * FONT_WIDTH;
     int g_height =3D 24 * FONT_HEIGHT;
=20
-    s =3D chr->opaque;
-
     s->out_fifo.buf =3D s->out_fifo_buf;
     s->out_fifo.buf_size =3D sizeof(s->out_fifo_buf);
     s->kbd_timer =3D timer_new_ms(QEMU_CLOCK_REALTIME, kbd_send_chars, s=
);
@@ -2056,6 +2062,7 @@ static CharDriverState *text_console_init(ChardevVC=
 *vc, Error **errp)
 {
     ChardevCommon *common =3D qapi_ChardevVC_base(vc);
     CharDriverState *chr;
+    VCDriverState *drv;
     QemuConsole *s;
     unsigned width =3D 0;
     unsigned height =3D 0;
@@ -2092,7 +2099,8 @@ static CharDriverState *text_console_init(ChardevVC=
 *vc, Error **errp)
     }
=20
     s->chr =3D chr;
-    chr->opaque =3D s;
+    drv =3D (VCDriverState *)chr;
+    drv->console =3D s;
=20
     if (display_state) {
         text_console_do_init(chr, display_state);
@@ -2196,6 +2204,7 @@ static const TypeInfo qemu_console_info =3D {
 };
=20
 static const CharDriver vc_driver =3D {
+    .instance_size =3D sizeof(VCDriverState),
     .kind =3D CHARDEV_BACKEND_KIND_VC,
     .parse =3D qemu_chr_parse_vc,
     .create =3D vc_init,
diff --git a/ui/gtk.c b/ui/gtk.c
index 608400b56d..90cf4d5596 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -181,6 +181,12 @@ struct GtkDisplayState {
     bool ignore_keys;
 };
=20
+typedef struct VCDriverState {
+    CharDriverState parent;
+    VirtualConsole *console;
+    bool echo;
+} VCDriverState;
+
 static void gd_grab_pointer(VirtualConsole *vc, const char *reason);
 static void gd_ungrab_pointer(GtkDisplayState *s);
 static void gd_grab_keyboard(VirtualConsole *vc, const char *reason);
@@ -1685,7 +1691,8 @@ static void gd_vc_adjustment_changed(GtkAdjustment =
*adjustment, void *opaque)
=20
 static int gd_vc_chr_write(CharDriverState *chr, const uint8_t *buf, int=
 len)
 {
-    VirtualConsole *vc =3D chr->opaque;
+    VCDriverState *vcd =3D (VCDriverState *)chr;
+    VirtualConsole *vc =3D vcd->console;
=20
     vte_terminal_feed(VTE_TERMINAL(vc->vte.terminal), (const char *)buf,=
 len);
     return len;
@@ -1693,9 +1700,14 @@ static int gd_vc_chr_write(CharDriverState *chr, c=
onst uint8_t *buf, int len)
=20
 static void gd_vc_chr_set_echo(CharDriverState *chr, bool echo)
 {
-    VirtualConsole *vc =3D chr->opaque;
+    VCDriverState *vcd =3D (VCDriverState *)chr;
+    VirtualConsole *vc =3D vcd->console;
=20
-    vc->vte.echo =3D echo;
+    if (vc) {
+        vc->vte.echo =3D echo;
+    } else {
+        vcd->echo =3D echo;
+    }
 }
=20
 static int nb_vcs;
@@ -1704,6 +1716,7 @@ static CharDriverState *vcs[MAX_VCS];
 static CharDriverState *gd_vc_handler(ChardevVC *vc, Error **errp)
 {
     static const CharDriver gd_vc_driver =3D {
+        .instance_size =3D sizeof(VCDriverState),
         .kind =3D CHARDEV_BACKEND_KIND_VC,
         .chr_write =3D gd_vc_chr_write,
         .chr_set_echo =3D gd_vc_chr_set_echo,
@@ -1722,9 +1735,6 @@ static CharDriverState *gd_vc_handler(ChardevVC *vc=
, Error **errp)
         return NULL;
     }
=20
-    /* Temporary, until gd_vc_vte_init runs.  */
-    chr->opaque =3D g_new0(VirtualConsole, 1);
-
     vcs[nb_vcs++] =3D chr;
=20
     return chr;
@@ -1765,14 +1775,12 @@ static GSList *gd_vc_vte_init(GtkDisplayState *s,=
 VirtualConsole *vc,
     GtkWidget *box;
     GtkWidget *scrollbar;
     GtkAdjustment *vadjustment;
-    VirtualConsole *tmp_vc =3D chr->opaque;
+    VCDriverState *vcd =3D (VCDriverState *)chr;
=20
     vc->s =3D s;
-    vc->vte.echo =3D tmp_vc->vte.echo;
-
+    vc->vte.echo =3D vcd->echo;
     vc->vte.chr =3D chr;
-    chr->opaque =3D vc;
-    g_free(tmp_vc);
+    vcd->console =3D vc;
=20
     snprintf(buffer, sizeof(buffer), "vc%d", idx);
     vc->label =3D g_strdup_printf("%s", vc->vte.chr->label
--=20
2.11.0

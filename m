Received: from eggs.gnu.org ([2001:4830:134:3::10]:33817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rI-0005QH-EH
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rC-0004Dp-Pk
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:32 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6rC-0004Cw-8Z
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:26 -0500
Received: by mail-wm0-x242.google.com with SMTP id d140so58624671wmd.2
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:39 +0100
Message-Id: <1485524749-118532-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 31/41] char: allocate CharDriverState as a
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Use a single allocation for CharDriverState, this avoids extra
allocations & pointers, and is a step towards more object-oriented
CharDriver.

Gtk console is a bit peculiar, gd_vc_chr_set_echo() used to have a
temporary VirtualConsole to save the echo bit. Instead now, we consider
whether vcd->console is set or not, and restore the echo bit saved in
VCDriverState when calling gd_vc_vte_init().

The casts added are temporary, they are replaced with QOM type-safe
macros in a later patch in this series.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/baum.c       |  23 ++---
 backends/msmouse.c    |  16 +--
 backends/testdev.c    |  22 ++--
 gdbstub.c             |   1 +
 hw/bt/hci-csr.c       |  10 +-
 include/sysemu/char.h |   2 +-
 qemu-char.c           | 280 ++++++++++++++++++++++++++------------------------
 spice-qemu-char.c     |  39 +++----
 ui/console.c          |  21 ++--
 ui/gtk.c              |  30 ++++--
 10 files changed, 230 insertions(+), 214 deletions(-)

diff --git a/backends/baum.c b/backends/baum.c
index 109469e..4b48cf0 100644
--- a/backends/baum.c
+++ b/backends/baum.c
@@ -85,7 +85,7 @@
 #define BUF_SIZE 256
 
 typedef struct {
-    CharDriverState *chr;
+    CharDriverState parent;
 
     brlapi_handle_t *brlapi;
     int brlapi_fd;
@@ -255,7 +255,7 @@ static int baum_deferred_init(BaumDriverState *baum)
 /* The serial port can receive more of our data */
 static void baum_accept_input(struct CharDriverState *chr)
 {
-    BaumDriverState *baum = chr->opaque;
+    BaumDriverState *baum = (BaumDriverState *)chr;
     int room, first;
 
     if (!baum->out_buf_used)
@@ -281,22 +281,23 @@ static void baum_accept_input(struct CharDriverState *chr)
 /* We want to send a packet */
 static void baum_write_packet(BaumDriverState *baum, const uint8_t *buf, int len)
 {
+    CharDriverState *chr = (CharDriverState *)baum;
     uint8_t io_buf[1 + 2 * len], *cur = io_buf;
     int room;
     *cur++ = ESC;
     while (len--)
         if ((*cur++ = *buf++) == ESC)
             *cur++ = ESC;
-    room = qemu_chr_be_can_write(baum->chr);
+    room = qemu_chr_be_can_write(chr);
     len = cur - io_buf;
     if (len <= room) {
         /* Fits */
-        qemu_chr_be_write(baum->chr, io_buf, len);
+        qemu_chr_be_write(chr, io_buf, len);
     } else {
         int first;
         uint8_t out;
         /* Can't fit all, send what can be, and store the rest. */
-        qemu_chr_be_write(baum->chr, io_buf, room);
+        qemu_chr_be_write(chr, io_buf, room);
         len -= room;
         cur = io_buf + room;
         if (len > BUF_SIZE - baum->out_buf_used) {
@@ -471,7 +472,7 @@ static int baum_eat_packet(BaumDriverState *baum, const uint8_t *buf, int len)
 /* The other end is writing some data.  Store it and try to interpret */
 static int baum_write(CharDriverState *chr, const uint8_t *buf, int len)
 {
-    BaumDriverState *baum = chr->opaque;
+    BaumDriverState *baum = (BaumDriverState *)chr;
     int tocopy, cur, eaten, orig_len = len;
 
     if (!len)
@@ -612,14 +613,13 @@ static void baum_chr_read(void *opaque)
 
 static void baum_free(struct CharDriverState *chr)
 {
-    BaumDriverState *baum = chr->opaque;
+    BaumDriverState *baum = (BaumDriverState *)chr;
 
     timer_free(baum->cellCount_timer);
     if (baum->brlapi) {
         brlapi__closeConnection(baum->brlapi);
         g_free(baum->brlapi);
     }
-    g_free(baum);
 }
 
 static CharDriverState *chr_baum_init(const CharDriver *driver,
@@ -638,10 +638,7 @@ static CharDriverState *chr_baum_init(const CharDriver *driver,
     if (!chr) {
         return NULL;
     }
-    baum = g_malloc0(sizeof(BaumDriverState));
-    baum->chr = chr;
-
-    chr->opaque = baum;
+    baum = (BaumDriverState *)chr;
 
     handle = g_malloc0(brlapi_getHandleSize());
     baum->brlapi = handle;
@@ -663,13 +660,13 @@ static CharDriverState *chr_baum_init(const CharDriver *driver,
 fail_handle:
     g_free(handle);
     g_free(chr);
-    g_free(baum);
     return NULL;
 }
 
 static void register_types(void)
 {
     static const CharDriver driver = {
+        .instance_size = sizeof(BaumDriverState),
         .kind = CHARDEV_BACKEND_KIND_BRAILLE,
         .create = chr_baum_init,
         .chr_write = baum_write,
diff --git a/backends/msmouse.c b/backends/msmouse.c
index 2c238ba..30087b3 100644
--- a/backends/msmouse.c
+++ b/backends/msmouse.c
@@ -31,7 +31,8 @@
 #define MSMOUSE_HI2(n) (((n) & 0xc0) >> 6)
 
 typedef struct {
-    CharDriverState *chr;
+    CharDriverState parent;
+
     QemuInputHandlerState *hs;
     int axis[INPUT_AXIS__MAX];
     bool btns[INPUT_BUTTON__MAX];
@@ -42,7 +43,7 @@ typedef struct {
 
 static void msmouse_chr_accept_input(CharDriverState *chr)
 {
-    MouseState *mouse = chr->opaque;
+    MouseState *mouse = (MouseState *)chr;
     int len;
 
     len = qemu_chr_be_can_write(chr);
@@ -122,9 +123,10 @@ static void msmouse_input_event(DeviceState *dev, QemuConsole *src,
 static void msmouse_input_sync(DeviceState *dev)
 {
     MouseState *mouse = (MouseState *)dev;
+    CharDriverState *chr = (CharDriverState *)dev;
 
     msmouse_queue_event(mouse);
-    msmouse_chr_accept_input(mouse->chr);
+    msmouse_chr_accept_input(chr);
 }
 
 static int msmouse_chr_write (struct CharDriverState *s, const uint8_t *buf, int len)
@@ -135,10 +137,9 @@ static int msmouse_chr_write (struct CharDriverState *s, const uint8_t *buf, int
 
 static void msmouse_chr_free(struct CharDriverState *chr)
 {
-    MouseState *mouse = chr->opaque;
+    MouseState *mouse = (MouseState *)chr;
 
     qemu_input_handler_unregister(mouse->hs);
-    g_free(mouse);
 }
 
 static QemuInputHandler msmouse_handler = {
@@ -165,12 +166,10 @@ static CharDriverState *qemu_chr_open_msmouse(const CharDriver *driver,
     }
     *be_opened = false;
 
-    mouse = g_new0(MouseState, 1);
+    mouse = (MouseState *)chr;
     mouse->hs = qemu_input_handler_register((DeviceState *)mouse,
                                             &msmouse_handler);
 
-    mouse->chr = chr;
-    chr->opaque = mouse;
 
     return chr;
 }
@@ -178,6 +177,7 @@ static CharDriverState *qemu_chr_open_msmouse(const CharDriver *driver,
 static void register_types(void)
 {
     static const CharDriver driver = {
+        .instance_size = sizeof(MouseState),
         .kind = CHARDEV_BACKEND_KIND_MSMOUSE,
         .create = qemu_chr_open_msmouse,
         .chr_write = msmouse_chr_write,
diff --git a/backends/testdev.c b/backends/testdev.c
index 2339693..dfa4fe1 100644
--- a/backends/testdev.c
+++ b/backends/testdev.c
@@ -30,7 +30,8 @@
 #define BUF_SIZE 32
 
 typedef struct {
-    CharDriverState *chr;
+    CharDriverState parent;
+
     uint8_t in_buf[32];
     int in_buf_used;
 } TestdevCharState;
@@ -79,7 +80,7 @@ static int testdev_eat_packet(TestdevCharState *testdev)
 /* The other end is writing some data.  Store it and try to interpret */
 static int testdev_write(CharDriverState *chr, const uint8_t *buf, int len)
 {
-    TestdevCharState *testdev = chr->opaque;
+    TestdevCharState *testdev = (TestdevCharState *)chr;
     int tocopy, eaten, orig_len = len;
 
     while (len) {
@@ -102,13 +103,6 @@ static int testdev_write(CharDriverState *chr, const uint8_t *buf, int len)
     return orig_len;
 }
 
-static void testdev_free(struct CharDriverState *chr)
-{
-    TestdevCharState *testdev = chr->opaque;
-
-    g_free(testdev);
-}
-
 static CharDriverState *chr_testdev_init(const CharDriver *driver,
                                          const char *id,
                                          ChardevBackend *backend,
@@ -116,14 +110,10 @@ static CharDriverState *chr_testdev_init(const CharDriver *driver,
                                          bool *be_opened,
                                          Error **errp)
 {
-    TestdevCharState *testdev;
-    CharDriverState *chr;
-
-    testdev = g_new0(TestdevCharState, 1);
-    testdev->chr = chr = g_new0(CharDriverState, 1);
+    TestdevCharState *testdev = g_new0(TestdevCharState, 1);;
+    CharDriverState *chr = (CharDriverState *)testdev;
 
     chr->driver = driver;
-    chr->opaque = testdev;
 
     return chr;
 }
@@ -131,10 +121,10 @@ static CharDriverState *chr_testdev_init(const CharDriver *driver,
 static void register_types(void)
 {
     static const CharDriver driver = {
+        .instance_size = sizeof(TestdevCharState),
         .kind = CHARDEV_BACKEND_KIND_TESTDEV,
         .create = chr_testdev_init,
         .chr_write = testdev_write,
-        .chr_free = testdev_free,
     };
     register_char_driver(&driver);
 }
diff --git a/gdbstub.c b/gdbstub.c
index 3de9bcb..719e413 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1732,6 +1732,7 @@ int gdbserver_start(const char *device)
     CharDriverState *mon_chr;
     ChardevCommon common = { 0 };
     static const CharDriver driver = {
+        .instance_size = sizeof(CharDriverState),
         .kind = -1,
         .chr_write = gdb_monitor_write,
     };
diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
index 9c3fb3c..bf2deb0 100644
--- a/hw/bt/hci-csr.c
+++ b/hw/bt/hci-csr.c
@@ -28,11 +28,11 @@
 #include "hw/bt.h"
 
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
@@ -314,7 +314,7 @@ static void csrhci_ready_for_next_inpkt(struct csrhci_s *s)
 static int csrhci_write(struct CharDriverState *chr,
                 const uint8_t *buf, int len)
 {
-    struct csrhci_s *s = (struct csrhci_s *) chr->opaque;
+    struct csrhci_s *s = (struct csrhci_s *)chr;
     int total = 0;
 
     if (!s->enable)
@@ -387,7 +387,7 @@ static void csrhci_out_hci_packet_acl(void *opaque,
 static int csrhci_ioctl(struct CharDriverState *chr, int cmd, void *arg)
 {
     QEMUSerialSetParams *ssp;
-    struct csrhci_s *s = (struct csrhci_s *) chr->opaque;
+    struct csrhci_s *s = (struct csrhci_s *) chr;
     int prev_state = s->modem_state;
 
     switch (cmd) {
@@ -455,7 +455,7 @@ static void csrhci_pins(void *opaque, int line, int level)
 
 qemu_irq *csrhci_pins_get(CharDriverState *chr)
 {
-    struct csrhci_s *s = (struct csrhci_s *) chr->opaque;
+    struct csrhci_s *s = (struct csrhci_s *) chr;
 
     return s->pins;
 }
@@ -463,6 +463,7 @@ qemu_irq *csrhci_pins_get(CharDriverState *chr)
 CharDriverState *uart_hci_init(void)
 {
     static const CharDriver hci_driver = {
+        .instance_size = sizeof(struct csrhci_s),
         .kind = -1,
         .chr_write = csrhci_write,
         .chr_ioctl = csrhci_ioctl,
@@ -470,7 +471,6 @@ CharDriverState *uart_hci_init(void)
     struct csrhci_s *s = (struct csrhci_s *)
             g_malloc0(sizeof(struct csrhci_s));
 
-    s->chr.opaque = s;
     s->chr.driver = &hci_driver;
 
     s->hci = qemu_next_hci();
diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index b0b4231..8bb94e5 100644
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
 
     int (*chr_write)(struct CharDriverState *s, const uint8_t *buf, int len);
     int (*chr_sync_read)(struct CharDriverState *s,
diff --git a/qemu-char.c b/qemu-char.c
index 5d04d82..dfd1b4c 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -165,12 +165,14 @@ static void qemu_chr_free_common(CharDriverState *chr);
 CharDriverState *qemu_chr_alloc(const CharDriver *driver,
                                 ChardevCommon *backend, Error **errp)
 {
-    CharDriverState *chr = g_malloc0(sizeof(CharDriverState));
-    qemu_mutex_init(&chr->chr_write_lock);
+    CharDriverState *chr;
 
     assert(driver);
     assert(driver->chr_write);
+    assert(driver->instance_size >= sizeof(CharDriverState));
 
+    chr = g_malloc0(driver->instance_size);
+    qemu_mutex_init(&chr->chr_write_lock);
     if (backend->has_logfile) {
         int flags = O_WRONLY | O_CREAT;
         if (backend->has_logappend &&
@@ -536,6 +538,7 @@ static CharDriverState *qemu_chr_open_null(const CharDriver *driver,
 }
 
 static const CharDriver null_driver = {
+    .instance_size = sizeof(CharDriverState),
     .kind = CHARDEV_BACKEND_KIND_NULL,
     .create = qemu_chr_open_null,
     .chr_write = null_chr_write,
@@ -546,6 +549,7 @@ static const CharDriver null_driver = {
 #define MUX_BUFFER_SIZE 32	/* Must be a power of 2.  */
 #define MUX_BUFFER_MASK (MUX_BUFFER_SIZE - 1)
 struct MuxDriver {
+    CharDriverState parent;
     CharBackend *backends[MAX_MUX];
     CharBackend chr;
     int focus;
@@ -568,7 +572,7 @@ struct MuxDriver {
 /* Called with chr_write_lock held.  */
 static int mux_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
 {
-    MuxDriver *d = chr->opaque;
+    MuxDriver *d = (MuxDriver *)chr;
     int ret;
     if (!d->timestamps) {
         ret = qemu_chr_fe_write(&d->chr, buf, len);
@@ -702,7 +706,7 @@ static int mux_proc_byte(CharDriverState *chr, MuxDriver *d, int ch)
 
 static void mux_chr_accept_input(CharDriverState *chr)
 {
-    MuxDriver *d = chr->opaque;
+    MuxDriver *d = (MuxDriver *)chr;
     int m = d->focus;
     CharBackend *be = d->backends[m];
 
@@ -715,8 +719,7 @@ static void mux_chr_accept_input(CharDriverState *chr)
 
 static int mux_chr_can_read(void *opaque)
 {
-    CharDriverState *chr = opaque;
-    MuxDriver *d = chr->opaque;
+    MuxDriver *d = opaque;
     int m = d->focus;
     CharBackend *be = d->backends[m];
 
@@ -734,7 +737,7 @@ static int mux_chr_can_read(void *opaque)
 static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
 {
     CharDriverState *chr = opaque;
-    MuxDriver *d = chr->opaque;
+    MuxDriver *d = opaque;
     int m = d->focus;
     CharBackend *be = d->backends[m];
     int i;
@@ -756,8 +759,7 @@ static bool muxes_realized;
 
 static void mux_chr_event(void *opaque, int event)
 {
-    CharDriverState *chr = opaque;
-    MuxDriver *d = chr->opaque;
+    MuxDriver *d = opaque;
     int i;
 
     if (!muxes_realized) {
@@ -787,7 +789,7 @@ static void muxes_realize_done(Notifier *notifier, void *unused)
 
     QTAILQ_FOREACH(chr, &chardevs, next) {
         if (qemu_chr_get_kind(chr) == CHARDEV_BACKEND_KIND_MUX) {
-            MuxDriver *d = chr->opaque;
+            MuxDriver *d = (MuxDriver *)chr;
             int i;
 
             /* send OPENED to all already-attached FEs */
@@ -809,7 +811,7 @@ static Notifier muxes_realize_notify = {
 
 static GSource *mux_chr_add_watch(CharDriverState *s, GIOCondition cond)
 {
-    MuxDriver *d = s->opaque;
+    MuxDriver *d = (MuxDriver *)s;
     CharDriverState *chr = qemu_chr_fe_get_driver(&d->chr);
 
     if (!chr->driver->chr_add_watch) {
@@ -821,7 +823,7 @@ static GSource *mux_chr_add_watch(CharDriverState *s, GIOCondition cond)
 
 static void mux_chr_free(struct CharDriverState *chr)
 {
-    MuxDriver *d = chr->opaque;
+    MuxDriver *d = (MuxDriver *)chr;
     int i;
 
     for (i = 0; i < d->mux_cnt; i++) {
@@ -831,12 +833,11 @@ static void mux_chr_free(struct CharDriverState *chr)
         }
     }
     qemu_chr_fe_deinit(&d->chr);
-    g_free(d);
 }
 
 static void mux_chr_set_handlers(CharDriverState *chr, GMainContext *context)
 {
-    MuxDriver *d = chr->opaque;
+    MuxDriver *d = (MuxDriver *)chr;
 
     /* Fix up the real driver with mux routines */
     qemu_chr_fe_set_handlers(&d->chr,
@@ -849,7 +850,7 @@ static void mux_chr_set_handlers(CharDriverState *chr, GMainContext *context)
 
 static void mux_set_focus(CharDriverState *chr, int focus)
 {
-    MuxDriver *d = chr->opaque;
+    MuxDriver *d = (MuxDriver *)chr;
 
     assert(focus >= 0);
     assert(focus < d->mux_cnt);
@@ -885,9 +886,7 @@ static CharDriverState *qemu_chr_open_mux(const CharDriver *driver,
     if (!chr) {
         return NULL;
     }
-    d = g_new0(MuxDriver, 1);
-
-    chr->opaque = d;
+    d = (MuxDriver *)chr;
     d->focus = -1;
     /* only default to opened state if we've realized the initial
      * set of muxes
@@ -911,7 +910,7 @@ bool qemu_chr_fe_init(CharBackend *b, CharDriverState *s, Error **errp)
     int tag = 0;
 
     if (qemu_chr_get_kind(s) == CHARDEV_BACKEND_KIND_MUX) {
-        MuxDriver *d = s->opaque;
+        MuxDriver *d = (MuxDriver *)s;
 
         if (d->mux_cnt >= MAX_MUX) {
             goto unavailable;
@@ -938,7 +937,7 @@ unavailable:
 static bool qemu_chr_is_busy(CharDriverState *s)
 {
     if (qemu_chr_get_kind(s) == CHARDEV_BACKEND_KIND_MUX) {
-        MuxDriver *d = s->opaque;
+        MuxDriver *d = (MuxDriver *)s;
         return d->mux_cnt >= 0;
     } else {
         return s->be != NULL;
@@ -955,7 +954,7 @@ void qemu_chr_fe_deinit(CharBackend *b)
             b->chr->be = NULL;
         }
         if (qemu_chr_get_kind(b->chr) == CHARDEV_BACKEND_KIND_MUX) {
-            MuxDriver *d = b->chr->opaque;
+            MuxDriver *d = (MuxDriver *)b->chr;
             d->backends[b->tag] = NULL;
         }
         b->chr = NULL;
@@ -1195,6 +1194,7 @@ static int io_channel_send(QIOChannel *ioc, const void *buf, size_t len)
 
 
 typedef struct FDCharDriver {
+    CharDriverState parent;
     CharDriverState *chr;
     QIOChannel *ioc_in, *ioc_out;
     int max_size;
@@ -1203,15 +1203,15 @@ typedef struct FDCharDriver {
 /* Called with chr_write_lock held.  */
 static int fd_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
 {
-    FDCharDriver *s = chr->opaque;
-    
+    FDCharDriver *s = (FDCharDriver *)chr;
+
     return io_channel_send(s->ioc_out, buf, len);
 }
 
 static gboolean fd_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
     CharDriverState *chr = opaque;
-    FDCharDriver *s = chr->opaque;
+    FDCharDriver *s = opaque;
     int len;
     uint8_t buf[READ_BUF_LEN];
     ssize_t ret;
@@ -1241,7 +1241,7 @@ static gboolean fd_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 static int fd_chr_read_poll(void *opaque)
 {
     CharDriverState *chr = opaque;
-    FDCharDriver *s = chr->opaque;
+    FDCharDriver *s = opaque;
 
     s->max_size = qemu_chr_be_can_write(chr);
     return s->max_size;
@@ -1249,14 +1249,14 @@ static int fd_chr_read_poll(void *opaque)
 
 static GSource *fd_chr_add_watch(CharDriverState *chr, GIOCondition cond)
 {
-    FDCharDriver *s = chr->opaque;
+    FDCharDriver *s = (FDCharDriver *)chr;
     return qio_channel_create_watch(s->ioc_out, cond);
 }
 
 static void fd_chr_update_read_handler(CharDriverState *chr,
                                        GMainContext *context)
 {
-    FDCharDriver *s = chr->opaque;
+    FDCharDriver *s = (FDCharDriver *)chr;
 
     remove_fd_in_watch(chr);
     if (s->ioc_in) {
@@ -1269,7 +1269,7 @@ static void fd_chr_update_read_handler(CharDriverState *chr,
 
 static void fd_chr_free(struct CharDriverState *chr)
 {
-    FDCharDriver *s = chr->opaque;
+    FDCharDriver *s = (FDCharDriver *)chr;
 
     remove_fd_in_watch(chr);
     if (s->ioc_in) {
@@ -1279,7 +1279,6 @@ static void fd_chr_free(struct CharDriverState *chr)
         object_unref(OBJECT(s->ioc_out));
     }
 
-    g_free(s);
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
 
@@ -1296,7 +1295,7 @@ static CharDriverState *qemu_chr_open_fd(const CharDriver *driver,
     if (!chr) {
         return NULL;
     }
-    s = g_new0(FDCharDriver, 1);
+    s = (FDCharDriver *)chr;
     s->ioc_in = QIO_CHANNEL(qio_channel_file_new_fd(fd_in));
     name = g_strdup_printf("chardev-file-in-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(s->ioc_in), name);
@@ -1307,7 +1306,6 @@ static CharDriverState *qemu_chr_open_fd(const CharDriver *driver,
     g_free(name);
     qemu_set_nonblock(fd_out);
     s->chr = chr;
-    chr->opaque = s;
 
     return chr;
 }
@@ -1448,6 +1446,7 @@ static CharDriverState *qemu_chr_open_stdio(const CharDriver *driver,
 #define HAVE_CHARDEV_PTY 1
 
 typedef struct {
+    CharDriverState parent;
     QIOChannel *ioc;
     int read_bytes;
 
@@ -1463,7 +1462,7 @@ static void pty_chr_state(CharDriverState *chr, int connected);
 static gboolean pty_chr_timer(gpointer opaque)
 {
     struct CharDriverState *chr = opaque;
-    PtyCharDriver *s = chr->opaque;
+    PtyCharDriver *s = opaque;
 
     qemu_mutex_lock(&chr->chr_write_lock);
     s->timer_tag = 0;
@@ -1479,7 +1478,7 @@ static gboolean pty_chr_timer(gpointer opaque)
 /* Called with chr_write_lock held.  */
 static void pty_chr_rearm_timer(CharDriverState *chr, int ms)
 {
-    PtyCharDriver *s = chr->opaque;
+    PtyCharDriver *s = (PtyCharDriver *)chr;
     char *name;
 
     if (s->timer_tag) {
@@ -1501,7 +1500,7 @@ static void pty_chr_rearm_timer(CharDriverState *chr, int ms)
 /* Called with chr_write_lock held.  */
 static void pty_chr_update_read_handler_locked(CharDriverState *chr)
 {
-    PtyCharDriver *s = chr->opaque;
+    PtyCharDriver *s = (PtyCharDriver *)chr;
     GPollFD pfd;
     int rc;
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(s->ioc);
@@ -1532,7 +1531,7 @@ static void pty_chr_update_read_handler(CharDriverState *chr,
 /* Called with chr_write_lock held.  */
 static int pty_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
 {
-    PtyCharDriver *s = chr->opaque;
+    PtyCharDriver *s = (PtyCharDriver *)chr;
 
     if (!s->connected) {
         /* guest sends data, check for (re-)connect */
@@ -1546,7 +1545,7 @@ static int pty_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
 
 static GSource *pty_chr_add_watch(CharDriverState *chr, GIOCondition cond)
 {
-    PtyCharDriver *s = chr->opaque;
+    PtyCharDriver *s = (PtyCharDriver *)chr;
     if (!s->connected) {
         return NULL;
     }
@@ -1556,7 +1555,7 @@ static GSource *pty_chr_add_watch(CharDriverState *chr, GIOCondition cond)
 static int pty_chr_read_poll(void *opaque)
 {
     CharDriverState *chr = opaque;
-    PtyCharDriver *s = chr->opaque;
+    PtyCharDriver *s = opaque;
 
     s->read_bytes = qemu_chr_be_can_write(chr);
     return s->read_bytes;
@@ -1565,7 +1564,7 @@ static int pty_chr_read_poll(void *opaque)
 static gboolean pty_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
     CharDriverState *chr = opaque;
-    PtyCharDriver *s = chr->opaque;
+    PtyCharDriver *s = opaque;
     gsize len;
     uint8_t buf[READ_BUF_LEN];
     ssize_t ret;
@@ -1590,7 +1589,7 @@ static gboolean pty_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 static gboolean qemu_chr_be_generic_open_func(gpointer opaque)
 {
     CharDriverState *chr = opaque;
-    PtyCharDriver *s = chr->opaque;
+    PtyCharDriver *s = opaque;
 
     s->open_tag = 0;
     qemu_chr_be_generic_open(chr);
@@ -1600,7 +1599,7 @@ static gboolean qemu_chr_be_generic_open_func(gpointer opaque)
 /* Called with chr_write_lock held.  */
 static void pty_chr_state(CharDriverState *chr, int connected)
 {
-    PtyCharDriver *s = chr->opaque;
+    PtyCharDriver *s = (PtyCharDriver *)chr;
 
     if (!connected) {
         if (s->open_tag) {
@@ -1634,7 +1633,7 @@ static void pty_chr_state(CharDriverState *chr, int connected)
 
 static void pty_chr_free(struct CharDriverState *chr)
 {
-    PtyCharDriver *s = chr->opaque;
+    PtyCharDriver *s = (PtyCharDriver *)chr;
 
     qemu_mutex_lock(&chr->chr_write_lock);
     pty_chr_state(chr, 0);
@@ -1644,7 +1643,6 @@ static void pty_chr_free(struct CharDriverState *chr)
         s->timer_tag = 0;
     }
     qemu_mutex_unlock(&chr->chr_write_lock);
-    g_free(s);
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
 
@@ -1684,20 +1682,19 @@ static CharDriverState *qemu_chr_open_pty(const CharDriver *driver,
     fprintf(stderr, "char device redirected to %s (label %s)\n",
             pty_name, id);
 
-    s = g_new0(PtyCharDriver, 1);
-    chr->opaque = s;
-    *be_opened = false;
-
+    s = (PtyCharDriver *)chr;
     s->ioc = QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
     name = g_strdup_printf("chardev-pty-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(s->ioc), name);
     g_free(name);
     s->timer_tag = 0;
+    *be_opened = false;
 
     return chr;
 }
 
 static const CharDriver pty_driver = {
+    .instance_size = sizeof(PtyCharDriver),
     .kind = CHARDEV_BACKEND_KIND_PTY,
     .create = qemu_chr_open_pty,
     .chr_write = pty_chr_write,
@@ -1823,7 +1820,7 @@ static void tty_serial_init(int fd, int speed,
 
 static int tty_serial_ioctl(CharDriverState *chr, int cmd, void *arg)
 {
-    FDCharDriver *s = chr->opaque;
+    FDCharDriver *s = (FDCharDriver *)chr;
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(s->ioc_in);
 
     switch(cmd) {
@@ -1902,6 +1899,7 @@ static void qemu_chr_free_tty(CharDriverState *chr)
 #define HAVE_CHARDEV_PARPORT 1
 
 typedef struct {
+    CharDriverState parent;
     int fd;
     int mode;
 } ParallelCharDriver;
@@ -1919,7 +1917,7 @@ static int pp_hw_mode(ParallelCharDriver *s, uint16_t mode)
 
 static int pp_ioctl(CharDriverState *chr, int cmd, void *arg)
 {
-    ParallelCharDriver *drv = chr->opaque;
+    ParallelCharDriver *drv = (ParallelCharDriver *)chr;
     int fd = drv->fd;
     uint8_t b;
 
@@ -2000,13 +1998,12 @@ static int pp_ioctl(CharDriverState *chr, int cmd, void *arg)
 
 static void pp_free(CharDriverState *chr)
 {
-    ParallelCharDriver *drv = chr->opaque;
+    ParallelCharDriver *drv = (ParallelCharDriver *)chr;
     int fd = drv->fd;
 
     pp_hw_mode(drv, IEEE1284_MODE_COMPAT);
     ioctl(fd, PPRELEASE);
     close(fd);
-    g_free(drv);
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
 
@@ -2030,9 +2027,7 @@ static CharDriverState *qemu_chr_open_pp_fd(const CharDriver *driver,
         return NULL;
     }
 
-    drv = g_new0(ParallelCharDriver, 1);
-    chr->opaque = drv;
-
+    drv = (ParallelCharDriver *)chr;
     drv->fd = fd;
     drv->mode = IEEE1284_MODE_COMPAT;
 
@@ -2044,35 +2039,45 @@ static CharDriverState *qemu_chr_open_pp_fd(const CharDriver *driver,
 
 #define HAVE_CHARDEV_PARPORT 1
 
+typedef struct {
+    CharDriverState parent;
+    int fd;
+} ParallelCharDriver;
+
 static int pp_ioctl(CharDriverState *chr, int cmd, void *arg)
 {
-    int fd = (int)(intptr_t)chr->opaque;
+    ParallelCharDriver *drv = (ParallelCharDriver *)chr;
     uint8_t b;
 
-    switch(cmd) {
+    switch (cmd) {
     case CHR_IOCTL_PP_READ_DATA:
-        if (ioctl(fd, PPIGDATA, &b) < 0)
+        if (ioctl(drv->fd, PPIGDATA, &b) < 0) {
             return -ENOTSUP;
+        }
         *(uint8_t *)arg = b;
         break;
     case CHR_IOCTL_PP_WRITE_DATA:
         b = *(uint8_t *)arg;
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
         *(uint8_t *)arg = b;
         break;
     case CHR_IOCTL_PP_WRITE_CONTROL:
         b = *(uint8_t *)arg;
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
         *(uint8_t *)arg = b;
         break;
     default:
@@ -2088,12 +2093,14 @@ static CharDriverState *qemu_chr_open_pp_fd(const CharDriver *driver,
                                             Error **errp)
 {
     CharDriverState *chr;
+    ParallelCharDriver *drv;
 
     chr = qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
-    chr->opaque = (void *)(intptr_t)fd;
+    drv = (ParallelCharDriver *)chr;
+    drv->fd = fd;
     *be_opened = false;
     return chr;
 }
@@ -2104,6 +2111,7 @@ static CharDriverState *qemu_chr_open_pp_fd(const CharDriver *driver,
 #define HAVE_CHARDEV_SERIAL 1
 
 typedef struct {
+    CharDriverState parent;
     int max_size;
     HANDLE hcom, hrecv, hsend;
     OVERLAPPED orecv;
@@ -2115,6 +2123,7 @@ typedef struct {
 } WinCharState;
 
 typedef struct {
+    CharDriverState parent;
     HANDLE  hStdIn;
     HANDLE  hInputReadyEvent;
     HANDLE  hInputDoneEvent;
@@ -2132,7 +2141,7 @@ static int win_chr_pipe_poll(void *opaque);
 
 static void win_chr_free(CharDriverState *chr)
 {
-    WinCharState *s = chr->opaque;
+    WinCharState *s = (WinCharState *)chr;
 
     if (s->hsend) {
         CloseHandle(s->hsend);
@@ -2156,7 +2165,7 @@ static void win_chr_free(CharDriverState *chr)
 
 static int win_chr_init(CharDriverState *chr, const char *filename, Error **errp)
 {
-    WinCharState *s = chr->opaque;
+    WinCharState *s = (WinCharState *)chr;
     COMMCONFIG comcfg;
     COMMTIMEOUTS cto = { 0, 0, 0, 0, 0};
     COMSTAT comstat;
@@ -2224,7 +2233,7 @@ static int win_chr_init(CharDriverState *chr, const char *filename, Error **errp
 /* Called with chr_write_lock held.  */
 static int win_chr_write(CharDriverState *chr, const uint8_t *buf, int len1)
 {
-    WinCharState *s = chr->opaque;
+    WinCharState *s = (WinCharState *)chr;
     DWORD len, ret, size, err;
 
     len = len1;
@@ -2258,7 +2267,7 @@ static int win_chr_write(CharDriverState *chr, const uint8_t *buf, int len1)
 
 static int win_chr_read_poll(CharDriverState *chr)
 {
-    WinCharState *s = chr->opaque;
+    WinCharState *s = (WinCharState *)chr;
 
     s->max_size = qemu_chr_be_can_write(chr);
     return s->max_size;
@@ -2266,7 +2275,7 @@ static int win_chr_read_poll(CharDriverState *chr)
 
 static void win_chr_readfile(CharDriverState *chr)
 {
-    WinCharState *s = chr->opaque;
+    WinCharState *s = (WinCharState *)chr;
     int ret, err;
     uint8_t buf[READ_BUF_LEN];
     DWORD size;
@@ -2288,7 +2297,7 @@ static void win_chr_readfile(CharDriverState *chr)
 
 static void win_chr_read(CharDriverState *chr)
 {
-    WinCharState *s = chr->opaque;
+    WinCharState *s = (WinCharState *)chr;
 
     if (s->len > s->max_size)
         s->len = s->max_size;
@@ -2301,7 +2310,7 @@ static void win_chr_read(CharDriverState *chr)
 static int win_chr_poll(void *opaque)
 {
     CharDriverState *chr = opaque;
-    WinCharState *s = chr->opaque;
+    WinCharState *s = opaque;
     COMSTAT status;
     DWORD comerr;
 
@@ -2318,7 +2327,7 @@ static int win_chr_poll(void *opaque)
 static int win_chr_pipe_poll(void *opaque)
 {
     CharDriverState *chr = opaque;
-    WinCharState *s = chr->opaque;
+    WinCharState *s = opaque;
     DWORD size;
 
     PeekNamedPipe(s->hcom, NULL, 0, NULL, &size, NULL);
@@ -2334,7 +2343,7 @@ static int win_chr_pipe_poll(void *opaque)
 static int win_chr_pipe_init(CharDriverState *chr, const char *filename,
                              Error **errp)
 {
-    WinCharState *s = chr->opaque;
+    WinCharState *s = (WinCharState *)chr;
     OVERLAPPED ov;
     int ret;
     DWORD size;
@@ -2406,18 +2415,14 @@ static CharDriverState *qemu_chr_open_pipe(const CharDriver *driver,
     ChardevHostdev *opts = backend->u.pipe.data;
     const char *filename = opts->device;
     CharDriverState *chr;
-    WinCharState *s;
     ChardevCommon *common = qapi_ChardevHostdev_base(opts);
 
     chr = qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
-    s = g_new0(WinCharState, 1);
-    chr->opaque = s;
 
     if (win_chr_pipe_init(chr, filename, errp) < 0) {
-        g_free(s);
         qemu_chr_free_common(chr);
         return NULL;
     }
@@ -2436,9 +2441,8 @@ static CharDriverState *qemu_chr_open_win_file(const CharDriver *driver,
     if (!chr) {
         return NULL;
     }
-    s = g_new0(WinCharState, 1);
+    s = (WinCharState *)chr;
     s->hcom = fd_out;
-    chr->opaque = s;
     return chr;
 }
 
@@ -2456,6 +2460,7 @@ static CharDriverState *qemu_chr_open_win_con(const CharDriver *driver,
 }
 
 static const CharDriver console_driver = {
+    .instance_size = sizeof(WinCharState),
     .kind = CHARDEV_BACKEND_KIND_CONSOLE,
     .create = qemu_chr_open_win_con,
     .chr_write = win_chr_write,
@@ -2483,7 +2488,7 @@ static int win_stdio_write(CharDriverState *chr, const uint8_t *buf, int len)
 static void win_stdio_wait_func(void *opaque)
 {
     CharDriverState   *chr   = opaque;
-    WinStdioCharState *stdio = chr->opaque;
+    WinStdioCharState *stdio = opaque;
     INPUT_RECORD       buf[4];
     int                ret;
     DWORD              dwSize;
@@ -2516,8 +2521,7 @@ static void win_stdio_wait_func(void *opaque)
 
 static DWORD WINAPI win_stdio_thread(LPVOID param)
 {
-    CharDriverState   *chr   = param;
-    WinStdioCharState *stdio = chr->opaque;
+    WinStdioCharState *stdio = param;
     int                ret;
     DWORD              dwSize;
 
@@ -2556,7 +2560,7 @@ static DWORD WINAPI win_stdio_thread(LPVOID param)
 static void win_stdio_thread_wait_func(void *opaque)
 {
     CharDriverState   *chr   = opaque;
-    WinStdioCharState *stdio = chr->opaque;
+    WinStdioCharState *stdio = opaque;
 
     if (qemu_chr_be_can_write(chr)) {
         qemu_chr_be_write(chr, &stdio->win_stdio_buf, 1);
@@ -2567,7 +2571,7 @@ static void win_stdio_thread_wait_func(void *opaque)
 
 static void qemu_chr_set_echo_win_stdio(CharDriverState *chr, bool echo)
 {
-    WinStdioCharState *stdio  = chr->opaque;
+    WinStdioCharState *stdio  = (WinStdioCharState *)chr;
     DWORD              dwMode = 0;
 
     GetConsoleMode(stdio->hStdIn, &dwMode);
@@ -2581,7 +2585,7 @@ static void qemu_chr_set_echo_win_stdio(CharDriverState *chr, bool echo)
 
 static void win_stdio_free(CharDriverState *chr)
 {
-    WinStdioCharState *stdio = chr->opaque;
+    WinStdioCharState *stdio = (WinStdioCharState *)chr;
 
     if (stdio->hInputReadyEvent != INVALID_HANDLE_VALUE) {
         CloseHandle(stdio->hInputReadyEvent);
@@ -2592,8 +2596,6 @@ static void win_stdio_free(CharDriverState *chr)
     if (stdio->hInputThread != INVALID_HANDLE_VALUE) {
         TerminateThread(stdio->hInputThread, 0);
     }
-
-    g_free(chr->opaque);
 }
 
 static CharDriverState *qemu_chr_open_stdio(const CharDriver *driver,
@@ -2613,7 +2615,7 @@ static CharDriverState *qemu_chr_open_stdio(const CharDriver *driver,
     if (!chr) {
         return NULL;
     }
-    stdio = g_new0(WinStdioCharState, 1);
+    stdio = (WinStdioCharState *)chr;
 
     stdio->hStdIn = GetStdHandle(STD_INPUT_HANDLE);
     if (stdio->hStdIn == INVALID_HANDLE_VALUE) {
@@ -2623,8 +2625,6 @@ static CharDriverState *qemu_chr_open_stdio(const CharDriver *driver,
 
     is_console = GetConsoleMode(stdio->hStdIn, &dwMode) != 0;
 
-    chr->opaque    = stdio;
-
     if (is_console) {
         if (qemu_add_wait_object(stdio->hStdIn,
                                  win_stdio_wait_func, chr)) {
@@ -2684,6 +2684,7 @@ err1:
 /* UDP Net console */
 
 typedef struct {
+    CharDriverState parent;
     QIOChannel *ioc;
     uint8_t buf[READ_BUF_LEN];
     int bufcnt;
@@ -2694,7 +2695,7 @@ typedef struct {
 /* Called with chr_write_lock held.  */
 static int udp_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
 {
-    NetCharDriver *s = chr->opaque;
+    NetCharDriver *s = (NetCharDriver *)chr;
 
     return qio_channel_write(
         s->ioc, (const char *)buf, len, NULL);
@@ -2703,7 +2704,7 @@ static int udp_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
 static int udp_chr_read_poll(void *opaque)
 {
     CharDriverState *chr = opaque;
-    NetCharDriver *s = chr->opaque;
+    NetCharDriver *s = opaque;
 
     s->max_size = qemu_chr_be_can_write(chr);
 
@@ -2721,7 +2722,7 @@ static int udp_chr_read_poll(void *opaque)
 static gboolean udp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
     CharDriverState *chr = opaque;
-    NetCharDriver *s = chr->opaque;
+    NetCharDriver *s = opaque;
     ssize_t ret;
 
     if (s->max_size == 0) {
@@ -2748,7 +2749,7 @@ static gboolean udp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 static void udp_chr_update_read_handler(CharDriverState *chr,
                                         GMainContext *context)
 {
-    NetCharDriver *s = chr->opaque;
+    NetCharDriver *s = (NetCharDriver *)chr;
 
     remove_fd_in_watch(chr);
     if (s->ioc) {
@@ -2761,13 +2762,12 @@ static void udp_chr_update_read_handler(CharDriverState *chr,
 
 static void udp_chr_free(CharDriverState *chr)
 {
-    NetCharDriver *s = chr->opaque;
+    NetCharDriver *s = (NetCharDriver *)chr;
 
     remove_fd_in_watch(chr);
     if (s->ioc) {
         object_unref(OBJECT(s->ioc));
     }
-    g_free(s);
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
 
@@ -2775,6 +2775,7 @@ static void udp_chr_free(CharDriverState *chr)
 /* TCP Net console */
 
 typedef struct {
+    CharDriverState parent;
     QIOChannel *ioc; /* Client I/O channel */
     QIOChannelSocket *sioc; /* Client master channel */
     QIOChannelSocket *listen_ioc;
@@ -2803,8 +2804,9 @@ static gboolean socket_reconnect_timeout(gpointer opaque);
 
 static void qemu_chr_socket_restart_timer(CharDriverState *chr)
 {
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = (TCPCharDriver *)chr;
     char *name;
+
     assert(s->connected == 0);
     s->reconnect_timer = g_timeout_add_seconds(s->reconnect_time,
                                                socket_reconnect_timeout, chr);
@@ -2816,7 +2818,7 @@ static void qemu_chr_socket_restart_timer(CharDriverState *chr)
 static void check_report_connect_error(CharDriverState *chr,
                                        Error *err)
 {
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = (TCPCharDriver *)chr;
 
     if (!s->connect_err_reported) {
         error_report("Unable to connect character device %s: %s",
@@ -2833,7 +2835,8 @@ static gboolean tcp_chr_accept(QIOChannel *chan,
 /* Called with chr_write_lock held.  */
 static int tcp_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
 {
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = (TCPCharDriver *)chr;
+
     if (s->connected) {
         int ret =  io_channel_send_full(s->ioc, buf, len,
                                         s->write_msgfds,
@@ -2856,7 +2859,7 @@ static int tcp_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
 static int tcp_chr_read_poll(void *opaque)
 {
     CharDriverState *chr = opaque;
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = opaque;
     if (!s->connected)
         return 0;
     s->max_size = qemu_chr_be_can_write(chr);
@@ -2915,7 +2918,8 @@ static void tcp_chr_process_IAC_bytes(CharDriverState *chr,
 
 static int tcp_get_msgfds(CharDriverState *chr, int *fds, int num)
 {
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = (TCPCharDriver *)chr;
+
     int to_copy = (s->read_msgfds_num < num) ? s->read_msgfds_num : num;
 
     assert(num <= TCP_MAX_FDS);
@@ -2940,7 +2944,7 @@ static int tcp_get_msgfds(CharDriverState *chr, int *fds, int num)
 
 static int tcp_set_msgfds(CharDriverState *chr, int *fds, int num)
 {
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = (TCPCharDriver *)chr;
 
     /* clear old pending fd array */
     g_free(s->write_msgfds);
@@ -2965,7 +2969,7 @@ static int tcp_set_msgfds(CharDriverState *chr, int *fds, int num)
 
 static ssize_t tcp_chr_recv(CharDriverState *chr, char *buf, size_t len)
 {
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = (TCPCharDriver *)chr;
     struct iovec iov = { .iov_base = buf, .iov_len = len };
     int ret;
     size_t i;
@@ -3022,13 +3026,13 @@ static ssize_t tcp_chr_recv(CharDriverState *chr, char *buf, size_t len)
 
 static GSource *tcp_chr_add_watch(CharDriverState *chr, GIOCondition cond)
 {
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = (TCPCharDriver *)chr;
     return qio_channel_create_watch(s->ioc, cond);
 }
 
 static void tcp_chr_free_connection(CharDriverState *chr)
 {
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = (TCPCharDriver *)chr;
     int i;
 
     if (!s->connected) {
@@ -3057,7 +3061,7 @@ static void tcp_chr_free_connection(CharDriverState *chr)
 
 static void tcp_chr_disconnect(CharDriverState *chr)
 {
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = (TCPCharDriver *)chr;
 
     if (!s->connected) {
         return;
@@ -3080,7 +3084,7 @@ static void tcp_chr_disconnect(CharDriverState *chr)
 static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
     CharDriverState *chr = opaque;
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = opaque;
     uint8_t buf[READ_BUF_LEN];
     int len, size;
 
@@ -3106,7 +3110,7 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 
 static int tcp_chr_sync_read(CharDriverState *chr, const uint8_t *buf, int len)
 {
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = (TCPCharDriver *)chr;
     int size;
 
     if (!s->connected) {
@@ -3125,7 +3129,7 @@ static int tcp_chr_sync_read(CharDriverState *chr, const uint8_t *buf, int len)
 static void tcp_chr_connect(void *opaque)
 {
     CharDriverState *chr = opaque;
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = opaque;
 
     g_free(chr->filename);
     chr->filename = sockaddr_to_str(
@@ -3146,7 +3150,7 @@ static void tcp_chr_connect(void *opaque)
 static void tcp_chr_update_read_handler(CharDriverState *chr,
                                         GMainContext *context)
 {
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = (TCPCharDriver *)chr;
 
     if (!s->connected) {
         return;
@@ -3197,7 +3201,7 @@ static gboolean tcp_chr_telnet_init_io(QIOChannel *ioc,
 
 static void tcp_chr_telnet_init(CharDriverState *chr)
 {
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = (TCPCharDriver *)chr;
     TCPCharDriverTelnetInit *init =
         g_new0(TCPCharDriverTelnetInit, 1);
     size_t n = 0;
@@ -3232,7 +3236,7 @@ static void tcp_chr_tls_handshake(QIOTask *task,
                                   gpointer user_data)
 {
     CharDriverState *chr = user_data;
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = user_data;
 
     if (qio_task_propagate_error(task, NULL)) {
         tcp_chr_disconnect(chr);
@@ -3248,7 +3252,7 @@ static void tcp_chr_tls_handshake(QIOTask *task,
 
 static void tcp_chr_tls_init(CharDriverState *chr)
 {
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = (TCPCharDriver *)chr;
     QIOChannelTLS *tioc;
     Error *err = NULL;
     gchar *name;
@@ -3287,7 +3291,7 @@ static void tcp_chr_tls_init(CharDriverState *chr)
 static void tcp_chr_set_client_ioc_name(CharDriverState *chr,
                                         QIOChannelSocket *sioc)
 {
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = (TCPCharDriver *)chr;
     char *name;
     name = g_strdup_printf("chardev-tcp-%s-%s",
                            s->is_listen ? "server" : "client",
@@ -3299,7 +3303,8 @@ static void tcp_chr_set_client_ioc_name(CharDriverState *chr,
 
 static int tcp_chr_new_client(CharDriverState *chr, QIOChannelSocket *sioc)
 {
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = (TCPCharDriver *)chr;
+
     if (s->ioc != NULL) {
 	return -1;
     }
@@ -3370,7 +3375,7 @@ static gboolean tcp_chr_accept(QIOChannel *channel,
 
 static int tcp_chr_wait_connected(CharDriverState *chr, Error **errp)
 {
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = (TCPCharDriver *)chr;
     QIOChannelSocket *sioc;
 
     /* It can't wait on s->connected, since it is set asynchronously
@@ -3418,7 +3423,7 @@ int qemu_chr_fe_wait_connected(CharBackend *be, Error **errp)
 
 static void tcp_chr_free(CharDriverState *chr)
 {
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = (TCPCharDriver *)chr;
 
     tcp_chr_free_connection(chr);
 
@@ -3437,7 +3442,7 @@ static void tcp_chr_free(CharDriverState *chr)
     if (s->tls_creds) {
         object_unref(OBJECT(s->tls_creds));
     }
-    g_free(s);
+
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
 
@@ -3446,7 +3451,7 @@ static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
 {
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(qio_task_get_source(task));
     CharDriverState *chr = opaque;
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = (TCPCharDriver *)chr;
     Error *err = NULL;
 
     if (qio_task_propagate_error(task, &err)) {
@@ -3467,6 +3472,7 @@ static void qemu_chr_socket_connected(QIOTask *task, void *opaque)
 /* Ring buffer chardev */
 
 typedef struct {
+    CharDriverState parent;
     size_t size;
     size_t prod;
     size_t cons;
@@ -3475,7 +3481,7 @@ typedef struct {
 
 static size_t ringbuf_count(const CharDriverState *chr)
 {
-    const RingBufCharDriver *d = chr->opaque;
+    const RingBufCharDriver *d = (RingBufCharDriver *)chr;
 
     return d->prod - d->cons;
 }
@@ -3483,7 +3489,7 @@ static size_t ringbuf_count(const CharDriverState *chr)
 /* Called with chr_write_lock held.  */
 static int ringbuf_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
 {
-    RingBufCharDriver *d = chr->opaque;
+    RingBufCharDriver *d = (RingBufCharDriver *)chr;
     int i;
 
     if (!buf || (len < 0)) {
@@ -3502,7 +3508,7 @@ static int ringbuf_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
 
 static int ringbuf_chr_read(CharDriverState *chr, uint8_t *buf, int len)
 {
-    RingBufCharDriver *d = chr->opaque;
+    RingBufCharDriver *d = (RingBufCharDriver *)chr;
     int i;
 
     qemu_mutex_lock(&chr->chr_write_lock);
@@ -3516,11 +3522,9 @@ static int ringbuf_chr_read(CharDriverState *chr, uint8_t *buf, int len)
 
 static void ringbuf_chr_free(struct CharDriverState *chr)
 {
-    RingBufCharDriver *d = chr->opaque;
+    RingBufCharDriver *d = (RingBufCharDriver *)chr;
 
     g_free(d->cbuf);
-    g_free(d);
-    chr->opaque = NULL;
 }
 
 static CharDriverState *qemu_chr_open_ringbuf(const CharDriver *driver,
@@ -3539,7 +3543,7 @@ static CharDriverState *qemu_chr_open_ringbuf(const CharDriver *driver,
     if (!chr) {
         return NULL;
     }
-    d = g_malloc(sizeof(*d));
+    d = (RingBufCharDriver *)chr;
 
     d->size = opts->has_size ? opts->size : 65536;
 
@@ -3553,12 +3557,9 @@ static CharDriverState *qemu_chr_open_ringbuf(const CharDriver *driver,
     d->cons = 0;
     d->cbuf = g_malloc0(d->size);
 
-    chr->opaque = d;
-
     return chr;
 
 fail:
-    g_free(d);
     qemu_chr_free_common(chr);
     return NULL;
 }
@@ -3849,10 +3850,12 @@ static const CharDriver stdio_driver = {
     .parse = qemu_chr_parse_stdio,
     .create = qemu_chr_open_stdio,
 #ifdef _WIN32
+    sizeof(WinStdioCharState),
     .chr_write = win_stdio_write,
     .chr_set_echo = qemu_chr_set_echo_win_stdio,
     .chr_free = win_stdio_free,
 #else
+    sizeof(FDCharDriver),
     .chr_add_watch = fd_chr_add_watch,
     .chr_write = fd_chr_write,
     .chr_update_read_handler = fd_chr_update_read_handler,
@@ -3915,9 +3918,11 @@ static const CharDriver pipe_driver = {
     .parse = qemu_chr_parse_pipe,
     .create = qemu_chr_open_pipe,
 #ifdef _WIN32
+    sizeof(WinCharState),
     .chr_write = win_chr_write,
     .chr_free = win_chr_free,
 #else
+    sizeof(FDCharDriver),
     .chr_add_watch = fd_chr_add_watch,
     .chr_write = fd_chr_write,
     .chr_update_read_handler = fd_chr_update_read_handler,
@@ -3942,6 +3947,7 @@ static void qemu_chr_parse_ringbuf(QemuOpts *opts, ChardevBackend *backend,
 }
 
 static const CharDriver ringbuf_driver = {
+    .instance_size = sizeof(RingBufCharDriver),
     .kind = CHARDEV_BACKEND_KIND_RINGBUF,
     .parse = qemu_chr_parse_ringbuf,
     .create = qemu_chr_open_ringbuf,
@@ -3951,6 +3957,7 @@ static const CharDriver ringbuf_driver = {
 
 /* Bug-compatibility: */
 static const CharDriver memory_driver = {
+    .instance_size = sizeof(RingBufCharDriver),
     .kind = CHARDEV_BACKEND_KIND_MEMORY,
     .parse = qemu_chr_parse_ringbuf,
     .create = qemu_chr_open_ringbuf,
@@ -3974,6 +3981,7 @@ static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
 }
 
 static const CharDriver mux_driver = {
+    .instance_size = sizeof(MuxDriver),
     .kind = CHARDEV_BACKEND_KIND_MUX,
     .parse = qemu_chr_parse_mux,
     .create = qemu_chr_open_mux,
@@ -4558,17 +4566,13 @@ static CharDriverState *qmp_chardev_open_serial(const CharDriver *driver,
     ChardevHostdev *serial = backend->u.serial.data;
     ChardevCommon *common = qapi_ChardevHostdev_base(serial);
     CharDriverState *chr;
-    WinCharState *s;
 
     chr = qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
 
-    s = g_new0(WinCharState, 1);
-    chr->opaque = s;
     if (win_chr_init(chr, serial->device, errp) < 0) {
-        g_free(s);
         qemu_chr_free_common(chr);
         return NULL;
     }
@@ -4668,6 +4672,7 @@ static CharDriverState *qmp_chardev_open_parallel(const CharDriver *driver,
 }
 
 static const CharDriver parallel_driver = {
+    .instance_size = sizeof(ParallelCharDriver),
     .kind = CHARDEV_BACKEND_KIND_PARALLEL,
     .alias = "parport",
     .parse = qemu_chr_parse_parallel,
@@ -4691,9 +4696,11 @@ static const CharDriver file_driver = {
     .parse = qemu_chr_parse_file_out,
     .create = qmp_chardev_open_file,
 #ifdef _WIN32
+    sizeof(WinCharState),
     .chr_write = win_chr_write,
     /* FIXME: no chr_free */
 #else
+    sizeof(FDCharDriver),
     .chr_add_watch = fd_chr_add_watch,
     .chr_write = fd_chr_write,
     .chr_update_read_handler = fd_chr_update_read_handler,
@@ -4708,9 +4715,11 @@ static const CharDriver serial_driver = {
     .parse = qemu_chr_parse_serial,
     .create = qmp_chardev_open_serial,
 #ifdef _WIN32
+    sizeof(WinCharState),
     .chr_write = win_chr_write,
     .chr_free = win_chr_free,
 #else
+    sizeof(FDCharDriver),
     .chr_add_watch = fd_chr_add_watch,
     .chr_write = fd_chr_write,
     .chr_update_read_handler = fd_chr_update_read_handler,
@@ -4723,7 +4732,7 @@ static const CharDriver serial_driver = {
 static gboolean socket_reconnect_timeout(gpointer opaque)
 {
     CharDriverState *chr = opaque;
-    TCPCharDriver *s = chr->opaque;
+    TCPCharDriver *s = opaque;
     QIOChannelSocket *sioc;
 
     s->reconnect_timer = 0;
@@ -4764,7 +4773,7 @@ static CharDriverState *qmp_chardev_open_socket(const CharDriver *driver,
     if (!chr) {
         return NULL;
     }
-    s = g_new0(TCPCharDriver, 1);
+    s = (TCPCharDriver *)chr;
 
     s->is_unix = addr->type == SOCKET_ADDRESS_KIND_UNIX;
     s->is_listen = is_listen;
@@ -4810,7 +4819,6 @@ static CharDriverState *qmp_chardev_open_socket(const CharDriver *driver,
         qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
     }
 
-    chr->opaque = s;
     /* be isn't opened until we get a connection */
     *be_opened = false;
 
@@ -4867,12 +4875,12 @@ static CharDriverState *qmp_chardev_open_socket(const CharDriver *driver,
     if (s->tls_creds) {
         object_unref(OBJECT(s->tls_creds));
     }
-    g_free(s);
     qemu_chr_free_common(chr);
     return NULL;
 }
 
 static const CharDriver socket_driver = {
+    .instance_size = sizeof(TCPCharDriver),
     .kind = CHARDEV_BACKEND_KIND_SOCKET,
     .parse = qemu_chr_parse_socket,
     .create = qmp_chardev_open_socket,
@@ -4918,9 +4926,8 @@ static CharDriverState *qmp_chardev_open_udp(const CharDriver *driver,
     qio_channel_set_name(QIO_CHANNEL(sioc), name);
     g_free(name);
 
-    s = g_new0(NetCharDriver, 1);
+    s = (NetCharDriver *)chr;
     s->ioc = QIO_CHANNEL(sioc);
-    chr->opaque = s;
     /* be isn't opened until we get a connection */
     *be_opened = false;
 
@@ -4928,6 +4935,7 @@ static CharDriverState *qmp_chardev_open_udp(const CharDriver *driver,
 }
 
 static const CharDriver udp_driver = {
+    .instance_size = sizeof(NetCharDriver),
     .kind = CHARDEV_BACKEND_KIND_UDP,
     .parse = qemu_chr_parse_udp,
     .create = qmp_chardev_open_udp,
diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index c7eb306..1aed451 100644
--- a/spice-qemu-char.c
+++ b/spice-qemu-char.c
@@ -7,7 +7,8 @@
 
 
 typedef struct SpiceCharDriver {
-    CharDriverState*      chr;
+    CharDriverState       parent;
+
     SpiceCharDeviceInstance     sin;
     bool                  active;
     bool                  blocked;
@@ -27,17 +28,18 @@ static QLIST_HEAD(, SpiceCharDriver) spice_chars =
 static int vmc_write(SpiceCharDeviceInstance *sin, const uint8_t *buf, int len)
 {
     SpiceCharDriver *scd = container_of(sin, SpiceCharDriver, sin);
+    CharDriverState *chr = (CharDriverState *)scd;
     ssize_t out = 0;
     ssize_t last_out;
     uint8_t* p = (uint8_t*)buf;
 
     while (len > 0) {
-        int can_write = qemu_chr_be_can_write(scd->chr);
+        int can_write = qemu_chr_be_can_write(chr);
         last_out = MIN(len, can_write);
         if (last_out <= 0) {
             break;
         }
-        qemu_chr_be_write(scd->chr, p, last_out);
+        qemu_chr_be_write(chr, p, last_out);
         out += last_out;
         len -= last_out;
         p += last_out;
@@ -70,6 +72,7 @@ static int vmc_read(SpiceCharDeviceInstance *sin, uint8_t *buf, int len)
 static void vmc_event(SpiceCharDeviceInstance *sin, uint8_t event)
 {
     SpiceCharDriver *scd = container_of(sin, SpiceCharDriver, sin);
+    CharDriverState *chr = (CharDriverState *)scd;
     int chr_event;
 
     switch (event) {
@@ -81,20 +84,21 @@ static void vmc_event(SpiceCharDeviceInstance *sin, uint8_t event)
     }
 
     trace_spice_vmc_event(chr_event);
-    qemu_chr_be_event(scd->chr, chr_event);
+    qemu_chr_be_event(chr, chr_event);
 }
 #endif
 
 static void vmc_state(SpiceCharDeviceInstance *sin, int connected)
 {
     SpiceCharDriver *scd = container_of(sin, SpiceCharDriver, sin);
+    CharDriverState *chr = (CharDriverState *)scd;
 
-    if ((scd->chr->be_open && connected) ||
-        (!scd->chr->be_open && !connected)) {
+    if ((chr->be_open && connected) ||
+        (!chr->be_open && !connected)) {
         return;
     }
 
-    qemu_chr_be_event(scd->chr,
+    qemu_chr_be_event(chr,
                       connected ? CHR_EVENT_OPENED : CHR_EVENT_CLOSED);
 }
 
@@ -168,7 +172,7 @@ static GSourceFuncs SpiceCharSourceFuncs = {
 
 static GSource *spice_chr_add_watch(CharDriverState *chr, GIOCondition cond)
 {
-    SpiceCharDriver *scd = chr->opaque;
+    SpiceCharDriver *scd = (SpiceCharDriver *)chr;
     SpiceCharSource *src;
 
     assert(cond & G_IO_OUT);
@@ -182,7 +186,7 @@ static GSource *spice_chr_add_watch(CharDriverState *chr, GIOCondition cond)
 
 static int spice_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
 {
-    SpiceCharDriver *s = chr->opaque;
+    SpiceCharDriver *s = (SpiceCharDriver *)chr;
     int read_bytes;
 
     assert(s->datalen == 0);
@@ -201,7 +205,7 @@ static int spice_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
 
 static void spice_chr_free(struct CharDriverState *chr)
 {
-    SpiceCharDriver *s = chr->opaque;
+    SpiceCharDriver *s = (SpiceCharDriver *)chr;
 
     vmc_unregister_interface(s);
     QLIST_REMOVE(s, next);
@@ -210,12 +214,11 @@ static void spice_chr_free(struct CharDriverState *chr)
 #if SPICE_SERVER_VERSION >= 0x000c02
     g_free((char *)s->sin.portname);
 #endif
-    g_free(s);
 }
 
 static void spice_vmc_set_fe_open(struct CharDriverState *chr, int fe_open)
 {
-    SpiceCharDriver *s = chr->opaque;
+    SpiceCharDriver *s = (SpiceCharDriver *)chr;
     if (fe_open) {
         vmc_register_interface(s);
     } else {
@@ -226,7 +229,7 @@ static void spice_vmc_set_fe_open(struct CharDriverState *chr, int fe_open)
 static void spice_port_set_fe_open(struct CharDriverState *chr, int fe_open)
 {
 #if SPICE_SERVER_VERSION >= 0x000c02
-    SpiceCharDriver *s = chr->opaque;
+    SpiceCharDriver *s = (SpiceCharDriver *)chr;
 
     if (fe_open) {
         spice_server_port_event(&s->sin, SPICE_PORT_EVENT_OPENED);
@@ -255,7 +258,7 @@ static void print_allowed_subtypes(void)
 
 static void spice_chr_accept_input(struct CharDriverState *chr)
 {
-    SpiceCharDriver *s = chr->opaque;
+    SpiceCharDriver *s = (SpiceCharDriver *)chr;
 
     spice_server_char_device_wakeup(&s->sin);
 }
@@ -272,11 +275,9 @@ static CharDriverState *chr_open(const CharDriver *driver,
     if (!chr) {
         return NULL;
     }
-    s = g_malloc0(sizeof(SpiceCharDriver));
-    s->chr = chr;
+    s = (SpiceCharDriver *)chr;
     s->active = false;
     s->sin.subtype = g_strdup(subtype);
-    chr->opaque = s;
 
     QLIST_INSERT_HEAD(&spice_chars, s, next);
 
@@ -334,7 +335,7 @@ static CharDriverState *qemu_chr_open_spice_port(const CharDriver *driver,
         return NULL;
     }
     *be_opened = false;
-    s = chr->opaque;
+    s = (SpiceCharDriver *)chr;
     s->sin.portname = g_strdup(name);
 
     return chr;
@@ -386,6 +387,7 @@ static void qemu_chr_parse_spice_port(QemuOpts *opts, ChardevBackend *backend,
 static void register_types(void)
 {
     static const CharDriver vmc_driver = {
+        .instance_size = sizeof(SpiceCharDriver),
         .kind = CHARDEV_BACKEND_KIND_SPICEVMC,
         .parse = qemu_chr_parse_spice_vmc,
         .create = qemu_chr_open_spice_vmc,
@@ -396,6 +398,7 @@ static void register_types(void)
         .chr_free = spice_chr_free,
     };
     static const CharDriver port_driver = {
+        .instance_size = sizeof(SpiceCharDriver),
         .kind = CHARDEV_BACKEND_KIND_SPICEPORT,
         .parse = qemu_chr_parse_spice_port,
         .create = qemu_chr_open_spice_port,
diff --git a/ui/console.c b/ui/console.c
index f48ba26..495d5a2 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1046,9 +1046,15 @@ void console_select(unsigned int index)
     }
 }
 
+typedef struct VCDriverState {
+    CharDriverState parent;
+    QemuConsole *console;
+} VCDriverState;
+
 static int console_puts(CharDriverState *chr, const uint8_t *buf, int len)
 {
-    QemuConsole *s = chr->opaque;
+    VCDriverState *drv = (VCDriverState *)chr;
+    QemuConsole *s = drv->console;
     int i;
 
     if (!s->ds) {
@@ -1958,7 +1964,8 @@ int qemu_console_get_height(QemuConsole *con, int fallback)
 
 static void text_console_set_echo(CharDriverState *chr, bool echo)
 {
-    QemuConsole *s = chr->opaque;
+    VCDriverState *drv = (VCDriverState *)chr;
+    QemuConsole *s = drv->console;
 
     s->echo = echo;
 }
@@ -1998,12 +2005,11 @@ static const GraphicHwOps text_console_ops = {
 
 static void text_console_do_init(CharDriverState *chr, DisplayState *ds)
 {
-    QemuConsole *s;
+    VCDriverState *drv = (VCDriverState *)chr;
+    QemuConsole *s = drv->console;
     int g_width = 80 * FONT_WIDTH;
     int g_height = 24 * FONT_HEIGHT;
 
-    s = chr->opaque;
-
     s->out_fifo.buf = s->out_fifo_buf;
     s->out_fifo.buf_size = sizeof(s->out_fifo_buf);
     s->kbd_timer = timer_new_ms(QEMU_CLOCK_REALTIME, kbd_send_chars, s);
@@ -2056,6 +2062,7 @@ static CharDriverState *text_console_init(ChardevVC *vc, Error **errp)
 {
     ChardevCommon *common = qapi_ChardevVC_base(vc);
     CharDriverState *chr;
+    VCDriverState *drv;
     QemuConsole *s;
     unsigned width = 0;
     unsigned height = 0;
@@ -2092,7 +2099,8 @@ static CharDriverState *text_console_init(ChardevVC *vc, Error **errp)
     }
 
     s->chr = chr;
-    chr->opaque = s;
+    drv = (VCDriverState *)chr;
+    drv->console = s;
 
     if (display_state) {
         text_console_do_init(chr, display_state);
@@ -2196,6 +2204,7 @@ static const TypeInfo qemu_console_info = {
 };
 
 static const CharDriver vc_driver = {
+    .instance_size = sizeof(VCDriverState),
     .kind = CHARDEV_BACKEND_KIND_VC,
     .parse = qemu_chr_parse_vc,
     .create = vc_init,
diff --git a/ui/gtk.c b/ui/gtk.c
index 608400b..90cf4d5 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -181,6 +181,12 @@ struct GtkDisplayState {
     bool ignore_keys;
 };
 
+typedef struct VCDriverState {
+    CharDriverState parent;
+    VirtualConsole *console;
+    bool echo;
+} VCDriverState;
+
 static void gd_grab_pointer(VirtualConsole *vc, const char *reason);
 static void gd_ungrab_pointer(GtkDisplayState *s);
 static void gd_grab_keyboard(VirtualConsole *vc, const char *reason);
@@ -1685,7 +1691,8 @@ static void gd_vc_adjustment_changed(GtkAdjustment *adjustment, void *opaque)
 
 static int gd_vc_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
 {
-    VirtualConsole *vc = chr->opaque;
+    VCDriverState *vcd = (VCDriverState *)chr;
+    VirtualConsole *vc = vcd->console;
 
     vte_terminal_feed(VTE_TERMINAL(vc->vte.terminal), (const char *)buf, len);
     return len;
@@ -1693,9 +1700,14 @@ static int gd_vc_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
 
 static void gd_vc_chr_set_echo(CharDriverState *chr, bool echo)
 {
-    VirtualConsole *vc = chr->opaque;
+    VCDriverState *vcd = (VCDriverState *)chr;
+    VirtualConsole *vc = vcd->console;
 
-    vc->vte.echo = echo;
+    if (vc) {
+        vc->vte.echo = echo;
+    } else {
+        vcd->echo = echo;
+    }
 }
 
 static int nb_vcs;
@@ -1704,6 +1716,7 @@ static CharDriverState *vcs[MAX_VCS];
 static CharDriverState *gd_vc_handler(ChardevVC *vc, Error **errp)
 {
     static const CharDriver gd_vc_driver = {
+        .instance_size = sizeof(VCDriverState),
         .kind = CHARDEV_BACKEND_KIND_VC,
         .chr_write = gd_vc_chr_write,
         .chr_set_echo = gd_vc_chr_set_echo,
@@ -1722,9 +1735,6 @@ static CharDriverState *gd_vc_handler(ChardevVC *vc, Error **errp)
         return NULL;
     }
 
-    /* Temporary, until gd_vc_vte_init runs.  */
-    chr->opaque = g_new0(VirtualConsole, 1);
-
     vcs[nb_vcs++] = chr;
 
     return chr;
@@ -1765,14 +1775,12 @@ static GSList *gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
     GtkWidget *box;
     GtkWidget *scrollbar;
     GtkAdjustment *vadjustment;
-    VirtualConsole *tmp_vc = chr->opaque;
+    VCDriverState *vcd = (VCDriverState *)chr;
 
     vc->s = s;
-    vc->vte.echo = tmp_vc->vte.echo;
-
+    vc->vte.echo = vcd->echo;
     vc->vte.chr = chr;
-    chr->opaque = vc;
-    g_free(tmp_vc);
+    vcd->console = vc;
 
     snprintf(buffer, sizeof(buffer), "vc%d", idx);
     vc->label = g_strdup_printf("%s", vc->vte.chr->label
-- 
1.8.3.1

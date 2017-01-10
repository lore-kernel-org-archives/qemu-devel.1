Received: from eggs.gnu.org ([2001:4830:134:3::10]:47294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cR0XB-0005Bx-Df
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cR0X6-0007mg-AK
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cR0X5-0007mD-Pw
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:28 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D06E8C04B316
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 17:48:27 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Jan 2017 18:47:57 +0100
Message-Id: <20170110174810.17748-8-marcandre.lureau@redhat.com>
In-Reply-To: <20170110174810.17748-1-marcandre.lureau@redhat.com>
References: <20170110174810.17748-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 07/20] char: move callbacks in CharDriver
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

This makes the code more declarative, and avoids duplicating the
information on all instances.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/sysemu/char.h |  46 ++---
 backends/baum.c       |  11 +-
 backends/msmouse.c    |  11 +-
 backends/testdev.c    |   8 +-
 gdbstub.c             |   7 +-
 hw/bt/hci-csr.c       |   8 +-
 qemu-char.c           | 479 ++++++++++++++++++++++++++++++--------------=
------
 spice-qemu-char.c     |  32 ++--
 ui/console.c          |  28 +--
 ui/gtk.c              |  11 +-
 10 files changed, 381 insertions(+), 260 deletions(-)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index fee2c3493c..2dd05642fb 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -85,24 +85,11 @@ typedef struct CharBackend {
     int fe_open;
 } CharBackend;
=20
+typedef struct CharDriver CharDriver;
+
 struct CharDriverState {
+    const CharDriver *driver;
     QemuMutex chr_write_lock;
-    int (*chr_write)(struct CharDriverState *s, const uint8_t *buf, int =
len);
-    int (*chr_sync_read)(struct CharDriverState *s,
-                         const uint8_t *buf, int len);
-    GSource *(*chr_add_watch)(struct CharDriverState *s, GIOCondition co=
nd);
-    void (*chr_update_read_handler)(struct CharDriverState *s,
-                                    GMainContext *context);
-    int (*chr_ioctl)(struct CharDriverState *s, int cmd, void *arg);
-    int (*get_msgfds)(struct CharDriverState *s, int* fds, int num);
-    int (*set_msgfds)(struct CharDriverState *s, int *fds, int num);
-    int (*chr_add_client)(struct CharDriverState *chr, int fd);
-    int (*chr_wait_connected)(struct CharDriverState *chr, Error **errp)=
;
-    void (*chr_free)(struct CharDriverState *chr);
-    void (*chr_disconnect)(struct CharDriverState *chr);
-    void (*chr_accept_input)(struct CharDriverState *chr);
-    void (*chr_set_echo)(struct CharDriverState *chr, bool echo);
-    void (*chr_set_fe_open)(struct CharDriverState *chr, int fe_open);
     CharBackend *be;
     void *opaque;
     char *label;
@@ -125,7 +112,8 @@ struct CharDriverState {
  *
  * Returns: a newly allocated CharDriverState, or NULL on error.
  */
-CharDriverState *qemu_chr_alloc(ChardevCommon *backend, Error **errp);
+CharDriverState *qemu_chr_alloc(const CharDriver *driver,
+                                ChardevCommon *backend, Error **errp);
=20
 /**
  * @qemu_chr_new_from_opts:
@@ -475,15 +463,33 @@ void qemu_chr_set_feature(CharDriverState *chr,
                           CharDriverFeature feature);
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename)=
;
=20
-typedef struct CharDriver {
+struct CharDriver {
     ChardevBackendKind kind;
     const char *alias;
     void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp)=
;
-    CharDriverState *(*create)(const char *id,
+    CharDriverState *(*create)(const CharDriver *driver,
+                               const char *id,
                                ChardevBackend *backend,
                                ChardevReturn *ret, bool *be_opened,
                                Error **errp);
-} CharDriver;
+
+    int (*chr_write)(struct CharDriverState *s, const uint8_t *buf, int =
len);
+    int (*chr_sync_read)(struct CharDriverState *s,
+                         const uint8_t *buf, int len);
+    GSource *(*chr_add_watch)(struct CharDriverState *s, GIOCondition co=
nd);
+    void (*chr_update_read_handler)(struct CharDriverState *s,
+                                    GMainContext *context);
+    int (*chr_ioctl)(struct CharDriverState *s, int cmd, void *arg);
+    int (*get_msgfds)(struct CharDriverState *s, int* fds, int num);
+    int (*set_msgfds)(struct CharDriverState *s, int *fds, int num);
+    int (*chr_add_client)(struct CharDriverState *chr, int fd);
+    int (*chr_wait_connected)(struct CharDriverState *chr, Error **errp)=
;
+    void (*chr_free)(struct CharDriverState *chr);
+    void (*chr_disconnect)(struct CharDriverState *chr);
+    void (*chr_accept_input)(struct CharDriverState *chr);
+    void (*chr_set_echo)(struct CharDriverState *chr, bool echo);
+    void (*chr_set_fe_open)(struct CharDriverState *chr, int fe_open);
+};
=20
 void register_char_driver(const CharDriver *driver);
=20
diff --git a/backends/baum.c b/backends/baum.c
index 2e404a11cc..109469e8f7 100644
--- a/backends/baum.c
+++ b/backends/baum.c
@@ -622,7 +622,8 @@ static void baum_free(struct CharDriverState *chr)
     g_free(baum);
 }
=20
-static CharDriverState *chr_baum_init(const char *id,
+static CharDriverState *chr_baum_init(const CharDriver *driver,
+                                      const char *id,
                                       ChardevBackend *backend,
                                       ChardevReturn *ret,
                                       bool *be_opened,
@@ -633,7 +634,7 @@ static CharDriverState *chr_baum_init(const char *id,
     CharDriverState *chr;
     brlapi_handle_t *handle;
=20
-    chr =3D qemu_chr_alloc(common, errp);
+    chr =3D qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
@@ -641,9 +642,6 @@ static CharDriverState *chr_baum_init(const char *id,
     baum->chr =3D chr;
=20
     chr->opaque =3D baum;
-    chr->chr_write =3D baum_write;
-    chr->chr_accept_input =3D baum_accept_input;
-    chr->chr_free =3D baum_free;
=20
     handle =3D g_malloc0(brlapi_getHandleSize());
     baum->brlapi =3D handle;
@@ -674,6 +672,9 @@ static void register_types(void)
     static const CharDriver driver =3D {
         .kind =3D CHARDEV_BACKEND_KIND_BRAILLE,
         .create =3D chr_baum_init,
+        .chr_write =3D baum_write,
+        .chr_accept_input =3D baum_accept_input,
+        .chr_free =3D baum_free,
     };
=20
     register_char_driver(&driver);
diff --git a/backends/msmouse.c b/backends/msmouse.c
index 2490b2c073..2c238ba1b3 100644
--- a/backends/msmouse.c
+++ b/backends/msmouse.c
@@ -148,7 +148,8 @@ static QemuInputHandler msmouse_handler =3D {
     .sync  =3D msmouse_input_sync,
 };
=20
-static CharDriverState *qemu_chr_open_msmouse(const char *id,
+static CharDriverState *qemu_chr_open_msmouse(const CharDriver *driver,
+                                              const char *id,
                                               ChardevBackend *backend,
                                               ChardevReturn *ret,
                                               bool *be_opened,
@@ -158,13 +159,10 @@ static CharDriverState *qemu_chr_open_msmouse(const=
 char *id,
     MouseState *mouse;
     CharDriverState *chr;
=20
-    chr =3D qemu_chr_alloc(common, errp);
+    chr =3D qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
-    chr->chr_write =3D msmouse_chr_write;
-    chr->chr_free =3D msmouse_chr_free;
-    chr->chr_accept_input =3D msmouse_chr_accept_input;
     *be_opened =3D false;
=20
     mouse =3D g_new0(MouseState, 1);
@@ -182,6 +180,9 @@ static void register_types(void)
     static const CharDriver driver =3D {
         .kind =3D CHARDEV_BACKEND_KIND_MSMOUSE,
         .create =3D qemu_chr_open_msmouse,
+        .chr_write =3D msmouse_chr_write,
+        .chr_accept_input =3D msmouse_chr_accept_input,
+        .chr_free =3D msmouse_chr_free,
     };
     register_char_driver(&driver);
 }
diff --git a/backends/testdev.c b/backends/testdev.c
index cd25094f86..233969391b 100644
--- a/backends/testdev.c
+++ b/backends/testdev.c
@@ -109,7 +109,8 @@ static void testdev_free(struct CharDriverState *chr)
     g_free(testdev);
 }
=20
-static CharDriverState *chr_testdev_init(const char *id,
+static CharDriverState *chr_testdev_init(const CharDriver *driver,
+                                         const char *id,
                                          ChardevBackend *backend,
                                          ChardevReturn *ret,
                                          bool *be_opened,
@@ -121,9 +122,8 @@ static CharDriverState *chr_testdev_init(const char *=
id,
     testdev =3D g_new0(TestdevCharState, 1);
     testdev->chr =3D chr =3D g_new0(CharDriverState, 1);
=20
+    chr->driver =3D driver;
     chr->opaque =3D testdev;
-    chr->chr_write =3D testdev_write;
-    chr->chr_free =3D testdev_free;
=20
     return chr;
 }
@@ -133,6 +133,8 @@ static void register_types(void)
     static const CharDriver driver =3D {
         .kind =3D CHARDEV_BACKEND_KIND_TESTDEV,
         .create =3D chr_testdev_init,
+        .chr_write =3D testdev_write,
+        .chr_free =3D testdev_free,
     };
     register_char_driver(&driver);
 }
diff --git a/gdbstub.c b/gdbstub.c
index de62d26096..96363b36c8 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1730,6 +1730,10 @@ int gdbserver_start(const char *device)
     CharDriverState *chr =3D NULL;
     CharDriverState *mon_chr;
     ChardevCommon common =3D { 0 };
+    static const CharDriver driver =3D {
+        .kind =3D -1,
+        .chr_write =3D gdb_monitor_write,
+    };
=20
     if (!device)
         return -1;
@@ -1762,8 +1766,7 @@ int gdbserver_start(const char *device)
         qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
=20
         /* Initialize a monitor terminal for gdb */
-        mon_chr =3D qemu_chr_alloc(&common, &error_abort);
-        mon_chr->chr_write =3D gdb_monitor_write;
+        mon_chr =3D qemu_chr_alloc(&driver, &common, &error_abort);
         monitor_init(mon_chr, 0);
     } else {
         if (qemu_chr_fe_get_driver(&s->chr)) {
diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
index fbb3109cc1..9c3fb3c8f9 100644
--- a/hw/bt/hci-csr.c
+++ b/hw/bt/hci-csr.c
@@ -462,12 +462,16 @@ qemu_irq *csrhci_pins_get(CharDriverState *chr)
=20
 CharDriverState *uart_hci_init(void)
 {
+    static const CharDriver hci_driver =3D {
+        .kind =3D -1,
+        .chr_write =3D csrhci_write,
+        .chr_ioctl =3D csrhci_ioctl,
+    };
     struct csrhci_s *s =3D (struct csrhci_s *)
             g_malloc0(sizeof(struct csrhci_s));
=20
     s->chr.opaque =3D s;
-    s->chr.chr_write =3D csrhci_write;
-    s->chr.chr_ioctl =3D csrhci_ioctl;
+    s->chr.driver =3D &hci_driver;
=20
     s->hci =3D qemu_next_hci();
     s->hci->opaque =3D s;
diff --git a/qemu-char.c b/qemu-char.c
index f3756a373f..9ce0aadc9b 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -162,11 +162,15 @@ static QTAILQ_HEAD(CharDriverStateHead, CharDriverS=
tate) chardevs =3D
=20
 static void qemu_chr_free_common(CharDriverState *chr);
=20
-CharDriverState *qemu_chr_alloc(ChardevCommon *backend, Error **errp)
+CharDriverState *qemu_chr_alloc(const CharDriver *driver,
+                                ChardevCommon *backend, Error **errp)
 {
     CharDriverState *chr =3D g_malloc0(sizeof(CharDriverState));
     qemu_mutex_init(&chr->chr_write_lock);
=20
+    assert(driver);
+    assert(driver->chr_write);
+
     if (backend->has_logfile) {
         int flags =3D O_WRONLY | O_CREAT;
         if (backend->has_logappend &&
@@ -186,6 +190,7 @@ CharDriverState *qemu_chr_alloc(ChardevCommon *backen=
d, Error **errp)
     } else {
         chr->logfd =3D -1;
     }
+    chr->driver =3D driver;
=20
     return chr;
 }
@@ -252,7 +257,7 @@ static int qemu_chr_fe_write_buffer(CharDriverState *=
s, const uint8_t *buf, int
     qemu_mutex_lock(&s->chr_write_lock);
     while (*offset < len) {
     retry:
-        res =3D s->chr_write(s, buf + *offset, len - *offset);
+        res =3D s->driver->chr_write(s, buf + *offset, len - *offset);
         if (res < 0 && errno =3D=3D EAGAIN) {
             g_usleep(100);
             goto retry;
@@ -290,7 +295,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t =
*buf, int len)
     }
=20
     qemu_mutex_lock(&s->chr_write_lock);
-    ret =3D s->chr_write(s, buf, len);
+    ret =3D s->driver->chr_write(s, buf, len);
=20
     if (ret > 0) {
         qemu_chr_fe_write_log(s, buf, ret);
@@ -346,7 +351,7 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *bu=
f, int len)
     int offset =3D 0, counter =3D 10;
     int res;
=20
-    if (!s || !s->chr_sync_read) {
+    if (!s || !s->driver->chr_sync_read) {
         return 0;
     }
=20
@@ -356,7 +361,7 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *bu=
f, int len)
=20
     while (offset < len) {
     retry:
-        res =3D s->chr_sync_read(s, buf + offset, len - offset);
+        res =3D s->driver->chr_sync_read(s, buf + offset, len - offset);
         if (res =3D=3D -1 && errno =3D=3D EAGAIN) {
             g_usleep(100);
             goto retry;
@@ -391,10 +396,10 @@ int qemu_chr_fe_ioctl(CharBackend *be, int cmd, voi=
d *arg)
     CharDriverState *s =3D be->chr;
     int res;
=20
-    if (!s || !s->chr_ioctl || s->replay) {
+    if (!s || !s->driver->chr_ioctl || s->replay) {
         res =3D -ENOTSUP;
     } else {
-        res =3D s->chr_ioctl(s, cmd, arg);
+        res =3D s->driver->chr_ioctl(s, cmd, arg);
     }
=20
     return res;
@@ -453,7 +458,7 @@ int qemu_chr_fe_get_msgfds(CharBackend *be, int *fds,=
 int len)
         return -1;
     }
=20
-    return s->get_msgfds ? s->get_msgfds(s, fds, len) : -1;
+    return s->driver->get_msgfds ? s->driver->get_msgfds(s, fds, len) : =
-1;
 }
=20
 int qemu_chr_fe_set_msgfds(CharBackend *be, int *fds, int num)
@@ -464,12 +469,12 @@ int qemu_chr_fe_set_msgfds(CharBackend *be, int *fd=
s, int num)
         return -1;
     }
=20
-    return s->set_msgfds ? s->set_msgfds(s, fds, num) : -1;
+    return s->driver->set_msgfds ? s->driver->set_msgfds(s, fds, num) : =
-1;
 }
=20
 int qemu_chr_add_client(CharDriverState *s, int fd)
 {
-    return s->chr_add_client ? s->chr_add_client(s, fd) : -1;
+    return s->driver->chr_add_client ? s->driver->chr_add_client(s, fd) =
: -1;
 }
=20
 void qemu_chr_fe_accept_input(CharBackend *be)
@@ -480,8 +485,9 @@ void qemu_chr_fe_accept_input(CharBackend *be)
         return;
     }
=20
-    if (s->chr_accept_input)
-        s->chr_accept_input(s);
+    if (s->driver->chr_accept_input) {
+        s->driver->chr_accept_input(s);
+    }
     qemu_notify_event();
 }
=20
@@ -506,7 +512,8 @@ static int null_chr_write(CharDriverState *chr, const=
 uint8_t *buf, int len)
     return len;
 }
=20
-static CharDriverState *qemu_chr_open_null(const char *id,
+static CharDriverState *qemu_chr_open_null(const CharDriver *driver,
+                                           const char *id,
                                            ChardevBackend *backend,
                                            ChardevReturn *ret,
                                            bool *be_opened,
@@ -515,15 +522,20 @@ static CharDriverState *qemu_chr_open_null(const ch=
ar *id,
     CharDriverState *chr;
     ChardevCommon *common =3D backend->u.null.data;
=20
-    chr =3D qemu_chr_alloc(common, errp);
+    chr =3D qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
-    chr->chr_write =3D null_chr_write;
     *be_opened =3D false;
     return chr;
 }
=20
+static const CharDriver null_driver =3D {
+    .kind =3D CHARDEV_BACKEND_KIND_NULL,
+    .create =3D qemu_chr_open_null,
+    .chr_write =3D null_chr_write,
+};
+
 /* MUX driver for serial I/O splitting */
 #define MAX_MUX 4
 #define MUX_BUFFER_SIZE 32	/* Must be a power of 2.  */
@@ -795,7 +807,11 @@ static GSource *mux_chr_add_watch(CharDriverState *s=
, GIOCondition cond)
     MuxDriver *d =3D s->opaque;
     CharDriverState *chr =3D qemu_chr_fe_get_driver(&d->chr);
=20
-    return chr->chr_add_watch(chr, cond);
+    if (!chr->driver->chr_add_watch) {
+        return NULL;
+    }
+
+    return chr->driver->chr_add_watch(chr, cond);
 }
=20
 static void mux_chr_free(struct CharDriverState *chr)
@@ -842,7 +858,8 @@ static void mux_set_focus(CharDriverState *chr, int f=
ocus)
     mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
 }
=20
-static CharDriverState *qemu_chr_open_mux(const char *id,
+static CharDriverState *qemu_chr_open_mux(const CharDriver *driver,
+                                          const char *id,
                                           ChardevBackend *backend,
                                           ChardevReturn *ret,
                                           bool *be_opened,
@@ -859,7 +876,7 @@ static CharDriverState *qemu_chr_open_mux(const char =
*id,
         return NULL;
     }
=20
-    chr =3D qemu_chr_alloc(common, errp);
+    chr =3D qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
@@ -867,14 +884,6 @@ static CharDriverState *qemu_chr_open_mux(const char=
 *id,
=20
     chr->opaque =3D d;
     d->focus =3D -1;
-    chr->chr_free =3D mux_chr_free;
-    chr->chr_write =3D mux_chr_write;
-    chr->chr_accept_input =3D mux_chr_accept_input;
-    /* Frontend guest-open / -close notification is not support with mux=
es */
-    chr->chr_set_fe_open =3D NULL;
-    if (drv->chr_add_watch) {
-        chr->chr_add_watch =3D mux_chr_add_watch;
-    }
     /* only default to opened state if we've realized the initial
      * set of muxes
      */
@@ -975,8 +984,8 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
     b->chr_read =3D fd_read;
     b->chr_event =3D fd_event;
     b->opaque =3D opaque;
-    if (s->chr_update_read_handler) {
-        s->chr_update_read_handler(s, context);
+    if (s->driver->chr_update_read_handler) {
+        s->driver->chr_update_read_handler(s, context);
     }
=20
     if (set_open) {
@@ -1271,14 +1280,15 @@ static void fd_chr_free(struct CharDriverState *c=
hr)
 }
=20
 /* open a character device to a unix fd */
-static CharDriverState *qemu_chr_open_fd(int fd_in, int fd_out,
+static CharDriverState *qemu_chr_open_fd(const CharDriver *driver,
+                                         int fd_in, int fd_out,
                                          ChardevCommon *backend, Error *=
*errp)
 {
     CharDriverState *chr;
     FDCharDriver *s;
     char *name;
=20
-    chr =3D qemu_chr_alloc(backend, errp);
+    chr =3D qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
@@ -1294,15 +1304,12 @@ static CharDriverState *qemu_chr_open_fd(int fd_i=
n, int fd_out,
     qemu_set_nonblock(fd_out);
     s->chr =3D chr;
     chr->opaque =3D s;
-    chr->chr_add_watch =3D fd_chr_add_watch;
-    chr->chr_write =3D fd_chr_write;
-    chr->chr_update_read_handler =3D fd_chr_update_read_handler;
-    chr->chr_free =3D fd_chr_free;
=20
     return chr;
 }
=20
-static CharDriverState *qemu_chr_open_pipe(const char *id,
+static CharDriverState *qemu_chr_open_pipe(const CharDriver *driver,
+                                           const char *id,
                                            ChardevBackend *backend,
                                            ChardevReturn *ret,
                                            bool *be_opened,
@@ -1333,7 +1340,7 @@ static CharDriverState *qemu_chr_open_pipe(const ch=
ar *id,
             return NULL;
         }
     }
-    return qemu_chr_open_fd(fd_in, fd_out, common, errp);
+    return qemu_chr_open_fd(driver, fd_in, fd_out, common, errp);
 }
=20
 /* init terminal so that we can grab keys */
@@ -1385,7 +1392,8 @@ static void qemu_chr_free_stdio(struct CharDriverSt=
ate *chr)
     fd_chr_free(chr);
 }
=20
-static CharDriverState *qemu_chr_open_stdio(const char *id,
+static CharDriverState *qemu_chr_open_stdio(const CharDriver *driver,
+                                            const char *id,
                                             ChardevBackend *backend,
                                             ChardevReturn *ret,
                                             bool *be_opened,
@@ -1416,12 +1424,10 @@ static CharDriverState *qemu_chr_open_stdio(const=
 char *id,
     act.sa_handler =3D term_stdio_handler;
     sigaction(SIGCONT, &act, NULL);
=20
-    chr =3D qemu_chr_open_fd(0, 1, common, errp);
+    chr =3D qemu_chr_open_fd(driver, 0, 1, common, errp);
     if (!chr) {
         return NULL;
     }
-    chr->chr_free =3D qemu_chr_free_stdio;
-    chr->chr_set_echo =3D qemu_chr_set_echo_stdio;
     if (opts->has_signal) {
         stdio_allow_signal =3D opts->signal;
     }
@@ -1638,7 +1644,8 @@ static void pty_chr_free(struct CharDriverState *ch=
r)
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
=20
-static CharDriverState *qemu_chr_open_pty(const char *id,
+static CharDriverState *qemu_chr_open_pty(const CharDriver *driver,
+                                          const char *id,
                                           ChardevBackend *backend,
                                           ChardevReturn *ret,
                                           bool *be_opened,
@@ -1660,7 +1667,7 @@ static CharDriverState *qemu_chr_open_pty(const cha=
r *id,
     close(slave_fd);
     qemu_set_nonblock(master_fd);
=20
-    chr =3D qemu_chr_alloc(common, errp);
+    chr =3D qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         close(master_fd);
         return NULL;
@@ -1675,10 +1682,6 @@ static CharDriverState *qemu_chr_open_pty(const ch=
ar *id,
=20
     s =3D g_new0(PtyCharDriver, 1);
     chr->opaque =3D s;
-    chr->chr_write =3D pty_chr_write;
-    chr->chr_update_read_handler =3D pty_chr_update_read_handler;
-    chr->chr_free =3D pty_chr_free;
-    chr->chr_add_watch =3D pty_chr_add_watch;
     *be_opened =3D false;
=20
     s->ioc =3D QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
@@ -1690,6 +1693,15 @@ static CharDriverState *qemu_chr_open_pty(const ch=
ar *id,
     return chr;
 }
=20
+static const CharDriver pty_driver =3D {
+    .kind =3D CHARDEV_BACKEND_KIND_PTY,
+    .create =3D qemu_chr_open_pty,
+    .chr_write =3D pty_chr_write,
+    .chr_update_read_handler =3D pty_chr_update_read_handler,
+    .chr_add_watch =3D pty_chr_add_watch,
+    .chr_free =3D pty_chr_free,
+};
+
 static void tty_serial_init(int fd, int speed,
                             int parity, int data_bits, int stop_bits)
 {
@@ -1880,7 +1892,8 @@ static void qemu_chr_free_tty(CharDriverState *chr)
     fd_chr_free(chr);
 }
=20
-static CharDriverState *qemu_chr_open_tty_fd(int fd,
+static CharDriverState *qemu_chr_open_tty_fd(const CharDriver *driver,
+                                             int fd,
                                              ChardevCommon *backend,
                                              bool *be_opened,
                                              Error **errp)
@@ -1888,12 +1901,10 @@ static CharDriverState *qemu_chr_open_tty_fd(int =
fd,
     CharDriverState *chr;
=20
     tty_serial_init(fd, 115200, 'N', 8, 1);
-    chr =3D qemu_chr_open_fd(fd, fd, backend, errp);
+    chr =3D qemu_chr_open_fd(driver, fd, fd, backend, errp);
     if (!chr) {
         return NULL;
     }
-    chr->chr_ioctl =3D tty_serial_ioctl;
-    chr->chr_free =3D qemu_chr_free_tty;
     return chr;
 }
 #endif /* __linux__ || __sun__ */
@@ -2011,7 +2022,8 @@ static void pp_free(CharDriverState *chr)
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
=20
-static CharDriverState *qemu_chr_open_pp_fd(int fd,
+static CharDriverState *qemu_chr_open_pp_fd(const CharDriver *driver,
+                                            int fd,
                                             ChardevCommon *backend,
                                             bool *be_opened,
                                             Error **errp)
@@ -2025,16 +2037,13 @@ static CharDriverState *qemu_chr_open_pp_fd(int f=
d,
         return NULL;
     }
=20
-    chr =3D qemu_chr_alloc(backend, errp);
+    chr =3D qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
=20
     drv =3D g_new0(ParallelCharDriver, 1);
     chr->opaque =3D drv;
-    chr->chr_write =3D null_chr_write;
-    chr->chr_ioctl =3D pp_ioctl;
-    chr->chr_free =3D pp_free;
=20
     drv->fd =3D fd;
     drv->mode =3D IEEE1284_MODE_COMPAT;
@@ -2084,20 +2093,19 @@ static int pp_ioctl(CharDriverState *chr, int cmd=
, void *arg)
     return 0;
 }
=20
-static CharDriverState *qemu_chr_open_pp_fd(int fd,
+static CharDriverState *qemu_chr_open_pp_fd(const CharDriver *driver,
+                                            int fd,
                                             ChardevCommon *backend,
                                             bool *be_opened,
                                             Error **errp)
 {
     CharDriverState *chr;
=20
-    chr =3D qemu_chr_alloc(backend, errp);
+    chr =3D qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
     chr->opaque =3D (void *)(intptr_t)fd;
-    chr->chr_write =3D null_chr_write;
-    chr->chr_ioctl =3D pp_ioctl;
     *be_opened =3D false;
     return chr;
 }
@@ -2319,21 +2327,20 @@ static int win_chr_poll(void *opaque)
     return 0;
 }
=20
-static CharDriverState *qemu_chr_open_win_path(const char *filename,
+static CharDriverState *qemu_chr_open_win_path(const CharDriver *driver,
+                                               const char *filename,
                                                ChardevCommon *backend,
                                                Error **errp)
 {
     CharDriverState *chr;
     WinCharState *s;
=20
-    chr =3D qemu_chr_alloc(backend, errp);
+    chr =3D qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
     s =3D g_new0(WinCharState, 1);
     chr->opaque =3D s;
-    chr->chr_write =3D win_chr_write;
-    chr->chr_free =3D win_chr_free;
=20
     if (win_chr_init(chr, filename, errp) < 0) {
         g_free(s);
@@ -2424,7 +2431,8 @@ static int win_chr_pipe_init(CharDriverState *chr, =
const char *filename,
 }
=20
=20
-static CharDriverState *qemu_chr_open_pipe(const char *id,
+static CharDriverState *qemu_chr_open_pipe(const CharDriver *driver,
+                                           const char *id,
                                            ChardevBackend *backend,
                                            ChardevReturn *ret,
                                            bool *be_opened,
@@ -2436,14 +2444,12 @@ static CharDriverState *qemu_chr_open_pipe(const =
char *id,
     WinCharState *s;
     ChardevCommon *common =3D qapi_ChardevHostdev_base(opts);
=20
-    chr =3D qemu_chr_alloc(common, errp);
+    chr =3D qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
     s =3D g_new0(WinCharState, 1);
     chr->opaque =3D s;
-    chr->chr_write =3D win_chr_write;
-    chr->chr_free =3D win_chr_free;
=20
     if (win_chr_pipe_init(chr, filename, errp) < 0) {
         g_free(s);
@@ -2453,35 +2459,43 @@ static CharDriverState *qemu_chr_open_pipe(const =
char *id,
     return chr;
 }
=20
-static CharDriverState *qemu_chr_open_win_file(HANDLE fd_out,
+static CharDriverState *qemu_chr_open_win_file(const CharDriver *driver,
+                                               HANDLE fd_out,
                                                ChardevCommon *backend,
                                                Error **errp)
 {
     CharDriverState *chr;
     WinCharState *s;
=20
-    chr =3D qemu_chr_alloc(backend, errp);
+    chr =3D qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
     s =3D g_new0(WinCharState, 1);
     s->hcom =3D fd_out;
     chr->opaque =3D s;
-    chr->chr_write =3D win_chr_write;
     return chr;
 }
=20
-static CharDriverState *qemu_chr_open_win_con(const char *id,
+static CharDriverState *qemu_chr_open_win_con(const CharDriver *driver,
+                                              const char *id,
                                               ChardevBackend *backend,
                                               ChardevReturn *ret,
                                               bool *be_opened,
                                               Error **errp)
 {
     ChardevCommon *common =3D backend->u.console.data;
-    return qemu_chr_open_win_file(GetStdHandle(STD_OUTPUT_HANDLE),
+    return qemu_chr_open_win_file(driver,
+                                  GetStdHandle(STD_OUTPUT_HANDLE),
                                   common, errp);
 }
=20
+static const CharDriver console_driver =3D {
+    .kind =3D CHARDEV_BACKEND_KIND_CONSOLE,
+    .create =3D qemu_chr_open_win_con,
+    .chr_write =3D win_chr_write,
+};
+
 static int win_stdio_write(CharDriverState *chr, const uint8_t *buf, int=
 len)
 {
     HANDLE  hStdOut =3D GetStdHandle(STD_OUTPUT_HANDLE);
@@ -2617,7 +2631,8 @@ static void win_stdio_free(CharDriverState *chr)
     g_free(chr->opaque);
 }
=20
-static CharDriverState *qemu_chr_open_stdio(const char *id,
+static CharDriverState *qemu_chr_open_stdio(const CharDriver *driver,
+                                            const char *id,
                                             ChardevBackend *backend,
                                             ChardevReturn *ret,
                                             bool *be_opened,
@@ -2629,7 +2644,7 @@ static CharDriverState *qemu_chr_open_stdio(const c=
har *id,
     int                is_console =3D 0;
     ChardevCommon *common =3D qapi_ChardevStdio_base(backend->u.stdio.da=
ta);
=20
-    chr   =3D qemu_chr_alloc(common, errp);
+    chr =3D qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
@@ -2644,8 +2659,6 @@ static CharDriverState *qemu_chr_open_stdio(const c=
har *id,
     is_console =3D GetConsoleMode(stdio->hStdIn, &dwMode) !=3D 0;
=20
     chr->opaque    =3D stdio;
-    chr->chr_write =3D win_stdio_write;
-    chr->chr_free =3D win_stdio_free;
=20
     if (is_console) {
         if (qemu_add_wait_object(stdio->hStdIn,
@@ -2687,7 +2700,6 @@ static CharDriverState *qemu_chr_open_stdio(const c=
har *id,
=20
     SetConsoleMode(stdio->hStdIn, dwMode);
=20
-    chr->chr_set_echo =3D qemu_chr_set_echo_win_stdio;
     qemu_chr_set_echo_win_stdio(chr, false);
=20
     return chr;
@@ -2794,7 +2806,8 @@ static void udp_chr_free(CharDriverState *chr)
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
=20
-static CharDriverState *qemu_chr_open_udp(QIOChannelSocket *sioc,
+static CharDriverState *qemu_chr_open_udp(const CharDriver *driver,
+                                          QIOChannelSocket *sioc,
                                           ChardevCommon *backend,
                                           bool *be_opened,
                                           Error **errp)
@@ -2802,7 +2815,7 @@ static CharDriverState *qemu_chr_open_udp(QIOChanne=
lSocket *sioc,
     CharDriverState *chr =3D NULL;
     NetCharDriver *s =3D NULL;
=20
-    chr =3D qemu_chr_alloc(backend, errp);
+    chr =3D qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
@@ -2812,9 +2825,6 @@ static CharDriverState *qemu_chr_open_udp(QIOChanne=
lSocket *sioc,
     s->bufcnt =3D 0;
     s->bufptr =3D 0;
     chr->opaque =3D s;
-    chr->chr_write =3D udp_chr_write;
-    chr->chr_update_read_handler =3D udp_chr_update_read_handler;
-    chr->chr_free =3D udp_chr_free;
     /* be isn't opened until we get a connection */
     *be_opened =3D false;
     return chr;
@@ -3449,8 +3459,8 @@ static int tcp_chr_wait_connected(CharDriverState *=
chr, Error **errp)
=20
 static int qemu_chr_wait_connected(CharDriverState *chr, Error **errp)
 {
-    if (chr->chr_wait_connected) {
-        return chr->chr_wait_connected(chr, errp);
+    if (chr->driver->chr_wait_connected) {
+        return chr->driver->chr_wait_connected(chr, errp);
     }
=20
     return 0;
@@ -3570,7 +3580,8 @@ static void ringbuf_chr_free(struct CharDriverState=
 *chr)
     chr->opaque =3D NULL;
 }
=20
-static CharDriverState *qemu_chr_open_ringbuf(const char *id,
+static CharDriverState *qemu_chr_open_ringbuf(const CharDriver *driver,
+                                              const char *id,
                                               ChardevBackend *backend,
                                               ChardevReturn *ret,
                                               bool *be_opened,
@@ -3581,7 +3592,7 @@ static CharDriverState *qemu_chr_open_ringbuf(const=
 char *id,
     CharDriverState *chr;
     RingBufCharDriver *d;
=20
-    chr =3D qemu_chr_alloc(common, errp);
+    chr =3D qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
@@ -3600,8 +3611,6 @@ static CharDriverState *qemu_chr_open_ringbuf(const=
 char *id,
     d->cbuf =3D g_malloc0(d->size);
=20
     chr->opaque =3D d;
-    chr->chr_write =3D ringbuf_chr_write;
-    chr->chr_free =3D ringbuf_chr_free;
=20
     return chr;
=20
@@ -3613,7 +3622,7 @@ fail:
=20
 bool chr_is_ringbuf(const CharDriverState *chr)
 {
-    return chr->chr_write =3D=3D ringbuf_chr_write;
+    return chr->driver->chr_write =3D=3D ringbuf_chr_write;
 }
=20
 void qmp_ringbuf_write(const char *device, const char *data,
@@ -3892,6 +3901,23 @@ static void qemu_chr_parse_stdio(QemuOpts *opts, C=
hardevBackend *backend,
     stdio->signal =3D qemu_opt_get_bool(opts, "signal", true);
 }
=20
+static const CharDriver stdio_driver =3D {
+    .kind =3D CHARDEV_BACKEND_KIND_STDIO,
+    .parse =3D qemu_chr_parse_stdio,
+    .create =3D qemu_chr_open_stdio,
+#ifdef _WIN32
+    .chr_write =3D win_stdio_write,
+    .chr_set_echo =3D qemu_chr_set_echo_win_stdio,
+    .chr_free =3D win_stdio_free,
+#else
+    .chr_add_watch =3D fd_chr_add_watch,
+    .chr_write =3D fd_chr_write,
+    .chr_update_read_handler =3D fd_chr_update_read_handler,
+    .chr_set_echo =3D qemu_chr_set_echo_stdio,
+    .chr_free =3D qemu_chr_free_stdio,
+#endif
+};
+
 #ifdef HAVE_CHARDEV_SERIAL
 static void qemu_chr_parse_serial(QemuOpts *opts, ChardevBackend *backen=
d,
                                   Error **errp)
@@ -3941,6 +3967,21 @@ static void qemu_chr_parse_pipe(QemuOpts *opts, Ch=
ardevBackend *backend,
     dev->device =3D g_strdup(device);
 }
=20
+static const CharDriver pipe_driver =3D {
+    .kind =3D CHARDEV_BACKEND_KIND_PIPE,
+    .parse =3D qemu_chr_parse_pipe,
+    .create =3D qemu_chr_open_pipe,
+#ifdef _WIN32
+    .chr_write =3D win_chr_write,
+    .chr_free =3D win_chr_free,
+#else
+    .chr_add_watch =3D fd_chr_add_watch,
+    .chr_write =3D fd_chr_write,
+    .chr_update_read_handler =3D fd_chr_update_read_handler,
+    .chr_free =3D fd_chr_free,
+#endif
+};
+
 static void qemu_chr_parse_ringbuf(QemuOpts *opts, ChardevBackend *backe=
nd,
                                    Error **errp)
 {
@@ -3957,6 +3998,23 @@ static void qemu_chr_parse_ringbuf(QemuOpts *opts,=
 ChardevBackend *backend,
     }
 }
=20
+static const CharDriver ringbuf_driver =3D {
+    .kind =3D CHARDEV_BACKEND_KIND_RINGBUF,
+    .parse =3D qemu_chr_parse_ringbuf,
+    .create =3D qemu_chr_open_ringbuf,
+    .chr_write =3D ringbuf_chr_write,
+    .chr_free =3D ringbuf_chr_free,
+};
+
+/* Bug-compatibility: */
+static const CharDriver memory_driver =3D {
+    .kind =3D CHARDEV_BACKEND_KIND_MEMORY,
+    .parse =3D qemu_chr_parse_ringbuf,
+    .create =3D qemu_chr_open_ringbuf,
+    .chr_write =3D ringbuf_chr_write,
+    .chr_free =3D ringbuf_chr_free,
+};
+
 static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
                                Error **errp)
 {
@@ -3972,6 +4030,16 @@ static void qemu_chr_parse_mux(QemuOpts *opts, Cha=
rdevBackend *backend,
     mux->chardev =3D g_strdup(chardev);
 }
=20
+static const CharDriver mux_driver =3D {
+    .kind =3D CHARDEV_BACKEND_KIND_MUX,
+    .parse =3D qemu_chr_parse_mux,
+    .create =3D qemu_chr_open_mux,
+    .chr_free =3D mux_chr_free,
+    .chr_write =3D mux_chr_write,
+    .chr_accept_input =3D mux_chr_accept_input,
+    .chr_add_watch =3D mux_chr_add_watch,
+};
+
 static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backen=
d,
                                   Error **errp)
 {
@@ -4244,7 +4312,7 @@ CharDriverState *qemu_chr_new(const char *label, co=
nst char *filename)
     chr =3D qemu_chr_new_noreplay(label, filename);
     if (chr) {
         chr->replay =3D replay_mode !=3D REPLAY_MODE_NONE;
-        if (chr->replay && chr->chr_ioctl) {
+        if (chr->replay && chr->driver->chr_ioctl) {
             fprintf(stderr,
                     "Replay: ioctl is not supported for serial devices y=
et\n");
         }
@@ -4257,8 +4325,8 @@ void qemu_chr_fe_set_echo(CharBackend *be, bool ech=
o)
 {
     CharDriverState *chr =3D be->chr;
=20
-    if (chr && chr->chr_set_echo) {
-        chr->chr_set_echo(chr, echo);
+    if (chr && chr->driver->chr_set_echo) {
+        chr->driver->chr_set_echo(chr, echo);
     }
 }
=20
@@ -4274,8 +4342,8 @@ void qemu_chr_fe_set_open(CharBackend *be, int fe_o=
pen)
         return;
     }
     be->fe_open =3D fe_open;
-    if (chr->chr_set_fe_open) {
-        chr->chr_set_fe_open(chr, fe_open);
+    if (chr->driver->chr_set_fe_open) {
+        chr->driver->chr_set_fe_open(chr, fe_open);
     }
 }
=20
@@ -4286,11 +4354,11 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOC=
ondition cond,
     GSource *src;
     guint tag;
=20
-    if (!s || s->chr_add_watch =3D=3D NULL) {
+    if (!s || s->driver->chr_add_watch =3D=3D NULL) {
         return 0;
     }
=20
-    src =3D s->chr_add_watch(s, cond);
+    src =3D s->driver->chr_add_watch(s, cond);
     if (!src) {
         return 0;
     }
@@ -4306,8 +4374,8 @@ void qemu_chr_fe_disconnect(CharBackend *be)
 {
     CharDriverState *chr =3D be->chr;
=20
-    if (chr && chr->chr_disconnect) {
-        chr->chr_disconnect(chr);
+    if (chr && chr->driver->chr_disconnect) {
+        chr->driver->chr_disconnect(chr);
     }
 }
=20
@@ -4327,8 +4395,8 @@ static void qemu_chr_free_common(CharDriverState *c=
hr)
=20
 void qemu_chr_free(CharDriverState *chr)
 {
-    if (chr->chr_free) {
-        chr->chr_free(chr);
+    if (chr->driver->chr_free) {
+        chr->driver->chr_free(chr);
     }
     qemu_chr_free_common(chr);
 }
@@ -4498,7 +4566,8 @@ QemuOptsList qemu_chardev_opts =3D {
=20
 #ifdef _WIN32
=20
-static CharDriverState *qmp_chardev_open_file(const char *id,
+static CharDriverState *qmp_chardev_open_file(const CharDriver *driver,
+                                              const char *id,
                                               ChardevBackend *backend,
                                               ChardevReturn *ret,
                                               bool *be_opened,
@@ -4531,10 +4600,11 @@ static CharDriverState *qmp_chardev_open_file(con=
st char *id,
         error_setg(errp, "open %s failed", file->out);
         return NULL;
     }
-    return qemu_chr_open_win_file(out, common, errp);
+    return qemu_chr_open_win_file(driver, out, common, errp);
 }
=20
-static CharDriverState *qmp_chardev_open_serial(const char *id,
+static CharDriverState *qmp_chardev_open_serial(const CharDriver *driver=
,
+                                                const char *id,
                                                 ChardevBackend *backend,
                                                 ChardevReturn *ret,
                                                 bool *be_opened,
@@ -4542,7 +4612,8 @@ static CharDriverState *qmp_chardev_open_serial(con=
st char *id,
 {
     ChardevHostdev *serial =3D backend->u.serial.data;
     ChardevCommon *common =3D qapi_ChardevHostdev_base(serial);
-    return qemu_chr_open_win_path(serial->device, common, errp);
+
+    return qemu_chr_open_win_path(driver, serial->device, common, errp);
 }
=20
 #else /* WIN32 */
@@ -4559,7 +4630,8 @@ static int qmp_chardev_open_file_source(char *src, =
int flags,
     return fd;
 }
=20
-static CharDriverState *qmp_chardev_open_file(const char *id,
+static CharDriverState *qmp_chardev_open_file(const CharDriver *driver,
+                                              const char *id,
                                               ChardevBackend *backend,
                                               ChardevReturn *ret,
                                               bool *be_opened,
@@ -4590,11 +4662,12 @@ static CharDriverState *qmp_chardev_open_file(con=
st char *id,
         }
     }
=20
-    return qemu_chr_open_fd(in, out, common, errp);
+    return qemu_chr_open_fd(driver, in, out, common, errp);
 }
=20
 #ifdef HAVE_CHARDEV_SERIAL
-static CharDriverState *qmp_chardev_open_serial(const char *id,
+static CharDriverState *qmp_chardev_open_serial(const CharDriver *driver=
,
+                                                const char *id,
                                                 ChardevBackend *backend,
                                                 ChardevReturn *ret,
                                                 bool *be_opened,
@@ -4609,12 +4682,14 @@ static CharDriverState *qmp_chardev_open_serial(c=
onst char *id,
         return NULL;
     }
     qemu_set_nonblock(fd);
-    return qemu_chr_open_tty_fd(fd, common, be_opened, errp);
+
+    return qemu_chr_open_tty_fd(driver, fd, common, be_opened, errp);
 }
 #endif
=20
 #ifdef HAVE_CHARDEV_PARPORT
-static CharDriverState *qmp_chardev_open_parallel(const char *id,
+static CharDriverState *qmp_chardev_open_parallel(const CharDriver *driv=
er,
+                                                  const char *id,
                                                   ChardevBackend *backen=
d,
                                                   ChardevReturn *ret,
                                                   bool *be_opened,
@@ -4628,12 +4703,62 @@ static CharDriverState *qmp_chardev_open_parallel=
(const char *id,
     if (fd < 0) {
         return NULL;
     }
-    return qemu_chr_open_pp_fd(fd, common, be_opened, errp);
+    return qemu_chr_open_pp_fd(driver, fd, common, be_opened, errp);
 }
+
+static const CharDriver parallel_driver =3D {
+    .kind =3D CHARDEV_BACKEND_KIND_PARALLEL,
+    .alias =3D "parport",
+    .parse =3D qemu_chr_parse_parallel,
+    .create =3D qmp_chardev_open_parallel,
+#if defined(__linux__)
+    .chr_write =3D null_chr_write,
+    .chr_ioctl =3D pp_ioctl,
+    .chr_free =3D pp_free,
+#elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__) || defined(__D=
ragonFly__)
+    .chr_write =3D null_chr_write,
+    .chr_ioctl =3D pp_ioctl,
+    /* FIXME: no chr_free */
+#endif
+};
 #endif
=20
 #endif /* WIN32 */
=20
+static const CharDriver file_driver =3D {
+    .kind =3D CHARDEV_BACKEND_KIND_FILE,
+    .parse =3D qemu_chr_parse_file_out,
+    .create =3D qmp_chardev_open_file,
+#ifdef _WIN32
+    .chr_write =3D win_chr_write,
+    /* FIXME: no chr_free */
+#else
+    .chr_add_watch =3D fd_chr_add_watch,
+    .chr_write =3D fd_chr_write,
+    .chr_update_read_handler =3D fd_chr_update_read_handler,
+    .chr_free =3D fd_chr_free,
+#endif
+};
+
+#ifdef HAVE_CHARDEV_SERIAL
+static const CharDriver serial_driver =3D {
+    .kind =3D CHARDEV_BACKEND_KIND_SERIAL,
+    .alias =3D "tty",
+    .parse =3D qemu_chr_parse_serial,
+    .create =3D qmp_chardev_open_serial,
+#ifdef _WIN32
+    .chr_write =3D win_chr_write,
+    .chr_free =3D win_chr_free,
+#else
+    .chr_add_watch =3D fd_chr_add_watch,
+    .chr_write =3D fd_chr_write,
+    .chr_update_read_handler =3D fd_chr_update_read_handler,
+    .chr_ioctl =3D tty_serial_ioctl,
+    .chr_free =3D qemu_chr_free_tty,
+#endif
+};
+#endif
+
 static gboolean socket_reconnect_timeout(gpointer opaque)
 {
     CharDriverState *chr =3D opaque;
@@ -4655,7 +4780,8 @@ static gboolean socket_reconnect_timeout(gpointer o=
paque)
     return false;
 }
=20
-static CharDriverState *qmp_chardev_open_socket(const char *id,
+static CharDriverState *qmp_chardev_open_socket(const CharDriver *driver=
,
+                                                const char *id,
                                                 ChardevBackend *backend,
                                                 ChardevReturn *ret,
                                                 bool *be_opened,
@@ -4673,7 +4799,7 @@ static CharDriverState *qmp_chardev_open_socket(con=
st char *id,
     ChardevCommon *common =3D qapi_ChardevSocket_base(sock);
     QIOChannelSocket *sioc =3D NULL;
=20
-    chr =3D qemu_chr_alloc(common, errp);
+    chr =3D qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
@@ -4724,16 +4850,6 @@ static CharDriverState *qmp_chardev_open_socket(co=
nst char *id,
     }
=20
     chr->opaque =3D s;
-    chr->chr_wait_connected =3D tcp_chr_wait_connected;
-    chr->chr_write =3D tcp_chr_write;
-    chr->chr_sync_read =3D tcp_chr_sync_read;
-    chr->chr_free =3D tcp_chr_free;
-    chr->chr_disconnect =3D tcp_chr_disconnect;
-    chr->get_msgfds =3D tcp_get_msgfds;
-    chr->set_msgfds =3D tcp_set_msgfds;
-    chr->chr_add_client =3D tcp_chr_add_client;
-    chr->chr_add_watch =3D tcp_chr_add_watch;
-    chr->chr_update_read_handler =3D tcp_chr_update_read_handler;
     /* be isn't opened until we get a connection */
     *be_opened =3D false;
=20
@@ -4795,7 +4911,24 @@ static CharDriverState *qmp_chardev_open_socket(co=
nst char *id,
     return NULL;
 }
=20
-static CharDriverState *qmp_chardev_open_udp(const char *id,
+static const CharDriver socket_driver =3D {
+    .kind =3D CHARDEV_BACKEND_KIND_SOCKET,
+    .parse =3D qemu_chr_parse_socket,
+    .create =3D qmp_chardev_open_socket,
+    .chr_wait_connected =3D tcp_chr_wait_connected,
+    .chr_write =3D tcp_chr_write,
+    .chr_sync_read =3D tcp_chr_sync_read,
+    .chr_disconnect =3D tcp_chr_disconnect,
+    .get_msgfds =3D tcp_get_msgfds,
+    .set_msgfds =3D tcp_set_msgfds,
+    .chr_add_client =3D tcp_chr_add_client,
+    .chr_add_watch =3D tcp_chr_add_watch,
+    .chr_update_read_handler =3D tcp_chr_update_read_handler,
+    .chr_free =3D tcp_chr_free,
+};
+
+static CharDriverState *qmp_chardev_open_udp(const CharDriver *driver,
+                                             const char *id,
                                              ChardevBackend *backend,
                                              ChardevReturn *ret,
                                              bool *be_opened,
@@ -4813,7 +4946,8 @@ static CharDriverState *qmp_chardev_open_udp(const =
char *id,
         object_unref(OBJECT(sioc));
         return NULL;
     }
-    chr =3D qemu_chr_open_udp(sioc, common, be_opened, errp);
+
+    chr =3D qemu_chr_open_udp(driver, sioc, common, be_opened, errp);
=20
     name =3D g_strdup_printf("chardev-udp-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(sioc), name);
@@ -4822,6 +4956,14 @@ static CharDriverState *qmp_chardev_open_udp(const=
 char *id,
     return chr;
 }
=20
+static const CharDriver udp_driver =3D {
+    .kind =3D CHARDEV_BACKEND_KIND_UDP,
+    .parse =3D qemu_chr_parse_udp,
+    .create =3D qmp_chardev_open_udp,
+    .chr_write =3D udp_chr_write,
+    .chr_update_read_handler =3D udp_chr_update_read_handler,
+    .chr_free =3D udp_chr_free,
+};
=20
 bool qemu_chr_has_feature(CharDriverState *chr,
                           CharDriverFeature feature)
@@ -4857,7 +4999,7 @@ ChardevReturn *qmp_chardev_add(const char *id, Char=
devBackend *backend,
         goto out_error;
     }
=20
-    chr =3D cd->create(id, backend, ret, &be_opened, &local_err);
+    chr =3D cd->create(cd, id, backend, ret, &be_opened, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto out_error;
@@ -4910,86 +5052,33 @@ void qemu_chr_cleanup(void)
=20
 static void register_types(void)
 {
-    int i;
-    static const CharDriver drivers[] =3D {
-        {
-            .kind =3D CHARDEV_BACKEND_KIND_NULL,
-            .create =3D qemu_chr_open_null,
-        },
-        {
-            .kind =3D CHARDEV_BACKEND_KIND_SOCKET,
-            .parse =3D qemu_chr_parse_socket,
-            .create =3D qmp_chardev_open_socket,
-        },
-        {
-            .kind =3D CHARDEV_BACKEND_KIND_UDP,
-            .parse =3D qemu_chr_parse_udp,
-            .create =3D qmp_chardev_open_udp,
-        },
-        {
-            .kind =3D CHARDEV_BACKEND_KIND_RINGBUF,
-            .parse =3D qemu_chr_parse_ringbuf,
-            .create =3D qemu_chr_open_ringbuf,
-        },
-        {
-            .kind =3D CHARDEV_BACKEND_KIND_FILE,
-            .parse =3D qemu_chr_parse_file_out,
-            .create =3D qmp_chardev_open_file,
-        },
-        {
-            .kind =3D CHARDEV_BACKEND_KIND_STDIO,
-            .parse =3D qemu_chr_parse_stdio,
-            .create =3D qemu_chr_open_stdio,
-        },
-#if defined HAVE_CHARDEV_SERIAL
-        {
-            .kind =3D CHARDEV_BACKEND_KIND_SERIAL,
-            .alias =3D "tty",
-            .parse =3D qemu_chr_parse_serial,
-            .create =3D qmp_chardev_open_serial,
-        },
+    static const CharDriver *drivers[] =3D {
+        &null_driver,
+        &socket_driver,
+        &udp_driver,
+        &ringbuf_driver,
+        &file_driver,
+        &stdio_driver,
+#ifdef HAVE_CHARDEV_SERIAL
+        &serial_driver,
 #endif
 #ifdef HAVE_CHARDEV_PARPORT
-        {
-            .kind =3D CHARDEV_BACKEND_KIND_PARALLEL,
-            .alias =3D "parport",
-            .parse =3D qemu_chr_parse_parallel,
-            .create =3D qmp_chardev_open_parallel,
-        },
+        &parallel_driver,
 #endif
 #ifdef HAVE_CHARDEV_PTY
-        {
-            .kind =3D CHARDEV_BACKEND_KIND_PTY,
-            .create =3D qemu_chr_open_pty,
-        },
+        &pty_driver,
 #endif
 #ifdef _WIN32
-        {
-            .kind =3D CHARDEV_BACKEND_KIND_CONSOLE,
-            .create =3D qemu_chr_open_win_con,
-        },
+        &console_driver,
 #endif
-        {
-            .kind =3D CHARDEV_BACKEND_KIND_PIPE,
-            .parse =3D qemu_chr_parse_pipe,
-            .create =3D qemu_chr_open_pipe,
-        },
-        {
-            .kind =3D CHARDEV_BACKEND_KIND_MUX,
-            .parse =3D qemu_chr_parse_mux,
-            .create =3D qemu_chr_open_mux,
-        },
-        /* Bug-compatibility: */
-        {
-            .kind =3D CHARDEV_BACKEND_KIND_MEMORY,
-            .parse =3D qemu_chr_parse_ringbuf,
-            .create =3D qemu_chr_open_ringbuf,
-        },
+        &pipe_driver,
+        &mux_driver,
+        &memory_driver
     };
-
+    int i;
=20
     for (i =3D 0; i < ARRAY_SIZE(drivers); i++) {
-        register_char_driver(&drivers[i]);
+        register_char_driver(drivers[i]);
     }
=20
     /* this must be done after machine init, since we register FEs with =
muxes
diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index 30db420e2f..c7eb306f34 100644
--- a/spice-qemu-char.c
+++ b/spice-qemu-char.c
@@ -260,16 +260,15 @@ static void spice_chr_accept_input(struct CharDrive=
rState *chr)
     spice_server_char_device_wakeup(&s->sin);
 }
=20
-static CharDriverState *chr_open(const char *subtype,
-                                 void (*set_fe_open)(struct CharDriverSt=
ate *,
-                                                     int),
+static CharDriverState *chr_open(const CharDriver *driver,
+                                 const char *subtype,
                                  ChardevCommon *backend,
                                  Error **errp)
 {
     CharDriverState *chr;
     SpiceCharDriver *s;
=20
-    chr =3D qemu_chr_alloc(backend, errp);
+    chr =3D qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
@@ -278,18 +277,14 @@ static CharDriverState *chr_open(const char *subtyp=
e,
     s->active =3D false;
     s->sin.subtype =3D g_strdup(subtype);
     chr->opaque =3D s;
-    chr->chr_write =3D spice_chr_write;
-    chr->chr_add_watch =3D spice_chr_add_watch;
-    chr->chr_free =3D spice_chr_free;
-    chr->chr_set_fe_open =3D set_fe_open;
-    chr->chr_accept_input =3D spice_chr_accept_input;
=20
     QLIST_INSERT_HEAD(&spice_chars, s, next);
=20
     return chr;
 }
=20
-static CharDriverState *qemu_chr_open_spice_vmc(const char *id,
+static CharDriverState *qemu_chr_open_spice_vmc(const CharDriver *driver=
,
+                                                const char *id,
                                                 ChardevBackend *backend,
                                                 ChardevReturn *ret,
                                                 bool *be_opened,
@@ -312,11 +307,12 @@ static CharDriverState *qemu_chr_open_spice_vmc(con=
st char *id,
     }
=20
     *be_opened =3D false;
-    return chr_open(type, spice_vmc_set_fe_open, common, errp);
+    return chr_open(driver, type, common, errp);
 }
=20
 #if SPICE_SERVER_VERSION >=3D 0x000c02
-static CharDriverState *qemu_chr_open_spice_port(const char *id,
+static CharDriverState *qemu_chr_open_spice_port(const CharDriver *drive=
r,
+                                                 const char *id,
                                                  ChardevBackend *backend=
,
                                                  ChardevReturn *ret,
                                                  bool *be_opened,
@@ -333,7 +329,7 @@ static CharDriverState *qemu_chr_open_spice_port(cons=
t char *id,
         return NULL;
     }
=20
-    chr =3D chr_open("port", spice_port_set_fe_open, common, errp);
+    chr =3D chr_open(driver, "port", common, errp);
     if (!chr) {
         return NULL;
     }
@@ -393,11 +389,21 @@ static void register_types(void)
         .kind =3D CHARDEV_BACKEND_KIND_SPICEVMC,
         .parse =3D qemu_chr_parse_spice_vmc,
         .create =3D qemu_chr_open_spice_vmc,
+        .chr_write =3D spice_chr_write,
+        .chr_add_watch =3D spice_chr_add_watch,
+        .chr_set_fe_open =3D spice_vmc_set_fe_open,
+        .chr_accept_input =3D spice_chr_accept_input,
+        .chr_free =3D spice_chr_free,
     };
     static const CharDriver port_driver =3D {
         .kind =3D CHARDEV_BACKEND_KIND_SPICEPORT,
         .parse =3D qemu_chr_parse_spice_port,
         .create =3D qemu_chr_open_spice_port,
+        .chr_write =3D spice_chr_write,
+        .chr_add_watch =3D spice_chr_add_watch,
+        .chr_set_fe_open =3D spice_port_set_fe_open,
+        .chr_accept_input =3D spice_chr_accept_input,
+        .chr_free =3D spice_chr_free,
     };
     register_char_driver(&vmc_driver);
     register_char_driver(&port_driver);
diff --git a/ui/console.c b/ui/console.c
index e4bb22fe87..f48ba26d2a 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1051,6 +1051,10 @@ static int console_puts(CharDriverState *chr, cons=
t uint8_t *buf, int len)
     QemuConsole *s =3D chr->opaque;
     int i;
=20
+    if (!s->ds) {
+        return 0;
+    }
+
     s->update_x0 =3D s->width * FONT_WIDTH;
     s->update_y0 =3D s->height * FONT_HEIGHT;
     s->update_x1 =3D 0;
@@ -2000,8 +2004,6 @@ static void text_console_do_init(CharDriverState *c=
hr, DisplayState *ds)
=20
     s =3D chr->opaque;
=20
-    chr->chr_write =3D console_puts;
-
     s->out_fifo.buf =3D s->out_fifo_buf;
     s->out_fifo.buf_size =3D sizeof(s->out_fifo_buf);
     s->kbd_timer =3D timer_new_ms(QEMU_CLOCK_REALTIME, kbd_send_chars, s=
);
@@ -2048,6 +2050,8 @@ static void text_console_do_init(CharDriverState *c=
hr, DisplayState *ds)
     qemu_chr_be_generic_open(chr);
 }
=20
+static const CharDriver vc_driver;
+
 static CharDriverState *text_console_init(ChardevVC *vc, Error **errp)
 {
     ChardevCommon *common =3D qapi_ChardevVC_base(vc);
@@ -2056,7 +2060,7 @@ static CharDriverState *text_console_init(ChardevVC=
 *vc, Error **errp)
     unsigned width =3D 0;
     unsigned height =3D 0;
=20
-    chr =3D qemu_chr_alloc(common, errp);
+    chr =3D qemu_chr_alloc(&vc_driver, common, errp);
     if (!chr) {
         return NULL;
     }
@@ -2089,7 +2093,6 @@ static CharDriverState *text_console_init(ChardevVC=
 *vc, Error **errp)
=20
     s->chr =3D chr;
     chr->opaque =3D s;
-    chr->chr_set_echo =3D text_console_set_echo;
=20
     if (display_state) {
         text_console_do_init(chr, display_state);
@@ -2099,7 +2102,8 @@ static CharDriverState *text_console_init(ChardevVC=
 *vc, Error **errp)
=20
 static VcHandler *vc_handler =3D text_console_init;
=20
-static CharDriverState *vc_init(const char *id, ChardevBackend *backend,
+static CharDriverState *vc_init(const CharDriver *driver,
+                                const char *id, ChardevBackend *backend,
                                 ChardevReturn *ret, bool *be_opened,
                                 Error **errp)
 {
@@ -2191,14 +2195,16 @@ static const TypeInfo qemu_console_info =3D {
     .class_size =3D sizeof(QemuConsoleClass),
 };
=20
+static const CharDriver vc_driver =3D {
+    .kind =3D CHARDEV_BACKEND_KIND_VC,
+    .parse =3D qemu_chr_parse_vc,
+    .create =3D vc_init,
+    .chr_write =3D console_puts,
+    .chr_set_echo =3D text_console_set_echo,
+};
+
 static void register_types(void)
 {
-    static const CharDriver vc_driver =3D {
-        .kind =3D CHARDEV_BACKEND_KIND_VC,
-        .parse =3D qemu_chr_parse_vc,
-        .create =3D vc_init,
-    };
-
     type_register_static(&qemu_console_info);
     register_char_driver(&vc_driver);
 }
diff --git a/ui/gtk.c b/ui/gtk.c
index 86368e38b7..608400b56d 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1703,6 +1703,12 @@ static CharDriverState *vcs[MAX_VCS];
=20
 static CharDriverState *gd_vc_handler(ChardevVC *vc, Error **errp)
 {
+    static const CharDriver gd_vc_driver =3D {
+        .kind =3D CHARDEV_BACKEND_KIND_VC,
+        .chr_write =3D gd_vc_chr_write,
+        .chr_set_echo =3D gd_vc_chr_set_echo,
+    };
+
     ChardevCommon *common =3D qapi_ChardevVC_base(vc);
     CharDriverState *chr;
=20
@@ -1711,14 +1717,11 @@ static CharDriverState *gd_vc_handler(ChardevVC *=
vc, Error **errp)
         return NULL;
     }
=20
-    chr =3D qemu_chr_alloc(common, errp);
+    chr =3D qemu_chr_alloc(&gd_vc_driver, common, errp);
     if (!chr) {
         return NULL;
     }
=20
-    chr->chr_write =3D gd_vc_chr_write;
-    chr->chr_set_echo =3D gd_vc_chr_set_echo;
-
     /* Temporary, until gd_vc_vte_init runs.  */
     chr->opaque =3D g_new0(VirtualConsole, 1);
=20
--=20
2.11.0

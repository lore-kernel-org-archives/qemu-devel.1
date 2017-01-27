Received: from eggs.gnu.org ([2001:4830:134:3::10]:33752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rC-0005JX-MO
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6r7-0004BU-J3
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:26 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6r7-0004B0-2M
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:21 -0500
Received: by mail-wm0-x242.google.com with SMTP id r126so58372224wmr.3
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:20 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:35 +0100
Message-Id: <1485524749-118532-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 27/41] char: move callbacks in CharDriver
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

This makes the code more declarative, and avoids duplicating the
information on all instances.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/baum.c       |  11 +-
 backends/msmouse.c    |  11 +-
 backends/testdev.c    |   8 +-
 gdbstub.c             |   7 +-
 hw/bt/hci-csr.c       |   8 +-
 include/sysemu/char.h |  46 ++---
 qemu-char.c           | 479 ++++++++++++++++++++++++++++++--------------------
 spice-qemu-char.c     |  32 ++--
 ui/console.c          |  28 +--
 ui/gtk.c              |  11 +-
 10 files changed, 381 insertions(+), 260 deletions(-)

diff --git a/backends/baum.c b/backends/baum.c
index 2e404a1..109469e 100644
--- a/backends/baum.c
+++ b/backends/baum.c
@@ -622,7 +622,8 @@ static void baum_free(struct CharDriverState *chr)
     g_free(baum);
 }
 
-static CharDriverState *chr_baum_init(const char *id,
+static CharDriverState *chr_baum_init(const CharDriver *driver,
+                                      const char *id,
                                       ChardevBackend *backend,
                                       ChardevReturn *ret,
                                       bool *be_opened,
@@ -633,7 +634,7 @@ static CharDriverState *chr_baum_init(const char *id,
     CharDriverState *chr;
     brlapi_handle_t *handle;
 
-    chr = qemu_chr_alloc(common, errp);
+    chr = qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
@@ -641,9 +642,6 @@ static CharDriverState *chr_baum_init(const char *id,
     baum->chr = chr;
 
     chr->opaque = baum;
-    chr->chr_write = baum_write;
-    chr->chr_accept_input = baum_accept_input;
-    chr->chr_free = baum_free;
 
     handle = g_malloc0(brlapi_getHandleSize());
     baum->brlapi = handle;
@@ -674,6 +672,9 @@ static void register_types(void)
     static const CharDriver driver = {
         .kind = CHARDEV_BACKEND_KIND_BRAILLE,
         .create = chr_baum_init,
+        .chr_write = baum_write,
+        .chr_accept_input = baum_accept_input,
+        .chr_free = baum_free,
     };
 
     register_char_driver(&driver);
diff --git a/backends/msmouse.c b/backends/msmouse.c
index 2490b2c..2c238ba 100644
--- a/backends/msmouse.c
+++ b/backends/msmouse.c
@@ -148,7 +148,8 @@ static QemuInputHandler msmouse_handler = {
     .sync  = msmouse_input_sync,
 };
 
-static CharDriverState *qemu_chr_open_msmouse(const char *id,
+static CharDriverState *qemu_chr_open_msmouse(const CharDriver *driver,
+                                              const char *id,
                                               ChardevBackend *backend,
                                               ChardevReturn *ret,
                                               bool *be_opened,
@@ -158,13 +159,10 @@ static CharDriverState *qemu_chr_open_msmouse(const char *id,
     MouseState *mouse;
     CharDriverState *chr;
 
-    chr = qemu_chr_alloc(common, errp);
+    chr = qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
-    chr->chr_write = msmouse_chr_write;
-    chr->chr_free = msmouse_chr_free;
-    chr->chr_accept_input = msmouse_chr_accept_input;
     *be_opened = false;
 
     mouse = g_new0(MouseState, 1);
@@ -182,6 +180,9 @@ static void register_types(void)
     static const CharDriver driver = {
         .kind = CHARDEV_BACKEND_KIND_MSMOUSE,
         .create = qemu_chr_open_msmouse,
+        .chr_write = msmouse_chr_write,
+        .chr_accept_input = msmouse_chr_accept_input,
+        .chr_free = msmouse_chr_free,
     };
     register_char_driver(&driver);
 }
diff --git a/backends/testdev.c b/backends/testdev.c
index cd25094..2339693 100644
--- a/backends/testdev.c
+++ b/backends/testdev.c
@@ -109,7 +109,8 @@ static void testdev_free(struct CharDriverState *chr)
     g_free(testdev);
 }
 
-static CharDriverState *chr_testdev_init(const char *id,
+static CharDriverState *chr_testdev_init(const CharDriver *driver,
+                                         const char *id,
                                          ChardevBackend *backend,
                                          ChardevReturn *ret,
                                          bool *be_opened,
@@ -121,9 +122,8 @@ static CharDriverState *chr_testdev_init(const char *id,
     testdev = g_new0(TestdevCharState, 1);
     testdev->chr = chr = g_new0(CharDriverState, 1);
 
+    chr->driver = driver;
     chr->opaque = testdev;
-    chr->chr_write = testdev_write;
-    chr->chr_free = testdev_free;
 
     return chr;
 }
@@ -133,6 +133,8 @@ static void register_types(void)
     static const CharDriver driver = {
         .kind = CHARDEV_BACKEND_KIND_TESTDEV,
         .create = chr_testdev_init,
+        .chr_write = testdev_write,
+        .chr_free = testdev_free,
     };
     register_char_driver(&driver);
 }
diff --git a/gdbstub.c b/gdbstub.c
index de9b62b..3de9bcb 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1731,6 +1731,10 @@ int gdbserver_start(const char *device)
     CharDriverState *chr = NULL;
     CharDriverState *mon_chr;
     ChardevCommon common = { 0 };
+    static const CharDriver driver = {
+        .kind = -1,
+        .chr_write = gdb_monitor_write,
+    };
 
     if (!device)
         return -1;
@@ -1763,8 +1767,7 @@ int gdbserver_start(const char *device)
         qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
 
         /* Initialize a monitor terminal for gdb */
-        mon_chr = qemu_chr_alloc(&common, &error_abort);
-        mon_chr->chr_write = gdb_monitor_write;
+        mon_chr = qemu_chr_alloc(&driver, &common, &error_abort);
         monitor_init(mon_chr, 0);
     } else {
         if (qemu_chr_fe_get_driver(&s->chr)) {
diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
index fbb3109..9c3fb3c 100644
--- a/hw/bt/hci-csr.c
+++ b/hw/bt/hci-csr.c
@@ -462,12 +462,16 @@ qemu_irq *csrhci_pins_get(CharDriverState *chr)
 
 CharDriverState *uart_hci_init(void)
 {
+    static const CharDriver hci_driver = {
+        .kind = -1,
+        .chr_write = csrhci_write,
+        .chr_ioctl = csrhci_ioctl,
+    };
     struct csrhci_s *s = (struct csrhci_s *)
             g_malloc0(sizeof(struct csrhci_s));
 
     s->chr.opaque = s;
-    s->chr.chr_write = csrhci_write;
-    s->chr.chr_ioctl = csrhci_ioctl;
+    s->chr.driver = &hci_driver;
 
     s->hci = qemu_next_hci();
     s->hci->opaque = s;
diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index fee2c34..2dd0564 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -85,24 +85,11 @@ typedef struct CharBackend {
     int fe_open;
 } CharBackend;
 
+typedef struct CharDriver CharDriver;
+
 struct CharDriverState {
+    const CharDriver *driver;
     QemuMutex chr_write_lock;
-    int (*chr_write)(struct CharDriverState *s, const uint8_t *buf, int len);
-    int (*chr_sync_read)(struct CharDriverState *s,
-                         const uint8_t *buf, int len);
-    GSource *(*chr_add_watch)(struct CharDriverState *s, GIOCondition cond);
-    void (*chr_update_read_handler)(struct CharDriverState *s,
-                                    GMainContext *context);
-    int (*chr_ioctl)(struct CharDriverState *s, int cmd, void *arg);
-    int (*get_msgfds)(struct CharDriverState *s, int* fds, int num);
-    int (*set_msgfds)(struct CharDriverState *s, int *fds, int num);
-    int (*chr_add_client)(struct CharDriverState *chr, int fd);
-    int (*chr_wait_connected)(struct CharDriverState *chr, Error **errp);
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
 
 /**
  * @qemu_chr_new_from_opts:
@@ -475,15 +463,33 @@ void qemu_chr_set_feature(CharDriverState *chr,
                           CharDriverFeature feature);
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename);
 
-typedef struct CharDriver {
+struct CharDriver {
     ChardevBackendKind kind;
     const char *alias;
     void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp);
-    CharDriverState *(*create)(const char *id,
+    CharDriverState *(*create)(const CharDriver *driver,
+                               const char *id,
                                ChardevBackend *backend,
                                ChardevReturn *ret, bool *be_opened,
                                Error **errp);
-} CharDriver;
+
+    int (*chr_write)(struct CharDriverState *s, const uint8_t *buf, int len);
+    int (*chr_sync_read)(struct CharDriverState *s,
+                         const uint8_t *buf, int len);
+    GSource *(*chr_add_watch)(struct CharDriverState *s, GIOCondition cond);
+    void (*chr_update_read_handler)(struct CharDriverState *s,
+                                    GMainContext *context);
+    int (*chr_ioctl)(struct CharDriverState *s, int cmd, void *arg);
+    int (*get_msgfds)(struct CharDriverState *s, int* fds, int num);
+    int (*set_msgfds)(struct CharDriverState *s, int *fds, int num);
+    int (*chr_add_client)(struct CharDriverState *chr, int fd);
+    int (*chr_wait_connected)(struct CharDriverState *chr, Error **errp);
+    void (*chr_free)(struct CharDriverState *chr);
+    void (*chr_disconnect)(struct CharDriverState *chr);
+    void (*chr_accept_input)(struct CharDriverState *chr);
+    void (*chr_set_echo)(struct CharDriverState *chr, bool echo);
+    void (*chr_set_fe_open)(struct CharDriverState *chr, int fe_open);
+};
 
 void register_char_driver(const CharDriver *driver);
 
diff --git a/qemu-char.c b/qemu-char.c
index 464c69d..ce8d4bb 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -162,11 +162,15 @@ static QTAILQ_HEAD(CharDriverStateHead, CharDriverState) chardevs =
 
 static void qemu_chr_free_common(CharDriverState *chr);
 
-CharDriverState *qemu_chr_alloc(ChardevCommon *backend, Error **errp)
+CharDriverState *qemu_chr_alloc(const CharDriver *driver,
+                                ChardevCommon *backend, Error **errp)
 {
     CharDriverState *chr = g_malloc0(sizeof(CharDriverState));
     qemu_mutex_init(&chr->chr_write_lock);
 
+    assert(driver);
+    assert(driver->chr_write);
+
     if (backend->has_logfile) {
         int flags = O_WRONLY | O_CREAT;
         if (backend->has_logappend &&
@@ -186,6 +190,7 @@ CharDriverState *qemu_chr_alloc(ChardevCommon *backend, Error **errp)
     } else {
         chr->logfd = -1;
     }
+    chr->driver = driver;
 
     return chr;
 }
@@ -252,7 +257,7 @@ static int qemu_chr_fe_write_buffer(CharDriverState *s, const uint8_t *buf, int
     qemu_mutex_lock(&s->chr_write_lock);
     while (*offset < len) {
     retry:
-        res = s->chr_write(s, buf + *offset, len - *offset);
+        res = s->driver->chr_write(s, buf + *offset, len - *offset);
         if (res < 0 && errno == EAGAIN) {
             g_usleep(100);
             goto retry;
@@ -290,7 +295,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
     }
 
     qemu_mutex_lock(&s->chr_write_lock);
-    ret = s->chr_write(s, buf, len);
+    ret = s->driver->chr_write(s, buf, len);
 
     if (ret > 0) {
         qemu_chr_fe_write_log(s, buf, ret);
@@ -346,7 +351,7 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
     int offset = 0, counter = 10;
     int res;
 
-    if (!s || !s->chr_sync_read) {
+    if (!s || !s->driver->chr_sync_read) {
         return 0;
     }
 
@@ -356,7 +361,7 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
 
     while (offset < len) {
     retry:
-        res = s->chr_sync_read(s, buf + offset, len - offset);
+        res = s->driver->chr_sync_read(s, buf + offset, len - offset);
         if (res == -1 && errno == EAGAIN) {
             g_usleep(100);
             goto retry;
@@ -391,10 +396,10 @@ int qemu_chr_fe_ioctl(CharBackend *be, int cmd, void *arg)
     CharDriverState *s = be->chr;
     int res;
 
-    if (!s || !s->chr_ioctl || s->replay) {
+    if (!s || !s->driver->chr_ioctl || s->replay) {
         res = -ENOTSUP;
     } else {
-        res = s->chr_ioctl(s, cmd, arg);
+        res = s->driver->chr_ioctl(s, cmd, arg);
     }
 
     return res;
@@ -453,7 +458,7 @@ int qemu_chr_fe_get_msgfds(CharBackend *be, int *fds, int len)
         return -1;
     }
 
-    return s->get_msgfds ? s->get_msgfds(s, fds, len) : -1;
+    return s->driver->get_msgfds ? s->driver->get_msgfds(s, fds, len) : -1;
 }
 
 int qemu_chr_fe_set_msgfds(CharBackend *be, int *fds, int num)
@@ -464,12 +469,12 @@ int qemu_chr_fe_set_msgfds(CharBackend *be, int *fds, int num)
         return -1;
     }
 
-    return s->set_msgfds ? s->set_msgfds(s, fds, num) : -1;
+    return s->driver->set_msgfds ? s->driver->set_msgfds(s, fds, num) : -1;
 }
 
 int qemu_chr_add_client(CharDriverState *s, int fd)
 {
-    return s->chr_add_client ? s->chr_add_client(s, fd) : -1;
+    return s->driver->chr_add_client ? s->driver->chr_add_client(s, fd) : -1;
 }
 
 void qemu_chr_fe_accept_input(CharBackend *be)
@@ -480,8 +485,9 @@ void qemu_chr_fe_accept_input(CharBackend *be)
         return;
     }
 
-    if (s->chr_accept_input)
-        s->chr_accept_input(s);
+    if (s->driver->chr_accept_input) {
+        s->driver->chr_accept_input(s);
+    }
     qemu_notify_event();
 }
 
@@ -506,7 +512,8 @@ static int null_chr_write(CharDriverState *chr, const uint8_t *buf, int len)
     return len;
 }
 
-static CharDriverState *qemu_chr_open_null(const char *id,
+static CharDriverState *qemu_chr_open_null(const CharDriver *driver,
+                                           const char *id,
                                            ChardevBackend *backend,
                                            ChardevReturn *ret,
                                            bool *be_opened,
@@ -515,15 +522,20 @@ static CharDriverState *qemu_chr_open_null(const char *id,
     CharDriverState *chr;
     ChardevCommon *common = backend->u.null.data;
 
-    chr = qemu_chr_alloc(common, errp);
+    chr = qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
-    chr->chr_write = null_chr_write;
     *be_opened = false;
     return chr;
 }
 
+static const CharDriver null_driver = {
+    .kind = CHARDEV_BACKEND_KIND_NULL,
+    .create = qemu_chr_open_null,
+    .chr_write = null_chr_write,
+};
+
 /* MUX driver for serial I/O splitting */
 #define MAX_MUX 4
 #define MUX_BUFFER_SIZE 32	/* Must be a power of 2.  */
@@ -795,7 +807,11 @@ static GSource *mux_chr_add_watch(CharDriverState *s, GIOCondition cond)
     MuxDriver *d = s->opaque;
     CharDriverState *chr = qemu_chr_fe_get_driver(&d->chr);
 
-    return chr->chr_add_watch(chr, cond);
+    if (!chr->driver->chr_add_watch) {
+        return NULL;
+    }
+
+    return chr->driver->chr_add_watch(chr, cond);
 }
 
 static void mux_chr_free(struct CharDriverState *chr)
@@ -842,7 +858,8 @@ static void mux_set_focus(CharDriverState *chr, int focus)
     mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
 }
 
-static CharDriverState *qemu_chr_open_mux(const char *id,
+static CharDriverState *qemu_chr_open_mux(const CharDriver *driver,
+                                          const char *id,
                                           ChardevBackend *backend,
                                           ChardevReturn *ret,
                                           bool *be_opened,
@@ -859,7 +876,7 @@ static CharDriverState *qemu_chr_open_mux(const char *id,
         return NULL;
     }
 
-    chr = qemu_chr_alloc(common, errp);
+    chr = qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
@@ -867,14 +884,6 @@ static CharDriverState *qemu_chr_open_mux(const char *id,
 
     chr->opaque = d;
     d->focus = -1;
-    chr->chr_free = mux_chr_free;
-    chr->chr_write = mux_chr_write;
-    chr->chr_accept_input = mux_chr_accept_input;
-    /* Frontend guest-open / -close notification is not support with muxes */
-    chr->chr_set_fe_open = NULL;
-    if (drv->chr_add_watch) {
-        chr->chr_add_watch = mux_chr_add_watch;
-    }
     /* only default to opened state if we've realized the initial
      * set of muxes
      */
@@ -975,8 +984,8 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
     b->chr_read = fd_read;
     b->chr_event = fd_event;
     b->opaque = opaque;
-    if (s->chr_update_read_handler) {
-        s->chr_update_read_handler(s, context);
+    if (s->driver->chr_update_read_handler) {
+        s->driver->chr_update_read_handler(s, context);
     }
 
     if (set_open) {
@@ -1271,14 +1280,15 @@ static void fd_chr_free(struct CharDriverState *chr)
 }
 
 /* open a character device to a unix fd */
-static CharDriverState *qemu_chr_open_fd(int fd_in, int fd_out,
+static CharDriverState *qemu_chr_open_fd(const CharDriver *driver,
+                                         int fd_in, int fd_out,
                                          ChardevCommon *backend, Error **errp)
 {
     CharDriverState *chr;
     FDCharDriver *s;
     char *name;
 
-    chr = qemu_chr_alloc(backend, errp);
+    chr = qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
@@ -1294,15 +1304,12 @@ static CharDriverState *qemu_chr_open_fd(int fd_in, int fd_out,
     qemu_set_nonblock(fd_out);
     s->chr = chr;
     chr->opaque = s;
-    chr->chr_add_watch = fd_chr_add_watch;
-    chr->chr_write = fd_chr_write;
-    chr->chr_update_read_handler = fd_chr_update_read_handler;
-    chr->chr_free = fd_chr_free;
 
     return chr;
 }
 
-static CharDriverState *qemu_chr_open_pipe(const char *id,
+static CharDriverState *qemu_chr_open_pipe(const CharDriver *driver,
+                                           const char *id,
                                            ChardevBackend *backend,
                                            ChardevReturn *ret,
                                            bool *be_opened,
@@ -1333,7 +1340,7 @@ static CharDriverState *qemu_chr_open_pipe(const char *id,
             return NULL;
         }
     }
-    return qemu_chr_open_fd(fd_in, fd_out, common, errp);
+    return qemu_chr_open_fd(driver, fd_in, fd_out, common, errp);
 }
 
 /* init terminal so that we can grab keys */
@@ -1385,7 +1392,8 @@ static void qemu_chr_free_stdio(struct CharDriverState *chr)
     fd_chr_free(chr);
 }
 
-static CharDriverState *qemu_chr_open_stdio(const char *id,
+static CharDriverState *qemu_chr_open_stdio(const CharDriver *driver,
+                                            const char *id,
                                             ChardevBackend *backend,
                                             ChardevReturn *ret,
                                             bool *be_opened,
@@ -1416,12 +1424,10 @@ static CharDriverState *qemu_chr_open_stdio(const char *id,
     act.sa_handler = term_stdio_handler;
     sigaction(SIGCONT, &act, NULL);
 
-    chr = qemu_chr_open_fd(0, 1, common, errp);
+    chr = qemu_chr_open_fd(driver, 0, 1, common, errp);
     if (!chr) {
         return NULL;
     }
-    chr->chr_free = qemu_chr_free_stdio;
-    chr->chr_set_echo = qemu_chr_set_echo_stdio;
     if (opts->has_signal) {
         stdio_allow_signal = opts->signal;
     }
@@ -1638,7 +1644,8 @@ static void pty_chr_free(struct CharDriverState *chr)
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
 
-static CharDriverState *qemu_chr_open_pty(const char *id,
+static CharDriverState *qemu_chr_open_pty(const CharDriver *driver,
+                                          const char *id,
                                           ChardevBackend *backend,
                                           ChardevReturn *ret,
                                           bool *be_opened,
@@ -1660,7 +1667,7 @@ static CharDriverState *qemu_chr_open_pty(const char *id,
     close(slave_fd);
     qemu_set_nonblock(master_fd);
 
-    chr = qemu_chr_alloc(common, errp);
+    chr = qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         close(master_fd);
         return NULL;
@@ -1675,10 +1682,6 @@ static CharDriverState *qemu_chr_open_pty(const char *id,
 
     s = g_new0(PtyCharDriver, 1);
     chr->opaque = s;
-    chr->chr_write = pty_chr_write;
-    chr->chr_update_read_handler = pty_chr_update_read_handler;
-    chr->chr_free = pty_chr_free;
-    chr->chr_add_watch = pty_chr_add_watch;
     *be_opened = false;
 
     s->ioc = QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
@@ -1690,6 +1693,15 @@ static CharDriverState *qemu_chr_open_pty(const char *id,
     return chr;
 }
 
+static const CharDriver pty_driver = {
+    .kind = CHARDEV_BACKEND_KIND_PTY,
+    .create = qemu_chr_open_pty,
+    .chr_write = pty_chr_write,
+    .chr_update_read_handler = pty_chr_update_read_handler,
+    .chr_add_watch = pty_chr_add_watch,
+    .chr_free = pty_chr_free,
+};
+
 static void tty_serial_init(int fd, int speed,
                             int parity, int data_bits, int stop_bits)
 {
@@ -1880,7 +1892,8 @@ static void qemu_chr_free_tty(CharDriverState *chr)
     fd_chr_free(chr);
 }
 
-static CharDriverState *qemu_chr_open_tty_fd(int fd,
+static CharDriverState *qemu_chr_open_tty_fd(const CharDriver *driver,
+                                             int fd,
                                              ChardevCommon *backend,
                                              bool *be_opened,
                                              Error **errp)
@@ -1888,12 +1901,10 @@ static CharDriverState *qemu_chr_open_tty_fd(int fd,
     CharDriverState *chr;
 
     tty_serial_init(fd, 115200, 'N', 8, 1);
-    chr = qemu_chr_open_fd(fd, fd, backend, errp);
+    chr = qemu_chr_open_fd(driver, fd, fd, backend, errp);
     if (!chr) {
         return NULL;
     }
-    chr->chr_ioctl = tty_serial_ioctl;
-    chr->chr_free = qemu_chr_free_tty;
     return chr;
 }
 #endif /* __linux__ || __sun__ */
@@ -2011,7 +2022,8 @@ static void pp_free(CharDriverState *chr)
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
 
-static CharDriverState *qemu_chr_open_pp_fd(int fd,
+static CharDriverState *qemu_chr_open_pp_fd(const CharDriver *driver,
+                                            int fd,
                                             ChardevCommon *backend,
                                             bool *be_opened,
                                             Error **errp)
@@ -2025,16 +2037,13 @@ static CharDriverState *qemu_chr_open_pp_fd(int fd,
         return NULL;
     }
 
-    chr = qemu_chr_alloc(backend, errp);
+    chr = qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
 
     drv = g_new0(ParallelCharDriver, 1);
     chr->opaque = drv;
-    chr->chr_write = null_chr_write;
-    chr->chr_ioctl = pp_ioctl;
-    chr->chr_free = pp_free;
 
     drv->fd = fd;
     drv->mode = IEEE1284_MODE_COMPAT;
@@ -2084,20 +2093,19 @@ static int pp_ioctl(CharDriverState *chr, int cmd, void *arg)
     return 0;
 }
 
-static CharDriverState *qemu_chr_open_pp_fd(int fd,
+static CharDriverState *qemu_chr_open_pp_fd(const CharDriver *driver,
+                                            int fd,
                                             ChardevCommon *backend,
                                             bool *be_opened,
                                             Error **errp)
 {
     CharDriverState *chr;
 
-    chr = qemu_chr_alloc(backend, errp);
+    chr = qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
     chr->opaque = (void *)(intptr_t)fd;
-    chr->chr_write = null_chr_write;
-    chr->chr_ioctl = pp_ioctl;
     *be_opened = false;
     return chr;
 }
@@ -2319,21 +2327,20 @@ static int win_chr_poll(void *opaque)
     return 0;
 }
 
-static CharDriverState *qemu_chr_open_win_path(const char *filename,
+static CharDriverState *qemu_chr_open_win_path(const CharDriver *driver,
+                                               const char *filename,
                                                ChardevCommon *backend,
                                                Error **errp)
 {
     CharDriverState *chr;
     WinCharState *s;
 
-    chr = qemu_chr_alloc(backend, errp);
+    chr = qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
     s = g_new0(WinCharState, 1);
     chr->opaque = s;
-    chr->chr_write = win_chr_write;
-    chr->chr_free = win_chr_free;
 
     if (win_chr_init(chr, filename, errp) < 0) {
         g_free(s);
@@ -2424,7 +2431,8 @@ static int win_chr_pipe_init(CharDriverState *chr, const char *filename,
 }
 
 
-static CharDriverState *qemu_chr_open_pipe(const char *id,
+static CharDriverState *qemu_chr_open_pipe(const CharDriver *driver,
+                                           const char *id,
                                            ChardevBackend *backend,
                                            ChardevReturn *ret,
                                            bool *be_opened,
@@ -2436,14 +2444,12 @@ static CharDriverState *qemu_chr_open_pipe(const char *id,
     WinCharState *s;
     ChardevCommon *common = qapi_ChardevHostdev_base(opts);
 
-    chr = qemu_chr_alloc(common, errp);
+    chr = qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
     s = g_new0(WinCharState, 1);
     chr->opaque = s;
-    chr->chr_write = win_chr_write;
-    chr->chr_free = win_chr_free;
 
     if (win_chr_pipe_init(chr, filename, errp) < 0) {
         g_free(s);
@@ -2453,35 +2459,43 @@ static CharDriverState *qemu_chr_open_pipe(const char *id,
     return chr;
 }
 
-static CharDriverState *qemu_chr_open_win_file(HANDLE fd_out,
+static CharDriverState *qemu_chr_open_win_file(const CharDriver *driver,
+                                               HANDLE fd_out,
                                                ChardevCommon *backend,
                                                Error **errp)
 {
     CharDriverState *chr;
     WinCharState *s;
 
-    chr = qemu_chr_alloc(backend, errp);
+    chr = qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
     s = g_new0(WinCharState, 1);
     s->hcom = fd_out;
     chr->opaque = s;
-    chr->chr_write = win_chr_write;
     return chr;
 }
 
-static CharDriverState *qemu_chr_open_win_con(const char *id,
+static CharDriverState *qemu_chr_open_win_con(const CharDriver *driver,
+                                              const char *id,
                                               ChardevBackend *backend,
                                               ChardevReturn *ret,
                                               bool *be_opened,
                                               Error **errp)
 {
     ChardevCommon *common = backend->u.console.data;
-    return qemu_chr_open_win_file(GetStdHandle(STD_OUTPUT_HANDLE),
+    return qemu_chr_open_win_file(driver,
+                                  GetStdHandle(STD_OUTPUT_HANDLE),
                                   common, errp);
 }
 
+static const CharDriver console_driver = {
+    .kind = CHARDEV_BACKEND_KIND_CONSOLE,
+    .create = qemu_chr_open_win_con,
+    .chr_write = win_chr_write,
+};
+
 static int win_stdio_write(CharDriverState *chr, const uint8_t *buf, int len)
 {
     HANDLE  hStdOut = GetStdHandle(STD_OUTPUT_HANDLE);
@@ -2617,7 +2631,8 @@ static void win_stdio_free(CharDriverState *chr)
     g_free(chr->opaque);
 }
 
-static CharDriverState *qemu_chr_open_stdio(const char *id,
+static CharDriverState *qemu_chr_open_stdio(const CharDriver *driver,
+                                            const char *id,
                                             ChardevBackend *backend,
                                             ChardevReturn *ret,
                                             bool *be_opened,
@@ -2629,7 +2644,7 @@ static CharDriverState *qemu_chr_open_stdio(const char *id,
     int                is_console = 0;
     ChardevCommon *common = qapi_ChardevStdio_base(backend->u.stdio.data);
 
-    chr   = qemu_chr_alloc(common, errp);
+    chr = qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
@@ -2644,8 +2659,6 @@ static CharDriverState *qemu_chr_open_stdio(const char *id,
     is_console = GetConsoleMode(stdio->hStdIn, &dwMode) != 0;
 
     chr->opaque    = stdio;
-    chr->chr_write = win_stdio_write;
-    chr->chr_free = win_stdio_free;
 
     if (is_console) {
         if (qemu_add_wait_object(stdio->hStdIn,
@@ -2687,7 +2700,6 @@ static CharDriverState *qemu_chr_open_stdio(const char *id,
 
     SetConsoleMode(stdio->hStdIn, dwMode);
 
-    chr->chr_set_echo = qemu_chr_set_echo_win_stdio;
     qemu_chr_set_echo_win_stdio(chr, false);
 
     return chr;
@@ -2794,7 +2806,8 @@ static void udp_chr_free(CharDriverState *chr)
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
 
-static CharDriverState *qemu_chr_open_udp(QIOChannelSocket *sioc,
+static CharDriverState *qemu_chr_open_udp(const CharDriver *driver,
+                                          QIOChannelSocket *sioc,
                                           ChardevCommon *backend,
                                           bool *be_opened,
                                           Error **errp)
@@ -2802,7 +2815,7 @@ static CharDriverState *qemu_chr_open_udp(QIOChannelSocket *sioc,
     CharDriverState *chr = NULL;
     NetCharDriver *s = NULL;
 
-    chr = qemu_chr_alloc(backend, errp);
+    chr = qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
@@ -2812,9 +2825,6 @@ static CharDriverState *qemu_chr_open_udp(QIOChannelSocket *sioc,
     s->bufcnt = 0;
     s->bufptr = 0;
     chr->opaque = s;
-    chr->chr_write = udp_chr_write;
-    chr->chr_update_read_handler = udp_chr_update_read_handler;
-    chr->chr_free = udp_chr_free;
     /* be isn't opened until we get a connection */
     *be_opened = false;
     return chr;
@@ -3448,8 +3458,8 @@ static int tcp_chr_wait_connected(CharDriverState *chr, Error **errp)
 
 static int qemu_chr_wait_connected(CharDriverState *chr, Error **errp)
 {
-    if (chr->chr_wait_connected) {
-        return chr->chr_wait_connected(chr, errp);
+    if (chr->driver->chr_wait_connected) {
+        return chr->driver->chr_wait_connected(chr, errp);
     }
 
     return 0;
@@ -3572,7 +3582,8 @@ static void ringbuf_chr_free(struct CharDriverState *chr)
     chr->opaque = NULL;
 }
 
-static CharDriverState *qemu_chr_open_ringbuf(const char *id,
+static CharDriverState *qemu_chr_open_ringbuf(const CharDriver *driver,
+                                              const char *id,
                                               ChardevBackend *backend,
                                               ChardevReturn *ret,
                                               bool *be_opened,
@@ -3583,7 +3594,7 @@ static CharDriverState *qemu_chr_open_ringbuf(const char *id,
     CharDriverState *chr;
     RingBufCharDriver *d;
 
-    chr = qemu_chr_alloc(common, errp);
+    chr = qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
@@ -3602,8 +3613,6 @@ static CharDriverState *qemu_chr_open_ringbuf(const char *id,
     d->cbuf = g_malloc0(d->size);
 
     chr->opaque = d;
-    chr->chr_write = ringbuf_chr_write;
-    chr->chr_free = ringbuf_chr_free;
 
     return chr;
 
@@ -3615,7 +3624,7 @@ fail:
 
 bool chr_is_ringbuf(const CharDriverState *chr)
 {
-    return chr->chr_write == ringbuf_chr_write;
+    return chr->driver->chr_write == ringbuf_chr_write;
 }
 
 void qmp_ringbuf_write(const char *device, const char *data,
@@ -3894,6 +3903,23 @@ static void qemu_chr_parse_stdio(QemuOpts *opts, ChardevBackend *backend,
     stdio->signal = qemu_opt_get_bool(opts, "signal", true);
 }
 
+static const CharDriver stdio_driver = {
+    .kind = CHARDEV_BACKEND_KIND_STDIO,
+    .parse = qemu_chr_parse_stdio,
+    .create = qemu_chr_open_stdio,
+#ifdef _WIN32
+    .chr_write = win_stdio_write,
+    .chr_set_echo = qemu_chr_set_echo_win_stdio,
+    .chr_free = win_stdio_free,
+#else
+    .chr_add_watch = fd_chr_add_watch,
+    .chr_write = fd_chr_write,
+    .chr_update_read_handler = fd_chr_update_read_handler,
+    .chr_set_echo = qemu_chr_set_echo_stdio,
+    .chr_free = qemu_chr_free_stdio,
+#endif
+};
+
 #ifdef HAVE_CHARDEV_SERIAL
 static void qemu_chr_parse_serial(QemuOpts *opts, ChardevBackend *backend,
                                   Error **errp)
@@ -3943,6 +3969,21 @@ static void qemu_chr_parse_pipe(QemuOpts *opts, ChardevBackend *backend,
     dev->device = g_strdup(device);
 }
 
+static const CharDriver pipe_driver = {
+    .kind = CHARDEV_BACKEND_KIND_PIPE,
+    .parse = qemu_chr_parse_pipe,
+    .create = qemu_chr_open_pipe,
+#ifdef _WIN32
+    .chr_write = win_chr_write,
+    .chr_free = win_chr_free,
+#else
+    .chr_add_watch = fd_chr_add_watch,
+    .chr_write = fd_chr_write,
+    .chr_update_read_handler = fd_chr_update_read_handler,
+    .chr_free = fd_chr_free,
+#endif
+};
+
 static void qemu_chr_parse_ringbuf(QemuOpts *opts, ChardevBackend *backend,
                                    Error **errp)
 {
@@ -3959,6 +4000,23 @@ static void qemu_chr_parse_ringbuf(QemuOpts *opts, ChardevBackend *backend,
     }
 }
 
+static const CharDriver ringbuf_driver = {
+    .kind = CHARDEV_BACKEND_KIND_RINGBUF,
+    .parse = qemu_chr_parse_ringbuf,
+    .create = qemu_chr_open_ringbuf,
+    .chr_write = ringbuf_chr_write,
+    .chr_free = ringbuf_chr_free,
+};
+
+/* Bug-compatibility: */
+static const CharDriver memory_driver = {
+    .kind = CHARDEV_BACKEND_KIND_MEMORY,
+    .parse = qemu_chr_parse_ringbuf,
+    .create = qemu_chr_open_ringbuf,
+    .chr_write = ringbuf_chr_write,
+    .chr_free = ringbuf_chr_free,
+};
+
 static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
                                Error **errp)
 {
@@ -3974,6 +4032,16 @@ static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
     mux->chardev = g_strdup(chardev);
 }
 
+static const CharDriver mux_driver = {
+    .kind = CHARDEV_BACKEND_KIND_MUX,
+    .parse = qemu_chr_parse_mux,
+    .create = qemu_chr_open_mux,
+    .chr_free = mux_chr_free,
+    .chr_write = mux_chr_write,
+    .chr_accept_input = mux_chr_accept_input,
+    .chr_add_watch = mux_chr_add_watch,
+};
+
 static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
                                   Error **errp)
 {
@@ -4246,7 +4314,7 @@ CharDriverState *qemu_chr_new(const char *label, const char *filename)
     chr = qemu_chr_new_noreplay(label, filename);
     if (chr) {
         chr->replay = replay_mode != REPLAY_MODE_NONE;
-        if (chr->replay && chr->chr_ioctl) {
+        if (chr->replay && chr->driver->chr_ioctl) {
             fprintf(stderr,
                     "Replay: ioctl is not supported for serial devices yet\n");
         }
@@ -4259,8 +4327,8 @@ void qemu_chr_fe_set_echo(CharBackend *be, bool echo)
 {
     CharDriverState *chr = be->chr;
 
-    if (chr && chr->chr_set_echo) {
-        chr->chr_set_echo(chr, echo);
+    if (chr && chr->driver->chr_set_echo) {
+        chr->driver->chr_set_echo(chr, echo);
     }
 }
 
@@ -4276,8 +4344,8 @@ void qemu_chr_fe_set_open(CharBackend *be, int fe_open)
         return;
     }
     be->fe_open = fe_open;
-    if (chr->chr_set_fe_open) {
-        chr->chr_set_fe_open(chr, fe_open);
+    if (chr->driver->chr_set_fe_open) {
+        chr->driver->chr_set_fe_open(chr, fe_open);
     }
 }
 
@@ -4288,11 +4356,11 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
     GSource *src;
     guint tag;
 
-    if (!s || s->chr_add_watch == NULL) {
+    if (!s || s->driver->chr_add_watch == NULL) {
         return 0;
     }
 
-    src = s->chr_add_watch(s, cond);
+    src = s->driver->chr_add_watch(s, cond);
     if (!src) {
         return 0;
     }
@@ -4308,8 +4376,8 @@ void qemu_chr_fe_disconnect(CharBackend *be)
 {
     CharDriverState *chr = be->chr;
 
-    if (chr && chr->chr_disconnect) {
-        chr->chr_disconnect(chr);
+    if (chr && chr->driver->chr_disconnect) {
+        chr->driver->chr_disconnect(chr);
     }
 }
 
@@ -4329,8 +4397,8 @@ static void qemu_chr_free_common(CharDriverState *chr)
 
 void qemu_chr_free(CharDriverState *chr)
 {
-    if (chr->chr_free) {
-        chr->chr_free(chr);
+    if (chr->driver->chr_free) {
+        chr->driver->chr_free(chr);
     }
     qemu_chr_free_common(chr);
 }
@@ -4500,7 +4568,8 @@ QemuOptsList qemu_chardev_opts = {
 
 #ifdef _WIN32
 
-static CharDriverState *qmp_chardev_open_file(const char *id,
+static CharDriverState *qmp_chardev_open_file(const CharDriver *driver,
+                                              const char *id,
                                               ChardevBackend *backend,
                                               ChardevReturn *ret,
                                               bool *be_opened,
@@ -4533,10 +4602,11 @@ static CharDriverState *qmp_chardev_open_file(const char *id,
         error_setg(errp, "open %s failed", file->out);
         return NULL;
     }
-    return qemu_chr_open_win_file(out, common, errp);
+    return qemu_chr_open_win_file(driver, out, common, errp);
 }
 
-static CharDriverState *qmp_chardev_open_serial(const char *id,
+static CharDriverState *qmp_chardev_open_serial(const CharDriver *driver,
+                                                const char *id,
                                                 ChardevBackend *backend,
                                                 ChardevReturn *ret,
                                                 bool *be_opened,
@@ -4544,7 +4614,8 @@ static CharDriverState *qmp_chardev_open_serial(const char *id,
 {
     ChardevHostdev *serial = backend->u.serial.data;
     ChardevCommon *common = qapi_ChardevHostdev_base(serial);
-    return qemu_chr_open_win_path(serial->device, common, errp);
+
+    return qemu_chr_open_win_path(driver, serial->device, common, errp);
 }
 
 #else /* WIN32 */
@@ -4561,7 +4632,8 @@ static int qmp_chardev_open_file_source(char *src, int flags,
     return fd;
 }
 
-static CharDriverState *qmp_chardev_open_file(const char *id,
+static CharDriverState *qmp_chardev_open_file(const CharDriver *driver,
+                                              const char *id,
                                               ChardevBackend *backend,
                                               ChardevReturn *ret,
                                               bool *be_opened,
@@ -4592,11 +4664,12 @@ static CharDriverState *qmp_chardev_open_file(const char *id,
         }
     }
 
-    return qemu_chr_open_fd(in, out, common, errp);
+    return qemu_chr_open_fd(driver, in, out, common, errp);
 }
 
 #ifdef HAVE_CHARDEV_SERIAL
-static CharDriverState *qmp_chardev_open_serial(const char *id,
+static CharDriverState *qmp_chardev_open_serial(const CharDriver *driver,
+                                                const char *id,
                                                 ChardevBackend *backend,
                                                 ChardevReturn *ret,
                                                 bool *be_opened,
@@ -4611,12 +4684,14 @@ static CharDriverState *qmp_chardev_open_serial(const char *id,
         return NULL;
     }
     qemu_set_nonblock(fd);
-    return qemu_chr_open_tty_fd(fd, common, be_opened, errp);
+
+    return qemu_chr_open_tty_fd(driver, fd, common, be_opened, errp);
 }
 #endif
 
 #ifdef HAVE_CHARDEV_PARPORT
-static CharDriverState *qmp_chardev_open_parallel(const char *id,
+static CharDriverState *qmp_chardev_open_parallel(const CharDriver *driver,
+                                                  const char *id,
                                                   ChardevBackend *backend,
                                                   ChardevReturn *ret,
                                                   bool *be_opened,
@@ -4630,12 +4705,62 @@ static CharDriverState *qmp_chardev_open_parallel(const char *id,
     if (fd < 0) {
         return NULL;
     }
-    return qemu_chr_open_pp_fd(fd, common, be_opened, errp);
+    return qemu_chr_open_pp_fd(driver, fd, common, be_opened, errp);
 }
+
+static const CharDriver parallel_driver = {
+    .kind = CHARDEV_BACKEND_KIND_PARALLEL,
+    .alias = "parport",
+    .parse = qemu_chr_parse_parallel,
+    .create = qmp_chardev_open_parallel,
+#if defined(__linux__)
+    .chr_write = null_chr_write,
+    .chr_ioctl = pp_ioctl,
+    .chr_free = pp_free,
+#elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__) || defined(__DragonFly__)
+    .chr_write = null_chr_write,
+    .chr_ioctl = pp_ioctl,
+    /* FIXME: no chr_free */
+#endif
+};
 #endif
 
 #endif /* WIN32 */
 
+static const CharDriver file_driver = {
+    .kind = CHARDEV_BACKEND_KIND_FILE,
+    .parse = qemu_chr_parse_file_out,
+    .create = qmp_chardev_open_file,
+#ifdef _WIN32
+    .chr_write = win_chr_write,
+    /* FIXME: no chr_free */
+#else
+    .chr_add_watch = fd_chr_add_watch,
+    .chr_write = fd_chr_write,
+    .chr_update_read_handler = fd_chr_update_read_handler,
+    .chr_free = fd_chr_free,
+#endif
+};
+
+#ifdef HAVE_CHARDEV_SERIAL
+static const CharDriver serial_driver = {
+    .kind = CHARDEV_BACKEND_KIND_SERIAL,
+    .alias = "tty",
+    .parse = qemu_chr_parse_serial,
+    .create = qmp_chardev_open_serial,
+#ifdef _WIN32
+    .chr_write = win_chr_write,
+    .chr_free = win_chr_free,
+#else
+    .chr_add_watch = fd_chr_add_watch,
+    .chr_write = fd_chr_write,
+    .chr_update_read_handler = fd_chr_update_read_handler,
+    .chr_ioctl = tty_serial_ioctl,
+    .chr_free = qemu_chr_free_tty,
+#endif
+};
+#endif
+
 static gboolean socket_reconnect_timeout(gpointer opaque)
 {
     CharDriverState *chr = opaque;
@@ -4657,7 +4782,8 @@ static gboolean socket_reconnect_timeout(gpointer opaque)
     return false;
 }
 
-static CharDriverState *qmp_chardev_open_socket(const char *id,
+static CharDriverState *qmp_chardev_open_socket(const CharDriver *driver,
+                                                const char *id,
                                                 ChardevBackend *backend,
                                                 ChardevReturn *ret,
                                                 bool *be_opened,
@@ -4675,7 +4801,7 @@ static CharDriverState *qmp_chardev_open_socket(const char *id,
     ChardevCommon *common = qapi_ChardevSocket_base(sock);
     QIOChannelSocket *sioc = NULL;
 
-    chr = qemu_chr_alloc(common, errp);
+    chr = qemu_chr_alloc(driver, common, errp);
     if (!chr) {
         return NULL;
     }
@@ -4726,16 +4852,6 @@ static CharDriverState *qmp_chardev_open_socket(const char *id,
     }
 
     chr->opaque = s;
-    chr->chr_wait_connected = tcp_chr_wait_connected;
-    chr->chr_write = tcp_chr_write;
-    chr->chr_sync_read = tcp_chr_sync_read;
-    chr->chr_free = tcp_chr_free;
-    chr->chr_disconnect = tcp_chr_disconnect;
-    chr->get_msgfds = tcp_get_msgfds;
-    chr->set_msgfds = tcp_set_msgfds;
-    chr->chr_add_client = tcp_chr_add_client;
-    chr->chr_add_watch = tcp_chr_add_watch;
-    chr->chr_update_read_handler = tcp_chr_update_read_handler;
     /* be isn't opened until we get a connection */
     *be_opened = false;
 
@@ -4797,7 +4913,24 @@ static CharDriverState *qmp_chardev_open_socket(const char *id,
     return NULL;
 }
 
-static CharDriverState *qmp_chardev_open_udp(const char *id,
+static const CharDriver socket_driver = {
+    .kind = CHARDEV_BACKEND_KIND_SOCKET,
+    .parse = qemu_chr_parse_socket,
+    .create = qmp_chardev_open_socket,
+    .chr_wait_connected = tcp_chr_wait_connected,
+    .chr_write = tcp_chr_write,
+    .chr_sync_read = tcp_chr_sync_read,
+    .chr_disconnect = tcp_chr_disconnect,
+    .get_msgfds = tcp_get_msgfds,
+    .set_msgfds = tcp_set_msgfds,
+    .chr_add_client = tcp_chr_add_client,
+    .chr_add_watch = tcp_chr_add_watch,
+    .chr_update_read_handler = tcp_chr_update_read_handler,
+    .chr_free = tcp_chr_free,
+};
+
+static CharDriverState *qmp_chardev_open_udp(const CharDriver *driver,
+                                             const char *id,
                                              ChardevBackend *backend,
                                              ChardevReturn *ret,
                                              bool *be_opened,
@@ -4815,7 +4948,8 @@ static CharDriverState *qmp_chardev_open_udp(const char *id,
         object_unref(OBJECT(sioc));
         return NULL;
     }
-    chr = qemu_chr_open_udp(sioc, common, be_opened, errp);
+
+    chr = qemu_chr_open_udp(driver, sioc, common, be_opened, errp);
 
     name = g_strdup_printf("chardev-udp-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(sioc), name);
@@ -4824,6 +4958,14 @@ static CharDriverState *qmp_chardev_open_udp(const char *id,
     return chr;
 }
 
+static const CharDriver udp_driver = {
+    .kind = CHARDEV_BACKEND_KIND_UDP,
+    .parse = qemu_chr_parse_udp,
+    .create = qmp_chardev_open_udp,
+    .chr_write = udp_chr_write,
+    .chr_update_read_handler = udp_chr_update_read_handler,
+    .chr_free = udp_chr_free,
+};
 
 bool qemu_chr_has_feature(CharDriverState *chr,
                           CharDriverFeature feature)
@@ -4859,7 +5001,7 @@ ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend,
         goto out_error;
     }
 
-    chr = cd->create(id, backend, ret, &be_opened, &local_err);
+    chr = cd->create(cd, id, backend, ret, &be_opened, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto out_error;
@@ -4912,86 +5054,33 @@ void qemu_chr_cleanup(void)
 
 static void register_types(void)
 {
-    int i;
-    static const CharDriver drivers[] = {
-        {
-            .kind = CHARDEV_BACKEND_KIND_NULL,
-            .create = qemu_chr_open_null,
-        },
-        {
-            .kind = CHARDEV_BACKEND_KIND_SOCKET,
-            .parse = qemu_chr_parse_socket,
-            .create = qmp_chardev_open_socket,
-        },
-        {
-            .kind = CHARDEV_BACKEND_KIND_UDP,
-            .parse = qemu_chr_parse_udp,
-            .create = qmp_chardev_open_udp,
-        },
-        {
-            .kind = CHARDEV_BACKEND_KIND_RINGBUF,
-            .parse = qemu_chr_parse_ringbuf,
-            .create = qemu_chr_open_ringbuf,
-        },
-        {
-            .kind = CHARDEV_BACKEND_KIND_FILE,
-            .parse = qemu_chr_parse_file_out,
-            .create = qmp_chardev_open_file,
-        },
-        {
-            .kind = CHARDEV_BACKEND_KIND_STDIO,
-            .parse = qemu_chr_parse_stdio,
-            .create = qemu_chr_open_stdio,
-        },
-#if defined HAVE_CHARDEV_SERIAL
-        {
-            .kind = CHARDEV_BACKEND_KIND_SERIAL,
-            .alias = "tty",
-            .parse = qemu_chr_parse_serial,
-            .create = qmp_chardev_open_serial,
-        },
+    static const CharDriver *drivers[] = {
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
-            .kind = CHARDEV_BACKEND_KIND_PARALLEL,
-            .alias = "parport",
-            .parse = qemu_chr_parse_parallel,
-            .create = qmp_chardev_open_parallel,
-        },
+        &parallel_driver,
 #endif
 #ifdef HAVE_CHARDEV_PTY
-        {
-            .kind = CHARDEV_BACKEND_KIND_PTY,
-            .create = qemu_chr_open_pty,
-        },
+        &pty_driver,
 #endif
 #ifdef _WIN32
-        {
-            .kind = CHARDEV_BACKEND_KIND_CONSOLE,
-            .create = qemu_chr_open_win_con,
-        },
+        &console_driver,
 #endif
-        {
-            .kind = CHARDEV_BACKEND_KIND_PIPE,
-            .parse = qemu_chr_parse_pipe,
-            .create = qemu_chr_open_pipe,
-        },
-        {
-            .kind = CHARDEV_BACKEND_KIND_MUX,
-            .parse = qemu_chr_parse_mux,
-            .create = qemu_chr_open_mux,
-        },
-        /* Bug-compatibility: */
-        {
-            .kind = CHARDEV_BACKEND_KIND_MEMORY,
-            .parse = qemu_chr_parse_ringbuf,
-            .create = qemu_chr_open_ringbuf,
-        },
+        &pipe_driver,
+        &mux_driver,
+        &memory_driver
     };
-
+    int i;
 
     for (i = 0; i < ARRAY_SIZE(drivers); i++) {
-        register_char_driver(&drivers[i]);
+        register_char_driver(drivers[i]);
     }
 
     /* this must be done after machine init, since we register FEs with muxes
diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index 30db420..c7eb306 100644
--- a/spice-qemu-char.c
+++ b/spice-qemu-char.c
@@ -260,16 +260,15 @@ static void spice_chr_accept_input(struct CharDriverState *chr)
     spice_server_char_device_wakeup(&s->sin);
 }
 
-static CharDriverState *chr_open(const char *subtype,
-                                 void (*set_fe_open)(struct CharDriverState *,
-                                                     int),
+static CharDriverState *chr_open(const CharDriver *driver,
+                                 const char *subtype,
                                  ChardevCommon *backend,
                                  Error **errp)
 {
     CharDriverState *chr;
     SpiceCharDriver *s;
 
-    chr = qemu_chr_alloc(backend, errp);
+    chr = qemu_chr_alloc(driver, backend, errp);
     if (!chr) {
         return NULL;
     }
@@ -278,18 +277,14 @@ static CharDriverState *chr_open(const char *subtype,
     s->active = false;
     s->sin.subtype = g_strdup(subtype);
     chr->opaque = s;
-    chr->chr_write = spice_chr_write;
-    chr->chr_add_watch = spice_chr_add_watch;
-    chr->chr_free = spice_chr_free;
-    chr->chr_set_fe_open = set_fe_open;
-    chr->chr_accept_input = spice_chr_accept_input;
 
     QLIST_INSERT_HEAD(&spice_chars, s, next);
 
     return chr;
 }
 
-static CharDriverState *qemu_chr_open_spice_vmc(const char *id,
+static CharDriverState *qemu_chr_open_spice_vmc(const CharDriver *driver,
+                                                const char *id,
                                                 ChardevBackend *backend,
                                                 ChardevReturn *ret,
                                                 bool *be_opened,
@@ -312,11 +307,12 @@ static CharDriverState *qemu_chr_open_spice_vmc(const char *id,
     }
 
     *be_opened = false;
-    return chr_open(type, spice_vmc_set_fe_open, common, errp);
+    return chr_open(driver, type, common, errp);
 }
 
 #if SPICE_SERVER_VERSION >= 0x000c02
-static CharDriverState *qemu_chr_open_spice_port(const char *id,
+static CharDriverState *qemu_chr_open_spice_port(const CharDriver *driver,
+                                                 const char *id,
                                                  ChardevBackend *backend,
                                                  ChardevReturn *ret,
                                                  bool *be_opened,
@@ -333,7 +329,7 @@ static CharDriverState *qemu_chr_open_spice_port(const char *id,
         return NULL;
     }
 
-    chr = chr_open("port", spice_port_set_fe_open, common, errp);
+    chr = chr_open(driver, "port", common, errp);
     if (!chr) {
         return NULL;
     }
@@ -393,11 +389,21 @@ static void register_types(void)
         .kind = CHARDEV_BACKEND_KIND_SPICEVMC,
         .parse = qemu_chr_parse_spice_vmc,
         .create = qemu_chr_open_spice_vmc,
+        .chr_write = spice_chr_write,
+        .chr_add_watch = spice_chr_add_watch,
+        .chr_set_fe_open = spice_vmc_set_fe_open,
+        .chr_accept_input = spice_chr_accept_input,
+        .chr_free = spice_chr_free,
     };
     static const CharDriver port_driver = {
         .kind = CHARDEV_BACKEND_KIND_SPICEPORT,
         .parse = qemu_chr_parse_spice_port,
         .create = qemu_chr_open_spice_port,
+        .chr_write = spice_chr_write,
+        .chr_add_watch = spice_chr_add_watch,
+        .chr_set_fe_open = spice_port_set_fe_open,
+        .chr_accept_input = spice_chr_accept_input,
+        .chr_free = spice_chr_free,
     };
     register_char_driver(&vmc_driver);
     register_char_driver(&port_driver);
diff --git a/ui/console.c b/ui/console.c
index e4bb22f..f48ba26 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1051,6 +1051,10 @@ static int console_puts(CharDriverState *chr, const uint8_t *buf, int len)
     QemuConsole *s = chr->opaque;
     int i;
 
+    if (!s->ds) {
+        return 0;
+    }
+
     s->update_x0 = s->width * FONT_WIDTH;
     s->update_y0 = s->height * FONT_HEIGHT;
     s->update_x1 = 0;
@@ -2000,8 +2004,6 @@ static void text_console_do_init(CharDriverState *chr, DisplayState *ds)
 
     s = chr->opaque;
 
-    chr->chr_write = console_puts;
-
     s->out_fifo.buf = s->out_fifo_buf;
     s->out_fifo.buf_size = sizeof(s->out_fifo_buf);
     s->kbd_timer = timer_new_ms(QEMU_CLOCK_REALTIME, kbd_send_chars, s);
@@ -2048,6 +2050,8 @@ static void text_console_do_init(CharDriverState *chr, DisplayState *ds)
     qemu_chr_be_generic_open(chr);
 }
 
+static const CharDriver vc_driver;
+
 static CharDriverState *text_console_init(ChardevVC *vc, Error **errp)
 {
     ChardevCommon *common = qapi_ChardevVC_base(vc);
@@ -2056,7 +2060,7 @@ static CharDriverState *text_console_init(ChardevVC *vc, Error **errp)
     unsigned width = 0;
     unsigned height = 0;
 
-    chr = qemu_chr_alloc(common, errp);
+    chr = qemu_chr_alloc(&vc_driver, common, errp);
     if (!chr) {
         return NULL;
     }
@@ -2089,7 +2093,6 @@ static CharDriverState *text_console_init(ChardevVC *vc, Error **errp)
 
     s->chr = chr;
     chr->opaque = s;
-    chr->chr_set_echo = text_console_set_echo;
 
     if (display_state) {
         text_console_do_init(chr, display_state);
@@ -2099,7 +2102,8 @@ static CharDriverState *text_console_init(ChardevVC *vc, Error **errp)
 
 static VcHandler *vc_handler = text_console_init;
 
-static CharDriverState *vc_init(const char *id, ChardevBackend *backend,
+static CharDriverState *vc_init(const CharDriver *driver,
+                                const char *id, ChardevBackend *backend,
                                 ChardevReturn *ret, bool *be_opened,
                                 Error **errp)
 {
@@ -2191,14 +2195,16 @@ static const TypeInfo qemu_console_info = {
     .class_size = sizeof(QemuConsoleClass),
 };
 
+static const CharDriver vc_driver = {
+    .kind = CHARDEV_BACKEND_KIND_VC,
+    .parse = qemu_chr_parse_vc,
+    .create = vc_init,
+    .chr_write = console_puts,
+    .chr_set_echo = text_console_set_echo,
+};
+
 static void register_types(void)
 {
-    static const CharDriver vc_driver = {
-        .kind = CHARDEV_BACKEND_KIND_VC,
-        .parse = qemu_chr_parse_vc,
-        .create = vc_init,
-    };
-
     type_register_static(&qemu_console_info);
     register_char_driver(&vc_driver);
 }
diff --git a/ui/gtk.c b/ui/gtk.c
index 86368e3..608400b 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1703,6 +1703,12 @@ static CharDriverState *vcs[MAX_VCS];
 
 static CharDriverState *gd_vc_handler(ChardevVC *vc, Error **errp)
 {
+    static const CharDriver gd_vc_driver = {
+        .kind = CHARDEV_BACKEND_KIND_VC,
+        .chr_write = gd_vc_chr_write,
+        .chr_set_echo = gd_vc_chr_set_echo,
+    };
+
     ChardevCommon *common = qapi_ChardevVC_base(vc);
     CharDriverState *chr;
 
@@ -1711,14 +1717,11 @@ static CharDriverState *gd_vc_handler(ChardevVC *vc, Error **errp)
         return NULL;
     }
 
-    chr = qemu_chr_alloc(common, errp);
+    chr = qemu_chr_alloc(&gd_vc_driver, common, errp);
     if (!chr) {
         return NULL;
     }
 
-    chr->chr_write = gd_vc_chr_write;
-    chr->chr_set_echo = gd_vc_chr_set_echo;
-
     /* Temporary, until gd_vc_vte_init runs.  */
     chr->opaque = g_new0(VirtualConsole, 1);
 
-- 
1.8.3.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d83Qb-0006GG-T9
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d83QW-0003D8-AP
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:35:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d83QV-0003Cg-TC
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:35:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D31799FDE6
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 11:35:34 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 15:33:29 +0400
Message-Id: <20170509113332.4987-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170509113332.4987-1-marcandre.lureau@redhat.com>
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/13] char: move CharBackend handling in
 char-fe unit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Move all the fronted struct and methods to a seperate unit. This avoids
accidentally mixing backend and frontend calls, and helps with readibilty=
.

Make qemu_chr_replay() a macro shared by both char and char-fe.

Export qemu_chr_write(), and use a macro for qemu_chr_write_all()

(nb: yes, CharBackend is for char frontend :)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/chardev/char-fe.h         | 249 ++++++++++++++++++++++++++
 include/chardev/char-mux.h        |   1 +
 include/chardev/char.h            | 242 +-------------------------
 include/hw/char/bcm2835_aux.h     |   2 +-
 include/hw/char/cadence_uart.h    |   2 +-
 include/hw/char/digic-uart.h      |   2 +-
 include/hw/char/imx_serial.h      |   2 +-
 include/hw/char/serial.h          |   2 +-
 include/hw/char/stm32f2xx_usart.h |   2 +-
 backends/rng-egd.c                |   2 +-
 backends/wctablet.c               |   2 +-
 chardev/char-fe.c                 | 358 ++++++++++++++++++++++++++++++++=
++++++
 chardev/char.c                    | 342 +-------------------------------=
----
 gdbstub.c                         |   1 +
 hw/arm/omap2.c                    |   2 +-
 hw/arm/pxa2xx.c                   |   2 +-
 hw/arm/strongarm.c                |   1 +
 hw/char/cadence_uart.c            |   1 +
 hw/char/debugcon.c                |   2 +-
 hw/char/digic-uart.c              |   2 +-
 hw/char/escc.c                    |   1 +
 hw/char/etraxfs_ser.c             |   2 +-
 hw/char/exynos4210_uart.c         |   1 +
 hw/char/grlib_apbuart.c           |   2 +-
 hw/char/ipoctal232.c              |   2 +-
 hw/char/lm32_juart.c              |   2 +-
 hw/char/lm32_uart.c               |   2 +-
 hw/char/mcf_uart.c                |   2 +-
 hw/char/milkymist-uart.c          |   2 +-
 hw/char/parallel.c                |   1 +
 hw/char/pl011.c                   |   2 +-
 hw/char/sclpconsole-lm.c          |   2 +-
 hw/char/sclpconsole.c             |   2 +-
 hw/char/sh_serial.c               |   2 +-
 hw/char/spapr_vty.c               |   2 +-
 hw/char/virtio-console.c          |   2 +-
 hw/char/xen_console.c             |   2 +-
 hw/char/xilinx_uartlite.c         |   2 +-
 hw/core/qdev-properties-system.c  |   2 +-
 hw/ipmi/ipmi_bmc_extern.c         |   2 +-
 hw/misc/ivshmem.c                 |   2 +-
 hw/usb/ccid-card-passthru.c       |   2 +-
 hw/usb/dev-serial.c               |   1 +
 hw/usb/redirect.c                 |   2 +-
 hw/virtio/vhost-user.c            |   2 +-
 monitor.c                         |   2 +-
 net/colo-compare.c                |   2 +-
 net/filter-mirror.c               |   2 +-
 net/slirp.c                       |   2 +-
 net/vhost-user.c                  |   2 +-
 qtest.c                           |   2 +-
 slirp/slirp.c                     |   2 +-
 tests/test-char.c                 |   2 +-
 tests/vhost-user-test.c           |   2 +-
 ui/console.c                      |   2 +-
 chardev/Makefile.objs             |   1 +
 56 files changed, 664 insertions(+), 622 deletions(-)
 create mode 100644 include/chardev/char-fe.h
 create mode 100644 chardev/char-fe.c

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
new file mode 100644
index 0000000000..bd82093218
--- /dev/null
+++ b/include/chardev/char-fe.h
@@ -0,0 +1,249 @@
+#ifndef QEMU_CHAR_FE_H
+#define QEMU_CHAR_FE_H
+
+#include "chardev/char.h"
+
+typedef void IOEventHandler(void *opaque, int event);
+
+/* This is the backend as seen by frontend, the actual backend is
+ * Chardev */
+struct CharBackend {
+    Chardev *chr;
+    IOEventHandler *chr_event;
+    IOCanReadHandler *chr_can_read;
+    IOReadHandler *chr_read;
+    void *opaque;
+    int tag;
+    int fe_open;
+};
+
+/**
+ * @qemu_chr_fe_init:
+ *
+ * Initializes a front end for the given CharBackend and
+ * Chardev. Call qemu_chr_fe_deinit() to remove the association and
+ * release the driver.
+ *
+ * Returns: false on error.
+ */
+bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp);
+
+/**
+ * @qemu_chr_fe_deinit:
+ *
+ * Dissociate the CharBackend from the Chardev.
+ *
+ * Safe to call without associated Chardev.
+ */
+void qemu_chr_fe_deinit(CharBackend *b);
+
+/**
+ * @qemu_chr_fe_get_driver:
+ *
+ * Returns the driver associated with a CharBackend or NULL if no
+ * associated Chardev.
+ */
+Chardev *qemu_chr_fe_get_driver(CharBackend *be);
+
+/**
+ * @qemu_chr_fe_set_handlers:
+ * @b: a CharBackend
+ * @fd_can_read: callback to get the amount of data the frontend may
+ *               receive
+ * @fd_read: callback to receive data from char
+ * @fd_event: event callback
+ * @opaque: an opaque pointer for the callbacks
+ * @context: a main loop context or NULL for the default
+ * @set_open: whether to call qemu_chr_fe_set_open() implicitely when
+ * any of the handler is non-NULL
+ *
+ * Set the front end char handlers. The front end takes the focus if
+ * any of the handler is non-NULL.
+ *
+ * Without associated Chardev, nothing is changed.
+ */
+void qemu_chr_fe_set_handlers(CharBackend *b,
+                              IOCanReadHandler *fd_can_read,
+                              IOReadHandler *fd_read,
+                              IOEventHandler *fd_event,
+                              void *opaque,
+                              GMainContext *context,
+                              bool set_open);
+
+/**
+ * @qemu_chr_fe_take_focus:
+ *
+ * Take the focus (if the front end is muxed).
+ *
+ * Without associated Chardev, nothing is changed.
+ */
+void qemu_chr_fe_take_focus(CharBackend *b);
+
+/**
+ * @qemu_chr_fe_accept_input:
+ *
+ * Notify that the frontend is ready to receive data
+ */
+void qemu_chr_fe_accept_input(CharBackend *be);
+
+/**
+ * @qemu_chr_fe_disconnect:
+ *
+ * Close a fd accpeted by character backend.
+ * Without associated Chardev, do nothing.
+ */
+void qemu_chr_fe_disconnect(CharBackend *be);
+
+/**
+ * @qemu_chr_fe_wait_connected:
+ *
+ * Wait for characted backend to be connected, return < 0 on error or
+ * if no assicated Chardev.
+ */
+int qemu_chr_fe_wait_connected(CharBackend *be, Error **errp);
+
+/**
+ * @qemu_chr_fe_set_echo:
+ *
+ * Ask the backend to override its normal echo setting.  This only reall=
y
+ * applies to the stdio backend and is used by the QMP server such that =
you
+ * can see what you type if you try to type QMP commands.
+ * Without associated Chardev, do nothing.
+ *
+ * @echo true to enable echo, false to disable echo
+ */
+void qemu_chr_fe_set_echo(CharBackend *be, bool echo);
+
+/**
+ * @qemu_chr_fe_set_open:
+ *
+ * Set character frontend open status.  This is an indication that the
+ * front end is ready (or not) to begin doing I/O.
+ * Without associated Chardev, do nothing.
+ */
+void qemu_chr_fe_set_open(CharBackend *be, int fe_open);
+
+/**
+ * @qemu_chr_fe_printf:
+ *
+ * Write to a character backend using a printf style interface.  This
+ * function is thread-safe. It does nothing without associated
+ * Chardev.
+ *
+ * @fmt see #printf
+ */
+void qemu_chr_fe_printf(CharBackend *be, const char *fmt, ...)
+    GCC_FMT_ATTR(2, 3);
+
+/**
+ * @qemu_chr_fe_add_watch:
+ *
+ * If the backend is connected, create and add a #GSource that fires
+ * when the given condition (typically G_IO_OUT|G_IO_HUP or G_IO_HUP)
+ * is active; return the #GSource's tag.  If it is disconnected,
+ * or without associated Chardev, return 0.
+ *
+ * @cond the condition to poll for
+ * @func the function to call when the condition happens
+ * @user_data the opaque pointer to pass to @func
+ *
+ * Returns: the source tag
+ */
+guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
+                            GIOFunc func, void *user_data);
+
+/**
+ * @qemu_chr_fe_write:
+ *
+ * Write data to a character backend from the front end.  This function
+ * will send data from the front end to the back end.  This function
+ * is thread-safe.
+ *
+ * @buf the data
+ * @len the number of bytes to send
+ *
+ * Returns: the number of bytes consumed (0 if no assicated Chardev)
+ */
+int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len);
+
+/**
+ * @qemu_chr_fe_write_all:
+ *
+ * Write data to a character backend from the front end.  This function =
will
+ * send data from the front end to the back end.  Unlike @qemu_chr_fe_wr=
ite,
+ * this function will block if the back end cannot consume all of the da=
ta
+ * attempted to be written.  This function is thread-safe.
+ *
+ * @buf the data
+ * @len the number of bytes to send
+ *
+ * Returns: the number of bytes consumed (0 if no assicated Chardev)
+ */
+int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len);
+
+/**
+ * @qemu_chr_fe_read_all:
+ *
+ * Read data to a buffer from the back end.
+ *
+ * @buf the data buffer
+ * @len the number of bytes to read
+ *
+ * Returns: the number of bytes read (0 if no assicated Chardev)
+ */
+int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len);
+
+/**
+ * @qemu_chr_fe_ioctl:
+ *
+ * Issue a device specific ioctl to a backend.  This function is thread-=
safe.
+ *
+ * @cmd see CHR_IOCTL_*
+ * @arg the data associated with @cmd
+ *
+ * Returns: if @cmd is not supported by the backend or there is no
+ *          associated Chardev, -ENOTSUP, otherwise the return
+ *          value depends on the semantics of @cmd
+ */
+int qemu_chr_fe_ioctl(CharBackend *be, int cmd, void *arg);
+
+/**
+ * @qemu_chr_fe_get_msgfd:
+ *
+ * For backends capable of fd passing, return the latest file descriptor=
 passed
+ * by a client.
+ *
+ * Returns: -1 if fd passing isn't supported or there is no pending file
+ *          descriptor.  If a file descriptor is returned, subsequent ca=
lls to
+ *          this function will return -1 until a client sends a new file
+ *          descriptor.
+ */
+int qemu_chr_fe_get_msgfd(CharBackend *be);
+
+/**
+ * @qemu_chr_fe_get_msgfds:
+ *
+ * For backends capable of fd passing, return the number of file receive=
d
+ * descriptors and fills the fds array up to num elements
+ *
+ * Returns: -1 if fd passing isn't supported or there are no pending fil=
e
+ *          descriptors.  If file descriptors are returned, subsequent c=
alls to
+ *          this function will return -1 until a client sends a new set =
of file
+ *          descriptors.
+ */
+int qemu_chr_fe_get_msgfds(CharBackend *be, int *fds, int num);
+
+/**
+ * @qemu_chr_fe_set_msgfds:
+ *
+ * For backends capable of fd passing, set an array of fds to be passed =
with
+ * the next send operation.
+ * A subsequent call to this function before calling a write function wi=
ll
+ * result in overwriting the fd array with the new value without being s=
end.
+ * Upon writing the message the fd array is freed.
+ *
+ * Returns: -1 if fd passing isn't supported or no associated Chardev.
+ */
+int qemu_chr_fe_set_msgfds(CharBackend *be, int *fds, int num);
+
+#endif /* QEMU_CHAR_FE_H */
diff --git a/include/chardev/char-mux.h b/include/chardev/char-mux.h
index 45cdfc7e67..8928977897 100644
--- a/include/chardev/char-mux.h
+++ b/include/chardev/char-mux.h
@@ -25,6 +25,7 @@
 #define CHAR_MUX_H
=20
 #include "chardev/char.h"
+#include "chardev/char-fe.h"
=20
 extern bool muxes_realized;
=20
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 0e1ef1ea4f..02a08f2bec 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -16,6 +16,7 @@
 #define IAC 255
=20
 /* character device */
+typedef struct CharBackend CharBackend;
=20
 typedef enum {
     CHR_EVENT_BREAK, /* serial break char */
@@ -27,8 +28,6 @@ typedef enum {
=20
 #define CHR_READ_BUF_LEN 4096
=20
-typedef void IOEventHandler(void *opaque, int event);
-
 typedef enum {
     /* Whether the chardev peer is able to close and
      * reopen the data channel, thus requiring support
@@ -44,17 +43,7 @@ typedef enum {
     QEMU_CHAR_FEATURE_LAST,
 } ChardevFeature;
=20
-/* This is the backend as seen by frontend, the actual backend is
- * Chardev */
-typedef struct CharBackend {
-    Chardev *chr;
-    IOEventHandler *chr_event;
-    IOCanReadHandler *chr_can_read;
-    IOReadHandler *chr_read;
-    void *opaque;
-    int tag;
-    int fe_open;
-} CharBackend;
+#define qemu_chr_replay(chr) qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE=
_REPLAY)
=20
 struct Chardev {
     Object parent_obj;
@@ -103,15 +92,6 @@ void qemu_chr_parse_common(QemuOpts *opts, ChardevCom=
mon *backend);
  */
 Chardev *qemu_chr_new(const char *label, const char *filename);
=20
-
-/**
- * @qemu_chr_fe_disconnect:
- *
- * Close a fd accpeted by character backend.
- * Without associated Chardev, do nothing.
- */
-void qemu_chr_fe_disconnect(CharBackend *be);
-
 /**
  * @qemu_chr_cleanup:
  *
@@ -120,14 +100,6 @@ void qemu_chr_fe_disconnect(CharBackend *be);
 void qemu_chr_cleanup(void);
=20
 /**
- * @qemu_chr_fe_wait_connected:
- *
- * Wait for characted backend to be connected, return < 0 on error or
- * if no assicated Chardev.
- */
-int qemu_chr_fe_wait_connected(CharBackend *be, Error **errp);
-
-/**
  * @qemu_chr_new_noreplay:
  *
  * Create a new character backend from a URI.
@@ -142,150 +114,6 @@ int qemu_chr_fe_wait_connected(CharBackend *be, Err=
or **errp);
 Chardev *qemu_chr_new_noreplay(const char *label, const char *filename);
=20
 /**
- * @qemu_chr_fe_set_echo:
- *
- * Ask the backend to override its normal echo setting.  This only reall=
y
- * applies to the stdio backend and is used by the QMP server such that =
you
- * can see what you type if you try to type QMP commands.
- * Without associated Chardev, do nothing.
- *
- * @echo true to enable echo, false to disable echo
- */
-void qemu_chr_fe_set_echo(CharBackend *be, bool echo);
-
-/**
- * @qemu_chr_fe_set_open:
- *
- * Set character frontend open status.  This is an indication that the
- * front end is ready (or not) to begin doing I/O.
- * Without associated Chardev, do nothing.
- */
-void qemu_chr_fe_set_open(CharBackend *be, int fe_open);
-
-/**
- * @qemu_chr_fe_printf:
- *
- * Write to a character backend using a printf style interface.  This
- * function is thread-safe. It does nothing without associated
- * Chardev.
- *
- * @fmt see #printf
- */
-void qemu_chr_fe_printf(CharBackend *be, const char *fmt, ...)
-    GCC_FMT_ATTR(2, 3);
-
-/**
- * @qemu_chr_fe_add_watch:
- *
- * If the backend is connected, create and add a #GSource that fires
- * when the given condition (typically G_IO_OUT|G_IO_HUP or G_IO_HUP)
- * is active; return the #GSource's tag.  If it is disconnected,
- * or without associated Chardev, return 0.
- *
- * @cond the condition to poll for
- * @func the function to call when the condition happens
- * @user_data the opaque pointer to pass to @func
- *
- * Returns: the source tag
- */
-guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
-                            GIOFunc func, void *user_data);
-
-/**
- * @qemu_chr_fe_write:
- *
- * Write data to a character backend from the front end.  This function
- * will send data from the front end to the back end.  This function
- * is thread-safe.
- *
- * @buf the data
- * @len the number of bytes to send
- *
- * Returns: the number of bytes consumed (0 if no assicated Chardev)
- */
-int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len);
-
-/**
- * @qemu_chr_fe_write_all:
- *
- * Write data to a character backend from the front end.  This function =
will
- * send data from the front end to the back end.  Unlike @qemu_chr_fe_wr=
ite,
- * this function will block if the back end cannot consume all of the da=
ta
- * attempted to be written.  This function is thread-safe.
- *
- * @buf the data
- * @len the number of bytes to send
- *
- * Returns: the number of bytes consumed (0 if no assicated Chardev)
- */
-int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len);
-
-/**
- * @qemu_chr_fe_read_all:
- *
- * Read data to a buffer from the back end.
- *
- * @buf the data buffer
- * @len the number of bytes to read
- *
- * Returns: the number of bytes read (0 if no assicated Chardev)
- */
-int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len);
-
-/**
- * @qemu_chr_fe_ioctl:
- *
- * Issue a device specific ioctl to a backend.  This function is thread-=
safe.
- *
- * @cmd see CHR_IOCTL_*
- * @arg the data associated with @cmd
- *
- * Returns: if @cmd is not supported by the backend or there is no
- *          associated Chardev, -ENOTSUP, otherwise the return
- *          value depends on the semantics of @cmd
- */
-int qemu_chr_fe_ioctl(CharBackend *be, int cmd, void *arg);
-
-/**
- * @qemu_chr_fe_get_msgfd:
- *
- * For backends capable of fd passing, return the latest file descriptor=
 passed
- * by a client.
- *
- * Returns: -1 if fd passing isn't supported or there is no pending file
- *          descriptor.  If a file descriptor is returned, subsequent ca=
lls to
- *          this function will return -1 until a client sends a new file
- *          descriptor.
- */
-int qemu_chr_fe_get_msgfd(CharBackend *be);
-
-/**
- * @qemu_chr_fe_get_msgfds:
- *
- * For backends capable of fd passing, return the number of file receive=
d
- * descriptors and fills the fds array up to num elements
- *
- * Returns: -1 if fd passing isn't supported or there are no pending fil=
e
- *          descriptors.  If file descriptors are returned, subsequent c=
alls to
- *          this function will return -1 until a client sends a new set =
of file
- *          descriptors.
- */
-int qemu_chr_fe_get_msgfds(CharBackend *be, int *fds, int num);
-
-/**
- * @qemu_chr_fe_set_msgfds:
- *
- * For backends capable of fd passing, set an array of fds to be passed =
with
- * the next send operation.
- * A subsequent call to this function before calling a write function wi=
ll
- * result in overwriting the fd array with the new value without being s=
end.
- * Upon writing the message the fd array is freed.
- *
- * Returns: -1 if fd passing isn't supported or no associated Chardev.
- */
-int qemu_chr_fe_set_msgfds(CharBackend *be, int *fds, int num);
-
-/**
  * @qemu_chr_be_can_write:
  *
  * Determine how much data the front end can currently accept.  This fun=
ction
@@ -328,69 +156,6 @@ void qemu_chr_be_write_impl(Chardev *s, uint8_t *buf=
, int len);
  */
 void qemu_chr_be_event(Chardev *s, int event);
=20
-/**
- * @qemu_chr_fe_init:
- *
- * Initializes a front end for the given CharBackend and
- * Chardev. Call qemu_chr_fe_deinit() to remove the association and
- * release the driver.
- *
- * Returns: false on error.
- */
-bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp);
-
-/**
- * @qemu_chr_fe_get_driver:
- *
- * Returns the driver associated with a CharBackend or NULL if no
- * associated Chardev.
- */
-Chardev *qemu_chr_fe_get_driver(CharBackend *be);
-
-/**
- * @qemu_chr_fe_deinit:
- *
- * Dissociate the CharBackend from the Chardev.
- *
- * Safe to call without associated Chardev.
- */
-void qemu_chr_fe_deinit(CharBackend *b);
-
-/**
- * @qemu_chr_fe_set_handlers:
- * @b: a CharBackend
- * @fd_can_read: callback to get the amount of data the frontend may
- *               receive
- * @fd_read: callback to receive data from char
- * @fd_event: event callback
- * @opaque: an opaque pointer for the callbacks
- * @context: a main loop context or NULL for the default
- * @set_open: whether to call qemu_chr_fe_set_open() implicitely when
- * any of the handler is non-NULL
- *
- * Set the front end char handlers. The front end takes the focus if
- * any of the handler is non-NULL.
- *
- * Without associated Chardev, nothing is changed.
- */
-void qemu_chr_fe_set_handlers(CharBackend *b,
-                              IOCanReadHandler *fd_can_read,
-                              IOReadHandler *fd_read,
-                              IOEventHandler *fd_event,
-                              void *opaque,
-                              GMainContext *context,
-                              bool set_open);
-
-/**
- * @qemu_chr_fe_take_focus:
- *
- * Take the focus (if the front end is muxed).
- *
- * Without associated Chardev, nothing is changed.
- */
-void qemu_chr_fe_take_focus(CharBackend *b);
-
-void qemu_chr_fe_accept_input(CharBackend *be);
 int qemu_chr_add_client(Chardev *s, int fd);
 Chardev *qemu_chr_find(const char *name);
=20
@@ -399,7 +164,8 @@ bool qemu_chr_has_feature(Chardev *chr,
 void qemu_chr_set_feature(Chardev *chr,
                           ChardevFeature feature);
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename)=
;
-int qemu_chr_write_all(Chardev *s, const uint8_t *buf, int len);
+int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool all);
+#define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, true=
)
 int qemu_chr_wait_connected(Chardev *chr, Error **errp);
=20
 #define TYPE_CHARDEV "chardev"
diff --git a/include/hw/char/bcm2835_aux.h b/include/hw/char/bcm2835_aux.=
h
index 2a051c5646..cdbf7e3e37 100644
--- a/include/hw/char/bcm2835_aux.h
+++ b/include/hw/char/bcm2835_aux.h
@@ -9,7 +9,7 @@
 #define BCM2835_AUX_H
=20
 #include "hw/sysbus.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
=20
 #define TYPE_BCM2835_AUX "bcm2835-aux"
 #define BCM2835_AUX(obj) OBJECT_CHECK(BCM2835AuxState, (obj), TYPE_BCM28=
35_AUX)
diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uar=
t.h
index eed7d8d358..118e3f10de 100644
--- a/include/hw/char/cadence_uart.h
+++ b/include/hw/char/cadence_uart.h
@@ -19,7 +19,7 @@
 #ifndef CADENCE_UART_H
=20
 #include "hw/sysbus.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "qemu/timer.h"
=20
 #define CADENCE_UART_RX_FIFO_SIZE           16
diff --git a/include/hw/char/digic-uart.h b/include/hw/char/digic-uart.h
index 370b48a6c5..de9a3e3551 100644
--- a/include/hw/char/digic-uart.h
+++ b/include/hw/char/digic-uart.h
@@ -19,7 +19,7 @@
 #define HW_CHAR_DIGIC_UART_H
=20
 #include "hw/sysbus.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
=20
 #define TYPE_DIGIC_UART "digic-uart"
 #define DIGIC_UART(obj) \
diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
index 05500f5346..baeec3183f 100644
--- a/include/hw/char/imx_serial.h
+++ b/include/hw/char/imx_serial.h
@@ -19,7 +19,7 @@
 #define IMX_SERIAL_H
=20
 #include "hw/sysbus.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
=20
 #define TYPE_IMX_SERIAL "imx.serial"
 #define IMX_SERIAL(obj) OBJECT_CHECK(IMXSerialState, (obj), TYPE_IMX_SER=
IAL)
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 01dcd2a8d2..c4daf11a14 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -28,7 +28,7 @@
=20
 #include "hw/hw.h"
 #include "sysemu/sysemu.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "exec/memory.h"
 #include "qemu/fifo8.h"
 #include "chardev/char.h"
diff --git a/include/hw/char/stm32f2xx_usart.h b/include/hw/char/stm32f2x=
x_usart.h
index 4259dbeb1e..9d03a7527c 100644
--- a/include/hw/char/stm32f2xx_usart.h
+++ b/include/hw/char/stm32f2xx_usart.h
@@ -26,7 +26,7 @@
 #define HW_STM32F2XX_USART_H
=20
 #include "hw/sysbus.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "hw/hw.h"
=20
 #define USART_SR   0x00
diff --git a/backends/rng-egd.c b/backends/rng-egd.c
index 5448f6e5f5..ad3e1e5edf 100644
--- a/backends/rng-egd.c
+++ b/backends/rng-egd.c
@@ -12,7 +12,7 @@
=20
 #include "qemu/osdep.h"
 #include "sysemu/rng.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
=20
diff --git a/backends/wctablet.c b/backends/wctablet.c
index a4d3ae098a..6c13c2c58a 100644
--- a/backends/wctablet.c
+++ b/backends/wctablet.c
@@ -32,7 +32,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "sysemu/char.h"
+#include "chardev/char-serial.h"
 #include "ui/console.h"
 #include "ui/input.h"
 #include "trace.h"
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
new file mode 100644
index 0000000000..ba19e168ce
--- /dev/null
+++ b/chardev/char-fe.c
@@ -0,0 +1,358 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qapi-visit.h"
+#include "sysemu/replay.h"
+
+#include "chardev/char-fe.h"
+#include "chardev/char-io.h"
+#include "chardev/char-mux.h"
+
+int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
+{
+    Chardev *s =3D be->chr;
+
+    if (!s) {
+        return 0;
+    }
+
+    return qemu_chr_write(s, buf, len, false);
+}
+
+int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len)
+{
+    Chardev *s =3D be->chr;
+
+    if (!s) {
+        return 0;
+    }
+
+    return qemu_chr_write(s, buf, len, true);
+}
+
+int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
+{
+    Chardev *s =3D be->chr;
+    int offset =3D 0, counter =3D 10;
+    int res;
+
+    if (!s || !CHARDEV_GET_CLASS(s)->chr_sync_read) {
+        return 0;
+    }
+
+    if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_PLAY) {
+        return replay_char_read_all_load(buf);
+    }
+
+    while (offset < len) {
+    retry:
+        res =3D CHARDEV_GET_CLASS(s)->chr_sync_read(s, buf + offset,
+                                                  len - offset);
+        if (res =3D=3D -1 && errno =3D=3D EAGAIN) {
+            g_usleep(100);
+            goto retry;
+        }
+
+        if (res =3D=3D 0) {
+            break;
+        }
+
+        if (res < 0) {
+            if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_REC=
ORD) {
+                replay_char_read_all_save_error(res);
+            }
+            return res;
+        }
+
+        offset +=3D res;
+
+        if (!counter--) {
+            break;
+        }
+    }
+
+    if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_RECORD) {
+        replay_char_read_all_save_buf(buf, offset);
+    }
+    return offset;
+}
+
+int qemu_chr_fe_ioctl(CharBackend *be, int cmd, void *arg)
+{
+    Chardev *s =3D be->chr;
+    int res;
+
+    if (!s || !CHARDEV_GET_CLASS(s)->chr_ioctl || qemu_chr_replay(s)) {
+        res =3D -ENOTSUP;
+    } else {
+        res =3D CHARDEV_GET_CLASS(s)->chr_ioctl(s, cmd, arg);
+    }
+
+    return res;
+}
+
+int qemu_chr_fe_get_msgfd(CharBackend *be)
+{
+    Chardev *s =3D be->chr;
+    int fd;
+    int res =3D (qemu_chr_fe_get_msgfds(be, &fd, 1) =3D=3D 1) ? fd : -1;
+    if (s && qemu_chr_replay(s)) {
+        error_report("Replay: get msgfd is not supported "
+                     "for serial devices yet");
+        exit(1);
+    }
+    return res;
+}
+
+int qemu_chr_fe_get_msgfds(CharBackend *be, int *fds, int len)
+{
+    Chardev *s =3D be->chr;
+
+    if (!s) {
+        return -1;
+    }
+
+    return CHARDEV_GET_CLASS(s)->get_msgfds ?
+        CHARDEV_GET_CLASS(s)->get_msgfds(s, fds, len) : -1;
+}
+
+int qemu_chr_fe_set_msgfds(CharBackend *be, int *fds, int num)
+{
+    Chardev *s =3D be->chr;
+
+    if (!s) {
+        return -1;
+    }
+
+    return CHARDEV_GET_CLASS(s)->set_msgfds ?
+        CHARDEV_GET_CLASS(s)->set_msgfds(s, fds, num) : -1;
+}
+
+void qemu_chr_fe_accept_input(CharBackend *be)
+{
+    Chardev *s =3D be->chr;
+
+    if (!s) {
+        return;
+    }
+
+    if (CHARDEV_GET_CLASS(s)->chr_accept_input) {
+        CHARDEV_GET_CLASS(s)->chr_accept_input(s);
+    }
+    qemu_notify_event();
+}
+
+void qemu_chr_fe_printf(CharBackend *be, const char *fmt, ...)
+{
+    char buf[CHR_READ_BUF_LEN];
+    va_list ap;
+    va_start(ap, fmt);
+    vsnprintf(buf, sizeof(buf), fmt, ap);
+    /* XXX this blocks entire thread. Rewrite to use
+     * qemu_chr_fe_write and background I/O callbacks */
+    qemu_chr_fe_write_all(be, (uint8_t *)buf, strlen(buf));
+    va_end(ap);
+}
+
+Chardev *qemu_chr_fe_get_driver(CharBackend *be)
+{
+    return be->chr;
+}
+
+bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
+{
+    int tag =3D 0;
+
+    if (CHARDEV_IS_MUX(s)) {
+        MuxChardev *d =3D MUX_CHARDEV(s);
+
+        if (d->mux_cnt >=3D MAX_MUX) {
+            goto unavailable;
+        }
+
+        d->backends[d->mux_cnt] =3D b;
+        tag =3D d->mux_cnt++;
+    } else if (s->be) {
+        goto unavailable;
+    } else {
+        s->be =3D b;
+    }
+
+    b->fe_open =3D false;
+    b->tag =3D tag;
+    b->chr =3D s;
+    return true;
+
+unavailable:
+    error_setg(errp, QERR_DEVICE_IN_USE, s->label);
+    return false;
+}
+
+void qemu_chr_fe_deinit(CharBackend *b)
+{
+    assert(b);
+
+    if (b->chr) {
+        qemu_chr_fe_set_handlers(b, NULL, NULL, NULL, NULL, NULL, true);
+        if (b->chr->be =3D=3D b) {
+            b->chr->be =3D NULL;
+        }
+        if (CHARDEV_IS_MUX(b->chr)) {
+            MuxChardev *d =3D MUX_CHARDEV(b->chr);
+            d->backends[b->tag] =3D NULL;
+        }
+        b->chr =3D NULL;
+    }
+}
+
+void qemu_chr_fe_set_handlers(CharBackend *b,
+                              IOCanReadHandler *fd_can_read,
+                              IOReadHandler *fd_read,
+                              IOEventHandler *fd_event,
+                              void *opaque,
+                              GMainContext *context,
+                              bool set_open)
+{
+    Chardev *s;
+    ChardevClass *cc;
+    int fe_open;
+
+    s =3D b->chr;
+    if (!s) {
+        return;
+    }
+
+    cc =3D CHARDEV_GET_CLASS(s);
+    if (!opaque && !fd_can_read && !fd_read && !fd_event) {
+        fe_open =3D 0;
+        remove_fd_in_watch(s, context);
+    } else {
+        fe_open =3D 1;
+    }
+    b->chr_can_read =3D fd_can_read;
+    b->chr_read =3D fd_read;
+    b->chr_event =3D fd_event;
+    b->opaque =3D opaque;
+    if (cc->chr_update_read_handler) {
+        cc->chr_update_read_handler(s, context);
+    }
+
+    if (set_open) {
+        qemu_chr_fe_set_open(b, fe_open);
+    }
+
+    if (fe_open) {
+        qemu_chr_fe_take_focus(b);
+        /* We're connecting to an already opened device, so let's make s=
ure we
+           also get the open event */
+        if (s->be_open) {
+            qemu_chr_be_event(s, CHR_EVENT_OPENED);
+        }
+    }
+
+    if (CHARDEV_IS_MUX(s)) {
+        mux_chr_set_handlers(s, context);
+    }
+}
+
+void qemu_chr_fe_take_focus(CharBackend *b)
+{
+    if (!b->chr) {
+        return;
+    }
+
+    if (CHARDEV_IS_MUX(b->chr)) {
+        mux_set_focus(b->chr, b->tag);
+    }
+}
+
+int qemu_chr_fe_wait_connected(CharBackend *be, Error **errp)
+{
+    if (!be->chr) {
+        error_setg(errp, "missing associated backend");
+        return -1;
+    }
+
+    return qemu_chr_wait_connected(be->chr, errp);
+}
+
+void qemu_chr_fe_set_echo(CharBackend *be, bool echo)
+{
+    Chardev *chr =3D be->chr;
+
+    if (chr && CHARDEV_GET_CLASS(chr)->chr_set_echo) {
+        CHARDEV_GET_CLASS(chr)->chr_set_echo(chr, echo);
+    }
+}
+
+void qemu_chr_fe_set_open(CharBackend *be, int fe_open)
+{
+    Chardev *chr =3D be->chr;
+
+    if (!chr) {
+        return;
+    }
+
+    if (be->fe_open =3D=3D fe_open) {
+        return;
+    }
+    be->fe_open =3D fe_open;
+    if (CHARDEV_GET_CLASS(chr)->chr_set_fe_open) {
+        CHARDEV_GET_CLASS(chr)->chr_set_fe_open(chr, fe_open);
+    }
+}
+
+guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
+                            GIOFunc func, void *user_data)
+{
+    Chardev *s =3D be->chr;
+    GSource *src;
+    guint tag;
+
+    if (!s || CHARDEV_GET_CLASS(s)->chr_add_watch =3D=3D NULL) {
+        return 0;
+    }
+
+    src =3D CHARDEV_GET_CLASS(s)->chr_add_watch(s, cond);
+    if (!src) {
+        return 0;
+    }
+
+    g_source_set_callback(src, (GSourceFunc)func, user_data, NULL);
+    tag =3D g_source_attach(src, NULL);
+    g_source_unref(src);
+
+    return tag;
+}
+
+void qemu_chr_fe_disconnect(CharBackend *be)
+{
+    Chardev *chr =3D be->chr;
+
+    if (chr && CHARDEV_GET_CLASS(chr)->chr_disconnect) {
+        CHARDEV_GET_CLASS(chr)->chr_disconnect(chr);
+    }
+}
diff --git a/chardev/char.c b/chardev/char.c
index 392dba6a86..b986ce1857 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -22,7 +22,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "monitor/monitor.h"
 #include "sysemu/sysemu.h"
@@ -35,9 +34,6 @@
 #include "qemu/help_option.h"
=20
 #include "chardev/char-mux.h"
-#include "chardev/char-io.h"
-#include "chardev/char-parallel.h"
-#include "chardev/char-serial.h"
=20
 /***********************************************************/
 /* character device */
@@ -129,12 +125,7 @@ static int qemu_chr_fe_write_buffer(Chardev *s,
     return res;
 }
=20
-static bool qemu_chr_replay(Chardev *chr)
-{
-    return qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
-}
-
-static int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool =
all)
+int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool all)
 {
     int offset =3D 0;
     int res;
@@ -158,94 +149,6 @@ static int qemu_chr_write(Chardev *s, const uint8_t =
*buf, int len, bool all)
     return offset;
 }
=20
-int qemu_chr_write_all(Chardev *s, const uint8_t *buf, int len)
-{
-    return qemu_chr_write(s, buf, len, true);
-}
-
-int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
-{
-    Chardev *s =3D be->chr;
-
-    if (!s) {
-        return 0;
-    }
-
-    return qemu_chr_write(s, buf, len, false);
-}
-
-int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len)
-{
-    Chardev *s =3D be->chr;
-
-    if (!s) {
-        return 0;
-    }
-
-    return qemu_chr_write(s, buf, len, true);
-}
-
-int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
-{
-    Chardev *s =3D be->chr;
-    int offset =3D 0, counter =3D 10;
-    int res;
-
-    if (!s || !CHARDEV_GET_CLASS(s)->chr_sync_read) {
-        return 0;
-    }
-
-    if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_PLAY) {
-        return replay_char_read_all_load(buf);
-    }
-
-    while (offset < len) {
-    retry:
-        res =3D CHARDEV_GET_CLASS(s)->chr_sync_read(s, buf + offset,
-                                                  len - offset);
-        if (res =3D=3D -1 && errno =3D=3D EAGAIN) {
-            g_usleep(100);
-            goto retry;
-        }
-
-        if (res =3D=3D 0) {
-            break;
-        }
-
-        if (res < 0) {
-            if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_REC=
ORD) {
-                replay_char_read_all_save_error(res);
-            }
-            return res;
-        }
-
-        offset +=3D res;
-
-        if (!counter--) {
-            break;
-        }
-    }
-
-    if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_RECORD) {
-        replay_char_read_all_save_buf(buf, offset);
-    }
-    return offset;
-}
-
-int qemu_chr_fe_ioctl(CharBackend *be, int cmd, void *arg)
-{
-    Chardev *s =3D be->chr;
-    int res;
-
-    if (!s || !CHARDEV_GET_CLASS(s)->chr_ioctl || qemu_chr_replay(s)) {
-        res =3D -ENOTSUP;
-    } else {
-        res =3D CHARDEV_GET_CLASS(s)->chr_ioctl(s, cmd, arg);
-    }
-
-    return res;
-}
-
 int qemu_chr_be_can_write(Chardev *s)
 {
     CharBackend *be =3D s->be;
@@ -278,75 +181,12 @@ void qemu_chr_be_write(Chardev *s, uint8_t *buf, in=
t len)
     }
 }
=20
-int qemu_chr_fe_get_msgfd(CharBackend *be)
-{
-    Chardev *s =3D be->chr;
-    int fd;
-    int res =3D (qemu_chr_fe_get_msgfds(be, &fd, 1) =3D=3D 1) ? fd : -1;
-    if (s && qemu_chr_replay(s)) {
-        error_report("Replay: get msgfd is not supported "
-                     "for serial devices yet");
-        exit(1);
-    }
-    return res;
-}
-
-int qemu_chr_fe_get_msgfds(CharBackend *be, int *fds, int len)
-{
-    Chardev *s =3D be->chr;
-
-    if (!s) {
-        return -1;
-    }
-
-    return CHARDEV_GET_CLASS(s)->get_msgfds ?
-        CHARDEV_GET_CLASS(s)->get_msgfds(s, fds, len) : -1;
-}
-
-int qemu_chr_fe_set_msgfds(CharBackend *be, int *fds, int num)
-{
-    Chardev *s =3D be->chr;
-
-    if (!s) {
-        return -1;
-    }
-
-    return CHARDEV_GET_CLASS(s)->set_msgfds ?
-        CHARDEV_GET_CLASS(s)->set_msgfds(s, fds, num) : -1;
-}
-
 int qemu_chr_add_client(Chardev *s, int fd)
 {
     return CHARDEV_GET_CLASS(s)->chr_add_client ?
         CHARDEV_GET_CLASS(s)->chr_add_client(s, fd) : -1;
 }
=20
-void qemu_chr_fe_accept_input(CharBackend *be)
-{
-    Chardev *s =3D be->chr;
-
-    if (!s) {
-        return;
-    }
-
-    if (CHARDEV_GET_CLASS(s)->chr_accept_input) {
-        CHARDEV_GET_CLASS(s)->chr_accept_input(s);
-    }
-    qemu_notify_event();
-}
-
-void qemu_chr_fe_printf(CharBackend *be, const char *fmt, ...)
-{
-    char buf[CHR_READ_BUF_LEN];
-    va_list ap;
-    va_start(ap, fmt);
-    vsnprintf(buf, sizeof(buf), fmt, ap);
-    /* XXX this blocks entire thread. Rewrite to use
-     * qemu_chr_fe_write and background I/O callbacks */
-    qemu_chr_fe_write_all(be, (uint8_t *)buf, strlen(buf));
-    va_end(ap);
-}
-
 static void qemu_char_open(Chardev *chr, ChardevBackend *backend,
                            bool *be_opened, Error **errp)
 {
@@ -458,40 +298,6 @@ static Notifier muxes_realize_notify =3D {
     .notify =3D muxes_realize_done,
 };
=20
-Chardev *qemu_chr_fe_get_driver(CharBackend *be)
-{
-    return be->chr;
-}
-
-bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
-{
-    int tag =3D 0;
-
-    if (CHARDEV_IS_MUX(s)) {
-        MuxChardev *d =3D MUX_CHARDEV(s);
-
-        if (d->mux_cnt >=3D MAX_MUX) {
-            goto unavailable;
-        }
-
-        d->backends[d->mux_cnt] =3D b;
-        tag =3D d->mux_cnt++;
-    } else if (s->be) {
-        goto unavailable;
-    } else {
-        s->be =3D b;
-    }
-
-    b->fe_open =3D false;
-    b->tag =3D tag;
-    b->chr =3D s;
-    return true;
-
-unavailable:
-    error_setg(errp, QERR_DEVICE_IN_USE, s->label);
-    return false;
-}
-
 static bool qemu_chr_is_busy(Chardev *s)
 {
     if (CHARDEV_IS_MUX(s)) {
@@ -502,84 +308,6 @@ static bool qemu_chr_is_busy(Chardev *s)
     }
 }
=20
-void qemu_chr_fe_deinit(CharBackend *b)
-{
-    assert(b);
-
-    if (b->chr) {
-        qemu_chr_fe_set_handlers(b, NULL, NULL, NULL, NULL, NULL, true);
-        if (b->chr->be =3D=3D b) {
-            b->chr->be =3D NULL;
-        }
-        if (CHARDEV_IS_MUX(b->chr)) {
-            MuxChardev *d =3D MUX_CHARDEV(b->chr);
-            d->backends[b->tag] =3D NULL;
-        }
-        b->chr =3D NULL;
-    }
-}
-
-void qemu_chr_fe_set_handlers(CharBackend *b,
-                              IOCanReadHandler *fd_can_read,
-                              IOReadHandler *fd_read,
-                              IOEventHandler *fd_event,
-                              void *opaque,
-                              GMainContext *context,
-                              bool set_open)
-{
-    Chardev *s;
-    ChardevClass *cc;
-    int fe_open;
-
-    s =3D b->chr;
-    if (!s) {
-        return;
-    }
-
-    cc =3D CHARDEV_GET_CLASS(s);
-    if (!opaque && !fd_can_read && !fd_read && !fd_event) {
-        fe_open =3D 0;
-        remove_fd_in_watch(s, context);
-    } else {
-        fe_open =3D 1;
-    }
-    b->chr_can_read =3D fd_can_read;
-    b->chr_read =3D fd_read;
-    b->chr_event =3D fd_event;
-    b->opaque =3D opaque;
-    if (cc->chr_update_read_handler) {
-        cc->chr_update_read_handler(s, context);
-    }
-
-    if (set_open) {
-        qemu_chr_fe_set_open(b, fe_open);
-    }
-
-    if (fe_open) {
-        qemu_chr_fe_take_focus(b);
-        /* We're connecting to an already opened device, so let's make s=
ure we
-           also get the open event */
-        if (s->be_open) {
-            qemu_chr_be_event(s, CHR_EVENT_OPENED);
-        }
-    }
-
-    if (CHARDEV_IS_MUX(s)) {
-        mux_chr_set_handlers(s, context);
-    }
-}
-
-void qemu_chr_fe_take_focus(CharBackend *b)
-{
-    if (!b->chr) {
-        return;
-    }
-
-    if (CHARDEV_IS_MUX(b->chr)) {
-        mux_set_focus(b->chr, b->tag);
-    }
-}
-
 int qemu_chr_wait_connected(Chardev *chr, Error **errp)
 {
     ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
@@ -591,16 +319,6 @@ int qemu_chr_wait_connected(Chardev *chr, Error **er=
rp)
     return 0;
 }
=20
-int qemu_chr_fe_wait_connected(CharBackend *be, Error **errp)
-{
-    if (!be->chr) {
-        error_setg(errp, "missing associated backend");
-        return -1;
-    }
-
-    return qemu_chr_wait_connected(be->chr, errp);
-}
-
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename)
 {
     char host[65], port[33], width[8], height[8];
@@ -977,64 +695,6 @@ Chardev *qemu_chr_new(const char *label, const char =
*filename)
     return chr;
 }
=20
-void qemu_chr_fe_set_echo(CharBackend *be, bool echo)
-{
-    Chardev *chr =3D be->chr;
-
-    if (chr && CHARDEV_GET_CLASS(chr)->chr_set_echo) {
-        CHARDEV_GET_CLASS(chr)->chr_set_echo(chr, echo);
-    }
-}
-
-void qemu_chr_fe_set_open(CharBackend *be, int fe_open)
-{
-    Chardev *chr =3D be->chr;
-
-    if (!chr) {
-        return;
-    }
-
-    if (be->fe_open =3D=3D fe_open) {
-        return;
-    }
-    be->fe_open =3D fe_open;
-    if (CHARDEV_GET_CLASS(chr)->chr_set_fe_open) {
-        CHARDEV_GET_CLASS(chr)->chr_set_fe_open(chr, fe_open);
-    }
-}
-
-guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
-                            GIOFunc func, void *user_data)
-{
-    Chardev *s =3D be->chr;
-    GSource *src;
-    guint tag;
-
-    if (!s || CHARDEV_GET_CLASS(s)->chr_add_watch =3D=3D NULL) {
-        return 0;
-    }
-
-    src =3D CHARDEV_GET_CLASS(s)->chr_add_watch(s, cond);
-    if (!src) {
-        return 0;
-    }
-
-    g_source_set_callback(src, (GSourceFunc)func, user_data, NULL);
-    tag =3D g_source_attach(src, NULL);
-    g_source_unref(src);
-
-    return tag;
-}
-
-void qemu_chr_fe_disconnect(CharBackend *be)
-{
-    Chardev *chr =3D be->chr;
-
-    if (chr && CHARDEV_GET_CLASS(chr)->chr_disconnect) {
-        CHARDEV_GET_CLASS(chr)->chr_disconnect(chr);
-    }
-}
-
 static int qmp_query_chardev_foreach(Object *obj, void *data)
 {
     Chardev *chr =3D CHARDEV(obj);
diff --git a/gdbstub.c b/gdbstub.c
index e53661ec41..98854c33e7 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -26,6 +26,7 @@
 #else
 #include "monitor/monitor.h"
 #include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "sysemu/sysemu.h"
 #include "exec/gdbstub.h"
 #endif
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index 566749a9eb..4b4c024693 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -30,7 +30,7 @@
 #include "hw/arm/omap.h"
 #include "sysemu/sysemu.h"
 #include "qemu/timer.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "hw/block/flash.h"
 #include "hw/arm/soc_dma.h"
 #include "hw/sysbus.h"
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 0d43cc707c..629e6c64e6 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -17,7 +17,7 @@
 #include "hw/char/serial.h"
 #include "hw/i2c/i2c.h"
 #include "hw/ssi/ssi.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "qemu/cutils.h"
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 967caea749..7683edc9e5 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -34,6 +34,7 @@
 #include "strongarm.h"
 #include "qemu/error-report.h"
 #include "hw/arm/arm.h"
+#include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
 #include "sysemu/sysemu.h"
 #include "hw/ssi/ssi.h"
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 4bfc185376..4a2c124104 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -23,6 +23,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
index 77d91c8558..762e3d8ada 100644
--- a/hw/char/debugcon.c
+++ b/hw/char/debugcon.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "hw/isa/isa.h"
 #include "hw/i386/pc.h"
=20
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index 4f1dec7f1d..34306e11ff 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -29,7 +29,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "qemu/log.h"
=20
 #include "hw/char/digic-uart.h"
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 81d792cb47..3f787632c7 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -26,6 +26,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/char/escc.h"
+#include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
 #include "ui/console.h"
 #include "ui/input.h"
diff --git a/hw/char/etraxfs_ser.c b/hw/char/etraxfs_ser.c
index 33e3e16397..c1fba9f50f 100644
--- a/hw/char/etraxfs_ser.c
+++ b/hw/char/etraxfs_ser.c
@@ -24,7 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "qemu/log.h"
=20
 #define D(x)
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index d93125645a..b51d44a321 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -23,6 +23,7 @@
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
+#include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
=20
 #include "hw/arm/exynos4210.h"
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index 39d1133c61..32d98edf49 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -24,7 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
=20
 #include "trace.h"
=20
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index b8a3c92c9e..337a3e566a 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/ipack/ipack.h"
 #include "qemu/bitops.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
=20
 /* #define DEBUG_IPOCTAL */
=20
diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c
index 6b0633e518..3948dcd332 100644
--- a/hw/char/lm32_juart.c
+++ b/hw/char/lm32_juart.c
@@ -21,7 +21,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "trace.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
=20
 #include "hw/char/lm32_juart.h"
=20
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
index a7610c28ce..cff8c38f90 100644
--- a/hw/char/lm32_uart.c
+++ b/hw/char/lm32_uart.c
@@ -26,7 +26,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "trace.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "qemu/error-report.h"
=20
 enum {
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index b639b53c83..fe12ad5ccb 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -9,7 +9,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/m68k/mcf.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "exec/address-spaces.h"
 #include "qapi/error.h"
=20
diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
index 5ef847c5eb..e19d0f6520 100644
--- a/hw/char/milkymist-uart.c
+++ b/hw/char/milkymist-uart.c
@@ -25,7 +25,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "trace.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "qemu/error-report.h"
=20
 enum {
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 1d6c6e9f33..75a1a2f55e 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "chardev/char-parallel.h"
+#include "chardev/char-fe.h"
 #include "hw/isa/isa.h"
 #include "hw/i386/pc.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 1757035bb3..33802f00c8 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -9,7 +9,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "qemu/log.h"
 #include "trace.h"
=20
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index 755d514188..1b15046690 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -17,7 +17,7 @@
 #include "hw/qdev.h"
 #include "qemu/thread.h"
 #include "qemu/error-report.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
=20
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/event-facility.h"
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index 0fd3cb4887..4a107a268d 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -19,7 +19,7 @@
=20
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/event-facility.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
=20
 typedef struct ASCIIConsoleData {
     EventBufferHeader ebh;
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 80c7696d8d..ca9816d045 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sh4/sh.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "exec/address-spaces.h"
 #include "qapi/error.h"
=20
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 2317e45404..8f02f3a612 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -4,7 +4,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/qdev.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
=20
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 8418db6a07..0cb1668c8a 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -11,7 +11,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "hw/virtio/virtio-serial.h"
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index 1cdbe59f8a..cb849c2e3e 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -25,7 +25,7 @@
=20
 #include "qapi/error.h"
 #include "hw/hw.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "hw/xen/xen_backend.h"
 #include "qapi/error.h"
=20
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index bcebdae3da..71ed2fc1be 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -24,7 +24,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
=20
 #define DUART(x)
=20
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-s=
ystem.c
index 4da0c6a24e..a549d39030 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -20,7 +20,7 @@
 #include "hw/block/block.h"
 #include "net/hub.h"
 #include "qapi/visitor.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "sysemu/iothread.h"
=20
 static void get_pointer(Object *obj, Visitor *v, Property *prop,
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index 35285383fd..329b03e17f 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -30,7 +30,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "sysemu/sysemu.h"
 #include "hw/ipmi/ipmi.h"
=20
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index a45bb7943d..e904e646ba 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -29,7 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/event_notifier.h"
 #include "qom/object_interfaces.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/qtest.h"
 #include "qapi/visitor.h"
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index c2096b25ab..fed3683a50 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -9,7 +9,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
 #include "ccid.h"
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 4f592d0f82..fa123eea37 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -16,6 +16,7 @@
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
 #include "chardev/char-serial.h"
+#include "chardev/char-fe.h"
=20
 //#define DEBUG_Serial
=20
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 48468fc61a..865aa9fbe0 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -33,7 +33,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
=20
 #include <usbredirparser.h>
 #include <usbredirfilter.h>
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 07b97205fa..0b6025e9c7 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -13,7 +13,7 @@
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-backend.h"
 #include "hw/virtio/virtio-net.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "sysemu/kvm.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
diff --git a/monitor.c b/monitor.c
index 1b041e0514..032e97485b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -35,7 +35,7 @@
 #include "exec/gdbstub.h"
 #include "net/net.h"
 #include "net/slirp.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "ui/qemu-spice.h"
 #include "sysemu/numa.h"
 #include "monitor/monitor.h"
diff --git a/net/colo-compare.c b/net/colo-compare.c
index d2cdcdfd78..db18e8ec7e 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -25,7 +25,7 @@
 #include "qom/object.h"
 #include "qemu/typedefs.h"
 #include "net/queue.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "qemu/sockets.h"
 #include "qapi-visit.h"
 #include "net/colo.h"
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 03a380b4db..33818955e2 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -20,7 +20,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
 #include "trace.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
=20
diff --git a/net/slirp.c b/net/slirp.c
index af3e8b22ac..6a6d727999 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -37,7 +37,7 @@
 #include "qemu/sockets.h"
 #include "slirp/libslirp.h"
 #include "slirp/ip6.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 77d2ce22a6..526290d8c1 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -12,7 +12,7 @@
 #include "clients.h"
 #include "net/vhost_net.h"
 #include "net/vhost-user.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qmp-commands.h"
diff --git a/qtest.c b/qtest.c
index dbf70a7018..9a5d1dc50d 100644
--- a/qtest.c
+++ b/qtest.c
@@ -17,7 +17,7 @@
 #include "cpu.h"
 #include "sysemu/qtest.h"
 #include "hw/qdev.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "exec/ioport.h"
 #include "exec/memory.h"
 #include "hw/irq.h"
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 3b92cb54ce..e79345bdfc 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -25,7 +25,7 @@
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "slirp.h"
 #include "hw/hw.h"
 #include "qemu/cutils.h"
diff --git a/tests/test-char.c b/tests/test-char.c
index a6ab17c100..42844993a3 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -4,7 +4,7 @@
 #include "qemu-common.h"
 #include "qemu/config-file.h"
 #include "qemu/sockets.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qom/qom-qobject.h"
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index acc392d046..4ca11ae28d 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -16,7 +16,7 @@
 #include "qemu/option.h"
 #include "qemu/range.h"
 #include "qemu/sockets.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "sysemu/sysemu.h"
 #include "libqos/libqos.h"
 #include "libqos/pci-pc.h"
diff --git a/ui/console.c b/ui/console.c
index 6cf795a23d..d914cced53 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -27,7 +27,7 @@
 #include "hw/qdev-core.h"
 #include "qemu/timer.h"
 #include "qmp-commands.h"
-#include "chardev/char.h"
+#include "chardev/char-fe.h"
 #include "trace.h"
 #include "exec/memory.h"
=20
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index 1feda0f0ed..e0b37dbfd8 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -1,6 +1,7 @@
 chardev-obj-y +=3D char.o
 chardev-obj-$(CONFIG_WIN32) +=3D char-console.o
 chardev-obj-$(CONFIG_POSIX) +=3D char-fd.o
+chardev-obj-y +=3D char-fe.o
 chardev-obj-y +=3D char-file.o
 chardev-obj-y +=3D char-io.o
 chardev-obj-y +=3D char-mux.o
--=20
2.13.0.rc1.16.gd80b50c3f

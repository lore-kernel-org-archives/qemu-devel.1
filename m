Received: from eggs.gnu.org ([2001:4830:134:3::10]:38270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCD9-000514-DB
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYCD7-0006sB-Sr
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:41:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYCD7-0006rw-Jr
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:41:33 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9A85C04B92E
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 13:41:33 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Jan 2017 17:39:31 +0400
Message-Id: <20170130133954.31353-19-marcandre.lureau@redhat.com>
In-Reply-To: <20170130133954.31353-1-marcandre.lureau@redhat.com>
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 18/41] char: rename remaining CharDriver to
 Chardev
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

CharDriver no longer exists, it has been replaced with Chardev.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/sysemu/char.h | 40 ++++++++++++++++++++--------------------
 qemu-char.c           | 11 +++++------
 2 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 2a3b887b8a..b4303e7b22 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -74,7 +74,7 @@ typedef enum {
     QEMU_CHAR_FEATURE_REPLAY,
=20
     QEMU_CHAR_FEATURE_LAST,
-} CharDriverFeature;
+} ChardevFeature;
=20
 /* This is the backend as seen by frontend, the actual backend is
  * Chardev */
@@ -141,7 +141,7 @@ Chardev *qemu_chr_new(const char *label, const char *=
filename);
  * @qemu_chr_fe_disconnect:
  *
  * Close a fd accpeted by character backend.
- * Without associated CharDriver, do nothing.
+ * Without associated Chardev, do nothing.
  */
 void qemu_chr_fe_disconnect(CharBackend *be);
=20
@@ -156,7 +156,7 @@ void qemu_chr_cleanup(void);
  * @qemu_chr_fe_wait_connected:
  *
  * Wait for characted backend to be connected, return < 0 on error or
- * if no assicated CharDriver.
+ * if no assicated Chardev.
  */
 int qemu_chr_fe_wait_connected(CharBackend *be, Error **errp);
=20
@@ -188,7 +188,7 @@ void qemu_chr_delete(Chardev *chr);
  * Ask the backend to override its normal echo setting.  This only reall=
y
  * applies to the stdio backend and is used by the QMP server such that =
you
  * can see what you type if you try to type QMP commands.
- * Without associated CharDriver, do nothing.
+ * Without associated Chardev, do nothing.
  *
  * @echo true to enable echo, false to disable echo
  */
@@ -199,7 +199,7 @@ void qemu_chr_fe_set_echo(CharBackend *be, bool echo)=
;
  *
  * Set character frontend open status.  This is an indication that the
  * front end is ready (or not) to begin doing I/O.
- * Without associated CharDriver, do nothing.
+ * Without associated Chardev, do nothing.
  */
 void qemu_chr_fe_set_open(CharBackend *be, int fe_open);
=20
@@ -208,7 +208,7 @@ void qemu_chr_fe_set_open(CharBackend *be, int fe_ope=
n);
  *
  * Write to a character backend using a printf style interface.  This
  * function is thread-safe. It does nothing without associated
- * CharDriver.
+ * Chardev.
  *
  * @fmt see #printf
  */
@@ -221,7 +221,7 @@ void qemu_chr_fe_printf(CharBackend *be, const char *=
fmt, ...)
  * If the backend is connected, create and add a #GSource that fires
  * when the given condition (typically G_IO_OUT|G_IO_HUP or G_IO_HUP)
  * is active; return the #GSource's tag.  If it is disconnected,
- * or without associated CharDriver, return 0.
+ * or without associated Chardev, return 0.
  *
  * @cond the condition to poll for
  * @func the function to call when the condition happens
@@ -242,7 +242,7 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondi=
tion cond,
  * @buf the data
  * @len the number of bytes to send
  *
- * Returns: the number of bytes consumed (0 if no assicated CharDriver)
+ * Returns: the number of bytes consumed (0 if no assicated Chardev)
  */
 int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len);
=20
@@ -257,7 +257,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t =
*buf, int len);
  * @buf the data
  * @len the number of bytes to send
  *
- * Returns: the number of bytes consumed (0 if no assicated CharDriver)
+ * Returns: the number of bytes consumed (0 if no assicated Chardev)
  */
 int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len);
=20
@@ -269,7 +269,7 @@ int qemu_chr_fe_write_all(CharBackend *be, const uint=
8_t *buf, int len);
  * @buf the data buffer
  * @len the number of bytes to read
  *
- * Returns: the number of bytes read (0 if no assicated CharDriver)
+ * Returns: the number of bytes read (0 if no assicated Chardev)
  */
 int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len);
=20
@@ -282,7 +282,7 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *bu=
f, int len);
  * @arg the data associated with @cmd
  *
  * Returns: if @cmd is not supported by the backend or there is no
- *          associated CharDriver, -ENOTSUP, otherwise the return
+ *          associated Chardev, -ENOTSUP, otherwise the return
  *          value depends on the semantics of @cmd
  */
 int qemu_chr_fe_ioctl(CharBackend *be, int cmd, void *arg);
@@ -322,7 +322,7 @@ int qemu_chr_fe_get_msgfds(CharBackend *be, int *fds,=
 int num);
  * result in overwriting the fd array with the new value without being s=
end.
  * Upon writing the message the fd array is freed.
  *
- * Returns: -1 if fd passing isn't supported or no associated CharDriver=
.
+ * Returns: -1 if fd passing isn't supported or no associated Chardev.
  */
 int qemu_chr_fe_set_msgfds(CharBackend *be, int *fds, int num);
=20
@@ -373,7 +373,7 @@ void qemu_chr_be_event(Chardev *s, int event);
  * @qemu_chr_fe_init:
  *
  * Initializes a front end for the given CharBackend and
- * CharDriver. Call qemu_chr_fe_deinit() to remove the association and
+ * Chardev. Call qemu_chr_fe_deinit() to remove the association and
  * release the driver.
  *
  * Returns: false on error.
@@ -384,16 +384,16 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, E=
rror **errp);
  * @qemu_chr_fe_get_driver:
  *
  * Returns the driver associated with a CharBackend or NULL if no
- * associated CharDriver.
+ * associated Chardev.
  */
 Chardev *qemu_chr_fe_get_driver(CharBackend *be);
=20
 /**
  * @qemu_chr_fe_deinit:
  *
- * Dissociate the CharBackend from the CharDriver.
+ * Dissociate the CharBackend from the Chardev.
  *
- * Safe to call without associated CharDriver.
+ * Safe to call without associated Chardev.
  */
 void qemu_chr_fe_deinit(CharBackend *b);
=20
@@ -412,7 +412,7 @@ void qemu_chr_fe_deinit(CharBackend *b);
  * Set the front end char handlers. The front end takes the focus if
  * any of the handler is non-NULL.
  *
- * Without associated CharDriver, nothing is changed.
+ * Without associated Chardev, nothing is changed.
  */
 void qemu_chr_fe_set_handlers(CharBackend *b,
                               IOCanReadHandler *fd_can_read,
@@ -427,7 +427,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
  *
  * Take the focus (if the front end is muxed).
  *
- * Without associated CharDriver, nothing is changed.
+ * Without associated Chardev, nothing is changed.
  */
 void qemu_chr_fe_take_focus(CharBackend *b);
=20
@@ -437,9 +437,9 @@ int qemu_chr_add_client(Chardev *s, int fd);
 Chardev *qemu_chr_find(const char *name);
=20
 bool qemu_chr_has_feature(Chardev *chr,
-                          CharDriverFeature feature);
+                          ChardevFeature feature);
 void qemu_chr_set_feature(Chardev *chr,
-                          CharDriverFeature feature);
+                          ChardevFeature feature);
 QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename)=
;
=20
 #define TYPE_CHARDEV "chardev"
diff --git a/qemu-char.c b/qemu-char.c
index 67e577d0b5..b68d4a9059 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -3171,13 +3171,13 @@ typedef struct {
     Chardev *chr;
     char buf[12];
     size_t buflen;
-} TCPCharDriverTelnetInit;
+} TCPChardevTelnetInit;
=20
 static gboolean tcp_chr_telnet_init_io(QIOChannel *ioc,
                                        GIOCondition cond G_GNUC_UNUSED,
                                        gpointer user_data)
 {
-    TCPCharDriverTelnetInit *init =3D user_data;
+    TCPChardevTelnetInit *init =3D user_data;
     ssize_t ret;
=20
     ret =3D qio_channel_write(ioc, init->buf, init->buflen, NULL);
@@ -3204,8 +3204,7 @@ static gboolean tcp_chr_telnet_init_io(QIOChannel *=
ioc,
 static void tcp_chr_telnet_init(Chardev *chr)
 {
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
-    TCPCharDriverTelnetInit *init =3D
-        g_new0(TCPCharDriverTelnetInit, 1);
+    TCPChardevTelnetInit *init =3D g_new0(TCPChardevTelnetInit, 1);
     size_t n =3D 0;
=20
     init->chr =3D chr;
@@ -4991,13 +4990,13 @@ static const TypeInfo char_udp_type_info =3D {
 };
=20
 bool qemu_chr_has_feature(Chardev *chr,
-                          CharDriverFeature feature)
+                          ChardevFeature feature)
 {
     return test_bit(feature, chr->features);
 }
=20
 void qemu_chr_set_feature(Chardev *chr,
-                           CharDriverFeature feature)
+                           ChardevFeature feature)
 {
     return set_bit(feature, chr->features);
 }
--=20
2.11.0.295.gd7dffce1c.dirty

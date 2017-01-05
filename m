Received: from eggs.gnu.org ([2001:4830:134:3::10]:53561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cPBIR-0007KH-VF
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cPBIR-0002kn-2L
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:53:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43299)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cPBIQ-0002kW-QP
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:53:46 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE94FC030706
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 16:53:46 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  5 Jan 2017 17:53:17 +0100
Message-Id: <20170105165329.17227-9-marcandre.lureau@redhat.com>
In-Reply-To: <20170105165329.17227-1-marcandre.lureau@redhat.com>
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/20] char: fold single-user functions in
 caller
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

This shortens the code a bit.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qemu-char.c | 95 +++++++++++++++++++------------------------------------=
------
 1 file changed, 29 insertions(+), 66 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 1cd0531152..3dd692a55f 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -1886,22 +1886,6 @@ static void qemu_chr_free_tty(CharDriverState *chr=
)
 {
     fd_chr_free(chr);
 }
-
-static CharDriverState *qemu_chr_open_tty_fd(const CharDriver *driver,
-                                             int fd,
-                                             ChardevCommon *backend,
-                                             bool *be_opened,
-                                             Error **errp)
-{
-    CharDriverState *chr;
-
-    tty_serial_init(fd, 115200, 'N', 8, 1);
-    chr =3D qemu_chr_open_fd(driver, fd, fd, backend, errp);
-    if (!chr) {
-        return NULL;
-    }
-    return chr;
-}
 #endif /* __linux__ || __sun__ */
=20
 #if defined(__linux__)
@@ -2322,29 +2306,6 @@ static int win_chr_poll(void *opaque)
     return 0;
 }
=20
-static CharDriverState *qemu_chr_open_win_path(const CharDriver *driver,
-                                               const char *filename,
-                                               ChardevCommon *backend,
-                                               Error **errp)
-{
-    CharDriverState *chr;
-    WinCharState *s;
-
-    chr =3D qemu_chr_alloc(driver, backend, errp);
-    if (!chr) {
-        return NULL;
-    }
-    s =3D g_new0(WinCharState, 1);
-    chr->opaque =3D s;
-
-    if (win_chr_init(chr, filename, errp) < 0) {
-        g_free(s);
-        qemu_chr_free_common(chr);
-        return NULL;
-    }
-    return chr;
-}
-
 static int win_chr_pipe_poll(void *opaque)
 {
     CharDriverState *chr =3D opaque;
@@ -2801,30 +2762,6 @@ static void udp_chr_free(CharDriverState *chr)
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
 }
=20
-static CharDriverState *qemu_chr_open_udp(const CharDriver *driver,
-                                          QIOChannelSocket *sioc,
-                                          ChardevCommon *backend,
-                                          bool *be_opened,
-                                          Error **errp)
-{
-    CharDriverState *chr =3D NULL;
-    NetCharDriver *s =3D NULL;
-
-    chr =3D qemu_chr_alloc(driver, backend, errp);
-    if (!chr) {
-        return NULL;
-    }
-    s =3D g_new0(NetCharDriver, 1);
-
-    s->ioc =3D QIO_CHANNEL(sioc);
-    s->bufcnt =3D 0;
-    s->bufptr =3D 0;
-    chr->opaque =3D s;
-    /* be isn't opened until we get a connection */
-    *be_opened =3D false;
-    return chr;
-}
-
 /***********************************************************/
 /* TCP Net console */
=20
@@ -4611,8 +4548,23 @@ static CharDriverState *qmp_chardev_open_serial(co=
nst CharDriver *driver,
 {
     ChardevHostdev *serial =3D backend->u.serial.data;
     ChardevCommon *common =3D qapi_ChardevHostdev_base(serial);
+    CharDriverState *chr;
+    WinCharState *s;
+
+    chr =3D qemu_chr_alloc(driver, common, errp);
+    if (!chr) {
+        return NULL;
+    }
=20
-    return qemu_chr_open_win_path(driver, serial->device, common, errp);
+    s =3D g_new0(WinCharState, 1);
+    chr->opaque =3D s;
+    if (win_chr_init(chr, serial->device, errp) < 0) {
+        g_free(s);
+        qemu_chr_free_common(chr);
+        return NULL;
+    }
+
+    return chr;
 }
=20
 #else /* WIN32 */
@@ -4681,8 +4633,9 @@ static CharDriverState *qmp_chardev_open_serial(con=
st CharDriver *driver,
         return NULL;
     }
     qemu_set_nonblock(fd);
+    tty_serial_init(fd, 115200, 'N', 8, 1);
=20
-    return qemu_chr_open_tty_fd(driver, fd, common, be_opened, errp);
+    return qemu_chr_open_fd(driver, fd, fd, common, errp);
 }
 #endif
=20
@@ -4938,6 +4891,7 @@ static CharDriverState *qmp_chardev_open_udp(const =
CharDriver *driver,
     QIOChannelSocket *sioc =3D qio_channel_socket_new();
     char *name;
     CharDriverState *chr;
+    NetCharDriver *s;
=20
     if (qio_channel_socket_dgram_sync(sioc,
                                       udp->local, udp->remote,
@@ -4946,12 +4900,21 @@ static CharDriverState *qmp_chardev_open_udp(cons=
t CharDriver *driver,
         return NULL;
     }
=20
-    chr =3D qemu_chr_open_udp(driver, sioc, common, be_opened, errp);
+    chr =3D qemu_chr_alloc(driver, common, errp);
+    if (!chr) {
+        return NULL;
+    }
=20
     name =3D g_strdup_printf("chardev-udp-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(sioc), name);
     g_free(name);
=20
+    s =3D g_new0(NetCharDriver, 1);
+    s->ioc =3D QIO_CHANNEL(sioc);
+    chr->opaque =3D s;
+    /* be isn't opened until we get a connection */
+    *be_opened =3D false;
+
     return chr;
 }
=20
--=20
2.11.0

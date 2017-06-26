Received: from eggs.gnu.org ([2001:4830:134:3::10]:55344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dPXA3-00024f-Mp
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dPXA0-0002tc-Uk
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:46:51 -0400
Received: from mail-eopbgr50109.outbound.protection.outlook.com
	([40.107.5.109]:28420
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dPXA0-0002sp-NS
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:46:48 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 26 Jun 2017 19:45:41 +0300
Message-ID: <1498495550-72357-5-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1498495550-72357-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1498495550-72357-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 04/13] char: forbid direct chardevice access
 for hotswap devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

qemu_chr_fe_get_driver() is unsafe, frontends with hotswap support
should not access CharDriver ptr directly as CharDriver might change.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/chardev/char-fe.h | 10 ++++++++++
 chardev/char-fe.c         |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 0314870..385aa99 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -63,10 +63,20 @@ bool qemu_chr_fe_connect(CharBackend *b, Chardev *s, Er=
ror **errp);
  *
  * Returns the driver associated with a CharBackend or NULL if no
  * associated Chardev.
+ * Note: avoid this function as the driver should never be accessed direct=
ly,
+ *       especially by the frontends that support chardevice hotswap.
+ *       Consider qemu_chr_fe_backend_connected() to check for driver exis=
tence
  */
 Chardev *qemu_chr_fe_get_driver(CharBackend *be);
=20
 /**
+ * @qemu_chr_fe_backend_connected:
+ *
+ * Returns true if there is a chardevice associated with @be.
+ */
+bool qemu_chr_fe_backend_connected(CharBackend *be);
+
+/**
  * @qemu_chr_fe_set_handlers:
  * @b: a CharBackend
  * @fd_can_read: callback to get the amount of data the frontend may
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 86a878b..be96fb5 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -183,9 +183,16 @@ void qemu_chr_fe_printf(CharBackend *be, const char *f=
mt, ...)
=20
 Chardev *qemu_chr_fe_get_driver(CharBackend *be)
 {
+    /* this is unsafe for the users that support chardev hotswap */
+    assert(be->chr_be_change =3D=3D NULL);
     return be->chr;
 }
=20
+bool qemu_chr_fe_backend_connected(CharBackend *be)
+{
+    return !!be->chr;
+}
+
 bool qemu_chr_fe_connect(CharBackend *b, Chardev *s, Error **errp)
 {
     int tag =3D 0;
--=20
2.7.4

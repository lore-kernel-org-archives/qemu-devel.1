Received: from eggs.gnu.org ([2001:4830:134:3::10]:60044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dFGKo-00080d-N6
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dFGKn-00010E-Qs
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:47:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dFGKn-000104-Jr
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:47:29 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 29 May 2017 12:45:44 +0400
Message-Id: <20170529084546.26500-13-marcandre.lureau@redhat.com>
In-Reply-To: <20170529084546.26500-1-marcandre.lureau@redhat.com>
References: <20170529084546.26500-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 12/14] char: rename functions that are not
 part of fe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, f4bug@amsat.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

There is no clear reason to have those functions associated with
frontend.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 chardev/char.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 3d5316166e..4e3808aefc 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -66,8 +66,7 @@ void qemu_chr_be_event(Chardev *s, int event)
=20
 /* Not reporting errors from writing to logfile, as logs are
  * defined to be "best effort" only */
-static void qemu_chr_fe_write_log(Chardev *s,
-                                  const uint8_t *buf, size_t len)
+static void qemu_chr_write_log(Chardev *s, const uint8_t *buf, size_t le=
n)
 {
     size_t done =3D 0;
     ssize_t ret;
@@ -91,9 +90,9 @@ static void qemu_chr_fe_write_log(Chardev *s,
     }
 }
=20
-static int qemu_chr_fe_write_buffer(Chardev *s,
-                                    const uint8_t *buf, int len,
-                                    int *offset, bool write_all)
+static int qemu_chr_write_buffer(Chardev *s,
+                                 const uint8_t *buf, int len,
+                                 int *offset, bool write_all)
 {
     ChardevClass *cc =3D CHARDEV_GET_CLASS(s);
     int res =3D 0;
@@ -118,7 +117,7 @@ static int qemu_chr_fe_write_buffer(Chardev *s,
         }
     }
     if (*offset > 0) {
-        qemu_chr_fe_write_log(s, buf, *offset);
+        qemu_chr_write_log(s, buf, *offset);
     }
     qemu_mutex_unlock(&s->chr_write_lock);
=20
@@ -133,11 +132,11 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, =
int len, bool write_all)
     if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_PLAY) {
         replay_char_write_event_load(&res, &offset);
         assert(offset <=3D len);
-        qemu_chr_fe_write_buffer(s, buf, offset, &offset, true);
+        qemu_chr_write_buffer(s, buf, offset, &offset, true);
         return res;
     }
=20
-    res =3D qemu_chr_fe_write_buffer(s, buf, len, &offset, write_all);
+    res =3D qemu_chr_write_buffer(s, buf, len, &offset, write_all);
=20
     if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_RECORD) {
         replay_char_write_event_save(res, offset);
--=20
2.13.0.91.g00982b8dd

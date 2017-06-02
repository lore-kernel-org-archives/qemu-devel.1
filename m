Received: from eggs.gnu.org ([2001:4830:134:3::10]:46890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGhDt-0006gd-3l
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGhDr-0005F3-Ug
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:42:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dGhDr-0005E7-L3
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:42:15 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  2 Jun 2017 11:40:36 +0400
Message-Id: <20170602074040.7400-12-marcandre.lureau@redhat.com>
In-Reply-To: <20170602074040.7400-1-marcandre.lureau@redhat.com>
References: <20170602074040.7400-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/15] char: generalize qemu_chr_write_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

qemu_chr_fe_write() is similar to qemu_chr_write_all(): the later write
all with a chardev backend.

Make qemu_chr_write() and qemu_chr_fe_write_buffer() take an 'all'
argument. If false, handle 'partial' write the way qemu_chr_fe_write()
use to, and call qemu_chr_write() from qemu_chr_fe_write().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 chardev/char.c | 70 +++++++++++++++++++++++-----------------------------=
------
 1 file changed, 28 insertions(+), 42 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 02142b480e..c9e46f00f0 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -96,7 +96,8 @@ static void qemu_chr_fe_write_log(Chardev *s,
 }
=20
 static int qemu_chr_fe_write_buffer(Chardev *s,
-                                    const uint8_t *buf, int len, int *of=
fset)
+                                    const uint8_t *buf, int len,
+                                    int *offset, bool write_all)
 {
     ChardevClass *cc =3D CHARDEV_GET_CLASS(s);
     int res =3D 0;
@@ -106,7 +107,7 @@ static int qemu_chr_fe_write_buffer(Chardev *s,
     while (*offset < len) {
     retry:
         res =3D cc->chr_write(s, buf + *offset, len - *offset);
-        if (res < 0 && errno =3D=3D EAGAIN) {
+        if (res < 0 && errno =3D=3D EAGAIN && write_all) {
             g_usleep(100);
             goto retry;
         }
@@ -116,6 +117,9 @@ static int qemu_chr_fe_write_buffer(Chardev *s,
         }
=20
         *offset +=3D res;
+        if (!write_all) {
+            break;
+        }
     }
     if (*offset > 0) {
         qemu_chr_fe_write_log(s, buf, *offset);
@@ -130,54 +134,20 @@ static bool qemu_chr_replay(Chardev *chr)
     return qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
 }
=20
-int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
+static int qemu_chr_write(Chardev *s, const uint8_t *buf, int len,
+                          bool write_all)
 {
-    Chardev *s =3D be->chr;
-    ChardevClass *cc;
-    int ret;
-
-    if (!s) {
-        return 0;
-    }
-
-    if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_PLAY) {
-        int offset;
-        replay_char_write_event_load(&ret, &offset);
-        assert(offset <=3D len);
-        qemu_chr_fe_write_buffer(s, buf, offset, &offset);
-        return ret;
-    }
-
-    cc =3D CHARDEV_GET_CLASS(s);
-    qemu_mutex_lock(&s->chr_write_lock);
-    ret =3D cc->chr_write(s, buf, len);
-
-    if (ret > 0) {
-        qemu_chr_fe_write_log(s, buf, ret);
-    }
-
-    qemu_mutex_unlock(&s->chr_write_lock);
-   =20
-    if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_RECORD) {
-        replay_char_write_event_save(ret, ret < 0 ? 0 : ret);
-    }
-   =20
-    return ret;
-}
-
-int qemu_chr_write_all(Chardev *s, const uint8_t *buf, int len)
-{
-    int offset;
+    int offset =3D 0;
     int res;
=20
     if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_PLAY) {
         replay_char_write_event_load(&res, &offset);
         assert(offset <=3D len);
-        qemu_chr_fe_write_buffer(s, buf, offset, &offset);
+        qemu_chr_fe_write_buffer(s, buf, offset, &offset, true);
         return res;
     }
=20
-    res =3D qemu_chr_fe_write_buffer(s, buf, len, &offset);
+    res =3D qemu_chr_fe_write_buffer(s, buf, len, &offset, write_all);
=20
     if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_RECORD) {
         replay_char_write_event_save(res, offset);
@@ -189,6 +159,22 @@ int qemu_chr_write_all(Chardev *s, const uint8_t *bu=
f, int len)
     return offset;
 }
=20
+int qemu_chr_write_all(Chardev *s, const uint8_t *buf, int len)
+{
+    return qemu_chr_write(s, buf, len, true);
+}
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
 int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len)
 {
     Chardev *s =3D be->chr;
@@ -197,7 +183,7 @@ int qemu_chr_fe_write_all(CharBackend *be, const uint=
8_t *buf, int len)
         return 0;
     }
=20
-    return qemu_chr_write_all(s, buf, len);
+    return qemu_chr_write(s, buf, len, true);
 }
=20
 int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
--=20
2.13.0.91.g00982b8dd

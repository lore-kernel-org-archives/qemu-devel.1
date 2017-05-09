Received: from eggs.gnu.org ([2001:4830:134:3::10]:59898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d83QN-00062j-0C
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d83QI-00039L-W5
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:35:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d83QI-00039B-NQ
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:35:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF00EC04B927
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 11:35:21 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 15:33:28 +0400
Message-Id: <20170509113332.4987-10-marcandre.lureau@redhat.com>
In-Reply-To: <20170509113332.4987-1-marcandre.lureau@redhat.com>
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/13] char: generalize qemu_chr_write_all()
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

qemu_chr_fe_write() is similar to qemu_chr_write_all(): the later write
all with a chardev backend.

Make qemu_chr_write() and qemu_chr_fe_write_buffer() take an 'all'
argument. If false, handle 'partial' write the way qemu_chr_fe_write()
use to, and call qemu_chr_write() from qemu_chr_fe_write().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char.c | 69 +++++++++++++++++++++++-----------------------------=
------
 1 file changed, 27 insertions(+), 42 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index af7d871ed5..392dba6a86 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -96,7 +96,8 @@ static void qemu_chr_fe_write_log(Chardev *s,
 }
=20
 static int qemu_chr_fe_write_buffer(Chardev *s,
-                                    const uint8_t *buf, int len, int *of=
fset)
+                                    const uint8_t *buf, int len,
+                                    int *offset, bool all)
 {
     ChardevClass *cc =3D CHARDEV_GET_CLASS(s);
     int res =3D 0;
@@ -106,7 +107,7 @@ static int qemu_chr_fe_write_buffer(Chardev *s,
     while (*offset < len) {
     retry:
         res =3D cc->chr_write(s, buf + *offset, len - *offset);
-        if (res < 0 && errno =3D=3D EAGAIN) {
+        if (res < 0 && errno =3D=3D EAGAIN && all) {
             g_usleep(100);
             goto retry;
         }
@@ -116,6 +117,9 @@ static int qemu_chr_fe_write_buffer(Chardev *s,
         }
=20
         *offset +=3D res;
+        if (!all) {
+            break;
+        }
     }
     if (*offset > 0) {
         qemu_chr_fe_write_log(s, buf, *offset);
@@ -130,54 +134,19 @@ static bool qemu_chr_replay(Chardev *chr)
     return qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
 }
=20
-int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
+static int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool =
all)
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
+    res =3D qemu_chr_fe_write_buffer(s, buf, len, &offset, all);
=20
     if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_RECORD) {
         replay_char_write_event_save(res, offset);
@@ -189,6 +158,22 @@ int qemu_chr_write_all(Chardev *s, const uint8_t *bu=
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
@@ -197,7 +182,7 @@ int qemu_chr_fe_write_all(CharBackend *be, const uint=
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
2.13.0.rc1.16.gd80b50c3f

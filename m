Received: from eggs.gnu.org ([2001:4830:134:3::10]:60054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d83Qv-0006WX-MC
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d83Qr-0003J1-Mt
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:36:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d83Qr-0003Iu-E0
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:35:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 657BE64DB2
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 11:35:56 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 15:33:31 +0400
Message-Id: <20170509113332.4987-13-marcandre.lureau@redhat.com>
In-Reply-To: <20170509113332.4987-1-marcandre.lureau@redhat.com>
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/13] char: rename functions that are not part
 of fe
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

There is no clear reason to have those functions associated with
frontend.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index b986ce1857..77e7b347f4 100644
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
-                                    int *offset, bool all)
+static int qemu_chr_write_buffer(Chardev *s,
+                                 const uint8_t *buf, int len,
+                                 int *offset, bool all)
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
int len, bool all)
     if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_PLAY) {
         replay_char_write_event_load(&res, &offset);
         assert(offset <=3D len);
-        qemu_chr_fe_write_buffer(s, buf, offset, &offset, true);
+        qemu_chr_write_buffer(s, buf, offset, &offset, true);
         return res;
     }
=20
-    res =3D qemu_chr_fe_write_buffer(s, buf, len, &offset, all);
+    res =3D qemu_chr_write_buffer(s, buf, len, &offset, all);
=20
     if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_RECORD) {
         replay_char_write_event_save(res, offset);
--=20
2.13.0.rc1.16.gd80b50c3f

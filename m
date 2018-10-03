Received: from eggs.gnu.org ([2001:4830:134:3::10]:42159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7erW-0000RT-Ai
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7erS-0002iz-FC
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:58:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g7erS-0002Zp-35
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:58:34 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  3 Oct 2018 14:57:51 +0400
Message-Id: <20181003105755.10862-3-marcandre.lureau@redhat.com>
In-Reply-To: <20181003105755.10862-1-marcandre.lureau@redhat.com>
References: <20181003105755.10862-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/6] chardev: remove qemu_chr_fe_read_all()
 counter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

There is no obvious reason to have a loop counter. This limits from
reading several megabytes large buffers in one go, since socket
read/write usually have a limit.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-fe.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index b1f228e8b5..f158f158f8 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -56,7 +56,7 @@ int qemu_chr_fe_write_all(CharBackend *be, const uint8_=
t *buf, int len)
 int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
 {
     Chardev *s =3D be->chr;
-    int offset =3D 0, counter =3D 10;
+    int offset =3D 0;
     int res;
=20
     if (!s || !CHARDEV_GET_CLASS(s)->chr_sync_read) {
@@ -88,10 +88,6 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf=
, int len)
         }
=20
         offset +=3D res;
-
-        if (!counter--) {
-            break;
-        }
     }
=20
     if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_RECORD) {
--=20
2.19.0.271.gfe8321ec05

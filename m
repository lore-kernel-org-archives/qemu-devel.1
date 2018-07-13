Received: from eggs.gnu.org ([2001:4830:134:3::10]:40945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxp4-0003f6-B7
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxp3-0001Ad-4q
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57084 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fdxp2-00018z-V3
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E7DCBB41E
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 13:09:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jul 2018 15:08:49 +0200
Message-Id: <20180713130916.4153-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180713130916.4153-1-marcandre.lureau@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 02/29] chardev: remove
 qemu_chr_fe_read_all() counter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: airlied@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
2.18.0.129.ge3331758f1

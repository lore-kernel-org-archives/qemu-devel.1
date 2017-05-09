Received: from eggs.gnu.org ([2001:4830:134:3::10]:59583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d83PG-00050U-5H
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d83PC-0002LP-53
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:34:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d83PB-0002LH-SR
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:34:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1D0D5BECB
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 11:34:12 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 15:33:22 +0400
Message-Id: <20170509113332.4987-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170509113332.4987-1-marcandre.lureau@redhat.com>
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/13] char-win: rename win_chr_init/poll
 win_chr_serial_init/poll
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

Those 2 functions are specific to serial chardev, make it more clear.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-win.h    | 2 +-
 chardev/char-serial.c | 2 +-
 chardev/char-win.c    | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/chardev/char-win.h b/chardev/char-win.h
index 70215e04c2..e0b3839a77 100644
--- a/chardev/char-win.h
+++ b/chardev/char-win.h
@@ -46,7 +46,7 @@ typedef struct {
 #define WIN_CHARDEV(obj) OBJECT_CHECK(WinChardev, (obj), TYPE_CHARDEV_WI=
N)
=20
 void qemu_chr_open_win_file(Chardev *chr, HANDLE fd_out);
-int win_chr_init(Chardev *chr, const char *filename, Error **errp);
+int win_chr_serial_init(Chardev *chr, const char *filename, Error **errp=
);
 int win_chr_pipe_poll(void *opaque);
=20
 #endif /* CHAR_WIN_H */
diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index 094e08dca5..fef3a91c77 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -45,7 +45,7 @@ static void qmp_chardev_open_serial(Chardev *chr,
 {
     ChardevHostdev *serial =3D backend->u.serial.data;
=20
-    win_chr_init(chr, serial->device, errp);
+    win_chr_serial_init(chr, serial->device, errp);
 }
=20
 #elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)    =
  \
diff --git a/chardev/char-win.c b/chardev/char-win.c
index 5e7daeeae1..11abad1521 100644
--- a/chardev/char-win.c
+++ b/chardev/char-win.c
@@ -56,7 +56,7 @@ static void win_chr_read(Chardev *chr, DWORD len)
     }
 }
=20
-static int win_chr_poll(void *opaque)
+static int win_chr_serial_poll(void *opaque)
 {
     Chardev *chr =3D CHARDEV(opaque);
     WinChardev *s =3D WIN_CHARDEV(opaque);
@@ -71,7 +71,7 @@ static int win_chr_poll(void *opaque)
     return 0;
 }
=20
-int win_chr_init(Chardev *chr, const char *filename, Error **errp)
+int win_chr_serial_init(Chardev *chr, const char *filename, Error **errp=
)
 {
     WinChardev *s =3D WIN_CHARDEV(chr);
     COMMCONFIG comcfg;
@@ -130,7 +130,7 @@ int win_chr_init(Chardev *chr, const char *filename, =
Error **errp)
         error_setg(errp, "Failed ClearCommError");
         goto fail;
     }
-    qemu_add_polling_cb(win_chr_poll, chr);
+    qemu_add_polling_cb(win_chr_serial_poll, chr);
     return 0;
=20
  fail:
@@ -208,7 +208,7 @@ static void char_win_finalize(Object *obj)
     if (s->fpipe) {
         qemu_del_polling_cb(win_chr_pipe_poll, chr);
     } else {
-        qemu_del_polling_cb(win_chr_poll, chr);
+        qemu_del_polling_cb(win_chr_serial_poll, chr);
     }
=20
     qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
--=20
2.13.0.rc1.16.gd80b50c3f

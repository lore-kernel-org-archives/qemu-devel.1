Received: from eggs.gnu.org ([2001:4830:134:3::10]:40843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMjM-000190-HC
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRMjJ-0006Te-1l
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cRMjI-0006TR-KP
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:30:32 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC0584D6A4
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 17:30:32 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 18:29:41 +0100
Message-Id: <20170111172956.11255-26-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-1-marcandre.lureau@redhat.com>
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 25/40] char: rename and move to header
 CHR_READ_BUF_LEN
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

This define is used by several character devices, place it in char
common header.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/char.h |  1 +
 chardev/char.c        | 13 ++++++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 1e1f5c7b2b..1a65798e3e 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -22,6 +22,7 @@ typedef enum {
     CHR_EVENT_CLOSED /* connection closed */
 } QEMUChrEvent;
=20
+#define CHR_READ_BUF_LEN 4096
=20
 #define CHR_IOCTL_SERIAL_SET_PARAMS   1
 typedef struct {
diff --git a/chardev/char.c b/chardev/char.c
index b28f87d010..f710a01c9b 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -87,7 +87,6 @@
=20
 #include "char-mux.h"
=20
-#define READ_BUF_LEN 4096
 #define READ_RETRIES 10
 #define TCP_MAX_FDS 16
=20
@@ -471,7 +470,7 @@ void qemu_chr_fe_accept_input(CharBackend *be)
=20
 void qemu_chr_fe_printf(CharBackend *be, const char *fmt, ...)
 {
-    char buf[READ_BUF_LEN];
+    char buf[CHR_READ_BUF_LEN];
     va_list ap;
     va_start(ap, fmt);
     vsnprintf(buf, sizeof(buf), fmt, ap);
@@ -913,7 +912,7 @@ static gboolean fd_chr_read(QIOChannel *chan, GIOCond=
ition cond, void *opaque)
     Chardev *chr =3D CHARDEV(opaque);
     FDChardev *s =3D FD_CHARDEV(opaque);
     int len;
-    uint8_t buf[READ_BUF_LEN];
+    uint8_t buf[CHR_READ_BUF_LEN];
     ssize_t ret;
=20
     len =3D sizeof(buf);
@@ -1265,7 +1264,7 @@ static gboolean pty_chr_read(QIOChannel *chan, GIOC=
ondition cond, void *opaque)
     Chardev *chr =3D CHARDEV(opaque);
     PtyChardev *s =3D PTY_CHARDEV(opaque);
     gsize len;
-    uint8_t buf[READ_BUF_LEN];
+    uint8_t buf[CHR_READ_BUF_LEN];
     ssize_t ret;
=20
     len =3D sizeof(buf);
@@ -1952,7 +1951,7 @@ static void win_chr_readfile(Chardev *chr)
     WinChardev *s =3D WIN_CHARDEV(chr);
=20
     int ret, err;
-    uint8_t buf[READ_BUF_LEN];
+    uint8_t buf[CHR_READ_BUF_LEN];
     DWORD size;
=20
     ZeroMemory(&s->orecv, sizeof(s->orecv));
@@ -2354,7 +2353,7 @@ err1:
 typedef struct {
     Chardev parent;
     QIOChannel *ioc;
-    uint8_t buf[READ_BUF_LEN];
+    uint8_t buf[CHR_READ_BUF_LEN];
     int bufcnt;
     int bufptr;
     int max_size;
@@ -2759,7 +2758,7 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOC=
ondition cond, void *opaque)
 {
     Chardev *chr =3D CHARDEV(opaque);
     SocketChardev *s =3D SOCKET_CHARDEV(opaque);
-    uint8_t buf[READ_BUF_LEN];
+    uint8_t buf[CHR_READ_BUF_LEN];
     int len, size;
=20
     if (!s->connected || s->max_size <=3D 0) {
--=20
2.11.0

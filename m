Received: from eggs.gnu.org ([2001:4830:134:3::10]:59749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dFGJZ-0006lP-PL
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dFGJW-0000pp-Nw
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:46:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dFGJW-0000pg-Hu
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:46:10 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 29 May 2017 12:45:34 +0400
Message-Id: <20170529084546.26500-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170529084546.26500-1-marcandre.lureau@redhat.com>
References: <20170529084546.26500-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/14] char-win: remove WinChardev.len
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

The "len" argument can be passed directly to win_chr_read()

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 chardev/char-win.h |  1 -
 chardev/char-win.c | 16 +++++++---------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/chardev/char-win.h b/chardev/char-win.h
index 73a0e3caef..70215e04c2 100644
--- a/chardev/char-win.h
+++ b/chardev/char-win.h
@@ -32,7 +32,6 @@ typedef struct {
     HANDLE hcom, hrecv, hsend;
     OVERLAPPED orecv;
     BOOL fpipe;
-    DWORD len;
=20
     /* Protected by the Chardev chr_write_lock.  */
     OVERLAPPED osend;
diff --git a/chardev/char-win.c b/chardev/char-win.c
index a46d878ef8..5e7daeeae1 100644
--- a/chardev/char-win.c
+++ b/chardev/char-win.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "char-win.h"
=20
-static void win_chr_read(Chardev *chr)
+static void win_chr_read(Chardev *chr, DWORD len)
 {
     WinChardev *s =3D WIN_CHARDEV(chr);
     int max_size =3D qemu_chr_be_can_write(chr);
@@ -34,16 +34,16 @@ static void win_chr_read(Chardev *chr)
     uint8_t buf[CHR_READ_BUF_LEN];
     DWORD size;
=20
-    if (s->len > max_size) {
-        s->len =3D max_size;
+    if (len > max_size) {
+        len =3D max_size;
     }
-    if (s->len =3D=3D 0) {
+    if (len =3D=3D 0) {
         return;
     }
=20
     ZeroMemory(&s->orecv, sizeof(s->orecv));
     s->orecv.hEvent =3D s->hrecv;
-    ret =3D ReadFile(s->hcom, buf, s->len, &size, &s->orecv);
+    ret =3D ReadFile(s->hcom, buf, len, &size, &s->orecv);
     if (!ret) {
         err =3D GetLastError();
         if (err =3D=3D ERROR_IO_PENDING) {
@@ -65,8 +65,7 @@ static int win_chr_poll(void *opaque)
=20
     ClearCommError(s->hcom, &comerr, &status);
     if (status.cbInQue > 0) {
-        s->len =3D status.cbInQue;
-        win_chr_read(chr);
+        win_chr_read(chr, status.cbInQue);
         return 1;
     }
     return 0;
@@ -146,8 +145,7 @@ int win_chr_pipe_poll(void *opaque)
=20
     PeekNamedPipe(s->hcom, NULL, 0, NULL, &size, NULL);
     if (size > 0) {
-        s->len =3D size;
-        win_chr_read(chr);
+        win_chr_read(chr, size);
         return 1;
     }
     return 0;
--=20
2.13.0.91.g00982b8dd
